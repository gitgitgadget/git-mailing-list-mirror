Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB371803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958676; cv=none; b=EKoUJf1kmAp2qKBJJLyuhWdtnrsPWudXEVmjjGThvbUg6Pr5n5SQ23aAnC0CXS2WOkXnzFE6YSQqI2AQgklEOPvoWBX/nyeeXO1ERe4n7n1QO6oIgkqQ/gBOwQmdeeKGK9zwCP/rsDX2ETofwfAUwAipNnC/bHjOF7LkTT0Px+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958676; c=relaxed/simple;
	bh=Xym2az8nIzWRJRGL1p4CLKPdfGRz5u+uDyzG/rgQtKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZj17CgWEQ1ai3F2fA1SgkCKccyrQFGrmQJByn5xclyyaL/q+8KsfG9G/3z1xlWUjqo+wchbY8hQ77UOE8HL+ZrCeM2Wcq03W8lEv7xXpxnjmfoCdY8Xp+L9e7wfdDmF9TMaEq8GfWFxAQgUuxQPsOEDWYC8uggaT5jTEPuavEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=I3Tfi+au; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="I3Tfi+au"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0b167da277so759256276.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958674; x=1723563474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+XHDDSkiW4aIWdzDSuaHryfMbsYU/x3XE0s8rQEBQ=;
        b=I3Tfi+auv11NCzcNC/QiBSNrt8f39NyB7WS08L7JZZoFh3ySjXVRlufMb57vec99Ml
         l0dW8iLZYu1IDjRp2J+Mu/wBU5lhE2Lzxu2GyFTIs/4aKQnRLmFtDlPw6M/U56NQMOmx
         5GnfTfj56c0gaCVzHmD9D9RShfrQfplmEI9WI1OdyRcZvH24x1MIVNGwiTxISvjkiG/Z
         SsC+K4SN32bR8mwn7FyExAQQx3D7xkKtvcUWHweI6warEqnUxJd1yP3x2NiK1tcaxId7
         jSMhxzqk01IKjOcS/g6zMzK3BEoh6ppQqKaQZJ37d0cMmYUDtFrOPF8YzPSIOD2bRd6y
         gnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958674; x=1723563474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR+XHDDSkiW4aIWdzDSuaHryfMbsYU/x3XE0s8rQEBQ=;
        b=kyDCB4Bjh/qLlz5J0/XX1Dfxch0I+uwc8C+ouGD0o4KR5JjvkoZ9lCZzk75ZVEc2nd
         vJffv22Z0duusiC6QihK9At+jSP1KGRskg3TXgG123bEq35VytWqGUmthe3oAf/sBSOX
         8ZkhDKw9E/3kKwkL3ukBapTczipx9bnRQ6n5W/Qi3wufYma+XAmKc6YDaw9cGby9bbPr
         5We0Tf655iE/NfbjR17fUnyAYOLbfx7RbxlduCDUS1PXfhonsQfqugHR63uqaGJp+7A3
         8u9GavNWMVYbsdP1zPifYl5Lc41qJI+Fw9ifbTu0Zc6Z5rADnu5hMP9OJum61WSjkxTJ
         nxHA==
X-Gm-Message-State: AOJu0YwK+QSGx8zx00Xhqir49jlbF6NJA1miRbJCF/esEF7dOMJhr69t
	xTfFzZT2+I0Y6F2ehe8ccQpej8ViMERlY8SAVekr9lEaG5ydDA3YO7pCwtF6hWzEmjrKN0a4AQM
	Q
X-Google-Smtp-Source: AGHT+IF038dUDNykiYgC+GEQSarsqeOXFnyBL3m4Owx81JL4Rv5pfnx7sw1hztaVZjy3werrBMvkQw==
X-Received: by 2002:a5b:708:0:b0:e0b:c50c:e26a with SMTP id 3f1490d57ef6-e0bde4cad35mr15969452276.35.1722958673682;
        Tue, 06 Aug 2024 08:37:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be50ef3f8sm1737944276.0.2024.08.06.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:53 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/19] midx: teach `midx_fanout_add_midx_fanout()` about
 incremental MIDXs
Message-ID: <550ae2dc933c6d0c45fead9737e405c4025af9ad.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

The function `midx_fanout_add_midx_fanout()` is used to help construct
the fanout table when generating a MIDX by reusing data from an existing
MIDX.

Prepare this function to work with incremental MIDXs by making a few
changes:

  - The bounds checks need to be adjusted to start object lookups taking
    into account the number of objects in the previous MIDX layer (i.e.,
    by starting the lookups at position `m->num_objects_in_base` instead
    of position 0).

  - Likewise, the bounds checks need to end at `m->num_objects_in_base`
    objects after `m->num_objects`.

  - Finally, `midx_fanout_add_midx_fanout()` needs to recur on earlier
    MIDX layers when dealing with an incremental MIDX chain by calling
    itself when given a MIDX with a non-NULL `base_midx`.

Note that after 0c5a62f14b (midx-write.c: do not read existing MIDX with
`packs_to_include`, 2024-06-11), we do not use this function with an
existing MIDX (incremental or not) when generating a MIDX with
--stdin-packs, and likewise for incremental MIDXs.

But it is still used when adding the fanout table from an incremental
MIDX when generating a non-incremental MIDX (without --stdin-packs, of
course).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a77ee73c68..0accbdbb04 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -196,7 +196,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 				      struct pack_midx_entry *e,
 				      uint32_t pos)
 {
-	if (pos >= m->num_objects)
+	if (pos >= m->num_objects + m->num_objects_in_base)
 		return 1;
 
 	nth_midxed_object_oid(&e->oid, m, pos);
@@ -247,12 +247,16 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					uint32_t cur_fanout,
 					int preferred_pack)
 {
-	uint32_t start = 0, end;
+	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
 
+	if (m->base_midx)
+		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
+					    preferred_pack);
+
 	if (cur_fanout)
-		start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
-	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
+		start += ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
+	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
 		if ((preferred_pack > -1) &&
-- 
2.46.0.46.g406f326d27.dirty

