Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E881BD9C1
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323837; cv=none; b=oYLdygD5s4MpKmVIZrbc0H596EQwjtGBr4RxtyMp4Pb1ENoRbp3mMp0Hd5CWLftaX7JO+oz34ynhGB4L+WJRfnSKh3DqTXSdIjh+Wt8QI45ln0W/CpeVz/kW5BGxF8gk2c8yGQADNt9P+Y6Sgz78k9P7FiFlGMrtJcFVIGvAt60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323837; c=relaxed/simple;
	bh=57vcAJfBDThdK60T76KWU/6i1dDQrzn+WzF0MXrxeuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRtH/N6cTcK1GeDRHl2Z04vrUwTOAE1m0fgZT/+5jNeSHM6BbAFPfgZpnvBhMs0QiXAboUV9EFNyuvRV7tGUrsiLVmhKvEcBMQZNmxf4aRoou2xbu7gqfhSPo++CjqllaWVTvaPTxH4AIVABlQjrlsOxBQAwjz7ZX4KuZy0WZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKajV2ZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTEla1NU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKajV2ZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTEla1NU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 315701380111;
	Fri, 31 Jan 2025 06:43:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jan 2025 06:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738323835; x=1738410235; bh=xiOPlFnF4d
	m0FdnhrjqlTiwFSU6zL3wc6Pt+uYqgV20=; b=XKajV2ZWY7DaaSWw4XEu7JRVBh
	dC3qPteLe6gpL5Tn5YhIenS+QfvhoS8cGyd2D6hdHfEBymZ9VqJOyVti17MCoHIA
	8N5YchbOORqF/LkwLujO0oe/c7FQPUwXGW8Zp73ydqF0h038dOQ2pWvbjU4o5vyG
	nuSDjBmkSCFMEvx7mwgDmoqYjjl7OHpQ8PFyIMgc4YX7XXJhdEv1lBOYqYzrZRwx
	VyH0K8uOjtQHv2vRWRjT517qaAexuo6kLSVkeOTcuDwjAnm4ujDqMLUlgaQF3TAe
	7HfHi19y5qHFZApvjmG2PHMTctpgVS2HiXg5oiSw1LoeBfoLYESQ5frf9WMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738323835; x=1738410235; bh=xiOPlFnF4dm0FdnhrjqlTiwFSU6zL3wc6Pt
	+uYqgV20=; b=dTEla1NUSGfaSHhMXe7+vMdYeZPhNcBcRdF3yHX+H8kt3+X3yT+
	gLrqqlzA5ZqAJfIObTZwqy7kKCCt719t5qxazSdfPX89tbdYYWFHe9a6L/YEih1L
	gYzHrhuiDFvOE4wPJZUGPEj3zGdi40Bhc+L+jbjH9NsfSkEKD3hyDkW8OgldQMsT
	bdhnbQuwDkaftCPykmJkDHK0QMxdnqoEykssXkSBH66lhxUiBNKSCpq66sbn7j8k
	YW4dClLMWIzy/I58ej09LUuiYZ9XnuQVqTuhfCRZ8lzyOBpdxLESyWj8ggXIBh83
	kFhEdUWPGakwSe4KZGxXxuISzgWYZfpyDRQ==
X-ME-Sender: <xms:erecZ6PDuBfZlJzQ7bg98TrMyHAt3zwuMkIRzGBPukFSG8bVev47mg>
    <xme:erecZ4_aqRWwD6RE6ssvJZu2_qoZ4LsPGYM1aQ_PhGg5Ruv8OhqcOFkfi_A6lnKLL
    iHq7MSVboGHJWEQMA>
X-ME-Received: <xmr:erecZxTh4kgOb4DzobsGHuAETQ6UtFd-zdTIT_GBLm34viXzGvoWycLr8rzmJvfzdwI-lEqMMRqeRgbdbzwgLsbNCvTyLtsMougN2yMQnEXLdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:e7ecZ6s5JfoM4mUQrW2MPgajJc1nz8g8w4TgE3pwuFEULtkd6e1fBg>
    <xmx:e7ecZyf0kKMsajWNcwAO1OC43CxSQpiPIRxzeqXJdi00AvQ8CsUyqw>
    <xmx:e7ecZ-2a7UaoiXVNvNSw3p9chpT8NZ_FF1iYJjLcL8i9c8L24YTd4A>
    <xmx:e7ecZ292dXc3OvMl6IsGvJyLus03kfF3_NDdDc0WD78tDk9WNpXYhQ>
    <xmx:e7ecZy6RwzQicz3WCTyReI8ccDq5YEZP2inhGejD8VZUO9IdhBEWwS5R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:43:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75696bc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 11:43:54 +0000 (UTC)
Date: Fri, 31 Jan 2025 12:43:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] t/unit-tests: convert hashmap test to clar framework
Message-ID: <Z5y3ebBpzYM0wUVG@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250130091334.39922-2-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091334.39922-2-kuforiji98@gmail.com>

On Thu, Jan 30, 2025 at 10:13:31AM +0100, Seyi Kuforiji wrote:
> Adapts hashmap test script to clar framework by using clar assertions

s/Adapts/Adapt as we generally want to use imperative wording in commit
messages, as if we're instructing the code to change.

Also, please note that the code is not a script. Scripts get executed by
an interpreter, but C files are compiled by a compiler before they can
get executed. So you should be talking about "code", not "scripts".

> where necessary. Test functions are created as both standalone and
> inline to test different test cases.

I honestly don't quite know what this second sentence is supposed to say
:)

> diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/u-hashmap.c
> similarity index 60%
> rename from t/unit-tests/t-hashmap.c
> rename to t/unit-tests/u-hashmap.c
> index 83b79dff39..6b6d22005a 100644
> --- a/t/unit-tests/t-hashmap.c
> +++ b/t/unit-tests/u-hashmap.c
> @@ -1,4 +1,4 @@
> -#include "test-lib.h"
> +#include "unit-test.h"
>  #include "hashmap.h"
>  #include "strbuf.h"
>  
> @@ -83,23 +83,23 @@ static void t_replace(struct hashmap *map, unsigned int ignore_case)
>  	struct test_entry *entry;
>  
>  	entry = alloc_test_entry("key1", "value1", ignore_case);
> -	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +	cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
>  
>  	entry = alloc_test_entry(ignore_case ? "Key1" : "key1", "value2",
>  				 ignore_case);
>  	entry = hashmap_put_entry(map, entry, ent);
> -	if (check(entry != NULL))
> -		check_str(get_value(entry), "value1");
> +	cl_assert(entry != NULL);

We usually avoid explicit `!= NULL`, but I guess in this case it's fine
to keep this as-is as you simply keep the preexisting style.

> @@ -165,39 +163,19 @@ static void t_add(struct hashmap *map, unsigned int ignore_case)
>  
>  		hashmap_for_each_entry_from(map, entry, ent)
>  		{
> -			int ret;
> -			if (!check_int((ret = key_val_contains(
> -						key_val, seen,
> -						ARRAY_SIZE(key_val), entry)),
> -				       ==, 0)) {
> -				switch (ret) {
> -				case 1:
> -					test_msg("found entry was not given in the input\n"
> -						 "    key: %s\n  value: %s",
> -						 entry->key, get_value(entry));
> -					break;
> -				case 2:
> -					test_msg("duplicate entry detected\n"
> -						 "    key: %s\n  value: %s",
> -						 entry->key, get_value(entry));
> -					break;
> -				}
> -			} else {
> -				count++;
> -			}
> +			int ret = key_val_contains(key_val, seen,
> +						   ARRAY_SIZE(key_val), entry);
> +			cl_assert(ret == 0);

This could instead use `cl_assert_equal_i(ret, 0)` so that the error
message mentions what the observed error code is.

> @@ -242,38 +221,21 @@ static void t_iterate(struct hashmap *map, unsigned int ignore_case)
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
>  		entry = alloc_test_entry(key_val[i][0], key_val[i][1], ignore_case);
> -		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
> +		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
>  	}
>  
>  	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
>  	{
> -		int ret;
> -		if (!check_int((ret = key_val_contains(key_val, seen,
> -						       ARRAY_SIZE(key_val),
> -						       entry)), ==, 0)) {
> -			switch (ret) {
> -			case 1:
> -				test_msg("found entry was not given in the input\n"
> -					 "    key: %s\n  value: %s",
> -					 entry->key, get_value(entry));
> -				break;
> -			case 2:
> -				test_msg("duplicate entry detected\n"
> -					 "    key: %s\n  value: %s",
> -					 entry->key, get_value(entry));
> -				break;
> -			}
> -		}
> +		int ret = key_val_contains(key_val, seen,
> +						ARRAY_SIZE(key_val),
> +						entry);

Indentation is off here.

> @@ -330,32 +292,68 @@ static void t_intern(void)
> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +void test_hashmap__replace_case_sensitive(void)
> +{
> +	setup(t_replace, 0);
> +}

I was briefly wondering whether we should use `__initialize()` and
`__teardown()` functions instead of this setup function so that we can
then get rid of `t_replace()` and other test functions. But then I
realized that we want ot have these separate functions anyway so that we
can easily test with case-sensitivity enabled and disabled, so this is
probably okay.

Patrick
