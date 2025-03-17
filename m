Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B292F30
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248841; cv=none; b=OC+5+oFOfH9rkH5sO3se2ILXiD2EmTWyOgJvLnUAoJ4gOYPGmMGuf5g/g817G/W/bzlmsRS84EW0hdOaGe2iVIEvohLfIeaTj9VN6kkJfuifY7VYbhvRN+Xu3XnMimHSlRNZAaxrCIof9lQU1+IpBYlo+YvNtgs6QgAzHTAbLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248841; c=relaxed/simple;
	bh=4u3B8x6N0jbjc76hOssyRMCWCYJjjact8uIiqe7/EUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgTXf7EC1eXrEgOciYuPLTVHdRSqV/fTuSXhr8zhuaMTRsSU0HwlKSr8x+j4t1o7fFv92tUjP8qIZid/GPB95/jvslmFPwgUtSQDSKbZOkCKVsYbaBURIzjEj6wwCnzgCGp18QcA920Zo+aJ5AFGdjL7lUMtyiZwSOLPdn4A3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zV02Krr9; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zV02Krr9"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08b14baa9so394146885a.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742248838; x=1742853638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oECbsWQMw6Tq0Bsm6nMn4lWHIH6/PeUVosL7B70SSmA=;
        b=zV02Krr9JOKO/Ic5wuHa8DiHDY8ujeppRxwYHrwxEHCfLm6ad8bmSyJS4+sJRcBi52
         5Dyq39U82pyz1T6jlQkLIU7pznpFuc44TYAnudFjNPBRL3Zjk99K59nds6qmG9TrsSIM
         SOAJmiAeWWVM8uvY3AciOleXxBqOUxm58CCfXP5W1xGLWDXKq9cFMQ/y+uH/C15q9M66
         bDqaGNmivuMxfGK5v45FdBUwV5okfqxqUnDXTctwVC5aT/yEggzsZgniSP9/WNMFsswE
         dY/hb7D+f4QG5wRXb2H3LFtiPjbCMz8zlul+rc37gqmc/h0wPhsAwkRhK2xbWaPiBTIX
         ykpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742248838; x=1742853638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oECbsWQMw6Tq0Bsm6nMn4lWHIH6/PeUVosL7B70SSmA=;
        b=S6cEW6OOMP1BGmP3wsKmxsyi7dL6IOr42uJp+8c9+rrsvmoo8FUzTWxPVzS4yPOQ9O
         9I3AK8wtZDKvJJ0Ue4McM8S6ZnygZISbdxelGG1y8h4EdjOCbFV3IOU+J8qxVGEBtnlZ
         s2tmn2FujlRDRFek7wmE9QAeY2YFzPO8DlCaY7izl2c7taY8RY4mcv6dylY46XF1OnaT
         ZtPbqjdAgPdVXEKvIiDL/WT16sde/fSL9QN7OcAARdM+TAMb8kaKkxs2EcrIdLQTOdEn
         48jGvzdOo+57B6oyF5jmr99oDJAS0wa6l/2fsFaCE8ll+fDhO3v24QnhJ68lqYHgPEcx
         riKA==
X-Gm-Message-State: AOJu0YyPlEorispuTnGiAQdKPLyyR16017ndYcDevdLBJdnNHJ95b1IF
	z7+tm8sCz8ritTASeg0Wv7TI1krZNn1aL+6LSq5SUBmfqRmnnfMELbDYfMZTMT8=
X-Gm-Gg: ASbGnctoW0bGEfmnHCWm0Cdcer0EsvnhGnogowiAqM8mt2Re33CSRyaZfsVthKSDkZD
	IFLrRjcvuMK4k98H6JJhk3qNMJyTLiyoWdiJyE0XOiJ//hV7A0nqyPB5iQOXw2NOhjYwJUtjg42
	putDhRLBpONnWg1YDeG+rnSdoQJl54fap+Lb8BoJSmR052ri/qKHOAgGYy/Ovz4iEDUa3XArTa1
	YHNUjXDULL006sp5FZHMjm7wIKoOExF+fbwo1R3yJ/uR9M1e81fX5fu+yxdt4pWjTr9vTPW1iJw
	bgaTWV62JqtAjkViALpzWhWAQAavR2EXWawbcE3KqW9iTl3O6u42AJgBS7n2XjczUw0QqVBHc8/
	E89thn72di1aebD5ucO+hDXe4umo=
X-Google-Smtp-Source: AGHT+IFZ1gpA5xLTDG94NwVgfkXCuLMxboBZqm4eTnBT8241DzS5wL1IXUeO/0DvV1s1QwWxwcy1fQ==
X-Received: by 2002:a05:620a:1996:b0:7c5:3b3b:c9d8 with SMTP id af79cd13be357-7c57c8c0344mr2191248785a.45.1742248838212;
        Mon, 17 Mar 2025 15:00:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d8a62asm634419585a.96.2025.03.17.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:00:37 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:00:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
Message-ID: <Z9ibhJxjlc2DxKdX@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030706.GE2334191@coredump.intra.peff.net>
 <Z9H+vWHFkATWNLxt@nand.local>
 <20250313054107.GE94015@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313054107.GE94015@coredump.intra.peff.net>

On Thu, Mar 13, 2025 at 01:41:07AM -0400, Jeff King wrote:
> > Do you think it'd be worth handling rs->fetch in a switch/case block? At
> > least that would allow us to catch unknown values more easily, though it
> > seems unlikely we'd ever add any :-).
>
> ...this whole thing is badly named. It is called "fetch", but the only
> two values are true/false. But for some reason we named them
> REFSPEC_FETCH and REFSPEC_PUSH. Surely it should be "type" or
> "operation" or something if we were going to use an enum and switch?
>
> I tried to limit the extent of my changes on opinionated matters like
> this. I almost dropped the patch entirely, but I did enough
> head-scratching to find that latent bug that I didn't want to lose it.
>
> If you want to fix the name and other clarity issues on top, I don't
> mind, though. ;)

OK... I agree that these are at least named confusingly ;-). We could do
something like:

--- 8< ---
diff --git a/refspec.c b/refspec.c
index c6ad515f04..07d401bc71 100644
--- a/refspec.c
+++ b/refspec.c
@@ -181,14 +181,14 @@ void refspec_item_clear(struct refspec_item *item)
 void refspec_init(struct refspec *rs, int fetch)
 {
 	memset(rs, 0, sizeof(*rs));
-	rs->fetch = fetch;
+	rs->type = fetch ? REFSPEC_FETCH : REFSPEC_PUSH;
 }

 void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;

-	refspec_item_init_or_die(&item, refspec, rs->fetch);
+	refspec_item_init_or_die(&item, refspec, rs->type);

 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
 	rs->items[rs->nr] = item;
@@ -227,7 +227,7 @@ void refspec_clear(struct refspec *rs)
 	rs->alloc = 0;
 	rs->nr = 0;

-	rs->fetch = 0;
+	rs->type = 0;
 }

 int valid_fetch_refspec(const char *fetch_refspec_str)
@@ -249,11 +249,13 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		if (item->negative)
 			continue;

-		if (rs->fetch == REFSPEC_FETCH) {
+		switch (rs->type) {
+		case REFSPEC_FETCH:
 			if (item->exact_sha1)
 				continue;
 			prefix = item->src;
-		} else {
+			break;
+		case REFSPEC_PUSH:
 			/*
 			 * Pushes can have an explicit destination like
 			 * "foo:bar", or can implicitly use the src for both
@@ -263,6 +265,9 @@ void refspec_ref_prefixes(const struct refspec *rs,
 				prefix = item->dst;
 			else if (item->src && !item->exact_sha1)
 				prefix = item->src;
+			break;
+		default:
+			BUG("unexpected refspec type %d", rs->type);
 		}

 		if (!prefix)
diff --git a/refspec.h b/refspec.h
index 382ba2d5c1..a20cf883e4 100644
--- a/refspec.h
+++ b/refspec.h
@@ -32,8 +32,8 @@ struct refspec_item {

 struct string_list;

-#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
-#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
+#define REFSPEC_INIT_PUSH { .type = REFSPEC_PUSH }
+#define REFSPEC_INIT_FETCH { .type = REFSPEC_FETCH }

 /**
  * An array of strings can be parsed into a struct refspec using
@@ -45,9 +45,9 @@ struct refspec {
 	int nr;

 	enum {
-		REFSPEC_PUSH
+		REFSPEC_PUSH,
 		REFSPEC_FETCH,
-	} fetch;
+	} type;
 };

 int refspec_item_init(struct refspec_item *item, const char *refspec,
--- >8 ---

, which gives us the "default" case in the switch statement. But this
really is a boolean. I wonder if we should just use 0/1 constants and
leave the field name alone. That would turn something like:

    if (rs->fetch == REFSPEC_FETCH) { ... }

into:

    if (rs->fetch) { ... }

, which I think is cleaner. There's no reason to rename true/false to
FETCH and PUSH if the field name itself is already 'fetch'.

Thanks,
Taylor
