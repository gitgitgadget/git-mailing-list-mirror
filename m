Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8412020248
	for <e@80x24.org>; Fri, 22 Mar 2019 23:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCVXWu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 19:22:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35535 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVXWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 19:22:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so4470244qte.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhIbEQBRI6tHSv/M8cIp7E/1+KC4VCuvYL4UfwEAucY=;
        b=jKRy5Amro3I/ZaXPGizdJJPkI5B2HJ/Czo6YQX1yD/hnMBPKkwXCzpS9M2HA1kr0Ec
         9ugjDiIWafdrebmF9PXy5j+eM0vB9tNTYFbNB8DXR7UbjWBtEch0WFCOjrQgBnMWk0PR
         2xdz64/jn2aNuHqh+TrNurOT8Dz1TadX1PnHX+cAMmlD8mbsPDlsILuFdZvTuUCk2tKW
         honG5TbIK3E/FFdd/0DjsOEQ9u7kl2ntwnAPGGYi3FJG/ZMh4Ao3s6CxdukJh9ziBAS8
         1SpIsZNsLIVB47dgIMWX9+A3+q4hdAxsvr0yidCsoCSwZGSEbOgv/pmCXwDlPtRtLCBd
         uPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhIbEQBRI6tHSv/M8cIp7E/1+KC4VCuvYL4UfwEAucY=;
        b=IWnfOssn49v5CQlxHiLK8Fhrsp6EdYzT0TleEw0jOL0WQ4WSjdosgG01inDHPR5dgE
         VP/DKBpL43cz+N9EIBY/7eKUo3ZN+R3ZBf7h6rMorPxIE0KKecMHPHBdSwMmr7HwWTO/
         K/rR3hs+AqunZwt00f//waklEKVSNkiyEhmJOW/0MezPYKfn79Q81zWvymENDARUCr3t
         k1/92sP6Fh1lW2+/z8IAchHVTpp/BseEZnZ1cqkRNh5ItDY2Y8xi7FmNJYoQyzFaDAH7
         CjX5vyObmd0fMYCfadOFSRsgpuX/N4V2ARzP45v79oHR8bU7KFxPxTWLEl6th+5sZNns
         cJ8w==
X-Gm-Message-State: APjAAAW9Erj4eVZlXtzGDkoLN6UK7ZbDugzb3zXxtD8qgI6t4MnR1sGZ
        6R4kKFNE8Cg+M8KC1n769tBP3OtM4zg=
X-Google-Smtp-Source: APXvYqwuZiq8eEDyyKEEDK3DGa79wca2HUFd1rD6rZizmwfB3F8SNJYfR5ukVsosjbu7YlP0Z+13Bw==
X-Received: by 2002:ac8:a49:: with SMTP id f9mr10624155qti.134.1553296968381;
        Fri, 22 Mar 2019 16:22:48 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i68sm5002765qkf.42.2019.03.22.16.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 16:22:47 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com
Subject: [GSoC][PATCH v4 0/7] clone: dir-iterator refactoring with tests
Date:   Fri, 22 Mar 2019 20:22:30 -0300
Message-Id: <20190322232237.13293-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226122829.19178-1-avarab@gmail.com>
References: <20190226122829.19178-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset contains:
- a replacement of explicit recursive dir iteration at
  copy_or_link_directory for the dir-iterator API;
- some refactoring and behaviour changes at local clone, mainly to
  take care of symlinks and hidden files at .git/objects; and
- tests for this type of files

Changes since v3 includes:
- Addressed Duy's and Ævar's comments and suggestions in v2,
  including but not limited to:
  - Add patch to replace strcmp for fspathcmp
  - Code comments refactoring
  - Unident snippet at mkdir_if_missing
- Made t5604 added subtests pass under GIT_TEST_MULTI_PACK_INDEX=1
  and GIT_TEST_COMMIT_GRAPH=1
- Re-implemented patch 2 with linkat(), to be simpler and have a safer
  behaviour when clonning repos with symlinks at .git/objects
- Split first patch's tests into patches 1 and 2, tweaked it a little
  to reflect the previous item changes, and replaced some usages of the
  string 'link' for 'symlink' just to avoid confusion with 'hardlinks'
  which are also known just by 'links'.

v3: https://public-inbox.org/git/20190226122829.19178-1-avarab@gmail.com/

Matheus Tavares (6):
  clone: better handle symlinked files at .git/objects/
  dir-iterator: add flags parameter to dir_iterator_begin
  clone: copy hidden paths at local clone
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal
  clone: Replace strcmp by fspathcmp

Ævar Arnfjörð Bjarmason (1):
  clone: test for our behavior on odd objects/* content

 builtin/clone.c            |  72 ++++++++++---------
 dir-iterator.c             |  28 +++++++-
 dir-iterator.h             |  39 +++++++++--
 refs/files-backend.c       |   2 +-
 t/t5604-clone-reference.sh | 137 +++++++++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+), 42 deletions(-)

-- 
2.20.1

