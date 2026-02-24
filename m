Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303A1DED42
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959641; cv=none; b=lRi/CElR0wCG0g/Eks3Iuo0yZtZdHoQbVt0tRKsyJW/ODSOq+mHLRuRzoVVlbT+hIYp08XdkQCl6lE5qksDc0N/byRhZ2xnDfqeFElcVMoQWpBhrVh7YxCgkEhuCU8IUtMemNO3BGS5O1MKs7z4Vh2qTXOh31qS9MNCvObvDki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959641; c=relaxed/simple;
	bh=BPBTDjx9AT22QaLYLhgiydCeN/G8TiD9g4N6xCXyklw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1zPp4+VfUqEf+cYJccp6nwjI+mytloOVvHbsHOHZoVvTC1e7zSzkgrKxzn2b58WIlBXOXqRRuxo/aq/Vr/Wf4Hl8R5uqoghYfKhZ3N4zDeDnvd1u6cV0d/hGT0tsUI/zc/N5wNIH/Ke2aC1ffBYlDHbCpiG7vHPxPc04kCKjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=RFRToitS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="RFRToitS"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a1627a09so35283441cf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959639; x=1772564439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajYcHiS+o16wlO1bsEt9lWMCJyoNbBI+jDvxGN/lPnc=;
        b=RFRToitSSnvwxUIibwj9ZxDz/Zgy4Cmt7mrEqm4WhoIA5JRVXs5HxmktccpLE3NOrE
         GlQY/SOPeMWVh+NlceAvDvy8wdT5ObFb+QBkA0W5kSR9w/tdeF8b/pdRUYDgpjYj0imo
         iRefapArakwqxdC3kBktzR9n/GC7lisp7s9J3EMX7+CYxU193FtgHsI/AxjVVyxgaYbt
         jFP53uZ/0Jt1VHRcSpA9YYyJSn/sACEYkKOSzeB9cede+1o3HRt8gOQekEWVDqIHmzUW
         tIhXHHmOBaDTscIvphg9XMNDhR3z9ArAAE6bkwr338EKs0s4+W5/4HXaY5ew8QDk+MXi
         CXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959639; x=1772564439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajYcHiS+o16wlO1bsEt9lWMCJyoNbBI+jDvxGN/lPnc=;
        b=RIXRo7E1DLiM3IqGe1jIkYV1iaaEEPheMDWQzpPAJ9jVtHO/jepoj8HLgXJNC8u1Wd
         JRDOZeMi4syOsueXWcDN+deefimNb/Itm2Ie7g0FMjbs33dsm89rRUSN92h5ILU4VwaP
         jdlL8m9WIoqpwDHdJK1tXtxe6BN05kTmkQbLOPFPeMm//wuEaYhPUxYdrRpTTm3tUCS3
         +QCZX9qxXybD17U528MBOxEWiD/Y7c8Ggr6EUz7asWTAU0zr9vFmbLPH6fKIVZOK+j3x
         rXxvJOETTsiE4hDZs0UZAoLNeyBTSar6iGe5j4wXJRk7RSJNfIkXjrU1cFLW+G3gWU+S
         G/ng==
X-Gm-Message-State: AOJu0YykMx/TyE3sZMue1c5mr1pfUtZSrrtSgCPv5RyjKAk/irYEBX4V
	+fzc3E0dEWZPEoGZTm160CZUdH2ke4UQYWXEPBI4ePCbtEJHKp29sYrByeXqe1Qxb8L+28u526E
	RflWIgxI0kw==
X-Gm-Gg: AZuq6aIzk6gacBFCFnu0CwWuDDFWhoge4515nE7rShkG4QVvRSMpKZ3zysK2J5tsyqI
	lhqgl8uxuyXG3ctWcLA6J36rO/fTn2syaqXLaI5Y0u0awg9GDnSAkLmt+BqCP4x7Prx7XgDid5t
	lGJfwrDZfkS7IKd9ct6U+dwJBLNdD2IY6JZzWedQWU/rtqHMYY8n80tDcSwBX04NVs1EW8I9FgS
	0kjfKm8VRbuewQIaKt1EYnOyGVURQIn0Gy2s2Iwm6L8kiM558IwCNRz2a+OG2Zz2Z7it/w7xYz/
	i/Ic6TTsYOzUrBA6qVl4WgnCE/mqLToX4he13K4JJ2eDUO2uYaoRWepebuiC6NHyfJ/GbV4JFlp
	zcHRwHGBZ1IwbvAHCX+6rmVMuDCRNusuIebkgZbeag7yieWdZYrPLJzgD2OAitSYMv+NJKpiuXO
	Cd8NJwEMPvTfSCjJy8LhZuHmVvia1mYsTBRrfVU2Br6TAsFRGcemgbRaMHSzN6zqmxmf2HU39vI
	wJQVIhwKaXTmIuIb4bJSir2mx1uBw==
X-Received: by 2002:ac8:5d94:0:b0:501:3c86:80b9 with SMTP id d75a77b69052e-5070bc66da2mr188943981cf.40.1771959638636;
        Tue, 24 Feb 2026 11:00:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50725d40438sm49997721cf.33.2026.02.24.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:00:38 -0800 (PST)
Date: Tue, 24 Feb 2026 14:00:36 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/17] t/helper/test-read-midx.c: plug memory leak when
 selecting layer
Message-ID: <505c8d72aa1befb07dda537945152b07b812dc25.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

Though our 'read-midx' test tool is capable of printing information
about a single MIDX layer identified by its checksum, no caller in our
test suite exercises this path.

Unfortunately, there is a memory leak lurking in this (currently) unused
path that would otherwise be exposed by the following commit.

This occurs when providing a MIDX layer checksum other than the tip. As
we walk over the MIDX chain trying to find the matching layer, we drop
our reference to the top-most MIDX layer. Thus, our call to
'close_midx()' later on leaks memory between the top-most MIDX layer and
the MIDX layer immediately following the specified one.

Plug this leak by holding a reference to the tip of the MIDX chain, and
ensure that we call `close_midx()` before terminating the test tool.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-midx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 9d42c587564..388d29e2b53 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -26,9 +26,10 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 			  int show_objects)
 {
 	uint32_t i;
-	struct multi_pack_index *m;
+	struct multi_pack_index *m, *tip;
+	int ret = 0;
 
-	m = setup_midx(object_dir);
+	m = tip = setup_midx(object_dir);
 
 	if (!m)
 		return 1;
@@ -36,8 +37,11 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	if (checksum) {
 		while (m && strcmp(midx_get_checksum_hex(m), checksum))
 			m = m->base_midx;
-		if (!m)
-			return 1;
+		if (!m) {
+			ret = error(_("could not find MIDX with checksum %s"),
+				    checksum);
+			goto out;
+		}
 	}
 
 	printf("header: %08x %d %d %d %d\n",
@@ -82,9 +86,10 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 		}
 	}
 
-	close_midx(m);
+out:
+	close_midx(tip);
 
-	return 0;
+	return ret;
 }
 
 static int read_midx_checksum(const char *object_dir)
-- 
2.53.0.171.gde83996e422

