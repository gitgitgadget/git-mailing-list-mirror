Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B9CCA48A
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGYUe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiGYUes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:34:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8B22B28
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bn9so6693096wrb.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BWV2J+OEqm+FLFkss7C1WYGe4M6nDiAYaVnQ7Kr4OLE=;
        b=mqB7H49m06lRx6AU+IgSUMlwkgipJEldUtdDhnQhPnUZUhbeXfFreXkE8Gau3mtULD
         6QdCWpFaR59mzrNjFZQsGek7ts8rsXhju/ZzzidGPOJPj38dgCkx3Ykxxs1r5RaQfRoO
         jEHYP+JIKXag8nYthWwBPWl8Qp4MfRKLQcpbzFTzATv9M+1Ujs5vHNpB7d0apQNPdBgj
         gOiPT84bDsOo9CLtgXBHVi7Js1WNq5QrUSfUYrVjQ6dpwr2/lssTxHpmg0Ul8xSHnT8u
         1/j9itEO3yTdJZKEDIPqniJHg/8t4kYGDIvVQ78hVR4alyPMbSAxZbLZ2oBAos9s4yNF
         3MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BWV2J+OEqm+FLFkss7C1WYGe4M6nDiAYaVnQ7Kr4OLE=;
        b=Upl+zOYDgPIEFLOUP4aXutftjv8eQTL4fFu+Hex5p3qQyYXAbAejxP72M54e42LY1j
         W99oatFhVwCU7+Q+NMuakz2i8MeS8fu95eaIfNpJ6d/H1gj1AdzffxfCRQZ4V8KzDwbL
         WfNJhgbnXtY1MlgQGcjaewEpK6h7rYp7FdpjCBNsTRSeSXTXKWpEaLMCNR1MYSPZF4n1
         /xsqztAGcJMp8i1wfCnGpXfGnjGJgwfRyrmtxCxS29/AOiiq/YrW3JzyeNrmZc+1aftc
         6HgqmHaJV4Wh1CWgdpisriF/nVG8460EJ3u6RNxx11/g+5GHdDxsVcZiRXWHjzzuMaeJ
         Bv8g==
X-Gm-Message-State: AJIora9XARnVX8YkZLvf7PjsR7rq5PxrdCFZimhj0tQ0+WjY+rdeQGMv
        kxQ5Rq1ewt8XdGuj/B60l5m9T9Zh23o=
X-Google-Smtp-Source: AGRyM1vqN109kdAs+EvyvjLt0/4FBYGUtbTgQepfFngQ5q9isDvhLD6wTIahU03l4DNhhnVXTADQjg==
X-Received: by 2002:a5d:5244:0:b0:21d:866e:2409 with SMTP id k4-20020a5d5244000000b0021d866e2409mr8491454wrc.400.1658781284268;
        Mon, 25 Jul 2022 13:34:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d460b000000b0021b970a68f9sm12452391wrq.26.2022.07.25.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:34:43 -0700 (PDT)
Message-Id: <e823b168ab7254a0c56e549b240cce9b70d5a2f4.1658781277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 20:34:37 +0000
Subject: [PATCH 5/5] clone: --bundle-uri cannot be combined with --depth
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

A previous change added the '--bundle-uri' option, but did not check
if the --depth parameter was included. Since bundles are not compatible
with shallow clones, provide an error message to the user who is
attempting this combination.

I am leaving this as its own change, separate from the one that
implements '--bundle-uri', because this is more of an advisory for the
user. There is nothing wrong with bootstrapping with bundles and then
fetching a shallow clone. However, that is likely going to involve too
much work for the client _and_ the server. The client will download all
of this bundle information containing the full history of the
repository only to ignore most of it. The server will get a shallow
fetch request, but with a list of haves that might cause a more painful
computation of that shallow pack-file.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-clone.txt | 3 ++-
 builtin/clone.c             | 3 +++
 t/t5606-clone-options.sh    | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 60fedf7eb5e..d032d971dd7 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -327,7 +327,8 @@ or `--mirror` is given)
 	Before fetching from the remote, fetch a bundle from the given
 	`<uri>` and unbundle the data into the local repository. The refs
 	in the bundle will be stored under the hidden `refs/bundle/*`
-	namespace.
+	namespace. This option is incompatible with `--depth`,
+	`--shallow-since`, and `--shallow-exclude`.
 
 :git-clone: 1
 include::urls.txt[]
diff --git a/builtin/clone.c b/builtin/clone.c
index 4224d562758..4463789680b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -937,6 +937,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (bundle_uri && deepen)
+		die(_("--bundle-uri is incompatible with --depth, --shallow-since, and --shallow-exclude"));
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 8f676d6b0c0..f6bb02ab947 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -58,6 +58,14 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
 
 '
 
+test_expect_success 'disallows --bundle-uri with shallow options' '
+	for option in --depth=1 --shallow-since=01-01-2000 --shallow-exclude=HEAD
+	do
+		test_must_fail git clone --bundle-uri=bundle $option from to 2>err &&
+		grep "bundle-uri is incompatible" err || return 1
+	done
+'
+
 test_expect_success 'reject cloning shallow repository' '
 	test_when_finished "rm -rf repo" &&
 	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
-- 
gitgitgadget
