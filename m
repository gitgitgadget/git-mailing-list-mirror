Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114389;
	b=IptgTpk5xtqLbzlQLZCfiEscZ8En82iNoJNL2ghS2Dz8A2d/V+LgN9nK9MziLbNuHTCc
	 mzpNEi4XL07wDMU70LPN9n2923zVRtLVQ0/2EetbOGguSTofFk+mzlNzlm1FEh+RvxCFj
	 LYP87wUCYBWCvI7CfLg51tpda+xBhE3/bMnHUEZX01b/m9KmXJkjvnbDFVkV6x0YGphtr
	 vTt2RZovj34vBHdcyVErYcN3vou7QBLnNe0WElhJgXcfyIqfLgovY/rAdp+cI/QwzIwkC
	 yDNPfUh/yqcgRTSLpNVH1TOyXGYqpzWf7iMWgSb2d5gbLi3nQKVtz1AYD7bLyqemgFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114389;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7U6e15C8L8jm24W/dXb2pOljDuE82OVr+bNs7Q9LUwI=;
	b=j2KlRmFtoc9N8AEUG1PB/6ghYoM/Kw6HsmzGNYk/e4Dtg59wAA8nJAZLQiTi0lpEuH24
	 BF0WeFuDyAJhtA9dg3rbbkTB/ZCNCILOe3NOZ+Arc1omy3PKIBAmr5oCAOdyAfL1PRgQl
	 4g1eM8qflsSlFTlBRTcuH9lmeFJ/Y8TGGMX8ntVof1awUDkZlifC+/CEzAAlQaeveLJfZ
	 mlZpfasy7RUcjAcRXanZubi7VsDR+fYbqJcnoQWuEdt+aPgiPGvVV7Rwawqp7Pa/PohzD
	 eWE2S1hwafRUAv66G4Fq4CnG67vgL2b+at7Qn7boVgil+Tdxqhpf8rOPKY7PoZqE0eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hKdGuqLT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="rupH5m/R";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4ED606AA88
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 18:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4ED606AA88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hKdGuqLT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rupH5m/R
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AF7C71D00244
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 13:53:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 13:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795114387; x=1795200787; bh=7U6e15C8L8
	jm24W/dXb2pOljDuE82OVr+bNs7Q9LUwI=; b=hKdGuqLTyvkin3AA4kunFQh0u9
	vVXyAKnrCX3zfxdZD+IHWxfCN0+PV/OD0QLbYJv6uqCD7wKC1s8uRs/5NTYyu3Rz
	YQk269JoicPWv0pnS2bw6l30VYHBLE9liNqxoipXiYcjKkx3uDO648uDhDPBziEQ
	6L9vxwi1aHGRHWQ+1Lk+pfMp1Deg+7fudy7+FJPGOkj1Fwh4U62rn1vnMLY6ywPV
	BsbWwU90ENElRmLIXORrEEU3WEILtPuOksgx/WH7K24HzeWSghG1hN0Q/Qqm7+Q7
	KtAGYB/o/Ff4BY7ZOyiKaPtaS7rbH7xFbQ/xc30Evp4M45uo6IQJzKVs4ehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795114387; x=1795200787; bh=7U6e15C8L8jm24W/dXb2pOljDuE82OVr+bN
	s7Q9LUwI=; b=rupH5m/R1tYdO/orY8wu26zqCspUjtVCdk8qys3uA45FcFIuLVO
	LzhaNOxPUe4jB/ORUJBQaCwB7sbpPt5ekt8C0SSJbT2xyA1bybbIuTfPqM2DjBMx
	ppg2G4rEWrOsrw90lgWtI7XFx2Q6QmKY2c+lhtZbaAisev9bXUCnlTxZpoq82lNZ
	NL4uClxnTkykbAXj+sDK5WCnat9V+Ofuu/vhnVXjp3viIDJlNtbdJfSgWrjDVmVY
	hdCXVNoLUFz7WW+8TN125mjZVnH3AvgsgnNPu6mjM2PNqY4EMauE8yAn3NCpHdFc
	MiFNYO4CVFggegvB3U1dOiJZumouLcwRnGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795114387; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IOFywbZ9GQ4M844UlC3lLjeXpiduSJkUP5Smuwx9YFV35+E
	YmXYTx8hLGH9Av4qpYRHte5Q9qXAlMGtGDicaBZkrsNpDLccKGUtNc2l62f45X3Q
	8EWaK7VlgK42iJxReu4Zf8mTh+XqsdMIzMVUJMR/Qav70rb3g1hrKAhfXXT8EiIQ
	L2JNtooqMivxN2RpnU1DZ7okBSqU8DH8x56q4Zk3qSKArnDaHJTygbwwacOH8dVB
	6XSjWG0BHLoO8ZVwwCicMZhXRAyRw2rcVQSjs8Oxd0VHM37W4FMBvnJwG/yPxmAW
	/7fvjt5uqeNjfES099xuo0cTut6vSLv6z4XG0aQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QVTrXi7sOZyU+oHfyPDeUbWiimGwx1BI/sCtXdaWaG0=:058E7ZFkV3Qu5HxbyG2ZRbJCqftsrUULI44cT/fDGZw=;
X-ME-Sender: <xms:k0X_aormG3C8wzCEQgK4oySG0__-Nj0xrl3eXRHMpznWfsZOwUvrKA>
    <xme:k0X_amEcC7I6t0qlZwgpWGegpJkQvCxXqI8IUUemH9r2a5UPXNCduNTX_m2xW0gm4
    NjyeL7c3ayDanYaYwE_iVFiMWA51Dir0i8FA2eiAZQ4sQICHJe3dP8>
X-ME-Received: <xmr:k0X_aqlDJEZ2FoeB69f1p1W6GlLIgmR0JdIfy25nf7QM1IGY2Uql2GDeSQFdhWadxdQqa4c8g5LH6OrbiqUDyJO7Mu9iTcbcYPuz>
X-ME-Proxy-Cause: dmFkZTFyjxWISUnG1q7QhZD6h8w7hdtMZmxPJatLLPMbjjjZtEh33pEKyjLwGDE5c2xWnf
    6v5MfNuZoV3Ac2dntE+XFYDBuSXVxz6xfnIVWR0NI6XHUtGs0Q8fQ5rTeeENcyKlgTRyo1
    PfIIM/wEaWLO+bwNG7MjBJpcaPB/CW5BcJxZr9csvulECl+O/nAXxGWVH80PmdnWONqqcY
    9HQeHhJSopPahQClAWPXH2/K1Xd4kaBCVauM9CddRvyUK6PyhI40RRbOxHUVCw7TXEWDmg
    f/x9leL+mYpDU4HElczwDOlYJE4HH+YMoKu1TgyYc+8clfComn6pVW2wP/97NhUwhc0UWR
    EGozNdjPm3fUnNpKaqMSOaEz8udkAEAvqctXaiyLzpIZTSA/JyCBgTUQFE3RqLD44T+Z89
    qQ1DlAJxlFVqDbioDl6XCJo3SKfYMWD+PU5wXT6DeQ0RQUwQ3yeNPcM4q5uimMQz+BwuIk
    htgkuqnFI70t3EHkZqWH6Rl7iqcwZvSwFLTgCtJHRb6P3WyLNoLu9a3PBPW2i2Td+T3wm7
    wpDzYffiK3v7l2erhN0l18jWbYi1Ki4xSkui8qZkBU83vMjZebq+cBN1Vygv5StBov4pEy
    UKZEdRmRNsu/3BVyl6QwPThMlg/t7tyAbNnFC108oFnYEku4sZgoSXZDsgPw
X-ME-Proxy: <xmx:k0X_apko0UjwwMrVC0fLqa091yvDo2ylUZLDxmpLkKqMzrXnTXuuPQ>
    <xmx:k0X_ars69XDSNYcshKkiVtQj8YvJWZRSyJnIyJNa_QM7_PGEq65Wsg>
    <xmx:k0X_asmEI8REYTO1o_e3-lFH8wOdx-hgaJ0m6f0_u8vWX_qXLiJ0dw>
    <xmx:k0X_amspi5HHcJoBmXCKSbfxU05jRH4K_Sy_C55uGxoqL4-ZR5E7fg>
    <xmx:k0X_auGpkls_JLDlKsjdgghj2-dJTYQW9-7v1JDRM3izn-RN3aNLzGTe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 13:53:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] fast-import: do not show the path when "feature
 export-marks" is forbidden
In-Reply-To: <20261117-ks-fast-import-consistent-check-unsafe-v1-1-fc1ed53c79b2@gmail.com>
	(Kaartic Sivaraam's message of "Tue, 17 Nov 2026 21:33:05 +0530")
References: <20261117-ks-fast-import-consistent-check-unsafe-v1-1-fc1ed53c79b2@gmail.com>
Date: Thu, 19 Nov 2026 10:53:05 -0800
Message-ID: <xmqqbj7ky7ou.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index ab5d2a2344..998167794c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -3918,7 +3918,7 @@ static int parse_one_feature(struct fast_import_state *state,
>  		check_unsafe_feature(state, "import-marks-if-exists");
>  		option_import_marks(state, arg, 1, 1);
>  	} else if (skip_prefix(feature, "export-marks=", &arg)) {
> -		check_unsafe_feature(state, feature);
> +		check_unsafe_feature(state, "export-marks");
>  		option_export_marks(state, arg);
>  	} else if (!strcmp(feature, "alias")) {
>  		; /* Don't die - this feature is supported */

This is an obviously correct change, but doesn't this bug caused by
forced repetition annoy anybody?  This if/else if/else cascade is an
obvious trap waiting for another similar bug to be added.

Wouldn't it be much nicer if the above hunk can be rewritten like
so,

 		option_import_marks(state, arg, 1, 1);
-	} else if (skip_prefix(feature, "export-marks=", &arg)) {
+	} else if (check_unsafe(state, feature, "export-marks", &arg)) {
-		check_unsafe_feature(state, feature);
 		option_export_marks(state, arg);
 	} else if (!strcmp(feature, "alias")) {
 		; /* Don't die - this feature is supported */

so a separate call to check_unsafe_feature() can be lost, and we no
longer have to repeat "export-marks=" and "export-marks" for all
these "unsafe" features?

If we plan to ever add an argument-less unsafe feature, the helper
needs to be updated to require NUL (instead of '=') after we find
the end of the feature name with skip_prefix() when the feature is
an argument-less one (perhaps signaled by arg==NULL or something),
but you get the idea.

 builtin/fast-import.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git i/builtin/fast-import.c w/builtin/fast-import.c
index ab5d2a2344..673d3f2289 100644
--- i/builtin/fast-import.c
+++ w/builtin/fast-import.c
@@ -3896,12 +3896,20 @@ static int parse_one_option(struct fast_import_state *state, const char *option)
 	return 1;
 }
 
-static void check_unsafe_feature(struct fast_import_state *state,
-				 const char *feature)
+static int check_unsafe(struct fast_import_state *state,
+			const char *feature, const char *prefix,
+			const char **arg)
 {
-	if (!state->allow_unsafe_features)
-		die(_("feature '%s' forbidden in input without --allow-unsafe-features"),
-		    feature);
+	const char *arg_;
+
+	if (skip_prefix(feature, prefix, &arg_) && *arg_ == '=') {
+		if (!state->allow_unsafe_features)
+			die(_("feature '%s' forbidden in input "
+			      "without --allow-unsafe-features"), prefix);
+		*arg = arg_ + 1;
+		return 1;
+	}
+	return 0;
 }
 
 static int parse_one_feature(struct fast_import_state *state,
