Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BABAC761AF
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCQQ2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCQQ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 12:28:48 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696F2BED6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:28:41 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c2-20020a170903234200b001a0aecba4e1so2993865plh.16
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679070521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmYX3gNCXjYvZ39xUyb3MSpausxB4TkXxjOfXhXIaac=;
        b=FEzoG3T3UpGEl7aYVx+UfZd8Q3KJ0I6UW2fZGgYe062JnfCDHEVca37r8x3DfaOadN
         GATNiP4OkcJvfVqOZALejn1Bo2qePKM2N4ylXoY2I8VPPAgWl7OwjP3S3839OPx5DGmG
         wZqNc10p3WFdM3jBKvpAc3kAqPSxYuX4aI9O78YDl3OiYoVW3639zd1cZSAoRL+A/jJp
         6xY7XZLumb6eN8LZirTi00PBXjR+c3s5HedeyZnZ4Fl99lgvMNuRhcmodtbkLKYyMuYo
         WpriWbl5MGxiVyRCjcdNDDbXqRwjryh750LMhxCem25vpyl+tl3KUGTQQF+X7ZRrFvip
         zizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmYX3gNCXjYvZ39xUyb3MSpausxB4TkXxjOfXhXIaac=;
        b=kVJBKY2L6vdsoNkvLMsNA69pgl7V8ypKH4vS+bShl8TDu2J8XbPck+0RIFbv9Nq7kb
         qrYsYHbnXAt6kRP/9+i1RmpHHcMiKseooJNjueopjwFLWcCg5cYkqXmZuCel7RMdmEM0
         6MYHeKu5mEE5EPW6IihcfrQzYCoYk+rfqS8L/0+gUma5wTVXWlet1ohF0njS1533c/Ah
         qaPjpNHqhd4Hvg3DRRuHpn4oFF2BVN64O2TeNXF5cQ2gSgxT9T2kKv3WntpcKk24Pccp
         dsRx4nzTmNcjcy1u53MTzMm7w7GJ3bnbjN0TBBVfAp7aCFCV0x7bXkD6ZdBOKAxmkAYK
         8Z0g==
X-Gm-Message-State: AO0yUKWFGwvZM1BwtgPHe1JJU/IpjDEH+7z/6Eq50hUMWmhnBVF7HWke
        kzI2PX+EcfffPpPWKWWS+70VQOwWHYtIIw==
X-Google-Smtp-Source: AK7set9Sajyj/BaeqRmdDNsGz+OzZS4zUmsZcadO+TCx5F8PjYPEPWs9b2SFqXh8gGWtePtmNXYhVgBcAEAaAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1086:b0:23d:551c:c5fb with SMTP
 id gj6-20020a17090b108600b0023d551cc5fbmr2383653pjb.4.1679070520957; Fri, 17
 Mar 2023 09:28:40 -0700 (PDT)
Date:   Fri, 17 Mar 2023 09:28:39 -0700
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
Message-ID: <kl6lcz57uytk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/5] bypass config.c global state with configset
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That libification url
> (https://github.com/git/git/compare/master...chooglen:git:config-lib-pars=
ing)
> doesn't work for me, and I didn't find a branch with that name in your
> published repo. So maybe you've already done all this
> post-libification work...

Argh, sorry, I renamed the branch.

  https://github.com/git/git/compare/master...chooglen:git:config/read-with=
out-globals

> ...in any case. This RFC expands a bit on my comments on the v1 (at
> [1] and upthread). It doesn't get all the way there, but with the
> small change in 5/5 we've gotten rid of current_config_line(), the
> 1-4/5 are trivial pre-refactorings to make that diff smaller
> (e.g. moving the "struct key_value_info" around in config.h).

Thanks. I haven't read through it yet, but it sounds promising :)
