Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C6314D1F
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430138; cv=fail; b=hUpsNOSc5Fz6jThduxfRODazBs0/05FnjTiKz3ENT0dMST7zUgmbAB0bNDvWVjqzDO0t2lmHedM2kc1RFCPFbYSYQ3ffgtAvWF0B3jg+XGKA2L85zG7B7ztfc++XhuC6OXo0gxtAnE841sVkCFPwNVr45JgTrDHISBLwkEyr3hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430138; c=relaxed/simple;
	bh=ln1sadxAWpyGykZCx64xMmuUqWmNZYDPGGYPkJCME5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ftxq+7o48OzVSI+e4DP/fNBK/vVKhLSY7dMXcZIcqKLIyuqSjVhT0AlTvfRQ82bjWbJkuWmk4PORj43bxGzsdsUlprZhwWeg3Gc8mc2KcbyM4gmdGkyu3V9T7/1ky1HUpvG2qWbYqCEW6kXG4vGf8wRroGaPVPF25xJ1E5Ealvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R/hj0h2R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZwHn0Gjh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R/hj0h2R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZwHn0Gjh"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfX8E3527410;
	Fri, 22 May 2026 06:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TvIwyEpsFalujYauJo
	SYM8UFqAzV2QavmRxtPUztFqs=; b=R/hj0h2RIfbo6A8UPtorgL8Ev2IpXoLYvd
	o8QBW9OxWZPQq5RIcZP574ar3NKW9IG/KWgd/gV6yH/QpnQp4/+qXQU0WhlU0zNQ
	F07Qu0tO+mStT7YNKMtJXd6rNEn/l5IzzRNvbqe0rNLT+ebCx07S0PU3sNmWe83J
	2wcC42E2Yuhmc04x9mnePMUTFZmDE81CF5fWavyAy2jyEu73GZVTcmO763hHN8dx
	jeWItqKLD2WfW+OS2hbA2k4x6LA3CElWDe8TLH/BMhi3I4QCOExZ3r4SmuARSilb
	s1sRP07Ofig4YcKegZG7X3sJnL/AX9Jb0brPPSZgehHrzLuOfDxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gxx2gbq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 06:08:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64M5xl1m028810;
	Fri, 22 May 2026 05:59:49 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1kc80f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 05:59:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRSnBszyjUUSZSXmmEqRhuKVT1c6V/gQ6meRFlQZQNPZI5ZMt3meG7vmEo3zdbF5lzwtnD+ayB5WtgmAYIpaaTDLKrQWQITkBauPbdIHhWh0fpkzxgz9g3q6/ec+jH9kvDc2CFpTZmxtdTbyFwdsXkvy23RZcO8bD75q/uAKXk5uE3CA9+rQpauOZXPFml3AYR0fqp8S/nUFExy9g8l6dl6wulVjjYywiMQc4ln3CFAGmFduUrC/fJpIyB2cIGwvYvvUj3HmWy5Ksj17hNl8zZMUCzD7t+xHApPQzie1GXJ028H9MBwcaniay79Z2NFtxGtuhpAqeeByRQBjvDcSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvIwyEpsFalujYauJoSYM8UFqAzV2QavmRxtPUztFqs=;
 b=O9QDS6otCg/8hx3/iIZRaXpeejEajROyWCZEeLUkOBWQuVoQ14jR2MSuoRQJYBr5sG9AK3euIRb3X9OmCW1i0FrqQ4NUe0wc7GZK5QKA/lyZ6SYdK98PihodInKKtZWLEC6FiL84YHSufiDmgmDGjZmQh9itUEdnxOJq6U+K+4YV3YwavgsGQsCJFtUx2Vcdqg6lrEHMtIRNPwK2MAMvOFHt0TcAti9N2ci9atJ1Cse2YuVouaUvsZGSSl1V6F+kE+o8z3BGLDYGVzTBqS+N1P0z8vpRqvGchZ+gt0vqqYnte7ACXKbzfEsYBXJTXo2dDAqV/u0teHNDXmF1OYvc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvIwyEpsFalujYauJoSYM8UFqAzV2QavmRxtPUztFqs=;
 b=ZwHn0GjhasWPKsckbQ0cGkyuwVwNKn8mV8f2jLpw5hDNxO6yK61Mgyk1MWSFUNkxNIlt8Kn7PzLpoybNueQk2rfkNkRMxAQbbE/eNnaYe959rc3Zb6m14Pi+1WpOnMZoVJ5nsTSjEU9cADs7X9384Fj+R0ciQS7jYu9f8ut+Jfc=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ5PPF912A858AF.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 05:59:20 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 05:59:20 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net" <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com"
	<gitster@pobox.com>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>,
        "oswald.buddenhagen@gmx.de" <oswald.buddenhagen@gmx.de>,
        "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Topic: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Index: AQHc6bAhuZtT0aOntEWz+RUPTr2UiA==
Date: Fri, 22 May 2026 05:59:20 +0000
Message-ID: <a0916ed8965d2024ee0f6005c942f77a16f28dbb.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		 <f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
		 <b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
		 <2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
		 <cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>
		 <20260522051048.GA862219@coredump.intra.peff.net>
In-Reply-To: <20260522051048.GA862219@coredump.intra.peff.net>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|SJ5PPF912A858AF:EE_
x-ms-office365-filtering-correlation-id: 30f1b23e-f42e-4078-0f85-08deb7c74431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|6049299003|366016|38070700021|5023799004|4143699003|3023799007|22082099003|18002099003|56012099003|4053099003;
x-microsoft-antispam-message-info:
 Byr4i3XWu6ozUHCSR4KIXa7hH53/z/pDcTzrZ+TA8Lr1saSrK+XCjiLa5DkY8+KpYwksqT7DNpI/70Fx/65Bys/ITomWd1XrsoYnE3K8QwkTS6Qk0BZ6nrVQ87RyWakRnVGAGc6TpBiffr7E/pRhOo5EgOkI1AExRS/7UqZaHiisCigeyfPnFD+/lbo+Le9/VV0F1Z5p5OMP8vjcH72SfxN8x25rFjqFSq0Lvjj6dgZxu08yYZZlIpxUI81/pwcknGjb2ynVpCyOA1DulpTW5o8505hmr6HLXGL78wdTjBETWKWUm+8qRSeVlJIcoILq1vlLb3JqmE6tU4Ys8ikjj7Sea3NJMdVJMJnDaCo4Gnvg2bq5um5NEfDafKkAZyE9QO+PvpmDrHj00o6FnJEEsXFBw31AImYFyR/rxZLkYxaHPyCU+uo5OHlimEeXU1tBdA8dKxcR+L6uahEZO/GwMV+Jp/XoExRMN++m7uYqtMZscq670/0tVS6OdNRmaqNmhMjrlOUL9g1twIAoLm4PEI/DBpSmBJVLiDr99jMyVh2fLieiZk++MpbkYrhXcNvx5uiTTN/etc3W1dU1HGDHdlCVcdPbG3wREfMIiwmgeMMDhJyXygmTSAGAI+fOrqiBlGMuIHLJWlHZchv2cDEaxDtUc7M8SXMuLraD+duaSslXCXev7xDB1ks7EtSJ7R+c6BH0ulMM6YRpgbwvvsZXZDtV8ZxWjWypELUiYC4EFgg5v4aO0u4B38kg6MjaMVEu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(6049299003)(366016)(38070700021)(5023799004)(4143699003)(3023799007)(22082099003)(18002099003)(56012099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkNURkp1eXVsQ2VBWDlRS1BkLytVdjNBY3lISVY4ckUya2E1bU1nYUUyUUhE?=
 =?utf-8?B?b0RHaHhaejlyRHgvcHFtYkpMZ2FZVzc5S0tYZGZScW1aRFdHRG9ZdXNFUWZG?=
 =?utf-8?B?eURhRkhWcTFpSGZUSUhHQU5JYTlnaHdjWEtCbXRBV1dxSWJQMU5pUk0ycWVz?=
 =?utf-8?B?dDdBVVgydDFDc051cVdCQTVpZWZ2OFFMaEpUY25UcUMyQUVCNWZRY3hzV05N?=
 =?utf-8?B?cXpWZlRVUkJybXRjU0RmME9QditCd3ZBVFhKSy9SNGFkdklnbUtnN2xRdzVy?=
 =?utf-8?B?TmZVVTUvSk4zeFBJcDQ3UkR1VWJJbHN5ZHgxK0ZrSkNWdjFPbjBqTnZkMFNq?=
 =?utf-8?B?Z0F4ckR2TzlrZmZzUzNpSXRycENURVQyRzdndUJnR3VRVVBPb21PWWdTRDZP?=
 =?utf-8?B?UmZuOW0zMEJQeFdobjBpR284ZlBKNGFOV1BFWGNNTVBmNzNyMmJqWTFncFNr?=
 =?utf-8?B?aXpwQXdWUDRObVp6Kys3bCtmWUwwSzJneG90VFdjaUlQYmNhNjFjUEJuUHRN?=
 =?utf-8?B?RENQVE5CaTVqamZHcE5iOERyMmRudWhmNjhxNG03VHVtenZ2OGI3ZzI4cDdj?=
 =?utf-8?B?QytmWEQ3aXdSNGorOVpWRDFxNDEwYnkwUDB0WERhb3FBVmFBNmMxZFA3TmFz?=
 =?utf-8?B?bnBzSXJjTjRTSUZ0SGtmZEoybWJKWkNHSG52MzVNWmc5VzI4QkRxdkhtN0lj?=
 =?utf-8?B?T0dmdUh5Mm42eTRsL0g0SGNMVjg1NTNmREF6RVZPWEFSWmVnWlhYVHhOMHdN?=
 =?utf-8?B?RDcwUjMvWWZ2RHB5WVoxOXZYSDBwNFQvTC9pYlRtNldTRGpwK3BnRE9WYk1H?=
 =?utf-8?B?bFQrSFBWVXlsUUtGR0p2Wnk1c3h4OGEwTThmQVFoOUp6NHZaZlVYVFBWMTVp?=
 =?utf-8?B?K3NlZzdxZkRXVzkrc1Z5bDFQWDF1RDl3bERRUFJyNmRTK3lnNVNlTFJoSkJY?=
 =?utf-8?B?MkNXTUIyWWFBZTQ4dHlCSEJzdDNtQzFkYk1YOWxQWFdCNU0xVzJmSEhEcFVt?=
 =?utf-8?B?anNISE1kUm90SlF5T0dwbG5kS3c4NjhVa01YU29LdDhIZWwrZjdiZjE5Ti9t?=
 =?utf-8?B?RkpXVFF2MG5MWmFhampxMU9sUXFXMUdEMWhrcldNeDZVOXE5OWxtUkcwVWQr?=
 =?utf-8?B?aVF6MVhHODhXQmJYNExZdFdGL29ETWpiR0pobWpMOWo3VnUyUmR3NXZ6UytO?=
 =?utf-8?B?aEVtZ29DOG5kUy9PUDVDOExjdEFQZTdoWXVMcU91WWFXbWtpWnBaYklBK0Vz?=
 =?utf-8?B?YStuRHp6bVhmMURmR0VPdzdFUlVWUlQwMFRDTmVCV0pabG50UE1hajR0SC8x?=
 =?utf-8?B?TzF3dWRlZDQyNGhKaW5jdE11SDd4K2RXNnBZdWR1SDNqcGZ3cnVNWlVEeEdv?=
 =?utf-8?B?RXhGd3dFYzV0Nm5WUVl4dC9IcVJSaEVSdlJEREh0NWtTYkFGSHN1TDRYT1hQ?=
 =?utf-8?B?ME8yRXczaDhKQWc3dDgyd3B6WTNHMXlmSkZIWTc0WmpNY0c1aTVzd0dQY0Zh?=
 =?utf-8?B?M0xHNWZEMHZqVDFTeTR5cGtCQzB5UmVFWkt6eXpIRXFlMVZZOEF5SG84VFRm?=
 =?utf-8?B?RVgvdWdXTVhhN0h4dzlOVkU3QkxzZnV6THhmQ1VZSGNNYW42a252YXAxaUZT?=
 =?utf-8?B?ejhZei9TcEJ1cUNpcE84Ni8wdEh5ZkVCd3NuUmp5QXJvNzRBd2VwaExxQk5N?=
 =?utf-8?B?TTdwVmtXQ1p3eWx4VDNuemMwVnkzVXNSNVdmbGo3M0thWlN3RDVQcFo5K3Vm?=
 =?utf-8?B?a2VIK2QwdEFzbFZLSTBtY1pOdTA3WnhQekZiR3V3bGNMcDRvUzlYSXZRY2sy?=
 =?utf-8?B?ZFBDL3ZMYm03NjBkRTRDU3BQbUMyR3NNbVQyd3dNM2FheWRId3BsSTBSUzJQ?=
 =?utf-8?B?SE5rdkI3c1NQbXoxL3ZLV2YxVHlsZ1VtTlJaR211enhWclZwM3NGQUhVUXhq?=
 =?utf-8?B?TFFabzhvK2twbjdCdlhVZzlZUzBrV3Nndk53MituUm45emozTCtsT3JkTzJw?=
 =?utf-8?B?MVIxUFlOdnNXdkpCaktQbFhEOHVvMzJLNnhmd3RMcnVOM3pJdk9sWWtmMkh0?=
 =?utf-8?B?L09YcGxna2hlbkdUVFdqMTVNVmhWMTF6VTYvcVpZMGcrbjlYMkgvWUQxNEk4?=
 =?utf-8?B?TUNjSTFSMFNOMjZNdzJPTFZzeFRWV3hnTkdlQWtOSnZJeWN5a3hyMUpMRHRR?=
 =?utf-8?B?NU1NRWJ6VFZOdHVtQ3dEVTdIbXlCL05UNEl2UDNvVCtyRUQ3TlpLdEJ0Yllv?=
 =?utf-8?B?ek9VUmNyL01vdmp4QnNxV2FaNDdhaUtUaTV6dlFQbEExL1pTNXRRZkU2QmFi?=
 =?utf-8?B?MVpmUVNSSy9QeU9CR2VMMkxWa2FVZ29EZ2laSU8zNFRzZ0xJeHNEemhsanpE?=
 =?utf-8?Q?GGjK4UFE6xm3J9GOxBcW/8Z8JWCon7akKWG+zBToTZ1U4?=
x-ms-exchange-antispam-messagedata-1: 0oDrbn3rLFkdtCID0TeMJA/uYQSS2Kbc2wI=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-aCqNAIhC63zo57dn+QQs"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Z3zB1FzgOcBuk/6M+NHJxOfNYbdPaOA5wfZqZSMh9/UUYQxpDWl1YMgQlkdhHfm8ZRgRcDTdLFk2AfpTVblPWfAkWnWJu2YUfNboU9Ckfcsyplq4HLD86E/LlxNW+OyK8S7qRSEWZHTdh2A36QD5yyGG7RoW3FSkWUlDaiQ1bq9lv/R5F5uKv/Xut7oV90a/19jX4rk/vI1dBD3nzS66vknUMcxy8Gui230kSQUg8d1A4AA4AAXNFhFvuoW7Y7cyIeKIIJQH7M6PfwNF246EgWEIx84yvTEhaYkV6G6PwFC/m81z+eMnfHaZL3mgZOFiZxLernjqfo3zHZMJ1BeinA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5S7bSyvhfg1QeUSbdkjaH1lYlorIyRdpWgRQ19QMUdmETxx5O9xbKC9flk/TIR8NgAtbZZ5nfyXZf7UpLJG/TTQ9R3gJl5szJiS4IdHbcFcbmX9dcvRbPQzXG7BvwtfF15pHOStdmPsOIEDMMSW0nSGHzGM9/8mRy8Ekh1brAXYMMvkxvGLAo155IUoNMIbM2XPwwQXiGybvXDQsc6DOD/LFt8An8+dWnhIRTh7I/+ErFtjPPr9VPkXbk/TpA2KXZlEi5By0m5ItdMpYqh/4vprJK7uDOcRhwQA9XS9IDYqYQntARWpVrBCSPc/vPheqrfPfEDjtvV7/pVF3hV+Z7qg5kWHU9ToI9GLTU0pQD52lEPYoZNEzyNm7AUcbFoBhFDkIoNU8Yongb8Goyosk4tz1QVy2Q/2z2l5Izuo/6h/jVxvnCefUHOhS/LwOMFVQve1ol6mwRqYflpOqmsNK3y+8lGakA/oorwA0N35c4lszvRZkVnhf0CfQ1qdgJtPWOfFVAfoWjFTlKEpylgUKwRw0/h+PsqgL0RDzFeCRO4/1Bo2pbJA1iEFRwouAvzEQ3xYaXdDC/YP0RS3w9Q1X7Rl2+29ZIjJ9i0KUhLtHLr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f1b23e-f42e-4078-0f85-08deb7c74431
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 05:59:20.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfOHnlvyAO+MlQbFeYSnnB09HwbtAs4IJmR5YwbLwvNwgEOFKVCrOkBe9GjCtlk1vi4CrTfmkgCTjevLdDUB+OsUbZVJ5sn53JT0ExeMcJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF912A858AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220058
X-Authority-Analysis: v=2.4 cv=UOjt2ify c=1 sm=1 tr=0 ts=6a0ff2ed b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=TGl-OaM2wvXZqeebne4A:9 a=QEXdDO2ut3YA:10 a=y8_O597KSUpuQ0iEEv0A:9
 a=FfaGCDsud1wA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12298
X-Proofpoint-ORIG-GUID: DQNZPLT35cvtnLquLXavct9gWy62En2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OCBTYWx0ZWRfX4uKPW9wvG2iX
 3LpVgU2ro5Ruz1Wv85iszvuCfWIN85EAfeU1SAEr5lP2cceElNuuKFLZEhUs87fZucchCArRVD0
 DjnGBLaituESb94ejWnHs7vVMKTaaY2yHHj/Ttq5sX9IVNumFpYdb7Y9qqo2/qqJ/kZNqXyJgf0
 0e5JUuhs31bY7g5ijuJuVzJMYhj+iOn+r1q88PUOc8EElrtZm0ofFvss9XBZl5RMEPczIKbkFLn
 AmiqtdgDp+KQSMC9pk1HEjo0JqbaXJbTF9zS61PZo0YMRhiASXWyHVpNMbMNncr3jKOUnWVOk9N
 hLqOwpOEkfz1Ryl0EkECNl+oyVn/myckMG4aCtYeLL4ysHLxaHT5b+3hRaz93PJysVUKkTTSQ5b
 mX75nNwRWwhT3OFk+5XijS3WwZWAXzF1n/4ct9J6ZLrM1afABmrmbq9H4W/F+QVCEMo9edcH176
 DgSQ9PdKSXr30lkTkPhzj3j6iUJ9mQAUY9DGaFbc=
X-Proofpoint-GUID: DQNZPLT35cvtnLquLXavct9gWy62En2U

--=-aCqNAIhC63zo57dn+QQs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22 2026 at 10:40:48 +0530, Jeff King wrote:
> On Thu, May 21, 2026 at 04:36:05PM +0200, Johannes Sixt wrote:
>=20
> > Am 21.05.26 um 11:59 schrieb Siddh Raman Pant:
> > > The timeout is for the failure path, where the external helper has
> > > already stopped following that protocol or is blocked on something
> > > outside git's control. Since git starts the helper and puts it on the
> > > log/grep path, git also needs a bounded way to recover when that help=
er
> > > does not make progress. Otherwise an optional note source can prevent
> > > the main git command from completing.
> >=20
> > That Git communicates with a process that looks like it stopped is the
> > normal case, for example:
> >=20
> > - Output is sent to the pager. The user can take their time to study th=
e
> > output. All the while, git waits patiently for the user to advance the
> > pager.
> >=20
> > - Git fetch transfers large amounts of data across the network. Most of
> > the time it waits for data to arrive and does nothing. The peer process
> > looks like it hangs. Git does not decide to kill the connection at any
> > time. It is the user's decision to do so.
> >=20
> > If the notes provider hangs, then it is not on Git to decide when it ha=
s
> > waited long enough.
>=20
> Yeah, I agree with your point of view. If I understand this patch series
> correctly, it is about adding an external process to map commit ids to
> note data. So I can think of some existing features that are quite close
> to that in nature, none of which use timeouts:
>=20
>   - textconv filters and external diffs which process data in the middle
>     of a git-log invocation
>=20
>   - long-lived clean/smudge filters map blobs to arbitrarily large text
>=20
>   - cat-file's batch mode maps object ids to user-specified data about
>     that object
>=20
> As you note, it's up to the command to be well-behaved. Git should
> notice and respond appropriately if the command closes the pipe, of
> course. Sometimes a timeout can help with a poorly behaved command, but
> IMHO it is not worth the cost of non-determinism that it brings.
>=20
> Moreover, the bits touching run-command here make me nervous, especially
> after the challenges we saw in the child-cleanup topic that was reverted
> just after v2.54. There is often a shell interposed between Git and the
> sub-command, and we don't always know how the shell will react to
> signals. Using SIGKILL will eventually get us _something_ to wait() on,
> but it might not even be the process we care about!
>=20
> I don't really care much about this external-notes feature one way or
> the other, but if we are going to do it, I don't see any reason why it
> would not behave like all of the other similar parts of Git.
>=20
> -Peff

Okay, since the consensus here is pretty clear, I will remove this
commit and send a v2.

Thanks,
Siddh

--=-aCqNAIhC63zo57dn+QQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoP8LIACgkQBwq/MEwk
8irJZw//ULXgmYDf4MIwrcB5SWiarRxnCaZtm6ef0dYs3lYiaK2+gMmKCJnB7qjm
PvVSnVYNl1a7sw9MdnZjEJxwO52W5ins9XasBjMsLelHQmpAk/IzJ3gnCOwgLxhe
+k2qNGHcWgHQhjcdu9+K36X5KCU2bYpGH40+7n4+5kz01n8Yq42Pq/xuohaDjhFU
VAOEZhUtUOsGd+wImUSyXao/4DfoBmYUAG0KU2EHh1HXlFgwIZ3iN+ykrGv8cyEU
1WDJuJLdbRwry9HKUsAaSVztq7j5bDnFfxeQ/ubljyJGEvz0Jyh0AyN+skfHPbuF
0kD8mt0q1hjO4LGAgjiFxfDRzbrE2Pfn0RQqymGJKuwUf1wMM2BilJktME94LtCO
MnNjBOvu2JrcTlScs6R6VYA1lPfZLQ30CMEXcxKFbx4NU2vDZT9aFK48okEvwoa2
sI24f2G78p5KiqfcGrTn86JLMYPIkLKKOi55/APwddyQ9FtfWAgAy/j0l5lrvQfb
MrgLv/EMjftSgve2S9Ipg32jFDtaAdhcTibWxB4IVafpKrMqH9zTWhRtMS9Zm5Uh
YgjfARZgjO8h+En4UoB4mZOVMFkG6zocmFptdDxxh4zHMfdoYdwuICcdhjR4ou0C
/r02IhDxS9YTQMbqDY15wNOOX4Al62F9DASlChBPLWLIf+SN1dQ=
=33g7
-----END PGP SIGNATURE-----

--=-aCqNAIhC63zo57dn+QQs--
