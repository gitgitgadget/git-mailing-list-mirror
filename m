Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081071F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934993AbeCSSIF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:08:05 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44106 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968412AbeCSSHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:07:38 -0400
Received: by mail-pl0-f54.google.com with SMTP id 9-v6so10722443ple.11
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GOFf5iqegC0waHvVF/FPRl0uBW3zVXdSucxhUurxFQ8=;
        b=LZGdjFCsIMf/yZ3MmvN9KtH7XGr08ySHHNys0o5a8Hqydf6SP5Asy15DaacQGIxyzu
         pzUw4XXVfA6U//7z0V2DYiPk4Ekau6789oRf+NeZMGBoEXN43stv596VU6y8UYv74RvN
         IpJXJcR3if72OLm6xAgfgrfLLQAXvN7bY+qKcySF4LOuZ4Iehl8SkE6UBTSGDMEK5WC/
         R/0G7RdhUyCI3vEaYc2kmv8fYLeL2saEi7nA1LjCKFEfs1PPDqTS4qkPJO3qPjdFdsEs
         VgTasbweRpM7YFDPlDDQt3lpbdJX+tRQDdfqMkwJBfJ1TLrJs5t3wzwlnlk3kcCccNmq
         K8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GOFf5iqegC0waHvVF/FPRl0uBW3zVXdSucxhUurxFQ8=;
        b=FIuZMJXdfx4ZkjHbs8MGRi/LmIG6iVnHVtoMT84OXCNXeBuW4VseztkXaeQ0RDkujd
         1Zch2NkF+hwStz1310mP9d7WEyaPj5NQFdPVihwjTrjRacKzRc+H+ie+BOwokaAxAnGF
         g5GBCpNVUYfPX7kqXA/dwKZaI2pyHexAtCD0qczMYaVq3ECJyAgCzGEMOp+aldP+BIUN
         LpUk0z3J5UnvYnziehHSgTPtULTuow+h6sOZlngicc/TACYrym8FtghP/98twGi5iksd
         YYPc1uO04bBr4YYzUATGsFDGYjHGbobB3PUxIbeltjCdr2axBcw4SxzOcKveeMK6D+th
         x+xQ==
X-Gm-Message-State: AElRT7Ea7TTUVHF0PsVLC6KlpzHloHj+82dk3OEZfRGp8ReZ0RDyuWKg
        dvuh47kBeVg/6ARLXkjT4SG66FdmJns=
X-Google-Smtp-Source: AG47ELuVJF1UTxql/9P0urZ0+ZYIvgMIzZVcdU7wkSD0zPgJdnoCGj73gFhrrlCcoWqPLbOQmFn5Lg==
X-Received: by 2002:a17:902:2805:: with SMTP id e5-v6mr5258275plb.89.1521482857872;
        Mon, 19 Mar 2018 11:07:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y27sm949602pfi.156.2018.03.19.11.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:07:36 -0700 (PDT)
Date:   Mon, 19 Mar 2018 11:07:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 02/44] repository.c: move env-related setup code back to
 environment.c
Message-Id: <20180319110735.56f860f2794c36b1e2e6180c@google.com>
In-Reply-To: <20180303113637.26518-3-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
        <20180303113637.26518-1-pclouds@gmail.com>
        <20180303113637.26518-3-pclouds@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat,  3 Mar 2018 18:35:55 +0700
Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> wrote:

> It does not make sense that generic repository code contains handling
> of environment variables, which are specific for the main repository
> only. Refactor repo_set_gitdir() function to take $GIT_DIR and
> optionally _all_ other customizable paths. These optional paths can be
> NULL and will be calculated according to the default directory layout.
> 
> Note that some dead functions are left behind to reduce diff
> noise. They will be deleted in the next patch.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Thanks - I've reviewed up to this patch, and patches 1 and 2 look good.

> -extern void repo_set_gitdir(struct repository *repo, const char *path);
> +struct set_gitdir_args {
> +	const char *commondir;
> +	const char *object_dir;
> +	const char *graft_file;
> +	const char *index_file;
> +};
> +
> +extern void repo_set_gitdir(struct repository *repo,
> +			    const char *root,
> +			    const struct set_gitdir_args *optional);

Optional: Reading this header file alone makes me think that the 3rd
argument can be NULL, but it actually can't. I would name it
"extra_args" and add a comment inside "struct set_gitdir_args"
explaining (e.g.):

  /*
   * Any of these fields may be NULL. If so, the name of that directory
   * is instead derived from the root path of the repository.
   */
