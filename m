Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727A80626
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342543; cv=none; b=RDspj69644zX3nYfEEEG7ojb7Ywlp8DCx8PmyNFR4WNnVLHO1lvhJzv8DTkHdzfen2SFsdCy7gEYH6P1nDGaOqg3PJ81zILeDSUnJkfZ65C46LQmb1T/jTKeAjuneei0atxpsSE+0SbB5Cm1g1ZdZdiWWJ3tmKb7mIyt4chPab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342543; c=relaxed/simple;
	bh=44KQ3EAkN/r9Lpt3Z6TN3KeZHAMWTXNsgYBp9Ne5Afw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FOz+hvhn6d3w69leS0axjZbktMhhVuGVDlS8/y1iGWeqrNEjR/FlqZDT4+yYQRYokFPvfUxQJ8WuGsPSeBm3osWt/Lw6MBoh5ACo9Ntfm6wuTdzcpNzoCvn8J9vVN1OQfTsyZdGdggTqlUfp883FgU6MnD2W62UDKXFayJ05JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpfhOSl4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpfhOSl4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-349c5732fd1so239620f8f.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713342539; x=1713947339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=mpfhOSl4pejvz926oSvEqsGnS/dCFnt86fjzucgW5zelkwvOPvYh+1Wm6t35Qo0jWo
         rsd2oi4cszL9TG2pI6DTwlgCNoECP9PKbVTZP6OvlBrZ1N+XriDlwqF2zov7B7WBf+z+
         H9wXFEtgvTbb4dzrlYWZs20UOh/IUtni2SQOcgqpF/Rz9y+r2ZnWvSwED+tGyvdxa7Qq
         X64l5Kvr1e4BVhmoNH2mXdSThGs/y5cjxQqkrLWsT4hCHLNOUwUXTxPSY9fErBMxl2rL
         rJ0eFywyWxXXzF8qKTDEsxdy5UVscPSs34e2EHOs9doUm/cFlNZETo2eFgsHGXBqZBeQ
         pE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713342539; x=1713947339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=iUReOslHIuQPSZY3g81cc5JHH1/nIcx2wdiOnFS44jzvIHNQq1WhB0tOhCQGZRrcOW
         F4HcLW+x33j0KJeh+qe3W196tX7GogBJtFqSYU3R8NDGVqitMeLjA8QC09MPU8emyzuQ
         5Gf4oL9R2uAoDIysujNgO7r2lRjvje5bcJtj491OCir0/+Tglc6pYYhBHmjR72dGc+Kt
         oSbIEBG0h30VDnmbk2gvXG4dgawr8+RqBwzdXpIpbQ7DApM3B+v5BUTE2+k5NAxk+hXG
         G+vddE+rkQBpRLot6mRT9uEVs/6qgbNHcU1xQISkE1L6+VXsQOvdhdhMfhXEtAeHXYrM
         ZUSA==
X-Gm-Message-State: AOJu0Yzi0AWIcmF2kd6rsfHz7mQR2V5GZm1xj+dW+JRyggUWarZ31OXn
	CEBH8jWI7jNz7Hkd+BpIKmkVAdlq6L6RYPN1aEjc1xEvVoXhKOqEo9pPrQ==
X-Google-Smtp-Source: AGHT+IHlEk0B4UmWem0d6baMWcRdmgneUa1+0dKKE/zD5E/ZJ7jOd8LIf/5JEzyQtfpFieIrnVIaFw==
X-Received: by 2002:a5d:526b:0:b0:349:cc8c:56ed with SMTP id l11-20020a5d526b000000b00349cc8c56edmr585489wrc.6.1713342539153;
        Wed, 17 Apr 2024 01:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6245000000b0034334af2957sm16929550wrv.37.2024.04.17.01.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:28:58 -0700 (PDT)
Message-Id: <a86bcf2e1a0aadaaaeb5bfe5b0a4a0fa12594921.1713342535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 08:28:55 +0000
Subject: [PATCH 2/2] maintenance: running maintenance should not stop on
 errors
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
maintenance stops on a missing repository, omitting the remaining
repositories that were scheduled for maintenance.

This is undesirable, as it should be a best effort type of operation.

It should still fail due to the missing repository, of course, but not
leave the non-missing repositories in unmaintained shapes.

Let's use `for-each-repo`'s shiny new `--keep-going` option that we just
introduced for that very purpose.

This change will be picked up when running `git maintenance start`,
which is run implicitly by `scalar reconfigure`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           | 7 ++++---
 t/t7900-maintenance.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb5..b069aa49c50 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1858,6 +1858,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		   "<string>%s/git</string>\n"
 		   "<string>--exec-path=%s</string>\n"
 		   "<string>for-each-repo</string>\n"
+		   "<string>--keep-going</string>\n"
 		   "<string>--config=maintenance.repo</string>\n"
 		   "<string>maintenance</string>\n"
 		   "<string>run</string>\n"
@@ -2100,7 +2101,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	      "<Actions Context=\"Author\">\n"
 	      "<Exec>\n"
 	      "<Command>\"%s\\headless-git.exe\"</Command>\n"
-	      "<Arguments>--exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
+	      "<Arguments>--exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
 	      "</Exec>\n"
 	      "</Actions>\n"
 	      "</Task>\n";
@@ -2245,7 +2246,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 			"# replaced in the future by a Git command.\n\n");
 
 		strbuf_addf(&line_format,
-			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%s\n",
 			    exec_path, exec_path);
 		fprintf(cron_in, line_format.buf, minute, "1-23", "*", "hourly");
 		fprintf(cron_in, line_format.buf, minute, "0", "1-6", "daily");
@@ -2446,7 +2447,7 @@ static int systemd_timer_write_service_template(const char *exec_path)
 	       "\n"
 	       "[Service]\n"
 	       "Type=oneshot\n"
-	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%i\n"
 	       "LockPersonality=yes\n"
 	       "MemoryDenyWriteExecute=yes\n"
 	       "NoNewPrivileges=yes\n"
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0943dfa18a3..8595489cebe 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -639,9 +639,9 @@ test_expect_success 'start from empty cron table' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
 test_expect_success 'stop from existing schedule' '
-- 
gitgitgadget
