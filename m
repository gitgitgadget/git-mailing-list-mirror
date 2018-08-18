Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F6A1FAD4
	for <e@80x24.org>; Sat, 18 Aug 2018 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeHSAyT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 20:54:19 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45695 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeHSAyT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 20:54:19 -0400
Received: by mail-ua1-f67.google.com with SMTP id k8-v6so7706112uaq.12
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YNfDqw60IeQCnrmgIErf/JMo78+hlpnbLqC5iZrkALg=;
        b=eKVX6h2fwYcQ/IAHYQ+nr4/z/BUvKAdl53uzmjK5GATo6a5nEKyIOSKO7S/PYsfbIU
         CjbC43HL6Ki+Us9I/4N/UGIcL1hyA3DZISGyBJvB7BagkNB5BF1vAwSAiVt1LZbq1Ptc
         lGDMPsP0lVNHSemSrQuhyOjTGDBLn/v1Wia0Zlhv1LEdXTbXWVM4oTsuxhylAyOf2Xsa
         rgelej+tdFy+wnPf+j5e4ZxGKbzOBqkhzuwYDFmnjCsrx4GV0X1/+AuKHuX8Rc9X0o04
         mLvbgxjvE4QcxlntfvLNl/qllkr/S7oxIu7Dr4rPamjl2ovZX0ZZaPBU3NheKG3TJr3Y
         fFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YNfDqw60IeQCnrmgIErf/JMo78+hlpnbLqC5iZrkALg=;
        b=pdoDHv2ScfuOVIG7YeC67qQucBThvQd9to7tqDwadypsMNvIBONTIiE8Cj8xx81c8u
         h6GOnOyNrg8GoIv94d2NtHHxFRZD6688ZkWkxaJzEMemC04+rnNwOy7SYxpFXXI5rydV
         oDxl2h5Gn0CONJvaN+3X+lZSQuoIKyqxqYh7v/lhrVXfay93dbX+YiNPsMmZLNLqdjI6
         FKinaFMN1IEmVPpS1RdI8akYMOSdJ3Mb3n5XiU1omtrQyMTRZtNN7Ks1GaEtAv8cSJTX
         H/zpSb8HnR1JTIomykZrJgxqOSsPGx5CFA2P/hbtlGJuPIXdMgglrR9IN2sjOUEUDuoI
         vI4w==
X-Gm-Message-State: AOUpUlFaplR6tUqANRq5Ov2mtvNf2wUtpdyLuZZWtZBckUazTPxG9J9Y
        r7LI9S1+mwAhgzuGiY58gECWlVTP1TH9XnhDq5s=
X-Google-Smtp-Source: AA+uWPxlTHUAyeVw0w/LLL6fCLh+awUcvk40KG+YMNn6KDEIwr49fIfa6LDNTzuDKW13WxFBfKpmRZsMg5kXUtgneXU=
X-Received: by 2002:ab0:3242:: with SMTP id r2-v6mr26585854uan.92.1534628711573;
 Sat, 18 Aug 2018 14:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180812081551.27927-1-pclouds@gmail.com> <20180818144128.19361-1-pclouds@gmail.com>
 <20180818144128.19361-8-pclouds@gmail.com>
In-Reply-To: <20180818144128.19361-8-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 14:45:00 -0700
Message-ID: <CABPp-BGn_BauwEGuHBR92CBQ-sOuS_tDwW5uDdmjrqpF2jxwxA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] cache-tree: verify valid cache-tree in the test suite
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 7:41 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
...
> diff --git a/read-cache.c b/read-cache.c
> index 5ce40f39b3..41f313bc9e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2744,6 +2744,9 @@ int write_locked_index(struct index_state *istate, =
struct lock_file *lock,
>         int new_shared_index, ret;
>         struct split_index *si =3D istate->split_index;
>
> +       if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
> +               cache_tree_verify(istate);
> +
>         if ((flags & SKIP_IF_UNCHANGED) && !istate->cache_changed) {
>                 if (flags & COMMIT_LOCK)
>                         rollback_lock_file(lock);
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 78f7097746..5b50f6e2e6 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1083,6 +1083,12 @@ else
>         test_set_prereq C_LOCALE_OUTPUT
>  fi
>
> +if test -z "$GIT_TEST_CHECK_CACHE_TREE"
> +then
> +       GIT_TEST_CHECK_CACHE_TREE=3Dtrue
> +       export GIT_TEST_CHECK_CACHE_TREE
> +fi
> +
>  test_lazy_prereq PIPE '
>         # test whether the filesystem supports FIFOs
>         test_have_prereq !MINGW,!CYGWIN &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index bc43922922..3394540842 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1578,6 +1578,8 @@ int unpack_trees(unsigned len, struct tree_desc *t,=
 struct unpack_trees_options
>         if (o->dst_index) {
>                 move_index_extensions(&o->result, o->src_index);
>                 if (!ret) {
> +                       if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
> +                               cache_tree_verify(&o->result);
>                         if (!o->result.cache_tree)
>                                 o->result.cache_tree =3D cache_tree();
>                         if (!cache_tree_fully_valid(o->result.cache_tree)=
)
> --
> 2.18.0.1004.g6639190530

Should documentation of GIT_TEST_CHECK_CACHE_TREE be added in
t/README, int the "Running tests with special setups" section?
