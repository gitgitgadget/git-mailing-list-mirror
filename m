Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055621F576
	for <e@80x24.org>; Mon,  5 Feb 2018 10:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeBEKnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 05:43:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40741 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeBEKnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 05:43:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so2340310pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tCLU/a5BsoVeB6rx6C6hv+WSxPphGawT7G0rlbGPBCw=;
        b=NV4gTAcYM5KPf4Qcqv5qNCLhlcjqxV/RcLxUeOA02jVKfG85z26QXmvnT9ZRGx93n4
         dcA0m+ePJvfaLfalg6s1Qw/plgxszHqp9kb/BDlZ0vIDEwo9+nMT76cW4qbPTfhTzFBy
         aLazGSapQTKVMDYVcdwBRGR5StJDO6uj7LZAHgT0sD5YaQrCugrAQcoHSh8qB2HPS+FW
         2r+heXlP6zH/+kn58gguDbPGxwsVuwCcuLUDTltRF/zi3fDKBsEsbrEvU1/9cmL5Wc6+
         iEu54GO6RZCJ4M7B5iXuVsu6NJJQl9r+wEAczdMum60MiWbJWvkQsJtUzZU4sayIGev9
         aVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tCLU/a5BsoVeB6rx6C6hv+WSxPphGawT7G0rlbGPBCw=;
        b=kJ24NUCD7apB+6nJkUUY2kFawEWmI0xeVW0uPKHFnDlprwkQuWrFUd6JADG+CNXKwX
         9UWhvQK0RRvbnjDu2XLGiDMVEGiNZcSYfcKvpWBE0SrZj1YRPLD/aqH+seE7UO0kGpms
         4ryViTEpGb7RHqBueMc7p9Win+xjU175HAGRBJv92I3NieifF9yS6lhTYx5EEjlqiuZP
         k8F5SqZyjPN56ESzmf2TRXTgDQ3S0kJFl3Ks324JzD83o5zaNFzsMJvaErnuUSDQY2ZI
         kv3OIraNnARaNIFIJWZvUBVmmhm+NpY17IXz4hRkiMMNYLLW/U9RnfV0Mal+xiDWAXpf
         IW6A==
X-Gm-Message-State: APf1xPAk7IWoEkl6Ib6g43PbuaVcqkZKXHqpQwNGPdHQRsAZ4lgEVDSD
        lxxcF/J2++q2NVp2UuhAKVV29A==
X-Google-Smtp-Source: AH8x224UXx/IYJC1jD9KV8F9Q6s1+Zumklc9L1tpwR7Oa941+XzrRY+vpOHE18Bd6vLpzZ8YkZxxAA==
X-Received: by 10.98.66.86 with SMTP id p83mr295066pfa.229.1517827430113;
        Mon, 05 Feb 2018 02:43:50 -0800 (PST)
Received: from localhost ([14.122.163.127])
        by smtp.gmail.com with ESMTPSA id w12sm15657368pfd.86.2018.02.05.02.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 02:43:49 -0800 (PST)
From:   Chen Jingpiao <chenjingpiao@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, Chen Jingpiao <chenjingpiao@gmail.com>
Subject: [GSoC][PATCH v2] commit: add a commit.signOff config variable
Date:   Mon,  5 Feb 2018 18:40:59 +0800
Message-Id: <20180205104059.4759-1-chenjingpiao@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the commit.signOff configuration variable to use the -s or --signoff
option of git commit by default.

Convenience for those who prefer to add Signed-off-by line by the committer
instead of using format.signOff variable.

Signed-off-by: Chen Jingpiao <chenjingpiao@gmail.com>
---

Previous version of the patch:
[v1]: https://public-inbox.org/git/20180204020318.4363-1-chenjingpiao@gmail.com/

Changes in v2:
	* Update commit message: Move commentary explains to commit message.
	* Update test: Just test two combinations.
	Suggested-by: Eric Sunshine <sunshine@sunshineco.com>

 Documentation/config.txt     |  4 ++++
 Documentation/git-commit.txt |  2 ++
 builtin/commit.c             |  4 ++++
 t/t7501-commit.sh            | 10 ++++++++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92..5dec3f0cb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1303,6 +1303,10 @@ commit.gpgSign::
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
+commit.signOff::
+	A boolean value which lets you enable the `-s/--signoff` option of
+	`git commit` by default. See linkgit:git-commit[1].
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a4342..7a28ea765 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -166,6 +166,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	the rights to submit this work under the same license and
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
+	See the `commit.signOff` configuration variable in
+	linkgit:git-config[1].
 
 -n::
 --no-verify::
diff --git a/builtin/commit.c b/builtin/commit.c
index 4610e3d8e..324213254 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1548,6 +1548,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4e..adaaeea5b 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -505,6 +505,16 @@ Myfooter: x" &&
 	test_cmp expected actual
 '
 
+test_expect_success 'commit.signoff=true & --signoff omitted' '
+	git -c commit.signoff=true commit --allow-empty -m x &&
+	git log -1 --format=%B | grep ^Signed-off-by:
+'
+
+test_expect_success 'commit.signoff=true & --no-signoff' '
+	git -c commit.signoff=true commit --allow-empty -m x --no-signoff &&
+	! git log -1 --format=%B | grep ^Signed-off-by:
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.16.1.70.g5ccd54536

