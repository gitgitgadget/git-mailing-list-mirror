Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F47202BB
	for <e@80x24.org>; Fri,  5 Apr 2019 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDEVK1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:10:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEVK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:10:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so8558124wmf.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLEjv/iYQKHRcZhfeav9fbJvxjFp1ZT51wWxaLGFP4k=;
        b=EHdQNaOhw6njpigkaHNIvxhQ0zuyzv6TL7Okeddpuvf9ZtJ+woroaDTCkAr0BmU9c1
         bBJ4gPXbLKjlmhU0Eg4h3c+4n7yU+VnWtj30gctkx4xDOcSwjmyJBGn1qBGHs6KT9+/H
         j5TaZz1kUa79wD7duY+f4t/dxwVhUxR9z7ZzG5B9DlssXc3IU50Ipz6P0GazvRMlrMTo
         LlpTHDZuInmTuPiMqolkox9Q+vFmjCRTNptVG7FpqrsQZpxgqEhiadGUj0UFU3yKxO83
         AZRAKQITfM15SWR6hgZ7sHuSDH8yxZ3mny+Y9KDgM01kjx71vBVtxawgAix9sNIzXF3O
         Oh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLEjv/iYQKHRcZhfeav9fbJvxjFp1ZT51wWxaLGFP4k=;
        b=U32CPaGGCipsIZRQas3kl5WZEKE20Z6N09HFG2Lg33PjXOhEJlhIjaLb3fLUWv7KOh
         OAnC9NM0A4aJ1Av8qqmNWE6h22JLSMWbQZTo0nQ3hU5TGvQMbBq5c7gJE9CPrgWwfRo5
         rhey2qhgTkEBrNa0whL/3Z1+erPsZMW+wksBbMnE0AvMHYiTNRH6yKaXi4vlPjz7ArdC
         SlRdOdB+fXKy5KAnHhQ8L+l2aIibQACBRZl0iIKU/YglR1GXcuaYdff3BoRpr3dtqCMj
         kbSlJcpHlaPzliMWXvT649iON7aXA/NVZDaiGIXUecHzSwy9Kb69y59BcQisWmeb7Niv
         dCoA==
X-Gm-Message-State: APjAAAUbWPVcfYU1OGGSSmLApsm67DNmKRuYMfQW/xab6X8MVMn/hs7y
        Pm+JxsyHZcHrPqlmhCiISsg=
X-Google-Smtp-Source: APXvYqx1AoH7sLw4tHMcWwX2wXhUSCfn1ButzyeEMeTIqYmkYpRFXlNZJmTVeH7CW9/KLmUmyNOlrg==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr9722449wmc.92.1554498625236;
        Fri, 05 Apr 2019 14:10:25 -0700 (PDT)
Received: from szeder.dev (x4d0c3c70.dyn.telefonica.de. [77.12.60.112])
        by smtp.gmail.com with ESMTPSA id i28sm65002212wrc.32.2019.04.05.14.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:10:24 -0700 (PDT)
Date:   Fri, 5 Apr 2019 23:10:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
Message-ID: <20190405211022.GC8796@szeder.dev>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet>
 <20190405172536.GA11212@dev-l>
 <34af9bf5-4031-63ed-c34b-9f2c7ff76c51@kdbg.org>
 <nycvar.QRO.7.76.6.1904052047240.41@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1904052218200.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904052218200.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 10:19:59PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 5 Apr 2019, Johannes Schindelin wrote:
> 
> > On Fri, 5 Apr 2019, Johannes Sixt wrote:
> >
> > > Am 05.04.19 um 19:25 schrieb Denton Liu:
> > > > On Fri, Apr 05, 2019 at 04:55:37PM +0200, Johannes Schindelin wrote:
> > > >> On Mon, 1 Apr 2019, Denton Liu wrote:
> > > >>> +test_rebase() {
> > > >>> +	expected="$1" &&
> > > >>> +	shift &&
> > > >>> +	test_expect_success "git rebase $@" "
> > > >>> +		git checkout master &&
> > > >>> +		git reset --hard E &&
> > > >>> +		git checkout side &&
> > > >>> +		git reset --hard G &&
> > > >>> +		git rebase $@ &&
> >
> > > Using $@ in these expansions is wrong. You do not want to forward an
> > > argument list, but you want to construct a command line. $* is correct
> > > here. Then you can remove the single-quotes at the invocation, like so:
> > >
> > > 	test_rebase_same_head success
> > > 	test_rebase_same_head success --onto B B
> > >
> > > Function test_rebase() could be done in the same way, but the first
> > > argument, expected, still needs quotes at the call site, of course.
> >
> > That's a good idea, let me run with it.
> 
> Indeed, this patch fixes it (see e.g.
> https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=34370):
> 
> -- snipsnap --
> Subject: [PATCH] fixup??? t3431: add rebase --fork-point tests
> 
> Try to fix the Mac build, which currently fails thusly:
> 
> 	++ git reset --hard G
> 	HEAD is now at d8775ba G
> 	++ git rebase $'\177'
> 	fatal: invalid upstream '?'
> 	error: last command exited with $?=128
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t3431-rebase-fork-point.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> index 4607e65de6..daa0c77467 100755
> --- a/t/t3431-rebase-fork-point.sh
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -29,29 +29,29 @@ test_expect_success setup '
>  test_rebase() {
>  	expected="$1" &&
>  	shift &&
> -	test_expect_success "git rebase $@" "
> +	test_expect_success "git rebase $*" "
>  		git checkout master &&
>  		git reset --hard E &&
>  		git checkout side &&
>  		git reset --hard G &&
> -		git rebase $@ &&
> +		eval git rebase $* &&

The 'eval' is not necessary, all Bash versions down to v3.0 work
without it.

>  		test_write_lines $expected >expect &&
>  		git log --pretty=%s >actual &&
>  		test_cmp expect actual
>  	"
>  }
> 
> -test_rebase 'G F E D B A' ''
> -test_rebase 'G F D B A' '--onto D'
> -test_rebase 'G F B A' '--keep-base'
> -test_rebase 'G F C E D B A' '--no-fork-point'
> -test_rebase 'G F C D B A' '--no-fork-point --onto D'
> -test_rebase 'G F C B A' '--no-fork-point --keep-base'
> -test_rebase 'G F E D B A' '--fork-point refs/heads/master'
> -test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
> -test_rebase 'G F B A' '--fork-point --keep-base refs/heads/master'
> -test_rebase 'G F C E D B A' 'refs/heads/master'
> -test_rebase 'G F C D B A' '--onto D refs/heads/master'
> -test_rebase 'G F C B A' '--keep-base refs/heads/master'
> +test_rebase 'G F E D B A'
> +test_rebase 'G F D B A' --onto D
> +test_rebase 'G F B A' --keep-base
> +test_rebase 'G F C E D B A' --no-fork-point
> +test_rebase 'G F C D B A' --no-fork-point --onto D
> +test_rebase 'G F C B A' --no-fork-point --keep-base
> +test_rebase 'G F E D B A' --fork-point refs/heads/master
> +test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
> +test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
> +test_rebase 'G F C E D B A' refs/heads/master
> +test_rebase 'G F C D B A' --onto D refs/heads/master
> +test_rebase 'G F C B A' --keep-base refs/heads/master
> 
>  test_done
> --
> 2.21.0.windows.1.152.g5895f170b6
> 
