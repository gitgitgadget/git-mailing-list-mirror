Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E688384CF5
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528503; cv=none; b=KiVOMWIdre1bmYSHoPsZf87SbMRAMlLM+2WGkapptEPnKP6wjxXq+26l0MeFc2oITere98JnAl20wD/BpWBVV2i4eBtj5f0QPv5mjBWpqt1S88QFWdCx8kIs4uXDYKL99KP6J66WDzrT6o3F7eWC9Vdw5ACAPD3k7UJfVp1WVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528503; c=relaxed/simple;
	bh=TZpPlgqYqyY7uSwvHcxdZnh4NP12weq46KUc2hRnYz4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gWqdFk0HgZWG1mb528rzawO8Hg8avvyHakg+GW12J9E/9BQXOGFeyS4pI8e06RBomt6h0+WrZMJRqF9vBYN+HLywIKzAT9ysSc9iCo7mhBO7kDigv1FEq2WJ7fStzb3yx5OzhdyiAjaiDJ1GnuC1aDxBGuVXaBRufa2xHjPsawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxLLc30A; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxLLc30A"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6aae90e595fso306253eaf.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786528501; x=1787133301; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EwX/i7prZ76896VSKk6VK6yVKok97pZX2ib0SL9YLzU=;
        b=PxLLc30A1rnzdq1NysKbEAQOChWwUP+KcSZ9rW3Pi3APM6bxuaHrVHt7o6ZFVo+Lp9
         6ysIkOUbOORQMvmIAw4BjzbcFgPT4vbugXkk7rb8+oH0Tp0b5EE7ZMNJuY2UPoLav/rD
         HwKyLF/FdjQ+1pDny1sjR9yidAOHym3AIeUZS5sg7QfwMNl9/txx8qv6dEYp9FoUIthL
         TcRkxcfDqPYEblYnW4fUIwVXihq6nJLQ0vf5II+5Ojw2O1gNFhSdVq5cmeEN65RwpbqG
         fuQsh/ExyMmOvF+6vSOuCGm94dxz4jInBVhGh/byD3IEHg8TtfETtNjjIKpcTO8OzNM9
         zaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528501; x=1787133301;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwX/i7prZ76896VSKk6VK6yVKok97pZX2ib0SL9YLzU=;
        b=AZYgfqnusbcTEGG51Hptbj+fr+ydE5xkKgMlsKKIA/9frv+Ad6M5Vdk0Aspz8XLzMz
         YkJ5LUMW+46yZbkVZDytAE5pCQOPC2T9YdZHbCUN5sGTY+my7/sG23RxIye///8+HBz9
         PgCeyra8YsBmtekYXvILsYg8Q/qIBRoku72mMdkmIM6cWNAMA+t6QJLXLY/IDnaPMJN5
         qwKK1KI8ZMn4jnBxymWnOEkLY0v5E1R/3feAbzFGskxjUCP6eyPLYo3X7Qz9hHfCLpdN
         oR5rOY/nFTBoDOLWNpeNFHWJKx9a8YWzVVQtnRFDFMUB9ujmYAg4keBv/tKzrQIDwXYi
         hC8A==
X-Gm-Message-State: AOJu0YxgVBhOmOvO5iVylVC4GKLeqbXFDTAPpNP+Uh0RarnRXfzpelM4
	xKcwj8845hRacT4vasIpRmeQc7wGL44MKfgBM+gv7Al3jgZCzYlpafI+bxkXtA==
X-Gm-Gg: AR+sD10BgHtOCBHocQ2SodSmgt1rCGE8DKSBWVZaZmBiCFuDOT90ipJGSF3YrrOxtbO
	YX/TJxhSYMSgh/0Y6mLJZNjQdS6S13YLF/jQ97mqo9bUnFEEsAWdMIvh05YjTz3flH2kDtwOlgi
	f8v3K1VZ2fpTmv7yFx0wGuE4V27H/U2IpHibHqbpwG+HbuaFHnv3tKSkbhsQZ3zf5UC0XdLgBDB
	vlBKPQldo986jdMAEK1qLnoX/gOXKqLj5OfOfA1T6rydp3BHACp/IQujgscbgHA74SSXdx6nOYw
	8vhkXp/rd0fZH2Qg1P4a8DhKAFj77ZS4s4RbMy/2mIN44GUzd/i0PjEuobQzPQ34zFKx8e/Oci6
	YKG2ytbOC2nyrxPgqqDu2xn6a4l4X+ncfH9SKI9jD+DFfLOHQZV/e8GzMaF7fTNCfJfAnxkFXWH
	ou8YkEDiBje0C2umRznde41ZCc/q9Et1t9vHzLFNsX7a17NwByLb+BhOlvDOAKofI9
X-Received: by 2002:a05:6820:169f:b0:6a1:22cd:8ffd with SMTP id 006d021491bc7-6b0b2861f97mr2817955eaf.34.1786528500845;
        Wed, 12 Aug 2026 02:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.131])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad4c6b04sm2283522eaf.4.2026.08.12.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:54:59 -0700 (PDT)
Message-Id: <pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
In-Reply-To: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 09:54:57 +0000
Subject: [PATCH v2] sequencer: release the ODB before spawning git commit
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of 4557f1add261 (rebase--helper: add a builtin helper for interactive
rebases, 2017-02-09), continuing an interactive rebase uses the builtin
sequencer, which spawns `git commit`.

The child may trigger auto-maintenance, which may need to replace files
for which the sequencer still holds resources. See
https://github.com/git-for-windows/git/issues/6315: on Windows, this
produces unlink retry prompts that cannot succeed while the sequencer
waits for the child.

Resources such as file handles or memory mappings must be released
before spawning a command that may run auto-maintenance, as established
by 28d04e1ec197 (run-command: offer to close the object store before
running, 2021-09-09): release the ODB file handles and memory mappings,
so that auto-gc can repack (potentially deleting existing packfiles in
the process); If the sequencer needs to access the ODB afterwards, it
will gracefully (re-)open the ODB.

Release the sequencer's ODB before spawning `git commit`. The regression
test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
optionally use legacy (non-POSIX) delete semantics, 2026-05-07) to
trigger the failure on modern Windows.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    sequencer: release the ODB before spawning git commit
    
    This fixes https://github.com/git-for-windows/git/issues/6315
    
    Changes since v1:
    
     * Clarify in the commit message what the strategy introduced in
       28d04e1ec197 (run-command: offer to close the object store before
       running, 2021-09-09) is all about.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2198%2Fgit-for-windows%2Frebase-release-odb-before-commit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2198/git-for-windows/rebase-release-odb-before-commit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2198

Range-diff vs v1:

 1:  904d65e8cb ! 1:  039fd29039 sequencer: release the ODB before spawning git commit
     @@ Commit message
          Resources such as file handles or memory mappings must be released
          before spawning a command that may run auto-maintenance, as established
          by 28d04e1ec197 (run-command: offer to close the object store before
     -    running, 2021-09-09).
     +    running, 2021-09-09): release the ODB file handles and memory mappings,
     +    so that auto-gc can repack (potentially deleting existing packfiles in
     +    the process); If the sequencer needs to access the ODB afterwards, it
     +    will gracefully (re-)open the ODB.
      
          Release the sequencer's ODB before spawning `git commit`. The regression
          test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:


 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066..83952d96e3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,6 +1127,7 @@ static int run_git_commit(const char *defmsg,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	cmd.git_cmd = 1;
+	cmd.odb_to_close = the_repository->objects;
 
 	if (is_rebase_i(opts) &&
 	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..8f81c80fd4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -65,6 +65,24 @@ test_expect_success 'setup' '
 	test_commit P fileP
 '
 
+test_expect_success MINGW 'rebase releases object database before committing' '
+	test_when_finished "rm -f .git/hooks/post-commit repacked packs" &&
+	git switch -C repack-rewrite primary &&
+	git repack -ad &&
+	write_script .git/hooks/post-commit <<-\EOF &&
+	git repack -ad &&
+	>repacked
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="reword 1" GIT_TEST_LEGACY_DELETE=1 \
+			git -c core.commitGraph=false rebase -i HEAD^
+	) &&
+	test_path_is_file repacked &&
+	ls .git/objects/pack/*.pack >packs &&
+	test_line_count = 1 packs
+'
+
 # "exec" commands are run with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
 # to create a file. Unsetting SHELL avoids such non-portable behavior

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
