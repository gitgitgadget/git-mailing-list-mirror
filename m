Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C0120248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDMIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:08:39 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:46877 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfCDMIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:08:39 -0500
Received: by mail-pg1-f182.google.com with SMTP id 196so2970818pgf.13
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/X4ZQ88AAr2GDBpLTZEpbrz7hJitb40FxU13LhOYj5Q=;
        b=sASp1jFdEcawaI6JD+ty/y5bI1CA2ZJduxa0oDyD4CDiDO3dKR3Q16cwWCzW8ePZsP
         0rmxXTzA4LFTZYH0LvJpNiHuqUp/ho1U9nv1aFwGUYSdGUSfd9xWhvq7NR3p3EYfFpB/
         DghOz7q0wgSSOTfVv190sVm92jwyzXDFe7tzULmhJ4sgozmofW9Kwr+UlVGQtvuaqEhb
         AtYU4p1oJPEVjGmKVBt1ok4QzdwrbV6+B6kVNLillEcn9vbDpcC8j5oVr0Ml4Ww+wYsp
         6aUXFzX0R/uu8zAll8TXFUWV2K3RqCA5tewUuSPoZPYPYliiVhK2yo3ZVM3MBqqgn3Ie
         76Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/X4ZQ88AAr2GDBpLTZEpbrz7hJitb40FxU13LhOYj5Q=;
        b=dXKSLVKdZ4vLKERRykuBbqeMLpaIeSJ0HqaC6dqiniF+Hs/XYcI0tq5chFc0ywVd3e
         Fbt2qlFFmv6jLYHEvruDrrnvShVV//lnoAJN7g/xpxuhp26Vld+kIEXo5z+PmURyMMJz
         fHVvAO7J70N7sXpeXdhqrupNh1QtCM5+HFIpTbkJ3vmnIrFTHrT5Z5DE/s0fQa/mUreZ
         0ZzyaM5VQ7bbDSacyJt5dOaqReoPx7p6HZcAH8nlpeO5WaX/8UDrWaZ0FJuxm5QPi1rL
         x8V1Zc2QJqj7WAoFJ5S4gZcrfUSINd0QWEZUc7ZLkAZTCpSflXL8cCNHoM0F7Uz/ejpf
         T+cw==
X-Gm-Message-State: APjAAAU7LBrqnagR6mDOZkMPVC3vbOzhy5d48u6aAiUdMdm+fhWXbM5x
        gxe/bto97hVCxQM5IdmST7d6i89bKOI=
X-Google-Smtp-Source: APXvYqzxcsmk7d8VMNB8hwvOeuYccwEdxz7r1ALmiWJLCPyAxH+SdWS5vai2zL6QeQ0jpvX8gmTRfA==
X-Received: by 2002:a63:d80b:: with SMTP id b11mr18092588pgh.168.1551701318036;
        Mon, 04 Mar 2019 04:08:38 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id b138sm18791686pfb.48.2019.03.04.04.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:08:37 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v3 0/3] Use helper functions in test script
Date:   Mon,  4 Mar 2019 17:37:58 +0530
Message-Id: <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch ultimately aims to replace `test -(d|f|e|s)` calls in t3600-rm.sh
Previously we were using these to verify the presence of diretory/file, but
we already have helper functions, viz, `test_path_is_dir`, `test_path_is_file`,
`test_path_is_missing` and `test_file_not_empty` with better functionality

Helper functions are better as they provide better error messages and
improve readability. They are friendly to someone new to code.

Rohit Ashiwal (3):
  test functions: add function `test_file_not_empty`
  t3600: modernize style
  t3600: use helpers to replace test -d/f/e/s <path>

 t/t3600-rm.sh           | 349 ++++++++++++++++++++--------------------
 t/test-lib-functions.sh |   9 ++
 2 files changed, 187 insertions(+), 171 deletions(-)

-- 
Rohit
