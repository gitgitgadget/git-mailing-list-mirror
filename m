Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5976C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00FF610A1
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHSR7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHSR7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:59:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C1C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:58:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n6so12864476ljp.9
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acesquality.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=g7xK//Udkuqn6w99FN8sjjJm+Gcav1fkpzSziOIDpsw=;
        b=Y7qVqG6zdDY5HSZXmjUoqGkuGNpzgCWHKkRQKOpuTWuLEbm0tzYfFqWZ377YnyQmGO
         vTwEiNMZVA8LJ6dhKRqsf1lqwi9r4sOZ9ERwelrN4BIkXtPfprDVXwgrny/Wh5DBI1Kz
         Acgu51ZNDqoqHjUQCluULp/sl/AjCBXsL8iDpnCJlVyh2o06huzCzBm1hzYRbibUA18Z
         Zw3tTUDoeLdkwZPfZAYnm7ifcYhnOawjSmpCGIkVLDpGjIk90Sbmwh9dAR9WUX5iTTx7
         nnuJyaiRTwao1vB3nQhbf4M1K4K3wCkSKEd2xvKjqmy6Hj1wWEPM7gEZ6x/LaFq8TdL+
         j1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g7xK//Udkuqn6w99FN8sjjJm+Gcav1fkpzSziOIDpsw=;
        b=qhfs1F37PcG7Ky0vKxZ2cRfzd+G18MsjYHf0jPuNVU5S2QtksAbhGOKHecBl9mVlAI
         /aMPMmPhdfnOu5PhlUPJ7usF2AaSsDuw4vv4Vs4UyPgLPO/ZUruAvD0rBetfreDH1ljR
         f2ow+DegymcZ5MRIc2jEcXUeXRct3eBY1AXAQPWBS/g1uyzzdjJJWKXmluqYuXgVQ9Z4
         V6CGgNOQGrsAP5Hb4Xy7owEBW1mejdOGitkDbaWH6OO+BJcIVg4UH1NrhHWKsNQOo9YO
         49Vcz92pHVBAoyOI8rgXolgMZaTmSwi7TCjZLhX4Khz5QLRSzrdTuNjhRJfoWmH5B7oe
         hKRw==
X-Gm-Message-State: AOAM531u/gWyZIqiADmwXoccmxJ6KC5Ff8YXshtDQzH+5LrCdIcP/OhU
        H4inAAc5BcXCtFvZ1bmDYx+yyGW6CNq3CbnMRbuHk2W2jmqNAA==
X-Google-Smtp-Source: ABdhPJy6ir0bSkN5njtRTBoFKsYLlKfhn9ukjrxOKvUDyiPRlRLkefnIxSGgcfZACG3S/YNPp7LAcxo2wAbHIEwWD/U=
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr12852863ljm.11.1629395922087;
 Thu, 19 Aug 2021 10:58:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jonathon Anderson <janderson@acesquality.com>
Date:   Thu, 19 Aug 2021 12:58:30 -0500
Message-ID: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
Subject: Git Modifying DLL
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm having an issue with git modifying a DLL file and corrupting it.
When I download the original working file, it has a hash starting with
8FE400... I then commit the DLL and push it to our repo. When I
download the file from the repo, the DLL can't be loaded, and it has a
hash starting with E004FB...

Opening the DLL in a hex editor and using the compare feature, there's
a single change to the file. In the original, the byte code starting
at 0x0074 is 2E 0D 0D 0A 24.
In the git file, the byte code starting at 0x0074 is 2E 0D 0A 24

A single carriage return character (0x0D) has been removed, and the
file size has changed from 260,608 bytes to 260,607 bytes.

I ruled out the possibility that the repo server was doing anything to
the file because I deleted the file in my local repository then ran
"git reset --hard HEAD" to restore the file, and the hash had once
again changed to E004FB...

OS: Windows 10.0.19043 pro
git: 2.32.0.windows.1

I have no settings configured for git behavior handling line endings.

The original DLL can be found here:
https://www.powershellgallery.com/packages/PSWindowsUpdate/2.1.1.2

Navigate to "Manual Download", download the nuget package and unzip
it. The file is PSWindowsUpdate.dll

Thank you,
Jonathon
