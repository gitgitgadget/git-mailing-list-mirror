Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7641FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 09:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbcLMJcZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 04:32:25 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36239 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932301AbcLMJcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 04:32:21 -0500
Received: by mail-io0-f196.google.com with SMTP id b194so27282119ioa.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zLzVsflxcVWCn8LW4KlJOoYNFyYQAxiZ/6K1vCxA2Kg=;
        b=mMA/4IXNrxX8BoPZIkEkOvdgQ6L3Ro3nL10k+ImzhMsJA5zUF02NGqq3jKo2xMFfqN
         /bM5kFisHH2T3mCrqW3z+AVZ1VR3mME/C0nVYxc7RiSQ9+87zKMFYC3Ua9DEjDXwPM2j
         99QXJ4P3JwhGqxJbzBEReIMgqlqQRoQH7JhoKmv/UXiOwXg7Djc5cNcgH1ASjmED7Sky
         UwkyqYbUcoIO4emaiDKrS/qMfAACezbb/WQtes4SvlbIRaXt9pyKF71n1Rt3Q9mZoQxX
         I6VNPxxcYlnI4TFuDMuUkb+da7lZ4jgPUUffwUqt1tMGwwR36VkDeYosOK3nQAcCN/qB
         /8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zLzVsflxcVWCn8LW4KlJOoYNFyYQAxiZ/6K1vCxA2Kg=;
        b=KlkL7tHEEumLZtHlUSfgTacRt/Eshc4Kw5WTCI48gRVdJpHEgpuwrFf/iAE96fQ7ht
         58eJLqy8Sb+FUbhhBSpz3Yjwuuuz9kktc8rHCow2iJlj+pqRVQOl4h5VM7wF6Hand0wn
         e8JW3mCBr0KT9eoTPmFlRduZasLB/la5j4/VyuMB3geX7EbojScOyGhE7lMarr7n8/EP
         xKb0LDKZI2pzRaFxvICuCBq0j18bDOM/IYJNJiv5vYmXgxVpjHb/3Yvip29T+rNIbiGZ
         mv2jLYNcLHrL2gQ7Bm6mi+RZ8PeN1audI2jPHqDiJ8TLZfLWYxHnRsLXmrh5hMsA7WB/
         pWVg==
X-Gm-Message-State: AKaTC03uMKSQg2tfK4RZ4jmuE1p22GO02kQoBJWSJXXv4t8WAd1Ilf0sVBg356hy13Y8KzW1NXrThDUTTbvWBg==
X-Received: by 10.107.170.129 with SMTP id g1mr74521485ioj.51.1481621540249;
 Tue, 13 Dec 2016 01:32:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Tue, 13 Dec 2016 01:32:19 -0800 (PST)
In-Reply-To: <20161213092225.15299-1-judge.packham@gmail.com>
References: <20161213092225.15299-1-judge.packham@gmail.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Tue, 13 Dec 2016 22:32:19 +1300
Message-ID: <CAFOYHZAZAH9Rt1o73cx2uFvtr4weL00J+Yktei3h2GN1JgbY=A@mail.gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
To:     GIT <git@vger.kernel.org>
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        Chris Packham <judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:22 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Add cppcheck target to Makefile. Cppcheck is a static
> analysis tool for C/C++ code. Cppcheck primarily detects
> the types of bugs that the compilers normally do not detect.
> It is an useful target for doing QA analysis.
>
> Based-on-patch-by: Elia Pinto <gitter.spiros@gmail.com>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
> I had been playing with cppcheck for some other projects and happened to
> notice [1] in the archives. This is my attempt to resolve the feedback
> that Junio made at the time.
>
> In terms of errors that are actually reported there are only a few
>
> $ make cppcheck
> cppcheck --force --quiet --inline-suppr  .
> [compat/nedmalloc/malloc.c.h:4093]: (error) Possible null pointer dereference: sp
> [compat/nedmalloc/malloc.c.h:4106]: (error) Possible null pointer dereference: sp
> [compat/nedmalloc/nedmalloc.c:551]: (error) Expression '*(&p.mycache)=TlsAlloc(),TLS_OUT_OF_INDEXES==*(&p.mycache)' depends on order of evaluation of side effects
> [compat/regex/regcomp.c:3086]: (error) Memory leak: sbcset
> [compat/regex/regcomp.c:3634]: (error) Memory leak: sbcset
> [compat/regex/regcomp.c:3086]: (error) Memory leak: mbcset
> [compat/regex/regcomp.c:3634]: (error) Memory leak: mbcset
> [compat/regex/regcomp.c:2802]: (error) Uninitialized variable: table_size
> [compat/regex/regcomp.c:2805]: (error) Uninitialized variable: table_size
> [compat/regex/regcomp.c:532]: (error) Memory leak: fastmap
> [t/t4051/appended1.c:3]: (error) Invalid number of character '{' when these macros are defined: ''.
> [t/t4051/appended2.c:35]: (error) Invalid number of character '{' when these macros are defined: ''.
>
> The last 2 are just false positives from test data. I haven't looked
> into any of the others.
>
> I've also provisioned for enabling extra checks by passing CPPCHECK_ADD
> in the make invocation.
>
> $ make cppcheck CPPCHECK_ADD=--enable=all
> ... lots of output
>
> [1] - http://public-inbox.org/git/1390993371-2431-1-git-send-email-gitter.spiros@gmail.com/#t
>
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f53fcc90d..8b5976d88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2635,3 +2635,7 @@ cover_db: coverage-report
>  cover_db_html: cover_db
>         cover -report html -outputdir cover_db_html cover_db
>
> +.PHONY: cppcheck
> +
> +cppcheck:
> +       cppcheck --force --quiet --inline-suppr $(CPPCHECK_ADD) .

If I'm permitted a little GNU make-ism the following might make
CPPCHECK_ADD a bit more usable

+       cppcheck --force --quiet --inline-suppr $(if
$(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD)) .

Which would take us from

$ make cppcheck CPPCHECK_ADD=--enable=all

to

$ make cppcheck CPPCHECK_ADD=all
