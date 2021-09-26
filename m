Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A045C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6560FC1
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhIZQAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhIZQAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 12:00:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C9FC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 08:58:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so44441312wrb.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0kzOMWLLbCho8w/fAADwvgy3ak4MtXKkHs3FDjX/fiQ=;
        b=YjBBICCR+1JNFZlwfMLvavm0yZWwP8lPWb7mprbLvzSMAorR2N5S47tNuji2QqaySR
         rRrcn+wklrUEKS8JxF7kTUZLEkh3Cc7wbmI0J34xYXclaJurYSk4HYNx1TjsI3QDVto8
         MhGHd9cqtKXUhyZY0oFth8u5I63AAsW82lony/mqHgzUG3vKG5O6v/oR9268tyi4Xwhy
         Qc6277t27iMU4dRNqet3e2c27eBm6zMuRqnhbO8hPHj7rEhAX/xGVfhQttxQokJjU29I
         0OrgL1cED2eQD/ydiWO1NJo4OMntJT4NT1KMssk96qlWBJrgRxHUtTFeVMACMjtntGcY
         QuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0kzOMWLLbCho8w/fAADwvgy3ak4MtXKkHs3FDjX/fiQ=;
        b=NQUNcFadM6+IsEh3iRuIf6DujtqjIKyg1AHIO/mQ9dd1WVZpPH2adnvCIvSGNCG2Uy
         dGmTM3eB8cf6+g4OwS55gJ+BTy3Hh8vzn5L3EgaroNOeVmWyVxAJdkY4eud+F6vr/JtW
         OG8yw73ZU+fZoKCwjG3v3Dmp+HIDcJRFS0QxEfxnZK9ERMb6aE86My9zVs8rrBCPMXZU
         lIDCmvnNflmtvLkYdBclxgMtW0mK72hqjfhqS3a3LL9/5kLyDF+75LDElM0xLXTrWoK9
         WiLBIOAQ9suoJaybJH0Z84veS3mst/WJgyvs37STY+Ap1rg6GPdqXOWhaJ7ZTP+/Ql5P
         WR1Q==
X-Gm-Message-State: AOAM533ADo1mK+bKFmHMO3LAEEwTn5hTcY/Euq4sWwS5q1NfhP3b6QYa
        hvBfVGuPnXaTW+5jHODNQN1ChlsxAnY=
X-Google-Smtp-Source: ABdhPJwOBoycu6TDrDmNdMbYDSX233gPV+rTVE60I5DLaK308R19cvX1IBgYxGZ8wQHjBBrR/Mxxag==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr22627162wrc.227.1632671914685;
        Sun, 26 Sep 2021 08:58:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w23sm2972467wmi.6.2021.09.26.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 08:58:34 -0700 (PDT)
Message-Id: <pull.1091.v2.git.git.1632671913693.gitgitgadget@gmail.com>
In-Reply-To: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Sep 2021 15:58:33 +0000
Subject: [PATCH v2] connect: also update offset for features without values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <andrzej@ahunt.org>

parse_feature_value() takes an offset, and uses it to seek past the
point in features_list that we've already seen. However if the feature
being searched for does not specify a value, the offset is not
updated. Therefore if we call parse_feature_value() in a loop on a
value-less feature, we'll keep on parsing the same feature over and over
again. This usually isn't an issue: there's no point in using
next_server_feature_value() to search for repeated instances of the same
capability unless that capability typically specifies a value - but a
broken server could send a response that omits the value for a feature
even when we are expecting a value.

Therefore we add an offset update calculation for the no-value case,
which helps ensure that loops using next_server_feature_value() will
always terminate.

next_server_feature_value(), and the offset calculation, were first
added in 2.28 in 2c6a403d96 (connect: add function to parse multiple
v1 capability values, 2020-05-25).

Thanks to Peff for authoring the test.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
    connect: also update offset for features without values
    
    V2 incorporates Peff's test and test stability improvements, and
    attempts to improve the commit message.
    
    ATB,
    
    Andrzej

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1091%2Fahunt%2Fconnectloop-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1091/ahunt/connectloop-v2
Pull-Request: https://github.com/git/git/pull/1091

Range-diff vs v1:

 1:  dcbb05ddc4b ! 1:  908e4e6c4ed connect: also update offset for features without values
     @@ Metadata
       ## Commit message ##
          connect: also update offset for features without values
      
     -    parse_feature_value() does not update offset if the feature being
     -    searched for does not specify a value. A loop that uses
     -    parse_feature_value() to find a feature which was specified without a
     -    value therefore might never exit (such loops will typically use
     -    next_server_feature_value() as opposed to parse_feature_value() itself).
     -    This usually isn't an issue: there's no point in using
     +    parse_feature_value() takes an offset, and uses it to seek past the
     +    point in features_list that we've already seen. However if the feature
     +    being searched for does not specify a value, the offset is not
     +    updated. Therefore if we call parse_feature_value() in a loop on a
     +    value-less feature, we'll keep on parsing the same feature over and over
     +    again. This usually isn't an issue: there's no point in using
          next_server_feature_value() to search for repeated instances of the same
          capability unless that capability typically specifies a value - but a
          broken server could send a response that omits the value for a feature
     @@ Commit message
          always terminate.
      
          next_server_feature_value(), and the offset calculation, were first
     -    added in 2.28 in:
     -      2c6a403d96 (connect: add function to parse multiple v1 capability values, 2020-05-25)
     +    added in 2.28 in 2c6a403d96 (connect: add function to parse multiple
     +    v1 capability values, 2020-05-25).
      
          Thanks to Peff for authoring the test.
      
     @@ t/t5704-protocol-violations.sh: test_expect_success 'extra delim packet in v2 fe
      +test_expect_success 'bogus symref in v0 capabilities' '
      +	test_commit foo &&
      +	oid=$(git rev-parse HEAD) &&
     ++	dst=refs/heads/foo &&
      +	{
     -+		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
     ++		printf "%s HEAD\0symref object-format=%s symref=HEAD:%s\n" \
     ++			"$oid" "$GIT_DEFAULT_HASH" "$dst" |
      +			test-tool pkt-line pack-raw-stdin &&
      +		printf "0000"
      +	} >input &&
     -+	git ls-remote --upload-pack="cat input ;:" . >actual &&
     -+	printf "%s\tHEAD\n" "$oid" >expect &&
     ++	git ls-remote --symref --upload-pack="cat input; read junk;:" . >actual &&
     ++	printf "ref: %s\tHEAD\n%s\tHEAD\n" "$dst" "$oid" >expect &&
      +	test_cmp expect actual
      +'
      +


 connect.c                      |  2 ++
 t/t5704-protocol-violations.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/connect.c b/connect.c
index aff13a270e6..eaf7d6d2618 100644
--- a/connect.c
+++ b/connect.c
@@ -557,6 +557,8 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 			if (!*value || isspace(*value)) {
 				if (lenp)
 					*lenp = 0;
+				if (offset)
+					*offset = found + len - feature_list;
 				return value;
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 5c941949b98..bc393d7c319 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -32,4 +32,19 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 	test_i18ngrep "expected flush after fetch arguments" err
 '
 
+test_expect_success 'bogus symref in v0 capabilities' '
+	test_commit foo &&
+	oid=$(git rev-parse HEAD) &&
+	dst=refs/heads/foo &&
+	{
+		printf "%s HEAD\0symref object-format=%s symref=HEAD:%s\n" \
+			"$oid" "$GIT_DEFAULT_HASH" "$dst" |
+			test-tool pkt-line pack-raw-stdin &&
+		printf "0000"
+	} >input &&
+	git ls-remote --symref --upload-pack="cat input; read junk;:" . >actual &&
+	printf "ref: %s\tHEAD\n%s\tHEAD\n" "$dst" "$oid" >expect &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 4c38ced6901a8523cea197b31b2616240ec9fb6e
-- 
gitgitgadget
