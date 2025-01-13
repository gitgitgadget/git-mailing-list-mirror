Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF601D014E
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802199; cv=none; b=fiu5xovSHTQTgKiealg0Wd/ZS+Tk+eB2pq69aJw3bFlDvTwWiMSAgogreY5hYjoQO0OFX1Yo417mesUCm6bbb9/tN6FQ4sL6+QFwQZES5rewVykfyV9MLGuvZ8ulHJ7PThX3pxlDxXX91DmZNOXewX6QM3ETMg2D4k7UvOupbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802199; c=relaxed/simple;
	bh=n6B/fnMm5/pZFJMTbANDTvhi3S3pc5Tu6s9Km5HLfXM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=gUzZsO5KHmhvlTzx5ibuW/qpTFCrTsQXnawYyrOPv0KGRsJYt7KU5iObsliT5VcO8+lwOSMFkcohQ2o8GD3di0Mrt1/MfDCv+evkLGuKPAvSbUrpVtKh2VgtjA2VIogYg0AAOgt5HApu5bgt2gxfLlwNfwSCL2lfHWvB/PAkvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEzWL3yW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEzWL3yW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so45667015e9.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 13:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736802196; x=1737406996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fc89FESfCkz8dsFBweap+q1BpGYAxqZWvauAnmG7Z8c=;
        b=CEzWL3yWJvuOvQERN6EZ4BXyZqzAp+9akksigQiADDW5RctQ2LBoL/vMNR+imKopv/
         9YK6a2INKqx0xRw3VKkSpRnQt/WvGWVI58va2cwvWyClX738N/6X6Y+07Utjl9ye5/Sq
         ZYqkaCwIXYuT68nl+dRlEhkk/qS2OranpKg9djs734LZtPRpA7uC0vAek2i1cVzZ+5tE
         ta0lZva7yqO9pmkJ+BDIX0U3VjTh4RACVyxM0VVKijSJl6T8coKOraNexZpxVJZyaOyV
         WW6lcB7WlY5iGuTt9AhHPr0oEDSlOA+nefYXOtEKQWDHpc+cMgv1rZKUv+zsTj7oc8Vz
         KlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802196; x=1737406996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc89FESfCkz8dsFBweap+q1BpGYAxqZWvauAnmG7Z8c=;
        b=vCaGncO4c/Ra9+H62gozdnU1MYJB3MFy/Vgr2GTPYNDgzqVZw+7J9hP2AEV0KMhQSs
         XTTpUlByfsMohIIQq98HXnze4AQME4XcHq9HIeP5V8MstK2Z6chh1BX3xDuAvhJluhkC
         xphTVOqZHEK2mYppL18r1m1n0VIN4T8urYIA3RHVuxPBsD8O+Z0/Y4ZCTdPT7l8kqgmJ
         YhxMNvzOMfVDPDtyybI7nN11s8xyelfVqVBLcw2pw/ZF+pEUCAau/ZPslk8IZhVR7Wl9
         xbSolz+ydSmqYM0PhWEqtjsEyfMVN0eTAgPSYs1wFMjnI+FyThFcKR86zLXH5/JYYWKZ
         C0kA==
X-Gm-Message-State: AOJu0YwKMfV1BienZybKDqh+omMOI8FtAvg0koNtL38IGWNRxMN83SE1
	y0Q1ZgeMvGgEDi4kJL2g1uIde2dHG8FlxTajU0/5JvYksRryxd4t6f4R7A==
X-Gm-Gg: ASbGncsjnelvS7ud9SXAHzL3TCwMTyj3JHe+jrjGi47Nc/Sc1zak00y0pFXkFm7u7Ou
	+a5pfvsLihyQhZGqeXIok0rRaq0p7k4YGkQalNCpqCD9pNRNyAdjPul6xQKBOQFWLlTkTnPjgCh
	CKOfZ3G8jhO1OOFBgzbwZh0J+z95x/fOncQ4aa9UcbHUdWGs+85s8fw5lX2YSwfJkZPi1zEA/Ut
	yK2JD1bOY/dXsTB7iBbA3tPA9JOokz6JeW0RyWspvL8tGHLywRrfwMHyA==
X-Google-Smtp-Source: AGHT+IGdj7f8PPXO7kUiv84yBcz96qEsqJSSlhNG2El3E1hbtAPtv5Z/v+fi+fp22OQXTsYqYOwAIw==
X-Received: by 2002:a05:600c:8711:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-436f475f6a3mr82408565e9.27.1736802195820;
        Mon, 13 Jan 2025 13:03:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e89ca5sm188713275e9.29.2025.01.13.13.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:03:15 -0800 (PST)
Message-Id: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 21:03:14 +0000
Subject: [PATCH] docs: add vim syntax modeline [RFC]
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Git documentation is written in AsciiDoc. This format is easily
mistaken for the pervasive Markdown.

Add a vim modeline to help editors identify the format and provide
syntax highlighting, rendering and autocomplete.

This makes editing the documentation easier for prospective
contributors. This is particularly important because new contributors
often start with documentation changes.

An alternative could be to move the modeline up or down the file (the
location is not important).

A simpler alternative could be to rename files *.adoc. This would have
the advantage of being recognised by even more tools.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    docs: add vim syntax modeline [RFC]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1874%2Fhickford%2Fasciidoc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1874/hickford/asciidoc-v1
Pull-Request: https://github.com/git/git/pull/1874

 Documentation/git-add.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5f2c3592b8d..123c98541b1 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -1,5 +1,6 @@
 git-add(1)
 ==========
+// vim: syntax=asciidoc
 
 NAME
 ----

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
