Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27B391832
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271582; cv=fail; b=b1SuItRA0OoiV8vwWUYimObufVYzUVcWhGRgbedaVAx/hSk1s3ei89wVtmDQPrw1GdBuHLYhgQTtDo/TASFUQqlkP/w9hGQt6WsuBGTM93uL1L+X8IrJxbbj33ZI7rocTXOTsygAbzAN1zcJGKEalS9hV4JmqSfm+xxe7RpbzIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271582; c=relaxed/simple;
	bh=8smeHQuE7fCtS7uRLu527/xUYbvyU31g2XmOqx83+Oo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MW0Wse730joUkBiHKDjkgbXWm70RUNOmpB3ES+oW+JKg7GQZ1hMSsLEXtvHxx0W6bby+1Ft7t5pVHyNQrrXNLqxtKoZPTbtfl4/g8DAkvGNN+KwfJHCd2UoU6tF1Rfdn47i6gVbfXMYKREBrold3go4LJ29HiAJr2e1gjyj2RZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o0adf0Dq; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o0adf0Dq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btOlVC8ytxjSr5AtdAHkIPLjqO12M9l/+/8A/DmYzUenZ05g2x+dyRgcrxx2IoW4oQVF+WF1w2GiidJCNeWlqt/LttFiq4/4CX8zYp0tGjxieyOXpeU8jYYrZfgus+6s954vKflAiwyuKzCrsVTHjqB87PBq6qlsT6GaMVQkrJH9wD2D3voKxqpLoFWjI3fbz4pXXWEMSobV3zgOwPqMKRcNHs0DNKxTwddOTY8bV0UrHE1YVEvP3In+PN0K7UtRU1nyGrCvLmRlWGlsr42M4pgcPWKxZUQNMUgLI6yTSDhCWhQy9aIyt5cj/qqVge/YUafoNzncU3fLwZliP5XC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfUMCo56cTxCyTMQligP4ItksuLf94DuEiyqDYxgbSU=;
 b=kYo50v6N0MOC/eDB+gdW85kaCdNKTn6o37ftKdNxLvxvjQtWwrY82HqyAVqBvv3RWeaeRzEnu1EEwAxl7kN+dOqQ9LGSfrirqnLE5vOQFdm1XCyNKlwQD5J/CCuhGUR0n6mPRJi/9/pe68xs8V+kK31brixcDhKG4sfI2XG9QQ58/5JHXS1CKi9VIO7XdHW0PIquc5P5K/tXC8FI1fyeE4eum1G9pgIhdO4wtfCQN17s7l2etKToNyF42uCgjQmr2l4Pw1F3dl3wqsEQK8kXQiI7sJjV4vm3s37jbi0cRLpJATedfeGuU7yHXwd0KYWoLch4KIOSF4AggrCxpnWi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfUMCo56cTxCyTMQligP4ItksuLf94DuEiyqDYxgbSU=;
 b=o0adf0Dqj3RiGuU2EZdh95igm5Ax5XpIMjzs8xtvNa2nrvdx/wrxw5oiCVrpFrnekQATAdoKA3+tRvakT6SptYa5lX2g7bvSfT8u+7hAuhhpBC4pVTVR1NFOB9YCueAw7+gfa4EEV2lkWNYuzxOjqcekbYM42f9DaeuV6KYkZ0Zh8wEwRvC6HqJrTiIi/Csm/XkGDStEsoWhRTO6q/j/QtRqUXhutXMrrTdtLZ0xjdj0yK7ldQPcAjcjQYenVK3BYS0/q2cWqnCNu/YEiaw7tMrEAyMWZVTN3hSGzo+O8zy8W7QfEtLvHxVWotaVCsHfSPDRhMo8GR55GDzlzk6T/g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1557.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 23:26:15 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 23:26:15 +0000
Date: Thu, 12 Mar 2026 08:26:11 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
Message-ID:
 <SY0P300MB0801C9B110080DA6DE9827BFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq7brjtp7c.fsf@gitster.g>
 <SY0P300MB0801DA185098623A3729B9F8CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY0P300MB0801DA185098623A3729B9F8CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abH6E6t3foZ_mxL8@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd6b107-94fb-4263-923d-08de7fc5971d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|19110799012|8060799015|5072599009|15080799012|6090799003|23021999003|25031999004|461199028|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W//q0JG0//im8pkN01l3u+Obk/hZrXBlnmSfbgRZ1yVCaiVcyGu7FQBS5Hke?=
 =?us-ascii?Q?hChnjoZdTYoOqr9N2c6x6dY5CErT3mBncFiWuLux3S7MXZcHZvtdAct7r1hp?=
 =?us-ascii?Q?jZ0cyddbRo32oV1HBhmdkpD18tJ5p+SAFIUXwqQZ7u167PuzI79ybyUyXm/A?=
 =?us-ascii?Q?0qCx0ZZctHKetC4I4oOcFPxRhzTAAyW6xyYSlDiJopE/7p+59ss41UXW9/j3?=
 =?us-ascii?Q?dxyGVBF7Cl/eeFWN1MKBuovbjHb8XT6Doj/214YxVx6ikTIU7BHLliaMNQpP?=
 =?us-ascii?Q?VcV+niqUKAzOxt44hYVj22P6Qt/gQSX2guBrKVdhWs+Q10dhLGi58HbAlUDI?=
 =?us-ascii?Q?/BSUZL4wZKbxBbQDncz2ZP3N/uZtBb0tj4UMyt1OOdrA+/psv2a/OmnnKD/B?=
 =?us-ascii?Q?D3KsmhBqciPqIGGv5Q+IAL0trX76X+sBYn9cnC9vVbl5nD0Ja9ynrqtp+Utg?=
 =?us-ascii?Q?njb1j+6OQv9W0UArSCuJ0ly2fN06SUwmpX1GtXmfo0Po8Cchml4q+lkeCryy?=
 =?us-ascii?Q?DHgN8Bt424UPUk4B+XIqtf4qfPt09Iq/E+Emdq16Vp33g9lQykWFBJTSH/5B?=
 =?us-ascii?Q?NLK4WQOWzdSE3yoXJwh1da2h/U0KfLertUHmaJe0CdaiJyO05QQNXkhe5gX3?=
 =?us-ascii?Q?S4pLprFU4Xd/AcM2UcXPkmtGXGVD4A3EZwtphPGn9dkmDCw13yJlVuGAOMgy?=
 =?us-ascii?Q?Q1yvTzIX4+9454c5XUvUHYDtcJgdf1e8mtJ4CmLt0p6IDfQP+sBdVRAfazws?=
 =?us-ascii?Q?hSSNPxuyCMI+nzZtuwzlk657NrWdpao+JryqPheX7p+kIiOJUfzk/8DtID8Y?=
 =?us-ascii?Q?nvmjVvKRZEFWl8jp4BJgPWQd7sHiVlLIeVpid71A31IKyjiyaegruitNaHjM?=
 =?us-ascii?Q?vr/hTQsiiOA+fJ1UfAkDFXJcbr7mzXz0YlbxLLeakZhUTutkogxN41FnFWkb?=
 =?us-ascii?Q?DLsXWSkSLZ/cjArNOc8P2w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqrz71XqxgcMw1mjZPgOdaX03pElo4tFD61hY2eqU1WdliSQjv6UyGMaLGPl?=
 =?us-ascii?Q?X+XVTznpjAsNgUMgS9kCKCLruPv+ytQTTRd8+WpiOCggTSXwC7MkN2OGTMW7?=
 =?us-ascii?Q?Zm2Y1MCFR1n6/muVarrIv71Z162Ruq9jfQoKHnGNZTlYf5QQqCviqExOdkr/?=
 =?us-ascii?Q?bA+spaXCbHURVFCRHElJBgXoRdyePp/d9GELT7rCV6bOl4oknJQ6Xu7kkRX2?=
 =?us-ascii?Q?rVY/Vz1hTOL3hKHaZhRD2NjoDjjKumG0cYZuTOtI4PacYorm6UjOCSqmYCdL?=
 =?us-ascii?Q?P8AqC/bEtY5Cp6554OsqFkX3AdCdWpEyZNd39WY0d9I4gKC39xBNIOHTeS/z?=
 =?us-ascii?Q?UbQ9ApSTW0zC4pCpkzvbLi0td2mprygIxGPhih5BNkELOvQph9H67py5SDbU?=
 =?us-ascii?Q?Ay9uA+NLPA+QhpRVJZc2zl8UO9E2HCX56r2Xb98Nw1qugVSCQX5xopbb3UnM?=
 =?us-ascii?Q?0WN2k9O1NnMRuL8XWohsvUSyA75bsxQdunGL+vXzHUGwUzUXBtidleMu9aJG?=
 =?us-ascii?Q?YwbPCpzs6eGt2P7diKVj0tZJ+8fhkGN17wCAux6GrdYMy1OHSIikBkogYxKc?=
 =?us-ascii?Q?BiZl+uEKBKSQuIYi8395U1id8lKv05yJSMq5DZ9xXA9FDrxx5gmtcP4pRHOj?=
 =?us-ascii?Q?Z7RklqwJcxkdwzyT4xakVVbI1mCDVHCohZQ6BI3Q9+9ExLG7lXgKPEYaZV0q?=
 =?us-ascii?Q?GmjfAFFrvc8dhQMscEL5YEyhQA8bTM1pyoeSIqG7Yilrd2Ai8vH64QhhChQE?=
 =?us-ascii?Q?8maFYeRUe8JifELSClBkrpP3Z71k3A5YjxRwkNEm5mFzFwqyXx06hX3M30Gs?=
 =?us-ascii?Q?D/gI1JyxkaxBQuJSMvWq8yKtvItgpiDxoC/liNJxNQEqD+Q33jx0sd/pvfW3?=
 =?us-ascii?Q?d7oWFaH0dr/F8uwM9fn/9ItOLDdpyLPvb1F0PfvJhi/O+4jxnx3sk5VqRHKJ?=
 =?us-ascii?Q?DSCwT9L4skrTFnJzBKwNcgUiGaTK7E+YXO7l8vB/5Z88phAsC7IRbGc5Q8Mi?=
 =?us-ascii?Q?4fkl9A/+guAS1snADjh5sU6oYeChboIPbuaBKNcNUwohFMA7l+LOU3H15hKn?=
 =?us-ascii?Q?I8lOzotexLTp3k/oS45FCb1GVrh78t69w26fTFElHb86RPkqhT4KvwH9QtlT?=
 =?us-ascii?Q?nfjjzFlAVETuzH5P6Gh6HQLXMxfFOv1RySGCjIuE4izQ1hH0ukkmpop63tmJ?=
 =?us-ascii?Q?mROTE3vBWLb1cEmuUH5P9FYYRYmvIZDyesEW1kiiF8pJjUp47QUnKEGvNHUC?=
 =?us-ascii?Q?If85Kb5ZHwLCGezxBBo4ALtqT33RmgNO2l4N3K6NGOEP1FzwoIVz/CQx+yGq?=
 =?us-ascii?Q?giZZ5TYGrgCXh+NphxBZ3NeokYK3a/eCw+uUfq+kp+qbSZKSdtLzdxC/THus?=
 =?us-ascii?Q?w3EhXk72ux8TPt0jncAPKXGZSfKB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd6b107-94fb-4263-923d-08de7fc5971d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 23:26:15.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1557

On Wed, Mar 11, 2026 at 11:48:41AM +0900, Jiamu Sun wrote:
> > There should be some explanation on the reason why this is very
> > different from SIMILAR_ENOUGH used in help.c for main commands,
> > especially given that the levenshtein() call here uses identical
> > weight parameters (0,2,1,3) as used by the call there.
> 
> Will add a comment to explain it.

	/* skip and count prefix matches */
	for (n = 0; n < main_cmds.cnt && !main_cmds.names[n]->len; n++)
		; /* still counting */

	if (main_cmds.cnt <= n) {
		/* prefix matches with everything? that is too ambiguous */
		best_similarity = SIMILARITY_FLOOR + 1;
	} else {
		/* count all the most similar ones */
		for (best_similarity = main_cmds.names[n++]->len;
		     (n < main_cmds.cnt &&
		      best_similarity == main_cmds.names[n]->len);
		     n++)
			; /* still counting */
	}

	if (autocorrect.mode != AUTOCORRECT_HINTONLY && n == 1 &&

If I read the code correctly, for the prefix matched case, the similar
command finding in help.c skips all prefix matched strings and increases
"n". Inside the "else", since that "n++", the "n" will always be greater
than one, thus no correction happens, e.g., it doesn't autocorrect
"commi" to "commit". Do you know if this behavior is by design or
something else?
