Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DE312815
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098714; cv=none; b=AQxTryPzPmeJC+Pr3Sld6OjZoBdZI1hxJTbpwpK4PR18zv6df8Evn2zcarrHM/wIIgtZN+lOFdWm+Idi97AMXjGgGRCDa+sggN/FepRP9/c/L8saXUsnyT/4VSV6zvcVJjZuIOk4sfbi0YiiC00c7Ih5iqYkVCMswwEVhxkkv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098714; c=relaxed/simple;
	bh=Lahtq4RGcYGG7HynRUHZDN5LQMK2NhnbaL5xZW87nIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9uf/u3gNd1OS9lZswv3XS9KcZkfyK2sECFqnMc0OXBSghIn9zxvR1Vfc/JsY6tohaDbi1VC1PyLkRiWk03HiUl3cQ6Kvtp7O2hl5oH/7HDebg/saSXr/PHkBZMwnKuwliw0qKV+jPBs2EdaAXjR4MNwh3SNOOQcII5QYhRSu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bx4dIHNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ln9T2UAJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bx4dIHNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ln9T2UAJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 924007A0136;
	Wed, 15 Jul 2026 02:58:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 02:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098712; x=1784185112; bh=HFmpHBoki9
	yyiq1h5jpND4T7kVav1XXI++w+7c4Xd/M=; b=bx4dIHNu8XWti2e1W1qQskeuJV
	VyXwNSCcoXSTrUXEBSLIKfqsMbzNUImJEUVV26K2I9bwuDPotjhfiwlJWbAiSkAF
	JPVSD0APlbdoNX+g+7WyFJyAvMNHGFOnE2z1+j+bloBN/FGIX/EUsjdMXS802api
	c5UqtDfTn0n9sOWwwWveatP9hX0pEKRp6i6E15i05P8ghZ29Sf9kRPeEUjB+Tw/I
	PSpWZPQo24+V895i4QohIuvUS0nPdrgl2ZsnEKxnvfC6mog4HmYLbs9ng2uQSBL7
	wEN3wM3N2zAcpST7Sz0zWGAfuj2dYFAwSvkH3vP5nRWnIwtIEUs0U7ZZ6ZQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098712; x=1784185112; bh=HFmpHBoki9yyiq1h5jpND4T7kVav1XXI++w
	+7c4Xd/M=; b=Ln9T2UAJH3wympz52zXPI8lRRG5di4Gbz/lhQ8kVTKj9RNmE3+5
	NBzYZ6Rc2DsTa9hl4zy0BLu6lp2gqxGJXsqmU9B6pTlwWc7AT+9zsG6Cx+64H0L/
	mQi+tSvOnNvcq6q6zWI+iYI1STYO3LGXYqK4jdBzDrHlQ0ZtmdM9/TMQ3zUlKHLQ
	9cRTid98bBmI+i/tgQxabAINiX4txgxfGRpedh1I5ebBl6zRQec5H4MPQGtDODJA
	SrbwxtiYxCEdFBJ1noHsoppq5MJL3lVZbNRFA+X1iA0X7siXwUhGayinkW/kg8Cb
	kRCl7mb1v79GPl+ut+YkCOUgT23XKWM8+Nw==
X-ME-Sender: <xms:mC9XanLWziYf7mOaY1kF6GayKKY5SmqMrYapcAaWJF7GIdFvQnISaQ>
    <xme:mC9XaimypZnxi-ql37vZy2-kcPf-SCpIuQ2n0jOX1BliMK54UR9bHTN_B4hSU2JZL
    K2ycS0H06MTtrOGMFi4tm3MuVYc5_uqA9TkHCmb0kpLj6ZggmhOGg>
X-ME-Received: <xmr:mC9XatG550nJMxMD8Goxup30yXkZHLKBCRJuaHx6rrQJUrucKKzzWKFeBJI8NLQbawl644VgeWyYOVsBMTA8jsjQGy0hF-99hmf7sYprFb4>
X-ME-Proxy-Cause: dmFkZTG1WWLcByQmmxMSO/Is/1htfmCFwhWIbKc8tIyFwIy51tFCJGhWeULuMmLOXCSBLQ
    MFx1NYf4CviGlxGqPgq43w2i6MMCPtAwKkpA08/2Yta0HdXwCFPrSj0n6YWWjj4yYRMvdj
    m0qyDTj6SufVs3QizVkbE3H4edg3c3M2MnQPEQDOyz5AjnzUcvuGvK++Z5CbADHe0XZePf
    Q6jFCZT8ntJHMp4+oFMZl5p845ZNgpHlDOSm3eoZSpB2FtBvTnTwkfeVjeecBnDY75Aqfh
    XZnCuuGXJnvxOWBdYCMGi+rojKUK1izkSXYOhntYw2Z1/dz+wA/Hwfa0SczX5RCrgIR7SW
    NCuT8xZ5PTGSAxOIFJ22Q7lshVLzqX3stpsbbY674zJzLCAsCcc63Bn7ThIAdOpcqgYSWG
    JcE8hulPd+8UmVmNsqbheto3fj1yryLovOTGmN/vqnveFjw+ZD/+4A5NH3HWWX6Mx9kSRd
    BW09aaNO+6o1hqGNanVExO0HHvoTvX9Zlwi6XKVHpcuLMKC/0mRCuuwvfSYkZQ+oReCfUk
    kxsPPYBN1R2RfTdAW7gcdX+T07Hhve2qSVQkqhQqt2yYuR5IlT9tTZXYEjy/A2lvez1dCT
    vZ4re/KGX/lIqM2NAw5g5Azi08a8S1q2YxEeV068oWuFOPaU0n4+WnXlSymQ
X-ME-Proxy: <xmx:mC9XaqFnEhynu147uZbZSsmDEryw8Lwq-RO78RbrFaZbq0v_dSeA1A>
    <xmx:mC9XaiNBvg1XnIVAMkIQO33dyKUBPmB_pb0RSVOY3wYC1E8DZ12f5A>
    <xmx:mC9XahGvXDn5j8813jpqUiKVqE_xp_jV3RssYrX1NRv_GBRg9lzqBw>
    <xmx:mC9XahPaPkF56Jkd9nlEItwK_G4t3if-dd5sZ4tlqL7XfF_OZ2G7vQ>
    <xmx:mC9XahN-nX2IV62frHgBb26lx-58tgkEto09eppzXM84G1E-QO_WTw-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:58:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15f13016 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:58:31 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:58:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/11] transport-helper: check dup() return in
 get_exporter
Message-ID: <alcvlJABsStbRtw8@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <1792042098cd50ba164b90e5ce62430037661343.1784069325.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1792042098cd50ba164b90e5ce62430037661343.1784069325.git.gitgitgadget@gmail.com>

On Tue, Jul 14, 2026 at 10:48:40PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/transport-helper.c b/transport-helper.c
> index 80f90eb7ba..31883b244e 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -487,6 +487,8 @@ static int get_exporter(struct transport *transport,
>  	/* we need to duplicate helper->in because we want to use it after
>  	 * fastexport is done with it. */
>  	fastexport->out = dup(helper->in);
> +	if (fastexport->out < 0)
> +		return error_errno(_("could not dup helper output fd"));
>  	strvec_push(&fastexport->args, "fast-export");
>  	strvec_push(&fastexport->args, "--use-done-feature");
>  	strvec_push(&fastexport->args, data->signed_tags ?

Makes sense. The only caller already knows to die in case it sees a
non-zero return value.

Patrick
