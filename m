Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20184F4735
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863228; cv=none; b=g5PgZn7PiIRsr1sK0G6e6cfZVwWp3pfc1XadVMlo7GmpLlAXM8GqkW/Yr3EUD/NMzrPPkQ0sG67zcJ1SE5Swvg3OcxWNKT3TB1Bbckac3eDF81nvvUcCNBItc1HHI1MzX9cGzAQMinmCImyO28t2qzK2MjSmPM26B/GZ1tjN+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863228; c=relaxed/simple;
	bh=7Rg/T3BClcSWqpgfcM2odzau0j5YEKrv9LI3rekKbu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X8sMlrauiT0drlPYno9dD2oidfQNBoosVCT/sxk6o8ci71g5gxT2BHCVKzt8TGL2EbSWLLfFT/Ma99Zi2kdlDO9DvfoDXKsqXDHjT3E6mPSJebNOkg8V0366myqwY6xXwm8rkqBu9pp79xS+PH0fTK7SAf1fltawHRYix2gT4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r34nGoSt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r34nGoSt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48431648f33so3681603f8f.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863225; x=1789468025; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o+PbNdCqJQUSXHncYI8vOQP7Y8g7RakpciN+G3vWBm0=;
        b=r34nGoStM1pQRm/Dmdx9yNUHevGkqK/MtxVRZv5CVoNokMH1ox/XQw/964AFs736Eq
         5sxbyFUgexK8gXf3Bv9IIUfbXDc/MacC7eblSXG01RG3ZsJgYoCDY2jVKOmwaIVrpKzy
         qnToBDeFFJYE5GGOwVaSqSMDXDMGx+Jf0z4hXB3/oBQ5azHwvay3aDk0/RMYP0PGsSI9
         Z4F9P3P7by0sfrdy4xGAk77dbiBcmBAIH3KMnSSt/zyz0S2DVf7/DvYfDacT/lWgidG8
         q64TZ1EMF6rAvOHRkN3u96OvPevQSJQgPedloBGWzOVtrrjV1d6SELU3SQXKCrZcH1Zm
         uwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863225; x=1789468025;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+PbNdCqJQUSXHncYI8vOQP7Y8g7RakpciN+G3vWBm0=;
        b=EG1ftTAreHbuVMM86yihB8WJ0+iomUE4oOgmfU4fSKaN4bMJk7I1+wefo3aQKfI8ok
         Z4a5DWZtnF0jhsW7Fgv/PzQhOZOVMpEyLLgLE0j++sG9tR2ganKkvOLLgCxRQoTnOf6A
         uIsTTg2ir0WJMKhgC/mxH8GXjEYXEhQwfaaArF8SBeK4ISaliBCxKfDzLkNGh0kFyK6F
         LrS/KlJIas56zsX/jOFjhJzyf+oZeRfVhSuTFT5jgyNcDiYrHAMX+Qo18X3CLNjwh5kg
         L9Xv2GqXIBaAzz9n6mEPCWHmJQgPsKb/k8fO3gjMzekivtu15KOmWpgcJh/mij2qjwlT
         MJpg==
X-Gm-Message-State: AFuF++k4fyAjcrgqaSG2YeAx+CqIqZCva4l5DJQemJWM45i5XXEp4m0X
	ToVPVEiVwFxO14Pb8yKmyouvE+vV4kjrQV1gIilAIgqX0MnCDdW/GQnT
X-Gm-Gg: AYBFou3Mv3IBII3Dsn5d3bOqTTOV+Vy8BHSW0PZzD8YjON05wTNKqYsKhmKTRU4uwzM
	w91HMbRu0mDGwkZYK/p+tmQdwAwxj3FUMBVKvYlv18Qf2d99Op7r1l+pcI+wnezG2BEkF3A5aWn
	deqytIJwB8FjPYwYGYCtYhLNy3UdJlSu5Qq/0ohqO8Laasmi/oOeV0nTxTMAZ2kSRkL3srAYsfA
	0m/Ca3NJGS/Ch2Z7B8XaXaMgJnoT+q3dafXmaUQ3yrCknaIEUDPUemgPmihXy0qVIkFHqMfoAl3
	n9m7IvYIeVJHyqrKWFMcjUlO+2UBuDVvDrmWfcwWo2k25e96mXC0G01mEAc0wjPJMoLpNaCeT00
	D+DraygmTEFT121n78ziEfesubvKmJp1Riu+ixT2K2xiss6a8x895iW7u4p2443fr5tf6IIqw65
	YZHuV6lRM9Q1tCH7bKxWcbyQVuywcj4XkuVW782WMxtHHuw0TX8KpRNgCJHaPaZfgrpkPskh8Ab
	jYb2LjB+A3QU5le9lXZmfavaws=
X-Received: by 2002:a05:600c:1d04:b0:49d:7d4:5f0d with SMTP id 5b1f17b1804b1-49d07d4602bmr184719765e9.16.1788863224682;
        Tue, 08 Sep 2026 03:27:04 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ed36:96cf:ac4a:2747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm34446572f8f.32.2026.09.08.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:27:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/4] hook: introduce the receive-report hook
Date: Tue, 08 Sep 2026 12:27:00 +0200
Message-Id: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Qy07DMBAF0F+pvMbIj/jVFf+BWNiTcWugMUrSC
 FTl37GLECHycqTxueN7IxOOCSdyPNzIiEuaUh7KYB8OBM5+OCFNfZmJYEIzywU1ytI0zGPur4D
 0nPMbVUH66CL3Bi0pDz9GjOnzjj6//MzTNbwizFWqG+c0zXn8uqcuvO79BthWwMIpp9bb3jrUy
 kr7dLr49P4I+UJqwCI2hOBNQhQCHUMRjQcBcU/ILdE1CUkZ7ZxTQkfmmRZ7otsSukl0hdCBd84
 o3ztl9oT6Ixxrf0QVQiroQQeUAHxP6C0hm4SuVwgrA4/BBQ57wmyJdhemEqBrE9Ir86+LdV2/A
 fs4CaBYAgAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6805; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7Rg/T3BClcSWqpgfcM2odzau0j5YEKrv9LI3rekKbu8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqf4vbCHqvUgVEiQ8axcAWQU5yLHBkqwaQQw
 trrw7SQYgDkw4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqn+L2AAoJED7VnySO
 Rox/5MwMAIl8Xej16UH6tNxrVoeQuyTDmRLh3SK6LZCnzS/nWWIvTLAGeS76ZRNR/A4kvnF5q9R
 hj/rgGVssQ6cvNATKw/8H+Hv6PllafVq365TLWo/jCYl50hsvuR0Ae9paNc1o8Ek0lbbVrj0vvF
 Undc6jYEEjtDc3/vw4nUoTvev4fyV5oVdMaRqHn23wwXU8EPG/3W3f5XoK1rtFWG+dIj7L4PUFZ
 fUQ1zSAiBG4tQfujznBWNMwT+U3JeKVZq9aJ4IkEEp1eknIputx9SmCj02jzA2or7rIP6Uvvo0a
 85fudnLI34hg8mw3DW4dDI7zex8w/XqNlzTe7+9qIe6TFrMR8tZLK5Qh+dULBP10QVxuLGYR89L
 +EyAwNSjxXNaInAhyO+Gn6GM982PYvtiWWYkdDC5LSbBPGtJQZWDGKyohzC3Le5deTIdt4OH6fm
 yB/u+PDBWon5SmV8BD4d6BbEHkMt89tk6XkrdE/392S1xvjuj3wk5Ab2bYljqU28+3GzQ/tc9f7
 ec=
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
 Documentation/githooks.adoc         |  61 ++++++++++
 builtin/receive-pack.c              | 146 +++++++++++++++--------
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 401 insertions(+), 48 deletions(-)

Range-diff versus v7:

1:  a80b77f284 = 1:  55f08ef482 doc: add proc-receive hook info in 'git-receive-pack.adoc'
2:  116699bd30 ! 2:  df5840c4fa receive-pack: drop static variables to track report status version
    @@ builtin/receive-pack.c: enum deny_action {
      };
      
     +enum report_status_version {
    -+	REPORT_STATUS_UNKOWN = 0,
    ++	REPORT_STATUS_UNKNOWN = 0,
     +	REPORT_STATUS_V0,
     +	REPORT_STATUS_V2,
     +};
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc,
      	struct shallow_info si;
      	struct packet_reader reader;
      	struct odb_transaction *transaction = NULL;
    -+	enum report_status_version version = REPORT_STATUS_UNKOWN;
    ++	enum report_status_version version = REPORT_STATUS_UNKNOWN;
      
      	struct option options[] = {
      		OPT__QUIET(&quiet, N_("quiet")),
3:  e36b4e7a21 ! 3:  d7c3b7ed55 receive-pack: move message generation to separate function
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     -static void report(struct command *commands, const struct strbuf *unpack_status)
     +/*
     + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    -+ * For v2 protocol, set `detailed_report` to true, which will also add detailed
    -+ * report per reference update.
     + */
     +static void generate_report(struct strbuf *buf, struct command *commands,
     +			    const struct strbuf *unpack_status,
4:  e7c1c0d196 ! 4:  d0e632235a hook: introduce the receive-report hook
    @@ builtin/receive-pack.c: static void update_shallow_info(struct command *commands
     +
      /*
       * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
    -  * For v2 protocol, set `detailed_report` to true, which will also add detailed
    +  */
     @@ builtin/receive-pack.c: static void report(struct command *commands, const struct strbuf *unpack_status,
      
      	generate_report(&buf, commands, unpack_status, version);
    @@ builtin/receive-pack.c: static void report(struct command *commands, const struc
     +	if (run_receive_report_hook(&buf)) {
     +		strbuf_reset(&buf);
     +		override_cmds_error(commands, "receive-report hook failed");
    -+		generate_report(&buf, commands, unpack_status, false);
    ++		generate_report(&buf, commands, unpack_status, version);
     +	}
     +
      	if (use_sideband)

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

