Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB704208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdHORE2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:04:28 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35430 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdHORE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:04:27 -0400
Received: by mail-yw0-f179.google.com with SMTP id l82so8261814ywc.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m/SJ5l4QBM3+b8udlx9dxElXBGTDUQpiP1M3He5x/Gw=;
        b=ssP3xUQHqMevQvsTwkTgtv6qmWyy4kZ/Ra9UWx29eOjeD2/slPRIf98iLoEUrH8hg/
         AkQYqCPW5bfNuq6TskI7JTmwHxE5VNRySc0EGlKuQNNxkaiY7cPZ0fsZGnZVuVTLRXkG
         owtR+syWp55aswf9VItjy05reK2bXaQKFf/V5cGBSB+WvkvDgVdG0XYtpnDgw/jRpk36
         0Y3lWYu5ADf19f33pAY4CRwH+nZSLnSmc6u/qKWRBJzVMJkkvEDmuwHgOwjQgTfDIjb1
         ycajMOLywk/iN7OyDp8phvnV/5eTAdb1Adh2a3IH69z6ICzQznLh0F/43KIdqLFFinJm
         Lc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m/SJ5l4QBM3+b8udlx9dxElXBGTDUQpiP1M3He5x/Gw=;
        b=TdIB0p5M+6hX2z1QeBCoc26G1QwhWp1iYiK1TqBCoKAOIjMX3p/Avolp01rcfDt+bh
         Q2t6LXY1syr9Qb66dH4k+1c9ILus7lvJ3NAUyRTnRPbFqeL3QFOYZTq8WGLUy21fHyAj
         kOOKbRQKBRdCaR8B+w5Um9eN7Df/pGruHLRAg5GwJ7ojpo7T+EjxXG9zUDdhJsvsaN+h
         wc6fh7jDoL5eMlSELPs00I2uDCJFQNqUpP9fcxMhI5mytPnaw0hKSGotGBAq3xMzA39e
         E9uKD5aM3RjD1uGpDZtJSTvEQ7Ps/UQdK3BAgK1A892RaKFvDXPVCxYO/UCKYFnXpW7n
         gaMw==
X-Gm-Message-State: AHYfb5g6aMbTFoMcptVlDM04gu9J9D1lniQ0g6qzuogdHqe0syeQzLOb
        VQt8NYPoXftVtCtNx5c8fDqHX+QDINed
X-Received: by 10.37.98.71 with SMTP id w68mr22723279ybb.14.1502816666700;
 Tue, 15 Aug 2017 10:04:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:04:26 -0700 (PDT)
In-Reply-To: <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:04:26 -0700
Message-ID: <CAGZ79kbT7MZcWnWiQOWt_SkFMpK-u5K2=9ktXK6FaaHypt7+Nw@mail.gmail.com>
Subject: Re: [PATCH 4/5] commit: implement free_commit_graft
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:49 AM, Patryk Obara <patryk.obara@gmail.com> wrote:

Here is a good place to explain why this is a good patch,
(which is not immediately obvious to me at least).

> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  commit.c | 11 ++++++++---
>  commit.h |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 499fb14..6a145f1 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -109,15 +109,20 @@ static int commit_graft_pos(const unsigned char *sha1)
>                         commit_graft_sha1_access);
>  }
>
> +void free_commit_graft(struct commit_graft *graft)
> +{
> +       free(graft);
> +}
> +
>  int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>  {
>         int pos = commit_graft_pos(graft->oid.hash);
>
>         if (0 <= pos) {
>                 if (ignore_dups)
> -                       free(graft);
> +                       free_commit_graft(graft);
>                 else {
> -                       free(commit_graft[pos]);
> +                       free_commit_graft(commit_graft[pos]);
>                         commit_graft[pos] = graft;
>                 }
>                 return 1;
> @@ -163,7 +168,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
>
>  bad_graft_data:
>         error("bad graft data: %s", buf);
> -       free(graft);
> +       free_commit_graft(graft);
>         return NULL;
>  }
>
> diff --git a/commit.h b/commit.h
> index baecc0a..c1b319f 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -247,6 +247,7 @@ struct commit_graft {
>  };
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>
> +void free_commit_graft(struct commit_graft *);
>  struct commit_graft *read_graft_line(struct strbuf *line);
>  int register_commit_graft(struct commit_graft *, int);
>  struct commit_graft *lookup_commit_graft(const struct object_id *oid);
> --
> 2.9.5
>
