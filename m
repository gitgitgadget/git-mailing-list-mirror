Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF515E55A
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769202913; cv=none; b=ZhAGp7gU/xBemtgkf7jUIvGKf0LiJZblPXtNbCjqgupy40GlKc2pbmzg90gqhIqbCRGxdvMWXXyloesjbcygrK4bicqUnbXyuqjdbv7Y5hCgk5X+UPSXoQG+loTbflkUEdsH+fpKf2/Ca/TJ35GY8apImdC/efWZVMf+/7kgL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769202913; c=relaxed/simple;
	bh=4oCQV383JqWryli1a3Zkmdcx8T7b2nsXwkxFRoqd5fg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=fNHekzqKI14q1bESvRJpztUFRKcmC7Ypl14YKTuQD0MOTWcpKhKAwzqHq4W7PUDmIJnxQ0vkKycN+mBe6w2O+7O2VYPaKP3EiN953unajd8ohUZ1N+ogouj+uLDaydsWRWcbNiBkd++SrCVmx2cZz4U5/lLUCOHOxcYRWcU8xrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUmniWlL; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUmniWlL"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-502a26e8711so14589901cf.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 13:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769202909; x=1769807709; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZUatlVYQmchdq678m6RZr2UIaBwwzA1V2bH78z3eD8=;
        b=SUmniWlL/12+/BaZvyn+y892QopWOb/3RGes58uukHkuy5I/DcvNXwNPmw/rtODZ1H
         z0PfVl438AcS4Bu4096mmwlLrlufpFXO2HRTmTBZx2a2r6cRktJjZAS7brMRQoZnQvGR
         w1jQUuSke5KzCj7YfrEMIfvYGINjDPOTDmxgzQtpbPPJkse3qMMZPDywnlZxoTBCjjoN
         zRbZKEHAsNdg56cMtd4TGIk1dxOQMf7X1sqyj9gP1PGv1xaMv5bH5Ib6r0/5uS9e0gf2
         lboUatZ+jjvsJIOF3PberWGXE/gikAr2Yi4Qi9iNmws5Rj9gAbFufjSesxt9ddlvj0l3
         NcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769202909; x=1769807709;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZUatlVYQmchdq678m6RZr2UIaBwwzA1V2bH78z3eD8=;
        b=bfvF7WyD1KJobj/WPOWbCN5MDDNHxpdIRpLLP61AMTYiEwrkELqB5XiduWDh2ZOo+K
         7cRFVow5Ux1249pCUhykTV6tywKSuucgJMdqVYyVHmF0WO7k27kZXKdCrN3BCL36vXyk
         3TWgzMDFX92jV2WPkpGNEa2yFQO/QeqNQOPiiCST2BdHmYFVvgWwP2r5TqPQiM0Myr34
         +YxIZr7Kf6UIarsNP6s6NSBgQk1wUJ/cZI50TkoS0QF95rUh1LT53yce6VFhE4AKsJZQ
         Xo6tXYaTVflE4YRbHcblx13E4LWlLCN6vDEvZ/TB1/0mqvVxYPx898Acxsy5G5b0AIZh
         LToA==
X-Gm-Message-State: AOJu0YwE4od86zcOXqL2eoH6otH0C4Qq7wPl9AHQCprXWiMp7fimhVNN
	XmFSb2ZA7heS2e6TE4NXVgkbOh/oaoZG6UGnK/BEKV/4xwIGLCwrJJdF/3+d1TIihY4=
X-Gm-Gg: AZuq6aJaFw4dgPnraog60wtO1BqB1QzsPbVg2RU/iLZTaOawsHKz0q+8IOxgqqwpNSK
	EM9nKnSMZ6EP75vxv07tsKe+bLWWGIpYJARPe9kZuHsyf8yAps2XE92gG0rlArBm0u3dhORD/Zc
	Pws468Z2ksO248zvzKxCZbUO0K2FMRlaDSQaVyBDvUdJwShVXOjbKfnNFjkHfAHtFnzb5oQ7qQh
	Mxc/7gq1o2I80WGtHcgX39xoTlZ5Ru8eX0t/8vEYFoeQmcq00SRuMDHuVHx60Wq6ntyIBO4eu7P
	K/042K9Ob5yP+3wQJ9qn6Cy7mmP1SbOfaAlfVXZqErJfMnY7F2KR8PmzH0/UhUTvBStmphkYEHD
	JDUqPrQpzi9LWJFQdypxMQ6KGjldNHzxwccB5TocTkcSrVZDaKLZXC85+1ShYh4KOcQoXaUh+KA
	7Fl5jZpEhngqmwBSo=
X-Received: by 2002:a05:622a:341:b0:501:51fb:622c with SMTP id d75a77b69052e-502f7741553mr59298621cf.37.1769202909233;
        Fri, 23 Jan 2026 13:15:09 -0800 (PST)
Received: from [127.0.0.1] ([172.183.133.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7f9c7c7sm29926551cf.31.2026.01.23.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 13:15:08 -0800 (PST)
Message-Id: <3a5b642d05b9fcafb684631a0026959bfc362d2b.1769202903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Jan 2026 21:15:01 +0000
Subject: [PATCH 2/4] doc: finalize git-clone documentation conversion to
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use backticks where appropriate for command-line options

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
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

