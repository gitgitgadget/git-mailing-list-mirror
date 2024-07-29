Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DF3C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259624; cv=none; b=q42dqw1x/pLP6Yig/nuK/6+7c+PCje+bEoSGDPG0nDTxFhJhc4oWmdrgORp4+WjDZSTcq9KPiuU6Muw+/qJC7vcJswMzYRKn/bsL1hFYM/Ny9S7lvrc6nzmoTWTavtLnmLLIRQ6+4XMuJ/DNNAHwLchF9TMCYdSt/wxYLy+Q4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259624; c=relaxed/simple;
	bh=oax5/mdMia1wwui+zWhHZFMJU1RQQUU4ACCyNwi5t3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXSYSaR8JDEOFofxyoGRxY7bRY+oEAG1TVfchZHRKEVV3nq6v7zjZhg+sfsRccs8LyjS8KbqD/+gzKBp055fGrOSukg8oXaylXq5wmi/0bA8b0AUY1mSE849LproRg3bkYYyzLTnTitLoZAI9dkYX+j2gV6E/AcppB65JjIpbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlDxf5nn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlDxf5nn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso17386345ad.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259621; x=1722864421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IR9haSBQCofcS8AJE48/2fbkLIAod6GEFRFzV3dFIc=;
        b=WlDxf5nn2R9my49jzHFc3QZgR2utl2BPBPAWSQzcfHf10lEmtwUed2Z+bB+qP+JVKY
         i22PlJFwFLFcPT94uzFayQ2I/sBYQ0rW/xCE5ky1I14elmgwwboWbM2HXQ4mm7haHMGj
         A9XRzWDw7mbYRtzu/3TIH80Ohs20zdy4065g96UDWC0m8Q/FIP6vCcWw1Y4DiJ2BVvjI
         kgl1ezlFNjOjJHLjLkSypAPmmtOEjSOCALqGaFbftO02PQYzz3bFcojDiyiVInDCp5PQ
         QWfwcHLjKNre+sgDbXpNDfjqEa434gfKgcKdMgHaLM026l16qGg6sWbzoyzBaWXPMqJT
         F3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259621; x=1722864421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IR9haSBQCofcS8AJE48/2fbkLIAod6GEFRFzV3dFIc=;
        b=NNVrwDSQ+7fY9K0seFnqOg3yDjrpja3OQi/BDa2PSQnoNfoX58D+lDB4GrgsDVK2eT
         7/vIoGJd47FwfL8kQUUtFpeF8QZGu4c+wSUU2iWPsCX6uY5HDL6QB9vNOsnjU+mEN8Gm
         znX/5tjTo1vbdfTE6ZmP0WgE3HwOMzOwlGV1ec1gToOQYnbAvVg77Ers5OvbR6gpThgX
         jN3kQ6pyfVIZ0ol8yBezoDNMBqS440DyQ2kLNDQ0G0PSDCL8srskMPH4dEs51s/7lP7g
         UPvZv7IGGNq3zSsSfrl+2wmtxt3MmH1rPydrov16fM1lr5/N+9gQAbrJq6Wz8/NGnnn/
         vwcw==
X-Gm-Message-State: AOJu0YyOPfVvwKjbRSVmSyG7MFZpoMYk+Tpc0x+ptSEynF44hcuN+vDn
	5GXKSyILxSiKn4f7Q/1/wPBRm1cEwdU2RoACfHycSQcMjN9dpQd2E83wdQ==
X-Google-Smtp-Source: AGHT+IFt5gLosEoIXBYfDaoJ0S/j6i8RjrfAjX9JUHJ4PR9HGwfBfwrXTOM+nXh7fn6sLvuvn2QwVg==
X-Received: by 2002:a17:902:e804:b0:1fd:672f:2b34 with SMTP id d9443c01a7336-1ff04858af4mr59209325ad.33.1722259621483;
        Mon, 29 Jul 2024 06:27:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7f593sm82718965ad.36.2024.07.29.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:27:00 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:27:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 07/10] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZqeYuWCQxOwW6msl@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8553e2bc1b..7ca1628ba5 100644
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

