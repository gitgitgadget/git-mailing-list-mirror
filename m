Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843C2EA48F
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627205; cv=pass; b=dPmZcDlBEZ8qBurGYPNpoywzpZVavk/1jrjBgpgSDvdFqrPAvyz1whi6R3lWKMSb1JQUXpF9A9mm2IqwzIcz7/kxRCJqwKkgIAsEJB+7ChXTv40iAEabrmFSd6B2E04fx1CFzO6Zyhhtk/SfQ8xgJGrbYCytXOcEqIMczLjHosw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627205; c=relaxed/simple;
	bh=urQA4ppEuCOHNQfFmwzVEcsscp70hTZAPerExQklx3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLDPCzoDhQr0Rf/4cUBALGbSZmJROLq0bSsejIdYoIBP0LLn41mLicyYUJulO0aIa5W2JXPEC+5bdmKPeTW+n1mR+6vivkoTZGPQW+dG/c9M0eDUdps/MsSteQWqGb9RtOmTAt5pu7/Qd4b/hlIvsukMoM9oSlj0c1po9SDnk2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gDQxGiEE; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gDQxGiEE"
ARC-Seal: i=1; a=rsa-sha256; t=1774627184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dLxkTMnMWSNTP9+hdaul5iSWF6ofImkhmJVI1zuwtBncj3t4q/IfCuRJ62KHTcLIcQDcHrD674ht/hltgii1nMG8gQrn0TzzaGm6LuxoDPYbxDUmxN4qU875kPlF1s/yy+IewjfWU4MMNqkB6jBlK65pOPpHzjl1LpP1f5cUT5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774627184; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LOl4vfSXqaZK8z9SA1WDRPYJg6H+FVeRzL/o5vhPoBw=; 
	b=NWYfqfC976+hX/vQyxh8g8vn6Nu7k1apwRkzDm1ZDI5Zov6LtMv7vtvBlEoK47j1sy/UGlkJOJCWMiDrAql8DMxvEbQhiZsGxyuAKKVXp4c6NzSE0dd7jUDXiFfcUxxxIvbEfLiqBP5jB/wZaZNOzJB2VhIYdpzk86HrmP9B/68=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774627183;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=LOl4vfSXqaZK8z9SA1WDRPYJg6H+FVeRzL/o5vhPoBw=;
	b=gDQxGiEEIQf78I05CZFhmV752bvRbG/UUu+PYO8NCNfWaI91uWmPsMsza6abmyPq
	E6xcRbW22yMERNYxr/Ru3ZyhiVD6HRY57IZ5kCkoJAogjq31lVBu9Khur/F45M0kiEo
	GUM25es8NoFduMLip8Iml/dPcTalKjzxd1HkXHfQ=
Received: by mx.zohomail.com with SMTPS id 1774627181454192.55128538611518;
	Fri, 27 Mar 2026 08:59:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 10/12] hook: move is_known_hook() to hook.c for wider
 use
In-Reply-To: <acaYUU4FvEwWTaNu@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-11-adrian.ratiu@collabora.com>
 <acaYUU4FvEwWTaNu@pks.im>
Date: Fri, 27 Mar 2026 17:59:36 +0200
Message-ID: <87v7ehl0uv.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 27 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Mar 26, 2026 at 12:18:17PM +0200, Adrian Ratiu wrote:
>> Move is_known_hook() from builtin/hook.c (static) into hook.c and
>> export it via hook.h so it can be reused.
>> 
>> Make it return bool and the iterator `h` for clarity (iterate hooks).
>> 
>> The next commit will use this to reject hook friendly-names that
>> collide with known event names.
>> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  Makefile       |  2 +-
>>  builtin/hook.c | 10 ----------
>>  hook.c         | 10 ++++++++++
>>  hook.h         |  6 ++++++
>>  4 files changed, 17 insertions(+), 11 deletions(-)
>
> This needs to also be changed in Meson now, as we're adding
> "hook-list.h" as a dependency for the builtin sources, not for the
> libgit sources. Something like the below patch.

Nice catch, yes, though we might need the generated .h both for the
builtin and libgit sources. Will double check this.

I also wonder why meson does not fail ... Likely it's because the
builtins are built before libgit.

(the makefile did fail, because I didn't move that dep there as well
initially)

> diff --git a/meson.build b/meson.build
> index 1b0e431d5f..2536ea80ae 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -560,6 +560,18 @@ libgit_sources += custom_target(
>    env: script_environment,
>  )
>  
> +libgit_sources += custom_target(
> +  input: 'Documentation/githooks.adoc',
> +  output: 'hook-list.h',
> +  command: [
> +    shell,
> +    meson.current_source_dir() + '/generate-hooklist.sh',
> +    meson.current_source_dir(),
> +    '@OUTPUT@',
> +  ],
> +  env: script_environment,
> +)
> +
>  builtin_sources = [
>    'builtin/add.c',
>    'builtin/am.c',
> @@ -736,18 +748,6 @@ builtin_sources += custom_target(
>    env: script_environment,
>  )
>  
> -builtin_sources += custom_target(
> -  input: 'Documentation/githooks.adoc',
> -  output: 'hook-list.h',
> -  command: [
> -    shell,
> -    meson.current_source_dir() + '/generate-hooklist.sh',
> -    meson.current_source_dir(),
> -    '@OUTPUT@',
> -  ],
> -  env: script_environment,
> -)
> -
>  # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
>  # build options to our tests.
>  build_options_config = configuration_data()

Thanks for the patch, will do something similar in the next re-roll and
credit you.

Will wait about 1 week in case there is more feedback.
