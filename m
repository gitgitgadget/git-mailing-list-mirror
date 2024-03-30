Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806718BFC
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807656; cv=none; b=YqraMa0nZbpb1HrVyeGuUV3E/Ey3kLfpDR4oLYZBMFanCl7jSxQhFpyC5eAOdY/2BE5TDi9lnr4GcPkD4zFODyQcoxUHqrj6LKmhJH+2j9DueOssWUWaAVb+e/BJpQiduQ2KEjMMjBDrJu7r127bcZ0cJgJ0MSlvvuybgILcJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807656; c=relaxed/simple;
	bh=fEz7zdPwhXxZLCVZebQGWMb5LNJ1BpgIhan16VBXCoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cCFHgQrNi4n02GAzKl6CsRoBBRlFjlvBQQ5ddPfCDwJkrrB1sem61cgfXPDRXbYo5eF2RdcJiC/R80pvO+eKNbXfsSH1ZiX7vaaaUBcKBLT9WJkulOWToT9psA8lT0EsibWkWUN37llg+pAdQOuo91Z9uitUMb02z6Wm2zawB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxUQGW7q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxUQGW7q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4154471fb81so16987295e9.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711807653; x=1712412453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bL1hXjK15JCWDNRC19wXu5puvSd65tC1jfX/7ApKFNI=;
        b=WxUQGW7q1wxnzsalrmztdsDMhVxKJLf20fscAfft4UYhkEPMjUWTKbZ+VSn0rXFnll
         fCWbiRnjWDPCjcM8eRGyeFwsc4W/V0h0XKTMEBZY8yTz4ZoylaFgtdw5xitiZVoHrTPj
         PfzPTVhjW0PgLmWFWFaZsCX0LEVhh0OD/Vi9WfQuALDcc77uzphTdY+sK+s5Ytp86hUe
         fj/s4l657mtP3fTjxMwTlgpCPVbhiAqyK/LTQfSaAbiHbXLyV3OqxC++tDTntGpGDOww
         cECsVPb9SbrAT7fUBQRoXTQXXGt8covQFC9YeP4ENtT6+1gI/n2ydsDPvbs8/QchJwuu
         30Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807653; x=1712412453;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL1hXjK15JCWDNRC19wXu5puvSd65tC1jfX/7ApKFNI=;
        b=qH7ifSDXoHOKVNQ0VqIGuN+FF/kNqLCTkL5/y7URTmLN9DT1DjMRBq0oE0MIpjRcVD
         p5J3jcO56xV0o2q+sTWNK2yV+GuUvO//l9Af0Yz4BwTMhwkzHgfm2xmitaPqgR5N6KsR
         POPv0T7EQa35PKq8jMqwlEh7VAHSJqjV/LBgqcqI0IXdEJDSPmFdsoFMYZUCbUHwa7i2
         uuTOkh/c6QtroO/6cwBpbt5t6oR3MdAqmj7KjasedF+wqQ+BHXNvPU4ogIjoSiVhQDU9
         gk5f0TRwLpju11sVZPIc/Aqn8AT3/Itd5AAFdcwRCmgGN7lwTq2mD7FfZymfQ/UsI7Gb
         PIZg==
X-Gm-Message-State: AOJu0Yw151koKJBxDww3kF/ewTnbObm2NXZGJ8mKmSQKwtvpGWzYEaJ8
	5rDY1GySnAJDZfAAOV/NggiYOojkPcT7Qq3Fow5tEQKrv21Gf+q4YeJJ45N8
X-Google-Smtp-Source: AGHT+IE15tdm1J/5POhkXFkyFPs0NpkLCCVh2lCDdzgt8J3mIO7vcty1qXO5sNWLDtwupWjLhGZ9FA==
X-Received: by 2002:a05:600c:3c99:b0:414:8e3:d8e0 with SMTP id bg25-20020a05600c3c9900b0041408e3d8e0mr4085481wmb.17.1711807652739;
        Sat, 30 Mar 2024 07:07:32 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041493b57976sm8603851wmn.18.2024.03.30.07.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 07:07:32 -0700 (PDT)
Message-ID: <57bbf2a2-1596-4b7c-a467-82b7b5b22a20@gmail.com>
Date: Sat, 30 Mar 2024 15:07:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
In-Reply-To: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since b3b18d1621 (advice: revamp advise API, 2020-03-02), we can use
advise_if_enabled() to display an advice.  This API encapsulates three
actions:
	1.- checking the visibility of the advice

	2.- displaying the advice when appropriate

	3.- displaying instructions on how to disable the advice, when
	    appropriate

The code we have in builtin/add.c to display the ADVICE_ADD_IGNORED_FILE
advice, is doing these three things.  However, the instructions
displayed on how to disable the hint are not shown in the normalized way
that advise_if_enabled() introduced.  This may cause distraction.

There is no reason not to use the new API here.  On the contrary, by
using it we gain simplicity in the code and avoid possible distractions.

For these reasons, use the newer advise_if_enabled() machinery to show
the ADVICE_ADD_IGNORED_FILE advice, and don't bother checking the
visibility or displaying the instruction on how to disable the advice.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c              | 6 ++----
 t/t3700-add.sh             | 3 +--
 t/t7400-submodule-basic.sh | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..8f148987f7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -328,10 +328,8 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		if (advice_enabled(ADVICE_ADD_IGNORED_FILE))
-			advise(_("Use -f if you really want to add them.\n"
-				"Turn this message off by running\n"
-				"\"git config advice.addIgnoredFile false\""));
+		advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
+				  _("Use -f if you really want to add them."));
 		exit_status = 1;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f23d39f0d5..76c2c9e7b0 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -370,8 +370,7 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 hint: Use -f if you really want to add them.
-hint: Turn this message off by running
-hint: "git config advice.addIgnoredFile false"
+hint: Disable this message with "git config advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 00c1f1aab1..5c4a89df5c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,8 +212,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		The following paths are ignored by one of your .gitignore files:
 		submod
 		hint: Use -f if you really want to add them.
-		hint: Turn this message off by running
-		hint: "git config advice.addIgnoredFile false"
+		hint: Disable this message with "git config advice.addIgnoredFile false"
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
-- 
2.44.0.417.g254ece0ee4
