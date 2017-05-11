Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8B9201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbdEKURq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:17:46 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34281 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932366AbdEKURp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:17:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so19041188pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Giva6qtKnYkUnQsvgyEDTuVgO4SEGsDE9mQJE8b+Y8Q=;
        b=QisxFlEOz78W6uZtfOI7W56r0yGSie/U8ZDIV3+0N5rwX4Q/L61rM+oFX6OhRSuixx
         aw//62YVKr2KuvICT/Ky+I1GhaEq46tMWci3N0eVVc7/V7a03R08zkoCSqKm+904tLtZ
         EnJInq5ZyVQeaVx/h628XIMhq8ErSUdh8jbj7dMmwInThCnOUozHf4pF6QwdA0YpfGfq
         Y+blcISOCt+c7e7HKIcP7xTdHTctTtmkSLwFJgz8Bn86D/NcAVf+LXYHm7Yu0JdBY42u
         hI5XIX+rh89c6n0NwCBvW7THLQGYPbFODEDdYecSNkZC5vfiGYsM0/nBkPi05su5HzEJ
         zX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Giva6qtKnYkUnQsvgyEDTuVgO4SEGsDE9mQJE8b+Y8Q=;
        b=g6A6BxK8cpY1UX2fBYlDVSp0KnUnVo8RcxcGE4ZSItna/qTIaYOQ98wKuEsv1C3VKk
         F7iddSXl2DSFHY5Uhio5IiJNdaeU534uWrYBTJCmmTfUAhW/cAnlXAp7s1qEVyVsdLWH
         /u2ONsujV6zVm78LwKyLMUPGvIfa+VGy5Dy0XoNe4NsEoTX2uAaz1lrYajH6MkCjyHsX
         D5Gx6lNXknhLAa1/AhwXEfR2mypm79AzbArra3z0A90BumnERAh5kEq8RAU671mPZmZr
         7xG2MrbjF47eLp9sEoFzLRdLnOoQLT3A3UuMbaZ/h0xEVk4dJuVrrca0SC589ZGLMgu5
         Ne+A==
X-Gm-Message-State: AODbwcAM+h37LA2Lqk0sG8ORjfG1CQrjpLk/OhInpxzgTQJ5HR8xNMYJ
        iIrY1RH8R9qRJx60
X-Received: by 10.99.140.93 with SMTP id q29mr295128pgn.237.1494533864487;
        Thu, 11 May 2017 13:17:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:938:3d1d:44aa:d816])
        by smtp.gmail.com with ESMTPSA id l186sm1541372pgd.42.2017.05.11.13.17.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 13:17:43 -0700 (PDT)
Date:   Thu, 11 May 2017 13:17:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 26/29] pack-objects & index-pack: add test for --threads
 warning
Message-ID: <20170511201742.GJ83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com>
 <20170511091829.5634-27-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511091829.5634-27-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Add a test for the warning that's emitted when --threads or
> pack.threads is provided under NO_PTHREADS=YesPlease. This uses the
> new PTHREADS prerequisite.
> 
> The assertion for C_LOCALE_OUTPUT in the latter test is currently
> redundant, since unlike index-pack the pack-objects warnings aren't
> i18n'd. However they might be changed to be i18n'd in the future, and
> there's no harm in future-proofing the test.
> 
> There's an existing bug in the implementation of pack-objects which
> this test currently tests for as-is. Details about the bug & the fix
> are included in a follow-up change.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5300-pack-object.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 43a672c345..1629fa80b0 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -421,6 +421,40 @@ test_expect_success 'index-pack <pack> works in non-repo' '
>  	test_path_is_file foo.idx
>  '
>  
> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=N or pack.threads=N warns when no pthreads' '
> +	test_must_fail git index-pack --threads=2 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 1 warnings &&
> +	grep -F "no threads support, ignoring --threads=2" err &&
> +	test_must_fail git -c pack.threads=2 index-pack 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 1 warnings &&
> +	grep -F "no threads support, ignoring pack.threads" err &&
> +	test_must_fail git -c pack.threads=2 index-pack --threads=4 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 2 warnings &&
> +	grep -F "no threads support, ignoring --threads=4" err &&
> +	grep -F "no threads support, ignoring pack.threads" err
> +'
> +
> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.threads=N warns when no pthreads' '
> +	git pack-objects --threads=2 --stdout --all </dev/null >/dev/null 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 1 warnings &&
> +	grep -F "no threads support, ignoring --threads" err &&
> +	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
> +	cat err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 2 warnings &&
> +	grep -F "no threads support, ignoring --threads" err &&
> +	grep -F "no threads support, ignoring pack.threads" err &&
> +	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
> +	grep ^warning: err >warnings &&
> +	test_line_count = 2 warnings &&
> +	grep -F "no threads support, ignoring --threads" err &&
> +	grep -F "no threads support, ignoring pack.threads" err
> +'
> +

Some of these tests you might want to rewrite using test_i18ncmp to
ensure that the messages match in other languages.  That is assuming
this error message is translated (which it should be).

>  #
>  # WARNING!
>  #
> -- 
> 2.11.0
> 

-- 
Brandon Williams
