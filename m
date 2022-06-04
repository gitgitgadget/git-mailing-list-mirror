Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4ACCA47F
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiFDLR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiFDLR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 07:17:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE6140F9
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:17:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q15so5353259wrc.11
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X5jufu0KHv3cSskIgAE0ac8TXDrgVBE5lhiJOG92Fjw=;
        b=It2lgngf+4yX4NwFqn9WVICKdbtMenJ1JcwxaKxpME5TEpXne9VTntxui+K8+0V7Ho
         PPtUbu2fZgubKVk1CvdIyUX5ZPyS8ZCPLDG+CzQShbCjBiZKb4btuEAOP1JgAbBaAJbv
         m0Q2IsUWANCoMMd5m44celZSPEkwX/26lRu1o2wPR85l1Uc/gSzVtVKUXSdm9YJre+Op
         dXFQmA6bC2AEFI+xX/bVl0jAsyTBjCI2ylCyFMmL8JpKdXazz0YJ+CriBsw+xHpDCl1q
         DNoJB5YJwT5BMAwQOx072I39kiAegG4fofuzkE7yUOL00v0x3ntrnwne3E+GxYI+JuQ7
         r8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X5jufu0KHv3cSskIgAE0ac8TXDrgVBE5lhiJOG92Fjw=;
        b=mNcRDA7d5nj3Tyv8/l4T9MoBWrGQsJmJuquzVmeGlzSCeg4fNjMtcL2EJu0PBFkKvY
         QM3FRAA5quij5mno3XFpb0wYNCWwFdIoNuY8v+b+8yMh5nA2/wJjpZSJbpJm5hq4fB+6
         GE2ViCAK1c1TlmODycsDQ3lZO7qW1ydmrsP/c3TqsSh780GgGEodf0IWib9Vqazpvfew
         msz2VHfo47qjqYawsbFgW5EZjKxgS2zh0hTxmO9S/2EFU8nLIT6adHPF87AeOayswndz
         JFA0Xy/qD5eTSDVFvoMRrnJZQyEv3to7OLicLKSP3tfNDZLik7MVQwufFGg2NKZS8spl
         Ek0w==
X-Gm-Message-State: AOAM530wnxkgABAAaSXx2LBvRy3UA+aULLKZ878rB7KUIsTPLxvmu55b
        sb1eYqz3HH2iF2sHlnl7N2KTUHCVEBy+QK6H
X-Google-Smtp-Source: ABdhPJyiz4sk01mngRVd4a6AfAaQIztUlJ2ZCjV+PRj0SjFZjhThKEQa7hHGMx4rcbjQNMtNZGMqpg==
X-Received: by 2002:a5d:4c86:0:b0:210:2e6e:3a93 with SMTP id z6-20020a5d4c86000000b002102e6e3a93mr12203464wrs.185.1654341472034;
        Sat, 04 Jun 2022 04:17:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d400d000000b0020ff7246934sm9989065wrp.95.2022.06.04.04.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:17:51 -0700 (PDT)
Message-Id: <d60ec67cb0673a9a9ed16c62f69e0a5235966ae2.1654341469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jun 2022 11:17:46 +0000
Subject: [PATCH v2 1/4] rebase.c: state preserve-merges has been removed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
this option is now removed as stated in the subsequent release notes.

Fix and reflow the option tip.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..bad95d98adf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1110,8 +1110,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive),
 		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
-			      N_("(DEPRECATED) try to recreate merges instead of "
-				 "ignoring them"),
+			      N_("(REMOVED) was: try to recreate merges "
+				 "instead of ignoring them"),
 			      1, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
-- 
gitgitgadget

