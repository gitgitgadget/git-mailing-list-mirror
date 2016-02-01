From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] post-strbuf_getline cleanups
Date: Sun, 31 Jan 2016 18:14:01 -0800
Message-ID: <xmqqzivlw51y.fsf@gitster.mtv.corp.google.com>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 03:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ40L-0004Wi-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 03:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933637AbcBACOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 21:14:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933416AbcBACOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 21:14:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 344624187F;
	Sun, 31 Jan 2016 21:14:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qiBvGq9Hd62D0vJqOgnKP+qcIDg=; b=JHihCU
	x9vQQO20yEeqIM/yIMdtX8BEAZ9GFwV6nmmmYqmNJUJ8MBqLMvnUaH5S6gmxWtEx
	7/SAMNFxJVg10v/doGveVW7J/dAQKOnxT5lo1lakW2lRjtBvzKCQ05NGkCBtvs1l
	13Ycu9L43mQcvboX8h6LeOOHsZ5ISlyKhG1AA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tmkjMcSr0FhOg/x2kRgH2H3N+lmGBokt
	L6MHv2VIf/Ox346wRCRUsoTYVqlNkalkHk8JypI0g/RZKq6v5drnuSK9dFbMC42j
	FWeYD1P0B88Vmqqzll7wy1HycHfMkXVu8KFg6gU4jSzY0qUXoaJ8zM9aXLQmsvux
	LYFOYexQn/Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C8F74187E;
	Sun, 31 Jan 2016 21:14:03 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A5CA64187D;
	Sun, 31 Jan 2016 21:14:02 -0500 (EST)
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 31 Jan 2016 06:22:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7662FBD8-C889-11E5-AE53-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285177>

Jeff King <peff@peff.net> writes:

> As promised, here are the "how about this on top" patches that came out
> of the discussion for the "strbuf_getline" series in:
>
>   http://thread.gmane.org/gmane.comp.version-control.msysgit/21773/focus=284001

Thanks for following up.

> As I looked further at some of the option-parsing cleanups, I realized
> that some of them are more than cleanups; we're actually fixing bizarre
> behavior and segfaults.
>
>   [1/6]: give "nbuf" strbuf a more meaningful name
>   [2/6]: checkout-index: simplify "-z" option parsing
>   [3/6]: checkout-index: handle "--no-prefix" option
>   [4/6]: checkout-index: handle "--no-index" option
>   [5/6]: checkout-index: disallow "--no-stage" option
>   [6/6]: apply, ls-files: simplify "-z" parsing
>
> -Peff
