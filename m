Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021010.outbound.protection.outlook.com [52.101.186.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0440BF2
	for <git@vger.kernel.org>; Tue, 28 May 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905817; cv=fail; b=qgQwTR1DXq8ygU3TJ0lzk/e/O97JiVPZH9CjE7Je+th/epSSDLju6r5AFkR49DB14jUBCMrukAFDN5ri2jnG4t93AJeM7ljM5lSE98zayZ7+DHdtdjSKJZOOLf2u0BX1+zhqiE1wr5tjN++ocB3GwO5AQRd8Aoqmyi8ZIcHWK6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905817; c=relaxed/simple;
	bh=dgrdiJH+XqGv4nrccba+embcnmNue65NNmxYeb2ombw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=El4GqaFYmQSMXf8CJxRvquyKbGLIZImIKYdfd0GYVHsCmJGB7KM2l8AycDtX8qIkQiSClifD490vZ1C7FIztVoTPJVCP085G/8RlLL2vHgWJ0nXzp4tMHMUdDw3ayNlLPaQcCF2gDmnuuplfZ3zrn3s5Tqx87Bqt7vhyulj9CcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=pSCmE+TZ; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=pSCmE+TZ; arc=fail smtp.client-ip=52.101.186.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="pSCmE+TZ";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="pSCmE+TZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI4g2Ppr/Z+q6E7gXhfeyJSzWa8wR2kmScCBzJ1L4NjuGOTycfIQTSglQpHtbIsQG0DMj8byZepJPZzRGYAJJaATwbtS7tWb19RrrC5+aVa/89Bc2VO397DQbW8V23R9OU8f71NWBfqARgSKhRy3G6ZyaqpdL0bZ+v8WJToFmWkVM45BQ0hY+eKMxaKsU6z2Lxx7b8qsir9m3g6Z0Pj8L6PV/mqYiZi7/PDNuCBXhteRnljr+VtGHgqo+rDK4ta/QPcPjXpYQrNnQesmd9i6uaLvg/ukC+OE/okFt6ruGp0xNyGS9081zQ8gUIi/V5pxwCqd0M+jF1mBB9ic50uHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22gSdjrIh2ObvTJ1Ln9wJfLZqY3KD/iutxxDJMqXd5s=;
 b=G2ayo0JNF5xiD07JGzlsE7Ylv4Kev8CB6gml2XZ/X4vUHN27Sj+0767iACtEZQ6152DWZRg0zDrCauks6rtwvvQMc66yZ85IDkGf0XFpIwt7gyww+raEnfTt8rYK3SgSvdf+1bYFvq7HNMN11d5OxruIqwMc8jwzdUKtbBQn2AA7cVjFRPDPdomjlbbS0n0Y27qKzZuU5WKdjE5RVOLwlMIffUFrPIZcukeW11ZoeQ4n/QufTjZGBg8hvEOOZRRq3ou2sWf4m8bRtBLCL7KSyxxuEqgH9XYlGi0BUnW/tq2OAZ25PTfFFjW32PbGF0Iujc3wjQvzBaRkU7ahZEikCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22gSdjrIh2ObvTJ1Ln9wJfLZqY3KD/iutxxDJMqXd5s=;
 b=pSCmE+TZlR3/oE/uwGmNCN9O6JeP3GIRdB12mkeS+VDS5HDjay63wBUSR5b167qvVnYwTREh+f7Gwi9/n6XIZc4z2hkMENnzJpVWgeR88w8E5djM5vFxNl1HMmc51Dp7mGeZIY3B7+TNuw7gIGRGZDqNkaOd/vO4klPd+IIF8SI=
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by GV0P278MB0902.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 28 May
 2024 14:16:50 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::e5) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7611.14
 via Frontend Transport; Tue, 28 May 2024 14:16:50 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx4.crn.activeguard.cloud (Postfix) with ESMTP id D74A67FCF9
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:16:49 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011007.outbound.protection.outlook.com [40.93.85.7])
	by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id 03FC17FCFB
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:16:49 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=pSCmE+TZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22gSdjrIh2ObvTJ1Ln9wJfLZqY3KD/iutxxDJMqXd5s=;
 b=pSCmE+TZlR3/oE/uwGmNCN9O6JeP3GIRdB12mkeS+VDS5HDjay63wBUSR5b167qvVnYwTREh+f7Gwi9/n6XIZc4z2hkMENnzJpVWgeR88w8E5djM5vFxNl1HMmc51Dp7mGeZIY3B7+TNuw7gIGRGZDqNkaOd/vO4klPd+IIF8SI=
Received: from GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3f::8) by
 ZR1P278MB0980.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:58::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Tue, 28 May 2024 14:16:48 +0000
Received: from GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f0bd:eb74:d905:7267]) by GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM
 ([fe80::f0bd:eb74:d905:7267%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:16:48 +0000
From: Chris Burr <christopher.burr@cern.ch>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] Cannot set safe.directory with command-scoped configuration
 when cloning
Thread-Topic: [BUG] Cannot set safe.directory with command-scoped
 configuration when cloning
Thread-Index: AQHasQc+YZFGHJeYLUKigciZWXL5Qg==
Date: Tue, 28 May 2024 14:16:48 +0000
Message-ID:
 <GVAP278MB01511C708AE804393BA3B7A48BF12@GVAP278MB0151.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic:
	GVAP278MB0151:EE_|ZR1P278MB0980:EE_|DB1PEPF00050A00:EE_|GV0P278MB0902:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d64b0b1-3ab8-48eb-76a1-08dc7f20d12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?pcGyp2vqoNQarRtE+NDeefnH2kWDxmiHt3fcix6USEXiayXTBtrMijpzo3?=
 =?iso-8859-1?Q?bbQ5R0VvZ7JHQQOTP6rpgyvvDn6kljQfQxRhsM5AFXb3gHMletCN0Zq29h?=
 =?iso-8859-1?Q?XACas1B0Vb75SM7PaOFEk4r1jNb+fKdUXcpDqgSVY3eaorg8OMQ7IMsRxZ?=
 =?iso-8859-1?Q?mES9PGd4kJjYLCPgsbi42tztO+RTozHE8yFwzTq3wEQ/EV72dXPoyzto0g?=
 =?iso-8859-1?Q?7Q1OshSMd7VwwgTSq7DDCV0Vb4e2lRVM3d1J7bnjCSBdS7tFJ75+QOjbr9?=
 =?iso-8859-1?Q?IPdccvjRXx93WVeogWbwX9DABm9rQiwkbElpBiBC0ZW3u/XG+kzsXWLsXk?=
 =?iso-8859-1?Q?2ogkXYD6sUGRRQs53L0odmDkRTA0BpZiCEQU9RK12rY1Q0rVHikedncGOc?=
 =?iso-8859-1?Q?+PVdSDgO1juTQ+0WrbAsDdLLbBGNAVzQppr42ZKq/ZdPCM31u1kV6V4H7Q?=
 =?iso-8859-1?Q?h/UOPFM/hdbpyi0/+JubXFhThXFavVYgL3wOm8Wx1++7D8ijgzjkE9anS5?=
 =?iso-8859-1?Q?VgcBNypeGWGqBmgNdKpQc+/iRd8FER+N4+jfdrnfJglx7Yc7hsjq/dFCdv?=
 =?iso-8859-1?Q?z0UyN9Nr0fEacsOo2NBtGZkEaa+vzY1K4AqF9o/rHlPfzRw2mU1hJhnmmh?=
 =?iso-8859-1?Q?zyEFjxXrO2J4IjHjoxoXAZ0ScpskXpNvPk5FJepQ8cH1bleWza6eKOqCna?=
 =?iso-8859-1?Q?bbwk2JTF8kvcdg1HFD8e/D/Vv8zhuHcAbBDG4Boi0Z2rnQRQFUHXrvF0Ft?=
 =?iso-8859-1?Q?nbP21ayECoKWYHA/SfT5zx1K8AJaRTaFrfpW6Up7/ruUgRDwoxzTSZErVk?=
 =?iso-8859-1?Q?brwaMLY4b1kWQntCWyNfAs7Aek7re6eMAhro4tP704YPoBnyMVlTJU4f/2?=
 =?iso-8859-1?Q?iA4HDCigmttXtpAjhjhHCKiwkrdbgj02HLqaaUM0+GqlrGQAP2jCvZb/AJ?=
 =?iso-8859-1?Q?PgbI/BxYL+mroEfgvY0kj+Jp4B9+5GNUCuzYsoC+TFMvR6C1Qj6OsBJSRY?=
 =?iso-8859-1?Q?4YIObc9EcikL/uoNzWly7wO0eueaws1t+CJboSxd+shgCm317GVJUnYzHF?=
 =?iso-8859-1?Q?SpH9mD/Puws+eBACZxvKSB6FKALEV6Vp2BI/QD8GYl3pPTpIqURfwCc1If?=
 =?iso-8859-1?Q?u0m7MISbFKy8cOJlfmk8I+LW7EUo3XdvkQebQpcb78pE5cNdcPUpC3u8yv?=
 =?iso-8859-1?Q?kpCobWSLsmSnh3h+fJqyMAgQzjn9rbak4BXKZ1Kj6Q7JXsNlFA/5Htxh7W?=
 =?iso-8859-1?Q?HzNRJWu0kny1Isj3Tc4vxnElAaenLbv28KRJV4zm0lch5hHfAMZ1+2Sko3?=
 =?iso-8859-1?Q?hl5Wji+uKxKgseAGW1NIACGnH988g//+3C56oQl9nxgaBaEtw8qlxUYFfy?=
 =?iso-8859-1?Q?5OK9pdszm3eVjAnXYPak3MJIUW6WMWTw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB0980
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9a21c5bc-6415-4934-4cd3-08dc7f20cfd8
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?xikkuSWXF9oQ/ZmLek/RhJGnu+gIFSpyou1UYeZDUEoKeJeqkDcKsNPzuo?=
 =?iso-8859-1?Q?MnoIW793B+7R4YvfZUCPhRfmR676ljStjqN1FCeasqMACaRbL46nTRL5uj?=
 =?iso-8859-1?Q?UG5kNbtusIiDOCvbRpWuQJnEKbfg7iFkNtGIL81fCc1/yh85u8hfuv4Ogj?=
 =?iso-8859-1?Q?i2ujnmhYEdDPUc54QpePxZclFh+5FDLixpghXtoUZalnB2G2r/c+a3H0IA?=
 =?iso-8859-1?Q?YhmXQb/c2uOQOHKXvNvUb5IZDQMnfSHf3yTXDp7jqglQZD7siRxAqFREAR?=
 =?iso-8859-1?Q?xme0qK+z/glKS88dll9JIN+lAejH7x9LzFyI/jvW+QjHXolzdkaLRxNP5b?=
 =?iso-8859-1?Q?cszt7zrsb2/r2tUMMIOrhqCQ5Gg4YJeBpCFY5WSKFt87jaxcb7+eEKTI2v?=
 =?iso-8859-1?Q?JRJWOHIgcoOWeVYzHxNiLrrnvNPCEAIyRBy0X8i5NgchSbOvprpJ4OySVY?=
 =?iso-8859-1?Q?ZIm9Bebo90+kPYHZg1x1ux3roZWcsFCQ/chn0oUVcVnYhZC7bzmrJ2ebET?=
 =?iso-8859-1?Q?TN8hiYpCDeFa3By+PRyjYkmlBZ1mbrfVJEyHNwaKwKyPIj9Ca61SfZPHEh?=
 =?iso-8859-1?Q?aLMog3RsS/jckVFeWQQMDsfYUkXKOSW4FGobQXPF3XwSAIy57DrbMS6p0G?=
 =?iso-8859-1?Q?wYsQ0bdb7KvL9ANZBPXLdKQ79qu6WauSQPGH3C5ub/P5fHC7hs1j30zx7t?=
 =?iso-8859-1?Q?MKLkOu5NQPx1hZfyiRqAoUmyxBj8yARicuv+S8+09s0N+QdiOYvKWtQOv0?=
 =?iso-8859-1?Q?55LMME4YuAoKH4soNbIr3SMOOGvEQU3DIWMQIB6UlPzDJWqcSUzdqwedZh?=
 =?iso-8859-1?Q?dirCjNll2X/FvfuVB1SfvS/bPelpeDBHuX/+74LGfF9sHc9sGIhcWue4Qj?=
 =?iso-8859-1?Q?rVoHPQ3sKUCRWfsuIESleu8+CBZ7rltu+/Cf1oW2UKGnrp+lzW+Xey+sq7?=
 =?iso-8859-1?Q?XUk0uyL/p/URFK7m0Q72C4ykh3GLLHjgjj53szSi0DzozEo0iV9BxlNwzh?=
 =?iso-8859-1?Q?wStAq5Hn/zMYq4tLpGtbNsMrRhZNsIEHrI7oVbqjisYXu5NmdVfO5Nkjlt?=
 =?iso-8859-1?Q?uoASv29SGkWryVP5yB4QJFpV81nvJzG0FwSPaXWHdpadCZgk01EiL/1ap6?=
 =?iso-8859-1?Q?dG4Tw20tSFyrc6rD91T8dNNyvxI91ls2y2CgOemQp3ZYBvN22h7zeWzHqy?=
 =?iso-8859-1?Q?nu+1Q06eNJbFDMNa1CQHp0Oyi9p+XCOHq4axUpr1XJ57GdZ68lKSqi3Xig?=
 =?iso-8859-1?Q?BYaZv2LSjKSQPY286tlRwDPNXlTPcPLMaxANAtTVhj+NCpHLOx2IvuDP3r?=
 =?iso-8859-1?Q?5C3NbXwTsexlM/etzFKaYA3IRM3/PZut1S3AxcGTx1zap+8sxw7Sw4Se29?=
 =?iso-8859-1?Q?Eg47UwxsjMMe7xaMV1ouOfLc+Kb4uRl0clWSZO6xcNmtbKtCqSDK/E+HkK?=
 =?iso-8859-1?Q?+9CTYqZZ4X13rned?=
X-Forefront-Antispam-Report:
	CIP:51.107.16.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx4.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:16:50.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d64b0b1-3ab8-48eb-76a1-08dc7f20d12e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.16.99];Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0902

With git version 2.45.1 calling "git clone dir1 dir2" fails if dir1 is owne=
d by another user due to the protections for CVE-2024-32004.=0A=
=0A=
According to the documentation I expected to be able to set the safe.direct=
ory option with either "-c" or "GIT_CONFIG_" environment variables. From th=
e "safe.directory" documentation:=0A=
=0A=
> This config setting is only respected in protected configuration=0A=
> Protected configuration refers to the system, global, and command scopes.=
 =0A=
> Command scope includes both the GIT_CONFIG_ variables and the "-c" flag.=
=0A=
=0A=
This works for operations like "git status" but not "git clone".=0A=
=0A=
To reproduce, first make a repository with your current user:=0A=
=0A=
$ mkdir repo-1 && cd repo-1 && git init && cd ..=0A=
Initialized empty Git repository in /private/tmp/repo-1/.git/=0A=
=0A=
Now clone from "repo-1" using sudo (or any other user account, if using sud=
o SUDO_UID needs to be unset):=0A=
=0A=
$ sudo env SUDO_UID=3D git clone -c 'safe.directory=3D*' repo-1/ cloned-rep=
o/=0A=
=0A=
Similarly setting the corrosponding environment variables also doesn't work=
:=0A=
=0A=
$ sudo env SUDO_UID=3D GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dsafe.directo=
ry 'GIT_CONFIG_VALUE_0=3D*' git clone repo-1 cloned-repo=0A=
=0A=
In both cases, the command fails with:=0A=
=0A=
Cloning into 'cloned-repo'...=0A=
fatal: detected dubious ownership in repository at '/private/tmp/repo-1//.g=
it'=0A=
To add an exception for this directory, call:=0A=
=0A=
	git config --global --add safe.directory /private/tmp/repo-1//.git=0A=
fatal: Could not read from remote repository.=0A=
=0A=
Please make sure you have the correct access rights=0A=
and the repository exists.=0A=
