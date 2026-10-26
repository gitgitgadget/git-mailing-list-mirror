Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793030596;
	b=167tJaK5SEGQces/NQIzrE9BKN3/+j2No7/CgxlPJlPJJz1uVqY78bn2ugOyxzTG+mF4
	 gt5tCKh4X5lVGRcA6/AoQoY4eZ/MLi86eJmTGgcTS+O/wusti47GIdtDCIbKfE0qqGNiH
	 Vuom11cNA9y019WhGtcJ1kRhER1RUnTlml1keUtZCnqzLXLmBVPuxIwsy4sojzFTv+WZn
	 uFVQCQsjYJF/xHcXxk5MXcTGkFGWMIyq0PHPpoyimbEDB4tG2kcNZ/qRgyyAdf2KF2dQb
	 niRciZTg5AWkTouCJ73xsSbMY9KTN9kGD2fN/ngSjnhUF7QVUcLSMem7z1BzWZGbilw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030596;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-MGA-submission:Received:DKIM-Signature:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dLqRkZKFDv41MLPPD7b7ay1/y6pNFBSXWJ/QZFTcKp0=;
	b=rt6KaXBMwVprizzEn9PpvDLLhu3huAvADWFwpxPPMfaorRO9xiVnmHDbi5fY1Z6R2M4e
	 gCl3TWP/8oZ1R35gySt00durw3MHVqBv4IunOOKUuxGwkWVu2wmYBuHrbEBeEVHZqNjw4
	 Oqwvbm0Fil7Q+nXj3yEg1UyOxUTBZDqhqwHVI5KJgt1FE1AXnzB34sic1aBowEmNOxC2f
	 sy2/QQPeobYImT7lNUtF6yiEsDBxDQDrlVgTT+GuEYuUjvOQrm04GVEB29OIERUzF8SZA
	 y72nUUD5yf3hfX+4ikPpuGcIQJkxGttKjw7m7FnQzGoTjcu5pLjKbicqDWzJbSGljGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atos.ai;
	spf=pass smtp.mailfrom=atos.ai;
	dkim=pass header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=lqfyX+fL;
	dkim=pass header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=Fh04CwXd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.177
Received: from smarthost2.atos.net (smtppost.atos.net [193.56.114.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB113606A31E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB113606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=lqfyX+fL;
	dkim=pass (2048-bit key, unprotected) header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=Fh04CwXd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.ai; i=@atos.ai; q=dns/txt; s=mail;
  t=1793030594; x=1824566594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dLqRkZKFDv41MLPPD7b7ay1/y6pNFBSXWJ/QZFTcKp0=;
  b=lqfyX+fLh8qrRdcJC+mEqxmWrbDNwUpOx9nceVN0lui+tDgHhCBqsjpL
   d4sTMfdrqt4awpfG3nmmBkHJYX1AWaau1c/5tXadIdJjbDiVkGIFETscq
   srKIt3nFHfPIt/SSf8054D5xSGd8MzgPk5OvqX11b6O6U9zvUJvDtNAYr
   rpJz2xileeajPd+kYsEQGOxhbJk3NwSKFPOkYWQgwXqoDroEqTEdoFDhv
   l3ayLWAcl+mzs7N/84YyYnoQVW0rJLig2bDgAXRvvk5AjumZ3KLjLzEKV
   5numBW5ZrpVa1MDKRs9x6u8nqqba9zCF1XaeFwScmdntjnIQndA/ftLq+
   g==;
X-CSE-ConnectionGUID: j4lI/60nQvq8f16pZrtVug==
X-CSE-MsgGUID: zyZ71TlaQ+ab1SNZ9FN51A==
X-IronPort-AV: E=Sophos;i="6.27,179,1787004000"; 
   d="scan'208";a="884586497"
X-MGA-submission: =?us-ascii?q?MDEZCrHeM1KozVPFaJ4PlgIJUBQCBodX7VF0TJ?=
 =?us-ascii?q?qYYZJcGaNqZU1I9f/et+DHofAZFUKETTzyqmsnjFnuCxCNCZpOBMXJb0?=
 =?us-ascii?q?oW0bI7h3nHeSxB+4S643GYUqj/oARowj5FhtUQ7cgTva9Lv0MllG+clE?=
 =?us-ascii?q?9h?=
Received: from mail-gv1pr07cu00107.outbound.protection.outlook.com (HELO GV1PR07CU001.outbound.protection.outlook.com) ([40.93.214.103])
  by smarthost2.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Oct 2026 17:03:05 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI3qp3UW5Y4VqPw+X/um1xjMMC7SmIc/gKH2IVBvJC2V488QkbHFV1pUZhOX8XS/obDNKhoKqzNHam8KOcJLXdmvZabrQGyoRGQuNfkZmwy8CRDVHLFb0cIB4enPwfiYr0pP1z28goSd2Ra+GzVIE+BHQlmBOd5TWwL7OUlL0zoNSZX4VKyZ9JXPg06Rm7hLZuOk+4v+zT65TcfDbMO3XI63MbdIgPkJHmw+B33IJ+RezEy1ea234KdEWbcW/tY073E1e+iuPJiP8SzZ0gaBZtibJl/Pm4QmDNKTTMhApZqH6RQnLe1vT2MkEkhs9DT+FY1bRXiqfXydDZiH35yPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLqRkZKFDv41MLPPD7b7ay1/y6pNFBSXWJ/QZFTcKp0=;
 b=X/Kx7q5SGLXxAzTsj0J5AdrhbMwCs0aEeoGlMQSkTW8oa7u/FXOR44MKZ0GOBtRaNdQSVDYOFmwvEgruNTguAfNbGtvN+fUluLfm2a3mhcCUWGVWOriqWHSEpWKh5rh60m6x9lmqdrE74UJT3B7u/zhBVBT+yGQ+bo66Uz15sGTYwF+f+HZdr3pC40bME4kbFD5dNkPHChUM9ZrSRaxea+XhLvH7p+ACYwT0qJNevUXQJFpVWG+1FFggrttU0qoKah6RtoiENTanVRqp0ZS74lkUK/W/Q4QO9IpyImfIutRtbtIa+3S+1EUPuf7arfX96iZ03CkruHWrpyi/zeLKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.ai; dmarc=pass action=none header.from=atos.ai; dkim=pass
 header.d=atos.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Atos.ai; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLqRkZKFDv41MLPPD7b7ay1/y6pNFBSXWJ/QZFTcKp0=;
 b=Fh04CwXdMzS3qm8+D/01TpecjfId0CrmLKCE8JW3+0vZRCzjzdx0IPHkKiMtO5dZC4/tW8YwSTbzfiQUSegrOpz2ZAl77++DqOLdOJeWYGHd9+E33S+YXhKtEHHsDga58dYRAIePQzwj8AzYNxAtMKhyPQOZYUG8KlWFAU+NPbgehBcPSadyR7VSJWekOf5r7JwrmEn4P8btR13iDaQJss9NCETixXQe8bRXBdkeKzyzgl07CedmWhlFubJJKjC+Y39p1pyEtbzWuusfARU2+e18lAhFqzAcbfe6dZpQ3/PYVPhe48uqSysmhQMd7yxJzXyLfXJdQiTrsAvQKf4esw==
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com (2603:10a6:20b:517::6)
 by GV2PR02MB11201.eurprd02.prod.outlook.com (2603:10a6:150:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:03:02 +0000
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef]) by AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:03:02 +0000
From: Richard Kerry <richard.kerry@atos.ai>
To: Julia Evans <julia@jvns.ca>, "git@vger.kernel.org" <git@vger.kernel.org>
CC: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, Junio C Hamano
	<gitster@pobox.com>
Subject: RE: [PATCH 2/2] doc: add new Git tutorial for beginners
Thread-Topic: [PATCH 2/2] doc: add new Git tutorial for beginners
Thread-Index: AQHdVcpm9Cox0KrEn0OMrcYDuuWQI7cGwW3cgAATD4CAAR02QA==
Date: Mon, 26 Oct 2026 16:03:01 +0000
Message-ID:
 <AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g> <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
In-Reply-To: <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=e272c64b-662c-47af-bc93-d894098473ea;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-10-21T11:23:47Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8336:EE_|GV2PR02MB11201:EE_
x-ms-office365-filtering-correlation-id: 908c95b5-6ac0-4067-d720-08df337a9ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|261021121427099003|261026140227099003|38070700021|4143699003|56012099006|11063799006|261022115727099003|261009223027099003|261022105027099003|261022113327099003|261021135927099003|261022075727099003|261021123027099003|10067099003|22082099003|261026121527099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 O++bT6BK9J9+kH/Y6LOAQ8HKBKZQ8nLjvUGzI8f6LhtwBls9i+F4aMwL+wF6XBMqjpeULpibcmdMJgwoWtHy4LNF/YWS1eBSe+Wjzl9uBAclNWjIT15iU8lygVSvYz1Xs9dbL/flohT6T/DbCOVjl00FAoApUkxeH1FkmOkDdqqLxCTgbcVaNDU2/dvnRdBHNvrggTQYcNIY6sHuJkkP69NaCtx5fFdolN/1J8Y/n5CDyXKQ55akUIEPwb6f/J93oPMd9OLXiVqGdI4mGwhofKT3iC6pQOGvz6ymb0qlj3LIlhLYeHXrPge/qfW3x+cj8dQhU7bXXT+DJmnj0SWCVhSnCUaOfN4g8q3iZSK0XKYr1/J/jKx79kHw4bq80t2CaK3hdOF+OwHXs2b4B2vfXZ5o4YKzGNmPmJ835uAhrsGqfm/YfGZh2LWr5tenQtM/nmjuE4CCMOm8JTW/O0aQEbemkbT0a8CRPpJvQfjZtN0if1gx63wLjpQy12Ejz6NEJ4Y0pN7lygbwnICHR3VoeDDjVsaoY46Sp4aS29JLPAU+TZRLdOFBgr7qf+BRIW7SdFgJGsAk7aSe4N4Y/oPcYyE5MXJVDPOZOuABK61JKlvvuZJ0g8OadpDlW8nLTQphWvRBu+vLDMOaIXLEafEOBQ/Vj18szcctXMzKz0b4hwAGqfAC0Z66GABTeUd4k2AKL6MdwnjhHbPOIkzjR5S0q+R+1Z+MSKVTgAeWWh15koU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8336.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(261021121427099003)(261026140227099003)(38070700021)(4143699003)(56012099006)(11063799006)(261022115727099003)(261009223027099003)(261022105027099003)(261022113327099003)(261021135927099003)(261022075727099003)(261021123027099003)(10067099003)(22082099003)(261026121527099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Zf4T9yqQ/qcJ6xnXsQZ2hOygutK2KjAUZyIH5J0/FMGX51Q9JVNTTewjtm?=
 =?iso-8859-1?Q?tuW3EQtW2hN+0CzEvxo2dB07jSZS0WJ3E2ieAO+ZcDbfROiN9F7pKhVeBy?=
 =?iso-8859-1?Q?OxfL3Rk9bpMoRbBKYBdJW1SwrwF7XXRBmJRYJ894CF7M5Jn/M0/UaG5DP8?=
 =?iso-8859-1?Q?qpnpuCLWrvT90aqfIJTb3HoIJa0wk4kTz0oAQ4D/4MGI80+eFroT02LXRb?=
 =?iso-8859-1?Q?eXCssI9APR9jcWNOUkU9UtcRuh/zAiPYD7Pn/gXbTfVVHNDxGN37jWXFFd?=
 =?iso-8859-1?Q?+qDkqglHMfaHet+zmgmPXJJJE3+9269IA7ReHqCJ1I0Ns96riBfVk13Tkx?=
 =?iso-8859-1?Q?z8FMaSdf2JOIh9KJ3ksHTyzRHoNwjXlJSp9PYC17dcubMZQac4coKkKWZX?=
 =?iso-8859-1?Q?KueeJwOfxDbPb3GTxqAS4NgUCBjwzkzRLIjpd52God1bhs8YhCH02vovh/?=
 =?iso-8859-1?Q?3p7ipZBXT4aRx3KcmKfKPdJ/M94k9FhAhlE0l1Piyzc3XPo0WSA6/PV80S?=
 =?iso-8859-1?Q?DxRKuGkMr6vNdNraoSPMftGEHcvn0wuag1u2RwIZmHiSXEzyYgwrG6sftv?=
 =?iso-8859-1?Q?Hjqikwz1NyrRK3VF8cM9z1fsMN78qKOrXv95PsBwB69P1NAi1IHK286S9Y?=
 =?iso-8859-1?Q?KvOrZ4nvHs/5QbNBlPM+aNhRUeYzu7EFSPVtG+c7+3OdvAsWcUJyvVaBbY?=
 =?iso-8859-1?Q?QR1x/vC4NLXzzRkqZK1FAbJ2qE4JXf4oDBtrkZLwyNzDP9zxjtOLWD8/R7?=
 =?iso-8859-1?Q?7dKBA0OoOJj0c1iZMlSlfaRKbEXRjXI5LWWYb/4aRjrzN6m+xPC5OiDaZ/?=
 =?iso-8859-1?Q?Jzmv1f7fQ6f7Oo6Pfem+noninYaSBRXpta5xrmAS4kpoiYzieHnDzIUoGT?=
 =?iso-8859-1?Q?f1JtbfX2vahS3BwsNwoVqKzFRS1ylAEHK3Ii/Y5bMcvI6BZSRJGSMi6y9B?=
 =?iso-8859-1?Q?5acEvSUMmhwJq4UcP1LA3dGFE+tz3RYxN07o7fTZvVc7NRRc4KBU84RE1H?=
 =?iso-8859-1?Q?stUXc1FRDjHkRfEcpM7l7Q41ySsQmvfXeaKm32gnu1Ub/fzdZBfQy959Fs?=
 =?iso-8859-1?Q?pML9Nm7xt23H9SttyfG763sRl9EjBsxSVwxZd/mXZGAo33OE3sgEBQgrqJ?=
 =?iso-8859-1?Q?mF98tiacGxCRjBVuac+2T6sVJtxZnEdqhFIxm3OuGzPZmYIOHQZYpZLdjD?=
 =?iso-8859-1?Q?gHyIs4dCUq+RagaibLIYNmxJv3NC1W8Y5o3BatfSVjdAAbTpHhf4K4gmYY?=
 =?iso-8859-1?Q?K9RQ+XafJIPsmtrW0F4eTG6e33fvra0AzBtf3JqKCqlC7pL3FSfrNu4+Nl?=
 =?iso-8859-1?Q?1mkFu3dxY2bq9mwqYJA7oAUkx8iAS9ZspkR1rZx6hHSzkDdro9h+Uby14P?=
 =?iso-8859-1?Q?Pro7MtXP3BrgtzT8lvmCUM5N8E2W2R9+4Fhv9cNpj93A8T3KVj4nN9mkwl?=
 =?iso-8859-1?Q?Hjf5wVXv+Ac42vvfxRG5NN+hecJH58Ao/+H/grSARHGvnDfncmOybFJH2D?=
 =?iso-8859-1?Q?NHTbtyDzfBamEjETgGPza8ughXGmfm+kIX41MptiOYE9LBb0SFdJXirisw?=
 =?iso-8859-1?Q?K8n86WVK7zpd8fcKaoHnBoqKTsf+oWpJkzB4m/YUh6JS4rneitTdniAof3?=
 =?iso-8859-1?Q?yyi/TFIB3yVhtyrJVb27R5/ym5OjVxAf8vJl0PbrVtR4QFPF2iP4HF5zHw?=
 =?iso-8859-1?Q?F0G0DYQtpBGaDBM7ofNzcFdy+lwylx4ajyc9n8CXP8nrIGrKWibKlSIMcs?=
 =?iso-8859-1?Q?a5WISXB/vwMIKds5Nv1TFiqX1M1J1rf6G6kPwU/XXC//IXabOdFCdon2b0?=
 =?iso-8859-1?Q?kU2S58pdXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F6Q0q0Slpe1XYF6bx1E/3ZrqRNwYRSlzg2wmqjS66mlfJnwRS6WT0tNipOhe1NAZtnLcd8QVCXdcCLePOUGz+GHe0li82aUlOYw96M9UKgyslolk2cKliUW2fo0+nA5gQOeAJ+ucixF/2f0OVNHoDvwKoJk6ktJp4cjslPFFzhONm7iNFBgz3FFBZFSqwSX+6FaFcEOOQ0ZtbjsK9hfuqhgyUUbIUPTeknfMalMo8MKHoGLnJ0RDyVf/+KqmVQDRhyg0fYT9gGFVTBuGe+0iWtUiAIux4eR8/Tb5NqvNGisvwnnBKKwORwLO/FF55Sp/Bk2xRRk0IvIPwohor6ndjw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlTCkBHc1wmu6tplbbMBtpLExtzD33L6yYC8l+fWVYmoL3OGrxh0ugtdBdlheSCJM1IqQBmVyXCmQP+0iF6+8TgJ5Y+ZVe7PrhHTealAzgZpLWFX//ppnA4s5WCYKCJ1VAXqIK4ITln9wGrk71HOirvfToLr4c7ejQm/kVPtwVvMS8e4zWCaOKHnM0pDg9+4q0jp3LKRQkW6jITtc4fuB7uqPqQe/sIdh5XMSKOjvGkOZ+CXXN2verphCuEGCh3f2780PvwI/egZhKBUnFgj91p0AnCNs1r29wZ+KGM+qOwio4464SaZDgkRH4ZtZ1BlBnL28M1KZxl+rTWuXk5etOR3MXbsvhRlfI3XEEv+RY3QdZ9jFhBvTf5diye/vi4+L0+ZbVY8zrWirVd/EV1ZYBvwTkRQTlZidEtQbTzWtVVKN9jPGAnLAslyfJK30hoSONFKd5xHk31IwzDW/TYAcj+u8mYmTgsEWCYOACcZg4YdAP+gh0gCcixskcmie316WP2u+xfp7iYn6P3hdIVn8luh8pxf5wC3aPUR53ApAr/u4FM2gskJmKmcF1x6/Hx7wID05JRuaU5s63jkGx7h9eurdw8sfJkz1oFB3woXV47ViAbS0cxrnaZfV3br8AVIoZRFpo2og3n+M+yf3JBea69dbsTNY9p8can74K5mB0obzGvzTnZzzQSaAR13Br+q
X-OriginatorOrg: Atos.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8336.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908c95b5-6ac0-4067-d720-08df337a9ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 16:03:01.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AalDNrP2p+A2oyKwSr5CeblzohLbXHudo+dmvo5/j71MAE8J7/HuH1TmmoLg5ulNL4cPFMaOGSpgvZIbJAXM3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11201


Hi Julia, Team,

There was a request earlier for notes from Windows Git users, so as I am on=
e I thought I might respond a little.

I use Git mostly via a GUI app.  I do understand that documentation for Git=
 proper needs to treat it as command-line as all the GUIs are a bit differe=
nt.  I think they all work via the CLI version and all that I use do always=
 show the commands, so I quite understand that documentation needs to be do=
ne like that.

However....

Windows users don't use vim (or  vi).
Windows users don't use ssh.

I'm sure neither of those are completely true, so please no-one write in an=
d say that I'm wrong, but I think a lot of Windows Git users won't do so, a=
nd will feel such mentions are not aimed at them and may take it that the w=
hole document isn't either.

I'm sure I've read somewhere that ssh is a nightmare to set up on Windows, =
so a first-class mention of it may put off Windows users.  It might perhaps=
 get a note that it's for Linux/Unix/etc users only (or only-ish).  Anyway,=
 I've been developing on Windows for about 30 years and using Git for about=
 eight, and never needed ssh for anything.  Https is all that I've used for=
 GitHub and BitBucket, which you might consider likely to be the most commo=
n servers users might see.  And bearing in mind that GitHub has on-prem ver=
sions that may be found in corporate settings.  I'm not sure how easy it is=
 to set up a local Git server by other means as I've never really tried.

Vim I think is very uncommon on Windows.  The only editor that is universal=
 is NotePad, but I don't think that would be used much for serious developm=
ent.  I use versions of Visual Studio but Visual Studio Code (no relation) =
may be more common nowadays.  For general editing I may use emacs for histo=
rical reasons, but I suspect that's nearly as rare on Windows as vim.  Some=
thing like NotePad++ would be better.  But then again, it isn't universal.

In short, if it mentions of someone using ssh and vim, I immediately think =
they are a Linux user, and I may tend to skip those parts of an article, or=
 even assume the whole thing is not aimed at me.



Kind regards,

Richard Kerry
BNCS Engineer - Media Competency Centre
MidCity Place, 71 High Holborn - London WC1V 6EA - UK
atos.ai





> -----Original Message-----
> From: Julia Evans <julia@jvns.ca>
> Sent: 20 October 2026 19:23
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>; git@vger.kerne=
l.org
> Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
>
> Caution: External email. Do not open attachments or click links, unless t=
his email
> comes from a known sender and you know the content is safe.
>
>
> >
> >> +Step 10: Create an SSH key (if needed)
> >> +-------------------------------------
> >
> > Even though AsciiDoc implementations are somewhat lenient to allow
> > difference by a char or two, but the number of hyphens there must
> > match the number of chars on the previous line, so add one '-'.
>
> I meant to reply to this one. I wonder if it would be better to update al=
l the
> headings to use a different form, like this, because it's easy to acciden=
tally get the
> number of `-` characters wrong when editing a heading.
>
> =3D=3D Step 10: Create an SSH key (if needed)
>
> I don't feel strongly about that though, happy to stay consistent with ho=
w other
> pages do it.
Atos is a trading name used by the Atos group. The trading entity is regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534). The registered office is located at: Second Floor, MidCity Place,=
 71 High Holborn, London, WC1V 6EA. The VAT No. is: GB232327983. This e-mai=
l and the documents attached are confidential and intended solely for the a=
ddressee and may contain confidential or privileged information. If you rec=
eive this e-mail in error, you are not authorised to copy, disclose, use, o=
r retain it. Please notify the sender immediately and delete this email fro=
m your systems. As emails may be intercepted, amended, or lost, they are no=
t secure. Atos therefore can accept no liability for any errors or their co=
ntent. Although Atos endeavours to maintain a virus-free network, we do not=
 warrant that this transmission is virus-free and can accept no liability f=
or any damages resulting from any virus transmitted. The risks are deemed t=
o be accepted by everyone who communicates with Atos by email.
