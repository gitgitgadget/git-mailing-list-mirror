Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010021.outbound.protection.outlook.com [52.103.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0B2D2382
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717721; cv=fail; b=n61YQakVeUMHIVxJskn2Ekl/p/3TUpZv2CyRxv2UXFD9qJS7/0JViWdqgOjCr/WIwdXuXvFZxi6YZ3P9j63pEtKT15N7IXi+mipzMJWa4YfkSCG8kALWgrabAjaBYLshZ9yjyq4MdPMcoMlaaC0A/RN5XApwdEEVzMpZEuaSTHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717721; c=relaxed/simple;
	bh=6JuQIdpFRvbmqu4hf3AU0XMY+eoyxr3hFeFDa2N0ZSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PJPDvsthJK9oFJhZty3zQwZDaRgOl0dkOQS9RHVhftqh/pl57lzzYGhRFD7TqQIzN2ZmRt2pN3zWHeBsYtKHxwvv/JUyf9Vx2ocfl9kRqqP2aNazFoaZwIQJYjPFYmlP8/cRGEJwXblkW51d7yM+Pg8K1XWV9jX8poUvwirH5JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QyiePq4E; arc=fail smtp.client-ip=52.103.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QyiePq4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBO7JVLR6ljnupSp9EiNmXyeIIWvzoymmtQGITkDJaz1UbuyLb6d5u/4YbQ2cRhgmJ6cpp5NI3JE4d2G9cf1L0ojR0JOVsUpPqyy+ZoclBNldD1XeQ6MEShuJ8hFowhdB+UdPj70neZJZUM8TznAAFQVmeQgbY25O+MwR5dOPQ6vTYz96gU3YrqPEdcx8dVmHN4875djowrOtuRL2CdU9VL0Xvjrq0r1hV2rmMyLc8AOp1Jeb8y96NTBBN+NEUUCyWcufPH8hIB9TMk214qZbnjE0s8PDOVf4ZRdLgWmRUJcJeSxi2/L9JGx7OFte0aC1liwR+OP/92TOEOpmgU1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7jfYlebV6T1z8KTAX4H2i0/0eRfFKWdQmwrjiNwMTM=;
 b=iPKCw9uFc2YpikoNWP3Cq/ljzyH7+mOXgDM5OvUkfBhsmZOrSeFTk9VSjAr5KnV7lB7uNcnUHv5SA4gl9GVvFKBDRWmD0qlmA/0htic4v9E8BEOzX9RgaMOFX88wQBUvAfhh5V+eGZIwr5ME+Fs1DYz9LoncWfihWujaUqDvYcRRD9c7kllI3IXy7JzSmyAA4kT2Zi5B63R4uQ1dBlvNSP8tbc+PvtswAQsgTqvxWcJUQoqaMvAUVchN8axcH7VkobZCpD9WMXAd6LR42/uKLydnnMxKmrlTB2zW1eX7evjRdm993smzNtdOy8YT50Q7xrNaqBd9PGvYHrhq5/8KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7jfYlebV6T1z8KTAX4H2i0/0eRfFKWdQmwrjiNwMTM=;
 b=QyiePq4ER12Tfj4NjVTZeNsYmmpsySiGOpktTC/5h4jxRKcnzxTub482RH/pqjvp4LiOvw4o+PgVWLBvpICvpueQq1BCJavkKCVnLSX0kdDS5/72zVH1aPsUy5UbZYv/NNGwEoijvSkepITL83x3cZ3rU9B4MNuuNgL8zY0ip5dLyrK1o/P+yQBarZ4B9MSDJM1xSAOGPmOCOab5FB5w+wOcunpCjQecu+tGLKtCJKg/9ZUdr6D0NsHFo2COqKTWnDocUxhc6A8XANFBV2p04s6Ru9h3S+4GlFQ/UNoi4DmoEo2nt2t8Krlwi7hGjNE3dS57I6ck8Sq2IXr3Y9zX1Q==
Received: from ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22f::18)
 by SY2PPF39C22CC0F.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::390) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 03:21:56 +0000
Received: from ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b874:b167:fc15:40ca]) by ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b874:b167:fc15:40ca%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 03:21:56 +0000
Date: Tue, 17 Mar 2026 12:21:42 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 07/10] parseopt: autocorrect mistyped subcommands
Message-ID:
 <ME0P300MB08117F31CDFE8D038C3E0557CE41A@ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqse9zo93p.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse9zo93p.fsf@gitster.g>
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22f::18)
X-Microsoft-Original-Message-ID: <abjIxls1eQRSTrpB@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0811:EE_|SY2PPF39C22CC0F:EE_
X-MS-Office365-Filtering-Correlation-Id: 177cc754-4349-45da-e81b-08de83d4576e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|15080799012|6090799003|461199028|5072599009|19110799012|8060799015|51005399006|23021999003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hugYXvz4d0663OifqXgZT5REuSX1QDFw2SKIgFjBC534Vl7fn5we0kZTLkkr?=
 =?us-ascii?Q?M0F8GdfLJi/PJy25nY3d+JUe2E3iuk/ABx0y6YoNN/N5F7EKxUKU/K4VfEjp?=
 =?us-ascii?Q?WcZQoTplNUgVs3/QUITupgg84+293G7Ya+Cdu1j0qUPoPiqixqBdYyMBycl+?=
 =?us-ascii?Q?eDGVeiu1J2199C63V/niycDZC3LNfmBWyboaNoqWUB4Yns+dAWqmSWPHrio9?=
 =?us-ascii?Q?NlC7x47ov1NdpKtEMKQ19VCuRsd/HBBdiCU13RG9cyPYV1ucwiRFTdMSEst9?=
 =?us-ascii?Q?LJtoyWlBKbzhkn0RjvEwY/JvE40veeYf/y/DI+PBOJY2lnIzfD1qB8dN/A/j?=
 =?us-ascii?Q?UTf854Ewq6GxqpQCyCXEAjw0olc6K5QbySHNxoP45GGeZkIF7jRoQsaJW8RO?=
 =?us-ascii?Q?nNb5ZpSTpEyoNFyRr9bdoq9ct6W029YQ48d8WpIuID1G6YSlEdtPNkT9FUCt?=
 =?us-ascii?Q?xyPcKFkmCXvgrFswZendSElNFnqFhF7pSzrFpUBj3x8UMfKdI0VAWpZUf8RF?=
 =?us-ascii?Q?xcj7TXBLjQCWjKOEy5sqlDhjLLN8sD/AqNUWmptkI712PBAgnXRMqar07g4p?=
 =?us-ascii?Q?g4hgMautyenH9c9+5yrAHOcCAGHZKZMK4ibbsYEqY6007NcwO6Y22uBuSySY?=
 =?us-ascii?Q?KCRDrB+4pS3jfpBilzLTZ4qEoG/kbwzXlRV2BqrsuvYvl2rsWFdXsR8xx1+J?=
 =?us-ascii?Q?vIUPqHBkrVgiLlMZMiknUucJzopOT3/X6/88Ny85CUK94/m4nghMJXdm11j1?=
 =?us-ascii?Q?kFEnOX9afSpM1l6wjSMdCLjZahw2P1lwrqXjL4Rn9lzXRmK8Gslo3kdrN6pC?=
 =?us-ascii?Q?bKWfIdN3K0vJsUFhPQLpJK+b+raKp6np05+RaLm8cbm+eLfmast/Bokx9spH?=
 =?us-ascii?Q?M/zFgCrGnEfZwggI6rPLaLKhP7o+fqsiGwsABFmXHKuwDTMi0wisYhysPvBJ?=
 =?us-ascii?Q?KkTGB5Phy4MUxPnfWWv8BA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFfsabwU9iRh22ClzsGXm/q7SHQ9HyiauBSml45x2PzGLJvjIqfzhvsBz/X/?=
 =?us-ascii?Q?9Jr68hyNezO2u94s1BXxPbHDvSlKQ8iIGkkJGYg1dHUXAnfMUCm4j4y+Q/hr?=
 =?us-ascii?Q?+Ka3AUK+ZE70vV3eHocPKGTNPfNYbjsU6evdrrY37yE3KJCV0QQR/LbEDrWT?=
 =?us-ascii?Q?yqxzF4E/e0H6yFozP4laKdsANrXPcsPcSsFzLwOkVXbc1dvumx6hFIMD/G7w?=
 =?us-ascii?Q?QIGBpi6GNXQryFmKpIbI62AB/I28+B3zmW+JHwA9gdd9OdyHiQF854+2KSFv?=
 =?us-ascii?Q?5gle2xiVBtm7FCBhEisBfNCOdlp6hKazjnP0DuSKDR2gWcz/jGPROK/8lA/I?=
 =?us-ascii?Q?NFdAS+mkadzO8YAbwDMRTfzYomfIxY/4ay4W72vW476GkhhTw0dTjHO/4BXH?=
 =?us-ascii?Q?TWRpST1HKNyLC7GYvoInJ6nM8uZZl1ij0MreTgUAczXYRhcUxNtIgIA2Rvex?=
 =?us-ascii?Q?KjI4BjHGZVRay4vGR/qS5xCriGBIA8BcOqT5N5NYq0UBQkA14Rd61b5TSl7I?=
 =?us-ascii?Q?dLWFYndsPuWYre1xt7hrQKzraOlPR3AAjXD2cPSxU378fOvvn6YRZgE5tFgy?=
 =?us-ascii?Q?4aJVz0sMROoS0FGVfEl94wdf4KBNJsfggzKqqHHs5IWtGNghtyPcvijNASqI?=
 =?us-ascii?Q?PZWWDGJYvbpdLwAdg8DznTQzel08FPQ96HqHXrUhETbPE18Twps34V0DpiK5?=
 =?us-ascii?Q?HYTNWWRcBlJzKFCaWwX3KlfD3oXFHRlizLKO9//gQQPV9thi6+bwlkwuIGgy?=
 =?us-ascii?Q?/E97WltDctV9aTVrTb02cGhd3Zx5kT5w/A4dH4BKaNaZFhxzecalnnOxtIpD?=
 =?us-ascii?Q?XPBWzl5uuRvqCfoIfuCbHCjfYTdiK+OXjjFBWBG1/ryT+FoMUuMge5MSlyy+?=
 =?us-ascii?Q?2N8SQDWVDsNBdYZO5KerEujorXisSAXwu7bcTs9kgwR1ok2hkP2MdKNd8dmp?=
 =?us-ascii?Q?oO4+5pHtZ70xOKRq2bzLWA1UsqlvTKr37Ov0ox5v/Vm0OgM6+R9EBaGoVgFq?=
 =?us-ascii?Q?af078JCKoawlHpf3kqJn5v2MH4UK7Op5AbeT+p8yfirqdYkPIc1vN+GzYtfr?=
 =?us-ascii?Q?hwHQVxKByeUyyDpHLbbZwcCH9aiFC2czq1qOfZxQ4/B7ZMNQCYtecSlSJ99g?=
 =?us-ascii?Q?2NUYlwEKV45tT3AA0ORpBlxIAasSLLfd4QKBmfnJ74kNegkY2dUgKFAunVXm?=
 =?us-ascii?Q?lRwn5GYhHoeC1bc6qkF0pqWRNgRpFrC5P9w5yW49NEcWdv3Uz3RuduoQgu8E?=
 =?us-ascii?Q?zTuon7uLgNmnfrs13lmc87bm9s70HYXRXAa8mA7fEmgw8Onr88DlSyuuey6U?=
 =?us-ascii?Q?FtjJwj4pgoe833ghFLRQUNb1GDsJPKsbsZrh6bzxE8M71bpy04SWoVOfN0pl?=
 =?us-ascii?Q?jATuE/scLWNV0NSov0/Vt6570vvI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177cc754-4349-45da-e81b-08de83d4576e
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:21:55.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF39C22CC0F

On Mon, Mar 16, 2026 at 12:41:30PM -0700, Junio C Hamano wrote:
> Is there a reason why this needs to differ from the settings for the
> typo detection/fixes for main commands?  Would the same reasoning
> apply to both, and if not why not?
> 
> I would have expected that we would just emulate what we already do
> to the main commands, and later with experience with the subcommand
> typo detection/fixes, would tweak the parameters either only to the
> subcommand part or to the both with justifications.

I initially wanted to emulate the existing behavior. However, I noticed
a huge difference in how prefix-matched commands are handled, which
affects the autocorrection behavior. And we can only use the same
parameters if we do the exact same thing on prefix match handling in
subcommand autocorrection.

I looked through the old mailing list. If I didn't miss anything, the
patch that introduced this behavior (e.g., not correcting "statu" to
"status") was only trying to fix a UX issue, where the suggestion output
didn't include prefix-matched commands. In that thread, they didn't
mention that this would also change the typo detection behavior, and no
one discussed this side effect. I treat it as an accident.

Because of this, I was confused about whether I should copy this
behavior. I chose not to.

However, if we want the main commands and subcommands to act the same, I
can do that and try to move the logic to autocorrect.c so both places
share the exact same typo detection.

Do you want me to do this?

> > +	/*
> > +	 * Builtin subcommands are small enough that printing them all via
> > +	 * usage_with_options() is sufficient. Therefore, AUTOCORRECT_HINT
> > +	 * acts like AUTOCORRECT_NEVER.
> > +	 */
> 
> Sorry, but I am a bit confused with this reference to "Builtin
> subcommands".  Are there subcommands that are not built-in?

No, that's just poor wording. Will fix it.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
