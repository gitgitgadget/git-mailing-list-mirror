Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E7F201A4
	for <e@80x24.org>; Mon, 15 May 2017 04:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbdEOE6C (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 00:58:02 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36841 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOE6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 00:58:01 -0400
Received: by mail-pg0-f46.google.com with SMTP id x64so34813374pgd.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 21:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dxSaf1Nv1YlxrIAaZ/vD2R3MAzPxuN9OJvm4TVP+NFU=;
        b=qpzYqQrkLUAQa6NC96KL7YZ8zXZfFkQGRETKN1+q5MHEwasIBO6VH/beaPCcxCHnG2
         jDXAj1TxpGvlRhZ5vESwxtSfEHCP8fEt7fzjRpu2Kk9SqO/jZgwaPphC42pRVuKPwuEL
         QzhuH2idJwfKI0TRMLov2AX+/aM9/JaNmtjoduqldu34oN7DPSEwFxB9aEfAjR5+ydPV
         cg5TcP1r47VO8enNQz34rPEDUXNbsNgJ8KAiQJz+4e9A06QFj4AfjYlS06QunQNTv9q6
         Na0B6ta11oOdGV9tItvkPm+YOwdO2ypQ5R6mc8Vmg0aY+vDEg0Wl2HrHrKWYyNpLAv7y
         iyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dxSaf1Nv1YlxrIAaZ/vD2R3MAzPxuN9OJvm4TVP+NFU=;
        b=fiaMcbzAZR8mhsCQUVQh9vm0nXxoFs7yNbSirmexxLuH3onwzAEhRSp/+5jpgTu51P
         fu048A6u7F69ZCwU3tFtwxAUCBMKcJO9O6LU6EiMtrPJevrajRk3is23jOTDGe5tQMyx
         AsHCSg+TQ9r/84Bw08O4S9B6LvOQQDLXCp35S7JLiWrm8hiOVKmCByLcTivplxK+IL0Q
         VUNJT5noCj2NDsUVnGeRA+ZGE2OoaITTo9ANb7s0C730byXs/72Pn3u3EHk1NQFQFgUE
         sHmpV6caAIBt0Nw/pz+ZNGQ4p3T9u07ykhdPUI4+ojX1iGhI4ZgvOm7BzGvu1P1fqVN+
         9bsA==
X-Gm-Message-State: AODbwcCT4IfOSMu1Nsa/LIeNdaOAFJYi+/bLgds+tOmS8PrNEQXzwAg1
        VBCg0gV9v1le2w==
X-Received: by 10.98.89.194 with SMTP id k63mr4149072pfj.81.1494824280857;
        Sun, 14 May 2017 21:58:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id r13sm18065443pgn.16.2017.05.14.21.57.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 21:57:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 04/29] log: add exhaustive tests for pattern style options & config
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-5-avarab@gmail.com>
Date:   Mon, 15 May 2017 13:57:57 +0900
In-Reply-To: <20170513231509.7834-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:14:44 +0000")
Message-ID: <xmqq1srqwwbu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +	echo 2e >expect &&
> +	# In PCRE \d in [\d] is like saying "0-9", and matches the 2
> +	# in 2e...
> +	git -C num_commits log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="[\d]" >actual &&
> +	test_cmp expect actual &&
> +	echo 1d >expect &&
> +	# ...in POSIX basic & extended it is the same as [d],
> +	# i.e. "d", which matches 1d, but not and does not match 2e.

s/not and//; I think.

> +	git -C num_commits log -1 --pretty="tformat:%s" -F -E --grep="[\d]" >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -280,6 +301,77 @@ test_expect_success 'log with grep.patternType configuration and command line' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'log with various grep.patternType configurations & command-lines' '
> +	git init pattern-type &&
> +	(
> +		cd pattern-type &&
> +		test_commit 1 file A &&
> +
> +		# The tagname is overridden here because creating a
> +		# tag called "(1|2)" as test_commit would otherwise
> +		# implicitly do would fail on e.g. MINGW.

Thanks.

> +		# POSIX extended needs to have | escaped to match it
> +		# literally, whereas under basic this is the same as
> +		# (|2), i.e. it would also match "1". This test checks
> +		# for extended by asserting that it is not matching
> +		# what basic would match.
> +		git -c grep.patternType=extended log --pretty=tformat:%s \
> +			--grep="\|2" >actual.extended &&

Makes sense.

> +		if test_have_prereq PCRE
> +		then
> +			# Only PCRE would match [\d]\| with only
> +			# "(1|2)" due to [\d]. POSIX basic would match
> +			# both it and "1", and POSIX extended would
> +			# match neither.

OK.  BRE would match because the other side of "\|" is empty to
match anything?

> +			git -c grep.patternType=perl log --pretty=tformat:%s \
> +				--grep="[\d]\|" >actual.perl &&
> +			test_cmp expect.perl actual.perl
> +		fi &&

