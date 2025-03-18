Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAB2080D2
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338225; cv=none; b=asytLHtUGKkTUy8tOGC8rAtgh6H1n626MomDsi6EbEP7j2JwoIRw9pJ3JU1Dg5tbS4N6IyVAoywIt1TELSj0vuYnSJDKHr1igb6OZ71S10y2NFydI3VQozqUtbi/8uzcETrWJpW7/+3QY19Bw2woHjMwXOIXE9RifknGg5GEdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338225; c=relaxed/simple;
	bh=mW7UHbpZM+uzoC30EMllGFnHA8TO5E6WIu8PmX4w6io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTMiMpnBk1I1TFG53Opm80MzY5xpKNMLRfrhOSgUFq+jhJPClBd/7Q1NS/+o/k79mcHCDKI9PYWjN1yWs7J7bmV1kAttx8Jt6VaBR7Uj642bPkmoJPwbFXbrqlGOD1FalT1AD2AlFSSqmUrg6I6chVwmkSwGYrnUa3E/xLYcJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uHHP7ufR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uHHP7ufR"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7be6fdeee35so1083062385a.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338223; x=1742943023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3csdj2t6BBKxjSbaSbomj2BGwvdrzVKeX7lHgL6lm0=;
        b=uHHP7ufRBwjq1Pjzc84/GTgJLw9b5u0pk9rLY/t+VCO1Nnh27ABFKomw8cDSrhhM5K
         0IQIddWapZ6Ao2IUnH/9NR9NcU7917iHlbODGng2401n9+jcz+aEnnM1iuAp8G2bpgUP
         LtZW8jrksOgFND0ndVx+cRs+U7NYJW4WLBJcjrItMfN4C/1uMwkk+71x0Krv0A1GmL1v
         slQy4qmy4Dw87vlijda+S4LluYfG1B309kiJXeZzus8iZSuZZtMEue4YdrCvFFaM8Lt5
         lchI5akHo/9/+ABjqMSuoEEhhCNAh29Y+L6rg5OvXT3znXhTSeuvHTBzQ+e+/TUJ9Dn9
         W6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338223; x=1742943023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3csdj2t6BBKxjSbaSbomj2BGwvdrzVKeX7lHgL6lm0=;
        b=GU3oKO1JgvuGZRjXsNxIKQcQCPWZ//tkkGFu9mE3bVKHTiU0v3QHnY8J64Cla3nRCy
         SkG9DAX8Y+Uc5eLLrSl+QrEdSnN1I4JtFhQKKpkORFsUcYbKLKKyejM9ftd9kivWg71q
         uL2brykpACmjP8tkcYODOVisg80nVEsyVFIYR6dzjSfS0Cgb5aekE9Pc9lf6LtLgZ3WU
         mPwgSLx5zwu1p7vTDU5o/If5SsjIaN0oBquGPcp5RP5+fiJeF5c5HHiO1cWqHPjQ3EMq
         iViUcZ6/8SKt1u0lU+N7VWil4w2G0QQ/pVaKaj3ynHF6OsURDgTiSuAZNKhEFyekySXc
         CGCQ==
X-Gm-Message-State: AOJu0YyOkmvhBnV+qVibmg84RdL+qTdmwgK6T6LlkxJaTR0lGTfM2Qfd
	j71km/x7K8sZGxT/jhKm55S21VNFLjuRmVOGMzh2OtZ6sRooL9u3p4jFuuzcPyDlSI6jSvAajqu
	4IRc=
X-Gm-Gg: ASbGnctjS49PRQ5kuzWbjyjReENxWa/6oS2E1krlZXPN7zU+2KPTVqLmbyQ/3CBw/E0
	DBJsUdy+M3M0fuEELNTCa0XleIj0RYnHV4fGoj1sG6xsIBlLWIlvlauk8TAe88dJ6Akc5tu6XZl
	5Dy8v2IUkktkuBmm6r+b0Zi3jiayi5U0gb+emvesGbBYkmRn/TWLLMTJa/LbeUokOUb/Y3MFjTX
	AlMGvusadf7+/C9lwcq4WBpneoChQQwTyN4Zf/rfB5q7diC6P3n+YMxNNCBBV2VbSGj9gxKnaDt
	/zcbGQVJC1T7LiNrLrGCYWCfVglT684b4SYrx7UZaDU6llwqMWIjKEJ8gaXn/NmmisU94dqNypL
	spe2VFRwbyXxZ9Z3K
X-Google-Smtp-Source: AGHT+IG5h60fkb2XCv4TRR6t6PXCWiD8o8/BWP0A4G8p4cQHk/ky/FnlmmnGs8WjNtc5xh5LKzCXAw==
X-Received: by 2002:a05:620a:1a8f:b0:7c5:4dc4:ae48 with SMTP id af79cd13be357-7c5a846018emr58883385a.39.1742338223071;
        Tue, 18 Mar 2025 15:50:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4f531sm773197785a.19.2025.03.18.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:50:22 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 2/4] refspec: replace `refspec_init()` with fetch/push
 variants
Message-ID: <c3021b82ce95d0c04d94b293773275a0a6bda01c.1742338207.git.me@ttaylorr.com>
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
2.49.0.3.gbb7a4a684c.dirty

