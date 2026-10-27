Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122608;
	b=pQ6VMdScs/zGCxARZjIMhm/9YVVyygB6F1ANtbDTgQI5VNB7NADOcywg6gVqbV9oaHUb
	 zpUb3W7D30V1YttuTAPcf4Hve/jLXQu7u5+ejYw7OxFrAkxjkNLUGX19ZdOmcDWGnY4hz
	 NH8tyVvokZPIywLyrcE6E2DiwGvb33i8MFHNqGl5LYXW9+CFOTUr7lsmTzfRKYTe8+78m
	 y4iO1A1193KmBnE2BDhFwMpMzAyjHVwrU9qZMPF6FpuL/I3fsHYV/7cGM7X3k5dh0Jr9f
	 NqGmBuZJt1tUOVFWymiWIXIl0wTlqdUnUlEJRGvYa+CKm3GWjts6coALZZblTRw9EuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122608;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9utK5/AMoMNv5TT3mDsUVptFXTHqSSFOHjLE48Si3Gc=;
	b=bmKZBSdnwYgu+41cUL+ON3m07K+83kxSzeI+Xr+FI6znknRdRk25bdQVTBRf8rORyEUB
	 IU4fniQ9EqOZ9NwR2p3htuFRxP3S/k6/u8k5WTVKLajMYiDZByYZbVeXjbm/qFd4Z6RNk
	 awSnBF0N5G7W7rwii+dgK/ukmwi8K5jwnZXBeikEGDePGhob7V0DjCdt+x3KGhYkBypwO
	 zcsUkJ0ZCofKkGZeyY6SY7Fzvz1aC1lX7xgC57e7zuKn2Az/1RXEMDHeDMJ50I33XyySu
	 jEV+Yydlfx4dosgec718sel3KEQzv0poOh5XI/rEny3hMv631fJxshhh3HTxNfU5VLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=en81kbdn;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043E606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7043E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=en81kbdn
Received: (qmail 38398 invoked by uid 106); 27 Oct 2026 17:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=++X9iLD+1cYlquPN51sRT4Tq9HAXQ+/KVpvSFL0sRCc=; b=en81kbdnAzchDJVIshsjku9eFMEF3k/d3Kj50RKOzAphMF9JHxE6hUH0/K92H28kpxKzyahtPrE69y1uZ4rXy+sqGil/u31rXkKo42WOt/dy5TXks4Lm6nwFVDU+PanKgbmGL/HF20mBsi7jy09y6i3mJ3Yxadz74m63ybFVVN0eHdHoiDWNZKeEITK5zkKa5UmC5WgNTnMUy7UVbVZW1FnOnwej3sJ+OoTeV1p0tqv1VX0qyuEmQvNjyptzFF8TuImUXArFVkQiUqQRdLZTMTvYk9V3e2CreFBfoxegVJWqWhrDElA/N78Hdqp1P1A9JK5YovzYJR+l4YOEBNrVnQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 275975 invoked by uid 111); 27 Oct 2026 17:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:36:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:36:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 4/8] test-lib: allow an external program to supply TAP output
Message-ID: <20261027173645.GD136740@coredump.intra.peff.net>
References: <20261027173205.GA97799@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027173205.GA97799@coredump.intra.peff.net>

A program which produces its own TAP output can't use test-lib.sh,
because our TAP header and test counts conflict.

We used to support this with test_external, but dropped it in 5beca49a0b
(test-lib: simplify by removing test_external, 2022-07-28). That
interface let you mix shell tests with external TAP, which required
special handling for the test counts. But we can bring back a much
simpler variant: tell test-lib.sh up front that it will be a thin
wrapper for an external TAP generator, and let it stay out of the way.

Now you might ask what is the point of using test-lib.sh at all if it's
not going to generate any output. And the point is: it does other useful
setup, like handling logging, setting certain environment variables, and
so on. The next commit will wrap the clar unit-tests which will bring
some real-world benefits.

The only changes we need here are avoiding the TAP header and the plan
count. Note that if we skip the whole script via GIT_SKIP_TESTS, though,
we still have to emit a count (since we wouldn't run the external
command at all).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3d001b91da..3754db0ea7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1277,8 +1277,11 @@ test_done () {
 
 		# Maybe print SKIP message
 		test -z "$skip_all" || skip_all="# SKIP $skip_all"
-		case "$test_count" in
-		0)
+		case "$test_external,$skip_all,$test_count" in
+		t,,*)
+			: nothing
+			;;
+		*,*,0)
 			say "1..$test_count${skip_all:+ $skip_all}"
 			;;
 		*)
@@ -1534,7 +1537,7 @@ then
 	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
 fi
 
-if test -n "$HARNESS_ACTIVE"
+if test -n "$HARNESS_ACTIVE" && test -z "$test_external"
 then
 	say "TAP version 13"
 	say "pragma +strict"
-- 
2.56.0.559.g7c1a1d8168

