Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7A1208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeG2RRg (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 13:17:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34223 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeG2RRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 13:17:35 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so7046259ith.1
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ebw9phf06e6IONcwbQQgr5X7PsBiV9JkYOEaoqn6OS0=;
        b=Ojqd0SCPyI+M4aDRHSYM7dxxmZ5N9di3VPVY+KfcoB71o8qcngqDG+Ur4uUOrJNcMW
         b1TMNN7rKxBYfSL3osiUZ95WiJ063eUgsA464PTE+ExGpwhRXWmXA4styxZ8oNsJb8LK
         mDTlD0MNdgOvPQLCP78URAlXG7gC1rbUCIYE5nKV342Ims1+ZEJOTcBuc5a336yljVIM
         tfKpWc+8YKN2AD9dnMd5layFhdOUiRfxyMRs+0qxau00RN5XTKTFvfZzM4ta+Dbd+0FU
         PEY/v5qdLjrkZ1X1kXy/jEmpoCFPVrvHaBr0bqhT79YQU6CQdH/ZNl5T8Ro+WpmLBpht
         J7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Ebw9phf06e6IONcwbQQgr5X7PsBiV9JkYOEaoqn6OS0=;
        b=qvPlxRMifym6PZCWdAq4fnPZ+G01X467IE2cyC+GeAHeQGAb+sKdjlYgDYQr3/b60F
         3et4YKQ9TwfiRKQ1QyJqbPGVA0bq2Y7gfgAYXS6lhtYS5WuPtIp2mfLhI6fUYtLSzbS1
         5f3gG9EEiXmjJFiPrp1LbJ1b0k36IwniQ+Gr49uQRbcJInTgP5tnviiUo/72jaMxt+LG
         t2sXYj1NiVSmvAwz4Xead7Ht0aY9eWYOKrbGchnJHI1OhMmiVFb0+H+/W6hhmhylTnQB
         gJsBNQVvUGgCi4LZRDoQx6MiTjpaDIXIuMCTKV90rQLOXIgDgY+5ZJBk/qFvhFPVg4Vp
         QG0Q==
X-Gm-Message-State: AOUpUlHfjh3JeGfaFrqVkYV8jT0PbQYiZjKKVwjzXyhFPnPmR3qbp8NX
        jKRdLP0/GM+ag+dBFTLTKtBGxgEmcUc5QBgYB3krkw==
X-Google-Smtp-Source: AAOMgpe9y3p3JmqWdQWuCMEB3JTt2c0qCoDpuAwx8BfFlgMe8I2mHNTJpACxCUfeL5k7s8sTsAqxW/J5iHeYL0uG9r8=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr12491967itf.78.1532879203698;
 Sun, 29 Jul 2018 08:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180729153605.27298-1-pclouds@gmail.com>
In-Reply-To: <20180729153605.27298-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 29 Jul 2018 17:46:17 +0200
Message-ID: <CACsJy8AKHo4g5607GdiuLVBy1746gEEFbsYjB2RLwvQvE24Sgg@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: document about thread synchronization
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tOn Sun, Jul 29, 2018 at 5:36 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
>
> These extra comments should be make it easier to understand how to use
> locks in pack-objects delta search code. For reference, see

Side note. I wonder if we could take progress_lock() less often in
find_deltas() to reduce contention. Right now we take the lock every
time we check out one object_entry but we could pull like 16 items out
of the list per lock. I don't know how much actual contention on this
lock though so maybe not worth doing.
--=20
Duy
