Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9255B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 16:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJQABQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 20:01:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33578 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJQABQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 20:01:16 -0400
Received: by mail-io1-f66.google.com with SMTP id l25-v6so16871571ioj.0
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVbiZR7NapeSLXNXDDhp1/MD+Q9Z+ocgrJ/uWg0Y2uc=;
        b=uAyzyBkD47nda9HoTPUw+wWQy9ikvMsFSAChNlggUUXkA4mIsPRbOoaQGBICnv+5fJ
         joBXu+gIpAFqvlBK68lM3zUvg2GBIH18mD7OWD542rfrM3+zkYubtTA0MJgQZWD9Nu2X
         1ScuF9d2HY/rgPQHQqbHAPDxkIwXtrks+hotrQrz238geD0Dy8knHzI9rQkAv8hMw+d5
         GQFuH3h9wL6ahcL9nh00pqHZjy7VKI3ycCFJpy6wCLXq6rLZ/MUN586L9RqBbad3w1SN
         d84nzj7uOumMTvqwtcyv3Rg09J75ytGjxYo9dK2B6G6a4Isp6+ZQltD6ZNeBRLDwzc7B
         0z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVbiZR7NapeSLXNXDDhp1/MD+Q9Z+ocgrJ/uWg0Y2uc=;
        b=HaKEIqh3E3ULxp6i7gTu0rVmccsdHo90dQZbCRToRL7c7rkKmruG4Q84P9pc8NqpV8
         4xbr7mW817h0fe3t1QJ3VwEi1cvuivdJVXJd2j1ANmTrMnqQT0uf9Jz5i/k1zHytrTkz
         yt7p6txdvmsonsUc58e06JGZbHgMQnOSPnn+NH84u4DPd+bVbtEk2XKkABm+OMc/9X6v
         7Wvaip3IJ3a5P80xuu0KSaNBwvuk2gb/W0+vXTA/Oy3NRana6FxSAM0ixr+nQU75iTTD
         nRiiuGCoaFTXEWcxg1dsXvAjSIfeu88ryJpRMq2Loes0UmuAHUDL8fXMLQJOHNyJJdhI
         uykA==
X-Gm-Message-State: ABuFfojJeoweLrqUqag9lFBklnrpVOPmXEUYeop8J0+eEI1S7c2RNaed
        1k+5nS8IR/0RAS48i4u9rTCRISSm1p/3iJmFwSE=
X-Google-Smtp-Source: ACcGV63C7kq9uNUVpvqty1dF7k6xYs7/yvwoFzoHMBf9QG4M4VxjFjU/LHICNskwx1CP2rHat5ouur9HMcACmtAG5qU=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr15133837iod.118.1539706208116;
 Tue, 16 Oct 2018 09:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net> <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
In-Reply-To: <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 18:09:41 +0200
Message-ID: <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 6:01 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/16/2018 11:35 AM, Duy Nguyen wrote:
> > On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> Since the commit-graph code wants to serialize the hash algorithm into
> >> the data store, specify a version number for each supported algorithm.
> >> Note that we don't use the values of the constants themselves, as they
> >> are internal and could change in the future.
> >>
> >> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> >> ---
> >>   commit-graph.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/commit-graph.c b/commit-graph.c
> >> index 7a28fbb03f..e587c21bb6 100644
> >> --- a/commit-graph.c
> >> +++ b/commit-graph.c
> >> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
> >>
> >>   static uint8_t oid_version(void)
> >>   {
> >> -       return 1;
> >> +       switch (hash_algo_by_ptr(the_hash_algo)) {
> >> +               case GIT_HASH_SHA1:
> >> +                       return 1;
> >> +               case GIT_HASH_SHA256:
> >> +                       return 2;
> > Should we just increase this field to uint32_t and store format_id
> > instead? That will keep oid version unique in all data formats.
> Both the commit-graph and multi-pack-index store a single byte for the
> hash version, so that ship has sailed (without incrementing the full
> file version number in each format).

And it's probably premature to add the oid version field when multiple
hash support has not been fully realized. Now we have different ways
of storing hash id and need separate mappings.

I would go for incrementing file version. Otherwise maybe we just
update format_id to be one byte instead, and the way of storing hash
version in commit-graph will be used everywhere.

> It may be good to make this method accessible to both formats. I'm not
> sure if Brian's branch is built on top of the multi-pack-index code.
> Probably best to see if ds/multi-pack-verify is in the history.
>
> Thanks,
> -Stolee



-- 
Duy
