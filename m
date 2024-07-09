Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82136152160
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528568; cv=none; b=rhSXDy/iGAGmOXBopaDAiYAtglw6tVHqWAHMlK6dEi6vbsu/V7AX6317GYDkCldtAPkiyckAOXfpwsz8VSxPfM8F0/duaC5p2fGmhzhCX/dwNnwThDG2ZxhS9wRAi7jT14AUffFONuQIAcPc173mHj5lEBpJBdbae8DkQKZydik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528568; c=relaxed/simple;
	bh=GPo+wJphr/bQOMx/lM4LzA7A2cyA6HvGGdXEE2sIFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cph/KJ/JhcbZKAtMcen9gkLa5xFlUjNmizbxBvym31OvHvogeLvkR5jXPhHvG3CMpbcPBUEuqmnc2G8ur67AW3xjL6BzhQienqLr0RRiq5WWt+tzemUEWVEPrxH9FoOvahZqhwnrG7KBloo9V7g+v08OvLAw+GdAvYgSfpScN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDRQh49g; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDRQh49g"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b13791a5eso3098600b3a.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528566; x=1721133366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=PDRQh49gXJgbT41zldrGwRJ9ogtBiwsU77/QofYZMOhQIDBA4C6e4BvSfmgDbTIvIE
         oPguLTjJDy8WhYhNcXqf1Rz1QKK7GmZUNoXPx1Vtr13Nw4btxWMeqZwu+qZ4J59DDnH6
         EmvlL1SA/0fNka6IdE70QujpwecHXaEvD1xfFCA11z/OOKoxHreVJ12ZVNCBwSjq+jdI
         ka6aTnFIIG1xa7fQhK+DRE73M4AzlS8XlGzJUr/wQehX4LBUZTahmCGIhbw0aTMNC7ub
         DHYL/TYO2lJkXxI/3v4057X26FCOjpk+g6+GfWAR5CSKrdgdil8sGRyTQb8yHOORSTPV
         QgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528566; x=1721133366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=vV0cfPwykCmAb0CuJr7HIbXE6rvD/6xj4OwsKI3tqyW0T6m0VWkX73SMBe/BEhxduA
         bmX/vRKtoqsWlWHKzkKl3GW3FP211qn8ODZcFm7it1zuC0SDR+Cn2tNSjYXdyN8EkmPt
         ivV/F4jBYMJsyTNGFWwmx8+aHQgzsLmOSmcQrZ7BhYlDi/LykvAYUlx/F+Pa0cfcC7LU
         R0SmMe9GPfrRDnY265aXD0H28mleW5S9t5/A+1dPCoC5xnFZPGYttEGZATEMw2glmJQH
         N+AAtxcn9bpEzaFdKWYkfnz00DqOmDQHqm/lwIp6IghlEHyLWwgapQrbErHBVnP0k8wJ
         XCuw==
X-Gm-Message-State: AOJu0YyjB1AONUgOvoq+accbaSreTOucowD9CU6PW2Y7ADi1oJERwshF
	Ll+5pV8iUh5TYLESXTswLVtoZmDQpf/MMl1agvzGwARWCdJrEJad9H4WXO0G
X-Google-Smtp-Source: AGHT+IFKf+jirBf7MuIXbWnnV3ZWGFeSUeKA7jO1In6Cmum9/I9uEYKgP+YCqnSArqmC89s7z2Wj4w==
X-Received: by 2002:a05:6a00:180e:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-70b435f6239mr3238666b3a.25.1720528565358;
        Tue, 09 Jul 2024 05:36:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43984adcsm1672686b3a.162.2024.07.09.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:36:04 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:36:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 6/9] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <Zo0us3MQE0VYNrCu@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

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

