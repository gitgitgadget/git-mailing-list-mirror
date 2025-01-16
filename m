Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FD1F2C54
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033188; cv=none; b=gKeHFTd+lS6D1KGVW/OoGYp8v6x0MVuCrAsjGc1gCWelJU8XnqK/ZKBhtB8a0kcGl6kTsYav2VZ9azfGrwNpXxJfLbqjxMGWdzL93w7VWDYSeXH5K2Obp9jRQh0/gypTjeWr02LJzxRmefBiqUBKb8qm84wIMP6BrHD1gV62Eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033188; c=relaxed/simple;
	bh=cSg0OwtnLfueH+HiYS1tA6TTBHAnF6T6qpDDhEvPNF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMqW4x4+oQ0e1dM7rDLTiKCtFTqvz3QuXI2fFaI/XF+yhYcJrT+uOEQgWWKbos87rr5Oae4PFKqiG3Hc53cPZ/BjhysBIh3ceYLPSFhLASd55nUCvLBVicZJfgtrmDR7c2rXLhdx+KVH8jNV/Y4iKmzwjqxrgwjHKcG7hJkQU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q82pnCQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gidSgoB2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q82pnCQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gidSgoB2"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBD3A2540103;
	Thu, 16 Jan 2025 08:13:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 08:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737033184; x=1737119584; bh=tljAunt9EV
	oXdGa5lERHUVDVCoBxIdX3MNSWSp7EQOo=; b=Q82pnCQMxQSLUWOTec/erwtOvm
	GFPY+ddO/J+pOq11HYpmWhrHTDHXS+uppBjansFfIyl0AlgtnwcgaXCfvjx3tb5I
	Fi7UbRq7g6hCeCa70dRfuiOBaplHsjN331QfHVLcZg8z65UmF7MFyFf1jmFhPWXB
	TWwZROc69BT/5zAuJwhfNzcDxmOONbXxEcTiJ05WVnVXaO5JFF++W3agrLBaT6YG
	Mf7Jv3mOOlrvYlQwqnUBc+NhreCuHrDI8MPh43fc4mN6ltlvLxp9h7qhSKxw0eSD
	IHWFZfddvh4PLsrBhOjoYpfFDQZmVB+1dn20oehMLbPsfvqJ7t0IAUYr5eeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737033184; x=1737119584; bh=tljAunt9EVoXdGa5lERHUVDVCoBxIdX3MNS
	WSp7EQOo=; b=gidSgoB2/mN4kISyqlLoT/ByonhtDd4XjCCLc800M/F2TyTduSk
	5afDS+UAvSNqAvd5XoDtv8yFriOGShL6XNm7RQ7j0k08A5MdhYZQCkjnTXj1sOFP
	wjrDQ8gAf7XWZf1n66B5yojSOCMaWw4sPFiwUQEIH4/nm8B9BDayybyYgh96cwaE
	LDzIYcVHFj1spkJnYL8R92dJgncDSFWRLcYTMCGAw4jgT5ghSV0IjtcV44h0hbUq
	pr30fd78I1aVl81W9PMfvC7KxPDpnKpm8FL2oSQ/ozOGg8FeDPpNrk8xSxRDCMro
	I1w9IhiOfor46c5LyqZBdztN7l3yvTaGu4g==
X-ME-Sender: <xms:4AWJZ_zztJj2dpIjS-L5muANMigTRR4SWhEx6EHexEQVGT33LX5mwA>
    <xme:4AWJZ3RmhlTMe8brBZHutW95twAJ2qbIPWgKGxmw1jHVOmuXrdNEBWSu3Imaz5T7A
    O7E9aKx7NetfmM0eg>
X-ME-Received: <xmr:4AWJZ5Uvlr8x4vzbHx2Topb1Kk-iiUwoym7j0SiChZxo-NpcRhhYfjPyk9sAcCvPEBAJjcX-wB6bzcrQHJiFMTMBnXSfG8nhUuUeaZ8ocizZ0A__xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:4AWJZ5iM8dkQkwSFZVMNnh29vOxdn9x4052cY9j8FAHLTMXhZzF6aA>
    <xmx:4AWJZxAxjXjRC7OvKkEItMrJnvYzjY8gaKbI9mMdqPLrk2-S0XkqtQ>
    <xmx:4AWJZyLg2MmGZVyDGaWJbePJdVr-l8TOQYXXy1IwQD40a1pD00-SAw>
    <xmx:4AWJZwCMq1gknQNxoLFCAAm2KKjP0qtGfzqEPXb9ww2ZWwVph_jSmw>
    <xmx:4AWJZwNovCBKpxRE3BgyEbyB-o2ThktEj4YXGci8lU-nIHBsJvvJV5yk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:13:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ad3cd74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:13:03 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:13:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] t/unit-tests: adapt priority queue test to use clar
 test framework
Message-ID: <Z4kF3pqipEZ5WAzH@pks.im>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116104911.77405-4-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116104911.77405-4-kuforiji98@gmail.com>

On Thu, Jan 16, 2025 at 11:49:10AM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> deleted file mode 100644
> index a053635000..0000000000
> --- a/t/unit-tests/t-prio-queue.c
> +++ /dev/null

Hm. A bit surprising that Git decides to not render this as a rename, as
most of `test_prio_queue()` is unchanged.

> diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
> new file mode 100644
> index 0000000000..d36a565e6f
> --- /dev/null
> +++ b/t/unit-tests/u-prio-queue.c
> @@ -0,0 +1,94 @@
> +#include "unit-test.h"
> +#include "prio-queue.h"
> +
> +static int intcmp(const void *va, const void *vb, void *data UNUSED)
> +{
> +	const int *a = va, *b = vb;
> +	return *a - *b;
> +}
> +
> +
> +#define MISSING  -1
> +#define DUMP	 -2
> +#define STACK	 -3
> +#define GET	 -4
> +#define REVERSE  -5
> +
> +static int show(int *v)
> +{
> +	return v ? *v : MISSING;
> +}
> +
> +static void test_prio_queue(int *input, size_t input_size,
> +			    int *result, size_t result_size)
> +{
> +	struct prio_queue pq = { intcmp };
> +	size_t j = 0;

This is a `size_t` now, which is different compared to before. Might be
worthwhile to point out why you did this in the commit message.

> +	for (size_t i = 0; i < input_size; i++) {
> +		void *peek, *get;
> +		switch(input[i]) {
> +		case GET:
> +			peek = prio_queue_peek(&pq);
> +			get = prio_queue_get(&pq);
> +			cl_assert(peek == get);
> +			cl_assert(j < result_size);
> +			cl_assert_equal_i(result[j], show(get));
> +			j++;
> +			break;
> +		case DUMP:
> +			while ((peek = prio_queue_peek(&pq))) {
> +				get = prio_queue_get(&pq);
> +				cl_assert(peek == get);
> +				cl_assert((size_t)j < result_size);

This here is the reason, to avoid -Wsign-compare. But the cast here
isn't necessary now that you've adapted `j` to be a `size_t` anyway.

> +				cl_assert_equal_i(result[j], show(get));
> +				j++;
> +			}
> +			break;
> +		case STACK:
> +			pq.compare = NULL;
> +			break;
> +		case REVERSE:
> +			prio_queue_reverse(&pq);
> +			break;
> +		default:
> +			prio_queue_put(&pq, &input[i]);
> +			break;
> +		}
> +	}
> +	cl_assert_equal_i(j, result_size);
> +	clear_prio_queue(&pq);
> +}
> +
> +#define TEST_INPUT(input, result) \
> +	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
> +
> +void test_prio_queue__basic(void)
> +{
> +	TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
> +		   ((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 }));
> +}
> +
> +void test_prio_queue__mixed(void)
> +{
> +	TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
> +		   ((int []){ 2, 3, 4, 1, 5, 6 }));
> +}
> +
> +void test_prio_queue__empty(void)
> +{
> +	TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
> +		   ((int []){ 1, 2, MISSING, 1, 2, MISSING }));
> +}
> +
> +void test_prio_queue__stack(void)
> +{
> +	TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
> +		   ((int []){ 3, 2, 6, 4, 5, 1, 8 }));
> +}
> +
> +void test_prio_queue__reverse_stack(void)
> +{
> +	TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
> +		   ((int []){ 1, 2, 3, 4, 5, 6 }));
> +}

All of these look like failthful conversions to me.

Patrick
