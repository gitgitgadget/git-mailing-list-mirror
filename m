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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E06B20248
	for <e@80x24.org>; Mon,  1 Apr 2019 14:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDAOPr (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 10:15:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAOPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 10:15:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so12300429wrq.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hn5l8xB77hca9CO2k45Ov0cK1tVkQ70aTEFCG1Acqt8=;
        b=Q/WnX1mPR6fYb2pNR73TpBsaGUT/Je6Xqyw8SQQWfeIgBhaha4xB7i4uCVB4fIi+2i
         AeayzWIb3yS+Ya38cNNge0XwJYebedLbHZY5RQ8pbzlMf1YwhNHdaVhVWtyETJvYqahC
         2ylgX5/3NKwoyx5uIv2r7ydmlhXqfAovp5C8I5xYZyZZty1q3mBgpDo+kuXtfulHlF+7
         zMrPVZviOrzOGxOLenPBJfUu0UKpAmPQYjLcyzdZM25r6e8nzRn89Q65O2C36LwZ18Ka
         8pbmumjmfB6CzHi1Y0aIAiGwU9V54a/frso7na5uvQ5mUk+LG/fQXjc/XsDuhfWcFWG+
         EPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hn5l8xB77hca9CO2k45Ov0cK1tVkQ70aTEFCG1Acqt8=;
        b=JnBc+zdhXb9fZBgi+Erynb/bwlSDaaE+8R8hav5P4rmdeOeLm8oe51K667ESxNS7Mr
         bYE+WgptbiRa2LbYzYqjIIgtrDrttGdSR5jvf647RI8wcwV0KnEAUxzk9OpExouj1Db5
         sWynjElsmv9aY95N9b1EfljDbP28BXhBvLkv90MuXlzjt2smAiZgA+T60GvYdL6RYiJZ
         Qd0kjPfLuDZ3ck+rkrG2FrzMyK+v1szdhMQtRDOjtLrQslMbbd289y+Jo1CBrZ1EACjw
         KZfiuNiVDcMlMA8mU8sArDDFGdZkbM5r2jKV7Ir0XDxYgGR+UQ0KtCCSu/oi8TPj9Anf
         M6lw==
X-Gm-Message-State: APjAAAVqnz/wvG69yx2MlxCk0bzezaMTcZmnDSBiJ9dreoR7WbO5cl30
        3uCF0MysvHPS+w7MZV7loD0=
X-Google-Smtp-Source: APXvYqyJrGE2gwaIQQZJlb+tydUBXf5ZX6rh98rr1AhMOcl1hytqso036ouiXn5A4kki62NvUGLusQ==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr34354455wrr.1.1554128144969;
        Mon, 01 Apr 2019 07:15:44 -0700 (PDT)
Received: from szeder.dev (x4db6660d.dyn.telefonica.de. [77.182.102.13])
        by smtp.gmail.com with ESMTPSA id n13sm14119339wrw.67.2019.04.01.07.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:15:44 -0700 (PDT)
Date:   Mon, 1 Apr 2019 16:15:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] progress: clear previous progress update
 dynamically
Message-ID: <20190401141542.GJ32732@szeder.dev>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-4-szeder.dev@gmail.com>
 <20190401132959.GB11664@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401132959.GB11664@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 09:30:00AM -0400, Jeff King wrote:
> On Mon, Apr 01, 2019 at 01:52:16PM +0200, SZEDER Gábor wrote:
> 
> > diff --git a/progress.c b/progress.c
> > index 842db14b72..3149ecd460 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -84,6 +84,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
> >  	const char *tp;
> >  	struct strbuf *counters_sb = &progress->counters_sb;
> >  	int show_update = 0;
> > +	int last_count_len = counters_sb->len;
> 
> I don't think it could matter here, as these are meant to be smallish
> strings, but I think we should get into the habit of using size_t
> consistently to hold string lengths.
> 
> It makes auditing for integer overflow problems much simpler (this is on
> my mind as I happen to be tracing some bugs around this the past few
> days).
> 
> (There are a few instances in the next patch, too. Other than this nit,
> though, your series looks good to me).

I started with using size_t, but then switched to int, because:

  - After a bit of arithmetic I had to compare to term_columns()'s int
    return value anyway (in the next patch).

  - The second hunk in this patch adds these lines:

        int clear_len = counters_sb->len < last_count_len ?
                        last_count_len - counters_sb->len : 0;
        fprintf(stderr, "%s: %s%-*s", progress->title,
                counters_sb->buf, clear_len, eol);

    Here 'clear_len' has to be int, because the printf() format "%-*s"
    expects an int, and otherwise -Werror=format= errors ensue.  OK,
    it could be size_t, but then it must be casted to an int upon
    passing it to fprintf(), and after the next patch there will be
    three such calls.

I could resend using size_t.  Should I resend using size_t? :)


