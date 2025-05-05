Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A124EAAF
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458850; cv=none; b=GbFT2iXOjzCQWYoqigtIbl6iv7HQTB/hv7Dr/N9V+Qm8FNldOCWgzwjWwkxmlU3ZJNoN2779FS6HD7HuYy/pi9Ufv5lhW4YQA82J6+7iPRaOqVV0q21dYJo0pdJrfIEzBVHmgFHrlLiX9ClrGD8FEH2u9MiOFACfHWETJwVuPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458850; c=relaxed/simple;
	bh=oYYxq3tmlAO8yARhosA8Se8h4Ab73CinnsUaVSP1v+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ATmz/+S2uKKRuASH/6EPMgJ/49RlDchbTQq/Fs4xs486Ujthj257mO2aFGnXGOWq1jaYiZ0GgCuj322fwZnR0kPO3sCSRS9SGLkJHr9BBxVXdXV6KcwY9REqVLNZ4u0O43auwk6uaNADlfI8SKYhuB5iVRYfyZusXXHodPDBCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsIqHHag; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsIqHHag"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ee623fe64so4649177f8f.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458846; x=1747063646; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkorQ5qOlHRod6gIzPh4vA+FrLiEgpqE3WQ3gENRf8o=;
        b=SsIqHHagFqRSEVcjKC1WG5MjKtmBZj9/KOJYB2pNBhNd/EJkJ/qUSjMNWJlsXRQnc+
         OSSuE3lWudCCKY7XAz+vhO7JwVncPUL44jP+uFPxiQc3mbiazuuJ/WTxdc3VYjWOoxnx
         hJNPEHjXcs0hHd614uCF5FSbiA1LgZhmlTP9ytFwwz9Ts04Kxz8ZfAEyIYhBm0C+nQMW
         F2brbJmUHJcn7o1uzqMRAbTGLOpvfjHvSGECf2XdGeHu+kJIaBb4ijqhOx3JUPKP92wY
         COC3hcFbk49FLjvvXfAKUis32pIG1Wk5r3Zb9Z7KuiGuTjG/NlDl8LrD7l6EDj0fRsqn
         tpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458846; x=1747063646;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkorQ5qOlHRod6gIzPh4vA+FrLiEgpqE3WQ3gENRf8o=;
        b=PECVXSyO/ltKhyzpuRKZ+zyWTAX603KpwC2jm0ks27OCa8VGWNP9Xvk9/Nx835RdLe
         JdlHDWsDj1OLmz4cc+wmkYWnf5n4IgEE7+FXNr+4a+xKJAVGkAG/aiSN6RCVCzfeH4+m
         jevCQKjqtN11n65QUoDLtDNDQAXXbKfcM4NcBEhxdsG9QoH6Tn+SydroLAjjQNPJyc7B
         5TtaMGlL/Yee9ie83SBxukz5EHf1T7fbgT3QMXouXizYRRevykhWzAu6gj/ytfHCbn56
         bcqPJvrMght6TG7Ryo1l/WdcAXNzqlkUMQb8ZEK5MzXLSvwtGOG8uCuUrMFIUMZ1jftM
         DmdA==
X-Gm-Message-State: AOJu0YzWnRj1fNigrNEPr8jbf16ZOprrpGrpW7JBJ57n92WyUUkhPI4B
	kyUPumZAVLWQM1ekOGkUOc+FccqjB1Sz7uAIxXBlT6nluVez9LHN0oiHzg==
X-Gm-Gg: ASbGncu4Dn8Gar2cJ1Gz8egoCAkEBNbIRGU9e2Am3+FtusZNCvGa2TTjija5wB8JVE6
	FTjI8C2K20j5GLoJusY46ebYmHC9x6NJoI3XYM4B5rvAvcOxKWXotRzfGoB6Mqn5T3rNvKhPmyb
	4AJl1/Hzakwf1UkBLGjwRDXNqw7nrVeeakAIwP2U78tfrjloa092lpTifkNGsq7K6u8d+33qR/B
	DDnscHNBcClFgUAXa37Zqx+k2GPm7reMXfiKQ8K6My2l7AC8rS0y4GYHp75HYmeRTEdYPoi/IrT
	UuEF54wHzJYqjBcP4VFvJ112jVshJrN5Ncweibk5UA==
X-Google-Smtp-Source: AGHT+IF+dXP5Yawp+0bSa7Pm4LCG+RLV9ZdzrPFXgYjI+zuACREEVLoT3X9WcqtnPClD5tXS9uKBcQ==
X-Received: by 2002:a05:6000:4285:b0:39c:268b:8b66 with SMTP id ffacd0b85a97d-3a09cf34755mr7056322f8f.43.1746458845765;
        Mon, 05 May 2025 08:27:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3339sm10666284f8f.21.2025.05.05.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:27:25 -0700 (PDT)
Message-Id: <pull.1913.v2.git.1746458844.gitgitgadget@gmail.com>
In-Reply-To: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
References: <pull.1913.git.1746008680.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 15:27:20 +0000
Subject: [PATCH v2 0/4] scalar: add --no-maintenance option
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>

These patches add a new --no-maintenance option to the scalar register and
scalar clone commands. My motivation is based on setting up Scalar clones in
automated environments that set up a repo onto a disk image for use later.
If background maintenance runs during later setup steps, then this
introduces a variable that is unexpected at minimum and disruptive at worst.
The disruption comes in if the automation has steps to run git maintenance
run --task=<X> commands but those commands are blocked due to the
maintenance.lock file.

Functionally, these leave the default behavior as-is but allow disabling the
git maintenance start step when users opt-in to this difference. The idea of
Scalar is to recommend the best practices for a typical user, but allowing
customization for expert users.


Updates in v2
=============

 * The previous use of toggle_maintenance() in register_dir() would run the
   'git maintenance unregister --force' command. There is a new patch 1 that
   is explicit about whether this should or should not happen and new tests
   are added to verify this behavior in the later patches.
 * A new patch 4 adds the --[no-]maintenance option to scalar reconfigure.

Thanks, -Stolee

Derrick Stolee (4):
  scalar: customize register_dir()'s behavior
  scalar register: add --no-maintenance option
  scalar clone: add --no-maintenance option
  scalar reconfigure: add --no-maintenance option

 Documentation/scalar.adoc | 29 ++++++++++++++++++----
 scalar.c                  | 51 +++++++++++++++++++++++++++++----------
 t/t9210-scalar.sh         | 20 +++++++++++++--
 t/t9211-scalar-clone.sh   | 11 ++++++++-
 4 files changed, 90 insertions(+), 21 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1913%2Fderrickstolee%2Fscalar-no-maintenance-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1913/derrickstolee/scalar-no-maintenance-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1913

Range-diff vs v1:

 -:  ----------- > 1:  f3a3cfe3ef1 scalar: customize register_dir()'s behavior
 1:  4910bacd052 ! 2:  1b99a559520 scalar register: add --no-maintenance option
     @@ Documentation/scalar.adoc: Note: when this subcommand is called in a worktree th
       
      
       ## scalar.c ##
     -@@ scalar.c: static int stop_fsmonitor_daemon(void)
     - 	return 0;
     - }
     - 
     --static int register_dir(void)
     -+static int register_dir(int maintenance)
     - {
     - 	if (add_or_remove_enlistment(1))
     - 		return error(_("could not add enlistment"));
     -@@ scalar.c: static int register_dir(void)
     - 	if (set_recommended_config(0))
     - 		return error(_("could not set recommended config"));
     - 
     --	if (toggle_maintenance(1))
     -+	if (toggle_maintenance(maintenance))
     - 		warning(_("could not turn on maintenance"));
     - 
     - 	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
     -@@ scalar.c: static int cmd_clone(int argc, const char **argv)
     - 	if (res)
     - 		goto cleanup;
     - 
     --	res = register_dir();
     -+	res = register_dir(1);
     - 
     - cleanup:
     - 	free(branch_to_free);
      @@ scalar.c: static int cmd_list(int argc, const char **argv UNUSED)
       
       static int cmd_register(int argc, const char **argv)
     @@ scalar.c: static int cmd_register(int argc, const char **argv)
       
       	setup_enlistment_directory(argc, argv, usage, options, NULL);
       
     --	return register_dir();
     +-	return register_dir(1);
     ++	/* If --no-maintenance, then leave maintenance as-is. */
      +	return register_dir(maintenance);
       }
       
       static int get_scalar_repos(const char *key, const char *value,
     -@@ scalar.c: static int cmd_run(int argc, const char **argv)
     - 	strbuf_release(&buf);
     - 
     - 	if (i == 0)
     --		return register_dir();
     -+		return register_dir(1);
     - 
     - 	if (i > 0)
     - 		return run_git("maintenance", "run",
     - 			       "--task", tasks[i].task, NULL);
     - 
     --	if (register_dir())
     -+	if (register_dir(1))
     - 		return -1;
     - 	for (i = 1; tasks[i].arg; i++)
     - 		if (run_git("maintenance", "run",
      
       ## t/t9210-scalar.sh ##
     +@@ t/t9210-scalar.sh: test_expect_success 'scalar register warns when background maintenance fails' '
     + 	git init register-repo &&
     + 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
     + 		scalar register register-repo 2>err &&
     +-	grep "could not turn on maintenance" err
     ++	grep "could not toggle maintenance" err
     + '
     + 
     + test_expect_success 'scalar unregister' '
      @@ t/t9210-scalar.sh: test_expect_success 'scalar unregister' '
       	scalar unregister vanish
       '
       
      +test_expect_success 'scalar register --no-maintenance' '
      +	git init register-no-maint &&
     ++	event_log="$(pwd)/no-maint.event" &&
      +	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
     ++	GIT_TRACE2_EVENT="$event_log" \
     ++	GIT_TRACE2_EVENT_DEPTH=100 \
      +		scalar register --no-maintenance register-no-maint 2>err &&
     -+	test_must_be_empty err
     ++	test_must_be_empty err &&
     ++	test_subcommand ! git maintenance unregister --force <no-maint.event
      +'
      +
       test_expect_success 'set up repository to clone' '
 2:  7ab1914b830 ! 3:  e52b1282d93 scalar clone: add --no-maintenance option
     @@ scalar.c: static int cmd_clone(int argc, const char **argv)
       		goto cleanup;
       
      -	res = register_dir(1);
     ++	/* If --no-maintenance, then skip maintenance command entirely. */
      +	res = register_dir(maintenance);
       
       cleanup:
       	free(branch_to_free);
      
       ## t/t9211-scalar-clone.sh ##
     -@@ t/t9211-scalar-clone.sh: test_expect_success 'scalar clone warns when background maintenance fails' '
     - 	grep "could not turn on maintenance" err
     - '
     - 
     +@@ t/t9211-scalar-clone.sh: test_expect_success 'progress without tty' '
     + test_expect_success 'scalar clone warns when background maintenance fails' '
     + 	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
     + 		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
     +-	grep "could not turn on maintenance" err
     ++	grep "could not toggle maintenance" err
     ++'
     ++
      +test_expect_success 'scalar clone --no-maintenance' '
      +	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
     ++	GIT_TRACE2_EVENT="$(pwd)/no-maint.event" \
     ++	GIT_TRACE2_EVENT_DEPTH=100 \
      +		scalar clone --no-maintenance "file://$(pwd)/to-clone" no-maint 2>err &&
     -+	! grep "could not turn on maintenance" err
     -+'
     -+
     ++	! grep "could not toggle maintenance" err &&
     ++	test_subcommand ! git maintenance unregister --force <no-maint.event
     + '
     + 
       test_expect_success '`scalar clone --no-src`' '
     - 	scalar clone --src "file://$(pwd)/to-clone" with-src &&
     - 	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
 -:  ----------- > 4:  6fac9c4c394 scalar reconfigure: add --no-maintenance option

-- 
gitgitgadget
