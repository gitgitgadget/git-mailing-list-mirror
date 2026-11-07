Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027366;
	b=XVaPb8OrbI/fd+qXINpBzugRTxZwZpKJqIBCjxjBKKVYWpWQW769Y9WtDBvc3k57X87N
	 Pkl1+hs38W7UFG8lF+5mER2X8mFHc6rHtjgf5gRaNj35BFet/pzs6Y2kD5BdWqGEjRZUM
	 kHn5GkICtyNGOATUIfYKAFsDO/jmM5m4Tn5PBj+23bOpMvDbZyNwTFW0MaCoPoPviMEo1
	 2b4q11SKMBJinixcfYso9ju/BsrPmjMpiG0N5GFjiOcRDDcF6GLAytQceshDWUveIE23D
	 UV40oP58uxVzkdvqRgS64JSEqs/mz62qDb+kLpTd+zI1ZkAe0AG3Fx08V8X/rmF+K1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027366;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wmcA72TaeEbwyBzhVXyiZ1eH7846PyAkHNEpMOTByGY=;
	b=CUiwUbTU9F1kACcmCpOpBHWZCe6AKffNHqVPy2CV+IsQ2ewzoK4djBRHMK+yQxFHcEbQ
	 gOIVL27NSZOK92K5YRleQl4uPKh/LLk4Qmput5nn755o6oNS/1bY6hhVDIXvbh+ZKF7gP
	 QQVjjDXvzakCJ81ccwKVD2VhiIUqwnD+iOlDvT1QpOfSf+TFxFuk15Q8xgTR/nSaiMIb+
	 z5etl6M0FkDV8Sqq3f6aFTejsw5dSIic/Pwj9nG2zrqdPW1FYalEAFE5eVoj5sEzLcUvI
	 RroIqN+W/9CZjdkSrFha3C3ULDhGxLT2h54IWvu010BApYo/EIRJW/505q7wH5BJCWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Wy9UDNka;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V50chqea;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DC606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 04:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D2DC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Wy9UDNka;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V50chqea
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 49638EC01C9
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 23:56:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 23:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794027365; x=1794113765; bh=wmcA72TaeE
	bwyBzhVXyiZ1eH7846PyAkHNEpMOTByGY=; b=Wy9UDNkaUY0sWfgxn1oKmzxxsB
	6nKLzfpD3Yr8Fl9nd/RCNFlg5Z5KsYo4cmH3L+jev0xxNjxoSPAa0pLO+yMGgp+t
	0tvW60aXf6maGN8ZO92+SbLKZT509gNyAmbrH08m1sSTApgaDiW5kIDaEHB5sB0W
	0Em2i8vKBTfbwK1ttqmrMZgs+ShwBIQZAfm00HUfkaJeDAZwJiWqQhzZOaNP/1TD
	jAK1Pyztk6v67pZSQxoeJYTHyYMUmIfI5zpozPjbLwA66Jn6RLS8BPuC+JUuczcs
	2lZt7K1kJZAQEJ+kNt/D2zqgB8QDy3vbQDEVcSDh29t7dCGI4+MsRvZApFzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794027365; x=1794113765; bh=wmcA72TaeEbwyBzhVXyiZ1eH7846PyAkHNE
	pMOTByGY=; b=V50chqeaPnpDSDPHxeEbw05rT8rgUXaoaFafiNquEPnGwEZQD0p
	DY2l7QyZw91F6lqgA2T4EsLxAAMDlWYBL9Luu4xZAE5vaFHtAikduFbGJFre9Jni
	ToXgE0SBtksVAViPuwpvXExpKPpj54qRpZ+E1Cs8fg8+Aosomor0ypwsV4NKFB+8
	6B3oCT6avdy56W2mt9hiIARntu+DPT/c2QW4kfjKf9fGGcBURdNgw9gJBKYQ5StP
	j+v+G6z+wP4ivU4FnjsP3qJ+RbxfYxBykm0lO/hR0D7i6n8oLHPGhp2TA+I0f31w
	9YGtIvbuzY1bimC4g927JSMADikQbrlzx0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794027365; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kZlc/GKbJbGnyAt/SYoaHH0ykabOPx2345faogQoE7OkpdX
	osGRL2CM2AiNQaavaWvXpkGLRIGbyy9EIRG4EsWjfofhjKLwbA5QM0hIC7Dc10VP
	mWl3c/u3EG4p7Rsv504jmvWKcgYLp+JHTIzgIY9ITpyBvY9nC8jqezxDsjwC6B+4
	SsR0SIcQern9uQq7Z8okwv1ZqMObu32r+kqV/vYJlG+D982SzD8gpfiQYSqD0qzv
	q48W9qHBr+rqYCK4rCeBwzW4W08bbd+QpXfERifIWhUJpQk8jz77Uy3C0Hmx8WWQ
	A+nvdbBmEBiNOreLGt/x2nAV0EH+CUF334C6o+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:thZYH7aSqVtJl/2v6Jghd1+z7Va/rHA76xRZFFqGzgY=:V8e+YlVYBIspCEbSVA1LMxJnZB/tor+K/EEOyopXFP0=;
X-ME-Sender: <xms:Za_uav8PerqI89M2A0-mPIR42h08zIy5ijUezJm7ZOcZ-TeBBZer4w>
    <xme:Za_uainQmAylogly5Hj59JSBOemJOQK94a0wVDamWLGdA2MRGn7VeVz-J1hOyQRTp
    DqUWO4qDdCCQ12DNE5gh272-IATb9pX8yz1eAwaeiVaS5L_FVayddU>
X-ME-Received: <xmr:Za_ualUK9L6lPK-wcAaAuHAU6sC0iUZk1OPogE7hf3XDiSJSkvD7lwZEwpogUW6Qr7-G7qcef7ppgrVo0dnqwhUkqRUmQdiN-ALr>
X-ME-Proxy-Cause: dmFkZTFzhF3YCcVoWXZZfn/Cfd0ZLLJO03htgO0fq4q9paW1PiNHUfFQJ/oJEv9791i4OY
    zaSkJnzXlGsSN+vm15g4ZmJj1SLVgifayAhWzZveHtk51JgioJv5W+vHjekHbz5stty1BL
    EIsJoCYDDZ2b2NzFeiShV2EZbxfILU4Sm0nU0Xduo2AuvjCJgOWA98IqCPvJ+jwERXNc7F
    vS+T/Lqdo6uuCcGQk/D5G+uoV2NhdJh7g9W42o/C3/aiKiHQNv5dPn+8wTrM9zqdu6EcjA
    31fAqyoBjWLvnVReyu8rmjEXh0qYr04lj2wpxYLeXmVEBXPT7OlSmKm9YdVXRY/lNO76ik
    Ni+RvT8XunCV2qNtIBeJs1uPiemA8e4MZZamj/aGC+C81+7JT/Wn68HeiAHAYYAMgywzmZ
    /nHD9oxjKIUpcFi0nN+UzJ0i0L+a2jbVbqB0j6wdXxCyFWae8zLUbwJiIJ2i4lJQy0KTRN
    Zwl9UCBq/gKMIupmvCf3THlfIZlaLCp24Qz0Ml3aeVI+lmBOPgBS0HOVPwOWzPPyr8H+nX
    toApbxuWFDyAGkZlSaFFzfU8b+OTUH2eo3CCMTQlLm7qWJnkpXRGHNtSVICPe/VqNGaMZ+
    bu+nqb2bTRZT6uPPV5PjpumF35pd13huKKpNzV6i1pwhtP7va5XlSXFErVNA
X-ME-Proxy: <xmx:Za_uanHuLVEtLLKWCJnXrk8Q21tBR2FhIgTTx9PgDoKvb4iQFsQVAg>
    <xmx:Za_uahfJCdjLdQEjp96SFT-R_Ko8fF17GbIJ7Dn2diCNlt40N13UJg>
    <xmx:Za_uaoKiBR4pa7OeFVBRIzBGJeE-joEI75Cpt3TAOS8lz-1gw38YEQ>
    <xmx:Za_uamFFeLpl4DF6Ii_5n8kn8N8FeUmzktVR5mer_9-5_oDSh2wqWg>
    <xmx:Za_uak_qDf6WyeVEQToIMJvnlaPKTQVSajxvoaCvO6H1JAms07-0MZZX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 23:56:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Antoni Borowski <antekborowski11@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  jpoimboe@kernel.org
Subject: Re: [Microproject v2] describe: do not translate --debug output
In-Reply-To: <20261016185418.162998-1-antekborowski11@gmail.com> (Antoni
	Borowski's message of "Fri, 16 Oct 2026 20:54:18 +0200")
References: <xmqqpkx9fq8o.fsf@gitster.g>
	<20261016185418.162998-1-antekborowski11@gmail.com>
Date: Fri, 06 Nov 2026 20:56:03 -0800
Message-ID: <xmqqjymp9r4s.fsf@gitster.g>
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

Antoni Borowski <antekborowski11@gmail.com> writes:

> @@ -477,14 +477,14 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  		}
>  		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
>  			struct possible_tag *t = &all_matches[cur_match];
> -			fprintf(stderr, " %-*s %8d %s\n",
> +			fprintf(stderr, "Debug:  %-*s %8d %s\n",
>  				label_width, _(prio_names[t->name->prio]),
>  				t->depth, t->name->path);
>  		}

This one has _(translation) still lurking here.  prio_names[] should
not be translated.

prio_names[] is defined as file-scope static.

    static const char *prio_names[] = {
            N_("head"), N_("lightweight"), N_("annotated"),
    };

In describe_commit(), the length of _(prio_names[]) is measured only
for debugging purposes (which is outside the pre-context of the
above hunk), and they are shown with the fprintf() we see above.

The values in prio_names[] should lose N_() around them, and all _()
around prio_names[] should bbe removed to make this conversion
complete.  Perhaps prio_names[] should be moved to that if (debug)
block, which is the only user of that array.  It may even make sense
to rename prio_names[] to make it clear that it is only used for
debugging output and nothing else.

So, earlier I said this looks ready for 'next', but no, it still
needs a bit more work.

