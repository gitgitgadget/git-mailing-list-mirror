Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297D4A4F0C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161690; cv=none; b=jVNRP+/Ygoz9VzVOXYwRKNjzpcaOqBY+jWwtGWnbsO3eKM/LZ3Kexkcn90Kve+X6pXOdNkcwDQSlCksG81Ibrmsd4ZkWJ0oKvj0v2yVp64lQUYv9fwPvOd/7JQZBCU2WcZkxapVfpqx1ajHUpGnnlQcDII+fQSErGARlWGPDXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161690; c=relaxed/simple;
	bh=aQwXa7V2A68eSLP2zX67SwDN7mnr9hEZBZwIKg27VlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cX+BZU1BtNE8SUWm+HwvEE28vBW2E9lIBS5WuD5XsyD3FO4pS3GLSUPFbmAKLEwKJXkCFu2WWV3QagzZDMYKA37nEI+Oe8EkbjIbp8IevL92QC+1aaIU4pwUPo5RbgmbSqXz9JV84Mqyh0wKRJN3JT6lHIID5B80XIfUN2oEugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLgoCwB1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLgoCwB1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49e63568bfbso10080275e9.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161686; x=1789766486; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8a419bpiDpj+Qt9pkvjLEV+NKadAQPyoOYBMGZrgx8=;
        b=eLgoCwB1M4kHoDGJZCBUI4yS5mJeds0DYDk0G34SBgNGLrJkm8V0UhKW45KTeREOni
         B+uQ4oI9J9gSjqDRs+oNj9RBhkegwWZiB/fR6V7E0wSV1rnYfhv9kUd3jbWAgzrN10BN
         qYoSm1kl9ATTGNwS+nU13I3PoJjD0IkEmVh46bGT0NT10vmHbonXoVI4rxWN6waO38rm
         RRKlteQoZ2ymTqeqsHW7u2mW8d49nz4Vchsoo0Op8RhZ2itNS1BfECEAQ48nsRp0HY0s
         V+hNsx3tqyYpGu+LucNa64OzAS5KJ1F+5lPVwl1BXPfgvoABFy2JOzBU1Uz5nmdZl0sO
         wr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161686; x=1789766486;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8a419bpiDpj+Qt9pkvjLEV+NKadAQPyoOYBMGZrgx8=;
        b=BKJYIkBC41J3olNLkeK7tVc3zpUkZkml8KbTargCGgrG+/SyerUnPhf4UA7CVMecyE
         K909r7qY5fmRTv+Wa+OPByoKnASucHHcffzVW24X0NZnBku5Jht2EkNw1lS606r8seC3
         aT3uU7S1dSuNIr5EarzCcEEmJ1QjkUJEy0pusmApuuDKgVgKrRugCbXAeDrBGCED5J5V
         MO57o3qDS7x/LhMOQF5DP2h3Ns+jKjGy7hkQ+twOwTinsMjQ4ITLkVyOlcVZPS2uesj8
         gq1dwgafTEqpUMyeYkCzb9POkpSK6uXEQy2riyJKwKgHHj1z2nZbIo8GbnhoD5FBFhho
         zzlA==
X-Gm-Message-State: AFuF++n+4IrVIW3RQ+gRBcBJ3ViqNZG2tfkDvOYOIq4KDGj2KQqE0TUp
	teQGj325xgtNxOcVzvghamd7PmRvlfXv0UrB3i6sM0j+tjWSpVrN5ZKt
X-Gm-Gg: AYBFou0n4aVXDEskSlzsj1+wRfX/q79RZkZBZEdnOutssyK34+Fs9gnQqU5ccZDzgi0
	dM2Goxtvhk3dw++Z1KGffCpX63/i+3l/A1ahDunY6akIaM1fT7peN505isJH8pfFXJBZW8di9JJ
	7XutVnESAWHWKXSooeSS+bq9Ufe6h9FWevnK2Do7nPddsFz9m8Uc2u7akEjKLmCJrYo4M1kyn+9
	QSTP34iWNXP1K/2+WAxJOWSj0ydR3Ofa7YLv/oRbzuJjjRIXrD4aV/Ip1bn2gwq2wVb9QpOWJpT
	sjIJlkXosFqUkTBvt4mZf0+dSVteY4ngjDWM7N+f2fKWHrlwZUevRrpKtA9op8g4EFqLz1/JHx8
	M3lEWcImvEFWNEW/CxiWr0b8kBVlEUhIrqUN/TxCuN9K3aTTmid2nUojtmNfIUa7Z151M4eZnvJ
	4Sqj1ekT9uVn8qGEYU806e/oVCdli+FSIRQUs4otzn+k0n7Xr7kolJHCBvTHLnXprGJkh809rFh
	lWfaf3350IY9ZEX/f+GAP+c7ljTh7R46VEQFT4z4wSbG8p5
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49e619805f1mr70137535e9.4.1789161686204;
        Fri, 11 Sep 2026 14:21:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:3cb1:ed0d:e325:5fc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm9435939f8f.2.2026.09.11.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 0/4] hook: introduce the receive-report hook
Date: Thu, 10 Sep 2026 23:54:05 +0200
Message-Id: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23RzU4DIRAH8FdpOIth+MaT72E8ADu0qN01u+1G0
 /TdhRoj2XIcMvwG/nMhC84ZF/K0u5AZ17zkaSwFsIcdiQc/7pHmoRwQzrhmFjg1ytI8nuZpOEe
 kh2l6pyoIn1wCb9CScvFzxpS/burL62+9nMMbxlOVaschL6dp/r6NXaH2/Q2wvQErUKDW28E61
 MoK+7w/+vzxGKcjqQNW3hAcugQvBDqGPBkfeUxbQrSE7BKCMiqdU1wn5pnmW0K2hO4SshA6gHR
 G+cEpsyXUP+FY/yOqEELFIeqAIkbYErolRJfQ9RXcigApuABxS5iW6GdhKhF1TUJ4Ze6ysC3RX
 6otREBrvTbgEe424lrCdQlXs2BSDBIMMsSWuF6vPwsId83fAgAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7311; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aQwXa7V2A68eSLP2zX67SwDN7mnr9hEZBZwIKg27VlM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqkcMqd5xZsMhARCk8FqqhNc4vsWS713KFvy
 3SrI489Sj2hQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqpHDKAAoJED7VnySO
 Rox/yBYMAJ5aIOkWUek9tTfUdlWqvOy5XMisRJHh+G7kbrhO/1d2qkUHKCTmFTRYY7GNyiH/KI4
 60kooufqG65S6OmGuiGRyIv/OKo96R6B91rj1WIE7sf8Qksuq0M5Mg2R4RCnHO8OKcb1tvP24Wp
 HoKN8QfLHzhV4seGMlGmK/AcM5mTT/e1h73U/x7FjWhw3YCEx0gyFXbm7sF0H0qaa4Ap1bj6DvV
 5w20rFJcfJ2f4ip0RSPx4Yxk4GPOmXkbqxkT5l515tgTz9ROiclCgug1Zvih4q12OVkqCA1zNj7
 VtEVCFJvzuElkx/jf+97j1JGgWRNlni+mS0DaVhcveGuKamCI8EaMUNEH/0Qwh4WrOZBm9qH71W
 qnC8PMEsv8W3PqonvLCH7N6UgKt++IT2q3x1lmjzehplBe/ETHQ+Ux29U86OLe3483dkskPXcu5
 sYo9GW8fo3h01rQIx5o5owYNRK8k+QWG3b4+JtsPugm2CF3/xUSW2kVaOQY37CEfRk70eG+wKo7
 Tc=
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
Changes in v10:
- Fix a leak when reassigning the command strings.
- Link to v9: https://patch.msgid.link/20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com

Changes in v9:
- Fix a bug where we were causing a BUG() when no report was requested.
  It is perfectly valid for clients to skip the report and we shouldn't
  fail when they do so. Thanks Junio!
- Link to v8: https://patch.msgid.link/20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com

Changes in v8:
- Fix spelling mistake s/UNKOWN/UNKNOWN
- Remove a stale comment from previous version.
- Fix an argument which wasn't changed with the previous version's
  changes.
- Link to v7: https://patch.msgid.link/20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com

Changes in v7:
- Removed report_v2() since it is the same as report() with the new
  changes.
- Used a switch statement instead of an if/else for the enum.
- Removed an unnecessary curly brace.
- Also rebased on top of latest master (3cb9185f65 (The 22nd batch,
  2026-09-02) as there were conflicts.
- Link to v6: https://patch.msgid.link/20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com

Changes in v6:
- Introduce a new commit which introduces `enum report_status_version`,
  use that and drop static variables in the codebase.
- Reword the commit message and documentation to:
  - State further why reference-transaction cannot be used.
  - State the responsibility of the hook owner to undo and reference
    changes if needed.
- Link to v5: https://patch.msgid.link/20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com

Changes in v5:
- Rewrote some of the commit messages and documentation.
- Renamed the function `generate_response` to `generate_report` to avoid
  ambiguity.
- We now override the cmd's error_strings, this avoids the whole
  precedence issue with the earlier series.
- Also add information about how we can override the unpack status to
  fail the push and add a corresponding test.
- Thanks to Patrick for the review!
- Junio: This causes conflict with next ('jt/receive-pack-pluggable-writes')
  similar to before, please let me know if its better for me to add that
  dependency.
- Link to v4: https://patch.msgid.link/20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com

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
Karthik Nayak (4):
      doc: add proc-receive hook info in 'git-receive-pack.adoc'
      receive-pack: drop static variables to track report status version
      receive-pack: move message generation to separate function
      hook: introduce the receive-report hook

 Documentation/git-receive-pack.adoc |  17 +++
 Documentation/githooks.adoc         |  61 +++++++++
 builtin/receive-pack.c              | 147 ++++++++++++++-------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 257 ++++++++++++++++++++++++++++++++++++
 5 files changed, 436 insertions(+), 47 deletions(-)

Range-diff versus v9:

1:  711a817307 = 1:  c1e4b04739 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  9e2df905d2 = 2:  a722caf2ab receive-pack: drop static variables to track report status version
3:  b871b95544 = 3:  beff68683c receive-pack: move message generation to separate function
4:  3d4e967fa5 ! 4:  8819db1ae1 hook: introduce the receive-report hook
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
      
     +static void override_cmds_error(struct command *commands, const char *err)
     +{
    -+	for (struct command *cmd = commands; cmd; cmd = cmd->next)
    ++	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
    ++		if (cmd->error_string_owned)
    ++			FREE_AND_NULL(cmd->error_string_owned);
     +		cmd->error_string = err;
    ++	}
     +}
     +
      /*
    @@ t/t5412-receive-report-hook.sh (new)
     +	test_cmp expect-report actual-report
     +'
     +
    ++test_expect_success "non-zero exit with pre-existing ng from proc-receive" '
    ++	test_when_finished "rm -rf upstream" &&
    ++	test_when_finished "git -C workbench remote remove origin" &&
    ++
    ++	git init --bare upstream &&
    ++	git -C upstream config receive.procReceiveRefs refs/for &&
    ++	git -C workbench remote add origin ../upstream &&
    ++	git -C workbench push origin $A:refs/heads/main &&
    ++
    ++	# Use a proc-receive hook to generate a dynamic error string.
    ++	# This is used to capture any leaks stemming from overriding the
    ++	# error message via the receive-report.
    ++	test_hook -C upstream --setup proc-receive <<-\EOF &&
    ++	test-tool proc-receive -r "ng refs/for/main/topic push-rejected-by-service-x"
    ++	EOF
    ++
    ++	test_hook -C upstream --setup receive-report <<-\EOF &&
    ++	tee raw
    ++	exit 1
    ++	EOF
    ++
    ++	test_must_fail git -C workbench push origin HEAD:refs/for/main/topic >out 2>&1 &&
    ++	test_grep "receive-report hook failed" out &&
    ++
    ++	test-tool pkt-line unpack <upstream/raw >actual-report &&
    ++	cat >expect-report <<-\EOF &&
    ++	unpack ok
    ++	ng refs/for/main/topic push-rejected-by-service-x
    ++	0000
    ++	EOF
    ++	test_cmp expect-report actual-report
    ++'
    ++
     +test_expect_success "hook stderr is relayed to client via sideband" '
     +	test_when_finished "rm -rf upstream" &&
     +	test_when_finished "git -C workbench remote remove origin" &&

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

