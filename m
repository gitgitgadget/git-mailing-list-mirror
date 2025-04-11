Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273022BE7D5
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413990; cv=none; b=Zffvxpyww4b2Ff2nvh2ZAv0zwLIDoTAAuWd64Dm+B7VslH2e5Iu2yNGnRytiWuBZV/RkAvGrXXzEZkiX3z/C1F+SLBdm4Lx1n6S3oX4Hv/z75z+QR8xBpyOvui71pMSSyTBR6YRJL29Xq62DT229wAXq5Fw4Ywh/EY1mZOR+QDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413990; c=relaxed/simple;
	bh=8qX1xwMLsD9aXK/D/8ctPhNyPyHJd3eArgQLAnabp94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvtSop1xCT/+N9GAAMn5qUr4PcEUa2tTqvxfQMMb532zUFt+Y5GhV6kimY25HHWDBPbzdW/39Q7kxql70U4GMrTt9TKFtLlu30gH/XsKiNjQ5SUv4ITRAc6Tf/3N+ajVv1KlvGj+ViMGwMfCznY5j8wxHfCNKSX9UiIq63pWJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xPsJJgRz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xPsJJgRz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e90b8d4686so19070616d6.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413988; x=1745018788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1i3yzxZd1yu8PCFMzrOIMo/zRGQEeeeMxBao/sAoy8=;
        b=xPsJJgRzkvak7HF0GQ9mdyvXzsXV/LiAGDUT+rIFkmX4z34VA0Xai+LGFwPZTDKxD/
         5Om4QfYtUSYzzC5GyztJhdjnZx7vm+ohHdAPTbwETxx1o8cLND+AFwTarGRH2bReGZgP
         Appbkjz6yNE/6pf5C9nHq8vczDBLBjn2w0RKnNKMIci/ls8WtsyT1pFW7y7a/aS9PDYa
         BiLQSGhUGfOE95+Qsjt71gkK20HmSLym3LZLhhT1jmMbf+srmKOFroPdKU76cgmlljiX
         RdyxqSRW5bpeBoRoOCUY2DFbcgbu2M3AtYK5jeHGRXdt1OIJM5CSi10Kmvh6RZlUAsnV
         fJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413988; x=1745018788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1i3yzxZd1yu8PCFMzrOIMo/zRGQEeeeMxBao/sAoy8=;
        b=KfRvyL4EvSc4uYNzvaTpN6USA7ZRdypZcfovHvEBOnqL3eEoTkOKGlYu7ixi49sa9u
         7Nu76JTfHglMNzmTabM8HxQrvSgI9x2l0ZyKgt/2SRhS9u6Hm2iqTKWx/4XlJhVPEIhZ
         txSH4GoRqKv93/ayH3+P5Xf5T5DTjt5lR3nxYjKwC3LrxgWiYFu8fSK1pDk1HWXCEQrk
         fYophw4JLT0KIPWA7yrpncjU/lUnEdjXWkC0p111FmTkejMi6mwf78aDkB781bqbZ231
         T2gfXCek+iUXyO+Kc3zI1o2MgGqZ3phrTn+7IQKHJHdVlEhCCB3DsPV51uZjjfAfF33H
         okMg==
X-Gm-Message-State: AOJu0YxsP+P6a6ZWyEw+r+n/SOjoItGjRnOO3qjWOjKld1jGOubBRtoa
	lC2yQwnA9NjRHtkpBuKe/0HZ9jMXQWgBZkbyDmDLhKHTZNzK9DG3e/FyqIX+mml5/Pra5p7eKbv
	tXzQ=
X-Gm-Gg: ASbGncvVOY1fv+C1goH9hY+RFfXA2Zbj3uFwgm8JHSOl1uCIpAQ3043f8CMalJH7mmr
	rpoFndx+2Zln7wK2MrTaIzZr7q8VVsWQgb9REe9HfPIhItaOWeq0l3ARKg/aNu78YmETLVrSz8O
	kj04Ym6ZjcBiVKsAriMSP6q5i1ASIY6BKthOCVIimCcA40UftFN7qy45y33ba+oxdtKbTiczecO
	yvxN2AYLCy1L5Zab1UdKv3SPoB3f3eIwrApzaV2Epx6Ia5Mr0O8fSTRhv1u7F01R5iCQt+vk7FS
	RobfczktO0RG3cKxgeQ5ciRBaIcTdPwLHBWQSErGx9DEdlKXcRg3x01nbatc/83s1u9v84kIN03
	W0TInJ1ZswMRP
X-Google-Smtp-Source: AGHT+IH3PR9TgyaxV5DksPqMvOpVqQwpIsBdC+FHppbey1R+uofS/IN45V8qbMKFLNVBPNbCXBRhzQ==
X-Received: by 2002:a05:6214:d08:b0:6eb:2f30:55cd with SMTP id 6a1803df08f44-6f23f1dd77emr69803036d6.45.1744413987706;
        Fri, 11 Apr 2025 16:26:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea06e15sm42771646d6.83.2025.04.11.16.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:27 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 3/8] pack-objects: factor out handling '--stdin-packs'
Message-ID: <43e889b15762b2aed65d0c5fbaef19bcb65e8f14.1744413969.git.me@ttaylorr.com>
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
index 540e5eba9e..793d245721 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3672,6 +3672,17 @@ static void read_packs_list_from_stdin(void)
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
@@ -3767,7 +3778,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -4773,11 +4783,7 @@ int cmd_pack_objects(int argc,
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
2.49.0.229.g19b69c1246

