Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2065.outbound.protection.outlook.com [40.92.90.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A827471
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550818; cv=fail; b=OofVDyIzHf5xWQElBqa6Ofg3UBeZthh0HjACJgA7w7QorSDPfzR3fpdhodMkWENvWEq3D/N1rIxPuCilrkCZ2b6zqmYsuvLDzl8e7f7iF3g1yAp4XZCFEINoZMA+JmrFdUmRZ1PKW4V7xApW44qahZ0dYd92Dr0IpvQAFFNXYvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550818; c=relaxed/simple;
	bh=/ihcZADJuKAiJ2+pdBMNAVA7NhVaSJAWbzDpQQzDXwc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=R5fmFbjNZeBeVEFrpxwX/hZbAuNnRMYk0wQjK/84Ssu01+qPRfy5ONK+xS09v6Mm6LsCuqrqceVhoFObxlZt0u1ltF8sCAB9Nu3HOSSCdpNR0Dk6czEKY9E5JiFfgVln0PuTLbDcPR20JLnTE5F/EoZlBbkv4x4MHxP0Ss3lxN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; arc=fail smtp.client-ip=40.92.90.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEZp/M59/FR/sGqvqGUCxBvKND4mTbMX4DU3WpPmm1o9h66EuSXcaDFD7JfgU5vaB+2lGKfGFYUPJwK1ObM1VcHFUKKkUZepqhEkXZaw9bTdjRPnRk5975btUUWhlUwLwNi/Uu5RdDHNSy5GkqUmFiejVx/xcygBhL9DzmGG958v524d11KAaocr76lxT2oO7po7Ayu/v06cxNhOUKU2k7h4l2hx6LcEnUCldMmdV1CWEPg8Hx0VTXkO2JF0X8NTPvYLYv/j/NKd3qbVwmB74TUl9oJcxojTITs4Hf6i2egNlbVptkqW2BYPlpHqTRZe0AJ4pZLl7SC1qpD8pcM1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajHoYXT+z5MzOlfZY6UK2Gh8HPXiSuRPiu0EfCLycmY=;
 b=adKRd6TlqqUaAmn0iUYbpJjmgQ1x2FoHfA4qvKrYIa5R3lysdEx31mPSjn2U42WHkMkPGaAaOKueygmIdGaS9PO8mp5nG33DujtpQHv8mrnGlt6bobIUxEwyl0SKCPEi0wb+tmw1NIhuTnJHYMvUICZrTJVuhMAjtI/6WcAjTsbkBzrTLjPI43hOSZsPkRmJR5GqsvvN7Ld+if3bISW3KW51lrRhSkU56bnZaabW1gajLd9RcnU2Lyf+5LYKILuEmqQvGc+vQJrj/YKakVc395ELjSb0sTxYEr87dO/qbDGugEpVuFrFsnch83bJQTSSrLzwIce91Q6Da2KNU2jcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AM8P250MB0105.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Sat, 10 Feb
 2024 07:40:14 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::3780:e692:f8f7:4b90]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::3780:e692:f8f7:4b90%4]) with mapi id 15.20.7270.025; Sat, 10 Feb 2024
 07:40:14 +0000
Date: Sat, 10 Feb 2024 08:40:11 +0100 (CET)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Christian Castro <christian.castro@dlhcorp.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
In-Reply-To: <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
Message-ID:
 <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN: [7oWsT2oT71h2MIzZShzS1Q/mEycotCkz]
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <ecffe606-efdc-46c3-bb9c-eadcac015034@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AM8P250MB0105:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c38344-3bc3-4cd8-9e3f-08dc2a0b8475
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BJOIBQwGK3e1lCPgKd1m7MmOFObVQe+hd3GsXagxrh2Oeua1EGw6w/+G85zSa5Gm62e2MqWiPHNHzFbgRf3YJNBUgPXhq+9ABZvbTMpkLwZqebBnQbIH/8tY/KjuiZJTbXzON8PUazFdROOdFXlsePvn6f1JJubaEdtn/GWLXtPKbo4WPHMb8k2JVhbpHiGU0KsEMWXDLAZSkSTlfGB+UX/s7RzKZguav05NsKPW+U+DHysys4726NDaY95wm9NriWRL8QVB+EZxhQOPV6quFAdVthxq5BGaaV5aopPxfyfiEqt4Q5xeBmZQ4khKnL+HvhyqKLs+R49toUTTxFtgdFXwMFNmVk9gf4w+GeQH1rAi7VucqRG7shYdf+0w8/EbmzrSBjmeJOQOkY8ituyjY8/Eae2/AqlqTK2DAs/Ei+t3u3BPoFmOPEBjGlKnS5SEHq+wJI6CSO9vGO4gKL2qBkiRhtGm5SmBKYlsn8lExglOxRXVqnS+DcVSHt58/PxXBexPjQzQaVMTpTRo6quMXxRHGtnTWswakOlUlkRUWvfCk+NOuUvRgB3aHFuHvNk0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pb3M5DxzYTUCqJPRLSx75FgtODRtV+TsamNtQfHfl8n3guVkLaCXKKDCHRvS?=
 =?us-ascii?Q?4sBFipZFJV7+pEbOlap7dk42u0/G5tPXVHtWXDgYujWNnJUWTJHH+lhbJGLv?=
 =?us-ascii?Q?CeAR7xA2JJjW2qjer2o8UKNyLDXhfvwNqp+Mkx0b6OJHhfSz8e2BoEYZnSuf?=
 =?us-ascii?Q?8E0MGOGXXmQ6lAPeg9ME4/7WCDrtu1Z9xWts+EfomRH14WMwmvRx8cooLdy+?=
 =?us-ascii?Q?Uae3wfUUMjLUi8zTs5hCQBk1ZhCj9lttJgcGG8VUUTXEt2ougna/G0UWMdND?=
 =?us-ascii?Q?P7FYLhhIKDryPVg5p/vwZdjGQkvCXPkV+AHs2YykMNd3lUqLvKaJTvO9yuew?=
 =?us-ascii?Q?F7rpPC8GdA1Cigz+BKX517YagIfaQay//BaWi5x18LxsErfSg81PGT70Be5G?=
 =?us-ascii?Q?cJO+l6x7CjL3l0k2kamXcwnG0PrUJxzEiPYslHO6R2kbIoRPx1Vbhwu5r/2G?=
 =?us-ascii?Q?qyoQ33tbL+E8TBRf+vxOe50Ixq69jPKYzEM+CCpIjukwJgt/K49JYDUlmHTf?=
 =?us-ascii?Q?/GsZaYwNmLGnd9jPIyyj1JcTufSDJJclf1uM5nhvZcTwzo7v4duoo/T7IVl5?=
 =?us-ascii?Q?NXUk166sWWe6C8RJt0TfDvTxbNPLnuaehRcTREimBCqaukXCps3c8bI1thjJ?=
 =?us-ascii?Q?jGvZumrXCgn0SkGanRa+ALc1EHTOiQ5yiKWK7ICjYEDElcdJ5tH25QzSxHrp?=
 =?us-ascii?Q?+3snpQqBKFySyv28eCmTRKdKNWTFna+DCYdJMV9VqT17QCJ28UjhPdCxTssM?=
 =?us-ascii?Q?G5pmFL4dBtFjyx1EAmsgRfP3vRPXsoQT5KOGq6gbThyixPAdgAk+Xp0jiQzF?=
 =?us-ascii?Q?mm0UFHRnvPv2VQnmDIU0XLRAeiboilUsjuMliFs5DXXpt8OAx0V3xp8FTy0R?=
 =?us-ascii?Q?RcgCyZ2JWixhRUTjaqqJlhrq0GIlEH6mAjpzQCqfo2E+k+gu9FvR5hnhLHzB?=
 =?us-ascii?Q?bwuvdIDxERzPEmeH4GpWcNf/8F7Lgx93FBRV5+d1QVA+9ERpIbiDEnM9+ev2?=
 =?us-ascii?Q?l8UGwsrolVoX99njJTNuq+IgXro68FkfyQmvQ/sQ8Hi2Osrzh0zbNFwGZvOM?=
 =?us-ascii?Q?65o+KBB+sDE9WJ/Ku5EtPiwlBbMhg35/YshXjN4trZrkvUVLr76IQTGwBo/d?=
 =?us-ascii?Q?mOQ/Tyu6iQFE8kN3emGY36J31chsxEM/oDAbY99LHs1SjPAcEm3g6FGr0XtT?=
 =?us-ascii?Q?nf13+mXwBBX9XIo1mdEsW9ZO/egaZlKNTCxFAz2mfeHT4Ot97W4nJohfEKY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c38344-3bc3-4cd8-9e3f-08dc2a0b8475
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 07:40:13.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0105



On Fri, 2 Feb 2024, Christian Castro wrote:

> Hello Git for Windows,
>
>
> I have a question on the GUID and/or SWID tag for Git for Windows 2.43.0.
>
> Can you tell me where in the product the GUID and/or SWID tag would be stored in Windows for Git for Windows 2.43.0?
> Our scanning software has detected both 2.39.2 and 2.43.0 on the same Windows but this is not so, only 2.43.0 is installed.
> This was an upgrade from 2.39.2 though so not sure if that is messed up the results somehow.
>
> I've looked in C:\ProgramData and there are no regid folders not regid.xyz files exist for this product (for the SWID tag).
>
> The Windows registry also does not have a GUID information for this product located under:
> HKLM\Software\GitForWindows
> HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1
>
>
> If you've included a GUID and/or SWID tag for your product somewhere in the installation process, can you please tell me where these are stored under Windows so I can fix? I'd appreciate it.
>

Neither of those things really exist in Git for Windows. Well there are 
GUIDs, but no GUID that is used in the way you'd expect from an MSI 
installer.

The Git for Windows installer is an innosetup based EXE installer. 
Innosetup doesn't have these concepts. There have been efforts to 
introduce an MSI installer over the years, but they've all fizzled out.

As for SWID tags, you're the first person to mention them in almost 15 
years of ISO/IEC 19770-2 existing.

>
> Thank you,
>
> Christian Castro
> Sr. Systems Administrator
> Office:  301-628-3551
> DLHcorp.com
>
>
>
> ****WARNING**** This email message (including any attachments) are to be treated as confidential/proprietary and may contain copyrighted or other legally protected information. It is intended only for the addressee(s) identified above. If you are not the addressee(s), or an employee or agent of the addressee(s), please note that any dissemination, distribution, or copying of this communication is strictly prohibited. If you have received this information in error, please destroy the information and notify the sender of the error. Thank you.
>
