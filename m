Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E790D1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfBPLeK (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:10 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40134 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfBPLeK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:10 -0500
Received: by mail-pf1-f175.google.com with SMTP id h1so6134138pfo.7
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCCiV5GbRv00WbcQ+PGss3GIlsHOiV2knV78m13SCzU=;
        b=FQfAq2s1nnSRRhZdOiNIC1gK0u78jyXxqUePmcs8UzRYy7CoQ9UezrlkKP2EsryAyw
         7nE0tcKzV1ISl9yBcDpIVMoFw6KJSH4nvVjziDo7MnlWBbqnPK35Sw7gJPNQvYGQymDx
         d8hRAGTnksZPS4iUwt8uSbu//lJpv0MRslRMdJPRMg0FLc9sKmMzZrPy+QqBoI4c0rCP
         /vrAsVTCVdxkftR/F0ccU6gVntYQyH5MsfWQIMBifXoRpFFbRNBVHxD9mw6/pHQyFCHc
         DfJMfALJxD6N6DY6DKybqYAVxsbbVY/omZ4QmOH5mdxhpKoLO7x2FOfAJiQgF7feOAM4
         lJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCCiV5GbRv00WbcQ+PGss3GIlsHOiV2knV78m13SCzU=;
        b=bkqzdLxJTBt7UItAKeuLaW+4XMP0AC9fP1wi6Q2L/ArW6G15vqg3sNMDxUOJU+h+3+
         j5YR2jL89BBpnMS1SRKVBkYbukGUKLbP3T6ENpxwDE3qUsuKaOpevfKEP7Dg8dEz3J1Q
         2WlBKVH+4tQSHUWbf3psl6qyTMkOCEVyaJtnDcqLGuF6wBOvgbkbAI3HMD6RECJKkmb5
         /ziVnSf4wP/NiERKUlGm8/OqxQrjvB7m3TNqz53knWz6gos2l/nc37RSgNMNZOD+KLZF
         kuTgENPhj1xEGi3u/jUbDS0rN8NRrx8Z0LkbMifZiTwvyRS274rwDt+KLtpC8FEen/HF
         G2qQ==
X-Gm-Message-State: AHQUAubyN9uBn4v+58ObREma4Slj3aRtbMDGeGfEsKAzLeI7Y1dEg+Ly
        +2Mey3CZdovTFt0TJZ5/xkSb0y/H
X-Google-Smtp-Source: AHgI3IZbllcnpPwF1Dxmnt6hkSGXkI8lOxpfVJopLGhmSPxcatLGLBqTRkugdMjrEnVpr9Sdq4mPcQ==
X-Received: by 2002:a62:9305:: with SMTP id b5mr14263435pfe.10.1550316849192;
        Sat, 16 Feb 2019 03:34:09 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 4sm7908188pft.96.2019.02.16.03.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/21] nd/diff-parseopt part 2
Date:   Sat, 16 Feb 2019 18:33:25 +0700
Message-Id: <20190216113346.25000-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes the subject line to help clarify in "git log --oneline"

Nguyễn Thái Ngọc Duy (21):
  diff-parseopt: convert --patch-with-raw
  diff-parseopt: convert --numstat and --shortstat
  diff-parseopt: convert --dirstat and friends
  diff-parseopt: convert --check
  diff-parseopt: convert --summary
  diff-parseopt: convert --patch-with-stat
  diff-parseopt: convert --name-only
  diff-parseopt: convert --name-status
  diff-parseopt: convert -s|--no-patch
  diff-parseopt: convert --stat*
  diff-parseopt: convert --[no-]compact-summary
  diff-parseopt: convert --output-*
  diff-parseopt: convert -B|--break-rewrites
  diff-parseopt: convert -M|--find-renames
  diff-parseopt: convert -D|--irreversible-delete
  diff-parseopt: convert -C|--find-copies
  diff-parseopt: convert --find-copies-harder
  diff-parseopt: convert --no-renames|--[no--rename-empty
  diff-parseopt: convert --relative
  diff-parseopt: convert --[no-]minimal
  diff-parseopt: convert --ignore-some-changes

 Documentation/diff-options.txt |  20 ++
 diff.c                         | 510 +++++++++++++++++++--------------
 2 files changed, 319 insertions(+), 211 deletions(-)

-- 
2.21.0.rc0.328.g0e39304f8d

