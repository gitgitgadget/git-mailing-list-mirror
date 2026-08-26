Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DF34A3AB
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739598; cv=none; b=uetdNHzYm/5yfe4SI011B70sLqT1q+VB9avpVMwBpzW1NLGTGCQ1Mt5Eu74/HBdHMnbUVJosZSnm1s2TZh19ECPAHx16y7A6ep7FYQh7Xq5Dlar8iA4GNrmuuD0wFRxgt5N6Gpkv4pB/zTMvDi5v9fDerHKwkkZH+Ccfgk/O1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739598; c=relaxed/simple;
	bh=m8UHK+WxqvC7m+kTSADRohXIZTZew4i9E4rchsnu5lk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Ps7RIlT2NgVJARrrlXcP/8WRGdTy6gRg+mpXa54rXvAM/vuAsaiLHZv+7rQSmFuWrKE9wF5bTgxbuaY4wTU22BFMeo4lKDQn51fazyrAMtVU22de0udGLgI8ORzi0YR45uhGoTIz9UKIWQ1sccJpx8m4erNF88NPJkh8SA86QgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYXPCbp3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYXPCbp3"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c16794450aeso82977866b.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787739594; x=1788344394; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2txF60IH/QmR6o4WX1EJU+oAjRuj49G60339+Ew3y8=;
        b=NYXPCbp3XyagTp/Ech6cNJsF7xiasZEo3bMWsl63KTLI6w7qWMnSTZDyWOITWgXoiW
         PsDctljT4y9X+5nKzPfZ17Lflqto3p+vK/AQh9PvXJlMF/bENVC/gLUWUhtvj/ZEUKmV
         IWTj9vwRv4rtYoNzlBElW753rvPJNOiV8/9EsbLuykAdYMs09/sOVP9VN/PW4NLxH9Dj
         2Oas53QtdZn/m0cUWfTAZ47rAuKQNIqOD0wtgaj60AeKx3OAHYHaJZSnAgFfr+qu+nAr
         Blhb9UOj5OIT9hCRPizNIpzyOZAXlVT7qKWeBnbmDi6YIM2EA5adx8oFIvB184IG9IB4
         DEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739594; x=1788344394;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2txF60IH/QmR6o4WX1EJU+oAjRuj49G60339+Ew3y8=;
        b=L8qt7XlHEVwbgNnwlWesbQDrqtKvqRadYEw6ejz7vsaFyPIEh+RZocbQEJ2mvYy5e3
         vbEz3q6gsSbRiLW2rePIo6OBD6pPPSGxowTifpw0l9Clr9ursVOPfg8FuYgp2/9LS2Xr
         DsVLVGSErrfdocxaIwLYvYUKEkLuVoC1tSzqv9jgDA3jdhyAEe10k45wNUk+ZAWjwamJ
         qtu8YKuwDgmD0vrDF9e/9dhRrcQpubmyz8x8YGpaU8vOF31K8QgxQ3iUWAGyudyBf7FS
         hlwzUHYCY16cDAQF9svYSvdIGSfXnoNc+DKeTqczipoRQYqAuoZnoYfUxb5VDiiqEnQP
         MAuw==
X-Gm-Message-State: AFuF++nSLhNEdU1Wx7A+NJXUCfbA2gluSW6ku42x4DlzhfKjBwMXcHfY
	i2TezuIiuadPkDluycPhGn6uWX974/wk25hvAKXHgXyiGTYYmsdbCWQh
X-Gm-Gg: AR+sD13cbwCd1Dtuc8yHtBqMet7rNm2+vAAt9FmJbuTeSa/O5zNrlVIypOkrtOVLGe8
	rbrTQOQv9sHqP6OAW1QD6+Zt4IiwGBIDQPy7pTICEWis8olcj8DwkejaSWISddYR4IXh1RmxOxH
	BS/2Ss9Sg3XzCWs/d9m07cdSnz/XZWQ4scA6zsluce8Y56qDEZEGbN7EqEZyJQQqij9DHyYqOt9
	kOXIh8iOQUdl5vYH9MKYKy9IDYjEdj+EL0c4aUgFJVyd3yh72W8UfP72gBmAYL4rggzAWem73nG
	yYEyrQ+Nuk2jUsCyE66/uhAf5ZkinE1d6swpTWz99gudGAzoGVdY4zVmcTLoFSJhhW3GH8NsP1o
	LBx3xaK3zmoA537pr73+kryLOSq1xkOWwB8KbfqXPlpF0/p+QfMe3ZAqfKyJzuZML6tTNQ1HT/E
	VYM5q2+h60LBAY2TVIW0cQhAEapW2g2ZaJo/kxx/5Lba/odIQSvcfN+loaH7Jbo7VYI/6/WGuqP
	vesVDpi4QtkIH30XLm21VBMw4HoHe/W4YmYZg==
X-Received: by 2002:a17:907:9802:b0:c25:2f1a:b396 with SMTP id a640c23a62f3a-c252f1abfbemr76798466b.13.1787739593909;
        Wed, 26 Aug 2026 03:19:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d310:93d0:2327:2f19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d6acasm477971566b.9.2026.08.26.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:19:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/3] hook: introduce the receive-report hook
Date: Wed, 26 Aug 2026 12:19:36 +0200
Message-Id: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N3YrCMBCG4VuRHO9IMv2b7JH3IR7EdGKj22ZJa
 lGk926rCEV6+MHM8z5E4ug5id/NQ0QefPKhm0b+sxG2Md2JwdfTFiixlKQQqoLAd30M9dUyNCF
 coDhmxmmnTMUkpsf/yM7fXuj+8N7pejyz7Wdpvmh86kO8v6qDmu8+AVoLDAoUkKGaNJcFZbQ7t
 cb/bW1oxRwYcEGgWiVwIlhLRlcZi9Z9E9mSyFeJDCTkWhdYOmlkiUtiHMcnacbiJ0wBAAA=
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11386;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=m8UHK+WxqvC7m+kTSADRohXIZTZew4i9E4rchsnu5lk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqOvcdN8xVvYjA2t40bW0c36/DEZfsHK+YN5
 H5+Zafwo3MBBIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjr3HAAoJED7VnySO
 Rox/NwYL/RpQmSUG64mKJnjGv+fJP013+HI+fIbioGDHSuQj7Hd1gTUUGTeSzihrFcQ27cBa9ow
 GyzBFS9zA4rT9aZ0d0+EZmnKP/6575yI6c17Gg3dwrzA1EjKw/QiD0mSq4IiMFkfkCmT7Nw6utF
 1cOp6P2hRPA3LJUwVJ1af87duRtkK3YzdM3wNZx/55m3PPQNleW1wrhqrPtpBfZK2p7YhhGUa8I
 em5D8MrLD79z+ONWutj3mX/doAA1G36VHCiK2kYRdH6GmW9PLpTer6H+5UvBQiUc1+tGtdpdlp/
 TSoiCETamhDxa3h900H9Hxo/hsiQmqEDAE0xIOzh0TPQxK9JvSTkfE6yskL8w0pY7QU13ZKxp+A
 UMzWfZr7cZgm7+KQqJHdgdaQC3OPsOdKSVByQkVcwpkXg79E6DvxVBv0Th1gLj3ATEfS3m+4Iyn
 JsdanpuPDe9mPsyWTthFaeZrwPF5Ks+DF35Jjvux3XKV/4hWHABoh/JH1jqhvScobX8jtPaqLm6
 3w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Introduce a new receive-report hook which kicks in after the reference
transaction is complete, but before the report is sent to the client.
The hook receives the pkt-line encoded report in its stdin and its
stdout replaces the report transferred to the user. If the hook exits
with a non-zero exit code, all references are marked as rejected.

The first patch, adds missing documentation to 'git-receive-pack.adoc'.
The second patch refactors code and the third patch contains the new
hook.

---
Changes in v4:
- Change the name of the hook to be 'receive-report' to avoid ambiguity.
- Link to v3: https://patch.msgid.link/20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com

Changes in v3:
- Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
  into a new commit.
- Add a new commit to move out the response generation in receive-pack
  to a new function.
- Instead of die-ing on non-zero exit code, we modify each reference to
  indicate that the hook failed.
- Instead of correctly listing out the protocol, link to
  linkgit:gitprotocol-pack[5], as the protocol also differs between v1
  and v2.
- Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com

Changes in v2:
- Modify the documentation and commit message to be more verbose.
- Add documentation to 'git-receive-pack.adoc'
- Use 'ret' as the variable name for the return code.
- Modify the test to also check for the 'remote:'.
- Link to v1: https://patch.msgid.link/20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com

 To: git@vger.kernel.org
 CC: ps@pks.im
 CC: gitster@pobox.com
 CC: jltobler@gmail.com
 CC: kristofferhaugsbakk@fastmail.com
 CC: phillip.wood123@gmail.com

---
Karthik Nayak (3):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: move message generation to separate function
      hook: introduce the receive-report hook

 Documentation/git-receive-pack.adoc |  15 +++
 Documentation/githooks.adoc         |  43 ++++++++
 builtin/receive-pack.c              | 137 ++++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 200 ++++++++++++++++++++++++++++++++++++
 5 files changed, 356 insertions(+), 40 deletions(-)

Range-diff versus v3:

1:  b899f31ffa = 1:  30784c0448 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  335182cd3d = 2:  55d6a46815 receive-pack: move message generation to separate function
3:  80aa575dab ! 3:  99eeafb537 hook: introduce the report hook for git-receive-pack(1)
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    hook: introduce the report hook for git-receive-pack(1)
    +    hook: introduce the receive-report hook
     
         When running 'git-receive-pack(1)', there is no way for the server to
         intercept and modify the status report before it is sent back to the
    @@ Commit message
             too late, at the point where we have already reported success to the
             client.
     
    -    Introduce a new 'report' hook. The hook receives the complete pkt-line
    -    encoded status report on standard input, after all ref updates have
    -    been applied to the repository by execute_commands() but before the
    +    Introduce a new 'receive-report' hook. The hook receives the complete
    +    pkt-line encoded status report on standard input, after all ref updates
    +    have been applied to the repository by execute_commands() but before the
         report is sent to the client. See linkgit:gitprotocol-pack[5] details on
         the protocol structure.
     
    @@ Commit message
           status if any ref is 'ng'.
     
         - Non-zero exit: the hook's stdout is discarded, receive-pack modifies
    -      all references to be rejected with a 'report hook failed' error.
    +      all references to be rejected with a 'receive-report hook failed'
    +      error.
     
         In both cases, any output the hook writes to standard error is
         forwarded to the client over the sideband channel and appears as
    @@ Documentation/git-receive-pack.adoc: requests. It handles refs whose names match
      `receive.procReceiveRefs` and executes the actual ref updates. See
      linkgit:githooks[5] for the full protocol description.
      
    -+REPORT HOOK
    -+-----------
    ++RECEIVE-REPORT HOOK
    ++-------------------
     +This hook is invoked by 'git-receive-pack' after all the ref updates
     +have been applied but before the report is sent to the client. The hook
     +receives the complete report in pkt-line format on stdin and its stdout
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
      status will cause the transaction to be aborted. The hook will not be
      called with "aborted" state in that case.
      
    -+report
    -+~~~~~~
    ++receive-report
    ++~~~~~~~~~~~~~~
     +
     +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
     +`git push` and updates references in its repository. It executes on
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
     +
     +* To abort the entire push unconditionally, exit with a non-zero
     +  status. In this case the hook's stdout is discarded, `receive-pack`
    -+  modifies all references to be rejected with a 'report hook failed'
    -+  error.
    ++  modifies all references to be rejected with a 'receive-report hook
    ++  failed' error.
     +
     +Any output written to standard error is forwarded to the client over
     +the sideband channel and will appear as `remote:` lines on clients
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      	return code;
      }
      
    -+static int run_report_hook(struct strbuf *report)
    ++static int run_receive_report_hook(struct strbuf *report)
     +{
     +	struct child_process proc = CHILD_PROCESS_INIT;
     +	struct async sideband_async;
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
     +	const char *hook_path;
     +	int ret;
     +
    -+	hook_path = find_hook(the_repository, "report");
    ++	hook_path = find_hook(the_repository, "receive-report");
     +	if (!hook_path)
     +		return 0;
     +
     +	strvec_push(&proc.args, hook_path);
    -+	proc.trace2_hook_name = "report";
    ++	proc.trace2_hook_name = "receive-report";
     +
     +	prepare_sideband_async(&sideband_async, &saved_stderr,
     +			       &sideband_async_started);
    @@ builtin/receive-pack.c: static void report(struct command *commands, const char
     -	generate_response(&buf, commands, unpack_status, false);
     +	generate_response(&buf, commands, unpack_status, false, NULL);
     +
    -+	if (run_report_hook(&buf)) {
    ++	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
     +		generate_response(&buf, commands, unpack_status, false,
    -+				  "report hook failed");
    ++				  "receive-report hook failed");
     +	}
      
      	if (use_sideband)
    @@ builtin/receive-pack.c: static void report_v2(struct command *commands, const ch
     -	generate_response(&buf, commands, unpack_status, true);
     +	generate_response(&buf, commands, unpack_status, true, NULL);
     +
    -+	if (run_report_hook(&buf)) {
    ++	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
     +		generate_response(&buf, commands, unpack_status, true,
    -+			  "report hook failed");
    ++			  "receive-report hook failed");
     +	}
      
      	if (use_sideband)
    @@ t/meson.build: integration_tests = [
        't5409-colorize-remote-messages.sh',
        't5410-receive-pack.sh',
        't5411-proc-receive-hook.sh',
    -+  't5412-report-hook.sh',
    ++  't5412-receive-report-hook.sh',
        't5500-fetch-pack.sh',
        't5501-fetch-push-alternates.sh',
        't5502-quickfetch.sh',
     
    - ## t/t5412-report-hook.sh (new) ##
    + ## t/t5412-receive-report-hook.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='test report hook'
    ++test_description='test receive-report hook'
     +
     +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    @@ t/t5412-report-hook.sh (new)
     +	test_when_finished "git -C workbench remote remove origin" &&
     +	git init --bare upstream &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	cat
     +	EOF
     +
    @@ t/t5412-report-hook.sh (new)
     +	git -C workbench remote add origin ../upstream &&
     +	git -C workbench push origin $A:refs/heads/main &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	exit 1
     +	EOF
     +
    @@ t/t5412-report-hook.sh (new)
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-\EOF &&
     +	To ../upstream
    -+	 ! [remote rejected] <COMMIT-B> -> main (report hook failed)
    ++	 ! [remote rejected] <COMMIT-B> -> main (receive-report hook failed)
     +	EOF
     +	test_cmp expect actual
     +'
    @@ t/t5412-report-hook.sh (new)
     +	test_when_finished "git -C workbench remote remove origin" &&
     +
     +	git init --bare upstream &&
    -+	test_hook -C upstream --setup report <<-EOF &&
    ++	test_hook -C upstream --setup receive-report <<-EOF &&
     +	tee raw
     +	EOF
     +
    @@ t/t5412-report-hook.sh (new)
     +	git -C workbench remote add origin ../upstream &&
     +	git -C workbench push origin $A:refs/heads/main &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	test-tool pkt-line unpack |
     +	sed "s/^ok /ng /" |
     +	test-tool pkt-line pack
    @@ t/t5412-report-hook.sh (new)
     +	git -C workbench remote add origin ../upstream &&
     +	git -C workbench push origin $A:refs/heads/main &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	echo "push rejected: service X is down" >&2
     +	test-tool pkt-line unpack |
     +	sed "s/^ok \(.*\)/ng \1 service-x-is-down/" |
    @@ t/t5412-report-hook.sh (new)
     +	git -C workbench remote add origin ../upstream &&
     +	git -C workbench push origin $A:refs/heads/main &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	echo "push rejected: service X is down" >&2
     +	tee raw
     +	EOF
    @@ t/t5412-report-hook.sh (new)
     +	git -C workbench remote add origin ../upstream &&
     +	git -C workbench push origin $A:refs/heads/main &&
     +
    -+	test_hook -C upstream --setup report <<-\EOF &&
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
     +	echo "hook-stderr-message" >&2
     +	exit 1
     +	EOF

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

