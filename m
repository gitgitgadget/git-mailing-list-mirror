Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406811F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeBIUcz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:55 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44517 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeBIUcy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:54 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so2670250wrc.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rRMzb7/74bOPaX0oAEnWPwBVs/b5ATRqlH9AUtsCxsI=;
        b=ab5hilcS2e0WWdHsxOIApJhopIm/+qNeCs3Fnmslzxa06DXQLcSL06FpWjUiCeeRgF
         rUyg98G57xSSYbYlf7AcwkbqRUPpkLcNJB5CS46n6uonyq+u+Tz8wMFjhaZtmF64fY6S
         sn6dMtQhRlJ4JLgueWwb//CSRHPmafCViAdsr0YHLZqJuJdDqQjuEmmBeugR15Une/qE
         vpAsbrP6EP7NN9sfpH/4Z4VuSspDrDkuhXH1Vq/u6n+ykpeA1xlJoUp4VRyAZ14YbnQv
         kNZCG8Xgd3qNeO57PkjxpCduEbaupiXx9MJkPwhFXt8SpmYcn3nJmC9sEPjgny4BM1Ji
         KmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rRMzb7/74bOPaX0oAEnWPwBVs/b5ATRqlH9AUtsCxsI=;
        b=Tp22Y5ZQqPwAzh6JFFR33CL3Fo9pLvWNNBAsUCSCCb0RqAF3hn4QEfrjd4+559+tcG
         NFCoGMMfCRlOpu6FMGUpIiSw5uCL1Ld6Tmu4/YQIpHxnNkkH4EcwXn4Ar2r4JZEE2McL
         ayi/SlmA4fk4bXSIb0ZTu3Vt36XVNpdQ4MqjkhVMDNbReBIYuWKOI/WxsEmATvCOvwmY
         pISuGiANrg8lwJFTsc6nKvNkwIPc2mmjex4SCyNGxL1jVyjhi8r2I3VFrGqdlxL9vd1U
         8wKNq24cHyfdn3F4XRRuVS5MJ7Nu6X0qnaYW5RbO9qiMAVZW/y33XTq/h2pLfvFxvXWE
         E8iA==
X-Gm-Message-State: APf1xPCKb0pZX2cY5pOjMhuaTaZGHhlm0J4gUgHPgiDJr8u2r0RrN0ke
        PpfmSEIvSvwf3QzAFG8BfMmv0imH
X-Google-Smtp-Source: AH8x224B/8Q37gDjq4q2Epsue+lY/X8mYCfHRvk0/ORo6FOW5Ui5rEK7bD7baWYZYWiYnCxXK2p7dg==
X-Received: by 10.223.158.201 with SMTP id b9mr3328554wrf.192.1518208372618;
        Fri, 09 Feb 2018 12:32:52 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:51 -0800 (PST)
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
Subject: [PATCH v5 10/17] fetch tests: expand case/esac for later change
Date:   Fri,  9 Feb 2018 20:32:09 +0000
Message-Id: <20180209203216.11560-11-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
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

