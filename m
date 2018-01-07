Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2598A1F406
	for <e@80x24.org>; Sun,  7 Jan 2018 00:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeAGAjL (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 19:39:11 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37011 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeAGAjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 19:39:10 -0500
Received: by mail-qt0-f195.google.com with SMTP id f2so9937820qtj.4
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 16:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n4PqPS2Pv7P9XgDUqIx3KdFVG+amK8c/hGCmio8hsOw=;
        b=qbSUBxfsdCVswJe2gxrhFMsWFyvksYoRTTbFr8k8wkg9xQp8nwAbRqvmDqb8RPrWpf
         QCNd1l3e9dKYHaR+KCz2AseLSoav8YFFnAcPbRh7s+MJSOShz/jgzfHZP2IAMxHPuAMu
         Si3e3IdRBXz8zfyuKFTgaCpsjlZFOhYm/6WD6zBA9wv+FgBJPj6nmexteYb861QejZI7
         OEQtw4wyvX7woIsrYYwj7NOiZao05WhMMRs/BupdhdaMekYOO187YioVmgPHrZqCweJV
         VPXJS/Dy5sqgd6k+8wyAo9A0151+E/P/GffRm7W73BC7EnnclcJRIe7sz5diVdNhg1Ld
         9N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n4PqPS2Pv7P9XgDUqIx3KdFVG+amK8c/hGCmio8hsOw=;
        b=W/675Y0gqm4RVmeXA/9IhNEYbwJfvb/aDDPO54cKzPlB62fkit1GTEHvBpCoFNMtvn
         Es7CBUefSC9j/Zuig/VEVXS88W6TsM2NQ01KfHo85GCm+91UExvXWYNcvDb9ZLi5bRqE
         c3YgW8oGrO2Pv+73lsRMaFwRiMB++UoCBEJU2RoeUjVP9cS4hu7qpppwP7nvRKDyEQ2E
         E4I60PO6nnqeFJXo4v3ESaSBdY4ZHvxlEMS2cdJJ5peu0IGFJ0BTI4S9FJ3rgb190DII
         QmCXdHY7rEqwGXVn7HOnfBS8VkrQxR5uPxirDRzeRo5vf2MDB4KpBDPtVRrOYTuvvRer
         LDvA==
X-Gm-Message-State: AKwxyteV8sZzfMfTT1M05vPiXebA2lDDiZkUS9SIVK3lsQFSgmzXUomA
        R0OryvQ3HMsAZl2Weq4Hp7QPx9mmFwqyXpBL/mg=
X-Google-Smtp-Source: ACJfBotr8wY6IWz3nmmnHLPj1uZnN5fGym9zhqrCFQWaKhShsbe5Y9stM0zUzsPbMHb++I5gJ51HlWhoEZHqBTXUFaU=
X-Received: by 10.200.1.10 with SMTP id e10mr7343317qtg.51.1515285549590; Sat,
 06 Jan 2018 16:39:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Sat, 6 Jan 2018 16:39:09 -0800 (PST)
In-Reply-To: <20180106184614.20115-6-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com> <20180106184614.20115-6-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Jan 2018 19:39:09 -0500
X-Google-Sender-Auth: aKOGjpiWGCo6PDng9v4Ppd1cDRQ
Message-ID: <CAPig+cRX6uJWzPNMaMoWdjcDGQqjMUz8Z5b3Gnhg3OOgHBBWOg@mail.gmail.com>
Subject: Re: [PATCH 5/8] Doc/gitsubmodules: use "Git directory" consistently
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> @@ -113,7 +113,7 @@ obtain the submodule from is configured here for example.
>  This file mainly serves as the mapping between name and path in
> -the superproject, such that the submodule's git directory can be
> +the superproject, such that the submodule's Git directory can be
>  located.

There are two more instances of this capitalization inconsistency
later in the file. This patch probably ought to address all of them.
