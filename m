Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9298E2018D
	for <e@80x24.org>; Thu, 11 May 2017 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934018AbdEKSbN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:31:13 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33317 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933972AbdEKSbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:31:12 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so17820014pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qq2fG9pw6Y9ZAHBJgTNoxE3TT/veBEYmft/fhW76LH4=;
        b=CkPDardwzbD2qHMhcs/KywW9d9+E78ecZiKN4NVm8pxVkJFS31hcf5v9Rqf6or4GXw
         UzT5HnWfbxtdx7P9BMINXVWHEMivDjmbrMkV9LAmPsz/nGCbLyj+BljchQWkzoFdg0WX
         WJJntwkL8hetjwtWt559pqUYPfFoEwNc/ToCX5UxCqmhu4OQK1XdpO7VWP24IZgHhwgS
         p5ManRw6fDLqx8HbkZ5N5Py86roUCqIGn8C6d605WNtOVKH/XnJzjFSFaS+URMxi6q0m
         y2ffxaOrRc+wHWhyD9Tg83C6AxiyuqCI4u91sYzEWBhJawV0RrdXumJcmFQTIOg1nxdi
         NPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qq2fG9pw6Y9ZAHBJgTNoxE3TT/veBEYmft/fhW76LH4=;
        b=aHG4YMp966lNWV2NGCWQV3jCueiXCA/NZwbNwNt2WCL+8bNhY8Qf++vYc6hx6SqckV
         cNkaMqBSATMyTQvqyJ6GAKObUuvB25Q4NQ6FpQYtQFPrY+GtY68onXJRx7xWyRRVaejW
         oqnoe4CcjMVYw0si1vCPsIbZOLc2/pJtC61sca51vrDQkluZxi8su0Fz2Mm9YIlTbeXh
         RQ5sDt3ttIuVr6ZT3V8z4gRuAMnKh/f/iE86MaF0pNypMveX094Yv+twaTqsQpJ491z+
         v4k2N3KJ7qRfMZXeTO0qnLd1i1MEGn++R6e9iyINbfEB2iW66iLUeIhH6isBJQbk2TTS
         IjSA==
X-Gm-Message-State: AODbwcCn4s7A2Hcl5vdAFDpdE+EMxd5grkCYK9I7znLr7MDu7oIo+PfO
        tCbWrlftfYPtGwLT
X-Received: by 10.98.0.7 with SMTP id 7mr153927pfa.127.1494527471749;
        Thu, 11 May 2017 11:31:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id w30sm1275163pge.45.2017.05.11.11.31.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 11:31:10 -0700 (PDT)
Date:   Thu, 11 May 2017 11:31:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 07/29] grep: change non-ASCII -i test to stop using
 --debug
Message-ID: <20170511183109.GC83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-8-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Change a non-ASCII case-insensitive test case to stop using --debug,
> and instead simply test for the expected results.
> 
> The test coverage remains the same with this change, but the test
> won't break due to internal refactoring.
> 
> This test was added in commit 793dc676e0 ("grep/icase: avoid kwsset
> when -F is specified", 2016-06-25). It was asserting that the regex
> must be compiled with compile_fixed_regexp(), instead test for the
> expected results, allowing the underlying implementation to change.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t7812-grep-icase-non-ascii.sh | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
> index 04a61cb8e0..969e7c0dda 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -36,29 +36,14 @@ test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre utf-8 string with "+"' '
>  '
>  
>  test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
> -	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
> -		 grep fixed >debug1 &&
> -	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
> -	test_cmp expect1 debug1 &&
> -
> -	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
> -		 grep fixed >debug2 &&
> -	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
> -	test_cmp expect2 debug2
> +	git grep -i -F "TILRAUN: Halló Heimur!" &&
> +	git grep -i -F "TILRAUN: HALLÓ HEIMUR!"
>  '
>  
>  test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
> -	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
> -
> -	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
> -		 grep fixed >debug1 &&
> -	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
> -	test_cmp expect1 debug1 &&
> -
> -	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
> -		 grep fixed >debug2 &&
> -	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
> -	test_cmp expect2 debug2
> +	test_write_lines "TILRAUN: Halló Heimur [abc]!" >file3 &&
> +	git add file3 &&
> +	git grep --debug -i -F "TILRAUN: Halló Heimur [abc]!" file3
>  '

Your commit message leads me to believe that you are reformatting the
tests such that you don't use the '--dubug' flag yet this last line uses
it.  Is this intentional?

-- 
Brandon Williams
