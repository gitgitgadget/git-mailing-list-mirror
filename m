Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054176;
	b=UKjISX4Yghj/QrMqRwhKbux26U/PwMuNZzgdiveQ0UqYWghQAbL/BKFis8S8b8OpygTf
	 HQFwUkpTNTEitgO2+zsZqQb2s/7g7UYoO4Scl3PYnAvR3zM+igy/TJDJ3I/bE/qAZ9QvZ
	 kVajcIZV1YvN/MQ5k/3zTO3mWI3GE7GD12MJR06bjCuxwW5tBUHp6w4G2h2UKxJ1yWDRe
	 +yOAgB5xz1RhxiXzuMi5R7CSPAVk7ZxR5iZ6coCYn5IWiIuk+24S+HdK/C/AbnyGRL9rN
	 ftqPZbjF8ZEJscHGR69c67G11fvhZ8Ih2gzBftvy93sbkyuPxCI1dyz+Pb795i3Vn7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054176;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VmP6nTnQDLw/DMSgFAVoSPYsGq1YO7SCElTh6mhpMIM=;
	b=Ks3psGo7YbK+pv+o+W9v9CygXxxmfUZEzyI3/yA2u3x1dLD5bPDCXjdjMixThT+USSHf
	 554kg7tuJiF7H9lRUATXrK4NZG4r8otq+W5HWGi7NqfQA+Pb0yefCZ3Br5wL690JNQ1VT
	 iG05AIZvsWM8ZEdKwTyy6vVRfZpwYJBHQMxuejS7apAO8EvHMSdmx6aCp55CZYJPLhxh/
	 fkf25NttaRNA3x3jFfXqaaBr/v6fOexccubzOtUM9+74GiJPsi7/5qMVIulioVnJoYzXt
	 taj1zTobZKmrGuj/YjeimRvbvw5R3AzOH6kR2Anfcs8gZUbTcUI+wyntM08Dv33vJMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V6jcfRj4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RwmaYFWh;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42284606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 22:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42284606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V6jcfRj4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RwmaYFWh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7408FEC0A68
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:36:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 18:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793054174; x=1793140574; bh=VmP6nTnQDL
	w/DMSgFAVoSPYsGq1YO7SCElTh6mhpMIM=; b=V6jcfRj4TaCdUUQyhr4wUDp9Sh
	P5eACXBSvuh/YFhUBHnhdRQ4dQCYpcGa9ruUBngwoIzhIk+CZvfetFjkLcCmkodU
	GQlLOvfDsYGFhR3cHGZmsZ4z5YsdwYroD3DGxtBtqd1tPcjW9ZhfHAz+/BxsWJpY
	j/RtLyLsAKNZg7ITz/xxBBXq0ChwivFm7fojDCmxjL0Zb4zCTpfqPfxzc86jHKaf
	UUcgR1qUTXD0yT1MPwlthfGXwg8W5mPRPdezFf8pCMA5lsJI8lZMPb7uzzH48rOY
	4ONO5My058tt9ezf0jaW9TLuXpa+G1WSbP9yN1FVZm4LVFdGtGap1CazAp8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793054174; x=1793140574; bh=VmP6nTnQDLw/DMSgFAVoSPYsGq1YO7SCElT
	h6mhpMIM=; b=RwmaYFWhbRfLdh+ksOgFG/Sl176Bxzs3hiqpSlJWVGhSwnzHgI4
	m8aP63C0VPGfqT+6q1ag1rrvYWFi/uso8e/iVSYVzpVzpnUdgE+T2a556T+dcNyt
	JvRgo3uk5nRrGzLK1IQXq4cFMYE3Z+sJUXmGfxZVqcIj83a34uRvz1FuT6ynlgDp
	GnpNG2fQ9dwZP25R3HclYFuB6KhUpXCwhJPccvADkmdBG1hpJp/+pBUK653beSf9
	PUykYgpT0LY2znGclM5MNm/fROBhFwRjZzAF5qqKo2DKURdQQFx0h3ndDa2XRZVI
	5SZ/4uAk/86vgLM5o22PkL7s5/NNnNpsrWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793054174; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Qd543pJABKk9197Ij4F5Re2ceRG/oEWssLCKSdA/b5C2FB9
	9CiSdHqdBjeOwJcZYuiHz5nHokPPsFCfIoROE/ZNnN24Otweb4tRk1w9OzkcKBZv
	Ax6teX9Tx+Sc7iglY/eVMELZMtHVYyHd0dALv+55BrU8qJTrOcXerzRrlY8ibcT4
	quF5Pws7NmTN6GKM0+K5VSEs6JcLgmrFl4sQfg4u4taHNsXc8OcTRAmfdRDRkLey
	/IVw+56geYiF9MlTPB59xt+UoP1wSmjrJY2kszEx3Y54nkd69fMEB1VYkzqMduW9
	9DMgMWmFR5PGUHQ2NhA38E56W3NVYejZhi1n5Ug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:H6e5xss+arsY24BngaPm+40wvbTKQNgqBlQecosDXcU=:fkwvBAJewtB5rHuvJickVd9DHF8IgITzRfYXWG7u7mc=;
X-ME-Sender: <xms:3tXfatg78YvncW27g5UQHa8CGNpxh1SSNDfPj17-uhtWpi68czswEA>
    <xme:3tXfalvMC8R-oegZYy9fp7X3kiZ3F3NSv80mzeqPFobp_N_Su2nJcJqogzt33g5fz
    rFW1913JZPMpUxNmpG1R9uytM-g-avWw1cPKWu4Wv5UpBoutdcHKEE>
X-ME-Received: <xmr:3tXfam4fR6m5fFBH0fm3EfyS0bv3Ict9glXIIs3kZUF34AC6A-nN91iCCEIjPWgoNycJJ9yx9LqfbKi8KjZSOEs1yM44mBJeryOl>
X-ME-Proxy-Cause: dmFkZTFXZcFlgxX85dMjsp3bpK8ajofyZU6tJh1wUGmdIURHuTErykPE6M6CJv0IIQb0Ap
    3XpMNItSylTPWcAR5LVJnPIaXiUAV3aVfqIyTfpR5S1uNuXvqQ0ajnMeDPApKqk7V3tCw2
    FLBXqJo1sXJRO6LiFTawjlRmtEODtUcddHnK6HcFHl6v9ML7Q7ZLq3wVqpGGaf3gCon1pI
    lrH9rBakKp8NArcufuZCXsJadnTrJuJboeed5txwBPNs2KvWAJhzoXb1HI4cyDPqB5cttG
    2VvnFKnKnJNo3mWMT3O1vJoaL7tUchWN5ImFpxZggd7GJH5ipjBsKXTwdE4ArAG9wNJyO8
    IYHOMEaUkrlbrJbusxF/pOBJBKS78QdmKYcgqM5GBtY3Kdv1UxUS8EgfF5FJJ3ppTfokAo
    VYUWzhKgg2a9ranbjHnVzn+S3GuPGJ1QWhhFeaWqMtEATsfekCk0BR3mwAw/1NertVPOdu
    lk8f6O5TZVJP5Tu2CQ5NFf4D5q+siYT8wHBMimQi0nIMKF1cPItcjq7QWb0W22gKHE5/xz
    gn1OKbfBV6FcOefA6Ei9ppu7Icmzjrsc2kLlkQC815Zjl1AD95wN13RRcn7CwnTkQMSR5o
    rDTgfr04f+xztBkKqf3n1Ka9lLyuuMLTeZBgvkjHPxOsQVIXjKCFP7waK1yQ
X-ME-Proxy: <xmx:3tXfapOl2jrcLGNAaW2PGrmyq7m_1QeHaWnvkJN3D7TO4d1Ezy3J0Q>
    <xmx:3tXfastg1ANZnbMtyIpyXfr3lRMhX8XBV4qqJM-f07yKCMdkCfIQcw>
    <xmx:3tXfaka3t0SaSu742sGJ21Jb3rsVlEKW710XmSNEIcZ4GC6bU6wwhA>
    <xmx:3tXfamxjcgfhsUzbuFftiht4tpz_QfQLy4TAwL9ORF6UIkrBm_z0aA>
    <xmx:3tXfausGtf2_OHyor6x0tAqfhpWm_CA20z1flbuPInmTMYwwm_pOWsoL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 18:36:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Tuomas Ahola <taahol@utu.fi>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 2/2] doc: remove references to gittutorial-2
In-Reply-To: <0a42345cecec10bd32ae3db1a699452b164a2f25.1793022742.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Mon, 26 Oct 2026 13:52:22
	+0000")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<pull.2241.v3.git.1793022742.gitgitgadget@gmail.com>
	<0a42345cecec10bd32ae3db1a699452b164a2f25.1793022742.git.gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 15:36:12 -0700
Message-ID: <xmqqse1snl7n.fsf@gitster.g>
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

Forgot to mention one more thing.

>  Documentation/gittutorial.adoc       | 23 +++++------------------
> ...
> diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
> index 519b8d8be2..006e534778 100644
> --- a/Documentation/gittutorial.adoc
> +++ b/Documentation/gittutorial.adoc
> @@ -622,24 +622,12 @@ Next Steps
>  ----------
>  
>  This tutorial should be enough to perform basic distributed revision
> -control for your projects.  However, to fully understand the depth
> -and power of Git you need to understand two simple ideas on which it
> -is based:
> +control for your projects.  However, to fully understand the Git
> +documentation, it's useful to learn how Git stores the history of
> +your project in its database. See linkgit:gitdatamodel[7] for an
> +explanation.
> ...
> -Part two of this tutorial explains the object
> -database, the index file, and a few other odds and ends that you'll
> -need to make the most of Git. You can find it at linkgit:gittutorial-2[7].
> -
> -If you don't want to continue with that right away, a few other
> -digressions that may be interesting at this point are:
> +A few other commands that may be interesting:
>  
>    * linkgit:git-format-patch[1], linkgit:git-am[1]: These convert
>      series of git commits into emailed patches, and vice versa,
> @@ -662,7 +650,6 @@ digressions that may be interesting at this point are:
>  
>  SEE ALSO
>  --------
> -linkgit:gittutorial-2[7],
>  linkgit:gitcvs-migration[7],
>  linkgit:gitcore-tutorial[7],
>  linkgit:gitglossary[7],

As the main tutorial is being rewritten from scratch, and it seems
to assume that nobody has ever heard of gittutorial-2 ;-), the above
patch would not merge well when both topics meet in 'seen'.

I do not think this topic to remove tutorial-2 would need further
rework, but just in case if it ever becomes necessary, could you
leave the changes out of this series?  I can remember to take the
other side and ignore the changes to the file done on this branch,
but not having to remember one such thing helps quite a lot when you
have to deal with 100+ merges to rebuild 'seen' on top of 'master',
with updated topics of the day.

Thanks.
