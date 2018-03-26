Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F00E1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeCZRp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:45:59 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:38298 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbeCZRp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:45:59 -0400
Received: by mail-yw0-f177.google.com with SMTP id x20so5394732ywg.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGU6uM6ju4ZF4igMohT96JY/KD9d1vgOzHVnGkOVVNg=;
        b=C8EZimkORr09gkEEGbGfE38Wdh3YlOO0HRJHh4AXC/r8beeyw7hf8JTLYECvTTUBqy
         d4VnYdZFCgL/nzt4C7M1HamCBPwcSlUPKWwflAXVFduYYEtt2P8NQEodyWIsFTKjDJoX
         BNUw+UHsTrDAVwhhOY5ewX/VzdIQoP66ihnPjq0bAZr/ccNrzXzRvf1YmiJXsFaRnMvg
         hGK0GHBoHxxZrCWkonVapiMUDW7pTlurzcvfWT8ftaJs864QnQNSvpiF04mdyLTvkWjk
         KPRvaCYRaL1T2CJ+IRwpmpt8/6eXh3ukJ14RRvGwZrGOcFJG2A22FxAUkucEHepc/JIM
         VppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGU6uM6ju4ZF4igMohT96JY/KD9d1vgOzHVnGkOVVNg=;
        b=guOj+tuB+1jJP8RPlJOb/O884FlUVe5JpufimO2y3V7UgR8tq020m1Y8DZ2V3yRYuZ
         +UQ/SNXn6q9z1hi+bDVdIsKFm4/BlGtWRT/Lp7J2++aYTyFU/A6F2W+iEzjLgcNxC1E2
         WOoskiIG1JmlQrmMxNHHF6GY7q1n1df80XPfri32AJ2s/HZgXLAHOsqmNUbk0fsvSJt6
         z96Is1anYX+dXiY+Mq+d0ngMUytNHk2GsTl5t4KIBvPgvd0kJsZMrFNrGT6u82hNPKS3
         nke51oA7LO/LqUzDtCxFnnG7w7BigDLO5Nc8fKulcINesVw4crCTbpPLjdRwp9yleVAj
         wbCw==
X-Gm-Message-State: AElRT7EwPo2yG4Tdc53lXzftLQ1hfmQSey1UxPiPPEWo3z1Uv8Wb5Ajl
        5zKoadjzPFLALB8h40LQN0cQNrBBLBkt5e9IwQURDw==
X-Google-Smtp-Source: AG47ELvyPEWQ+oNLhNY6RbNjvzHwiDGdOs7x4eb5Z2MiqsUNS6iI+CuGk/bDMq1BhW5sZxnXlGHcomQGqvb1fmlWamE=
X-Received: by 10.129.86.5 with SMTP id k5mr15166312ywb.345.1522086357868;
 Mon, 26 Mar 2018 10:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180303113637.26518-1-pclouds@gmail.com> <20180323172121.17725-1-pclouds@gmail.com>
 <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com> <20180324053144.GA11420@duynguyen.home>
In-Reply-To: <20180324053144.GA11420@duynguyen.home>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 17:45:47 +0000
Message-ID: <CAGZ79kbkc2d-EHDTWP1GvCU62=ogZbP0ffxOHZamdQK+3h1yJw@mail.gmail.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 10:31 PM Duy Nguyen <pclouds@gmail.com> wrote:

> I got too excited when searching and replacing. Here's the fixup
> patch.

Thanks for picking up the series that I left unattended over the last weeks.
I have reviewed nd/remove-ignore-env-field as well as sb/object-store
as currently queued and found them well done.

Thanks for driving this when I was away!

With the fixup patch, both series are
Reviewed-by: Stefan Beller <sbeller@google.com>
(No need to apply that as it already looks funny to have
3-5 sign offs including mine)

With these 2 series reviewed, I'll continue reviewing
sb/pack-files-in-repository and the rest of my mail box.

Thanks,
Stefan

> -- 8< --
> Subject: [PATCH] fixup! object-store: move packed_git and packed_git_mru
to
>   object store

> ---
>   packfile.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/packfile.c b/packfile.c
> index 63c89ee31a..0906b8f741 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1937,7 +1937,7 @@ static int add_promisor_object(const struct
object_id *oid,

>          /*
>           * If this is a tree, commit, or tag, the objects it refers
> -        * to are also promisor objects-> (Blobs refer to no objects->)
> +        * to are also promisor objects. (Blobs refer to no objects.)
>           */
>          if (obj->type == OBJ_TREE) {
>                  struct tree *tree = (struct tree *)obj;
> --
> 2.17.0.rc0.348.gd5a49e0b6f

> -- 8< --
