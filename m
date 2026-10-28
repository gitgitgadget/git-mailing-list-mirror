Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217146;
	b=N0xMGmyS/P9xjrGiNwEaFqQnd/EIZ+X9BSPtFcrGY9yc7B6Mf3xdPffQJWUykJ9nzoO5
	 jOVRT/BLHGDmrt3aEsJN1giGBELsDfU3PYM3aAAFIVBzdM6eTzkAZ6z6wW/Qgd7WybVM4
	 Y0Ij29fM7ZHZJ7Yionta1WVbOyatIeDbRm0ld2gZHvrYvrusujA9A2KYrJD7OAva3jMrU
	 +GhbTMRW/f6juXmjZYkhXGKvKGYdY4FYUaO0fFH72xClG1oC5vZTiKWOuECgprLiemzu3
	 pqATgEc43mZffaYPacSFMMmQ3GmaYJLvC5dVq14s1nQzFXur5NSNibLTdfbQRcq0rvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217146;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=jtp/quaWLZ1lIVvzQY2QZ2t71wfyot9iPtTL55o5dOA=;
	b=aVH9ZLKmS7A4ivhz3KKQK1KZ/pg+FaeVTx2LBJEIt3THA+scYESV3togiubofCY86zbi
	 2QSZHJgCzypLG/1bymbiDd2kRs4Hbz7cuJDh8y9DgCpjswBQZPmfs9wyNc3KTnPfh55Uv
	 ktzN7ToJ8o/JFxuDdn40RwQYzk/bjCLFSunviCWepeRmc/ilxNFcqxRYTW0Tj/0DL5+f+
	 GFdWLhTOKj5QlUZj1AmDQuPNHwYb48oCavtNfexUU8uBkMwP78IIwA2Gt6iviVzs3CCFn
	 QBxkY9FW8v6syQ2JvKebJ5dP/i93kWqXAw9V64MLJWet/aSRl1B+eiXBgi1yMws9CsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XnMUC9Ai;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ML7Qez8g;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F1606A31F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40F1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XnMUC9Ai;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ML7Qez8g
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE2D01400069
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:52:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 15:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1793217144; x=1793303544; bh=jtp/quaWLZ1lIVvzQY2QZ2t71wfyot9i
	PtTL55o5dOA=; b=XnMUC9AiMqjZrOy8ZQ0mwhiykRDfFj9mSUuhMEt6bgFrFpyj
	G+7/LKoWnDg+2TprT/SaJ94jsIVUfU0IsPXiVkUF6eaSs3FUty4lu0ZyAJKSFVhC
	H5zIQwa+hIsGam6wO07XhIQ+NRIuNVcTaeYLMN3Hw68IHoArhhwNwnMpf5fW3kvd
	MoRhxOtgz6sk6v5hhF6bcBxk1KcqCmZ48mcLdbOMBZNILFTPBOvQbSDJ31W0LYIn
	5Q9iJJj2pykYTOnNqC30SV5g0LcO09n1QIw9R9Ct6RYJIlD+beiUVMaBGGm65jZh
	adWIW8FkdfhzGErfdnAxFlw5nbeWRrxXSuw3OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793217144; x=
	1793303544; bh=jtp/quaWLZ1lIVvzQY2QZ2t71wfyot9iPtTL55o5dOA=; b=M
	L7Qez8gX7WzPTvPoE/VrGz/mWjGLKjLd25mda7ecakfEK6Sbvg9LFxM2b+Qf06cj
	dKGECV2StErT6e0J42e6y1Wl0xAmqvjgPXjOtWq6y3JZ7D/FG/hdLzN8wfIDnML+
	j4BTPKTbYqMFASkQMbtWX+7gTGt0c6CHQMO82Cji5sIGajpiqnmWOp6tx991PkiJ
	Pi3nOxNvuKVU3Y6HJdiZxIJb/NVftNkWsBeBJ/n2RCAcbBWwkPBWCI6Dagh7qhUd
	28NSGf5GOsOh3yFvsfqVuW5Ahv4mnTGA8GDrIpoo1Ha5BEr0UJjI7HbyzOGuSnIN
	NafujALYhRZkDVEKKyDig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793217144; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iljucUg2WYFdSwkqXgF6dOsX/rn128SUg/wtf1RPyuHgvCP
	tPBddupSs2EeXzvYqMnkbyjPrG3AtpDQdT+PuNeViVLu/U9hGwqEKGOJDptsTKdN
	LYNm8JkHpYQx8pnoBKanIG1a/HVKlB0X93GrqNBUnWiCqOWOGxLaBfAXvdVPGtds
	Ii3kYFsiRnxbT3i7Xu4qSoouInY45IdxbzmE+oG5WunWO3YfH0typ9NAJR3HhkAB
	DMHWcDOpSzqiMfI9I1amEH5NNYMGB5TxJX1yXAJpOf7gVB09/lhFoWSjWEGjVQbU
	ouZMDDgoAozpn894Xlgu+vjTV7oqoaQ3Oz9jd1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:n/Skhp3VLnrEHyojFZVRIKu/ZvlB5F6A0/oViaHML9U=:bTt2uITLNtgm/NU15Pvp+6vvSY+Kc9qdmu7DuLJPSyM=;
X-ME-Sender: <xms:eFLiaizFWrO-aifX_CxNFawvgod4ecGCqVfGwLBDxk7zmy8yVSxZbQ>
    <xme:eFLiakQb768ATB-afEsMCkMhksLoHFlZFf38zDhTsdmbRq7mrzm3NNSv4-UTsLTA7
    2NwACSKwNWX5ESYZupTUVctx7mFLSqV632q1R9-AbjKEThyZFIA0yQB>
X-ME-Received: <xmr:eFLiah-qRgoonDbDxy2NXG3UL-5qSPBftqrLvP95cTgFEdMVmmquyKwLq4K2xJzG2Bgjm99pOjcO9gZTb3iKQ8qTFgmsO-jPUSgO>
X-ME-Proxy-Cause: dmFkZTFDJrQ2uS1lbfhqZaFshHcby4gcPzx6QbPpeHmBiyBD7bz7FtkY6+QaWTy+Sm+AmV
    Pte4CawvhwydRgI4UpAZJNI/f2nylp5bL6UQPcwZyiQ8hJu1VSmkjaWI3dKiW642EUMnwB
    A+Z44IrSX6kofSKfGFIofdPLXOClwpXJ4IjDfsGKOLtQIRugpxe3ViIquS9s05s99ex2c9
    sw2bBFn9IkF920OZCSnZ9A7cjYsgP8ZO4WObj60MW73QqSfg2LyR8JA3g6ZEt5MbNJbRPn
    cfU3lQmmiVLR0GZscS4zU2cZdK5jWWmTYpze2dlL9sfl1UnbvBoDPOBGeKzvc0h5THLpQs
    V/m9eGyDR3rDYnpS0KCD2vs7ED02FoCfzpQiT35xog+tmpwiDefUKMhLgYWZ/9rk+TElm/
    wonLlI8S2ks3Sr7dUZeZcv7FwDZxo9SkmUQEFKq3mt9IP6JwfVn72m+T/aCpq1l4H4JIOm
    RTQazlkob/UbqmOyfnv/HSY5PFbe+O757PodqX7P+xHh4HSnnWCYrSuxM912luTRX/Eonv
    4fhupGdqlbGpfkmvbOhpvlfMYT09tMcgS2uXLght1h0x47USV4FWtyFWEjTEfdK4m7sXAl
    m4ZdbFcg0rvpm9SqNIXf9gWxRaR0IiqwJ6HlWPJry5sdJVTXN9dF0bz0HNMw
X-ME-Proxy: <xmx:eFLiajqSXLtF-IydvMmW8lB4LLhPc5bnXEq9mraJpUlNsMkn3TNxZQ>
    <xmx:eFLiamncCPVvKQ1D2lfxhyjnGsqeDZvkQ54llip9onSeaHJUTSD_CA>
    <xmx:eFLiaiIaMCcEzgN-i14lcUxqTIUtkTjtxn8vOwmbCWYkMIH9cX4_pA>
    <xmx:eFLiajxf4lWp_UHOliAkIkOXcMg4myDRjo4mqloCxma5oLTsiCQdXA>
    <xmx:eFLiamLZNWCgJBxdbbtGOg-1aw46wE3AMSl2ex2LdFkwA-lTcIDb1xct>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 15:52:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ident: remove unused author_ident_sufficiently_given()
Date: Wed, 28 Oct 2026 12:52:23 -0700
Message-ID: <xmqqo6cd8ux4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

A pair of functions {author,committer}_ident_sufficiently_given()
were created to replace user_ident_explicitly_given() in d6991ceedc
(ident: keep separate "explicit" flags for author and committer,
2012-11-14).

But author_ident_sufficiently_given() is never used in our history.
We only check if committer ident is sufficiently given and use it to
nudge the user to set user.{name,email} configuration variables.

Remove the unused author_ident_sufficiently_given() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ident.c | 5 -----
 ident.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/ident.c b/ident.c
index 0b7aacecd7..eb73d073d8 100644
--- a/ident.c
+++ b/ident.c
@@ -602,11 +602,6 @@ int committer_ident_sufficiently_given(void)
 	return ident_is_sufficient(committer_ident_explicitly_given);
 }
 
-int author_ident_sufficiently_given(void)
-{
-	return ident_is_sufficient(author_ident_explicitly_given);
-}
-
 static int set_ident(const char *var, const char *value)
 {
 	if (!strcmp(var, "author.name")) {
diff --git a/ident.h b/ident.h
index 3c03403879..7e60e36415 100644
--- a/ident.h
+++ b/ident.h
@@ -60,7 +60,6 @@ const char *fmt_ident(const char *name, const char *email,
 const char *fmt_name(enum want_ident);
 
 int committer_ident_sufficiently_given(void);
-int author_ident_sufficiently_given(void);
 
 struct config_context;
 int git_ident_config(const char *, const char *, const struct config_context *,
-- 
2.56.0-433-ga9209adf11

