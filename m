Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFAA1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 12:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934537AbeAJM5s (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 07:57:48 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35035 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934535AbeAJM5n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 07:57:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so1618311wme.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pnbi9LAmNh/hOS6oETHtPzaaIIiHSdsdRExWdFrKl8c=;
        b=l+ZP2O0N1T32bM3aDnZNCVC4eyJn98ypFW6Ngy1BAgn9en693bPVUoebH+8wb2CQT/
         IGVQe6Qz7GDRbY5EsleCusfq1iY5bJMWBWeTjdkTa+bbYNAtO1votmWZMIGvrBgajmPB
         8z+unh+aDGJzM4c4reeOLPg0Mw/OPKMt6Amzt6Fl7TJAnIEyO9z8T7GPmrx+2ofV+2SI
         8kXzL+uv5MeSqFEZT0XA3fyeZL5vfyvMk+eaVDzCnTrRa7zw6einbWTH9YL9G0N3kDHO
         NiSMwEMBc+W4q8VloRdNsVv+XCUXw9yu6ouHoq8HCTGhWPLhu4nz2XUUTds7qVFK1Lgt
         kxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pnbi9LAmNh/hOS6oETHtPzaaIIiHSdsdRExWdFrKl8c=;
        b=jUASh2iW4fIbrov15IdpD8fiPOz4SShNyicaVFdnUv4QjTuWmingI/OnMv1Y9zjUbW
         upq8c4nI3gtGiM0DKWv+RRdybekSTzeq16ke/4M0ho+vB2L31MIQXUFsj4NAzFaIkYpH
         ak2NV7jENvWjaD3DL7XRLWi4/MeQOH41bCrJ8B2VhdewApCX2bW1dQ59cx7ZzQx61GQu
         qyw7L0bm4i5pkN+odbvRFwSMNWOuDiiOAO1YSXF7xcGv5jezNOvqRLofNfkb5QfgfTnX
         KCZtgyfm80IpYAs69JX/ly83HDQNYt8a5L7VhLst7nWfQntG/Zx3nKLkZMQ1/u6BkQBi
         3pag==
X-Gm-Message-State: AKGB3mK9Vpy+Tvc2FGJR4MTuOIX7WpBFjUOac1nA/gUuvzWTRbUX3lYr
        t+PqBthZHY7k0s4ee/H/6p2Ih8Qf
X-Google-Smtp-Source: ACJfBoun09C0AtXEuHaS2W/1mLkGu6pQVmLuC0xkhSX5e0BZomGK0asoxyFUUIhh5ex+wweSjYxzxQ==
X-Received: by 10.28.13.207 with SMTP id 198mr14263695wmn.61.1515589062192;
        Wed, 10 Jan 2018 04:57:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p29sm22722530wmf.20.2018.01.10.04.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 04:57:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] the cat-file -e option doesn't work as documented
Date:   Wed, 10 Jan 2018 12:55:52 +0000
Message-Id: <20180110125554.12582-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -e option to cat-file will emit output, after promising not to.

We should take either 1/2 or 2/2, but not both. I'm partial to just
documenting the existing behavior and dropping 2/2, it's useful to
know if you passed in something that didn't look like a SHA-1.

But if others disagree we can drop 1/2 and take 2/2. Up to you.

Ævar Arnfjörð Bjarmason (2):
  cat-file doc: document that -e will return some output
  cat-file: -e should not emit output on stderr

 Documentation/git-cat-file.txt | 7 ++++---
 builtin/cat-file.c             | 8 ++++++--
 t/t1006-cat-file.sh            | 7 +++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.15.1.424.g9478a66081

