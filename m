Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B941F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBHQU5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:57 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50885 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeBHQUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id f71so10490501wmf.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rRMzb7/74bOPaX0oAEnWPwBVs/b5ATRqlH9AUtsCxsI=;
        b=JBPsAWVvHBj+fYfg7v6jghNn29eEgijloow/3BhoRpQsyes3IiKVDspOqZbFbuwBdw
         +CPrxl1ydu+Hc9qIN5P6z/RqSPiYOocieahHmLOASuvUF78rBzu8cabpanwQdoRu7zlF
         KEhHf+V8qjBA7I9xYUksAvFNQSuJLZfoHsEhPCMWtJlEH2o2VB6w6IuIpadcgBIF+DB6
         n0sEvCqPDVIb47YVMKxOuRyIWY8IzcCcHVP0Lk0v1VI4DZtMhKpQEITPpPykwqd9R1Ih
         2LQlBWWN6VQSE8eTnGAdomBxy1mKVsLbL2rOSZWGcFuPohLXZQEESV/l7IYtT6mDY7N+
         MLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rRMzb7/74bOPaX0oAEnWPwBVs/b5ATRqlH9AUtsCxsI=;
        b=JBnviuXJY5R1CwA9Nxo6x9sOdsz4W6TdXWiK82TtqsGGwVa4LNSrJxOk7TlIJfZqjZ
         Wo6fHN3qFwtnL2vo0IUJlNupMD1ayMLYKcOyqSlhMdfwVbE+QYOxvbyE0/D5lp2DD1xT
         2SQ8yOyaI+7SZrFI1j183ScCvVL+pFMkk/17wf9zfPogkX62BJChka2G65r0bYxF6aLB
         08JkxpeTBPiTWxKTz8ytm/1mFzQ8I8DDsJlP4NQW5edtsDAbRA2/DdckWeli+M5SgB32
         TQNb0XrKP7tMvim0C1xj26zyN40rmdpdocc7/GZ1hUgcAKt2bvqKODyyKIgqasbIzzsS
         Xbqw==
X-Gm-Message-State: APf1xPB9DbojxhYMBTAQfOfbAmXiT431dvRv5Vz4AjgQ5bgP85hD+2Hz
        d4y4WUozq50lEV5MJ14qKZz8Rn7W
X-Google-Smtp-Source: AH8x226kE957+YpOouS/hW71S+IwoWSIv1guY1UV/GmY9HmpUDYu49hsWw0Z19WMfimsncbAnm3Kcg==
X-Received: by 10.28.191.131 with SMTP id o3mr1459424wmi.81.1518106819119;
        Thu, 08 Feb 2018 08:20:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/17] fetch tests: expand case/esac for later change
Date:   Thu,  8 Feb 2018 16:19:29 +0000
Message-Id: <20180208161936.8196-11-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand a compact case/esac statement for a later change that'll add
more logic to the body of the "*" case. This is a whitespace-only
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 88d38e0819..dfc749f576 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -543,8 +543,12 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 set_config_tristate () {
 	# var=$1 val=$2
 	case "$2" in
-	unset)  test_unconfig "$1" ;;
-	*)	git config "$1" "$2" ;;
+	unset)
+		test_unconfig "$1"
+		;;
+	*)
+		git config "$1" "$2"
+		;;
 	esac
 }
 
-- 
2.15.1.424.g9478a66081

