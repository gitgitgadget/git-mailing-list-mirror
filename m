Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCC381C7
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343477; cv=none; b=RIR37SCpez9Xpo2UQP15yBZbB5Ko4OHAVQxal6ah1edd3J/7fn1eaq7U+XfTCc4KCSgL3FVw0Lu+9coORz7Kvwon89609GqQymy6CMz+pzNuYpKkEL4M73j/qywzz/PyiXTPzS87J4MLdTEt+wU9S73NgulmiuliBV+Qv0JoUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343477; c=relaxed/simple;
	bh=tdzpHmTKkZ24KvC3xTC7FnONi0Z/QV8MVeUyetSmH50=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hj9bWP1P0p86Ut+mY8a1TFSc5BLlS7tVROXr0Wtw7M/w0QgmkTg/NkwRCgxlOr93FsViH0AW/G4Kt3TYhm7eJ6Sa7b6N3S/WI++heoKq0uwl86y+cxk6HdcEA3kQ4H6B+oXbqicLcjlIEgA7Q0hQis3evXsOp1dsu+Mi+RAGGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWOCITQl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWOCITQl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34b64b7728cso3206405f8f.0
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343474; x=1714948274; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEr1tDLxI7cdJtH9InmwvzeqtnIvZlPqbs8ciueP0vg=;
        b=TWOCITQlGDzHBaxSjlCnaCPj+WBzNaYrvyTe+lfkEQ8/Yz4mCtxRSQBauxCKjHf22b
         UV64tcCY5mbySh8/5rEM4SuojDlFcq32jVc1IrSjr5GlBOx3s0x6jgH1SwwrLhQn2HSy
         qq+H5veKKW8806z06nvoS9gPgWJGSzjpGJ5rYNZT2Z0Wa0VYbWvBwjMvbM60y2JuObcV
         ZoJXfL4klUyxrdj17zBk7HtQ3gwRVgg02AT6mmI0lDlnl1bRV9kCXVr7AdW9m/K7T0d+
         nEYybu+9TcCspa9UUGi4ML9731U2aUrnyA3OXkhiFvteZpM7kV1wu4NJJ5DvMxZ/7iNo
         j9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343474; x=1714948274;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEr1tDLxI7cdJtH9InmwvzeqtnIvZlPqbs8ciueP0vg=;
        b=U6+ogxeGhZx5539LruZr7ZzWzgv5zHPA1CP0dBCH165iYcoZmuAWOLxXHiBcGSPZ3O
         zTcgkeD/HuToVCbW4rO/enFtQOg0cRb4F/4Jw6cL1ag+ZN8csy2ew0J9XfknjqYVzvEh
         l4s5jgAXJY+0YbzIHiH6lJqYctgt4+r1Jhe0h+Q36yJyJViCj9/emgdMktfcwID1xGm5
         90bsIzcOntJgdwcUDJrcyBNuIkVl8T7qa5gsiifj8LOn/DPVLIaVre8f6FJBO6oEbQl3
         Mx6nzTSVU31cukWq/eICLE4nOeMOKHTSTaR/cK3aHUchc7vz9+9OesT5P6sJn3qMdCjD
         Rm6A==
X-Gm-Message-State: AOJu0Yz0GaoOma5JZ85/rpmR/Y2unk+eQoxB2LekMADp2UMnqDujsqyy
	VNwakW8fBatwG8txAvIOWrYUV3HwpuwwPLxXOTFOs1qePvhCx/V6ArP2cw==
X-Google-Smtp-Source: AGHT+IFeNI2Mbjkr9XcnDXO2Q4cOqIufmkpHwtJz33bvQRqPwHsi8DQO/wtXDIc7tWGTmXtfqalBUA==
X-Received: by 2002:a5d:6da3:0:b0:34c:f507:1f54 with SMTP id u3-20020a5d6da3000000b0034cf5071f54mr2033108wrs.25.1714343474621;
        Sun, 28 Apr 2024 15:31:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17-20020a056000109100b0034c85919609sm5602534wrw.41.2024.04.28.15.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:14 -0700 (PDT)
Message-Id: <abda074aeef2ffb20d2156b5f24f47745b6f3134.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:31:00 +0000
Subject: [PATCH 12/13] Documentation: describe the url-parse builtin
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

The new url-parse builtin validates git URLs
and optionally extracts their components.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 Documentation/git-url-parse.txt | 59 +++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/git-url-parse.txt

diff --git a/Documentation/git-url-parse.txt b/Documentation/git-url-parse.txt
new file mode 100644
index 00000000000..bfbbad6c033
--- /dev/null
+++ b/Documentation/git-url-parse.txt
@@ -0,0 +1,59 @@
+git-url-parse(1)
+================
+
+NAME
+----
+git-url-parse - Parse and extract git URL components
+
+SYNOPSIS
+--------
+[verse]
+'git url-parse' [<options>] [--] <url>...
+
+DESCRIPTION
+-----------
+
+Git supports many ways to specify URLs, some of them non-standard.
+For example, git supports the scp style [user@]host:[path] format.
+This command eases interoperability with git URLs by enabling the
+parsing and extraction of the components of all git URLs.
+
+OPTIONS
+-------
+
+-c <arg>::
+--component <arg>::
+	Extract the `<arg>` component from the given git URLs.
+	`<arg>` can be one of:
+	`protocol`, `user`, `password`, `host`, `port`, `path`.
+
+EXAMPLES
+--------
+
+* Print the host name:
++
+------------
+$ git url-parse --component host https://example.com/user/repo
+example.com
+------------
+
+* Print the path:
++
+------------
+$ git url-parse --component path https://example.com/user/repo
+/usr/repo
+$ git url-parse --component path example.com:~user/repo
+~user/repo
+$ git url-parse --component path example.com:user/repo
+/user/repo
+------------
+
+* Validate URLs without outputting anything:
++
+------------
+$ git url-parse https://example.com/user/repo example.com:~user/repo
+------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
gitgitgadget

