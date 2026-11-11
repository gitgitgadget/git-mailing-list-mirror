Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437360;
	b=lChA0XqDip/xeaFWyz8d+H+NiEqllpmPWWYmEAkQdgQ8Cr2x5ioZlXw+nfQso4KjeJPz
	 x7vq5fv7j1y98QP02R38J4wEb2yUEbcViWlgGk+19rNBVdCIgWL1vJZ0Ps0SXYAKa/0lc
	 rMbuCzFFLn6JfVYCuiNG9RGAMhoBVRygIGH9i17Y4aek0HpZ17BNewroI+/ei4a6WbXBS
	 EcnpAV3DDtjocmCaj1ZMdnoYrgY4JS+yuZcMHJ6rqdWWgWDijxSMNrkUU41Mk0haEOeVv
	 +qcNs5TSD9YqNgl+fJKA1v4PooTVvMP20N17p2kUNkO+FPJTTD3UfXaeMiOCypKiK1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=HINaTkfdDx/sHwjWTldz/7VKAGK2MpOKri5VEtmLamM=;
	b=3f6RvMX76tBp4SL58SPmJ968IL/0DSgmM88drqRbEb6moU+39eOJ8fy+97t94bYiqUsH
	 5imTMmcB+puVL408H93hj8ltyf8jdxFVgZNmXu3sVz4nlL9RBWhWJKznlYg8USVumAD67
	 WIClndxBlJg3e7HPqO0odnF/yc1z+xMw8teya1USbFS5CGcyU3RhTLZ5V94zvpxebEVFX
	 KClK/bqgcel8X/Vf29I3IZ01I4svJpbEXnrifIBXZs97BdXGpMSHaAfsyQ5LnRI7GTLJq
	 Cnh+71QzwnHbprLTM40oeyMBSp1Iw3vcnEeMZ5Lppai0bHmeHOVnNFNi0PDZAKicTyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9vpx0ok;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83266606AEE6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83266606AEE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9vpx0ok
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-846566246e8so261831a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437359; x=1795042159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HINaTkfdDx/sHwjWTldz/7VKAGK2MpOKri5VEtmLamM=;
        b=F9vpx0ok/WJDbYl8btHnG4pUPrykKDgh3TQ0m1wrFWnHNqaEnH8nejdoyihYQyfP8z
         doZav7sdPyOZrKwYaNvctNVtJqZT08EEERlHO8+HzGMhl1pAGk7TL4Mi0K2jiTGinUuE
         p6DWGIRLPX7l0q/echaT1eTnDYAFNobzmDVUusOzKge5zG/cf2XAalEQhPZMluu7NFjT
         W+SlaC4uFeQC03uLp9v3J6+EvuvkJ0grpqCqpcnzapzs7tvpC0o6uQWp4v1lq7vasun5
         Ft9X3m+q3c/olU8v4A+TsrjLtT9ODaTFsgGOvKGa/LNR6ykUgNMDEA7kaTtn9/R+Einn
         L0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437359; x=1795042159;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HINaTkfdDx/sHwjWTldz/7VKAGK2MpOKri5VEtmLamM=;
        b=rdivN8bPHBbuJhfuGo66oXbkY+ULdK3l4UStrzGr4Ob2D5f7ivFIL/il7lI8BaZJov
         KU7j1WjKBQ/xMV+DOiJC48dqew9MQJjZ+9AtzI+ymHQYkwuSY+AxlL/NqPL9xUunLO3Y
         oMOPpL9hGdXYqQPc4u9x4Gvh9yFmpgoOU6heH6jjYnOr1Uvj7y7PLUBK8p8TF6M4o9xx
         A8hbp1TElavQ5N7NeYCqe9ydZ+Jb4NUh5oqLb/ls0n1RSZlkUMuzLBEDJqKD/N2kH/OO
         41GAyRZ2LzSH2HnqEyG8xQPoUGpgdL+4c9Pboa6ut7ymQ7qNdJ17ozx1fuer4D/4VkYm
         BhlA==
X-Gm-Message-State: APuU4Z9Sr6bM6d+KOe4S/jPhr+3+7c3CBL35xDbSkbTKDVbcE1wgreXA
	v1HFBak5GCKKwyr3tECmGoCsGxT1W9HUzblUwvp9GPMfUfRvEUcpPw0kbBglVA==
X-Gm-Gg: AYBFou2XrGzwIxDKoe8WPPVQFHDMwDrojGMSflOz6SYFh8WLRMApMIMl/uBDvrFuoJv
	SDF5Vrt9rIPlK1rkvt3YORCRfnNOfSkYSQWcObyAObg2WIuZA2htsknsuSfrUf7hCUosXKNQOUH
	1cb5+lB83SxyXBCzxeBMdLva07tIhrKZSL+Z2iU2AYnaDn9JCvYHJlfqwB7OSWNxkjPTWaem/eW
	ZuPLhOCn1HaewdzP5TYEEcMUgV2j5TtLbaQFhHTIcSUpyImNXhs6EbiDISc2bPaJBbNJ+JQClBM
	BZGRFFAH9RWRvhidw0u+2YXpepAm5o9QL9FPZotu3NuTwRCOud9J6OMOiutOl853pVpCduce4j4
	Ug3+moDiI7umxZhAx2hZ3rMQCzjsPrQ5huoLCoipBMvIkOlWs0vUIWq6fzbPJK6vpIXTiT1MSs3
	Prqg1mKHYOHHLQ41FOFI3GJcgMQiOTiC1gb/os+p1U36I+u/iyHXef2NYox0xE5gWQG+2P70xs5
	Yp2tvitvb7cqG/CsSzhX402BrYZPAeOCn5LiEsqhI9YbtnnaxYQ1/JIX4RaqQF5FaLkNt6MpkoZ
	7SCTJ8dZHOAic9skjAlfWLARLR+8+DXi/ks=
X-Received: by 2002:a05:6830:442a:b0:845:614b:eab9 with SMTP id 46e09a7af769-86152677024mr720564a34.6.1794437359546;
        Wed, 11 Nov 2026 14:49:19 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm5453934a34.17.2026.11.11.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:18 -0800 (PST)
Message-Id: <1262222ccd3884e0d2bfb2f227800fbb5ccf1c61.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:01 +0000
Subject: [PATCH v3 01/15] rebase -i: handle NULL value for
 rebase.missingCommitsCheck
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A rebase.missingCommitsCheck without a value, as in

  [rebase]
  missingCommitsCheck

or "git -c rebase.missingCommitsCheck", makes "git rebase -i"
segfault as it writes the todo list: get_missing_commit_check_level()
passes the NULL value to strcasecmp().

The setting takes "ignore", "warn" or "error". An unrecognized value,
perhaps one meant for a newer version of Git, gets a warning and is
treated as "ignore". Treat a missing value the same way.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 rebase-interactive.c          | 10 ++++++++--
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..9eb70b09b3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -30,8 +30,14 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 {
 	const char *value;
 
-	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value) ||
-			!strcasecmp("ignore", value))
+	if (repo_config_get_value(the_repository, "rebase.missingcommitscheck", &value))
+		return MISSING_COMMIT_CHECK_IGNORE;
+	if (!value) {
+		warning(_("missing value for option "
+			  "rebase.missingCommitsCheck. Ignoring."));
+		return MISSING_COMMIT_CHECK_IGNORE;
+	}
+	if (!strcasecmp("ignore", value))
 		return MISSING_COMMIT_CHECK_IGNORE;
 	if (!strcasecmp("warn", value))
 		return MISSING_COMMIT_CHECK_WARN;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b3ee96f560..16fdf6b6e3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1562,6 +1562,18 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i warns about and ignores rebase.missingCommitsCheck without a value' '
+	rebase_setup_and_clean missing-commit &&
+	(
+		set_fake_editor &&
+		FAKE_LINES=1 \
+			git -c rebase.missingCommitsCheck rebase -i HEAD~3 2>actual
+	) &&
+	test_commit_message HEAD -m C &&
+	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
+	test_grep ! "commits may have been dropped" actual
+'
+
 test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
-- 
gitgitgadget

