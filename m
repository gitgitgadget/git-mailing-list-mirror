Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74619D07B
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179879; cv=none; b=lhT3fq3l22mwm+d4lYeD6SWTyAz823NbXw8EZPddVyW+PivgqEQsZHkj4WODqNDe5+XKY2ZcGgz2Y07AiVUeGvH90e0XBSR81Bz+Gt9lpKGxzqfv0CqWUWHo4p0GIHF9xjrkiSal8ccp3fFQbdN8CaI+ll1tlZ0EU6T81oXDa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179879; c=relaxed/simple;
	bh=ym937/s3qZosnt1bORG/KyLdCsOgrJ7+vNzZNpyhWt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buRTxOzuToPlPPOzzeEC6gq9ltow0w20Nlbc4w3ik6CmTZ/yf2W6cBv9UwmfcDcmZWlOBS2kGAkdJuY9ulmEMiqQkRsISmf7V+bgqXEmkmiaNW23EkQBXIGlLwkDUjol07ZkBImaBPosev9XMebwslz2pEOzbg0Tm9IbzWcTy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwS1jras; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w0CzisRK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwS1jras";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w0CzisRK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EA1041380FEE;
	Fri,  2 May 2025 05:57:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 02 May 2025 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179876; x=1746266276; bh=Ryk6p/j5FF
	hoQ3N7e9ZOffRjUbZwX0ALbQRLxYQhtOs=; b=mwS1jrasVKc00zkztL7apQ0qYx
	wbvIIyod11OoKq+AnHW/Pr8ZMZp0x9T5fF4vvzEE4frNxuyZsGoIhLfaol6h/IVu
	491R/2P/VZt1VKrzvHtOpFFqRSU+3ZJuUHQbqQifgeZ6hFNUFHdxvf2j5sltLbsK
	lM/UBVJmIb9i0+7G4oAM1uSoT6ON1e5KAlu4CkcUrnVW2pv+8XwEXYP/xXZr5lno
	zAHV2dKfG6NLXt0QsG+of3N2aDpYZVVvTyhT0BZGHh6wwpBCNM8cmL/CO2CWb1Yw
	eql8vuJLT5zI9rWtmKKeCLXQu5VBQN00OhlEAMbtZ+IsdwcSe/Ij/daOYyMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179876; x=1746266276; bh=Ryk6p/j5FFhoQ3N7e9ZOffRjUbZwX0ALbQR
	LxYQhtOs=; b=w0CzisRKvjTeW4C5l1348DlaZ7edDvRoSzNYjSBuOIjsXhhhlCf
	+pCRSDGpr90EsL+gKnVhJri4PS9HD9E/ZqdUSD/YZiOen3UYSusiZP5h0Xchjhg3
	Sha3J91nj+538J+rjhVXzu9gEOubizO+zoRPPbu8dEfSqoNNxYkSHtPLFBuVZUYO
	FpF95P3qjQq9OAm5jhNFKt05prPM5jek3YwYM3zttXHpHA9tW2nyMFzBkQSn0+u+
	oRIHtve9Kn4rp9bvO6ZN1Rj7QswJpQVIaQaLZNMfC2eK1zWDYP9eQHLBllR2xLee
	NAwwd4/7+4j4gcmOohaZkE2Wx7TPRAcR0sA==
X-ME-Sender: <xms:JJcUaPJ-EB5o0CSxx1zf6tdC3j94E0X40XX4r5cJ7D9BNumXPmRSoQ>
    <xme:JJcUaDKVIcoVzA8y2cL33XXu04TF9u_IhivV4anh7Aq-jb67_d7cIqrzr2p6OnHFG
    su8U3BpClRT3F9bew>
X-ME-Received: <xmr:JJcUaHvKzxm76GX_6wE_7KFLvTdeKuBpMHvW81NY9N7W0NEg6QlKo0xQziYG4mrYhv5tNmFnwSD1Ggx8avD9-l3kbrrms-VKhIgMEPpejmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:JJcUaIYkq0WMp2skJJaoNqDa_A_79lQA9ROZrIKWwkar9xbbKpiYzw>
    <xmx:JJcUaGa1eoho3dvDpIeBeQMAE0Gl4Gr7qj2-i2y2lqxXEh1pJsxmPA>
    <xmx:JJcUaMB8J4qRbZ4RP3oGgurXNLFy2S3kPVwkD4ULpholfXRjbu18_A>
    <xmx:JJcUaEYvgkA6Q6_JZ4soW-xuoAuuYgdU7xl446xvUGTh9IS7U_Q6YA>
    <xmx:JJcUaK9xnQQMASFFchsx2pG25DXTxMAIcH9mpUjVRvAN9kx3GRL3rSg0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9467d540 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:55 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/10] t/unit-tests: convert reftable reader test to
 use clar
Message-ID: <aBSXIih1QleXX8wg@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-7-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-7-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:58PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/u-reftable-reader.c b/t/unit-tests/u-reftable-reader.c
> new file mode 100644
> index 0000000000..6c35063105
> --- /dev/null
> +++ b/t/unit-tests/u-reftable-reader.c
> @@ -0,0 +1,78 @@
> +#include "unit-test.h"
> +#include "lib-reftable.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/reader.h"
> +
> +void test_reftable_reader__seek_once(void)
> +{
> +	struct reftable_ref_record records[] = {
> +		{
> +			.refname = (char *) "refs/heads/main",
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 42 },
> +		},
> +	};
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_ref_record ref = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_reader *reader;
> +	struct reftable_buf buf = REFTABLE_BUF_INIT;
> +
> +	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
> +	block_source_from_buf(&source, &buf);
> +
> +	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
> +
> +

Nit: empty newline.

> +	reftable_reader_init_ref_iterator(reader, &it);
> +	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
> +	cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
> +
> +	cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
> +												REFTABLE_HASH_SIZE_SHA1), 1);
> +

Indentation is wrong again.

> +	cl_assert_equal_i(reftable_iterator_next_ref(&it, &ref), 1);
> +
> +	reftable_ref_record_release(&ref);
> +	reftable_iterator_destroy(&it);
> +	reftable_reader_decref(reader);
> +	reftable_buf_release(&buf);
> +}
> +
> +void test_reftable_reader__reseek(void)
> +{
> +	struct reftable_ref_record records[] = {
> +		{
> +			.refname = (char *) "refs/heads/main",
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 42 },
> +		},
> +	};
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_ref_record ref = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_reader *reader;
> +	struct reftable_buf buf = REFTABLE_BUF_INIT;
> +
> +	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
> +	block_source_from_buf(&source, &buf);
> +
> +	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
> +
> +	reftable_reader_init_ref_iterator(reader, &it);
> +
> +	for (size_t i = 0; i < 5; i++) {
> +		cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
> +		cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
> +
> +		cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
> +													REFTABLE_HASH_SIZE_SHA1), 1);

Here, as well.

Patrick
