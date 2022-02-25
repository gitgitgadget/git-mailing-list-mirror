Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C6EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiBYQC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiBYQCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:02:52 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87411200
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:02:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so5046561pfe.7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJAA2UhGOFQ7t1TTpFxSt6XnBMimvPvLRhecExrXDz0=;
        b=nwCjlds5u6pB4z4EpoySCaO6btA/PHaMbBxlegtAn1zXswBEiKAfHLmWeUuRhg6VtW
         TydCZi/4KnvAF/nfzpHpNb/lnhJokWH3kYoK9VbQ04N6v0YQGzXA29AN+DgRj8mzD0gN
         KycNKv5B4+sAdy/ErSGhl9recF7jPIJkFAtUQdoaRhEL6Q8D+f/VSymD4/ujJt3tPfxt
         3D7EmHGw1JKUxuF4YZnGKDwjVr8lr8+Wgb+g5vKj409zYoLQX9rewHZEztmMCj0iEt8B
         hRVm7gEWIAuo5+AjyED+arcFn8Nq6y0YmD8+6ZXEUvtiBjB6JwkbfqezoL9AhSrJzckc
         OAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJAA2UhGOFQ7t1TTpFxSt6XnBMimvPvLRhecExrXDz0=;
        b=3PL6qyrX9kWAMyBwWPPgBXkO27nF+z3EKT2mv/cE14DkmL9i4Fek6o3rS4ao+3ct7G
         3xbXnwT7XPN4L/0AIfsMwOl3zTwx9pka+sZlPUzcw2aYsyW9nMMbHu+sZJTyxZwCY1TA
         0dOA437vS/YTBsGKwR33p5na7Q9/BQC42+UhQDGh0o+uE3in1Z1p8qBvQO4hl1kLVIfC
         L4iMaatZo6+02Q/FvUem9nS1QovjgzRigsESLKwARyjJ3B8d1dXx8fOMFilVRpcMKtJl
         wtY91Jgl0k3Yk8ezl0fEld1G6QTnaiaA/h2kjOx7DVDpzv3KT7tG41fb6X4jSNDyQP/T
         cOtA==
X-Gm-Message-State: AOAM530nUMNOnBB/2mczFKBkQgLWqdh2wmo2aURHv+Ns7xBbwk4tzYRJ
        I1Sde7cUPN25mi39OX7B0v8=
X-Google-Smtp-Source: ABdhPJwlBWM4PGXE2U3c9ShPOOCskZMUSuAFFG1dVDqM9R5scDehJ7E6MT2e0nwKq43j0GK/oLTd+w==
X-Received: by 2002:a63:da14:0:b0:374:844c:777b with SMTP id c20-20020a63da14000000b00374844c777bmr6611872pgh.99.1645804939916;
        Fri, 25 Feb 2022 08:02:19 -0800 (PST)
Received: from localhost.localdomain ([202.142.80.210])
        by smtp.gmail.com with ESMTPSA id d7-20020a056a00244700b004e1300a2f7csm3608681pfj.212.2022.02.25.08.02.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Feb 2022 08:02:19 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Julia Lawall <julia.lawall@inria.fr>, git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Fri, 25 Feb 2022 21:31:47 +0530
Message-Id: <20220225160147.14824-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> As I just pointed out in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejv=
> aqbjf.bet/,
> it seems that replacing the static check presented in v1 by a runtime
> check needs to be reverted.
>
> In addition to the example I presented, there is another compelling reason
> to do so: with the static check, we can detect incorrect usage strings in
> all code, even in code that is platform-dependent (such as in
> `fsmonitor--daemon`).

First of all, thank you so much for putting so much time to look into
my PR. I appriciate your research about various possible outcomes of this
Patch request.

I saw your mail where you listed some of the disadvantages of the current
version. I also agree with the arguments you provided and it is also true
that one wouldn't find any clue by seeing the output of the `CI` link
you mentioned (i.e. https://github.com/git/git/runs/5312914410?check_suite_focus=true).

Let's see what Junio, Ævar and others say about this.

Thanks :)
