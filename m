Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFAC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 06:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiHHGQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 02:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 02:16:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26826FF
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 23:16:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p18so7656235plr.8
        for <git@vger.kernel.org>; Sun, 07 Aug 2022 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=q7VfuL9NF7BDOwcVlnNQnl4pX/svesUrEldO/6Igfzo=;
        b=Jt7NTUxsmdAYWxh6/MWTa72WItb5/JzyHrSfl+0ODUxOsFUFppjzcXzbHuhlt8PhXn
         CEr8offGXREO6s3R03bdtJBZmT5NEY5PhUgFx91DhncfDdGz9V4gFmP6tetAD7c0kk/Q
         4rPUocDEcubipNiMXtjoSQOiEsarIlS6LnivxRJnwGyLwqnQpKPRYCuFLHEnZTgkoeMp
         QQE0v49peTNIGPOQVyIFvf2NkoXgGFEuJBj/UZasCl09QFbXYNYlYiKph9EziAhF0iq0
         /uFSKX20mtFwF1JZKLN9Pqj1gu0BwatRMpMIjWVV8AIPZr6inHGBC8LA/ilf32xW3mmr
         Q3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=q7VfuL9NF7BDOwcVlnNQnl4pX/svesUrEldO/6Igfzo=;
        b=VtUjs5H83RPZKbFuS+hPb00gGwsDRpzZcdh+0h1mAsbMTF1pbBKuCgOdh/6im4WGjN
         Lxmmc2QAQP/1RLo6WzwRPMMJx4EVsEFlMwi5T2PyoJGeHFqxe1FJG9JKu2yckNb/Z00z
         fpogJWstFsIFWr6qcwfahbelHHMYlmGWCx/iVHVWaLnuksnpqE/7W29R1Es100GKNrnb
         yf0Ng9Wg9Fz3lL4bOy3pP7JrEZgzc0UtZzGBNWAn/ycd95v4BmtjHNp2k9+XyymRfo6X
         8g2SwJtKaNPPRH/A2xosAd/1oLkwntgMUicYT36xyT5CWHIbNEdlR34aIiYOq58I2QnU
         AiuQ==
X-Gm-Message-State: ACgBeo1BM1oGJUdLD1gTLAq7fORCdWDcZoy5OELydh2O/EUIYPfxLB57
        5hnTzp40nw2LS08mE72POHo=
X-Google-Smtp-Source: AA6agR5IlRXmCHurxl7WUrs99ctLxbkemc8xE4I0SAtbzvKEBENnOxqEdLgbvjvHXD7qvPJ6gXxfGA==
X-Received: by 2002:a17:903:240e:b0:16d:cc17:8f16 with SMTP id e14-20020a170903240e00b0016dcc178f16mr17284389plo.100.1659939402564;
        Sun, 07 Aug 2022 23:16:42 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.101])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b0052de09a38d0sm7764130pfq.2.2022.08.07.23.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:16:42 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@jeffhostetler.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Mon,  8 Aug 2022 14:16:36 +0800
Message-Id: <20220808061636.88692-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <xmqqa68iz5yx.fsf@gitster.g>
References: <xmqqa68iz5yx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> So, what is the outcome from this discussion?  It seems that this
> subthread on [1/2] is blocking the two-patch series?

I think it's blocking. I replied a comment to comfirm that I understand Ævar
Arnfjörð Bjarmason's suggestion and also there is an improvement change in it:

  https://public-inbox.org/git/20220801122515.23146-1-tenglong.tl@alibaba-inc.com/

Thanks.
