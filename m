From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe: simplify has_changes and contains
Date: Sun, 07 Jul 2013 10:25:59 -0700
Message-ID: <7vbo6e5ljs.fsf@alter.siamese.dyndns.org>
References: <1373118807-1345-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<20130707040337.GA30898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvsiy-0004rt-AC
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3GGR0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:26:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab3GGR0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:26:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BC222A815;
	Sun,  7 Jul 2013 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s8E614KWAdNyVvmcY7E/3WOvW2w=; b=d0rxMB
	gKRLPvpjxtmfvzAjUdxopMTue0T5jHbgJ/nqxUx6FC/F0i/Y3csivmTeX4ZC1Nnk
	5Wdt0j7Ffs30Wewne26INFgWDITqrvfXEPaUYaTo1up9kBMbdZYv9qnlpMfwYZmW
	tOmk8qA0LfEp83npAUDQAFD5klA7ZVF8niios=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MONy19JGFWlBbyAaxyO2FeunLjG58eRr
	yKeqC1qk3sxPdqd4XxXyJWbANsu6JvjO2cltLCX5yNIySYZ4WcovwJmLpRSzLDGH
	LXmG7FNDcCaWRT2FsX7kY32GZcGhtvDZiahftGmWqaDlE+0bpjE4xMcofQ8RXgBu
	hhFKvFDV8XI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F5282A814;
	Sun,  7 Jul 2013 17:26:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ACB62A810;
	Sun,  7 Jul 2013 17:26:01 +0000 (UTC)
In-Reply-To: <20130707040337.GA30898@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 7 Jul 2013 00:03:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B74D754-E72A-11E2-8529-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229778>

Jeff King <peff@peff.net> writes:

> Before, if (!one && !two) we would call contains(two, ...), and now we
> will simply assume it is zero. Which I think is an improvement, as we
> would have segfaulted before. I don't think it is a bug in the current
> code (we would not ever feed the function two NULLs), but it is nice to
> be more defensive.
>
> Acked-by: Jeff King <peff@peff.net>

Thanks, both.
