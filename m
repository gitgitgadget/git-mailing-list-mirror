Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420BD1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfAUPEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:04:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37224 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAUPEe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:04:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so23760899wrt.4
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAhPVvHr4H0AoGckfvTcVJLj6ky89dcwS/RLpNIwmfM=;
        b=CBIlusqR7jtbyio8dW9MW/v1jqDjykYtvIrcvt9cfiPCkNzsoXH2bmTySs8cDzRvWS
         cC1j7pabaROBe32ZjpPYLcrWKVvUOE+SJZyk8gOUUNEOPPO42DsDlWXrZlFFpRbtnBPv
         t8Kw7fFD9lXnp8cYsktfxUSHzhDyS17lQDOL1nVFeseq7Jo+S741e/ogxQXd+fLm/BZ6
         xXuzgQucWUvPm2ZOOHAORJPpR4JqxHkwkohU9sfMjOaGomIoEl3ZrkKCi9ssqDhNJDHa
         4wRw+IoqhTxzJjbJiWUoXoVOhaUW1AKOfVeX1liML0+9aqcnXPHyZy4due1eZ8vj6PK8
         AM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAhPVvHr4H0AoGckfvTcVJLj6ky89dcwS/RLpNIwmfM=;
        b=hPtG0b8SMN+O/sWA4eDDwgYb7W3Wxqbsk5nf7qfzsPwxqhj7hqwSJlyK8t70HWnIff
         o98yQk7xM7BR6y4YL9XLmgWD58y8M0ckgVFSPjXUFENzaKBCR291ulFAp/wlcXOnpuNV
         k7hVT8rQmYeeozF+MgSguuVe9H9tCCIphBWz3GPwxUXO03x2PIvwFnMnoKGIHLiH/2MO
         jH40J6bx1ryFj1hzgdtIuNNdyaoFDcoAxI9OILHTwbyTWeDR22WW8XpxzmCSl4Dtxs63
         9oRH2B2QboTSfW2ApMhk1mpvgAkNjMnSfWaNo6rkUsLc/0bn8sdZaAWa2Ie6ytwinUol
         eCsg==
X-Gm-Message-State: AJcUukcYk+QgDNO9L0tiO5Mw3JJPVjXiER+1tElAvDB0TSwdk1TQr3H4
        42gsR8E63fTSOZSIUn6JSUd4iV5Q
X-Google-Smtp-Source: ALg8bN5pThP+NXiGhW+55HlN8pe98TQxt8QVPD5av6pIRSKxqbEK4oDLzJ1xmn8+8FN1YgkFURWfmA==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr28518340wrq.265.1548083073197;
        Mon, 21 Jan 2019 07:04:33 -0800 (PST)
Received: from szeder.dev (x4db9d4de.dyn.telefonica.de. [77.185.212.222])
        by smtp.gmail.com with ESMTPSA id t4sm63743291wrb.64.2019.01.21.07.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:04:32 -0800 (PST)
Date:   Mon, 21 Jan 2019 16:04:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 5/5] Add `human` date format tests.
Message-ID: <20190121150429.GR840@szeder.dev>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20190121051646.20991-1-ischis2@cox.net>
 <20190121051646.20991-6-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121051646.20991-6-ischis2@cox.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 20, 2019 at 10:16:46PM -0700, Stephen P. Smith wrote:
> When using `human` several fields are suppressed depending on the time
> difference between the reference date and the local computer date. In
> cases where the difference is less than a year, the year field is
> supppressed. If the time is less than a day; the month and year is
> suppressed.
> 
> Use TEST_DATE_NOW environment variable when using the test-tool to
> hold the expected output strings constant.
> 
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>  t/t0006-date.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index ffb2975e48..35f7b52dd7 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -128,4 +128,22 @@ check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
>  check_approxidate '2008-12-01' '2008-12-01 19:20:00'
>  check_approxidate '2009-12-01' '2009-12-01 19:20:00'
>  
> +check_date_format_human() {
> +	t=$(($TEST_DATE_NOW - $1))
> +	echo "$t -> $2" >expect
> +	test_expect_success "human date $t" '
> +	test-tool date human $t >actual &&
> +	test_cmp expect actual

Note that the relative time output is translated, see all the Q_()
calls in show_date_relative().  Consequently, these tests fail in
GETTEXT_POISON builds.  Please use 'test_i18ncmp' instead.

Furthermore, I think it would help readibility of this helper function
if the commands in the 'test_expect_success' block were indented.

> +'
> +}
> +
> +check_date_format_human 18000 "5 hours ago" # 5 hours ago
> +check_date_format_human 432000 "Tue Aug 25 19:20" # 5 days ago
> +check_date_format_human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
> +check_date_format_human 13000000 "Thu Apr 2 08:13" # 5 months ago
> +check_date_format_human 31449600 "Aug 31 2008" # 12 months ago
> +check_date_format_human 37500000 "Jun 22 2008" # 1 year, 2 months ago
> +check_date_format_human 55188000 "Dec 1 2007" # 1 year, 9 months ago
> +check_date_format_human 630000000 "Sep 13 1989" # 20 years ago
> +
>  test_done
> -- 
> 2.20.1.2.gb21ebb671b
> 
