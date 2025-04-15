Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5882BCF49
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757219; cv=none; b=kwYyEKLlwKBKXA29NPJJiuvNTCUTX6gjevijEIwp+gXLe8ijdpwcTTflxaHFesQDhYdPI+vtS3HM1DC+8KQxShHfPGbQWZoWEV5qN1KkmgsOZaLMbmQrB8ujEJDnkXwh83PCqFO7oRY/0W1GO/JY4UoeV5vIZPOqjexDPTvSefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757219; c=relaxed/simple;
	bh=SzTBiQQnrItaSH0QwLfam/jj5h4h59pmDi+277BRWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd0H6G/G2mxOBcyznoHUsjjOyFUcVuLKACFgSvV/1Dw7zDrkAo7d1qsbCVOcOPwDrdlXlf9qCc0H/AfJeMsBBhlHyawn3g4CAEzkdPuYNjesRl9l4hgzExl3jbaaAR9VzEEmdvVyPXdjFubJJyogFykhwX5rqLTbb6Db913qb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=l2pRg2nW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="l2pRg2nW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e39d1db2so341760285a.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757216; x=1745362016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THUXxuoq3jBbce3nzc5a/iCchbKKxI2VBTZ22nN3Os0=;
        b=l2pRg2nWwjiAf7zh4BovR7SunONTbRlVsbyUCE3RywsCfPwQtW1uP9g/gaNVyShvec
         ZtfMVOiNb5AYughG6o0/z3jA44IBdPoMfYTv0CID8BFLFTNirK9Wzl+GAPcYm3lVJjCt
         WUItVEAzI2RNKC76YvVaYjMNZVnf5Y84w0v5RjXE24VATT43u8zLX7ztO98ZTzHUsNyS
         B2JfWHF7uRb0hsfALygxayN8IAbshcWzEgtBcMEBmRq6CC1IF0TAaLQGXrx7CiLArZLQ
         5PmGtw3Jmuh96Te52rnPrjwOTPx0jpi86L2hzHRC6LuTA4aVVvPYS9PNSztHij8xJO3w
         O1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757216; x=1745362016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THUXxuoq3jBbce3nzc5a/iCchbKKxI2VBTZ22nN3Os0=;
        b=jHEj1eR9eCoKFLYBVz4BETKO+UmIE28xKDGaOvm82yPOAlbniIsdiP6oZBIn+jsDcs
         9IR3hOM8lBvlCsvvMIuQZWSZHoSDuL5MNxQygQCN2oWWOkBBJNo3z5oYUpRyhP/vtulC
         BsvR9CDZgRvWG+7agKs0U6pgUYRlazYGxTWHrn0+o6jWdL0GUJsR4dc2j+lLd+93K/eL
         DtYqp5WosskbWKfng94b12PfR9TETmzP9M9hLK5YxsldaWzFLF+SoJivBL5N3QqzJ+cI
         H5b+QCNuSJn+eD3w2P8ev4CAokh6dmG6ufXltMBdwtecd9LOegPzGZcMd3b+WMwN+Cfu
         GsSw==
X-Gm-Message-State: AOJu0YzjAyPBTEDL5V89drIB7y+8U9SuTWSFOFTDlOO1YOgm2JcVJ0hm
	mPVspNk6hKnkcaqXKoDCdI7AT0P1tK2YceMR4tAtlNj0/pCe8R6UmsGRAmDCzdefijqwlc+zA+T
	Yltc=
X-Gm-Gg: ASbGncuySpUKhnT2pYZwX505/UKgTBCAxDCxtQt41l/D7vuiSJOKIkk/5gfrWV0Tg2G
	Htd3ye4N4sSPOhIcS0ZYkNFhminbIA+tL0s06PY/0NbBf4sJRy5uOWwNC8GyBHNrgd63xDFkoTj
	0zkRQ9suD4dAgLaI3pu7Rm21U0bmFl6cu511XaZ1B6XKUir1AB3+kD/HzkSo8OCdXEG7Y2At3RT
	0o03LVh21hEHEL49uxtFroXCk1E3kQRWkGJb6BhBBbT1Nnt0mw62BiQwRYiTk6nET5tAAUeK30K
	0DFdEPg8xl14R0aSxzez9E4xviUzBITucxmfZ4XV9Lw8XsAfpQOzBXWmsf58tV1sHjmgiOZ5Z7x
	7X7s96ZWeQyXP
X-Google-Smtp-Source: AGHT+IE7guyjeBqI13RuSpV4b3MnI4wrb4nYkUepuSyP4To1cWe1BA+NHS0Oc5HrGo1rO7/K4ggxvQ==
X-Received: by 2002:a05:620a:3188:b0:7c5:4be5:b0b1 with SMTP id af79cd13be357-7c914240fbemr190967185a.35.1744757216220;
        Tue, 15 Apr 2025 15:46:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb15cffsm99288761cf.18.2025.04.15.15.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:46:55 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:46:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/9] pack-objects: factor out handling '--stdin-packs'
Message-ID: <6f8fe8a4e10198b0339337376279cff4ac654879.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

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
index 4ab695a3aa..a293267074 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3674,6 +3674,17 @@ static void read_packs_list_from_stdin(void)
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
@@ -3769,7 +3780,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -4776,11 +4786,7 @@ int cmd_pack_objects(int argc,
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
2.49.0.230.ga662d77f78

