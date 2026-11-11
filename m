Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394094;
	b=dujz7evA+boiFudp6pnN8brR9NOKKrAOF0gBtM5ywi7ADYDrE6Ed9JudjQydYZ8taqV/
	 DhT1GpBKzJK8RNkSWCxl30ORBc0vkKaasN92UNJ/TVzzn6p3R05m3z0HbUCdstAYcxe4Q
	 NP5yV+IcfWHBc7HeZuNVUjDXgiAQvcC7RTZHidhlSDpDxqcBL5WExjeax4U9aWIAjgGwu
	 tzIVA5JiDHu30e5V6UYC9EWdxdJTPjA8+Dbik8hxIyChFacKQd5CYa61Ny2vBmmAe1rMf
	 TQX7o1TfTZPOoQyAmU0bShlmPps8jXZyHQMF4SC21eG5pBeObHOAOOT9vJc2iT1241g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394094;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=F2k6VzYP50IPlv2uZ8SP5fqOdxJp8olhf9WZ3SWqd88=;
	b=DjGji1acUU0fL2xeTx/RCJA4RL32xipsWnx1YyrOe6WxBMLQYk6EmJHMkdf9ci0eURf6
	 Qw/o7hyLDD/Kga+bCL4HXg6qQ8VWIyLAXJL/g35U4ltOxJOVcEqjzj7jrfaJ6pTHSJe2w
	 7nHc8M5tX6SNKVKe7I+U2uhwwlLkHtgiB4NWU9SuammA/KVjsKiwz25jmKSt60DOoaavQ
	 0zSplBdDak7B9bLdbGgiJDxC/9t062/a+XxgwrKdOgFFGoiio2u0ORuvZ/r5GyCJtlqhE
	 t1tvZMwg3FmibSyj36hoMyi5r9T2cz681miKsdLBi9F/Ko7XW55KtOJMImwrL2uANzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=z8bLJIXq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QT8Sckuq;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79090606A33A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79090606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=z8bLJIXq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QT8Sckuq
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84F30140013D
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 05:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394092;
	 x=1794480492; bh=F2k6VzYP50IPlv2uZ8SP5fqOdxJp8olhf9WZ3SWqd88=; b=
	z8bLJIXq6agus57YQwb2R2zen8dEArsNMhhhJWdTreseWt4iddeeAnPK3yBmPekW
	pyv1wtNWu8Sb/Kw7/wB+O3WnegIxRme/nCFl6omypxmRaTmKHwnkYT7qosVfQzY6
	ztT3vz2o9fL4k7E9gQRRayKBt3B88ZhF7zF1kH2SwPgE1m5JWc5X+gqOMRUQVMXX
	F4R1upCY676N+Bd5dvhq2blfd8PQ/kNk9Gu3lB2WKbkeloBRBj4Ph+yKInawaVl1
	RCydi99vPUwZehrbfT7xZTU88P3QlVzaJLSXbW7XXqlLCjPXVHIPHQM7vJBolmyZ
	/mqXzfippBGyrT2StjsGmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394092; x=
	1794480492; bh=F2k6VzYP50IPlv2uZ8SP5fqOdxJp8olhf9WZ3SWqd88=; b=Q
	T8SckuquxQGjL12zRJECbhKHDT+Znuz8W4+inSmmBvi//Xz0H1n7gtDavrt5Jw18
	AQAYXBomr7GBQ30OIp0nJGmSVjl6YjXw9NBSlYVGwtZ0ziRJZu4f+IWru9GEqWId
	i6gn6YjnCoqeOXdncK3j5NFLB722smOjM008MxrJi5zd40YMg3r/ZsPSoCHkNt/J
	U43/dhbUOc4wHtGh/aZ7ne/0VRj9b2J4VBjhHMatCwLRcYHV1/kYCcUiDedJ1pGF
	byRF+qp95vhQF22cPQo9pKuiE2e4DlQG9PNFUwrV0MXJHRi7uU0MOXO1EU3jYuMw
	p6VnXS3cHGKGcHspyXhkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394092; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:R4bG5jAk+HBLgsi6Th4PsRITimlIu71P1UGiskPzVQMGDT7
	m2ejbIze8hUFFzzZTEnAF7PDrPtWqKlHeahdAa7WFMV10UkYzYHjk0npdl7Su5gP
	tqF5dQD94DGFcSZX8LdKFnwp77inNZeV+LIg3hnlQ8c1ONh1CfJLZIusFAZCCYQ8
	ZIgU3a4kzym7sB2IcGR7IFqWCe/opCKC7dIJFAtt2DAZYyONg8KovfXS4gSQYy/y
	G3lp4qNvuRHawokgmc4ejlb8vWWw9P6juaSBz/EUuwsxBYS4iew+FDLFUZfikLHn
	QGpxNf8w4BNoSYeWZnJ7WjL0mLtrwH/YOrZi79g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:S7onNYNxVL4Vaznn3zxW9XviC47QBLNzhtxlaIDYP8w=:IY2LbJoWPxY+8Jab0VcOLLpuke+xBTYQRdP9raR4nUc=;
X-ME-Sender: <xms:7Ef0arcr6BbWqCRkZzDk9SbURJ4JH4mNb-KXS3uhUDJhE7tOUEUjGg>
    <xme:7Ef0aoPHA7qzYEUI3ogIj8tBIgxYAgZ3tzk2J3rWZxVFv1skxHiQeUsbo27vfAtbD
    zk9Fn0RdgoJG3tvk2GQv7LcBI5nEXktepS3MkA0HtPnjfP6hw2fEwQ>
X-ME-Received: <xmr:7Ef0apiyiY2LMDyyCadSUuZiWuGR2PMcjLSzu_JYECrVQSDQZIzazBc24hNvZS2MGwBVGA>
X-ME-Proxy-Cause: dmFkZTF68gyuBnIeQdRwGHfH7RpIlBB8u9KW7pV3fOGC/OlYIHC/es/K1KGMlODmxVcYNN
    GcBPQs7w3Y96F0FmpqZnu4iQb4d4EpGTBCZXw7DiRDog/gQMeooaoeiW/rahAnDOA50GUb
    c4dB14xxYQkQBdSkZ9hjjF5SnZQiniIU+NLLiwFEAgUQn4fzO4lce5M4wUPVZoO4pDq27i
    jGd15xQCLdEN/tbUSivRW8Pi5kI7yyUpOYt6zWSIhNvjWLMuDwfacf+lDI/awuiTbTbZm7
    0Vo56/7kHJh2z0p0DOTgWIM0kwI3CjQPY7ZkNFI7u3pDe4mOu42s71W4yeK21amwK8V5DI
    u1J8WZdoTd+nzt8DIKV/O+djDCV6f3dzGiWce1h0anskxCwde9msmuPybeodupHA0t70BO
    pvewWsA09htpfB/0bkDuGDKv+b77+KDifcF14il8zK1GfOPOtSIpVyv1TfNggCCGINZeLQ
    tizAZ0rHH3EotDt9GpTfe/5UZ14FjRuYtQ3swDD+Lm3CkN4VxXOa3OCFpJGqMPh6iRO/3I
    8bY2Y8WkxOGR2SbZdBG62D86TBWnTxf9QM9ZTF/8EKw+gXNbRmUSdx752DF1ytyqHcvQ3F
    6DWzuccLUxKz8SnUKhxxFCw9KsKZ+nmeECE1UhOZ288t1GN7Cf8y2pSv5CkQ
X-ME-Proxy: <xmx:7Ef0ar2oVUe-rWCwIvYoxthfTDzeNXSGwCjOuxsKnaUJXb4tn8gb2Q>
    <xmx:7Ef0ajjcj3aIn34LolXWQngg8ht2QH2EG7je9-Q-wsceiuWLYQmGHA>
    <xmx:7Ef0ardhUZ0lCdEXiHRl7W6cCVIdnoppWY9BE1Vp4gTwORQe7HSppA>
    <xmx:7Ef0amkYEGhrzNhoI24qM6oosJJpCcMZCTBLdOViNXzhzlMt3odk2Q>
    <xmx:7Ef0an3w89OIEGHswyTw42bHWtdaU2_LTEYOAbwZZcj6QZ8bhYMXdfab>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97a38963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:55 +0100
Subject: [PATCH v3 4/7] t0027: optimize how we reset repository state
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-4-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

In t0027 we verify our logic to convert CRLF for all kinds of
combinations of attributes and configuration, which ultimately results
in 2600 test cases. This is of course on the heavier side, so on Windows
this takes more than 10 minutes to run.

One source of slowness is `checkout_files ()`, which gets called for
a lot of our test to set up the initial working directory. As part of
that we both remove the old files that we care about and then check them
out again via git-checkout(1), but we do this one by one for every
single file.

This is of course rather wasteful, as we have to spawn ten different
processes every time the function is invoked. And on top of that, we
also have to rewrite the complete index in git-checkout(1) every time.

Speed this up by instead using a single invocation of rm(1) and
git-checkout(1). This reduces the runtime by about 20% on all platforms,
and on Windows this reduces the runtime by ~2.5 minutes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 49dbf09da77..a3904b729b3 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -303,13 +303,15 @@ checkout_files () {
 		git config core.autocrlf $crlf
 	'
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
+	paths=
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
-			rm -f crlf_false_attr__$f.txt &&
-			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
-		'
+		paths="${paths:+"$paths "}crlf_false_attr__$f.txt"
 	done
+	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
+		rm -f $paths &&
+		git ${ceol:+-c core.eol=$ceol} checkout -- $paths
+	'
 
 	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
 		test_when_finished "rm expect actual" &&

-- 
2.56.0.611.g1030f0b940.dirty

