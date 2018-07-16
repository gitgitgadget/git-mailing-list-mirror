Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C96208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 21:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPV7p (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:59:45 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33351 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeGPV7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:59:44 -0400
Received: by mail-yw0-f170.google.com with SMTP id c135-v6so14735847ywa.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnsBL9X4ilGCFhv0nL0cv8FotFr2/yHpGEAHZ16Q9qk=;
        b=mVVsVbZtRj4L1N2N+OaL6ahgzj0XRKNVUHfFh/xcftZCz94Gt2aYj3JcPKDhyk6VpK
         NRIfixkg/NH/I72eDjYzM1FI+AdijT5aHCx2mFrEkYxR8REwIoUfqB+YwhCq7emQJfCg
         vVGsCOkeCRMBToXpVMKmx5bZRG9s9lilaruD9rkDPnStJ7x6eI9ZmesQdZn4u7MG4yJf
         uOBPNm5oxM1mfmBk4yG+GUpOd80wo00o8rTWPMqY760XF1RINExh0jx1YP4rfd9K++B5
         ohn5pedZ3tbytJ34QIERc4NRf54onl4zjxqi0yLVf/kNKkeqEWf5Y4X0tXXT6twmJ+7C
         7zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnsBL9X4ilGCFhv0nL0cv8FotFr2/yHpGEAHZ16Q9qk=;
        b=CXAbYwOZKpEXNQAbuA58tqXLaneeUbJg8JQJi/vC1CkAcuSdYN4HZ1GrznQLpP5V5t
         fZn3VKDZRlJSkf9/LvCqW5eN7uiNuG/biEQmISoSJXuTcu/9p/kXa6RgeQKDSOPkAisP
         IpXH1bwJ1uJgR/a6EAr4Z6iTlgFi3oauGtfR1dwwS9pxCcT2E/d2ULX+HWWIJ/w/Kcau
         8c0JDVJbWiBNfCxULySOi0q0nVhHEdD2Jn3NLokbfr+/77wahJE4PetTM4u7cpKeo1vm
         OIfTHANq5QxDRVfH0ZE2UZ0lkb4vNpXxml2VqQzVVrtG4iCBxXE6zofjjxC4BkiHXfAz
         VyIA==
X-Gm-Message-State: AOUpUlGZegU918AWEEA057t+4tcwObqgpsQuvvYCXJ55QVicMQJK3N7V
        NMi7cdwcvE7E63FkNLa10oSQFdp5ZItnZC700uxs0g==
X-Google-Smtp-Source: AAOMgpcEaKhFZEhHLJoMnQhm8WyhEVe6hJTMJb88Nhdp9alVXeKnG0NhO/vDM3bQS9wKu5FvkPy9ydjzhu79fIHHxZk=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr8855168ywk.345.1531776628286;
 Mon, 16 Jul 2018 14:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <3b0379cf6fb42ca5ee4e10cb20bf42ff333e1456.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <3b0379cf6fb42ca5ee4e10cb20bf42ff333e1456.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 14:30:17 -0700
Message-ID: <CAGZ79kbV-ahEYdCPyp6-mo+hVYr1c2+Xf-F5xYD3mCwBX9g16g@mail.gmail.com>
Subject: Re: [PATCH 12/16] test-reach: test reduce_heads
To:     gitgitgadget@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'reduce_heads' '
> +       cat >input <<-\EOF &&
> +               X:commit-1-10
> +               X:commit-2-8
> +               X:commit-3-6
> +               X:commit-4-4
> +               X:commit-1-7
> +               X:commit-2-5
> +               X:commit-3-3
> +               X:commit-5-1
> +       EOF
> +       {
> +               printf "reduce_heads(X):\n" &&
> +               git rev-parse commit-5-1 &&
> +               git rev-parse commit-4-4 &&
> +               git rev-parse commit-3-6 &&
> +               git rev-parse commit-2-8 &&
> +               git rev-parse commit-1-10

Please use rev-parse only once.

I am not sure about the usage of { braces } in the test suite,
+cc Eric who sent a test suite linting series recently.
Do we need to em-'brace' the statements that describe the
expected behavior? (Or is it supposed to be easier to read
for the reviewers? I found these very readable so far... but
this question just came up)

Thanks,
Stefan
