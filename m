Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D802D61130
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbhIHA4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhIHA4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:56:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDFC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:55:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e23so1368651lfj.9
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg21mH2tJCXu2wMzamnAYphDPqPu2U+AjbRagz3V+m4=;
        b=fsD0Ly+EM+ZXMentQzSi3Awdfv1LgcbZKVc0XvBmBgPUNvskkSeaHcVCBeelST3cmt
         GmCVFC3ig3bO+LetOUZqlN+OjnabVYdgPm+Q6f7NIs0r0HgUdJmiKpwuGSupRtRhGx3N
         aWAvZM0/4xJzygv7ArU0DwGHBzc5U8Xjf1mA3tp+9n64rYBg/sJ1lc2XLcwo42hNaLg3
         9JOpbWwMxlX4T2DMLQ6JEMjmpZt7W/jYSt8qS7gvjIq8rq/cjoL/HWZw7hOawnHFIo9B
         FuswbeFYCvbmc5UnI035fukacWnqpwi/X8RfIuKcoRdxQJxqFz5pfT2OtivUWiHHdPSI
         1PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg21mH2tJCXu2wMzamnAYphDPqPu2U+AjbRagz3V+m4=;
        b=RGQFrX2XJMDhl1UUgnxo5W2t7sjEhN1tP3ltOog7+4ABRbYoSz5Z5VNtlPjG/MogBu
         9LF3H1CSExHz7m5KOVV+3y0w0fFIhBUPfotfkr8ZGyaJCb8OggRBMhZegMzEBy3wouvS
         4mLhYOUI/gEVdgxwGp6LYNzYrn/4oFmmexc4+u2trgJGuXZ/LDAk0w8ypKoSxaf27xjm
         7Po7zpd806fEmhJm3RKn7AH2fa9xh35x2UOuJDZ++A0DQpUJJ8BDZP0EAQ+YXLrIi7km
         xsfcUqQrriWaPAXNTu6t398MRItaCFqPlZ1Cyuv9UGrL/lW5xRFgiKoNn0+jlv2eHUzv
         ziWA==
X-Gm-Message-State: AOAM531Uzz3A9iFqQBfhgjEUiGL9Nl2jESyAVlBiMs9th+8KPmp7EkOk
        G8lN/OIuPOqTdnnXS0Douubx/SnTDRTTRAMWeyY=
X-Google-Smtp-Source: ABdhPJz+Da5GeAiAKfZJMk4uXI1XpMN1CduesvrK0vCK+BuSQcCU8LCgebWlSAjnSS1JOz7EbaR+A8rlBjgwbleR2Ig=
X-Received: by 2002:a19:700b:: with SMTP id h11mr781242lfc.180.1631062537676;
 Tue, 07 Sep 2021 17:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
In-Reply-To: <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Sep 2021 17:55:29 -0700
Message-ID: <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 12:44 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> Hello everyone,
> I'd like to bump this review up in people's inboxes since Patch V2
> hasn't gotten any traction in over a week.
>
> Thanks in advance for taking a look,
> - Neeraj Singh
> Windows Core Filesystems Team

BTW, I updated the github PR to enable batch mode everywhere, and all
the tests passed, which is good news to me.

Thanks,
Neeraj
