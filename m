From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 00:35:53 -0700
Message-ID: <7v1vna3nae.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
 <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <1250475682.7155.16.camel@marge.simson.net>
 <20090817064801.GA31543@coredump.intra.peff.net>
 <7v63cm3ntl.fsf@alter.siamese.dyndns.org>
 <20090817072559.GA9730@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <efault@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McwlJ-0003ZK-RM
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037AbZHQHgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbZHQHgD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:36:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZHQHgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:36:02 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBBA72C35C;
	Mon, 17 Aug 2009 03:36:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F39712C35A; Mon, 17 Aug 2009
 03:35:55 -0400 (EDT)
In-Reply-To: <20090817072559.GA9730@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 17 Aug 2009 03\:25\:59 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E30FCE6-8B00-11DE-BC02-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126133>

Jeff King <peff@peff.net> writes:

>> But I can tell you that this "just warn" cannot be a good idea for a very
>> simple reason: breaking and then warning is useless---it is too late for
>> the user to do anything about it.
>
> Did you miss the part where I asked "should we include instructions to
> the user on how to fix this"?

Actually, I didn't.  It is very hard to lose data once you put it in git;
"by following recovery insn the user can redo" is often trivially correct
thanks to it.

But it is not a very good option to cause the damage and then give
recovery insn.  The user might have ran out of quota, and even if he
didn't, he wasted needless cycles for the unwanted sort of repacking.
