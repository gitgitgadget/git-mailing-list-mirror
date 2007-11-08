From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Handle relative paths containing "..".
Date: Fri, 9 Nov 2007 00:10:20 +1100
Message-ID: <ee77f5c20711080510i138729b9vb0b9ad485cb2db3@mail.gmail.com>
References: <1194489192-20021-1-git-send-email-dsymonds@gmail.com>
	 <7v4pfx3zs3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq79l-0006lf-Kn
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbXKHNKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbXKHNKW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:10:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:17106 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXKHNKV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:10:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so137342rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 05:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AbOJDzW+b4bIvIYNQgchkLViyl5r4QkCIujBUqwfl5w=;
        b=r4ntUUP5RUWwUUS/6JflZvJkx/I1BCDcgQarmV8Qb/iwSpSmRwXiU1HI78xYXX/l1wVcDQN2cUZDIjVjh9LLrHlTmnH6Ho9jadhoQ7mBjjXV5kEeKoB73TQGOlLQj2bSaYhK0FAsOzX7dax3g5RPzO8uwlNGp6b74yWHkpbZ1EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=msGROHINe1Hs8OmcWma6xkBFgUggAlYC1C+hUBZCDNDuDATFp+//ZsV+7OsprzsFxvA1qsfEdPRhrRV11Thze3FyPHyoaKnslSR34zbZ3PIqcjOzfv9uDVEkYIzW8TvFz1DGPDHpqar/ziEFbMFnZcdMx9InlzVKFAtBeF8gDnU=
Received: by 10.140.251.1 with SMTP id y1mr229982rvh.1194527421062;
        Thu, 08 Nov 2007 05:10:21 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 05:10:20 -0800 (PST)
In-Reply-To: <7v4pfx3zs3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64013>

On Nov 8, 2007 7:30 PM, Junio C Hamano <junio@pobox.com> wrote:
>
> Have you tested this patch from the toplevel of any tree, where
> "git-rev-parse --show-cdup" would yield an empty string?

No, I didn't. Arguably, "git-rev-parse --show-cdup" should always
return a path to the top-level, which would make this kind of
construction much simpler. Is there anything that relies upon it
returning the empty string when you're in the top-level directory?

> I also wonder how this patch (with an obvious fix to address the
> above point) would interact with GIT_DIR and/or GIT_WORK_TREE in
> the environment.

No idea. I'm still learning my way around the git codebase, so I was
hoping for some review and feedback from more experienced Gits.


Dave.
