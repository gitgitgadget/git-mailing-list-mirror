Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1722FF22
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860098; cv=none; b=joa47FPWkUrLu89P0jTAxU6I+iDtxQtvqsETw2fVYv7rxZ0t9ATy8ZD1aBCx5E+U5stnqah0GWVHo7kT5yzoMZH1fedUeQ4f9YZVFXWtnd7H1BN/QXD9N+Tlisto+yqYnq1fTRB+s7nZLVu5fO081l6X0ohpBBh9eZdZemKj9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860098; c=relaxed/simple;
	bh=ssQFIe5KKg6DfkgSsrozTAVWroKKQ1cLWdMOeb/OMpM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oviACwmLNB86y5fxEfB4rUdQYzO9RS2BT8ACYsGzLZbVywR/VgcRGouBKuokiJNT0tUHQIXS4LQaXt33to0hTknX8WVvIm6zmy5TtQMKXSa5xu/zDXa+sCYu7+vFeAS5Db6UV0JnDizPYNeabCKXSEFLD22jBnF8ep+USKTRoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ph6813uY; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph6813uY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651c366f7efso12363947d50.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860096; x=1779464896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7UNZDZysCaZpBioM0hKZ5jhZ+winuvp2IdRz4Mqv5M=;
        b=ph6813uYspjANjfS1OZxruDRsoydUG54FG/TDLwa9/AVyaKcvYzv2Nf0filJ7RLMYo
         5ve58O9cEROPCGrd3QlHdVvwhsXh+4MOuKK0jhlNE0z3umwmyTG3hwpJi+a5qj0a3yvT
         InOytKTncyYeGQVcuXLEDk+5LSNr58SlbuUCrIYl6II2bV5F6twH9eRnzs+bFib8Jhnv
         Jnhk/KnPlSsRODDVYPy8oB8GjqH2ubDRXPAFaWK9xNIeQnZpjk8T4bxQXtzS3VIEM2/v
         wQgIjfc8qL/irF1DDuf3o0MEp+ua00Mnk4HSZVowc78syLtwf68hfsvvrffEzx4+VD43
         uEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860096; x=1779464896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7UNZDZysCaZpBioM0hKZ5jhZ+winuvp2IdRz4Mqv5M=;
        b=ihyn6z0Cj0SuxaIImRN1Gx59TnfPQ0dA/Q8odGYFBOf71ERdJp+16x87bXq2muCc/t
         KHLydm+i6TjauWmTnMKwUVdvduIGBA/aZvkPi9k9uGk5/d4nvcNFM+l+jVlU54Y3Lxxl
         LvjPWefCUs/a0u5p8t57TiNipvi988YdWttSv4N5o+FwoufjzcqBqrLJewwkpLl+NGIZ
         YIZ8Jr02WsxlFRqYAp+WMnVkUEe1aa1ISGqlzhNc/qdEcV1OL0z/hbWdwEhK9KdmTl34
         ufY9iWz+JQ9atL9tsYdLhVW5Gx9tWmRISk2tdBumbv/vTIG1X0RJ/5Es3ocdtQ9rnk12
         9kjw==
X-Gm-Message-State: AOJu0YyF9BciB11ZoFUq+1tUTPV/BsxOYvhXVa80B3JnTotN6VfiQEKW
	TTyU1bE0nZ7UD+1WHM+cuYWOLaJbJsamxGxKmYUrzg/LtHXnIgiBy/lPYG9MKA==
X-Gm-Gg: Acq92OGq6vwJN+LULtwvLc4XEu0kWmic+EBd4K7gmjCC8iMrcWSzRSYNpkgNusW949w
	cqLxkqGo2jRAUF0J3bxu/JSNGeoeQEvylXSHX8NcqbvhzzNq+pRZ7QU8wuHY13shtOXORC/R39z
	tD/gAkz2gDvmqpc0AC7lfMbrFb1X5FynXZcnNYH7iwgObcQdyakwtRNwpvD3wBftXS3odKo1rxC
	fqttxhEQctb6oOiPkMghHXF3KHaw7lP1Xiw5vBGfI+jfyWj5vuq7CVXbsieWh73o6GRHzuP+nR1
	n1TMBaj6XOvP7eO4qcTMJxn4lAv7gAUWjiQNrW4cxlZpRy2CO7csGuXXsJ8NP8Fp8z3o09qyqFs
	amIM3qc9KTM6t8f2SbZJWW7Iu7LWRIEXxcFfm/M36eM4nSGtH9B9sNpSbXUBJ7zD98IiMoEytOt
	D6w4m3LeVKs5XUHStdBow8o3GTKmdrVBq7eQ==
X-Received: by 2002:a05:690c:e3c3:b0:7bd:8ce4:92c with SMTP id 00721157ae682-7c95bd18fa4mr46861107b3.31.1778860095560;
        Fri, 15 May 2026 08:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.59.242.4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f28b3617sm32022717b3.13.2026.05.15.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:15 -0700 (PDT)
Message-Id: <6c7d5c5853d5e36a0fddcc403c5be66f51517c00.1778860091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
References: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 15:48:10 +0000
Subject: [PATCH 2/3] diff-format.adoc: 'git diff-files' prints two lines for
 unmerged files
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 10637b84d9 (diff-files: -1/-2/-3 to diff against unmerged stage.,
2005-11-29), for unmerged entries 'git diff-files' print both an
"unmerged" line ('U'), as well as an "in-place edit" line ('M')
comparing stage 2 (by default) with the working tree. The "Raw output
format" documentation however mentions that all commands print a single
line per changed file. Adjust diff-format.adoc to also mention this
special case, for completeness.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/diff-format.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 7f18c64f1e..43d91ef868 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -19,7 +19,9 @@ compared differs:
 `git-diff-files [<pattern>...]`::
         compares the index and the files on the filesystem.
 
-All the commands print one output line per changed file.
+All the commands print one output line per changed file,
+except `git diff-files` in the case of an unmerged file, which prints
+both an "unmerged" and an "in-place edit" line.
 
 An output line is formatted this way:
 
-- 
gitgitgadget

