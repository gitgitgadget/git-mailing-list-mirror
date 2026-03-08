Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010073.outbound.protection.outlook.com [52.103.72.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032917993
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007651; cv=fail; b=hScWqRyXw6A0/k286VN/4qHSF65F97UDXZtVzqyv3uN5x6jBbUB3PV4+JoehqRdERMCOTYbjvxsc37QbdCkEljVJFX3hMjsdbybLFMwFhkz+ryQpWUtk6k/kGXbHt8nDUrIDYXyLo5erpnuLftSjtLXau03tQLS3MZ9bj130VPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007651; c=relaxed/simple;
	bh=XeaQ66gkTHUG4Bx3atSHUoLvZzpvSgcdxfOmXfV3soI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qnws4ODppbtuLyRKwSiVh/tzBRqL4Vdkl0t1Mn22lctrpZw3er+luh8bYfOYOsPyN5eMeujEIps84WHCa42Okvd9cfqwgP+1hnrzQw5MTEtjQZqwJA6dH91CLj+lCNvGjYStFb4PY8fF6lY8USHDm81SF1Sk+buIvhT0doxm+RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s11r9Zz2; arc=fail smtp.client-ip=52.103.72.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s11r9Zz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krm17E0WJpINYcxvcJN9R7wfDWV01yauqXU4GakY1UH8eHOXNIu5N7LX5/QImyb4zuyhZ3ho1meXiwoIzR4dypkPvBlZFoF90tnHhYq85CvLumYcUuI3Y2Yi1fyU7I/GmybLzFJjEsCfZ+HF7lmzBnOynvYfaFGKB1GUrF218xmN7qO+3p8Jzo0SSxF1oIjOHi85J1b+mvu0flzDBtw/IkKxtdslfM776vlqU7ivdW4dRXsA3v3cv8dlg+R3uMa/5DSYn1a6abVxKS6k1YZlez5KATRMdz0rWe4dJSqkY+Q4Huor9a4HMwlNB6Y62IADAEfvSF9I7Xzqf8+aLgwkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFIKkxY+yKGEp42tES+KAospHPS77oFXFcM+X8sTlco=;
 b=aLsyf6zIeK2SCcDx/OKayI9mRLICApHqYk4o/IgyxjrnuEy6LAVuwcXPeDjQNmO7r7TbpiCwLzqWBh+i9DvUWIN20953qQi0eCK0D0niadXH7JVGSDhNJiFbl0TlTuct2NnRfqnQCtnNid8xUs07La5Z3UaLI+x7CIuJ+kOgQRlfTHlARer4zCTb9iAevEVgOzpI4wKGO1ZtLZWusscXWNzQwc4EkUkPgl6iGBhTp9R+5gxQ1axNMfQs7wsJ6ayZmxfAKxmcBxrHjjQthWgYxnVqjdyPV61jIV4NwlDwnNIQ3rW1z6NssqfuQLjeHbnWl1WZ+KDSqdRdkSXJ3bADXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFIKkxY+yKGEp42tES+KAospHPS77oFXFcM+X8sTlco=;
 b=s11r9Zz2f9MmftFzVDdFrSW3hyiI14qNiOB8r+PqhB8q6Me/u0Wd88lGL8lAmSO1t4Qt+23tyu0Vtjke5e4S4OZSBcpmZDh3++Y+UCyhTchzsA9vZ/WvwuXnOtSyOXDMr0PELxh1j5QmjKEzS9FsLPnQwyhmIQphL47Lw1rMAR2m1dON8f5H0PObEJ985VZqI1W69Ke7xA7UT3jc7F4qb/Se6m05g4Y9R4wXaobLbsNQT+/N6EWK2xTL/ZjJeXVShFgaVssAimSN9Fx+Ck8VAkYVBGrflnt4a7XMzVKved2I2HERAlnYZDSRlvtYwk1SYd/pbgArEM6UGSPslLagtQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0517.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 22:07:27 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 22:07:27 +0000
Date: Mon, 9 Mar 2026 07:07:17 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] parseopt: add subcommand autocorrection
Message-ID:
 <SY0P300MB080125A3AD82CEF7341D0863CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqo6ky9j4l.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6ky9j4l.fsf@gitster.g>
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aa3zFXuHdp5thSOM@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0517:EE_
X-MS-Office365-Filtering-Correlation-Id: ca664ed9-3d13-44c1-c143-08de7d5f1446
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|25031999004|8022599003|5072599009|19110799012|23021999003|461199028|8060799015|15080799012|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	DvlcpWimkYX9v56t/lqvDekhBmurkavAGZO32oxz7XN91RcgiRP0PocY8ilI8ZnAnoR1PN8CoRbO1ql4nVBp7QC8ukc8e4yhzijphgnAQEcvQynsLk6HKeJN3Z7wo7Ocb0PCTW+wBrj1cTnZaDgBrVio+eI7/804qBcfYAZD5EUHH4EU33bLzC5c2YShwU1WdR3ZYbT3AoYxcQJKlrTjlcwVxa3T7C1Q9eDp/qmYR8wN5eDCiCEilqv0SgOccBnY6fHn+tRAFORurqdboEIbz1bap5n0xVk7GKkZmX7Q3WFdJF9MgXY1foyrqnp4IipAuqa1jR8blOUSeEO+8if4hdLnPQfksW7xi0K3kAy4BBaAhVVT55lFpR39uTMW/aiNNGtE5rFsmqaGYLKcSuW1e8K5NqDLFsDSBKr6fSgTT5YJDVcAaU+ZNrE/F2HwDw6IO9k2dC9rCXctNWMbr8gb8W0wO5aOwmGlAoxr4xECLOrFYUEtxCsolwjESYppbCiIkUQCkPySlJ9+x4XOnIMIPCubA5eu3ff0qAJLXgkR8J5Zf0PjbycDbCWH8y47nTgCj+8azzikAJTKTmxuo2r08OMK4e9TEcWyMjkILFPujD5oFen8KG9bsfWC7sfe2/i8cHVzOPftQqepkQfiqVJpNoWspEW1UHzAXsNVDVK/Uq6auojqWLgPCt5pcgHgrS0Ie/CCJT0sHr5pjRJo3wc4CanjbfCX2d+xl1gCcbRVb7vErHsGSn6aG+rgviINLnYcph9HF9gM+Mh81grcz6Aop5/TXEOL2zOVB/igARsjASJUYtN+JA/h7YiBsOOnn+wJdoH3FfbHjDNWMSceOlNhCE5OdM3bkDmHMEI4GJ0IdCgPWql813BY+nIAhvOTUQYCGa4/GIxKzSi23GOGvTvce+jIfidGSL7CQLnP8lF1iAZE1wljWO2W5ZzwUgSnGunK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0nRFE942wERY6YXyJaIxRXgBYBhmno7ZKBae1dpNhFpQEEjXGtL/gMZEB7bv?=
 =?us-ascii?Q?CxFvIaZQTf1jx3+bUCIgBSvD+yyQRL4iRdYdzWJ8Z8JPYQFxj/87br2Veb+0?=
 =?us-ascii?Q?FMpOTbP9WXLZ5LQfe8QohN0jkZbTk1Nkt1gbzCDLR39psj8dtQAOYWUpXpDy?=
 =?us-ascii?Q?U7L8jPVipePiHm3NCxA37FVv6rUiTKysrSCmY5d8hnOl8THjVcf9Lv8ZPA7k?=
 =?us-ascii?Q?/6ziW80+WNpbAFAmUuFApJ1ccZPjfUIo85bePdu1dZYYPJIqDuCUG3bh6F2v?=
 =?us-ascii?Q?qUy3N0PXJGsWEL4dZRG18QRvBlijMCtwrwRygXCLvWhfWMMKTLsaTOFFReis?=
 =?us-ascii?Q?qzaQIhwSc+kKZy7r9KfdRkJT0qIDCcapzcv+4udeOK6k9UqvPAsyC0Z0ZsOF?=
 =?us-ascii?Q?AP0nz9FLljKzanMCIB/tyFBIcUWW+TvOlA1iO9O3uCL7AYBNVb+6N5d9WqP7?=
 =?us-ascii?Q?HdehtbXSRj4NPNBQ08l4mY8fK4C8E2Cx8/vG/pT/weNEWcnkVTz00kdpDlcd?=
 =?us-ascii?Q?9kuzwqHUy5kBzhvo6jDHNb+RuNZ3wnkbzsa7ZU8+F8MCDy4MP+z4jFVbAlv7?=
 =?us-ascii?Q?ePBV4Dr8jK00OQpFLx6f/ElAbFuFF45KPTgPdq7Kg/hxtKH2kZQA0lX/Te36?=
 =?us-ascii?Q?jE+D8SPtYHVPZKHZ2iWTMyXs9QHeWhog3+yEjBkPGNbmZQ0EmvTlKuiefDpB?=
 =?us-ascii?Q?I9uo2jUK1aTfUtytU02p/BYWUMWys1duwqCtporejdWp1xr8jDF8bmd4GFOy?=
 =?us-ascii?Q?AiPxe0hqkTEkUcn5Ax1JvtuYgJEd6Lg/VjWxlVi2eqXA6pqTxdvn50KLVjIG?=
 =?us-ascii?Q?fiPKWkBHYo6d+JkiFzQi/B4mWrnTGCxzAo7JosrF+AFDcy0gSaWV0Nsc7+W6?=
 =?us-ascii?Q?U/8yXySh4BqeGIXCczxNOztcSRWnOwlrRPU/c+AUxyCGNHyRITsEVoYIcIxq?=
 =?us-ascii?Q?Ep4m49Qqz/kiVhMtpGNyr/jCjHdoLYdk8pXNbUkkg+UqegIPvddEUzXavu/5?=
 =?us-ascii?Q?/XagSVqxGDBw0OhZd1E3+hgBG9P3EOvvmFBHIRwMhQ6bSttnE2b4uPuRp2A4?=
 =?us-ascii?Q?X9g5D8E6Rda3kcB9cepn8Ci7dzu/O4OoxWz9eNp2mt4J2JQ2AGfYUUBhywzj?=
 =?us-ascii?Q?CqVWVCv01r/NJAHoSfpvYTCE98i2SvOpQ4h0Mvc/GRq+9ceh8442SBLjFvn1?=
 =?us-ascii?Q?BI6cYBHhzpZZGUeP4ycFgBSzgQOQAqhBoyEqEYNp9RaaBIYabBcamu1RbWco?=
 =?us-ascii?Q?FDlRk+OLWue6nD7+9QC3lK1naMn0RYR5DK3vTO0faNAxCZCBpSZCBTJTzn6d?=
 =?us-ascii?Q?ki7xTfPbSVLfhbhcGBUoCzosDLQ92B5lGNrAm3vlWhvy95brYl/RuWNiRVv2?=
 =?us-ascii?Q?LS7o/WBBLn9/LSuQCfO7jTX5nZBg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca664ed9-3d13-44c1-c143-08de7d5f1446
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 22:07:27.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0517

On Sun, Mar 08, 2026 at 01:11:22PM -0700, Junio C Hamano wrote:
> Jiamu Sun <39@barroit.sh> writes:
> 
> > So, this series introduces subcommand auto-correction.
> >
> > Currently, builtins with mandatory subcommands enable autocorrection by
> > default. However, those using PARSE_OPT_SUBCOMMAND_OPTIONAL skip it to
> > avoid treating valid unknown arguments as mistyped subcommands.
> 
> This is a bit confusing as it describes the behavior introduced by
> this series rather than the state of the codebase before these
> patches.  Since subcommand autocorrection doesn't exist yet, it
> would be clearer to phrase this as describing your implementation
> choices. Perhaps:
> 
>     By default, this implementation enables autocorrection for
>     builtins with mandatory subcommands. However, for those using
>     PARSE_OPT_SUBCOMMAND_OPTIONAL, autocorrection is skipped to
>     avoid misinterpreting legitimate unknown arguments as mistyped
>     subcommands.
> 
> or something, perhaps?

Right, that's confusing. By "currently", I meant "in this patch".

Will reword the cover letter in v2 to use your phrasing. Thanks!

-- 
Jiamu Sun <39@barroit.sh>
