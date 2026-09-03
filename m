Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5E28C5B1
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421953; cv=none; b=LaE62uR5U1OG7lz0aA3gj6LGPsq9dpJGLsB/ZtYjbGFO7OmYBBnMOIVhO9bwXITCDiXxaC1xsOoLAsuf6mSaxz8Ua5VoquJ6ox/kbssLuF6Bsl6fzuk1c9jmbIJE/3FlczeUZyrOngZ9iNHTkoRIbbYMMuCZIZgK0TQ9AUjfKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421953; c=relaxed/simple;
	bh=uglI3CqfLmRLdb4Y5KiA9dNvlnW/kka8otaDMbRXvJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRcCujXxBtoA2Vq1+qDWeIfgiDOaiaPrwzpfrHQ7HwC6Wgp8OlquH0yhK4iHvkBRaPNQeJXgOdAG0kbY0+dud2q1fLtKjXcy/CWZB5og1FLHvAU/Leh0Kir36w6IV4B0enb1fnodjVkRun+7dROoMlRUlkMZ2/31+3MGRPcElMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r0VAZ5YQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGMgixYF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r0VAZ5YQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGMgixYF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D98E41D000B9;
	Thu,  3 Sep 2026 03:52:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788421950; x=1788508350; bh=pwpcCag0Gw
	tTwGdISktuuAg/bJY2VYVyl5jT+8nk6Qg=; b=r0VAZ5YQ5WJaKHtLwO/z/5zQDk
	e86tSbI4EnKDhG7Lf4IUx0lxM7qbJ/ip2N3Q2VADN6qJZnJJAiRVSmlsWEjgHb1l
	NxA1MwS6wGPhDrF9spga1Qxjeh4jG2DNQuaHOrYJOdAMk89LCRglGG9N2viWc+tJ
	0YujyTW88JP+6ro2G2KeTnq7y6FMj/m67VEbPdUzUJvr4DwZlfrFB6UTRePluj4O
	vq+yZyWgF64SJw5wTwJqrtxjzufIL3Vhu/t742ygW2qaC20RGY14mEKLb7qPVj3j
	1Wqva8RF8Zsy8xwtG/X3Ri4qHPZ1mqpah7CMEtx4hcfOetNVfvDESddGfGWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788421950; x=1788508350; bh=pwpcCag0GwtTwGdISktuuAg/bJY2VYVyl5j
	T+8nk6Qg=; b=pGMgixYFoTJxAaxTPRsOjn8E3x2fVlieM37kNUpiiySqaTpQOxY
	q+/IaJdnRcgZw05hUYf+j1D/2BNgIlyl/510hPLJBaw0fWgqQA0ZMJ6FzeCbVd/J
	8wyXCdAfnB62wif8BXahG1HfXNryR6JwhKyM/GLTFnsy6QT3aAG6WcetWwHvGHDS
	PKle1gagF5ydN769W+Qzvnqa1yPFwfE7URcXKkobx4oxqfivANB5EpyHzVdm5QGC
	7xvtrGh/pfNhUbEoH09/X9DtlUYRpfcTrNbuOQA6YXUnq2/3gcbWuL65rsvyxQxe
	U0AYwmkP1g8Md6OiATH4DoEGMe8t5PaTBOQ==
X-ME-Sender: <xms:PSeZam4MWYC3_xxcw2Rnc7vTSwGfI3kLFM6gNv8JNyrkYJ2BNqz9IQ>
    <xme:PSeZarVsE88qwPevctnHlvtWrEcYduwXjmjSGW9YIxjNO5OrI3wlCswp1w_sz8gxM
    Tz5p4oiwxsI7ldtaLJ-bOhu5M1gMRpxDGpGm7hZO793yGZb14EWKQ>
X-ME-Received: <xmr:PSeZao_6tlPXCqwR6OP0Vos4ZQEy_qAxV8iwaXmEgSyhPMtCkfh4Xw>
X-ME-Proxy-Cause: dmFkZTGkNbEDaByze6oomEVv+23bnOntoTBTBYzzgT2B0hFOeca9eOskvYykxAhh77+o68
    vVaPCvKFq652qIOIQQxRqA+VXPaehH0ipRhME4lOusKsTIrDsyCEZI4v0k3vo4T3hHD12X
    jIElwNU2r7LeCSVZxvjTqcPel0Dn5EkcZYxPV6rAD7KnehnISDzNASe7G6yyFb/S6hM7hF
    ZaF9GM1fU84pOAzj3rkAZfN6TtRMJUy+v4o4IQgb38eBuYV7qfUxnLSCY2HQ4rwiewB+3n
    uPLnT9IkYBky02pLIzAO99XiOJpAwpPpskzk2gUN673POSnUG9yVRFCIQMg+7gcLIoYRo1
    Y1jYpvo9oKrHscqI00HgcTJD1NE5gLXcWE81u0qhuJXp7J+fgK8YE4LxoVFGX0J30ePetC
    qlNdh2MLfiyv/hSJnou65PlF+ZDLwkcE9mb1ueE5bSZRE+Pt5vWJdgFvTyR5W9q1UrsDqN
    K7YAg734Tx/B6z5vGZYv33fJZkM7T6+wVR9wme9yMlwifuqaRi2G30jCtZqghcx5r+Mpaj
    YKLTAcEhDpqmMFZ/X/wDEmJpn3K4ikjVNZemjf+0ld9adV78wMg1mjMjWbJgVPgPcD+vzE
    DOZnwMvaXw6nKbrH/v0abp+VyoolkGb6MlH30gdleUSSBsdC5BuDwfDCyfJw
X-ME-Proxy: <xmx:PSeZankPBiPJVo46TJrTCI4RvHSrkUfIWVq62Rqt1tJ600XTqa0S8g>
    <xmx:PSeZamXfGTA9EWvVG7P2XifRRIbuW8xk02KG-qWbklvaLNy0Mgu3zw>
    <xmx:PSeZakEGdsYWZL7ElHoN8X6kzSipVI7Lm5fGEFWWpNMGWSevQ7XTbg>
    <xmx:PSeZaqfM4OCC70y9oUHFOMqQye-cV28DUVsikG8Z_gRdD8OztLM5jw>
    <xmx:PieZakHEDvRX0BipUvBim12oOP0XrkiCFMIeY_HZBTRBZWv0KlpHScWa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 03:52:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51c8a2ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 07:52:31 +0000 (UTC)
Date: Thu, 3 Sep 2026 09:52:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2] history: do not dereference NULL when parent tree is
 missing
Message-ID: <apknMr9Jk-CzdLAR@pks.im>
References: <5438d465.ab31e.1a062047bd5.Coremail.zkd18cjb@mail.ustc.edu.cn>
 <20260903063657.2067303-1-zkd18cjb@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903063657.2067303-1-zkd18cjb@mail.ustc.edu.cn>

On Thu, Sep 03, 2026 at 02:36:57PM +0800, Jinbao Chen wrote:
> write_ondisk_index() dereferences the return value of
> repo_parse_tree_indirect() unconditionally.  If the parent commit's
> tree object is missing from the object store (corrupt repository,
> object removed by tooling, or incomplete restore), the function
> returns NULL and "git history split" crashes with a SIGSEGV.
> 
> Guard the parse result and error out gracefully, following the
> codebase convention for objects that cannot be loaded.
> 
> Signed-off-by: Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>
> ---
> Thanks for the review!
> 
> Changes since v1 (no functional changes):
> - Dropped the parenthetical note about the UBSan diagnostic from the
>   commit message, as suggested.
> - Sent with the From address matching the Signed-off-by.

Thanks, this version looks good to me!

Patrick
