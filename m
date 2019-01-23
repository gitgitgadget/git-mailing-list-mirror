Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B98A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAWWoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 17:44:21 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56901 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAWWoV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 17:44:21 -0500
Received: by mail-qk1-f202.google.com with SMTP id a199so3427121qkb.23
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w74NMVVVNRW3YHNKhknOfVDutYbOBp7JXP9nPdf9UfY=;
        b=cFnBN8aj1A0Zzh1A/H88VGSYLPN59RR+JlxnIQPsk0ODf6BzAAdCAESi7N2tYxT21B
         F/8Q0hMlQ/6UsvfxLQ2Xor6RkrgLrcBpuPhGhaacGAD38j/XC5AbrFO8gnm14/vQRFaT
         PK77huzj0zpJi8/dL4ApDrepmZIwM5esvpYpZQWrEg2itVkk/YWv9D473EjU6X6XgSv3
         ayTGuSJ+aqoNWpKexz/uISHROybm0WXLAsYor2E+Fe2lYmu6+flj/GugFwhNuwpnR+MH
         hgDDPmgIc4cAYRHRUpWm+1MbSII3PvtX4aAzK2OBOMzaCgFwgm+YZM1wTz1nOktdo9xg
         u8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w74NMVVVNRW3YHNKhknOfVDutYbOBp7JXP9nPdf9UfY=;
        b=UhZUsQUIs8YEzPWziaibGMfCD7Vxgx6WVN0LNuzLa4dgEytBAHsds4H1QSBfpsjkm1
         dAJN/+JHCNmp2lTtxDTYupAteKH/atJPfZPiJ+PTYgZBxm6XANte8fYT6SSWgM9/YfdY
         7yZ9MWpyqsZd5MxnqoGohF+U4fKLTRyspZM9tWvixwq+dWb0D4EWGPhg2pu4l9i/0Etw
         +mpQKqjQ9YYF7ekXtjDwNAPdWJpMLXOZpQzHKuu3QIElB++rp/UpyXrJmKg7M4mk7SIo
         cjGwynCrLFti0XiOcKhBCga5/MmbXSHVA8+mEX4RKaakzazhIFnyHVFfJl4ahmC5h8tZ
         UfqQ==
X-Gm-Message-State: AJcUukeWH9it+kBellvYrAbIKZOWDpNZjDVMEFkZnUfBZs/fGRxf9Bv4
        pxNaNB36X/MMzkk1MAmhXf4R0ftZyDHrwrx3/6UZ
X-Google-Smtp-Source: ALg8bN4BP0kHflUFJZQAmoHVUCVg2kS3omd94c1XkTAfZAfIQ2bFZPUXCtf5m831nFXYN4V2wglAhXCyjDL2pRzpiIZV
X-Received: by 2002:a0c:981c:: with SMTP id c28mr2807927qvd.51.1548283459391;
 Wed, 23 Jan 2019 14:44:19 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:44:11 -0800
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
Message-Id: <20190123224411.149354-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.92.v3.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 0/9] Create 'expire' and 'repack' verbs for git-multi-pack-index
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The multi-pack-index provides a fast way to find an object among a large
> list of pack-files. It stores a single pack-reference for each object id, so
> duplicate objects are ignored. Among a list of pack-files storing the same
> object, the most-recently modified one is used.
> 
> Create new subcommands for the multi-pack-index builtin.
> 
>  * 'git multi-pack-index expire': If we have a pack-file indexed by the
>    multi-pack-index, but all objects in that pack are duplicated in
>    more-recently modified packs, then delete that pack (and any others like
>    it). Delete the reference to that pack in the multi-pack-index.
>    
>    
>  * 'git multi-pack-index repack --batch-size=': Starting from the oldest
>    pack-files covered by the multi-pack-index, find those whose on-disk size
>    is below the batch size until we have a collection of packs whose sizes
>    add up to the batch size. Create a new pack containing all objects that
>    the multi-pack-index references to those packs.

[snip]

Thanks - as you further explain in the snipped part, this is very useful
for users of repositories that use MIDX.

I only have minor comments (that I have written in individual replies)
and the series overall looks good to me.

I personally would have squashed patches 3 and 7 (the "prepare for"
patches) into the patches that implement the respective commands,
because I'd rather not have points where the commands don't work. Having
said that, rebase is probably not going to be affected, so I don't feel
strongly about this.
