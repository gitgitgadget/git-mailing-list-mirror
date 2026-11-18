Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990323;
	b=WIOfUHqZYjCBhpeplib8dIvwShNZZ1UIj+PlwSsk+mkDxV4CQwlTFENLrnn8FWkxZa35
	 sHC8mHgAWlQG8CDkP9Z+WPfhfvUMB/kUqghGThm3PA0YglfambMh7HTVWqOQqEmbk+LgJ
	 lZzA3IMrrz5PFg+l6/qBQ6zt+Bc3WeXsuMDXB9nAE9PMKVcnbdwsfzVwhMXS0ayWPO0xE
	 4pf4tpnAHoCYr/1TuhMoiEvquPy+QzMRLNUehxn+l+10V1w9ZpXQSLNloobizxhIfGNLM
	 BBhX8eTWY4L5PLRW7xFlLIEe1liacfXM/EefAWOQ7SwPO66nyPS2kaaYGV+mc2C5sAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990323;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ge5ob3DZd5sR05ZfUvhZnkGn9tOAzQWn6WTisPI5H9k=;
	b=VUo54C/1cgtn043JJQVUvRSyVUviCFtfWPoqzKPuPQDOPs7dnPxJmm7cBVpOyM6KWDJk
	 v/MmNBEJW2U7Dp6jaRG8ANrvlMwMfi7UQe/hQ3TM6rlp/9Fx3g1tbe72RldECW54/MY9n
	 0YUqHEEvlml1PBrOTIGwl3SfejU96PkrJvvobzmT+qxf4Us7J7dvNzRK3IJGI2Qd3yndJ
	 v8WHgP3yksZMXuphdWo5r9rOihe2F6a9/55zAzUDlVYS8ilXn48LPIspL3xyHh2Zc//AO
	 4pyhs8ewWp33wnTnrFeZ+TdtzZp7clgtnniMvZxfz5cJKyayE2LhXw9xBlu1mSUf/Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=axQc1IVS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xweS0KSv;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F6606A335
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 08:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8F6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=axQc1IVS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xweS0KSv
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45F071400165
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:25:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 03:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794990322; x=1795076722; bh=Ge5ob3DZd5
	sR05ZfUvhZnkGn9tOAzQWn6WTisPI5H9k=; b=axQc1IVSbke46oQgYCf7+1YeAo
	WFLl7bJZTELqc9LW0gwa0TtbgW9/aHig1ZCaPccl/LtUcm2MwSp8YKqqu9KUthrN
	ItBSMD+U0CLUHMrzE/r00GHXGipHWuboPlA+3hzWrUG7XDXnAEgtRbU0zf5qx1eF
	n+ZhyauaVQj7fGtCURHbmqoBhiIPBERwMLeHWDEP7tS294A7Rc0Ix9KhDMcXDAfU
	ynvlHuwbt2nUqw9EloYkfdZ17q2smfyoXoXyhbyTeSdflAkufQzwyvckRZoj+mMS
	b5kmJL73xm+4H3diMJHMMy0KKjR+Ih9G0AMsgvsnne4JuSSsTQEEM91Z5P2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794990322; x=1795076722; bh=Ge5ob3DZd5sR05ZfUvhZnkGn9tOAzQWn6WT
	isPI5H9k=; b=xweS0KSvekFYMxSjVOrD/Gb3xgwEkQzqPn0dQWfwZwWqOB4dUcp
	tvLrv9pxv7qeubRJmdzr19F3aIpBlEFH1LxSMFG3Yf29E2gHa+YgBf3Kl+RJ9uD5
	jXVkB+Z83+YkB2qE4wZFsq0df9rDD4zcMOMo/BU++h2C0jPk/NhEbvYn24D1uZli
	w5ZceS6HfRPb2pJ/YT4c610ZvVwUyQ/ulpX5KYWePIw5/iWfDUayxdEEjQsO6r9D
	Z7aIZQWYrmkQ44HVEbkak5+MyYdf3l7Z6hnppHS6rQzTd6lwvabaXdUC1dQ7+KvR
	ezgHmpzJur8Y1bptgGCS56xQhufbWnZ0b8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794990322; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:AxzqOMH7N/RhJYf7dC8JDh6jBhpUyS/jkqHem1EdEuKllcp
	LDmaU18cksOHo/gkOBRDT2Bv5FnXtLETJkod7huNK7y4HXPnrVifJvLpy8npx/O2
	aAYBBCx+l5jGU/KsY2WldL9hO3RawJickf6luoe9RKg3a3PTV8Wd7WXEghTu/gEt
	2oz+0KWAKQF9mFnMdLBY2jKfM8jtyICStoOa1OOGxqz1CBmnN4Uiq4QH0Yxw8vu6
	hvN4CFb9eoInvdXF8zPG3KJu1l6lVl3YXdyu5oGpbunPlF+S1XlVGdrTrschEnj1
	E+PCcZuogKPRRyezftWvNYiyJRAo7gbsgiZUd7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J5Ny/sTWSm+tBkT1onAi1mavn0iuWmzg6+3BHd9PXlE=:cGgH3GhC2ms0VKV9vT7yc7FHA+F+qwKz6VqKJujdf24=;
X-ME-Sender: <xms:8mD9ai7ZDIu0zavZfrYP3BrNWGcVfiUklSGwMz70mhUj3Viy90CyXw>
    <xme:8mD9avkNcdGA50K0nN5fk0swPYrs9uigt5R_gN5aiEIKyDY9z4Qan0TZ1XUqp1DW5
    PzS1s4ZAHpz-UJb4a9apGDd5K3nTIHBLGhy04hfgOl2SjDBeOmha0M>
X-ME-Received: <xmr:8mD9arQDANiAuCqVFLHJlJpkx_N6CsvK4E-8Q7rrqDqcNbeybjaZlw>
X-ME-Proxy-Cause: dmFkZTE55K3u9ahwWSLJ9WX6+RIaO3TJDWTAKz393EzLQGQUCE2cE3ExOSEvw8R66I/TPg
    Y0WFBr2+rfZjBIjuonTRK//T3nsmWFKqP9rPQoHKEw5JpJaqvJODCzmaBzJI0qblLf3R4a
    u4VkOztGnxYtv//+i4+fsj9XT58VL39W30wPSO1UA70iIvrzyI9e80evUq1fSf1Yf8tpGi
    YOl4JxDbnI+7FgVIV2LXC+3MDRpum6Vg4t20JGzE+IwSnOvMWrVV4cZrdrivyHdKlAuYlw
    qVYN1jxZvA43zFmhRQjMImiT6xxXSjwOZaM0k+j45qlYwFMlm9rk6LVbzJGyDvTgp9plbN
    9xTxjaXrHFHp1vevdVDpjef5DfA0+g1zc/9+Pk512v+/zQshjDgG6UyzbSjbutZLsJw30I
    iwDoo9Gh0hUuxyw3Njghlq7rPjk2Y7r+YKvZo2MDO8YA0AF7OaYCYABVlETdJCQ9qE+ExX
    XoI23KSqTudBNogr4sxO/3nsGKpuTBmO8xPEJ2YfoqIZ7zVrxpaGQKa0DydGmVHnNSiZdp
    D27KTzb1Im1imLbCwUFzwQ621h421VQ6hPVDHdhNvjAiLqn0dqZXxbBqI56CM8d7TNu8Tg
    vqNDTTsiVesvohGRD0yy1xO79+Dmest2sWL6i914247PADOWON3ExP4lnu6w
X-ME-Proxy: <xmx:8mD9amG7MmFtSv9YLrfuwmxNUJV-jSDBt5-z7JT70hQxnk1FPyG29w>
    <xmx:8mD9aoG91Dil306-h1g_dJX5vXjGbQSDlCFFeHQ3xYgot8qm8CHr-A>
    <xmx:8mD9asS08nQFsZPrY6NqEUhugXn1d4Yf4xCWdGJXkbAxdh-s01K2gw>
    <xmx:8mD9ahKGd4Sh9ZulZzBrcyWf_qMKpcop67sFbMyd0HrFhvhqpxVTFQ>
    <xmx:8mD9alDoPRIXoJA-sj2mDLZu2Teiul3FHJLL4_jgmHCS535PLuxKvNss>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 03:25:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de30ac21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 08:25:20 +0000 (UTC)
Date: Wed, 18 Nov 2026 09:25:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] odb: widen odb_write_object() length to size_t
Message-ID: <av1g7VQnCAcs5J1W@pks.im>
References: <20261117174353.1158905-5-christian.couder@gmail.com>
 <20261117174353.1158905-7-christian.couder@gmail.com>
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
In-Reply-To: <20261117174353.1158905-7-christian.couder@gmail.com>

On Tue, Nov 17, 2026 at 06:43:56PM +0100, Christian Couder wrote:
> odb_write_object() and odb_write_object_ext() use an `unsigned long`
> for their object length argument, while almost everything they pass it
> to already uses `size_t`: hash_object_file(), format_object_header(),
> convert_object_file(), the `write_object` callback of `struct
> odb_source`, and `git_zstream`.

Huh, I thought that we already had patches recently that converted this
function to use `size_t`... oh, yes, this is overlapping with Elia's
patch series [1]. I think it would make sense to rebase your patch
series on top of his patches.

[1]: <20261021101640.329990-1-gitter.spiros@gmail.com>

[snip]
> To fix the possible truncation issues with many callers and to prepare
> for getting rid of the check, let's use `size_t` for:
> 
> - the length argument of odb_write_object(), odb_write_object_ext(),
>   the odb_source_write_object() wrapper, and write_loose_object(),
> 
> - the size stored in `struct inmemory_object`, which is later
>   copied back into `size_t` fields (`object_info.sizep` and
>   `odb_stream.size`).

Yeah, makes sense.

> diff --git a/odb.c b/odb.c
> index de5be285d3..56a7910b03 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -702,7 +702,7 @@ void odb_assert_oid_type(struct object_database *odb,
>  }
>  
>  int odb_write_object_ext(struct object_database *odb,
> -			 const void *buf, unsigned long len,
> +			 const void *buf, size_t len,
>  			 enum object_type type,
>  			 struct object_id *oid,
>  			 const struct object_id *compat_oid_in,

Right. All functions that we pass `len` to already accept a `size_t`,
except for `odb_source_write_object()`. But you also adapt that function
at the same time, so we're good.

> diff --git a/odb/source.h b/odb/source.h
> index 7b56f51b82..8daf5df31c 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -454,7 +454,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
>   * object ID and the compatibility object ID, if non-NULL.
>   */
>  static inline int odb_source_write_object(struct odb_source *source,
> -					  const void *buf, unsigned long len,
> +					  const void *buf, size_t len,
>  					  enum object_type type,
>  					  const struct object_id *oid,
>  					  const struct object_id *compat_oid,

And the callback functions fo the backend already use a `size_t`, so
those don't need to be changed.

Patrick
