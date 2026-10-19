Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438916;
	b=FH1r0pwqP1pCxx6btXJ0HeaiWJtnx8eypLAARmAUb5A4DHs5VToHr33BbMoclXZRjYFu
	 /Zaf+1qob8/kV/Pb9RraOTLxzaSa54LmX0YyWBP15zYL9AfUOZr3mzhpOSAh3sAVgxxlm
	 qN93u1pXMDiYih9RbJ6X79vMKlFYWgoYtdsN2DSzAJpvJXJjMfzUa5IZ08NFsh0eZCjwx
	 rONQzAFEacXU9B0RlqsEmc3OGbz3YB8K+OZtSJinFB3AitX5hQLv9R3tm83kHYou1qWs/
	 LTn/bWQYOHl7a5A2LwWwH4CmuXIGpJZNwwIBBh3t/Hf48Mh6HCBRFM8DRMLm6kj4W8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438916;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=g1AIrRiRaGzQJMst4sdUfTM23dPg+hJbHlnz2lm7BeI=;
	b=03Xbpw20nAZmbvv2pSI2p2C4/Fjls505TtqlddVnD7DOEZ2V+HBSGyyKshi2yWCVUhra
	 nIORfDq9tCnRcU1akKNwCGK0EwiHmi2da3g+evPuUW91lmNvHbGtsXqMQS72JQwJ51feh
	 XZ4Xt76NMNhLiSz8l0aJlcYSCWSy0DmXdtI7NP/4hYXJl1T31q3XnMq+SBAp84w6Dki0/
	 U+CsVHi9OMCL1uOlvxupTI4y/op3/gGVMGo3iBjXb/tKShZd/9djpy6l3L1qYyLo8WoYr
	 4mI+Ffs8gc1McJ3h4UlqxJJVKnY/1urt6QwxFBkWATc09ceZ0LguT+AR+e8enARNnJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cG2TPsWe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UBNJt+PY;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4708606A31C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4708606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cG2TPsWe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UBNJt+PY
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EB826EC0064
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:41:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 15:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792438914; x=
	1792525314; bh=g1AIrRiRaGzQJMst4sdUfTM23dPg+hJbHlnz2lm7BeI=; b=c
	G2TPsWeUkQUZWNzeIjGdau6xT1ZWlj3agq+1sHdaLzVhg19b6t7VyAASIMnpwPoI
	LruKO2FOlbmgOysUPlUAZ5zMWCJz/5g06wxr23Ulw604tg2SkEbcdQaFXm6RIGhh
	eoJHqjAkkajbxuWZRWGrM5TTwpDTALph353bNcchw9frNy58HKLWrE9ino0vNxbi
	VG+SiW7GsFirys/Ytd3Bivq1tX9I4AO6gTQls/jap48dysd3gIL0Q1vBfnkCOzxO
	gUQuik9Py5HChJBg1ZukcCeVFFA1By7Sw6hy8wEO4ebzy3xV6r89CR0x/+wW5q+l
	IboHIroBWOyl6eTl32IVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792438914; x=1792525314; bh=g
	1AIrRiRaGzQJMst4sdUfTM23dPg+hJbHlnz2lm7BeI=; b=UBNJt+PYKX/O3BLmz
	aqkqyK4HQxlJ+tGBdfIGIcNnSPB0+gMn7d29p8HXDp+H1wRxaxZDG6orIoU43Epb
	3+c8xHgeHi9nFr3ya16KEnDZYeAIJ0wG4B+Lvw8mhQuu3a7LYdfPKQpI6XVy/jll
	NJ23NcrFDLQd0FjYp6CWbz27Hq3xAfOwUnsFhhIgAuQnQAoHkip8qGPtMO4PpogP
	CUNNiOHk99mwyZd5Wp6gj8qNg4nd8F2Dp3dSBpC4mVgB7jI6ZtyzLoOiodKcsMpb
	AxS/PAAtMIz5jww6YUySMAs22oj3WZZgA5zCbHdUmh0yVWf+ru/MEv+B+pEYY5SQ
	YSz5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792438914; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DPb9gIowdnN63k+tXAt73Kp3W5XLepVnz94HcbVKd2A1g0A
	KRd5Trom4se/A7a7Jb1uD2xmulyhvlR2hkl8vJZPHfOsW32btfhlXsFnOQVeXMf9
	oC1rCnOqs0z8xsS2ZXgZnOHLr1f74y7iMa7yS7Y9YTXvXJ7rhsy46PfGDGvMMe6N
	VEuNguKJXxibuVa9uPpQLkHsv9GlAmYTOiYsAd7qaPnTXo3gILEmw1nx9QPmGLlp
	bmk8tcW5SSRGQhOsByqqMkhHMwkUPUnPVPN4u83c9EQtbyZGsF4IQwJrAYTUrgXP
	sVw61e2lJboGJt2UoItpG7AGkyVMrW2UfRtjjuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YUM2WQAEqpD/SsE68UUgjWNMKwxD8xX8eEe0qq0j0s8=:r772EA1Fh9S8WApCTANnL4qdJVBRzQsFLj14d6Qvlp8=;
X-ME-Sender: <xms:gnLWarfEvH_0twzG1vtepsCzmf8o8N4lQXOUBGgVBu42ZqPE36PEgQ>
    <xme:gnLWaoojorhwfAN6r0H9w-ue5BbXIGz3SciB4vbgwfQi_ESD0CHL1MtqgqjsGEtL6
    UOG-6QLFKpu_zCR2bmBBHtcDWZWOxxnA7eFOXl_1w-79fGodFjc4sA>
X-ME-Received: <xmr:gnLWah4mrexsFeNASiDeEceGkgOIuQEXMceq6sNAP4kfSzcVekDmyrl63YsP4xVEUIfWp47fmvNEtnjem4S2ta10k33gzUgTkycT>
X-ME-Proxy-Cause: dmFkZTG0rxDxG3chKKtU89OtGsiBVckhyKIEWWPkCWT9xQCPRXKLs5RhAEybTACKBlk+Kx
    docZhI3QoKi0DhYCHdJf0fzR241+pQay+zb+DkvsjJwMfvnWIrpZrsYI3pN35eabnCEgrd
    fRLyz6UKI2KlGpfSzWj6S5QD/KPkK05gtch9AYWNCnpeAGLHmDoXJ4WjGVF5RYXu806jpc
    ibM1F2h6oH/mEBOciE4l7+C51H37WdK4dVnoFWIGYNulLTJYXFSktvFpTx8QJqqDq1dK+n
    +h9GX65mnoAxR1L5f2ruAHBOKY3XH3kWwmLP9msezi086bKjWiK+WZslPIefG+5oYDFThS
    BQ4lrC2sGgahDtTKFZm62EJ8BF5XYtueC7BnoFQg0wkIUhTGDHPFjGUbce6JKjObX6PIFF
    Wp0DmmlRG6YwfQW4RHCI7V+5UkSyGGZH6zb+Pp6sgTOjqDnuER51Kbrq1w0i3vskJfEdTm
    XXeVdY/lKwBufCMC/xnaLZgPtvGhAandGyrsS3pHNJ1bjVHJ153iX7yNEvOpXzx3V7XUf9
    x+vI8L1v+RGFyUWUyLgU1o4rk2qrCguEjKSePX1d80hoG90okSvv7SQa53iVQdsbM0U07o
    RAi2cqWpK869AfqiaGrXTr7pQxVAM3ieBEaqXC9awyK02YwHhBH1aHoKDjng
X-ME-Proxy: <xmx:gnLWamqyambK5RWycvI7-OZYQaGbh3r6TYWSxtz6RcSh0dM73DX0Qw>
    <xmx:gnLWariu0kfEaaykwpbrw2tgzMi0MEKdD1Yn2Vd5ERPyvsAjXfABBw>
    <xmx:gnLWaoI134kggKjF4ZCGDPf_PKGfsVpNHaQbXW19V8Wlkcbtp9U4jA>
    <xmx:gnLWajCex7sRenwsbvcZ4I27tA9cyYbpP1WTyadUhAIiOJAXhAz4zQ>
    <xmx:gnLWaoweeCM5YdelkFZyciu6a47XBuz9n-Y5m6zHINgJeQoSdhZn5__l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 15:41:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] github-ci: update macos jobs to macos-15
Date: Mon, 19 Oct 2026 12:41:52 -0700
Message-ID: <20261019194152.907881-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-314-g110ce7813b
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
macos-26 for the other two jobs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cf341d74db..e8f744d069 100644
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
+            pool: macos-26
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-14
+            pool: macos-26
           - jobname: osx-meson
             cc: clang
-            pool: macos-14
+            pool: macos-15
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}

Range-diff against v1:
1:  c7124011e9 ! 1:  7ca9f53bab github-ci: update macos jobs to macos-15
    @@ Commit message
           Subject: [Action Required] macOS 14 hosted runner image is closing down
     
         and suggests to update to either macos-latest (macos-26) or
    -    macos-15.  As we do not have strong reason to pick one over the
    -    other, this patch picks more conservative choice with hopefully
    -    smaller impact.
    +    macos-15.  Use macos-15 for two of the four osx-* jobs, and
    +    macos-26 for the other two jobs.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ .github/workflows/main.yml: jobs:
                - jobname: osx-reftable
                  cc: clang
     -            pool: macos-14
    -+            pool: macos-15
    ++            pool: macos-26
                - jobname: osx-gcc
                  cc: gcc-13
     -            pool: macos-14
    -+            pool: macos-15
    ++            pool: macos-26
                - jobname: osx-meson
                  cc: clang
     -            pool: macos-14
-- 
2.56.0-314-g110ce7813b

