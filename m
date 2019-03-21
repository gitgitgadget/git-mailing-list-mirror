Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E2A20248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCUVJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:09:57 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:45762 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCUVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:09:56 -0400
Received: by mail-ot1-f73.google.com with SMTP id i5so106836otl.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=aTTtOjMEvxQYspYILqGX5kgvmTIR+7Ywb5ak59Nwr+o=;
        b=J7h9+dpM8Elrew/wgVCDmO1gpox8s2eU/zAAg04I848+D6HsiGpI/MfLn+oLQZmVwK
         UJYg5OT5ECz9EMIOTNsRp3pZkTNMdk9G62B34PQwtzdOSoYwPSx2EEY+fIDAV3d+6eqd
         OeTkmB2TSpKwHC2j/Tobhl36zj9wwiwdczsqd3S7LwKmIBSaYs+3tYk5Ax7cUj3C79kU
         U+iTqQc1utZxPIjLmBL/uN5k8HguajDLbsWNeACQjsSIzT5PaM6o7Vjo+IDnwBVUuUyF
         raApCwlhQbHFVce4s/d2dPx9rSctqWdq/OER04RIJsHvQBCbG/THxWGrxHhBjhxrjMqI
         yhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=aTTtOjMEvxQYspYILqGX5kgvmTIR+7Ywb5ak59Nwr+o=;
        b=eF/VvFRQ65tz+lPyiGeg+Sth3BJacsbWp+XBgna1HhiAwAI/aLG44n5RX5d5uq0MIP
         WBorU3wVPw60m+LyDcTVLUpLNBLaMNYmWg0ti3F0Cfw4w5jWoSuqmVc9MwlCHYxWeM70
         NtMfvLv8LZG37BkBKSRxPedtpFKVD7SBnrsjH+pzWy5Zu6Jw0bmMczQFeIB+v/CLLSsM
         16bZq6sIAmFUikKnqkoP3U5dmjyqMbdMsPxa5SmUq0X+T9yAjUiyOa7xx2KvE2uOsAAB
         qKW7eUXONg1n2kv+w/0LHPOAZnBClLKfutPEGwXN+bF0o0Cip4SYnzTY4AgqNp/0QWMj
         h9SQ==
X-Gm-Message-State: APjAAAWQoq0pQZYv3zDh2jQjCrS0DAugna1M4du3tdAuEYkEEMUd17Xk
        61HOmHnduFn03cDPNNX7NnnmogFfxR1/xzg69IEJ5LHleJohcP/pYdJnQWx8HxjuRjTtAI/6UYY
        mldRxWZu7vznMsxdhkcNiLm7otKHc5wq2mfpOIY5a2btxfQ6vOUuHSxBj7hMxaGI=
X-Google-Smtp-Source: APXvYqwAraFMTLabW0lXGcrHu/RWqOHQZJCluQ9BFmX+SdA324vb2ned9mI/IcJFYcP5QZrpx5awD0IlOp8Ubw==
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr996739oif.117.1553202594577;
 Thu, 21 Mar 2019 14:09:54 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:09:50 -0700
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Message-Id: <cover.1553202340.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v3 0/1] Write trace2 output to directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Persistently enabling trace2 output is difficult because it requires
specifying a full filename. This series teaches tr2_dst_get_trace_fd()
to create files underneath a given directory provided as the target of
the GIT_TR2_* envvars.

Changes since V2:
* No longer appends a suffix to filenames on the first creation attempt.
* Renamed function & constant now that randomization is no longer used.
* Simplified strbuf usage.

Changes since V1:
* No longer supports timestamp templates.
* No longer supports filename prefixes.
* Always creates filenames based on the final component of the trace2
  SID.

Josh Steadmon (1):
  trace2: write to directory targets

 Documentation/technical/api-trace2.txt |  5 ++
 t/t0210-trace2-normal.sh               | 15 ++++++
 trace2/tr2_dst.c                       | 63 +++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  59d8c6511b ! 1:  ce5258610f trace2: write to directory targets
    @@ -23,8 +23,8 @@
      
     +	If the target already exists and is a directory, the traces will be
     +	written to files (one per process) underneath the given directory. They
    -+	will be named according to the last component of the SID followed by a
    -+	counter to avoid potential collisions.
    ++	will be named according to the last component of the SID (optionally
    ++	followed by a counter to avoid filename collisions).
     +
      `af_unix:[<socket_type>:]<absolute-pathname>`::
      
    @@ -37,7 +37,7 @@
      	test_cmp expect actual
      '
      
    -+test_expect_success 'randomized filename' '
    ++test_expect_success 'automatic filename' '
     +	test_when_finished "rm -r traces actual expect" &&
     +	mkdir traces &&
     +	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
    @@ -71,9 +71,9 @@
      #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
      
     +/*
    -+ * How many attempts we will make at creating a random trace output path.
    ++ * How many attempts we will make at creating an automatically-named trace file.
     + */
    -+#define MAX_RANDOM_ATTEMPTS 10
    ++#define MAX_AUTO_ATTEMPTS 10
     +
      static int tr2_dst_want_warning(void)
      {
    @@ -82,45 +82,47 @@
      	dst->need_close = 0;
      }
      
    -+static int tr2_dst_try_random_path(struct tr2_dst *dst, const char *tgt_prefix)
    ++static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
     +{
     +	int fd;
     +	const char *last_slash, *sid = tr2_sid_get();
    -+	struct strbuf base_path = STRBUF_INIT, final_path = STRBUF_INIT;
    ++	struct strbuf path = STRBUF_INIT;
    ++	size_t base_path_len;
     +	unsigned attempt_count;
     +
     +	last_slash = strrchr(sid, '/');
     +	if (last_slash)
     +		sid = last_slash + 1;
     +
    -+	strbuf_addstr(&base_path, tgt_prefix);
    -+	if (!is_dir_sep(base_path.buf[base_path.len - 1]))
    -+		strbuf_addch(&base_path, '/');
    -+	strbuf_addstr(&base_path, sid);
    ++	strbuf_addstr(&path, tgt_prefix);
    ++	if (!is_dir_sep(path.buf[path.len - 1]))
    ++		strbuf_addch(&path, '/');
    ++	strbuf_addstr(&path, sid);
    ++	base_path_len = path.len;
     +
    -+	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
    -+		strbuf_reset(&final_path);
    -+		strbuf_addbuf(&final_path, &base_path);
    -+		strbuf_addf(&final_path, ".%d", attempt_count);
    ++	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
    ++		if (attempt_count > 0) {
    ++			strbuf_setlen(&path, base_path_len);
    ++			strbuf_addf(&path, ".%d", attempt_count);
    ++		}
     +
    -+		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
    ++		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
     +		if (fd != -1)
     +			break;
     +	}
     +
     +	if (fd == -1) {
     +		if (tr2_dst_want_warning())
    -+			warning("trace2: could not open '%s' for '%s' tracing: %s",
    -+				base_path.buf, dst->env_var_name, strerror(errno));
    ++			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
    ++				(int) base_path_len, path.buf,
    ++				dst->env_var_name, strerror(errno));
     +
     +		tr2_dst_trace_disable(dst);
    -+		strbuf_release(&base_path);
    -+		strbuf_release(&final_path);
    ++		strbuf_release(&path);
     +		return 0;
     +	}
     +
    -+	strbuf_release(&base_path);
    -+	strbuf_release(&final_path);
    ++	strbuf_release(&path);
     +
     +	dst->fd = fd;
     +	dst->need_close = 1;
    @@ -140,7 +142,7 @@
     -		return tr2_dst_try_path(dst, tgt_value);
     +	if (is_absolute_path(tgt_value)) {
     +		if (is_directory(tgt_value))
    -+			return tr2_dst_try_random_path(dst, tgt_value);
    ++			return tr2_dst_try_auto_path(dst, tgt_value);
     +		else
     +			return tr2_dst_try_path(dst, tgt_value);
     +	}
-- 
2.21.0.225.g810b269d1ac-goog

