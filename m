Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705406;
	b=crXYOIoL4G/eMua/R1A+MbzT0NmxmLFeCVsOQNF216votkicHic4XTbpSs4HW0P7wTkM
	 wr9eSlN2zhku6zNkcv7Q5Io3kgMafdGVmQIKYo9pHrc0l+jHBQC2htZPvu7TTcaoOvs8+
	 dYmnU/6ugj1wEc/wIVjVaEILAEwwv4R58ZA9v5yjQyFx/lAiupHe2yWjLqmOaeriSus5U
	 /PvC4qhU4oZSsH4TXkGXPANYacfL2eqcUuK4x5pyKaO72zp7eufR9cdmSBqEaGrDzQ7xp
	 NfiOni2/3N3kYQGBBV3cEJyh9VRAkeSPOqeXEErPglOIMqmJi4lY6FCS8iMV+H4JWDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705406;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MxEM1GVad/OpKe+1h3b8YM3TS7qYPXoCrOLPUfTohNo=;
	b=nn2B2lFk0H+JYABdKmWelIKigSih9ccC2wTJuzHisJqH5e896pvPhJpdgcNr7Vz2nOt6
	 4+8y5QRZPFeWo6nRxtcH4hJ7hzwzoKOHsqfsMX36XAtu/7A/vaVkwOWFXWipJ1fJPRV8r
	 QN2Q4Q4lVfpMIYbgox/aJT4mfDiFHpQwaCj7RntxaaXsnrZKrH/oCfwkT8JKs55B1NE5g
	 WEKBd+eNhLtaS8WGDng0BUoYusufuhfyVhG0+pQkpGBINcZP/y/22h5f7Qeh7J7C+x1Um
	 Vpgf6DEVhuO9bxZMBhwJioetX4YxQM9Lq6gTFpF1Dbeq5RlIHBJnymIDx9spGscfCvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rgQMKxq2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hzTF8qcn;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE03606C570
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 11:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE03606C570
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rgQMKxq2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hzTF8qcn
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CFD7D1D0022C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:30:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 06:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793705405; x=1793791805; bh=MxEM1GVad/
	OpKe+1h3b8YM3TS7qYPXoCrOLPUfTohNo=; b=rgQMKxq25EpnyqK3GeaCZ2EKPe
	ml+ri9CLX7ImgoU7kUaWFjryyC1il6vv1tRZZPGPyjWauFJwlsD5ughfpgxp5JN0
	xaBXg3Inz5JouOaPT74IKix0SSpjQF3MbYEa/DOIxQJ2MTL466d5ehJb4YbMEdyx
	mKqR+2aFSb7LnpWifo9VO1dJ6xFA+42Y/JrXXxtRyMrWetvG4EFRdVNCZ/PkX3LG
	0RN3EczQjhoehyJXwbOm82QWlxzk/wvEcrAFnusg2f5dWjDPSOt9PPlntbSV2JZj
	6AHgZ4AlmAP9EyUX7t9n9vKNuG8VfXDlDH4GK2fuUgTf3ihR64YHfIKGRmqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793705405; x=1793791805; bh=MxEM1GVad/OpKe+1h3b8YM3TS7qYPXoCrOL
	PUfTohNo=; b=hzTF8qcnkS5rMU/JZ//iRQyF3vbWvhTVrd88Qk5ito7xH1N3bqE
	MMEe+ttnkfp7WZpBSelpzHef3TCE9KeX9DLbAWygfi3kA9DKvtRltVZzmsArn1yw
	D/C8AMQNQvXKoHxjwTaDf8ErXRRr2e4e7Jjj4UZMm2QPsIR9nzkmd9A+K9lz6S0l
	ij5VgMdP+4CVvkbPR/+eiuxR3TVGqWl74P4erBFLKz2IdPKHNQfmDK7vs4PRUDQt
	lFI44w98MwAJaMifXws5bmfOWsVM2MPtA1vCbgrz7j9s8DdZAAFzIwsp8gYNQHY5
	k2MZpj9apCPn6COzBnU+YMybsK7bXlgIgiQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793705405; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:uWUVQIXnqs/+r7Ner6jX0FnHN3H6sRWDqPc0sMGoWK6bgfz
	3+5wFWCgHjLg6a3jV4Bk98JfffF3xjmJGKPaGGxGN3T/znRFexl3+zyot8RYRoxG
	5VxMc83jwVKC8czCiroCqyno4rikTGfkvg1bfySTfzXhHm6PsLgfuS+5v8Cp7qAv
	ry8yL4IQTS7FDjSoOHN3kxVUupwNXc1bZ5FuCWvs6cykGxowWg9aOaIw4kwCHjt3
	Yp1njmq4wWozfbJXJQwZD6BmqW3eItPyntVUdn4/I84Z+udQ4b0emw+grkZb5W2q
	C8TZ27CYcpMfp8j+Sd1MFuLQZ5nqT7iAY+Y/oqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LUAEUlkHKZ8INtN2hF8hhpbZ1hn8pcALs5KYNyPi32o=:rHVcgzLqLPdJQyGZN6MuMWVR7ma1QsqsnPWVDXMnuhg=;
X-ME-Sender: <xms:vcXpavu0U75H6tBou8DXyrhaZUcB4mq7GDMjW0FEMyltfuxuu_jW3g>
    <xme:vcXpandR0CIwafhlCrPP7MrFhuxqKiRt4RzZcvzDG3-ngnuSTKkEuQi_IZlOIPOL5
    s3TqXe035258kuk8Frehz43_v5zKaLM87uzIzTjPI23hbS-gaB08-fZ>
X-ME-Received: <xmr:vcXpanyngbUzF6wy8YkvysGyYUD4pC2cExRzhgfngWdaQHxrF2u0iw>
X-ME-Proxy-Cause: dmFkZTFhtpSfkmIhik3CNpLEcjnopBeXT+0q7ikUzgzXra28TY7meHAIazuymjnPsssJnD
    cgbeWGckfa8PV77DTABqUX8Sqs25yvJh1K5bo0jt8TN60iG7Y1t5wmQgMk+7i3aSvYdduD
    lXdKYk6kb6z0ymlFK/8rJdJkBF9GCh3O2sLJ47dWbP9m4sRCq3CQKUWPVxBfUrAcoebed0
    tAP4/pdS3MAbGIL2/icMHGVI7VAP9xgzwjdpysIiD0OFJjplU0vb09C6V1niB0qKgZsH6z
    Au0qWYfHKDmMy9722j6/C1KHk0FEUJM8eCOd1iPg+sI/TUbpJwJ/KmZ2ucxyVHS9qirRTH
    /zAOz5LhfDvTO3v4JyJq15Gha5O9EzLsG3syiaqgQJtT9Thv/80o4gGWRbdzZcEgpwj1DR
    50cAe2r9LkcOR80A7My/nVKOwvM5qyHKrNWAYIFlnwNMWha3cRr94SQRtGia9chpZ5pjeE
    b01Aq/88Om9iBW+568DOdId04zMkJlQ4z1/qwy3eYqBQvoaNCP/dKoulUsUy78L14yWqq9
    b1+14QmtS95c1qHXiAVcDTFqUJI4wKEhMcLUBJY3nJr+MitqeecjAJgq0ytTpswarGlqp0
    8hrlyyzyOWwvi9CKNZaYZNxXP91Cr9y5BRlPchBClZeYABIo8b29EQxUMzTA
X-ME-Proxy: <xmx:vcXpatHFHYzvVA_Bv65ypQ4Ca-KvwPRX649zad_62DEzwzUx_tblRg>
    <xmx:vcXparw1VLD6kDdzqY6SDY-bZOc-UstKZBpXNaKRGQpryRrozJKuww>
    <xmx:vcXpausWCJxEqXqIQwEoeh5dmglOdr_UpXbC-OTL0LIh7z_HPA8j6Q>
    <xmx:vcXpao33lybiEuPeNpqDhQxK91aC4cBf3NnfmL-5EBrjbhJDY-mb-g>
    <xmx:vcXparSA9patIMNs0XI8uQV9eXlAo-GOEsysu7L5PlbGUGUfBZQXYNyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 06:30:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eaa76436 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 11:30:03 +0000 (UTC)
Date: Tue, 3 Nov 2026 12:30:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 3/5] doc: stop calling root refs pseudorefs
Message-ID: <aunFublgJruOr1V5@pks.im>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-4-andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101230326.3675597-4-andy.koppe@gmail.com>

On Sun, Nov 01, 2026 at 11:03:21PM +0000, Andy Koppe wrote:
> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> index 8d9be02036..6958ac033c 100644
> --- a/Documentation/gitdatamodel.adoc
> +++ b/Documentation/gitdatamodel.adoc
> @@ -211,15 +211,25 @@ remote-tracking branches: `refs/remotes/<remote>/<branch>`::
>  default branch. This is the branch that `git clone` checks out by default.
>  
>  [[other-refs]]
> -Other references::
> +other references::
>      Git tools may create references anywhere under `refs/`.
>      For example, linkgit:git-stash[1], linkgit:git-bisect[1],
>      and linkgit:git-notes[1] all create their own references
>      in `refs/stash`, `refs/bisect`, etc.
>      Third-party Git tools may also create their own references.
> -+
> -Git may also create references other than `HEAD` at the base of the
> -hierarchy, like `ORIG_HEAD`.
> +
> +[[root-refs]]
> +root refs::
> +    Git may also create references other than `HEAD` at the root of the

Nit: I'd drop the "also" here. It made sense before, but it doesn't
anymore now that this is its own list entry.

> +    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
> +
> +[[pseudorefs]]
> +pseudorefs::
> +    linkgit:git-fetch[1] and linkgit:git-merge[1] create the so-called
> +    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not references as
> +    such, as they are not stored in the same way, but they can nevertheless
> +    be used to refer to objects in commands such as linkgit:git-log[1] and
> +    linkgit:git-diff[1].

Do we maybe want to provide pointers to the glossary for those two
entries?

Patrick
