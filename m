Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837530DECB
	for <git@vger.kernel.org>; Sun, 17 May 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049630; cv=none; b=nskgGfQ1RODPV4NRQis96xpJi2G4V7OYVDtv1V539EQ2AQNgsIcYU5Jfa8UYqoOmz0gep7nReoiSH4XWz/HmAHRHk4+zCOZWzFOJsRbELPuQH5rMnSIxRQMOE5XymrLnbpaDkA8TXlpS9hN7TDC1BFigsmbegohaEgEo7yOQeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049630; c=relaxed/simple;
	bh=mYiNQ92+mp/rAPmFex8Vx8HNVb4E0ZUgUhTueyazUXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=iQX2mjSl08bXhVt4FCLSGdfWBRvdm3eLPEvYDZKH3B8rWyvtloXvA0u4HHdr/SS/UzrMiW46ktDRIhpZk4I34M0Ont0dBUkZVZ/TnuHrE8LdVrHZciu4ZxEgYvM+8RVK2kJFFaUTdegj9aSeK0cHob8ylRWPSwcpTf/VNF7u888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9/czCHV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9/czCHV"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso22756181cf.1
        for <git@vger.kernel.org>; Sun, 17 May 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049627; x=1779654427; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhVltt7QM0TwLWHahbrRlQBoJrEUlEDdh4kP8ZpMGfw=;
        b=h9/czCHVpR/w/t3TJvlEiDuLzK+JG5EyqzennoXfsDV/lNfdQGHkbnfm2jl9SaFi3F
         eR/TOBhbIK6VXOaVR63IBpvjzXamGkPh7dLnwOnn9F6jGDz87xpXVNiZ4feV+prUO1fR
         2PnlqdyDdsPRdewOL8OyX76HL3/VFqC6DOmNlC3ClSeJd2uZcHTdgEODrRD8Eg1XU4W8
         hOq4K8aDQgxaRZBmpUMV0KDZytgOcc+AfAEKxXwps2Ov1GidlTrnYNKII3vH4ebvsR15
         rS9N+zS9WkGVMqxF2pEW+7pJOhYsX8uDCaywgOXL0f5zdpEmVO8SJHamjF2DXt2aNZxL
         TuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049627; x=1779654427;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhVltt7QM0TwLWHahbrRlQBoJrEUlEDdh4kP8ZpMGfw=;
        b=sime9deJrMDGYGr7l5jncVx5bFoaZfJQAPriKXcZLP775GbCcvRmQN4+1iCU9834AJ
         X9HXYYjC3UtMejoeGOIwgPXloxwHUNka4/fUik4p8W1bGO6sUEx8YckjpphPrXpfQSCm
         zwt8qgES+0/Yv4KX3D4sH2EJJt7GmR7Psank9tKcWqCQS/ne3ExrYam7abt3zDK8TQV2
         lFuA+TTHj6VbGRNnAcdDLAGLRdj6sCvcvt2rvRiBpOUPKGH1BfvTlAMmaamgiZI6HUdW
         2Z8K++1UGnYoNVqeWvDVZpd+T91SV5xZKgZqY09T15al/QMtHFV3TXT8jSGSgniE40NK
         S8Fw==
X-Gm-Message-State: AOJu0Yx+AE6sWxzJDPYm998KJ9EUKdfFQTvVLYnAHprL9thTomHiK970
	sRvFaekf5eK7SC8rzGRyAjYUNzT3xjmPYYXLRcAGpiGZVa3HGMjXlpUnYfGr+w==
X-Gm-Gg: Acq92OHVAahXn54CNdEqx6k4lffOqemuAj+LWfN7Y1e+2NHW0ITF6CsZPgmN0tb1MiX
	n4FjosnqwRnW4Foht4vsWo1EQ7uYYMNWw0xTnMYfR98aLGRVpWILNNyXsFkUHPtxh9aLcC5cwUb
	VMA8mCoLtLPeTsZLZCG55R+0vNrYp/GL/hNKRxX9DxvNnf4XpLoY2uC2UY1B1sKDg0JclN7gDPy
	woHxdmInrNuhCWXoq4u1m9JKosa+G2X41e+cFshehcY2ZvjeXfoPUao6zUI7OdsKrSD2O8xvaIp
	/WRqljFFHLwkYPrleHY1gkNlAWxolXQGYvBmGx0y8UtHgW/bno6AWyYSRUTx8fbuuXoWOTQdeFs
	y4RvifMguzt0sJHZvlQaxxYt/4C0f2btXpqKohUuYws0nk0XwWK5Ns5Uv+73SuyhNI/huMuH4UD
	Cwlc/jmkQciMA20mCgJLLA4QfyEI8=
X-Received: by 2002:a05:622a:6201:b0:516:4fc0:27ac with SMTP id d75a77b69052e-5165a1f4f2emr179772621cf.50.1779049627319;
        Sun, 17 May 2026 13:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d4esm109748461cf.27.2026.05.17.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:27:06 -0700 (PDT)
Message-Id: <dbe4d20b4ba1af6b9c874522787634bc4e0baa19.1779049615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 May 2026 20:26:55 +0000
Subject: [PATCH 5/5] doc: convert git-imap-send synopsis and options to new
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

Convert git-imap-send from [verse]/single-quote style to the modern
synopsis-block style:

- Replace [verse] with [synopsis] in SYNOPSIS block
- Backtick-quote all OPTIONS terms
- Backtick-quote all config keys in config/imap.adoc
- Backtick-quote bare config key references in prose

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/imap.adoc   | 30 +++++++++++++++---------------
 Documentation/git-imap-send.adoc | 24 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 4682a6bd03..cb8f5e2700 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,44 +1,44 @@
-imap.folder::
+`imap.folder`::
 	The folder to drop the mails into, which is typically the Drafts
 	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
 	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
 	the value of this configuration variable is used as the fallback
 	default value when the `--folder` option is not given.
 
-imap.tunnel::
+`imap.tunnel`::
 	Command used to set up a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set.
+	to the server. Required when `imap.host` is not set.
 
-imap.host::
+`imap.host`::
 	A URL identifying the server. Use an `imap://` prefix for non-secure
 	connections and an `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required otherwise.
+	Ignored when `imap.tunnel` is set, but required otherwise.
 
-imap.user::
+`imap.user`::
 	The username to use when logging in to the server.
 
-imap.pass::
+`imap.pass`::
 	The password to use when logging in to the server.
 
-imap.port::
+`imap.port`::
 	An integer port number to connect to on the server.
-	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
-	Ignored when imap.tunnel is set.
+	Defaults to 143 for `imap://` hosts and 993 for `imaps://` hosts.
+	Ignored when `imap.tunnel` is set.
 
-imap.sslverify::
+`imap.sslverify`::
 	A boolean to enable/disable verification of the server certificate
 	used by the SSL/TLS connection. Default is `true`. Ignored when
-	imap.tunnel is set.
+	`imap.tunnel` is set.
 
-imap.preformattedHTML::
+`imap.preformattedHTML`::
 	A boolean to enable/disable the use of html encoding when sending
-	a patch.  An html encoded patch will be bracketed with <pre>
+	a patch.  An html encoded patch will be bracketed with `<pre>`
 	and have a content type of text/html.  Ironically, enabling this
 	option causes Thunderbird to send the patch as a plain/text,
 	format=fixed email.  Default is `false`.
 
-imap.authMethod::
+`imap.authMethod`::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 278e5ccd36..538b91afc0 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -8,9 +8,9 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 
 SYNOPSIS
 --------
-[verse]
-'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
-'git imap-send' --list
+[synopsis]
+git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+git imap-send --list
 
 
 DESCRIPTION
@@ -32,30 +32,30 @@ $ git format-patch --signoff --stdout --attach origin | git imap-send
 OPTIONS
 -------
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Be verbose.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet.
 
--f <folder>::
---folder=<folder>::
+`-f <folder>`::
+`--folder=<folder>`::
 	Specify the folder in which the emails have to saved.
 	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
 
---curl::
+`--curl`::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
 	option set.
 
---no-curl::
+`--no-curl`::
 	Talk to the IMAP server using git's own IMAP routines instead of
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
---list::
+`--list`::
 	Run the IMAP LIST command to output a list of all the folders present.
 
 CONFIGURATION
-- 
gitgitgadget
