From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 06 Feb 2013 16:26:31 -0800
Message-ID: <7vbobx9dfs.fsf@alter.siamese.dyndns.org>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> <7vmwvhmli7.fsf@alter.siamese.dyndns.org> <20130206221240.GC27507@sigill.intra.peff.net> <7vr4kt9f53.fsf@alter.siamese.dyndns.org> <20130207001013.GA28970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 01:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3FKW-000120-PC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 01:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab3BGA0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 19:26:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758535Ab3BGA0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 19:26:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5EAED605;
	Wed,  6 Feb 2013 19:26:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZIZtxXQKNBTjmMuRnwzst713ppI=; b=Et0HZ5
	uiMwcKsDvwvcnBqAIFCE87P93eIx8MhqP+tPwE1nRRIRbPnnv/16/RslwbRZoNEa
	Gxhco4pMpStYQtT6a6Jjxi/HmGBk8JJ5AiZaiednS1dJCWS+b3I9ZVoJj8cl7JQV
	zbsdSeuUI/GagfFIr1TP9PrceKgF9KYoRHvyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dAMJ1t5u9/NXAYL+wd5whM/ZrxXTzGhN
	GU0MnQ27gUKCR4VGMsXcKeffZ20bEIOZULMPSiLGezMfXtNjUmkQdSjvXiUkLtlt
	+RuCQ1WtmAov5ABnMTh6ZRUZOhqTRdUja8rj21zLSbhATLSIUla11PXEt8jpQxMg
	8C2BbTSnIqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66C86D5F1;
	Wed,  6 Feb 2013 19:26:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93EE5D5DE; Wed,  6 Feb 2013
 19:26:38 -0500 (EST)
In-Reply-To: <20130207001013.GA28970@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 19:10:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A32AB4C-70BD-11E2-9DAE-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215670>

Jeff King <peff@peff.net> writes:

> git-show should probably have the same option. I doubt it should be on
> by default, but I can see it being useful for:
>
>   git show --to-filesystem HEAD:Makefile >Makefile
>
> or whatever. I don't think those features necessarily need to come as
> part of Michael's series.

Yeah, all makes sense (including the part that it might be useful
but it does not belong to this series).

Thanks for sanity checking.
