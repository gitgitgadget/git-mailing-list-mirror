Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C877387361
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109153; cv=none; b=OLfEqWr8phzQiuIa6l5LN5OX/l/3/LMk7oS2MDIFCwk1sWNX2wmiYtOveMpfw8bjyu+GLzan6jXpDMcjYEu+GdoTOhmUF284hJKKLGhfPpgBqlAy331p6AtF/zEka1UoOHaAy7BXTwT8wuD0b0L/pQLMc/lz4EzzGetCdrhsJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109153; c=relaxed/simple;
	bh=y2uzU5vNFVRfM+pafKNQvRwbnLOIisGexNOTXTYbf9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGxH/0rsWlgUINAqYcwIdbNSahKsdjVOXbDmIeEbnaCIM0+wBgT9iTNHMk8RzOaBZmFS9xOJ8xz98JEeZOkvlKfNxIIDmC0TE3WbbTSyXSJKaVf2IeD61yh1H6ESiZfsn8JeCXLJZ0iYV/z3SqoyCIMNrth5yyM7f4ufdv0m09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvPyPE76; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvPyPE76"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso2762059f8f.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109150; x=1784713950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=cvPyPE76LMB8TlQ5GbW+72+8TZ2Rb9NKf0FSbHM7Eon5t9Myj6agxcDlzp+rgt06uA
         GKbck2kXGNUnaULjNpU1gPgEht6X8b015Vf1IP/2TqvDhIjJHAbvn6mnMtutzwAnZNKN
         bp0iDLksa8b71TuwC9Dl0a22Ye97iD9R5qTVXKLTELf2o15H8EYEkB0TxkrWtHyuLVkq
         JC4d1hakztvm7i58GubxDGNPEXHgIi+kmATU9/1GMXUhyGDsea1x+pzIfNnPH6/icoJx
         OB2E3P0iarsy21KEG0YUX7AsLiNM8OzjgJE0lpL+26SEFazFrObqJJv5eusHhjSquZnR
         hdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109150; x=1784713950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=gxG+62YL7AHedUzfujvEleXRZPAYK74coYxxlMEcqvUegJYx/xGknj4v5to+DtPK69
         h9Kh+QOnUQ5XgsAClCkOiZtiFoorKnhrAytCHNOic1VFaRL8eAn1LSYFAPsx8IANW8I5
         u+tz93V0zZIuEA3G5gYGJJwHJasBIZdTJtUYLJnqH+tj8xy3MC4DaEVpVErj4fM1LzsF
         3Bh5yYDI9AaCkbqvO9Xte5iCGux/o51GZaYBygIKvVZbW6rg4fcD0QrInjIjdZysMcWy
         unHm2q7HveYyqJ1fDbiMYTQfNszgvRrzlwb6BslHYDY97O9NbfFOdQWQoO8JWNABYYM5
         Llaw==
X-Gm-Message-State: AOJu0YxaWmvWnQ0Ut90skaeRwIhe7m/6ZlZRL2JH7xKGYzPTfALellZh
	zXdghc6kz/k9a5wVCbSez7uxnh7yDJr1n2zBeBHJfFa2StXJOXd2+XNE/vSIgJjQ
X-Gm-Gg: AfdE7cm6SL2AptiXrfaRpDHKS2cjHm5bVb6ZAH7b6kfLixyw6Ygl9JqzDvrSH7PqQwi
	yYJzd9ENF7ZaAr6Xt9I4Q9jN1htb8TqqxuutZCmOtoOq7XTRw+JdXUMP17+Vgav1QXFJIKZuwXw
	zIalEhuhk/wWNMxbpNjHSfklWwgvoleQTEVAWDx4Tdej5QPZ9KzJTnx58CNxHc7mwoDDZIlopkJ
	AvYhMYfyTTdfTnA2Xklr7dVhnshljORPNyXIvP3V0QDFBq29AQsGrG/gYhAnn/N1WN09J6Ws9L9
	3r2opU0wMVBrG1wjydxktAqpKs113cW+EQNRRxP0q8wDQ2Z+FRWSDbAwrAQCYDAeGgWHryKJMpb
	BSqA8KS+BN4tHM1hqLafyU5/BsaucdG0X14NEUtwXpiCpMdfuqQKtBtKowusw81o9YBVSbA7m88
	FjyBapmEtbn8dQZRiN7WNfhpOdff0Hqg1I+8EV7bO/7aFrCFeSsqGml821yarqStAvaEc7Lvv50
	Bk2pc47YoVzq3I3L9lKfcMQrHb5sBN55xNAjlSRIC71+ie8n+T+QmM8neyt7oRMx6WVKZ3yoL7f
	Zf0dAB84zlMtMrA2sM+5AjYEdCOD6jBvE0KhtpKZCaq6khZVmBeICWbv5wqSiggzK3+KySpHAWo
	DWtQmwB7xpA==
X-Received: by 2002:a05:6000:26c7:b0:475:f0d1:eb63 with SMTP id ffacd0b85a97d-47f488a8878mr6712317f8f.48.1784109149942;
        Wed, 15 Jul 2026 02:52:29 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:29 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v18 03/13] t1006: split test utility functions into new 'lib-cat-file.sh'
Date: Wed, 15 Jul 2026 11:52:11 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-3-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script 't1006-cat-file.sh' into a new 'lib-cat-file.sh' dedicated
library file.

A subsequent commit will need this functions, the goal is to improve
code reuse and readability,enabling future tests to leverage these
utilities without duplicating code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     object_name="$2"

-- 
2.54.0
