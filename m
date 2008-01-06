From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch: work correctly with ambiguous refnames
Date: Sat, 05 Jan 2008 18:53:44 -0800
Message-ID: <7v8x337jgn.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	<1199040667-31850-1-git-send-email-dpotapov@gmail.com>
	<7v7iiqppkw.fsf@gitster.siamese.dyndns.org>
	<20080104155114.GS3373@dpotapov.dyndns.org>
	<7vr6gxjpyn.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801051601490.10101@racer.site>
	<7vabnk81aw.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801060154150.10101@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLej-0008NK-3o
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYAFCx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYAFCx4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:53:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYAFCx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 21:53:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 37EB18CB0;
	Sat,  5 Jan 2008 21:53:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BC14C8CAF;
	Sat,  5 Jan 2008 21:53:48 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801060154150.10101@racer.site> (Johannes
	Schindelin's message of "Sun, 6 Jan 2008 01:57:39 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69705>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, from a cursory look I like the 2 patches (except for the 
> curly brackets around the single-line "else" clause, but I know your 
> opinion about this, so I will not object).

I care more about consistency across codebase than my own
preference [*1*].  I just picked the style the kernel folks seem
to use (see their Documentation/CodingStyle), only because (1)
there seem to be people familiar with it, and (2) I am not
particularly interested myself in wasting time arguing over
which style is superiour.  I just had to pick one and that was
the one I happened to have at hand.

And obviously I care more about correctness, so I'd appreciate a
review with non cursory look if you have time.

[Footnote]

*1* I favoring shorter code over consistency between when-true
and when-false clauses.  IOW, I do not like having to have {}
around a single statement in else clause when if clause needs {}
around it.
