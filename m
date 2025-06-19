Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9028ECEA
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375818; cv=none; b=R/DjlLkymlUHc9WhmGHuNbIFzGjPUhu6a3wuUKSP4e5X0V3PhzANYyVv3Yh2gMjYrPub1BQqBDPJZUqTOKPUyB6Ckn9Ph0PFB66vLcpQXuBeX4tALixRRnabYv282IjWobt97ikvOFF9Uc61cEa0uFc7S7wGJMHYQvEDXd01RGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375818; c=relaxed/simple;
	bh=dncQI5rBRQwFfaitPxSdW0BmwVVOtn+Hr22cXrvtMw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5olkpa7xV2/xLdyFxOorlfehT3Hl1guI2EGLLMhAUde9Z0X/7I0mq0UgVrDmtBr9NH0RFeQ8fn/FsynQbcQoxlMr2iPKkdDFk/G3lzzRT5qDYvCIvcO/wi9gUdu0fxTPB9/M7/x8mYy3qiQE4rsarsWFyTMs15v6MLR95cZjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oEk0X9C+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oEk0X9C+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-710bbd7a9e2so12875507b3.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375816; x=1750980616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rPfHh4yqQFKce6u8+hseK71R9f9Z3gOiKivi2xgg6XU=;
        b=oEk0X9C+KUR/i2t+jnYOZofr3SnWK2JuSZgVBMo+UPB6KnTAei9GkukFYqGafl3CaR
         //d0Z/hXuxsKL5yjHy2a3zJQ/0kYAoS0xRo9F7BVw1+TvyhWjEaiwTWTtf6BKs0tXodj
         Wo+BIfJ8hvP6+8fEceEjqR7Q1gfve4DQ+4nItZEhRgYTKjmso6W3s1g8eFCpBihTN9at
         496WKxZYYMMnK5hZ9kbO/y3lf96EPT9/ZvMr3Xa0ePxViREKrbb2zWyhLkP/lVZvPZIo
         ovpC3SClk7FjduPFQQfvLbzioJIv5sM0juj/p9JkBRQezoCgPqTD89iJiS6dBQrb/7Bt
         6rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375816; x=1750980616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPfHh4yqQFKce6u8+hseK71R9f9Z3gOiKivi2xgg6XU=;
        b=R+F5Qe6JkVWhdr9+iiLQ9SEOvWj386BsFdWrUvRom3F7miLTvANFgTxx57CKYQHvJg
         dBgrdVH1p6lMVFYiyE9L7JQro3q/LumdHBxyEOzWEyTWpcnt/WPt575i56vWhYzdEaJl
         d0CSxEl3fKPtjDZ8rCPswuveGjlGBXR0zvl2QYXxcHO0xlFkbWPv4y2hRshik5/kDIqy
         Dw9SekGoCkwV8RJf1zAd5UFhzjxrbGutjwqAD5+1TmwwQncF93jebwhc4O6M+vmddHQm
         1BeEfWDTCkibpkvGcX8TCYawj6Z8LjMmsVAI4BZKC8/OI7YfAAqqbcBn9agqYy4zj/6V
         O6KA==
X-Gm-Message-State: AOJu0YxixL229dRwTJ6y5gdccvxe5Xtp8oDIn8iKb+q0cM7r+TP4L7sg
	D+jW783t+AfyRbmPi8c/U2DpNhhuoONjksQqVEp0Oad4qNSDDA8uha7v5QLPR6Wf6mHYgK0kDaW
	hsRFw
X-Gm-Gg: ASbGncv5wT00VCqivfmFb1vJ/RcasWbi9wWmdHGV9uto/1rilONIVA03bjI9Nj6kMMp
	MLldK/peu7JopWpvlstIvjA2A/GyzUW4hm3HExDiHYTdI+u43eMR562vzKrUHcxNC3tUq1Tmjv9
	hzQKuT6XmQ974QerPFcrm+NSGwo8okP0dWbfIji+uUxKJd0kG/X5GLlLONl/bOi6/nfeKNvOEdq
	AHdiNxN0o2kG7JFY8X1r8Y5nHX/narqJgNQRkjck+16upRuyf0CnBmPNGFGaK++ncRvObHHbesT
	ffcI0O8MGnnU0V8qarDxwcsscn8H9k5/tR9gsuhOiNYMkv0iuhAgh7YCardkQQEZpubU7C1KkJ2
	8KQtvfo3u7kRY7IYQCM3dXwmHF24oPKvEhQ==
X-Google-Smtp-Source: AGHT+IHoy6lQXVUyTQW2JL1pJlx0UNfjBXYvETwPk9EAn16BpZBD2eb0d7L4iWAJ5U9yKHZycdzQYQ==
X-Received: by 2002:a05:690c:f10:b0:709:1b68:9f5c with SMTP id 00721157ae682-712c639acbbmr16677807b3.16.1750375815715;
        Thu, 19 Jun 2025 16:30:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4be30dasm2018237b3.98.2025.06.19.16.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:15 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/9] pack-objects: factor out handling '--stdin-packs'
Message-ID: <8d0492a80dd6df1f526f319dee3e95c395e53901.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

At the bottom of cmd_pack_objects() we check which mode the command is
running in (e.g., generating a cruft pack, handling '--stdin-packs',
using the internal rev-list, etc.) and handle the mode appropriately.

The '--stdin-packs' case is handled inline (dating back to its
introduction in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs'
option, 2021-02-22)) since it is relatively short. Extract the body of
"if (stdin_packs)" into its own function to prepare for the
implementation to become lengthier in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d04a36a6bf..7ce04b71dd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3909,6 +3909,17 @@ static void read_packs_list_from_stdin(void)
 	string_list_clear(&exclude_packs, 0);
 }
 
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin();
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+}
+
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
 				   struct packed_git *pack, off_t offset,
 				   const char *name, uint32_t mtime)
@@ -4004,7 +4015,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -5135,11 +5145,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		/* avoids adding objects in excluded packs */
-		ignore_packed_keep_in_core = 1;
-		read_packs_list_from_stdin();
-		if (rev_list_unpacked)
-			add_unreachable_loose_objects();
+		read_stdin_packs(rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
-- 
2.50.0.61.gf819b10624.dirty

