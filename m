From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Malformed branch name in fast-export when specifying
 non-HEAD/branch revision
Date: Mon, 22 Aug 2011 14:27:00 -0700
Message-ID: <7vpqjxuogr.fsf@alter.siamese.dyndns.org>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
 <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
 <CABPp-BFRZMZjhWuUUeD7Oa1HbWQMnZot7dRm3zKOpCoj_QwZeg@mail.gmail.com>
 <7vliurd62x.fsf@alter.siamese.dyndns.org>
 <20110817231922.GA28966@sigill.intra.peff.net>
 <CAGdFq_iiTt8F+kPXwZZT3fAKwZLCpPr7BOYtistxvv6s52Q5nQ@mail.gmail.com>
 <20110822161932.GA1945@sigill.intra.peff.net>
 <CAGdFq_gx+NutDCU7egr_fYUvVG=g1t76LiV1SV-W=0KWBTjHyQ@mail.gmail.com>
 <20110822175705.GB1945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Owen Stephens <git@owenstephens.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 23:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvc1X-00020A-7F
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 23:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab1HVV1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 17:27:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab1HVV1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 17:27:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83CEB4C2B;
	Mon, 22 Aug 2011 17:27:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ozOajl89aepRGYfelEg/ytjfCls=; b=HftJfi
	/M+LDzv3cpjcejtSBy3IX+4IsSe8zonBY+J3tGQxAMthXu1KN8Q3IwloJIXik8uw
	JICTF7N4LAofOig46uaHDQHHKZuxA1rkZrFwuMpt+HbPbSkReM5hNEalXk9fXib2
	Pizdcljnl2StZ6KUpDLIbI8qANCZ2QodGgOwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eTraAnxQBg9lhH/woTR9mAlOkoR3F9aR
	PfgDdNZ72fQJvVcWmWdfRhojTuisfTjk3PEHgWTNbUsStXQUNIrqyuidhBogj/g8
	x/Sqr2aq/khacOTCWfDvBfZwt8yCo4IkUZ1kp7i/7VQuVQLXMQEywt/cM3C+W1du
	fn00TackSXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C134C2A;
	Mon, 22 Aug 2011 17:27:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E68054C28; Mon, 22 Aug 2011
 17:27:02 -0400 (EDT)
In-Reply-To: <20110822175705.GB1945@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 22 Aug 2011 13:57:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A340B6E-CD05-11E0-9909-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179892>

Jeff King <peff@peff.net> writes:

> Yeah, the behavior of your patch looks fine to me. I thought the point
> in contention was that having export understand refspecs would fix a lot
> of _other_ cases, too.

Perhaps if we added refspecs we could cover other cases, too, but I do not
think we need to require the patch to cover additional cases. The more
problematic was that the particular implementation in the patch smelled
bad.
