Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCD1946B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728764618; cv=none; b=bq5jpanBEoQ8a/5Za7KUxO8EUCrxJOtG4wIsvINP4mm/m8bYTIFk8OULtxX/eSDBMQBOcI6HJJqmO7ZFUXNp6b22MjpH22KZ2SzJ0wOI8T+KPsnM/a4lKR7LY0e4poDbYgJumjdfboQ1tkVdsTREcG4Fs67GukUAerkPmckPJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728764618; c=relaxed/simple;
	bh=V/5Z2B9RfQGlgSuqPoElUaqr7A+qtDFKXfLoclYD18s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=S0iCA4rXN+9lGcenpps7Ny4W3yeyPco5uH3JlQxQxxNFPSlisj829zmr61y3frDVUBFft8ijcpsMl4L1erEWEYbGCOz/Y6CbREfCMf4+VakZC0Qyj6yw8dSWcUfuBFt53gvVQJiYYRIEPR3SmncuJ7DX36SXxuSqeeVYunC/AVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCaspjtx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCaspjtx"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso4453863a12.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728764615; x=1729369415; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p90KyNfi+UqwNK3JmOhvsY8k0oXpPer/YNh+GyCPBRA=;
        b=JCaspjtxzdK03kCgoUiCb8lthi3MwPhT7apu7w7Plxw+LIGRCzKcxro2HLtShJYIiq
         I2QkJ2Iso9UhLXhDE8T8AwVw7eZdVuHs7PL9OjjWxhS4Y+nFasowuZHLiZZdZkEZwXno
         dAhy7yl8Ez8oz9fJmra+0gSZnUn8yOsnP03dy/8MyA1IJMhlYiW9Jbp4JwV8+2Xsz7cQ
         QkGIp73F+XZynK7GxvKJvIvOyIhvxahPtijgjbib/Nlp1AU1vRbpTO/YZn08wISGyi4i
         49Bv+dr4cU5e6AXtPMq2io+75RMumeH0jX5hYzmA7ZkOTZDSAjYZJTI2S82yozwqBToR
         VWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728764615; x=1729369415;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p90KyNfi+UqwNK3JmOhvsY8k0oXpPer/YNh+GyCPBRA=;
        b=ZJ6kKyPR4SQf8LMj6xcxJzcfjuTYX3tLPX280joda7oWljw1z8TpKFmgi8AcI3fe2G
         P3pOVYzpQT1bPhVjOdvr4+i89h6lSYIrDY39QceFIX5ISf113VPqmT3NMigonjBvNQtI
         H2YtSigGDO3F4RYPDNy6dp6hUbf3Qac8NffKTaEVSrEeTwoaJzuJX89oi9yv7sIlE98q
         xi9yhY13YSDN/JDicGM35n+xY+wWH7yznspCBLdEkFO3J3kjEgjf5Y85bPTNpEvmuFVn
         tbt7elzoeaJMZW/5MkY/Q6U1JKP6BmHezgcGUysO7j5kQsPXF6FDHNykZ063HEK3YQNO
         Gtzw==
X-Gm-Message-State: AOJu0Yx4wItU1AwzOeQu8AS0K7Op3RnkrOtWtsOhvQSs9b8fcjLOrKPt
	FFzprQOOCwnSXHNCS73R3SNnNnMR5OUIJYuMVU+0ytM/q9v//JXK78J4ig==
X-Google-Smtp-Source: AGHT+IFwjy2YaLkmFNQmfYLfZN6BaDZ0hzLdDDDGqcQRd/XdwWWAxzUsnVA0HsOI6s9ZoBJyxwkK/w==
X-Received: by 2002:a05:6402:42d4:b0:5c9:4281:451e with SMTP id 4fb4d7f45d1cf-5c948c88378mr4670112a12.1.1728764614917;
        Sat, 12 Oct 2024 13:23:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372940e3sm3167853a12.81.2024.10.12.13.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:23:34 -0700 (PDT)
Message-Id: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>
In-Reply-To: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
References: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?imme=C3=ABmosol?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 20:23:33 +0000
Subject: [PATCH v3] diff-highlight: make install link into DESTDIR
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>,
    =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>,
    =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

From: =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

Make git's diff-highlight program immediately available to the command-line.
Create a link in DESTDIR that
refers to the generated/concatenated diff-highlight perl script

Signed-off-by: immeëmosol <will+developer@willfris.nl>
---
    add symlinking diff-highlight into DESTDIR

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-938%2Fimme-emosol%2Fpatch-1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-938/imme-emosol/patch-1-v3
Pull-Request: https://github.com/git/git/pull/938

Range-diff vs v2:

 1:  ca76f336ded ! 1:  af4bea815fa diff-highlight: make install link into DESTDIR #Makefile
     @@ Metadata
      Author: immeëmosol <will+developer@willfris.nl>
      
       ## Commit message ##
     -    diff-highlight: make install link into DESTDIR #Makefile
     +    diff-highlight: make install link into DESTDIR
      
          Make git's diff-highlight program immediately available to the command-line.
          Create a link in DESTDIR that
     @@ contrib/diff-highlight/Makefile: diff-highlight: shebang.perl DiffHighlight.pm d
       	mv $@+ $@
       
      +install: diff-highlight
     -+	test -w $(DESTDIR) && \
     -+		ln --symbolic --target-directory=$(DESTDIR) $(abspath $<)
     ++	test -w $(DESTDIR) && ln -s $(abspath $<) $(DESTDIR)
      +
       shebang.perl: FORCE
       	@echo '#!$(PERL_PATH_SQ)' >$@+
     @@ contrib/diff-highlight/Makefile: test: all
       
       clean:
      +	test ! -L $(DESTDIR)/diff-highlight || \
     -+		$(RM) --force $(DESTDIR)/diff-highlight
     ++		$(RM) -f $(DESTDIR)/diff-highlight
       	$(RM) diff-highlight
       
       .PHONY: FORCE


 contrib/diff-highlight/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index f2be7cc9243..a53e09e0bdd 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -10,6 +10,9 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
 	chmod +x $@+
 	mv $@+ $@
 
+install: diff-highlight
+	test -w $(DESTDIR) && ln -s $(abspath $<) $(DESTDIR)
+
 shebang.perl: FORCE
 	@echo '#!$(PERL_PATH_SQ)' >$@+
 	@cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
@@ -18,6 +21,9 @@ test: all
 	$(MAKE) -C t
 
 clean:
+	test ! -L $(DESTDIR)/diff-highlight || \
+		$(RM) -f $(DESTDIR)/diff-highlight
 	$(RM) diff-highlight
 
 .PHONY: FORCE
+.PHONY: install

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget
