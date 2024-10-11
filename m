Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7781CB333
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671860; cv=none; b=IfDjgUO2WSi23sxmyRDMgdXVryHHZkZ8P2pK8Q9oOvJL6LuJNhl0dFg8AYP6ffoF8Wo+4a8DmfuM6NkJN+OThS6weDi7SecCKcRepgA0D5VDDdReff182fhrPI9kVPHbFTekr9LEQxySvhfiNxorghH/XJkix80CITFfEd6Mvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671860; c=relaxed/simple;
	bh=d8P/UgKztmL6YZRx3O4KF2Xng0mZrQ+rHm6I3oe5Wqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ3r3W+Uu1oqnQqN/0bh52mkCznGnxwmKYUZmSMek94zJx8w5bMn860deI6Z34Dbs8vXjp+6qOz/AYJzgoPLnzBuQQ6LtWDT4Z0tOc9rwv526b/dOPbdWMYqnqei+DPQ54K1pXHNz7jHFl3AKbbZ8u+vkHtwWlYlYiEcMKdVD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TWN2VTjo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TWN2VTjo"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so837660276.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728671857; x=1729276657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sK8+rd7DAIkRDL22cz66Op117nSH1IDEKhadNE1Ic1s=;
        b=TWN2VTjo7gmFP0Njm0LJ/nSX4xxpj/56sb8bPr1YLwu9pAtpERHjE7Ig1ThOPtgk48
         Vl3oAQSlRVagIi2JnWeSBHxqBbXIgxTUIVXeuDjp2zvViJcjdOdXZmqjYX7vq0jS1rMK
         A+lNlqXPN3KOdGTSRtmmfyko77eZNus5wO4bLn58bHJ4XYyDrY7+a0stRlXlMcFLQHIk
         fw1MNUfWEYqfKevHc2TX30ePH0QSIRAutUikJHkbgWwIi90IJMDdvV3T57sQPZQCEJ/6
         PXYOjr6d/nMhwUoJj2+ws6jrGRzeF24AjAzUBdbA/XfJagfNZlJk52HAA2W6f4HQkJF4
         WbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671857; x=1729276657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK8+rd7DAIkRDL22cz66Op117nSH1IDEKhadNE1Ic1s=;
        b=nPQWwHyG4AclrFY/At5mlX2oQFQ5dqMsz8hLv0+OfdkLF9hmGcDuxb229eNl+YaCHv
         F6r9lu/ykfHxYEgIGHWmSz4FXfPbhmoPi7XvAedOSk5VoCkOziKb8fMu22FWGtx/YPvs
         RgMccvwaSqFC7cqTZIOQPEuId9rUQWpOMh1e3RB8LduxJ5V4IwZnN6eXyp9lLr5xhrd3
         d/dfWwC33Z9/TrXse4yJWRHDtZSHpRDOnpk62qAzZ1e7QoyIjbrRHW2QoUD+5NUE3S7e
         xOJn3WKXGJ7c0GhyUPQiYf7NFVQIRr8fUx8swdNBGAbTDKARFb1SElTLrT1ZRyIiGItP
         dJgQ==
X-Gm-Message-State: AOJu0Yz81AiAUlPDcPRBCKD8xyhkHegS/PJMgbuGifYcJmpPmUa7BuFZ
	RERhn8CfUbVvlHZYecK4CIRwJ+h4ac4UneumGpdAwzWZfpXJPxgsXRFyG6uaHuY5Z5WFFpM5/yM
	f
X-Google-Smtp-Source: AGHT+IGa4+CVsX6iLV9beoNPG1DSOX5Wh2S9CD9u02Fo//vs1OWGW9fKHFcL3ntvmo8aXTCkpmTUYA==
X-Received: by 2002:a05:6902:18d0:b0:e25:ce87:6437 with SMTP id 3f1490d57ef6-e2931bc9d72mr666492276.44.1728671857412;
        Fri, 11 Oct 2024 11:37:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ee007d9sm930021276.23.2024.10.11.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:37:37 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:37:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <3b31db4d2df4889029422f48f65173e957c9e7e3.1728671826.git.me@ttaylorr.com>
References: <cover.1728671826.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728671826.git.me@ttaylorr.com>

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
2.47.0.2.gd343f5dc9e5

