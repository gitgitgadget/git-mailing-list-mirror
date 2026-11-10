Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334250;
	b=3ZBWNMjUp9sIBpTZlZytqezL4yf5hMz/5mI9e1XYi8McD8XvGbOx1LNy9V3PVELY97HU
	 BqmZaxo3kFH+DX+b8zVfvCPBVzNcfSjjpHaVGzAajd3XkcNcU7gmCiypGhVjyfBat/ml8
	 0ZRSiqQkddGG6MZldEVbQ0mc2TdA8sczYBtAsaYfGw5A/TI3kHFSomAh+x80Cll1i/MmU
	 55meMse2reWiNpHlrZiF94HEiYOZW34d63FxEpyNmsoAhz+/DL8TEoaOaTsOcnq86YOAR
	 jKWpMhD9e57cvKRjaU62gk3kWUxS0QoV7/mF+g3kVg1OujXeADfCzcrj45qzh3lozyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334250;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3Z66QuCgx/FNjcgBL4UN3F0hRV85UyGphvWhvQmwNK4=;
	b=n84roDUHZYD8E6Qx6PQ5zYu9vKGO7JV5hcuQNM9RUhLd8DWpFw09fhz4u2KagC+bgUCT
	 bh/5Eswzfn1qH2A+3wbzK+e0OBf3QqNXjqrqJGf/5P/p1RNA52FwlWGdXT81d3i/XhX7X
	 bfr9V5anP5jgvALUX7AF00EIpzzDaTCBq4r5SPB+5GBQW+DhoKJOaB1ONVrLakgpbZERK
	 WHST962f/PRUArzOCnaZwkEL2hqUcaaXWkKQMWQtaJl0stiXty9lww/hu9JCKUkePEqZk
	 rQafO0ovpAUAKXZMcL/vnmrxT5qKyleohD1xIuIit7AH3IjZDWyb8iVkmU0pohrYNow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nx5vkn09;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lNISJffk;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A4606A33B
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F8A4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Nx5vkn09;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lNISJffk
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 87EA11D002A1
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:10:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 13:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794334249; x=1794420649; bh=3Z66QuCgx/
	FNjcgBL4UN3F0hRV85UyGphvWhvQmwNK4=; b=Nx5vkn09/OcoYIha6bZfV0ObR7
	I2gCViDuWq5NHSAnWNFbv8+Zk60mvQh9c35pmY8nkhgqCEHkDyO8tx9gmck7tQWh
	autySsbQcjFR30KNuf/PIPG9uM0dapessBEXyN+1sSXjN5nDgXTV3KnxwxOoX6N0
	CFDuLQF687RVqd1SX5GuLDcALglrhqkDvL4QPjcW0VLuNPUbtFxnbU6f+x0YEzpu
	ArIqN+pvMGVMo8HBnEgBoqvR6M7hGz4M4BDJ6b8lBdRBmQAMhdGjCtEPmvfQ4m7T
	EjgpiOsQcXiK1l9Jn6HpQWkd/LeBhiPwcLlHAV86MJs8DMX3DyF3Eqkwp4Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794334249; x=1794420649; bh=3Z66QuCgx/FNjcgBL4UN3F0hRV85UyGphvW
	hvQmwNK4=; b=lNISJffkCQ6AseRgm2KujnuXom0qRlIy/XQkbSvpUx69prwrR0g
	uAK72L+H5XRcOCvTsxoK5jKTQ4yiED61u8s63EGsshlGVMCJLcRM2YzCX6U/iaDK
	WVHkPKRf2LMdEv8dQNzf7KFzZWoNwQcGoJg5GBVhfWNdyyzsmRS85w+hdvIfQVEY
	TYUc8z/V66GItm5rS3ktpRb8rYiY+MJnzGDh837rvEFSqHeliy7ZyN8NZspJkGJt
	tNs+BfTMF+mit89rRvpgE5ABGRQSB1C7z9J+QQeUVqh6ymjILPNihTiAOBoDzZjw
	RCu1FBkYTj80pX0J7kKPYhZUtNsQ1wwPYug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794334249; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CzyWt8WN9vR+vCIZ/S140XIKplA6TII2VDC395QTIy43e+Z
	DHkK1mO4+dkUVXBcyjIpilkHfBNe3XoRnwh2gU168xZYaP78tpgb3pOahRLuu2wQ
	gPUTV2iWLDxzS4WtgK00KsmPGo8attc86968U+8T7wCGd6m2R1DHp9/eS1asRxI/
	qE/s2rGE1wT2NPjow1P5HdA3RLPOQIB71YIzg6JUVhGi+mU7EaJt4pN3TFEwkkkt
	Ghec16xS0OxjdDBIXh19o5peOb0z9sLmA2DR8YlyyzHhI2fX8rt4wdxBBiEmB1O/
	2CLh8BHob4o18sXaRdEJ7CHdCvKFJfsiWavIL3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:EcMBAGTO7H8jjKXzYUWghpuNzcyW0qVBpnczDB/Im4g=:tIvzWvhTqNEz1rtXecqadbwI1wk1oUOpFjpOFME0nFc=;
X-ME-Sender: <xms:KF7zal2dRPYdH5f1TRpiA4C3jPp2zpJAZL44zyHcKKbv6MmAPdnfGQ>
    <xme:KF7zasz8A8c1D_BXNsaSZb5MmMA1vaBhMWck1gmYErywM3B87ZHKOJOZRxFY2WI5C
    YyXa1zf4p7iZsn5iMuBZdFfMNe_06PhK0aYTENmUbGyGdHEjt1Kqnw>
X-ME-Received: <xmr:KF7zakG_lo3j5B5fyZBabvqU-cgTL5-_Fd5qBHQAKo4S_EUkVHrgfl8JsHHUi7VsvBJ_2cu6AhgJ75Hkis2PvMYaoVX2gfxGlh1l>
X-ME-Proxy-Cause: dmFkZTF0zMYiL93iMmEzz6D2/KBO4B8vsr3/exlbwHIjgr6i7P00NNW1xk82BKkS4O2ZJs
    rVg+jY5n5dVYHPskl2gASpavLzfQWOvl8OA/OiviA/MEItBwTVW9HmePT+CUyVGVmAe4+G
    seyKOsuN+PzivYZKlHMYAf8Y1Ciza1GnEM9wcKWW5azieWhWlIgrJOm4fxGCs4HpmrFOV9
    G4BM0HLofdWzrx6m8y0sRbwvXz6RkPnaUXLXk6UrSQ1e3L4MB1HXaPHtZvnE3uJieX488O
    Ku33fiTIqjv9mUQ/6uZvmdjrA4+inWi4WrAWUVTJEIyddMHDWgyvUKS9xalrvMuFmjQzn+
    UnGB8HsPMkshcVj8taoAbuF13iQUsZWUsStEhaBHVbvADoGl5fru0YLBOm/vHgOxjKJJe6
    Da/hCVUYnIuURrTok2DNzQHFIEr2ALeF+Lx+6IQEBUNumYF27Nt9AXXFU8sRMUDcSLD1QM
    ebWj8874WRzKC8GbVTrkNoRuEXaLBpVYaIqiWrszHRoqAwvB6CgjIVh8S8aodwry9VDTQy
    B4yOHogZx6TsBJ7LMjCro10qoT85uZYtAM2z0t88ZKz5BlyB1YGaS93x3qSmA/g4znxgKb
    M3hDLALtZRPCsOuKPaunFaQ6v/KDdHsH4vRsH3WvTQHs6I/ocBmjzb/EnAFg
X-ME-Proxy: <xmx:KF7zanY0Pbl2RNWVElmgbSsWigTB2b6jOhIsNj2zwyEn_BoaDyLadQ>
    <xmx:KF7zauC10wBeZ2UiYHceA4QKXtS-DNTilxv2xGdhK9-xx5B12dLiTQ>
    <xmx:KF7zanmrdAhcrE5HedDJvY0a2cEErPh-v3TYKH7_8eDiXz2QhTIaqw>
    <xmx:KF7zanx21AA2Yq9arhJMLOb-grgbrnHbdq0pyvJuXAu80rowHv8WTA>
    <xmx:KV7zampWE0OHA91xDhvPxQfJXEXnCl9LD_lXhz6ZIu4MFGaUg0N4x2Q9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 13:10:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: taahol@utu.fi,  git@vger.kernel.org,  julia@jvns.ca,  me@linux.beauty,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6] doc: git-rebase: update incompatible options
In-Reply-To: <20261101082230.141688-1-omri.sarig13@gmail.com> (Omri Sarig's
	message of "Sun, 1 Nov 2026 09:22:30 +0100")
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
	<20261101082230.141688-1-omri.sarig13@gmail.com>
Date: Tue, 10 Nov 2026 10:10:46 -0800
Message-ID: <xmqqa4ngsgk9.fsf@gitster.g>
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

Omri Sarig <omri.sarig13@gmail.com> writes:

> Changes in V6:
> - Update the commit message per the review comments, making it clearer.
>
>  Documentation/git-rebase.adoc | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index f6c22d1598..f1f675d311 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -217,6 +217,8 @@ OPTIONS
>  As a special case, you may use "A\...B" as a shortcut for the
>  merge base of A and B if there is exactly one merge base. You can
>  leave out at most one of A and B, in which case it defaults to HEAD.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>  
>  See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
>  
> @@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
>  	and this option would override that behavior, allowing commits
>  	with empty messages to be rebased.  Now commits with an empty
>  	message do not cause rebasing to halt.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  -m::
>  --merge::
> @@ -487,15 +487,11 @@ applying (in terms of the author date).
>  	Instead of using the author date of the original commit, use
>  	the current time as the	author date of the rebased commit.  This
>  	option implies `--force-rebase`.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  --signoff::
>  	Add a `Signed-off-by` trailer to all the rebased commits. Note
>  	that if `--interactive` is given then only commits marked to be
>  	picked, edited or reworded will have the trailer added.
> -+
> -See also INCOMPATIBLE OPTIONS below.
>  
>  --trailer=<trailer>::
>  	Append the given trailer to every rebased commit message, processed

Looking good.  Let's mark it as ready for 'next'.

