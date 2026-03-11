Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010016.outbound.protection.outlook.com [52.103.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41B35A38D
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209536; cv=fail; b=VrnrY5gKNXxUQ9rhkO8MGNEzhgxAUFzrW7Ga6o8Y7/pxVMWcE5eBgvI1LFa2g8TjGiM4Mp/9+5fzknzEwxmP6ctgG9wbzDha51hgrFGdJAfBMa35810eYEGcmvdEopZjTjxMbnbVM40UoWFG+CoEM2JQZsr3Aqrsu9QldRLAgrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209536; c=relaxed/simple;
	bh=GwnXwIDWDLOjjlaJQZ2qqioOaIpmc1fUnr99LCVT/pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DpaTZTxu3OwbXkatzO1Z4v0HNAQ1KzWX1dmAt5kxoxAWhZcjtq2yjJYAp9HrBcPWBzv37GVy0J/X0vbWX1S9yUk55OfjPVh93LPcTJ/bImdvMlSHgrXgGfecMMVT+fa5xZIevxX4Ki/ig52vZLhurpvQTc9LpBjS8THXaiHNiEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LcFnBY6V; arc=fail smtp.client-ip=52.103.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LcFnBY6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t02B5CgYOXA8xojqavagSOf6+920b/VU0nagndxGIr0iWI1hjzQQvX50Fdbl1+yporydFigoP7lW6/17iqUxCQkZKI99iKcmgcDiCYeSeDhgg32GUU9043H5jAUHh5c4DQN3kBq6igvDD2lmHWetvUqbCBPlZHrT7I0prZlAlEo6GaNOvNv4jDdR8mKVHq+rkZbpOcU+W7tqfXbMGHqaIACzHPCZmm8iCvVPOPHtCqdQTeRAAggThLgWO5R97NFE2CaIubDciK90bJMAF+pMKfE72JvOsMJ2HVlorKBZ6qNEkVy5molPTgxuxDJtP8AsxBODHFsr3KB87AIN7vAo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2WRgFnf+sKhAp3Ov8L86lCfFk+j4ENRSUIYThireSE=;
 b=CE5rbbXZ0FCGOzwPCG8+PkblJpkSimmHRrOpzmjLRDAxUZL4xs54Xi+TWi2qprpMm1n8uQe4NkVVvXlFtJniYE5VuXKFuhOi4uimABXOhH2Av7KbVdeCYr6NFWjfu5Fn9yHV73cfI4ejVZ5jNNy/21NWXfMHmUeD8JMtfNJYd1fc8JRItaNiie7TK+ofA+Bi/dYHGFGyCZOEj/dJs0ehhpQwqfcZjODkxCJr9DTOSx6iXhRd5oU1y7Wk+WiRoJXUdEkeZUpghJBsnIdWvZyOKIdopI/4AsoYIwEdW7Y7q+vejadIJzdKI0gkxY+/orxWEYG84Gz3Vy4kbQjD5aKe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2WRgFnf+sKhAp3Ov8L86lCfFk+j4ENRSUIYThireSE=;
 b=LcFnBY6VwrLV4ajFy2JuiThQz0CAaJhmimS1jrV1xHqzuHvxgZfkBTtdu8BMlQWjz8g8wXuiKIzqNYsglPJEJGX121Jxcmsb4pxtKGeQ9vbO1DIIO0nw+11LG7zze1LcLKw9UdcGFpr38nxndOAEZPIet6UlMT3mkIdSg0rkZtNb/sOn0XKqZ1Mbu63oe/y/p6TTvaTkvShxLMMV+enSESPheN1Jv/t7FEGPNHRt8dwYYjFYvhooHWuNF/Oqv4YWYcVtxABQH9iPD/jycwv0yoBTp3neWq3wfmpuSLSJN64+Sm+lrpvsLxFUSOQ88d3CqmcK+6cMC817UXAw69oelQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:12:11 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 06:12:11 +0000
Date: Wed, 11 Mar 2026 15:12:07 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/8] parseopt: extract subcommand handling from
 parse_options_step()
Message-ID:
 <SY0P300MB08016CECDD1CE84BC3CE9240CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
 <SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq3427ro8h.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq3427ro8h.fsf@gitster.g>
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abEHt-o2INN3fb0x@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB0618:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8f46a3-1f1b-48e3-69ce-08de7f35220c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|461199028|19110799012|23021999003|12121999013|15080799012|51005399006|41001999006|5072599009|8060799015|6090799003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?51YBI9FncaKkuyBbxnNwAC0QcitbOjQgNvQD7byVTZuo1orWdnoywBEMlXV2?=
 =?us-ascii?Q?rjBRHSTGknwKVCNRmGsvS4nzIKwch0yw3IALubO1/p8km0OrVaK5DGaIw1y7?=
 =?us-ascii?Q?0n1yFyyQ0EciBcntwykXBb55/iMG4xZX0oUEsVmqxndXaDZ7tIJVHD+bDDCM?=
 =?us-ascii?Q?NlEKUYhK6ibQzVinPI/29z09zjPIXrx3e1PVR2cqiHIPdX944ATKSgAci3C2?=
 =?us-ascii?Q?i8EGEFbOK4M3N/ttjBy7mvDbwioo8Zhx8wsx/U9COc1TnKx9iSxZJcGDo4+w?=
 =?us-ascii?Q?kFMy3g43skbAKZ8NIzlAS6IHts78UAD/v4cVoiKZAeYAqxHKkTR3ssXKeXui?=
 =?us-ascii?Q?0f55/aCmQ0xC8jGE9GBz6BXbYybZ5Eer3BFruTzW4+2TUrg4e6ubxJrMsa8J?=
 =?us-ascii?Q?tVGQL0qG/3xT3zDrbJrh0ukIPgnIsvedAaai3xKX0x25gB9RKkcY8oZOQ/3W?=
 =?us-ascii?Q?Qv8vyH1VVmNibA4awfhzxTR4q7nBnDopVqxM6akeXos5fGDkJdzOHkh58MWL?=
 =?us-ascii?Q?SXc9JDTwL8JmOw6/MRshfcpYPANfJyl9oExFnLCd4j19CYADQkAlLwC7vB7a?=
 =?us-ascii?Q?AYZ3Mn2iH6BDqvUL+yJ767UnqdL58CoZht0ASCcoHpbGwbvSvYpgOhqM0hmF?=
 =?us-ascii?Q?+Dgm/DRt5lKS8pmZnQTLjwTO+EgR0lK9PNJRQ9f8gOCpl+TkILNtjb6qxYPK?=
 =?us-ascii?Q?da8KYtHe0oy/JO6qDcxvtT4/UFqjACzA23Uv49PYJNaWG+7nf5TSU7ZvSzRL?=
 =?us-ascii?Q?gcRt7WLCgozdbkgXuC4pLjo5/fboRE5XmjlYS5rscFM3OBMHKhicFn2azxv4?=
 =?us-ascii?Q?Xyd62EiJCnZrAx4WRsNLnK79HEwbE/jvBIVIrcNZwK3Xp9IJqN6nSALooP7y?=
 =?us-ascii?Q?ueLfM1ka6IBxhBQUgxev2oPfNxe43yTtyeQdhXWcRLA4yFA0kPHu9Hcy3iag?=
 =?us-ascii?Q?fY+/lGffdDaIPfqWhHofnlqMP1uj/OOwtv/KnoDeS5dq3jEVDScAWDKpXFm1?=
 =?us-ascii?Q?zGZmbslZtYUbf8uv7l4mU4Wk4sP7gfgySvghFe8/MAvjviI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pwg+EZA/bdJ0g0q5M8zE0DOlv0NNn7EoyPHmCcoTlqq0zSPmq3feKh1YD4E?=
 =?us-ascii?Q?p1rumYc2DM9DBXfYDxCctVDtxzZKBHJ5f/eDcW2hv0ETNSaDKgdeLQBsBgjt?=
 =?us-ascii?Q?ZOr9qFayJ+W0/sYSq/Ldx8wTB5S/c/KU77efTBwLyZ18mo7pCUwdS4cHgpbf?=
 =?us-ascii?Q?gYKhcQuFPPUrzh9rjb6baWs9biQ3PukHCqANoh1FprsiKUW5Vu496JZL9AE5?=
 =?us-ascii?Q?Tb5uCrvn8nAo7SgIlLymahsQRNMD8CVCJd+jCvLP9yTkGgJM45t3BskdRGVo?=
 =?us-ascii?Q?iuN9lL0gD/zWgOURs+CraOj+eF7jV/MZp4TwtusZCWgEr9Ahx+SCiKuYhbK3?=
 =?us-ascii?Q?vRDxzUp6KSAuu0i7/5DBAgbfndQP1zh/852tT8qp5JWEBj6YO8o8uEPkFDo0?=
 =?us-ascii?Q?k5Qtj1CJzaikvdFc7q95NE0FdGqS6rWI34oGuc0ieSxnPdCPAgmMioAzVWNN?=
 =?us-ascii?Q?BQBEA75WDvG4LSiRFRLT953ha/KDEUIpeBVJ6VcpjnZBbv5oGzLIdHVI50uz?=
 =?us-ascii?Q?hsuZQift+0Di+vb6vqNNi6D2gg0UcEUGjVvMldJQRMpvQlZeFHZ2vq+0GnRy?=
 =?us-ascii?Q?scJvdgLOPZde/jucgGZFPWb1HY/7XtE0Be4n8fZuNhE4jefMfFHhewpkN9GP?=
 =?us-ascii?Q?ZqSrirsYe9vKhSgOSyVRPMo8josPYk6DSkG0c+LPiT99WZNjqQkeJI8/oIrt?=
 =?us-ascii?Q?Zr5vSIOkC3WTVzHLT2salibNVKjtER7pZZH6bRd5sjc89E3qend0M5wZLvFi?=
 =?us-ascii?Q?Nmc613laJV1VDIojDbq9X7mBNvCtLmslhm2LlO73b8H5wCwpDNzrFLwqZisU?=
 =?us-ascii?Q?8NsIFBYDAp+VSkAb0l5tTNVxi9W4xd4li2WpGa7P7hAT+3rECviRxRrxJquK?=
 =?us-ascii?Q?pcmfkjLtXVMwa7BSzqrkqsplgl8qo97eRfVKm17X0iejKo4SYbl4ixe2Egdh?=
 =?us-ascii?Q?O7HpvvagqbKUvF0L6c4R2SWTENDeDXOxFjJicHIVXq26943nJXP1pL6MLH/y?=
 =?us-ascii?Q?YSVmGeJECBF9lzjE9svqzxUVKFKh/G36X+9bN+hiTYVjIqRMBux5FO7Yb2MO?=
 =?us-ascii?Q?BewVI30iXDaq8UKZfQSb0+1eDxVKVHc7AXotwnyQiigZjAO8m+olneokJ094?=
 =?us-ascii?Q?OhmI5U15oWT937GQ4mXL7qm2l9SA863IRg/Va8dJ5clERUkoqhr0/1Q20bro?=
 =?us-ascii?Q?UhoLzw7nkwzqxgvtvVRCoryALXuFSU61btBgNDM6vwNHuLJAUpoE7x1zfRO3?=
 =?us-ascii?Q?ZyDR/7BiSOiMbsWnOsC00OLdQri+YP55zckw/Jr0FX4kKQ3K4qPUb2WteJEQ?=
 =?us-ascii?Q?00RCVggMuoGlRGpcxUDNB8G1HO6kM1TefvhgQcpkaa/br1guo0XFche6KEJ7?=
 =?us-ascii?Q?dwHNuhMYNVRyI3emEB+pWIUKWOWM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8f46a3-1f1b-48e3-69ce-08de7f35220c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:12:11.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0618

On Tue, Mar 10, 2026 at 09:20:30PM -0700, Junio C Hamano wrote:
> You can tell that it is a single statement immediately after seeing
> the beginning of the line, which says "return".  It does not matter
> how many lines the function call that follows "return" spans.

Makes sense, will drop it.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
