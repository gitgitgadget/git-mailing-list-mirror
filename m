Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317761F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeAEU3p (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:45 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36957 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeAEU3n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:29:43 -0500
Received: by mail-wm0-f50.google.com with SMTP id f140so4541933wmd.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jeg5MddgzhKpGFPSqoFUXTwNP8VJZtFxm3LhJvqWoXo=;
        b=hTevcuSi8oeBo2RQsGfjSMY21nSBrEgLnT5TsutFwg2xGfdPmYoAJfg6KoDlKv+3j4
         3gXlpC0SkJO4JrFn8DC9vI6CrISCYgkf+f2TFamSdRDcN54ZnFkKGJ5Nb9tnAeK0e29R
         Qxnx3shOeOVa+3mbjuuwcNbW6SoRZvJL7mAlekX70Pshv9ZJV1u/t2zANK8Ks3b7rzXH
         DCnt0cjwi8JHtQyFm7kmE9JkzEMeR/yhkvGB5JWIkW2ZtjhXeJbh6CO0Xq9RV1dVZgEB
         yAnn6Ez0L7FR5aZ7f8yhHidsPGjZe0hybuI7uwAAQob95sSbBhm/SILVhIMYG11n6oaX
         zzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jeg5MddgzhKpGFPSqoFUXTwNP8VJZtFxm3LhJvqWoXo=;
        b=of7ao3Nw/807aIf9hY4nVDR0VSnCxtZJw5/0y2i7v/TTE3iUTNQkRC8RR1A9DA+aLF
         RCyU8W0cx2phw47kmdZXMr3TxIs+n8kzZSE2NBmyjOlk5bSwWzGlCKr7zbBiKpNNO2Dl
         SS35MM5uI6mNLcDs07QGbDjtpPXbcleKHDI8jMOwmKjITAZmf4VZLUJqE4UDsZCo9obX
         4a/CckQFyiX3+Um15f00OA6sOWXF4c9Igc7IOBqDgGEj+wDqQHH+6Eyn8WD6AszHTOoI
         enn/vjGpFtN4Rz/siaoC5WQKbrziw2/LstG4wdcC7UakA5I2ERYWcjlPrv3q4XO8xdjV
         g+dQ==
X-Gm-Message-State: AKGB3mKVtyseFiFiFCFRGtNNl4FQz/unqQ8SUTLe9ZhW54Qdjt02kYmW
        xzTCnZVihR/C3mi+TuRh26NpNreb
X-Google-Smtp-Source: ACJfBoswKIrYkXDzEpw5QbtQz989iIvpGkV2KrgG4ylojCUE6BizXh51LguUPxEWT9nVvJfO9v/snA==
X-Received: by 10.28.113.81 with SMTP id m78mr3361436wmc.73.1515184182300;
        Fri, 05 Jan 2018 12:29:42 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 34sm6948719wry.34.2018.01.05.12.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:29:41 -0800 (PST)
Date:   Fri, 5 Jan 2018 20:31:51 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 13/34] directory rename detection: tests for handling
 overwriting untracked files
Message-ID: <20180105203151.GA24806@hank>
References: <20171228041352.27880-14-newren@gmail.com>
 <20180104005223.13566-1-szeder.dev@gmail.com>
 <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH66p1MU0Ry0LRcSpr7yGZymqwrnBmMh239xO3rgShdcw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Elijah Newren wrote:
> On Wed, Jan 3, 2018 at 5:52 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> 
> >> +             test $(git rev-parse :0:y/b) = $(git rev-parse O:z/b) &&
> >
> > There is a test helper for that :)
> >
> >   test_cmp_rev :0:y/b O:z/b
> >
> > Note, that this is not only a matter of useful output on failure, but
> > also that of correctness and robustness.
> 
> 
> Cool, good to know.  Is there any reason test_cmp_rev is not
> documented in t/README?

It is documented since a few weeks, I added the docs in 5a0526264b
("t/README: document test_cmp_rev", 2017-11-26).  Though as people
mention they just look in 't/test-lib-functions.sh' anyway, maybe the
docs should live there instead of in the README in the first place?

> [...]
