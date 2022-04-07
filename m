Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E686DC433FE
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiDGV1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiDGV1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 17:27:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B519C5A7
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:25:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so11830606lfa.6
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1j8YKt/h9Rk0L9qZTq4DDXLJGZP4Gkpg8dtL1ldjAdY=;
        b=qQbkV5KwtemcUAncte4mXnAMGIrIsFmeP/v68FHQV1kzn7D2yu+Yddnx9jXQ/rP7cI
         dxKM3KUT0iXpvzckwXEOOpQF6EwfORQJuxcoEggZoFfbF8DK0utnLjomzkr9jWZS9inv
         GFugVE07nrBiZuNqi/dhsRhdao58DEEHuAylrDGIyKhMM0tyJY2GloK622y1sQkp8xCL
         w5a9l1naD5CcOi+6m/wOazVIwp3ZJGI9KVtGWb0IlkXV0e1OWlvbCmrjuPBNEBPZ49Zh
         BRUL1CNcmugCj4DyiY1fpKVUjIXmx7B/n/SuL2jbcE7jx74OxnKsEPJ3CfaO31YAOb9E
         PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1j8YKt/h9Rk0L9qZTq4DDXLJGZP4Gkpg8dtL1ldjAdY=;
        b=JLbF/tEmPKvjvGdlp9HU5uF882jAz911R2iyTGXVsd2hm69JIafa17ToGrCfykvV0q
         UDUjeft9RbVfGgd+zprKkNDnStM5B/FI7d8+ScDTzQvKbkq1YsKRMzamoquz+00SAivK
         2xpGUHrzKq2b6tC1Sc+TGkdic1oLAMHuuDDQoBCQMUNdxBbhVZrH+8WZxSH+xXpQS3ua
         wHCwHj+hKhx7cE1GbdyQFvtni7S6DhpiY0h5Fa96wbSQRlh2cpwIaTwk6lrhloHbTGnW
         G4Jwqov3suWb2wC97WXrsvX/ewPj36+Mr0XJ1CWr6khikznkRSF2ymrESrV1/VnlPKVq
         a+cQ==
X-Gm-Message-State: AOAM5312R8oaELzWQLTlPAxkRWtbo8t1U47VgVIhUU2s3N3BjA5Oizw9
        G4btId2MZvAmRKxm/T+dlkVELTY28A/vqym8bvc=
X-Google-Smtp-Source: ABdhPJzVcVYrAugiAhMGvkzmEtdxUVWstnOpp5vaf+SPj4MtCXcmtrmnZjfLIccU8U89lxK8LLcyw6tXMexhF+hRBT8=
X-Received: by 2002:a05:6512:2811:b0:44b:4bb:30d6 with SMTP id
 cf17-20020a056512281100b0044b04bb30d6mr10785830lfb.686.1649366701484; Thu, 07
 Apr 2022 14:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:a8c:b0:132:c9bf:ceaf with HTTP; Thu, 7 Apr 2022
 14:25:00 -0700 (PDT)
From:   =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>
Date:   Fri, 8 Apr 2022 01:55:00 +0430
Message-ID: <CANv3_vrwtknWqO08=cVBFbaFU7hzia8psgr1mCHN2RsXWMPmnw@mail.gmail.com>
Subject: =?UTF-8?B?2LHZiNmG2YjYtNiqINmF2K7ZgduM?=
To:     11898207+NAQ1S@tickets.livechatinc.com,
        =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>,
        Cmail@gmail.com, freesupervpn@mail.com,
        "GearBest.com" <newsletter@edm.gearbest.com>, git@vger.kernel.org,
        info@bischoff-guss.com, M@gmail.com,
        Mapbox <newsletter@mapbox.com>, maskvpn@hotmail.com,
        media@campaign.who.int, opencovidpledge@gmail.com,
        support@alohabrowser.com, support@zendesk.com,
        ytandroid-support@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2KfZgdiy2YjYr9mGDQo=
