From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix "git diff" setup code
Date: Fri, 14 Sep 2007 12:11:42 -0700
Message-ID: <7vodg59i4x.fsf@gitster.siamese.dyndns.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
	<20070906022539.GG18160@spearce.org>
	<20070906101648.GD6665@basalt.office.altlinux.org>
	<20070909044648.GH18160@spearce.org>
	<7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
	<20070913035137.GM3099@spearce.org>
	<7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
	<20070914000108.GE3619@basalt.office.altlinux.org>
	<7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
	<20070914024303.GH3619@basalt.office.altlinux.org>
	<alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
	<alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
	<alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
	<7v4phxaz3o.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709141129451.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 21:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWGa3-0003qT-Fy
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 21:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbXINTLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbXINTLv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 15:11:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbXINTLv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 15:11:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C90D134A9D;
	Fri, 14 Sep 2007 15:12:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0709141129451.16478@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 14 Sep 2007 11:30:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58181>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 14 Sep 2007, Junio C Hamano wrote:
>> 
>> So I tend to think the attached is a better fix.
>
> Ahh, yes, that explains the conditional. 
>
> But whatever gets us to actually verify our options, and fill in the right 
> defaults is ok by me!

Sorry, my explanation only explains about missing setup_done()
when --no-index is used, but does not explain _if_ you actually
found that setup_done() was not called for you when you did a
real life test.  Was it only from code inspection, or did you
hit a case where setup_done() is not run?  If the latter then
there is something else going on, as I cannot think of a way to
call setup_revisions() and not have it call setup_done()...
