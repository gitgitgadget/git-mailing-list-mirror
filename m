Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468330EF96
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567311; cv=none; b=tFDPHE2AvJb46b/oA4DAxkB+UnVWEtBWmkkAOHclTW0jiVINh3YgpBawXcC4V1vL9eS8RiVYHZkRVaXEJqM1AL9WZpJYkBjoQQUIwzHtcwLN26NQw9vGb6iou2Ma2N9QRbO+XbbGB8Ge06nx05snu+U7V5P/mUATTVUdEVFe3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567311; c=relaxed/simple;
	bh=6TCs/qvJB2CEMVdjToP7u0t4/7Q1gA1yXnvGnwcWJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEssEY43Qs5lBLf6dRiXdmfluDibCGU1m8IU5i8hOiu0tXe55ai6WQ0W4IPEgeMteVkvQN6GEnePRGV00y9R/3NhZX5LFBun8WYG8HVXaGwsJW7cEWsKCP/VN2UJlnSYPTHOVbKRGSuK7IwVLh44z2muRCEvc65skMjRR7vDF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MKv/DVxw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MKv/DVxw"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7817c2d90d0so1099507b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567308; x=1761172108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxOv8D7DqmTiEc5K9K0eIN+ob27tXGIKgwlNEqRlb8E=;
        b=MKv/DVxwd366ZOIJ//cO/u0SiI5rhm3UTb/g7FN4NofCrH9x/8ca+z3D2/b2TFDOF1
         6C/Li9LwfT93RhqflLkb89N+9G33OO0ik1MV1tExkdOmTppRg7OdeS/uxHGTZcGnAdxK
         xJl7gqvAq/YI54ek+H6EP1atAXrgBzNtaDnnzlxZIWkbBa2hxpNOEbsBeRpzxKoLKI9m
         wAP04znFbteIcEHfi3QXIJrqq9Rwdm+SJdxGODakbQqQ5xpyK6LbONOqfloOlNAIgmK+
         ErQ8lLFiMOn4YepuEdeIGP7zrosIQKZHEXsLlaNxyIylkIUAWrvAVrWedmcL0XlQHEZL
         ZgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567308; x=1761172108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxOv8D7DqmTiEc5K9K0eIN+ob27tXGIKgwlNEqRlb8E=;
        b=DkE16SaSbY/Z3SWL23JHsE/Afpan8i7huzn0C4BheC2PfyiETUXpH2bn0qWq7Akaam
         e8uvvJnemwKShFVRVOekmOUVN6UIdS7IUz5nY8lu0gSxuHoPUh7vZsIPnSgUMvRkVklB
         VbFPfIAQNi+ofAa5qNQmHCIKCWLymE5fGiE362g048hkuAPTclLYMNYKJZl5xJE2RkUZ
         OdOMRBiIFBcMLIT16ojI2YyxCnEnpB+ak6+tqAjrrTxfb1QZj3anSX6VxXgf3MO8kfGY
         IPMJlDTkJxzww85jKMA2ntKyUJRWVmx3iVUla9MwWv0/gFa4RjmnlSTgTgrhbJsZQZbG
         0wvg==
X-Gm-Message-State: AOJu0YwarEWwbx7S2fUyXtz6U14o7PSkXqsyHBVQHQy10uSuM8MzjRhN
	O8zCbU9+tO6PzccywtbALXtYFNEMbrBgyAjc2K1tqBSaMOJxzQjVqI33UTcrFvOa22bZFpP3JYV
	5bQZNxgx1Yw==
X-Gm-Gg: ASbGncviDAstf9U0d+jG8M3zbdow33KYFh5UJ8VHRL++mjyLEi39tO1MT01lViXr5M1
	sInkrg5b9ykQryjHnd5lnxKfVre4uLX/ABRJoGMNGsfs/WuENbU7Jv/NMMAA0JogARKyxi9KhjF
	E7j8m8nRvu4Wn7M1jgEC89n2QNU4afRpzW4/GCKbX/8LZmozFAXkJVvDqEWEZQzm2H+wLiQZvRs
	q07klyoCSD4vzGxXmJJAOWHQz41HMa82AvjLhwvKCfIIH7pJO74fASEMWmkzqDWUo7/iDGhA1Qx
	SdwdoLnmMHhEFGDjBhX6tDzuSguhLlKv8LtBFQsVg4wLa/ypI0AvN7+Ss/6z0673y0D2d1P/37Y
	qCj0gUPHauVlaD2Td1z0rgxGaDmdA1YWEpNwUTn0z1v6dSGAfP8EKBD9+PEy463Rr4vsfZx9Ck9
	r96ZQ1YfFhjxQPrEQWSqQ+fONrD+NLIXGdYFyC3sjrOMFkxlo6aQOW/UgGCVgtTxCHFTgljcZ4S
	OA7XJWZWSjPHIm7YQ==
X-Google-Smtp-Source: AGHT+IEtbh3hN6HWbFXwf0av3eIkrxXa20jKLuOjtUDClg1EQxbbqhaGZ3i42eksqpElMSd71vnnTQ==
X-Received: by 2002:a05:690c:6e0a:b0:737:abf0:28b with SMTP id 00721157ae682-780e163949cmr318408187b3.10.1760567308321;
        Wed, 15 Oct 2025 15:28:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782931f5d47sm2583177b3.43.2025.10.15.15.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:28 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 23/49] builtin/repack.c: provide pack locations to
 `generated_pack_install()`
Message-ID: <2b81a26a843a9d9070bd5a41cdd741067079149a.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Repeat what was done in the preceding commit for the
`generated_pack_install()` function, which needs both "packdir" and
"packtmp".

(As an aside, it is somewhat unfortunate that the final three parameters
to this function are all "const char *", making errors like passing
"packdir" and "packtmp" in the wrong order easy. We could define a new
structure here, but that may be too heavy-handed.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bed902adde..966db27613 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -185,7 +185,8 @@ static int generated_pack_has_ext(const struct generated_pack *pack,
 }
 
 static void generated_pack_install(struct generated_pack *pack,
-				   const char *name)
+				   const char *name,
+				   const char *packdir, const char *packtmp)
 {
 	int ext;
 	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
@@ -1468,7 +1469,8 @@ int cmd_repack(int argc,
 	 * Ok we have prepared all new packfiles.
 	 */
 	for_each_string_list_item(item, &names)
-		generated_pack_install(item->util, item->string);
+		generated_pack_install(item->util, item->string, packdir,
+				       packtmp);
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-- 
2.51.0.540.ga7423965ad8

