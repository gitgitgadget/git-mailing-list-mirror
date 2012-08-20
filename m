From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Mon, 20 Aug 2012 13:57:30 +0200
Message-ID: <A42CEB6A-5951-4869-B890-92BDD2361EC1@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> <7vehn3rbom.fsf@alter.siamese.dyndns.org> <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com> <7v1uj2pysd.fsf@alter.siamese.dyndns.org> <9E4BBC27-5B26-4048-93D4-FE02C550F4E2@gmail.com> <7vobm6o1cu.fsf@alter.siamese.dyndns.org> <62FFD304-1902-4D69-9287-ECD1E32BABC9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 13:57:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Qbz-0001ZX-5w
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 13:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab2HTL5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 07:57:35 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64532 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2HTL5e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 07:57:34 -0400
Received: by eeil10 with SMTP id l10so1758369eei.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=Lm2El3BWNpUuBI7wCVx5PiV7bgksO5KrUBqi0+0OK7c=;
        b=Oo0WBrT1jb6j6qPDDpx05SupLrTQ5ZOgl2/Od4nwaC201oD3ToCFfT77xpzoiVc6Gl
         uagljCoqD/E35jcGNWEbIK3vAc0IZmW3nVuUzgPUXdf6BR8DS1rkrmSpa7vV1Jylpazp
         jYAsi+XSKRL1mKPectiPq1ZrrqaRGmbLtiRtywNZWSybvEmQ2PxxrwaTwN9B2ThFibtE
         zuRUYIfNffs0E8pITfiEffPAMB4mM2p/NznHQiz6XufQxDg3r2YCxg+rlPO30D9NDHMW
         CicAdp7VohCdlG/s0rAb5HFKkBTYglIBTqJexwBaZTtYWOsAm9dNgT6igV676CYtJNb9
         73gA==
Received: by 10.14.172.129 with SMTP id t1mr8472846eel.34.1345463853140;
        Mon, 20 Aug 2012 04:57:33 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id l42sm41334789eep.1.2012.08.20.04.57.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 04:57:32 -0700 (PDT)
In-Reply-To: <62FFD304-1902-4D69-9287-ECD1E32BABC9@gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203771>

On 20 Aug 2012, at 13:32, Alexey Muranov wrote:

> The problem of mapping branch names to file paths looks to me very similar to the problem of mapping URLs to file paths for static web sites, so i would propose to use the same solution: add a special extension to distinguish a file from a directory, for example ".branch" and ".tag" (like ".html" in the case of URL).  This would allow having both branches "next" and "next/foo" with refs stored in files "next.branch" and "next/foo.branch".  This will look very clear and familiar to people not specialist in Git, but familiar with static web sites.  The only limitation this would introduces is that branch names "foo.branch" would need to be forbidden.  If the extension is optional, this makes the new rule almost compatible with the current one, except if somebody is currently using branches
  named like "foo.branch" or "next.branch/foo".

Another possible choice for the extensions: ".~br" and ".~tg" (to keep readability of file names and allow all currently allowed branch names).