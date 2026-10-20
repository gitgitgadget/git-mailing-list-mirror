Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470349;
	b=X7uhdhNboRNRLiCb6d2Mt33e4J7LKslHnQiP8yV8f2P8KguI7/fLPEFAnTcTJvBzfCIr
	 aOG05Dyc9rxnMdgEa/bPD5j2oqe2moEv1sB9Y4L+0GUm6aHMOgiJ0CZ3YCiC+591bEnlq
	 17hP+6z7C9Ts/r7ErL3ltUcmIilPPDGv1T1Y87USv/Zy1oEpZOkKwpvOI2TXU9zZa5p0u
	 vbkcWxsVBFsq9BHqCByb7epN1qTyi+TuINqaMuzMIgo5FRf51jjB+KCc04h1nT3o8Twbd
	 weRLye4+24M0OmkASip/z+4rJqxITjTKjCvXG0/1HiqFSurasPjQbeLlcVRPCh4DhmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470349;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=mT1mcWNWvFuFpCn2N/1a+ekgqD++Gr0l03/GOnby9O4=;
	b=2sKk3ukm8S5IEFuHwB/W1ev+UTei3In3CLB5CpbrQeV6J7mDcV/n5Sx+3xu+TpkJlAu3
	 mITjGpERSTyhezotwcJ9bzgDtI3k+DSukQER7GdQjBZ6hToHJt1DumeuKIhK1Vr238Y+/
	 no6KMc4D4atOgYVaF79A6MYyUzhxjbIAsNWAYEnjAOocm1Rkf4YDqjXink5wh+EnyH7NJ
	 BbK2ia0Lv3eSz1sQdGRoqVTsfR/CGauEtaEgDbo1rjup6l6dPN7xbNPQsGMc8gY6fiBA8
	 V5mCpm3Y1SlyEFcswSNX1AaJUs3t3nIRchWPjvLUCnLEdf1Qy7/BWK3LGehVQL2JgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=poBnQrzP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yVy5n6N0;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405D606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3405D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=poBnQrzP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yVy5n6N0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CB961400093
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:25:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 00:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792470348; x=
	1792556748; bh=mT1mcWNWvFuFpCn2N/1a+ekgqD++Gr0l03/GOnby9O4=; b=p
	oBnQrzPZSwHIgchW2xsR5JpB4FvXrrNfjUkLLq/8oXKJ2PfNeLmxc770VJ5X4skz
	TZaXWdIJnAooSyer3QaCgV4Phz8rB7bfqGUuGx7XBGImcdRr7AxFL5MJZWrb7hJg
	DKvjyAcSNtC3p8QrY2SFIsDHXWuS6sfxU+JLD+yD7ZdY+g2pZGagL+NHI3EY2DKh
	SYd0xZe8444pz7Xtcp1fh8/eIBtjsNIaDTvMFEnw4xzUzl1hgIWcVMBYv8BTw6li
	qm8WFQ6d9BfmRJo8V16lsnmUOfkrnjE/v9SaczU2GTso7rezEHKifRAjkgd1xJdV
	HxMie7xRLyNZ2LgqYcoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792470348; x=1792556748; bh=mT1mcWNWvFuFpCn2N/1a+ekgqD++
	Gr0l03/GOnby9O4=; b=yVy5n6N0r7aznLLF3bS4lVWgldtwrGhwe6nnGycHPfeQ
	noO0gDJhrhNNBdxNgyLB3B0HDoptz9Dz5t+UYTjN/P93bMbqFUGFcYtN+82ckJu1
	q4UpDFB6zOkTwva9D2leTezE+saMrza7JJZHLCLTkkXhMSNqRtiQ3Avt8C/j0kua
	9CzpOpP8LDyPvvD4aStlX0ycTpA2N7z/ZcIkF3BoM/wMbMSSebYrHipAq6329hp5
	hgXnYLt0GDhqhncO/GHK6iaX4XR0TNXfc5vwhq6CRyB2Lrnx/TPFm5q2t1Kv6RPE
	0BOvw2td6DKjGh6RR+PNTRZNep7cTLDVmt0PoGwJwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792470348; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:liXKgXHWcSvVWDXUsqtKZOb7h+NoIaFLgGhOa/bGq8FSk8K
	M5bI8Dulm8bS3fPjD6FMwvKpigTJGXwVSBD0jM5E4SQI9eQW2WskujGAeTsZdUZZ
	JBQFoPGGkag4e2WWER3N4soYTJ1pAz8UDFLj3NxKgWHx30J8Rpxpirq9NhlndVtj
	/6zDFPDnV8gzn4kUHRpNwk6b/eNAjuC7ao9e59LHWFprDWg+DpYowoIgfNGCepcq
	JvgVepvjek5EN9N/J1eNtMkJLfbRJv8VebHdFYJa7SpL+YDiyXG6jpzsuJcDQW+h
	CU8h28ddXuNZYdXQaasU4xzbrJGp5ET+eAd97OA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NyAPAheHpkyvD5B2JvbTRE4ckNRFBJffnjWeWZIjU5o=:XLxAK78tCrY8gP/wJmSD5j4TNsam5w/D+B6yKFQRSMw=;
X-ME-Sender: <xms:TO3WaoOPYq9T2sBk9rrmi_2cGA0kZ75ltqqd5QJ1lABeGLj-wmPe9g>
    <xme:TO3Wak9sPvlA_ABe0oELNdrJcWl2dbncMS1CGphxp3pn5VqsJyrOxY1fhuDd3ARn8
    _fMHqkOzbtLe3Ybdq5_xV0q1KIJnaBzzH3KP5QZOx4azR6-F4_yBw>
X-ME-Received: <xmr:TO3Was4NAMSf6o6JEl_KJzcmlGaqeMoYGO475gt-gClOLNBpQrW8JWoHmo0i8y481zZdIapziGoWJddLLAK6k2YxI7FrPWcwDUms>
X-ME-Proxy-Cause: dmFkZTF6q13sMkQ0AxAmkQyBbUj2Gw84rrnFqLDGNAvgEV4JjQlpdlnT2sxI38ZiYTqvHU
    Xx2vuPO4+Zcw93X0/0kMJ2XN8yD8b6bD2F43q2wPRHPzJ5qNDZ2MB07Cv6qQZVGS2AidKe
    SfK/Q6Oa0ysCT89zcaaFc13WxhP57M9etEy0TPTbb0pr5F7SCQGAIMKKgnWsYVu9JBOwLR
    SalvgFPPLoJUJrV5TvHebyOcqKQlJ+5xevm5wTcHccG98vnCyYliELzEXqEKIfnGZvABgk
    FhQHN8hJldcDKQhD0hBmDJm76geCo5TDJRZ1TgXL52SC08XAQPok9mtna4E8ml16ya6yO9
    Ocf8CdsIFEsBM6+q6RZqz2X1cZvD/AZ0dXAfyiLeYFPtpdi+E23NrKAqNTBXB4xSowM3KH
    juHga3F03mH2kaZeeE09L7Nf2My/Bo5y4VAaN6pRYZQlfsyp7nLDEHU2vHmd7Qf8n3SbnU
    wmjgtprhpnPZ5xSie6zNiQ/Wlgu2C5tGuPq8ZTWXw2FEmy6lzLMbqjq4LxrnVVldjTCEm4
    4W0k/uGuTYZUauUtSvi5XXDrN7FAMBCQATX/ORfNZ5xHYbPUwWnVVLUVyvg2v0L9zgVec7
    FKLhzO8+LvbBg09JR4YbQqGp14KgjaK7aUfSXf9XF01lCwF3iWy4ALuslkxw
X-ME-Proxy: <xmx:TO3War09Lwa7Q79sHMGnoYYL4S568mfdyY78GYlPWdsF1pertqlvKQ>
    <xmx:TO3WajCVl82tzcMIdWCVoWAO76ozjbJuGyrri7wesURyoiLTzO1OgQ>
    <xmx:TO3Wat2Qa38fTW09ImlQIAp1JNB2BuYF7OkcazbQQjZYtCZyAg_LkQ>
    <xmx:TO3WatvuQ_Ii2krKgyDQxzN5-VbOSlHsF833DIWG3-7NP-747ee9aw>
    <xmx:TO3WajmbfPTpDZw4_qZjCLfreATM0PuGF88LvuqI_t_iI_kH04jU_cTV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 00:25:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3] github-ci: update macos jobs to macos-15
Date: Mon, 19 Oct 2026 21:25:46 -0700
Message-ID: <20261020042546.2854586-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-321-ga7e4057184
In-Reply-To: <xmqqfqy5clgz.fsf@gitster.g>
References: <xmqqfqy5clgz.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GitHub from <no-reply@github.com> address keeps sending

  Subject: [Action Required] macOS 14 hosted runner image is closing down

and suggests to update to either macos-latest (macos-26) or
macos-15.  Use macos-15 for two of the four osx-* jobs, and
macos-latest for the other two jobs, which is very similar to what
.gitlab-ci does.

Because we do not care which exact version we are running, so
request macos-latest instead of naming macos-26.  If there were a
similar symbolic name for the oldest-but-still-supported version,
we would use it instead of explicitly asking for macos-15, but
because there does not appear to be any, request macos-15.  This
would require us to update these two lines once every year, which
is annoying but is manageable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cf341d74db..7e5769f543 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -323,16 +323,16 @@ jobs:
         vector:
           - jobname: osx-clang
             cc: clang
-            pool: macos-14
+            pool: macos-15
           - jobname: osx-reftable
             cc: clang
-            pool: macos-14
+            pool: macos-latest
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-14
+            pool: macos-latest
           - jobname: osx-meson
             cc: clang
-            pool: macos-14
+            pool: macos-15
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}

Range-diff against v2:
1:  e28c655dc1 ! 1:  1ac29e72d1 github-ci: update macos jobs to macos-15
    @@ Commit message
     
         and suggests to update to either macos-latest (macos-26) or
         macos-15.  Use macos-15 for two of the four osx-* jobs, and
    -    macos-26 for the other two jobs.
    +    macos-latest for the other two jobs, which is very similar to what
    +    .gitlab-ci does.
    +
    +    Because we do not care which exact version we are running, so
    +    request macos-latest instead of naming macos-26.  If there were a
    +    similar symbolic name for the oldest-but-still-supported version,
    +    we would use it instead of explicitly asking for macos-15, but
    +    because there does not appear to be any, request macos-15.  This
    +    would require us to update these two lines once every year, which
    +    is annoying but is manageable.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ .github/workflows/main.yml: jobs:
                - jobname: osx-reftable
                  cc: clang
     -            pool: macos-14
    -+            pool: macos-26
    ++            pool: macos-latest
                - jobname: osx-gcc
                  cc: gcc-13
     -            pool: macos-14
    -+            pool: macos-26
    ++            pool: macos-latest
                - jobname: osx-meson
                  cc: clang
     -            pool: macos-14
-- 
2.56.0-321-ga7e4057184

