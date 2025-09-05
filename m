Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2109.outbound.protection.outlook.com [40.92.59.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281801F61C
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076365; cv=fail; b=PUWH/JbpQmYQ9VMvxEi2n3/g0wROg6mjIxkSe2JqFCsF7qg3iFGYVFvUxEYIx+TQrKyQzqLG194+WIJwah2D1BZ+c89Q/PI47eGLnvh+2bhYNzWnKNGZL/uZu9GSHlPd0GYto0/a887NRWl3TysXWRn95FDOhQgONalNRmnJq2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076365; c=relaxed/simple;
	bh=fHJQogeBkWrrLyJ1a3Lcutcd3r9bRpvg/3C6MqIr4pI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=q6s4qarUaHa9iw16PTciCd1nlT4/SfW3ae1WtO5PtQpjIF3iYMEtMd5aTqkZ66Q3dkcMsvhR0xjpDDqFQFxCjw+jnBYJrBGe6YlmUeSDiJCsXgUQtaPKdBRE1QsLEDFlr2IbfunSx1aIb1GziHBse7CRdqvRjENCFw9VQE3+Yj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=l9TG3sjp; arc=fail smtp.client-ip=40.92.59.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="l9TG3sjp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHs3mnVQHZmLn7beXeOv7YkXIo0EX/63+pXa8JcNJPKC+hNcWlf2iQAUw54ARjORBtXo6CJ+lIciA+W2Yd5Td7Hso7pM6Crqho74tbg0u2yGqEn9Nj0K87XKX+oprZUR2ol+vzaQfCjOJJqSWwh1ZN5SbZZkptL2o0YajPdZG4H1C6UWGkdiOixRzxwgMKMjquIZWldx5bNcLaSzEw1vxbNVPkgpzYtl6ZZhNCll+uAlbBl0dUcWLjAANGwHCdH46xmtWtQkW97BClT3jBisGgu3hEfnaFm8+uhG1XkazXLGWZWIPZNKPbUXvpYgDt2HfK9ZwpWAtum4oKhBc84YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzb3Nwj+0/O5rqUxUvHjOxpN7RNEm/dIrgEPeFSrqAM=;
 b=y+NltzQZzUQ/tZgOhpJwX7+EAbLe/GGs3DP1siQTFWZM15puU4z2Vg7WKfhQf18wMPyFf7PCxmBMHW7OQ6nmCWUFr7JZ6KDRNQWWG20LQwj9B2g3M1eGwjilrmRFuhJf8neNkVj+22O5guzTKu82JK9RGsE4jW7xWhtEjtUMqV4PwVD9NRYmrgMOyoYo+RDWzfDjR0kIPJjnhVe4VadY9RvARAM+xWiD3RzWHKd+sZCnS5cH5tKmmT588E3z7CintVZbTP/j61WMzblSVNBEHuEOwnvknlgAjNPqxHf3YyhqzgsV/dI7Zqns0ejKYl65+j+EOsgNYixA+aCkurt5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzb3Nwj+0/O5rqUxUvHjOxpN7RNEm/dIrgEPeFSrqAM=;
 b=l9TG3sjpJsTo1SAm7+OeRvIUMT3uJnKjnolhLjlLz7s3PCwWuMW6bQGZP0ky6NA7Vv7xOH5/rPWkMyRvc7BYbOgg8dQVHm9JvC8uzRi36so08UcPnXH7RH7D5uKOVc+joDDJW1zR6Bt3Yowt2qQCOFa7YKYhXcCRz3/NGraIe2DQ1pVYn+PQMvohOEtfq4yet/JCsZwnvgCPwNN7V3VSw5s7/87ALAdf+2jZVca8jBS0WNB9o6ag36FYd0NkldeItujKYvchA2NzKoITHBM/bNbMdN/CjCi/95SyToE6vJuwJ+RVoyTLMzL9mhrBi6EphXZlbyiyR7aFFzsqVfnZKw==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU7PPF2F5E906EE.EURP250.PROD.OUTLOOK.COM (2603:10a6:18:3::b47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 12:45:56 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ad6:ad31:a192:5183]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ad6:ad31:a192:5183%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 12:45:56 +0000
Date: Fri, 5 Sep 2025 14:45:46 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
    Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
    Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Junio C Hamano <gitster@pobox.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming
 mandatory
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
Message-ID:
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im> <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <3fb2d474-3110-5d28-5cf5-bf10c2a7373a@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU7PPF2F5E906EE:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ca292d-5217-429a-612a-08ddec7a27c6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|5072599009|461199028|6090799003|15080799012|23021999003|40105399003|440099028|3412199025|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1g7tFsC2Xg0g4wyRw2UTeiSbv9Ib2I/hmKfwJsa6244lqYO+1BuUYQ00DBag?=
 =?us-ascii?Q?pH3E6InwFcRHAr1IQCTLOl2QidRtqovogqMbxpDEaVaBLqCY6ncm1Kx8mIy4?=
 =?us-ascii?Q?6nEsznbRppxH6eKJctXmkFXJog68cqvCB1rogajMlaYYqii+11Mpdw8du30X?=
 =?us-ascii?Q?t8XmsljcqVeF6BxgSEoBGaxOlf8EadhCnjgJ7grza675YynTpYivg+n3+2nZ?=
 =?us-ascii?Q?AiwSpZq/+DcD3POsG9oiM7gB0TW7G7qQ8+807vrSw3UtqHFx6Uf0Oy+k2HTT?=
 =?us-ascii?Q?PMfd1Xg3wmiwbfBZQgjKfI3A9X38zdGzWdHbJMHCuvJ4fKVHdAs3PqJxj2Du?=
 =?us-ascii?Q?b+8S0qyBA7cUEmmqoXR8gUWyfXR5PW3koE/TJ3lKnboyOKVhAz4oImsJme64?=
 =?us-ascii?Q?mTo3d++mQ67A0f8i/IAVbepC1s/d16Q8HmkWNdcia57zoGq9lB0Th+ea0xlL?=
 =?us-ascii?Q?PNOoCDL0lqHPZ3ShDz/HNSPJYwhhLeTSScD+QUYd438JhocYxvi6ce9CvYLa?=
 =?us-ascii?Q?Q7M/LuMu2k2d7wzmWsarGvKm631fOOKbkmKdph6AsB9qTE97x7eYMwWZBqkG?=
 =?us-ascii?Q?r37pfAPChNjp1vTb7WeGy9rM2+EvWAM0Uu9X07i2vJk95nE4uYPei9vd29TG?=
 =?us-ascii?Q?vXCbOgLx9JARkI3N4Glez1eSxzPSAJeUkDZ6ON+tYLFTJTEJ46KRLIeMOeQ7?=
 =?us-ascii?Q?j4hklFyiXU1OPHYNvdgUGXfIARpOMS4vRijlUajGnnJgbSvECrWr8PheZsGM?=
 =?us-ascii?Q?qCahM5uPCYgQQxU/bL6O7/zynIPAqH/wPBdbHyD1eYFNHFXfxlkoakJtnHaO?=
 =?us-ascii?Q?oWQ/YUzjnAd0xt9lHY04B6a+8cbfwEOiIxiWYWozBy17ZIDE/uKMJ+Fkm2x5?=
 =?us-ascii?Q?7y1PmzFiFDWWt4AEaXAkgtVNlAjprLp6YsHU6Naoh9zz4zUhNqOYCF3PL7w3?=
 =?us-ascii?Q?SYoMHeuaGTR44PKx9btnZZpVUlm/Wzrv+KcS0m9QnCi6lYIGKHfg/4QnNR9b?=
 =?us-ascii?Q?GPpZS/26/4pbK7NJsJbWHL8lqfusKLDNRwF/WtIpQ6IzZeNkwmsU+nrRo69Q?=
 =?us-ascii?Q?ZFhbltsnUkw04OJ9+f6k92WX7FynjJ/uX7/Ktj/0FtHUeXaJzhkNYmZ5bbow?=
 =?us-ascii?Q?hiG0VJba2cPOV6RdswIEwzg7cJa8C7lQR1yqBdW05eodKcCN7u+29KUQtx05?=
 =?us-ascii?Q?kZU1e4QeW+kCc5kDgeopO2Z0bC8HpnSzKte6lw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfxVwGr7jedKeiVVlV19WTOAkgpOHg8EraTfs3usqes0Kh7kAMA9iwH+O9Gw?=
 =?us-ascii?Q?eYA2GXKJYYBVE5OwBYw6pA1XVpCl/fGk7hKSQiXYJmPrYgEiO3f2KypfifhJ?=
 =?us-ascii?Q?IG9ok0W7790GDQUgqppsJzSCGIDBzmP65JqO/+Vr+AEdoF4gIoJ5snYKPMkm?=
 =?us-ascii?Q?2swjRR665mAvYjkCP16XX9rMhPxcov3rDGictBynVJGdNPlHEbTL6iTHTu4u?=
 =?us-ascii?Q?XmkrgwEhtnejfcJhYRTJZCEpGYt/VSmn2xHhUtLLsG1mG7HE0dW5zwYVRL3d?=
 =?us-ascii?Q?TFj51D+rsIyNNpMoL2S+3XDKSqeMBH9+mZlGd1XSL3M9zgWrioNUCQ3P0/L1?=
 =?us-ascii?Q?XU3ehzRVyiJjqeVPUA8xs4x4pw6zEg9yExnOKWf9Dd5wXcqidpNcr45yqBSV?=
 =?us-ascii?Q?xxkPKW83GwbeAn1EXHwfEV1s24dCTtI5VeT1CAZf0leMiF/Q1r6lbfdyItWU?=
 =?us-ascii?Q?I7v3Stk6pSCMktV6CkWZDH12Tja8ZM6Fya0D+Bpk3eLLrUn6Zky/plM2iI5J?=
 =?us-ascii?Q?BqpBD1utrwBhQsUHYkm3bJw6aU5RZZWeKox8fECj4+xH31auUz+jOFxxMtOV?=
 =?us-ascii?Q?eWilNmbhCPJpdRnUQ5bi78wbr5jlJHfQb3ZcZl5Crf08KOYBK0AtlKdNEUBZ?=
 =?us-ascii?Q?zLVKuLl+Wa/D4RJI7WlUHHvSZshWoogqVKGo1H+sfaGn6NciBAMwkTJHKvR3?=
 =?us-ascii?Q?b3v3OIlorbTLan7MWen/LMjeZcd/obQoJKG3hrv8tDcnIiMlEhXgbbFCa17G?=
 =?us-ascii?Q?ME3PhFDkM6vOCHpcQwu2G4eY2/YlTqrjMk/6UKDfxnasYORNybzCEulbe5KD?=
 =?us-ascii?Q?MSpqz29go8XxqeCCAQdJzlmda6VsyoWFaWsQLF/djzvciBV6WX4NyVTh/Zir?=
 =?us-ascii?Q?w2Qu1wnnUcsItoOLNXV3/8h0siCRu4hRMIuTjFVVZu3AfhGQFERSdprPdxOn?=
 =?us-ascii?Q?VV/35n/vlaS6B9gcZyoY130c5vgwZyidKdpVOGoJzMcdYb0EJtqtNLkdVka7?=
 =?us-ascii?Q?TEJ5HHpmSH+B/jwZYcQOKL8pinofaEBBBf1yTP2dUhoa7EUeh8a8NwsuD6l2?=
 =?us-ascii?Q?uRL29B1ALZ45Lr1aVrIb32ftWu6Sz7qKHFghP7CeSDaspdzqHN6M0oYc3VDI?=
 =?us-ascii?Q?e4gb0eb3rDI7QVJDCvdYJVHL3So4vONOQwDccoNkhQ0MF9qEpZfAQBCNoTS7?=
 =?us-ascii?Q?kkzDMTfZDaUoBa1Wwz9+IGKcgijWEU7TeXSXpU1KIQW1A4N+6PLmME8dnRc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ca292d-5217-429a-612a-08ddec7a27c6
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 12:45:56.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF2F5E906EE



On Fri, 5 Sep 2025, Patrick Steinhardt wrote:

> Over the last couple of years the appetite for bringin Rust into the
> codebase has grown significantly across the developer base. Introducing
> Rust is a major change though and has ramifications for the whole
> ecosystem:
>
>  - Some platforms haven't yet been able to implement a Rust toolchain,
>    even though it is possible in theory.
>
>  - Some platforms don't have any support for Rust at all.

What's the difference between these two kinds of platform? It should be 
theoretically possible to build rust tooling for all of them, right?

>  - Some platforms may have to figure out how to fit Rust into their
>    bootstrapping sequence.
>
> Due to this, and given that Git is a critical piece of infrastructure
> for the whole industry, we cannot just introduce such a heavyweight
> dependency without doing our due diligence.
>
> Instead, preceding commits have introduced a test balloon into our build
> infrastructure that convert one tiny subsystem to use Rust. For now,
> using Rust to build that subsystem is entirely optional -- if no Rust
> support is available, we continue to use the C implementation. This test
> balloon has the intention to give distributions time and let them ease
> into our adoption of Rust.
>
> Having multiple implementations of the same subsystem is not sustainable
> though, and the plan is to eventually be able to use Rust freely all
> across our codebase. As such, there is the intent to make Rust become a
> mandatory part of our build process.
>
> Add an announcement to our breaking changes that Rust will become
> mandatory in Git 3.0. A (very careful and non-binding) estimate might be
> that this major release might be released in the second half of next
> year, which should give distributors enough time to prepare for the
> change.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Documentation/BreakingChanges.adoc | 36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index f8d2eba061..dbb15b6a57 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,42 @@ A prerequisite for this change is that the ecosystem is ready to support the
> "reftable" format. Most importantly, alternative implementations of Git like
> JGit, libgit2 and Gitoxide need to support it.
>
> +* Git will require Rust as a mandatory part of the build process. While Git
> +  already started to adopt Rust in the Git 2.52, all parts written in Rust are
> +  optional for the time being. This includes:
> ++
> +  ** Subsystems that have an alternative implementation in Rust to test
> +     interoperability between our C and Rust codebase.
> +  ** Newly written features that are not mission critical for a fully functional
> +     Git client.
> ++
> +These changes are meant as test balloons to allow distributors of Git to prepare
> +for Rust becoming a mandatory part of the build process. There will be multiple
> +milestones for the introduction of Rust:
> ++
> +1. Initially, with Git 2.52, support for Rust will be auto-detected by Rust and

Support for Rust will be detected by Rust? Should that say "by Meson"?

> +   disabled in our Makefile so that the project can sort out the initial
> +   infrastructure.
> +2. In Git 2.53, support for Rust will be made mandatory in case Git is compiled
> +   with breaking changes. Breaking changes can be enabled for Meson by saying
> +   `meson configure -Dbreaking_changes=true` and for Makefiles via `make
> +   WITH_BREAKING_CHANGES=YesPlease`. It will still be possible to compile with
> +   breaking changes, but explicitly disable Rust.

Mandatory, but not mandatory? opt-out?

> +3. In Git 2.54, both build systems will default-enable support for Rust so that
> +   builds will break if Rust is not available on the build host. The use of Rust
> +   can still be explicitly disabled via build flags.

I assume you mean that we will default to building with Rust, even when 
building without breaking changes, but I feel like the wording could be 
more explicit.

Assuming packagers read this when 2.52 is released, 2.54 would give them 
roughly 16-26 ish weeks of a heads up, assuming our typical 8-13 week 
development cycles.

> +4. In Git 3.0, the build options will be removed and support for Rust is
> +   mandatory.
> ++
> +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> +respectively.
> ++
> +The Git project will declare the last version before Git 3.0 to be a long-term
> +support release that is maintained until alternate Rust backends like gcc-rs are
> +able to build Git. The Git project may need to rely on distributions to help

Do we want to commit to promising support until gccrs is ready? What if 
gccrs ends up abandoned? Or takes an unexpectedly long time to reach a 
stage where it can build Git? It might make sense to give this LTS release 
a time limit instead, or in addidtion.

> +with identifying and backporting important bugfixes.
> +
> === Removals
>
> * Support for grafting commits has long been superseded by git-replace(1).
>
> -- 
> 2.51.0.417.g1ba7204a04.dirty
>
>
