Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191D2572
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483427; cv=none; b=O1Q/+VeGXwYp9stWR5RIcwG/MjmOkETgrTP7ItGXqtJH9JZolsyrlep5Il5NBfmkyRa0Tb1k8W6JKry6AXskqoDV0+FbhY60IV0J1QECFyZJcvwfMzl/nXB+eD5XoKYqt8qOpmNLOJSEJxv8muzt1/qjtTNUkywALxglvNmSxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483427; c=relaxed/simple;
	bh=uum8zvAr62s6lIhbZhXhBThOmZ+Wtqbnf51Gqx8YHY8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PStYrGupDS9OTuubXxyHco/2O1cNhANld9Z7xSi+xz+i1CvLcvcj/QcaNgh3VLoXsjgoz4GfxE00GZNJ2SF13egfcO3bQHNZb+C1fsWPN1xngMgL1jwCxUAw/Ib3g0wG22AVeJsNftNu375IuB227Xe7DBE3SB/aUmM7gpZni2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8YLmVm6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8YLmVm6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43634b570c1so30120745e9.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734483424; x=1735088224; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL4I5Mlg1zC7llXu0HKYq0ut97mBNnGYp3+Mb0nTHi4=;
        b=g8YLmVm6fxSY7dwlzpqw+3xy+kuTVlhMmCVNXZhPh3Ku34C8Iux2JXqmixP7B7+fbL
         Rmj4pEmQcNxJD2vUPzGz6LEISssTZkOZJis9A2cbbVFxQpX0mxlDVICwnbimnVMkYqCh
         TYU8xWfAqUhdnVqEIP0+XpXmqattMaOBrcBaN8QZMdIsH+WUYN9QxNJArZkDjwhPyvsQ
         jGm1+Zn9CqmtymLlaDScykL9xDlloqdLaBdNTzAtK139cnFvdI+9tb5yLm/vNNf0MVRH
         qdaSeDAKGL4e+JHh8291Daa+As8DIDyv1QqpEEMpchAfGNcbNkuW+xl1wrq77C4ClaBA
         pwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483424; x=1735088224;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GL4I5Mlg1zC7llXu0HKYq0ut97mBNnGYp3+Mb0nTHi4=;
        b=aAHG65u3UfwEdJrqYmHIZ2caoixbAQWSz/Z0QRsocEV5ikoD7/buD28m1WVWAxa2JT
         gc+n7z0o4YwqWV21LMcwlbe3MeBl/R6t0+OsmbIGo0+dqRDfBn38bEiFoM9GExY8ZkBF
         jqI9d1cteXhvUHfaXtCIZq49UzGtqWLZ2g6RCPfL4dZovqYGzJQ2NRwQFeLnBkCFDBV6
         SWZHP3LFfAv/zcJlpm+oMl5oKGcdE72mZYah84W80Chdtnrj5yRQ6zQF5pRxk3l37GeP
         KfboxxASyBf7jhPw1z2CaAHYvHS0zILz2fk9f2ANb5SWGHig0RIFWM0cTJVxZz6zsYj7
         /X1Q==
X-Gm-Message-State: AOJu0YyYblhKcXg03IXqb5EE4GlcPDNRkHZp8IwYn5I2BQODZTj4dSsn
	/cSOA+6C+F6HtuhWzYuxiziOnJvKz2z4Ujk4m+lhMNn9bn1i3m8Z/1Jaqg==
X-Gm-Gg: ASbGnctamNJ55q4H2iyTShrnUcehZaJV4WB3nEpzT8PjdaY1xCD6+Yed+4u7NpbTmhU
	rAXDhLqQQk/1uzi7fS/y/jQk6Q/rD042X+qLYHBgo93nI2eOivOZENxIkSn6Vt6F3NEHWfRLlv1
	D6OHT2hUEhIx6TrvdpEE5nVErdQ3Q8rONm1KjAAGTYu8sj6Kg3nmdoPun7TDEXbSS1vt0Tkw4Pz
	5OaIjCDy0yzJsfswhUBOzjHdU5yTZhsiW/4pkyhNdrda5d5MyaLVZ1BNQ==
X-Google-Smtp-Source: AGHT+IFsH6jjOKN3BhnH7GBWHrk8PCzV3sFl/qXGwz3eLQwi4nDBl6VfL6RnZLahayFRvwOMITQL/w==
X-Received: by 2002:a05:600c:3106:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-436553689fcmr5990225e9.17.1734483423382;
        Tue, 17 Dec 2024 16:57:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b1e8sm2804045e9.30.2024.12.17.16.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:57:02 -0800 (PST)
Message-Id: <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
In-Reply-To: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:57:02 +0000
Subject: [PATCH v2] doc: remove extra quotes in generated docs
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06) moved these variables from the Makefile to asciidoc.conf.in.
When doing so, some extraneous quotes were added; these are visible in
the generated .xml files, at least, and possibly in other locations:

```
--- a/tmp/orig-git-bisect.xml
+++ b/Documentation/git-bisect.xml
@@ -5,14 +5,14 @@
 <refentry lang="en">
 <refentryinfo>
     <title>git-bisect(1)</title>
-    <date>2024-12-06</date>
-<revhistory><revision><date>2024-12-06</date></revision></revhistory>
+    <date>'2024-12-06'</date>^M
+<revhistory><revision><date>'2024-12-06'</date></revision></revhistory>^M
 </refentryinfo>
 <refmeta>
 <refentrytitle>git-bisect</refentrytitle>
 <manvolnum>1</manvolnum>
-<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
-<refmiscinfo class="manual">Git Manual</refmiscinfo>
+<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
+<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
 </refmeta>
 <refnamediv>
     <refname>git-bisect</refname>
```

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    doc: remove extra quotes in generated docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1847%2Fspectral54%2Fdoc-remove-extra-quotes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1847/spectral54/doc-remove-extra-quotes-v2
Pull-Request: https://github.com/git/git/pull/1847

Range-diff vs v1:

 1:  c4f2acc9b07 ! 1:  89ce6212c02 doc: remove extra quotes in generated docs
     @@ Metadata
       ## Commit message ##
          doc: remove extra quotes in generated docs
      
     -    Commit <FILL THIS IN> moved these variables from the Makefile to
     -    asciidoc.conf.in, and in doing so added some extraneous quotes. These
     -    are visible in the generated .xml files, at least, and possibly in other
     -    locations:
     +    Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
     +    2024-12-06) moved these variables from the Makefile to asciidoc.conf.in.
     +    When doing so, some extraneous quotes were added; these are visible in
     +    the generated .xml files, at least, and possibly in other locations:
      
          ```
     -
     +    --- a/tmp/orig-git-bisect.xml
     +    +++ b/Documentation/git-bisect.xml
     +    @@ -5,14 +5,14 @@
     +     <refentry lang="en">
     +     <refentryinfo>
     +         <title>git-bisect(1)</title>
     +    -    <date>2024-12-06</date>
     +    -<revhistory><revision><date>2024-12-06</date></revision></revhistory>
     +    +    <date>'2024-12-06'</date>^M
     +    +<revhistory><revision><date>'2024-12-06'</date></revision></revhistory>^M
     +     </refentryinfo>
     +     <refmeta>
     +     <refentrytitle>git-bisect</refentrytitle>
     +     <manvolnum>1</manvolnum>
     +    -<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
     +    -<refmiscinfo class="manual">Git Manual</refmiscinfo>
     +    +<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
     +    +<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
     +     </refmeta>
     +     <refnamediv>
     +         <refname>git-bisect</refname>
          ```
      
          Signed-off-by: Kyle Lippincott <spectral@google.com>


 Documentation/asciidoc.conf.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index dbe36a52eab..b89bccf2309 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -21,9 +21,9 @@ tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
 litdd=&#45;&#45;
-manmanual='Git Manual'
-mansource='Git @GIT_VERSION@'
-revdate='@GIT_DATE@'
+manmanual=Git Manual
+mansource=Git @GIT_VERSION@
+revdate=@GIT_DATE@
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]

base-commit: 0fc57dec578fcc8dcda5cc3de6b81fa1f6719770
-- 
gitgitgadget
