From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Mon, 28 Jan 2013 22:21:47 +0000
Message-ID: <20130128222147.GD7498@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
 <20130128210136.GC7498@serenity.lan>
 <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:22:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzx5n-0007kw-2b
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 23:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab3A1WV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 17:21:56 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50915 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab3A1WVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 17:21:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 06A586064CD;
	Mon, 28 Jan 2013 22:21:54 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BPca2YENn21; Mon, 28 Jan 2013 22:21:53 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8A5626064A7;
	Mon, 28 Jan 2013 22:21:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214881>

On Mon, Jan 28, 2013 at 01:50:19PM -0800, Junio C Hamano wrote:
> What are the situations where a valid user-defined tools is
> unavailable, by the way?

The same as a built-in tool: the command isn't available.

Currently I'm extracting the command word using:

    cmd=$(eval -- "set -- $(git config mergetool.$tool.cmd); echo \"$1\"")

(it's slightly more complicated due to handling difftool.$tool.cmd as
well, but that's essentially it).  Then it just uses the same "type
$cmd" test as for built-in tools.

I don't know if there's a better way to extract the first word, but
that's the best I've come up with so far.


John
