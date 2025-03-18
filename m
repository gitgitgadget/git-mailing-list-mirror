Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F12080D2
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338222; cv=none; b=DOyo4cDAhe64IU17L9uCKABGTae2VAOJ8bQDJr/kGR3XNaS/ksK99frNK9zETFp0egh3oNKHxkj5WMgvgYbogTbNAuZKjyQRbwxdoQKz7huKQVaQ0ww6DFq/YLedPqtysVlfc5u9eVOkhAOc00I+IGvIji8I6AIcXg1q98nPN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338222; c=relaxed/simple;
	bh=lNE5XGZbIz2+zA8cBL8TSJmElQzrN09X/pBXOI/GG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUYWoTKTtVuSLRULFrT1kplBnoPEUHyy6DhBnDlAaZ5suQxZ/mcHMzYVRd/vmLHERQCPs6iiwmtBuesJXu/U3NySBY9V/wM9fc/rbztKrPDFGnxPzhNApC7pAa49gxj5Un6SKTzk4zGaUrwQfDxEDrLN/lAjOJCAEm00cWLA3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZBK7/MFw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZBK7/MFw"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47691d82bfbso49561861cf.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338220; x=1742943020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8sfQmFPwSKKwJMcleJdYOo70+FYdCRwGe7dY4FqCx0=;
        b=ZBK7/MFwZKOo81CiSmSdeqjxlX0Akrmft+Qc5Q86QPutdMgd5a6r91YgSs4/ld7/bW
         yaR55R7bcDxTZ55I3bPYWmki1q0bhNQRmg4rx2M5HBAPu2KrO6dYZw4u0jTLVjTB4Kpt
         L3/F0A+jY6NpgWFo8KzPRXvaW7851MtB7eo3XI77NrujwMn6G+JZFgzxJyHq6DqOGwTO
         ZmPyJ/6JJozNBVotuRmtQyhXvVnkB80EnTraL51eE5n7nVA+aDVF5PWreJ42KRNvb6dC
         Tqwzdqlthx9Z6dxW09ZPK6zzYzCfShTEgA0UAnf/+r7uCrv5dig99fgTbBtJAmZy741I
         VX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338220; x=1742943020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8sfQmFPwSKKwJMcleJdYOo70+FYdCRwGe7dY4FqCx0=;
        b=qJmnCHr6DICARug8Vuz3GxjLuTCmdgM3i9jw2zHJR5DOHnd8ZOo+26e+/cata0nbg6
         sqw2LUvGYRaufJ9/RnCi5sI3OYASnaCLPCxbM2++sm9Wv2gU6YCTQSb+e1755F3G5u2r
         dc62hhYaOcDmI5K5fR6Zw/UM1C7o4L8PSGFcSOlJvIAW/1Tjj/m5uyo3fFlMW/bZYv2E
         1iMmvBmQVBpH5WyjztfeUM88SeYXQUjQseRYfYbfu+bx+G6Ns/DkeuTgFj7T0MXTH359
         wdeEAVrR93T5fJZcPCQd6Uu2sFfgx6br6pPCy55d+8FbGVUMqQNufu13vBMfkUD28bIP
         l9Qg==
X-Gm-Message-State: AOJu0YxGWiWI1852LwhH6He/gL2fGcrxdUXwHBQA3rnbAjYaX5LlDRCw
	rB46UYZUlskCYnH/SYoEAkaHfB5Fpd8i6bk4C73ARJZ64dOnkFAHOOF7J6x0nw0HyEfoghyKNal
	tQ6Q=
X-Gm-Gg: ASbGncvaD2Dx4c1Z8uA9UnhCW7RdCDt1RDMQET2mZRzgcR5Bosm9/3PrZzdzmGgesAs
	+/KiQTR1i2sMWktSc6gFnWKXzqKc3ZWb/R8BIale27T6D+QAT2FWFO234vUT43M5toGmqagKMbd
	+2f26bJ6r+Qtq+VKnzv6Av6a6iTOuqYwSMujh9d9wddYFmzplYfoMpIJd/KWWPOg5+IUHy5RvBB
	z1RfZw5CgdPTNqFmKXy4/DH3v1m5z91a/nzHqaVW6sOiEDiXouh39loDueWM3j0p4bqMjwdyr05
	/xNoteO92dN/O9jTcPY0+Mb1LQjTxgXLZuW4QEQsMe4LiSQjcAsvjNkZ6sIV9UfMXoKWmCbHSs2
	D66nMYQpAiXj5nBjf
X-Google-Smtp-Source: AGHT+IGGaFjZr8xA/dO8Cj7IWeIhFgt0mItukrxf43044U3sH3FmKsfFTXRPq9nhtFofusvnNaYABA==
X-Received: by 2002:a05:622a:1e95:b0:476:af21:9d4b with SMTP id d75a77b69052e-4770841faedmr13371811cf.37.1742338219810;
        Tue, 18 Mar 2025 15:50:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb824a8csm72222271cf.65.2025.03.18.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:50:19 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 1/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <04e1ab8209681f9090ff880fb4e0b452ff0d747a.1742338207.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742338207.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742338207.git.me@ttaylorr.com>

Since 6d4c057859 (refspec: introduce struct refspec, 2018-05-16), we
have macros called REFSPEC_FETCH and REFSPEC_PUSH. This confusingly
suggests that we might introduce other modes in the future, which, while
possible, is highly unlikely.

But these values are treated as a Boolean, and stored in a struct field
called 'fetch'. So the following:

    if (refspec->fetch == REFSPEC_FETCH) { ... }

, and

    if (refspec->fetch) { ... }

are equivalent. Let's avoid renaming the Boolean values "true" and
"false" here and remove the two REFSPEC_ macros mentioned above.

Since this value is truly a Boolean and will only ever take on a value
of 0 or 1, we can declare it as a single bit unsigned field. In
practice this won't shrink the size of 'struct refspec', but it more
clearly indicates the intent.

Note that this introduces some awkwardness like:

    refspec_item_init_or_die(&spec, refspec, 1);

, where it's unclear what the final "1" does. This will be addressed in
the following commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pull.c     | 2 +-
 refspec.c          | 4 ++--
 refspec.h          | 9 +++------
 remote.c           | 4 ++--
 transport-helper.c | 2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9c4a00620a..8bbfcce729 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -738,7 +738,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;
 
-	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
+	refspec_item_init_or_die(&spec, refspec, 1);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
 		spec_src = "HEAD";
diff --git a/refspec.c b/refspec.c
index c6ad515f04..db5a1c34a5 100644
--- a/refspec.c
+++ b/refspec.c
@@ -233,7 +233,7 @@ void refspec_clear(struct refspec *rs)
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec_item refspec;
-	int ret = refspec_item_init(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	int ret = refspec_item_init(&refspec, fetch_refspec_str, 1);
 	refspec_item_clear(&refspec);
 	return ret;
 }
@@ -249,7 +249,7 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		if (item->negative)
 			continue;
 
-		if (rs->fetch == REFSPEC_FETCH) {
+		if (rs->fetch) {
 			if (item->exact_sha1)
 				continue;
 			prefix = item->src;
diff --git a/refspec.h b/refspec.h
index e2b5cc54ef..155494cd3a 100644
--- a/refspec.h
+++ b/refspec.h
@@ -32,11 +32,8 @@ struct refspec_item {
 
 struct string_list;
 
-#define REFSPEC_FETCH 1
-#define REFSPEC_PUSH 0
-
-#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
-#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
+#define REFSPEC_INIT_FETCH { .fetch = 1 }
+#define REFSPEC_INIT_PUSH { .fetch = 0 }
 
 /**
  * An array of strings can be parsed into a struct refspec using
@@ -47,7 +44,7 @@ struct refspec {
 	int alloc;
 	int nr;
 
-	int fetch;
+	unsigned fetch : 1;
 };
 
 int refspec_item_init(struct refspec_item *item, const char *refspec,
diff --git a/remote.c b/remote.c
index e609cf5c56..addd4a9999 100644
--- a/remote.c
+++ b/remote.c
@@ -143,8 +143,8 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
-	refspec_init(&ret->push, REFSPEC_PUSH);
-	refspec_init(&ret->fetch, REFSPEC_FETCH);
+	refspec_init(&ret->push, 0);
+	refspec_init(&ret->fetch, 1);
 	string_list_init_dup(&ret->server_options);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
diff --git a/transport-helper.c b/transport-helper.c
index d457b42550..43cd760119 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -162,7 +162,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
-	refspec_init(&data->rs, REFSPEC_FETCH);
+	refspec_init(&data->rs, 1);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline_*() family of
-- 
2.49.0.3.gbb7a4a684c.dirty

