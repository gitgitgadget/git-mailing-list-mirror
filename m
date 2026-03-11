Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011057.outbound.protection.outlook.com [52.103.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13E131E49
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197222; cv=fail; b=l5rjgaQWYPghhiWEgGcWF2miMZ7s+2XUdL9fCnkiRZ9CcungwZFSiH4nJ+/ETyiGWH3iBDrEtdO9/PdTZDKOIpiR04Ti+j18fbApZozczxrbhCapTIHWDmOQnNBgSH985zhFl+fU1U2aRqOMUellmAggqqVtBzaJbaPy/fIg31k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197222; c=relaxed/simple;
	bh=BAkePVXGHEk3RqosDCKM47MwCuL8a0RxwmmtwjhSg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sZk3HfHdnITBH6brr1fF2ATaZl0siursl2lUi2Q/phIKJABogcPBfDIWxsacXMJFJFvbdgS2NBrDJuGdtIJkfCj7Z4hAHECm6TL2PWMlukPZFzOKMgSqOOSGsQM9Q+wHI8FNadE/5wEEcYTzGGurgoQcB/C3VYKNlrGS+szeUw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q5tduzJg; arc=fail smtp.client-ip=52.103.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q5tduzJg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6+aoMbrjmbaGHF91JvhdBWMFmQIaiDv38c2TrsCmhOVwq8U3wfxQDTrDPo1M3q2fjlsQPZeS7Dud5NCM9YZFLKrNwpv2MQX4VRA7IZ24MXKB9lZ0hPufQ58hoSGay33mKhL2tFebHzsIgy/gCq+Gt81cxFuLqrtmx2LH4RaIiZwLulbun0jhahDpS1mCaBaeB7HKD7fHjpC0y1M6jVWCEy4imn7CvmdFhJqDQQGnIZQ/wGNaygj63Qis5WweLBuIpdeeNxwB2mR/fwyYva7x/98QbGRA7mo+wcQWHY/Fg55d9ormhhkXIoEn7y1UvkDCwdpaCUXjMTm0wyJDwlxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0TzBQpl6WA+jc2wERLRI+beEEhPbTsWJ/pzmrI39ko=;
 b=QO/TU2ntRNBNfynpECxQWfVS+owgHjLzsDKjv1kEIyLD5PEnB1vcdhIkgMeQqLOkDeIiix4fBFAumbdIYiaNvIwf8FmUwrvP1+SUPxxozo3ftdSHHo8TVogbyg1krcT5HSuVM1dIDWj871cy2/NoXrnMeKwSNWz4A+LXXgTRq+RUNspPt0/kEOVpUtuIs7UFkZMkNThiWUwCZO1G2doWxumhRvqBT8IbxYD5XuLR70WvWb1lnXguk+nFfBa+X5dJ38Z7RI2a1S8lkcPfmYm8N3TDxPl4LCs+j81FDNaEiApstWXj8jXosSO7iFWVcm5Gjf0a9eZmEiwnSUk8fcfDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0TzBQpl6WA+jc2wERLRI+beEEhPbTsWJ/pzmrI39ko=;
 b=Q5tduzJgM1zUue8eXX2DNQ+Y94SUlITpgvExKP3BrwM6Rj8GHY0LIFV+zqOufa45JiAJd4RAiSvVujPk4VxNlTNFxQgA64qHcte42fCK9BwIJs1WvB6QTLrJxPVAmGbP3yo+adPF+Pw/Uhyb7vaKXG6vMasxYGRJx1x91CBp+0MdCYIqLHcdBpuwOlBPQV8V4MQIGNBuzGWQS70YAevDLzyIplT8SacfwmAOqenyEPNzc0sK1P5FDIN1Caj2hmIJj8R4o8WtvkKSHbpZiaKiDcBIxiIoQPJCnejnCd/bCQmoq3+0BmLnHdhx2+L9xLbbga2lNnCIucC+SwbCVE2K3g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0031.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 02:46:55 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:46:55 +0000
Date: Wed, 11 Mar 2026 11:46:51 +0900
From: Jiamu Sun <39@barroit.sh>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/8] autocorrect: rename AUTOCORRECT_SHOW to
 AUTOCORRECT_HINTONLY
Message-ID:
 <SY0P300MB08013A8975797924A3C908FFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080176719022D3D7C2C5D70FCE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZTBFXZuzxm750w-xsT4e7C3+q6r+hcgyODRVZWjtCtbQA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTBFXZuzxm750w-xsT4e7C3+q6r+hcgyODRVZWjtCtbQA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abDXm0I0IVj96jQW@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0031:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a8c921-4590-4964-9d8a-08de7f1874d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|51005399006|25031999004|23021999003|5072599009|19110799012|8060799015|15080799012|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dkkNbvzDKLxaGOxOH7YRNfy3u3JFqfjFEnjSUqcgGTXTld7deT9f8YP7t4HK?=
 =?us-ascii?Q?acIjrn29thn0b8tbIi9m1qCTd8qzES8eO06vTmEmCJxHeDTV5qBHqbBUmVFH?=
 =?us-ascii?Q?StuGobk3VsJLCQjKhltnTNuCFy2a65bcQ4cNMZ6iCtcwdqlYNwvFwuRfWoiY?=
 =?us-ascii?Q?t/Kcq20E2bgFbz+vtT/t8XAIxkPSyXdr0JR5UnymB0mFpm31xbAPAhpFlYjf?=
 =?us-ascii?Q?utOvIfObMHKH7+/NX86CVhWeUzvd6LCQ3CkHvd3uj+N2TmkgZNYI5+97+Vzw?=
 =?us-ascii?Q?MxB+Nc+cJozpIlCzgYmv5mYYZ7QAcyF56HIz2wzQehNUZ9rBgxqIsXfqZb3+?=
 =?us-ascii?Q?LDDKD2QiP96oZE3t9ED/V2wJyoiLRGt22+3jGgEggLa1vX2hc+tiHuchLCGY?=
 =?us-ascii?Q?87OV6nKWnDF/OyBQ2CLrI7ze7Spljk24Us87Kt4vlXWizIYuL/DEMhNK1qDh?=
 =?us-ascii?Q?KUVtCoeEsJcnH4/6NC8qkxR3UgLABDZTCRR8KQbFeONC32EiUcTXe8rkhjJj?=
 =?us-ascii?Q?2OB4RakBOnWP8ZM6uudqCOltJH5gp8pdftxFwW38At0HFoLFYUgSfxqzjREp?=
 =?us-ascii?Q?JMZUyIxoDisCbrVyB4YSD5PXzEMrKP9Zy7W188n5C70TzPLp3c3NNn3QqveP?=
 =?us-ascii?Q?n+Noc94dzIHHYfHqV49NwZhSGAzmVRzrWhAaf6QydHiB3V7ysJ0DoNcbbA9s?=
 =?us-ascii?Q?Jakhy/s8mp8dOSDFQMoZaPKnSqlpKPBg3mSVbOkhxKFsGsi5TePxsS9/9dis?=
 =?us-ascii?Q?qDpY/6s6klKh9y86IcM0bUwWBT7xzXu5rAP1tp+rvkn/Vs6rV1wcjHVZCIP/?=
 =?us-ascii?Q?3/8BR51vBAM5IV8fSZefrym8u8ZINxLYoolTqFzJKnGNg2NKKeu1hph8DIJU?=
 =?us-ascii?Q?XhwRv9gdyHp5c0eQ1OOYfWlr07f8xJDKY0nP/RyNptGOrH9jW1buL2QOoSMl?=
 =?us-ascii?Q?LIOufyn9bsazmMewAdPcnA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqt93AE1Gi0hrt2eh1zQK7JSZ1vWQ8ctDaWUEY12SHexBqdPzE2SFkQv+egg?=
 =?us-ascii?Q?bOpomGdynG7otFSyNcl161hVVqJC/A9GQ6TmsUPfoOQfn6LL1eULWt9MkgIm?=
 =?us-ascii?Q?ZqeqgsWjOKsrcM49MctCX6aTaODeIVVu1aLJkz1zMbXx0hgp7VGOivk7iwX8?=
 =?us-ascii?Q?oFt7Gh0wlMf3hqRbB4twsXkHOHLoKPBik5jXDMRu1p48GYbxuTMT8gCIh1YE?=
 =?us-ascii?Q?wJtyRxraaQN+NeE1ceD6ndqDthE6holVrqbWZolZFhjbovOkuot99nJbU49b?=
 =?us-ascii?Q?5Dgkx6+iAga33oWQ9itsLtz9BwHWgBTkSZSWYbns9EKsxh9SHAxciEtqB3B0?=
 =?us-ascii?Q?IE/lfeO8YBaeN9Kp1m5BAX0XWwX3mHDbbqMA/RWMPEEJE30hsC3rPvxHVh6o?=
 =?us-ascii?Q?UkztyaHOZwpjluW09P/Om7hCHVZeX0DuGJ5wh6TIG67cowTpHeyRqsR2ydnj?=
 =?us-ascii?Q?2etAqjSKC8DqcEXtUF4+slXg5Ocf/s6khU+pJOBXp44mhmZ4U3/HrHqOVgGt?=
 =?us-ascii?Q?LJEiGfnr6I0axoN6eX1AqvXIDEFoO8xw1FTjDFhikC14fjRK8xNfkTS+83jX?=
 =?us-ascii?Q?WYrJtiJQWH/bsNBUQsYBOl6VcSeiNIdHbDgQv2RVs41UUuNnQ5iVm0aNC81A?=
 =?us-ascii?Q?RkR8HUmyjhnOOfZfMo1ABpgV4AfAmoP5+fwPzGqs0zo6NhIC+rcDHi7cJGo3?=
 =?us-ascii?Q?XsOs6a6R+5U/1DEmnmiqOvGMC1kVZwNg1qzK2o59KRkG/mWMMxFNKSu1fuM9?=
 =?us-ascii?Q?Fi6IOUfWUw/pK10Gk8ILNO2TA3Wn85dbQCAS5Ff5qZQ6nAYbY23dP+jYOU1k?=
 =?us-ascii?Q?KzYF8TniDEqTR1amm03/ZClImTdvB6Pf/6Y53DuZ4aMgjvNLxWnQzBUaP8kY?=
 =?us-ascii?Q?jzIAvsRARmadNYcT1aKo8pLUcfIZzqHSEmIyGr4Oom0RJwdjjnoDEMxmkrZ3?=
 =?us-ascii?Q?vpVv/325URIcS7wcX4l51vtmaZmjhreujbrvEqG2oGeNJyj4z85lP4Wu2m4Y?=
 =?us-ascii?Q?hF8LaP/q/lx0CT6eBwK6fV0bQhinergg+EK7ZoMWOhhlw6PG+Z8ClQcQZ1jW?=
 =?us-ascii?Q?e/19LYT9045lIuwGgjMxa+IcQTkhqouoVYhHHHNkFezJC4elhlYB212d3NOx?=
 =?us-ascii?Q?AvUktoTEUMf5USuBA1Tpt/3/Cl0cwVs4g95rcJuSwbaOUKOSop4y1SE3xNh2?=
 =?us-ascii?Q?d6gGirDz32ordLMbdTDhGKndy38l+U/OFjDcTtV+MIvgTD4mpGFkcLekg03A?=
 =?us-ascii?Q?DGqCsA7edlKU4bTM+YQAR32ZzgXyjTkGql8c6IBmK8Mzw95aRpTmzJuxoAJR?=
 =?us-ascii?Q?QRAq1F92RWBOpB1a/gGWS4cpazfDW8a5Qv6hpkVvjbVuJS8R7hrqtT2uiXQc?=
 =?us-ascii?Q?cwxpfRnhESPnQCe/+D71XNwEgxNy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a8c921-4590-4964-9d8a-08de7f1874d6
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:46:55.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0031

On Tue, Mar 10, 2026 at 07:08:52AM -0700, Karthik Nayak wrote:
> 
> [snip]
> 
> I'm not sure if AUTOCORRECT_HINTONLY is any better than
> AUTOCORRECT_SHOW. The latter indicates that we show the user something.
> Doesn't the former also mean the same?

You are right, it indicates that we show the user something.  But show
what?  A prompt can also contain a message that acts as a "show", and I
was quite confused when I first saw this part.  On the other hand,
HINTONLY has a clear intent, which is "hint".

> If we do decide to go forward with AUTOCORRECT_HINTONLY, can we rename
> it to AUTOCORRECT_HINT_ONLY? It's easier to read that way.

AUTOCORRECT_HINT_ONLY breaks the current naming pattern of the mode
enum.  Maybe we can use "AUTOCORRECT_HINT", as the "only" intent is
clear with other enum items.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
