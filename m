From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ALTERNATIVE v6.v3 4/6] config: parse http.<url>.<variable> using urlmatch
Date: Mon, 05 Aug 2013 15:56:36 -0700
Message-ID: <7vsiyniw63.fsf@alter.siamese.dyndns.org>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
	<1375298768-7740-7-git-send-email-gitster@pobox.com>
	<20130731224511.GA25882@sigill.intra.peff.net>
	<62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
	<5acf57129e37a87611ed03648f7b368@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 00:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Thk-0005NY-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 00:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab3HEW4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 18:56:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566Ab3HEW4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 18:56:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E47D36C62;
	Mon,  5 Aug 2013 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rh7GK2MtPioKTCKIocyqJ4390EE=; b=DcVfU1
	+1JNtJSIQrUtkbhxTUJfWC81ISud1/9UkU+/bxqpZPnWibR5XiDBFxFNF7SR3GlZ
	9QxGTA0bEzDSI+yLxyTr+w8kyOtNHdtQ12OfZi0jy5ul1cu3/AuWTzwh7E4hriZN
	PoWtykitlVufy/j8R3T4Ox+qGRTjdd6XQpGJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6zdlyZwGqiGxDtydxD/6a1pnUrpQD38
	xjjgg+MrDLzHhjWHsm8y23+fU9PBhQbxVD8d5xI3W4lFOeJ1ltleABRculZNJrf7
	QWwu2l61CdNBm4rW26qSnEDYxwgIsKzh99IFFXxebcd/+7tY7rDMToO2rcRJTw0v
	VWYU7Wt88Vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94DB936C61;
	Mon,  5 Aug 2013 22:56:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A622D36C60;
	Mon,  5 Aug 2013 22:56:37 +0000 (UTC)
In-Reply-To: <5acf57129e37a87611ed03648f7b368@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Mon, 5 Aug 2013 13:20:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48B7DE4E-FE22-11E2-B9FA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231705>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Use the urlmatch_config_entry() to wrap the underlying
> http_options() two-level variable parser in order to set
> http.<variable> to the value with the most specific URL in the
> configuration.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Oops, what did we sign-off?

> This version of 4/6 moves the tests to t0110 since urlmatch is now global.
> The config tests are removed since part 6/6 already has those and they no
> longer belong with the urlmatch normalization tests.
>
> The Makefile rule has been removed since it's no longer needed to build
> correctly as the test program no longer includes http.c.
>
> Other than those changes (and a minor rename to reflect the new location),
> this patch is identical to the previous v6.v2 4/6.

Ahh, figures.  Thanks.

Peff, any comments?

> diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
> new file mode 100755
> index 00000000..8d6096d4
> --- /dev/null
> +++ b/t/t0110-urlmatch-normalization.sh
> @@ -0,0 +1,177 @@
> +#!/bin/sh
> +
> +test_description='urlmatch URL normalization'
> +. ./test-lib.sh
> +
> +# The base name of the test url files
> +tu="$TEST_DIRECTORY/t0110/url"
> +
> +# Note that only file: URLs should be allowed without a host

It is somewhat unfortunate that the form most commonly used for
pushing is not supported at all, i.e.

	host:path

Current configuration set may not have anything interesting to
affect the git-over-ssh push codepath, so in practice it may not
matter, though.

> +test_expect_success 'url authority' '

"authority" refers to the host part? (not a complaint, but is a
question)

> +test_expect_success 'url port checks' '
> +	test-urlmatch-normalization "xyz://q@some.host:" &&

This is presumably replaced by a default port for xyz:// scheme,
whatever the default port is, in other words, it is as if no colon
is given at the end?

> +	test-urlmatch-normalization "xyz://q@some.host:456/" &&
> +	! test-urlmatch-normalization "xyz://q@some.host:0" &&
> +	! test-urlmatch-normalization "xyz://q@some.host:0000000" &&

Port #0 is disallowed?

> +	test-urlmatch-normalization "xyz://q@some.host:0000001?" &&

Is it the same as specifying "xyz://q@some.host:1?" and does it
match "xyz://q@some.host:1"?

> +	test-urlmatch-normalization "xyz://q@some.host:065535#" &&

Ditto, for 65535 and without #-fragment at the end?

> +test_expect_success 'url port normalization' '
> +	test "$(test-urlmatch-normalization -p "http://x:800")" = "http://x:800/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:0800")" = "http://x:800/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:00000800")" = "http://x:800/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:065535")" = "http://x:65535/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:1")" = "http://x:1/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:80")" = "http://x/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:080")" = "http://x/" &&
> +	test "$(test-urlmatch-normalization -p "http://x:000000080")" = "http://x/" &&
> +	test "$(test-urlmatch-normalization -p "https://x:443")" = "https://x/" &&
> +	test "$(test-urlmatch-normalization -p "https://x:0443")" = "https://x/" &&
> +	test "$(test-urlmatch-normalization -p "https://x:000000443")" = "https://x/"
> +'

OK, these answer most of the previous questions.

> +# http://@foo specifies an empty user name but does not specify a password
> +# http://foo  specifies neither a user name nor a password
> +# So they should not be equivalent
> +test_expect_success 'url equivalents' '
> +	test-urlmatch-normalization "httP://x" "Http://X/" &&
> +	test-urlmatch-normalization "Http://%4d%65:%4d^%70@The.Host" "hTTP://Me:%4D^p@the.HOST:80/" &&
> +	! test-urlmatch-normalization "https://@x.y/^" "httpS://x.y:443/^" &&

The comment is about this test, which seems to make sense.  What is
"^"?  Just a random valid character that can appear in the path?
(not a complaint, but is a question).
