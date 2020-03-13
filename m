Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA0C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02C6206FA
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRobhmYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCMMGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:06:24 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41171 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgCMMGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:06:24 -0400
Received: by mail-qk1-f170.google.com with SMTP id s11so675220qks.8
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6jFkbO3t/UtzJMzrCuOQl6Oop5ihahHy+A3oF7s6mws=;
        b=mRobhmYoD9FPYKs7wFjA9aZ89jgF2O6KdMaSTxP0lmraWsHV4DkAqd2CiwmB1FZTt9
         LcO97xic9eCh9BstBVLRl7XOEbc4AZ7EZV2l1+2VtnRUI9kx1fGOy0BldyIpwjSyPxP+
         GtDLu6Yhia5pGa/YRTCbhkBVNXBRA1dVrSsVl6l0w8ko7IdM3xJJRQBKVm/qy7xQoedS
         ReQCpJFdiYzPEG2veIHiqGJS4jiOyP7ukMQpYK7VW6UBer94aZnVnOPNlxi5kTGx8uTD
         D92K0TSk+y4scgtawhlsLWo5MYDwTPC/qUOX2E3777IW0KgcGUUdBL09x6bG86sKPuEk
         omzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6jFkbO3t/UtzJMzrCuOQl6Oop5ihahHy+A3oF7s6mws=;
        b=W/QKcQ2XF1FTV8THJng8cEZyu/Av4sgpXhi85TSk6asOkeCGLtdVYN+PBPJEjtqCMP
         wvxQODQ4WSqNF2z0L+r/xeTu3QLrVW/Kl3I+nOOLF9RYaf7edyeBLrrc2FNvJRNLDrKz
         00rdvhaTptV4r9jWX3JROlKkXBoChkRSAh6WAeW61I9buuMQmFXfDPTwCzmNg546Gczg
         DQVDRewcy2s8aUWiOZ31++Pc12rtpHdZ1sQIPd6woVo0x3twv7wU6Fbj69pAHqlhL3q6
         3yWmUfauzWduweU9z4ADSgGcJRrjCUBYKB1LqwQZuVc/mLxPv59v1N1uHraXwEmWh0Li
         +OAA==
X-Gm-Message-State: ANhLgQ3t+dxVjU9I2N6/sL7ZpYH4sScZcFGIva+g3sBKBwlD0zMv6Qvn
        AO4coVxk37Y4jLriyJbknprlGfitUBbPXJiZrbMscNUgyvU=
X-Google-Smtp-Source: ADFU+vuydmt61vV79JlpeoI9Zba5ao85sNDEQTJqjdkjxI44+cfykquDON5ii7vkgmbUIUeuxCF1q03E/ND8HBSoVdA=
X-Received: by 2002:a37:a1c9:: with SMTP id k192mr10804411qke.385.1584101182502;
 Fri, 13 Mar 2020 05:06:22 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UGF3ZcWCIFJlZHp5xYRza2k=?= <pawelredzynski@gmail.com>
Date:   Fri, 13 Mar 2020 13:05:46 +0100
Message-ID: <CAOTQ0KvpO5iVFsMqz5WPZd8uEd9_SRxQvznvEEB05jnTTWXBBg@mail.gmail.com>
Subject: Question on case insensitive systems.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I noticed that check for filename collision on case insensitive
systems happen only upon clone:
https://github.com/git/git/blob/c522f061d551c9bb8684a7c3859b2ece4499b56b/en=
try.c#L499
and
https://github.com/git/git/blob/c522f061d551c9bb8684a7c3859b2ece4499b56b/un=
pack-trees.c#L445

 What if collision exists on some commit that is checked out only after clo=
ne?

Is this behavior intentional (eg. for performance reasons)? If its a
bug, can I volunteer to solve it?
Best regards
Pawe=C5=82
