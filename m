Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3059262D0B
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784490888; cv=none; b=IQ1vyOckYC/Zm8FaUcJb0LVgrnFRvqFBav1RBVVm/aofJmaFXPnqXE3kG8sMhDlUDt6BxJcutEa9i6Qm8AUma8wCrLkEHCPgv5++LpyMG3puis9Z4Fa/diuCBoq6mT/h3N0ZzDLeZjZ4wbiJo0RM47n6Tywt1ODYcRL1psIW/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784490888; c=relaxed/simple;
	bh=9O9yQlpcx6not+iZwmV66lL4zydSBV4SEQI5zgxOJjc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=WwphbM4jhx5vA6SuGyMPy2z5qzvGeW628x7QXYoUaIytz09x8smP9tBUQC00oenVXLRQhN1T2MX/+dK6pH8CWS1RoYyLDqhnYQSqB1HFeMcdzxEXqs0+jDtrSIKKR9HcYk7hmM9SPuaSGpplnG9I3jpii9jTnJT3xrPFhUatLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF8N9LoR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF8N9LoR"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e57a753f9so845001685a.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784490885; x=1785095685; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnsDbp3vK2MNsrpcJIkFQo5EgFTEoBy3k36xGY3QpoM=;
        b=cF8N9LoRQ40ur5uWqIg+uJ8g2lY6rMzKuyH9FJGAOhMEnxVxCvJLuIJoCD3ci0bwjX
         f1C+r/lwTB/mTBxKyblkvdZRs0wDPP18BF7XAzoDZTRUOu+0CFAy6NikyJMS4sI6Cc4r
         f74YLIWE2bhq5cu/ahsb0/wKMmc6KDmOV9ES93JJ4bulRuQOD0SIWyKEaBamftQ2Ljty
         rTnE3QYBl2cIrORjwHGIEdUvfY5luARAC+a5MRUDfzYmd+qk2CPZ6+r//3JDIHlVdfpj
         YDwvByaYIcG488wdsjNnGI4/jlgjJWO+88huqbuLGAUrmo5xzsBWa+MBnZnWr59Etb5k
         pNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784490885; x=1785095685;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnsDbp3vK2MNsrpcJIkFQo5EgFTEoBy3k36xGY3QpoM=;
        b=W3tG6bjDVm0ywqMyvEUe2hou5spVTJsiy81BtC6QHBLTsJggLQtE+yE+PXFDJxNEEi
         afr3WcRiHGj0YJOaAILLdLaxM5E8EVGlPQVpHJGLNrmx2f59JjbPamm+yG7UteXJpn57
         EB0Eiv0/z3nCnH2T5Mdk3KhJauMqYBJhcUSyGD4yeXH8at1f6iwmKj5hj1D1l4p0rDQD
         aEoKqv4K9x2Dbo/j713aosDKRfF/l7LX1VaCtoUAU24ITONFp2WjU2O6bTzho+H5vggW
         0kwshO1xw/Jdc+DCm+i3FLdrv5r7v3cNu3q1NOenv3hk1qylFBkJUafMQRSKEYGNo7Lp
         hYaA==
X-Gm-Message-State: AOJu0YzpIkd4OwfTUozoK1p73QuYysC80K2jkTzK5JCkfG19X30JVqaM
	V7h4scdGFj7jRt4sx30RK1OmSqtQoqp+GRRP70oNQupRCd8mbaURWM/PM4Sf+g==
X-Gm-Gg: AfdE7ckrrIsKckezc87dgA1pfY3KqXDwU3rQbawqqJrYcE/rRASTBhwuQWbrlRvNSW4
	NQ4OOgaGXP6WY3ey7u1jvAwNO8XUyskoDIJB4/jjtmHLJ4JjDZUh5d1G132GKW7gtAPvdct6geG
	H904FvE5iSN0x4RrbJr8i6iV97+dM650TWyb1MTphtZqCoooSWP4+iDoTKUMx8H9KfLPMaZe8mF
	DFdG9wGIdeUmZVIaaQ73Bi0iMPoLLZy2zqHvd3h75e2aWQLMm9YEsJ3AtOF67yS07TibvjMFcNk
	sLQMsIQ6BQ5KVjtoexKCCzGUP+a83fr9Sd3057phf4ZjxwmsQESCyMx7aisHIsx8KrYPxDgikLu
	oLYXQocZk+7JTxnY368XQrxWguX+l6wohh3ONNXPEdjuuDLT8E7wr+3LHt39n87y6JhxtSiV2MP
	v7Ls8=
X-Received: by 2002:a05:620a:1a13:b0:92e:541e:632b with SMTP id af79cd13be357-930b3eaaa92mr1269582285a.2.1784490885531;
        Sun, 19 Jul 2026 12:54:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b543054fsm707089185a.30.2026.07.19.12.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:54:45 -0700 (PDT)
Message-Id: <5b6e9bd3f3569cf9977d1cfd120a92756ec86b29.1784490878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 19:54:37 +0000
Subject: [PATCH 4/4] doc: convert git-request-pull synopsis and options to new
 style
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

 * Replace [verse] with [synopsis] in the SYNOPSIS block
 * remove single-quote formatting from the command name
 * backtick-quote the flag
 * use _<placeholder>_ form for positional parameter terms

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-request-pull.adoc | 38 +++++++++++++++++------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-request-pull.adoc b/Documentation/git-request-pull.adoc
index 15dcbb6d91..8b6642b312 100644
--- a/Documentation/git-request-pull.adoc
+++ b/Documentation/git-request-pull.adoc
@@ -7,8 +7,8 @@ git-request-pull - Generates a summary of pending changes
 
 SYNOPSIS
 --------
-[verse]
-'git request-pull' [-p] <start> <URL> [<end>]
+[synopsis]
+git request-pull [-p] <start> <URL> [<end>]
 
 DESCRIPTION
 -----------
@@ -19,28 +19,28 @@ begins with the branch description, summarizes
 the changes, and indicates from where they can be pulled.
 
 The upstream project is expected to have the commit named by
-`<start>` and the output asks it to integrate the changes you made
-since that commit, up to the commit named by `<end>`, by visiting
-the repository named by `<URL>`.
+_<start>_ and the output asks it to integrate the changes you made
+since that commit, up to the commit named by _<end>_, by visiting
+the repository named by _<URL>_.
 
 
 OPTIONS
 -------
--p::
+`-p`::
 	Include patch text in the output.
 
-<start>::
+_<start>_::
 	Commit to start at.  This names a commit that is already in
 	the upstream history.
 
-<URL>::
+_<URL>_::
 	The repository URL to be pulled from.
 
-<end>::
-	Commit to end at (defaults to HEAD).  This names the commit
+_<end>_::
+	Commit to end at (defaults to `HEAD`).  This names the commit
 	at the tip of the history you are asking to be pulled.
 +
-When the repository named by `<URL>` has the commit at a tip of a
+When the repository named by _<URL>_ has the commit at a tip of a
 ref that is different from the ref you have locally, you can use the
 `<local>:<remote>` syntax, to have its local name, a colon `:`, and
 its remote name.
@@ -54,11 +54,15 @@ the `v1.0` release, and want it to be integrated into the project.
 First you push that change to your public repository for others to
 see:
 
-	git push https://git.ko.xz/project master
+-----
+git push https://git.ko.xz/project master
+-----
 
 Then, you run this command:
 
-	git request-pull v1.0 https://git.ko.xz/project master
+------
+git request-pull v1.0 https://git.ko.xz/project master
+------
 
 which will produce a request to the upstream, summarizing the
 changes between the `v1.0` release and your `master`, to pull it
@@ -67,11 +71,15 @@ from your public repository.
 If you pushed your change to a branch whose name is different from
 the one you have locally, e.g.
 
-	git push https://git.ko.xz/project master:for-linus
+-----
+git push https://git.ko.xz/project master:for-linus
+-----
 
 then you can ask that to be pulled with
 
-	git request-pull v1.0 https://git.ko.xz/project master:for-linus
+-----
+git request-pull v1.0 https://git.ko.xz/project master:for-linus
+-----
 
 
 GIT
-- 
gitgitgadget
