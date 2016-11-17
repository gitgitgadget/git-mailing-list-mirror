Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7AD1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbcKQSqS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:46:18 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36361 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbcKQSqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:46:17 -0500
Received: by mail-pg0-f47.google.com with SMTP id f188so93754562pgc.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZpgg4dxD/LjycdGChufvfOp6eAwt7ME0ELIlWzMMCE=;
        b=poLx4q8RIgWh4ODOQiD7QxGaLP+gyVpcr24FvdrYaXFDo0n8TPPUCEvN29mbu3Wd/r
         ANnlUtyvodmxdQoaRwKaYOMqIHA8Ryb3amiF+uKtMSLB2ACvncUAAMZHsKbQlkaiz8vX
         N+flrIyXSZTIcjEJS2rs9H7aTW/7/CqBmbKM8K0b5KjHtBUZf1MISsDvOPddDN71sj1D
         4VPVbHOEfkwYtWry92njP9yltXHkTcEb7LW6NBstdHTXQnwpcqGGNEF//hjLQ7YjjyVd
         hqYBSPDg+krcDi4lKMenG98uFkAebpkHODdnhm3r4xWHZqEcA7IePpk5z4DByH5NIB0A
         fPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZpgg4dxD/LjycdGChufvfOp6eAwt7ME0ELIlWzMMCE=;
        b=Dv+3DoUUYRV2YYUqzHQ3fpalfNVE0yVjsGA7QDKJf+WoM8X0JvQ7vzmBrJiNMmenrR
         QnvSKebmvBFuE6Orw37LkJuyBFPFUD6HOfq/5Ci97ElJjuN67xR46STgyj3ag9LPUeuT
         kOb7PX3VxOHp6Zrz3EjEC1sIDTNjKX29tLwLa1Vc9KAmW6crliPTQbxc/mNRfPR40RTP
         q0h+++hPIQ81KO9PD9dG98GQib+H98jADq+avSVHKrS4lcp7fzPR5ywghPYT29dvVQ63
         cT+H4a2MP8F8zHfv1KRo84cSrVco5k1Tb5HSanUOyREp1RCjf937cO5ZMtlvlwecIRIX
         AYmQ==
X-Gm-Message-State: ABUngveCiDnryaJ5z86X73UyfkGrCuPCJgZIeGeRZJgnDhqgqd1SvAB8FlxNRbF/BKcmF6Nw
X-Received: by 10.99.157.129 with SMTP id i123mr10080335pgd.148.1479408376656;
        Thu, 17 Nov 2016 10:46:16 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id u23sm9898946pfg.86.2016.11.17.10.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 10:46:15 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, hvoigt@hvoigt.net,
        sbeller@google.com, j6t@kdbg.org
Subject: [PATCH v2 0/2] bug fix with push --dry-run and submodules
Date:   Thu, 17 Nov 2016 10:46:02 -0800
Message-Id: <1479408364-150268-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479172735-698-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 of this series is just a small cleanup of removing a nested sub-shell from a
test and rebasing on the latest version of
'origin/hv/submodule-not-yet-pushed-fix'

As stated above this series is based on 'origin/hv/submodule-not-yet-pushed-fix'

Brandon Williams (2):
  push: --dry-run updates submodules when --recurse-submodules=on-demand
  push: fix --dry-run to not push submodules

 submodule.c                    | 13 ++++++++-----
 submodule.h                    |  4 +++-
 t/t5531-deep-submodule-push.sh | 24 ++++++++++++++++++++++++
 transport.c                    | 11 +++++++----
 4 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

