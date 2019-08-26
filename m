Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBAB1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfHZPVx (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:21:53 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39138 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:21:53 -0400
Received: by mail-wm1-f49.google.com with SMTP id i63so16265765wmg.4
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1xzPpmpTseWEiQzJ9mgWuRXFYydkPEJpTNCqPommdxU=;
        b=a79YPCZOQAc5DciNdBiVLrnUYcz3J2zUTBKn5XjNUHId31jeeCk4LuV3mC3OrC0Q6h
         496cSn7aXFzu9Zy92sFRCVfMkMiK2fN6HCTgc9O2xfmgDms89SPmvB2m/oOBA8zS2UBt
         8qX6FpVZBAu92l+LOIWWwBSmwn6qv1CtzfNZnuitL9KqiUEOWLR8nLdPXL++8r4tdct3
         8qR6eW3cIuFZJKsQosafgFKNRwfWpKgMQHLEoV1kuZ1wTEYMyEQj6bj0hSKTo6c7tT6q
         8Z1kH/wejMdHCOKxwlbhODAlRDLUeSiTpU2avq/r/I5ow++BnsUPRFAUhIMNRrI0lHfZ
         8+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1xzPpmpTseWEiQzJ9mgWuRXFYydkPEJpTNCqPommdxU=;
        b=unQl78aSwdJhYPUHd6eeRSu5yhgS3vyXkzmVAi4078G5u/vjK9Ks5hBb4uFDcdj/jN
         A7AkG/z/a1oWOcKdDO3QLLLn37WH7Nxj2mvpUWWO89hpLSopIVieY0hu8ufIUTUuessP
         gGfSGdEf2LqQh0ovD5cNA8hy7Zocxd2AirVZxEPG+jAOTsInoixIw2vdvxVkYK4Eh6r2
         ocyE6jFOqsu/7qjnOuAvTCFGn76kWGLe3+17r2A74dokzCrkjVKHi3ix4H7Z2fjmrq2J
         18yD/8bZrLTolyYVDqIkBFLCES3Nz75EoM+FG+jB+bMTGbifX+XgLT4FrOFkobhj6Wr6
         +t+g==
X-Gm-Message-State: APjAAAWrGHMmRUxK4w4onTIuVEehpc1PZnYg7VYEC1WDgGr2l2PV2Vya
        yPb/5GXZXOpUeCEeFNj50RQt9UFh0fM=
X-Google-Smtp-Source: APXvYqwsAxlatSlrpRrcsHNiJzjdOZYYNQmORTRfbHZcP131nDPRY4lZhtxwvVCRkmnFD9DLY/isVA==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr22779013wms.141.1566832911277;
        Mon, 26 Aug 2019 08:21:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l62sm25245033wml.13.2019.08.26.08.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:21:50 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:21:50 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 15:21:48 GMT
Message-Id: <pull.322.git.gitgitgadget@gmail.com>
From:   "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] banned.h: fix vsprintf warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously sprintf was the argument to the BANNED macro, where vsprintf is
expected.

Andrey Portnoy (1):
  banned.h: fix vsprintf warning

 banned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-322%2Fandportnoy%2Ffix-vsprintf-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-322/andportnoy/fix-vsprintf-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/322
-- 
gitgitgadget
