From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sun, 12 May 2013 22:01:38 -0700
Message-ID: <7vtxm7qxql.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
	<7vy5bm22f8.fsf@alter.siamese.dyndns.org>
	<518E0741.1060008@drmicha.warpmail.net>
	<518E16B1.7000505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 13 07:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbktP-0007dA-5U
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 07:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab3EMFBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 01:01:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab3EMFBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 01:01:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196F119BE0;
	Mon, 13 May 2013 05:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ivHmNO+H7uri/SwV/KwTHShNcBI=; b=w3JiRN
	hqGIS/aXigFfGPQL5tm4vGA7kiSw/Bg7Lx2tRsHzftsoW2srD8rVGqJXw6aDwrge
	DQUcXTo4rCoXBsP7MP5l+tFP6+ikh8nAUMbIsWij12g9c1qNk0b+kwRJdqYP8050
	CEiPr5804UMbQ2CjXYjsqOVhzyVnXiUT7HcZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RCCFKJXIvMMNKTqoZwvEOrnc1HMckU8U
	gYsgRZ/rT7PNY4FQFDI5Hw/vEOchAB20nGKPxn1nzdyzUrrPdhPY9a2vfzVuWHzy
	Bnolwf5r+Xt094J4IO4bPORkRBynPWMQ/dyBCLsiDGQb73MZZ5VV9M7agXozBKF7
	0jpzFQPQWbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCBA19BDE;
	Mon, 13 May 2013 05:01:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7116C19BDD;
	Mon, 13 May 2013 05:01:40 +0000 (UTC)
In-Reply-To: <518E16B1.7000505@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Sat, 11 May 2013 12:00:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32AEBA94-BB8A-11E2-9040-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224087>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Adding to that:
>
> Somehow I still feel I should introduce a new attribute "show" (or a
> better name) similar to "diff" so that you can specifiy a diff driver to
> use for showing a blob (or grepping it), which may or may not be the
> same you use for "diff". This would be a much more fine-grained and
> systematic way of setting a default for "--textconv" for blobs.
>
> Of course, some driver attributes would just not matter for coverting
> blobs, but that doesn't hurt.
>
> I'm just wondering whether it's worth the effort and whether I should
> distinguish between "show" and grep".

Haven't thought things through, but my gut feeling is that it is on
the other side of the line. We could of course add more features and
over-engineered mechanisms, and the implementation may end up to be
even modular and clean, but I cannot answer "Yes" with a confidence
to the question "Does such a fine grained control help the users?"
and cannot answer "If so in what way?" myself.
