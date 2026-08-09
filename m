Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010002.outbound.protection.outlook.com [52.103.13.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606B2EB5A6
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786298887; cv=fail; b=QnlJMle8YQeX9juVQvlARoWWoyPBcbPIBtiV/7/zbtpRQQktPpCKGg5Z3Q39Ucq6n5m3p6r6sKgwJYDilCGbKZow6vv+X4VJYQgkHA0QWwnDyuJ7RCJZ/7NsQtOTLIjfXu9Pir6pNTILgVN80qAGi0rnMkJXVy/HhyMQKRl0YlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786298887; c=relaxed/simple;
	bh=wFPMzsRMNa2dzdEbKDBUWQ2FOZTKbeG9db1p2tDpyso=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mEgBD659g17RtGXyFIu7+ItoHb8kRyDcxRMDq7RnBQhswibROaej6is2qs1RHxGiwITag6oai/HrPEIiskulNxGlPDLW7hyL6NfEGNJJCSHItPkcrAomSNktMC2ESviCnZaRfEqxGvn8M+BmbSfZKwvMKNpchs3vkKBdYopG9ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y1QFcTZh; arc=fail smtp.client-ip=52.103.13.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y1QFcTZh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+DUgWcRyh5XkRRZKwpDgt++werO9kxdbj67da9qJXSOqcK6kjf3R1T87TI5NB8JG9Hj85Swi+aDHtk4Pxeq+egcA7a1VahYMCM4KvgJi/Lhb4v6bGYr9dgrQ1HjvKxguTvMX1KlCNMS9KiDJQNUm9rhG1V0BWeCexlXwyJnaEJYvJhwi9NuW48NWcHE38SFFFH/COneaPRSPm1nG1XOXPCKy3VEFKGR0JIQ177AuS4LlumE5zOBJ+fs4bqhnFwOtYGGG+0OLizbkZrYxCincShkwX3IiQSTn9zs2B+TZc/6W2b1RsMQTR2yfRmlgjiVeeqxGgGMUIFtjY21z0KWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFPMzsRMNa2dzdEbKDBUWQ2FOZTKbeG9db1p2tDpyso=;
 b=N+MxJhuHpCC7apWC+uHwOoEPPZWAVFRdFY6HoA7ahUsxoxn8AiaiI1NqLPwKSFKv0Yd/qDTeEtI/9vzed5ZB6ad5FVpfZA1qJDE1BSQXczzxkQOKUAZbxd5xhtrOvbFM49saITlzaLMdsjZVvg9UpRWmCdjrDnRG8JCrtn1N67tWsj0GkGAshw8VVQVw8+mlUjlCZJY6eSeaViNreXPg62ZG6BE4gB5A2x91CVJxD86AyUHut0fxPoUirArDKFN6X4WGZkToDBb7YLe3mqzUi5QH+X9CkFLpHvY5SWOx+LQzkJClzOowWYlfu7EcmLycg+YUJxgkDPNL7SGtTD/G9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFPMzsRMNa2dzdEbKDBUWQ2FOZTKbeG9db1p2tDpyso=;
 b=Y1QFcTZhbP72yA/k1gHfrn203guCzgZ+P9fPM4+Ws4FMno8Lj7Rk9Jg4rPYigmSSDbGytMlHvgB0KC4Hh6EVyymrg2Xp6mvtFIgnkVLW2OMjkUUPcNbVq08TU/LY5Qqy7XEpa0hu4Gvvds8oSNNRKdP+nCtJEA5TXFVyjSPftg7MSb7sjuoglxpo4qbWhvO6yeqJwWaV/55O5mu5K7dXdGjj981YB6IiZOKxaB0q6azCr2OAak7dB1w/rAiAYdh3bCvJLAeaGi2yv8i1kvTSXOy2Jxd3nl6EbZ64bHazesx8j4qiKGjoSGOvkzeYQjaNcUD5Y6leG7+ECjoHU+WgOQ==
Received: from PH8PR14MB6996.namprd14.prod.outlook.com (2603:10b6:510:25f::13)
 by IA1PR14MB6389.namprd14.prod.outlook.com (2603:10b6:208:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 18:08:03 +0000
Received: from PH8PR14MB6996.namprd14.prod.outlook.com
 ([fe80::1722:b628:8c2f:b9b4]) by PH8PR14MB6996.namprd14.prod.outlook.com
 ([fe80::1722:b628:8c2f:b9b4%4]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 18:08:03 +0000
From: Srayan Jana <srayan.jana@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Is large object promisors currently usable (and where can I check the
 status of them)?
Thread-Topic: Is large object promisors currently usable (and where can I
 check the status of them)?
Thread-Index: AQHdKCn7IyLoUden2Eic4HU6Q7PkbQ==
Date: Sun, 9 Aug 2026 18:08:03 +0000
Message-ID:
 <PH8PR14MB6996467A2B268A157088ECADE0DF2@PH8PR14MB6996.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR14MB6996:EE_|IA1PR14MB6389:EE_
x-ms-office365-filtering-correlation-id: c968179c-d17f-4acd-d015-08def64127eb
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|51005399006|25010399006|31061999003|8062599012|15080799012|15030799006|8060799015|19110799012|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
	=?iso-8859-1?Q?N4PCmLtJT44PGIJk86LD4yzRq+eZ5DZCQEj0aFHZCbPNG1GU0AyTFNe72O?=
 =?iso-8859-1?Q?mr+ORhoheZjl5AujVt6hBVBiCY1EqQPiTpjGzHDePRlGWIQ4XFNj7EMTfs?=
 =?iso-8859-1?Q?IWcj7VLb6g0hVoxXSwHLc39uXx+NAOoSFHtbf0uQELmkqEvIdsSA/Un3G2?=
 =?iso-8859-1?Q?2HorCiWQgspXdbhouo+lt3e84bGp1RQxzno+reaJtEPRLBXnFAQK3rNp1Y?=
 =?iso-8859-1?Q?K5xS0lAqRVAufEADvQjPUzKTcUt5uC8DythwXoaHFQRb3amsRSPB1HiyQW?=
 =?iso-8859-1?Q?FIc0TZgFQM+Yrb+HlZcPqLXwepWY8vjpBqWQCjFpXPoGF5bCHYdl9FwARM?=
 =?iso-8859-1?Q?gtdZG4zPuBu6M1YLMg+rxbcjfo06+p0iFN3Simp4usEVaKUPvkRXnv/NHr?=
 =?iso-8859-1?Q?0zc0PQaK7FhThHMPbWA5h4qdnFEruA9zNqPDQj1WLlQE7LpqZNIxDSlKqo?=
 =?iso-8859-1?Q?bc4/dSh68baSKMdNrge7g+RQ+nbDKEelRKr4Kdfdk4mMmXfhonxeHD2fWj?=
 =?iso-8859-1?Q?k5gTRLsk6Hs30hPviQix68UcwaIqO0pFPgNg3ZZMSVQ6foHHus5iZuQGnh?=
 =?iso-8859-1?Q?9fhfgvHZ56DvPkW6S3HZOIXYNYgaeuqFM/TGjYB4pTNUWu8vFb+7rFBV9L?=
 =?iso-8859-1?Q?gTavIWa8Hb/O4VomF8hL1b50Bv0c+LlzNAYD1PxPROfk9iHG5zYV0C5Lzn?=
 =?iso-8859-1?Q?lzgG5K8lWSAzlHdM0orq9mXxV4feNywwpYiOrhH5TxEbrTRObdjPr3/HUS?=
 =?iso-8859-1?Q?5Aw61wTxBbwYMHGMMqQe37YMmiNjo7fOI/HwdcKAnLeuwX4K57rSwWE082?=
 =?iso-8859-1?Q?03N3fVmXj1CcsvMaPdk/Vr+rKoUHcxHPHYJFV5hnxv2zF6i3+LKBztIfSS?=
 =?iso-8859-1?Q?baHkhUleMHh4IowJwHMlsX4pvTa27Ulyi/E7z/XQ1uWBTCnQ0MAvI1r98p?=
 =?iso-8859-1?Q?302ANuAC6XdqsVeLIXzVqAVbO0NtRyr+bbSbEE81NaHy8vdijsvtsg=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9D+2UmqzECKcIgx5xsQZVnMRvM/Ol1BS7z/V+nRdFDBGBaGEww66xOeGy9?=
 =?iso-8859-1?Q?QlxsMLUAQUtpGK23mgv+olFurrgFKxdLGC7pQDWsTidWnTSg/kJMMVkeUG?=
 =?iso-8859-1?Q?XKWfUxX/yJeMTyP48YrPc218EnkerXRL6u60uTcTM51FIbppf3sQzMfXSg?=
 =?iso-8859-1?Q?3ARcT9sGwWNldmAd6SECBE/3RHT0lN/K7X9k3rjhqLuh0ikE8MUe0mqQBA?=
 =?iso-8859-1?Q?wQwui1tc5swsO1OjeYXkoQ+UmiOupfBqHEEeuLNmTW3sbbwEo7YLhKwo4f?=
 =?iso-8859-1?Q?EzP27RIKRIs1Wl4mROUiusjjEY24CEu5pCPFa7NPG9ffbbKGDRuipKCef4?=
 =?iso-8859-1?Q?b5LQNY1yhTid9bAjTTsrjo4jT3zupVRNaof7ELRegpztBDYeeP16LqH1FG?=
 =?iso-8859-1?Q?vMvWmUYwZ0QsLiZDUl/ZFd0DmFSWKZZVzRwjFdyvQTL1W8yBO80Sb0YZn4?=
 =?iso-8859-1?Q?kbCaHeRkK2JFeko6Nyzv2ZOTnxaTSKXd3gbbxVZ8LkQy/oDRb+Zz/JuPEx?=
 =?iso-8859-1?Q?BT8ONgyNp/VzLYgmZ+IfL4EtVGUNsjbW2lxJF+P8bkjF5QA0iQ5xBV+oOD?=
 =?iso-8859-1?Q?b5U1XXPQJTXiM+d0we3E8JYflURJ1lFRZcQuCYKym4c+P4YanBK0YWk6J9?=
 =?iso-8859-1?Q?OfQ4WkUZgMw9dLKxDPUGGIg9Fv+N5shoocwL7h3EckNOutFZh8HBRbnmop?=
 =?iso-8859-1?Q?Cw36EcjYjNnXTBqNWrU5lAKfRMnc3KFvrLEIw54mVEj7Xm+VPV4itOCP+z?=
 =?iso-8859-1?Q?0qbZ4aEp4lbcdc43Y/xoM4VO/y6oNvnnpCGNnlH8zk+J0TPcp+YTgGeC5O?=
 =?iso-8859-1?Q?NiiMdDYsi/Yw16HU2MHDkUQ/BCeoARI9UB7YD4GFhJTr94OEVcTrSRdFWz?=
 =?iso-8859-1?Q?KqSoPlkbkonnyFBALvbPzrqm+lM3wtSxkh5LfIHZHMJlqszXPzEtApHpXb?=
 =?iso-8859-1?Q?1ZRK1jK4AG2Pegr4W7tZywKo3/EkHewMGrW9uhsU/jTlDtPBi6+NcW9pX3?=
 =?iso-8859-1?Q?a1PoXjs+zOodGrkEEtkh50UkEJ56ZPuQ7Slz10h/gl0jsbzMXrVLHANRkW?=
 =?iso-8859-1?Q?kD5ZgurzIBd2tkNT+5HayJQNA8kOw/eKHyGj760O/2AcnfNF4/Zpq/jGFG?=
 =?iso-8859-1?Q?UVOXRqmjJecb+6OO1bZplyp/xD3OSqq0jS9zIgo7RBvq9cj4X+/BBiSfMT?=
 =?iso-8859-1?Q?s6JbBYmOeLjqQdZUEQLFBC4IQTAZDZot5foXd01b5MP9b+LKdeA4Giogfh?=
 =?iso-8859-1?Q?hw+kgidDWoJ6RBxl/Dlv0OxA7AMjBw9/Dl/m93+wZbqCTh07Tq4ISk8G/F?=
 =?iso-8859-1?Q?xLpuEmCsFolOJnSPZOC4x1SAFG2Y+RN2tH9Y0SEx3uOlKzHSkT36g7/Kit?=
 =?iso-8859-1?Q?1OemF8XIdW5AgUUv5QG3hzXZavIn++vjPPRycorwTBYGYyEL9qr9PjGmhm?=
 =?iso-8859-1?Q?18mNoQ21mxeWVsO0?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR14MB6996.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c968179c-d17f-4acd-d015-08def64127eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2026 18:08:03.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB6389

Hello!=0A=
I'm really interested in large object promisors as a replacement for Git LF=
S. I've been trying to figure out what the current status of LOP is, and I =
can't really seem to figure it out. Can I use them now or do I have to wait=
 a bit? What's the best way to keep track of the progress of this feature=
