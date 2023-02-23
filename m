Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E0C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBWFlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWFlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:41:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639843905
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:41:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 16so5556495pfl.8
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/LF77AUFYOia2B9ePUciKpNqUz6GDoE5OZyiNoYSDI=;
        b=PrecEJQah5COkNc9GGXZ4QtYCXbmwvKbbBYt6Ea9vxWzE1AmUUSw09UiD0QR+DtbOw
         X4yUPRX7lJLLwdGY7mB3NwZS0vtYyuAioCrs3v7AFIYD1GjHEVvp7KqyvdtjfcHZz+5C
         KxeUW32Nnst5BtG5mhVx1MpuDcKakfQjO3kqtT3PZpsAXb1ddYW57K8yyvVSb3fFYUjP
         GdNbz0P5a3JWxDZNkntSopK2QrhxGKBVonQmuZMbZ67IGDBgaKhqUrpLpFVSzgU87b2H
         F/bMaeSZhoj0qfhNU49C9vxYckTBaY/AJ72kHmBDknYH+eHlswvUpMnEdO+yKnULFt8d
         WCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/LF77AUFYOia2B9ePUciKpNqUz6GDoE5OZyiNoYSDI=;
        b=gPIrw6nVQ0myvrv+bCgea2nT990bPBVzOjbSxniOKWdAbfb3NdGlwvUpcW4l3B5wRk
         DGyh246ijbM2jZerPc/hZCcPSrssKpx/X9ol9e/ubFuFDRRnPaFmruELlY5CtXOirkDa
         7FDh0oxN3+7U1Gc+0CHbiKIAf1zxd1pakmDvgzcO7y37g4JYfb2HdP8JoTUiKIwSR7es
         OMmSKlDnuw/FTav/Q6zc+zVYgPR2e1Ld1CdbpHjl1QSeQPKV58NeDXBDYmL71Eng0DMt
         41SGBo4n8EyWe3xblT+Vl2iMloGQQ5G3PoHk8COawQLs8pYzpOZ9qeyzseqAeVd5/Xwm
         qxog==
X-Gm-Message-State: AO0yUKXyKVSh6CqVDrtgLmXIS+Oz0yxfAz79NJU6qqptHD3DsKoatlnu
        vn/jBmz6d77yr6xoAJ1bICLRL/FN76jH0A==
X-Google-Smtp-Source: AK7set89t2lwUYhMGQ47i3MFI8wSWh0QYGp38P7WYk5tjlMOF1s/GFJfrbar8rmKAkjR9cWKG17zDQ==
X-Received: by 2002:aa7:9574:0:b0:5dc:fa22:1bd9 with SMTP id x20-20020aa79574000000b005dcfa221bd9mr648987pfq.23.1677130863233;
        Wed, 22 Feb 2023 21:41:03 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dgt19tzyticxhd.ipv6.telus.net. [2001:56a:740f:7b00:8020:1c0:b10e:fa81])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0058d91fb2239sm7157453pfb.63.2023.02.22.21.41.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Feb 2023 21:41:02 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, nasamuffin@google.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [PATCH v2 0/1] MyFirstContribution: add note about SMTP server config
Date:   Wed, 22 Feb 2023 22:40:39 -0700
Message-Id: <20230223054040.30088-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230222011317.97943-1-gvivan6@gmail.com>
References: <20230222011317.97943-1-gvivan6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg (1):
  MyFirstContribution: add note about SMTP server config

 Documentation/MyFirstContribution.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  bd9bc70307 < -:  ---------- Documentation/MyFirstContribution: add setup template for git send-email
-:  ---------- > 1:  d295b4d913 MyFirstContribution: add note about SMTP server config
-- 
2.37.0 (Apple Git-136)

