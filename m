Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277DC3F2D1
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F0221D56
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUnN873F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCAPsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:48:41 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:34578 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAPsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 10:48:40 -0500
Received: by mail-io1-f47.google.com with SMTP id z190so8863720iof.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vC6Twh9ih36/Rjwqt838HeUJ54mR811jMYKft6a/y4w=;
        b=ZUnN873F5pYROrwas1drTnva+j4A/2o3rOK32+MnH49edllqKaTZTBdx0QIfpYnWMc
         r5PJI0kANjqBmIXOnE5kMf+IbdZ38Rft+4IJpCL0ghChgd/g+7hIdh9//fW89SVSSKQa
         rKRQF5TiahGEF/yOwismVwsFX9K+PDIBg9kSvmXqJVPPhdLlBLhhMtPHqNBou3w1ARYx
         lCz8vYtjF4Ar7i54sm70ViLeElqan4v5mYtNwsNpqmqSNqDALwgxzY3DJ+3EYww73km+
         AKKfZBY9nCyIsM5d2GljC1OKW/i6h8O+PLaO0Aiu0zmTzyWACIxww6a1MKuhNvbXp052
         U0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vC6Twh9ih36/Rjwqt838HeUJ54mR811jMYKft6a/y4w=;
        b=VkJITqFUAhLFSLczX1vKlJA7YMK1yh7DmZwzzkGo7p9FMjxuB6DzWPhZpqKVeWiQkb
         As7rTcAha7M3dGaC8RMDbrdg26w7SdcDNfuCpW9UDSa2VM7WNLv5dPLk84773uj/FT4E
         HwAIFAvWwyohwef9+iEegkTMi9s7ip4rk56vcCSQ8KuQ7UIdndoH0ehySUd/VQLV37d1
         cPXNKcpINZCHYnFApRI+tmnFMcfSBxjMfnDRgnrxk3NVWCQ4xAi/nkdwlX03N6OqKS9h
         uyGv0GZNwDW7X+I/eOBtOOOfxP9QHWbHPj5k4IGHg+eSesCQLA0YOKxx0MFUTHyTs0/H
         6Hlg==
X-Gm-Message-State: APjAAAVcm2KlQr7xQzdHeohsz1q1gZsFL/u8etD/JPUvOtaTYj7drq6L
        qKV+lDkGqbZoShYxSCFvhlXcWxvBaNhRIoKszSEChWnRVO4=
X-Google-Smtp-Source: APXvYqyAK/rDWuIWIqgTDcd3LqtS5/KXZcPgM8WydpRaGroiSyUR2gAR6RoYU7X5pKXIRDZmaeg9c4zoKikJPHtZTTA=
X-Received: by 2002:a02:ca11:: with SMTP id i17mr10980708jak.47.1583077720040;
 Sun, 01 Mar 2020 07:48:40 -0800 (PST)
MIME-Version: 1.0
From:   rm techup1 <rmtechup1@gmail.com>
Date:   Sun, 1 Mar 2020 21:18:32 +0530
Message-ID: <CAGdofc=ToWi4fSqT=avfJDdKvTMFVVc90rTunqZ3vzudTCLr9A@mail.gmail.com>
Subject: How does the Git community test each version of Git?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,


Can someone point out as to where I can find the Regression testing
scenarios for Git?

I`m also interested in learning more about how Git is tested before
every [Major] Release.

I would be glad if I can at least get a starting point to explore the
answers to above questions.


Thanks!
Rmtechup1
