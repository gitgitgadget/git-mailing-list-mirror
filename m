Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057D31F461
	for <e@80x24.org>; Sat, 13 Jul 2019 05:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfGMF1S (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 01:27:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43929 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfGMF1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 01:27:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so5199413pfg.10
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7GaB8RsW7cg5GHkfXuqAQt03Jc3EAdDMaYFKpCs7ado=;
        b=jGzwQwJYN1b8Dmw95UjBjlCshRX82oXD5do1bmzyKTlLDrZRdsVfoEzTZvu5PDBmoT
         BkO2Xrt/e92mOpnqDm1ku7hs1D0mmJVTXwfBGMm+lQFWbxzW+CRspZIjmlsWDVPcAUMb
         4CqHKtQm+eN2N4Pc7BOfwHGBSUzgLGf5saMojJdjfEUiN32HKfZg7JZxMaAlD96lnYE9
         D+L7XSZ/APq0efDeVRymGIdbWktepFtedJzS948C7ectgWiRqxc443272Sk8cWb6Er+A
         CIpNJiQiXq2q3VHAYv/YaaDgHgpS5f1nDMn8ERGk6s2rNKnUbfwVK64pYUshPR6EQrhu
         JG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7GaB8RsW7cg5GHkfXuqAQt03Jc3EAdDMaYFKpCs7ado=;
        b=QNZGoRlsunJyFD217M+SHK3uxXHc63+JH64wWqAv++YMqIPb4H3DXj6daU+I/zDaVT
         XlV2TEB8ImKJT+lcLHxHlLI5q46guIEkCIt025vGOlUux6Lr2bnLIxnnpel5aSxDQTN1
         pqbvT0IcscWl8J2y1hMlt2VoXUpeTW08h56P4AzpytejJV79gh/uWbd+wb8bCmFjrXy7
         KWfuYaov2lCOU9p8yWiEJWwJcrBXL0qn3xwEvnmkjH25YflzCUKQcFT+2KlYKTm0rcDd
         2F5SPqyqZe7iBLFmUCyw+r3aHbSOo6lI7oLfyh5IR2LfPv/jMPs3xpo7LDKdhcysTrej
         svVg==
X-Gm-Message-State: APjAAAX/nI+GfajXPyQYJbxVqk7rPz7sCPvd+8OfAudLVIqnb6Ck0KRP
        xl2xCDfns9gKejaY8ZmOszMh/sxmNiUYFMHj4kASsoV9yyQ=
X-Google-Smtp-Source: APXvYqxIeWbzH144v89KzqV1/XIcMDoko762B0VlkBwg271Cgc1qh77orAJZqncVhZtozBwPLlOhAGITRGk60d2v6qs=
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr16844072pjz.72.1562995637212;
 Fri, 12 Jul 2019 22:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190713051804.12893-1-eantoranz@gmail.com>
In-Reply-To: <20190713051804.12893-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Fri, 12 Jul 2019 23:27:06 -0600
Message-ID: <CAOc6etb_XFbQWDHg3YRNiskkntS0ro2MYgXCfp6oPv4LutQFGA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are
 no conflicts
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 11:18 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> @@ -1342,18 +1354,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>         if (verbosity < 0)
>                 show_diffstat = 0;
>
> -       if (squash) {
> -               if (fast_forward == FF_NO)
> -                       die(_("You cannot combine --squash with --no-ff."));
> -               if (option_commit > 0)
> -                       die(_("You cannot combine --squash with --commit."));
> -               /*
> -                * squash can now silently disable option_commit - this is not
> -                * a problem as it is only overriding the default, not a user
> -                * supplied option.
> -                */
> -               option_commit = 0;
> -       }
> +       if (squash && fast_forward == FF_NO)
> +               die(_("You cannot combine --squash with --no-ff."));
>
>         if (option_commit < 0)
>                 option_commit = 1;

One question that I have is if it makes sense to set option_commit to
0 if the user didn't specify --commit when using --squash, so that the
current behavior of git is not broken. Like you run merge --squash,
git will stop as it currently does... but it would be possible to run
with --squash --commit so that the revision is created if there are no
issues to take care of (currently impossible, you would see that
message saying "You cannot combine --squash with --commit.").
