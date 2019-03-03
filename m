Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D8B20248
	for <e@80x24.org>; Sun,  3 Mar 2019 23:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfCCXi3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 18:38:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCCXi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 18:38:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so1617909pfh.4
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 15:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGO0xUY5FkUz9gWT9LeZjOVtvDIsPfwpSc1/+YeQNYs=;
        b=SJnOtEPQNDFJa0BXUJYfazB7/+SI6O9NAZdPw0R1ztcIvSBkN0edUGNwGPCKJmeOIY
         JPepoGMz4VlEJI7aCCGYpZb86IpWKEKsmWZCrRvUlQqs3Cg4AwZIbZPgKp/kGGPyMXDD
         Jc/jAfI398d1Le2p9ax/7eWxWUa861tA/KfCBsnTlWhj0IbhcSgmbuKjx0ogpTBaj+0C
         BGSJTuc0wvJ/+IofLLIEbFZS1dx3cSC2qOt8nFtKhMQ6EM000hkoX++urbZ6kMq/RJis
         zIgGq2kbTicGefmdGRizQP+6RhAPvTMK5Ngu0uSqA94byvypVfmmQFVGrqM2zEFQ9qSX
         BtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGO0xUY5FkUz9gWT9LeZjOVtvDIsPfwpSc1/+YeQNYs=;
        b=DJjJevpZVFFtjvt5Dp35XW9/YvYaa2BiJsw+jbuPo5nnZA8LFZMelgGD/EOB4DCEIc
         hYndMeVPnbpLr4LM+wffgmPG9jculVfH5PUa6te4qnbHHazkQN6QdQH/vc0OMtobrb1A
         w7sGBljsSQnDLzKfTBONdnbOW+MXxDirSeLxkWWls4oiAxDJz6lckauzgXVODA7xwAw3
         oHO9GQDCcOCFRva23i/GgEQGFz4gxtSFOrMmzCz61GjcFHHNOLum1jn7v3c7QWaociCh
         0gPrDibkRIrE6dtq0YhtP4lqKsCvfrB+ihY78Yb8R1W8GLVAwCufiphBZJGdDFe4zJiN
         CUXw==
X-Gm-Message-State: APjAAAWbyxNBBC2i7BuZL00Ff8aXfa3DMkw3ARsAv3pHKoT7SpunpRGx
        G0H/dYBvGaIoG/nglhO22YQ=
X-Google-Smtp-Source: AHgI3IbOCT6vynJAhZZMDApnB9ccJvoNoFKwbGrgQMIGP/TOtKjE3DPqvbq1M8v7kfY6aCpclXnnnw==
X-Received: by 2002:a62:5e46:: with SMTP id s67mr17132419pfb.126.1551656308091;
        Sun, 03 Mar 2019 15:38:28 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id y6sm7284579pfy.87.2019.03.03.15.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 15:38:27 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 1/3] test functions: add function `test_file_not_empty`
Date:   Mon,  4 Mar 2019 05:07:48 +0530
Message-Id: <20190303233750.6500-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-lib-functions: add a helper function that checks for a file and that
the file is not empty. The helper function will provide better error message
in case of failure and improve readability

The function `test_file_not_empty`, first checks if a file is provided,
if it is not then an error message is printed, skipping the remaining
code, if <path> is indeed a file then check `test -s` is applied to check
if size of file is greater than zero, failing which another error message
is printed.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/test-lib-functions.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..f9fcd2e013 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -593,6 +593,21 @@ test_dir_is_empty () {
 	fi
 }
 
+# Check if the file exists and has a size greater than zero
+test_file_not_empty () {
+	if ! test -f "$1"
+	then
+		echo "'$1' does not exist or not a file."
+		false
+	else
+		if ! test -s "$1"
+		then
+			echo "'$1' is an empty file."
+			false
+		fi
+	fi
+}
+
 test_path_is_missing () {
 	if test -e "$1"
 	then
-- 
2.17.1

