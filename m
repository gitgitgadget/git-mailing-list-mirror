Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448047;
	b=Va3UlVfY5NKy+9Krd6XQc935SHFa/p8aV4hACKWmL9h0wYd2Ory9tSbuA3yuNarveQdQ
	 wMATLoBcRYNV+HgyMIs1Zql7qyo7HkkZapiK51+huWa4ybMV4G6TDftcdL5cWSGyPNzPS
	 eeEL2jt4xLGLuJ/Sz6TfUKWLqVjZwGHHL563+Adu3cQZtpFXDYMAdsobu2JstKynk8xLR
	 mBNRER6h4mOEZFOT9kwlsPU19hdCSvEwBD6CAcsj8o3d/52Mt7yO599iPNlgoQJKQjqKr
	 VyzeFAklHxAJWweFVZu0EnU8XasC1gX2Vs/u+mR1p1Vp0eC6eWgcMFueRWaj0txuETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448047;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7AwPxLVJwGB7FlGlyWXvAD2XJrI7nGrq10Os8RT6JD8=;
	b=fDVj1F9UvbjSQ64Z7mZfope+DC/DUJ2fhDLC4JCjXc9utDZSytYZYeU/+rRi41+zFseT
	 BMbfRT485KmAoDCWLpUaKc+saQDVHOR3Us01ntbPSw6NEcjeD7KZ7xdJ1WPeuGAPyEzXe
	 HdXICJDQVKrsbYmdrYNtAfvLzPUXeYCUNGOXb4SZKqa/JRMIr7dJtIJon+RtmfZNw+Ll5
	 bXU3Bsi4DMWrmDLFB87QxMkCXT/h+K1gJWYC76L3R9wMcsaqJERm/SIibDR35kD9L8qZO
	 ydxZPBhLDpTeSOLAiv4EKl6ft24+wC0vRdNmkdOFqrsD6cUSLG6xHMZBA+8K9bRxHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BKbi65E9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zq7bOTWq;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96D606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E96D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BKbi65E9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zq7bOTWq
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A04EEC0ABB
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:34:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 10:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795448045; x=1795534445; bh=7AwPxLVJwG
	B7FlGlyWXvAD2XJrI7nGrq10Os8RT6JD8=; b=BKbi65E9/IqFfeQvFr42xjx9VW
	+y9JcarRZ8d25E7CslHFNOD44FEfFyg90gxQNe3INrMpRLihgqJHwQhLjTHZ03Qv
	xhNQDxl19JXA91yZz8y9r1vqiUrjtkmz5bBkuiyTwXwOYWAUOJet3nh0C/jMmxkv
	yNH/U1uRKOvO7vXZqQoedad0tqmnJEEAzo08mHt3A7DeBLn6UCXbkOgoCfY8/bUz
	2vdwVeUsyTeT9j+qSFtO7dih1GIJYMPZRJOi/sZdpKXXsW8qUtXFg6I7Uz8Kx53e
	044gD7+DSuZ4yXffothiEtivBeuWfkdZ1Ivxroerl8wW9tdFZ+cLBVKnWfGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795448045; x=1795534445; bh=7AwPxLVJwGB7FlGlyWXvAD2XJrI7nGrq10O
	s8RT6JD8=; b=zq7bOTWqSWIF6u1GCmCB/G1DGHeTF500CW8XeA9BKA4biHF7nqs
	2y6KPWwHdlBq7KlTVBDpMSN8NgO4pSnb0AMixyZ+7vjqHMW2QKacO5KDznKnTdda
	Xy/578yfA8X/eEnldyVDh8AICtvSUqLunLCKve3rLNR9JsreZo1APTZG8tBza+eb
	9ZAZv/zPGg8pYA4znIFlJLoQFbQDMe1S27+7owoApWKghT6a9P6f77djyo6W+fQ3
	fCse6zlGEt896jTGOA/IccPJGgIlGWC1tTf8v2bskTLGREu+NCc9hHF8Gfu7jWOx
	Ys8HtTvFYtv8UQbk5kPNTqQPOyMRwEvYjVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795448045; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CDp01teUWy/KxAtkS9A+H99F1R6cjpa/s+X+I8HB5+y5r6P
	vIzd5bya2GSIsfz3oJKXSryiBqjZmNiJt9DlvXd1RHoxqyUwYal6e7o75TNUKb8a
	+YFeGEySnTCte/FntpYrlqjl6chuyWFV7hPmQ2pp1g3RITu6fvUFKwYc44NPOoDw
	hPz53X+HXw5q7Rk+eZrVQC5mgufxElTlUcdS+blgWUGCJN/OOcRPd0+tcryqDBK3
	OYMpxqBw9+q3s9fNtC7quOTHAGBdMEHy/fZAqAthbf9Plzu2WuNSa1Rj+aMvVtVm
	3wwLOP44PBO9U3E0wYpXDMlP96pNHcVTjHSF99Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wH+QaTKxvUIAV4EjXzgfXDOoWG1ojxb51lQ2Ke3Oxoc=:3kRhvSUkQlwv/IBA1JvcNwGFXR5ATqhMjUYSY7apgjI=;
X-ME-Sender: <xms:7VwEawL2LQYwGOgbSHR43aAVmxMaCP_Zpxu6P4wD-sWuf6EGXx69NA>
    <xme:7VwEa3BxnI0Y3AwdI9KoOEAOYMJPgvfT3Z1xabnksUdRC0AtbQKuj0oi-55mbDwob
    RVv4UW2QtXO__yZkp--INK2kQKO8XK8IuOJXX1d4sM8No4KQreqadU>
X-ME-Received: <xmr:7VwEa5B_2S95r2xugxKKbvG0wSInSXNz63TAS1FGcKN5axnkPXyHTbMkIOt62asK2g9MNl_Wm6WtM4UkYiet08ShzqTFzkBzGPSM6G8>
X-ME-Proxy-Cause: dmFkZTEw7RxEPRfcYiw3fQKrlKlZF3eD1SanuehaeWIbZQ56jeuXcp/+spwF14qyns6qiw
    3aAx6JaYAbHF2WBFFyknWX0cpIChhM9HpMV/ONKwu0qAYabS3ja9ynFspsdDNAXiOOdwwM
    W0/xs+h3m8Od0yGhuE/3kj5HHW6UX+VAGCqggd9MXdEX3g/X6GWF1acCzt1d6+aubGdj4g
    IU1JkYZPS+sPBAEkUYBG93fQbvDrkkFWnfhD+iFxkbzGTf1zXLcyxKSnqxZSnvYyI7LrcF
    q6/2sYTNJnsd9b1ema6DPjeUbsEZYFGJsoHARt+cGbbMEjp4934EmgwhsB7Jud4IfeQAbq
    JbngfmjPma/N4wf2gx/q5mUw7j6V1d5vVNVMC0i9Po3jkyYxlVVrqVsW4jy0Wx5qq4qqle
    CNXTzuKiKUM9l2dQJyX5EGgcH5UmS8lM8lS8Tlta/42YUfhCZahaF9qKT5R+LXcGVTAJbV
    79KQJT8KE9BbePN0k4hLzvJqdvJKle+Smj2xU8AUx615Wa8vbiLjHoGMtSPEEP7CGI6Rmm
    f4AOKb+UdMSg0T2YwC/tH9784cJNE1n1X3CCYowyCjeMyxzVFaUdSw2EK1yf40jMe/fmon
    7CNraSw37hBdy/631ufbhoXLtgbdrWWU2AWGyHMk2hQNjey6XLq/Sg1hxpOg
X-ME-Proxy: <xmx:7VwEa5Dal8boHGWhURudzzdYuKu23gKRnCdsMHX7wxgwFc5g2bCnvA>
    <xmx:7VwEa0os244dwEz8Cm-Qy7s12V056G5fxtdt6KY_UMqrVO-Unnqhkg>
    <xmx:7VwEazmxUMEb8O2gOzxGHEBV74OimCstRoUxiXyUJ1E04OIdEwJNDQ>
    <xmx:7VwEa0zzWfNBUGEiXvbSv0z8cSs3fQqAU8_7Kvy0-gRDk3JGWPir_A>
    <xmx:7VwEa8bL-ktKkfwTdp-uQAgw7LO4sc5mKnYc-5tz-bVBYbFZGEuBV3df>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:34:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Wasswa Edson <edsonwasswa54@gmail.com>,  git@vger.kernel.org,  Tanga
 Joris <tangajoris@gmail.com>
Subject: Re: [PATCH v2 0/3] credential: parse subcommands with OPT_SUBCOMMAND
In-Reply-To: <20261123014412.35076-1-laveeshb@laveeshbansal.com> (Laveesh
	Bansal's message of "Sun, 22 Nov 2026 17:44:12 -0800")
References: <20261114184752.1417-1-edsonwasswa54@gmail.com>
	<20261123014412.35076-1-laveeshb@laveeshbansal.com>
Date: Mon, 23 Nov 2026 07:34:02 -0800
Message-ID: <xmqq5wxnd0k5.fsf@gitster.g>
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

Laveesh Bansal <laveeshb@laveeshbansal.com> writes:

> Looks good to me, for all three patches. t0300, t0450 and t9902 pass
> for me.

Thanks for taking the time to review and test the series.  It is much
harder to write a positive review than to point out bugs, but
encouraging the authors is always appreciated.

Outside of a trivially obvious fix or a quick nod from a known area
expert (e.g., Dscho or J6t on a Windows-specific patch) or the original
author of the code being touched, it is hard for bystanders to tell from
a one-line "Looks good to me" how deeply the reviewer thought through
the changes.

One trick I sometimes use when giving a positive review is to walk
through the patch aloud, explaining in my own words what the old and new
code do and why the tricky parts are handled correctly.  That way,
others can see that a second pair of eyes really understood and agreed
with the approach (or the author can correct me if I misread something).

Thanks.
