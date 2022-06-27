Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA990C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiF0Sgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1D186DB
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so14247123wra.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N6bHGRGDaDqRNIxEMtB8llvdLvD5v5KCgVYAs2psvhI=;
        b=OVxKD6Dm5jfr0Tbp5Ax7x3GBsOp9UlztpP6no4qdt6bk0cCGlkyFmeSHlOo0oyz2PS
         AMOn/H2M1yjRpe5C0jQxDgCaXxSNjug0I4Llb1JlV2Oa8r/qcSLwRQQtBQ0soYicSlpf
         dfF5PtfCMozGAxUzOTlf7kiaLH//uqrGJkA/8Qw1HEK0nFej3M0paHebWp+4YqHhTuEN
         mHb8h/B6qJyFM+5Y1UQVQPzmGGvfaAjmLGH8MfAX2dNB2p7pkzvKum/kwkKoA507xSsS
         lgNDe7E1FDy2f9ZXZxE/SP9huwUWT/EoenEFiVuqQ8yds8REud3EzWO1XCOdjKTOOtX/
         AxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N6bHGRGDaDqRNIxEMtB8llvdLvD5v5KCgVYAs2psvhI=;
        b=heBSLIxPEHk1BMzprvshoF/jRxmnf4cJjs5YeB16SZEQ5EDByr+Kzx91prtOVOUAeR
         5PLKi0x9tCUeaUD/RZDVeteNT/QvKnphrh9favtoftDDZNCkya3i17Z6ht9CdzBWDsk7
         oCYZjBrk2259rk8buVIMZGTyRuV0CPMztY8RHk8cMknp29KwoUp3jB/OhtCpyf/KuY2R
         Hi+koMamgiPQGPteDHfy1kJHuYx52QM8VoWO8Hq4y99Bi19/FEdwnQ/m7fviUPFgWTWX
         hv47HSNidS5jj3Z6rwSmIQPQj9158ZYFW2QksFInnCv8LkuWsxQCyzJURyl4F7kpkYhi
         S5mg==
X-Gm-Message-State: AJIora9pUpleLPjcaJSLziPsOrXt0FHsXBlTlhFdooixStJW2dp6sFgV
        CBp/tY9JK8bLgUTpRSo2oyaqsbyzVqpdNA==
X-Google-Smtp-Source: AGRyM1sKF+whTZhI4KHVhyfOo0YuPy/UzRShWvMrln3aOQcl3hT42vDdLR51W6ZjmZ1MPJsuHE02CQ==
X-Received: by 2002:a05:6000:1acd:b0:21d:1079:e94 with SMTP id i13-20020a0560001acd00b0021d10790e94mr4079541wry.122.1656354682881;
        Mon, 27 Jun 2022 11:31:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020adff4cd000000b002103aebe8absm11142808wrp.93.2022.06.27.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:22 -0700 (PDT)
Message-Id: <5571e0f76ffd531986bf6c03b99bb34d00815fc3.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:04 +0000
Subject: [PATCH v4 03/16] bisect: avoid double-quoting when printing the
 failed command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already quote the command via `sq_quote_argv()`, no need to enclose
the result in an extraneous pair of single-quotes.

Pointed out by Elijah Newren.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index cc38a009bdd..2345c9f773e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1223,7 +1223,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			break;
 		}
 
-- 
gitgitgadget

