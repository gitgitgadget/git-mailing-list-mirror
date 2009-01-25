From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sun, 25 Jan 2009 15:15:54 +0100
Message-ID: <200901251515.55434.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901241228.33690.markus.heidelberg@web.de> <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 15:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR5nb-0003Xy-Rf
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 15:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbZAYOP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZAYOP2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 09:15:28 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:37047 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbZAYOP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 09:15:27 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id EC1ADFC4076F;
	Sun, 25 Jan 2009 15:15:25 +0100 (CET)
Received: from [89.59.126.247] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LR5ll-000064-00; Sun, 25 Jan 2009 15:15:25 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vk58ko8k7.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+/Z3ZzGU24zp84N+sRP2aGHwHeRhnsHf76efa6
	W3ntH6tmKOAi28I7mwRVZn5jJrOOdKjCZc9ohq3MLro0dgT7dw
	8gkTklV3tL8UHzUiy2pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107060>

Junio C Hamano, 24.01.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > So with the following diff it works:
> >
> > -	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
> > +	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")
> > +				       || !strcmp(var, "color.ui")) {
> 
> Why should format-patch need to even worry about protecting itself from
> "color.ui" to begin with?

That's the reason, why color handling needs another rework than my
patch, which only was originated from the color.ui git_use_color_default
workarounds. Call it shortsighted, if you want.

> If your patch is making color handling saner, I would expect that
> format-patch can *lose* the existing "ignore diff.color or color.diff"
> workaround as a result of that.  If you need to add even *more* workaround
> code like that, there's something wrong, don't you think?

That's the reason, why it doesn't make sense to continue work on my
patch base.

> > format-patch is perhaps the only place where the commit has broken
> > things, because I didn't find other places,...
> 
> You did not find the breakage in format-patch either to begin with; so
> your not finding does not give us much confidence that there is no other
> breakage, does it?

Of course not.

> Grumble...

Why grumble? That was just a personal suspicion. I didn't say: "I think
this is the only breakage place, please reapply".
