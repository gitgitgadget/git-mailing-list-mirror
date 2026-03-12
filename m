Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010000.outbound.protection.outlook.com [52.103.73.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3039478F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291243; cv=fail; b=o9nEGz1uvvjwlpOVyazW05CavH9T3b8THbmpz7Sem706+zBBbD6Furiep3r+CCLCNYqysjDadX61ZmK3fgcYOEDvZr8YwjGghuSmooO226umjZPeJkcsYt419j8ISZCZseq26G2nkE00lT1YDW4ymqxNKpR4WdyIJvvrsF2eJlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291243; c=relaxed/simple;
	bh=WnWUTAejCaeJVaDfU0u+CnClNhZwlksV1hHXMCxUojA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FY0iZRXjzhUKY4CM9WhWI6qdEK2krlxtDW+AIJcfRYOTgLv5+BS2l9djBMUkayuMqNadCHrRgmW7PWpLL6kNDPOehQnmrI86rfHn1nIZ5vzmXCX8ukrdXst4+fIxa/t0WGTXIDv3jjXvm1ZYlQLoDJ7RWl9e1oPWEKNAj4hnEJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GOcE3oWN; arc=fail smtp.client-ip=52.103.73.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GOcE3oWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw8a8Y0xBEr1ipm01X94DkSB0sr+XAd3pB/TgATDOdVaDv1iUT+5s7olOvB1oGmLzED3Xj/91BHjLHkIN4TWtPYVQF+WCKW8sQp7OewEwLqOXOqffZ3x8ZyrIlIVjIvGZMbX+5IFUcdV+mkC8KI1t4SXwOEDna3Nk0RFxnY2suQ8G4lIY61+v0q6aZMvLGREM72hGyi4u+Nthu0eDFoZORrIXZwhUYjajs1CHd0aqMsRYRikWHiO3Akl7thgHuwcrCpf46N/y7fODQG28FNAxmyU1/oPYTPHS4/qg2eJpE9BxXOlVwqGUYGY6L4hDYPF9UyMQ3BFIKHDLqqLA34yEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKI/dqISfVn99A8SxJ+CYhMvcz4EcMNefwBQIaoKvTc=;
 b=VDu1CR5zeEznQ6J5yM0LFn3AaxxkWvyQyXzxC6ngDDPD8Gd/Ns4l4CwyWfir/teT8RBt3Zwfbf6ndL9QdGtDt6+AdVgsIKVKkaDyVip7feyFFpf8v/SK5yv61rMSEaHFYNMlnnKVTPIc38chPVK0zKB5SY5jE1Gs0DZjon2WlqbErnUVYAomYap6uQOpenCsiDo7h48apo5AfQiOP5MxHyJS49KeWZgAcBFO+tz4z+lI2cwqjqRKtKQjjYyEkGabRi7jjwjyOuwkOJpTFnPCA+lcmTjHDmK+VvoXAl6McqN24BN0p1g+kZp1jDnWBk84xJOM4uD+RDWO0YtXpaE9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKI/dqISfVn99A8SxJ+CYhMvcz4EcMNefwBQIaoKvTc=;
 b=GOcE3oWNAkVJtdKP/yDcFuYP3eBNg9B0HyrQIrFoJgaQPYdjp4yRHHYjpCwtXlbXHMpiOoQEke7Qcw/do6IKrziuBE4bRiRUJ3CvyekmKqEKHBURdahl+VUtsNQC5gyub3aUZrbka7vrEA38euvqymsCa1tyS/PxMJRM9O0VlsQuwjgkjM3dKHW2yZkdfgExgW2w9h+gyCvP/gXNS+cLOpMdYFiGKydK3bF+XzfaSw6la7CyYfOFtNTUVYc92loAK6WzA6B+Aff4OU5U05GTSm12D55+UGPIDMv0f3LtuFISWMvyGHEeK95x9HyVnpx1cWcFArvyq7Jgg1rcMNzdpg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB0638.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:288::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 04:53:58 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 04:53:58 +0000
Date: Thu, 12 Mar 2026 13:53:51 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
Message-ID:
 <SY0P300MB08019AC7A54CBB4031646F70CE44A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq7brjtp7c.fsf@gitster.g>
 <SY0P300MB0801DA185098623A3729B9F8CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C9B110080DA6DE9827BFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq4imlkc04.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4imlkc04.fsf@gitster.g>
X-ClientProxiedBy: TY4P286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::16) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abJG30YqTNLv0znW@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB0638:EE_
X-MS-Office365-Filtering-Correlation-Id: 87472d16-23eb-4571-4bc8-08de7ff35edb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|25031999004|19110799012|8060799015|461199028|15080799012|23021999003|440099028|3412199025|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lV/G7qW4/k64hxJ3gAqwGaZFZqvk0cqkUDltPZy92zKfPSQybht/2trm4Ppa?=
 =?us-ascii?Q?V02tF6C/nbhZGbzanFSYMTm+aiMF4Edv1UIOCTn1IEuPIla+/pHGmtmawwVh?=
 =?us-ascii?Q?jApyyD5YTAt3Xy16FBUEKaZGYs5Ofc62MkMr4juj3BK82nztR4xsNv2UKcqj?=
 =?us-ascii?Q?sNX50CxQ61nSUdU3HsFlT/IiipUqBrepcFFjfI14RdLP7cFuhLWsIV0AdD79?=
 =?us-ascii?Q?vAGGGEs0tpsaaBiQnZdrSILqPaN11+3t6IOyvJbCfqMgckAdUPThA1QuOkqH?=
 =?us-ascii?Q?CabbWIBlrfUS1q2F/W8IBQgjT8tG6PlglteKi3WtlkT7OuHMklNMc/sZwxZO?=
 =?us-ascii?Q?TXzPzxbTjIIPxnFQO/Qy9qXK1WTiqq4UaHcHqWcsmJTlGseZRiGfNGS98g3W?=
 =?us-ascii?Q?ei94Az2GxQPYpu93rQF16zjncA5xP0mvH1kZe7/8RbG4rFaTZ7/uHfPR39Mp?=
 =?us-ascii?Q?7GHU9DoaPEKG9DwkAdVP13OsYJaiDABL+LAp64H3C0JXlOSszdlgkLRqzjBb?=
 =?us-ascii?Q?MTewR7W8AeqRloGKI/sHh0rt/J2ntPrQTJnN2wFnMsq9M1C/KqlDtySklTXe?=
 =?us-ascii?Q?RKP6sb92QS2JoXHRkdQOGhRe1yuvcBeSiRQbMS8sC1yjDb7IRE8ZPn+iVjh8?=
 =?us-ascii?Q?uS7Yzg3QANib1eG1KATBnjAs+6Hwhblpv3eB4Qrmu37BdZYP8Urto11n1Guy?=
 =?us-ascii?Q?P1esunlah1CxNNIskEVwC0U3xRJRRgOF+wKeyeYVAk6tYN07FlqpGpWm4Va0?=
 =?us-ascii?Q?oUF3h0buPMO1xX1nLZ/LZRoHR/OSOoGzrKN/08MP+omPLmE9FvLe8GaLkS1B?=
 =?us-ascii?Q?jrLKGfoNtlDr7OBNOmUz7nSdlni5iTxDqvO1LYbRfzJfAs0IWPNEj7wTzq28?=
 =?us-ascii?Q?Hx7OH8QPsssA623PWckhw04kkbih70fftH0f0mEC+uWI/Ovwv6BQZ76UiecG?=
 =?us-ascii?Q?SQAvZeb03fIcFs/wxt9Pxg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWMh7gZpbhPyfs2d/T3YILTVcJuyZn+Lw6F0xTlTTzXdtIICr0pfGxMhD3bV?=
 =?us-ascii?Q?SKC8svfkq0gNo5XttNn0jb0O8xihQVWnfhMOG+QiWWSy7JFfOOsu1gEUETOr?=
 =?us-ascii?Q?Bq1JgmAREditNuwMO5V6SauMNIcCqFi7twspRuwGNIvM74p94Iahc6llmFF6?=
 =?us-ascii?Q?vj/NTuPWUNSUPG2l5umVjQKVSAU1H8wUHGqa4cAFYXWq+TPXaBrdCZMv/BUi?=
 =?us-ascii?Q?UdLnu2srf5TiN0I/raKDcdpmenHuOLaA1QFKocOEAvFAZifA48AUxsNndJJL?=
 =?us-ascii?Q?u3wPvbnQvWv3OmBoPacn+g0JxEwKTsehhqCoPg1hbKlWeNA/KFCQqUHe3BtH?=
 =?us-ascii?Q?mvR7etzDBO0OmfnXhJ/2+WX6l/FaaAjzzrmiwYQnlRkgP+ALWWcuuA+EjlhU?=
 =?us-ascii?Q?G9/8RNPNF6jfBCL6nYk+6cFPQTaV1KjLmDNRdXri1JiB8JK5qeDVrTrAMrsz?=
 =?us-ascii?Q?JMGyI/tmMHrdFgB8M971NOoK6qtAcRwJEby/MYlNoFvMbDAJphAbm15Ezt8C?=
 =?us-ascii?Q?PxPIql8nWLYCaFXbPz+Tza2Cnn/b+a1Ksu7rj9WriVYkJogbZ9+0YYaxIcSN?=
 =?us-ascii?Q?DmyCN23rAa+1xn4lCck/eospOVlGpqmRqHl59kzl0gSvy58voUeSnSXjjvSY?=
 =?us-ascii?Q?tq3+BGHTo3lgjMSdxAUQoCyT2qJBNVPsvJDZrh4WivOiMNoG2BjsWn0TrLuK?=
 =?us-ascii?Q?XdzACP1CsCsypI9OW0aKdnzBSds+0PqSl2ELxAkGvv4EhuP63LwkMr4b7EZd?=
 =?us-ascii?Q?8GbxwEIr+eU7qSvR623svhBbsikEr5ni7InFuGGSrRtmXvOr3XtVq07snkat?=
 =?us-ascii?Q?fUvA1joAcP/wV+aTmWnk7sWUD6a5o1OctigeZYo0WzrhMMOn2cauoFJB5Uod?=
 =?us-ascii?Q?M1Ct3qKQNx8fLe/MX+bmwXOiyd0KxDDBGG9oDIuFGrJwLuO1BtP6kpdBN2aS?=
 =?us-ascii?Q?xRfijJcd8bVBVoWzzu37e6C786QFmxSypdxX3oGmx0Aa1pyQtTHWBwRFS32S?=
 =?us-ascii?Q?idlgkxcx9TQeGwrd+0k5CCb5GbYkqHlZupv+1We40ze1RwdNN4R8uVz+Qocc?=
 =?us-ascii?Q?aCISQP5PnGVIuE/YrHy4YetV8ZHMXNXEPnxco7EjCEyDOj+R1PkSSWfYfXPT?=
 =?us-ascii?Q?IE8GGmv4+7N79+2ZXem0RpkRDHE38AUNpuktiN9s9AK1P99nRcfD1R94Vzl2?=
 =?us-ascii?Q?WfD9MN8igNhab45c7vaXKWi0RVilDHAxh0I8L8++0AMR+PQGoMHM0A7LZ6fM?=
 =?us-ascii?Q?Bm3w1Jqr6+G+VEg4P6sjE4SG9Lo5inmMEQ8qMqBgKgbyaAi/ovGak0oTMUuj?=
 =?us-ascii?Q?Vv9W36c1ptlDvzNJh4t+1e2YJiB9q5IbPEnNJj/y0kYHlFOUEUlBxiIoSxrZ?=
 =?us-ascii?Q?3jZugyqhi20YbcM7bhT86HMZadww?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87472d16-23eb-4571-4bc8-08de7ff35edb
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 04:53:58.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0638

On Wed, Mar 11, 2026 at 07:38:51PM -0700, Junio C Hamano wrote:
> I don't, but others who have their hand in the code may.  "git
> blame" or "git shortlog --no-merges" may be good tools to use to
> find out who they are.

Thanks for the pointer!

+Cc Erik Faye-Lund <kusmabite@gmail.com>

The reason I asked is that I'm documenting similar_enough() for
subcommand autocorrection in this series. It allows "lis" to correct to
"list", but avoids "ad" to "add".

I noticed that the command autocorrection ignores prefix-matched strings
entirely (e.g., not correcting "commi" to "commit", as introduced in
commit 6612b9e471a3). I wanted to understand the rationale behind this
to see if subcommands should align with that design.

Thanks.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
