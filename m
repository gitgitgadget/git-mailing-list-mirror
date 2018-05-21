Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFAF01F42D
	for <e@80x24.org>; Mon, 21 May 2018 11:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeEULuH (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 07:50:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41824 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeEULuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 07:50:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id w15-v6so8156842wrp.8
        for <git@vger.kernel.org>; Mon, 21 May 2018 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spwtwQKqwm6ZepnXBRjtxWg5PBgtq8NK31MeCbn25I0=;
        b=IF3N66y/fRscZESjXM65kzcypEjSVw2h9cRPRpuVLKcLJ3xYsKZk1aQjW0RBQOkYfe
         Aym1cGYbIXorEQ89aBLBuOSzBnRjFG6z+SJdf4ZMGc0Q0GrtJ9s13gGvy4FjZ/m5nFep
         MhCbFyJ8ciHGl7ONN5ejHG1/sVVwQQMGw3n5vPoO7v/9tcQsWqUPqGHgpNnZvdIRA7sI
         rOh+t/OH/hMxQEOtuT+PN5yEswi3Kic96KW9Cbo/ljf+DLz4AnT9GcVLi+E+O2TKKc7n
         MKD3pKktHdQSG1EEYiNQNWUwiUftY8isRDm84OON/nl60TNCJCb5BHksqlwXfttq5hpn
         QnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spwtwQKqwm6ZepnXBRjtxWg5PBgtq8NK31MeCbn25I0=;
        b=MtFTFLbDgQppKTEhmCodH4OGmd4wKGh03B2FeWs4zz8rccxtouBpsh9K9IwPekti0E
         icn/f6wjSSrWICH3u3lion6Q9pbon5q6I460UwUPKA1e0TtM6zeJzCpN3d5+WEKyW4XY
         tF52wjIrOY/nfqmrlKSSgZWbzbWjctGWp2+0PYo+PNnCa/4FwbVH6qeJwNLCKMOQRP5n
         ZtEDhisYrAAnfZirCfi0WQnqZUL27x87C8TK90UTGEM2T2MLR4ZsKjLMrj/Pd7THWxg/
         0RYQ7FOVs7US/+oTqRJ3BV9oAqX8igSASYk7AwfraONpwnldwo51yTtH78Kbs/xcOkjW
         Wq1A==
X-Gm-Message-State: ALKqPwdCKrIi32SvU/pcSAFG3oapHyxcS7e/ptGNtJFPfkPOcD0v7JWQ
        1SEXzT0SUUU5yMmYi0zEhBk=
X-Google-Smtp-Source: AB8JxZomDckPL3kHGOIF3Kkna1Yu2vVbflCMXUlMdzZL+PvC84St2FMhT4fJRYNvI/xf+plgZCW+YQ==
X-Received: by 2002:adf:8124:: with SMTP id 33-v6mr14555511wrm.109.1526903405267;
        Mon, 21 May 2018 04:50:05 -0700 (PDT)
Received: from localhost.localdomain (x590cf651.dyn.telefonica.de. [89.12.246.81])
        by smtp.gmail.com with ESMTPSA id f8-v6sm8487129wrf.67.2018.05.21.04.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 04:50:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
Date:   Mon, 21 May 2018 13:49:40 +0200
Message-Id: <20180521114940.11288-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
References: <20180521055143.14701-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index 8f5c811dd7..c3b89ae783 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory' '
> >  test_expect_success 'prompt - deep inside .git directory' '
> >  	printf " (GIT_DIR!)" >expected &&
> >  	(
> > -		cd .git/refs/heads &&
> > +		cd .git/objects &&
> >  		__git_ps1 >"$actual"
> >  	) &&
> >  	test_cmp expected "$actual"
> 
> This one looks wrong.

It's right, though.

> Why not `cd .git` instead?

That case is covered in the previous test.

Once upon a time it mattered how deep we were in the .git directory
when running __git_ps1(), because it executed different branches of a
long-ish if-elif chain.  For the prompt it doesn't matter anymore,
because those ifs were eliminated, but for the completion script it
still does, which brings us to:

Christian!  There is a similar test, '__git_find_repo_path - parent is
a .git directory' in 't9902-completion.sh', which, too, performs a 'cd
.git/refs/heads'.

