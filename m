Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CD39FC1
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097835; cv=none; b=vC4F1TQQNIX8+paEvbKPR0qiRYDhmB0FzzlV4cquKkqwV8J6xRgKbAPtao6aio7SzcKiqvYec6Svrta7bfUqBjZT1Zo8fB0+bjhyyjjygnQNfwu0o9VdG4riBMw2kmVTaENaFkm0gx13GXYgZFXf7TPGPnac/X1OOcCN0V7qGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097835; c=relaxed/simple;
	bh=UaDX7RHLCp54lgpHDmOXYkvA6GXo1A/GjSnj6uZd8wY=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=jN8uGCfW3vk8GUYbVYtldntoo7ynvlV++R6X8MYsbwtDki6TkhIdCZy+kfsNGFPhL/lsBgkecgfQ66YiIpsXGJ4SInfPYcyK/DTRQeYRfadcoqLNmzhnQCqLrzl9pA7pbLTpiPEMuDgYPu9eQ/BJg4yXRzSoA1PI+F70mC8BrjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw1xAORm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw1xAORm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e914cdc48so431418f8f.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097832; x=1710702632; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pQNLCftMrUIJ/tqGQVXM8WCFzN6df1u/roajtaoXdjA=;
        b=Lw1xAORmlmLKec91kwEDN2ue/s+Gm8NTu/Z9Nv/5nTDhoOeYlEx1OwWT3dMQ0qv6Al
         afGF6rhtnjN1INjXzd1hur7u6gtRRfgYNLcOrquW7KloU0Mh2Eb9IRFtaKWor/2gfhwT
         igOPdY9bVZX/bcOl8mufNk+3siHBoo+l/TOZ3u1R84bxHUUUVDY5b6QzOX6HU7Ce54m3
         36BvOKBM0ZRVEE3NUl7Su/oaM9XbVLqLctVYF1ufpMkCr3pSyXAoHHfMANZB8tDXXycd
         cOaNbUQUM0vUUgUb22S1byX8RGLXFaFLhbUQpL5OLkVPiTukSaOuKoTfapcFSLncFBwn
         W4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097832; x=1710702632;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQNLCftMrUIJ/tqGQVXM8WCFzN6df1u/roajtaoXdjA=;
        b=FHI6C9HPJFEI/2pPgNju0l9+VUtjuW/sY97yP3DPnhy9QzqNFDFAb71Uf3NgTmrBH9
         6BXGYDRMjpmvuwbUjgXtYMl9BGlv6srKaYDY3MHkzaUg2q5znMrUKN7GIsBoHdmOSpAC
         CbIlRBwLYEz1RK/bf2S2TcqgcTDKzKbSDSnIFiGGpz5FT/rGTYVgSnEvodui6Bn5BbD3
         wmivrAiphXNDIlvn2Yx6zod5QSLmfNIsYYOA1OHplKHb0cLA7CIfZU0MLfcAQpWfRcdT
         X1/4n/FJu0TcQEUH/47pBGcuUFmHCp02y6AxOND8qgw5sx/85DIPWqY/S6PEWAKK2jds
         NxzA==
X-Gm-Message-State: AOJu0YyGG5zhuM0G1bTZto6ZLqpv7xdk2fWJMGkF369mt8N27O9tzCMP
	98UXZylxtphlJpyFAZSEkdaitliyyoOZze39E3zzDBTCcfOaB4/1VRVGDC+J
X-Google-Smtp-Source: AGHT+IGv4BeTygsvFIxqY8C4onN7/q67cvQIjt/M3nk4wZ4jeetrazRyQIHTHt7CINnxHqP4jg5HvA==
X-Received: by 2002:adf:ea87:0:b0:33e:7865:cf67 with SMTP id s7-20020adfea87000000b0033e7865cf67mr3112343wrm.55.1710097831540;
        Sun, 10 Mar 2024 12:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e8c2476fesm2431943wrb.5.2024.03.10.12.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:31 -0700 (PDT)
Message-ID: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:24 +0000
Subject: [PATCH 0/6] doc: rework doc files for git-init and git-clone
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

Following the new formatting rules that were added, I reworked the two first
manpages of the series on git-scm.com.

This mainly entails applying placeholder and verbatim markup when it
applies. Other changes are added; if it makes sense, they can be turned into
general rules.

Jean-Noël Avila (6):
  doc: git-init: format verbatim parts
  doc: git-init: format placeholders
  doc: git-init: rework definition lists
  doc: git-init: rework config item init.templateDir
  doc: git-clone: format verbatim words
  doc: git-clone: format placeholders

 Documentation/config/init.txt |  9 ++++--
 Documentation/git-clone.txt   | 30 +++++++++----------
 Documentation/git-init.txt    | 54 +++++++++++++++++++----------------
 Documentation/urls.txt        | 12 ++++----
 4 files changed, 57 insertions(+), 48 deletions(-)


base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1687%2Fjnavila%2Fdoc_git_clone-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1687/jnavila/doc_git_clone-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1687
-- 
gitgitgadget
