Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2074020248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfCFKaa (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:30:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFKa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:30:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so8251478pfn.8
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7LRqDzVeXBLi8MS8qrbIGrA+qMPj3I0DTZrEuT8kbtU=;
        b=XL6tTiG+xRo5KDUGI0P5R6YRwyXXmWz5l+fNWuaE/+kemSP2/mcZHER+l5T+VCLU7h
         VPZ9MyRyr0t6PgBHS4PN4ip4eavDkV490jueBhn1luSpLpF1YqM9jGT9awhmJ4KxeTPi
         905yxINDb3olOr1cRXKsfGlPyl7zln7QlgXmV7RSgtDuIhWslUmDUbnqkqEi5i3MteVX
         KzMV6WqEXCnQ46Uneq4pennUwb98kI1Ig7iT6NupoX6Btsb7lC3iQ2EQxqyxcQ+aj6q+
         np7v98ML49SPN7f4pi9oKwnwRFG5YgC8iqthM5ZNN/FRO4Oghg7eyTwDj1rfwpLsWW4b
         EKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7LRqDzVeXBLi8MS8qrbIGrA+qMPj3I0DTZrEuT8kbtU=;
        b=fEeMRnlelBWmMuRroSpatWkJm0SrmNp03dfedtilkMj1ePh8eAUf6ntSbyvq+tiWdL
         ooVgeEqpKoTSmeoy1uXCGn2j8SCn/Dj4QqjSK51Pbb5flDCs3NpIPj/cl2/EI3LTLlaK
         68Mu6Mck2VPDBaiJSwsnj1Q+IPZKZrSouai6IXxT85CbVCn5+g0NtWVaU7KTKNIQHEAe
         l+8qB2wltcD1i4untBv4WqDOFXcDQfzaaI+xolEE20D0RJr6HwI9ZEUkJhyofrbdG7YU
         0GVXEU9qp2juWw/YMJiaXpLTffQrDIXu8Ud0BvwM39gUZ+VsVI1Qj6u/MdWTYtATU+M3
         dJQw==
X-Gm-Message-State: APjAAAUxFnKPdMp1G4ag8v1/DazEOBUnZqYMDj8jNhGePiq8PxvoJUQ1
        fZy6JpCaePQWQAVE4hTn2acqI6S1
X-Google-Smtp-Source: APXvYqwKAXLe9RsAB2KOhw2aOtBxvocJmygMuY8O/q/X4v4wBAdvRzFCZ8r6v5LUf2ZBvmDP66j3/w==
X-Received: by 2002:a63:c042:: with SMTP id z2mr5655899pgi.307.1551868228684;
        Wed, 06 Mar 2019 02:30:28 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id l84sm3753588pfb.113.2019.03.06.02.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 02:30:27 -0800 (PST)
Date:   Wed, 6 Mar 2019 02:30:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 0/2] cherry-pick/revert cleanup scissors fix
Message-ID: <cover.1551867827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I stated earlier[1], I discovered today that git revert (and thus,
git cherry-pick as well) do not place the scissors line properly as
well. This patchset adds a scissors line when conflicts arise in both
cherry-pick and revert, which fixes the same bug present in git-merge
earlier.

This patchset should apply on top of dl/merge-cleanup-scissors-fix.

[1]: https://public-inbox.org/git/20190306014143.GA2580@dev-l/

Denton Liu (2):
  t3507: cleanup space after redirection operators
  cherry-pick/revert: add scissors line on merge conflict

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 builtin/merge.c                   |  13 +---
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  22 +++---
 sequencer.h                       |   3 +-
 t/t3507-cherry-pick-conflict.sh   | 122 +++++++++++++++++++++++++-----
 7 files changed, 138 insertions(+), 41 deletions(-)

-- 
2.19.1.6.g4de041ebd8.dirty

