Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1896D20196
	for <e@80x24.org>; Wed, 13 Jul 2016 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcGMTH6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:07:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbcGMTH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:07:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F049829401;
	Wed, 13 Jul 2016 15:07:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zA4W3A6VZcDxJSwJy3lr/6f+UrQ=; b=VbF70t
	gBB+N5sHEwu+sxLdp1ISFFFnne+FvCXfvzcgcU8k9XCwhZhWbYAEIMfwkz3TQKCS
	J7Wq5r6Njts4LsBJxnOHt3W65VxXFVH3hqG09+7rjJ75/PsV4ngysI1Fo145FHRL
	BzQHkAr2glF10BrIZxTw+E6xBJMKlnp/qVqEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pMwmXm5U4lA+eey2AtenNRwMU0NqgHZ8
	dkG1kbbIZ7hLYJtWhVbsL62eX2i0vNt0oSUb0u3OoKmEHMWwr8B5AxSw+IzoFSLT
	CDm8GK6Ddz9N3AXZKq/lTpn4obQuehXXNvRRkhON6QDd4/vZmXZ4oQKWAhekiTAy
	u/o2QICF11g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E8AC0293FF;
	Wed, 13 Jul 2016 15:07:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E2F9293FE;
	Wed, 13 Jul 2016 15:07:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607120927410.6426@virtualbox>
	<20160712073912.GA26431@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607121257450.6426@virtualbox>
	<xmqqbn2267zq.fsf@gitster.mtv.corp.google.com>
	<20160713020132.GA13918@sigill.intra.peff.net>
	<xmqqh9bt34n1.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607132048370.6426@virtualbox>
Date:	Wed, 13 Jul 2016 12:07:34 -0700
In-Reply-To: <alpine.DEB.2.20.1607132048370.6426@virtualbox> (Johannes
	Schindelin's message of "Wed, 13 Jul 2016 20:52:14 +0200 (CEST)")
Message-ID: <xmqq8tx51hmx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F8CFDD0-492D-11E6-B3B7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about this one instead (which is part of the time_t-may-be-int64
> branch on https://github.com/dscho/git which I still have to complete, as
> some unsigned longs still slipped out of my previous net)? It strikes me
> as much more robust:

Hmm, sorry, I do not see much upside here (iow, the 2038 test you
came up with is as robust).  When the internal time representation
is updated from "unsigned long" to a signed and wider type [*1*],
test-date has to stop reading the second-from-epoch input with
strtol(), whose property that overflow will always result in
LONG_MAX gives the robustness of the 2038 test, and needs to be
updated.  With this "is64bit" patch, you explicitly measure
"unsigned long", knowing that our internal time representation
currently is that type, and that would need to be updated when
widening happens.  So both need to be updated anyway in the future.

The update to check_show Peff suggested is the same as the previous
one, so there is no upside nor downside.

The prerequisite name 64BITTIME that lost an underscore is harder to
read, so there is a slight downside.

Moving of lazy_prereq to test-lib might be an upside if we were
planning to add a test that depends on the system having or not
having 64-bit timestamp elsewhere, but I do not think of a reason
why such a new test cannot go to t0006-date, which has the perfect
name for such a test and is not overly long right now (114 lines).

So, unless you have a more solid reason to reject the updated t0006
earlier in the thread, I am not sure what we'd gain by replacing it
with this version.


> -- snipsnap --
> From abe59dbb2235bb1d7aad8e78a66e196acb372ec8 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Tue, 12 Jul 2016 13:19:53 +0200
> Subject: [PATCH] t0006: dates absurdly far require a 64-bit data type
>
> Git's source code refers to timestamps as unsigned longs. On 32-bit
> platforms, as well as on Windows, unsigned long is not large enough to
> capture dates that are "absurdly far in the future".
>
> Let's skip those tests if we know they cannot succeed.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/helper/test-date.c | 5 ++++-
>  t/t0006-date.sh      | 6 +++---
>  t/test-lib.sh        | 2 ++
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/t/helper/test-date.c b/t/helper/test-date.c
> index d9ab360..1e12d93 100644
> --- a/t/helper/test-date.c
> +++ b/t/helper/test-date.c
> @@ -4,7 +4,8 @@ static const char *usage_msg = "\n"
>  "  test-date relative [time_t]...\n"
>  "  test-date show:<format> [time_t]...\n"
>  "  test-date parse [date]...\n"
> -"  test-date approxidate [date]...\n";
> +"  test-date approxidate [date]...\n"
> +"  test-date is64bit\n";
>  
>  static void show_relative_dates(char **argv, struct timeval *now)
>  {
> @@ -93,6 +94,8 @@ int main(int argc, char **argv)
>  		parse_dates(argv+1, &now);
>  	else if (!strcmp(*argv, "approxidate"))
>  		parse_approxidate(argv+1, &now);
> +	else if (!strcmp(*argv, "is64bit"))
> +		return sizeof(unsigned long) == 8 ? 0 : 1;
>  	else
>  		usage(usage_msg);
>  	return 0;
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index 04ce535..52f6b62 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -31,7 +31,7 @@ check_show () {
>  	format=$1
>  	time=$2
>  	expect=$3
> -	test_expect_${4:-success} "show date ($format:$time)" '
> +	test_expect_success $4 "show date ($format:$time)" '
>  		echo "$time -> $expect" >expect &&
>  		test-date show:$format "$time" >actual &&
>  		test_cmp expect actual
> @@ -50,8 +50,8 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
>  
>  # arbitrary time absurdly far in the future
>  FUTURE="5758122296 -0400"
> -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
> -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> +check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" 64BITTIME
> +check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" 64BITTIME
>  
>  check_parse() {
>  	echo "$1 -> $2" >expect
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0055ebb..4e1afb0 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1111,3 +1111,5 @@ run_with_limited_cmdline () {
>  }
>  
>  test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
> +
> +test_lazy_prereq 64BITTIME 'test-date is64bit'
