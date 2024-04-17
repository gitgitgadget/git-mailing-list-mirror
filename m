Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875C83CA0
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342543; cv=none; b=Vq7EUvNGG56Rceq8m9I8sIJmTBTQO6yZAUq0zYueD2DXu7KqkCJ4qwc4L+WiQY/jpM/vPvrwy1Xp2OWOjtIQ8H+UlymDCKzbqvLwINROOcqLR2Ykb0UJSRfPxnr3VBpJtxMPWBwlCqmWghzNwO+hrPHwWmT1sd6I2PLt3ie4dS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342543; c=relaxed/simple;
	bh=HSeF7qEb2xKpsCfX+UhyEVF1lLi1+jQAMzf3JXOImho=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mA9D7gswhhekDEis6HbeyG86Ry4qqh23UGRaMGxnSgnWLgDNj4HR451Tm2j+yVpXiQrQPc6sTIJGZl1doCOK8fpi4lP8O2zfajbubCY8T02++/UP3dhjv26AahXykkc3z3Mzh0swKrVXbo8apgV9EjpJZ2tqnO9opEQyutUe9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIqIjO6Z; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIqIjO6Z"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so64876931fa.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713342538; x=1713947338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJuqj2Q8NkHOWXuFCFVFxS3KYyPXRuwnJI+uNs9p5kM=;
        b=IIqIjO6ZJ1OJaONMAxgj6CEk9w+y5aMTl1rSy9c/mwF7aPBsrrMszgw1bqsIO4hzSN
         MW2CxnWAk91QyoGZJAqXL/5vq5/BjNhUJOcbBlTaQIvwwSw3ycOX9AcQg0F7Nelx8+tO
         8yf3jvIhZ54B3Av1c1qExTxc4+kQRJ+7aFHbz2ptiXxeasGxFjjCKKhwDXvkz+EHzygx
         B/BIAyEov7ogO0AlGy2MRP8r6/LDhTLx55WNlcS9wbDsrrOIVR9uoh2OJxRQOL2nK5uv
         54wD2UtOEiET4kpV0YgB0jy9XLPDUWFZ527CVDiYEvTsZQDXqXXdMH1sXaQuXJC99A5o
         L3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713342538; x=1713947338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJuqj2Q8NkHOWXuFCFVFxS3KYyPXRuwnJI+uNs9p5kM=;
        b=FSy2TSFfr788TXvIy7oTNCk1vOPjJEApkcPrmoMawWbgoihZwTWfFpe2xSwWm3Ga4y
         HJ0Y0G8mnEKis+ppAyC2ZgWY1sN249SNxtAYRDlVozuN8y1CWYEe5XCAF10cyOvDx2C9
         bq+jBWObKWkgzZ+mIonrUI6b8H7AiFyQLwfrTsYlNa+kJRQChjDKoKu5M4UMkkPoy9DK
         YT/k2h894uiUMBpTcW9a7lwnQl7BgSK/MrBaGs+YYA6fwc6nIGYu/pV71TzwQPCczH4e
         Rm0uTNzVutaP+UJwCzHFKhbjAh6y9Obm50xCi1cbg2WWMT8GuXYZnrN4sVuomVY/zrP1
         a+SA==
X-Gm-Message-State: AOJu0YwU0Fx/dKx4tHrwV1F/To0eMfNm4JB/NErXKExHMqp9HWabsU1M
	3QqNmLQCs8nK6qUvuq8u8XDwH8+xhyr4HSMwYIh+Nhw7AWdHkSqyTdBLHA==
X-Google-Smtp-Source: AGHT+IHLrESS9442gQZEr9gF2bO8g4Kqz9S/kDgZpIM45MFFBop72cRZTUpjfS7NBZqZkNdgsBmZrQ==
X-Received: by 2002:a2e:9c93:0:b0:2da:dfd1:8abf with SMTP id x19-20020a2e9c93000000b002dadfd18abfmr2905892lji.48.1713342538156;
        Wed, 17 Apr 2024 01:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00418a2ce7253sm1846356wmo.13.2024.04.17.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:28:57 -0700 (PDT)
Message-Id: <6721e3ada5d125bd6c33561c694acb986b17b38f.1713342535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 08:28:54 +0000
Subject: [PATCH 1/2] for-each-repo: optionally keep going on an error
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/microsoft/git/issues/623, it was reported that
the regularly scheduled maintenance stops if one repo in the middle of
the list was found to be missing.

This is undesirable, and points out a gap in the design of `git
for-each-repo`: We need a mode where that command does not stop on an
error, but continues to try the running the specified command with the
other repositories.

Imitating the `--keep-going` option of GNU make, this commit teaches
`for-each-repo` the same trick: to continue with the operation on all
the remaining repositories in case there was a problem with one
repository, still setting the exit code to indicate an error occurred.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-repo.txt |  4 ++++
 builtin/for-each-repo.c             |  8 ++++++--
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
index 94bd19da263..8c18001d825 100644
--- a/Documentation/git-for-each-repo.txt
+++ b/Documentation/git-for-each-repo.txt
@@ -42,6 +42,10 @@ These config values are loaded from system, global, and local Git config,
 as available. If `git for-each-repo` is run in a directory that is not a
 Git repository, then only the system and global config is used.
 
+--keep-going::
+	Continue with the remaining repositories if the command failed
+	on a repository. The exit code will still indicate that the
+	overall operation was not successful.
 
 SUBPROCESS BEHAVIOR
 -------------------
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 28186b30f54..74498539e9c 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
+	int keep_going = 0;
 	int i, result = 0;
 	const struct string_list *values;
 	int err;
@@ -39,6 +40,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
 			   N_("config key storing a list of repository paths")),
+		OPT_BOOL(0, "keep-going", &keep_going,
+			 N_("stop at the first repository where the operation failed")),
 		OPT_END()
 	};
 
@@ -55,8 +58,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	else if (err)
 		return 0;
 
-	for (i = 0; !result && i < values->nr; i++)
-		result = run_command_on_repo(values->items[i].string, argc, argv);
+	for (i = 0; (keep_going || !result) && i < values->nr; i++)
+		if (run_command_on_repo(values->items[i].string, argc, argv))
+			result = 1;
 
 	return result;
 }
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4b90b74d5d5..95019e01ed3 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -59,4 +59,20 @@ test_expect_success 'error on NULL value for config keys' '
 	test_cmp expect actual
 '
 
+test_expect_success '--keep-going' '
+	git config keep.going non-existing &&
+	git config --add keep.going . &&
+
+	test_must_fail git for-each-repo --config=keep.going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	test_must_be_empty out &&
+
+	test_must_fail git for-each-repo --config=keep.going --keep-going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	git branch >expect &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget

