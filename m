Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE56361DC1
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780634237; cv=none; b=Wsh/CrkR8RcDPQULEHz/9ugx1IijG+Vz8mXdKGjQ03vKhL94JHPB8r91SKVwzWNc3XEOElVlmWpgKaJw9MnyR8Bf6wZ3EzcgVW0ZmI+izfIOwH/UUJbZLAsgOmjS7kQbsU5IfhJeNBobr/LoP0T0vc8Yzxv4TBs8ZjTQmFS2iCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780634237; c=relaxed/simple;
	bh=wp7tQvtXhzmZXlCCCtxvUz3iIc+BHFumm5slSIMx5e0=;
	h=From:To:Cc:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L09bgj86Ug4ZphmxyLK/n+g+1G/cnpZj+F0B6o3I94G8OzKF3UUMEL+188piLQS/1Q58URPpqx4t7RSx8Yh2wr+GHT1i1iQabT/oJgVAClWNI1zJDoFvBtAVMtfMnZm33FLe3EMP+29UJCVS7KdjMtGYldc2epGizpIwLttrvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=fGie7pig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6mpMGRp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="fGie7pig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6mpMGRp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 32FC3EC0099;
	Fri,  5 Jun 2026 00:37:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 00:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780634234; x=
	1780720634; bh=xpe7y37hBuNDRfD57Az0ux+DkSKaEDmPnfFE9LQ2V+A=; b=f
	Gie7pigKypeAaX/IR1bEvr6RZyzq44yLWQ7U+XmiFzipP8vLU7uxoP4uvTBi+4gU
	HCvfF7tzWVdgxWF7AAIE46nPX7Sgr7EeLqfrytMjTrQI0V+v0/v/Qe0YTotVPXM1
	ixXqr6NDfD6daT0KetR9LIE5pWT1s9NhbM7ZO7+B0Unuea3KXKUO9TnIMwyVR4bp
	r/krXDw31r3ohZwpNjTBYejPiz4GtTdSMwTj0hl4IvjhYnqVfrgxSg8cbnsXiRwK
	XQ2Z7I/YOMfeo2ys0LS0PB6Cu4NruBMFVckl84CyQM4qEFpC1+5X6OSniqvt08+a
	h5U7Eaq9Mts4l7UKegCdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:cc:content-type:content-type:date
	:date:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780634234; x=1780720634; bh=xpe7y37hBuNDRfD57Az0ux+DkSKaEDmPnfF
	E9LQ2V+A=; b=U6mpMGRpZIyI6IeaKQrrFyFfcWU9Eu0SJJQrkoZQChBNcjXZVLp
	taTWFsBwPrNLHGO8mvXosmZ4m9e60uNjmkEUCLy/RE/gl9KHTHNobYoDPh5QMM3U
	u8+GLi5e2rGos5Ed0NGZXdoJ4+p+m62fj4ARwXnjUOomi78tTL5HHxwXm1xisJfy
	+cO6wFItJqed56IhkaqE0lrLisAbWq4vXGCV7YaoHEcluJhbXd9piCWDdTAl4CbE
	gDcy0mkfCGpOErLWOvqS5lLIYlBrw/SMEYjmFix3yfS5pPIchhSU5VXJWyB+iu7G
	zScPH3Hw5EbBIeX7LYdiCR0TA8VWBVrvgbQ==
X-ME-Sender: <xms:elIiagrnjQ2pra-Gxoh2RTlHAMBPZLRM0nVGAuzu7RWLk_7ju52ZPQ>
    <xme:elIiasr6ycR7e3V3Eonec-ZSoUTOCknX65hXAGb39P_VGmIaOCZWTClPLcykSgGz0
    g9k1jHdfXQXMPpHrlmOpMU-9LUvnQ65gb8C-WLeIqILwOyx3yek>
X-ME-Received: <xmr:elIiai060tMKTzXsFgVHw8k7MB0jVVBUuykrNGYg9m0nl5f1NMxFykU>
X-ME-Proxy-Cause: dmFkZTGVZfn+tHVa1q7yGoRqknWnVwM7nSv07V5rxel4dRnvF6LaJe0dchmsl+kAv4BHBr
    QtNCP1wtwmF3OZpjHw8pR8FiNgBk637iGq+16kaionvfrLUMppappGNwIwIqF7Ju2BGbPa
    kt8IeywlKK2U4tBxpsBpnQ24RUt2xVCiXz/E7AxraF4RkSojwZaPuA3jg+KFVRL4cDlk3X
    vfMUxzrGItp4w70S7t09+Te8Rl24xS2LH3g/RMUOcNDK4fHM1FOsi7OLmyRWwCQkmP+kH4
    Zz6aFz+LapxghpM2LNqK2Tzk8NdstJqT2VhgL7U+VMberrLYgD5L5DnZnEQEHnk800DFEW
    /D31/rLVGWAlti4fnvcU05L26D2SaLe7W/GwSn/vFNxFrOF76vKMfJL1x0OfwYsdLXww+H
    Z2urz3h8Q1arIq2Z38xJpN2vocm545G150d0iAyKxEKtkz9NIKbOEojzlE6NsejmyFG44+
    0oeHvJiAtaiAaqkJSIz469/s/T0DXAWRqvG9K8oB/WJEclnVl+LJYf7gRY1fWlmZtjUf0D
    lenEUrbFeKhRNz5Bp5bCy0h7qxQYGJIFYHd7iy1e0Aqrf01u0lnOzCpWWj2ahyvsVUuHKp
    phB3Z8sM1As9HPcMW/dbVvo05b44D0Uuat45J2WhBQYqO0hBMxueywkmDbtQ
X-ME-Proxy: <xmx:elIiajB8HeCMwXwkZk9TtcMzOWt7awddXMW7ATX-oJGaiSSY5n6svA>
    <xmx:elIiaid-J_Ca26QSUxvN9H3iIKzM_8Md41Mo3MadOQS6EUYuf8-26A>
    <xmx:elIiagiss3dG7zi0Vfki-pK8xhd5NxXCg82lHf7N99AW4SaGYflM-Q>
    <xmx:elIiaioiBMfR5fOMDXIiY6ZfDWX6UQsh3tR6nFn_A3CK0VYfUM7QVA>
    <xmx:elIiakBCJVltMqW77rSinpik_JbXN0dLb89ocpZ5AcmR6vCm5aWNbvf3>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 00:37:12 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Cc: 
Subject: Re: Mirror repositories for submodules
In-Reply-To: <xmqqcxy7qfgk.fsf@gitster.g>
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
Date: Fri, 05 Jun 2026 07:37:10 +0300
Message-ID: <87se71r4ax.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Benson Muite <benson_muite@emailplus.org> writes:
>
>> Would a contribution to add mirror repositories as alternate submodule
>> sources be considered for inclusion?  Some projects have mirror
>> repositories on other hosting services, and may have bandwidth limits on
>> their primary hosting service.  Being able to indicate mirror
>> repositories for where to check for updates and sources for submodules
>> when doing `git clone --recurse-submodules https://my.repo ` or `git
>> submodule update --init --recursive` would be helpful when there is a
>> timeout.
>
> I do not see why such a "oh, the repository at $URL1 seems to be
> down, but we know $URL2 serves the equivalent information, so let's
> go there instead" feature has to be limited to submodule use case.
>
> So, no, I do not think a contribution to add mirror repositories as
> alternate submodule sources should be considered for inclusion, as
> it artificially limits usefulness of the feature.  A feature to add
> mirror repositories as alternate sources might be worth considering,
> though.

Thanks for the feedback. This was motivated by problems when trying to
recursively clone, but a more general solution is also fine.
