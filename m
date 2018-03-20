Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A8E1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 06:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCTGhK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 02:37:10 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36552 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeCTGhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 02:37:06 -0400
Received: by mail-qk0-f193.google.com with SMTP id d206so521139qkb.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fQw6A3/Hy3J9xfPygjLOxTBGV1y3Hr10KkEMt1GXeGU=;
        b=J1QIUw8pQO2fVCNT4k0iCkZUjwuxid6bOzOrfF6qWyd8qVkVuaklk0KYax7Yezb6/f
         +gtgQiq85igUEn4i5Zyjcc6w5lh4tYrPzrD0A0KFncSMIH0n5cxxKBLnG5pPKUmwHrtq
         xL8tzdK4rBUI7m8C5Ed8Xk7AtSqsafbYIBkA67zPXmyqUeK2Hbf3gZw3F2HRspVCF89w
         hcemHMEd5QwUaWK71alWAGwribjjD0SdSk2SAryJ7ZJnqPG/RVGDrZoGCBZBesx/7X6v
         9t8opSryt14xx/yBnfSnkqjYklzSX84+UUu7Bz3DiMXq3YzkvGLR150RQkaCYJHH9ulu
         sjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fQw6A3/Hy3J9xfPygjLOxTBGV1y3Hr10KkEMt1GXeGU=;
        b=ZhS3vTw0GhKAfAGQbXJmWQWjtJ3Z69WyyEbajnq67ifl3CllPsY1yjKjAkC+KjcXcx
         URs5xM9T8evLb9fFqZXh4GeWqVRAYy3+5v4DbWGBgwYFrZsvjuMpNBcQj533MpV6neJo
         2OIO0nK7R8qzToVqwZxhqh1don8cQl8sMzIsycz72pVj7PtOvB/x/BOun00myomCCQf1
         7zN1svTxtmQYavrdoZf+BLrEg23LZATOyk91nDyFMi9+BTebFwvVvkfpszXO+xSVL5xS
         cIWbIhq3EsR8dNpyzGrJnkr/BasdQdLKNOsye3kbhXQ8yWvC383VqrtSE+45KDP64HLT
         f7kQ==
X-Gm-Message-State: AElRT7HqmNJqjrfcxEslkpq9XCeTo6EmuWPbCBpeDrj2jHSo4dPkUueo
        22M4xOqvovwEwTzj0AXf30f90ZBtB0x3vl3CS4Q=
X-Google-Smtp-Source: AG47ELucx0ZJFJbB3a5TF8PCqLP6+oWwX2VP+tFNAkIiXDHkE7mp/oSdlAAri9hfH1ulqmdq9/hxj1+H7DB1L9pMi00=
X-Received: by 10.55.3.140 with SMTP id 134mr22278608qkd.26.1521527826062;
 Mon, 19 Mar 2018 23:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Mon, 19 Mar 2018 23:37:05 -0700 (PDT)
In-Reply-To: <20180317222219.4940-2-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-2-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 02:37:05 -0400
X-Google-Sender-Auth: -qYkgI3EFBy1neSxbgGS1xthePE
Message-ID: <CAPig+cT8i9L9kbhx=b0sG4_QYNdoEDPW-1xypM9xzBqPmqR__Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> Fix these inconsistencies, and no longer show the identifier by making
> the 'git reset --hard' call quiet, and printing the message directly
> from the builtin command instead.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -303,8 +303,6 @@ static int add_worktree(const char *path, const char *refname,
>         strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>         write_file(sb.buf, "../..");
>
> -       fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);

A minor regression with this change is that error messages from
git-update-ref or git-symbolic-ref -- which could be emitted after
this point but before the new "worktree HEAD is now at..." message --
are now somewhat orphaned. I'm not sure that it matters, though.

>         argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
>         argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
>         cp.git_cmd = 1;
> @@ -320,10 +318,19 @@ static int add_worktree(const char *path, const char *refname,
> +       fprintf(stderr, _("worktree HEAD is now at %s"),
> +               find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));

I wonder if this should say "new worktree HEAD is now at..." to
clearly indicate that it is talking about HEAD in the _new_ worktree,
not HEAD in the current worktree.

> +       strbuf_reset(&sb);
> +       pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> +       if (sb.len > 0)
> +               fprintf(stderr, " %s", sb.buf);
> +       fputc('\n', stderr);
