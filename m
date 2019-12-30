Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37080C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D89720718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL3QdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:33:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44646 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfL3QdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:33:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so26581114qkb.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tMnrfdsQPlrN7XcBFCNGUh6ENhqBKoNRZIb/wc8LZyw=;
        b=aZB9AqrfjXqVjNrr8JCHoPqiC8S062VTKcK4GKR9eqvTpbGjK4zscX6wdfkhQSXSxS
         bh72pRushrvhX96ek/3Nw0Teb0W/XmRjHH6kFj3zrkE4ZKR5n4T8k/PjmIwkhyUVptip
         WoCZi3dKK2Ye5ba7LvqxzP9ORl1/YprsdsmhMuJpv6Q/seNNETfnjvk/lHkROsEBwfFC
         lNrcq0Y18Egg6rIa7/vcnNbW+tILvLO+8FTpuQp9pXbL5wzjVaVcLvY0utT6NzYIPPBU
         WAfc3N5x5LN24O6teMzxX70hTxQuBvgpD9a/app5yYuoGdFWpXaeTb7CfxLq0PICPkrM
         g/JA==
X-Gm-Message-State: APjAAAVVumhPik8KK+ESulPGupuXvNX6VwS7uNfoXT4P/zf8dhD2IICL
        pyqDr375Tt0r8k7z/faBJGM=
X-Google-Smtp-Source: APXvYqwoW8BOiFDadZviBdqmNQEkZg9XEVu5WnCu/BsbP05wuyVH5VSAHWTOKWMd2YuStfSRKw2t8w==
X-Received: by 2002:ae9:e01a:: with SMTP id m26mr56481380qkk.275.1577723599427;
        Mon, 30 Dec 2019 08:33:19 -0800 (PST)
Received: from vmi286618.contaboserver.net (vmi286618.contaboserver.net. [164.68.111.199])
        by smtp.gmail.com with ESMTPSA id h28sm12509004qkk.48.2019.12.30.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 08:33:18 -0800 (PST)
From:   Arnaud Bertrand <xda@abalgo.com>
To:     arnaud.bertrand@abalgo.com
Cc:     git@vger.kernel.org, gitster@pobox.com, xda@abalgo.com
Subject: [RFC PATCH 0/2 v2] *** Add branchname in commit when core.branchnameincommit is set ***
Date:   Mon, 30 Dec 2019 17:32:54 +0100
Message-Id: <20191230163256.14749-1-xda@abalgo.com>
X-Mailer: git-send-email 2.25.0.rc0.7.g17b02bf28a
In-Reply-To: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
References: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To avoid any change in the current git behaviour by default, I've added
a configuration variable that allow to activate the feature for those
who want to see the branchname in commit. 
By default, this feature is disabled

Arnaud Bertrand (2):
  Add branchname in commit header
  Add the configuration parameter core.branchnameincommit

 Documentation/pretty-formats.txt |  1 +
 cache.h                          |  1 +
 commit.c                         | 21 +++++++++++++++++++++
 config.c                         |  5 +++++
 environment.c                    |  1 +
 pretty.c                         | 15 +++++++++++++++
 6 files changed, 44 insertions(+)

-- 
2.25.0.rc0.7.g17b02bf28a

