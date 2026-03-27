Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CB3FD156
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633879; cv=none; b=t0gBzrTRKy2XU47dIJSSGxtRUZcqwbpB+OtxTlyHz+0mlECwgThtIm//KjbQXD+wzwePzz/8fCo6LkW6LXAwZPUFipV+RYYpSACik+qMTtqZVKD8zWN2gCsi2gq4Olza/u4mR5QtWkSrtDm1VmakIVIcMKsPiOmTVVfV4TmAwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633879; c=relaxed/simple;
	bh=ikYO0lLloZEJcRWWC99/RrbVY1/OnvBE8isq48o7yxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmPfImDEtpHneCq0GV44/msts0sU1RJnodWOXnr63rFkWLIhZ+B1NQhQDIMDluIkSWrhUR9azVLz9o5aJSHeJ70BZ+5mnEIgiKanfuDxW09ZxgxqCxPf3U3Tiw/vcuoVbuUL3DzqdEouauxPJYn1XtlCIhpefjx8q2uoIr1+QV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qArnlZa7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qArnlZa7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-793fdbb8d3aso27965837b3.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774633877; x=1775238677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7K4BnOdYw8riP54smkGBaBI45/SK4hv8Turdb92LBk0=;
        b=qArnlZa7c55H7+zT22iYrbfk+dCEN4LAfyb6fDBHwJR0Z866l2KF2cjb2HfWD8tDm5
         9eo5DGYfPblznfW17OdOEHcJv5UmFAS4TRIbYEiHUJ+nRVr8zgfoLlq/6k0rEbY++LKW
         3x7GEWJ0tlBTsbSOQGaIClbCOEZXbPWqgV95a6d5q03Rtxg6IPWTmr4hAXVsBDzkc6XK
         AdlYgxBNz3wwTbgnm1D+wn1AHVclL0jZVVHO8ZJjQvMm6ThrC/R2ebVO9QniWIHSduQq
         5VgXprmyzTEMqHsCpVfz6eOymn8a/4zfEsDudZWK6uY316g/UwmpvsWYxG1+z1aGrWCH
         1OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633877; x=1775238677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K4BnOdYw8riP54smkGBaBI45/SK4hv8Turdb92LBk0=;
        b=kH5LrBekh5somI+NXRZzXCHhEsr1drf8NszV7la37eSVuvGD69YBgnDvIY/ok3MjjU
         d0HLGUvhIbc6k+fL6QI0byPsehymX256KTqpEHgg2DTnr+JKtfmKcYbSxMj7v8tlGd7K
         b8mKTd0kejrXUijLwJyR5EE5tAm0TGArh9hWrtBdYFQpFvegGMtLbSHHn6c6B8PxUIx2
         Yrbb+rok5j0GmlMEE0CUmDm9ZI9oEbj5UNltA9v9uZd7dYSzTOke2Xdfl+KFfZAtEoVi
         GXRncXLs7qJWjbXcCifLtlyG170xbhvMGQB/Il9MkXpy7F1axtjNBU/UAEKCgBEXUr/U
         ZblQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+EkDy24bHcZMGHRFfSi2eJ2uBuov7Wb4OivQo/6kILC6B0w95gsAGUUj6oA8dmVZmGUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKYfZfcNQ2B+hHiDoK7eSw74yuUMlZdCW/r++IocNQYX7CP6F
	kjR/jHuiQJ5iWu7zsmn8hvRl9VY3fQSbMz63ZucKCad9/XxdwCcBumH3tf+W7xzOO2iSDY+mCZq
	dNIXPYX2z9Q==
X-Gm-Gg: ATEYQzzCl5e1oCy4e5NSFWL6s00/+0ZT09yQ1cT2007AW3sJSeC81HRwsI9C741MXiG
	Ayv4UkEgP8ZmcrCLbyOIjeri+dr5glbxc34WLh0P5NUnkLzTpyCfD4rSCsH0yd0LpGga5J3z7Jq
	PrfWxDvSW3ebgZhA2i5EECQpdy+/HUGfX0sRmWMhfWAyhOciAngZgngLqOTseaWiKiQW2zzBdUN
	QIWzhkoU56fX/v4ZYqyJZUDeHFyErlOetVeYJBNq1YO5e9w2DB9yJnW58sqBtMGd7psANYRxh2Y
	Ha6QrHdc1c0kdaerBEr9Qp7acZzkFkVeM53mzwydwkT82R026W+IPar7xouM6Nkg0xOQHtTMxZB
	j2NQd57+QgaD4suQvm+ovqcUSak5uKj60RK0mUeVBXUofJ/ijDeR6pGt/c4WjH0267wa/CjDzdb
	I6L4bEOHsSly1LJ1tcEKe6WG67dvy87xJx+vXkL09kIP2Bu4dXxlnnpRX5Bc8cfljw47XC1EXPP
	QBTvWzHNPz5vAZGgl9mSOFEZrcdUQ==
X-Received: by 2002:a05:690c:25c1:b0:79a:3e8d:9bd8 with SMTP id 00721157ae682-79bddcc0e87mr35249007b3.2.1774633876992;
        Fri, 27 Mar 2026 10:51:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e43b825sm33790977b3.47.2026.03.27.10.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:51:16 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:51:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acbDkI2vDXYu3mvL@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
 <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
 <acWoqXUwVUB2/65T@nand.local>
 <xmqq8qbensw5.fsf@gitster.g>
 <acWz48NfB+dlbHAz@nand.local>
 <b6e6ea33-76f0-42f8-9546-2e900f239530@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6e6ea33-76f0-42f8-9546-2e900f239530@gmail.com>

On Thu, Mar 26, 2026 at 08:29:57PM -0400, Derrick Stolee wrote:
> On 3/26/26 6:32 PM, Taylor Blau wrote:
> > On Thu, Mar 26, 2026 at 03:11:06PM -0700, Junio C Hamano wrote:
> > > Taylor Blau <me@ttaylorr.com> writes:
>
> > > If these STDIN_PACK_* constants would ever appear _only_ within the
> > > context of talking about the .kind member of the stdin_pack_info
> > > struct and cannot possibly appear anywhere else, then there is no
> > > point naming the enum.
> >
> > Yup, I agree. I'm inclined to leave the enum anonymous for now, since
> > the only place we would need a name for it is the suggestion Stolee made
> > above, which I think does not correctly handle an edge case where packs
> > are specified multiple times.
>
> I see that I messed up where a '|=' should be and where a '=' should be.
>
> 	const char *key = buf.buf;
> 	enum pack_input_kind kind = STDIN_PACK_INCLUDE;
>
> 	if (*key == '^') {
> 		key++;
>
> 		/* THIS ONE SHOULD BE EQUAL */
> 		kind = STDIN_PACK_EXCLUDE_CLOSED;
> 	}
>
> 	info = strmap_get(&packs, key);
> 	if (!info) {
> 		CALLOC_ARRAY(info, 1);
> 		strmap_put(&packs, key, info);
>
> 		/* THIS ONE SHOULD BE ADDING THE FLAG */
> 		info->kind |= kind;

Right, though the problem is not that we're setting the wrong flag bits
(though I agree in the previous version of this suggestion that we
should have been OR-ing them in), but that we're not setting any flag
bits if the same pack is specified multiple times.

Applying the following:

--- 8< ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 52bad8cea90..37c69f307d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3833,13 +3833,15 @@ static void show_commit_pack_hint(struct commit *commit, void *data)

 }

+enum stdin_pack_info_kind {
+	STDIN_PACK_INCLUDE = (1<<0),
+	STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
+	STDIN_PACK_EXCLUDE_OPEN = (1<<2),
+};
+
 struct stdin_pack_info {
 	struct packed_git *p;
-	enum {
-		STDIN_PACK_INCLUDE = (1<<0),
-		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
-		STDIN_PACK_EXCLUDE_OPEN = (1<<2),
-	} kind;
+	enum stdin_pack_info_kind kind;
 };

 static int pack_mtime_cmp(const void *_a, const void *_b)
@@ -3927,26 +3929,26 @@ static void stdin_packs_read_input(struct rev_info *revs,

 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct stdin_pack_info *info;
+		enum stdin_pack_info_kind kind = STDIN_PACK_INCLUDE;
 		const char *key = buf.buf;

 		if (!*key)
 			continue;
-		if (*key == '^' ||
-		    (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW))
+		else if (*key == '^')
+			kind = STDIN_PACK_EXCLUDE_CLOSED;
+		else if (*key == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
+			kind = STDIN_PACK_EXCLUDE_OPEN;
+
+		if (kind != STDIN_PACK_INCLUDE)
 			key++;

 		info = strmap_get(&packs, key);
 		if (!info) {
 			CALLOC_ARRAY(info, 1);
 			strmap_put(&packs, key, info);
-		}

-		if (*buf.buf == '^')
-			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
-		else if (*buf.buf == '!' && mode == STDIN_PACKS_MODE_FOLLOW)
-			info->kind |= STDIN_PACK_EXCLUDE_OPEN;
-		else
-			info->kind |= STDIN_PACK_INCLUDE;
+			info->kind |= kind;
+		}

 		strbuf_reset(&buf);
 	}
--- >8 ---

fails t5331.8, which verifies that pack-objects correctly handles the
same pack being specified as both included and excluded.

But if you do the following on top of the above:

--- 8< ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 37c69f307d2..b6e4f950a67 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3946,10 +3946,10 @@ static void stdin_packs_read_input(struct rev_info *revs,
 		if (!info) {
 			CALLOC_ARRAY(info, 1);
 			strmap_put(&packs, key, info);
-
-			info->kind |= kind;
 		}

+		info->kind |= kind;
+
 		strbuf_reset(&buf);
 	}
--- >8 ---

Then that works as expected. I agree that the end-result is a little
easier to read, so I'll squash this into the subsequent round.

> If the small tweak to my version works, I do think that the readability
> of the new organization would be worth it.

I agree! Thanks again for the suggestion.

Thanks,
Taylor
