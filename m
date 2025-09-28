Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25729D28A
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097301; cv=none; b=YSsr5VCEBMpipRtRBWhPjiz9CsWBxinOZxF98qFk+R0slq2+fVIhWJltdd+fCtli6UuLZWSf/yCRYLGoq8SfeBDbRKkx4x/DF9C8jYiBUmECkvvZj7tu8mMu3diQqAeSXXuB+cOd3Ef0Ev4yC8k6HHy7hP5T/Wx5BrMcIGhgVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097301; c=relaxed/simple;
	bh=sgFkgBAon6K5sWt4xx5vp8S31DTLrqzZVQea7UwVOgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7RxzKMTVfJFDjG360iSErVN53pgd7baIaFSZt2rT+bK/6Sp2C+D0OMm04RkunuiG1MuRRWRthjeei95t+8flUVwovPS6WKajJT9IzlvXj6vJfIQ4kT+Pb/HNDA+RdwuKRRxm1TpApRIsXhjU3QD15spz90/psBS/CYUf5bu+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=i0IXuI7Y; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="i0IXuI7Y"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-72e565bf2feso40644767b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097298; x=1759702098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/EYHB7YEsqLLhneBqOdRrfaN8IdI5DduyKQmxrxl74=;
        b=i0IXuI7Ykr8qwtIOKtfNHk/fqIM66CmoyNSkQ+R+2jLR1VtelDoqJHMlufvNAL7/T3
         XIfdejfQNtposZ26ZEgFkOk4zNbwALkNsGHpVrMfAhphr7revyqd0i7+zFh7wYv3qclb
         UUyJPBWXoBonE+87mL50ZetIrNOUMPlCf0fV9eKNh88xYjiXTfKxuZ6m6VGq9usLSG5y
         jziC8GSgRReJtmc5YP8YeU3ys5xHm4Dl9Zv6rmrx0R/8JhXsdDSIjEc2dTYECCtfbkdW
         Yiaik9TR9vZVtuD/sBl3QS7Fc1qVNOiMOxPTSvrCzT4RfGxQZO88EsCpCrc5wUhmrwMS
         dXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097298; x=1759702098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/EYHB7YEsqLLhneBqOdRrfaN8IdI5DduyKQmxrxl74=;
        b=kMm/wS+EPEUvObB9AnvSfVy1bZbq/RXDo7UQVKdbgwzGF2Zt5yQG16ZdNBUrDMLzvJ
         rZoYAbpL0HU2HevTQoIIp+2zm1NMOVYyJuae1UFxszRgwNHyMgB8uo9q1x5L0qLhUww0
         CAiKUKbiN1WyjXhn2zvyWc1reCadUDIzLMAJ1exi/6hrR+YJ72cec7LIML8zIAdYaODP
         MgJBLTsFli9pVre/fWa9k4s+Q1Jtx9nUvgVWb7Ukqql5HDpz39vE8+TY79SGnn2QCppK
         pVmA5mHeTbA8ozUO10yMofbctqFQfGrh3JLlGzcDBUFwBzOUyyJTq29XkFjmIENEAPu5
         Hd8Q==
X-Gm-Message-State: AOJu0YylFM5YLj6AVBmze7ZEKlEv8vHPmv6VXGWakFToKrjWcK/PbUX9
	xkEJEvNaMC7TFZD6Zq4LAuJ2lTOzJqSYvkA2UCmAjMk+VzruJBC4lYoumFfvqsSP2rSCgDbEhSm
	B+RJwIqmjtw==
X-Gm-Gg: ASbGncsQd8DQmxnL7jdSbcroalG7RXHyKelChldoxTcS0h1xsSNuOCJ3ywRyDOCjwlv
	M89TSvWH6vE64SbzImwaxfAnn8XWvngoO9ropq9mYNjHieLqy+6t5OWpYCvgSj5SgbawDUjY8gp
	WRWacuvsuTDzPACsKnluSgXGJ2b3hGAJkgcWGg0P8q1rhLmNywUKRT1k5BoxmZ9EDHXvG6nkRJm
	ovaJVRU6SiR5f/scJinQb3hU/xXH8oEGHIp06KqKGFsrO7uR2RkZaIO7Tplb+GoHp1DXzrymLx3
	3+4kVi3/FXIMHg2YQdXatWSjtgawYuSmiph2HSYew8inExmdjKV2nmR4iZok3JOCyfTIzjRijmz
	4tyDn9JJG6c+BTNAe2aC/cW3hHUV+UpjQ+txbpWd+JurQY+bU8Xka2pguVPREeUAqSGT/b5MwFH
	onRxAiuZUrlRPNh6X/bx1MKyyDoA==
X-Google-Smtp-Source: AGHT+IFeNAftlHdyYSgEA5AjOR8c94/8P/PfdAGWXnZaVxU+aCqCe4t2hy5kUGi0bPmalmrbQqOfGw==
X-Received: by 2002:a0d:e341:0:b0:717:c1cd:3443 with SMTP id 00721157ae682-764026bab11mr120938237b3.38.1759097298208;
        Sun, 28 Sep 2025 15:08:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765aebc1503sm23637097b3.0.2025.09.28.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:17 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 17/49] builtin/repack.c: pass "packdir" when removing packs
Message-ID: <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

builtin/repack.c defines a static "packdir" to instruct pack-objects on
where to write any new packfiles. This is also the directory scanned
when removing any packfiles which were made redundant by the latest
repack.

Prepare to move the "existing_packs_remove_redundant" function to its
own compilation unit by passing in this information as a parameter to
that function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 31137cf711..c5a88eda12 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -209,7 +209,8 @@ static void existing_packs_mark_for_deletion(struct existing_packs *existing,
 }
 
 static void remove_redundant_packs_1(struct repository *repo,
-				     struct string_list *packs)
+				     struct string_list *packs,
+				     const char *packdir)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
@@ -219,10 +220,13 @@ static void remove_redundant_packs_1(struct repository *repo,
 	}
 }
 
-static void existing_packs_remove_redundant(struct existing_packs *existing)
+static void existing_packs_remove_redundant(struct existing_packs *existing,
+					    const char *packdir)
 {
-	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
-	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
+	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs,
+				 packdir);
+	remove_redundant_packs_1(existing->repo, &existing->cruft_packs,
+				 packdir);
 }
 
 static void existing_packs_release(struct existing_packs *existing)
@@ -1659,7 +1663,7 @@ int cmd_repack(int argc,
 
 	if (delete_redundant) {
 		int opts = 0;
-		existing_packs_remove_redundant(&existing);
+		existing_packs_remove_redundant(&existing, packdir);
 
 		if (geometry.split_factor)
 			geometry_remove_redundant_packs(&geometry, &names,
-- 
2.51.0.243.g16eca91f2c0

