Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB438F247
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642018; cv=none; b=oZWSmV2TezFajQxheq+kRxcLUdI9k+M+iCUACk1kYgmDiVAPihxRUdGCH9Ckuhzy5X3wY1SRknj7f5aAQZ5uap6Jc61WFiUQXtHKT1yxi54AhBDBsfuBWr8WojDZMUXwaB76ld/s6i04IykLu0+w6YwRX96e0CPK9C2Gb75CwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642018; c=relaxed/simple;
	bh=KDkiPqDeIyH5TFuiCKoF+J1kiY6mXviNxm7rMyRW+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beRKzL6DQ1Cs/bnXnbC0+XDPSY3vT1FDCf71rV6YHjvRITXBYXBh+QFUbPuEGV4KXDZxkcRfNqZJLSKf0t/Gvmr3NOqxThCoHbpyN2Twsqlhk909cs71eEj0MnQe0u944wWMltY5NlNdgOwal6zzJv+B4q9KZfVNWJaBByJuejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gew3h4zi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gew3h4zi"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a74765703so24014877b3.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642016; x=1775246816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q+Ik3dZeq+JxKXI64Xqm/jhO09SATVieYUcYncEkm4=;
        b=gew3h4zirIWYHx11Yp0MiI9400hqyXCV0LxqQfUtZhL3Jj7QhFfmd+8MQb7wdNUhbm
         XahKRpDicpYfZZbnGS3z5vf7iPxq8eqNyaupE9naQ8TISx7cSt4R0TDZ3qWidqCrdnSK
         hX7RCBwnjVzGLh9jP5S/w5wjaTlbddc86rzRcQKX0MXP0HFwOg23S4qokbAJXRpIYjxj
         pUq0IeGPfVLric+R/cqSV2W1MRAg2W/e/JyHko5GhNjHbIqnOS9vG6DwAI5+LTZg1yUn
         YQT+SKVgvlFY33GZw36cxbK1KN47JQjRJk+RZNN2kVXyMqx4Q7S+gpdzAakCLyp/SXPd
         cJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642016; x=1775246816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q+Ik3dZeq+JxKXI64Xqm/jhO09SATVieYUcYncEkm4=;
        b=aWLA0FUyV73k4WGQ5jQKtk5E1Ei2IWfrUTHjGd6iL+T/OCdD5KtvLM5QshgxRJqncU
         UGm/hIwxdDOeba9/JXAM6/M+jpK98bp2aP3qO2UghJPxXEOZNtYcHF7OjdqCcRfnx/tp
         vj4x5J40vAF1NXBDxoYL25wwgJ4cmtjCxpkI6jrq7dubV+fXryINrRiRSIokTTCOsgJj
         sEf07Pf4eVVwCh0/GeHhpKnepo1FitMT+VjOUj0S9zdFGrDYxdfUCZXXfrqX/+80Xj9s
         KsAN0inwfkmJqmmY6e+4s+iZqTO3vOyiFFHUxFWoPI3+XopzBnXJJ4bGQ3kYSMiQyEm0
         QDqA==
X-Gm-Message-State: AOJu0Yz4YpF57S9kve0gm9AShTHLSI/oTr1PLDn/8OBQyluTFSC9cH6H
	FfcdsCzQQQzySK/Hko7LgbZZutFeLc766ZmoYJ7fGxuYCxMlSG6/U5GoV5UgGJujxpsNvGXoBO9
	ThxtZC5WyWQ==
X-Gm-Gg: ATEYQzwvIUixHcq0KC843L0XNU86Hp9FL95X3veucGVceYejPVOaCUhDrn3M5qjkvKE
	zhv+cUvdoNQs2Wdc+sScCx1gy3uTnEMCV8NN8FE/1IWaJFWfDRsTEmTjiyfhqJM2n+p80ffOC9c
	U7kj+s6MV+q0/qh5fo/hryIprWuY1cB0ZxjbJ711czBsSLydCiRPMS8JrDLIvlLS1v0Gr9rcphl
	VuClwKcGH1+VznNQFNMGJzyuHpiRt5KSvYW760rFwkMbbmLRtloeguD81EUYwL1x5CipWAtGawP
	m048dq9naRnzDjqCRUuWtQlpSxkezk8/4uHVFEp9r+Hxike+6uCzosA29xAA6DOjRQyrelcXCVO
	cElTY2eYXv12z98F6Ozq3697Bq7pgPQ/OWVZoxgeD5okGdYY7dYtUoBrBo9OSYRxKikMUJH5842
	LApey47AwKdzOSNMmCOYYZSaJMJMIDBKKq3dShsZe9rHgs49ebTixYvMjF6R/P5rGr9iCZ0pLs/
	XAKp4R9H/3ejQnlXH5NH1YY2fKI7A==
X-Received: by 2002:a05:690c:e4ed:b0:79b:d341:5711 with SMTP id 00721157ae682-79bddd29933mr36544167b3.24.1774642015566;
        Fri, 27 Mar 2026 13:06:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8e4fcsm22917b3.24.2026.03.27.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:55 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 5/5] repack: mark non-MIDX packs above the split as
 excluded-open
Message-ID: <c9ad9a0c4ae00e00c0e9aa5cf66157fd93691c6c.1774641999.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>

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
2.53.0.724.gb20b077944a
