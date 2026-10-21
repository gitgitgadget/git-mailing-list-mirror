Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605236;
	b=nW+qO0nv7ttZB6oc4K6i0Q6Cy09UWtdi+gsOQQELAUTTL1zmWFWWToUFB2GZIHBAu9n8
	 TRGzFcuuE+p5/O/pWN/7oM09eqFtLRFt39ob7/XYRAzdNe5bAMHc3D0uTvmY74YUqyZR9
	 FSgDQieRAo6WVCg6OHovNxiTrzMjwNzN+I56AyKPOjzPMBNlQiQxKHBSIHovK9o55F/s1
	 2YmGIj7WKd6Gi0hqe/OZgNAQ0zwmk3zN/gj5hTIeMZF95mNjCaY4Vm1dKfH26Z/Bm36Br
	 KG3AZISewY5xCHD0MdeZVhjWMgqoVl9J9W8WkRky0KHu1e0YEFxSbCd4nQJPNHa2S/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=iyhyqr2sIvyUveTwlNQZm7/cIKSzRHz2dDCNINGz108=;
	b=mS1n7FrmaSQJegFMB/kRZ187lU05O4shWjTJGLaWFn/4+cF4ANhfjUh3k5MBjCMb8Y25
	 oetkkrxHQstp7MSHamo3BBtAw32dJkKIVsuMaQ7fOkoFkbv8+mkMMpdwMUvfQMkSnKQzD
	 ru9LzGOvkJX2lat0fNKBTt/+z+CBpkdDpTVVajYYY00LEm6ZDiCgfXH1AlC67y0zLp6kg
	 c5gAWuLkYpq5fBFJfQw+I+f+jpULIJ8Q3taXyUQ/2AUgOLtmizPFCGnsUOhWfdmkfd2n9
	 W9evktl+PG2iLm6+6g46Opxl/DfARMYVaWT/ajqS+8At4zrMAO9UNyrKaTeB0+2L3WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=sjqo+YWU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GMBY6wpk;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4B606A31E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE4B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=sjqo+YWU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GMBY6wpk
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5F5A1400024
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:53:54 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 21 Oct 2026 13:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792605231;
	 x=1792691631; bh=iyhyqr2sIvyUveTwlNQZm7/cIKSzRHz2dDCNINGz108=; b=
	sjqo+YWUcxyEgbDOlEzD24NF308+X91Wpjbdly+YY71ASWm0DCopp/wIc36UqmZM
	cm5GpkFVYgkexnCzyaG44d+b13ChozPujXZSb2jVo5BQ1rP7PXoTHHVVH1d25xEO
	+bW4OaFyW9lDTsT5MJy7qXKremzYT/5+fv0UBmKwz2UkHJMNwsflxt5Xa93Cyz+o
	o8Fqo4Ask4/aTQwhe9PyqDaKS2pFtX44YbfAYE1ZtgccC/kwCyFWi+l6Bh5PcL6W
	VqioxRuQ9D4DofHlZO/2IqS/pe0ZAYXqF2Odi7VoXn4LA1bAmKHMkQtZ8AT9XsaP
	IvgKMOACumXuhBldpVAvxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792605231; x=
	1792691631; bh=iyhyqr2sIvyUveTwlNQZm7/cIKSzRHz2dDCNINGz108=; b=G
	MBY6wpktoq21lnJIFmt+O3J1Egd1ugD4tngege9zvd8HC0a1OHw+ujKl7enEa30B
	1bmPvqy8ESNTrp63S53crKpDqyMUvFFrA32lBZs8MZu7zwf6+nf11Ug4WqhxpWJn
	F2DqBYNB2vIVMAQJRQ/9aHk3fGNzphQyu6tN7ycssAEResIOyqJhKQJ4qvy72LmQ
	9LDay5teb0s8Lw0mKmMlhPTL+vWgnqLy+EkCCWL0MBlSJOIncZOgwG5cJeExyVsR
	FdIzGRBXml4ADDw/JpH7gkBhrYBaXNsghVYVGxNJm+VPndKdjiSBlCBEVIhWIwUT
	rJEiR2qs6OeTy5C9gUV0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792605231; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fqo839Y7LZOGxcgTm58elWRd51duRiWy5PeyJdi9DozXdr9
	sDqkjbEzZOWvVk6QH2Ariqopg3FHfXf0e7vV/sttCIpU7F4/2CAXWfVh81/F63bO
	/LgHl2DQImxnWQGtRYi7snOtKBsY+nQQQmUmyOx53wl9fF4+xrw7s1D3QzUwaUZ6
	1aB6U/DUSEP43t6tXjLGThodM106bCgg0wfrdE/k2y+MTPXGbzlqowv3OBzAFpzy
	09lX6VqrhajKHR1xSvDXSf6OBu1Oo71ohM6iRsNzmIl0eTZnlFATNNCJwlp+TQvc
	bKbSq8hYGaGDBGMlkIqc3TPGCv3nLVdr+Tjt4zQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Gfk8HaYt9sXXdg8fqebKLoCH83qU8ZOing14jSaOBd4=:6Mn8aSjj+5lVv+rAz6jw2sGIPleHl0jioqHlqJUTcfs=;
X-ME-Sender: <xms:K_zYakVrXXdR2ZJL0RH5KYX-clOuNIs3PEsfiwpbyb8fZIDssYIgNao>
    <xme:K_zYajZ-UVb6Qtmkd9NwLYh4VKeWMgzyJvO6k9g8QySJBGEYN4cRKWf8lxyn1NHbB
    hxVMAm4s3z_qu5f18bVyI-wyhTFvGTDq7gUqkI1kDHaUtZ7cMIkPng>
X-ME-Proxy-Cause: dmFkZTEB6rLro/1tgEdPXnmJoqMK/QE3bhUi0AT1rKDMH11z+uTbCZnLNm8wozRp7uNqD0
    J2pNjnsedCuCEIW7D2RvyEXedRKzx5tktSbD5i+oJr+VcJNdlL2DnOYETiKiOuN5Ia4xFF
    4G+kRiU0gKV7gzUEpTWufIPAr12T6vYss4QzogH3iQngCyfaPSxjufCjKmfpVlBPCFB/Ht
    X3ixhjMtiO5oanBSPymM+GeYoDRHCcKxSQFXg4Al0JtTXOXa+DyKmN46YYC3O/GAfNA84S
    frXcfCfSXBqTosHgXKaz+jOeLmrjmFlp6OS0qTobvyNmWypVd0JSDngzIKH6V1YWzKkVG5
    /MaSlUbTdo1JIAdcvaFs+QjYU23K4yKoo/ez2JMLP4S+jb0kSzqI04YB3HF75aax1gFxFD
    3SOicqLAJN4paUkAsBsBBhracAzUX4mcag0sSxfNXI5O5Lpz25ZQ6Rb9mEhJWpJaaNNJvZ
    e2F4IHpaX0G3yfOAP8Ka9Pho55/cX3qGoIwhUGdUG3tqDvLgfZynZCLgvAGLVOZcIB7Qx8
    sn25X0WMfH/TBLP2cK3euAsZmFFoMLyGQpN2AIgtQgcjekACyo7yIyYFv8J1nNU7B3tcmJ
    3g+vXzO95bwRLAAo6ZPzhZTIwnb9S7GhR+ihQ0NMJFPgxPiiZXjZ6AGdUP2w
X-ME-Proxy: <xmx:LfzYal8vXc4PYvGm_AS7aa-_RwCKor90vrFuR86kG14hRnBSzfOdig>
    <xmx:LfzYajzlHfZ7dQH6HTkk3OPO_bChsdWz-TS1lIl9DEROtG5O1J8ddA>
    <xmx:LfzYai7e2HW1H8rs1_oBGLGbibRhQXpTuy4qDapZ1OhhUCYNnr6wUg>
    <xmx:LfzYaq_oxEks_-4JN9t_kG0CeKAB6egxmhFZlT-55Allnw3_F47AxQ>
    <xmx:L_zYarFvp1m9QQJKtFARS4IG-b4MeOUz3JcecVwtd-4mOhGDHMr4-Kn7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 77ECD22C009C; Wed, 21 Oct 2026 13:53:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AuviX-i-bDAR
Date: Wed, 21 Oct 2026 19:53:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 "Jonas Rebmann" <kernel@schlaraffenlan.de>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Message-Id: <e1b21ca4-fe77-4aae-8135-a25397efee04@app.fastmail.com>
In-Reply-To: <atfmYYtUii4gWIIH@mit.edu>
References: <20261020141011.0015d172@gandalf.local.home>
 <xmqq8q3sw75e.fsf@gitster.g> <20261020152354.165ad128@gandalf.local.home>
 <83c59078-f6f1-456a-a99b-688eaf56bab0@app.fastmail.com>
 <atfmYYtUii4gWIIH@mit.edu>
Subject: Re: FYI, git output messages are being used by other tooling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026, at 00:48, Theodore Tso wrote:
> On Tue, Oct 20, 2026 at 09:28:10PM -0500, Kristoffer Haugsbakk wrote:
>> > Where returning 0 means the bad commit has been found.
>> > Otherwise it keeps looping.
>>
>> Is this different from git bisect run?
>
> "git bisect run" isn't always the best way to manage a bisection.  For
> example, I might run a command like:
>
>    gce-xfstests ltm -c ext4/4k,ext4/1k  generic/245 --repo stable-gc.g=
it \
>        --bisect-good v6.18.57 --bisect-bad queue/6.18
>
>[snip]

Thanks for the example. :)

>
> So yeah.  Sometimes "git bisect run" isn't really enough, and it would
> be useful to have a way for programs to be able to call other "git
> bisect" subcommands, and have a standardized way to get the results
> from the command without having to just parse the output and be
> dependant on the precise format of the human-readable output.

Yeah, I don=E2=80=99t know about git-bisect(1) subcommands but the `git =
rev-list
--bisect*` options showed some promise when I tried them.[1] But the
most useful property turned out to be the most annoying thing to figure
out for me: how to simply query for whether we have found the first bad
commit yet or not.

But maybe that was because I botched the bad/good setup.

=E2=80=A0 1: Like for `--bisect-vars`: if it turns out that it is *missi=
ng*
     some useful vars then those could be added without worrying about
     backwards compatibility.
