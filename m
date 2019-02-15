Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D811F453
	for <e@80x24.org>; Fri, 15 Feb 2019 15:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbfBOPtX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 10:49:23 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:44789 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBOPtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 10:49:23 -0500
Received: by mail-qk1-f182.google.com with SMTP id r21so5916709qkl.11
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 07:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KH9hwXG6fl+yB/XISsJGmSb9/VmBhypVO5UPiCfdww=;
        b=S6Kn2Jox5XEQNrQq3SMErHhmoydvGFKoSPuZySKdlos+YagUYLpqvLDvled9BGVW9n
         si/D7dsJCddsUjVPyoWVk6YAZGLsXQ2fWQGk8/Bk6mRn3D+626wGzPfle5gTIUjAnL/s
         /E6HuxpSDcKYLTyYT7axdiIMPU/m7AezmeyDUUHzkFQIN5pmzOXDwS9Uq3W3IiBVfnNy
         VtkTksX5yY5Y0XcJDAe44PrV1UmbznHWKE2ci4d5+pm60WhyrGqkIai1GNYKBCGBKY0K
         UlsUH+XXizVxgi/keN01G+JP2PwbwKPG6bugEINe/STbP3wW/Zb3/adjzF6yWuSjQMdq
         zDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0KH9hwXG6fl+yB/XISsJGmSb9/VmBhypVO5UPiCfdww=;
        b=cHlwOjV+Q+TvhXsgegF7Mrh7ZnjMaREot2HbuCUhuj/ZjuRpIaP2u3IUeO95H4Kvzu
         5bKSLs2XVkpeBU61zPHxqxG0TUw2r1wQes+UfumdXZFEhrJmW7Aw1qOBVxUCajbeulzg
         c0dReNpKgcm2mGjtfAVkp2fEqZbay/ht7671m0INqscYhpn5hwdG33msDjx68FUmZ4z3
         sjnrIeIJ85rFw2uujTtj+P8o708lz7YA6HsYmzob3LAyvmRWIGw7ZfezG5myge9+gi3U
         xmstLxj7P+YdXAbzeyt1d1hEyv0WKGSBmRaTOAcr/s/beSbvBFtEh/Co5MHpXShdT8kC
         i+jA==
X-Gm-Message-State: AHQUAuZL4Dz4WwWyWo6Q7IMehi7I8Lhv/h5JEdAwFwvAoY3qjz000DRi
        Mvoc1LPXW2YRji3Z+3p+6MGL192JQkU=
X-Google-Smtp-Source: AHgI3IbIr2JUFF4b784w9qAlzbmnSLKjY/fRdXsbel2IcJ6C6x7LMC45HZA/nsuiEnzNBLReVnz8Rw==
X-Received: by 2002:a05:620a:132d:: with SMTP id p13mr7177662qkj.232.1550245761986;
        Fri, 15 Feb 2019 07:49:21 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id j6sm2909593qte.29.2019.02.15.07.49.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:49:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH 0/2] clone: convert explicit traversal to
Date:   Fri, 15 Feb 2019 13:49:11 -0200
Message-Id: <20190215154913.18800-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert explicit recursive dir traversal at copy_or_link_directory of
clone.c to use dir-iterator API.

This is my microproject for GSoC 2019. Idea taken from
https://git.github.io/SoC-2019-Microprojects/#use-dir-iterator-to-avoid-explicit-recursive-directory-traversal

Matheus Tavares (2):
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal

 builtin/clone.c | 64 ++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

-- 
2.20.1

