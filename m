Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511896;
	b=DqJ6q5Z4sMY2d6iN3On1EWTyLbExsP+SxLktlHf5JBLivJh6fmaf/f/OsfgROM6euaBa
	 ncRDR1pGOQAKyReAmJ4A/cyZXWcuqoRONd9fKbQfiQAmcyozjYif02grUKFoFoornOxfe
	 ieVLqc1Fyz62OY2eMaxu1zJgJue17Z4y1CG/mQjsVSxH0o48D4gq7AaUOhrfOKET5/Js1
	 COlC1xoHIColR6t2LgwP7M41ccRDgpfuohx8y+RkagruDQlsjd4B2dLt/QkfA3FHzw5/6
	 PAlFvb2/TcEc/umf/N9850Uh8TfKSqF5vwyhImWzfVJYTd1PnAKRXXQt4Vh/ebJXTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511896;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=o6eyeg9GCAQldDohtlkHWx09j+cyLuwsmb6ZO8loqP8=;
	b=rSCfcgqZB4YRIaMQ7NwF6uhkW/+txA3zUmihG0NmX682UHDihZmT7aTuUslwWVBYC+E0
	 OZK8tDoNo0aLe/BIH6VDxnFFvrdLcyEmx/Tmwkqao+PeG/eTR2qg5JBNndlrE5Mj2FCoM
	 Wn1eXKFRwu0HSiq68mj2T7YkYLsH2ZS7Tzq4J4+bxBwyVIfLFDn5RHxPOuaz2EUa8f90P
	 H49UT4yMuFWYL1etNkCAOolzMOY8nKoxIOCXJXXMGSpsJhOqbzV24fYx4qiKS3WDmBIuc
	 5wRe7m4r9WsI5gDURroD0kApoytZPl6MkyzpQduHLnSr6lL5MSfC4cuMtoL5s4T0n5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=prS93EtR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LsZUz4YV;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B87606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B87606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=prS93EtR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LsZUz4YV
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CD1E1EC01EF
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:58:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 20 Oct 2026 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792511894; x=
	1792598294; bh=o6eyeg9GCAQldDohtlkHWx09j+cyLuwsmb6ZO8loqP8=; b=p
	rS93EtRtGNrIVi3aTOLIFuLRjoXODvBDe4PGa+K+vTzIVHcXq9Hjq5ddHh6W6m34
	BBEhRlVzpcfhn87repmhlGexDnZvTPWZIGy+OVsTMS2t24YPUFon3iHl0JrpOAwU
	kk4nTn7v7UGR/8/6KCgwg5GPWJnG8SadOmNbAMZ5gex60hxeOGaID3TM2SkYs74+
	WuaGFAPRh+sEIsvnSYLgql+s6OdyLU8mK7KeUzCGtHyGbpn20wiQp5d0wH6G4t0O
	Uh9PZAqkrKZsaiPTyrNMde8lUtcI1XrUjbhqKUgd+UGdmK837RXS7rARZuDyHh3n
	CrUPS43t9jDZoN/KOAvGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792511894; x=1792598294; bh=o6eyeg9GCAQldDohtlkHWx09j+cy
	Luwsmb6ZO8loqP8=; b=LsZUz4YVPAoSGl4mm68L6MwgiUlfomYHRMxN7dpO9uLB
	YM0myUj3NLWdABRkvFBQ5tqpzlmYK4A5FFYE6SD7AErL7bFYnAXABalvhzFu3yZ5
	7gC1wxbl7YgBzo96CMsCf2QRJAySVxF7lSiRcYUSAnVLG6P4/timHpAUbgJCxhrK
	pmacO5W2p5CZbKn1lVgEEQsnF6HUc/I4h4Y/7eNimIXbubKqlQy4T+tlnKcUz6dt
	c7cycAX5VLA77vuXEMcq7MnyQ1VCWvlqn0Q3P+ddFE8suC/5dKk0kjcMBDxzd3eK
	8ZmMt3C0Hv0ciLM1DAGa6Co9vXpf9yRgS6TvAoKCvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792511894; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HCAM0/vXkHpLU7QRhQxkKVHM1IPLe5SWiOxTfgK3SuD3i8J
	VkWjLBvEX9AhF4r/zU9Do1zh5ezG6DwcT5WORC4gqSqhjaboubnh8UshrApHGsdi
	7WJraUYvaA9FkAA7oj8VRVtTEW4sa/VKAlGXufT1anK9lmywok/6QWFiojKjomHt
	SJH5cut4gH9FRsf887UvqhCxDMfqk8uhTywwM34sBbdQPlZDmko8LnK0zXIABFII
	9WRVkKyWIP03id/Xz0yGDQgY/+vtUzeDnkHZ1mMdgwsW9jOul6o08NL1+O4NjVO8
	Q43Fc92wGwAAyrbyg5t4ZDX7MbyaVLO0VmsI3ew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KPTMcoG0dBjEp64AwpRFscGo2acKJQXZtY1L/niiQ9A=:FsuFc2qE50cOGdFCJnZNapcJ30wDd84vEqlCH1TQkdM=;
X-ME-Sender: <xms:lo_XapBYG1Pc5t7aaJIjcWTUwEKf1GbosrnTS6JWT-AIfTfhZ0niQQ>
    <xme:lo_Xati0iVGQrfKMXi6QJBaej7b83IyUEJohJWl9koVbmYVyq7MLR5qTDrRQeNV6q
    pg-ROZcYAZjdgpIgicIrATTAhlgnY6BezqWSJxamADdH6Q1GW8uUKU>
X-ME-Received: <xmr:lo_XaiMGhavA_KYVMyFOZAhIYyLYiEj6u-ah0ZGlOCiYMy8bu8dad7oTLHKpViCMqaZbbQQz8dYldgcMDTtHEUti-eXxdaAauTdL>
X-ME-Proxy-Cause: dmFkZTF171MS4ae/6AOljRaU5CcevHyft3wNTsh9Jm4C/IWNz6DMdZt5iwJrZp6QhLrnSW
    3C77wLNaqrQSDbGWhRvfybdY98dKI4S9Uf5eVQQkQ80Mj1GV/BVhMXcuqhKjOomvr4R/uT
    WpSM6gzMukRN2MJGEK85wCv+i74msU6ZRh/6GUAvjA7IwRYQvPUitnTR+wPgrFrwx1SfYo
    SHzqvtcVr1cQIa+9CVGWyPpTMwcY9Fz7pY74JobFpQsp9er3U7dYVO347NhTIGB7T/0rOj
    zd1tdxKT/f9ri/pvLaOpTirvRGNO6l+m43BxXpfjKKGK01FDD7VPVzqeyCrbQZyThyJ7P4
    3B0ViT5rAg7v8msiyOxTL7OxdHbyMwnnMgmhaiLYxCT1rUWSpiQnPfk5y9HhbfhGW3c3Eg
    r818sDJNZ22Ry9GSh3uLO5nU4+ovjdnHp/9Wcr1mfUEe3P6ivylN8JFWZrZrKHi7F/0+Sy
    l8Rgf1+3tzg9/7Qi0xJTDzSAuVxnl9aFYXyymIqkp/reiIsYlR034NGhmSvz/wxzMdPz0W
    oYqxCVAFy8jx/utKBTGIEP8PywxZaofBjDzEpqQFIcu+PJUFFkuaYLv0EujsbJyfggeHhT
    FZphIdz+tdFn2UgiiPLyUWx4X+RaB02+i9uty9rwdiyJi6JdrTIRzdd78Z/A
X-ME-Proxy: <xmx:lo_Xau5XRbXMeHPm33sIezK5BRjfrZNLTlZHOZivuthcYWl0sEvG6g>
    <xmx:lo_Xag3CtNiuTWzo90tdZuCG56f3eww1ovqLH7fvQN3Grik7DkTQRw>
    <xmx:lo_XavY44nJilCMf7VRBhp1VCKDy8ggfZm4svH9ygBvCoZ9cvdSJ6g>
    <xmx:lo_XaoD329vjzvmMUuhAeN6KH2s1p1NyaxNBhKHCmV2nOeNDmRdHvg>
    <xmx:lo_XasbuV0e05_PSQJNh7Ew3lIlmelZsuKLfCKmMaKBB51UqavivrhVs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 11:58:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4] github-ci: update macos jobs from macos-14
Date: Tue, 20 Oct 2026 08:58:13 -0700
Message-ID: <20261020155813.3315813-1-gitster@pobox.com>
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
macos-26 for the other two jobs.  Use explicit version number
"26" instead of "latest" so that we can more easily tell the
differences and similarities between github-ci and gitlab-ci
and compare their outcome on the same commit when needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Hopefully this is the final iteration, and hopefully the later
   part of the proposed log message explains the reasoning behind
   the choice between latest and 26 well.

 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7e5769f543..e8f744d069 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -326,10 +326,10 @@ jobs:
             pool: macos-15
           - jobname: osx-reftable
             cc: clang
-            pool: macos-latest
+            pool: macos-26
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-latest
+            pool: macos-26
           - jobname: osx-meson
             cc: clang
             pool: macos-15

Range-diff against v3:
1:  428ed741e9 ! 1:  2378f810f0 github-ci: update macos jobs to macos-15
    @@ Commit message
     
         and suggests to update to either macos-latest (macos-26) or
         macos-15.  Use macos-15 for two of the four osx-* jobs, and
    -    macos-latest for the other two jobs, which is very similar to what
    -    .gitlab-ci does.
    -
    -    Because we do not care which exact version we are running, so
    -    request macos-latest instead of naming macos-26.  If there were a
    -    similar symbolic name for the oldest-but-still-supported version,
    -    we would use it instead of explicitly asking for macos-15, but
    -    because there does not appear to be any, request macos-15.  This
    -    would require us to update these two lines once every year, which
    -    is annoying but is manageable.
    +    macos-26 for the other two jobs.  Use explicit version number
    +    "26" instead of "latest" so that we can more easily tell the
    +    differences and similarities between github-ci and gitlab-ci
    +    and compare their outcome on the same commit when needed.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    -         vector:
    -           - jobname: osx-clang
    -             cc: clang
    --            pool: macos-14
    -+            pool: macos-15
    +             pool: macos-15
                - jobname: osx-reftable
                  cc: clang
    --            pool: macos-14
    -+            pool: macos-latest
    +-            pool: macos-latest
    ++            pool: macos-26
                - jobname: osx-gcc
                  cc: gcc-13
    --            pool: macos-14
    -+            pool: macos-latest
    +-            pool: macos-latest
    ++            pool: macos-26
                - jobname: osx-meson
                  cc: clang
    --            pool: macos-14
    -+            pool: macos-15
    -     env:
    -       CC: ${{matrix.vector.cc}}
    -       CC_PACKAGE: ${{matrix.vector.cc_package}}
    +             pool: macos-15
-- 
2.56.0-321-ga7e4057184

