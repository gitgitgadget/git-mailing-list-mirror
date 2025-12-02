Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56973302CA6
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719357; cv=none; b=M0VzeBZcrqxdfS1UJJcX9XqlOMtMhO90qMOKisKOWaxzDHfEU4SctdSQmAckl9mHQtB0RWvCnBdU3iHg2L0BSCfUagg6aK/0ai7KhzQH7/mdMxpNd9LzAXMZnc8bvGiQ/1ZUK68RRk3XqiXysv+mZ/YRjNn6AkLqVcwPcTwmx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719357; c=relaxed/simple;
	bh=XkFPnYdTnk5JEfNiIh3kJ0R2b+L45XgDgP/VHiPAA3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kiYvCbj7KG2C7tBhUwCombdaSm9h+16YkRRP+AbXaFHbqz/b5Odph2u69dqhlxXoEP6xBh5gKTZ9Wox8qu5npmfGndxCkscm2Jh4sx7XL5HHidRwx1re93cVODSsMvIftDZrSzlNkiP5cjKhcEIUWkTPWUHwUxlBUKpZeeKXFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8d1BmNS; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8d1BmNS"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2d7c38352so38541885a.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 15:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764719355; x=1765324155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os0T7MdRQxRYppLQfYleWy8xwIIGkZhsryw3OJv00x8=;
        b=T8d1BmNSqk84gLlUWyZA9O4oPJQxODEPScBJIycgErvkqhf6L7xavD0UVJeVGlDLKb
         erustui5fTx2xfZWHjTj4soBKuxiTEB4PZvXlWQV6M3mOE4I7exUBHQGkW1UKoG9rmOq
         59b3vQNoHsACn6YjBsdyiKrb94zR7VQsi1vpBm7z7jmrMSBU+eJZ9DVt1vUifc2o3qMr
         S9XWcecsI7UTzLaueb2M01zghM8dYSgU8ir1+bXN3teuoRCx3KxFJzF+UgNcmSDCGq0j
         MY9nEQVD+m2MQV+DIm1gAku+5xoo+4FCbbReCb/UtWHJ/GAe725yuXoadfGOzffCF8/E
         x+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764719355; x=1765324155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os0T7MdRQxRYppLQfYleWy8xwIIGkZhsryw3OJv00x8=;
        b=gE3tn3/Vo1BWAANrE5OYvr+usEgau5b3PwV+5A4RYVCC3HGUYsLRczId6B/DwfLUGe
         3/SzcysSyJ5uzSucNpu7UpiZcN5hFChDxeSc0WQUkyGDtdJd1WgbBClPVl5Wx+f2aElz
         9xTcXR8ONdJYzgWdNH/zNHFWbNDcfumHthtN5aVDtPWmIZTt/u9i1PhFhTxELV7ZEZpn
         HaFou1ZO3DR6QVUIy5zpRYYh3fTBVscSafEcXL2V/8acbf89TLEn5sXm4YXddL1KMMkE
         Ma1NxyDLfl08Y+MihN2z6O7xNEIK/ekaRrCNunPiiOgDVxPVyuYX/u3BRiGNTS//alpd
         zVeQ==
X-Gm-Message-State: AOJu0YwQtE7X05kxjtsV9EaBGd9BQ3uBIYDAXsLIVgpqX3hApNGpQ53G
	ByRhPNam/gO6zPwL4BAmjhWtJG/tazYcE9x0WLqDUnyx0YZazIv7RSlZTo8QPQ==
X-Gm-Gg: ASbGncu+21m7GFK0eAGUPezRwZBnnjYWXvzTakUsxWsG4fqc72ZVR0HbaZIsUJpWXQG
	tfEysbnOUZ/zCzktPJyY2dbLi9LDY5R1pYpLssUbZFW2qIuB/6FdxHPuPzq9r42S5NZesUFv5Dh
	znoIJIOiP2VhVFHiGEexofvwZGzPDXHY6TSaagIqMsBTUJzcblup5MuuNi+vN3gPXCjvLyVwmhK
	8bGhLHZ8qP4Oztf431OsJYT4BvAKwEGljIj+kEa/XWKwvg9z9W6hh3v5mP0YmAPXuNYhOAh3iAF
	9yGGj7vz/ZXH8Ym457PuqPICjjsg4lE8dHNquFuBxuJ4bY4YrmwoYeZvQJHrGhsqRJt9FoJC315
	RGa9FvGrg/mnJCJvpMMZKLvPJR47dWhYroExgtg/N5naXcXufvMwNecaV60Lby2dqXUB5Xk0CRV
	jKTpMOCVq2d0ge1g==
X-Google-Smtp-Source: AGHT+IH1YlxWIIBxcOnlG288fNiMzsNpNER907JxQTdwDJnFnQgMaSyhVYp1KBsBtytalNCuc2NGxw==
X-Received: by 2002:a05:620a:4449:b0:8a2:bff5:40e3 with SMTP id af79cd13be357-8b5e00f85e1mr70530685a.38.1764719354592;
        Tue, 02 Dec 2025 15:49:14 -0800 (PST)
Received: from [127.0.0.1] ([145.132.102.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993ca7sm1194756585a.9.2025.12.02.15.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 15:49:14 -0800 (PST)
Message-Id: <pull.2111.v3.git.git.1764719353631.gitgitgadget@gmail.com>
In-Reply-To: <pull.2111.v2.git.git.1764339945182.gitgitgadget@gmail.com>
References: <pull.2111.v2.git.git.1764339945182.gitgitgadget@gmail.com>
From: "Stefan Rieche via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Dec 2025 23:49:13 +0000
Subject: [PATCH v3] doc: fix typo in git-pull.adoc
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Stefan Rieche <stefanrieche@gmail.com>,
    snowdroppe <stefanrieche@gmail.com>

From: snowdroppe <stefanrieche@gmail.com>

Fix typo in git-pull.doc from "git --rebase abort"
to "git rebase --abort"

Signed-off-by: snowdroppe <stefanrieche@gmail.com>
---
    doc: fix typo in git-pull.adoc
    
    Changes since v1:
    
     * Updated commit message as suggested by Kristoffer Haugsbakk

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2111%2Fsnowdroppe%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2111/snowdroppe/master-v3
Pull-Request: https://github.com/git/git/pull/2111

Range-diff vs v2:

 1:  a4a2c58461 ! 1:  7ea5aabac5 doc: git-pull: fix typo in command
     @@ Metadata
      Author: snowdroppe <stefanrieche@gmail.com>
      
       ## Commit message ##
     -    doc: git-pull: fix typo in command
     +    doc: fix typo in git-pull.adoc
      
     -    Fix typo in git-pull doc from "git --rebase abort"
     +    Fix typo in git-pull.doc from "git --rebase abort"
          to "git rebase --abort"
      
          Signed-off-by: snowdroppe <stefanrieche@gmail.com>


 Documentation/git-pull.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index cd3bbc90e3..d3006359ed 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -38,7 +38,7 @@ or `pull.ff` with your preferred behaviour.
 
 If there's a merge conflict during the merge or rebase that you don't
 want to handle, you can safely abort it with `git merge --abort` or `git
---rebase abort`.
+rebase --abort`.
 
 OPTIONS
 -------

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
