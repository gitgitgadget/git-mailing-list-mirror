Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3FE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbeLTMJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbeLTMJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so837972pfi.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O+pHHA5blM61VcTqYhofvaCIIXNhj06kpTey6MuUjCc=;
        b=V+lDJhKJb8YUj0xeFZ4FADCM83wLwMRtE3l8vZlReSz+sZPZxlajtlRDbTv4ocLNex
         46DFAVH5iZ25by7QOpceuB6gTVvgurN5jBbYJ1jdwvVo627jhuX83OabscM+pSIDJ6v6
         x7wih7IgOAiRUu6Kl8tWxY+hytkyfsTh2R+py/OY+42sH6zkYCwhihy7/fM8Gl6y6ATK
         5eFSKBkMj+8SDwNmyvv7ZIEy0cMpjWp8tKzQ34lpRYGVsxc58w48utJL3BmxU9KS7Ege
         F9qarTDaVpaZJyabfF7enBDDbO6xJAFP9QCJ/S2m64Ptdn9mLaNvL4cUNfXADLIKTql2
         IGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O+pHHA5blM61VcTqYhofvaCIIXNhj06kpTey6MuUjCc=;
        b=QoXvPUF7bDzVvxL4A/kPcPW9M6njQUJrJi7h8eSDWZcJU4kyC5m8ALdmB7smRfggRA
         g/toJtK0P4qw+jrbQTAz1JezqEyALfu1/HUzlWkt5NfGPA/7GxIW/9rEMisrN+MitGUi
         MUA4u13nfre9OnDp7P50MM0nrPRFNXMq4H0h8lX36FvkfbsSsavXGFAoU+eB/GJw5Ntm
         bWRG2aEKUr0ow1nItTP2AJ3+oRpQfSXgpEHFf216MgWkrEeZI3jCB8aJc3hJyZsTxmDM
         MOr/C5rIHcvDPVc+FNv/gbcahulyKG5Jdw03oPc1wet3CuwKEbQkxaK07KXWosE1iWB1
         TFUA==
X-Gm-Message-State: AA+aEWbcaUBpvtunLi1KLdDtyeM6aNhn1LtJHZU9gMQ76xW8+ptkGurH
        QRr+oPdMvZiU/gx/53d6SPQuGlXy
X-Google-Smtp-Source: AFSGD/X+9N0SKgvugbojJ1OMqJ/ICXqimmPvvju+2dUy4eN51hhyfWi4Z1GNp9hwDG/70LOYdJCIEg==
X-Received: by 2002:a63:4456:: with SMTP id t22mr23388607pgk.0.1545307764371;
        Thu, 20 Dec 2018 04:09:24 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d18sm28791872pfj.47.2018.12.20.04.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:23 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:23 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:11 GMT
Message-Id: <4950c889aacd869a8f4fd30b8d5cde4b43957347.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/7] add--interactive.perl: use add--helper --status for
 status_cmd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Call the newly introduced add--helper builtin on
status_cmd() instead of relying on add--interactive's Perl
functions to build print the numstat.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..a6536f9cf3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -597,9 +597,7 @@ EOF
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	system(qw(git add--helper --status));
 }
 
 sub say_n_paths {
-- 
gitgitgadget

