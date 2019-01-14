Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C056211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 06:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfANGLO (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 01:11:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANGLO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 01:11:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so7561556wmf.5
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sbwf+v9HnNnLhbc+/S7LHRbnJHvNyQBb6NH60KRzG7Y=;
        b=CByuafAfwSP4M3vwJ2PYB8UvyvJG2+0tGHt1x1OM9QONRTP9CfXUyST8bbzytArFSE
         AaunL+fSdPDw1AiyXtbLVgLIddm593dzXfQymV/TlZkSDUitnkxlBm9WunNRddVjHHmL
         Cuw6DfnicdOjlp14HBMhA4i6IjTIH3mQhbhAQou+7UEt6FZB5Bz9NF99H0tMAycwoM5k
         tAAsHaXofiifAKv25vClhiq2qSYvc+sAIPHNn7c/U7jJ74hTxapUh4MrzCF8jnUCo+PN
         An0G3kvqHbyIA5cQiP8h1HXg6b1NBDXCc9P4g5+OI0wu8Owb06Cdz9Hd3mzm2RRI1rOF
         60zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sbwf+v9HnNnLhbc+/S7LHRbnJHvNyQBb6NH60KRzG7Y=;
        b=oGhyu5EcGQ0Xb7ez5wSpK3WcyNSlB//zkBPUQxEN8l7ZyMSTRch44jv6u7TCWWko+0
         eDEctLcosoUoouDrV43JHzluc+qrTZLOWZS9ZM76/1VLvQJvnz+g2WurKhWTMhAdULLe
         aRVoDPdMu+vo02t0YhHEgIla7+2hN7bPxb8UgPFB3sm5/I5VMDeEHJotetrwYcuRpCwz
         iGUU7hxSyfjkPIy2xRyyFU+Qoh4D4WjD/KXZaqY/+40f/+3qVPZhO56UIQO9gNDhYR96
         oyZ8RilKXT13pYdfLLhQsFq2ASNw1TytSHfGohd1ni1WmriOS22HfeIx9VTeRSxVaIXK
         YXVg==
X-Gm-Message-State: AJcUukdZutNOZjxU8hBHseOo5aqD3Ouj/8UVeDxhL2HrKtQ8SyAfXYqm
        WLWYNMf6Z6nsH80Q+Z+X8yxxcXqQ
X-Google-Smtp-Source: ALg8bN5yvQN8BqccpzlrF45NOMXp20ZisTsSvPg4Z6+/VrF/4qQD5e9uL6Z3nS3+m6xBjgf/gNyMyA==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr10220716wmc.87.1547446271637;
        Sun, 13 Jan 2019 22:11:11 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:105a:2af8:35f7:f053:bef4:8540])
        by smtp.gmail.com with ESMTPSA id x15sm69487113wrs.27.2019.01.13.22.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:11:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] partial-clone: add missing 'is' in doc
Date:   Mon, 14 Jan 2019 07:10:52 +0100
Message-Id: <20190114061052.3380-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.99.g3004991f5d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/partial-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 1ef66bd788..896c7b3878 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -114,7 +114,7 @@ their "<name>.pack" and "<name>.idx" files.
   that it has, either because the local repository has that object in one of
   its promisor packfiles, or because another promisor object refers to it.
 +
-When Git encounters a missing object, Git can see if it a promisor object
+When Git encounters a missing object, Git can see if it is a promisor object
 and handle it appropriately.  If not, Git can report a corruption.
 +
 This means that there is no need for the client to explicitly maintain an
-- 
2.20.1.99.g3004991f5d

