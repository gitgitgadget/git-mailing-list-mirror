Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFF36C9E2
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559818; cv=none; b=hNUR6c3GgfsVGj3SIC1DBiJA0R/iNyHW5mE8Gps01aad4Op6zKHFXGRgrEWR0xBtT0rLLhHVtOe8HoV/WwtWfJ2d2UyTdctv2Y2x7Iubb2T+QkdwdR/PJh/KUzC5jUTjbFpTbbAh5YpEO/BnF28I94urd2Obw326mTPXAvbQJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559818; c=relaxed/simple;
	bh=hCmgvBb+EUoQXw2aIQqWVn/VDLMucToKE7VTKb9/ti8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MB7htT0ww623aiOMNMXEX6b+WTIULD+Gr1u5jA2tIvePUVJoO8IxBH0zeeUnasDzL9OoQic8SBhjZIFsT+J9KYsk6srBIGtuVLaTY8JFHwrFdTpYYvMiZoAVDxK8W/v5CMzBn1qUgRCq4gO9bj1NJFO9ON2O6WWl0QD/9rnwi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUmsh9bw; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUmsh9bw"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be1b5fe11cso2092487eec.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559816; x=1773164616; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+KLo///wsGFpqswXIJ3y5T0qwiXJ3wXYcahQjiwcvk=;
        b=kUmsh9bwfdJ9rmUMcIN+bYCM0k8lSrbU+iPR2yncpGj1sVsgXgDDWn7vA9+UJoP1jv
         LX5JLwUEirbYMUO2F8E6FPy+aVcjXF1lDggsVuBOdsW624VCvebUI/cOu2ydNGsP+TZ2
         Fw9j1ZMY7JgEWc2KchMqu9uB8YE9OZUj/rY4QG3CM/PxlLrDlHQhLu+XzmXZVwi1nvw9
         2mKOQcYOMXK5TeZmTzr8YSqcl8Ae6/Tc3iiqnq/d7XhcYE31yk9QW6BmD5oj7A5QB0gJ
         aw/EgLqm6x66O9i/UEoBAeaSH8GuRQ4hWh8hf/IOdwQHt8LNfeMwl34l/eKl7WcDbyzC
         Cu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559816; x=1773164616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+KLo///wsGFpqswXIJ3y5T0qwiXJ3wXYcahQjiwcvk=;
        b=aL9hnLyZeAo5sONnO3/UbhU4GMtfdLY0/1dFZE1+g3skdzeCavynjC8xrrU2cwd69a
         bShSXZv3tU2RsuWKXGBYyweYrIZ38VKVSvVtXOOZzRW8RSvgW6tEV/hbM4MfQvmXbuOE
         6DXAF3JVj5X18Ii0RSFiEcKDv6vde3jMTPFW4jJEG4K2ev0Jcb4mtgTy1mFFeLabobik
         ENg1d9KqzgOrnP3D8DEdIb2DBCXtA1PV76mv+sF7aDtoeYYs3KNLA46rJWjUDAy1KuTp
         UP6bD0D6xYERhy1+23rp/uxB5LRs6DCbiOrSe/51vwcJPTomSzZtEvFOcpz81d+RvnX8
         k3fQ==
X-Gm-Message-State: AOJu0YwqtXDiD5AyxieLla/TpNJX5XRxF+c1JJ2hppCoK1nSbxutoMV+
	dZ4vo8nUIkNaIhWrrwV3KoeptrQjPusILGwnBXx/FW2rSLmwSjCLxm8znnUguA==
X-Gm-Gg: ATEYQzxaJBSUG5vNJfceGugrDak8yUmfxcN+QD4us7AuMAdnPzvqRGzzWQrBWAhNJH4
	jlnBfvTeuJsBlFzXgRPEr5x191B7pPogAyGbiCk2q81uQOb72+fR/Rx991BD7QE9U3tofAWmojZ
	eHx9zyxvjJe5DHrA4DhY3tr5igpbvFC4ewqHgha1Fp3Dv6dquST9p90nkcz7D2eEQbFIk7/6Nk5
	Cy0ZICXD8seJV5zFhcj8BHxXj5T0DuId+xJjpvyiCxM+SXuoekhAq25DTEf7uyIUmcUYFW4c+Gk
	uukp5B5Zk21A2cxeWF6xMuEqX+mbMZ34qgDoWaaGeWlseBgTkLidB3RFOjUNlYcSWWYzMPhoDbT
	60478EEVzuy3EP5CwX5CvLfFXqg9I+e1hYTTxLBrtxtY6fqQhRhXYH/y0pc7yhR9X+7O3pMWbva
	pWsArNwBrNnOHnmOtJtmwIFI71ZQ==
X-Received: by 2002:a05:7300:538e:b0:2ba:964f:fa67 with SMTP id 5a478bee46e88-2bde1d056a8mr6600870eec.24.1772559815680;
        Tue, 03 Mar 2026 09:43:35 -0800 (PST)
Received: from [127.0.0.1] ([20.171.123.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be21dc44fasm2013437eec.25.2026.03.03.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:43:35 -0800 (PST)
Message-Id: <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com>
In-Reply-To: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
References: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
From: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:43:33 +0000
Subject: [PATCH v3] doc: add information regarding external commands
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
Cc: Omri Sarig <omri.sarig13@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>

From: Omri Sarig <omri.sarig13@gmail.com>

Git supports running external commands in the user's PATH as if they
were built-in commands (see execv_dashed_external in git.c).

This feature was not fully documented in Git's user-facing
documentation.
This commit adds a short documentation of this feature, making it easier
for users to discover and use.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
    doc: Add information regarding external commands
    
     * Patchset V2 have spaces instead of tabs in one of the lines, it is
       fixed in patchset V3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2220%2Fomrisarig13%2Fexternal-commands-documentation-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2220/omrisarig13/external-commands-documentation-v3
Pull-Request: https://github.com/git/git/pull/2220

Range-diff vs v2:

 1:  02841b66ea ! 1:  f90ad791d5 doc: add information regarding external commands
     @@ Documentation/git.adoc: System
      +	When a user runs 'git <command>' that is not part of the core Git programs
      +	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
      +	in a directory on `$PATH` is invoked. Argument passed after the command
     -+    name are passed as-is to the runnable program. These commands precedes
     ++	name are passed as-is to the runnable program. These commands precedes
      +	alias expansion.
      +
       The Git Repository


 Documentation/git.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..903d11c530 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -487,6 +487,13 @@ System
 	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
 	otherwise `$USERPROFILE` if `$USERPROFILE` exists.
 
+`PATH`::
+	When a user runs 'git <command>' that is not part of the core Git programs
+	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
+	in a directory on `$PATH` is invoked. Argument passed after the command
+	name are passed as-is to the runnable program. These commands precedes
+	alias expansion.
+
 The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it

base-commit: 2cc71917514657b93014134350864f4849edfc83
-- 
gitgitgadget
