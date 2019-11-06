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
	by dcvr.yhbt.net (Postfix) with ESMTP id E39911F454
	for <e@80x24.org>; Wed,  6 Nov 2019 18:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfKFSvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 13:51:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34780 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKFSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 13:51:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id v3so3009251wmh.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekjt67vQTBMrFAQ1564rDVcuyDGLYVOukXLMQrvOH+E=;
        b=L6z1qj0gWEpYPJO+x7nJB/6OD7jiAuek+K45yVw9Lg+pw1DyqjFrXJ660jVAX3sGAY
         ptlOA0Faud39FBdCeoPb+wCxoLTHIgYRnrpXxUi+IS4fmO6mbZz/tR+ZJOJ6OkfYxN1c
         iVcxtDBZnvFWebayDJsVKslEs3PeAv+XkjMhjE/eJIeLdnFaLoZPb9yjYuNpItwg0vFA
         fvHn31fO6ABRN0ymLtjPAe9yrAxyuEc8Sn01Of/xqo6/x7JC6b4TIb/fFkxdy+q4Xq1i
         +3qqoQIRbkSZLE91CVIS1w8eHE5/10D5S4ACOQ4canp/MATlN787qf7SoWluxWpc1yop
         ooKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekjt67vQTBMrFAQ1564rDVcuyDGLYVOukXLMQrvOH+E=;
        b=Rk0WaZcocyrwmjWwhglXfM7Hj7I0NIAHf23c+rN+QCML7JrUxATWdkzcYJ4CWZS+ls
         fuah35zq1dOgGtOB0MJKKc+fK2rYJo3FiE12XKmNVtV6r+I/iQnlDsp1JHWaV+BFGaeL
         f6IX3vQukTxbfuqZRzQyjopZpE29hMn/KSXX7LsYam6ftyZ9KzPDneSAMuUHWMxJcqxa
         AGT6+4G1DcOYlftzOx5noidWuwuQdoaxo5qsxOztkvbCcba/AQwKajqbb4EAlaTQ//ZK
         Lk7hfbO+ZIgUdd9QyK1aTlax/6xIYRJlx8TaSpZ5dYWAgFWet7sid08TEz1G4HtDweTy
         TVMw==
X-Gm-Message-State: APjAAAXRoN2KOL52F3KNNI8rZqewb0z6W7+6+NqqPxkIF1wS0uSREU0u
        dkZUIGs3y+gIPB1j+L7hniH1Kzhz
X-Google-Smtp-Source: APXvYqyzAhTWBkMIvKTn/GYVu5FsOs1ocU2nF5hGpBbxnp8pIbEE2cldmW8qG6biDYPWnDIxShhHWQ==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr3606024wmf.24.1573066301796;
        Wed, 06 Nov 2019 10:51:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm26611726wrc.84.2019.11.06.10.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:51:41 -0800 (PST)
Message-Id: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.git.1572981981.gitgitgadget@gmail.com>
References: <pull.451.git.1572981981.gitgitgadget@gmail.com>
From:   "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 18:51:38 +0000
Subject: [PATCH v2 0/2] fetch: add trace2 instrumentation
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

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

* matching common remote and local refs
* marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

Erik Chen (2):
  fetch: add trace2 instrumentation
  add whitespace

 fetch-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-451%2Ferikchen%2Ftest12-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-451/erikchen/test12-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/451

Range-diff vs v1:

 1:  4fdbb9f504 = 1:  4fdbb9f504 fetch: add trace2 instrumentation
 -:  ---------- > 2:  606756d7db add whitespace

-- 
gitgitgadget
