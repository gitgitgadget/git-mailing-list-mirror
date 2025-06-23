Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6A227B8E
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717937; cv=none; b=LbsmRYuO2KvQgZKmu6h18AprFBtAt45T17A+txt2cQU99V+aT0YrqJdYhqGRFLNk1s9y4piW6dpsfEvSa6oFGGoetOEkXBV8Yi8iZ2GJL2Twq5iTx9s4Zm+bJqWKYEMZUqIhMgGUECP8Y4a8dKOvVNS7GeHJ8laXBP/tlSAmDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717937; c=relaxed/simple;
	bh=MbCoPkb3VVrXgB945pEjTT2QVb495ura8cLJFlmCDkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1ohv7xl/mvA9vGASNf2CfnWtM3Fo/GnIwYGRvrPNUd3X9VuRk0zlJ4gPLN3bY08txnOCbB8UVETa1WttZQtIJTKYHzTuGo9UVkMW/m4y7WOKuinnzBdOTYq2uuaD2ddPZFwLhU4ph+1dLmOhvxq3ylTnXX6dHCSDKw5WSQnoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oJdgVdl/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oJdgVdl/"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-708d90aa8f9so46532077b3.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717934; x=1751322734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2P7CkkuV/NrpTzVvwHtCEfPIvFxoeltEMfuP+K+qf8=;
        b=oJdgVdl/bSdRSFIStuMDdcETChSuGf24a+iuMJ3DNxkRQU+7X2WY9/E2tW4OoUuqT7
         9nr1o08EEKNqK/9Uc8klBs5k2uqEq7B5Z73InkPhNAw1iBqm5NplRsZDvqMo2gb6gGQU
         5FOhpKe2ANV6Z6xxEW1W5Lnx2Z2FnrtfltRry4+fGf53CWYnpLapLcElSGq90wUTupBk
         L9BQiFGMXho3mRW/zT5gsfsQgwb03hmwvbgIQf1FOVbfXvt7HXpxpTldepsszutjMJwB
         5Dq67aWdsaui7kCbYJk62a1UUNsf6er/XM9RuRE17op9XEA9p10v3ZjQ8dv1vMprTevu
         yraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717934; x=1751322734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2P7CkkuV/NrpTzVvwHtCEfPIvFxoeltEMfuP+K+qf8=;
        b=T0jkeQ/frzF6wkBFS0dQXJXz2T2ONZVS2aEuhu+LOL72EEx7bpqduRTp0FJ73aUwyO
         GmMUHd/JWwJsXFEJ26PK3cO794p3Y5cIQ7mSeZHb9Fgdq2R0v5luQkkmWZ2m1jAwDa9M
         Ffh8MiOH2KnIyNahnTkFetqlLrG0H57J9v1sMI/0MLgTRu+L+DVDX3Ayl+qQzTj6qtQg
         9Y5CH8WqPrheiZltKDUZjarVksNugaUl7bg+zjyMxmddZ4S48Jl9kj1eUOsdHZMrUMDv
         9+KIxS7wJ+l4Ogy0oSsT0/6URhHNQMlLJxo7TTabvMVI3yCV1fGi3b25suFtvuwdMRxZ
         E6oQ==
X-Gm-Message-State: AOJu0YzW13gB/jG/yYt3SR+b+DIBGpD73bOsAowdiUSp/wXHdD3LHOUI
	SjsAu0A2/TDDCf7wxkclng8mv17igZN/TZuUzxFBKD1QtiK9rCKr/KDS7D5mAZjnzIlcCIC6bFN
	6TE6b
X-Gm-Gg: ASbGncukTFQ2kGt9pJNvsKkN6TCmaF/UXtI0GyiXD4Yxsc+/jH9c4/KiS+L6CRx035U
	E4Xhzymivy5i/MLATUcxqw+gXppUcUQjmq5YWzRMUy6mJQTrOcEk/y/ISXe0jgCmi2oCmPaGLLg
	wwzECaocNbhYZTeoRya11RCsAJBBfd12snMtXjTvLhGi0sH9k+hjE+8gbTQv3O5+Qkx10oXVV+q
	KQ0Xr7DPE64dbwv22j8iwYxGVENNFTrzg+8B2C+p70rVlAuKgJyNnb4RX7ElYEOVX9KUp4vhdaO
	lBelQhIHp6P8GED5ATIhkoTiAlOtKqSbuSV7ZtmisT+wGc8jJqj9zgL5EIv6L67n79W04o3uVLl
	xsGQRdYq4NSQBNAO0m9dzVhudLACOs4+35Q==
X-Google-Smtp-Source: AGHT+IE7yk1/ZhZth0FNAPL/muVv6gCFvQcBzcTx0ygIYf4Cey1Usc3WrMa/Q0xWPgtjlEuwD1H0Yg==
X-Received: by 2002:a05:690c:6b0e:b0:6ef:652b:91cf with SMTP id 00721157ae682-712c675e2ecmr203474497b3.27.1750717934244;
        Mon, 23 Jun 2025 15:32:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac5c538sm2694784276.33.2025.06.23.15.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:13 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <86fb36d3176198fa350dfaed261e8ae64b49b355.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

In add_object_entry_from_pack() we declare 'revs' (given to us through
the miscellaneous context argument) earlier in the "if (p)" conditional
than is necessary.  Move it down as far as it can go to reduce its
scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7274e0e00..d04a36a6bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3725,7 +3725,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
@@ -3733,6 +3732,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.50.0.61.g1981e40f2d

