Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2835C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983B2227BF
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuSLMoAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLSKxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:53:50 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:32980 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKxu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 05:53:50 -0500
Received: by mail-ot1-f51.google.com with SMTP id b18so6762405otp.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 02:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f2nb2WUGUuRYLAxY71Fa/1qKOVsKg/tBjE0kdJirSDk=;
        b=MuSLMoAV1CRLD/BB1qUcY21UGqg9FJ5SGUmBKDSuTnmGo6aYuGEccKWERo7ZQN2dnq
         Ge/6WrD+PuJNXfL13qzD1wYCysuV+iuZ+MSzHWT81FqaxZEQqBFKyR+AETIAgC6G/1t/
         yBevdVyMFn23Z/OVhkzpyPPf6uhj360naVT1cPDg7Xi4PqwH0RjRyxzhkGt3neFCJ+WL
         ZaUihiu/ap00Cy2kDyPTaBlWI48/tG8WieF3YLwqbnNjW5x4VzUxRYp0mm7FfziNwpV7
         Io5scbiFa4FeiJR2+SBd4NRBpe8cEQx0fiVPMIW9fO8/bmXdFMIjLgtUi3b50biO0xxj
         pvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f2nb2WUGUuRYLAxY71Fa/1qKOVsKg/tBjE0kdJirSDk=;
        b=J8t5OXBwhJdqaVgFpw9VnNP/A7evN5L7nE5LL8krrE5Uzrf9dBoIdelMRS0AUfJ7gY
         SXGuAWU52dFouCqOxqZcut7BxRK4ZOeDajTFSfp9tmRx0m1XGrv1r1vA2IF/SvnOIJdi
         rkpxNT4q8ZNO8qPuCd4fetjZ725pMf4rBzglKcYGee+lf3+8xBOG5OMuXulgJcUP9+sh
         5mWZHxBSlL8Y/dqpqaXcnuIYCHKV5TMhNULj/wGt+WSGPxnUtWEVAcIVOlO013HY8+LE
         HVoLAWBEPzON493ad2cnXA4mSXqJ/c5p5vrAfGOXaLAgNOfXBuGNb9tiVajSsPa08J97
         62zQ==
X-Gm-Message-State: APjAAAWaFdwQbALtqJNGlHHdHbDLrQrwMjji/LBRPaXbh61IdOUJzHvE
        pNhgUEIhEDts2wx0Ha49uAlRuFpW8Q/TwKYP6Cdq4ufJ
X-Google-Smtp-Source: APXvYqz3Mfcsapal5Rvrz1eFOrMlKGEfAsDQP54lnrMWRZmxVgOopmNR3m107juNpEsO2+Fbsz+hfOPdu3UsHKl8diA=
X-Received: by 2002:a9d:70d9:: with SMTP id w25mr1000637otj.231.1576752829386;
 Thu, 19 Dec 2019 02:53:49 -0800 (PST)
MIME-Version: 1.0
From:   Insane Sharpness <insane.sharpness@gmail.com>
Date:   Thu, 19 Dec 2019 10:53:34 +0000
Message-ID: <CAMNO-Ba0-Me67qEEfHoJyBoWg0X_x7=qmmZ1D8ZK9S_0Tk=J5Q@mail.gmail.com>
Subject: New Git Visualiser Tool - GitVine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey All,

I made an application recently to better visualise git commits on a
per file basis.
And added this to the git kernel wiki here
https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#GitVine

Does not try to compete with more feature rich & powerful clients like
Gitk, Kraken etc..
Just tries to be simpler.

Free Standalone & runs on Windows, Linux & macOS
Just needs git in your path. (Developed using Python, Qt & packaged
with PyInstaller)
Project Page Here: https://insanesharpness.gitlab.io/GitVine/

Its still a rough cut and loads of room to improve + add more features.
Please try, would love to hear what you all think.

Regards,
