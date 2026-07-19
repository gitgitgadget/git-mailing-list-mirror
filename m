Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C5298CC4
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784490884; cv=none; b=GfJ1ewfISzUwEv7gBsut5f/Ngv8I0RJy4mIrcy8N4colAsf0aGz4XS1JZOfRql8NYcqSv912T1pND/+O6vQ9e92P99y7Wk4KPGIbaxEHLskeikc7FQVi+MDTqREeSUgUmhxQW04AriFAKS3cn4WRbmp+QJGrIVFzqbrED7eoguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784490884; c=relaxed/simple;
	bh=Jwt2v05QWYYT1cLPV/BDNH16Xb3QXhWudmgH7aAakK0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JIO7e4KsQQFHGmBxR9t8XuXpSv2UfPyytm9e/nF2TWiHYf4eY6kSYW8Eh/k/oYhN5iRfa+2pH/ArNeKtona2hpT529Gd8/217JsnHOFb59otBwOO/Op9kkXmCjoohSYk5g7xKWtdS3UayNwQE4Ho49ZrmqOA6NGAzisk1VmSdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkvK19/r; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkvK19/r"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c21495722so67173151cf.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784490882; x=1785095682; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bFFXtLqJ6swV889PXoDOLZ5EMfLMonrdzwIHaORE4YA=;
        b=PkvK19/rd4oMZqYgFptv39UAbmY+RIk+eIGDR5v2uGttlnaIhtqYhFxpl58p+YQy1a
         lpjKnRuKR0WBI9RMW+1xSa9HkDu2seDGMQErvCfiJD96PkKB6PsHgE0Le2yBXeXMZWyH
         BvnqIixJsDyQkY7E72+26L2VFInrm4AkVQeBXX/9B4hEH8mGQ3k5GyXz2bE1mwR6WQZs
         yO0kCUhwFl9cPoQ8VIUqGDw0IhDeZNys11yife1ujaXvWR5jB5eba/jV5/GEZ0JzmNLF
         No8ediOMCYffY1jxlKp0PS3U6yS0MzqDvkkAoiRyAQ9XBD166K5Fa0NaCr1H0Ek/0yvr
         b8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784490882; x=1785095682;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFFXtLqJ6swV889PXoDOLZ5EMfLMonrdzwIHaORE4YA=;
        b=MxXXjzgkBEKfW0zPZRrmT6lc+lPD/y+87vWZ3XTxqyt0RUGmXECAo6yvZumFEBGc4m
         yGSWL8AQBX/ipx88uYAX1RcwKdg/ytFWG19Mf44ErjkPBdi8BVye3wjnLlaIe0disOLI
         76vKN40yjjgrkC0HTrD31jmz734C0hgP5elyyfUDoIMVXkfm5zD1MPN2FXv9XErVWkw4
         tk2lFRe/hKNjg0qRjhyhW43qWA+l33EHAzsezz7AzzfyTRyf7bbMaEhX2qX36mL2wACL
         EG0Cws35GFX8dvAVAlK6RoBwwDvTI58a7gqZvsZ501cAXa0srpiYg/LpGcfJHebcBdvI
         r2jg==
X-Gm-Message-State: AOJu0YxTCECcyNJ8a5vCUH6o9/+ahZsW7eNZ+DS880k7htTsJt3bIrSu
	FuirJAAkCczz9qaxA0y3Gw5IMH5gY8j1CKCts/DexWRnT3mia35qL7NSYqYWyg==
X-Gm-Gg: AfdE7ckD5egzNYerfnwxGJTCyxSsglr12Vl/i9hsgiFW8AZ3hT/SY6oOyT2+r87epdo
	a1/lP0Yi2bIs78U6AzZRlscCCFfhbFpeD+ozVPp0cV+xvtGa3TTeKM2wy1FV3+Ao1WO/mdjmXDw
	q+74vlgbuRQ4xHVFE5A3riUb+hBkb1Ptnhugy/g5Iwfh8/TfcVwgjsKN4u1kYtbJ5kIeqPXHwh0
	faTCb+vRePG9VrCbcJVjSmPAlCGaD2e7amv94TvgSsuUOmzy9ZiN+znlaDLzR7q5JNXqZnl2pSK
	QIhTmZpQz90e52Rrps9wSS2CHu+yyW3UYhTMLey1p1cTRmGXYoaiZ8vcUeVg0eZCtK6ppQY+q0y
	J0IVwiMLzRK2ceVqUsxcOMDBAfQJ3TpW42OrxMrU7RBhA59CHmj9aSuWyrKEHWug0NaG3dqLRj1
	TXYzo=
X-Received: by 2002:ac8:7d52:0:b0:519:dfd7:70cd with SMTP id d75a77b69052e-5213e082527mr109781001cf.49.1784490881918;
        Sun, 19 Jul 2026 12:54:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.20])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f504892sm58363951cf.20.2026.07.19.12.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:54:40 -0700 (PDT)
Message-Id: <798c06439015b3f5056574be4eaf09ef71f66494.1784490878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 19:54:34 +0000
Subject: [PATCH 1/4] doc: convert git-imap-send synopsis and options to new
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
 Documentation/config/imap.adoc   | 2 +-
 Documentation/git-imap-send.adoc | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index cb8f5e2700..6b97776bc3 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -41,7 +41,7 @@
 `imap.authMethod`::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
-	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
+	than 7.34.0, or if you're running `git-imap-send` with the `--no-curl`
 	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
 	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 538b91afc0..dd1e0a3718 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -192,7 +192,10 @@ supports only `XOAUTH2` as the mechanism.
 
 Once the commits are ready to be sent, run the following command:
 
-  $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+
+---------
+$ git format-patch --cover-letter -M --stdout origin/master | git imap-send
+---------
 
 Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
@@ -217,7 +220,7 @@ users may wish to visit this web page for more information:
 
 SEE ALSO
 --------
-linkgit:git-format-patch[1], linkgit:git-send-email[1], mbox(5)
+linkgit:git-format-patch[1], linkgit:git-send-email[1], `mbox`(5)
 
 GIT
 ---
-- 
gitgitgadget

