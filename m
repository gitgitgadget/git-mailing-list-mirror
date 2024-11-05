Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A451EB9FD
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833518; cv=none; b=DiKJrP1FnHtQf2Sr2OqBPWBRbs6SeOCeuS1Fis0gIW70CTCDQpJjR3BveDNswl+pmNjIaDVrEV/rEgZhAlONHDLyAmgeTn7ik8qNylAsisU6DXz5JVfDY1/pFVizmPmr+KhktYGy4JgUmlXBVCJEwnJ+EXHPbpLK0UE4wJ/bXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833518; c=relaxed/simple;
	bh=iNZwqRx1Kklgl+nfFccwKyI+ATqwiARtSL4h65Dd3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMVLFQYk1VT1y7GrN+C8tECJvoVTJcInUoLg3mAG6LrK33eIvk98z6FMzpoQwafqG0CtlWZ5I9k+2w/C2EY00dXvre1wgAEUQSwwOaL+nUesWLVB0mznVrn4gUiTcfYXEoU7X2AhjHCoD4Y+IDUkQ2M8mBIYw/iJ73D3LCcv9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HBcylbRI; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HBcylbRI"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so5291701276.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730833515; x=1731438315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjNdy5CJOmhCR5goHp/Odeue4EBoAiOklBHXmOidAmI=;
        b=HBcylbRIktBcqffPu9EYBkMeTbPgQDYm+pTtKD9OkDRPvvqlz7f5T4sdwxlP8suA5O
         1U/fMej4+fvloQqn+GLysZ9x7L5f0d6MZTHeNya1Qj1eUyMrbFpKO9nnS8UzE89Si31a
         koApe+j9IKaOTGeyEdDczvxFTS3lSNHYQoJlZ5Rxh/0S3wYCP7OqDf9igOjMoy9b4eHs
         0wsUucue+VWCSUM0IP1jQ159gR/Z695DMnuaCZu3ZDb9M4yAorJs4TXU2Oe4C4oLnvjp
         /ijL7v7guhd4l8Q/ho4jRu5uyeO7wBu+uo5U9h0rhGdOhFP3McAB7vbO0pyA3ZquiyCD
         A5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833515; x=1731438315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjNdy5CJOmhCR5goHp/Odeue4EBoAiOklBHXmOidAmI=;
        b=pFO/s+T94RzO9A5cwD2Qv21VZ67TOboQMt4SShtq04MeTbISn+PmRK4O47QXIMDI0o
         vSA/Q7KQh+a3CSeuQoz6TVOUhDI3P9yQ1ZGCVXQahW2slCbrmmeiWN5RoBGnSWjDXkdL
         5iwuBMxNZQsS3DmqsZhfgD7QYTA+YCX3oI7tL7AeiZ5Du6B1xhEoIKJl4tkNziZPXPbc
         PTotKzWt+4DZ+tqHblws2ADasSkR8Pgc70CgnqhBdyOcI6jXxk52RpwaHJsYy+E0kBDQ
         ULzfZb15JIKV0+wG1veVTU0eh8FlbySYjq5JPZMhvZJ33ddk2Y/U7W9gykgMCzacoTk5
         wtNA==
X-Gm-Message-State: AOJu0YzcQqVpMjsHewntsMbPp8CpJKStrZScsgLIiEK0NYM8T3nddxgW
	TuIYcpBOyujBxIsYt7jdKQ7uTwsowNB7f1dgl6At4INCzbHcWXIft2u8Uq4sdM6Yq39zmztqPx9
	llcY=
X-Google-Smtp-Source: AGHT+IGscYGzzMN5kLDsrDh3b+SO/ZB7tEvX6xfEpIIoIOfSx0i6WGalvG7eiskjLlQQO+7cT5F67A==
X-Received: by 2002:a05:6902:33c8:b0:e30:c614:5c40 with SMTP id 3f1490d57ef6-e330254f899mr13502556276.2.1730833515616;
        Tue, 05 Nov 2024 11:05:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adf93csm2694062276.55.2024.11.05.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:05:15 -0800 (PST)
Date: Tue, 5 Nov 2024 14:05:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
References: <cover.1730833506.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730833506.git.me@ttaylorr.com>

With the new "unsafe" SHA-1 build knob, it would be convenient to have
a test-tool that can exercise Git's unsafe SHA-1 wrappers for testing,
similar to 't/helper/test-tool sha1'.

Prepare for such a helper by altering the implementation of that
test-tool (in cmd_hash_impl(), which is generic and parameterized over
different hash functions) to conditionally run the unsafe variants of
the chosen hash function.

The following commit will add a new test-tool which makes use of this
new parameter.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c   | 17 +++++++++++++----
 t/helper/test-sha1.c   |  2 +-
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.h   |  2 +-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 45d829c908f..d0ee668df95 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 
-int cmd_hash_impl(int ac, const char **av, int algo)
+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 {
 	git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_HEXSZ];
@@ -27,7 +27,10 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 			die("OOPS");
 	}
 
-	algop->init_fn(&ctx);
+	if (unsafe)
+		algop->unsafe_init_fn(&ctx);
+	else
+		algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -46,9 +49,15 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		}
 		if (this_sz == 0)
 			break;
-		algop->update_fn(&ctx, buffer, this_sz);
+		if (unsafe)
+			algop->unsafe_update_fn(&ctx, buffer, this_sz);
+		else
+			algop->update_fn(&ctx, buffer, this_sz);
 	}
-	algop->final_fn(hash, &ctx);
+	if (unsafe)
+		algop->unsafe_final_fn(hash, &ctx);
+	else
+		algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index e60d000c039..1c1272cc1f9 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -3,7 +3,7 @@
 
 int cmd__sha1(int ac, const char **av)
 {
-	return cmd_hash_impl(ac, av, GIT_HASH_SHA1);
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
 }
 
 int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 2fb20438f3c..7fd0aa1fcd3 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -3,5 +3,5 @@
 
 int cmd__sha256(int ac, const char **av)
 {
-	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA256, 0);
 }
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21802ac27da..f3524d9a0f6 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -81,6 +81,6 @@ int cmd__windows_named_pipe(int argc, const char **argv);
 #endif
 int cmd__write_cache(int argc, const char **argv);
 
-int cmd_hash_impl(int ac, const char **av, int algo);
+int cmd_hash_impl(int ac, const char **av, int algo, int unsafe);
 
 #endif
-- 
2.47.0.231.gd8c1fc78b57

