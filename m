Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81271F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeBFEHM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:07:12 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44969 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeBFEHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:07:11 -0500
Received: by mail-qk0-f195.google.com with SMTP id n188so682679qkn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FFFT9v7lvGAKMBHhsgBO1zT3FblGurAn99smJzqLDRI=;
        b=tr82m+Om88qqYRJG/4/DfrcGeOcjg8VMi2wCPGnacWu6Nlxy4O2oV3DQrjS2s8D8F0
         eBsDtSL3b+EPovKEUqvmkPgSFfEeFSCW+uxuWlVa5gW4K0XtOVjIVVbTlsi5Y4Z4/C1V
         jr9sS08cWEVtWXMiCP84wQ3XYdDmXyFWHDuNVf9C+Hmvjl7NzM9sMbE8rNkCtc4Obc7T
         2/FHVuzkRVSAPnzuTcWIQXp9u+3KbjxwxJflot6rGLpoX3LuNeuK/gt7wp3gA4kK4qzo
         ir71vburK2ce/a5WDRF2NVutkqcNgd7O6ZI8xHSotQF7O2J+awl7D6z+AgzVO9+Z/0h2
         WTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FFFT9v7lvGAKMBHhsgBO1zT3FblGurAn99smJzqLDRI=;
        b=F6uoUKK/HRnWhOLisflvqoTC3JkbToH38p7uJQ+KV90g3nvfFbFpJscYSvyfZipFzR
         jBU8WXZD1wSdkBJNTP6b3VNRqk/0Mhy+YsWjN5ByJBvfP2eoAwnx8ld02iOJ3OraX/dw
         CCAH7q6VJx55a1Hb7FLpRUOmFlHgjOG3Khk8RnqQIjjW/Paqf5HBGHHGNvZzqkroGgDH
         X5HedJofusqrAmkXS8tgxo6cpOLZdBwWN5jcnx0l4scHrtUmIrqu2b7aUZjtiiyKiv4X
         kOYg40g9utvt2yt4cCxp1g77R09o96F96Vn6+wFz+aIY8UmYzzeUcVv2fLhEccM7SCdA
         Yjkw==
X-Gm-Message-State: APf1xPBPcnNRs0rzFb5h2I1H6B6zzlSFEB5NFp05+xC0bylegIZR4I5n
        Q99ychB88Mv+ys1exkecKTZdPLqnbPkjKlToEPQ=
X-Google-Smtp-Source: AH8x224Kk7WDbxmROb1nBc4/NpXd8fTiha3RSWnzUPkuqRXQ6RtcNksy9S94AA0RuBngrEU4L0G7kozn/uC18dROpxI=
X-Received: by 10.55.164.20 with SMTP id n20mr1581011qke.286.1517890030497;
 Mon, 05 Feb 2018 20:07:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:07:10 -0800 (PST)
In-Reply-To: <20180205235735.216710-72-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-72-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:07:10 -0500
X-Google-Sender-Auth: WRchhIip-GP4TrH7yOCuwgNCtq4
Message-ID: <CAPig+cT4=WA2PpovtG1M5hsrTxzDYdGjiYgvpp4Pbggc3Qo-Yw@mail.gmail.com>
Subject: Re: [PATCH 092/194] object: move grafts to object parser
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
> Grafts are only meaningful in the context of a single repository.
> Therefore they cannot be global.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/commit.c b/commit.c
> @@ -121,20 +120,22 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>                 if (ignore_dups)
>                         free(graft);
>                 else {
> -                       free(commit_graft[pos]);
> -                       commit_graft[pos] = graft;
> +                       free(the_repository->parsed_objects.grafts[pos]);
> +                       the_repository->parsed_objects.grafts[pos] = graft;
> diff --git a/object.h b/object.h
> @@ -4,9 +4,13 @@
>  struct object_parser {
>         struct object **obj_hash;
>         int nr_objs, obj_hash_size;
> +
> +       /* parent substitutions from .git/info/grafts and .git/shallow */
> +       struct commit_graft **grafts;
> +       int grafts_alloc, grafts_nr;
>  };

Do items moved to object_parser need to get freed when object_parser
itself is freed? Is that happening in some other patch?
