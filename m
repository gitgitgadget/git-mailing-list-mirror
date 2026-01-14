Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81E34EEE9
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420510; cv=none; b=uwPC8s3QP5r7PVKLmVomR1M06eU9HJCDNELNR7UFHJ9xILM2gfd2onKPJ7W0aS+RBFuN8gadE3OU4gDsmhbuhzLeEC8X4IWTWPG/gwo/ivOz+iyvpaqelZy+W6QAmsQj3jX5SD9QiiQIstRUl8g1x7LRuNgvNeZakIVsTAsMOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420510; c=relaxed/simple;
	bh=0Du5O4xwsWrFzFO1JctlVq+itUvTPQd64LA7jmPD9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzjOGypvmo3b4cRlFBapzaOFFo0rWK7v6+CfbHYHxQLEz/pmvS9y2MVGaKM0gnqH5EAbMeXm3L+8s75Y731YQi9XdBwTNpGzeRcV2Eu/bB8v1v7gsSGczVAQ9tqtE87JDrItaFig/B8JaGmE4d5+p5tXFIZH2Y2ssHbZp9pQGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ao1ZpI0O; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ao1ZpI0O"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso108218d50.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420508; x=1769025308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRx2jg7GHR5E37xcfKVJBs2hDy0oe3OQ70ONDv01NsQ=;
        b=ao1ZpI0Os8IM2apruHw90oJY/sOZBlBFBU+oq3o80gsja5RhhiUX9hvqhqGM5tls2h
         2/FaZSeUcaxs+G4taeKuBzs8z0foM6C8BC8mi0wFSnQHlDhesH2n/kMOX+EKSw4rwMYg
         Xo3xMZeDkJ7rXJTRqIRx9i0Fkjv4IVDG5IkWpZl6k6x7XyUjMMzu9fr1A+UiTEJrckaB
         Srk6ShicqaXd4sJz50II6aKGGiRydd/pUSY16mOjbXL3hUn3EnlPN8/85KbKQK6BqB5e
         sTJezJ+FrZc0USr0hoxhfMll3ZvkbaAgUuG4mW1rmdCfHoKdsRi7Aa7qWZ4Td9kKQr+B
         jJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420508; x=1769025308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRx2jg7GHR5E37xcfKVJBs2hDy0oe3OQ70ONDv01NsQ=;
        b=UqvOCsEImqgHlNDkvKBRl/jpfT1N57iP5hDb7nT/YpxficdtCVSiINeIoNkWsuX0pv
         zlAS7TmKECwZfULz6FR7S2FF9FvLS9djR4Q0dP20LOvieZ4twizLvDBZxVilPlQgDlHt
         0WUuKCHNYuXhOGKF+5NzWBXF5DwxjuFTDlHx1z7fkwTMJmFZzevCcodlUyU0LDLe0UxL
         zhde6VLUlC7n2qxhoCPe3Mz82H7ZVn0LP/eavwanm3ed/P0RVCJ3WUJ3MXOwgcUE0UFD
         jpYPzc6NQrZRxPTRL1KVuLncJzRaE68CFvXAW6rR8XMcXaDKwttzQsuhk5tmldZ3Hr4U
         uhjQ==
X-Gm-Message-State: AOJu0YwcCKmONxFgRGlEUasPheNpVwfyGfhF7nYoaVDRKNHCcYT4hkT8
	1rL6nyxDMVfewR9vZzr68HlS4l189wmnYbuHKbOu7Xl8pMIRlkuSZE/WQJzMtk0w983vbMBk5H/
	XQ/d5MYpKmg==
X-Gm-Gg: AY/fxX7AMaA/C1ZZ07AjhVXNGUiqzuSDO+5DQIBgTaDTaCuBRHCGc+z4HyvaBDPrDJz
	6G+lQZwbi689t3wBoE3unD44U4GwM9ied0HmnpdRAEmfF20/Ef382Ea3qgWXWO1iyzJCayEK6Le
	cOz6T2yg1t3bVIM0a+ib4Y6vIb5rH2ih4jYlT0Ed7aJw9M7uoH2PNF+UzPgnoPh3J8BcDmbWULo
	w08enXOB/nKa2pfavpEwK+aohbwKUGPxP8P6otHBGjuNkVlQTDwA3AjJkIjKDHbmbjV0myBpxkP
	bXDKLYArmGWu6Tg3z7NeCVz8k/P2BSZyevUmafvidxF9CeRT7WuZviRILZPlsz9kyAWmc+euMdz
	kECWn0X3in5ALMHt0Enxjs3zsVy3D0h0UpmeNnRFCEc2FFSPna7DzPXfNHrLUUH5Y+GHzFsfV7O
	2rQTKnmxmxUkZO74X6j84E3np9igqMSyYXoUdhHYBV5ZbzbKiOTkvlo1fyWCHG/oo7MG3VOXVEB
	vYoSBRoude/pvd9xg==
X-Received: by 2002:a05:690e:d47:b0:642:11db:f5f9 with SMTP id 956f58d0204a3-64901b0bb71mr4240565d50.55.1768420508292;
        Wed, 14 Jan 2026 11:55:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55b8b6sm93910047b3.4.2026.01.14.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:55:08 -0800 (PST)
Date: Wed, 14 Jan 2026 14:55:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/18] t/helper/test-read-midx.c: plug memory leak when
 selecting layer
Message-ID: <dbbcb49456385265eceb6dd77e054df1e26677c8.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

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
2.52.0.457.gb599f1ad4b0

