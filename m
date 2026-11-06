Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961023;
	b=2DMu1nBdrtD7xI69wY9wy1mSoDASeEDIyjU5hw8SNHU5r5fsOqsZwk97co8TnNutZ/ca
	 2Qgf8wQ239pm55PbIo8b2ynzrWJpFa/60zWbqryKG9sdX+eup862d4zE5oEiFMSQ32w37
	 DpWLbmmT1YXHR2zlf/sXzVUs2D7y34V1jZsfBvcYTsg0WuazTC1AtygCi1ZDv+y3aZVzy
	 s05x0DX8NZyyUwZhswzl4EQRo9CW8fmNay3axwons4GmfYwhdvKl5WwEspPpZGBVRHFgk
	 MySCVX3m3gybJmrOK2y6fNiocmGXWUjEg4T4pypIgZ+KMzlIOJjbj+s6rl95+61F5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961023;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=HntYHZhnxgVoSTq18MjE21rv2IeygyLNe1LD+ORt2w0=;
	b=czafIoFAKmFrUQlgNIju8F7aDKf2Y3059/5pRSVmB4WCY2h6EVag8gyyzZYwigOJinO8
	 ClF5xUoMIq14KLp60lO/CnX12NAiipc8MUhlTQWmyLljgfOZjY9XKPefPPxhA2ukcQv6w
	 N+smkhj07+8wauSzYGG0aeLIYUCtJyA8KNqQ+iA4Eq8JNfcWZLYTvngZCoP9wwcQsVHzU
	 m9h403NfM0vC95tz6brXL76O8l4yVL4Xc0y+otzCZ1Kb1+nA1FoleQD1A1f00+25HCGye
	 Ufvr3S7GX1TTE/dkXMkxVCVt5oxvwn0BUvviEXRXxY2+Bpr6oerr18AU/jj9HeOWk4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rOTkXLf9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nS5j+Ppi;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B2606D807
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB7B2606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rOTkXLf9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nS5j+Ppi
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B84ABEC01EA
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 06 Nov 2026 05:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961021;
	 x=1794047421; bh=HntYHZhnxgVoSTq18MjE21rv2IeygyLNe1LD+ORt2w0=; b=
	rOTkXLf9MHPTJUJxYw715nJZ0vxCUbjZMO5ncgi2mpsMo7cnWar294IEFJs1j+7C
	BaW8U3WggCDSl8Y3mFTnDa2cVgg4a6UWUz1+PRVDad97yTpYwU7pBkukax6QHHPQ
	vYuuDrRfs++JB61Ga/b2T2Ot6WS7O5zezdxl5I28JO4EvHrKr+vhneGtMv9rxHD+
	DFDPwZspxfwKQyCdJydSi/nz3BDQkSQgibAATqYpVDy+JW2f1uP6hVJmU3zxXqPv
	NTcXMuJmT1WTsV6VfrvPtF7GWh8WCvDnbNdc/K8mhp7Pghhm00txt7Q9AsBJvwZn
	z4B/zVegN3UujMgXa1yrqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961021; x=
	1794047421; bh=HntYHZhnxgVoSTq18MjE21rv2IeygyLNe1LD+ORt2w0=; b=n
	S5j+PpiidWgSihvZUpKhkp0TwxRqXPEpMgYjR0L6wnBXHfTOOMRQO7hk7vjBKcO8
	Qt4MxmZBMpFAOsLfhgBhMBFFEBPgohJNBIrhODjFQ8Gb4JNvQVZP24EMuqjaDS2Q
	ZLEmx+gjZSU8ELQs0OR1Iywj0omCefcxmPRp3SKRhTTDrqKNVp/aks1XoFqhRrGd
	ecjkz9C5jd63wgOHO8T1AN3QgEImw7iFWsiFX8P2m9un4isBM9q5RjKzoWMWYddX
	GtygwL35KpFmY0rgGdD/g4D0LeQy+9SMYnnjpJkh/hZ3djbciKN30DRM6+99HwK+
	sZTYN1wPajhLo3b5xml6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961021; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SQxVbCz6h1XQjVExjJ7XQttyllzDT9ArrXw+a4FvkkkZJPv
	rx4gsUQhoCEH26Q7VE73vBxIIyYpDU+8H9meJYvtQxtE9ctWz0qh38wr0Ro+hYxY
	HSDI58VTjf9Z5lnu7FQttTxT3tT1+rtFwz/YrGYspdjtu54LvivCT2JQK2v4kn2r
	RwRjGvIky7QtKM12Wx+XezRRvkLu5Be3zLaU1kWyH/c8hPC2DnhnHHli0d/gyGPJ
	/V5Gv2uD+VtghqoBYQUoChlnpHODbIJOcnM+h9pAbdQcTvbgzH0w5WwIH3gh9ExS
	wbhfS1iDOTxwDKdv5qXYvv8MZ7L5mWEk3uXSeGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7CWhoQFv8LeRi+cjxtSUuxS5qaprGlIdrKYgFIuUtC4=:BGfcnL1hoXb+sBNnZd6dgKbPjLKZAMRPbKeU95yhEbA=;
X-ME-Sender: <xms:PaztalGf0G3mZQsf78sxFpx7O5SO3RMPHSRJk1kdEkHSpnRkCepS2Q>
    <xme:PaztagU7NibfiRAsgOYPaWpRuUHF7WATXepupkxH-ZXsH4_VnXoO9Uqv06rmmzAiW
    F_o-duMeqCNeKWYUawEopmzSpN1lAChREFGzV8jj2Db7Tb9RplCqlI>
X-ME-Received: <xmr:PaztakyVAvGHUsCd72L58nkD27aIKm0iBpJnrodnCr4fKDndgPCl7hskBrSlSdPrz-gQTA>
X-ME-Proxy-Cause: dmFkZTGy77yXrjJS9/3QcuR7pa91rjJ1dPHPAmws2vnFDxHmVCZo6/qAJbB8zn+b2xX8hx
    2jNUqL0gYmXt9xXzGKEDcwA1blLEETl+6XVOGQtnMu+Ta9t5IU46E5JxbMAmgkNiHg1MGN
    VAG4GvEz1F1J+wueIPkWbgt24Ugo1ngfnHYpa/Z3EAxOam9qrqbygvrjFqLNScL/8IhS+8
    sTI/RoIWbNkQFt1lWWykvjNhwEwEtIvQSYAsoyoJmt+rvTiqMJnjy+sOSK4vZskVf8VYle
    aeqGxJm9Exev1XYrfNyRB45oA9OHchQZMN9BaUT+E5s4Qy1+zrAarY0O0PGLzMMK99ucB4
    zMWXTk8Tn2eZt2dyCiZfnXOdgpNXYHGlq8qLyRKqY9wtjXWN/hMOZKWdlSo94S0G0AKv9L
    XQm64wSExgbQlfPyirtzn3py6rKmp/Nroo7GNa4FMz+JL+rzGP8cu+b7yWxhjWinxcPdXY
    84rUXSB3pk0WWQurtBqvJ1eJJHw1+ukNlXtgTtzQurFzoFg+IBo0mpJbe+PUjx3r5yN9Gp
    N9m6RfXWThUuR+1j6I7ODow3dE+D1ws0lIkYPGYBZroJ9LIzX43PuL1rXcTwa7iGLTdbbn
    WzFSn+hqYuxcgnv5LGJkaASFJWKbRujKJHmHk5SxWAM69U/aturbs7uZEvig
X-ME-Proxy: <xmx:PaztamMiJqL52VHrW8TreKLDL6_uGPZ5i65spAlx3xdP6QwYORArqA>
    <xmx:Paztat4TLMQeXZt5DruXLA3jYKaeTALeLQf7y-3DYvgSrx8BuZhtKA>
    <xmx:PaztavPU3ZIAcBTTMoeauCc4Ah6K83O3BZFP7Qmvq6KvnBjE7_bHWw>
    <xmx:PaztajmwXruz2QcJwFdDf5HkosdFL_N9zJhDPEeyn4ash7Fk8V00rA>
    <xmx:PaztaiqjX_1P85XUi-CsQuIzlHrBh9ZDa2WC7l9P1_Nnxqo9M41OqPcu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1a34bf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:05 +0100
Subject: [PATCH 5/7] t0027: cache expected output files
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-5-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

In the preceding commit we have optimized one aspect of t0027 already.
Another inefficiency is `compare_files ()` and `compare_ws_file ()`,
which are both called more than a 1000 times.

These functions will repeatedly generate the same expected outcome even
though there's only a small handful of input files that the expected
outcome is computed from. Recomputing those every time is of course
quite pointless.

Improve this by computing the expected outcome once, only, to reduce the
number of spawned processes. This reduces the runtime by around 20-25%,
and on Windows the runtime decreases from 480 to 380 seconds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index eefb346d11f..25ed6b33704 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -5,22 +5,23 @@ test_description='CRLF conversion all combinations'
 . ./test-lib.sh
 
 compare_files () {
-	tr '\015\000' QN <"$1" >"$1".expect &&
+	{ test -f "$1".expect || tr '\015\000' QN <"$1" >"$1".expect; } &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-	test_cmp "$1".expect "$2".actual &&
-	rm "$1".expect "$2".actual
+	test_cmp "$1".expect "$2".actual
 }
 
 compare_ws_file () {
 	pfx=$1
-	exp=$2.expect
+	exp=$2.ws-expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
-		sed -e "s/0000*/$ZERO_OID/" >"$exp" &&
+	{
+		test -f "$exp" ||
+		tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" |
+			sed -e "s/0000*/$ZERO_OID/" >"$exp" ;
+	} &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" |
 		sed -e "s/0000*/$ZERO_OID/" >"$act" &&
-	test_cmp "$exp" "$act" &&
-	rm "$exp" "$act"
+	test_cmp "$exp" "$act"
 }
 
 create_gitattributes () {

-- 
2.56.0.500.g5d06dc02cd.dirty

