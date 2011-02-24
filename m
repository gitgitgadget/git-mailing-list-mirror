From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 11:44:13 -0800
Message-ID: <7vbp211alu.fsf@alter.siamese.dyndns.org>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
 <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
 <20110224190258.GA4318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:44:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psh74-0007OI-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154Ab1BXToa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:44:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab1BXTo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:44:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36CF94CC9;
	Thu, 24 Feb 2011 14:45:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZinQC5ZMJLCBBl8zTc0OpRBVlGw=; b=nDbKjX
	vyPRUvhC1W0GfrdqM42Qr86KcT++5GsomQPrZox2tX5NphddDokn50CdAYU2wNig
	8iljk2suOOClszIiUvsTOHGk63RWcWVhg2X0hJfLWx7XgGP2BxHQy014hxO85Rzr
	/mG3bcvzI1NE0Ry9MSktDKHkc41VRaNWQ+X5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tjX/OojiqXh/GlOMoxR7A3YkX3z6txxY
	k7fhFEDP/+uYonxoPiibUrwlgVgAhGJSW6rp6x8/cNak9LY9KBasKGApQqhxlCO7
	mkH4Gs0Y3xhA1gLijY63d1A91eJ9Z/AdpEL1LUAVEPUqdlPOMVQ5RlrXXzAg3Jx6
	Db/tckfVi3s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB1F94CC6;
	Thu, 24 Feb 2011 14:45:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8582A4CC5; Thu, 24 Feb 2011
 14:45:32 -0500 (EST)
In-Reply-To: <20110224190258.GA4318@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 24 Feb 2011 14\:02\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A74772B0-404E-11E0-B3B4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167854>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 24, 2011 at 10:25:04AM -0800, Junio C Hamano wrote:
> ...
> So I guess I'm not sure what your complaint is.

There was no complaint. I wanted to see the reasoning behind the choices
you made spelled out (and later copied into developer docs).

> I think I covered that pretty well above, but you lose the flexibility
> of pushing different trace types to different places if you want to.

That statement illustrates the inflexibility that all packet traces going
to a same place rather clearly, doesn't it, though?  That "two-tier" thing
was my primary concern.
