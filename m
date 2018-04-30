Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0BA215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 18:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeD3SDo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 14:03:44 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:39585 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeD3SDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 14:03:44 -0400
Received: by mail-oi0-f53.google.com with SMTP id n65-v6so8183519oig.6
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YCBMNME+f2bEPjP8+hOFLEHeSffxYAQyQHCKeNpgIvw=;
        b=Ty0EIlgafsUEuULH8RPt0ibXoShe9S7sA+gWp5kqAJKApQ6FSIzsFR679oRhutWR/4
         n8x+AlgmxVHFEjAJ/u2OXrMiuficMpx9kD77YnRZSMrsemeUNCyRr0IDcI17CeBFzj3Z
         j5uJ3fGPAvpvgxyAGdpRA0vpStOE3IBX4GcQhfscP53OfMpV4bTRHYWR1ItcwtrNDiuD
         woecm/8eDeSUgsVx7VGvnGsVZ5QrhTLVKh48iLWYNy913t5FEvo5ckql5qqGrL67k0D7
         HiDHHDKQac4F6xYVEosxvOQEEdo5jjgO4c5XE1NGLtOkJfjQQN0+EZZsolZaAnSLyGny
         Gqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YCBMNME+f2bEPjP8+hOFLEHeSffxYAQyQHCKeNpgIvw=;
        b=PZfQaCZJ/djNeAEE09V6vUPpw4ty7bFr7PsCyt2sIR9q5I9xb+YigYS97MhzliUPYa
         SpXQzyqhKfj8eooOEH6EGEfFUu0S1fYbNTgU6k1Z9eQnjVVJeJGmOpPFmkupKHR7xaVz
         7r8csWY7tDePhVTDwAOAlGt/D35Vym+p6bI5wiVyXiodAxFEX3LWuvYymb7RHRyd/Dtg
         xucAIR69ZF2bo77k/UjtzcaOgJzS+BIT7FsJqNk/1b6E4Zbc9NYwTWxWcxgrkqyA6cHV
         TFEXBgMPar5s4Ycofx0miq2nFrx6WsHczsgvdAphOStG1/n1/lNZDldV6d7fYALeMcIh
         Y1oA==
X-Gm-Message-State: ALQs6tDuK9ERAz2kkhHU8qMAXEze4c7VE1GGLaWeZMLMM482o7qCrZp5
        lbYG/ZiClY3tXdzN+sXU6fwvlLAge4vB0cTripU=
X-Google-Smtp-Source: AB8JxZopjiVkkitgStB8zmA7t4fqrssGcViyhCikk5XRr9CTlhBnREdVyxKzi+EB5mvZYSFTIPvL0rS5fwP5G5YkApU=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr7471337oir.56.1525111423465;
 Mon, 30 Apr 2018 11:03:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 11:03:12 -0700 (PDT)
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 20:03:12 +0200
Message-ID: <CACsJy8CX7cgd4EGSHVUtm35Aq92Us8WBA-r746vEaZiFP5Q5Lg@mail.gmail.com>
Subject: Re: [PATCH 00/41] object_id part 13
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 1:39 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [0] I can synthesize blobs, trees, and commits, but things are currently
> totally broken, which is, I suppose, to be expected.

Yup. I was tired and bored so I went playing with the new hash.
Writing and reading blobs (with hash-object/cat-file) were relatively
easy after fixing up fill_sha1_path and get_oid_basic). Then I worked
my way up to update-index/ls-files so that I could make trees with
write-tree. And I hit the first road block: struct ondisk_cache_entry
hard codes hash size so I would need to re-organize the code for more
flexibility (or even redesign the file format if I want to keep byte
alignment). Eck...

I guess I'll be helping review this series instead :D
-- 
Duy
