Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808571;
	b=P44FJ96lwzGNFo2rPBXgTS2c7HhCAssQQYVVT0nR71LUPekFsUL5tj5aSVQUtp6FI/PA
	 1x4AqwS489ZMLX83o/o1bEQT5/ubn708I1VgIH3ZsaKS4EbL/oiwaVAIXbv02wwvkIWA+
	 2PsGkI4xR+e3KEOxeqHV2CpB2YK3s+qMyBGanOso+fRhrMW50SLGkH0aW+J9owqYAc9jI
	 LVV9CMux2mDbtp+X8C8/fGb4C10Q5tBhmR4fZaQU+9XMdb0to2ATOh5SQ04UH/Cbv7wah
	 c2PaDtNc0T80zNvOZlm32AiWkQUogzsxFmbRpyYBJy3edHZkS5TuC27B8SwirX24lng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808571;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=PRTWJTC20j23zRa33OU4kcbYmSV+cnF8jkgcaHNKk88=;
	b=tP+f16TKwgmEISOFWEpPbGZiqPUURIlZea5M2jcDlXz5e5dY/BcvwIy2HU2DP6rkO7eE
	 TyPVC9r+Madmgnh5SBUQ+ThlphNCQPGY5SWuDNggeM8EuwB+BOOxSJEZUYFdqlzDa1/q5
	 svBTqf4E3Ui7texocDh0g1o5Mqcj5yLz/LqV+dgm6hFnhTbixOBLFYRpRjn6i85Fw89ah
	 yfv2VXduEEu1vEg0ycwsbjbnUv3xaYqgOqz+heS1e95nOOTNlV0gFSL/5gZ7TvZyR/OZ+
	 KGQva8GZ9vvChdGXVvD62z0zsC+1d49Jy9OREsoj9UOw4RtDFjJi3U0xmxx/AqTBaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Hr+Aqywb;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D2606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C8D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Hr+Aqywb
DKIM2-Signature:  i=1; m=1; t=1795808568;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:kNR01rW9Zo0S6G75GB8xGKzukciO
   a7A20ddcUXGb8XaGkYni5hZwVSK8KCJMhQLCjQ+1lcgv6/GEG7Sr53vgthUPCk/03Fym8oZBQOy
   Sx1s7aGhqzYZXL/VS4ui2tQ2m5+lLlK3rvrgM6AyumUvwbQ89ABhEgTSrTq+ys0fu1LWTyk5voX
   6h6EDnJ6Lrz35m9Mwiwxwt/a6YNl3uif3XkQUwC8x80kUnPUUrcuLOsOJwCbgJDptNgdyuUbck3
   uQ2ruTGmec9AYW2qq7Kdzhryaou3ZppD6eU/6U5iOQqxpPnYkGjQCJAuMX9dXuKEJGr6rYmCzxB
   RAb0fL5C2mB5Yg==;
Message-Instance:  m=1;
 h=sha256:
   nKxkcZPpSPWgRefqwBloFhDscB1esisIEKuJa116B00=:
   C7FHFlWGW4kVvIKNxgqfGxkyNONTuLfASEAP3LCqSlU=,
  sha512:
   sb2aZ/RdApvZcG8hOWNsPlHKnQF/HubUC7l83GYW6fz65nszGdCpwLkzdfF0fI41TDw69T48VJhW9WFqxbGNXQ==:
   FrWTJHFP+KWx+CyRULBksGf7QM398i++8qhJwQA7ZPOaD1NyD4z9lY8LepSa/JRMeZId/551zf0jaiUlzFLDUA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795808567; x=1796413367; i=tboegi@web.de;
	bh=PRTWJTC20j23zRa33OU4kcbYmSV+cnF8jkgcaHNKk88=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hr+AqywbaaYkxMob1Wiyg+Pwn6DeKYtsq7OCpXZcnxjTyefRAp3Aa/Hczc07MNuK
	 ZuaImUcAuX6mWs2FRylrb5m0QU9ph5jpBEvyeGiq3t3Agm5Be4DN5lw9DihDfAOyu
	 2a+v0hOhf1m5KGT6yiqkK47rY4fpRvyfOTcBPwH+nDeT8Vy+1zZWjq+7ISAyh/lEg
	 3XSbPueccwz57akZtuq6CVOHPBP/ncwTLCROFQakmA9fl9At7O3JnjU3Yoh7tPfyp
	 ZCiwAbVlMhclPvPGD9eCXYpkO9tojskKaRb8bDow09XCCPdDCtPWTHbYWyMRvPVwJ
	 kVmX1V4rW1b5H6A9ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1y6uQM2Yjd-00f04X; Fri, 27
 Nov 2026 20:42:47 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH/RESEND v6 2/2] read-cache: optimize file size change when conversion is active
Date: Fri, 27 Nov 2026 20:42:45 +0100
Message-ID: <20261127194245.10104-1-tboegi@web.de>
X-Mailer: git-send-email 2.56.0.236.g7e34d8174d
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fbp7LO59jVloC9kcu1XI7h16k35HovcFuJklmDPVZcTJ/gOXZsg
 1DHJjF0xn5sME/QE0s9XyRhz62wqbEuUs9LzBv13L9OqJhgYKUzbi5C/76wdruyTP4VCZoX
 dSvn/YNE+wu2ss0k/ew3E7pq75Dw4+9HuDRb3kdTk5u+LczUjrJQ7tV4m2iwpiQfyP4bZ2y
 y/bKI7S3RVzSOeiThG6CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkxgVlZM6l0=;Ypz2sQbulkDeEJGLhM7XsvVPhgq
 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
 Y2dQeyTpovdmbAV7MU9zCRoyFqEl432GRX7gg==

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Commit
"read-cache: do not trust a size change when conversion is active"
corrected the case when the file size in the worktree has changed.
Input filters may convert worktree files with different sizes into the
same blob.

Optimize the new code:
The call to would_convert_to_git() can be skipped since the same check
is done in ce_compare_data()  for regular files, which is called from
ce_modified_check_fs().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 read-cache.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 70f4787de9..3497997bda 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -9,7 +9,6 @@
=20
 #include "git-compat-util.h"
 #include "config.h"
-#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -456,13 +455,12 @@ int ie_modified(struct index_state *istate,
 		return changed;
=20
 	/*
-	 * Immediately after read-tree or update-index --cacheinfo,
-	 * the length field is zero, as we have never even read the
-	 * lstat(2) information once, and we cannot trust DATA_CHANGED
-	 * returned by ie_match_stat() which in turn was returned by
-	 * ce_match_stat_basic() to signal that the filesize of the
-	 * blob changed.  We have to actually go to the filesystem to
-	 * see if the contents match, and if so, should answer "unchanged".
+	 * When the length field of a regular file is zero or changed,
+	 * this does not necessarily mean a changed blob in the index.
+	 * All input filters (CRLF line endings, clean filter..)
+	 * need to be applied followed by a hash and oideq().
+	 * This is done in ce_modified_check_fs() below,
+	 * which calls ce_compare_data().
 	 *
 	 * The logic does not apply to gitlinks, as ce_match_stat_basic()
 	 * already has checked the actual HEAD from the filesystem in the
@@ -479,10 +477,9 @@ int ie_modified(struct index_state *istate,
 	     * So let's just special-case symlinks with a target path length
 	     * (i.e. `sd_size`) of 4096 and force them to be re-checked.
 	     */
-	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
+	    (ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0) &&
-	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
+	    (S_ISGITLINK(ce->ce_mode)))
 		return changed;
=20
 	changed_fs =3D ce_modified_check_fs(istate, ce, st);
=2D-=20
2.56.0.236.g7e34d8174d

