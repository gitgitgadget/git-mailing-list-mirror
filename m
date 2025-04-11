Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8362BE7B1
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413987; cv=none; b=WnJEDgkc2E4zL2HVK+7SrCF2NUl0pJFrz0JHGwD8n7kVC9fpG75SMVdB98vRj/d1XZ3XqrxWl3u7NSyz6/qUCTNsO2u5/Q7HflACy3ky5lYpOH+yf9vWqh04oBIwODOj3ZhfsLAhG75CGSlUDVsuBtwb1uXTSDQJmWEHwmznBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413987; c=relaxed/simple;
	bh=NB2cAdmufL3V6Az6kIuBj/iYNobliVsmUdSypPw0uoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTmrVRyQZWaCviR+eWqVTq1EmB2hny2FBkRBaZTCXhH/2McBXBBDMt8kk7lAwQq6Ce/aCcTqEJsCIzaS+xG8D8lMJzOg0zt45fHqbBlZzOYzJ+NNW62oGXIHXrHKmBzb35+Nl9Id9FXmDswzuNGDMo0+mPxulwf1veCk2NeyXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JGSHgSbZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JGSHgSbZ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476b89782c3so26158741cf.1
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413985; x=1745018785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khXxc1vF6BJaAq4IgAvRk9E0N05RXVeO5PHGLG7X7bY=;
        b=JGSHgSbZAsRS7wKuJfa0LB0bm9ZuvrqkHUdHxmdJ9trfn5c3w4HVwONdCAB1KenFk1
         hP+vEWBBQJyth/fZll+r1SeIhj/CO4SANwFQdrBIkJUIw3zO2bzFiGUv2Y1A7TYCr7w8
         FyFiOXSM878jGjfgjvBtClEdSGVmpexm0hAs/NxfSfgT1MBdQ/DDnqwA+wNBK9j+2dEt
         Phdli9+iLDGiLCYsaGw53E5JDYE9li/NaS35MgxtVt9iqnoAZIX+nURDWNDyAozW3UWq
         Heqbxn6a8qyvmkgbRIXifGC6WAVUskavKX7Q37dfgChvYuxX8BaF1aQug3GnOhXcsfUr
         bJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413985; x=1745018785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khXxc1vF6BJaAq4IgAvRk9E0N05RXVeO5PHGLG7X7bY=;
        b=U5iNrwh1BNDacPUAVesFhc0sOPnbHSY5r1UKv6XNmPVS6sbToTq99+sIUHg7SUeDHL
         ZjVnex9MXnyExfhbsvevzWGb1BhyInogWyZzfsfaP40kyVzaTvela0ws3uWQE1ErGBmG
         HmOc+4vPGIzMQnY3nYO3C3g1xHv6JqcqbS5GzvKWbWiHTt3s2NB6iEWr+YTT38LDTTXG
         r+2ArhMP/ja6F57v9MkaRTfRzwysLyXlhdEn5mI9XJwE16yRtrxu2FlyVpenmKuwR0zf
         SbqKZoXYGbBRMaq51zpT1cey7IN0djtFNjJ7KRGRfs7N0ZjVysRuT0kfLe0ucP1/EpjE
         RuBg==
X-Gm-Message-State: AOJu0YyDAPpHXh2KtBLUOWCAKm8Ivmy990+YSZdOCsekl/BuJm6hOMBA
	577tMZqxnPSmrkBrGYIdZbNaGZo+Y9FwieJG56UhKa6LeTsDaDqpM8DeE/7aj2V+lnWeEp0srHO
	ZMp4=
X-Gm-Gg: ASbGnctofvG/67adiinzETEIatynmR4EmT3Cvom/mT5c7jgYnMVRGQ/esfrbERxL1f7
	pdSNqs3yUuvApXOAk8ASB43o6BE7mIdXp1z+WfI7KwVPHDCUP9pcZmKZODMNCLXbuz3elZh+mLs
	Q6Ta+ALQmb1pglJiAKxqe6961KRP1EcyxQHZZ2HPajRb1+D2GYEOMh3nmgo9NLVvC/xRdeaLgVw
	uJyoQcSAAQyGreL/yoi6QPbgEMaSybJZDzilP5dD/IEE8Y+FzS21o6WDjks5sbvNx5nZaoyDV2C
	R/QQYHWRpE3vmFuL3c6rq6wbewLj5T7XHftR1ETp/nydaVJ2lvjphO+efk1Fs6hA+MBCGn9P4Bt
	4+fa8yJO+unLn
X-Google-Smtp-Source: AGHT+IHLjRHLdIyB/8HkhDkHXAMJbX+IpIiN+CiozKFW4uWfCu6mke8s0kpiNkXgRyPKM3TXX25Qtw==
X-Received: by 2002:a05:622a:1649:b0:474:eff7:a478 with SMTP id d75a77b69052e-479775ea817mr75940561cf.46.1744413984684;
        Fri, 11 Apr 2025 16:26:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796ed9bcdcsm33415141cf.49.2025.04.11.16.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:24 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/8] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <6357633f6d144f24ac561ccba908aea3aed7aaaf.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

add_object_entry_from_pack() handles objects from identified packs by
checking their type, before adding commit objects as pending in the
subsequent traversal used by `--stdin-packs`.

There are a couple of quality-of-life refactorings that I noticed while
working in this area:

  - We declare 'revs' (given to us through the miscellaneous context
    argument) earlier in the "if (p)" conditional than is necessary.

  - The 'struct object_info' can use a designated initializer to fill in
    the structures type pointer, since that is the only field that we
    care about.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index aaea968ed2..540e5eba9e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3490,14 +3490,12 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
-		struct object_info oi = OBJECT_INFO_INIT;
-
-		oi.typep = &type;
+		struct object_info oi = { .typep = &type };
 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.49.0.229.g19b69c1246

