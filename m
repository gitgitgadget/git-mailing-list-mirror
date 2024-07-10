Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA1BE4E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622886; cv=none; b=Upe0R4KptM17xKNHdZDhaM1g9PABbEX3lOHdVBRYWlDRVZiK7Jq6x6r26W/ppMg3Bxu+aPVb2gcGKpsbb02xI4lhVWfAbiRtkiPW80RZvi9mrPQsseqYUhhGOD4Ld7nYeqr82BoJSqKsfPSu7zz6g9s0PpX5ke43to0r2EFqXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622886; c=relaxed/simple;
	bh=GPo+wJphr/bQOMx/lM4LzA7A2cyA6HvGGdXEE2sIFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR4U3SlC6TKcxZQcuJaI/fjjKgsyfTCNhuYFE3GJSkzvZPAw1gLMyGgs2wK6+r9FLarkRa1o7cb6wfLFYOvfZLWAl+AUzcCRih7vpXFRFTAWPQq0vzV/tapsbWf0zPun3qjJZPIXi2d7TBcCJoGeudmGJT0kIR0ZTSY/RdEQfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2F5dX/r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2F5dX/r"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fbc0a1494dso11747575ad.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622884; x=1721227684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=k2F5dX/rb1LCK5xNshVn2hQulupWH6G4dDvJ5uc8YshKKVj7yUikzKS+euMnDdQI7+
         cE/T/FjYD+gqH+yOGDVWnAHSAEiV5UIWpVkRa+mXBIeweah5DzA+EVAZSwWUK9E8EBak
         xMKZmmnYJ5GdB6QTiJFx7yLeGzG51IluiiAUD3NmH7FG5GfAyfeOYG4M5VizehMXlRic
         yxe5TNUK5RzGsogVYQsKJCBLnlIij+2/62iDfzGubJxYWTUiTXG6esyffoDgXRPAVVS/
         woX6KMuDMKgpJMBmbSMwY4PR5M+KO+Qao5HhX7fbfgHuzwIPNkabwK+BgCKMfwUCRfPC
         vDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622884; x=1721227684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=IznXKCp9g5ZSmIf0MZQfzTlP8GA5a9XXSc5sgCcktfBTiNt7FGTL4KSp+sXWLPgH2c
         OHF0llnvlD+ddrofXxDFYAgcqSgh4jD3PwIHmfkqy9AyR0gOuhcHHn6QQN3ZqJqf1o8e
         CnkN5xu5tV0WMDxa7tfeFW7dazRWhHttfRWn283RgMR5dcsiACcxWKHPoeRtLgCYjcOV
         Z0TfZgFMaIKZrh+OVK8W4SPc1ey7OB0QFzQ5fpiUDb9w3hXeskpeuGI/hogv7WRHD+82
         NkXbXZEk5VCj+OxTZkYAgxCOk3zgKD6EnGcITuF/20dVEpOq2FUZ+XzdFsIL8F+cKfot
         EJng==
X-Gm-Message-State: AOJu0YyvhjkJLWGGhGlFwO36cHXMJejbVHT4cuUeNXCHWK7fUJA3x2ci
	SgmuNR3A7xKUxD5rKiID4dZu69cM65KeQqmOyk7X3znpam/wFAPKyZO6JA==
X-Google-Smtp-Source: AGHT+IHMBP7JUYPxM9kqlz6cLNRndhe36h6TR7C70/tNm+HOLTLJnJNfwvKhg2inROarB9gnOvct0g==
X-Received: by 2002:a17:903:2442:b0:1fb:9115:bb61 with SMTP id d9443c01a7336-1fbb6d0b6aamr54655885ad.21.1720622883836;
        Wed, 10 Jul 2024 07:48:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a26d72sm34767735ad.63.2024.07.10.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:48:03 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:48:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 07/10] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <Zo6fJCt-isAMDveB@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index de34538c4f..ec3357722c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -897,6 +897,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1066,6 +1081,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

