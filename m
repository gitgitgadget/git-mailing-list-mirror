Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECD13DDAE
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508009; cv=none; b=PtJhgPWSl8IM067qnHZ9hRkzbv8QApC86GsGDj0hKEquS6pE4PWDupqr/CV49TjtAkN8Q4XXvkXV7dJoK+lluetx1tG2kVd8ItBiUokMp6KEoTyAZvzjcPngwxpvvD8XxLWLArIpryaO74tVk0TRF4zMDZXb/E3SuBw0y/iHXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508009; c=relaxed/simple;
	bh=rC7jrlI0DdSg+I/X/dQukWZCaqCbcpJuEeG9/+VSM24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFmO4dV+VjOFuSJXNpijYMXZiS2TigYmfCmX9+XHk7Nr3otQ4aIi4L4F99HkyDex0rWA/E3Dm8E9qc0FBgIPLo6LMS3MeB4z7tXV6894Cu+JiAXjqAKibBNYe36AGfB7InMrvq0jOoGxLhZ0JA0+KPazA1H7dAuEPEjN54K1iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dqvM8EHl; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dqvM8EHl"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64e87a81639so320355d50.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508007; x=1778112807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TD0Hx+kiSV8890MQ648ka+NsPlkWai/HZHIOsnqmhY=;
        b=dqvM8EHlh45E/lDS+b4QhKTOLJ738xLCD5MbZJpjUrVIRyDPJ2Oaz75n9Q6kuF8qyq
         3i4Qy0xKM2HDK41bwOeteVhBK4V7WvqCLvUGFLBXPF21zy5G9LACPf7enAUy+VB1rvkS
         DbdNmR1y5LAb0ycxr1/J0aElG6JKSmR1um0zJjV94NN3Ox6UYQUq7Iq1y+ktl58C6sM/
         ZlVktuZHSv8LIC55FkU3U6riAmeE1XoDv6DOv0c0REJ48SzrlxyZFC7ZX0fUTAV6PKHh
         Kh+T9SnDVmM36azP2rRRw2LwW9T4hBhn4V0pP4pVRRPCEh5DFI9y1n9MyazHNNSfkfDl
         Y4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508007; x=1778112807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TD0Hx+kiSV8890MQ648ka+NsPlkWai/HZHIOsnqmhY=;
        b=LtQqb6N+DeEhsoECji6vFE/gEHA/FqPIvwr/l92/vYTLuuws5UY806a1rvAP9lFpUR
         Wj3sNw9I1H3QvEhtjQztmUj7iA39ZSI9u2n5uuBTD/QT3iKgowuSvXtp4Gm6xxQ7Nc74
         qd6ofPna4LaPBcvYP0d9fX3keWySMQFK5LvefDvNdZk4nzTpGq4VgGOcXbVp++DvJsky
         x6KMLS7BKX6G0h5mCqpGnYhzwLqYsEnKEj++1rYhxAarK6LgLQuBPXgFjDxxnDaQHIiU
         Ye0Y2jX6gs172jVTs28lxJs/aXelMXviQ7KWJxvMQ6e5rEbcji3xJdigYR/aLCKGOEh1
         Li5g==
X-Gm-Message-State: AOJu0YzTlm41F69IrX51vmTOVu2LHbn2vm4rbNhYrDvjM4qZitdMWrBe
	v0v8d+AYkw+5r4K64CASGmOGtoAG271SITI+77rv6OxklNA5nPioy0XgLTlkgguBBMaNZc6ejUD
	ZQKowUsMLyA==
X-Gm-Gg: AeBDietqoy5hTuY0HhKT9CHDMtwruBvsxedzWL8xGJaiEL8GjurslC+8ZZP0lub3vPb
	56tWN1Z2khuiCxS+kDnI/biC3N2X54OjRI0B6JbmOqMcobLHynaWv2U/luhLezinyqk24SfW5MH
	XHhl2bZlcs8Ya4yEAK36AYvmTA6MBrkCDp5cntXv0zXXDE2aXlto85h3zvakUcmrtHNNAqfgB3F
	lVDRjjaGwxuH8jo17xSWultQod1ppyMAtr90V1bmByRyCqv5tWJysyFCb2s8QQA01L1yk5FXG8X
	mw8kZ1Np+nbZdxArd7taMErFoqhbhSs76CjM9688P62YZUoDsZOwPjmEXKmkGiuYMYyl5GejDK+
	mhTVUJ6sE5G1gQ7fBe/SX0uiF6eaW+8imAPnUSet0xMd873uVQMSfnV4cgTHkXijS8ivGFRF7R5
	UPumUynpf5g8qE/jxf9OM7Hn/zF/ktjA6+H3+o/NEw4M7ud1UEXg3aBqS5oKFurPMHb7vXAoJ2x
	9CbGs2ewl7Ex3q3SuI45rRyLoh/dKXUJ370d9BdP7p9vheleAWcZYvYTpVcTkRCNsgb0prGgpVe
	QuGXYoSZywWYGmUnTRBdLhJvXxkUK18sbFjtfw==
X-Received: by 2002:a05:690e:43c7:b0:652:541e:9681 with SMTP id 956f58d0204a3-65c18aed55fmr319100d50.3.1777508007253;
        Wed, 29 Apr 2026 17:13:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff7b2ce7sm1947234d50.20.2026.04.29.17.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:26 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 07/16] repack: track the ODB source via existing_packs
Message-ID: <92aba3d366f78fbc0f5a0928107ed8f5791fb58a.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

Store the ODB source in the `existing_packs` struct and use that in
place of the raw `repo->objects->sources` access within `cmd_repack()`.

The source used is still assigned from the first source in the list, so
there are no functional changes in this commit. The changes instead
serve two purposes (one immediate, one not):

 - The incremental MIDX-based repacking machinery will need to know what
   source is being used to read the existing MIDX/chain (should one
   exist).

 - In the future, if "git repack" is taught how to operate on other
   object sources, this field will serve as the authoritative value for
   that source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 ++---
 repack.c         | 2 ++
 repack.h         | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4c5a82c2c8d..24be147d39a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -417,7 +417,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(repo->objects->sources))
+		if (!get_multi_pack_index(existing.source))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -564,8 +564,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo->objects->sources,
-				NULL, NULL, flags);
+		write_midx_file(existing.source, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/repack.c b/repack.c
index 596841027af..2ee6b51420a 100644
--- a/repack.c
+++ b/repack.c
@@ -154,6 +154,8 @@ void existing_packs_collect(struct existing_packs *existing,
 			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
+	existing->source = existing->repo->objects->sources;
+
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
diff --git a/repack.h b/repack.h
index bc9f2e1a5de..c0e9f0ca647 100644
--- a/repack.h
+++ b/repack.h
@@ -56,6 +56,7 @@ struct packed_git;
 
 struct existing_packs {
 	struct repository *repo;
+	struct odb_source *source;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
-- 
2.54.0.16.g1c05dfce579

