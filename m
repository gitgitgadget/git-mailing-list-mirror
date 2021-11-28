Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429AC433F5
	for <git@archiver.kernel.org>; Sun, 28 Nov 2021 08:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhK1IDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 03:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356121AbhK1IBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 03:01:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CEBC061574
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so8337919wrw.4
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 23:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4n4vSMdFvC2D9rPfuHtpZQnTH4nzBNFPzJHRBbUyK3M=;
        b=bXSqTKY4Ah1mwQfZ7ooxA0g7oIqUtNlczp88qnTpIA/JZfx15UztwBsjKvBznyUtGW
         QPPG++YUjYnpRMYNtHpf7xfK9glkJ7d0AeBor2lke+2qS7E3q1zdAmYJenzr/Y7wqYfN
         0e8+U4mz6aSNpT/WLFsX3qaMJrrZyVQW9glJJAq0rp/yu/1/TwlKf02iQauZdrHbFNNk
         vLUlFj2jUxeMhAB2025AZS+zh8a68eM4wY4ukMMDnuroWlbTQMwYZS9NDRStvOQf2HjO
         2uPQdfQdykP1raUOCsVKmmBJ7Fy6vQ3ys9yc4uJUriHVIdN1A/tmz/CJaH9vRhLTKYUK
         MqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4n4vSMdFvC2D9rPfuHtpZQnTH4nzBNFPzJHRBbUyK3M=;
        b=xN46J9beXO3OlqqWdk462zObiObmVzX9hkxpprgUaeVkUlZcUM+IeC8oGjvJG5AENf
         fLMmXe5eSAPqlToxE4Lf2SSJV3c2ywPSoZaMUffRHLLwns0oYGPvB8UzofjIHZR79NLX
         p1Rz8nJ5SgoXU2adnwtkByfY/y3+dnmt5gL+CHwVcSumT2tj6REhE1AFX/AaCTcNYyc2
         aO6GpOb0iSt6zRAthc5mrkbvhaP0pMNwStHYIXCVpcxEzd5Usdtf7EdUp5qZf2aW6vXw
         55raSFn/W0PT2NQWCvJUCVZZBnpBYDonQiWiiPBSRLt7DqJqcKH3biGdBEVW5Mkjsx1r
         burw==
X-Gm-Message-State: AOAM531o8LugWoFsjKkDo/MTTD8jnIt4YnH2k7L0ZvpCKqLkDTrME1hv
        irAbhM1TMTUWDlMdvl5tBs2/8DrBF0A=
X-Google-Smtp-Source: ABdhPJyQW5CIXPpqPcrjaGHC+ILnbncRwtxRR/zrYOAdQ0Z+Xp7P6+7xfo1rIzT4KkWfHmwfC/pucA==
X-Received: by 2002:adf:ea8c:: with SMTP id s12mr25222225wrm.535.1638086316552;
        Sat, 27 Nov 2021 23:58:36 -0800 (PST)
Received: from lesale.home (194-166-82-161.adsl.highway.telekom.at. [194.166.82.161])
        by smtp.gmail.com with ESMTPSA id d15sm14271725wri.50.2021.11.27.23.58.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 23:58:36 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH tig 0/2] Allow to toggle revision filter
Date:   Sun, 28 Nov 2021 08:58:16 +0100
Message-Id: <20211128075818.981790-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I submitted the same on github but sending here to see if there are comments.
These patches remove the need for starting a fresh tig in some scenarios
(nothing wrong with that but it adds up)


