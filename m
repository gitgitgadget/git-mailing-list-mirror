From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer
 lines.
Date: Wed, 28 Oct 2009 11:06:50 -0700
Message-ID: <7vd447o0jp.fsf@alter.siamese.dyndns.org>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
 <20091028171344.GA22290@quaoar.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 19:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3CvH-0008Mg-BO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZJ1SGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZJ1SGx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:06:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZJ1SGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:06:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3000F89321;
	Wed, 28 Oct 2009 14:06:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GhZQ5XfBMRuLSR+wrWby4CTPo6U=; b=gJJ9NI
	gIL6IiBOoD4PY7ztLmlTMsWKh6zjNURYPmjgSYLi5dVWuN2v3oMEw5EffK+VCEPs
	irDBlS2vvRTuy/jUldC0px8TYdJ5dTH9wx6v733kbJTq7mryzDt5B7LwxNpx0EZB
	bGsDJXiC3RpRXs1x8B1hiSmxJ2kHz/w05ZXMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ksfhv30gRLP0i8p5eLEIcq0zKcIGrqYN
	o7dEyUe6szu+Qqrf8JyOkPobWwtHoxdJqTbj+/QGNxv9vsmCoxxRJIulJ0z4IA9q
	Q6NXAxOoepFuIHzjPd7CzTU8DpAvp3Sfr0Rhfm+/2CTJT17IWnTeJVTOG7+UlhJF
	vGPEN6wSTZM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10C2C89320;
	Wed, 28 Oct 2009 14:06:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08C0B8931F; Wed, 28 Oct 2009
 14:06:51 -0400 (EDT)
In-Reply-To: <20091028171344.GA22290@quaoar.codeaurora.org> (David Brown's
 message of "Wed\, 28 Oct 2009 10\:13\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD0557D8-C3EC-11DE-8C63-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131489>

David Brown <davidb@codeaurora.org> writes:

> From: David Brown <davidb@quicinc.com>
>
> 'git commit -s' will insert a blank line before the Signed-off-by
> line at the end of the message, unless this last line is a
> Signed-off-by line itself.  Common use has other trailing lines
> at the ends of commit text, in the style of RFC2822 headers.
>
> Be more generous in considering lines to be part of this footer.
> If the last paragraph of the commit message reasonably resembles
> RFC-2822 formatted lines, don't insert that blank line.

I do not think it is particularly readable to add Cc: at the end, and in a
sense this patch encourages that practice (without the patch, the end
result looks ugly and that has an effect to discourage people from adding
Cc: there).

But this is not a strong objection.  Applied.

Thanks.
