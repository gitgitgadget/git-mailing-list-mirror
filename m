Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714FC1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeFKSUb (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:20:31 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39480 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeFKSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:20:30 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so23907264oth.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRbN1ifMRENrXpRyrjQP0tq9ftPYfhZlSOQzoPrFbrQ=;
        b=WMDF6xXKTMqRg6zTy2Gjpfl0avei4Ctfsh8Yg/dcX7x25rWoyXwGcx3f+BuRLi3OWx
         bUS84N8AHWCyLIFbhgx7UyehYmaxmf2aejZcjVUgUK6D0X/yzUHfJryXzYMhkZycUnvc
         EjRBSqF2LeMd+yMMQh3fwh0APBXRBMEQLQR2C1JpMa7ty2MYxhbUkhComvRdcBKwQcpd
         ct0hkF7YVBoGvL5t4TrG8FDaKv+4/fqLYQvuSLn7fIm8oo5xwfNglWXXxYWExiONJF0o
         4WZ7+/8EthaqVU/7n04CzE5L8w+d1Lr3oxk/I+ku/KL/j9G4UhJBiP6KqaWEDAHhxnJC
         Y7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRbN1ifMRENrXpRyrjQP0tq9ftPYfhZlSOQzoPrFbrQ=;
        b=lv/H2VZXlqMT/sw/fianvJtOLfeUzEXV4mKCyHZ70H+Cxzsxf/Mraezi4mZBez46qh
         rgcjYLZA8EET1Nn/iLo2usmNEnbFk8J/VSUtcA2ZeBHhzqb3RQ11WtdQ+M08VYnEcBAI
         IbH7/O1Y/AL1lMTR6+IX8unsAw5Ec3yT2X9M8TDDEfLNNfsKl3edNZbnDbsHuqAMt10E
         0pVjrgkrsAK9CSdQ0DkzUaDct8n0Nmg6MCE2AeTvP4QHQp0nc9M/LTW2xDCcj/Bq6kve
         /y56XgOwen+eBJaDTyuU0yOgYWbPUNGltoGI9833gx78eavxoPBY1+XPJM4N/or22y+Z
         Ns+Q==
X-Gm-Message-State: APt69E3pOfdgisuZegUubUuvvCjBL40YzsaDANH3vfqRNrHBXS2lzvnG
        ogvY79by9ExPf5hCJ8H4zq99Fqs0eslngBV2LKc=
X-Google-Smtp-Source: ADUXVKLriCOK25z18VnHkZZ41BB5EMsl0ZFjeyvfgrcuNCrUwV91aFk/CwA8fPBnYerlh+JHmo/44736ikxhxg0ui6U=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr184477oth.75.1528741229783;
 Mon, 11 Jun 2018 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com> <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
In-Reply-To: <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Jun 2018 20:20:03 +0200
Message-ID: <CACsJy8CDwGwiVk_Y-dbDowYjJH3iDQHntb_HvwK7R5-4Gy4SzA@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 6:05 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Jun 9, 2018 at 9:58 PM Elijah Newren <newren@gmail.com> wrote:
> > I read over the rest.  Found a small grammatical error in a commit
> > message.  Found multiple places that still need conversion, from
> > pushing up &the_index usages to callers of ll-merge.c and sha1-file.c
> > instead of having them in those files, to mixes of _cache_ and _index_
> > functions as in apply.c and merge-recursive.c.  However, Duy pointed
> > out there was more work to do,
>
> Yes. This is just fyi, 40 patches later, ...

Junio, just to be clear, I think I'll withdraw this 23-patch series
(reviews are still welcome though). It does fix some potential bugs
but it's not that critical. This will let me merge it with the other
40+ patches and reorganize better (after all this started out as a
single rfc patch, I didn't realize what I got myself into)

> i'm down to leaving the_index
> in three files outside builtin/: merge-recursive, notes-merge.c and
> transport.c. Even after the conversion we may need some more follow-up
> patches because it now shows places where we should _not_ touch the
> index at all, which may involve not simply passing NULL index_state to
> some functions, but fixing them up to tolerate NULL index_state. So
> it's going to be a few patch series until the_index is gone for good
> [1].
>
> [1] but like cheap horror movies, there's always a sequel:
> the_repository is still spread in many places and hides dependencies
> in the same way. We can't do anything about it though until struct
> repository conversion is more or less complete.
> --
> Duy



-- 
Duy
