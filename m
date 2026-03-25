Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2F396B78
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482722; cv=none; b=Yf5CnWU69LF9/B2LflMAaR1WG72ulZnJBuNqHykYXx2j5GwaPrjNAAJO39LBTZwdO2PwKvhJjo8e/Pe26FhocrxXxTRUAANKQtkfaeQqpzzxZAMugny3Vo91Ovaqk3fToV36H11Y9BEKSFqVhu98PefojgKIdSb0a04MiaRoi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482722; c=relaxed/simple;
	bh=hj9a7tmkGk8uUe7XXQ9zUzveigSYfn+OMUDGTnXqPIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr7oqMUYIbQASJydJQHqEeOZjklQYb0Q3tXVDdIP1wuCeTZLYZ73dusXQea1TUZCggxu+jn2eDPtfzVDykecHHY6cfqF0mYox+74TUd+emkd+0vJhmqUqU0tMJ8W0uRYSUzPp7B+FheRduJjQuwNa2cIWV2B5OizasuYTzxbKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Qs3vzG2n; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Qs3vzG2n"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79df972so641405d50.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774482720; x=1775087520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCbW4a3AsCsabJOclUYqjtdxK/7FX2b8AzdHsIOlp2k=;
        b=Qs3vzG2n8ka3GpaEmUp9x8Jd14SdWVksDvajrfR3Yd3ZxPT3HZ1RE8d2H2YscJzVqL
         lT4v6Wm9eSfcKLvh7jojB1goEBlhs4vfD4+5eph1dct1HKXOEJli0zmb0Jza3TdhUV+h
         LbziRU0NBnkLoANc55IsWPef7SmVWXuVbGPygRhuo92vIJSj5v6xY48WjHRumzcYfSbJ
         rXznyAKM6DSK061D6aUEpDvoRxjSKWsaDWr5XJVZZmE93lISBBXzju+csSM5+oL7Kn75
         KMXi6AF/C1UiWKy4V1IqUYWdnPznqPlRbP3sbomZCgBAzgza0fE+gHlOOF4kT4TpcZlP
         NRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482720; x=1775087520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCbW4a3AsCsabJOclUYqjtdxK/7FX2b8AzdHsIOlp2k=;
        b=Ie4kzhbhLL2LISH/dg9MpvSlBDRAPoihmJgG1b44BhWFTZF2RncHTx3anYUDpl0rzO
         v/JrPw/Vy5BVjWdBQN7AR6+ZqR2NB4nI9bQzFqEn28zu83LivhO0ufOGL4HM+EoTsgwt
         dHGmfRar2w9kt0pjhjLGs79pPLvweqwUee+dC4QMqLCNP+HOhW3l+CfCBAC38LXRszpE
         Muce/++lrjmLZYpFcEZ8CR2ozYUhMWYzAGGDLWgJVmm0AVusem1PHQLc3W/2qTeUfg6Y
         Cqo9b9j912E4+/TxmBumHpgIEoLRpv25HhMm/JIhCe3Dx5e03sn5H5gIGeJiQYXM8r6x
         1KOA==
X-Gm-Message-State: AOJu0YyD8oF28iW0FGm1twz6cRXvOGWt9SGO8IRfabLaVKllRWIWY/2u
	JyhfH4qp0pZag5cZnTAxLg9NSWK98aE2SlFOEY3iirjVWP9/CEPTyvt4vBq3P/L8vNwigRgm7d1
	GehxH+aXzAA==
X-Gm-Gg: ATEYQzwI9L/A0bdPhIjLRWR7iWkDwL2pzjH2BfcrHAX2YZElI4xio20yNohCfhU+ZML
	OKyFw76RLtlF2FDnpRz3kASWmBWyzwVotmidBFsq+Xd1c5ZvW6zRGfUmKyPZehnTKW/bhmAKywc
	DMXZ/+vIReh2tbCnQ8L6QxnCd20umxm+H/e13UGRfgWmA1GFy/dGVRYqALkGOijzcM+SeZ/b6PP
	MJPYyU5d+/lbuDQBp1e9rN3sS778NoOmdjfTocv4kriOS89qDp7DV/WMt18QnK0Jlf/e9NY/oCZ
	rXmqKPYJgypQLM0dGHbmWF6HkUfAjsv80mZJAffOJb9EAf6xWiC87blF4mI4ceilK+f+W2K5Wbx
	TIucCHo8GEh6YiJ2aJkRq/oaM1FAme/he6Bc3cqoeNbBJtco8vl2dwjU2si6xvhQuGjBjzY8+rm
	ZiKeYrBy3nRfkdBfooeQyviuYOlUqn6fOvGxXjP3RGEGxKU5cjIWw9mGXJA6ZO2cHwxuBqvs7gx
	7q2LiLEFgOoaAAaWth91A9RcnIQsA==
X-Received: by 2002:a05:690e:4196:b0:64d:6a5a:ac41 with SMTP id 956f58d0204a3-64ee6162bddmr4731138d50.47.1774482719683;
        Wed, 25 Mar 2026 16:51:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef6c32859sm692577d50.20.2026.03.25.16.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:59 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:51:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/5] repack: mark non-MIDX packs above the split as
 excluded-open
Message-ID: <23cb9f33dbac735feeb4fa9b5e7676ab871e2c94.1774482701.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774482700.git.me@ttaylorr.com>

In 5ee86c273bf (repack: exclude cruft pack(s) from the MIDX where
possible, 2025-06-23), geometric repacking learned to exclude cruft
packs from the MIDX when 'repack.midxMustContainCruft' is set to
'false'.

This works because packs generated with '--stdin-packs=follow' rescue
any once-unreachable objects that later become reachable, making the
resulting packs closed under reachability without needing the cruft pack
in the MIDX.

However, packs above the geometric split that were not part of the
previous MIDX may not have full object closure.  When such packs are
marked as excluded-closed ('^'), pack-objects treats them as a
reachability boundary and does not traverse through them during the
follow pass, potentially leaving the resulting pack without full
closure.

Fix this by marking packs above the geometric split that were not in the
previous MIDX as excluded-open ('!') instead of excluded-closed ('^').
This causes pack-objects to walk through their commits during the follow
pass, rescuing any reachable objects not present in the closed-excluded
packs.

Note that MIDXs which were generated prior to this change and are
unlucky enough to not be closed under reachability may still exhibit
this bug, as we treat all MIDX'd packs as closed. That is true in an
overwhelming number of cases, since in order to have a non-closed MIDX
you would have to:

 - Generate a pack via an earlier geometric repack that is not closed
   under reachability.

 - Store that pack in the MIDX.

 - Avoid picking any commits to receive reachability bitmaps which
   happen to reach objects from which the missing objects are reachable.

In the extremely rare chance that all of the above should happen, an
all-into-one repack will resolve the issue.

Unfortunately, there is no perfect way to determine whether a MIDX'd
pack is closed outside of ensuring that there is a '1' bit in at least
one bitmap for every bit position corresponding to objects in that pack.
While this is possible to do, this approach would treat MIDX'd packs as
open in cases where there is at least one object that is not reachable
from the subset of commits selected for bitmapping.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c        | 19 +++++++++++++++++--
 t/t7704-repack-cruft.sh |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f6bb04bef72..4c5a82c2c8d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -369,8 +369,23 @@ int cmd_repack(int argc,
 		 */
 		for (i = 0; i < geometry.split; i++)
 			fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
-		for (i = geometry.split; i < geometry.pack_nr; i++)
-			fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
+		for (i = geometry.split; i < geometry.pack_nr; i++) {
+			const char *basename = pack_basename(geometry.pack[i]);
+			char marker = '^';
+
+			if (!midx_must_contain_cruft &&
+			    !string_list_has_string(&existing.midx_packs,
+						    basename)) {
+				/*
+				 * Assume non-MIDX'd packs are not
+				 * necessarily closed under
+				 * reachability.
+				 */
+				marker = '!';
+			}
+
+			fprintf(in, "%c%s\n", marker, basename);
+		}
 		fclose(in);
 	}
 
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 77133395b5d..9e03b04315d 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -869,7 +869,7 @@ test_expect_success 'repack --write-midx includes cruft when already geometric'
 	)
 '
 
-test_expect_failure 'repack rescues once-cruft objects above geometric split' '
+test_expect_success 'repack rescues once-cruft objects above geometric split' '
 	git config repack.midxMustContainCruft false &&
 
 	test_commit reachable &&
-- 
2.53.0.614.g164f3b634ec
