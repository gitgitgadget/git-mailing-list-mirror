Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064D73444
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712366; cv=none; b=fZTfmbnAMKa6CTDUygEn4vHT8tKQMpXFWA60PtB1M7sZVYxkrmmoqDZq1vpZVdH8qROz5jz1wK/sHWGfc9EqDJuPOjVPvQNc2MYyeGEvcPtMRDJJzOf8iyDrDDznuCiBqiLouj5nbp6c8RLyNv75qqKHRj9RtBkOd/UJ/l3Wf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712366; c=relaxed/simple;
	bh=TuV+kyHhGLppDsB/tA3ttAbw9eso2bCNGWpk83rI0xA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwHUcCUSjWqH1kKfwHUbr4okgJLHawllfqJzdNF9z1IXuPWoWk7qZzz8JoH3KS3QuAMd1NxYWaUbfNTEaCKoHcLJ9NA6dp7/fEmc6XhhSN3jVzFJM5s2XMPC3QiiwMo6Wgf60azFUFumscnsXrh9EFxHtvHOmow3eI/IIamSI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=r0DGkGpb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="r0DGkGpb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44043348a9cso874581cf.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717712363; x=1718317163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypUmHEP1dY1bzlv5I9/ldQzKK8XwxBNndNFXyx2bSSE=;
        b=r0DGkGpbMb8696dqH0LmIrQMJfrag3DtOpLWJ67l/DniLHcD3RvNkNWBxKlp0LM1kO
         pOFEaUwYEkChhMFLQiv+EiCBFuin0wgz2Y/JPm75QOfo/a2bqMh0Yb5K4yQCYIrd7Jrr
         3O3Xvr1HGrfz2L5b05cgyOtfqfhD+AIxlTz7Ss2xjekPTm+I0MZkz3bOz5DdE8zA07/I
         XcrHySyKa0VWKDnASHZPsuwafAiI/U/MdlGWYwGpWTneGTKVdpHggwtAS6mxP3BhVfmR
         uRyBwbAkniTH/BxHqXBEUGvxVpsmeslRk3kxisWf6WI+pAdtDuC5wELzWHnY46P7j2Ef
         n7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712363; x=1718317163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypUmHEP1dY1bzlv5I9/ldQzKK8XwxBNndNFXyx2bSSE=;
        b=pxGEehjpcMeuVQCX8zHIRcZi69vKg4c1LEWfZmg9QVBf4CDYB5ssLbQ4B/CYJoSaVy
         xw8e65MY9dGXd6cWySC54xfyYEXYQGd31Q8O6N18x+bFuq7tI0BBkRJCUyNk/j38bDb3
         ui0kAmVC6bW7l+L4mq0hvY4ZPRrubfqb0usZSzpkogwxL36ehKLYc2ambaCB/nAusYAz
         gh+uinW87K9Es4c6xAUa2aT2gv+cADvea4GiCrTJY37nvmdzjNooa+2UK7SdpJ9Mh/8r
         JNZz/TSglU9QuM81XszWkyceJAhnaZTGYpb4CPCqhLxiUM9E81mpVNuDKYNWVMV+iYEK
         AdTg==
X-Gm-Message-State: AOJu0Yxv2E+sQCBzTX3ZMkOOA2uMxSpELDWe51Z4iAzeoZC17F8zAUuT
	mI02aD2DnWFzqGoc8wAw1DxAJhmNeTaddVo4T1I5QFLNyvO4sPkka5xuV91PEBrwf3DNq6bZWWY
	v24Y=
X-Google-Smtp-Source: AGHT+IGgkCqc0OMRTpsUntv1rDAwcAAopD3QhQd0lnGciEnNYkAuvcWoP8Zb5KIvE9QMPfOrt7MOHA==
X-Received: by 2002:a05:622a:1993:b0:437:bf2f:9bcb with SMTP id d75a77b69052e-44041b67bdfmr10115791cf.22.1717712363122;
        Thu, 06 Jun 2024 15:19:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038aa1266sm7578881cf.46.2024.06.06.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:19:22 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:19:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] commit-graph/server-info: use tempfile.h in more places
Message-ID: <cover.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This pair of patches addresses two issues (in the commit-graph and
update-server-info areas, respectively), where temporary files are
created outside of the tempfile.h API and thus survive abnormal process
death.

The commit-graph one is more prevalent, and has been the cause of some
minor headaches (for e.g. automated tooling to detect repository cruft
at GitHub complaining about unknown tmp_graph_XXXXXX files left around).

The fixes in both instances are relatively straightforward conversions
to use the tempfile.h API.

Looking at the remaining uses of mkstemp(), the remaining class of
callers that don't use the tempfile.h API are for creating temporary
.idx, .rev files, and similar. My personal feeling is that we should
apply similar treatment there, since these files are generated based on
.pack data, and thus keeping around temporary copies is unnecessary when
they can be regenerated.

But I'd rather keep that part out of this series and clean up a couple
of more straightforward spots where possible.

Thanks in advance for your review!

Taylor Blau (2):
  commit-graph.c: remove temporary graph layers on exit
  server-info.c: remove temporary info files on exit

 commit-graph.c                | 19 ++++++++-----------
 server-info.c                 | 26 ++++++++++----------------
 t/t5324-split-commit-graph.sh | 26 +++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 28 deletions(-)


base-commit: 7b0defb3915eaa0bd118f0996e8c00b4eb2dc1ca
-- 
2.45.2.411.g2d5a0536af1
