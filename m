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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9901F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKSBG4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:06:56 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:32845 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfKSBG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:06:56 -0500
Received: by mail-pf1-f176.google.com with SMTP id c184so11263311pfb.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RMyRBCeAVsT6WQHJNRpwsoPqyUmjlcNc9XpIOuXbIYs=;
        b=JaQpL8ogBTtg/rslZeJceHvCIXW08Qawm0j+aiNyPjoqIfR15CJcvP3uDIvBf7uTeU
         Tl8heXmohJ5CyU2GoKHoD4e+tDpcfHB4XDwOLsElb5Hc6sv0nS9X8Y3dTVHGtM/rrqMD
         sws0VVS3zfzAot3vT92FpHwFhVtULocV8zQWuJqQydedu3UzdGtfT5+kUgHyrao4k5t3
         nu23NySi1m+VFnvUXoJEdCHeXaksdGuglqIeXbb6L3jmkKdVE60nf/tNfRilUWQaWOQk
         C1QWWUlfsRLxWh94rHqE9JaKqnMZ1Ejgm6cHDMxh9bPto/HDLjhonm9Ek92uDFQG9DR0
         dVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RMyRBCeAVsT6WQHJNRpwsoPqyUmjlcNc9XpIOuXbIYs=;
        b=mI/zZ4/GYylb7sqUiuH38YEHjtb6i8xPlEgjYDaHNRbuL8sXM6r6suB3QMNUUprHUR
         /e0YsfK/ydJyKSnr9Y3yz54G1Ei92pMN11WU0vJZ0itk0upVBqRulM192m8PEHyizTk5
         JTtL70HQhd0Z5S/98WMbR2cQPqim/S3wX3nyPkEXBtVrT4WODTPHbAD4AlJcdhfKv/22
         O21+ABoBKIkfTNaCITk9vacgNJ3Ydan2tcoEOCQBoCidsgzPpdSFSQFvAPSNuZ6OQ5Ae
         K/gIfkWQqpw4ddgW5bG7GGHJ4vA3jf4x37ktwp2ImMmJy+yEVURPXxs3Bn1CooXsyOZO
         tOPw==
X-Gm-Message-State: APjAAAUxVbZcv9MMvwKeIutmdnUL2P1RxBmY75Avgx1UZVTrrezkk5dF
        3HBQasAJMq51ahwSrsnEddxgrAFl
X-Google-Smtp-Source: APXvYqxGFNOm82BS2sVg+Tw03QW1fFy0njj2zp0Rb7Ew7WWtTQXuX80dUfGEthsjgtaUoZ9Z5ZpLDA==
X-Received: by 2002:a62:76c6:: with SMTP id r189mr2596489pfc.48.1574125615154;
        Mon, 18 Nov 2019 17:06:55 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 16sm23642445pfc.21.2019.11.18.17.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:06:54 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:06:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] range-diff: don't compare notes
Message-ID: <cover.1574125554.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I was using range-diff at $DAYJOB earlier, I realised that it
includes commit notes as part of the commit message comparison. This is
undesired behaviour so this patchset documents it and stops it from
happening.

Denton Liu (3):
  t3206: remove spaces after redirect operators
  t3206: demonstrate failure with notes
  range-diff: use --no-notes to generate patches

 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.24.0.420.g9ac4901264

