Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012011.outbound.protection.outlook.com [52.103.32.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3F3ACA7C
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535171; cv=fail; b=YJLaXZlWhwP2kKp6XBE+zbOvSAe2J7yOF+QKbQr8Pzc+2Kej+T5RBgKZPHI76saSWS9G+NTf0s5mgbw877M/dJ9wg0IJKuvXUXAR+mzcM3Lqe6kXjDixBawKBjkHZRl2xqall5vYfQma4PwTq/+DGwahFf5bNpRrw4psqAC7YuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535171; c=relaxed/simple;
	bh=WR5biAK4vazQVfyjd79AkNKPNTb3NHbYKmhGAdUw6Q4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OKyvwHZBOmC9l2geBwuIbcvovh0SpyKEkHsO3pleWOywQ+45A1qEj5B361aQvVDOqOzXr1043mXzCdtHh4BSq5ZabWgNDZkIgSpzbiOVACDC4iW1K5T0zKooNUUlES+RLkD2ytQ5GxYPg72iHdf067SqdaLLFkPx1a5zuHEGHxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NJJayW+m; arc=fail smtp.client-ip=52.103.32.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NJJayW+m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Whzm6r+SbiBefl8nsihNpDWxueEE9s8JqO0HSUi6a4Dv6ixe2Xsn08GMo88osjd5WjCGSMiV7Szp2SVEH/dkyI44Q1qGSM9tVVH/yq7WN4OMg1SiEJ4OsrhdRToo55CvhmhJqj9SaXyMKA7JoOT4S5p9JPAiSE1RLEZfJldEH3EvpXxw2Y+tCGzvk8g3qThEJbjXofYZrbpXliQkIQy6E4mdbhrzv/lh7Ws8NZnyES0lTsZeU2MYrDSY6iwzsi7RwN5zdrDD6GhA0m0EffGAMgxDAJ4hHU3c1GjjcWpvXTBloaMR4Do/53rdN+/8cJlIP7SgdoUyo5rLi6N6SUgm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR5biAK4vazQVfyjd79AkNKPNTb3NHbYKmhGAdUw6Q4=;
 b=NrEvEk32vpt022VMfYArL89Q6aiKZi+/zeLCyrn1vsEBTCOjH0JPGSSEreVqtGf30qwLL+IL39tv08rG8bwiSVhMI/3w4CpUIdniU3ZHl4AeheVIJa8v5mzmsb+rdqcWwtxCXnYgeNOfhsV6mWlUmXk6f7THNozVOw8lXukVZN0UjbmJMEquxqPAH4TDKjK9Tciw7yrD+qf10V8A8L+jkHvJDH5t/dH50BM/r1URON/EZDiuLTaoZJO3MEQ9kuonO1Xb8Jdudbtgngsp7E/CLaclu8C/+sj7jtXT0oYMZjqfr2vsWVQulgGJ5AFPd4Tyzbj2spMYx3oEpC9swWpdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR5biAK4vazQVfyjd79AkNKPNTb3NHbYKmhGAdUw6Q4=;
 b=NJJayW+mOLeiLEwRWXKo+MyfozMOreBAwVcIGmEZ/IgVKvpUC8DvewNqj/EFddBjzpl6KsmU7sRRzpz5WzvW6xC5uRVLJIG7uhV2p+VXMyzsZgfsUJihRAczEf1aH7bsEjULO2yFYXVOaDtULTjaaocVGBnRTumIpNo8dZp04gvarNRFurMMAhW1+nLoZN3+aPgeCBIX1nBs40xkZQBwGGECY9s+pY+qWb/A7ncAX9MfmBi9Hf1BTSPDhfwxBpqA3SRJJq0f0Pz9NEHbwdugBFM7fHKb/fJm0vYCUpaBnJxt/vnPrvMfacOfGdpPUwMEdD4Hv8Nr8tlGhQPN5UlY+A==
Received: from DB7PR03MB3881.eurprd03.prod.outlook.com (2603:10a6:5:30::31) by
 PA4PR03MB7070.eurprd03.prod.outlook.com (2603:10a6:102:e3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 07:46:05 +0000
Received: from DB7PR03MB3881.eurprd03.prod.outlook.com
 ([fe80::2b66:ad40:56e5:e31e]) by DB7PR03MB3881.eurprd03.prod.outlook.com
 ([fe80::2b66:ad40:56e5:e31e%5]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 07:46:05 +0000
From: David Jordanes <davidjordanes@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git interactive rebase does not allow editing commits at once anymore
Thread-Topic: git interactive rebase does not allow editing commits at once
 anymore
Thread-Index: AQHc2HVNEzatREayVEW06QaekmyLpA==
Date: Thu, 30 Apr 2026 07:46:05 +0000
Message-ID:
 <DB7PR03MB3881199B8D12CC7A981ADF0CA8352@DB7PR03MB3881.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR03MB3881:EE_|PA4PR03MB7070:EE_
x-ms-office365-filtering-correlation-id: 01e49ed1-aa3a-4688-9729-08dea68c88d3
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|15080799012|461199028|31061999003|19110799012|8062599012|8060799015|51005399006|24021099003|440099028|3412199025|3430499032|102099032|40105399003;
x-microsoft-antispam-message-info:
	=?iso-8859-1?Q?Q06Bn31st9YD7kRma+DzzK1QWJNMgaxZAFXoKHnktshYMvgSTikiWdB1mP?=
 =?iso-8859-1?Q?Q3v1CWX4KOjGeInynN0UbSaXqz28k7W3Rwgr4BkKmOnjV8LF3vNKEP3mMu?=
 =?iso-8859-1?Q?K046lGitmYbRv2Yb5L6G3FcyPZoZKFn9JmdsZQrzTPVYkhIbqPzS4siF84?=
 =?iso-8859-1?Q?gEIkPWNGk2l36jZIt4HYCg5e2xaX1rmHlyZsRZ7xlKnct2DS+tYAURhwRf?=
 =?iso-8859-1?Q?zLslry6mSFUix4xlu0f3UnEQdObMm/l9woc7UKcIDi4F9i7rvV7ahauLaD?=
 =?iso-8859-1?Q?jM7eJeieI/S7X7pg7I83KimUPTOXPJLrZDLWOqT8SzQ27mzQYVRpKQcjS7?=
 =?iso-8859-1?Q?j7G2SjRtKqhFSp2EMJwIjqYk70sUxprw4VC794OOOV3cfM+YEb4TSP3Gva?=
 =?iso-8859-1?Q?7J48Jj6LT+N4CT5NxWdREinyJWnp9X8nJ8g5zCRRkjpXePPnnStYR+sZ1o?=
 =?iso-8859-1?Q?JOnqHXkdVUgJbayH03LwGuGXjSsrLLWboDSiOC2PXmGx06E8cfG2bxurdU?=
 =?iso-8859-1?Q?hLiypL0PueHSv3EAtIqctRQEXzoCm+YTDOlvh4Wyeu2jtlTD61TDylSHn5?=
 =?iso-8859-1?Q?mRpf8NtZWj15356HbIawTbHFpxKsld8PZfMiBCtuUAem/oqDs/yPraKGdf?=
 =?iso-8859-1?Q?/qQDmzm/isyaFfq0Bzo7UBcy12AGux3YJOtwiEHiomUUsGXoY1LpHenPM9?=
 =?iso-8859-1?Q?lmhbJv1ZAbZLWpV0v4fw9/vTDmz7JZlB7R6h3I0jYkynXLzfYw5X53tBxc?=
 =?iso-8859-1?Q?Z8wNAb2fnBNNU/7uoIGK1dzTX8SFJFIbUlr+fo/v/Xdyl6s4kHF6HORRfe?=
 =?iso-8859-1?Q?0NesYVkjTtxgeyURChgaJ5+YG0d7dJyevITbb81mzRKBG4bqKzMILHFAYC?=
 =?iso-8859-1?Q?WQJaO33cRzwMGRK6w81hgzJvnV4iIgoglpzM6M5q/4CX14Awrj4kdosCoO?=
 =?iso-8859-1?Q?HUAVt9AmH/pCQejjVn8Zpdaj+5Q/tk+7/6MVAugK3d2wVrseSvmHCg=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?txpM3T2w0qf8FQhWXvGRmEum42Xa+2AzjcFcHyzthXSW3jjknF9OcGxPFv?=
 =?iso-8859-1?Q?ZRUkoTDr0ac9ULfHyPTF5fZKpmL1hMoZmdzS5xTIG669VxpmpbMHuIGW11?=
 =?iso-8859-1?Q?g6PxbILj9hXekDZ0B53qCIzyev7JtL5PiQjOrgkVr+GlWZT9mO+X5xvdbj?=
 =?iso-8859-1?Q?PqL7jOeDjuKIX0zip4/naQ7S4cRh1FF+610P/QiStgkT8sN90jR4fiHL7f?=
 =?iso-8859-1?Q?YMnxrTDbV6GR1/Dj8LHSlKyUV57h09TZ9ow/Y8aQeDzfavFZTxB2cSnusr?=
 =?iso-8859-1?Q?xGaNPmypksX/W7KSCUULN8mvHRf2yPK0BY064nUQphHQS8auPyEN4iKnjd?=
 =?iso-8859-1?Q?LzbCRBCRSVxvXpjps8WzrNEZiKJJpEuMKN7ztoROyZqvdXlCiys9YDPKpB?=
 =?iso-8859-1?Q?dGWgyiB7vhJ0ZcyI8uDcvX/51YFDhMwKR2ITYJTlPTjQQQBvDAgBxkzpl/?=
 =?iso-8859-1?Q?GwS7C04cX3i1BJ2nucEuy8kSFtgHUh/Gzl3kTQMkLNn1z/hc6CH1f1zdfq?=
 =?iso-8859-1?Q?GABJd/qObsdf0rSdz7CzNXPlIz2zw/qyOkH+RacNKyzaOCrgMhi0j/jXdC?=
 =?iso-8859-1?Q?bwtNxLHhQb9Jwz97RAObrgK/XIxvp8ngaKdc80952Wh+e6/G+erCmqeIxf?=
 =?iso-8859-1?Q?zdUVG/A3tDZ8j2MV4cvoyPz8rO2xHGzIOkMyP1UV2MTy9XWcm9ZTI61Elu?=
 =?iso-8859-1?Q?6iQ9ckAgJ1VijOf456+PsEMDs3fplizF74N19uBtsdpvy3BDzt+SUwTBIZ?=
 =?iso-8859-1?Q?VfjHcTV5FWTU+AlMugxWf0nbHMUhsv6yMvcnrp6+BidALfHA2XbQXIHlZs?=
 =?iso-8859-1?Q?Nm322oXhIaeSf47Z1c5Ma2hJOK9ZhQuN4ioWizPqJGFAy6xGOTRoqD8cU1?=
 =?iso-8859-1?Q?ERWZNBGgkxm5isVFOWJTsx7+m3MykGdNwnndpDG7yDFNtzE12X8kzDWIr9?=
 =?iso-8859-1?Q?wa528TnoAYc/OizXtxPtwTfjtzVpeovmBguh7H3MrKnpK2zOGXcm09tDs9?=
 =?iso-8859-1?Q?TrY8mnmxNyp4X1+Mtfa0I4ngK12GMWXDtJDrhtVY6xI7WbuA0ObiqFaHIk?=
 =?iso-8859-1?Q?hb3EXJzmxzqZZwtQdR7X7W+INXLfwcxhuPp0L1HhPYmpXC/rvNfnaxFo2c?=
 =?iso-8859-1?Q?T7uiFQS/YkbfGvB8G2ZLPud+R1y7vDVMP9HrgHQ/XfNS2rzagAzSPLyQ5p?=
 =?iso-8859-1?Q?MQDZS0LYpcm6WqnuDN2DbFsDBjWf8KQCbog9Dmcma5AURN4zDN3wJUs5Hz?=
 =?iso-8859-1?Q?iLr4rklPXrftpghUhWXcG8bTBXvPs5mmP10V59HtZIXMLCv1ZEijhRct9T?=
 =?iso-8859-1?Q?q0ShuqQAfeG9J//K3zoy9pc1smNmGXQSMnIuOktCjoSmMeX1MK0OFg4ghC?=
 =?iso-8859-1?Q?/CrD5EGad2OiF3nNz5sjMUG68rsV6L7/B02pfBdtkSIhQnpi6929JIEeiD?=
 =?iso-8859-1?Q?ezL5APFGt12WodMBtSNHWyM9bEMNUo7tgyXiM2sTaZV0wn03a1rpnnkINc?=
 =?iso-8859-1?Q?bzGzj6ulCpUq33QMRXgvXi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB3881.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e49ed1-aa3a-4688-9729-08dea68c88d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 07:46:05.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7070

Git version: git version 2.53.0.windows.2=0A=
OS: Windows 11=0A=
=0A=
Steps to reproduce:=0A=
1. Create a dummy repo=0A=
2. Create a couple of commits=0A=
2. Run git rebase -i HEAD~2=0A=
=0A=
Observed:=0A=
Lines in todo appear as:=0A=
pick <hash> # commit 1=0A=
pick <hash> # commit 2=0A=
=0A=
After editing:=0A=
reword <hash> commit A=0A=
reword <hash> commit B=0A=
=0A=
Then git loops each commit to edit. =0A=
=0A=
Expected:=0A=
After editing, all changes should be applied at once (no loop).=0A=
=0A=
Question:=0A=
Is this intended behavior? By whom and why this flow was decided? What prob=
lem it solves? If I have to rebase interactively 10 or 15 commits I have to=
 go through all those commits one by one???=
