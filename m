Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A30D39C627
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138226; cv=none; b=p3Gw3nmqaNYjgK1wsQvmIGTT4VWbPcVLeskudXDC78wO0G2pfdeUihcmZeMX9MvgX0FRzwlK7yY2Z6+YsS063dgBMmlp6LgFPh5a6oPbnsc+9ZE09mObbgYAf0T6xdZmPbkHAd4aDQ6l0sMsNJEPYz6j7OUBl8cXJ051kJpr6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138226; c=relaxed/simple;
	bh=XIwOUJ0Sa4+Ylj9/vXkfh2ZorletZhEQiM9N4Gkno7s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Wx/2Im8um1IXnC3zwRCDghV16S9XMbf8Gh6HRgtRzH4/xRYftL2DO99z4LKmoO0wLlvla5p9XjazgwHcrFUi4kevPcuQBusqNQKrHXBtyfSw+uk47u3NSioszS/we2xIs/OPDww2a0eVDEna0hyYIdigYPBiwKJ8XDQ7MTIkxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnT1Bn8w; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnT1Bn8w"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-124a1b4dd40so686779c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138222; x=1770743022; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOms57ZWc9q/TU+oQ+eMjvdkHW3FT3VGb0rtAPu3/Hc=;
        b=SnT1Bn8waV3BV/b/vNtPrxPMOxP3yJvT0zXKzxR3FU3aO8cBqCahktJ/2ClciQmCCD
         7IzIbtWPD3VVDmipQqX1n5B4GVU/1p0BE0gcGIk4VU5Gu3AJBdQ742LLitZad005unjK
         BKnLo/zIiWVJ2Xslg4ls5MnuEj+nAYQ2VEd5UzZLzd6vkuhkKEibY/rgaZa065yzJGf/
         oJUS1i3lj3KuUqQpZKE/q4Py0vi6nx5AhUBxNAPBL9UkLYCDWhEE3bQ/ZKiKSlPIW/59
         36hLNTVCpkojkgDY7gzY9peDCMYaenRYP2WH08AWeVswA4YY9Jvz+nEP8RvsjCnOaUYc
         553Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138222; x=1770743022;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOms57ZWc9q/TU+oQ+eMjvdkHW3FT3VGb0rtAPu3/Hc=;
        b=OwTVPnyodlLhEn/2c+F6RVxfEH5qP5h2NlHQj9cvNWcX9g7S59B/VcSU1iOyOF3RNu
         fpq6YrNZW+FrqYDSQArjzvk4NpppBqfnasbz+k9PVAJDYhcK+JAFaxBmHC6lEB7E+3hA
         gFiUuyZD5PInZNOKPmaZgGiiPZ0oreHbf97iqJTY7/xNPRq8Pz+pTJaateQc8EFEDspA
         +QouGPDNpmAn1Pb/Uvxl9tY4+ueCrPd56+/0WIHbZOsjyPCcB2Y8uDm9LPVpVSNKe+yj
         wsOpLj3uKC3mQ8jJ/0VXq6ONfeSlE+F/agjwZmM9LfWy7KHQa8d0qM/XpAb7cm+A7B7c
         p9Vw==
X-Gm-Message-State: AOJu0YzvhCwHO8kUGEOCQj8UUpAGshd9LV0QrPMXgp07/EZ1D5l/cyd3
	zdFJiVkFf+weFPlBlJ/Xie44OTYmKTfhm26ygtT7SQkDcqC/PomM7yOASztFrei0djw=
X-Gm-Gg: AZuq6aKA8M5bidmqoB++dWGHKtA3dysfBFdsh4lUbmuqsFSelMcciZPRQr3mcCrPVLn
	JkN8rwc/X9mhKxOV9Y6hxPne3hQjVq6LmXXAny6KariWIqc5eeUJebaSvaEvXxxQUz0O8vDeGNZ
	OznxF901HzyuX6go2Z62Sif6vodjsDaqCHFk0ZxIT3H85LN0Fi3XBPVriofYMjvS/BkvID0V6x5
	yATSxF6iEMRhF5cuqa0rRvNKB1n+vLGs6PE8PdWBdry/TVjvMoaGMYTepTD3P7+C+Bv3tFBt4Zk
	BKauS8zkMpYI7uUCoYxXxxPfDZKPf7jK1myJlpqqgUI4iDR8agUaysKZMXL1lLVU4EJnNBC51Pw
	Zjapq0L9oEUO9CQqLCp5hYSO4MHxaPa9Ot+kh8Ac04q/8Pm06fHqqY6/8FcFe3H2Y7YaVZYXRZ3
	pzRqF5OVYoy+o0
X-Received: by 2002:a05:7022:6182:b0:119:e56b:9592 with SMTP id a92af1059eb24-126f47bb0a0mr45645c88.23.1770138221869;
        Tue, 03 Feb 2026 09:03:41 -0800 (PST)
Received: from [127.0.0.1] ([20.169.75.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm22098233c88.9.2026.02.03.09.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:03:41 -0800 (PST)
Message-Id: <5fd9f6d41a67b36d1898b451f283d468f2f060d5.1770138215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
	<pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 17:03:33 +0000
Subject: [PATCH v3 2/4] doc: finalize git-clone documentation conversion to
 synopsis style
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use backticks where appropriate for command-line options

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
---
 Documentation/git-clone.adoc | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index 57cdfb7620..7a0e147384 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -152,7 +152,7 @@ objects from the source repository into a pack in the cloned repository.
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
-	When no ++--server-option=++__<option>__ is given from the command
+	When no `--server-option=<option>` is given from the command
 	line, the values of configuration variable `remote.<name>.serverOption`
 	are used instead.
 
@@ -206,14 +206,14 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
-`-o` _<name>_::
-`--origin` _<name>_::
+`-o <name>`::
+`--origin <name>`::
 	Instead of using the remote name `origin` to keep track of the upstream
 	repository, use _<name>_.  Overrides `clone.defaultRemoteName` from the
 	config.
 
-`-b` _<name>_::
-`--branch` _<name>_::
+`-b <name>`::
+`--branch <name>`::
 	Instead of pointing the newly created `HEAD` to the branch pointed
 	to by the cloned repository's `HEAD`, point to _<name>_ branch
 	instead. In a non-bare repository, this is the branch that will
@@ -230,8 +230,8 @@ objects from the source repository into a pack in the cloned repository.
 	name.
 	This option is incompatible with `--branch` and `--mirror`.
 
-`-u` _<upload-pack>_::
-`--upload-pack` _<upload-pack>_::
+`-u <upload-pack>`::
+`--upload-pack <upload-pack>`::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
 	run on the other end.
@@ -240,8 +240,8 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
-`-c` `<key>=<value>`::
-`--config` `<key>=<value>`::
+`-c <key>=<value>`::
+`--config <key>=<value>`::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
 	initialized, but before the remote history is fetched or any
@@ -339,8 +339,8 @@ Specify the given ref storage format for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
-`-j` _<n>_::
-`--jobs` _<n>_::
+`-j <n>`::
+`--jobs <n>`::
 	The number of submodules fetched at the same time.
 	Defaults to the `submodule.fetchJobs` option.
 
-- 
gitgitgadget

