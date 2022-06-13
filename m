Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E59C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiFMPjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350736AbiFMPi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 11:38:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C3157EB9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k19so7080829wrd.8
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2StqKQ6yDZeblOPKDMXNkYKypA2ex0BiUGVOjqSB0tI=;
        b=eqJ2H1hfWkrZ7Byatq46jKf3VmlDidewRXtFRD5YPye6npzutQRwC5Cu2AEYkz6xlm
         mDN9tyRucSaPA/moLBkUUVgouevQn02xnVWIM3upJwSnNZ9ecNYKqLdovmDEPIHDYkCF
         s92J6Bl0CFYUbbPfA6sNNCI9AlneHg6wjBDZWnxlXjU62jyIIgKlZZGXggPNNFB2qRvZ
         h4Dg/Xd8lE7NhhERFWdK8+GN/Bv/wD2NnnZyLiCAPv8KbhyX/tXMTU4fLo1bqPwBuWI1
         qDeCLAm5/O2hskxQjKxs9Mg07WZCvAKS1+p1MOnPLQkcUeHHgjCTV2bK4iN640qq6cCn
         w7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2StqKQ6yDZeblOPKDMXNkYKypA2ex0BiUGVOjqSB0tI=;
        b=FBb7uzYcpU/KO4IKU5njGCPb5686iHn0kIaI2RbIZ2EcXEne6C1S/y2MD2tt+TWJxU
         C6xBlL5+vPu9PMzJeKLos1+S2MQ9Ua8ek/0DDq5XFI3yHGhcNftoajoIS7xXtazlJPNR
         OdBlGiahGOlOcgsgFy/2bcyWenV5ruci7TSEetgoBmnw6QGf0Jx5rlQc1yooBk38ifSN
         am02x8yTo+E9gVOolK3UqRdIYyFXK8uE+AIEoEcR6dEvX6ZV/4bFmUEqsZwYfZWjArPq
         akUCgcZdlpwk+JHl5orI+PEqQzQlxMVkP6dzfx3/61qW/9g2FSJjt75VrySui/a/+SHL
         QY8g==
X-Gm-Message-State: AOAM533pqd9+4PxIgtVYbvXy2u2R/d5LLxKksvoP9TYCTZAdPW2z6idR
        CdpnAmRkJJskI8vGGtgYeKle6KUdZwXlFw==
X-Google-Smtp-Source: ABdhPJx4I40q7+FOQXAE8VI3jiTD4UGdW9Pz0sKpLWV8dreh2EcORdZGNoODslfApKkHhy6AyZFvvQ==
X-Received: by 2002:a5d:498f:0:b0:215:4d13:477e with SMTP id r15-20020a5d498f000000b002154d13477emr48698528wrq.155.1655125992841;
        Mon, 13 Jun 2022 06:13:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b00213ba4b5d94sm10246228wrm.27.2022.06.13.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:13:11 -0700 (PDT)
Message-Id: <34daf06bb710434a2392b3cb91d35047565d5602.1655125988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
        <pull.1253.v2.git.1655125988.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 13:13:08 +0000
Subject: [PATCH v2 2/2] ci(github): also mark up compile errors
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When GCC produces those helpful errors, we will want to present them in
the GitHub workflow runs in the most helpful manner. To that end, we
want to use workflow commands to render errors and warnings:
https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions

In the previous commit, we ensured that grouping is used for the build
in all jobs, and this allows us to piggy-back onto the `group` function
to transmogrify the output.

Note: If `set -o pipefail` was available, we could do this in a little
more elegant way. But since some of the steps are run using `dash`, we
have to do a little `{ ...; echo $? >exit.status; } | ...` dance.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2f6d9d26e40..aa7e979a0bf 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -29,8 +29,14 @@ else
 		set +x
 		begin_group "$1"
 		shift
-		"$@"
-		res=$?
+		# work around `dash` not supporting `set -o pipefail`
+		(
+			"$@" 2>&1
+			echo $? >exit.status
+		) |
+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2,line=\3::\1/'
+		res=$(cat exit.status)
+		rm exit.status
 		end_group
 		return $res
 	}
-- 
gitgitgadget
