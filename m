Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5D204C07
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737849461; cv=none; b=twZdzUYaLYA8okSIVzQov7/YMahGU9ShMQMz+QYbYg+fj3gdqKsfj1uGqHTeOHDu0jbSdFMJmZ2qHPtsQO4GcyquQBILLdyKWHMOrvug1X8O1IU5+tSafsqa5cJ1bSq3HRGrJWivVBn1EM9A6kggH/Dca1CONA2Mdjk8l/WQQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737849461; c=relaxed/simple;
	bh=qahjdWGVjAuyTWp5aUrnpWV5g+ulniHnkvhbIE90cEQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Lka5umZBWcaqM3dIJ3g+QjPU0jEYYQIe9Cto92XXf331jBPsXLTGVfVZFEDhMUOWnGjtAGUB/k3/EjtuhUA0Rv17VeLvVmE1/R5GvahkopuWSj1xViD+hV6Z4Gjktzd03/n7lQVTmbxPeUcNeOPdeGHHlXkGi+U9yiB7vgO46A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeLxaxW7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeLxaxW7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so37423925e9.0
        for <git@vger.kernel.org>; Sat, 25 Jan 2025 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737849458; x=1738454258; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ntyogJXkYDOtqtDT9axCpnhlPSiNL71blFhmPMyJIRw=;
        b=TeLxaxW7VwP9L/tXt/cn0ddXpndhR5iVWwc+qMmd1yZ+X1q+aRJEZXH3n5g62BK/re
         Zp464O61v1mDgQ8kRcxnYt6c48I7XwglhEy5vrvHaOB9qHbpSOsuMJCJIIc3fmG8Aen9
         5slUqb0zIROw51efpTupruOSAyNLR0CAjbqOji0IchwHyR47LOgLImgz9qS/0EBBl488
         iW9fuzwb4/fTJum1k2/lAjPmuQN9g3bN3sqL3L9x1RE/2YpzZi2VzHmgullo04QU6TGZ
         QWVnrBxQ3V4IAIEMjbOh+z0Yt+E1AnngXXqJyBMnvs2OjAvPMWPbNu0YAoLjDu8rJ3hT
         mXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737849458; x=1738454258;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntyogJXkYDOtqtDT9axCpnhlPSiNL71blFhmPMyJIRw=;
        b=FRHcgZrv1XL2TFuyPWBkZgHbfAKZ74Uoi1KmL5CrZHbOKaN33SVEQhrF1t9JtrITm3
         dwL+r+uWCeQNmcH4PSyprMYQuw+v3ta/VP7/W3bQGFJpmvxTJUb7IGCmkLBulj4z8vTH
         WeCayw5Z/9zpymPnmGZIU1PjwH4ljuPyqun60ngcG3vq1tnJKl0vBn1Hhg4LtIwqXey+
         t2yokV5aj9IQY7jfU23x+ygTuH6Pienm8jXeIb8LsYwdZUl4c/E4Lp2SWcy6xbgA/uI1
         hh7amEKFr7VFqri0kli5MSFVD6foo1cVTtvreiYgVafRHOAByjTihPAKvhTauQ4mgrkk
         GK5g==
X-Gm-Message-State: AOJu0YwnSdRbdQDXaQUTHa+KzdjtzzHC9bxkBe1ZZ0Be1FjIvKEQTAeT
	Clw5TTOSRMM61ir9jsKdkvXbRbLJZ+8YQyywfov7y+EnhJbzqdPkno3Wkw==
X-Gm-Gg: ASbGncvam4/fykfglm6lo0qtJd/eSYrBYQ3etX/bzISutMhCnyyxmgH5YEYQwEznM8C
	MEh8SAb04WqnjWmrXrPevLwD3UmGCv15/Eyuy90l1mjKAcvQY9xhVbSsshFGwUGwDRMQZhlOWrF
	8du4m5rz9R4GW1jheg0ff7X6aWkAHNNKpQc3ysgMEgbLEV0PRPQJJxs2qB3FMZhOWmLFz0zygy2
	SIwr1TXWyngzLipd+Y1Qw2poGOjluMmfSBco4pI/L9Hxv4APk2hSUipgmqZmzCZu+g582r/Qco/
	yxIwXg==
X-Google-Smtp-Source: AGHT+IFWz/SDAL+uxPzeAqFeZfICgq2F/dYgj4eUkgbZopoJuxEty4/kZaz0qNLkcx6hB1aGa2EQUQ==
X-Received: by 2002:a05:600c:ccc:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-4389141c1e5mr276608235e9.20.1737849457777;
        Sat, 25 Jan 2025 15:57:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d3dbcsm78487575e9.40.2025.01.25.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 15:57:37 -0800 (PST)
Message-Id: <pull.1857.git.1737849456338.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jan 2025 23:57:36 +0000
Subject: [PATCH] bundle: avoid closing file descriptor twice
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

Already when introduced in c7a8a16239 (Add bundle transport,
2007-09-10), the `bundle` transport had a bug where it would open a file
descriptor to the bundle file and then close it _twice_: First, the file
descriptor (`data->fd`) is passed to `unbundle()`, which would use it as
the `stdin` of the `index-pack` process, which as a consequence would
close it via `start_command()`. However, `data->fd` would still hold the
numerical value of the file descriptor, and `close_bundle()` would see
that and happily close it again.

This seems not to have caused too many problems in almost two decades,
but I encountered a situation today where it _does_ cause problems: In
i686 variants of Git for Windows, it seems that file descriptors are
reused quickly after they have been closed.

In the particular scenario I faced, `git fetch <bundle> <ref>` gets the
same file descriptor value when opening the bundle file and importing
its embedded packfile (which implicitly closes the file descriptor) and
then when opening a pack file in `fetch_and_consume_refs()` while
looking up an object's header.

Later on, after the bundle has been imported (and the `close_bundle()`
function erroneously closes the file descriptor that has _already_ been
closed when using it as `stdin` for `git index-pack`), the same file
descriptor value has now been reused via `use_pack()`. Now, when either
the recursive fetch (which defaults to "on", unfortunately) or a
commit-graph update needs to `mmap()` the packfile, it fails due to a
now-invalid file descriptor that _should_ point to the pack file but
doesn't anymore.

To fix that, let's invalidate `data->fd` after calling `unbundle()`.
That way, `close_bundle()` does not close a file descriptor that may
have been reused for something different. While at it, document that
`unbundle()` closes the file descriptor, and ensure that it also does
that when failing to verify the bundle.

Luckily, this bug does not affect the bundle URI feature, it only
affects the `git fetch <bundle>` code path.

Note that this patch does not _completely_ clarifies who is responsible
to close that file descriptor, as `run_command()` may fail _without_
closing `cmd->in`. Addressing this issue thoroughly, however, would
require a rather thorough re-design of the `start_command()` and
`finish_command()` functionality to make it a lot less murky who is
responsible for what file descriptors.

At least this here patch is relatively easy to reason about, and
addresses a hard failure (`fatal: mmap: could not determine filesize`)
at the expense of leaking a file descriptor under very rare
circumstances in which `git fetch` would error out anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    bundle: avoid closing file descriptor twice
    
    This is a really old bug. Deviating from Git's practice, I did not apply
    this on top of the bugged commit. In fact, I did not even apply this on
    top of an older maint-* branch because it would cause conflicts even
    cherry-picking it on top of maint-2.47.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1857%2Fdscho%2Ffix-fetch-bundle-double-close-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1857/dscho/fix-fetch-bundle-double-close-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1857

 bundle.c    | 4 +++-
 bundle.h    | 2 ++
 transport.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index f18f98fec9c..d7ad6908433 100644
--- a/bundle.c
+++ b/bundle.c
@@ -607,8 +607,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (!opts)
 		opts = &opts_fallback;
 
-	if (verify_bundle(r, header, opts->flags))
+	if (verify_bundle(r, header, opts->flags)) {
+		close(bundle_fd);
 		return -1;
+	}
 
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
diff --git a/bundle.h b/bundle.h
index a80aa8ad9bf..d664b2f2d61 100644
--- a/bundle.h
+++ b/bundle.h
@@ -62,6 +62,8 @@ struct unbundle_opts {
  *
  * Before unbundling, this method will call verify_bundle() with 'flags'
  * provided in 'opts'.
+ *
+ * Note that the `bundle_fd` will be closed as part of the operation.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, struct strvec *extra_index_pack_args,
diff --git a/transport.c b/transport.c
index 10d820c3335..eb808f1e4b7 100644
--- a/transport.c
+++ b/transport.c
@@ -207,6 +207,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, &opts);
+	data->fd = -1; /* `unbundle()` closes the file descriptor */
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
