Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EDA1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441736AbfJQXQ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:16:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438437AbfJQXQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:16:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so2586724pfn.11
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iPUTF3s4s5nR2K+rVqxwIpa9LvY/V9gFImEDO5mZJ58=;
        b=lcaqY6Z+E7wcBOo5hBQ8Ito2bfy0cyoD2SkjlstzoYHYJ94Bd8y8kD+ZZerrFv0/B3
         KntkwLYfyz6WYpnlQvN5c0jZDTyJphPOrvGHDvF4XOxWI/lWStYa9OFjEzltaonptI25
         uRpzYDMpp7XKAPV4iqPt59GUeYHadgxo1c6/0vZbrDCLxmV0No5jQIIehqGwMh1pSqaJ
         uk9hpWGwfG8iKvYX6ObkmVHrxRMan8T1k9nKDq/JAxcjpQWQ5GpP0lkcJGAnvkj4IpRt
         KemGAR6epoHxRRoNyr/hPNmlGbBH0FgPGJEmiZVhJsAJyXesSt3umsOUVklds+R8DDzD
         Q6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iPUTF3s4s5nR2K+rVqxwIpa9LvY/V9gFImEDO5mZJ58=;
        b=eknv8oej41GOR8baRAgOu4DzLXP2cIwHM7UshxAgEeln6zcRtuExKDjs5a+Wuwqxbv
         RAmIl21MrIFr0WXgU3B8ulrI3llITunLgokMAOUHQtrsgmBkxry9fLzT2QEgLBxasIKj
         +rHAxqkuhxxrCh3jk8OYevOIfGJ21+NxQjPmQxlpnVyU5s4l0BG8PeCjZitq8xZ46yjL
         pMT63jhWJNz8T4QgCjoSCLmOThU560J4Pof9bm+GYuy1v5HL7gb8KLQTvCodaDr0M1E2
         TNRN7alVUcDBLmggdaKU0brbTLyfnsBOs+AomnY9ISNOk1Sm9T4Ii+aWYh3cD0emx7J4
         zy8A==
X-Gm-Message-State: APjAAAXCHr+eYl/VZadJEX+iszFQL9QV7qK1Fdg0yKLdcezEK5kEUuUX
        DRxV3pLRFYoWZd0xF3MtSyeuuZjW
X-Google-Smtp-Source: APXvYqwpp0m/CuTyal6XN0Dc2h/YtSGv0BW/rmuBKB4prkvXNsppxlAPtLhgspQBUFAsziN7olj8Fw==
X-Received: by 2002:a63:5448:: with SMTP id e8mr6712894pgm.10.1571354216698;
        Thu, 17 Oct 2019 16:16:56 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id d22sm4225716pfq.168.2019.10.17.16.16.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:16:55 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:16:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 00/12] t5520: various test cleanup
Message-ID: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like earlier patchsets, I want to implement a feature that involves
modifications to the test suite. Since that feature will probably take a
while to polish up, however, let's clean up the test suite in a separate
patchset first so it's not blocked by the feature work.

Denton Liu (12):
  t5520: improve test style
  t5520: use sq for test case names
  t5520: let sed open its own input
  t5520: replace test -f with test_path_is_file
  t5520: remove spaces after redirect operator
  t5520: use test_line_count where possible
  t5520: replace test -{n,z} with test-lib functions
  t5520: use test_cmp_rev where possible
  t5520: test single-line files by git with test_cmp
  t5520: don't put git in upstream of pipe
  t5520: replace subshell cat comparison with test_cmp
  t5520: replace `! git` with `test_must_fail git`

 t/t5520-pull.sh | 351 +++++++++++++++++++++++++++++-------------------
 1 file changed, 213 insertions(+), 138 deletions(-)

-- 
2.23.0.897.g0a19638b1e

