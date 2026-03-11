Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012065.outbound.protection.outlook.com [52.103.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE413FEE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194749; cv=fail; b=XE1raqDIs/xcQptbASoBMsOklqR568RZ9r+wK/gR2JN2yEMqH0bspN6UBSHw+RaXyviUsV9dwJO3A4JQauWWUrxf4mQq4sOCAmMV49E11qBTcXwzMt+RZP6xyN0OHLfhMhMIgVV/bPT9sEVyFKmo/2jLFpZj5pqdr5D2RNQIxGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194749; c=relaxed/simple;
	bh=Tw/ubbVhzdOkGnixtJM1QjL+DJs2gp5mAWnyClnT/XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Usqk3M6E64EeQvfv1YLbk93gZLnuFUlnQdliHl6ch0yDvnBEMBwChdo015poJllt7FFIRIgPbv2rYW3Df/q8Yb4OngfN2/PyZjFgM3bbKhCe1DbZYIyRk2dafDliSd600YTqj+iwWhhfwM6SAObxCIyIoIhtRmBpe8//ualzEnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oLII0Wh0; arc=fail smtp.client-ip=52.103.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oLII0Wh0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbZDlezcUAF/LYkIRrGCArtBqeVAQzMU3wPrpOhNkYQql+XCiv1OhCqXV7xPik/bAmxzVYeBeM/+qJsscvBg7ifcTxhFsaEuDVN8ZLkTlap+xSoiRJ7XA1ar40lcW9Eie3lzy+zQnMTNUbh/YlHU+ABkeIWrceU6Xj3DFrNn/zNyZn7CsjV0P6OqpfjhYYfAQaeQ9AnHpgciCKBpwrJPZ8WHfzSC2MFxAndV743jVEUVNThxOtKpzbqRgg1nOKowNSJcRP7XzJ6H0qIRWgpbMfn3hckpBjieyz0bbZ9D00+MFNkpSGQTcMnRWbD56gF0TR0bqW10uxl+cuy7hbGJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcqFsGHibRUtE1fDz0mIvZ3pZ91hX+ECWnEAhXQX2Lk=;
 b=FO3iF1n9NBYMZgn4syy3vNzNagwciJWHcEjkb/qU4GslIKnfkX9/n05a/YrpCrnQwehy2H6s/gEHrW58vjXSdizjCYEo7GRMlgfZP5q0cy0GikGl6HR9R3yLqDXX9aQorB1GbBLbJLdl1EDbMZJO01rToXe5o+2cOWtgy/HDF14nevCz04+N31ZVR4f9+SzVG/2sHpHFDAMP/5tDJwLHSllLnoYpWjTpzlRqZngG3i82GFl1LwaAElpZPc+vs3YJiWqAidWaAbBF9/aOKxebDvNPWPUSRB3lOYt3DfTazkwXn6CDIKZU3xtSYV8Y3jToEOEjO1yznvjCpzE6CfAn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcqFsGHibRUtE1fDz0mIvZ3pZ91hX+ECWnEAhXQX2Lk=;
 b=oLII0Wh0U7nvIpkqjNIRHiPoowDYe1JLl0rAyDKKHTlIH6W/4edmVOtnnqOl4iiTmUSLsdYyfi4g8POxvyg+dgG5kpx3ppRRc7wYBzndeYlIiozSv7XIOdAgiD3v0n3KFWGN/THSVxy0/2Z7AwHZ41jsOrY/FwrvDQOGFobZGVLu9AsrowgaFFJdJ5Jf4yUCjywib5md78ynagDIrxzVCPywM437QrrWGBYgYKh0qqRAwyfeoR0NbBz14R+It5qQxVjjOH8O03+mB9of1kUzJIZua9Wmjna7M8fkygOlmCgt7o6u5scZ+ZVAg0L4gKIiX0SdWRNN41XoceFOALMVpg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB0717.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 02:05:45 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:05:45 +0000
Date: Wed, 11 Mar 2026 11:05:41 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/8] help: make autocorrect handling reusable
Message-ID:
 <SY0P300MB0801952EB445C6B196EEEFEFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08017404C417D02058423130CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZQypadiSnU1hqHBUzzayGvvvv0z-X+-vNJRFgREmdB+qg@mail.gmail.com>
 <xmqqcy1btpht.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy1btpht.fsf@gitster.g>
X-ClientProxiedBy: TYCP286CA0234.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abDN9Rn__utCCXU3@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB0717:EE_
X-MS-Office365-Filtering-Correlation-Id: c732c010-6666-45bf-cb48-08de7f12b489
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799012|51005399006|23021999003|25031999004|8060799015|15080799012|461199028|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/utFcpxEDcevcpVRRo+2xfFf315OgIt8mo9sOqKP6KZ6rQgn8Id7rq71I5tz?=
 =?us-ascii?Q?7Gt/QysyM4kUOGjcDS5DwOtAabU+wmKqWpNv2jmhciZn87p/MA0Sq/WW6I0f?=
 =?us-ascii?Q?xTqPd/7vZ5d6UKGDExhmfHRS2tWYlZCPxNEv087jcGX9voONcKSnU6tjkn/B?=
 =?us-ascii?Q?MDRadL/0sz9jdUfnsoyqvflAW4qBr8Y7cGCxQkK4SuJGWWCByJAoMbN0xGHm?=
 =?us-ascii?Q?NyLIeB/l5s1jcSwjL9QDtY2ULOrgsslsQ4nYC+zJoQbJq7qYAeOT5FJd8K7o?=
 =?us-ascii?Q?7j/InmDKIZFJnsZZ8kURjiis+o35/9CxfypOqNQnYzAPo8bzocuZMja15U9P?=
 =?us-ascii?Q?T5vr2V9msQSkPoCzAcIZ4dmvJg4tB3penTa06oZBAoK6Xx5J7OC+Os6tp6nY?=
 =?us-ascii?Q?+URv7o9AhAf60xPDFN0Wp45P8Xb4uBd0ePdfG5Ia15ZZFvI+3mPeZVi12AIj?=
 =?us-ascii?Q?oct1+GVZqMem9S3+1SjHF9TrSnOxGuNbJWemdL9VZfxAIKpIQiIl+068ONfn?=
 =?us-ascii?Q?CkVvSOnV0aZ3o6z6v9IXzN+oftAO6HKWGI2peoQgLS5aai0deC6I4/MscbTZ?=
 =?us-ascii?Q?2tJF2uQum9+hpsFyo4FaQk14SZsIxyWVy7SKkQ7auGcCaemplvzrVJVWRZHN?=
 =?us-ascii?Q?U3Elc3VeCcviwldlRkQlxemJc97djfW3rAEoPIy0+qVitH2ooGywWyJDOpeL?=
 =?us-ascii?Q?GZcE2HpZHVngN3StEQurJGEsqeaxTey5OyLZMXyZqF27wpyaKBC22kaz2dLB?=
 =?us-ascii?Q?mpi0Kdxp8KVblwm8nG0P2aZME+h4xmPCu+zBk4PSf9osswmxj2X8YIfK4KNA?=
 =?us-ascii?Q?aWn2qlD0Ca5Opr/1Pn/ovFSSvm5WDckgAu2VLEfYF9mnIis2D8pyHxHIEabj?=
 =?us-ascii?Q?BztTSoQT8ER1r0PbBuLrLM8ov8Sqd0+dbMQO1Ds5k+47QmFvDyP4OCWuGovs?=
 =?us-ascii?Q?5P52zDP0+RigDuQIOQPu7w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?39/cKGERtoB/rO9HOSqVicT74LWvtkcUXewqzpTYvbvyn2sichKSKvWBuzWg?=
 =?us-ascii?Q?zJgaATCXVJjzfgENftWYoSK9FIeMSTNcEfUGJltk/rOXvLh1lPKrtSMou/Pe?=
 =?us-ascii?Q?07rlN/8I4Iny8nQ4t76LyhmSzviQq1rASNyNdACw/jrpPAIJrl7k7JHCOOey?=
 =?us-ascii?Q?NdoP0mG9cRlCopjWxBLXDZb0nZHfG8WXc3LVew/dwe358f71kSpZpFLybrtk?=
 =?us-ascii?Q?XWK6gl/dIBnMNCNuva9OGOGu6AMH0y/tPJ3uiTroeMSe22p8UpobUBMa5MAS?=
 =?us-ascii?Q?cVDnpLFqyALvG36YEKI3GBAdPPXH2Wu4M2Dv+WBRu0maxmEAHP5qEj3Emhxj?=
 =?us-ascii?Q?uXls0IYbFcS0dBfXAz0Vd0MCwhcv10TnqSgg0ZSoChULEB/byzr/S15Kg7nK?=
 =?us-ascii?Q?6iF2k5regp6caxow3Yenl6YFwMxHk3PIuawWuHvgXfrhyTB3AiQ77QwAp6Bg?=
 =?us-ascii?Q?nJaoyIvTTj6cYMS6WTjknZ86lxCiYKJv8EkFdK8XurjovlDRX93ag6ZEZoKA?=
 =?us-ascii?Q?mV8CktXMcD+FilLqlwyt0rL43FeWYOh7ZC3GM/yN/Ih0OCwbGQ6RjVyxBZLP?=
 =?us-ascii?Q?5BkbE3OwueWu7eWkC3iLaVWdpP9LFvoy3CAppr+S8XOKOp03x3O/Q+s9Kuq6?=
 =?us-ascii?Q?2VEINBRND46maGBYyhh/WWtePK0nP7xrBKbFLF/vp5UDlncTQO8Z4XR4Tp8r?=
 =?us-ascii?Q?TeiWhniJxGieL1z0LoEwfAFdJtiOVdPUy/jE9Xjt/hIWfWOXZZIypV6K2CJK?=
 =?us-ascii?Q?Fn8MNYbbxbH9fvI/faSghzkiS0sn98ARvU5bSYanz0W4zjfcP1alNKnHX7S5?=
 =?us-ascii?Q?wZJrKIhxNunbVSxvOQkxvTNL/XriKtv3Fydol9osYHa3KBYVS+JWV6dPe3Qy?=
 =?us-ascii?Q?ZEnfw1V2UZki1AYovGPcIosneSShwOaRxlk+IKX5+3hrmHt6+xphGzLyS+RB?=
 =?us-ascii?Q?3YZZOHCfoB/Uc5YZMo5+yNaIhUoB5SUGehDgJ21Togouq10NvwjXVONkhcBx?=
 =?us-ascii?Q?IjUJVufsAJ1+YcDGZgR0FD7Nu5tXh/CPRWCsM3idji8Hl91TpRfTfmkhpXtz?=
 =?us-ascii?Q?vAOT2P1BKvZPh2E0k0Qg3XskXcHFwaPW0c2GZAhrBHRRyUDap8q3ZUBzXjm2?=
 =?us-ascii?Q?zc9HrwbTIE3s5rwsRw+/FqTSVqNZY3v2XB6ZKm33IBlCO5Ac2JLULkhO3X/G?=
 =?us-ascii?Q?2P/kk91vcLk0o/mp92KWdMDI66WIKWqMppu64bop56ykP9QItpMK2d5/mCQp?=
 =?us-ascii?Q?knRekwJ8uT6EChhazmTCxUiNgm5q0syQb7DJ7xk1qAQdyaj9cx274KDL1LGG?=
 =?us-ascii?Q?69Q85N+IlE6VM+P3Ae4Ht7z7EibOZ9WFNRSYCeMH/Okb8G6RFoeMjEXLEgh5?=
 =?us-ascii?Q?6QKtXH6POgzM3TmD9u+erTesAMIj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c732c010-6666-45bf-cb48-08de7f12b489
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:05:45.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0717

On Tue, Mar 10, 2026 at 01:10:22PM -0700, Junio C Hamano wrote:
> > Why not use s/autocorr/autocorrect/ ? Also would be nice to add some
> > documentation about each of the functions here.
> 
> Good.

Used autocorr just because it's shorter than autocorrect. Will rename it
and add docs in v4.

> > Also got this from running `git-clang-format` on this commit. Generally
> > applying changes while moving code makes it harder to review. But here
> > the changes are small enough that we could get away with it. I'll leave
> > it to you.
> 
> No, you cannot leave it to the author.  
> 
> Leave it to CodingGuidelines; case and switch would start at the
> same column.

Was just copy-pasted as-is. Will fix.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
