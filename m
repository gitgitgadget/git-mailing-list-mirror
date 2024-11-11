Received: from mx0b-002b1501.pphosted.com (mx0b-002b1501.pphosted.com [148.163.154.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F01150990
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363746; cv=fail; b=q8uPnTAC18XiCgON3mh8gEnokhSiMVYdSodf1ws90z8zIoX8iOtnMmIlKmZocFGg+8P4Eme+sXPYvWF0GrPPefjj4fgtuLZ3aUqYWhTsD+iJ3o/i7BVgiIYZ1uuzeLaXOOwcImUxPdRaGaoL1NieUfdEdlNPld7tUJ8kwNnYWWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363746; c=relaxed/simple;
	bh=zvkUmFY3+3LJU74pUhB8lYm7eNHjD7B8frINYtzywww=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JpLorb79+1gUElFnWL2UhgJAa5MfsOuVtxjrsvaoZxGDpJ+SFGPMtjLlCkcTCeABHFUnkOTEEmxxze1wiCyXneaZMfuiyF2BfAXXwYxutOXqqGd+GCC9C4Xgoo0tZHXNDuPRNSi5e3kPQMfeUsp9hUtoybGAcbovhJaQT9MJkak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com; spf=pass smtp.mailfrom=epic.com; dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b=W353d00t; dkim=pass (1024-bit key) header.d=epic.com header.i=@epic.com header.b=cS4xfCNu; arc=fail smtp.client-ip=148.163.154.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b="W353d00t";
	dkim=pass (1024-bit key) header.d=epic.com header.i=@epic.com header.b="cS4xfCNu"
Received: from pps.filterd (m0119679.ppops.net [127.0.0.1])
	by mx0b-002b1501.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABLWx0V025830
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:16:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	2k24; bh=Ky+OCNBcWJ9cxNnT6NTM/qj37imsKCQ1vCghtkFRY+s=; b=W353d00
	tO1IV0nsINoMlIQjT0xIbKcS70c3icl0z1YPEDjCj3WaqgWqmieqIIau5rHdKK+Y
	Mnnll5b5QO4LnjtV/7/OsusVv3cNhindb2i6AyNMUIqse3iqkdyWJhvRSU183WtX
	YTaAAWnBnBSDA63tDKh1uwIu0zsb4OTxfr1TkfWRZp8RXhnWhiZoHFl6Aiu5AHjP
	86CFgzfwxUovyTBP3i0/edD54VmcMueH/SBV8n9yheAE39nat8FOXbQjY+WUpJVP
	4ylbmFlC/ovGxVW6+chSZmQ9zVnnRK3RMqrNB1AsUidbOrocURYrpgfDoPSs1DgG
	qOCYN0YS9QqVu1A==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-002b1501.pphosted.com (PPS) with ESMTPS id 42usxj839q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:16:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFSo03EN02MKV13c0JLYJ05gcalHvcW84QXOIX0ed6jw1nGV+37g6/ONcjlPhzdQB3yx3JgD6Q0l7jI7uQDjKdmb0J6mFTYM6yF/AFKUMswdTTpNe/eTte+ak86dybAMJXfdiqGEdeRG7/H8wR9gucgK1qlwW00yM8CdbJt2CO/WWxTMqIkS7MCQZh/GoEghRRH16id+W+aDztBwPnJr8o0tg4VGUF4RZPkWC10qHVlkbjg8s0tAEZZBfGUwaAooIOX4WhjoZEh1S3RKr3Lv1THqcZQLk4w4Tqkeorq5ZACVOPZyicPz7cnIy84nVJ6uRLUgHbAUj/Cl1JearqFnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky+OCNBcWJ9cxNnT6NTM/qj37imsKCQ1vCghtkFRY+s=;
 b=QYEhVOR7PKbgZsPDBoNpYh3KjWmfklEUOz8gFLk7wSvQkWw/gLtkYUhlza/+xl5TCsSPRhql9Yo55SOt5j2dO8dLy7nYdc3q8m/Yg+AR8JU/OM/GrxFfBfea1uerG0qqwfXO224GD6JjVt0hguoAtFznBjjnAdPZHpLUzCyjE/kQH2lH/o7z6ZMv7uz+6DX2F7g+921VfXknMKMdkEQqKnlD9kP6eTXR3jknrlpfJjeuN6C/9oU9bRONEsxDFqNc+qQp/ptiDgLShmdUNrM87DFj17dorfjo76nvMDM+GJeudzEOQy36L4BPacBp1PMltR/HetOKqmUf9F84OZm8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky+OCNBcWJ9cxNnT6NTM/qj37imsKCQ1vCghtkFRY+s=;
 b=cS4xfCNumkuS1s8ZOP5Up9Fkl4rTgWO9XKm8qaTwtpWkYlmqj8Hb2Xpn99nAiVgPeU1gPy0uiCG7seqLHFcT45sD3yk5ycLQCmiGThahVwkj2QPEZ4QUEorjQAXBqZ9PVwBUTFn3ICOhIN3AdVqmrhqTEldir+e9ZDDZ+FvrODs=
Received: from SA1PR17MB6501.namprd17.prod.outlook.com (2603:10b6:806:339::15)
 by SJ0PR17MB5705.namprd17.prod.outlook.com (2603:10b6:a03:387::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Mon, 11 Nov
 2024 22:15:44 +0000
Received: from SA1PR17MB6501.namprd17.prod.outlook.com
 ([fe80::ec44:513:300e:5d45]) by SA1PR17MB6501.namprd17.prod.outlook.com
 ([fe80::ec44:513:300e:5d45%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 22:15:44 +0000
From: Eric Mills <ermills@epic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG REPORT] git fetch --prefetch with incorrect options hangs with
 2.47.0
Thread-Topic: [BUG REPORT] git fetch --prefetch with incorrect options hangs
 with 2.47.0
Thread-Index: Ads0hY/TzdkSuGeVSKKmXLBoKSHaKA==
Date: Mon, 11 Nov 2024 22:15:44 +0000
Message-ID:
 <SA1PR17MB6501281EF202EA694CF9DC03CA582@SA1PR17MB6501.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR17MB6501:EE_|SJ0PR17MB5705:EE_
x-ms-office365-filtering-correlation-id: aadee521-a58e-414f-b7b4-08dd029e62bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fAhZY4fqBdf8mzFAsH27l2uuVfEKAnV0K/UZYeP+xwtLglnMwUg4QROFOQ?=
 =?iso-8859-1?Q?mzafNIaVGhVU5L5oSinEI7uk5HFJx7EcNCzISULR6nEx/pX4FkHtAl4903?=
 =?iso-8859-1?Q?NZfy6S58QIOE1sg4CAHj5sEM+1A3/lVSULEvLodkOb4hIQS+frXyKbRugZ?=
 =?iso-8859-1?Q?0lyEdAy2nsZQt4LANCPywFHxIQzivGnWH+OeLt3+daHON8XCDsW3xzO9ET?=
 =?iso-8859-1?Q?nTWQMt3cdELyfGHFgc8uUh67Uxt43wv5kKD3bNDLOgcvrZHTzCJ7CjwLdv?=
 =?iso-8859-1?Q?BeKe7ZoA+UL88e6hVyU5rDZBx3trmEUn9b6tVgQ0TYEdrcGdQuzyzTbWJG?=
 =?iso-8859-1?Q?Y+xqLdmPB8Gb5OonpCpSeHOg0Dl3XZUaFoEOfHzQSErOhBy7WxQVwrEgHA?=
 =?iso-8859-1?Q?XjLeVP9Xl7xCMLPDzkifYGw6f9vMn/hTCOmhXj5O7SMoOTMmyeumxjb4OB?=
 =?iso-8859-1?Q?j4Yho5wFDvvJG1uenMCO7M6V1x+SXjoY5pusQr0XILvN0TSnjLjZoYYWZ8?=
 =?iso-8859-1?Q?0nmp5bpxBb7qiOLSIBKxstN90DCVUq3xeo2dig2kHt8lorJOuTzOG7PQwe?=
 =?iso-8859-1?Q?7cxKXYpSdR5TUfGRak/WO4ywC+5M/ZWhK7JH/nBkkvs9tCA6G3YUyfu2l8?=
 =?iso-8859-1?Q?LEUI+9toRk8qq1Lv3UifRQhDXH23+FqtZQkQrn8Zxl8kM+mSmTr2c2wL17?=
 =?iso-8859-1?Q?U9PLILgtB717mfbdAQkcn2+YjH+Pds3HT6LZFU0tN//56zxAjPIItzV5dg?=
 =?iso-8859-1?Q?cGH+lsgZEmusgcCknDIZa6XGb29ZF/BOmqVreEpIqpBfO8mvEEO3IQSqGq?=
 =?iso-8859-1?Q?ErRbuumbALu6ZfhEw0CtlIvRwQ+9PwthxvzsMSWUWxkUmh8Fio7icr5WQv?=
 =?iso-8859-1?Q?hH3Jp0hCQH1+A+zSg7jsYzfWNR0VHRGufhewkR4fz4V9s3TNUndbV/0mNB?=
 =?iso-8859-1?Q?K+0BO49xMon8CpTASkpyKyvFUYksnoGPP07uFkptA3QC6VwYHN1Y4a1L3y?=
 =?iso-8859-1?Q?AcnxVpAOq9C1SqvwWUwZUm9q2yb7CHjioORrfxtUr6Ojf8DEXy0RL42PKn?=
 =?iso-8859-1?Q?yuJBZlPIILt/i3yYWK5JhHNn6t2I47q2xotAB5KpE2bQYqhArE9cxtBPYi?=
 =?iso-8859-1?Q?Ar+CUbx2HM633SKCMzJgDp9t2BqmKTTUPcf4FFhrYj0j/QqQ+29hbALbZw?=
 =?iso-8859-1?Q?6npX0bfrCknLgQERuo8cJRhHMd7IidZB+OQlOnTo1xNxf0ejk1zvZGvqlm?=
 =?iso-8859-1?Q?yABwYkCnuRmQC9Y9M33a+yVHqszq3CF/kR39kUWsyN3Z12SfIj6+Q0NgE2?=
 =?iso-8859-1?Q?7ubEANQid56ecG6ZebcvE9TlkKFQxtzbkag710HQVkuq9QEwJYsjV2KeIL?=
 =?iso-8859-1?Q?R/LSKaMPnY+sHaXv/2P5/uYmI6S9CPUmVwo9gkz0/AynM3VspY33T1d67U?=
 =?iso-8859-1?Q?0jnC7PG5clyYQuN/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB6501.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1/2mgC9zLdhjbtz2LO7QjiOGbkgRcAjJE0e/2MqRRaMJez8V5hkfCHCBYr?=
 =?iso-8859-1?Q?LjU9x2Si4xHWha60OiVLGVRh94YvCD5LZ+4EKo8Oe+2JB5ySbgM727Adpg?=
 =?iso-8859-1?Q?K8z4Qdw5WwwGjW2ZLZE68tt4eFEQplj5VuAGEfSSmHdynLAzlPJ25j80DJ?=
 =?iso-8859-1?Q?R88LzAbRCMb5gT8vtu6lHXljNbsmJisZdtIO8BJWVV6FrmRGYXUpg/pCXq?=
 =?iso-8859-1?Q?14CrXOe+x72qLkVkpvgdlXPq49jrgfSqgEpaWoup0wlcSgafdtca19K8sp?=
 =?iso-8859-1?Q?ZPam2XO+Kq3wv6ZPfzq7YbKc8ZPHSi888749f4UVpAD+9wQE0g4i1giCvd?=
 =?iso-8859-1?Q?kI04DU3y/HnqSYaLDWtMSLcB4yBFmUKHvXS2TeRvF3Wqtr/8i0pgh8gQDx?=
 =?iso-8859-1?Q?0/Si50A1sGCxwf2vocDeG4zvHYXQMBgsLmdANgmWwvh6LLAoh1TdK8187G?=
 =?iso-8859-1?Q?mCiVRYzX6Mw7OC7LZmjaMVtRXskIBLzTwI/jo5FLO/ZEW0jEYWO5fN8H3+?=
 =?iso-8859-1?Q?9bBdsOuJxRkSUpv51lExCzZUlfbWdEmtwjxRdDaZIrmLK3PmLRS1uZ9pFx?=
 =?iso-8859-1?Q?VMaTXmW9QNHD2Tc35+dkUuOjwiywQxXN2A9Us6CFmjd7r5a1WalPUuCZ83?=
 =?iso-8859-1?Q?RsGPppfldp0ybl22wq0fLkt1ILRVNE2wWi1tw+qlwWC6hlY8FqSzKg9ao1?=
 =?iso-8859-1?Q?2Fog1jDq+osTzQ2HHa7sMcRTcmOTQJzglgEqdl8iV3ULYcZ83hJZoTACoX?=
 =?iso-8859-1?Q?+TK/b+lZilu8HMZsvVuEpHgTGBxn9b1qkNR7525NvYq2WqaYJmdLY+Rk+w?=
 =?iso-8859-1?Q?9p8B5uHxCqZYje9O2TB3mm07O+Qf3DJhN0yIKeCTKkusWSfmes6LRX012n?=
 =?iso-8859-1?Q?86gpceAqHc2jdooAGMLYtPdUXlg7hP1E8u3fCRvpkneq7ssR6ZmwrCFXKi?=
 =?iso-8859-1?Q?ExL75Mjss0OFeDlhxpAZKZDRlkuoFk+1XzqfTj6Q2HvEkPqwz9JoFW0wTR?=
 =?iso-8859-1?Q?swUHaH0PsITIwjH3xtntWSev3uwhEePcWCC/mAqPSRHvkbGiuLGLs6sNdd?=
 =?iso-8859-1?Q?sh3Hu96pg60PFsmpwmt0uhz/XzA5ZPAJyTMAOhnAS9OIPMkOMytVRUMK9U?=
 =?iso-8859-1?Q?YL7WyjhB91lwqIGjKkNCJ/4rDQplJMYXaHQ73d5LL8/p56a2cQ6KRUgWnm?=
 =?iso-8859-1?Q?MKVvat63bJK6yGhQK5ZnxfcxF0clRyUK7M83IJvvoblP1zcleannVBz7nZ?=
 =?iso-8859-1?Q?KeFpQwyFfr9F0yakOcgmv8I/+NX71Ywdf2h4gL/Te7HXSB9uYcGbEFidL9?=
 =?iso-8859-1?Q?5uNC1IIHdRW5hKzQMtHEi2yZzvEEoIbacrhQyoZfEu1/2/hLEWOClsTSw3?=
 =?iso-8859-1?Q?9qP9zjOKr4Iy1PMbdbBssOlKUqkgAjBDXk/5idgjPceyCN0mkJ59ZrBle5?=
 =?iso-8859-1?Q?7KvwrqpnYvxbTrl6FXAOX2DdHUQWRFnsI/wO1nGhUGQxhcU2wzuEPYBy0Z?=
 =?iso-8859-1?Q?3D1o+M7GyRtU9e4HgsvbGcLs683h+kPx4Fy9K027Ufxrj5LdNO63mPYL2T?=
 =?iso-8859-1?Q?odi80Y8Jpvsc/nLUbpb2iUlKXb3TfUs7ESgTfmj+0JNHglQyxjXhTUqf3W?=
 =?iso-8859-1?Q?zlAgdLImHP8CQDA3RXw814xyhhGyrwTGebzeZSlPUKN7/DSGCwRgk3P79i?=
 =?iso-8859-1?Q?RIzfwkkgB9isVEkPnL8=3D?=
Content-Type: multipart/mixed;
	boundary="_002_SA1PR17MB6501281EF202EA694CF9DC03CA582SA1PR17MB6501namp_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR17MB6501.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadee521-a58e-414f-b7b4-08dd029e62bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 22:15:44.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfzV9reZyFAA6dH+Mszz+Gf+FZ5GAG6UAmFE2dVbV4GIIYTf3PjLy2ZzIjvmG+2TOdxBp3gQiY2vyWWubiAa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5705
X-Proofpoint-ORIG-GUID: 6G8YOBKMSCf2YM0MLVRgwNFY3g4SFG4C
X-Proofpoint-GUID: 6G8YOBKMSCf2YM0MLVRgwNFY3g4SFG4C
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=993 mlxscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110179

--_002_SA1PR17MB6501281EF202EA694CF9DC03CA582SA1PR17MB6501namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Eric Mills (he/him) | Epic | Hyperspace
ermills@epic.com | (608) 271-9000


--_002_SA1PR17MB6501281EF202EA694CF9DC03CA582SA1PR17MB6501namp_
Content-Type: text/plain; name="git-bugreport-2024-11-11-1449.txt"
Content-Description: git-bugreport-2024-11-11-1449.txt
Content-Disposition: attachment; filename="git-bugreport-2024-11-11-1449.txt";
	size=2627; creation-date="Mon, 11 Nov 2024 22:10:12 GMT";
	modification-date="Mon, 11 Nov 2024 22:15:43 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQpJIHJhbiBgZ2l0IGZldGNoIC0tcHJlZmV0Y2ggb3JpZ2lu
IG1haW5gIHdpdGggZ2l0IDIuNDcgb24gYm90aCBteQ0KV2luZG93cyBtYWNoaW5lICgyLjQ3Lndp
bmRvd3MuMikgYW5kIG15IE1hYyAoMi40Ny4wKSBhbmQgaXQgaGFuZ3MuDQoNCldoZW4gSSBkb3du
Z3JhZGUsIHNhbWUgY29tbWFuZCBzdWNjZWVkcyBvbg0KMi40Ni4yLldpbmRvd3MuMSAvIDIuNDYu
MiAobWFjT1MpLg0KDQpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJl
aGF2aW9yKQ0KSSBleHBlY3QgdGhlIGZldGNoIHRvIGNvbXBsZXRlIHdpdGhvdXQgaGFuZ2luZyBh
cyBpdCBkb2VzIGluIDIuNDYuMi4NCg0KTm90ZSB0aGF0IHdoaWxlIGludmVzdGlnYXRpbmcgdGhp
cywgSSBsZWFybmVkIHRoYXQgYGdpdCBmZXRjaA0KLS1wcmVmZXRjaGAgbWF5IG5vdCBiZSBtZWFu
dCB0byBiZSBydW4gd2l0aCBzcGVjaWZpYyByZWZzLiBUaGUgaWRlYQ0Kd2FzIHRvIHByZWZldGNo
IGBtYWluYCwgYnV0IGl0IHNlZW1zIHRoYXQgaW4gMi40Ni4yIHRoaXMgcHJlZmV0Y2hlcw0KYWxs
IHJlZnMgZnJvbSB0aGF0IHJlbW90ZSBldmVuIHdoZW4gYSBzcGVjaWZpYyByZWYgaXMgZ2l2ZW4u
IElmDQpwcmVmZXRjaGluZyBzcGVjaWZpYyByZWZzIGlzIGV4cGxpY2l0bHkgbm90IGFsbG93ZWQs
IEkgd291bGQgZXhwZWN0IGENCm1vcmUgdGFyZ2V0ZWQgZXJyb3IgbWVzc2FnZSBpbnN0ZWFkIG9m
IGhhbmdpbmcuIElmIGl0IGlzIG1lYW50IHRvIHdvcmssDQpJIHdvdWxkIGV4cGVjdCB0aGF0IG9u
bHkgdGhhdCByZWYgaXMgcHJlZmV0Y2hlZC4NCg0KV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0
dWFsIGJlaGF2aW9yKQ0KSXQgaGFuZ3MgdG8gdGhlIHBvaW50IHRoYXQgSSBoYXZlIHRvIGVuZCB0
aGUgcHJvY2VzcyBpbiBUYXNrIE1hbmFnZXIuDQoNCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3
aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8NCkkgZG9uJ3QgZXhw
ZWN0IHRoZSBjb21tYW5kIHRvIGhhbmcuDQoNCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRk
Og0KVG8gcXVpY2tseSByZWNhcCwgdGhlIGhhbmcgb2NjdXJzIG9uIGJvdGggbWFjT1MgYW5kIFdp
bmRvd3MuIEl0IGRvZXNuJ3QNCmhhcHBlbiBpbiAyLjQ2LjIsIGJ1dCBkb2VzIGhhcHBlbiBpbiAy
LjQ3LjAuDQoNCkV2ZW4gdGhvdWdoIEkgbWlnaHQgYmUgdXNpbmcgdGhlIGNvbW1hbmQgaW5jb3Jy
ZWN0bHksIEkgdGhvdWdodCBpdCB3YXMNCndvcnRoIHJlcG9ydGluZyBiZWNhdXNlIGl0IHNlZW1z
IHRvIGJlIGEgcmVncmVzc2lvbi4NCg0KSSBmb3VuZCB0aGUgaXNzdWUgb24gV2luZG93cywgYnV0
IHNpbmNlIEkgY291bGQgcmVwcm9kdWNlIGl0IG9uIG1hY09TDQoob3Igc29tZXRoaW5nIHNpbWls
YXIgb24gbWFjT1MpLCBJJ20gZmlsaW5nIHRoZSBpc3N1ZSB1cHN0cmVhbS4NCg0KT24gV2luZG93
cywgSSBkb24ndCBnZXQgYW4gZXJyb3IuIEl0IGhhbmdzIGluZGVmaW5pdGVseS4NCk9uIG1hY09T
LCBhZnRlciBhIGZldyBzZWNvbmRzIEkgZ290IHRoZSBmb2xsb3dpbmc6DQoNCmdpdCg4NDA1MSww
eDIwMTcxY2Y0MCkgbWFsbG9jOiAqKiogZXJyb3IgZm9yIG9iamVjdCAweDYwMDAwMTk3ODM5MDoN
CnBvaW50ZXIgYmVpbmcgZnJlZWQgd2FzIG5vdCBhbGxvY2F0ZWQNCg0KZ2l0KDg0MDUxLDB4MjAx
NzFjZjQwKSBtYWxsb2M6ICoqKiBzZXQgYSBicmVha3BvaW50IGluDQptYWxsb2NfZXJyb3JfYnJl
YWsgdG8gZGVidWcNCg0KWzFdICAgIDg0MDUxIGFib3J0ICAgICAgZ2l0IGZldGNoIC0tcHJlZmV0
Y2ggb3JpZ2luIG1haW4NCg0KUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9y
dCBiZWxvdy4NCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFy
ZS4NCg0KDQpbU3lzdGVtIEluZm9dDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuNDcuMC53
aW5kb3dzLjINCmNwdTogeDg2XzY0DQpidWlsdCBmcm9tIGNvbW1pdDogMWY4YTgzY2JhNmU4OGZh
ZDRiODgxODg1ZTY0Y2ZiODk0NThlMzY1Mw0Kc2l6ZW9mLWxvbmc6IDQNCnNpemVvZi1zaXplX3Q6
IDgNCnNoZWxsLXBhdGg6IEQ6L2dpdC1zZGstNjQtYnVpbGQtaW5zdGFsbGVycy91c3IvYmluL3No
DQpmZWF0dXJlOiBmc21vbml0b3ItLWRhZW1vbg0KbGliY3VybDogOC4xMC4xDQpPcGVuU1NMOiBP
cGVuU1NMIDMuMi4zIDMgU2VwIDIwMjQNCnpsaWI6IDEuMy4xDQp1bmFtZTogV2luZG93cyAxMC4w
IDIyNjMxDQpjb21waWxlciBpbmZvOiBnbnVjOiAxNC4yDQpsaWJjIGluZm86IG5vIGxpYmMgaW5m
b3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwp
OiBDOlxQcm9ncmFtIEZpbGVzXEdpdFx1c3JcYmluXGJhc2guZXhlDQoNCg0KW0VuYWJsZWQgSG9v
a3NdDQo=

--_002_SA1PR17MB6501281EF202EA694CF9DC03CA582SA1PR17MB6501namp_--
