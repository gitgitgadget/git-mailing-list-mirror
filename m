Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782867;
	b=tOxPJ+pjvp4NNEJjT3wYq+GHl9nl/qENlV5jl1UZoIbO+ikDc018+nsuV7jbXFtN/ijt
	 MXj5Ty0je2eXRGKhiEJnGMx4c73ovAGJ/0pSR2GdfOygIi0lQvqpLEauqNePybSxqawKd
	 TcC2A2EVpUbGlfe7+qxm3kMY5MJYXzxWM/S6rETLQ4762ouwO7mUrbX7vN4uoKSpVgkUd
	 7t1WLbOSVeJZg02nID+uM0M6bgdEzXRh9HTJuF5L+c4DmOT1YGBL4WitD91tNSjcC+HXn
	 x8t8jIe5qxXHtwS2bmsF3/vLyAOVHGPxKMJEpNOenjOrTuP5jJ1Gbdl6N1kNVArtS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782867;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LFVgxuv6RypHt5B+IPvqLckcUbJ3mVzUtBtyw1T/3os=;
	b=3if64Ox1wW+25R/mp0571FLdjxcTjSs5i3Ny4WoQmmqX1ta2lNuEVegvocDEIPVj68pR
	 ee+p7Uhl5xl6x+6LzhqQTHGne4+fdCP2iNJIV5Ya6w9Wm6Q0YnVp9N8JiLhHS/JuY4Vuf
	 Df64oSXuIBFyBSwNR7Lyy7gIhQ7VRgzCEJgC7vokf2Ego0O63paY0HhgCBA+S+DnP1+/v
	 U9JJKBevHb2H7y1lTPR1DLxzchLXu4+2yyfgv4vRO+xuRXhTuMFGQAwyIDh4RPe/nQRWY
	 1BPUqgP9a1LtwL8eWT28mN3iMMxomAuGKqiqnGiK7r1q421hdaoPgWFUb8XVqDzQDBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HWNLUMLG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VXux5Ofr;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB77606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 19:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HWNLUMLG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VXux5Ofr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08ED77A00C4
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:14:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 15:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792782865; x=1792869265; bh=LFVgxuv6Ry
	pHt5B+IPvqLckcUbJ3mVzUtBtyw1T/3os=; b=HWNLUMLGhchOf7IHdTYamZxJ6x
	kV0WiVrS2TlpEPwrPT0/BO9sKUQO+R0wsESkCIbNeQ3pJozSLQzl8P6t7LVOCxYw
	s5jU/I+X9GSWVoy9ozrvcg7pe/DpyJ6Ob3jGAd1k27Q7OgauberqHzi3bPi5d3w2
	NKjOG1a0/I2BZOWBswIi0WVLlCcBWO3RSKUGnnTPYDtEwnP9QhenAPSJ4Qngnsob
	3sZQbrtv7kyWCzBLcJPYwtck004FguLx1FfEJbY5TpkH96j0pu+JWiHKS0/PpCzE
	582XGQwQ4G2BGDSdjiwj8hySkpAuEtjYduf67S4obh4ZAItXOs4COdql4GAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792782865; x=1792869265; bh=LFVgxuv6RypHt5B+IPvqLckcUbJ3mVzUtBt
	yw1T/3os=; b=VXux5OfrCaMy1l6T/8gVAJ3p2N/j6s66vuJGLZPX+NXizrG4LJP
	W21QJbqcBOiN9Zt87nbkzdYV/wzyCU1rf+r08CUitO1FtfC3oxbVjzlNpBXCJTuL
	Tb+/PG9TKrAATimzvV3eErM3BM73BoGp9iDPCHYLxBeaQmSerisn3C4JX+zWpRjb
	w/MpX2HUenVBay9iZHWp73wW1APDuyEiDk9Bm2nFtsTkSINqqj97iSRKEblJ4YgB
	f90tptdjy/CprHVe7BQnxlnK4/hFQd2wB0bnkVXPFjDEr7gyw/xmi0N71DaDhW/E
	D7vVgPZafphFwt+w4jOMNevf0yXldL+vKgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792782865; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EZT60KUkbJGU2mISsu81VlGICcEroDL4CwxDKS/biPrnqPY
	Fla/sOnQCliUto/H1/p8HFmacNB3RRnjPl8ioIuYl+ffLcN068X9KGdXWELQwkMP
	kebDYneCsu8iPwIvJFOBQWwV3s2EdE0xvRbU1pvXqwxg0oYWLiVBofl33jYtOvok
	mqKFLnpXNzuCanzPYgoAQahDsBiQUSssl+oBTUJffHDTv5j4z+6qhJ5RvVewconN
	h8rCGrBf3HgLL40U939x8e5yXIPBnAdhNn8M3gHN8NPzzrwRIuO+IZc0CQXshldA
	2A0FB4ssPxR+bXOpBIyMCO0/qkN/8D2YMbZMhcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7200EWe2griGxtdwsEwSBsD5A6t3sxhU938ryKv4ldU=:rFpHIdxqSsPWnOixXLP3ES9+jdlX0pXgshNJcG/8sEo=;
X-ME-Sender: <xms:EbLbaoAvngZo87pvDNklkfISRO593hiPRLhnfdseMrz5_u4m5uGjvQ>
    <xme:EbLbasw91biV13gAJ6knyKsmlUjeXxPslkNsZgV_UHgo6_FDxNk7d1upkfKniTtuq
    x5b1dcPYlHfVHnpTjo7UP-O5NYXuZbnCu0pVkDULIuj-ZXmG7J-dQ>
X-ME-Received: <xmr:EbLbat1zpBMRDaVOFk58rHOumWVVTAjzKVpbIf9D6ClCKyBGuedBqkECx9f9RJoejpbnU-5MjcEj23sCIMoVfm-Ql42lwT-jq4n0>
X-ME-Proxy-Cause: dmFkZTFyjMI9pap88SkAMkfOQeLtZk3OnTJmu6iiNcNg7uiBM9GQ+eNr5ia4Bomkrd6A+p
    qOkNtLH2AVLFwXeJJDPdj41rd/9NRGgTYLPhwCs0FQKJW208it+Ty+9BjmTTPlM0C3eO9V
    hMs46VA8oiOAZHbHfs8p/fE9SKaKl+ic5rGOsOOja+ycwdeCKKTsohEVfGmI2dm00xqeh6
    29GCrFpKhAHJPG6jGkJogKN/WKOqd3o2yKCdwIM+BFnFohXGDvbmGYb0IiYdGxT6XwX8aL
    wfK5c8HExImKvXC6XQtByzmyTpz7RORfNwHiB+sfIfTXxNxLQfY1F2SsS817VF+GQEm4Sd
    etfFeA0S4PIUr/zDxcIFSDAbJqpIrEpK6TScI9VfoC0p9U2kOgiHXvoITFWbEd0rKFXtK/
    W32SPLPD0m+udNumc44Gz+rZB2ucfJ31NPrfDmRG16QwUWetRVD5AcMI2yYtFvIyk4HL8A
    w3VxpWA5exsm0CuQBF1ENIzoDAADt0ROpttpOWMG+C7E+QsXu5jqy11jDvzk7vU/R8wBec
    JqR5ScCRqGraGoyXWq1CSYWLJrI3T4s8JhkldMGAXo2qW6DJkzbK7HLjl8OsauAYJipCBK
    1gzin6Nk1JNWVaL3uTv8iuJaG89zrw6xY2kXBMeZERQKVumH85SEAYJB0SgQ
X-ME-Proxy: <xmx:EbLbakxRiSE1RaK6Yc0M00VgxEbLCbSBkQNZ1TKfnM-6cRZXoml4PQ>
    <xmx:EbLbasG5RsiB_cXa4ne9ZeR2ynz027yk8KT3rhOAA-rUn6u_kZfUxw>
    <xmx:EbLbavbcOb9-i2qnqt6viiPiKATGXKGEj_xYyiPoFq3_ubCCAIKWXg>
    <xmx:EbLbamB0yuIukG328p_DRYSqep2wVCvXLqct4ceAyNZsIKT8SdI2Gw>
    <xmx:EbLbaq1H2_srhtQjYNnYimF-LO1O3-nSlWVAj70Rc0fBYuf4j0aN9wmC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 15:14:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 23 Oct 2026 14:04:48
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
	<486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 12:14:22 -0700
Message-ID: <xmqqtsmc44c1.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Things to potentially improve in future docs revisions:
>
> - The explanation of zdiff3 is unsatisfying. It would be good if we
>   could have a clear example of a case where zdiff3 is helpful and a
>   case where it's harmful, and if we could give a better sense for
>   the reasons why users are actually choosing zdiff3 over diff3
>   (or the reverse) in real life.

Is this a stale comment?  I think you reduced this to just a side
note that says `shoter but ambiguous`, which is probably good
enough.

> +[[diff3]]
> +DIFF3
> +-----
> +
> +By default, Git doesn't include the original code when formatting
> +a merge conflict. To include the original code, you can set the
> +configuration option `merge.conflictstyle` to `diff3`.
> +This extra context can make it much easier to understand what's
> +happening in a merge conflict.
> +
> +Here's an example of what a merge conflict would look like when using
> +`diff3`. There's an extra section (between `|||||||` and `=======`)
> +with the original code.
> +
> +----
> +FRUITS = [
> +    "apple",
> +<<<<<<< HEAD
> +    "cherry",
> +    "mango",
> +||||||| 1c22e48
> +	"banana",
> +	"cherry",

These two should be indented with spaces the same way as all the
other lines in this list.

> +    "mangoooo",
> +=======
> +    "banana",
> +    "mango",
> +>>>>>>> add-fruit
> +    "orange",
> +]
> +----
> +
> +With this view, you can see that both sides fixed a spelling
> +mistake in "mango", and each removed one fruit to the list.

", and each removed one from the list", I think.

> +This makes it more clear how to resolve the merge conflict: since one
> +side removed `banana` and one side removed `cherry`, it would probably
> +make sense to remove both from the list, like this:

The reason why removal becomes the correct resolution is not just
one side removed, but the fact that the other side did not touch
what was removed by one side.  The "indifference by the other" is
what makes one's removal the preferred action by the semantics of
3-way merge.

So, let's rewrite the reason a bit more tightly.

    since one side removed `banana` while the other side did not
    touch, and the same happend to `cherry`, it makes sense to
    remove both from the list ...

or somethig like that.

Other than that, I did not see anything questionable in the 6
patches.
