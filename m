Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB940627B
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566868; cv=none; b=f6atboL2PEcvdjlfgSfXAzSxciJLt4a240HCZSFnUA7cbQ7CoyLzAOXpF5sWOyjR9us6kJsA4CZoZm0t8yi9dpzDQJvnEB/D7HWGWNDqPmGFye35li6XeskhUgl5u5wrrXZZGzvHaXMN0j7OjuqJT+sJdOpT+mWgYOE6wJPQZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566868; c=relaxed/simple;
	bh=qDHWDyWSZXqU4ffRbBeczzfmWS6D41AH8vrmzWgBJvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RafBP8Vi4q6jDvXEp1wtb2+VhrmAsgFkd+xzoPxK69gVZnk4/DKQ4IJYSNyQHv6JUVUV+jJVwWZzDGE4FQcIp1W3cHTmzILhJaw3dBD1tZ2VpgKcbrgS/HY1IVSdKU20I+hNrlYFpsGgGo8CSzZ7geHfo2wbiRMNXH9BhpzbCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSMotdeJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSMotdeJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1f758014b8so346821466b.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566865; x=1788171665; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwsRUqAdO3UkjSALfNgRrYY0I7N1w44XB5xjb4QbDDg=;
        b=TSMotdeJCGuGo2N5eqMMVHoUVq1b1BMRBY250sI1/zUAK6us5/axNTfg2ufI6nPMhR
         NcbXlGS11k68GVn7D1HZzKfRbRDoP3ruxtxGBSHR2H/ECjnXSx3mM9aHCp1/9o+JT6Xb
         i6r2QTiOW3eFl8aTkwzSs3Eu3AHc8HpxrV9HvTd5So704Xc5rdPAEE70KWYT96ajq1xz
         Du4B5fXy+KJzIDd0eZ1TSuIOQEm62RedSBZi84BeT3sW0ENKtrwAHqJV2O3v5zlAp9Aq
         wF1X7ToRef164gS5s/qo9UrG7vperP0GxXEGMY8SD3wb27t7lzNmEv35mYjnr8B+JwzQ
         9F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566865; x=1788171665;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wwsRUqAdO3UkjSALfNgRrYY0I7N1w44XB5xjb4QbDDg=;
        b=l/+VprSFXRsYAbXcZvAxlv4mxPJ53b0qT9SzTdgbLdw6/gtkWZshMoONaNl9IKuU+O
         5tKwX9SiEPKvY6IWgn7SB0lQYXC4RG+5gSIzIaSYEHqclAcjzRtI+L6Jpp0lGZ72HYB2
         44LKfc1/YP6Tt3lOwROvYOd+1OoOSLYiIYSXLo7QyMKIcCrx+YgkbcvsTxglf7MWod6r
         wawXusUvhoJ4UbGjDGjDlUPyLHJVW7dBE+UjEbwRBnb18Vg3wTOVwp7s8gUZ50KDslLk
         nEybDJIUXEdfQn2cHwsNEDFwyMtaqJWNdj+C0TbT+ay2xLDaPKA+I+5X0YpC+R54kN6M
         TB3A==
X-Gm-Message-State: AFuF++kKQmQn0lYaam4jRZN2lEt0vyq7MjNf6k6gTHulMlPyNMF58fx/
	3wcfTijnj0M9aLMmzEJcWk+ujbzOv3ZpcFiBGbe9+1U3DGjYWwp34I18
X-Gm-Gg: AR+sD10kjUCBfIjf4X2iGOlFBtatxC9G3LuPjMPEZgL7vTmkjye0IV1vR8xdJ2u9oQy
	RDGPvnQGOiwB23czeBFvNGEGVEfhpK3rmhkLojG2eV2E/Synf8hXlU9y7sSJrVipoe/hJgRfhJz
	4kIZFw2BIwVSkXG6oGMjBznKQU188wGN29qT5vk+a1DuKvznCQB3GsoOVOFvrZiqxonokVdXok4
	lEh/C2TEAQ/8w58hSCZJwfaCzW8AeAKRVoiDn5NBGURCWEpiMm5RRyM+OqRb4AS2by0oyldZKR5
	y2Rb/i8P4zC2bC41SltbducnETd4E/XPZS5EG0ivdyHsabc6AYqGlCrFETQ/xrR7IJ4bFGaffrQ
	5FkBa78JA2UC8UOvybEDGOKWE35KEQqdC0CWGNjuEaex/LGIQRuQq8/HUlVt56ZLtpNikp2j57+
	YTltugGTbh4kR8l93hUr1cF7YVDRVrWuGmZo4g8ajhPXW4bQERVPNdoLdEu3WhYE2MBsa9yCIpo
	0o2t61Dn632WYVFkY/cOjSYoyuYn94mfQ+dCg==
X-Received: by 2002:a17:906:9f8e:b0:c19:5572:d234 with SMTP id a640c23a62f3a-c246a4ac801mr3218718866b.1.1787566864535;
        Mon, 24 Aug 2026 03:21:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1327677066b.25.2026.08.24.03.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:21:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/3] hook: introduce the report hook for
 git-receive-pack(1)
Date: Mon, 24 Aug 2026 12:20:58 +0200
Message-Id: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4X0bA1dAiye/A/joZQtVIWaFhoN4
 d8tGBMPHCd5b2Zmnpwhz07JzBwF440dImSHhKlODi1x00RmkEKRogBe5sjNMDrbTIp4Z+2d53U
 mdaWFLAlZPD4dafPapJfrl/1U30iNq2lddMaP1r23ahDr7hfAvUAQXHCU2GBFRY4ZnttemsdR2
 Z6tgQB/ChC7CogKqlICXUoFSv8rlmX5AKYsoGoJAQAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, kristofferhaugsbakk@fastmail.com, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12076;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=UDdxKWX9nWIdUJKysdi/tF/VPhL88U92+h6LUzMBFDU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMGw29iA6kwbycxVfX4XPH26bEq3sVJ1F3B
 tmOUvFMBUj3E4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjBsNAAoJED7VnySO
 Rox/14AL/0CTh0m69CWuHWpc9xbull2ukjLRCoYx6UKaTFd4IYtD+aVHu2QgR+FJZdPHU4WFf29
 IiceH/qeB1o07dKynwQ9eOVk/XbIY6k9ccKJrKOhTBHOUqNGN98pOPf1hK0Xl0Gr5U2WWMfAG3F
 PDzm35i1Bj/++EXb2+aZqfGgl1se4AkO9mYmnYMmy0Z9fRcJl+04GNtQTx34W9//0DrB4He1kVD
 vz9HMyJ9GysasMBxOFRF6NwxTOj1B8ir73CGdtb4Xm6SgEArrHasOrzZsijSwwjX8cuU2yT1ofm
 XeQyCkJWBEp045QilkXGw/nOhqWs1g+U/Wd7kXnwGv0UN65rXKOQ0tvJ13X1mFa5KNcjWmi7Mmh
 aZWwR8TwqD75Xi631nZlNFX5UxIiy22mOgOU+JL8f+VHxTBuH8ZiUlhgp5V5v/9QK9o/ubau3CL
 3R0D9/0PHI4rdIZ40x0ydMOaj7JO5bN4HkKXzI7gkzIDII+QG9DOLvoM4Ix+PCP0H4i0AtJ9Ws8
 Pg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F



---
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

---
Karthik Nayak (3):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: move message generation to separate function
      hook: introduce the report hook for git-receive-pack(1)

 Documentation/git-receive-pack.adoc |  15 +++
 Documentation/githooks.adoc         |  43 ++++++++
 builtin/receive-pack.c              | 137 ++++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-report-hook.sh              | 200 ++++++++++++++++++++++++++++++++++++
 5 files changed, 356 insertions(+), 40 deletions(-)

Range-diff versus v2:

-:  ---------- > 1:  42aaf10403 doc: add proc-receive hook info in 'git-receive-pack.adoc'
-:  ---------- > 2:  cb55895d2a receive-pack: move message generation to separate function
1:  07fa5ba8bb ! 3:  5bfaea5033 hook: introduce the report hook for git-receive-pack(1)
    @@ Commit message
         Introduce a new 'report' hook. The hook receives the complete pkt-line
         encoded status report on standard input, after all ref updates have
         been applied to the repository by execute_commands() but before the
    -    report is sent to the client. The report consists of an 'unpack ok'
    -    or 'unpack <error>' line, followed by one 'ok <refname>' or
    -    'ng <refname> <reason>' line per pushed ref, terminated by a flush
    -    packet.
    +    report is sent to the client. See linkgit:gitprotocol-pack[5] details on
    +    the protocol structure.
     
         The hook's stdout fully replaces the report sent to the client.
         receive-pack fully buffers the hook's stdout before acting on the exit
         status, so the exit code is known before the client receives anything.
    -    This gives two distinct behaviours depending on exit status:
    +    This gives two distinct behaviors depending on exit status:
     
         - Exit 0: the hook's stdout is used as the report. The hook can
           rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
    @@ Commit message
           rejected refs as '[remote rejected]' and exits with a non-zero
           status if any ref is 'ng'.
     
    -    - Non-zero exit: the hook's stdout is discarded, receive-pack calls
    -      die(), and no report is sent to the client at all. The client
    -      observes a sideband disconnect and reports 'the remote end hung up
    -      unexpectedly', treating the entire push as failed.
    +    - Non-zero exit: the hook's stdout is discarded, receive-pack modifies
    +      all references to be rejected with a 'report hook failed' error.
     
         In both cases, any output the hook writes to standard error is
         forwarded to the client over the sideband channel and appears as
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-receive-pack.adoc ##
    -@@ Documentation/git-receive-pack.adoc: if the repository is packed and is served via a dumb transport.
    - exec git update-server-info
    - ----
    +@@ Documentation/git-receive-pack.adoc: requests. It handles refs whose names match the patterns defined by
    + `receive.procReceiveRefs` and executes the actual ref updates. See
    + linkgit:githooks[5] for the full protocol description.
      
    -+PROC-RECEIVE HOOK
    -+-----------------
    -+This hook is invoked by 'git-receive-pack' when it processes push
    -+requests. It handles refs whose names match the patterns defined by
    -+`receive.procReceiveRefs` and executes the actual ref updates. See
    -+linkgit:githooks[5] for the full protocol description.
    -+
     +REPORT HOOK
     +-----------
     +This hook is invoked by 'git-receive-pack' after all the ref updates
    @@ Documentation/git-receive-pack.adoc: if the repository is packed and is served v
     +replaces the report sent to the client. Allowing the hook to rewrite
     +the outcomes or abort the push completely. See linkgit:githooks[5] for
     +the full protocol description.
    - 
    ++
      QUARANTINE ENVIRONMENT
      ----------------------
    + 
     
      ## Documentation/githooks.adoc ##
     @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any state except for the
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
     +
     +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
     +`git push` and updates references in its repository. It executes on
    -+the repository once after all refs have been updated and after
    -+`execute_commands()` has applied all accepted ref changes to the
    -+repository, but before the pkt-line encoded status report is sent back
    -+to the client.
    ++the repository once after all refs have been updated and after all
    ++accepted ref changes are applied to the repository, but before the
    ++pkt-line encoded status report is sent back to the client.
     +
     +The hook receives the complete pkt-line encoded status report on
    -+standard input. The report begins with an `unpack` line indicating
    -+whether the object transfer succeeded (`unpack ok` or
    -+`unpack <error>`), followed by one `ok <refname>` or
    -+`ng <refname> <reason>` line per ref that was pushed, and is
    -+terminated by a flush packet.
    -+
    -+The hook's standard output entirely replaces the report that is sent
    -+to the client. The hook must write a valid pkt-line encoded report in
    -+the same format it received. The hook's stdout is fully buffered by
    -+`receive-pack` before any data is sent to the client, so the hook's
    -+exit status is known before the client receives anything.
    ++standard input, see linkgit:gitprotocol-pack[5] for details on the
    ++structure. The hook's standard output entirely replaces the report
    ++that is sent to the client. The hook must write a valid pkt-line
    ++encoded report in the same format it received. The hook's stdout is
    ++fully buffered by `receive-pack` before any data is sent to the client,
    ++so the hook's exit status is known before the client receives anything.
     +
     +There are two distinct ways the hook can affect the push outcome:
     +
    @@ Documentation/githooks.adoc: The exit status of the hook is ignored for any stat
     +
     +* To abort the entire push unconditionally, exit with a non-zero
     +  status. In this case the hook's stdout is discarded, `receive-pack`
    -+  calls `die()`, and no report is sent to the client at all. The client
    -+  observes an unexpected sideband disconnect, making the entire push
    -+  appear to have failed. In general, the hook should never exit with a
    -+  non-zero status code and doing so would indicate a bug.
    ++  modifies all references to be rejected with a 'report hook failed'
    ++  error.
     +
     +Any output written to standard error is forwarded to the client over
     +the sideband channel and will appear as `remote:` lines on clients
    @@ builtin/receive-pack.c: static int run_update_hook(struct command *cmd)
      static struct command *find_command_by_refname(struct command *list,
      					       const char *refname)
      {
    +@@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands,
    +  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    +  * For v2 protocol, set `add_reports` to true, which will also add additional
    +  * report per reference update.
    ++ * If `ref_error` is set, then all references will be rejected with the given
    ++ * error message.
    +  */
    + static void generate_response(struct strbuf *buf, struct command *commands,
    +-			      const char *unpack_status, bool add_reports)
    ++			      const char *unpack_status, bool add_reports,
    ++			      const char *ref_error)
    + {
    + 	struct command *cmd;
    + 
    +@@ builtin/receive-pack.c: static void generate_response(struct strbuf *buf, struct command *commands,
    + 		if (cmd->error_string)
    + 			packet_buf_write(buf, "ng %s %s\n",
    + 					 cmd->ref_name, cmd->error_string);
    ++		else if (ref_error)
    ++			packet_buf_write(buf, "ng %s %s\n",
    ++					 cmd->ref_name, ref_error);
    + 		else
    + 			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
    + 
    +-		if (!add_reports || cmd->error_string)
    ++		if (!add_reports || cmd->error_string || ref_error)
    + 			continue;
    + 
    + 		for (report = cmd->report; report; report = report->next) {
     @@ builtin/receive-pack.c: static void report(struct command *commands, const char *unpack_status)
    - 	}
    - 	packet_buf_flush(&buf);
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    + 
    +-	generate_response(&buf, commands, unpack_status, false);
    ++	generate_response(&buf, commands, unpack_status, false, NULL);
    ++
    ++	if (run_report_hook(&buf)) {
    ++		strbuf_reset(&buf);
    ++		generate_response(&buf, commands, unpack_status, false,
    ++				  "report hook failed");
    ++	}
      
    -+	if (run_report_hook(&buf))
    -+		die("report hook failed");
    -+
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    - 	else
     @@ builtin/receive-pack.c: static void report_v2(struct command *commands, const char *unpack_status)
    - 	}
    - 	packet_buf_flush(&buf);
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    + 
    +-	generate_response(&buf, commands, unpack_status, true);
    ++	generate_response(&buf, commands, unpack_status, true, NULL);
    ++
    ++	if (run_report_hook(&buf)) {
    ++		strbuf_reset(&buf);
    ++		generate_response(&buf, commands, unpack_status, true,
    ++			  "report hook failed");
    ++	}
      
    -+	if (run_report_hook(&buf))
    -+		die("report hook failed");
    -+
      	if (use_sideband)
      		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
    - 	else
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/t5412-report-hook.sh (new)
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success "non-zero exit causes receive-pack to die" '
    ++test_expect_success "non-zero exit reports as hook failed" '
     +	test_when_finished "rm -rf upstream" &&
     +	test_when_finished "git -C workbench remote remove origin" &&
     +
    @@ t/t5412-report-hook.sh (new)
     +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-\EOF &&
    -+	fatal: report hook failed
    -+	send-pack: unexpected disconnect while reading sideband packet
    -+	fatal: the remote end hung up unexpectedly
    ++	To ../upstream
    ++	 ! [remote rejected] <COMMIT-B> -> main (report hook failed)
     +	EOF
     +	test_cmp expect actual
     +'

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

