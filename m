Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C7C77B7C
	for <git@archiver.kernel.org>; Thu,  4 May 2023 09:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEDJur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEDJup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 05:50:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F851A8
        for <git@vger.kernel.org>; Thu,  4 May 2023 02:50:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so453867a12.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683193843; x=1685785843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnhiwD4WXCfcW1mv6I4bO1G6K79vBw5TK0T2XZRScSg=;
        b=d7dBkD8p9WjWYJ6B0gMoxWmjcsZQj+myxgnV05nmlurQ8ISwufN1K4hulr8RfS/DA6
         iZGK0erMn+0DUNushL/ZqjFb58qUF5Uia1IjOGqvKC7vYdL42Ub7Lm4f0lxBVnT5GbUC
         TU24oR2QV1d1TtSLdsKqVsYMnTardUQYPP4juW+ciosFOMPq08TyBcCJsfrGUfEcbTIq
         JWqlojPiIO8mQd7gGdINVXiWBbgTIgaZ3lI/otFSHb4rnhmd6W3gmrmGWE3D1wTzbQef
         Er+s4XEW/X1qZZJK8u7QJB7ipVYayIONtCgSk9a2YUKXvCmQDYbGN62W+12I9kvfdwpt
         McMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193843; x=1685785843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnhiwD4WXCfcW1mv6I4bO1G6K79vBw5TK0T2XZRScSg=;
        b=NQcGBhsRA78BsUlUJ/szfL+UdsJW9bWQgZ+OxmaqC8bqiIqLS6R9A9QdmLHCkMc2aI
         s56ea/qNHUBYpTPczTY/kR1tQnnBzqyhgCloZmDh4h6+637EzEhYhPviCxQl2I6WK2d3
         nwePXxVmoqUNZ6oWYMpmKajYWTs3xqb/eHXstb4sLYejd8JqPklkRnp/b5+gHcTy98Qh
         4diTlWWfUwnNO9Xl+gOsdcrApkF/j1rHZZlkdNp54xCrz8Yj+bKRpXRTIlf9R5A5MmKy
         mwKZPr1vxtDUvqdzjwB1gyisnym+SaFRupZuJV3ogwjBo1jGZ4Jhmf8C+3eCxpvHL55k
         MwDg==
X-Gm-Message-State: AC+VfDyuJbrYMHHWWCrZfJBSGMlek4xElGG+Mkb2XPJEsrLVVMqw9ApF
        Y8jXCkiIrRswTsCDo1Is0OmVSJoWUJ5YNb3a4Gv5fAnTvC0=
X-Google-Smtp-Source: ACHHUZ7gl6pC42IrWJAICM1TdvlgTWSy3X7YE8HVvWhG3b/txpYGskEkSxpRjBO3msJytrugr46QQm4k8W7Yf1Pbg84=
X-Received: by 2002:a17:907:97c3:b0:94a:474a:4dd7 with SMTP id
 js3-20020a17090797c300b0094a474a4dd7mr6083042ejc.60.1683193843053; Thu, 04
 May 2023 02:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com> <pull.1470.v5.git.git.1683144574158.gitgitgadget@gmail.com>
In-Reply-To: <pull.1470.v5.git.git.1683144574158.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 May 2023 11:50:31 +0200
Message-ID: <CAP8UFD1AuFWWC=iAe0duhpSsw9HnA-tcpV2F3NGT+089aY60Ow@mail.gmail.com>
Subject: Re: [PATCH v5] attr: teach "--attr-source=<tree>" global option to "git"
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2023 at 10:09=E2=80=AFPM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> @@ -314,6 +315,21 @@ static int handle_options(const char ***argv, int *a=
rgc, int *envchanged)
>                         } else {
>                                 exit(list_cmds(cmd));
>                         }
> +               } else if (!strcmp(cmd, "--attr-source")) {
> +                       if (*argc < 2) {
> +                               fprintf(stderr, _("no attribute source gi=
ven for --attr-source\n" ));
> +                               usage(git_usage_string);
> +                       }
> +                       setenv(GIT_ATTR_SOURCE_ENVIRONMENT, (*argv)[1], 1=
);
> +                       if (envchanged)
> +                               *envchanged =3D 1;
> +                       (*argv)++;
> +                       (*argc)--;
> +               } else if (skip_prefix(cmd, "--attr-source=3D", &cmd)) {
> +                       set_git_attr_source(cmd);
> +                       setenv(GIT_ATTR_SOURCE_ENVIRONMENT, (*argv)[1], 1=
);

It seems to me that for other options "cmd" is used here instead of
"(*argv)[1]" as the second argument to setenv(), for example:

setenv(GIT_SUPER_PREFIX_ENVIRONMENT, cmd, 1);

> +                       if (envchanged)
> +                               *envchanged =3D 1;
>                 } else {
>                         fprintf(stderr, _("unknown option: %s\n"), cmd);
>                         usage(git_usage_string);
