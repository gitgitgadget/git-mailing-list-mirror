Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7B61FDD
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960327; cv=none; b=UETIQpn+p7dTzsIDbLPA/X1LCL90oRjN76c+v+QxLur0VKY+j61twm2uT9xKuBQNxWllpKh70/HeZVRhgiMPM8zIClEBfgzEkI9Y7VJhfEgv9m9IFPQ9iF5Q8kJm378kHvh0HpTdTkfgXzQMCxemLnqijse2M5GPB2z4kCay/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960327; c=relaxed/simple;
	bh=ek9E8IClAA5Pug9rfdoQVLLDaCJUaD2cNG50fTVw0ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAKWKzQ0xYlG49zepZJEL3QpOLDEempBY0kAcG09mZjzETHrXj8e+Vkz6N4Z6rdHqytLZr9hB99YCdkiooTcRvUtViNgr0KDyvNaooGnEOJ/kGKNbPkIZrlqVu5yYsjEher8L3/VufRKoMWO4VKfA/aCIRjTk02lJMFOxq6K/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq9MdpzQ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq9MdpzQ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e15406855so2144805fac.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960324; x=1721565124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvuzcrY6ir+rp6T0QqF0tlZePMzXH1J6N3QzRgz8UW8=;
        b=fq9MdpzQzEDoiTXpSMXgVniEcFbW1BrGxf2Am5ap9OIKeS1PVXzS9QhnVNrohhoxHi
         M5n1igUCfcd5f/wMeHwRPM35FtxePpT/G4EsFPfm3eya/H9KuTiFuLoRUhKAkShzyqsa
         rj9D3HwM1sgRyWye8z4ANpR15nUwe/cRnWDA+XF7lcvY+L0569Hcm2N4XqJv7nGbvQVu
         U2uYQuUAQB5XxYrYHHlc1mmhqjYOmMjQzQJuAqS5atm8XJ6qTV+sGlZ/s2elaAT2GO8m
         rgC7Tw4DcS1IxWCTDdlisrRPsmz+WYLUF0Wc5btNF4LrqTLG92Ng8s92Il2nYKPxp6Cv
         Zq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960324; x=1721565124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvuzcrY6ir+rp6T0QqF0tlZePMzXH1J6N3QzRgz8UW8=;
        b=WmBTzoQlBerjKKj9BGR3Om7kMFlLH/GhePKf8eAE3CQeOO4DNB7IEKLHLLPLcZavmA
         LH+lG24Cb16sPzmQFU+Q/hqcZZJhwKVQmJJ5sfVsTc6KcmfRJzFxcqfmSjgqshHp4ivI
         rbIK2TU49/jqbf/lylMQ3n9ePKAAbnW8rhGQewye1DcdNsswz52N/e20U2GvFHrizWEW
         vikrssr0T9rvq1HtSisCDFtG4lS8iT/wuaTIAKX5s7ZFQMMwMYC/Vo5yIW2CHtMSNmyv
         uW6ZcKlxF/pKWUgD81QFwlZHJXgcrgA0k26kZ4ktG+tGZoV7nY+R0lcqiBHcjuEocBKH
         9nzg==
X-Gm-Message-State: AOJu0YxnqDXi8iioec2GY9B5ydrF+htwbrSKpZM6ohNucdVYa//PmHlc
	CghoyvdqVl9allE3jbdWEy2wuXhIpuwCtMQJ/uwMeWW1cTwzLtf4BqyEWQ==
X-Google-Smtp-Source: AGHT+IEyrDzBp9W/WtAeKZmkqc5SbBNvKgz8aeElrFErjEFLmzA06G0jJ2AtVIXkfwdGOPeNFW1XqA==
X-Received: by 2002:a05:6870:c112:b0:259:8b2f:8d76 with SMTP id 586e51a60fabf-25eae7efc0amr13624967fac.20.1720960324577;
        Sun, 14 Jul 2024 05:32:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebd113csm2612527b3a.91.2024.07.14.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:32:04 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:32:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 07/10] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZpPFSe1nIDRGtsH9@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpPEdmUN1Z5tqbK3@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d22488c5d0..d3b466b84e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -898,6 +898,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
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
@@ -1067,6 +1082,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

