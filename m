Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F287207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 17:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424870AbdD1ReS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 13:34:18 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34560 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422832AbdD1ReQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 13:34:16 -0400
Received: by mail-pg0-f54.google.com with SMTP id v1so18091197pgv.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VOLdvRDrCt6MBUGOqEsefGCihS7Ltn+ZZTNYxEWe5pw=;
        b=RocPykdySXUYm0X/oZh84d2T+KumDX/cSy3xa2tpPYcbpgMgV4kK+Ej6FUQaydUtXv
         9ahuXhT7GIu27AWFpoDiE+lNtWvQhZ/lQjuZEei57UpQM1oQoKcsUDzm30DDT3KHI/+y
         dvJ+CWqoxhlAW7yjNgWPtxhkMjdRgNZ6Sm+3So29KYyy1BHos/XXub1v7v/8C/oY05DT
         dYg0dUYL6rUfFrxh0RPxj0cNwGB67brW/RiCb36wvW3LgA+u3zMK1Afyx3dsplBGXJ3a
         CbsGBK7iBEvfRSElaayfLWyKK5q6SiTCOUHDCue/kC8coNEc636PPG7K1V4CI++QvMdI
         c0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VOLdvRDrCt6MBUGOqEsefGCihS7Ltn+ZZTNYxEWe5pw=;
        b=Xzro1ltr8mcaeVokP6qmBIAV98KoZCAYCyJF2Y7Cke4Dbf3c+LZ27NNBpLvAR5B28t
         o2TJ94bYXaOn9W61lc8pmSrumObw1DxlveHgFkk4JlFxD2thWJ+bPq2zkoCGNK2OF0GH
         +zlA7+LkOzl0eLiK5+qBZdFY/sxCM1m0JWM+Mp4Kt37mcqUEWd0IHF0ion35CBBpGtl8
         qyKw07VS+JqU0wngog7P5QFwwL37W7Nl1Lt2ErMDkCUMzImMYEP9JRIMtbchGNOSOHRG
         +Bl3y7t0CTQJbjUPuK9YyCHKZslOXejTxEFCCvNByfyKBNX7c2ijzrmhgdJHt52bFmW8
         Sq4Q==
X-Gm-Message-State: AN3rC/6mc75RSpK/HRvecUzZQWL8Yql1QexhZqhyQh9svZ/UibDewTnk
        7xumrMmZwYvyvdtAtS+caSkClv6DYXawn4yCIw==
X-Received: by 10.98.204.93 with SMTP id a90mr13267462pfg.6.1493400856028;
 Fri, 28 Apr 2017 10:34:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 10:34:15 -0700 (PDT)
In-Reply-To: <20170427205037.1787-1-marcnarc@xiplink.com>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com> <20170427205037.1787-1-marcnarc@xiplink.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 10:34:15 -0700
Message-ID: <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 1:50 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> So here's my attempt at fixing this.
>
> The thing I was missing is that init_revisions() calls diff_setup(), which
> sets the xdl options.  It's therefore necessary to have the
> diff_indent_heuristic flag set before calling init_revisions().
>
> A naive way to get the indentHeuristic config option respected in the
> diff-* plumbing commands is to make them use the git_diff_heuristic_config()
> callback right at the start of their main cmd functions.
>
> But I did not like that for two reasons:
>
> * It would make these commands invoke git_config() twice.
>
> * It doesn't avoid the problem if/when someone creates a new diff-something
>   plumbing command, and forgets to set the diff_indent_heuristic flag before
>   calling init_revisions().
>
> So instead I chose to make the indentHeuristic option part of diff's basic
> configuration, and in each of the diff plumbing commands I moved the call to
> git_config() before the call to init_revisions().
>
> This still doesn't really future-proof things for possible new diff plumbing
> commands, because someone could still invoke init_revisions() before setting
> up diff's basic configuration.  But I don't see an obvious way of ensuring
> that the diff_indent_heuristic flag is respected regardless of when
> diff_setup() is invoked.
>

The feature was included in v2.11 (released 2016-11-29) and we got no
negative feedback. Quite the opposite, all feedback we got, was positive.
This could be explained by having the feature as an experimental feature
and users who would be broken by it, did not test it yet or did not speak up.

So I'd propose to turn it on by default and anyone negatively impacted by that
could then use the config to turn it off for themselves (including plumbing).

Something like this, maybe?

---8<---
From 58d9a1ef135eff9f85b165986e4bc13479914f8e Mon Sep 17 00:00:00 2001
From: Stefan Beller <sbeller@google.com>
Date: Thu, 27 Apr 2017 14:26:59 -0700
Subject: [PATCH] diff.c: enable indent heuristic by default

The feature was included in v2.11 (released 2016-11-29) and we got no
negative feedback. Quite the opposite, all feedback we got was positive.

Turn it on by default. users who dislike the feature can turn it off
using by setting diff.compactionHeuristic (which includes plumbing
commands, see prior patches)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
diff --git a/diff.c b/diff.c
index 11eef1c85d..7f301c1b62 100644
--- a/diff.c
+++ b/diff.c
@@ -27,7 +27,7 @@
 #endif

 static int diff_detect_rename_default;
-static int diff_indent_heuristic; /* experimental */
+static int diff_indent_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
