Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E253D96A
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754235; cv=none; b=i+b3DBMPWb8sXgIRiYCu/Xkqy4DYEgS7yOG2aQgzrk/N2vqFpKiyGmyO5QsgSxE8Km522n+popTyjbw2XFC+xGknaK5lBk9ZSHrg3+hqaYWHVCGGoG7Zqu7hoVeVKUoeqS5tlA5z3o0UnLoTkskKTeUGwr1fcJk/xqSlGmCAiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754235; c=relaxed/simple;
	bh=zG8hZ7aBjknpq6q5bXKIzqFlHqPrFpB+jcQrTiPkdfQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OienN5Ga0UqT8kmInHCj5T4S2IjJih5N0/z+ShJ2e21HU9eqQNqNH/zUntB2u73e9VUQU41omZlf0umU5zdYEG0WiNThZtfDcN1eHjYQOKQ27zAWuojPqcFLCNxPk/sM6ESV3LoCsLWhb9J8pRKD6rxf9QYBjEQ1ZZcp4n/FzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBMfbUNo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBMfbUNo"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f646ff1bso53415966b.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728754232; x=1729359032; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ncd+Mwm6VncGPmtzK905igewFCJ8NWzkbfiPnW5PC8=;
        b=iBMfbUNoGz9A6Nv3It2wYlBLknCNQoh3/VSgz4tg7vYdOKs6iaj6I7ybGIt31SLkBK
         Fc69CBf20u3/5OOgHrXkAOENrwaW5/aitpMndoQprG6QW1bcEvfQUbStTQBcVeReVksh
         ihOdVJkFK6iapYfU7ItPFClbhmvNNy4Kfpg4mf+1Hfc6P8zTxMr82g7EJe0cFI/RN9dU
         AVS5kmCsXEWP2Utch+DLl4KPcGkrkKyRQIEzmFR3FNqovjZOXZBfJjXigjICcb1dYEN3
         wV9+Qx4GE+cNEhbQ78I8m1RUO+IC9TcteE0wI4Oqo+XVRrwjH/lusfDOFQz6SDrwqikk
         jK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754232; x=1729359032;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ncd+Mwm6VncGPmtzK905igewFCJ8NWzkbfiPnW5PC8=;
        b=Z7dfSVKH/3SoDn7bHbxRAgJcnfN3JKBDb6HZ2DGWb91w2GKjfDKbTFpl43vwYqKfi5
         4dxHAyg696BWjOEa/qWW/HoKbTB+D6J3sQyE0VQ1FH2yJfEyhrNFZ8DpNkLBAQqAdB5V
         2RHqb3E6KtREn7bxPTGH2GzwFcgWYRLCgTplmLSEJ2yJjtP9Ea1iIUyPFC9RIsX6x5hA
         0P3Q0/X8pytLXhndoQC7bkrJME3enQ+xozaSBKA1koP6ZhsBrFGOCSMOj8TkahomDM+Q
         TwGDHyWvxOcjQx/ElIrwfH5fOuOVFMyX5MlwpLiUNdCEE4WmzJ5WIFfdjs1Hb2GWA8a8
         6+hA==
X-Gm-Message-State: AOJu0Yx7HG2RCZL6i1cjVGCUoRuzjobgahXSSiXVKQYzquCEyxMDsbLW
	LdAFvMEK5XRSveznIOw03eUQ9XLzB5TbkuOxX6Os3rFRmq+RGZoi/whs4w==
X-Google-Smtp-Source: AGHT+IE5rqkGeclvQBgQsOWU13oe+EdyqMJtnB4eO2Qw2ClQ9VJeffyS9ti+ifuOskq0HEUPiH6kuQ==
X-Received: by 2002:a17:906:6a12:b0:a99:742c:5c7 with SMTP id a640c23a62f3a-a99b9305ed1mr481974766b.10.1728754231598;
        Sat, 12 Oct 2024 10:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec56d8sm349847066b.17.2024.10.12.10.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:30:31 -0700 (PDT)
Message-Id: <pull.938.v2.git.git.1728754230466.gitgitgadget@gmail.com>
In-Reply-To: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
References: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?imme=C3=ABmosol?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 17:30:30 +0000
Subject: [PATCH v2] diff-highlight: make install link into DESTDIR #Makefile
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
    =?UTF-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>,
    =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

From: =?UTF-8?q?imme=C3=ABmosol?= <will+developer@willfris.nl>

Make git's diff-highlight program immediately available to the command-line.
Create a link in DESTDIR that
refers to the generated/concatenated diff-highlight perl script

Signed-off-by: immeëmosol <will+developer@willfris.nl>
---
    add symlinking diff-highlight into DESTDIR

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-938%2Fimme-emosol%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-938/imme-emosol/patch-1-v2
Pull-Request: https://github.com/git/git/pull/938

Range-diff vs v1:

 1:  e23aeb1a76c ! 1:  ca76f336ded diff-highlight: link to diff-highlight in DESTDIR #Makefile #diff-highlight
     @@ Metadata
      Author: immeëmosol <will+developer@willfris.nl>
      
       ## Commit message ##
     -    diff-highlight: link to diff-highlight in DESTDIR #Makefile #diff-highlight
     +    diff-highlight: make install link into DESTDIR #Makefile
      
          Make git's diff-highlight program immediately available to the command-line.
          Create a link in DESTDIR that
     @@ Commit message
      
       ## contrib/diff-highlight/Makefile ##
      @@ contrib/diff-highlight/Makefile: diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
     - 	cat $^ >$@+
       	chmod +x $@+
       	mv $@+ $@
     -+	ln --symbolic --target-directory=$(DESTDIR) $(abspath $@)
       
     ++install: diff-highlight
     ++	test -w $(DESTDIR) && \
     ++		ln --symbolic --target-directory=$(DESTDIR) $(abspath $<)
     ++
       shebang.perl: FORCE
       	@echo '#!$(PERL_PATH_SQ)' >$@+
     + 	@cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
      @@ contrib/diff-highlight/Makefile: test: all
     + 	$(MAKE) -C t
       
       clean:
     ++	test ! -L $(DESTDIR)/diff-highlight || \
     ++		$(RM) --force $(DESTDIR)/diff-highlight
       	$(RM) diff-highlight
     -+	$(RM) --force $(DESTDIR)diff-highlight
       
       .PHONY: FORCE
     ++.PHONY: install


 contrib/diff-highlight/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index f2be7cc9243..19e0cf17ccd 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -10,6 +10,10 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
 	chmod +x $@+
 	mv $@+ $@
 
+install: diff-highlight
+	test -w $(DESTDIR) && \
+		ln --symbolic --target-directory=$(DESTDIR) $(abspath $<)
+
 shebang.perl: FORCE
 	@echo '#!$(PERL_PATH_SQ)' >$@+
 	@cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@
@@ -18,6 +22,9 @@ test: all
 	$(MAKE) -C t
 
 clean:
+	test ! -L $(DESTDIR)/diff-highlight || \
+		$(RM) --force $(DESTDIR)/diff-highlight
 	$(RM) diff-highlight
 
 .PHONY: FORCE
+.PHONY: install

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget
