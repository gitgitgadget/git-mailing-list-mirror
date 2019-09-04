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
	by dcvr.yhbt.net (Postfix) with ESMTP id 782301F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIDVic (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:38:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35504 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIDVic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:38:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so358382wrx.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=J8jISmyNAteygIMBkJ9T1I60XISO/IrlILiA1G8EDHI=;
        b=XCyw0IXw/1ZHqdA9M4w00Bwg2dwka/LVaCEllURy8QlyZYbW9uwatEdZW592xfYO/u
         RXQOpyIMJvi5xz3NiYkFRUryHqfw3ODAkNpo701VeZKjJ8SGLH4aMJnuNhnx2gZ/Q5QE
         emKH4KNNZSRypTMogJYe/SsziI13ZVYOxFEAl1CbJa/rUGS4MC1Ykc/2m2EPKMcSRZPk
         RY+APXYKwCamwMjBptkTb5BoqrZxnVuICHTqWHwS6KrtY2RodEH/UI6GZ064zxioUtin
         g6O7qkBl3HbNfWTnLWbcGtyUH3YiKSWvb5Ms/HoObds0iwhZ2BOFpxDpULYzBHy8ttuR
         reiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J8jISmyNAteygIMBkJ9T1I60XISO/IrlILiA1G8EDHI=;
        b=OtRruJaNzDDIwM31/bupiCVpNql6bL/NMZPYILqd0O3KH81MvlYVpXqjWfNv5BSrgo
         XVDOR9ih2M3breti6/6nqY7S4BU7EnfPzvOBP//+NHLqOs5VvQykKWvfTcHRK327N08s
         RVMsFBR062TudM4fWwnuoIJPZLBULKXuJdwut4g573K6azmmiPbN/Euj4WUwvWq9Z0xZ
         oKAVg2rnSot9OOB0RwoSc3vnzcGDU9LjgXffFAY3oQJc7lbaeKoAXEzfuCCPh850ZHGQ
         Zw9fj5g4fHI4Qr5lVabQFZSOFECT4SzPUi0FpHR28MwFimCA7ozsItqAW0GrXCiydswB
         XopA==
X-Gm-Message-State: APjAAAWD2KizSkZ2tOgogwT6brdIW+Sx1G7JlGQT8Dsn8gIES3ESwJqH
        WNACWQSFLNPcQa9eKATOxpPzQRdT
X-Google-Smtp-Source: APXvYqwf9VQpic/pJZXmEgx2Bm9Cypahwu71r2FjKTf5lwAUj3DVfZbfACtXeMQlt0Asa81NKgu3Wg==
X-Received: by 2002:adf:e485:: with SMTP id i5mr7326718wrm.175.1567633110234;
        Wed, 04 Sep 2019 14:38:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24sm217427wmc.25.2019.09.04.14.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:38:29 -0700 (PDT)
Date:   Wed, 04 Sep 2019 14:38:29 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Sep 2019 21:38:27 GMT
Message-Id: <pull.133.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Teach git reset to optionally read the pathspecs from stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Especially in 3rd-party tools, where the shape of the repository/worktree is
unpredictable, it is a wise thing to have an option to pass pathspec
parameters via stdin rather than via the command line, as the latter has
size restrictions that the former does not have.

Johannes Schindelin (1):
  reset: support the --stdin option

 Documentation/git-reset.txt | 11 +++++++++
 builtin/reset.c             | 45 ++++++++++++++++++++++++++++++++++++-
 t/t7107-reset-stdin.sh      | 41 +++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100755 t/t7107-reset-stdin.sh


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-133%2Fdscho%2Freset-stdin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-133/dscho/reset-stdin-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/133
-- 
gitgitgadget
