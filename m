From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Fri, 04 May 2012 10:18:29 -0700
Message-ID: <7vwr4ramqi.fsf@alter.siamese.dyndns.org>
References: <4FA2B4D3.90809@seap.minhap.es>
 <20120504070802.GA21895@sigill.intra.peff.net>
 <alpine.DEB.2.00.1205040921090.12158@tvnag.unkk.fr>
 <20120504073913.GA22388@sigill.intra.peff.net>
 <7v4nrwc61e.fsf@alter.siamese.dyndns.org>
 <20120504160543.GB1331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 19:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQM9M-0007Xs-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 19:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab2EDRSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 13:18:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2EDRSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 13:18:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAAE7B50;
	Fri,  4 May 2012 13:18:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xu7mMvaLbk6wlI775VfSC5STeKc=; b=q6acKK
	mQ8AvWW+XUKe7b99NVameCPq7Bb4fBWlPg9SCrGi7ZPgaFNhDduSA1YnJyZ8LMMo
	3SBP5UXtPNKobUfjP/rf8UNxjs7tfvZVhcxLm3LktOewmVuQSZGfyQp8rg8rAzKt
	7/e9G+z6iDm124uCIB/UFnX+xxq+66rhvCpBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVKls/pBzbJnaKv/HrZts+p+4YyPbDsU
	yfrGnlpRUKGWTRfZJZp5C1xnryetDmu+QL7QQPvMvEKgW4XPmgzg/4ETHLshVDle
	YSEXgszuhNDysflyk1FIsztBiY03InW3/ZzpWPVi8Zwe59GmGBRNBViP9UyMJ424
	FZdIS6740b4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A35A97B4F;
	Fri,  4 May 2012 13:18:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A2637B43; Fri,  4 May 2012
 13:18:31 -0400 (EDT)
In-Reply-To: <20120504160543.GB1331@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 4 May 2012 12:05:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BC95E62-960D-11E1-B184-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197040>

Jeff King <peff@peff.net> writes:

> I am very tempted by that, too. In the meantime (and even once that curl
> version comes out and we write the new code, people will still be on the
> older version of curl), we have a fallback: they can use http.proxy if
> they want auth support. It's not as nice as supporting auth on the
> environment variables, but I think it will end up being a lot cleaner.

Sounds good.
