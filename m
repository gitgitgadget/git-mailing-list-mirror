Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CE3806AC
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303184; cv=none; b=VtWBX1XTyvTkOTU8OMtV/1gkfYUI86EmuZC7rPH6rjn77frHInq5evyeYxjngHSGN/LZjHbazLEc/BqYV1bKGPqJIqjuLnuAxuRgUHBnXDKlbRM+D+mhAyRFGFfEKfzcvWKGWvu6b8QkwXnnLwXCesxojOWHUGalI0NTsqtIBrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303184; c=relaxed/simple;
	bh=ZVPGuWrur72lVulaAgmxJS1+DG0PhM8GLKYB6cpEblI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoMI+N63A5PPYUBfWfbqWMWKPfngyC0l9bZ7sIeYIW/J3Y5Ld+bw4XVGpOzR0VeSi70daM7uxCPwbU4tVenQ5fqZtrFPbXM8ASo1Gc0gzMpcFeGo58KdvybWHy0lVErYeFBK+QMEj7bgq+XvHPaUN3K2MOboSZ1yF1tWDJPgswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVIgMlT4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVIgMlT4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so39586705e9.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774303180; x=1774907980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC/WJfKqd20XhM4uUN86CWn5VY2z8W0HkpoYKITxYdI=;
        b=eVIgMlT4DJcLQE6rhnYuj6O/TzLKKL8FOnFw7j5ih5B9SzCFry6id7VZNKBGqEQm/G
         5lEcuGqapN+yEmz09uM1gQsZaS/rmYla6nlrdFm04+giE63iphzJM50UqmkQglBnBTyZ
         hWXq6IRcGdcFSixlWqFYqyl/7Uul3MItd1rmx1tCclTUtvHYd+FiKdSMLbmiMw4K9CIm
         aGAUmrcN49d3TI2OQwkT3tul4YqDVtb5agAYzPV0kBRX0VYIbs/2oxcn04R8AoQhQ4aQ
         En1rtb06bjRRAtIbifIEgRN6eVmZ2t9lZ5riFh5HxIDNsXlKY5lPvkoazAS6p1vxTKVi
         z5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303180; x=1774907980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GC/WJfKqd20XhM4uUN86CWn5VY2z8W0HkpoYKITxYdI=;
        b=imKWX13dea8jWKZX0OB9N7hNZsLLscIDWlWaoC1GXxhTuNgzB/7RxnsnXuwIJvZkK7
         FsgjRqK23YsBM93qng45IVMkRU+Mk0PI8dF3P5uMRN+TqNvG3za5oABItcIzTkrnaNpX
         SAydkqaV99AIKN9fDjDUQtabXU0s6ig7VECy8sNEp0QlDvP8ZyBDynyiS8DHagmQur1S
         pR/xWQhn6bXkg/pxncfl/edhbnB6FHftIIKdosa/NQemxQ2HdnUYWSMyTWp9vhqKtjWT
         DAfSYmOP7VuNXBxFDaHDNIKaGvZBIJ7GsM4d+HCRuGfp755M6R0h/tGSPT4GU3x6ZYnS
         dujw==
X-Gm-Message-State: AOJu0YwnUZu4Y7wob4Vs4HxW12gt1osj5LA1PTprYLCQfT5zvRt8XyRi
	MpvZAZj/ZVmcWNR+gkP9jsmZBx4grO72FInrslCumBypWpBodGGefHQbAf6ZdrqmNfjZqw==
X-Gm-Gg: ATEYQzzY1ZQ8IkXLhFYNaWpz0oEeRDAaJb8H2rVHLwsrm5/tc0g1S9NWyVQupYXkog0
	pvQ5HAMLJEj4ejvFORTA+iz2/ptGwXwG7TyByWupUOAcNzjB+ybHVdafWFOV328Gue3mngEUTO4
	SgmN3Fk09bRgE4UgIyAG2cSN342gzxN9Q6g5Q4+meTrnMc41FTU5rqYFFN1rh6BrsDTm3f+/RW7
	W4yh3yTLopQue9ZDBypk7sQyxRljclWKxWS+KPIJKfSVGUleG1PZELwI6CfXjjWErmiK0/AJBeS
	bA4Gsf890eMGH3gX/urWxPIwXAp7tbrd9Lzt3z8aLYfOJe2+XFI4CxiMZ0ukqrraRIv3xgrrtuw
	SBfWApqWapvMv7j+EOqhd8VrLdRi1W9G29dJJ5OCXidTzAnOwZlZ7qPHd0x8C2sc6GGIIJOx+oJ
	IGFq0nliEvVPNis9HP6FcnHJ4vLd/OzPdQPXIjKjR3zCbhCfxe/YGczpX9x3vK9DCtxosdH5pfh
	7oKsHvaiFviYxHPT3557L596gJPGu7DcsJbnV8Jsn71YotMXbAqHYztJVg=
X-Received: by 2002:a05:600c:8b67:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4870f202618mr15984985e9.10.1774303179906;
        Mon, 23 Mar 2026 14:59:39 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711693a08sm2734015e9.2.2026.03.23.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:59:39 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v4 0/3] graph: add --graph-lane-limit option
Date: Mon, 23 Mar 2026 22:59:32 +0100
Message-ID: <20260323215935.74486-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322195406.108280-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time produce
wide graphs. A lane consists of two columns, the edge and the space
padding, each branch takes a lane in the graph and there is no way
to limit how many can be shown.

Add '--graph-lane-limit=<n>' option that caps the visible lanes to n. Lanes over
this limit are replaced with '.' truncation mark.

The '*' commit mark is visible when it lives on a visible lane or the first
hidden lane, any deeper lane doesn't show the commit mark but keeps the commit
message visible. 

Merges where neither the commit nor its parents live on a visible lane are skipped
because they dont carry any visible information.

The original idea to limit columns was noted as a TODO in c12172d2ea
(Add history graph API, 2008-05-04).  This does not implement
gitk-style column rearrangement, it only truncates the visual output.

Possible future improvements:

- When all branches involved in collapsing or padding are over the limit, the
  truncated lane doesn't show any information, this lane could be removed to
  make the graph more compact. Currently these lanes still appear because
  graph_output_collapsing_line() mixes state handling with rendering, so it can't
  be skipped but callers always expect a non empty buffer. Fixing it would need
  to refactor the callers to handle empty buffers instead of expecting them to
  always have content.

- Collapsing and merges lanes that start on visible lanes but end on hidden ones
  are kept to maintain the most information possible on the visible lanes, but
  the information about where they go is lost. They can be kept, removed or think
  of a way to show that information without showing the lanes.

Changes since v3:

- Rewrote commit messages to focus on reasoning rather than the
  implementation details.
- Changed graph_max_lanes to int for consistency with other
  rev_info fields like max_count.
- Zero and negative values are now accepted and silently treated
  as "no limit", following what --max-parents does with negative values.
- Removed the MINIMUM_GRAPH_COLUMNS macro.
- Fixed missing "--" prefix in the documentation.

Pablo Sabater (3):
  graph: add --graph-lane-limit option
  graph: truncate graph visual output
  graph: add documentation and tests about --graph-lane-limit

 Documentation/rev-list-options.adoc |   5 ++
 graph.c                             | 131 ++++++++++++++++++++++++----
 revision.c                          |   6 ++
 revision.h                          |   1 +
 t/t4215-log-skewed-merges.sh        |  53 +++++++++++
 5 files changed, 180 insertions(+), 16 deletions(-)


base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
-- 
2.43.0

