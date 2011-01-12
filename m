From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Wed, 12 Jan 2011 01:07:51 -0800
Message-ID: <7vd3o232xk.fsf@alter.siamese.dyndns.org>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110107195417.GC6175@sigill.intra.peff.net>
 <7vsjx449bv.fsf@alter.siamese.dyndns.org>
 <7vipy0483h.fsf@alter.siamese.dyndns.org>
 <20110111065207.GF10094@sigill.intra.peff.net>
 <7vvd1v4bmt.fsf@alter.siamese.dyndns.org>
 <20110111180208.GC1833@sigill.intra.peff.net>
 <20110112012515.GA30856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 12 10:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcwgh-0002Gz-7r
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 10:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab1ALJIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 04:08:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1ALJIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 04:08:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2494B2697;
	Wed, 12 Jan 2011 04:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2NUWWJFiDgFmVNm6/1ped7bzl34=; b=E3mjRJ
	pNPUVvf0L1IGcuWtb132hQoP0ab/vDXhG5OpbYJc4tjoeeJxhfeQlBnSdPtTSPm9
	r+8yU8Ot/+iNZzz0Ty/iL3IQPoMBPZCjcAZW/blwUReD3CBxOrhcvOSWagxGid1T
	IzWiKfNqnrv/Vn3mQrINdxjP4PHj9B/rFHo90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YWXYhaSYTjhllArdUJ1XreHISbIzw6G0
	rc90SKg+qEX/fMKjEdhn0R5RIAt13ucPC1vtxS364Fit5yjcldocGPAHEfwr1gwS
	0+K+MIlB1kqzRNh9DTWYnSYJdTvhrGA+MsKbyAocBI45WU2x7dqDXs/UVY5fiqUs
	8qAMwjU3JSI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D84FB2696;
	Wed, 12 Jan 2011 04:08:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 711E92692; Wed, 12 Jan 2011
 04:08:39 -0500 (EST)
In-Reply-To: <20110112012515.GA30856@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 11 Jan 2011 20\:25\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EBF8984-1E2B-11E0-B0B6-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165009>

Jeff King <peff@peff.net> writes:

> I'm not sure. And to be honest I don't really care, because I think
> people with ambiguous refs are little bit crazy anyway (after all, in
> the current code it simply calls die()). But I think there is some
> argument to be made that due to tracking, start_point is not _just_
> a regular ref. We do care about its branchiness.

I do not really care either myself, and if 

    git branch --track foo heads/ambiguity
    git branch --track foo tags/ambiguity

allows the user to differentiate between the branch and the tag, it would
be more than sufficient.
