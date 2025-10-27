Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3F28727B
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571247; cv=fail; b=BR7Mj7yrvIMGKxKSnIcXwnIH2Xcrh7bLUYdSzPXIO/h+b6w998SCGm0JyyTppevVpe9EqK0JmfVd/9A4Pb0jsME+koH6lGB1aSl1DGo4HMiSzM+gGllU9jz4Yw9elPQT64iJdnvIJn9Ifk/dygjPBMr0mElyJdpfPw6eqo/PZS0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571247; c=relaxed/simple;
	bh=F8CUgh6jfGT1IeZDpoC5Ud892ELE4Om9FboFggIIcig=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IBueaAxYbCyRJeb/CHGsiiPx0lvC7wjcuCpUiDDGZ62xgNuvMEYI+IJiel2FGqyLiLzSgmW9T0AOytr5pf7tCTG3SUCfEjQsFczD+w0wrQsu17wbwv4R1qJDJzLxks4zQVYEO24t87cRgxXASIJKc0M9sPiVMFydErcgRY4dgnI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sGkojTGx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sGkojTGx; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sGkojTGx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sGkojTGx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qxI7r/PXNfdqm1nG7Vu9KgSngdAuIEXnLQP7+6K+lX6DD08QUxcLXYzmW4yBZrreOQ+jsqfE5NN3cLZKGzqwrqrYA7aVGKAG/3IvuroYstRVNu67+gwz3z6uHZKamXDpqErMk7c4R4SKq87z7Q5h6QW1YOO+8hvAzihFtqaJAtafQGOJHyR0G7UxRTLc299i+RJADzmNTW/kd6ARxymJ+mUav8L+tN9ZB/HIggVQWCJLK/yuUbpNDmbJJYo4cxzT2zGmKh0IaODgkH+7hHjs3ko2I5LMcndWB+ompRiIguMHhfvj1LsnUi/UTduvuDEuZ2IWhYKAHaUvASo4V9T07A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn/EZla/JwsE+lAFDsbDGFLxpd7Q0Y8QYVKHVBjvMEE=;
 b=I5WHLBwkTjNP9kMjz+s6FIYZClV7AkHhE5X9fSFVoNfVeYldRewkjVpVHegkJpZsCid1pC0TtYhSYJVHkfQUVmM4y8QAEeZnhvXku1vmChkfKZ1tHUIzjeZ3ACrIVUoViGJtKxXaHI2mO9dIY60gM8Pk8bOwYMWdDlrCx1bbVAdMVv3Ka3LYmaHlFa/qtmmxtE4qdcylPR9PpB8tDGDG2RpoZuKXI+ERPa3jxD/gMCu9DzQ+Wm9R4ODCGGegUnW2h8yR8vKsWDnY4lq66bfCkVPbM9E3GcgA4Ugkc/lWufGZb+pSr5Q0Jnn3eEpPeFZv9RAUbeaT6asqrIBXA8s6zg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn/EZla/JwsE+lAFDsbDGFLxpd7Q0Y8QYVKHVBjvMEE=;
 b=sGkojTGx6Lcuwb2gv91vS3eqMMQKXfKXmKRkz/MQSUIGPfjNuy3csCudSYsDiEbk5sjVPkjVGSS2mHS//J34EpzE/0NFcd3vpv2BM2dhBeHjE2NRlh8n/KkSDNYAKcbc4IGSjBlwoGFwdaBnRIK+WPdw7t0EY++FQmpleQzXLpA=
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by AS8PR08MB9220.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 13:20:40 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::ea) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 13:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Mon, 27 Oct 2025 13:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rek+GHp3mbWwI87p4QmnuTiFseVPkCeDylP1rwGLWAr5Cxq5j3SVxv4kQchwkzcq27WWfOQACxbn1PBWiOvhtIliO0HVcLJrQrpnJosnaSMXBchQ3wbBoIuHhEfhorZ1Fhw5WM6IkY1lv0Acjy4z2lTRDNHfVOeqIMZ+gdVSSuhSzXxYd3JniaPcuM0SCGwhMyxANhiGjvkaTzKozXiUPWjGp6fZQvdb+mSEBZR8vOCzOQ2G5aJrrL6opHDwKNuC1bEjgTxiykSlMFuxddqZMAGcO8P2Khpcnd+2nLpbrlPLcpHU+QLz2tOya1w3hVbNmXy6Nisp/1ZEkpiBRVGhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn/EZla/JwsE+lAFDsbDGFLxpd7Q0Y8QYVKHVBjvMEE=;
 b=NjITikmpEc2leyMc4kr0OPGnIk6kPNX/QmsjBcE0oy2MoO1C0hWo7ZMKyRPY0+3zuwiJBBtifDXa6zh0yiwh5ARPYWvqC3CMTN7DmF0SC1dPRmN+oRUcC1YpP2U8b2vi8NVM4vgj/6UX6vqyIx6kc4dIK38rI+JMeXs37w5GYFSpRlmk3+IfJxpd96IPPJszE2rG5+uhjwD1ZS8w30QHV9lsYaTbQSRH/EH9crLZ+cQlHvD185sJHAxZfSzl5RkNlmStOsBODsqMOqsOrWfHaUfQoiL1TQmnrnM+TuzhvqNA7g/3kc3ELM/PHCmLvNZsxEbZLNdBIwwKgUaoAjZJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn/EZla/JwsE+lAFDsbDGFLxpd7Q0Y8QYVKHVBjvMEE=;
 b=sGkojTGx6Lcuwb2gv91vS3eqMMQKXfKXmKRkz/MQSUIGPfjNuy3csCudSYsDiEbk5sjVPkjVGSS2mHS//J34EpzE/0NFcd3vpv2BM2dhBeHjE2NRlh8n/KkSDNYAKcbc4IGSjBlwoGFwdaBnRIK+WPdw7t0EY++FQmpleQzXLpA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV2PR08MB8271.eurprd08.prod.outlook.com (2603:10a6:150:b8::21)
 by PA6PR08MB11264.eurprd08.prod.outlook.com (2603:10a6:102:517::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 13:20:07 +0000
Received: from GV2PR08MB8271.eurprd08.prod.outlook.com
 ([fe80::20e7:cd58:1d48:acde]) by GV2PR08MB8271.eurprd08.prod.outlook.com
 ([fe80::20e7:cd58:1d48:acde%6]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 13:20:06 +0000
Date: Mon, 27 Oct 2025 13:20:03 +0000
From: Alice Carlotti <alice.carlotti@arm.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Broken WS_BLANK_AT_EOF highlighting with 0-length diff hunks
Message-ID: <5447f4f0-68be-b554-9fde-579a8dac69ff@e124511.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO2P265CA0487.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::12) To GV2PR08MB8271.eurprd08.prod.outlook.com
 (2603:10a6:150:b8::21)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV2PR08MB8271:EE_|PA6PR08MB11264:EE_|DU2PEPF00028D12:EE_|AS8PR08MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cac44cc-228d-4774-bded-08de155b9fbf
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?YUjVUvJVf9PgJC70U0C4iZweGsBYc/etTtJxUXJeNiD/P/ZOgWtj3xmUR9I+?=
 =?us-ascii?Q?U6FMnQyrZp4UCUlKXk5C3JbvWDjIGwA5yDrLOcZXxAVd7cmhQbf+3hNuRkAG?=
 =?us-ascii?Q?piq9YEEgdeDOwkPJpxx53HyIrxq08a7QsdIvraVZ2LTxOvGwR23ypkkwyCOP?=
 =?us-ascii?Q?Ga2NfG1AVvy3sQae2ibGX6lol48XvWs0Q7zjM05omNwRE8kSb7+qyvPv4J/Q?=
 =?us-ascii?Q?AvGywk1xfzqCVbIXU5qg4WRz15uIC/MPbq6Fld2e0e7PsTAkd/SR7tRGfiE7?=
 =?us-ascii?Q?AhHZVa8WRqL20AwTUeXxD7oUDTnZW13Wt6bm9TmpW41J43m27UkrCENsFqP4?=
 =?us-ascii?Q?Z43aDAqx7MJracAvftuL9ErsY4j9mkH7t+SpcyRuIou0N2E0xkmIC30c2abx?=
 =?us-ascii?Q?I4EPMrBTcRj9D6igV4tZk6VDMXoZWgjbZFnaFA6MU7hOO1p1wrpcbahVdheB?=
 =?us-ascii?Q?KfMCNtEfZBd3YEEVPAOJmMDhHPKBd2oOADyPAsKy4hwf1IE95htd+U+MncMy?=
 =?us-ascii?Q?Qe8YDDViX5jrBCp8/rVAByqughyODl0bFqioIkmudgTEcFzlVSAE5HS+J+lI?=
 =?us-ascii?Q?t7wejwk5P6kN4/fpASmjC++6xoOlkWrBkTuw9U6RU+XxWl/bDHjppKbGM2y/?=
 =?us-ascii?Q?qbKx9M827E+3TIL6s5M829PJKQMJR5TMHY4epIClyyi0t0zrTPVYAt8+kzt8?=
 =?us-ascii?Q?OEYPQFawUhZBQmlRc5gIcBDYsZbt6n2Mqr6qJg10xokcpra8Dz1vJkGm7DDC?=
 =?us-ascii?Q?UrCOf27ZpkFAfUPDg9ZLBl7aIvgXPo2eth+FlY9WsPo+G00xElXp1i/XEc1i?=
 =?us-ascii?Q?D4H2BQxyW+PSX1RN1A83/8CfUiWDFjaNno9VKTz98CX4JDKfd9FqP3xEAQuO?=
 =?us-ascii?Q?VUk4PpWR5AFescdgIoDg07bfJcje3ty9ZTi2icAKH7fZ3VXxOjWfPph5AN8N?=
 =?us-ascii?Q?85wM1AgAYqMAUo4YxToW9XCUuPi/014uHo4jgvh1YwBVTKLvF4mVBILyYREf?=
 =?us-ascii?Q?PttEJfeBw7LlLISFqrQLyfxUOqqEV5YaLgQvhNJfLSG3vazvHWYhLEgL/sJk?=
 =?us-ascii?Q?mAyzkqnrm08Y9Cin3O4TCcnoXLf8ce+KNNyleP3lhW0GzISlwo+KDSLH1Cu1?=
 =?us-ascii?Q?WzQoHS0CEJb4qj+EfTM7rh3yXg8p5/5rxNmoEks77k8/TdoqiaQkcXXyAiEK?=
 =?us-ascii?Q?E0nWY5VaCPpbEYApagxE5ynHAfZM6v54ss3L5EVec3x39Bi9OpSFKbpN5kpZ?=
 =?us-ascii?Q?BAWrDf4jfU3rDaPd16GSB4frkFGjF0G5QnssJz+qPJUDUEhb+azJDbkmVG+U?=
 =?us-ascii?Q?3B9Rw41Gi+T2g2CBecSka37MJaOkY7QHMh67MN9xnBzw1uDOP+NW6e7YE/DC?=
 =?us-ascii?Q?yVvS0YKpEbzpupyAALfczzXa7nX5ddomAv7J7TKdnZTWUbwMuN5cseFWc+/p?=
 =?us-ascii?Q?NiCoU8eyW5nIwPpmCGbIrVEytP3Aazh4CjwBdFi4zN32bE7Zf8hP+w=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8271.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11264
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9256101d-5b28-4286-2050-08de155b8bbe
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t18ApMIVXDecUwZgsX085DtPRDxGudsTGwqAcn3I9G0Q/inZusUmyc/7JFtN?=
 =?us-ascii?Q?6rAnJ5GbFlS8LGRPRy+NeunRP+yUWnmyvvAlwStcJEzKJ0WQFIGt8l/pHEVu?=
 =?us-ascii?Q?6KhejiMtYXdy6ukgn/3+cdcLX4KU8IWnGOHDnl6piEr7iTzWkPFS+BT97xDp?=
 =?us-ascii?Q?5iUiKHBwnMpfHCHfcr9mop2+RqwDga4WZw88AkdL94d1PZI/oWwdpL8NtLC2?=
 =?us-ascii?Q?6a3bjH8Kctt9l1+S174F3sWSL/XoXmj60+zNl8wdDxUKofQu9bzkJBEKsrV4?=
 =?us-ascii?Q?ItL+pRJM1GBJD5YF2TRAcy6m7XhovKfr+K6SIDCLlF8ikBs2Xppg37xjL1NF?=
 =?us-ascii?Q?SnRwBFAtMZ/LSApitNAJgGleRJ8YYWDCxSGScpZfQzotxatqbfw3zQTUi08i?=
 =?us-ascii?Q?rE6ip0PHhOOdf6x3lxcrMobrMxhfc6vFGHmuo50JAmallKU+/F+oIMfqfb+8?=
 =?us-ascii?Q?LfhQInTokGdcQc8EKFm4jcDCqLIqeNyBD5x/Vb1IicKQAWB5GXSv4K0SVQko?=
 =?us-ascii?Q?7mmy6ADWiZRDeHedH8Tvx/+oJKpQeFJjyUcwQUNkQovVdV45RbxnrY9B2oHc?=
 =?us-ascii?Q?gMrxuqhxhgJ11x+19kPpDSYwvbOyEpFH++sMWciNMLfgczXVKljtxNiGjWee?=
 =?us-ascii?Q?8mU11Hpmzw/w+a8ERy/R0ny04NkFH9l4iT5AbB6Lri15QZU1749OTb5D3Ley?=
 =?us-ascii?Q?cv/f/91Q4B8iIWo9giME+B924Cvjn7YRB2Vj31DSwfkcPeopPZ6d/+xbqOT+?=
 =?us-ascii?Q?5MVxcBp2g3knQc0V4QRPXVf9tLekW9+7jgAUfpnmwh01WAW87uuupTDh0h/v?=
 =?us-ascii?Q?uSJ2912UWbuWz05XPTJNzJ/0FZ5I7j50gJQCHOxznmz9xTaIiHsEeSl1Nvfs?=
 =?us-ascii?Q?ph2TpvfQGlz3h84h9yWb9u6EXA2cuPusQRkpzz6UN0UuNOKwWNP5gnRhK6eE?=
 =?us-ascii?Q?cJmIl8U60ueAptM4SB9gyC6mkCsen1AAv0eVBW/7Hc6iUbFJS+PYoh9PbLbF?=
 =?us-ascii?Q?/GCWK6E2+UZoZpygS8mGXsvoa063H+UWzXiiqCd4se6EmO0p5vcSVkWFJKcf?=
 =?us-ascii?Q?IK6jePDtF78madgB9wPxmLPcBmJYg/EW5kXeZNwAiurAHCznr6ygsGFgshC6?=
 =?us-ascii?Q?D2auY+KV/j0uHLj+Cp/k90+HmGCuUAeOTKzRFJIzxuFwKCPR1A/zZQlmeIdE?=
 =?us-ascii?Q?u/EaVncjpf8krhT6xI43+VjpBNPTA8iuZjXWqXmnbl9hvKW+fJpZB+Pu+90z?=
 =?us-ascii?Q?YkaQFqJ4hVbK3YxAKyxys8fS1G5d1pbQ4y2XgpvbtD0zJQ6Aq5MNlsKenJsH?=
 =?us-ascii?Q?whslPPbbIUIu1FVs5I69gl1P8tkpkY2MDlTrPyNjvFxhr6O7ht/za8gIUKVU?=
 =?us-ascii?Q?PcKDNP6LCKtnJzxWfPA+a4s9LhyYkPfKZef1JH453xorAKUmmLMildY8UW60?=
 =?us-ascii?Q?vePB2KCTan2t6peaIiK/M8JPNVGDhRQWYCr+U8Ko2LyZE1F9Yuf/dYERXdkE?=
 =?us-ascii?Q?PRfBEMFag1IKs2tX133HHu/Y9jPs+aSr7E7l52Dtu/11/WGCYWSJqvpN8tmn?=
 =?us-ascii?Q?FuMncw7IgYqjnhaqLA4=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:20:39.9072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cac44cc-228d-4774-bded-08de155b9fbf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9220

Whitespace error highlighting is missing for blank lines at end of file whe=
n
the final hunk contains either zero old lines or zero new lines.  This most
commonly occurs with new files (which happens to be when WS_BLANK_AT_EOF er=
rors
are most likely to be introduced), but can also occur with -U0.

The reason for this is that the initial line number in a hunk header is red=
uced
by one for zero length ranges.  In particular, an empty file uses 0,0 where=
as a
full nonempty file uses 1,N.  This discrepancy is deliberate, and was agree=
d in
https://lore.kernel.org/git/7vbqvictsc.fsf@assigned-by-dhcp.cox.net/.

We currently parse the hunk headers in diff.c:find_lno().  We could therefo=
re
fix the bug here by incrementing lno_in_{pre|post}image whenever the
corresponding length is zero.  Parsing the full ranges is complicated, but =
I
notice that there is code to do this in apply.c:parse_range() - perhaps thi=
s
code could be copied or reused?
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
