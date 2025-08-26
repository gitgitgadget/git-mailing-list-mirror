Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD062DE709
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233134; cv=none; b=ecNiD0cmDW9SwBPPu27MQgb+9EjzAeTepJgKd2LBxwt1DlZcw+8rc9R88kQlv2yXJ6i182IeME52pW9/ZYkIl5CozL49q2NE0ElO3aJUKMvsi7Q3mY2PUs78ilZaQTjQCVWD2QE6tD+kdfSJeRCmJJQW1K4wjQct2xft5+S43Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233134; c=relaxed/simple;
	bh=nU/PSha5jhJw1h5GOpA1iMqlN2c1+C2Qz1QX1i/FVrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXKvRMtu6SrG8pXmrx+cw9LKNvb5ujgHVOn2acbTjpRzmdeS1GUByEOk6JMiIEfY8PZ15JgJxnfqaS2gJiKPUiTZd1ahxTPtk2vJ+8qMLQ3+sMb1hO5m+KBVNyE1SaFw0rMCn4iXg83+8N4h4vH3kebuYDQC7HbfPNuIvk7Br04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScmcMVaD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScmcMVaD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267872f3so4741471a91.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756233131; x=1756837931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5TtTyyFZB+x0YDP0lJoQv1MaHm3DxgpKDfngkBZofs=;
        b=ScmcMVaDsK9edPEeROtEsaToJpIZtxSMtPLibb47deeAK4xnlE0QWcTCita6jvKBHf
         sF516feyME5iF7SMrUBboErXBvnE6ZuzSIeo8BVTPZK70vkREKTVrrkFB/OvmQQ0hcsq
         ArfKZMocyHgedKfuuD/ug1Xsorjhong7BjEYkxNouodZXVCeXTu32yEStNtxz1oSxeJ9
         q9WpfQwTitS4C650tS33MKkaIRZRMPX+KcmUFyPtHIJIOl/cL2wDSwKBIPPFe+qmIGwQ
         kNZR+ep4izJnbxWpsFTPp5GvqHygX95j/8+iCG36LJMzGIK4XMPMoiCrsVLD/7y6UoqP
         3Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233131; x=1756837931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5TtTyyFZB+x0YDP0lJoQv1MaHm3DxgpKDfngkBZofs=;
        b=NgN6LWrVZo2hXwz3ngfkf51sByw4y3WLtjv4uK6sRg8kXwSVM2/zqbpF5wxnjrqYjr
         3HkUIeCAu9PrBHOTZheWkeWQHHUzNcwJHk826EC7gCknd/wEz97JODRdMK+XLSfUyI4L
         nVgIgVkils7LcExrYkf7J3TuU3Ru4qHLzHuaJZfLWDqwqx3ElxxW5bsM//hbdU0QwX1d
         XQ7adZU8axoGmNAddG6bc4f7icrPTuHZ2LrfFR5cgHmD8c6d+ohEtvfDyajtNolo92eV
         Xpu5UAz1SCP/O2vkMP9+01hfPIDAHu9WQ2hTZufjm/dMpWplpaGVfczlSk4EkWsk9ArV
         RRMQ==
X-Gm-Message-State: AOJu0YykJuusxH2W9eS9RZCWh4UjGzmiDzDMYRA5sCkLlL6K73HHxm9Z
	K8OGJxu9gRYKRXOD3swIYdwwsGF3wq+VDFx6n4gNsCXyAQ9Z1ECn7lCdL2rUYw==
X-Gm-Gg: ASbGncu2UOkzhZSxRVPVvKTWGI+oF3iGt8Y1B9TO0K5z+VEJ/7imLwseJI2uFryJSjc
	qcffeMUtkIe7i1tPsi1EIb/DabIaZShfq20MJU5VnCTRWHlzJfviVKR9dvz5jQLXViY5z95M2W/
	rCRhNeSoWnXDAj0EoGFSsAf+gmpm78wWU63hhbTflE0aLLHZ4yqci/tn4lMt1znVoK2bdRbF6N7
	z4qA4WOSiZVchRMvuD86v4eKaNAc8JfXnlZRbJY/OhfXwQ26YOOswO2NEULfg5fHNnK7DDFbS4R
	jqkthfsptYyMPetmGDGdkazlESUoQBHVi4tYNPhyOQ+fV5nZPvWuUGwyq2iqF1XOyUzQN2ZfmMe
	1pvTIoLUp484HVdEysKcDEAiEOfEYq3u8eeA0C4609QW6Xm29khPaWIvJbcX9q5k=
X-Google-Smtp-Source: AGHT+IFTQWq7wJLux5T716tkUPy/sKDgeT8hzvtJgQByU/bk2OQVuVNCnSU3CeshNhzh73p8j5pyog==
X-Received: by 2002:a17:90b:2f87:b0:31e:fac5:5d3f with SMTP id 98e67ed59e1d1-32515e37453mr26193889a91.16.1756233131205;
        Tue, 26 Aug 2025 11:32:11 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276af0786dsm193214a91.27.2025.08.26.11.32.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 11:32:10 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 0/2] repo: add -z and objects.format
Date: Tue, 26 Aug 2025 15:32:03 -0300
Message-Id: <20250826183205.19566-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This v2 contains small fixes pointed in the last version:

1. Adding two extra spaces in the usage string

2. Use `object.format` instead of `objects.format`

Here's the range-diff versus v1:

1:  4cb193f59c ! 1:  3ea40b1572 repo: add the flag -z as an alias for --format=nul
    @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
      --------
      [synopsis]
     -git repo info [--format=(keyvalue|nul)] [<key>...]
    -+git repo info [--format=(keyvalue|nul)|-z] [<key>...]
    ++git repo info [--format=(keyvalue|nul) | -z] [<key>...]

      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      COMMANDS
      --------
     -`info [--format=(keyvalue|nul)] [<key>...]`::
    -+`info [--format=(keyvalue|nul)|-z] [<key>...]`::
    ++`info [--format=(keyvalue|nul) | -z] [<key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
    @@ builtin/repo.c

      static const char *const repo_usage[] = {
     -	"git repo info [--format=(keyvalue|nul)] [<key>...]",
    -+	"git repo info [--format=(keyvalue|nul)|-z] [<key>...]",
    ++	"git repo info [--format=(keyvalue|nul) | -z] [<key>...]",
      	NULL
      };

2:  37087dcc17 ! 2:  1d062e690e repo: add the field objects.format
    @@ Documentation/git-repo.adoc: values that they return:
      `layout.shallow`::
      	`true` if this is a shallow repository, otherwise `false`.

    -+`objects.format`::
    ++`object.format`::
     +	The object format (hash algorithm) used in the repository.
     +
      `references.format`::
    @@ builtin/repo.c: static int get_layout_shallow(struct repository *repo, struct st
      	return 0;
      }

    -+static int get_objects_format(struct repository *repo, struct strbuf *buf)
    ++static int get_object_format(struct repository *repo, struct strbuf *buf)
     +{
     +	strbuf_addstr(buf, repo->hash_algo->name);
     +	return 0;
    @@ builtin/repo.c: static int get_references_format(struct repository *repo, struct
      static const struct field repo_info_fields[] = {
      	{ "layout.bare", get_layout_bare },
      	{ "layout.shallow", get_layout_shallow },
    -+	{ "objects.format", get_objects_format},
    ++	{ "object.format", get_object_format },
      	{ "references.format", get_references_format },
      };

    @@ t/t1900-repo.sh: test_expect_success 'setup remote' '
      test_repo_info 'shallow repository = true is retrieved correctly' \
      	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'

    -+test_repo_info 'objects.format = sha1 is retrieved correctly' \
    -+	'git init --object-format=sha1' 'sha1' 'objects.format' 'sha1'
    ++test_repo_info 'object.format = sha1 is retrieved correctly' \
    ++	'git init --object-format=sha1' 'sha1' 'object.format' 'sha1'
     +
    -+test_repo_info 'objects.format = sha256 is retrieved correctly' \
    -+	'git init --object-format=sha256' 'sha256' 'objects.format' 'sha256'
    ++test_repo_info 'object.format = sha256 is retrieved correctly' \
    ++	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
     +
      test_expect_success 'values returned in order requested' '
      	cat >expect <<-\EOF &&

Lucas Seiki Oshiro (2):
  repo: add the flag -z as an alias for --format=nul
  repo: add the field objects.format

 Documentation/git-repo.adoc |  9 +++++++--
 builtin/repo.c              | 24 +++++++++++++++++++-----
 t/t1900-repo.sh             | 18 ++++++++++++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.39.5 (Apple Git-154)

