Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163548;
	b=wAU3CQ5Tt1ZZcfrGgA2uICaaAvm0lekSDldEXCxsw5eo2riO/rXUjl62qWYXU8P46Dm5
	 KF8IKaJd2j6+gch1RKmgB5J2mQj4C6c5Ml9NglS7UqsC/Dg1wwuVlcVMe4r0a4RTKd3Ox
	 WNjyBYSNY5vSG947UZkX95szsozQBKlnSsZYVZKbHWPJ2mJlY1kGrc68XIiu1oyvzpswk
	 NdLTRn3eOoNyCNjDU9lp4T5+13PanRJYZ90YqzBUacdz8Jlz6alK6QtUft/t/1slxPKh9
	 o1bc+v5elRcqWxom2Rlrnbnw1JcgbfQsH+TfFAuZZtUi/sz7uDR3oEzmy+NhTselx5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=U6f3FwsU9mcpquM5RtbDa24cT+E3BfPU42CJpgBdJg4=;
	b=KXHHSFHTfZhZMJEPOkjQB97AL0toGwGKK/0YwF4Ekt4UpDsgbRd/oiGKws0s3SwSyT7z
	 xHkWRW1bPDf5pGRWqTn5eRUkeJH3cVAjdC2+tnQDqZHgIcz/g++1KtdPaMcaOingR/V3c
	 YJlNrgemCerVKx3BNaHq4jbg1TVu3kfbs3x1GqiC4tBSqAmajoRUQbYG0LH79VhzcOKlO
	 6cg/nTrE9R6jl0yJecStolcqW5K6mxYZxlFh3JJ9YWNu67uoSPiugWg0CKuGzPicZXK5m
	 u3z7TrP9USaH5QrD1Ah9vc+56NGZJgmP4nkKc3dDU1156rxmBiGhRK/NCTIi31U27Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="geZK/V/G";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="KClSsAo/";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E38606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 18:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=geZK/V/G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KClSsAo/
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CBCD14000BA
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 13:45:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 08 Nov 2026 13:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794163547; x=1794249947; bh=U6f3FwsU9m
	cpquM5RtbDa24cT+E3BfPU42CJpgBdJg4=; b=geZK/V/GsGWEuKUO8ME9Oi7+Ry
	Kb+0JZejNXUwLNkZaRAb0cO8Vo9mFVRUQK/g1+a/LTSv/hCNccepzlnDhiJqnQKB
	Zv6luuJD6oJGUdfw5hFKJNVV917/8Dc9ZGe249U8jl82O0HhkKkGO2yr47CrHPov
	yhk+3ksafmWSdGYIDzRHNH8tMk5j/Z7b+3g3+uW0NCEAiLQCXwiipbFiLt2s73e/
	IKBOfDtTQeGalI5Vze0AVasOKAp2BhB4lm60hVM+ED/kf7FBTa8YEHRcK5iVnN7p
	zMhz3BQaZA96ZAz0w3tldUUvPb57vLxMhfCHChYXVfTHHWelWR8QyYA+lf8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794163547; x=1794249947; bh=U6f3FwsU9mcpquM5RtbDa24cT+E3BfPU42C
	JpgBdJg4=; b=KClSsAo/2bNhsLgP/Gw5PolVpGY+S7QSCbA63W8X2BC0dZDXpon
	K4+w2XPCSswaWG/DIBEgqIwJhJu/92NJEstWbv+WnBJ7T0SkfAX2KnKuNXtWVZKG
	Tmp33ZFeM+kLYy42SWOHSxGHb0tSVJkeSm0Jmo1JrYC8B+bIcAv+NR8GI72SoXND
	p4cDbfdmkHRjxEeniGH9Qn7UeKbjbDJWq03thIrrrinwUNSk9x5vZEVjkuaAoHXx
	zinszM+1MQUJSyxMuUKsvkfOSIhULwwp4KYQbaxRlZjkgaplPMw9hUwMLyyhnd+D
	6KNJxht4YyX1NY1P8woNJcTYfa7Ig8vLyfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794163547; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PRNHB4RxoWBHnzkhP0prIK8vXfVWr4VUSgRnBgLo/UQQkfH
	Yqj83l6o46fVY+qGvtzHth62/vhFiRloXW0pKdub0+nE/kArlXTSu2Sh7KmEBjyE
	NSC/xdYxhrJodarQKEYz3Kvv1eBuB9h2hGfDh1pHIM6SBtiASTD1LkcKK9A4uFPo
	1VUPVCIcchFCFuJ5orlirvm9XYINYh0aNTWRbCoABx1Ao8Y34xPArW+MmnVXaxsZ
	TnbNmP7c7CLVcjaKtmSpxG9o5U0lZaaeAzq9sfwBoF115qbWirf7L8g9iIaUQbSd
	9+FFGjt1oNIlEQC7EQjfnt0S27hXuVcRYAZB01A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YC45XVHpJIDgYFArW373ExJ/ftB8mWqi5tAtleNIX0U=:YFUJWb56l9hSImy0ZTJyGvtnRomuBwcCo207iN6dSjc=;
X-ME-Sender: <xms:W8PwatFqR5Ft2VKbYb4a_ag8WnAwcT3pheV3-xRkOoNFmhtSTAiepg>
    <xme:W8Pwas5O9ili_13dz_067tgGdNSp9pu4L9lgIOuUToAR3JHP-qGPywzQJXAslWce4
    j8oXZI8eJeWC4jj9YhBZfhlMUqlQbeDFZHnulJ6R6U2kbd3qvIgCVQ>
X-ME-Received: <xmr:W8PwaruvtEvkQ7ckouePvp5CAGKei6gHjbUVtcG9DQb34e4BFacvMvuwL7rKeXsr-7Q_Sx7XShLcWhWaSnNB1RuLT_ffIcrwZ97q>
X-ME-Proxy-Cause: dmFkZTFDx9+PKY5xIalXXR5QQyUzD4jCPYSsbPj/Z1KzpCWnEZqmzEFXdecmM4tdtdqE1Y
    dLbByTWLGEwihLJE8G40J1gCnOXxkcQQZoSkfntX8cNo+15TAhFlzkA6cNQSAt19uRuLDE
    Q1ZceXo6ZhG0UBc+9KvvtTsl0H2lYHE1m/DH7Qg8BGNHkcqjTqmgCJoI8y0hOoaJYlbNGN
    /RrLVNTn90HPPeBI/CMlDQ8XK8ugVv+uWEIvOExdVZf/Px/uHhttHyVZmB37mPDnlUYPs1
    yATdMJ9yRvGy3EpBWg2kZ/KQsVB/DW8RrWwMmwBNKq/9sjzRm1TAQVWzDmCXlY7tIQJIV0
    jQQfEh4hO1liu/lTPvllyDitV0VWl+plN18feP4G/KSQRgmo2dF+J0IeFPP3TaWfZnD5Ot
    YmLtfPXxvQgc6vmQ9IEK6GHXp4Pgyzj+NRBIUdcvrBddYVo0D98RLyTH+Dlq8NSrAGF0sO
    OtmCuDa6+gQgA26BxY2HsDpjSyRjGUhYgw3jFWk+4/YNA1plvwe+6KssJALixDr71GQhZU
    Q/YEh24Cxhz0YqY8UPoRBME+ZWpGj8HJZoaL9X1U4yAeEaKyoB9gyHr3ONzlVcoT0ABpdw
    y3bb6jXp41WgXomakoWnIdjPo9VteTUmrtU+UuRxUPXbp1bF+bJg+ULSrYlw
X-ME-Proxy: <xmx:W8Pwal4KdmknYs6Rh3O7On82X6LaxYRa4ZEdbjgRTJ0an5pIAAVFFA>
    <xmx:W8PwauUr0VX527CY8ry2NcZBUbpIcW2b0L83HoWr-PfaYs7H1U-jlg>
    <xmx:W8Pwav-BhgyebgSfMpTg0OSDBOwJZsjbxMY48L1oBTwEfWgigRujSg>
    <xmx:W8PwailaUUI8UufgpwkORCyYxFtLOe5nwl9vx5dGVnw2pqyPtfEE7g>
    <xmx:W8PwakW1O5LPHdUVD_x6FTX__beVBRqBsHeXB35hlsXrCgkMfbz81UQ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 13:45:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
In-Reply-To: <20261108071933.6586-1-husainsitamuwala21@gmail.com> (Hussain
	Sitamouwala's message of "Sun, 8 Nov 2026 07:19:33 +0000")
References: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
Date: Sun, 08 Nov 2026 10:45:46 -0800
Message-ID: <xmqqy0b32mcl.fsf@gitster.g>
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

Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:

> Explain that promisor remotes accepted from a server are tried
> before other promisor remotes, and that the remaining objects are
> requested from the next remote when a fetch fails. The ordering
> was introduced by 8808e61fd3 (promisor-remote: try accepted
> remotes before others in get_direct(), 2026-04-07).
>
> Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
> ---
> Changes since v1:
> - shortened the subject and wrapped the commit message
> - clarified what "accepted" means and the fetch fallback wording
> - checked the wording against try_promisor_remotes()

Please thread your patches correctly.

This message, which sends the v2 iteration of the patch, should be a
reply to your v1.  However, there is no In-Reply-To (or References)
header linking this message to the message that contained the v1
iteration.  This hurts automation.

Also, it is not considered good manners to send a new iteration
before first finishing the discussion on the reviews you received on
your previous iteration.  You respond to reviews, saying "I will fix
this point", "I think this one is fine as-is because...", and so
forth, wait for responses to your response, and eventually come to
an agreement with those in the discussion.  Only after finishing all
of that do you prepare and send a new iteration.

Thanks.

>  Documentation/technical/partial-clone.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
> index 18718a3840..efe9acac65 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -195,7 +195,10 @@ cache servers for fetching missing blobs while continuing to do
>  filtered `git-fetch` commands from the central server.
>  
>  When fetching objects, promisor remotes are tried one after the other
> -until all the objects have been fetched.
> +until all the objects have been fetched. Promisor remotes that the
> +client accepted from a server's advertisement are tried before the
> +other promisor remotes. If a fetch from a remote fails, the objects
> +that are still missing are requested from the next remote.
>  
>  Remotes that are considered "promisor" remotes are those specified by
>  the following configuration variables:
