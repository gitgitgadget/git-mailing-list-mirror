Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61731F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfJCXdD (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:33:03 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:55498 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJCXdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:33:03 -0400
Received: by mail-vk1-f202.google.com with SMTP id n79so1768821vkf.22
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EQu6Y7Ogtoa6KK2TBwwhxd/MyYg+Q/zFwy2++kNID7o=;
        b=U4GriS7Z6OV1HAKV7A/UEw+CnE/MJKnCu1OPskF3oMgIG/UOnQIvDS8qaGQWj4SfB9
         kVKo887D68KYC5VVpksbqBIWtfhNKrsED4oi/zpXRKwcYpr9aCWC1rXYtAyAi2I74giG
         xJO/teRJTvK5CRkd7AZSom/DDmb/+Dq0XCwQ9+NVRS7g2CBhfeyilzyB6QUJHl//W4kG
         eaKfsHA24P0R878/vgaLtgK6h9YMHuKcNSwxfQIJxs5bzeA5JpDR8QwOxmiGOuj3qRBs
         7x5qrlui4Jl6me456BOJH6+2UwLQa1btikqp937pjNSxItOvMcmrKHEEbThKZfUDThri
         xhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EQu6Y7Ogtoa6KK2TBwwhxd/MyYg+Q/zFwy2++kNID7o=;
        b=Cj9xI8nuJ75G1yW6lo1GAD3TznoNtdGy8QF/5oep3mLP4xGLekky852lolIlzcTjSl
         Nrs4frdIbDsNV9Ou9i7Bwhx2+Y7HBpLwQdued0vuxAbk2XyQFYoiLU/egRaB0oWJQrTW
         AaM5Ay71RrkPY7qfxpqtmh18jPu35LoVFdkhyPcmsuk5uM+sKmEPQFX3Voyf82Te20GN
         gFB/I9RNDEj1/l0/WqrF0ryN19HLDhaRzVgZN7tUTFmiBk87RdsE/3+Wy003ojMpH2jf
         7ZQsCi220k/Y5XaoJeBU4Nzs8A9xTDw0MFX+Vnj/Lvuj018/SdKZXB2/u29pY7Nvr2Kp
         7PxQ==
X-Gm-Message-State: APjAAAUWLYn49+KY4l7X7Mh279ffNAsMEoR4YjL+2Vi+mCrXazVK01ln
        T8LCQ3O+TNGcFvQ40cwRLupFJsyhif3TnL+Z7jko1muPFdTDDIPliIGcuewpudY3zI/+BtzTwQT
        G0wtEd6H4ijBXcp7VGPT/GFWjQE5tXPQEo6/NEoYvijvNdw1StAFhmpZ1bk6ZgxU=
X-Google-Smtp-Source: APXvYqy54GQppAbRXG1dNwlPhcy7FXRMQdJ2sQA27wW51H8P0BjnLIy6rDYTq2CGt/C1MXLNssC3U1pFiBnfGw==
X-Received: by 2002:a9f:3152:: with SMTP id n18mr5958099uab.130.1570145581914;
 Thu, 03 Oct 2019 16:33:01 -0700 (PDT)
Date:   Thu,  3 Oct 2019 16:32:55 -0700
In-Reply-To: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
Message-Id: <cover.1570144820.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v4 0/4] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Cc:     stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the delayed reply. I've added a new documentation patch
describing what we expect w.r.t. the version event and its "evt" field.
I've also reworked the final patch to allow writing a full trace session
to the sentinel file, and to make sure that the overload event comes
after the version event.

I am still incrementing the EVT and writing a new "overload" event,
since you said in the last review that this approache seems best to you.
But I am also happy to keep the EVT=1 and make "overload" a new field in
the "version" event if you've changed your mind.

Josh Steadmon (4):
  docs: mention trace2 target-dir mode in git-config
  docs: clarify trace2 version invariants
  trace2: don't overload target directories
  trace2: write overload message to sentinel files

 Documentation/config/trace2.txt        |   6 ++
 Documentation/technical/api-trace2.txt |  30 +++++--
 Documentation/trace2-target-values.txt |   4 +-
 t/t0212-trace2-event.sh                |  19 +++++
 trace2/tr2_dst.c                       | 113 ++++++++++++++++++++++---
 trace2/tr2_dst.h                       |   1 +
 trace2/tr2_sysenv.c                    |   3 +
 trace2/tr2_sysenv.h                    |   2 +
 trace2/tr2_tgt_event.c                 |  31 +++++--
 trace2/tr2_tgt_normal.c                |   2 +-
 trace2/tr2_tgt_perf.c                  |   2 +-
 11 files changed, 185 insertions(+), 28 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  a757bca8f9 docs: clarify trace2 version invariants
1:  bf20ec8ea2 ! 2:  98a8440d3f trace2: don't overload target directories
    @@ Commit message
         The config can also be overridden with a new environment variable:
         GIT_TRACE2_MAX_FILES.
     
    -    Potential future work:
    -    * Write a message into the sentinel file (should match the requested
    -      trace2 output format).
    -    * Add a performance test to make sure that contention between multiple
    -      processes all writing to the same target directory does not become an
    -      issue.
    -
     
      ## Documentation/config/trace2.txt ##
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
     +	struct stat statbuf;
     +
    -+	strbuf_addstr(&path, tgt_prefix);
    -+	if (!is_dir_sep(path.buf[path.len - 1])) {
    -+		strbuf_addch(&path, '/');
    -+	}
    -+
     +	/* Get the config or envvar and decide if we should continue this check */
     +	max_files_var = tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
     +	if (max_files_var && *max_files_var && ((max_files = atoi(max_files_var)) >= 0))
    @@ trace2/tr2_dst.c: void tr2_dst_trace_disable(struct tr2_dst *dst)
     +		goto cleanup;
     +	}
     +
    ++	strbuf_addstr(&path, tgt_prefix);
    ++	if (!is_dir_sep(path.buf[path.len - 1])) {
    ++		strbuf_addch(&path, '/');
    ++	}
    ++
     +	/* check sentinel */
     +	strbuf_addbuf(&sentinel_path, &path);
     +	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
2:  bab45cb735 < -:  ---------- trace2: write overload message to sentinel files
-:  ---------- > 3:  790c5ac95a trace2: write overload message to sentinel files
-- 
2.23.0.581.g78d2f28ef7-goog

