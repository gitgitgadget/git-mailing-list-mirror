Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44D81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeDNUH3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 16:07:29 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33772 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeDNUH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 16:07:29 -0400
Received: by mail-wr0-f178.google.com with SMTP id z73so16000862wrb.0
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gTjTsaltMf0WBjSod9R7BfcKbS81xiUDS/7ucYknABk=;
        b=YZYe4Fl0HnPMQs5T8tYOWkIdgZR0CZ7m6urUf5anMzs1SCR7I9ABsr7/C2C8PgvIHY
         e375FtAv+5Rvslc50+jo3kTC8C6tf7J9rOo6CQNxAiv8PY7m0/ab/BZlCqKlPW8lVz4w
         AMRS0gBi06pPzN4SZYEkfPOXPjnYCDtOFkeA216wkTYwKNkqs9zliM1Nr1AxEnzETzTn
         6g0yo6nQIROEPaf9jy+5ITD34M+7MJfDs1kOKfU0FE3jQZL85yxPaggsQXSNcB+C5LNJ
         B/cf7jgd6O93ni+pMIiLLwjpUdyY10R9Q2ixfGjvPOML0utfdVq2VetFFr8V0uOH7c9C
         M6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gTjTsaltMf0WBjSod9R7BfcKbS81xiUDS/7ucYknABk=;
        b=pyThhqPv8yQ5GiILQjd/asnmDsSxrbeE2pFSyqtd4NQZJ7Cv1DeK9epLtoHhzUySP0
         wqbzABrwnG5yDRdezIcnyct+fziEcws7a1l43M17WzG/YXs8FNzQtm5P2yuzNEeerhMk
         AvXAHKPchSGe6xS+9exIY3Wpv2JecetHchPdlDJLJ3jGuU/rnz+h0rG9n1fmi9y69Ia2
         E6pjakPtAJbgJ64ejTGLaKoFKmLIONc160N1xl+HynL2yrz5/s+s/2zA9dOs1JWYIsfW
         dyu3jtF9szDf0rQ5u09wCSLvTBGkOxITrbV/aUnzMA5735qaRdp/COJfyzitpCoWuqcI
         gSXg==
X-Gm-Message-State: ALQs6tD7i/mQmYx10bj4WaaMlhzhhFtFdbP3pRDaKwF4v6VNoCIS7ve4
        +KM4NxbsjW7eNgOB6uL6LlA=
X-Google-Smtp-Source: AIpwx48thZIE7gDFuoo/ms+cd7fFz9pY66fUD+oeleeGXmMhsDh1YcWOJ7T7fkJzloxvqx6dIRiyXw==
X-Received: by 10.28.153.213 with SMTP id b204mr7031725wme.79.1523736448091;
        Sat, 14 Apr 2018 13:07:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 19sm4587027wmv.18.2018.04.14.13.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 13:07:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Doron Behar <doron.behar@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request: Add diff.word-diff <mode> and perhaps diff.word-diff-regex <regex> configuration options to enable always using word-diffs in git diff
References: <20180414200227.b35bdkir6ygio5is@NUC.doronbehar.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180414200227.b35bdkir6ygio5is@NUC.doronbehar.com>
Date:   Sat, 14 Apr 2018 22:07:26 +0200
Message-ID: <87604tft6p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 14 2018, Doron Behar wrote:

> I've just came across the wonderful command line option for `git diff`:
> `--word-diff`. It could be great to have a configuration option that
> will enable this feature by default when running `git diff`.

Do you know you can do:

    git config --global alias.wdiff "diff --word-diff"

?
