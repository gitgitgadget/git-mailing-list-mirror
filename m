Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1A1C6FF1
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250281; cv=none; b=WjxFHS4dfvKIMFd8XrSNF7ZuHraoxZ7yiylvDIZGTFTK3JTW++xJ3huJ4c4RnF/Ve6q9iUvOJ37gsfanzJfbT67qbH4R2ik4mXYe8NoWZG02YPAH5soN40kAGLDXW0w/1HbxwBty8uC9IZ8Q6jNVULisIsDKaEzyPhq6TLoQvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250281; c=relaxed/simple;
	bh=fPfi5Yjmm9YN+TpoguSWismC+pa2z4Jp6gZQkqdgLwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftL/YAEO40Vycp/pFGn8tnpM3vQrsHLE1rSp2nu66LM6Gj5QJgm53gNeldPOwJ7USlmxhY2YGUBcjpbCJPIi6BO7tfZGX5nbSBukZ/Ul0+SRUff7GYL3tizsdT0yqt/Ddyzrhd3r7RGqDEgPCSzoSqLLLThGL+rNnjunU578dqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bkSGi3/M; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bkSGi3/M"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c554d7dc2aso809693785a.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250278; x=1742855078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSYSmq5OjS+9CHnirCPHfM8EKsGG3zGOVGM7Vyg61XQ=;
        b=bkSGi3/MHQ9jwOFYZBxie7gk3ZYt7pz7QwI7LZ8RxSGf/6xflKCagTCDJfKqABijJH
         o/uXK1p5vfe4r1Pbiu8rsDysmQ9n/dn7WpdYIj+mH7z11Upupw5EvV+WZxetATSYtvxH
         Md3omq26NtI7dDz2xSUOQwAz1G0/Jrt7JpRLf1JwHjv7xAJoLZc1WfmkxGJDGKk9uRSS
         Ju0MEM8SlfX86mdy6qeVKXXYZALymKoLQO2kbJbUlcJzwV8+GmypuyhfvGSgFtb+bqDX
         cYjia/Wd1ENqswcTY5jPAxXddwH+3gh3YA7gMjLAkRaVgDWZvbECE265XMDKKLl96duZ
         gCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250278; x=1742855078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSYSmq5OjS+9CHnirCPHfM8EKsGG3zGOVGM7Vyg61XQ=;
        b=TsXmV7BUE2M1ucKSW/QQOm8q2Ui0luTfgnKzVZ1fkuYVKjaDDZKqyl+i0YR78e/9op
         txoyQZ1yDXMTBhC6S5nYIExMGacE/rcndR9BQ4TMArb07yz6refTx8uj1R773lYFASFp
         hU67pDAOe54QvMSJ4RvrLGEobNv1UmTBpjH7Yq2Vq7zMU7s/TDimLYSnnOML6T+idsHk
         sC0AI5bp7Vp8mOll7B8IcLK41LLHriZ5aHN7fQirQyZAXI2x6153FHDOwVfWoUeKnZ9H
         CdmDOk5Q6ficJ1xA+YU6RoXi23EN/saKw5uLyeiFhOxgKE0y/2udEAUioGP5EUXFP4GB
         9DZQ==
X-Gm-Message-State: AOJu0YwgeQFbVGKCnPa0P6oMoGZEVycZD+Z2PNLdWmZWTE+zfbOg4Y6d
	/SMu6FQ8CSAap9q0FSBPsf0lZP0RSeXwUOdFRXByxbENDELoeKs0QV98GpePvGh1pPoSVC7XQjG
	Pa7E=
X-Gm-Gg: ASbGncsdKqpxgX/I7AEA+shBMSbtu76FKWo3gCvZhFwKwNV3nDk3v22mDumsu/dNgO9
	YfD3ILU+eRtik9VqdsFrQWbvdvNzhTNty2WKFeF/57H6BBLfD/cuZSj3Z9szWlte7kRGHAeQARW
	y3P3TjdG3MxOYIXGY/tt/twn2civPFbR6dgdoqRT5JBAG5KmrHjfXjQZvdPtLCe9d50gMZZRMBd
	hEZJ6tHxlWvdHgPQPuRj98BmzpBr91zNqBJpoJul7qNOs5ROFvMh/mi96hugFYJpJvWtrEtWL30
	cQ5ABL4865RG/PPEqV6n6YqeLKsZ6rmNtcXx87gAs2AoQ9R0Ut7EJattYV2MUaa8fGY4F5i59at
	vpoRwe3Piy7ggPYPz
X-Google-Smtp-Source: AGHT+IHIGlkeT4xYPnx8cnOhtTboVn3NPx2vxK+/OjuWQuGRui1zDMCX7aTKjAlyUH0k1Mw9N+gTDA==
X-Received: by 2002:a05:620a:179e:b0:7c5:6140:734f with SMTP id af79cd13be357-7c57c7d2912mr1939292985a.18.1742250278617;
        Mon, 17 Mar 2025 15:24:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4e60esm641857785a.6.2025.03.17.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:24:38 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:24:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 2/4] refspec: replace `refspec_init()` with fetch/push
 variants
Message-ID: <fd2354dade380a6d0109398bdc422709966728dd.1742250259.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742250259.git.me@ttaylorr.com>

To avoid having a Boolean argument in the refspec_init() function,
replace it with two variants:

  - `refspec_init_fetch()`
  - `refspec_init_push()`

to codify the meaning of that Boolean into the function's name itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refspec.c          | 12 +++++++++---
 refspec.h          |  3 ++-
 remote.c           |  4 ++--
 transport-helper.c |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/refspec.c b/refspec.c
index db5a1c34a5..f6be0c54d7 100644
--- a/refspec.c
+++ b/refspec.c
@@ -178,10 +178,16 @@ void refspec_item_clear(struct refspec_item *item)
 	item->exact_sha1 = 0;
 }
 
-void refspec_init(struct refspec *rs, int fetch)
+void refspec_init_fetch(struct refspec *rs)
 {
-	memset(rs, 0, sizeof(*rs));
-	rs->fetch = fetch;
+	struct refspec blank = REFSPEC_INIT_FETCH;
+	memcpy(rs, &blank, sizeof(*rs));
+}
+
+void refspec_init_push(struct refspec *rs)
+{
+	struct refspec blank = REFSPEC_INIT_PUSH;
+	memcpy(rs, &blank, sizeof(*rs));
 }
 
 void refspec_append(struct refspec *rs, const char *refspec)
diff --git a/refspec.h b/refspec.h
index 155494cd3a..7db68e56c8 100644
--- a/refspec.h
+++ b/refspec.h
@@ -52,7 +52,8 @@ int refspec_item_init(struct refspec_item *item, const char *refspec,
 void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
-void refspec_init(struct refspec *rs, int fetch);
+void refspec_init_fetch(struct refspec *rs);
+void refspec_init_push(struct refspec *rs);
 void refspec_append(struct refspec *rs, const char *refspec);
 __attribute__((format (printf,2,3)))
 void refspec_appendf(struct refspec *rs, const char *fmt, ...);
diff --git a/remote.c b/remote.c
index addd4a9999..25af97a44b 100644
--- a/remote.c
+++ b/remote.c
@@ -143,8 +143,8 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
-	refspec_init(&ret->push, 0);
-	refspec_init(&ret->fetch, 1);
+	refspec_init_push(&ret->push);
+	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
diff --git a/transport-helper.c b/transport-helper.c
index 43cd760119..69391ee7d2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -162,7 +162,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
-	refspec_init(&data->rs, 1);
+	refspec_init_fetch(&data->rs);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline_*() family of
-- 
2.49.0.rc2.13.g95783265fd

