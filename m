Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B1C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiCLAKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCLAJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:09:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2DD2272C0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:53 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t11so15200299wrm.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=N1UZ4b4kNCG5MQ7DOblNnbP7KH/VJMAJn8E+sdPKOOmp4Tm9yClXUV3gwk0paW8DM0
         3dCUqOCKUamlDGH43Pt9zUrqpIQaYi1AO/LvU8XEa+3hOwLP3i24zG9lSXsHaE3GkIUS
         mQBgpqUj02thHGI7VKoby+i4z3nQ0TOmwP/vFl3xk6BnCbp4P1msj+tGDAZnHinmN8X8
         CUJ8NIPa3aF2xn9v9HqSbZPoQ7IcjEfXyH1GuFIHd8nhqHX/1oXjM5udEnz9RWBCRGB2
         s66iG/m9zX+2IgBFS3ht6ndfntmMSimhMiw6NWk/Gasw1jeGe4PhKYlwD72VqYPUy42I
         Jynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=0oXZEyYSgWvr/l7k2ovSjTJ/vSW9G4cCQafu54YEXBvc8t7ugKV9CqWGyEV45CDKl8
         KrvibaW18jQhLG0QfGVq/3qE+3rWD5Vmo/yLTwhf/kqtx42mfzo54krwamZPjsDNlPc8
         C8t6XrAFFap3gx51m6VFAeaSUgzP4smg0wci2/Cq3LK78MIxamxC5DpNRA0Ijx8kG3d9
         91WO/M3cpPDmU3tJwNhwNKtfmDYPQfu0auVan2ejZhYG/YZR1QhOJ/z/bG8BjAp0f+Mm
         ih+gA5iT/hUkAn/Y9gsGvHpj1aCF8LxpPtZGlzYM6/C8Ig+OSgppnmtERV4VKa7vBCFJ
         uRAw==
X-Gm-Message-State: AOAM532c6EiDVHwAGYXX0KQDIU4VJwM9sJ1xWLrfkK1bLNGdD+52ZjBS
        BWS+WoN9pIOI5NYe5X1VcxJ/QZbYlT4=
X-Google-Smtp-Source: ABdhPJxWnCF95PY3LP8KsqI6G6N6AxKBW1GWxPaYzAF7EDJNIV807/cdpw4HOVsKrwpH/viaHWV2Vg==
X-Received: by 2002:a5d:4441:0:b0:1f0:882d:77e9 with SMTP id x1-20020a5d4441000000b001f0882d77e9mr8791526wrr.718.1647043732035;
        Fri, 11 Mar 2022 16:08:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm14110488wmq.40.2022.03.11.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:51 -0800 (PST)
Message-Id: <7206ef8dd8ab088feab841c5574d486b6f19af5e.1647043729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:45 +0000
Subject: [PATCH 1/5] reset: revise index refresh advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the advice describing index refresh from "enumerate unstaged changes"
to "refresh the index." Describing 'refresh_index(...)' as "enumerating
unstaged changes" is not fully representative of what an index refresh is
doing; more generally, it updates the properties of index entries that are
affected by outside-of-index state, e.g. CE_UPTODATE, which is affected by
the file contents on-disk. This distinction is relevant to operations that
read the index but do not refresh first - e.g., 'git read-tree' - where a
stale index may cause incorrect behavior.

In addition to changing the advice message, use the "advise" function to
print advice.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config/advice.txt | 4 ++--
 builtin/reset.c                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..971aad2f237 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -69,8 +69,8 @@ advice.*::
 		merge to avoid overwriting local changes.
 	resetQuiet::
 		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to enumerate unstaged
-		changes after reset.
+		when the command takes more than 2 seconds to refresh the index
+		after reset.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/builtin/reset.c b/builtin/reset.c
index 6e65e90c5db..a420497a14f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -525,9 +525,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 				if (advice_enabled(ADVICE_RESET_QUIET_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
-					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+					advise(_("It took %.2f seconds to refresh the index after reset.  You can\n"
 						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
-						"to make this the default.\n"), t_delta_in_ms / 1000.0);
+						"to make this the default."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
-- 
gitgitgadget

