Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010006.outbound.protection.outlook.com [52.103.73.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4914352C2B
	for <git@vger.kernel.org>; Fri, 15 May 2026 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855677; cv=fail; b=jkaoWNy57W0g1+8+1NGuVZc9tkfroXu0CfSfdLli3OIjukR21xAPep7rBqv6rFFUFBSKTb28Zo/PfSut1ct9PmfHmOEoySDwZ/48bbsmieGvwbmrpBYPEjkdo094mc3H8GcCbIhYW5fp8UC3m8mhmE1mCB8UDvaKNBN3TAhHBa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855677; c=relaxed/simple;
	bh=bay8lynx3qnCoHIKKi1dd8IX3bk+c+GoDk8nMhN5k7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gw5ZjgrUJyo0LTq18faMcOi/HsPo4omR7SDBofamVZM8Ustj0kyrAOYpM4IbBWxhNhvNQkQQBkUPa/HEhq6ToOD/m+0uXrWS+2/TXgmeCgLbLKFImho+MF8o60etGXtPVDryuV8VgCBdBmmXdbp1NEBVnUFrKvbk8TKIgTtwMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f+lntRDd; arc=fail smtp.client-ip=52.103.73.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f+lntRDd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9QuMr1GD06i1uoTis6vbbAghMsiAG/tn+TbX573GejwjuMIsT64Je5JdhiBgjxBkTw5Z5y8pFC3d/6+3obty/mYMERjMtLbHzT0U+xsw3CHm/JlJ6TipKV4/oIfq17YX+WkjE2kQwop/tMQ+hWJr3t7SAgZhtXkCeFF49hisI0RSrY1tUDiXFUcQwZeaqHKwT5Xl89AvOKMosLd/OP11Iily66OOas/w0Ebs1Ca6uIFZBPO9LrTjgB8SMaN8knuwMmkfETzhZ9TEDmCHHMXLqPo53+vM1My7ZXhwU6qiyeUX6QksYjSkz6ldx8Yad2wCOqoL9eGmg6eCbuR43ntBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNNjnOOtxo5RRFIo/EwRQzc6WCTlqgaG30nnDVS8lrw=;
 b=O50n2sCtX+UrOQd8jdzYjYAR+eJ+4mpTPzlduIO8GHFI8EcTFo2i9F0K3ePQ9lOb3/vibSiOap7P8no1HqBnwdIf7kv5ABhynr1aL/VR5m5fkKmwMtiIQ8GilDKMZ9Xb69j6s81bQCrIOBEFvK000W4RLRewplbEZnonS87G+nD6Z/DoM1ylW+pjHa7Y700cBHING/fF7hTdu4ZwrVlGcECfKbbi4z2oBriFfJ3BIy6lUIX5kz3bS2IpoPfVtKau7klmX+tn3DuSZpyYvtt27LenyHbwpVlmbzTzRdjDowH3TKtDtJa1b3SCvLcX2NFkxMDssRKi1ms6EKClu30CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNNjnOOtxo5RRFIo/EwRQzc6WCTlqgaG30nnDVS8lrw=;
 b=f+lntRDdQ4tnd48fj7qfTT0lilw9PkBe63tf/ezGo4Wu7lwxrXgQp+KMh6j2FIR3eCvQSBujTu5UnMipny99slTeZgJ0cEOSZzaU455+oXnOy5ti1Alrw32EypZdjUogsqVn//moV+IQza1l96WRHqIgmQOlMzLu4kv0vYUsVLxvMXflazBbgJvDiwk/GvOP7Yn3cTn/TyY9C9NJE1wJlGTPvv88qCpFQG6kpjE0BBdxqqVysFUEXD4yUlQA73briiNJ0HceinmmiBM2Pz2vlgBCaQlieRuxKido5gTIUp5dVwjC4ELT9YpBOzWjhJcncww+b1Z3wJAI9VoHO1+OQw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0312.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 14:34:29 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 14:34:29 +0000
Date: Fri, 15 May 2026 23:34:22 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/10] parseopt: add subcommand autocorrection
Message-ID:
 <SY0P300MB0801E50FCB7EB2F45CD15208CE042@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqcxz2tzpr.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxz2tzpr.fsf@gitster.g>
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <agcu7pNLOlitO2Mo@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0312:EE_
X-MS-Office365-Filtering-Correlation-Id: f73e5b4c-64d4-487a-30db-08deb28f1242
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|19110799012|15080799012|23021999003|24021099003|55001999006|25031999004|6090799003|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCu4pG7mFyFJlhEZRu0HpFYGgtHY2lWyGHIyRN6UkTc7WbpDtlRLLSX412fZ?=
 =?us-ascii?Q?QDY/0KI/b18ag1eGabEhajVsH1KbArdlQyI73xw22+lIml8BJN+1oYTnNoDl?=
 =?us-ascii?Q?Hwvkyk5kL+xMJqZWiseFkjaPqDFS0cf0SLBpjyC3tx0Cw0ZPP9c4XLBg4lZU?=
 =?us-ascii?Q?FTgrLVlFu//SQ5Gy7sKsLMYf/pIw+FPfAIZXIfmDdIvul1EqJ1eZ2yEtYGJ9?=
 =?us-ascii?Q?bluTA7eph4+7Od/KBRgIVlOuVppGfbjzsN8wQywbvKAb4vYJfraIp7piK4Xc?=
 =?us-ascii?Q?GhI2pUgU/L8QiXKJs8TpZj+nhghBfkBjmBRVAwaZm4/BjmiL7gQlHWOJLHKp?=
 =?us-ascii?Q?EMiXrdK6YYq7eCWIZmVNwqySxLBr4QTIkLWjjW8HCu3ihYn/1GUR23r4yrQ8?=
 =?us-ascii?Q?BFU5JMirOE0JYnBefBqlfdZTIyBg6NuUeun+14pk9of5a4mSmaqElKApHtCH?=
 =?us-ascii?Q?WaId8z1k3nNBPf+UK7tNQCqD93QaLVf6aZ3PZX75Eo/c/a2IEs4y/kv7VLeF?=
 =?us-ascii?Q?9fWaiEttSUKA1luKjCyZDzBeFeOnkPhxsKhhepiH3EliSN0BGuhvK9oRd5l0?=
 =?us-ascii?Q?v5bvsCrOV5mesw9UvMU+fsFV/Spxbv+TY/HBUU+298ehHioL8cH3n+bNttJP?=
 =?us-ascii?Q?uCS+euwIT5DcEJT/VMfLIjNPhNMEPh+9KiH2mxLl6pHGzCc0Ovm8MfHJU8Nc?=
 =?us-ascii?Q?VjS7SMZWKkoCFJ39zm0n/cOqNQWW5LKpSPFiwrYUjqLj5mEEdwoj2A8fGGhT?=
 =?us-ascii?Q?N5vEtwrHiQ7fVjJdnTPl5wi5g+msF3lp8+rBGBK1oxF/6DH1wADUDKmAg981?=
 =?us-ascii?Q?0YXdT7wIm+/BznGJ97pBOlE3HLtmRhTKYQNB/F9UgPW9t59zW3MQ/hRZWFXb?=
 =?us-ascii?Q?6STLvphpp54IRmzYUZKuPdYvjq0N5cDZhggTnVYSb4nPb6A4n+MbebV8cuLM?=
 =?us-ascii?Q?Xi2d0KP4YM1epfCgMeqY594fPc4X4oHNbUcfp50Ikb1nCS4W8RJXhdluHhJb?=
 =?us-ascii?Q?7aOjqHyXt/Cf+kCU1l6Sb7Bkr9TdCWowtmMNBSYi/CoA3gU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsk2EgWcACZVYGVcx0DyAbgdx+y3RVoCgi1ub4ZkRiL32pmX8KDuz3c1iHVI?=
 =?us-ascii?Q?mZg3SFOLyIrAQO2/FG3V/4tYYjX7LvrkupJYXybgdSGn1wFQg/lCB/YeanA7?=
 =?us-ascii?Q?+frS+ObWyJLB0o2o4sYbi2UyJ6f4k/+TPrzBP7tmyRsc1uC+k6qBXr7z3EXR?=
 =?us-ascii?Q?w1LEqM1oXu9bOAO+AhwIimhUqKdlmcVjzzaBUNIxxxguDNdJ0Mj2s+mgjEbo?=
 =?us-ascii?Q?GKUIQUfjUpa/uBPKJlKnTwq9g7nxWAcJEetlpBLmtb/UUcs4DF8p5ciRv7h2?=
 =?us-ascii?Q?93yqK6iJPIfXScScuqMxkoRuOlmBJar/DVF/dWNalN+dr7I4U/QzaogeHJCv?=
 =?us-ascii?Q?lCk7LffWWy4h3zjO3/xO6knmqUUSKfU7t3o5N0sJy91baltetwbwDSkNs/OS?=
 =?us-ascii?Q?KToqve+SvVoS/lJd/s1RD7CxBaV5uMCA+vePVZFLT6tLW/Pcg99n04v5xti8?=
 =?us-ascii?Q?DLQxdW8BskqFAjGBw7jdexsyNN+afFP7J45+ieTTbhskfF+uFeSJBXpAk4fD?=
 =?us-ascii?Q?VE/w/fcXm8yHe+FldJRGwkNGYP4eDh61wyRTVZfIeedgNIJFddUjNkBImr1n?=
 =?us-ascii?Q?Gprc9jJCzGP1uyR/MmnHIf6padB5QqKjBsNXdZHfIK6lb+hPhoEaZycm8ubo?=
 =?us-ascii?Q?U7tXKVgTMpKg0p6ADeH9S4DsC+5yLMndgGbTIcfhuaNWPyTRrajNrJDrC8YC?=
 =?us-ascii?Q?SZBoGoTsvRTk1JaHgZoAJ0jVL7FMn6HNvDOUBctRO2WNLOgENBjdWoJPIC6j?=
 =?us-ascii?Q?dVNqjeu+x7ON5o0qrx9uJxpTQt10n4oV2BLAjERqaqAvHEEqrR4elPm+hwhW?=
 =?us-ascii?Q?Z0o/pOxLvv3P8e96FPDQqEen/6PQp37KvB96DP5xpzg4oUOZ39rWxtXtvWfU?=
 =?us-ascii?Q?80DobAwsp2uVQNzQbPi47RhlHhLVWWPHrS9MN00rmrdXfY/vG0wvVBmS8BXx?=
 =?us-ascii?Q?B7S7haJboEaxVvZtWNDSZ8Bv7M3Xy/P7i7a1HzrAiY2rYEVc8hsQehPn3AZH?=
 =?us-ascii?Q?WvDllEMkdTZbAFnA51yG26dsiHyc4bM7HJ4J7403F5F3dMgYOMmtWXnZCA4W?=
 =?us-ascii?Q?7noEATgVFhWobvbNtH2eFvkXviFxNKl/qVRfqJuhONRKHEAJsLslVGEYS6EK?=
 =?us-ascii?Q?5ZGvEKTdi3HFQ/eskQGvgfmrzKk0yeRCBOaCf/GLnWklFprgFKFHbXbKPY1y?=
 =?us-ascii?Q?4eciLmekG7hbmAKcB84oh8k1gIFmxO3npS/bQ3VrJ61tFF3NQrx94NOPN9vC?=
 =?us-ascii?Q?18Ir37Rm85uD/ZdXWXm9HlRktoNguN5l4A+8omsmKa7UzJFm4Zm8sPndWdJ8?=
 =?us-ascii?Q?/VenK0blJgDFmX20zP5jq9ZukTBOXeoaohKgyLuGIh23w5miDb/TbHhV63i1?=
 =?us-ascii?Q?+ihCXxkycxNTVm9W+TpWBHjRhn1yiiz3/Lqneit82L/QVNZuviKYiveJ019O?=
 =?us-ascii?Q?uPfihHPCJlnmYSPG0NEELS/mpxEo299G?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e5b4c-64d4-487a-30db-08deb28f1242
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 14:34:29.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0312

On Mon, May 11, 2026 at 12:03:12PM +0900, Junio C Hamano wrote:
> I've been carrying the following fix on top of these series since
> Apr 23 when the topic was merged to 'seen'.  Can you fix these up at
> the source, so that we can move forward with this topic?
> 
> Thanks.

Sorry for the delay. This email didn't reach my inbox.

By the time I saw this fix, I had already sent v6. Should I resend v6
with this fix squashed in, or bump to v7?

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
