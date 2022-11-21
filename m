Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DDCC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKUDAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiKUDA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:00:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0EC2FC06
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b12so4111108wrn.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWo9OoIErwIDRMHSD9NwxmYmRFcrsleCZMdfGNNF5Js=;
        b=dSvInlYlycUoAhN25sTIT7ag8WiCNrnqruLZDcUFp5tMsAfoK4HFP5uzvGuJVdqPYg
         K2wrYf1zePV5xCaaGAbgy4P8UQcek/lIlIz5IFv7DBahtynD4F/oyM2IQzBJVP7lRIia
         KGJh8C9b5fOR9VZhy7qDuQBcMST3OVfDQEt4vdyQ5YnEMKzv4ozrpsNRPVOiewKeBSRq
         FBI7KvUqgTbGzfY7lK2TNotL2Hc4IQBr4PAufskAoFe6J1F0mbnDu+961cjLR9mwyGaJ
         Bkto0xz46xdp3MpVuUWUUK9fZjKTx2x125aBFf0l8NUt+4jQBU4aDJVfErwA0b7xdKa7
         URCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWo9OoIErwIDRMHSD9NwxmYmRFcrsleCZMdfGNNF5Js=;
        b=0WdLjqm9V1gjBpr0CHoOjYoh2811p83rr9vVpeiO27UgD+IRs9dWivZf1e+A3sNQvJ
         JaKgWnN8E/Ximv+mGbyw9QK5D9BGwFN/jEDRYXpwnl3aXPCwEx6lVIf8AO7MSDciIBNK
         begkRUjeNYcko66X0aE5R8dwtGTL0llh8AAAytPz6BktKuhb5zlWiuCvpq5jtNIlL/7l
         M8OjxA7ZxsqZK7gniLTuWWxxCZ9puEsupJGZ5smh2mgF/zksTLbqdV75ojaH7XUwSmAQ
         TrRb6h7KckfcSOj/h/N0y2q3EK+iQl72+L9DteFr9oC8jRGN6VqZdqKt6WUfakMWlet5
         JO+w==
X-Gm-Message-State: ANoB5pnAuwZN/+3P7vHQzaIjjpGDlTDREHkV7NDoWev/98QiqAjwBSC5
        y/ptupcnnPwjktiBFisNYV3LdHgDJCk=
X-Google-Smtp-Source: AA0mqf634DQ0oOlpVNoOqX3601S8Yna1soktDTzJh7D8/JRe2i/rVL5kXMbf/em6d3JTRug+afVRyw==
X-Received: by 2002:a5d:6049:0:b0:22e:32f8:ca31 with SMTP id j9-20020a5d6049000000b0022e32f8ca31mr9765901wrt.247.1668999624728;
        Sun, 20 Nov 2022 19:00:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d4dc3000000b0022e57e66824sm11404565wru.99.2022.11.20.19.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:00:24 -0800 (PST)
Message-Id: <617f98dcb40d417fbb48d9c1de8fa9ab650f5370.1668999621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 03:00:20 +0000
Subject: [PATCH 2/3] t1509: make "setup" test more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

One of the t1509 setup tests is very particular about the output it
expects from `git init`, and fails if the output differs even slightly
which can happen easily if the script is run multiple times since it
doesn't do a good job of cleaning up after itself (i.e. it leaves
detritus in the root directory `/`). One bit of cruft in particular
(`/HEAD`) makes the test fail since its presence causes `git init` to
alter its output; rather than reporting "Initialized empty Git
repository", it instead reports "Reinitialized existing Git repository"
when `/HEAD` is present. Address this problem by making the test do a
more careful job of crafting its intended initial state.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1509-root-work-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
index eb57fe7e19f..d0417626280 100755
--- a/t/t1509-root-work-tree.sh
+++ b/t/t1509-root-work-tree.sh
@@ -243,7 +243,7 @@ say "auto bare gitdir"
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
 	rm -rf /refs /objects /info /hooks &&
-	rm -f /expected /ls.expected /me /result &&
+	rm -f /HEAD /expected /ls.expected /me /result &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-- 
gitgitgadget

