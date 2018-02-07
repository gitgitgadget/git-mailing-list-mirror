Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCE11F576
	for <e@80x24.org>; Wed,  7 Feb 2018 08:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbeBGIvN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 03:51:13 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40639 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeBGIvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 03:51:13 -0500
Received: by mail-qk0-f196.google.com with SMTP id e20so133674qkm.7
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YliU2Ehe6wCNHF7Jy2xa/SyZPMNE4NYhQbG4ui9Z0vk=;
        b=NP57yQroVpXpPp2uWf54hjSI/fnDgq2DAEklfwGizu1i/wpsDbzYVeg4DZvglLaJNa
         yiLV59PBnBwPKkzLICKFLyqhPLrbaZ+NuIsHrojnDogeAJRdjWeJdFxW69ZViatbjcoI
         XoXTu0tujL75flusdcYj6IQWsryetfq8ZHo8S60xSx+L1OKuJ0iDDblAc3oNdH6GZ4Cr
         RHvduYNNz/DJehrDTBDrcV3L8bQPShPdwig6KuWpqjspwc+zBA2Vr7eD9MgBrAXyCiwE
         cyeFtlLbQKFV88Ps+Dws1ZkS5hqOQ9EbgKL7WwQkeumExALweTzTV6ntIY2EmsBc22dr
         KNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YliU2Ehe6wCNHF7Jy2xa/SyZPMNE4NYhQbG4ui9Z0vk=;
        b=OM3WWsHEbmHnSl+9Dds6H8xPufYjPvaWbddHe7Dvhgg2mT/Mcmem7FjfQEXEYeaBi9
         1fFsKlOXW4LsR/FsFyIvGSAuI56WJJ5/vvSEyPh7u2tf+kh2xYulBlIYt6YekKZYXLMi
         wFssPVdXlC7Y2LTmvHBfvAo7WyJGGRYOgnauWLfGUB5775s2owOLzvuuOXiFACbUi4xI
         cmt3hM/tKmbJDsQZKGp+mYeRxk0CRD5Sx2/CGIXjr0aZsWdyRPa4zTo9RPWYjSeFKlU1
         Cntv7XFaWYGIi8GtDMgRWtuqxxdN0zAOHrMGoaGSLYaAfLfJ+BmO3tp9nNCCABUQ5e45
         1zwQ==
X-Gm-Message-State: APf1xPDHolGBThJZzXKVwwcaGFatppfZ3lp/BmWFExh1MNsL7IccDH2t
        nDjmruZLS2sSJfyIKSLyu4GSpJTVxIZuIvPc3vaKWg==
X-Google-Smtp-Source: AH8x225As0Gag9N2PkyR2YXVkY75zOfgz+z/rj4Q+E4/zvyVxWu8Us5aDAk24BBQLpQAXFTBoVLP1eFgd48j+n0CzDU=
X-Received: by 10.55.177.135 with SMTP id a129mr8102975qkf.112.1517993472266;
 Wed, 07 Feb 2018 00:51:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 00:51:11 -0800 (PST)
In-Reply-To: <20180205021202.GA17847@duynguyen.dek-tpc.internal>
References: <20180121120208.12760-1-t.gummerer@gmail.com> <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com> <20180205021202.GA17847@duynguyen.dek-tpc.internal>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 03:51:11 -0500
X-Google-Sender-Auth: 9bjwQaqVxCLRbCgLsTLaYpUWqq4
Message-ID: <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 4, 2018 at 9:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> As a former translator, I'm not thrilled to see a sentence broken into
> two pieces like this. I'm not a Japanese translator, but I think this
> sentence is translated differently when the translator sees the whole
> line "Preparing ..., setting ...".
>
> I think the purpose of "Preparing..." in the first place is to show
> something when git is busy checkout out the worktree. As long as we
> print it before git-reset, we should be good.

The original message was "Enter <worktree>" which had the potential to
confuse someone into thinking the working directory had changed[1], so
it was changed to "Preparing...". The reason for keeping that message
(rather than dropping it outright) was to provide context to messages
printed after it, especially messages such as "HEAD is now at..."
which might otherwise confuse the reader into thinking that HEAD in
the current worktree changed rather than HEAD in the new
worktree[2,3].

[1]: https://public-inbox.org/git/55A8F4B1.9060304@drmicha.warpmail.net/
[2]: https://public-inbox.org/git/CAPig+cRSHwmmF9cCUbRrDCCW4kvg9PeOUxP5VQpSGfxzMxHWOQ@mail.gmail.com/
[3]: https://public-inbox.org/git/CAPig+cSLs4-uKicVMBSKnEro_FYD722Hs1_U6qzTriM8Ciok2Q@mail.gmail.com/
