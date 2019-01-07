Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F020D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 09:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAGJP6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 04:15:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41605 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfAGJP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 04:15:58 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so26294432vsc.8
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 01:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hchWjpsozAsCfrDNcecgek9wS9AFDY+ZkC52SvHL88k=;
        b=DmUm9y0Uh/ywbWRCxX6SRahO3ReqWndo2oeG/1H66HYztDeAypgqJsLLArFKWN+5tI
         6UYZzM5cAT3Sg6FfceA9+s7qTum3huuaepImsl1DZ2+8QtSdaSJrt/jqMCPrR77VWM+0
         bX0zFpav/ng3z9UGyR2upqec8EecJG65x4Gxf650SALp+VutxZolYzFkOY92jj7dlA63
         3ynVQtU40DGyC7DxpYcBPc0IL0Vg3Bcq91buxAOM/aZ0sBrv7/6jmq4X222tCXU5b9Y8
         bf+43o/qh3Jtqz8EkncOtu6kMLAPGIEagzvNfnURnzBI1TgZbOqHcIGWa4DK+UrMYr7F
         GHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hchWjpsozAsCfrDNcecgek9wS9AFDY+ZkC52SvHL88k=;
        b=VCpvLa3KuU6o3vT4d+IbJXaN2GzmNbWuiT/GQWaPd96jnlG7TmQPnz/3ZyHo0wkvZF
         17+tWvkEMSZXRps+EnkmHYEGZxiR2ZcOaHt7/KVKRVSSVzUcKxwpStEDFkLFnbVR2hT6
         ZmFQ57mCHO1+B8OBRz6XS32w6JJJ68hyHKcEInjUw00MPoFk+4Am3OTskuQAMRFQ71VN
         chR8FpSG9l/wTcdcsGez8Mk68QaU5GJPitTUOZRd91k7w0XeNoeOoKHUgPMgZJll+ajB
         rANlOUrgr6rRsFejsrnJs2DkdcZGSCGB1lC5rPKnlmyuWi1tDa0kzjpvNIfmBrDmkLoB
         drTw==
X-Gm-Message-State: AA+aEWYVqSLsuUZiyxU4tEQ89tSgXp+T70zz51EBFWIUztVotK4sB6pB
        2UvVo7q3DhSovgnIdHLgB6oPr04ErNsdDGBe0Spv2Q==
X-Google-Smtp-Source: AFSGD/XK2eWNMoosBlmplL7d3x+wWx+sJ0FfEWYz4URldI30IVYrtwHq4kKlyiQKri2VMG7FH+V6kCQIQ1LqJPDW51A=
X-Received: by 2002:a67:f294:: with SMTP id m20mr24797787vsk.81.1546852557037;
 Mon, 07 Jan 2019 01:15:57 -0800 (PST)
MIME-Version: 1.0
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <pull.101.v17.git.gitgitgadget@gmail.com> <d64492dc-4643-823b-c804-3c152c4d9090@ramsayjones.plus.com>
In-Reply-To: <d64492dc-4643-823b-c804-3c152c4d9090@ramsayjones.plus.com>
From:   TANUSHREE TUMANE <tanushreetumane@gmail.com>
Date:   Mon, 7 Jan 2019 14:45:45 +0530
Message-ID: <CAJ6Xce1A2RtBtd0FLouAUQRqaOVtTM4z28eYf45HMO6qK-w+fQ@mail.gmail.com>
Subject: Re: [PATCH v17 0/7] git bisect: convert from shell to C
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Tanushree Tumane via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, you are right. I will revert this back.

On Fri, Jan 4, 2019 at 8:08 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
>
>
> On 02/01/2019 15:38, Tanushree Tumane via GitGitGadget wrote:
> [snip]
> > base-commit: 7f4e64169352e03476b0ea64e7e2973669e491a2
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-101%2Ftanushree27%2Fgit-bisect_part2_fixup-v17
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-101/tanushree27/git-bisect_part2_fixup-v17
> > Pull-Request: https://github.com/gitgitgadget/git/pull/101
>
> I didn't look at the patches, only the range-diff below, and the
> only thing I noticed was ...
>
> >
> > Range-diff vs v16:
> >
> >  1:  f1e89ba517 ! 1:  338ebdc97a bisect--helper: `bisect_reset` shell function in C
> >      @@ -16,8 +16,9 @@
> >
> >           Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> >           Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >      +    Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >           Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> >      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >      +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> >
> >        diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> >        --- a/builtin/bisect--helper.c
> >      @@ -53,8 +54,10 @@
> >       +       struct strbuf branch = STRBUF_INIT;
> >       +
> >       +       if (!commit) {
> >      -+               if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
> >      -+                       return !printf(_("We are not bisecting.\n"));
> >      ++               if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
> >      ++                       printf(_("We are not bisecting.\n"));
> >      ++                       return 0;
> >      ++               }
> >       +               strbuf_rtrim(&branch);
> >       +       } else {
> >       +               struct object_id oid;
> >      @@ -69,11 +72,11 @@
> >       +
> >       +               argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
> >       +               if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> >      -+                       error(_("Could not check out original HEAD '%s'. Try "
> >      -+                               "'git bisect reset <commit>'."), branch.buf);
> >       +                       strbuf_release(&branch);
> >       +                       argv_array_clear(&argv);
> >      -+                       return -1;
> >      ++                       return error(_("could not check out original"
> >      ++                                      " HEAD '%s'. Try 'git bisect"
> >      ++                                      "reset <commit>'."), branch.buf);
>
> ... this 'branch.buf' will refer to the empty 'slopbuf', since
> the call to 'strbuf_release(&branch)' now precedes this call
> to error().
>
> ATB,
> Ramsay Jones
>
