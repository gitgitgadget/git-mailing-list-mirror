Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190EA1F406
	for <e@80x24.org>; Sat, 12 May 2018 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeELUyW (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 16:54:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39721 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeELUyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 16:54:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id e1-v6so3844531pga.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rntdqSJQ89D1n3Q7iGdgjcO0qDX+4FBBBoAvSv/0wbY=;
        b=IKX1TXP2bn/Jz245rRi9eWv6bygQ/M1VqoF2x3zXvaL/3echvNVHTc6QEfMKF362FP
         OQ2MDRMXwFpA2/0ubMIpBcrnYQTD7/xCGelj1uMaqClwokQqmp/Op7NsIKoSoLExdMZe
         4X51S787Ey9+Fnucl4Y9AlQJZiRT9IrssY+vdRbvIkaAPlZBhNKpsLX1fkMrOEvHpoeu
         aAPQUA5PYvjyUxaza/sbkR4ExmziqqrzSHHWMs2aMchK8hW8gRCzIGmDMqRmRNHBnv8A
         9L0iWubZLbttKemQ16zk04QeJkM47wYRPJH8k9MflTSq+IEMwsIY25d+iMo0QsP7Vmm3
         iFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rntdqSJQ89D1n3Q7iGdgjcO0qDX+4FBBBoAvSv/0wbY=;
        b=hJlNaNmjJQMNF2Su1egX1gTijF0ZK0pv4abLZIPQ1ldIsXh9T8QTOSKtCduNqdw17p
         PftocTJfUeBwOZ+szbh+q8zwdLDvX3LUhj7Pu+DwU80n9RSTYjl5vWYyLVI+UbP+lHPf
         KS0hX+o4wzNnlrU0b4FK7Aqlon1ld2KNFQo+mOTU7jiYPJU08IPmaprnWJaqTgfDi/Di
         eKSFqqovA/2SikpxsM9gYADV+BD4TI6c7hWgKrqdwXQ80kztJDDm9lsBzGx/KFbtJ16j
         yGeIv2GZxfoqt04aTrqfpDhNep52rvMg7NijiEOvIy68sv9VkmqUIpzfp1UvhIKph6JE
         YyQQ==
X-Gm-Message-State: ALKqPwe83pPKzOyoAzEzuSJu3C4fHsdSxJhUd+oJAkiUd1TD1DHXefEc
        fMRecddDhXf8KLYPFRiXS/jK98TIc0uriKZebzQ=
X-Google-Smtp-Source: AB8JxZpXjflyZj0SM7ztO9BWT6HdVxF72EHIGk5QKB5M0Ptt8LUjhUABU2d8l/JxNTvl6y5qhOXVxShAYeSenm8h9Z4=
X-Received: by 2002:a62:62c2:: with SMTP id w185-v6mr4358566pfb.78.1526158460684;
 Sat, 12 May 2018 13:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 13:54:20 -0700 (PDT)
In-Reply-To: <20180511211504.79877-7-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-7-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 22:54:20 +0200
Message-ID: <CAN0heSo681Db75Nj=kfUT441+zmL6gDzoPAHTzC7R+Mh2ozb_Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] commit: force commit to parse from object database
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:

> -int parse_commit_gently(struct commit *item, int quiet_on_missing)
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph)
>  {
>         enum object_type type;
>         void *buffer;
> @@ -403,17 +403,17 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>                 return -1;
>         if (item->object.parsed)
>                 return 0;
> -       if (parse_commit_in_graph(item))
> +       if (use_commit_graph && parse_commit_in_graph(item))
>                 return 0;

Right, this is where we check the graph. It's the only place we need to
consider the new flag.

>         buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>         if (!buffer)
>                 return quiet_on_missing ? -1 :
>                         error("Could not read %s",
> -                            oid_to_hex(&item->object.oid));
> +                                       oid_to_hex(&item->object.oid));
>         if (type != OBJ_COMMIT) {
>                 free(buffer);
>                 return error("Object %s not a commit",
> -                            oid_to_hex(&item->object.oid));
> +                               oid_to_hex(&item->object.oid));

Some spurious indentation reshuffling going on in two lines here.

> --- a/commit.h
> +++ b/commit.h
> @@ -73,6 +73,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
>  struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
>
>  int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size, int check_graph);
> +int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_commit_graph);

Unlike my comment on a previous patch, this one is meant for external
use. That's why it's not marked as static above. Ok.

Martin
