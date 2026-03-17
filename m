Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30F1D9A54
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714100; cv=none; b=SmYhAS3w3+5iWByNbaUCYenAIit/SLNPoxEb4KCvGdN6gbm+6S47TxZC5eCGh1gYKniVBVzDfwP3Tj00qXot7VrIpe6npZutcUkOUjlNZpjUDTOnMuZ4m9FwrFKdDrYzuNfOie/o0tH/TnbJPy8z8orRxJk02oKt2qDcfoNkwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714100; c=relaxed/simple;
	bh=H71D/1IGD4J6BEck8/CiqLBAKC2J4Qzyaz34ttYMjjk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OWv7tXHfL2G0kc8uY5sSGH/XDK3uI6f64RIPZFqXuV0BQEkFJwGkHEviKwBSkZ9d5cZfYUlTP5rnMW8cU+LK2dxcDnLvp5b+T9nkGvc+b2i4jg2gUVWW6byWnlRqvE8buI93f4+boWU2BxXwVHchSapjxNcRkz+35SY9WvmrXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlgWPB9S; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlgWPB9S"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4e9694so1736390c88.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773714097; x=1774318897; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBkxHBl8ILEenfLhcsdND0Hy3nkKWhPkZ7d+LPgllUM=;
        b=AlgWPB9Su5KpJ0aP0pcHqoRWL8KTZDXpgChhdDF4hvN/UFfzQhDBFJwCyE21D+zFDp
         DXQ9yKu08fjEfr82TapXv1XNsPoMXoKZHcnRga7BqTsOg70F5NA7wo1+Ls+Sug7cqiyL
         ZrhJtBLdbKQdC3VhyqnM4CcAQfY/0HtYQonaOt3dgvEEJPpanh0PTgCcOG+fvAun4U/M
         c0ehLIjTxbR5ciR2Op5VcxuN7KmIfpzCP9nybk2NjnC6lvTYt90XqwbFKYLXCeaWndae
         wUCiV0oY0BS0ZIht1e2pdW1jyB4TCw3PnJ+OKNFDqWht29Lmmx9bWXGZkJ5hPiwS2nKh
         50vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773714097; x=1774318897;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBkxHBl8ILEenfLhcsdND0Hy3nkKWhPkZ7d+LPgllUM=;
        b=NbS3fPjJrV8XErTujwgfNhGBHQg2M0zcmUsUolpD1glAVp8MDxDsfcZJ55FD7G6bYh
         T2WA+aL1R9Z4BK6CLDcFfcOxn7OJ7X63g+7rYzhBC9qwx352aiGf0pEfURAXtzwkeBnO
         V7CoSSv5Tthn78GXaucmHe0NE1wzqvSl0iswsb6Hg4UhBVPnBZKw4Pm4pxBiBFUO32//
         FD5xaxAjfzQYhnaxmIITIVKw0zziBoFFCuRbmwVn9Qjom6IFRFlrvkeZSYU2jp7WnPED
         w8r0FkuPJBgjsDdVFue1+qznaRiL+jHF6K+lgMtdH7+wweFXt5iRAG7WhdCXcRRH/xJK
         1CWA==
X-Gm-Message-State: AOJu0YwvaxDxF8mWw7zYSKxRemoJIJvE/iAmgSFjq1Fh4SLipLVo8zih
	MjEtAlACXPs08hSCWLMvgInlvOunHY6Ve44HFO/AN4zvx6gYDuacvuHM+Vqxo1L6
X-Gm-Gg: ATEYQzwYcDKnfk1xvO30/Yzj2XUrjOvBMkE+cSh6iGeobEG/+dvmFRnH4cxNPf2swQ7
	OUJYU2cOyl4KFCtmXJkXt5pYKP0VKGBtBfS8tC4rnohL3FOjHAumvViMGOlO2K1RY5HBHEJSjks
	wGgj6HXSHyS1ElI4Uw69H1wBFsPZaRd2z//R5QUTwtdqfC4//FEQ+0keiGgBrEFs6tAg2AOIBzo
	Hmqliw2lMzX/02+Z0mkiYyXmmLyaCYCUzdGH5Ds1qSmuz3X80ziW+JfKiQSQODii8Qje5wr1hXG
	YTAIgXlgW7G9we3m5Ncz9lCJq5pkzdTwS2f1e2y3tfMr1T8RGVpCzt+6lSJmGo+K3Vtq/rQKuQR
	DqZP5gROOQFEjSczvyHZfurxkloXH9RnZW7TfDDHcbnRc89t4M7BPViDmzfV5qQ1ZkimMs3sMUv
	Ei/KvtpQRQDowjiRqUpxbWO3pfUOV2JsLb/w==
X-Received: by 2002:a05:7022:684:b0:11a:3734:3db3 with SMTP id a92af1059eb24-128f3e1d21cmr6948437c88.32.1773714097079;
        Mon, 16 Mar 2026 19:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.50.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63b6a34sm17449789c88.14.2026.03.16.19.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 19:21:36 -0700 (PDT)
Message-Id: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 02:21:31 +0000
Subject: [PATCH v2 0/4] line-log: route -L output through the standard diff pipeline
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

git log -L has bypassed the standard diff pipeline since its introduction,
using dump_diff_hacky() to hand-roll diff output. A NEEDSWORK comment has
acknowledged this from the start. This series removes dump_diff_hacky() and
routes -L output through builtin_diff() / fn_out_consume(), so that diff
formatting options like --word-diff, --color-moved, -w, and pickaxe options
(-S, -G) work with -L.

This replaces my earlier series "line-log: fix -L with pickaxe options" [1].
Patch 1 is the crash fix from that series (unchanged). Patch 2/2 from that
series (rejecting -S/-G) is dropped because this series makes those options
work instead of rejecting them.

[1]
https://lore.kernel.org/git/pull.2061.git.1772651484.gitgitgadget@gmail.com/

Patch 1 fixes a crash when combining -L with pickaxe options and a rename.

Patch 2 is the core change: callback wrappers filter xdiff's output to
tracked line ranges, and line ranges are carried on diff_filepair so each
file's ranges travel with its filepair through the pipeline. diffcore_std()
runs at output time, so pickaxe, --orderfile, and --diff-filter also work.

Patch 3 adds tests covering the newly-working options.

Patch 4 updates documentation.

User-visible output change: -L output now includes index lines, new file
mode headers, and funcname context in @@ headers that were previously
missing. Tools parsing -L output may need to handle these additional lines.

Known limitations not addressed in this series:

 * line_log_print() still calls show_log() and diff_flush() directly,
   bypassing log_tree_diff_flush(). The early return in log_tree_commit()
   (and its associated NEEDSWORK about no_free not being restored) is
   pre-existing. Restructuring -L to flow through log_tree_diff_flush() is a
   larger change that would affect separator and header logic; it is left
   for a follow-up.

 * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
   unimplemented for -L.

cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com

Changes since v1:

 * Patch 4/4: fix documentation formatting: use line continuation
   instead of indentation (Kristoffer Haugsbakk)

Michael Montalbo (4):
  line-log: fix crash when combined with pickaxe options
  line-log: route -L output through the standard diff pipeline
  t4211: add tests for -L with standard diff options
  doc: note that -L supports patch formatting and pickaxe options

 Documentation/line-range-options.adoc         |   4 +
 diff.c                                        | 279 +++++++++++++-
 diffcore.h                                    |  16 +
 line-log.c                                    | 196 ++--------
 line-log.h                                    |  14 +-
 revision.c                                    |   2 +
 t/t4211-line-log.sh                           | 348 +++++++++++++++++-
 t/t4211/sha1/expect.beginning-of-file         |   4 +
 t/t4211/sha1/expect.end-of-file               |  11 +-
 t/t4211/sha1/expect.move-support-f            |   5 +
 t/t4211/sha1/expect.multiple                  |  10 +-
 t/t4211/sha1/expect.multiple-overlapping      |   7 +
 t/t4211/sha1/expect.multiple-superset         |   7 +
 t/t4211/sha1/expect.no-assertion-error        |  12 +-
 t/t4211/sha1/expect.parallel-change-f-to-main |   7 +
 t/t4211/sha1/expect.simple-f                  |   4 +
 t/t4211/sha1/expect.simple-f-to-main          |   5 +
 t/t4211/sha1/expect.simple-main               |  11 +-
 t/t4211/sha1/expect.simple-main-to-end        |  11 +-
 t/t4211/sha1/expect.two-ranges                |  10 +-
 t/t4211/sha1/expect.vanishes-early            |  10 +-
 t/t4211/sha256/expect.beginning-of-file       |   4 +
 t/t4211/sha256/expect.end-of-file             |  11 +-
 t/t4211/sha256/expect.move-support-f          |   5 +
 t/t4211/sha256/expect.multiple                |  10 +-
 t/t4211/sha256/expect.multiple-overlapping    |   7 +
 t/t4211/sha256/expect.multiple-superset       |   7 +
 t/t4211/sha256/expect.no-assertion-error      |  12 +-
 .../sha256/expect.parallel-change-f-to-main   |   7 +
 t/t4211/sha256/expect.simple-f                |   4 +
 t/t4211/sha256/expect.simple-f-to-main        |   5 +
 t/t4211/sha256/expect.simple-main             |  11 +-
 t/t4211/sha256/expect.simple-main-to-end      |  11 +-
 t/t4211/sha256/expect.two-ranges              |  10 +-
 t/t4211/sha256/expect.vanishes-early          |  10 +-
 35 files changed, 870 insertions(+), 217 deletions(-)


base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2065%2Fmmontalbo%2Fspike-xdiff-line-range-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2065/mmontalbo/spike-xdiff-line-range-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2065

Range-diff vs v1:

 1:  e7b8cc2c78 ! 1:  ccfc1b03ff line-log: fix crash when combined with pickaxe options
     @@ t/t4211-line-log.sh: test_expect_success 'show line-log with graph' '
      +		--find-object=$(git rev-parse HEAD:file) >actual
      +'
      +
     ++# Commit-level filtering with pickaxe does not yet work for -L.
     ++# show_log() prints the commit header before diffcore_std() runs
     ++# pickaxe, so commits cannot be suppressed even when no diff pairs
     ++# survive filtering.  Fixing this would require deferring show_log()
     ++# until after diffcore_std(), which is a larger restructuring of the
     ++# log-tree output pipeline.
      +test_expect_failure '-L -G should filter commits by pattern' '
      +	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
      +	test_must_be_empty actual
 2:  6921b07a0f = 2:  4e2bc55082 line-log: route -L output through the standard diff pipeline
 3:  09e00d3f82 = 3:  cf7720ae98 t4211: add tests for -L with standard diff options
 4:  0d3e84a088 ! 4:  93e771b7cd doc: note that -L supports patch formatting and pickaxe options
     @@ Commit message
      
       ## Documentation/line-range-options.adoc ##
      @@
     - 	Patch output can be suppressed using `--no-patch`, but other diff formats
       	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
       	`--name-only`, `--name-status`, `--check`) are not currently implemented.
     -++
     -+	Patch formatting options such as `--word-diff`, `--color-moved`,
     -+	`--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
     -+	as are pickaxe options (`-S`, `-G`).
       +
     ++Patch formatting options such as `--word-diff`, `--color-moved`,
     ++`--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
     ++as are pickaxe options (`-S`, `-G`).
     +++
       include::line-range-format.adoc[]

-- 
gitgitgadget
