Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04743295DBE
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421052; cv=none; b=oiuVpwlaV/CpU2yLVTqV6aTmBTsXcs+yuztpZyZdt6lBs+Q/pCp9yHg9SjwNGkF/JAJGUfMywtf3/2fft0SyOVM1BqI5ehW1UtO4oGxfOh60vKLe2yh+UcpJO3P3PlzAwSUBvnRzoTQ2VnIZr7KavIgKoNxCHhs7UGawJyPWAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421052; c=relaxed/simple;
	bh=xq1kaD5L+/16evrTqLHqrrX2Rj1dzwbFus00CIiuJ1s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Tf8OKLwlyyvXk0o1KSo4BjIJWnEt0CiOhqX9FGagU5ayftE+64HWepDacq27imgA/GmViaoYuhENwFvFbGQxEScG5k/r6agh1C/BBDvyGWprLI539nGMjH3/zoIsPEGsHlKjQz4L2enebg60lX+ePaHuok7jZEyokFqQmzZ3DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi4jMuVw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi4jMuVw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b78a034f17so4153937f8f.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421048; x=1755025848; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl1jQ2qF7i0DRJq6Bm2VSWcxoCJ5+OMOu3NUeBMgWXE=;
        b=bi4jMuVwDI83+7LPo81F9B9IIgzuPlGejOY96v+Zu5D4c07B+i/DrkHt00nWHPpEeZ
         5iWxd9Z5EMI/I8Rnq35mxSJCZnNhBdUBQz4se41oMqyqIbeOU2yuuqepiJiXS8xDCkiW
         WXtW8F/RcIpiNhDeYjo7Z4Pu6zLQVQl05Cuvoey1OjHTdK5hRUKzWioNCaG3OpFgNE+P
         6EuJrNWDmlKcevd9TVGgLZoo1WSZl1lG510cfq+YiY6pyrKKnVSXEEpaJLClsqPM6sc4
         wjw0xOxS96JhPijad33lxBgF4jKQ8PDxcDpOAdZ7k4VzvsSFmXrFkpyMXaYtRd3dji1P
         gj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421048; x=1755025848;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl1jQ2qF7i0DRJq6Bm2VSWcxoCJ5+OMOu3NUeBMgWXE=;
        b=LiTFP6rYojue4PJUqgyHUG8K4EhqyQwHjJoTcYDve5Yz/VF+kxyHmQJeDGp0Y31xdv
         6bzLzFJCP0QhRzGhEPH+UU9mmIXGDwJBt3eAIfUl/A22Yvo+5ATX2oXqzTa3CaC1qvMm
         TTau9JY5IR/Qbj2kx6NbacGOWVtP+pgEbFmkCZholHtr4ce2yEJRFbPhxxZhiYMAcrfA
         V6ios5GKqtX36iA0FzmgTrORyRHhWfGoIxeJZS5mPokiBRpS7C7GeoTguMky65+rfZZS
         CCGf0tEjYo8ZJ0Igapj0gTsRauOGVlCwM79Lg3V5JCk/sugcii4mnxs5n+KoZIqfE50C
         BR7A==
X-Gm-Message-State: AOJu0YydNLJLfwwopJXWTJMPLzpnaXri2dMdLuy3ap5Hj3lW1bh7t7y0
	fnUFdEv88dB1HxyJGWMsEmQcRNZ7L0LOhL1Dq9y7HCT4uCcI+jDMMICqipXIIA==
X-Gm-Gg: ASbGnctGPurHGyXmC313Yunrgu3Mlmj0wHkQnUzFHCvmnuObrLiNYUbfhH3f5G8u3Di
	jOuBlWqjDiIuf+amn+si+DGtFwCuFRaC1IxNg85Uc3HpJOWL1RUg+W0TUOhgnYLHD5oS2loKfe9
	zWq8kM7DWxEbpHROa349/SOqMrsawuWGRqPXjvUmgTOArMMesziVBJMfS8M2WbCw3m5Wsaj1Pgi
	Gx3TMOGQu3XWyDIYSB7GfGnpLlzxMdIQIHDLY2QHvwZdvLQOhztEaleEBhR03offFnV2hU5fo5M
	lS9gaoRTfzFFOiTMUXft5SmNUFnga3i3VwNvyf5stjKF0Z/JityVk3ss7KOAySPloZrAwc7uKkS
	l/8Q54UBgk8kfrt0wm1SEo5/S1RZriCyd/A==
X-Google-Smtp-Source: AGHT+IF/rr5lgtcslDvf+orbzzvxyz8NJfWCUkphASCz04Kz+0FKQ4nNLp/xAW8ppzp4fy/TrtczTg==
X-Received: by 2002:a05:6000:2003:b0:3b7:9dc1:74a9 with SMTP id ffacd0b85a97d-3b8f418ee53mr142247f8f.42.1754421047674;
        Tue, 05 Aug 2025 12:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm5999175f8f.19.2025.08.05.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:10:47 -0700 (PDT)
Message-Id: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:10:39 +0000
Subject: [PATCH v2 0/6] Introduce more doc linting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Reviewing the documentation part of the last patches, it turns out that the
majority of my comments are related to the latest documentation guidelines
which are both easy to forget and almost trivial to automatically check.

This series implements the automatic tests for basic doc rules. At the
moment it conflicts with "[GSoC][PATCH v6 0/6] Add refs list subcommand" and
possibly with "[PATCH v4 0/9] refs: fix migration of reflog entries"

Jean-Noël Avila (6):
  doc: test linkgit macros for well-formedness
  doc: check well-formedness of delimited sections
  doc: check for absence of multiple terms in each entry of desc list
  doc: check for absence of the form --[no-]parameter
  doc:git-for-each-ref: fix styling and typos
  doc lint: check that synopsis manpages have synopsis inlines

 Documentation/Makefile                        |  21 +-
 Documentation/RelNotes/1.6.2.4.adoc           |   1 +
 Documentation/blame-options.adoc              |   3 +-
 Documentation/diff-format.adoc                |   1 +
 Documentation/diff-options.adoc               |   3 +-
 Documentation/fetch-options.adoc              |  15 +-
 Documentation/git-am.adoc                     |   3 +-
 Documentation/git-backfill.adoc               |   3 +-
 Documentation/git-cat-file.adoc               |   6 +-
 Documentation/git-check-attr.adoc             |   3 +-
 Documentation/git-check-ignore.adoc           |   9 +-
 Documentation/git-check-ref-format.adoc       |   3 +-
 Documentation/git-checkout.adoc               |   2 +-
 Documentation/git-clone.adoc                  |  12 +-
 Documentation/git-commit-graph.adoc           |   3 +-
 Documentation/git-commit.adoc                 |   4 +-
 Documentation/git-config.adoc                 |   3 +-
 Documentation/git-difftool.adoc               |   9 +-
 Documentation/git-fast-import.adoc            |   5 +-
 Documentation/git-fmt-merge-msg.adoc          |   3 +-
 Documentation/git-for-each-ref.adoc           | 264 +++++++++---------
 Documentation/git-format-patch.adoc           |  12 +-
 Documentation/git-fsck.adoc                   |   9 +-
 Documentation/git-gc.adoc                     |   6 +-
 Documentation/git-http-fetch.adoc             |   4 +-
 Documentation/git-index-pack.adoc             |   3 +-
 Documentation/git-log.adoc                    |   6 +-
 Documentation/git-merge-tree.adoc             |   3 +-
 Documentation/git-multi-pack-index.adoc       |   3 +-
 Documentation/git-p4.adoc                     |   1 +
 Documentation/git-pack-objects.adoc           |   3 +-
 Documentation/git-pull.adoc                   |   3 +-
 Documentation/git-push.adoc                   |  18 +-
 Documentation/git-range-diff.adoc             |   3 +-
 Documentation/git-read-tree.adoc              |   3 +-
 Documentation/git-rebase.adoc                 |   2 +-
 Documentation/git-refs.adoc                   |  20 +-
 Documentation/git-reset.adoc                  |   3 +-
 Documentation/git-send-email.adoc             |  30 +-
 Documentation/git-send-pack.adoc              |   3 +-
 Documentation/git-submodule.adoc              |   6 +-
 Documentation/git-svn.adoc                    |   2 +
 Documentation/git-update-index.adoc           |  12 +-
 Documentation/git-upload-pack.adoc            |   3 +-
 Documentation/git-worktree.adoc               |  12 +-
 Documentation/gitprotocol-http.adoc           |   2 +-
 Documentation/gitsubmodules.adoc              |   3 +-
 Documentation/gitweb.conf.adoc                |   2 +-
 Documentation/lint-delimited-sections.perl    |  48 ++++
 Documentation/lint-documentation-style.perl   |  33 +++
 Documentation/lint-gitlink.perl               |   7 +
 Documentation/merge-options.adoc              |   3 +-
 Documentation/mergetools/vimdiff.adoc         |   8 +
 Documentation/scalar.adoc                     |  18 +-
 Documentation/technical/api-path-walk.adoc    |   5 +-
 .../long-running-process-protocol.adoc        |   1 +
 shared.mak                                    |   2 +
 57 files changed, 446 insertions(+), 232 deletions(-)
 create mode 100755 Documentation/lint-delimited-sections.perl
 create mode 100755 Documentation/lint-documentation-style.perl


base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1945%2Fjnavila%2Fdoc_linting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1945/jnavila/doc_linting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1945

Range-diff vs v1:

 1:  e79bd6a67ef = 1:  e79bd6a67ef doc: test linkgit macros for well-formedness
 2:  322df2d8dde = 2:  322df2d8dde doc: check well-formedness of delimited sections
 3:  5806390052b = 3:  5806390052b doc: check for absence of multiple terms in each entry of desc list
 4:  03a8428849f = 4:  03a8428849f doc: check for absence of the form --[no-]parameter
 5:  713c86dae92 = 5:  713c86dae92 doc:git-for-each-ref: fix styling and typos
 6:  e03f3f5c55a ! 6:  d57478ea5cd doc lint: check that synopsis manpages have synopsis inlines
     @@ Commit message
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     + ## Documentation/git-checkout.adoc ##
     +@@ Documentation/git-checkout.adoc: include::diff-context-options.adoc[]
     + 	separated with _NUL_ character and all other characters are taken
     + 	literally (including newlines and quotes).
     + 
     +-<branch>::
     ++`<branch>`::
     + 	Branch to checkout; if it refers to a branch (i.e., a name that,
     + 	when prepended with "refs/heads/", is a valid ref), then that
     + 	branch is checked out. Otherwise, if it refers to a valid
     +
       ## Documentation/git-refs.adoc ##
      @@ Documentation/git-refs.adoc: This command provides low-level access to refs.
       COMMANDS
     @@ Documentation/lint-documentation-style.perl: while (my $line = <>) {
      +	if ($line =~ /^\[synopsis\]$/) {
      +		$synopsis_style = 1;
      +	}
     -+	if (($line =~ /^-[-a-z].*(::|;;)$/) && ($synopsis_style)) {
     ++	if (($line =~ /^(-[-a-z].*|<[-a-z0-9]+>(\.{3})?)(::|;;)$/) && ($synopsis_style)) {
      +			report($line, "synopsis style and definition list item not backquoted");
      +	}
       }

-- 
gitgitgadget
