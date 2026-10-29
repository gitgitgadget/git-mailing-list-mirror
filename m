Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312548;
	b=mdkdR+0RDEmIg63hrnuDbYkicF1Z/LUMSmy9RAje+j9VfYiDhWPWgAGr5HfSyZh+cMJf
	 rn/EIoh+gZXT9ZPKduG7g7Ob4V8bgXxGikou6lLTlw5tzdIpRWQyzQrP8lLXWMEiUWcdr
	 nmIDHOcIeSZ9i6QU1SR2nKVSmyEhP6YB+SdOZrf0UvwCID0gIfdBi/z8GzbyqMPdKw4nW
	 KPmFcLzcsT/gt2UGusbHC0b4AK51dj6P51uMOzqagkYJCyEUR3zryODRHNNH+75WAwiq4
	 VDibXyjTwFLFxYykb/ATtD/szWcnKVhwvCSY8iJbbSqXoqP/K6BN6zxldZcRq27AssQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=x2zPuL9lFfIc4bc4BsxEiaJG7DW3VMGD5FnPYmHllls=;
	b=pVfbgbJoRxNmay3pnPyJmmzJkxKkdB7hQWFsREeEUhUR9eweaCPrBnQa4R9wZoGGTyGI
	 D/bacpPA6gtULq8TXsMO3gAUr+kZCCf2NFkoMJT/uRksVE8Pu7Fq01aksTzdhTuGp+A3i
	 UJtjLoBd+7W50CnZ0VfNXqjNXPMjlIZpY2teqBpV3mMAamGo/vCzBIzEOgvySSEQU0kw9
	 wtRireoMm0/NRASVVhSEbpTXsPEba1JxYdLgKdjkC2PF9cgs1VofQE5FN+fdWdWQhwwGU
	 k7GJKKATC220kjZIUE3Xd8nR1Hz3hr6OgOsY755IOk0VZznSA5OqvMTU8tg1K2j2z0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dHMp+VOC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DrBK7wbQ;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D190606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D190606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dHMp+VOC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DrBK7wbQ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7F6A7A012B
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:22:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 18:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793312546; x=1793398946; bh=x2zPuL9lFf
	Ic4bc4BsxEiaJG7DW3VMGD5FnPYmHllls=; b=dHMp+VOCuWT87ft7U1+u/5ALqf
	Ux/B2cC2FNPZYJMx2uZvgyUfytcWYGCXQ5nRmo40pSPOSsJ2g5Ue4ObeZDQGkNHC
	N6IZbonJod7eWIcdRr/nlXy9EYcE7ONCYX4mD5eF5x5pxcOMYRrJcyirMOWXPUYD
	G6mMO2TUquwS0ftT0zenyLHCplc61vrTNelHitz6mg4CxEZO27eGKTlwD2A3qIcl
	+y/ovKad1I+bHzuEpjRBHebD4nLbRqEMomSDXuW2dMN22pLPGdy6yguug0Sb91li
	ZcDAKH6Y1gdHvZnbow4tOfegarK6RJgEGk0c7cZykXB+oTtGz62pt4Rz1j/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793312546; x=1793398946; bh=x2zPuL9lFfIc4bc4BsxEiaJG7DW3VMGD5Fn
	PYmHllls=; b=DrBK7wbQCul1bo6cN0qwsYF14GRVCBbd+38jkChpe1jvf0pS0xp
	NT1rRjlHPHLiiu+A9qoAEDDucSSF2AWEdKtR7mpkZa/VHUBYD218gu0HZY1Uw3ZW
	1HokqztpI0+8nCQN2+Gq2Do0GTaku1fV/IGNV4gCrB5CuzX6PMoCBIhLzYYoTcOx
	x2jXCk72WvYIgm5l8wbrQUjTIZabmJasRPTzmZiYon+5THu+TperA/JJGnhC6n5N
	aSWl8mpPIpUwMgurRmbSiF2jWGEphJIUIHHm0afgRCW6yMRoNmpNyX76E73MQqNF
	coCtf4qFkSZMcuDwaM1iMOsWS6OPW30OnXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793312546; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MkVEkC/pDi4nqc8aylGddz51UBLAeHsfiJl5cpVgKV2kHMl
	eQO1nvtDVKAjMZKYgo9UNVPAleq+EO8SKCcSD6Ad18UqkFB5Zdod8mVuHroL5fK2
	MqJWvLQenum4gNXebmqvvW6VIAOlJvCO+KcEUOJKcikwgPMvpUQfzwjrtZ5GuAUc
	UmC9QcHCfRqkOqO6eQN3wyfDnt5opr/CKZ+QmQ1gWnv8QdzPUox3wKWFb8RhamhO
	gEjvOzpJ3/BkgMi0X+1eYYEqnTjti3KPHqOpnpcfrycjBFFDhQu6dLgugXtcloHz
	XLfpxTKs2uqMpZddRhqVlM2IGlJBApq2tYNdFtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wY7T9rsRQgugt8Auhz9qQHXJSQqBbj6t1i2OlhF51tw=:PxZl7Kgd3gHKpBnAVc66a0ehv+HB7rXYwyQp+35HtuA=;
X-ME-Sender: <xms:IsfjarM65jpJD28-MZPi-z1Juc4bzQM4ui2hCi9spGaMuC3Qi7GhzQ>
    <xme:Isfjas-Q9qblr_J5y1BA2MHBYjnsHIN0SxdK7DBUultMoy2s_6bopktpo_aatGVeq
    8b61wV7VLmvaeBblEhCPRTFxMAjt6YTty_MBcASJ9MnjH6GOg0ZqA>
X-ME-Received: <xmr:IsfjavSv0wu68PdA7naJle9HsOCyXqSBxb4VlGlIMoKGxra50ssW11ndPE84ZvabvD11pL03yEpWK09zlHBpEhhfX9o0E74u_atC>
X-ME-Proxy-Cause: dmFkZTGcpCnZZjL4fU60fkOX7owY4tBF2M1T+kxpCyO5NvNqBaJhoe35XP6Pv9G+N4yB1t
    CMM3Yi27TMK66Sq5wYbemm11MHpb2glYdD7BTukHNG/Q3ifYw2zQwauSh4l1ZSSO8gjihh
    UI8TUbGjyg4KIPif5A5xrn82XLPDOum2EKIJEiZ7qWitVLWuXV3cKAKjxVAVuGSfhd6iDv
    x48b47cSPRxM7XZwQXEPmpikKGJx8uH6yAgULNycS9VKmcoXmouUGvFge0TvI5Nusofvrg
    OVZCcvY7x5fxz4/aTrNU4/jG58MhTJiy31vSOmfcOOgJXRN0hlKQ/8Sy2EucGxYD0J9up/
    ahSDobLG+mgcvlXgs0ODCVoTNtRug9Y2DLV0x+SM1QpT4YlXcfuFJxlGpVDkIA1YzxxtuT
    K+ibJX+aYi43R+B+cQ7bk4eyjinSg4ul4NUy8RM5hVvBQ8xMgus8MsdM2K2CjQrpIs48xP
    IR+vIwW6sHaV1AcE/u9UyvPDm65GKwqpj0pejzZ4ysbm7JlbS6a5YAqVTW5d1GizwEHx4X
    AgwkpZ934uc8QEskWeNw1LaxI9kxnoaFno5ZIyewHWJNOtjBlC87u//c8GD3S6ppAjSdcF
    XvuC2kwdepbJM0zvZgM8XlV1bNBNHXqiAEWEBeDwlw4WP3NDocx6KHLVuLpg
X-ME-Proxy: <xmx:IsfjaukwR9_N9JO5bPqMOZehHDlVhzlUJn75fV8eH0YQD0xDAODTgQ>
    <xmx:IsfjavReTtm7WTFq0yfr9mFzi9GFvcIA7Hg-Lw36cpktnx4ObRQFGQ>
    <xmx:IsfjasPzM19PFqisqX441bX9Wjas73PuU3NDSIN3NM7HzEb29d97Mg>
    <xmx:IsfjaoUPz4_RluHgKYC0cHf9vvnHZVCuZAv8b-GYMveYc-Wx315pqg>
    <xmx:IsfjaizPggFuro-ybYIcMrmHT8isY4bF3ofrZVN32P1Xx0XmHBaXB7iu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 18:22:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/4] loose: fix migrating "loose-object-idx" with
 batch fsync
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 28 Oct 2026 19:24:09 -0500")
References: <20261022234007.3081825-1-jltobler@gmail.com>
	<20261029002413.3291184-1-jltobler@gmail.com>
Date: Thu, 29 Oct 2026 15:22:25 -0700
Message-ID: <xmqq8q3gywny.fsf@gitster.g>
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

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> While working on a separate patch series to convert the "files" ODB
> transaction to be eagerly created instead of lazily, I encountered this
> bug that causes an ODB transaction to fail on commit when a
> compatibility hash is also configured. This occurs because the temporary
> directory migration code does not know how to handle the loose object
> index file.
>
> This patch addresses updating the migration logic to explicitly merge
> mapping entries in the transaction and atomically write a new
> "loose-object-idx" file.
>
> Some other approaches I considered:
>   - Storing the uncommitted object mapping entries in the transaction
>     without writing a file and only writing on transaction commit. I
>     chose to keep writing the temp index into the transaction so that
>     child processes that write to the tempdir could still append entries.
>   - Also writing mapping entires to the main ODB loose object index.
>     This also didn't seem like a good apprach because it write entries
>     that may not ultimately get committed.
>
> Changes since V1:
>   - The loose object index write after the merging maps is now atomic.
>   - Added a fixed timeout to all loose object index writers.
>   - Duplicate entries are now dropped when writing the merged mapping file.
>
> Thanks for the review,
> -Justin

Thanks.

Merging this topic to 'seen' had a funny interaction with other
topics in flight.  repo_write_loose_object_map() function, from
which loose_object_map_write() helper function was extracted out of,
loses all callers, and will disappear in the merge.  But the new
helper, which gained a caller loose_object_idx_merge() in this
series, remains.
