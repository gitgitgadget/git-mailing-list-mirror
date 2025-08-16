Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2049.outbound.protection.outlook.com [40.92.89.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4ED229B2E
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331631; cv=fail; b=NQ7jlAEwqvKOeIos56VJS0SWvBPDL7jaNdf3QQM22mQR6YR4lf+3k9RtCt3KqbxX6rTBypgR1iKkvN8aeJ4J+hcWYBjBtlXghG3PYU7+xuJUBIEBHoZj+uaIGkvyXFY/bmr13iO3mE5YyrL7GjdycUiTsYsPjGLAad+JwrWCuaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331631; c=relaxed/simple;
	bh=UEQK93Nv9F/AVUL2iGk7TUT/PRxAaLXD9dRJAKH5jvE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=ZRKDhfrSJXGeP+CDlaznZ1vJvWOcpG7YQ5T2eiPAA+wb9/zBNMZ/TFBhHEE/Ub3E4QhzQQmUWvY3ocTEo10RlkQJEBs+JQ0CNjdTe4PaYmep8hvQcieYdvEK8n5J2DfDZSUC+1oVgNRS+/Zj36FlHra+HgEWIrfiGuSFJ1y877U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=nPM/zplY; arc=fail smtp.client-ip=40.92.89.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="nPM/zplY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REJJAwkuNFY3wL1Fy8M0RgEfMTxA0lVE3P2WM0BD+oWgHxwmLBNnhmxUoHn0zZkkqRCS6uVDKwubAue8ycG5baUIU5TVF1qkFL2AlrtF+yjJPBRLp81zEV/dPypFFV35DU1HWUDHZLqfx36TD+Vlu7UIG6Xeb4CcCU6SZyCsOI9xjLalZNL7CoxrFDrwfdOqxxuxRHrbg0Wg8we9Nz1T1nruroqDQIRehxyZxH2RFC3Tus/xDNlXEVw3lYrFD41aDwIR0vwYc6uqbhD9CyYb/n+xeBvxGbqDf3NPlX5OBiJhHw5HpJz12GM9KnnzEoV7QaDN26RRDdaIKqM7tE9/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWSecAejGLdKlcMV8hjLB26zl8XzJX4jgIxa9tZRgY4=;
 b=wX+g4tCNep0RW+qURdI5A935YlonyHYkQWrK5lSEphnh5f3r6B5Nnns2GzhvlyZjBT1ak17DoLFMcq+huOgNhWuqs4hcbHVeltVo/aOskFBfo6MBfzj3W0hROr3vcRo1V4OPpxmBIEwdoMT2L9nO19yaHZdnOFKjTcWZmuMPXF3/+vt0bh/QIRneYnR0gYtMbM/Gv3jYNskHGm1FqCJ14mhXTXqoRSmD9nPDG27X5uCME6zpeW7llHU6Zw1xB1Ys0LiGIo7+XnUyY6NhY/FCoULAZJpC+yrEtkiIUSjQo9iIVxvOrgTfefiDFC5v6Bm1oaRp5rd6Cjzh0t2b9YRZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWSecAejGLdKlcMV8hjLB26zl8XzJX4jgIxa9tZRgY4=;
 b=nPM/zplY+4GIt9/qrxptddTQsCAQ9I3zses+3sNxdrdL4hLDgiglkFG57AUenAyvACPGhd7GIKOzAy1jdL/sWCMHHbNAROz8oTsjSAvtex5yEm31EC73EYKI9/hO91aVD0vYPkkIbhLGN3gJu6VMvih1ySjLS+T+6gjDXEX9Tjhy33EHdN86Z/uvSjhU00fO4/MOnRVYMCIrxlEbfXRK8daNxtjGeFYqwbOknrrZOBWRPmTKXMZf0Nlox3RcmFx/TLesuPuDb1tue1u02wDpHj9Hgb9aueGao4zvfH3duB0dyu+HQ9Q18kpShqEpqebdkmfiRDsC7QARpc//XPBA6w==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DB9P250MB0569.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 08:07:06 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9031.012; Sat, 16 Aug 2025
 08:07:06 +0000
Date: Sat, 16 Aug 2025 10:06:57 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Junio C Hamano <gitster@pobox.com>
cc: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Eli Schwartz <eschwartz@gentoo.org>, 
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, 
    Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Ben Knoble <ben.knoble@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 01/17] doc: add a policy for using Rust
In-Reply-To: <xmqqcy8wnuga.fsf@gitster.g>
Message-ID:
 <DB9P250MB06923623511AA4E1361F1600A537A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com> <DB9P250MB06923B01AACB69F02170B1E3A534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <xmqqcy8wnuga.fsf@gitster.g>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <d78fbbeb-320c-dff0-10ec-13198011817c@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DB9P250MB0569:EE_
X-MS-Office365-Filtering-Correlation-Id: 34470092-2a13-4f4a-9e82-08dddc9be3e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799012|8060799015|15080799012|6090799003|461199028|23021999003|3412199025|440099028|40105399003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMtCHgTqOEgLUCFR13HcROxTDm8EzEpgWleQwmR+X9TJglXubasz8fRXZNUI?=
 =?us-ascii?Q?PeTWK3Zk5HLSpzi6OzEaV4zyS1NPoBQhFzEmZg8zC1ctiioyYKy8O1GTB9Jg?=
 =?us-ascii?Q?4Hmrcb1YD/y/c5Er/2DRu471n3NpnS0eXSxjG2y0fOj3z7xJHOkAU7TSpo+A?=
 =?us-ascii?Q?Xccv48KeUBLN5KsYJrGIoe4mYUFZblPQ/9tLGWbgDljIBE770Cqt5sEYdPPX?=
 =?us-ascii?Q?hMA0IU7ej9RVlEeNzA95ErRFvpgrk2+dWgkhetZoEfTZ9WEhFtb3cjeHPz9z?=
 =?us-ascii?Q?iU6pV2nuqvRWUynjcAq9Wr/PgA9lnE95zutcUiZH98ihlsIEtP+HOfnKkj0s?=
 =?us-ascii?Q?ODvFB+S3r4Fc6ctNT5QByNGcWxX0oUeEdBJHTD7H44tfE6Bbcy+nexV6CrrB?=
 =?us-ascii?Q?4f0VZu6yA1R0xJE1xB0nzPxe2q8xKBwvylYIffNGlvphDP1gb1FtVkWr7sdI?=
 =?us-ascii?Q?qu3GdpUIBkWADNljsjBqSBXKyDb4b+R72HGX8AbvItsqHlZaShsriykaH3Ye?=
 =?us-ascii?Q?pcFpGAkdgh+FBBgU2kn++VlLNEsUqHPyNGrySWyeUiHWRsubuNy8TgqzCwBn?=
 =?us-ascii?Q?0S5PB7EvMD76cQrBLErnNEdgFJg7BiQiK+AhTCow+ciwpEGz/nu0VyPZ0eey?=
 =?us-ascii?Q?VuMYbpyxaX0DF4k6EBxZ4JnD/4k8u6Q0qKiOtW2XPkeybgLrscqfK012pviA?=
 =?us-ascii?Q?jwkRJC+Rf6EKFPaUVp8G8VXZyaiqGRBCu0l7pRrxYf7CfSzwCx86j8OtVVMD?=
 =?us-ascii?Q?IZf8UcQp0L/+mnf4O0TK4PY6SDaF48MJDFVETGVIWjzED41tjCq0HXJJV5Xq?=
 =?us-ascii?Q?iyZciBeoQGsKxtvxdKnKmqbG2c9M3YLbrFm9uRlgwMSCN3b1zNcVR6mEgYCy?=
 =?us-ascii?Q?E3Uz1fgVY1zFkBZf1+Astx1Df5UtziWui417LRkxDc5MQCoQqZrcQsn6q3/u?=
 =?us-ascii?Q?3VO2w52Pacz34/aFAGI1Ssodm6ATVgkAyya3fZ2A0/YR2wwqIj0IyNUIAUy1?=
 =?us-ascii?Q?9QJYh2zJBV8ouk4Flh+kre9R8OKM9RcZZWj80+ZCEkvQ1uk01sJnzych8ZkG?=
 =?us-ascii?Q?FcCEpDxJjE2DQ0wTuV2YLTRoAHhv40xtSSw0bWZx9n7UxEZD21KkzeSB+jUy?=
 =?us-ascii?Q?JbQRjTzC/st0jmmz4lE71L6qSGIpL0Ja2ido41ElbCh/F5lgGyCXK/dJarhy?=
 =?us-ascii?Q?476qfA6AN+Ck0BmDbVG/E2dRIHOQiIaR7VLmUA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNvs8R4CNOcOW4rHihU0LQWXFIwJ+NKbE2a86r1CMGNQGKU3sfRVMO57euH8?=
 =?us-ascii?Q?wgfpvv5vYsYviOEpuXklvTi+wFRyNIzWVUaHHWmwGmfQeoTLuQulhqud1Ofa?=
 =?us-ascii?Q?Iw2QGeZvXulr34AgMSrHF9V0v5B8rjjsjwyizP3DoMpKkVcK+N7jECTsS8Wh?=
 =?us-ascii?Q?oWxyJfCc4HdKIyUSAnPuG8doU/AtTYzgXD8+TCYxLN4WVQTNAjSPk1KMnQJi?=
 =?us-ascii?Q?b89YCo/uBKDdXsTxzJH1QSWJBfNU1YHXPcDb44DCY1SzovewO3cYATBrHNWi?=
 =?us-ascii?Q?ZCW4A6NFeAPhIi7wdyalT9BygbekRs6DXe5w/6eotejIZVAqP1bFqXYdw6oS?=
 =?us-ascii?Q?8S+RgBvFWB5m/9UEi6zwGPX1yBmlkTtMDCb3pRm+ZdbVadsvvYsyGJ5fxOT0?=
 =?us-ascii?Q?culLW+kgxb/YGvDwb3UK2ib/sA8mkWpYMMbxaz65ypvgaZNTbm1r3qgdyJHU?=
 =?us-ascii?Q?hzC/1IO9jl2JTrzXymUYgMxjztAzzVVlFHHO6qWDhQiB6Au6Mfse3OsDG84V?=
 =?us-ascii?Q?3u950cjR4I7+iKj+313e3xz+GwyFdNhzys6U4F5+AH973NWII60AXgqIM6D8?=
 =?us-ascii?Q?lLEis/nRR4eK4VpaMoj4huUODvk6Eqi5fsW7tdMu/nBAcAAOnGrfzkYMfwCN?=
 =?us-ascii?Q?JDfWtmbkJSxwit+auwywIl/wn2K/E7VFiL0496nKIdTPF0m31feMoBtgkE3A?=
 =?us-ascii?Q?HMZoYkDQL97tgX1JSCzejSe4Z63oMTNFTfGVGPgfjghwOHy8m6V7zuwpMMds?=
 =?us-ascii?Q?Fc4CTaW96c4TqUpxxYI43+ykA5r/LY1m4bgira5Tqrq2V6yRU2IvktnZICIA?=
 =?us-ascii?Q?WAhSPVAN373m9tyT1F/3jiWG2ZC1iqu8YxjNLlW1A51kcIM9psvTV+vKF1/d?=
 =?us-ascii?Q?DpDHYjc755oO1e35E2n32an06U8klReds48oMS9nOUrDEv/OEArDVOGgLbCd?=
 =?us-ascii?Q?suHHEbNDuvkMNAy5GJ83WDf3AnQ+3ol5YQvFas/lZcoNQQJxIJDaFgO14h/u?=
 =?us-ascii?Q?Peal4OvZvzd7cvcjHniAEdIMRTggHXyNm4K/8RGTwx2++/hirOCkjwSYvuCZ?=
 =?us-ascii?Q?NUjhKOqdwCHNoujBKI5FBWnJW6boT7D7g8LbSO0BRRZeYU4NTfKsGrPb6R8N?=
 =?us-ascii?Q?H6z4KzfpdPurNCyIBm9Cy8jZczsDo5Zwu+aOp9wwEI1FDy4WcSd22hQ7x+SO?=
 =?us-ascii?Q?+xvoHNEB/pyUVvbNqyX0b4M4Q25pio9KFYl3Grx7+vwFftv0IhUvWKJJDWA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 34470092-2a13-4f4a-9e82-08dddc9be3e2
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:07:06.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P250MB0569



On Fri, 15 Aug 2025, Junio C Hamano wrote:

> ...could you trim your quotes to relevant parts that is needed to
> help readers understand the point?  It is a bit brutal to force
> readers wade through 200 lines of text only to find this "you got
> .txt suffix for a document with .adoc suffix" comment.
>
> Thanks.
>

Sorry, I'll try to be more mindful of trimming my mails.

Best regards

Matthias
