From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 02 Nov 2007 13:19:58 -0700
Message-ID: <7vhck41jtd.fsf@gitster.siamese.dyndns.org>
References: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
	<7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
	<6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de>
	<!47299855.9010204@op5.se>
	<3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <472AF5F8.40208@op5.se>
	<20071102132446.GA31758@hermes.priv> <472B2B8F.1060203@op5.se>
	<7vfxzo3046.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:20:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io30F-0007S9-Hb
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798AbXKBUUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758068AbXKBUUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:20:09 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:43566 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757798AbXKBUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:20:07 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6BF242F2;
	Fri,  2 Nov 2007 16:20:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DB4E990FF4;
	Fri,  2 Nov 2007 16:20:23 -0400 (EDT)
In-Reply-To: <7vfxzo3046.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 02 Nov 2007 12:42:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63169>

Junio C Hamano <gitster@pobox.com> writes:

> If you linearlize the history by rebasing the lower branch on
> top of upper, instead of merging, the bug becomes much easier to
> find and understand.  Your history would instead be:
>
>     ---Z---o---X'--...---o---A---o---o---Y'--...---o---B'--D'
>
> and there is a single commit Y' between A and B' that introduced
> the new calling site that still uses the new semantics of the
> function that was already in A.  "git show Y'" will be a much
> smaller patch than "git diff A C" and it is much easier to deal
> with.

Typo.  Y' uses "the old semantics of the function, even though
that was already modified at X'".
