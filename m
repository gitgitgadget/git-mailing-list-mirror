Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF75A114
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906371; cv=fail; b=FRCYv6MuBchPRy15NRK+ROMjdOZnCOtKcKwAanJEJ3Vx4ekhonsx7BiACphk7vrwtTiwKbDRiXxQYrRcXxq6w0fZnMe77Wsv86EowqWL9Jl5FywRLJ+wOqJc5AlkjbXOhGJ4hxiENbHX1La62UxtJooI0DBoLpvyro1oJWKgsiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906371; c=relaxed/simple;
	bh=SxCrDxX/5wSxYbcmBqTxYu0yu0vMVs0V9DQt4xoT7PY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NiX4sKcCiNceyCGjUjb2UPHkV3mujXYr/BujpFDbKLQhR9wBl/fegPwATwkIST9KSEfMt3TPygc/p1jGb6XvscdBYhG0IqpIiVWdW9hjLYkevsXLfJCYDnth/O5jLNAihGtZaWEL5y12I4ba/9DNL18x1PdlM/pfb81BYaJzbCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=XcVyHO9p; arc=fail smtp.client-ip=40.107.7.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="XcVyHO9p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfa3jtwa7okddcY7S8vwwn2QAsEl0rTgIjVhj3sNR/KC+EqPGYRo1N4WPt11qCLDaCTPC62I4Z6VBbcTZme6Cq38IudwhbihUnh5prBtzAhjEFAY6uLMEeCQQNZzvoN/IDUGvxYKNE2/O6fTT21Si65JyC5VjnByCyUaRfXtFatULIeibJBAn2ZeuDpQ3iEXr26uJkNlbhdWhzlhrbwyHwghKvig7P6cA8W51xXa4kulFZCCjDIuEBE3O4VcQYsKnI3qebnTRhSe9HAre3jQHZsaY1U1UDahZY3bYt6oaghTQ3mlk9nXUTUY+O9tSr7tRngW1HEGzpTOekyyMMwwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxCrDxX/5wSxYbcmBqTxYu0yu0vMVs0V9DQt4xoT7PY=;
 b=lPQ58Yn2wDMvEhEj+HMoLt7HsKnHHgTp9hWMKriqQZvSujP/To65Aq1cm8mc16uwTkaGK9rY3TnKasWf1KF4JHGPLFSEgekZbDBTlgIAm1oDQprQIQITljx1BA6br/Fe6AbDoDAUEWXunnT8vek9yCzGQN9cNovEO3X3gCmUGXilSLlNwd64fLOkUYZ5GoNSald/RJs8Yobe5ctDXOlL/W08kddQxv1sxPOGSSnR928LHutwBAP/mnpwWMNU6n8dmsdmEpsk5JVZHhKodlSO57opdkTeHEBK2TYotX2lxQcHDuTTBGXoRm9gxQ/0+3sUEVaaP0rO2YJncXRxIW2r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxCrDxX/5wSxYbcmBqTxYu0yu0vMVs0V9DQt4xoT7PY=;
 b=XcVyHO9pradIh4yfM/QFK487DzlR/MpP+xbfm14CcIqhLr/co+6UViZu9MBbStI/anBHO9in+8Ba7nbv9ClFYo41C5DTVWr1ShLI9P3kcpaMnkgPct10YTb7XftKQ+M6Ry5vgq3WxkeNn9L6Me/UViOtcCwp15QJRlFAwWcJhDt2Iq/3UUatpp1DfukY1K5ikX5yS2/eBg/4vobQYBDcs28jxX4tx6t2KfVKU2Gge++kH1zx2twtxpJ+IghtMlt7f12sC8/+UtM6+5xJBTPNR3y8c4xNkg/pC08dV1wLpyH2Xmpn7lnwbpGKq7L956goXQ9kmiwxshdFi2NG/UKk8Q==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by DB9PR02MB7179.eurprd02.prod.outlook.com (2603:10a6:10:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 13:59:24 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::90ba:855e:a753:79a5]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::90ba:855e:a753:79a5%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:59:24 +0000
From: "Baumann, Moritz" <moritz.baumann@sap.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Accuracy of "git blame -C" - are there configuration options?
Thread-Topic: Accuracy of "git blame -C" - are there configuration options?
Thread-Index: AQHaa6RWLJJUmHp20UCV7h4P5SYpFrEt6NDS
Date: Fri, 8 Mar 2024 13:59:24 +0000
Message-ID:
 <AS1PR02MB81855C978C6A42E4D6E2DE5C94272@AS1PR02MB8185.eurprd02.prod.outlook.com>
References:
 <AS1PR02MB81858FD5DDD15551754AEA74945E2@AS1PR02MB8185.eurprd02.prod.outlook.com>
In-Reply-To:
 <AS1PR02MB81858FD5DDD15551754AEA74945E2@AS1PR02MB8185.eurprd02.prod.outlook.com>
Accept-Language: en-US, en-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|DB9PR02MB7179:EE_
x-ms-office365-filtering-correlation-id: e903d112-ceec-4b50-b639-08dc3f77f639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gHS6ussadYRpp471E2MthJkjVPtOpDxwTZv13tBLH3UipkqE7ikHCmYcOwDYyJgmfGPEW1ixyEsxB5X6p6kAH7Ge2Sakp9ZyDM4hG0IWmiqgdUjuqyjuTRQ0d7k31AA9+n5+FVYWqm+YSxBrdwDN+kW/BhlxZFwW0tlFcSWTyU4nwtGRNUFmPWi27suc71dAvOZ2J7aT07JrOESutUFOANDnrt/Lm+2rnP84/4Kjg/a/E/kO5J6kJP/YhkWSbvzXfFl0k1q5c0034yrxspayaVPefTtNQ0pDhmc90/7r7FFmVc7FQvn5C1zsGIY/MEAAl1XdVk3jWsYhWnfOapEt3YlfOWlZzlr9yFoDgn5pH+4SxhoCzXbhsaVSyKeI/AyvpKys4P3Qu4v4ucrgxSK3dVx/8UgRmWKATDmds36ZHj6ofk712gNTF5oS5zosV0HgqRleyEZO+Py6gRSkBljm4vvWPBP9YJvf9hfp+AaV3RrdaH5pcm+9J9Fa0w4fIhwWoMxpZosx9LXxPXwjr/XzyUjrNMYCfMwo9DLfHeNZu/1gqq8z/7e3WN0VL8PTqwBy7khZLect3BIzgKozx4fucAz1iLLQ1iSUoIsX1vozwvkHavlwkKvyOH++rrFlgNF00zPwh720I8QKgFNt2g4mP6fL2qe7TVMOO9H+D63k8x4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mE1oZ8fuQdu4W9Zukjmw2QAbaQBT74Ot6SRsiP8PCNMlVVySpKv+fKN6PS?=
 =?iso-8859-1?Q?uUDRLxaolyu+gCMRL4+B4ZoQLX+Vi+F1GCehSMp4OV3/rc5kHavhn7U1MD?=
 =?iso-8859-1?Q?zSNkEz/NGGy1djFi7S++tnNqcww03CS8ozq6VJ3hz9r5ZL9qNI3Oos9wdu?=
 =?iso-8859-1?Q?DPUo96DzEQ7ZuPGDnDhbXhGYIgo38BF7rrccSD5i862to7By/IxwkYa1Ug?=
 =?iso-8859-1?Q?6bLHWc/F0kIt93b0Uo9a09jHgUDeHR9xNisIb7XFQ8ALnQLEiyukCXd1yk?=
 =?iso-8859-1?Q?SPw91q+o++582xOwbHVwm2sA6mc5OfP6LzkGyXcXlo6tR9WAWEriCR3eGt?=
 =?iso-8859-1?Q?YfqV1L+RO4vHPjbFzsyvhmfnL6bDecLn6K8WDObG4L7H+De1FvHpVTUNEU?=
 =?iso-8859-1?Q?Qic6EsAbWRvw7UTBkxkQiaTddOP5t5hKBM+1H26WSMOPlxfgY2UPjp7Xgk?=
 =?iso-8859-1?Q?ZT+xl436tpUByqt33xwrpxdfTpjyuM1h/nMFexGo4Ipjq+CBbngmpiER4s?=
 =?iso-8859-1?Q?XDgoiGhxXVSiNm4+09JtcTd+mQeNPrARCL1yaFFmjq/qH1Yd4+bwNFjHPR?=
 =?iso-8859-1?Q?6/jILRCMIE2u6oUSYO/LgH/xrN+TXu/uqBhwRs+4FDLtBBQH4fQG5hByMA?=
 =?iso-8859-1?Q?h5lZ/0wLzVsd3rEWwEOml6dE9MnTadEhZhkVslFB9vClXHJJIX/GMyjg55?=
 =?iso-8859-1?Q?9P24faV+4mJUPiLgxWrg9OVktmHeAQ5ie/DUs7dLQIDLow6fd9ZjdKHf8e?=
 =?iso-8859-1?Q?E/FRlnjFsn502XPqCliCsVlkNXX050VlDAA/Q6A/lOBOIPwOvjWKsY+5Qn?=
 =?iso-8859-1?Q?HanhvEPlkH5k1X0n9DRmZ1v/a2kkQBwaff82ZgI/KV6QDojRjRop38qQaC?=
 =?iso-8859-1?Q?w/hg0GqzDTY1I7lzVUASW4D/fdsyvaJ6eyBv+r3QZQHJ6T/mdWIASwM+U/?=
 =?iso-8859-1?Q?4nvcRtOH5PdeIIUwkgtc/qKj/6iS43eGb/ItJZt8XS2szIk+5RA2G6jQ7H?=
 =?iso-8859-1?Q?tgj9KmTLeGLVpnFr2/GR93ApkjW79fCySDrlqAavnsW3gbJoDkFI2UeyA+?=
 =?iso-8859-1?Q?zdv9ygbCqr/j1igNWFU/l84nT/8RAozMi8y7GesPpuNjvNsA1cFIDY2wQ1?=
 =?iso-8859-1?Q?mP+okYv/xC24t7kQC+SDLAeMU89SvZp2ljnzUKhYDr2toKQuC1XNgtgVLD?=
 =?iso-8859-1?Q?7I09VMvxHz7x8f2EkByur2q+YvhI4dq2LM0xR8ploB+0ZnbexVlFMNTIai?=
 =?iso-8859-1?Q?MvBGF0Glzg82yEJ+VreEZnNfh14AwOX63+3GT78aVe3xGE/X76nQWMJfXw?=
 =?iso-8859-1?Q?FuPCT+kNLnbsNyGEdprS0xH2ioVCpffpJBY+FfE4qY7u0jFZrb8tMDoynv?=
 =?iso-8859-1?Q?bynz56NJboh3uvbflPJmpPV+rbQzI+DyqLA+YHkuI4uco7njYtZf2S65AI?=
 =?iso-8859-1?Q?wqxVr0iZLWWDT6y2JhTCe2E0PFs14uitgpakp5dhpnl/kxuOIm5Jz6KhCg?=
 =?iso-8859-1?Q?pGKP7DpkU5649HZVLiz5T6ojI1Jq2BRosxXiBQqN5PBRTpoA/BEHZ1SPkz?=
 =?iso-8859-1?Q?d/rGASCrnxgtJh56CUxRv8Urfo09sZEvQZEIYcZnTwlYqTltoWMxCFP0mY?=
 =?iso-8859-1?Q?bFGvMO3tjZa9S1krqqlqh0ITCduFHRJsQ3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e903d112-ceec-4b50-b639-08dc3f77f639
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 13:59:24.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hM/rMnP23lNgJpWC8Ea0pfXiiDizLqK3KEF75/kbpqMDGynOXaRYI53qAVFfCRk+24bMeyuUp/bvW5OkvLIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7179

Maybe I should rephrase the question to clarify what I want to achieve:=0A=
=0A=
Is there a way to execute 'git blame -C' for an entire large file at =0A=
once and get the same accurate results as if 'git blame -C -L' had been=0A=
called for each line separately?=0A=
=0A=
---=0A=
=A0=0A=
Hi,=0A=
=0A=
A colleague recently experimented with "git blame -C" and noticed that=0A=
the accuracy with which git detects lines moved from other files varies=0A=
a lot depending on the sizes of the files involved.=0A=
=0A=
Example repository: https://github.com/Boddlnagg/git-blame-problem=0A=
=0A=
The latest commit on all branches moves some lines from Decl.cpp to=0A=
line 93 of DeclBase.cpp. "git blame -C" doesn't detect this on main, but=0A=
on the "works-as-expected" branch, in which the size of Decl.cpp was=0A=
artificially reduced, it does.=0A=
=0A=
Further experiments show that the following work as well:=0A=
git blame -L 93,95 -C main -- DeclBase.cpp=0A=
git blame -L 80,108 -C main -- DeclBase.cpp=0A=
=0A=
However, with a sufficiently large range, it stops working again:=0A=
git blame -L 80,109 -C main -- DeclBase.cpp=0A=
=0A=
How does the pickaxe search of git blame work under the hood? Are there=0A=
any configuration options I can use if I want to trade performance for=0A=
accuracy?=0A=
=0A=
Best regards,=0A=
Moritz Baumann=
