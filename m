Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF0C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 21:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiK2VGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiK2VF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 16:05:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3755AA2
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:05:57 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z17so10090470pff.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FeS+W7S1Wlp+SzWC2gdurbYrrtzcDc5EFwf4cKXBwA=;
        b=Fbof8WdF30R84MBiqDE9HQ9Db47rG0Mj7IgVVhDWux6iO/NR0Hprdtt3P7gLjJGY6C
         6kzi0MCKemPer/WD6bJF9p/GP6d/fjj3BuAK3+Zd7ToAYiFuPncWSAfdo6q6506Y3Yt0
         MGijnbTtnOsg7l6RiXRLoefF2UlX8zU7ywjIe7C+lSypJlLz38f1Zaq3TccMIsU6UA95
         vkdNxhrqyfB7zJMN5IC5depXTAuk34kevDljDUfWileodMuPnpWh/iQa6+ro6bWw6i2U
         ovXNf5MdBJRx5SZFoIersvkic5XA9XGgBujFoIE3h4Zhs15cRXhSIs4r/jiG8F/ox93A
         Crjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FeS+W7S1Wlp+SzWC2gdurbYrrtzcDc5EFwf4cKXBwA=;
        b=5CJilx/aap7GVT7PK28y1RlBknVWmCB6KGQq1MVy11Bh1ZT56BS5TQOIDqhk0sgj+C
         qSiTfe7rt0eDLei9yBJ5l6+SgU5ngEvXfDLkyVAbKnCwzJu8Lzb2g4T/7zEnbcOJFThr
         G1T9Wtz5tSMqNsAg1E4A/LDu2ADSW3qg13Jh8Fp/1RAwRHQ/d1+qBfd+NuHlrhHdfOVs
         DtN57wkYrWjIMFrvCI6ZSUZTzrEh8Rg4QIyZ5vsbiuxzrQ8HuxGEP7y6nKkK2trN0Vdn
         EA0/Koe9/b1YhJDRSgXTKGEcXFUp2oj1OVb8OEBlXbRaFpBIxNQ44duF6WgiNgu5IlJE
         DFGw==
X-Gm-Message-State: ANoB5pnh3/9Q02MyiQ1eUW0+RIMz/IGucqV7rjwrl+nOvHwWzRG/ncNq
        xMlWgategpxDygLcc6OvhUlYuBRS5AjV80Ae0SE=
X-Google-Smtp-Source: AA0mqf6A4kZFaGi8ksDglSomUCumGSXDoPix09quSFNRhHaZO/d5z2YTBc2DaGzmONuB5LxOtaPZYOAFu4XfU1gYQRo=
X-Received: by 2002:a62:605:0:b0:574:ec7f:20d0 with SMTP id
 5-20020a620605000000b00574ec7f20d0mr17740691pfg.77.1669755957253; Tue, 29 Nov
 2022 13:05:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com> <b79a4852-1e20-2c9a-a91c-f1ea629af402@dunelm.org.uk>
In-Reply-To: <b79a4852-1e20-2c9a-a91c-f1ea629af402@dunelm.org.uk>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Wed, 30 Nov 2022 06:05:43 +0900
Message-ID: <CAF5D8-vTmDEX1aF1a3hh_U81Zk=pUGbHQtgp69Zz4bPwZRq99A@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] git-jump: support Emacs
To:     phillip.wood@dunelm.org.uk
Cc:     Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Mon, Nov 28, 2022 at 7:13 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Yoichi
>
> On 27/11/2022 01:18, Yoichi NAKAYAMA via GitGitGadget wrote:
> > Add an optional argument 'stdout' to print the quickfix lines to standard
> > output. It can be used with M-x grep on Emacs.
> >
> > Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
> > EDITOR="emacsclient" and EDITOR="emacsclient -t".
>
> I've tested this version and it addresses all of my previous concerns,
> thanks for working on it.

Thank you for confirming.
Your feedback has allowed us to refine the implementation.

-- 
Yoichi NAKAYAMA
