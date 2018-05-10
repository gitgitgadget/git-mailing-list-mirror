Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31671F406
	for <e@80x24.org>; Thu, 10 May 2018 14:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeEJOzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:55:05 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:41432 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935624AbeEJOzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:55:04 -0400
Received: by mail-ua0-f172.google.com with SMTP id a3-v6so1492673uad.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVsTXa3OFBAryWG/a4rP/68ntH8i19rXQHGQHHZutfk=;
        b=cI3jvGxUd6QjDJHm3zxnQyU2xopCvYs8znHYiRsbMBqe0ZClJeG3ciaN4TnDJNVaJ3
         d2Ybi3E6mH0FEd9jGConM0IIn6IB3/nJzdUhJIyHUUKvExPFAOS2cqAUOWVc+x5HMfC5
         lXR/e7GQrI+1ndT+2uUBSnN8iNLPKH+OlLqrcF93pNMDwW/7xMGZEOoCeYt/btHcnOcG
         KgQ+6Lj5FjyUh9O36JrYr39B9aUS8ymu1HSrrnaApJbckt80o8iXkUwkg4QfKBeuLYRp
         WUrliOFhzsJdHtZ5x8zyBFPXBoHYTSO/0WU61TPff1P2ghSsuFdotHhfijzb7/E0lgvt
         KtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVsTXa3OFBAryWG/a4rP/68ntH8i19rXQHGQHHZutfk=;
        b=V9br5j4LbhMcmDW4+K/syIRE/ZVvjp8ljwsrnZEOOQpS7JT2Y7Pv6Hd2zo3a4KeuSJ
         pq1TmMADrzAieoPbOmWSpF1O1a+WOT/UHw4v8/ooIyjqnAwUckagOWKZL6uwDbjPLaR+
         gGRgZvcXriO2iZfbrU5h8Zwuc+JLJi3q5hHqfc6vOk8eSAzpDu74ei1Mguif15H6eJx4
         dHyGQqp6V6XBKW9AZaMQOs6WVAU1fvm5BQX2HqjG40eynLk4Ta5B74EBO9H6C+Sfd0IW
         KaL9U/0ieu6f9+11/bzSg/OxGngYPL/JuAi3Cu5aPbiI5t84J0Aogml68Iktw/J8svBo
         bjLw==
X-Gm-Message-State: ALKqPwe/K8GF/IyNWCejzj8o7RGdlbv9pQOQOItVjQczQEYYgzJFXT8t
        7g1TXBYSpGueqdEoZ4xPTpPyGnkDwJTOoa+X/VBN7A==
X-Google-Smtp-Source: AB8JxZpvn744XveL+yEP+Shu3TQ3TJMXpw6UvbqoaHs8o2aLv/d2B77DY+NIYejUwulj/0KTYgmIN+Nyi+EtJuh/Yhw=
X-Received: by 2002:ab0:5bd6:: with SMTP id z22-v6mr1271837uae.48.1525964104128;
 Thu, 10 May 2018 07:55:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Thu, 10 May 2018 07:55:03 -0700 (PDT)
In-Reply-To: <20180510143432.GC25617@sigill.intra.peff.net>
References: <20180510135852.25232-1-szeder.dev@gmail.com> <20180510143432.GC25617@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 10 May 2018 16:55:03 +0200
Message-ID: <CAM0VKjnVAWdxL152MGQWFmJdHC99F=PjKpj9GdU62NV40XJi=A@mail.gmail.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 4:34 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 10, 2018 at 03:58:52PM +0200, SZEDER G=C3=A1bor wrote:
>> Since testing bitmaps doesn't need a worktree in the first place,
>> let's just create bare clones for the two JGit tests, so the cloned
>> won't have an index, and these two tests can be executed even with
>> split index enabled.
>
> Nice, this seems like a clever workaround.
>
> Reviewed-by: Jeff King <peff@peff.net>
>
> The more heavy-handed approach would be to just disable the JGIT prereq
> when GIT_TEST_SPLIT_INDEX is in use, which would cover this and
> potentially any other cases. This is nicer because it lets us continue
> using the test. And it's not like we have a ton of jgit dependencies,
> such that dealing with each individually would be a burden.

We could also 'sane_unset GIT_TEST_SPLIT_INDEX' in these two tests,
but I think that we should do that only in tests that specifically
check split index behavior (i.e. t1700).
