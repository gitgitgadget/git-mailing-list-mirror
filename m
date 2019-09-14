Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110AE1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 00:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfINA0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 20:26:04 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34111 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbfINA0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 20:26:04 -0400
Received: by mail-qt1-f202.google.com with SMTP id f19so33595770qtq.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M5FQ0tdW10JGWo2qBWST/Dn2Qy4HYj+CrtJB01fomew=;
        b=NtHeQqYSIfMjfh04gN22bJnS32zJxtcQri2gbqcnVZ0jWbgzcrWaaow9N3qjK31ZKx
         pPnuMOyJJS9z2COFaaTR8sZna27ISa8TVftj2WzFdcQVTsoGmfYOucgJBj/nx/Ki/4W1
         5u/X05Vjv6uq7r/50yh1c+HWXNBK7M7XmaV9OMYeY+G6RTLb3DI5uGHJOd5sl/pv1Inx
         kjHpog35rl39894iexZ4BG7OzeYmgYUQCVxnO4MhTWQaImkMTmj652xUQrvcOt2EvctZ
         hqBorOh2TyAzWhs3MIqIJTFirVhT2JkBlibyhTOKNE9Hv9U2afO1kLBKWCp1TIZxGefa
         ZiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M5FQ0tdW10JGWo2qBWST/Dn2Qy4HYj+CrtJB01fomew=;
        b=GBixXvT57QRC5T453+7QnT/DqrxaKP2e/EzU4bPPBHXUfpDivkdMXhbJe+sJDg+1rz
         EPeUS++jH2kG+CUHyZF0uTE/lAulpKhvct8YVIfLA4ugYY44+I+pznMIzr83QvDjrEn6
         8zUVHhoO4pZ6Y6hIgagwKnN2OM3fKeTqfWmsT29LeLT7tZhv8aGlQdurgPNIdI84Qx2I
         vMA4jkBj7Xa8Gn4L18DJb0vkR2ca1UeG7dJpYguu0phfOhOgr0/e2sskx38RUKuWTzRQ
         VgX3vzQruPvKdHmSJoyzQLS1YKAJbSHsPz78gzD8IC8yp02lV8TnXPa/n13K9kr+20Ft
         pjfw==
X-Gm-Message-State: APjAAAWwTt9LxE0QIm3FZL3NGzxjq8kLixfUg6lKJOiAomkKQRT/Zv4M
        pT7aT9tqAzix9j2mUBjy4CjtSdDy+BiPdde7fzdS1k1kEqJOMQ821icrxnvt+iodrwd3O5BSIdg
        KehYVcTVpM1tNUh3cNGwBGPHi1/KR+Mvm/bF1AqjakskyNa8uf3WPQdaZLrvBxPE=
X-Google-Smtp-Source: APXvYqzIffCfimCQ7vcqtSsq5HnEbjLEA0VCf8x5E9Pw9ZcNaDlmE3dmtHc9TwmfNE3KYZvAz/fG+alzOTEWAQ==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr6888566qkl.434.1568420762928;
 Fri, 13 Sep 2019 17:26:02 -0700 (PDT)
Date:   Fri, 13 Sep 2019 17:25:57 -0700
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Message-Id: <cover.1568419818.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [RFC PATCH v3 0/3] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is still RFC, as I still haven't done performance testing yet. I'm
mainly looking for feedback right now on patch 3/3, which extends the
tr2_dst API with an optional function to write a custom message into the
overload sentinel file.

Changes since V2:
* Added a new patch (3/3) that allows the different trace2 targets to
  write custom messages to the overload sentinel file.
* Added a new "overload" trace2 event type.
* Bumped up the trace2 event format version.
* Moved the test from t0210 to t0212, so that we can test the custom
  writer for the event target at the same time.
* Removed some unnecessary sanity-checking in the test.
* Fixed a coccicheck complaint about strbuf_addbuf.
* Used hardcoded file modes to be consistent with the rest of the
  project.

Josh Steadmon (3):
  docs: mention trace2 target-dir mode in git-config
  trace2: don't overload target directories
  trace2: write overload message to sentinel files

 Documentation/config/trace2.txt        |   6 ++
 Documentation/technical/api-trace2.txt |  24 +++--
 Documentation/trace2-target-values.txt |   4 +-
 t/t0212-trace2-event.sh                |  17 ++++
 trace2/tr2_dst.c                       | 118 +++++++++++++++++++++++++
 trace2/tr2_dst.h                       |   3 +
 trace2/tr2_sysenv.c                    |   3 +
 trace2/tr2_sysenv.h                    |   2 +
 trace2/tr2_tgt_event.c                 |  21 ++++-
 trace2/tr2_tgt_normal.c                |   2 +-
 trace2/tr2_tgt_perf.c                  |   2 +-
 11 files changed, 191 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  65e05a3db5 = 1:  eacffe250d docs: mention trace2 target-dir mode in git-config
2:  f897a11068 ! 2:  bf20ec8ea2 trace2: don't overload target directories
    @@ Documentation/config/trace2.txt: trace2.destinationDebug::
     +	write a sentinel file that will block further tracing to this
     +	directory. Defaults to 0, which disables this check.
     
    - ## t/t0210-trace2-normal.sh ##
    -@@ t/t0210-trace2-normal.sh: test_expect_success 'using global config with include' '
    + ## t/t0212-trace2-event.sh ##
    +@@ t/t0212-trace2-event.sh: test_expect_success JSON_PP 'using global config, event stream, error event' '
      	test_cmp expect actual
      '
      
    @@ t/t0210-trace2-normal.sh: test_expect_success 'using global config with include'
     +		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
     +		xargs touch <../expected_filenames.txt &&
     +		cd .. &&
    -+		ls trace_target_dir >first_ls_output.txt &&
    -+		test_cmp expected_filenames.txt first_ls_output.txt &&
    -+		GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0
    ++		GIT_TRACE2_EVENT="$(pwd)/trace_target_dir" test-tool trace2 001return 0
     +	) &&
     +	echo git-trace2-overload >>expected_filenames.txt &&
    -+	ls trace_target_dir >second_ls_output.txt &&
    -+	test_cmp expected_filenames.txt second_ls_output.txt
    ++	ls trace_target_dir >ls_output.txt &&
    ++	test_cmp expected_filenames.txt ls_output.txt
     +'
     +
      test_done
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +	}
     +
     +	/* check sentinel */
    -+	strbuf_addstr(&sentinel_path, path.buf);
    ++	strbuf_addbuf(&sentinel_path, &path);
     +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
     +	if (!stat(sentinel_path.buf, &statbuf)) {
     +		ret = 1;
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +		closedir(dirp);
     +
     +	if (file_count >= tr2env_max_files) {
    -+		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
    ++		creat(sentinel_path.buf, 0666);
     +		ret = 1;
     +		goto cleanup;
     +	}
-:  ---------- > 3:  bab45cb735 trace2: write overload message to sentinel files
-- 
2.23.0.237.gc6a4ce50a0-goog

