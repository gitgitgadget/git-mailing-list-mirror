Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2791F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0J3D (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44665 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0J3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so6361261edr.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=US9CgrfJ9h5hlnGhhlj2TzAVDbjynVV74eJEyOx/DsE=;
        b=J+RPuYWDHZu6GbSitXYbI9XKXOV1+f7lttg30VYYZPwvfGvsCnF43jbnu0UXk/aHvA
         V+tys3lMHBsuGHnUOE/tn2sy6/xRWw77nYRdXrYaeKfnAnYtnlpiyiPzOHMOVipCvRT9
         cmdW03vXhtgvQ7vms4WmxYk83pxe6swEw8osdsyY46F9kTrz/2hKkmQu8JP3UKqkZthx
         I/O9F+o9VU8hJx0OerMkoZze9m7TTW2cmNuh6buVEi73MbV8RV/yQLm7ftvb0BqYVA8w
         sBerUFH9sgS0DPSeRNHxYdLXCY3u3fHTWxwgL+pBHo6F5w1NOuygaMPytWhYCk0FNhAJ
         tuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=US9CgrfJ9h5hlnGhhlj2TzAVDbjynVV74eJEyOx/DsE=;
        b=p55D5IiSsYfz3LXgzfORJweOf2D/tgef1RywCUSJhP1gL47nthVG0XuefxBrvM/5m3
         P3vgJNZodITuJtHDCMmA1w7UNhlIPPZBgUHtLS8qiysp39JDudqu5Q3hjdeE40MIBL4b
         I9agk+oJtNDsJjsaYaCliorLkfovjyR+jwERWDPMp5sz52w4WECHm7Sjb3c6Xsxw7zd0
         xlGmjSB4AMu3s/SqsW43drXiG9dVqLEmuC/xOYoTffZaOlWXMs/TRRYtdCDVjdYiG2uc
         QiGUaz19anWGn2tqHv7DrGZV2s2zgxRo9WId2KM/1eUPMzoAWXH8vDooWfjK4YFKBH8B
         MNfQ==
X-Gm-Message-State: APjAAAVulz6mTZ7BksfsrIR1SqLY8rMBWUn8DojA16UHizyMrSgOZX7h
        Q9Nr1sf581av7Lrk6u0wYJkUK0tp
X-Google-Smtp-Source: APXvYqyzDquco/YlRlo7dVOu3VuUGXcX7T/Yxtt6wilrVSXUZqU+n60PuY41zlrS0Wp6FTmrnfMfuw==
X-Received: by 2002:a50:940b:: with SMTP id p11mr2922139eda.194.1561627741740;
        Thu, 27 Jun 2019 02:29:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm320137ejb.36.2019.06.27.02.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:01 -0700 (PDT)
Date:   Thu, 27 Jun 2019 02:29:01 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 09:28:59 GMT
Message-Id: <pull.215.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: enable GCC's stack smashing protector
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

Recently, I managed to upstream the Data Execution Prevention/Address Space
Layout Randomization patches of Git for Windows. Now it is time to add to
that by also enabling GCC's augmenting feature which reduces the attack
surface even further.

Johannes Schindelin (1):
  mingw: enable stack smashing protector

 config.mak.uname | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-215%2Fdscho%2Fmingw-stack-smashing-protector-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-215/dscho/mingw-stack-smashing-protector-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/215
-- 
gitgitgadget
