Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2751F576
	for <e@80x24.org>; Fri, 23 Feb 2018 09:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeBWJ5D (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 04:57:03 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46861 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeBWJ5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 04:57:02 -0500
Received: by mail-pl0-f66.google.com with SMTP id x19so4628360plr.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eW+AlXpxH6Sc3BffdGpb5o+pwu9c8kb7kZZHHhXzatE=;
        b=AkKN0ZCMAyjo6RgNoqM9Cg18ZF99Imyiuw5Lw+y4P19gIFZszqi3Nq3he7atoL87uL
         uHl46RQ4qMXkKwPtObRtyRvNoXlMVYBEvSQEnyTaBk8tYDntVwxEvXt3Frtxt1pOcf0M
         k0aiEZ/sM7PRLnLtiOcltIK7lke1D3sHUFUpYDd8ZkfzYAbVP4feErbXaR8lePBgnYh3
         ibxTsYDtJh9am6qceSeRxAP7+XgLXrcU5l4ASZ/2NmKE0I/s9JemuOQ2IRpXaVWMwBII
         S0A5GOl08tPOSMJr8W/aBhUAm2jEmt3f4Vyvae2Y5+dAFw5AAQhmoPOb1Kkvcn2o6g+G
         Lotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eW+AlXpxH6Sc3BffdGpb5o+pwu9c8kb7kZZHHhXzatE=;
        b=BJ8WSu5Ih3abhobfIg5Tzxtjegp97szPsZsT5YEdR4wMyOK1BGxuWwT8qAHSuHvVal
         hfF2Fpnr8IDPkLWJWxKN0hhBL4z1O1/OK/cAic2CVcw9bE3emX4seg9EiEJCvEt+j0Ps
         Ejce7pnnWQoqG1CELvg0sC7bLaWnOsS7bhBXS6AQEXwcJ1FoV9LrnrHTA2GjmPAd12cg
         0S3CKJryMy/C4RGc6M4cP1H3ScahqAgGfzNXtPBi3OGhPmGbDavirtXMwbl0gK5e/o3l
         JxknRMUmJABOSIJMzw9K+RiJbO7AMSFsX5ES1W042thgki7jnOkXPTVdb7OOfSYZeGTx
         yClg==
X-Gm-Message-State: APf1xPCgL098+m4an8nq7uyLUsSMyyPuYoTRxPiXG3h2iH+hJGiYSxzd
        QRNqqKO4ixLzWewjypOZfeEjug==
X-Google-Smtp-Source: AH8x226lwOSngNp7f8a7ZhT+tFrtbc4Y8WSdWhAEYV/rhgFvt4Cvlt82wODgBtcnIsFZwSq908MJ3w==
X-Received: by 2002:a17:902:7789:: with SMTP id o9-v6mr1213478pll.422.1519379822206;
        Fri, 23 Feb 2018 01:57:02 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id n190sm3433805pga.89.2018.02.23.01.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 01:57:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 23 Feb 2018 16:56:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/2] Fix initializing the_hash_algo
Date:   Fri, 23 Feb 2018 16:56:38 +0700
Message-Id: <20180223095640.25876-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180214180814.GA139458@google.com>
References: <20180214180814.GA139458@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 1:08 AM, Brandon Williams <bmwill@google.com> wrote:
> At some point yes we would definitely want the setup code to fully
> initialize a repository object (in this case the_repository).  And I
> would even like to change the function signatures of all the builtin
> commands to take a repository object so that they don't implicitly rely
> on the_repository at all.
>
> When I introduced struct repository I seem to remember there being a
> couple things which were different about setup that made it difficult to
> simply call repo_init() on the_repository.  If you can fix whatever
> those issues with setup were (I can't remember all of them) then that
> would be great :)

I can certainly try! I start to remember all the hairy details in that
setup code.

The first step may be something like this, which identifies all the
"repo init" entry points. This is basically a revert of e26f7f19b6
(repository: pre-initialize hash algo pointer - 2018-01-19) and doing
things the proper way, hopefully.

This is on 'master', independent from Stefan's series. I have another
patch on top of that series to remove the use of ignore_env in
sha1_file.c (and things seem to work). Basically whenever you have to
initialize the hash algorithm, there's a good chance you need to
initialize object store as well. But I'll hold that off until
Stefan's and this one are both merged.

But yeah, it looks like we need some surgery in setup.c if we want
something as pretty as repo_submodule_init() but for the main repo.

Nguyễn Thái Ngọc Duy (2):
  setup.c: initialize the_repository correctly in all cases
  Revert "repository: pre-initialize hash algo pointer"

 builtin/index-pack.c             | 5 +++++
 builtin/init-db.c                | 3 ++-
 cache.h                          | 3 ++-
 common-main.c                    | 4 ++++
 diff-no-index.c                  | 5 +++++
 path.c                           | 2 +-
 repository.c                     | 2 +-
 setup.c                          | 5 ++++-
 t/helper/test-dump-split-index.c | 2 ++
 9 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

