Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3461F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJPX0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:26:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55286 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPX0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:26:31 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so33654499ita.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ky+1ZHktGy1XIl1I8VHP5XMB41+5Ger03+wAfTnAXOI=;
        b=VynGC8qud0lBuhz/eEfS8frf3n22YEDox7HtEytmAqDrSkTHFeaeNr9yHI6EXix/kQ
         I6gRLOzkm1Mw7bncbVmioxxIAIwJHOhqcE/GDfEr7afQUYvytsq4LyxbD/uIP8OFNeHM
         /KVfibBkAiLZCLh9YGqYGxSGviU3YBK9sEARLnTTUGaLmib6IFuxGWcJZH2IdWfByoF3
         hsIVHM4edUXh1X1T2r452uFl8aV7sIHhiWI8i4j9h3QiNvc1RkzQr4r02JStKFBHv5b8
         ZCRIxDWGNrF3KmfDEQWTXcURc8b14HDuNBLieZU9MKLJlsDY/y5VHOKBTSn4ufk+Qc8P
         dDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ky+1ZHktGy1XIl1I8VHP5XMB41+5Ger03+wAfTnAXOI=;
        b=QrFQsWgtPGwbsY77LjsBCenf5co0Ba9cTA0aY9TleK+JHBAew0hTvlXbmx2erMA2y4
         ZTTD1z97iMrokyz9hXERFlMb2gpjfga1eD7iCuElRKVTQZtQ43xwVgNa0CShYYua/SaV
         tGK0BrwkjSNmp/xZfol2LeEFm/TEMx+1u1UpZTuixVpsNSvvQad/VRV+KBREDcidXFVN
         9i/nZgZdXpadMm9LUrVJI68kFqT52KDWWh9UmIoIsq/vMsUka+GDDZHZcyFjWLVamk3w
         oqEG9mHNFY4K1G3EUP5XQeMJ6ex2x0/bxexmwnOhb0aGtPluSs4R/ESVmqT+D3Yf1qSh
         yK6A==
X-Gm-Message-State: ABuFfogtUiSKRYzfBErHsL/HKQRoPEADTwAFhrCluF4z1kkAsLc7+Pnq
        yhl84A6bVN1sig47GXi4za6sgg7NviIOJQ/hRLE=
X-Google-Smtp-Source: ACcGV609YC1lpyjqH3X1E+yt6EJNS75CVR5KNz59lFknFw23d9v1LqBpPotB5sf6cpUO0SFFibQ+W+lYYwl0nbcW6Ik=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr16358165itg.70.1539704131736;
 Tue, 16 Oct 2018 08:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net> <20181015021900.1030041-14-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-14-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:35:05 +0200
Message-ID: <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Since the commit-graph code wants to serialize the hash algorithm into
> the data store, specify a version number for each supported algorithm.
> Note that we don't use the values of the constants themselves, as they
> are internal and could change in the future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  commit-graph.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 7a28fbb03f..e587c21bb6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
>
>  static uint8_t oid_version(void)
>  {
> -       return 1;
> +       switch (hash_algo_by_ptr(the_hash_algo)) {
> +               case GIT_HASH_SHA1:
> +                       return 1;
> +               case GIT_HASH_SHA256:
> +                       return 2;

Should we just increase this field to uint32_t and store format_id
instead? That will keep oid version unique in all data formats.

> +               default:
> +                       BUG("unknown hash algorithm");
> +       }
>  }
>
>  static struct commit_graph *alloc_commit_graph(void)
-- 
Duy
