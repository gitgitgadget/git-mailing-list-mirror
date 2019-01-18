Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C89A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 22:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfARWUJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:20:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38769 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfARWUI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:20:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so12363612ede.5
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsoeAIrH++F72T6chbwr+pvDiaF2b4Lfp0lEM0Ta330=;
        b=qa9RL46voJcGqLALsHo3zYNvIO0SP9TykpkDbGg/yF5kvDsp24ilhinUoC/3wq+RTy
         HrsojwPaPJTM+OTOHrYhBoec7tj3fZvkz4RsUZvb9IsENGMC+t0Lh0WtKZqzcmuncTkM
         3Anqbtx1BzWsYCHX4oCWgTsZrFSGmmGb/31zrkOKxl1gYDFICdR2zapMQAaw95gDrzX/
         FM/DYq8gnOgGfDniYzm0n/uNK2L4AiqoXnupdZHBVCTCfAeCdiS5xjkjVe1N4OeENzFc
         qSikojiyPXIPrH66xtF7f+anVNc5FXYzF/8N4ZL/pShXFISnLNTLiHcl3MxUvSwdM0OO
         mYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsoeAIrH++F72T6chbwr+pvDiaF2b4Lfp0lEM0Ta330=;
        b=E112xFCBrfod8bQWsTvkibGMrmL9jT9c+0h+XsAvODGmFwOyeHw55WgivRQfEc3rfE
         LC0S53kOQ/7pijWa9EygxQYrZDGi+TLOi6KmeHsTxdAZWPQ+4LIvbkvDuw7SyURbQYXU
         fihyeavoDDJTA4PnWH+OBxq80YBsXoHcHU4PZHMOZGQTqtZkPPX9P2FffndYpqdckJXw
         VNi1+HR09YtL23rI2tdK5NollhLlRKaDbJp2p6byIGgjpy8so+CULwgkJd1mipxep3qd
         40iz1i6ldDClNvPaZBjLTRDQinZ+rjKzb4PTprQYIM7op39x13vlLJbU1wWSxxpwaDcj
         cTLg==
X-Gm-Message-State: AJcUukcrIkyUNIekixglnseolL7Y0R4N/cMZJ1e6hlr+Gk2MHEPTDhbT
        VeQmB+WDmhTxIzCnmZpnk3i7Q/THShLHmUu0nnFrbQ==
X-Google-Smtp-Source: ALg8bN6ITK1hh5UjMsGpv6d4nSX+UH/M1ZGErVSumLy1EiIszbjUj+CKm2O7fgGAWUqs9/Y/qEEzzw3iYLdOZQM3DSQ=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr16933366edd.215.1547850006721;
 Fri, 18 Jan 2019 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net> <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net> <20190118213458.GB28808@sigill.intra.peff.net>
 <20190118214626.GC28808@sigill.intra.peff.net>
In-Reply-To: <20190118214626.GC28808@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Jan 2019 14:19:55 -0800
Message-ID: <CAGZ79kaPXQUY=FN3qusc2PNs=o1EiNarcBejOQKiozMSPvEOYw@mail.gmail.com>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I dunno. This is why I submitted the initial patch as the simplest fix. ;)
>

The first patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

Diffing across both patches, this seems to be the relevant part:

---8<---
@@ -1111,14 +1116,13 @@ static void collect_some_attrs(const struct
index_state *istate,

        prepare_attr_stack(istate, path, dirlen, &check->stack);
        all_attrs_init(&g_attr_hashmap, check);
-       determine_macros(check->all_attrs, check->stack);

        if (check->nr) {
                rem = 0;
                for (i = 0; i < check->nr; i++) {
                        int n = check->items[i].attr->attr_nr;
                        struct all_attrs_item *item = &check->all_attrs[n];
-                       if (item->macro) {
+                       if (!item->attr->in_stack) {
                                item->value = ATTR__UNSET;
                                rem++;
                        }
@@ -1127,6 +1131,8 @@ static void collect_some_attrs(const struct
index_state *istate,
                        return;
        }

+       determine_macros(check->all_attrs, check->stack);
+
        rem = check->all_attrs_nr;
        fill(path, pathlen, basename_offset, check->stack,
check->all_attrs, rem);
 }
---8<---

which I think is correct.

Maybe we could refactor the big condition (if (check->nr)) to be
its own function and have

    if (!check_overlaps_all_attrs(check))
        return;

instead. The function would allow for a natural place to put a comment
convincing us why the optimisation works as expected. :-)

And after rereading that code, the optimisation checks
if any of the requested attributes in 'check' are touched in
all_attrs, which sounds like a natural optimisation when we assume
that filling in the actual values take a lot of time as the stack
of attribute files might be large.

I think this patch is correct, too.

Stefan
