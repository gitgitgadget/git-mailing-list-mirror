Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81331C244B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671857; cv=none; b=RWXKFjsrMx842220CUeB2BblW05gkQGiQ/3ntiU+dLqnegGPCCTbFd9nzBTWlqKFlIHi9bJms34owxxDW4cym5DS8RetFzfw1+6moGYKelPA/7hcn64pVeouTU12MVFLD9Xp+uUQkjwK/48GsKpjm2ahYS5RLVGUmOVdGJtAXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671857; c=relaxed/simple;
	bh=0whqfWDiGsog6Z/khdKsHHFMk8EZLRETnYCqVUzmeq4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VGl+0DubkWpvDrd1eKU2law7ftzqyyo7aGwiJhiY6pU4TwVHr8LogeESItATX0PDkJvKSO0xfoAfvFwEvuJYu9+D1wuzb9ahl3owGF/0BMTsvpVPnnBEaV+gbT5774WFhfIDeBEqsybjJCTBrCZT7Ifd7f2d4QCT1EToa+UElJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bTfH22rS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bTfH22rS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e314136467so21999007b3.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728671854; x=1729276654; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0golRz4ylnufiKWTme0O/DTnIjAQZ0uV6rShFLn1FQ=;
        b=bTfH22rSZK+kaYHDwnLbqN2b3ZIzE2YAmY4rIQY3oKPX0911My34dp36uTFkpnoYx1
         PFbSQqH0hxZMfpFkjniKfYmSte+I90QsO2nb1ceyclyvbM2fJ966RGPFIBNoEtegd3eD
         eHLVyIKlHYpJjHMEHLOy0/Wc/FnrHTuDYluH8eI8GIOp48xRwWsM7x/BOH1YIJ7BqTOA
         4fCeHuIGsaNpRz3C1GwMmcextkzwuhXhbx0oeNir/+VMd4BIwMmdXIedoDW21W8coFdh
         3O85lJNui0Mkl/Cw58kk7qs4+zdjvE7bfcAgs4lprfktGl//4iJtJ8SzcXIglwD277zl
         PDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671854; x=1729276654;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0golRz4ylnufiKWTme0O/DTnIjAQZ0uV6rShFLn1FQ=;
        b=NUIG8GUneHSx3CxdmZ5C4m6EJSPS637ouuSI21dZ1KXWKe2x6EUaQp3hU8XfdiQEm+
         YjXe6YYH4aCHytUU0Nnv13LqLEGEGS6GvBbAxG3A0edTFg/Y6QpWBQMudH0HsFyuwe+T
         zci63jMuuz2XXYzTFHk6buB/ml882tvkqRvdU4xK05XtpwKox7ywlkKqnF05gXIG6RSP
         X/CJDZtCzmuteFbo6as/iyR12wuiXWkojxF6Mu7N26AdB3vOB/SFXZfxZx0ZQ1vZVdwT
         EW1PES7jVmAybWtLrj4F0ZlI1KeBUBRNQsNiJupBCWh8anoOIRgzG8l2i08CYt3mrOgE
         qepQ==
X-Gm-Message-State: AOJu0YxwcjRwzKcmExuI1VQLjQGLH0leLy//PzjC7h5BXYguabFGW5Xd
	fuWJM7+dk+B2tKoTbKZx/PW+HBtD4QfieWNElKQiIv4VjlPo6VMp5HVKlj2EyzhxdM0g6DZLXCD
	p
X-Google-Smtp-Source: AGHT+IH5cUvWDrllE6Ztzpw52G0fKJ8XfJig/WmN2YpTOFBqibPF8a6BTB/MKmqVACooYjVCNDJImQ==
X-Received: by 2002:a05:690c:883:b0:6e2:611:7abd with SMTP id 00721157ae682-6e344cde16bmr29076957b3.20.1728671854350;
        Fri, 11 Oct 2024 11:37:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b619d8sm6986217b3.11.2024.10.11.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:37:33 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:37:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <cover.1728671826.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series implements a new 'sha1-unsafe' test helper, similar to
't/helper/test-tool sha1'.

I have found such a helper to be really handy when debugging the new
SHA1_UNSAFE build knobs, e.g., to easily compare the performance of the
safe versus unsafe routines, different unsafe variants, etc.

Taylor Blau (2):
  t/helper/test-sha1: prepare for an unsafe mode
  t/helper/test-tool: implement sha1-unsafe helper

 t/helper/test-hash.c   | 17 +++++++++++++----
 t/helper/test-sha1.c   |  7 ++++++-
 t/helper/test-sha1.sh  | 38 ++++++++++++++++++++++----------------
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  3 ++-
 6 files changed, 45 insertions(+), 23 deletions(-)


base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.47.0.2.gd343f5dc9e5
