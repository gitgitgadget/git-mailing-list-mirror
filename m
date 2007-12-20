From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Thu, 20 Dec 2007 01:40:24 -0800
Message-ID: <7vtzmdpuuv.fsf@gitster.siamese.dyndns.org>
References: <20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
	<7v8x3ul927.fsf@gitster.siamese.dyndns.org>
	<7v7ijejq6j.fsf@gitster.siamese.dyndns.org>
	<20071216212104.GA32307@coredump.intra.peff.net>
	<7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
	<20071219141845.GA2146@hashpling.org>
	<20071219142715.GB14187@coredump.intra.peff.net>
	<20071219143712.GA3483@hashpling.org>
	<7vy7bqrzat.fsf@gitster.siamese.dyndns.org>
	<20071220092315.GA31337@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 10:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Htz-0002mL-O9
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 10:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbXLTJkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 04:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbXLTJkt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 04:40:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbXLTJkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 04:40:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1666E8523;
	Thu, 20 Dec 2007 04:40:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B85E8520;
	Thu, 20 Dec 2007 04:40:31 -0500 (EST)
In-Reply-To: <20071220092315.GA31337@hashpling.org> (Charles Bailey's message
	of "Thu, 20 Dec 2007 09:23:15 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68985>

Charles Bailey <charles@hashpling.org> writes:

> Perhaps a comment saying tha zc is designed for <= 9999 z's?  Given
> this, a lot of the /g are redundant.

Yeah, /g redundancy is a leftover from the time when it did not have
these sawtooth patterns.
