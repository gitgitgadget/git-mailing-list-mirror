Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35A11F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfDXPW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:22:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46730 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfDXPW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:22:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so25686567wrw.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQLEPzMnyuMj4IgNNPh3AWmEl+BPnPJbE5phBq3ya2g=;
        b=f/Z5BR4Hfk+B2vhqRsYyqQ6gniFz7TscMYj01MjEDqATItQEKqt7M8kf8+trG9xPw3
         du7u8gi2TqHIj8sy1EHOaw/SeZE/bTNFNAIpFVWArdlONW/bbR/ALozyUS7N2jE/3r6f
         kXnNGL/+haTpQy7Ryw7tu7QcrhtXvSla6SaSxdvcp9MTgTCfoZ4Qg927rHFcy/yftDPO
         Qq3MW8eVds/I2bJHcq31uaD27SOop/IqjdNwHm6RgIYBUksLoPC9KmSUI6miz5PC4zK4
         1u8gUJ3TUllQk53TEbLJJgQK1I9zQB+uekUOXDh2QHA1h1VPTUfe57lNga0gAJ3gP/gx
         UkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQLEPzMnyuMj4IgNNPh3AWmEl+BPnPJbE5phBq3ya2g=;
        b=ESZVYUEeENTyxptz5grgrb+UiuTWV6z7YiO6mcxs1n0CYCRIVjrGGSFUe0pkVJ8A+U
         wY+x+BwNfPNwTF4u0ZpJLjBL67u7nOw9szZEZ2VsdKaYJFkjaow2+lcoDmrgDdKfs5Pm
         ucBehbrKbd1i+tJiIQaMxOG4x1pWeGSe95/ZVvU28bTZEaUn9Tm26AWnTyNcIVPUebUu
         SN2JaAl5PVPdXhJotjHoIBSVze1ajMbthN3usFsApLjMo/6xx/NcVTRq9tWXTJOXq2q7
         FBbOWzYq7f2Bx2x/mBFGtbOxk47Zms0VfXzmS2WOqrRYnIGPOb9Pp62azG8PmNmXaaAF
         2Rzw==
X-Gm-Message-State: APjAAAWKO+bQPiLLTU/JhnlOsZNK+ZS7t01l2TP0ahcuzrXaeJzo7Ucs
        AZbfg5mBZnniHi53hYiMeDtnrRo8
X-Google-Smtp-Source: APXvYqxiE6VoxXZ7lcjWA5Gyan/1vzWgRmmNOh8qDPbRNGwb375Romk44HPoFnBNAErtCzVjKMvkVQ==
X-Received: by 2002:a5d:4483:: with SMTP id j3mr11174644wrq.145.1556119347412;
        Wed, 24 Apr 2019 08:22:27 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d187sm3289802wmd.42.2019.04.24.08.22.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:22:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] diffcore-pickaxe: implement --pickaxe-raw-diff
Date:   Wed, 24 Apr 2019 17:22:13 +0200
Message-Id: <20190424152215.16251-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
References: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements --pickaxe-raw-diff as explained in 2/2. I based this
on "next" because Duy's in-flight diff option refactoring would have
conflicted with it.

Ævar Arnfjörð Bjarmason (2):
  diffcore-pickaxe: refactor !one or !two case in diff_grep
  diffcore-pickaxe: add --pickaxe-raw-diff for use with -G

 Documentation/diff-options.txt | 17 ++++++++++++
 diff.c                         |  3 +++
 diff.h                         |  2 ++
 diffcore-pickaxe.c             | 48 +++++++++++++++++++++++++++-------
 t/t4013-diff-various.sh        |  1 +
 t/t4209-log-pickaxe.sh         | 45 +++++++++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 9 deletions(-)

-- 
2.21.0.593.g511ec345e18

