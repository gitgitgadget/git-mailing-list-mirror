Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F61F2365
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164717; cv=none; b=BT1OU8ZSG+wvOVI0/oirB1N4Hnxg0Ad31vmjlL/x6GggxV+RwH/KHn5uz9S5DR3hmFs4atrsizyno2aC4A4DfutFy5dYQjFeTyhYtyWUtLo0u/1qXy7moqvdiatDRBdWYPqZdm68y8ke5hhOS4sCww2D0D+q4BfsleR042vW1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164717; c=relaxed/simple;
	bh=p0V40tBW1Ihcb4Ahx+sbWAZCOC/u26vbQeBAXgi2HyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJQk7H04TimJUZRxoYPeSDnyFo2tUxSP59VmXcI3zGugryo++V7+k16sIopTGn8L9o0vk+m8jMr38FYSUt0V9a0q3pQb9dIQMlYwUTP2N4gvuYbzbz6c6aRHsyND6QYmefbuT7wyBM6Nnb56PlVLncd1JOfqGzRvgqyh/mteC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4OmRIs0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4OmRIs0"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46c8474d8f6so22129841cf.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164715; x=1740769515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLZKjp+PNhxzeXgxPXQvWq4wK79noyUQrKZQZ0boRnw=;
        b=L4OmRIs0Q7QV/xyXCkAe6uVN208jzXZOey5y2cd3mu8nzgT+0583Plr09uXVnDZbzF
         RJvvy0leeBBgiZpEC8DJIRUsgr/nPB5wP/m+gZq8EGI9Y9emeXtXPrS7R1Ur3MS1d8OY
         7W6tC4gDCQ32RHdCVjHjwHsNLZxWef4VMFNEwyOLJvUxOugl1gkzH+A9gkFUubGAmypp
         Q+whLGfY9PVxzw+WRdBAZbnu8wTsKRpHKq4S6j8WEx2EziFvGwi8KCEKbnPf4/CQkaBI
         beI/8IaX7N0YlDQOinJelagAvZsjoS7FzFlTMwdrunWLpBF5fBkK/LGLOzWL/8sOcJzh
         2x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164715; x=1740769515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLZKjp+PNhxzeXgxPXQvWq4wK79noyUQrKZQZ0boRnw=;
        b=VQ7A0pkNx/qsai1KaLmjOL9r2mLI3sTT6K97IMTJqAWiYjhDLsNY3h+plC6UCu5ztc
         q4/ngtv7B7s5PQ5W9qe6dQOe0B7K1qHCT8Aj/xlomcfiOQdO/w0/HRZzD8GNsJRRXQeP
         WYF3OASFraV/dh3Hi2p3Xz2WI+rCVpVkJx8S5EsE2Mu99HJtpP7YL2THJtIxcdeHLuv9
         iubvoB6Lpsp2JKgy7hmqFi8Chf40MM2VAdS57d+CdQ/k7MxZeonur98UMoz8FsRJxPY8
         FfrYsMHFliC1PuYzPioqVurOO4G32YGFTfJyrMcedb96MFVyhkG+2morKMoKOHcpiUoE
         eZOg==
X-Gm-Message-State: AOJu0Yz+uxM2NSPbalwuMh7oBnZmcw19o7WJl898K0W3h3D+qDIUoAp8
	hZQt8TqdBrXUyi+ALbhApsscOcF2xf+k+X7lgycUu3iOrjoUbDuNlEWvM8wOzhM=
X-Gm-Gg: ASbGncvAz4jz9oYcaBPgb8/fUyC6jag6wiNxuQ2yUxIEr6/U86dYJFO6pnUg5GibU8N
	zdO4Vh3IPlI/0QnIebMBo9AEFGtpJGX6BDbXwM5KTUbeOvqAf7VSCfDmScVSDY/QwAN07fL0vcz
	rJI1WIw/mq9bCTsugl/OFXFG4IQXjAA+XWiaMlibNC5+vI7LaVBucNsenlfGtFZFDoDNewzrzkQ
	KPbYI7OS2AD/PGzHKV7e0qHg+naPRXft529NbLNLqBrXcY0eIJQK0H+cx05FbT+32BhhNbAVsea
	qp7YoiBqAm6hlaU+gGK8V4NX1/LqeSCcjIeIMTOZWx/W2HOamcDV
X-Google-Smtp-Source: AGHT+IFLKlEmuajISoU1Uqd5r+Ms6OQh6Ku3YDitaFUWhX7vq7aoINWVpIl60NQLKx786uDHDGOLSQ==
X-Received: by 2002:ac8:5994:0:b0:471:83ac:98ba with SMTP id d75a77b69052e-472228ac8d8mr69057231cf.5.1740164714670;
        Fri, 21 Feb 2025 11:05:14 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:14 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 0/8] cat-file: add remote-object-info to batch-command
Date: Fri, 21 Feb 2025 14:04:41 -0500
Message-ID: <20250221190451.12536-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Calvin Wan’s (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
command at [1].

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[2]. This patch series implement the client
option for it.

This patch series add the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported in this implementation.
The type (%(objecttype)) is not included in this patch series, as it is not yet
supported on the server side either. The plan is to implement the necessary
logic for both the server and client in a subsequent series.

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will terminate with an error.

Changes since V10
================
- Add a check on command input to prevent overflow.
- Add other checks to prevent potential abuse.

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (4):
  git-compat-util: add strtoul_ul() with error handling
  cat-file: add declaration of variable i inside its for loop
  t1006: split test utility functions into new "lib-cat-file.sh"
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.adoc        |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 125 ++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  85 ++++
 fetch-object-info.h                    |  22 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 git-compat-util.h                      |  20 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 664 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 19 files changed, 1065 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v10:
1:  a4a5aefa3e = 1:  814c53b402 git-compat-util: add strtoul_ul() with error handling
2:  c67e79804e = 2:  04f41100c4 cat-file: add declaration of variable i inside its for loop
3:  7f0b824714 = 3:  3af67e6648 t1006: split test utility functions into new "lib-cat-file.sh"
4:  0d22d6af6e = 4:  cb1088e436 fetch-pack: refactor packet writing
5:  34c34c7464 = 5:  614daac4bb fetch-pack: move fetch initialization
6:  54dd237c45 = 6:  4bc403fa2c serve: advertise object-info feature
7:  90a3d987d5 ! 7:  adae08d5a8 transport: add client support for object-info
    @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
      	args.reject_shallow_remote = transport->smart_options->reject_shallow;
     +	args.object_info = transport->smart_options->object_info;
     +
    -+	if (transport->smart_options && transport->smart_options->object_info
    ++	if (transport->smart_options->object_info
     +	    && transport->smart_options->object_info_oids->nr > 0) {
     +		struct packet_reader reader;
     +		struct object_info_args obj_info_args = { 0 };
8:  9d932c2cb2 ! 8:  975d39cb6a cat-file: add remote-object-info to batch-command
    @@ builtin/cat-file.c
     +#include "alias.h"
     +#include "remote.h"
     +#include "transport.h"
    ++
    ++/* Maximum length for a remote URL. While no universal standard exists,
    ++ * 8K is assumed to be a reasonable limit.
    ++ */
    ++#define MAX_REMOTE_URL_LEN (8*1024)
    ++/* Maximum number of objects allowed in a single remote-object-info request. */
    ++#define MAX_ALLOWED_OBJ_LIMIT 10000
    ++/* Maximum input size permitted for the remote-object-info command. */
    ++#define MAX_REMOTE_OBJ_INFO_LINE (MAX_REMOTE_URL_LEN + MAX_ALLOWED_OBJ_LIMIT * (GIT_MAX_HEXSZ + 1))
      
      enum batch_mode {
      	BATCH_MODE_CONTENTS,
    @@ builtin/cat-file.c: static void parse_cmd_info(struct batch_options *opt,
     +{
     +	int count;
     +	const char **argv;
    ++	char *line_to_split;
    ++
    ++	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
    ++		die(_("remote-object-info command input overflow "
    ++			"(no more than %d objects are allowed)"),
    ++			MAX_ALLOWED_OBJ_LIMIT);
     +
    -+	char *line_to_split = xstrdup_or_null(line);
    ++	line_to_split = xstrdup(line);
     +	count = split_cmdline(line_to_split, &argv);
    ++	if (count < 0)
    ++		die(_("split remote-object-info command"));
    ++
     +	if (get_remote_info(opt, count, argv))
     +		goto cleanup;
     +
-- 
2.48.1

