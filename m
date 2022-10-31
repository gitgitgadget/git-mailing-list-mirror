Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D6FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiJaPSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiJaPSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 11:18:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E5B1146D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:18:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hh9so7565720qtb.13
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUefQ6gEdlcsPXgjBhOUfUYf7vPrNL1rLA9Pqyrezn8=;
        b=Upyu9rkE44hTeBH02SJ66f3wOAYTKTTE0XE7p57cmRXptshJUcHK46x5vrmt3Ci8RD
         Q0IruU7cuAgfef0YQ6PATnFBG2DllqjkkuCow4GYFM7WzdVQ4mJOKRgZ9W7QyK+GgICa
         SrT9kSY5mHxgezkOmR8OxtHg6Aj+VAKND/Ey6+xxeeh1W+38GClCXPhju6ngO/sCe0Eq
         sp2cZB/OXumw2gutegJPHyoUJY4xfP0qYdYbNYRCfFeN6d8D+Izy2eczQRQaEHKRiujY
         RoAo+BWhJT/zy0lpZTLswjCEgwFQT0+/qeDgYmySe0tCtRj4cEKoo+/svT1otVMBlTGz
         xj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUefQ6gEdlcsPXgjBhOUfUYf7vPrNL1rLA9Pqyrezn8=;
        b=uI8yUDTvDavl5hCqg6oFOCET/HGChLaKrNnrzG9FVT56eyFm9wwKDSL2W6wPiHtksc
         DmMPl/mAd3Dw0qjYVzQXlnkUoAA1C3W/eP36X2tEwa+Qtf1qYOFVsq+fVZrqNTyOIUQe
         BvmKmlgscY9oZ1ADOYbbDGJryoz5owy303BJ69LkMKgu/CCvT/zNRXANh8m6H9uTtu6x
         V0/bf/3OxlLuodL1eMQn6tibiiCkeYhcGpgN6qZwTnGX4tD28MsyVdeJ6Es6NyA0SLU4
         Ho7SL3UlTlnDVx8ALQ91GfQoAT7gpjvW8s4iQpO9PMh0OQSKBvWYy++hsVafIOIWH0/7
         Kigg==
X-Gm-Message-State: ACrzQf0A9yuMLo+keoYbylYykL58BmPuOLPU8t6nazajK731CHL/UwPT
        e1zxKEki+bywjedfqQOEYY7Q/EM2jiQ=
X-Google-Smtp-Source: AMsMyM5iNRRROsbivonVvdRO8u0tFY849NWy6fNzkatAfdV0vRJ8w2n8QnaK5GG9QQG9ONEP2t++kw==
X-Received: by 2002:ac8:5f14:0:b0:39c:dae5:35d5 with SMTP id x20-20020ac85f14000000b0039cdae535d5mr11045738qta.312.1667229519103;
        Mon, 31 Oct 2022 08:18:39 -0700 (PDT)
Received: from [10.37.129.2] (pool-71-187-159-144.nwrknj.fios.verizon.net. [71.187.159.144])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a241100b006ce7d9dea7asm4188965qkn.13.2022.10.31.08.18.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:18:38 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     git <git@vger.kernel.org>
Subject: Large repos mini virtual meetup
Date:   Mon, 31 Oct 2022 11:18:37 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <4D2B0F7C-3ABD-44B0-BDFC-D5960BE261DD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

=46rom our contributor's summit back in September, one theme that emerged=
 was the work around scaling Git for large repositories. In an effort to =
gain shared consciousness around the problem space, surface opportunities=
 for cross collaboration, and deduplicating current efforts, I am organiz=
ing a mini virtual meetup where we can share about common problems we're =
trying to solve in scaling Git for large repositories.

Anyone is welcome to join! Here are the details:

Google Meet Link: https://meet.google.com/zid-azpu-apa?hs=3D122&authuser=3D=
0
Google Doc for notes: https://docs.google.com/document/d/18Mh6WokkSb3t7xe=
LsTdAUrSd8xfxZ4Myc-X25sG8b1Y/edit?usp=3Dmeetingnotes
Time: Thursday 2022/11/17 11am-12pm PST / 2-3PM EST / 8-9pm CET

Thank you!
John
