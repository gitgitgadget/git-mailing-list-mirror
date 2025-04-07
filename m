Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD14223302
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055940; cv=none; b=iHJv2DajX1vkjKClinD1quoMzLEiyUJSipKxYHXE/oWaSjQP+nJG1DMzQu8+Bwj2VPzU1RAnucbqapV7YCmOeWIQ5RUg/olDyKq/Z7W3Yhq8iVGON7JUWuw7BqzoO809L7Qnqc9apNjgdR1Kw8NT/38KqEWSwIRMgTkeyAiFIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055940; c=relaxed/simple;
	bh=InsC6GCd1LDmH/PxWALsOC8/c5Po0MLZJ9xqH8LVDpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/pC1zI9qQ9rjo3aC1Old1QByj+0SvnLXQnQE2OXcTWxq0mxbmgNrK6+t8rEuaWxbwXL2oQdFJa7iBStf0CGbxrPH8wtteVZrEVB1QAnm1lw02UH24nLuJ70rGCErhhOo5I5gHjPoeXg9Irba73ZDysBQnFWtx/yNHFteCWPbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P722UVU5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P722UVU5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c277331eso4347579b3a.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744055938; x=1744660738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pydMlhy3BA5nBnn2/5mxTGXT5t3GEJ/8Ig/Rtu96mKQ=;
        b=P722UVU52xFF3t06VRR1rowDqUOV10Mavi4y/OF3kJFPNR2dpY7DvarneKFCdVy8bu
         E2cs468FMaTrhNLU1MQl6/tXTu5Lbp7wWo2QmkFUC0HwmwkgHZATyGHZvuQTYyEV0lxz
         vpaKsnC8UY8Pr73rgoNDOZQlZ3KFuC+VUB9IaT8j554HbB8sDfKNlluoMXFgEttVMKZp
         oLuB47xAG8ht+2GR5KkhkMF7kPNWZF7pEoUveGaHxufcPOkbqb/YpvW/xCJRRGFEn6mj
         yhRv57MDEEWOxGZ04HM0ueZObEI0py9UU7+qYZZFWxCDP+gDtRhG9xaLTzoC+QEgXEdZ
         x7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055938; x=1744660738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pydMlhy3BA5nBnn2/5mxTGXT5t3GEJ/8Ig/Rtu96mKQ=;
        b=bBJo1rxYkzerxJM/j/In4C7qWrh/r0kkZVWjZNd1Nf1FjzJW4NVqwFuLy+aRQGJyQQ
         OSutWDUuAQ3CvWvMBHnA0hdBpVPv6Io1s8zNDhXRcEi85jaHIjpRvtR37oPdhj9WcFNY
         IhJ4RmGKUoJs/lch+t/wtZ4GorlEY5q8ml6aayWTs3ZwiMFBmNxprfQkEFzZr0FXFXH4
         UfD7GkqrCyGe886wrL11w4V8Mg4rrT+owiPp3K78U8qgRuUuLiNaCCjNgVaTi0B+c4XK
         wbiOeuR4JHVocZlmuhy2OR7R3Yk7QrU0HMaOOuabhWklpcmxr54Awz4cOkwm/JoHqZgi
         5MCA==
X-Gm-Message-State: AOJu0Yza6ZzfjdVHGIF7TXw9jvePO2KEGCLZYr5Pxh+XcZ0aS6NHXxg7
	04W4PXhTsFL8zj3A+DOeSTTF77TloZipteWORLBKKeXOl11B7I/L0r/uukha
X-Gm-Gg: ASbGncuH5Cg7Jxy5kwkbMi3l66XwZo2i5WF9Dsd6r5W56mURG9Ylqd7wsJj2+F/M+gE
	TXltlZ/Fig36fsH6Ll7JcwJ8hbc+ZwaoNBpcx26KJU2nWvmq5rjzRuemAObD3EaZOqtwp+MUpie
	9nFHYJ1kgiBEDSAoKQXqYDaYusl9fny9+r+IMUp+8qE5EpaVDfkes5cokeYiH25KS1egjQdaH46
	P52KtaMygxgVvt1JSk18qnK/L8a75W4gpdagaNosAkWA73WWg0O1TwNuAHpOJUniksC8Q/iqaW6
	cPdUGimnH9R3xK/LhC8U/iAWaruz7ThIx2BqmRA0Llb7V97RlkcdXGfsxiSaGhsUoJesiA==
X-Google-Smtp-Source: AGHT+IFzTF2oJiFTD7cOEhOLyUrsvcymQLOeq1O+cFB2KHSUYYBM1krSjTsNw1yBAtoaS8x/LwMuMw==
X-Received: by 2002:a05:6a21:3386:b0:1ee:c830:abdc with SMTP id adf61e73a8af0-20143b1b482mr676267637.15.1744055937630;
        Mon, 07 Apr 2025 12:58:57 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc3fd411sm7644032a12.52.2025.04.07.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:58:57 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 0/1] remove unnecessary if statement
Date: Tue,  8 Apr 2025 01:28:40 +0530
Message-ID: <20250407195850.299348-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406121513.154084-1-usmanakinyemi202@gmail.com>
References: <20250406121513.154084-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an earlier patch[1] (f29f1990b5 (config:
teach repo_config to allow `repo` to be NULL, 2025-03-08))
which has been merged to the master, we checked `repo` is not NULL
before making call to `repo_config()`. Later, in another patch series[2]
which has been merged to master, `repo_config()` was taught to allow
`repo` to be NULL.

So there is not need for checking if the `repo` is NULL before calling
repo_config() in the earlier patch.

Also, Patrick suggested having the test inside the
"t1517-outside-repo.sh"[3] instead of having it in the individual test
files like[2] and I also think it is a good approach as we will
have all such tests in one place. So, for this patch, I added the
test inside the "t1517-outside-repo.sh". If this is accepted, I will
move the test for previous builtin cmd which has already been merged
to master to "t1517-outside-repo.sh" file.

[1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
[2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi202@gmail.com/
[3] https://public-inbox.org/git/Z9vCDFRUG7IzU_AG@pks.im/

Changes since 2 
================
- Make reference to commit that teaches repo_config() to be NULL instead
  of the merge commit. 

Usman Akinyemi (1):
  builtin/update-server-info: remove unnecessary if statement

 builtin/update-server-info.c | 4 ++--
 t/t1517-outside-repo.sh      | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

Range-diff versus v2:

1:  020b228eb1 ! 1:  cd359dafe8 builtin/update-server-info: remove unnecessary if statement
    @@ Metadata
      ## Commit message ##
         builtin/update-server-info: remove unnecessary if statement
     
    -    Since we already teach the `repo_config()` in "1a764cdbdc
    -    (Merge branch 'ua/some-builtins-wo-the-repository', 2025-03-26)
    +    Since we already teach the `repo_config()` in "f29f1990b5
    +    (config: teach repo_config to allow `repo` to be NULL, 2025-03-08)"
         to allow `repo` to be NULL, no need to check if `repo` is NULL
         before calling `repo_config()`.

-- 
2.49.0

