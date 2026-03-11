Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011027.outbound.protection.outlook.com [52.103.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D72517AF
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195381; cv=fail; b=EioX3O+WWhQounWKJ4bgT4+P+qa8G7BDjVy9wjwyZV6jqyeVjfLX5frUHLJHI5+QwmHtFXoCJQ3vzhOuqfB87xmhkYbXJmVPeDwf+17nBMOByoz5nSuApTEO8V7LLRh5iMnGMO4FLtYIvcNV9NA9jX/f7cFohHgFUflPWRR7GJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195381; c=relaxed/simple;
	bh=jJDYJQblITpEga6fHXWeY5Zp/lhwlBzKh3xYiZwvdQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0Z6DqHZx9mUZGgg/vKg4lUheqzsuo+CzPneLOl9s1Rm11tk8hF6/rO59VrG9VV0r+bTdPmB5jbG79M7mvyg9ssRXUmCoC3zgwkTxdtcggSTrvSigEBaYIPW8ompanLXCHnNbhWQkFx4D3m8D1zIieL2k44H8DoFFNdQUcgdkzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QIv4xs5/; arc=fail smtp.client-ip=52.103.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QIv4xs5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2R2l7zDyqnYy6KxJGGBAX5nerGMDnknKOEIKf4FdoiKpdmImhdTq7Au34kLfqmPmK5MQpRRlaLsEEJHb5aDznVkpjZLytTWipVQA7t5SIehfWr/n17srTJfg9avSjtRGHUkRYOIDMLwQnfm3Y8SSm1hctOJVBCL+CM28ib4MwPzHkhThjAMKy0sqOJI04Ea45wE4ZFMCaWQdVrnkHTWR46ha8fiwcXCUPHMkQvJ+ZfFl9oCAjEW8L/vZSl2DopKGpIsGmo+/LW+irLR9A5KnDo8muOTmd3y/Iad0+VhXLci1C/HpZ5Q/olGo4M6wJl8fst57JQZajFddZQOVTsehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U3DZ+X4a99yQH4hdnlo6ZBiqyMZ/4XZAyWksRcYvWo=;
 b=QxX2kmEX9AA7vcouJcyhZsWnfVo//dhJgzZRm2J15bmdtGSJlkZsFiuitwly5Ay4JteUM4nUAkBWGpFBy8jRnaMQsjqtGLnRJ+XeGHLJStjWtpKwV11f3w5dvUGsQIJlvrcJGhCmqeOIpBzBTEkK69USw47IwPlqCzIA/Kc6ebg8NjElqXu+WY9XTyH7PN2W+EWw/mw8p2B1ZDPv3lTwdSrK+1SQBeDRr6NoMGimAMm45L7ffA+4dSdesu+c6QnOF1i+SfvR/tRLsy/+UUTaSyfUJKWyp1jn1LL3uhXM0M5HfydhY8nr0yIdeyWeicT6+ZROyvuekdh3jKowObJp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U3DZ+X4a99yQH4hdnlo6ZBiqyMZ/4XZAyWksRcYvWo=;
 b=QIv4xs5/5rg3td4JYvoMkMdQOSn+YqU/I0tx5Us7fLN6QwsEK3mc2lykfW3HG0h5XX+gIc2KprhtWlRYGIJ25+/8bmWykoUN/AgHcN64J/C1nkzKeUswhZnMXRF2oLtmW8YT2GRi01qkhY5mdE4v3I+pI4rdeTdnhR8dMloxk6thlyuR/55TkSfJ8NYLd5bkUNHfx55lgMSj7Wu5szL7QKAGdw+VLIIBqfLWLuOh9WuwqQlaqdz5S5MRVBiI1ttilGqCmuaMwhE23M447GH3PJ1Nb5h9Gly6RcSvKDPzLDGOxLQftfzylVG0pSRBh0tbM21grYDY4/Na2C8/aKPSfQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by MEWP300MB0015.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:1fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 02:16:13 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:16:13 +0000
Date: Wed, 11 Mar 2026 11:16:09 +0900
From: Jiamu Sun <39@barroit.sh>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] help: move tty check for autocorrection to
 autocorrect.c
Message-ID:
 <SY0P300MB08013EBB2DC457AF040977D3CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801E98F538F5320E7B663F0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZS=2msGg5d-6-LgVD6XSduYze46iWcT2X_dJDd=6AOOkA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS=2msGg5d-6-LgVD6XSduYze46iWcT2X_dJDd=6AOOkA@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abDQaWZKqewDBn-L@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|MEWP300MB0015:EE_
X-MS-Office365-Filtering-Correlation-Id: 70317dc5-e87c-4bc1-7436-08de7f142b41
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|15080799012|23021999003|8060799015|6090799003|5072599009|461199028|25031999004|19110799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLdjpfCz1YFIznWAj5qu1Ihe5vBuP+RcY9Ik7yEkA0J/aVsMKrEK22ahbD8b?=
 =?us-ascii?Q?bPPO0D3EOp3d6FOoEiXtoUXkgidW9VEthZXLCipwma3Kt16klaP6HoH2RNSP?=
 =?us-ascii?Q?zetR4zohyYPQTrIoYSlt2u+qyAVilz58uZOkwuI+CVH5iW3q4PBXI8WldJyF?=
 =?us-ascii?Q?mbzDkFXx4xUZdPt9n69TGjpE4qYEU3bDZhGkFcUWGjb9NXWkup3VZ/8ldsEp?=
 =?us-ascii?Q?ObpuvHmjsKVs0mFRm/Hq2DhUBoMSP7+tdVBQdYVbK0nn1kOZneHUDTs91nlC?=
 =?us-ascii?Q?o36BQ4Ipr6mrU4ieF1vXuAoU3nWF4xHv0nrNM3cpIpiJhtxyGn+XZB/ttZOb?=
 =?us-ascii?Q?6ZZ+iQ/z9Pkua+Yfukrd13UuJH28G3Z6B28xwYltfvnEHpSOVF5Nwptm/4k6?=
 =?us-ascii?Q?PDPw3QiDsPw2tg7LhFxBgWbBdFLQyOcBbH/SRJwxK/beVPzMBPzcmhBzMKyS?=
 =?us-ascii?Q?ecxtU6CRX546CBL6BwzexWiHHL888uMU8qxAf0gYp6T9pEvlkS6TxkEw4Mea?=
 =?us-ascii?Q?NQDuhs+ufbaPudlHHRHDB4NvCFoapltSpKCQwxQE8mIwavdlKKP7+URwXTDn?=
 =?us-ascii?Q?whcfU3OBgoTbYdrhHPhgPUmwmdnvHje6oIZS6biDMvdoBXv6ybDUgaMclRza?=
 =?us-ascii?Q?0i25yMwnnacLrujFL/Tr9HEXR7feLHUbR8+UD0H+e28jSRvms+RdwdslIi08?=
 =?us-ascii?Q?14RWdZdceS1BHHIJzUKwsFbJLUxkkbDRmZC9vkFhZnKKaZDRRcU1Z4HWDWZm?=
 =?us-ascii?Q?wKM8dl/3Emn1tcLFuz6/j7IBzy+ph0CK09QGVAw5stayXDJtHacbb/Wc1OoJ?=
 =?us-ascii?Q?WpzfuDb1h7mqOkxop0htGQqQd/lPBvMS/mZ+DhPYaHq4qw12UroJAz+JTbT6?=
 =?us-ascii?Q?g+j2VBgiQykkTCmWZzdj8paw7J/I1UZynmEEACcFp96mqqe8vQwuWT8Obnwx?=
 =?us-ascii?Q?/Pf05b0opzfuLj48f+RM4A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/saQjsGMAJ0mReQWD0WY0NwsAlZrew2x4jZQrL5JXn1UBoOoL4He4yLpslu?=
 =?us-ascii?Q?oLFo9E9EiwVhlUFkU3veiVfefpsyCsqyF/2CXj95p1Y+NN98eOpZUzjrsWk5?=
 =?us-ascii?Q?LRwu8DON1pAudpz3r9LrIBk7liA+CrPCF0YTy1lH0A8JywR0QHvRQzWKMEKG?=
 =?us-ascii?Q?Wgriz/sTjkHy3M3SJ0WxPpKao183dodmubclZVtgMVnfO0TtHRq0sqe9ZGHy?=
 =?us-ascii?Q?WagstLn6cEgTKdjVmI+cPOWpc6E7lGh9tEM4a4FQ66AVHz6Gcz/uLlwlx1e4?=
 =?us-ascii?Q?km9dTXN7jCM8iTwj43ou5MwWQOu2e14kRUua8/mSiA3sC5qywGlI9LoMwEfK?=
 =?us-ascii?Q?X5p0ad75T5V6s6/mq9tvEo85qEJ7PBgORWuBOZbeQP4yj2+sMU9luYI0auMb?=
 =?us-ascii?Q?3FhO6zY9AMLFLzCsP/q37Y9aViQ0tO7BWHdzO7BvQtwPcqcYXWlV93KP364m?=
 =?us-ascii?Q?xcd1YEQCCWXse+eQZBjX/AL38+vbBbi0iECkwyBTF1ZcZ3e6rxyfLAbPvk+/?=
 =?us-ascii?Q?OldhjQf/Kto/8pYzMazbqIUeJHTb+Agmfj2XeondiF+pqIdrwmRgdVaooZRa?=
 =?us-ascii?Q?+OmlEH/5xHKtJzuBrvoJ0GuzEy6WdNQ3k+BmMIkSkP4HyqQlYrJ23O6/FknZ?=
 =?us-ascii?Q?xpb+X4G3j71JRx59vX5wiiuCZnCYkrR2TtgdcNWrLruR7qn2k7j4s83WjyxE?=
 =?us-ascii?Q?nTaSDInroAs7T96gvcpy5fHP/GyA8ptVKjAz6bhNU5kksaEK8ApUgn14NndU?=
 =?us-ascii?Q?FSIuc7zbuvZdpNmszHYGnCwqUuEIx3Af/ja6eC8Gv8XJDwYepRXyiXjX0arw?=
 =?us-ascii?Q?/+4jGmUmG6rSQX5cOMB1kSFI+W6ZklfMCAvaPALc0+5U8svb05Y6Ee+Udhso?=
 =?us-ascii?Q?bIpvQJmYZczOCHy1IPW4owN3+ZZl18CBuCYa+wNjLet9yjZbPa/qdablz9p4?=
 =?us-ascii?Q?+R4nDI68FUqTFrOcC/PNGEh4yikcnpjUVIONgL5nnYgxJumWqulQ5FcppMy9?=
 =?us-ascii?Q?425JGlpHMxN2fJGRyhyogUwWo/EF6q0SFATSas2DTGQQATlf95tXQ0uxKneR?=
 =?us-ascii?Q?RRFHVM0+F0aDN2Ifj40XgUM33fhM4Wg483XNBKEanmSqd0wjBb3DWEU49duO?=
 =?us-ascii?Q?Qlg0vpaC9QczNPopocjH0wekhYnysgtRpEZui7+v5pyAILBoMC2v5tUZ/bcc?=
 =?us-ascii?Q?7wUfxnsCmpsZPJWx10/THwzlKDXmH1Dr0t/dQRLa541939DLt0oD6jGghU5g?=
 =?us-ascii?Q?2tlosZoOZHU0HxEylAX4gxXtiaOWMFmDnF6Y5efP38WqFu9M7lIGWsLt2yHu?=
 =?us-ascii?Q?2cSkBQgZNZGtehBTv55p5t82hsSBCbJAQQhqXW3C95w8X1fAu0nO0CvSYLBc?=
 =?us-ascii?Q?yQhlyskIveE/6YbJoqGWc1dQWU8K?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70317dc5-e87c-4bc1-7436-08de7f142b41
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:16:13.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWP300MB0015

On Tue, Mar 10, 2026 at 07:06:17AM -0700, Karthik Nayak wrote:
> > +struct autocorr {
> > +	enum autocorr_mode mode;
> > +	int delay;
> > +};
> > +
> 
> I would say the naming doesn't indicate what it is used for. How about
> 'autocorrect_config'?

Using autocorrect_config is best for semantics. The only problem is that
it's too long.  Since currently, this struct contains all fields needed
by our autocorrect_*, using "autocorrect" to describe it is enough,
perhaps?

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
