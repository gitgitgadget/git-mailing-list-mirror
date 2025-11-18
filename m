Received: from mx0b-009e4e01.pphosted.com (mx0b-009e4e01.pphosted.com [66.159.239.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D0259CB2
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.239.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494423; cv=fail; b=MP425kNa5Vpve/f6kgKm0pKeHYtR18v+SWgfpTTQlwltTeK1CiRiFCYszDghuBI8zs5Dsd8844fZ+OaojC8h78wKOMb2JPxhCeteoUsepiOMzt5SJR2ex1GPKzp1cu8mugPWyXkF9920hJKPHfJJ018GWxE6ev62rN9Ggx3QJcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494423; c=relaxed/simple;
	bh=3rotrvqBhOxL93pDwKwvz2Nk4V26BG+t9ur23x23lRU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c/zb3bTzpi6LzZlBR2/jYRnfQ7eGSfegbEe7ftlLY/RkOPFSojcGo/qZ/ADT7GIvidM4ky1VRNwu6EEbr4cz5NliRZ/mqivipMA6Scxa85TtByaj4+VenrlHzFxUfZmvJtq++qdifOMUlpP42F+dMB0x+18rsxjvClE8GiNJZ44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=32bjfunds.com; spf=pass smtp.mailfrom=32bjfunds.com; dkim=pass (2048-bit key) header.d=32bjfunds.com header.i=@32bjfunds.com header.b=45p7jh4j; dkim=pass (2048-bit key) header.d=32bjfunds.com header.i=@32bjfunds.com header.b=ZvVQU2c3; arc=fail smtp.client-ip=66.159.239.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=32bjfunds.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=32bjfunds.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=32bjfunds.com header.i=@32bjfunds.com header.b="45p7jh4j";
	dkim=pass (2048-bit key) header.d=32bjfunds.com header.i=@32bjfunds.com header.b="ZvVQU2c3"
Received: from pps.filterd (m0443109.ppops.net [127.0.0.1])
	by mx0b-009e4e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AICmgPB238120
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=32bjfunds.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=key1; bh=3rotrvqBhOxL93pDwKwvz2Nk4V2
	6BG+t9ur23x23lRU=; b=45p7jh4jED1a5qz9uyAV1GnBXGtmVoyvg2RSgiTWuok
	MAbZsnpsSjTxwowzDu+VZfCipucMeG4rBzIO5UBDoAsT6sy4EcnPqScF49PJ6+lS
	iTcamu2xSZwOI9bIIU+aEP9r4iWd5X8yqV3AIyCQcV+wCfNekTQ3OhVXDT9QgoRK
	9RQJgvxG/3iD1mFKd80N/9vOSlaa03OK93GL0hGKpKlN57sFegbmrWdZCmR9k0FP
	chloYWx7BvuD7Nqk2Z7Ny9nOYuf3UPeZ5V7+HOFMIATOIvC7pROpV6mwJVnkadRx
	LLEq/wDsMYKrnvgxzx0j2MO7htASg8Ww7j7OExX7TWQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
	by mx0b-009e4e01.pphosted.com (PPS) with ESMTPS id 4af90th967-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:15:03 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgjca+4kKlEw1DGu4UCWlXIxIeblds/7U+wqbEkWOfP67qb74NeJe8GalglqDfTsegDabWFrxXMZOFsYZHrDtjgWHyZEF+cJpeuImVbxsWBHLorEOZGaVSR4ts9GTKnOX5nhtVF0YGIbPEVPQN/Jmf5mk77hHcM9v8/Vjwlvu/yV0IBtvYfS8ZvjPJ47hoq1KSVaIf5V+3pjCIC1FHYE7Xv29YjpvgpEKJFp5AUIRUvfpQW9wjfU0y4GNOsFHXIw/rp76uhRkRzFf58IOeiRxKeX8m7W508KPTr00otuUSB/AyioDHLzsDjOnYcYIE6lM1f7zuCgFV+oNaPn9KaGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rotrvqBhOxL93pDwKwvz2Nk4V26BG+t9ur23x23lRU=;
 b=rKhEFP/PslEZWxt8rQ2ZMlHYUkz/ABamPrwrlDKIdvVAMrxY3A/NrDtzisFSGZN7a30XdZZvOnaL8bHz2RTl4bGOmBj89X3/92xRtaWAxhd2SV+h87e3z2GyN6+AKSOdvK+csrUcRe3RFx8oKzyCSIcbX1rD6zKnkYTBLo/JLPqU8ChldLZR800nSdBzC994uz7jSiCiZtJR/H+dL/ksneIBdZDybdKyGsJds2w809D+rWR4C98Jp4wqZqIZ2ANKT1SUKQP/iwt61q9Mg1EkyNL3emVAHscKrQzMlViOBuJRfcMAlRAJQEjVeGSoM0F92d9h7a6XVPDnAGL6jKaZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=32bjfunds.com; dmarc=pass action=none
 header.from=32bjfunds.com; dkim=pass header.d=32bjfunds.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=32bjfunds.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rotrvqBhOxL93pDwKwvz2Nk4V26BG+t9ur23x23lRU=;
 b=ZvVQU2c3o5qIqLn/x9Md6d3eCRIBcUMSI9H5vS1UfrHWhiNM0bwWB5KZQgusb7YqHOckuZFRibIZs69EbJl8JjyrA1Rfytz/99EanLjqyGfb+VKca/s88XwCqvSE6lngG14E7aTqiahO6z+BsqtGlK2lzWxq5O14bDCDSy55y15fUIfBRDPFJwcpY6EaJVClzywoHRj7Gp41JSJrA4+QrOPeyg6pdMGjDDlugWldzIiEMu+N8t/7I1H//iWiwBe96PAKdPf8APnPsgo655B8yU3QxPoGC19cSKZSmAfjrGCGEupSO64spxquSDl/wMO1aZCwDMbqp+lUjofkiPWOLA==
Received: from LV8PR17MB7435.namprd17.prod.outlook.com (2603:10b6:408:256::5)
 by BY5PR17MB3939.namprd17.prod.outlook.com (2603:10b6:a03:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.8; Tue, 18 Nov
 2025 19:15:00 +0000
Received: from LV8PR17MB7435.namprd17.prod.outlook.com
 ([fe80::f93e:7619:f8b4:b3d8]) by LV8PR17MB7435.namprd17.prod.outlook.com
 ([fe80::f93e:7619:f8b4:b3d8%3]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 19:15:00 +0000
From: Bailey Muckel <bmuckel@32bjfunds.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Interactive rebase bug involving merge commits
Thread-Topic: Interactive rebase bug involving merge commits
Thread-Index: AdxYv6CtSsYZTSP+SkWwDqf7PQ5Adw==
Date: Tue, 18 Nov 2025 19:15:00 +0000
Message-ID:
 <LV8PR17MB74355C21BF9542254EE8E82BADD6A@LV8PR17MB7435.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR17MB7435:EE_|BY5PR17MB3939:EE_
x-ms-office365-filtering-correlation-id: 5ec26fb5-4520-4e2e-d722-08de26d6c4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+w0ZozLupwe7E9W3/GFnkxiuUcmN4Smld3atYCOuRxEBIT3Qa+o7QrXa/g?=
 =?iso-8859-1?Q?6YmLDXzf/xsP0RQehgzjHdvu6Aoq8/Sj9oQcYvny/M9T2lNABbsAG9O8bZ?=
 =?iso-8859-1?Q?Xie8Fc04E6BahePZtK4URTt3rWCagzsG+TJedGXTOtAqsqtqhigjkubptK?=
 =?iso-8859-1?Q?7zzaZUza/V0WKWkEnAGqKnKyCemZF+YsVFNSBTMKPRNOvP1N4FUBEA7v9W?=
 =?iso-8859-1?Q?YM1fAkk1FU2mkeZ13qrpTGbfQQHMga0yheNUtunrgFD6rbDecmSQL4mybF?=
 =?iso-8859-1?Q?FWRwuECghHi0Q2xikJ4LVkNwdvHktY3emRng3rc84KkBWJHFF8owChwYS5?=
 =?iso-8859-1?Q?YxGj6dgtLajSvWgEKzhq/FROw8refe/NJpVYjrXYhMZ+9Kuz/Zoe6xKNXX?=
 =?iso-8859-1?Q?sNuNnlG72Vx0BTN2en8ODhvKhV0TeTkkt7YkJQ3A0xNZrkyvFG5r1FWzCP?=
 =?iso-8859-1?Q?UUlqAxlOMc8nqjR0HFP3A4yYb+QqdY/siXsyNHDDaPxzDETtAQoz0tQjvH?=
 =?iso-8859-1?Q?mIgjOFEGdso7FyYW5thC33d3fp3kZ1vU4s4PNsfFLeFgkmhLPDVsIpzslC?=
 =?iso-8859-1?Q?spDuU5ykCrPj1Rxyxm+qmf6TXpMLMmS5lcDya3ZRTagxvdVGLU9ws1Slo4?=
 =?iso-8859-1?Q?jUY7UpoJVi5eZq2qpJmPehKoQUI3FbWWHR6GLDh21To2+LqReczBKzBo0E?=
 =?iso-8859-1?Q?3LHpK4id5rEgWjINfSRhiQZfOxDMyqydlI30PjkH6xyD3QSlKp5M2EArKQ?=
 =?iso-8859-1?Q?00lOuxLzsYoKPb0Nin5LT6ZYixUdhJNbefXpxQW2RQz5mjpzwKXJnv3SI1?=
 =?iso-8859-1?Q?897ajiXOQ/14tF6wJYJotWElZGzsFPqBjsuQ8AVkA7JzE4Lv/vwuPXaxkY?=
 =?iso-8859-1?Q?XeL7GU8DC8iIz5peF2AfatMJx779WUaNcaLW9cxyMNjkZd+sICRPZq1LwJ?=
 =?iso-8859-1?Q?tCXpjxKVHd/MhuPUzCIz25zbF7tFOTA3OO9R4fpCQLzezlJ+EnumEqaxu5?=
 =?iso-8859-1?Q?rF+XllOIh1hDLjkGgyq2f00B80Rlk3Qa7UF5XtPR5QiVnb+O3E8WWkLURm?=
 =?iso-8859-1?Q?Wacz6UUt0AxyLgySiRtRmZsMOpW9NZjVNzG2ZmSqEH+tCJwXGeyOW11rBv?=
 =?iso-8859-1?Q?VTYv39q79ZuL0/svtouAUZzc1fL9zGflF02pUybJak6sJCnlP78vTp0HJX?=
 =?iso-8859-1?Q?vV+z3l+88ELNLWR7PIu1oem78t8lESoO0/Tpj18kLr2MuLqIGBGDy6Lw4y?=
 =?iso-8859-1?Q?XgYMleSEJlQ2DuBpY1JLHOsDTsJ1PVAPoM/LirOU5QcULxoC6SkJf9J0hn?=
 =?iso-8859-1?Q?6Kj3Ojktm97mRtpr7gvCoI56T5ztUfZf8R1yE1z2umMdR2SPNqJkMBU2hp?=
 =?iso-8859-1?Q?Dmq7h3qh1e2pSiOGPDvkBQ+D5OnyetgQLuDaGWfT6/OcMKd5uxtXDmwUpC?=
 =?iso-8859-1?Q?Ecqmx8B5HQfiMg8k8/Ou3fXxw/qNMpna2nT8Je4Nr0KmGOstvpLM+PFOzO?=
 =?iso-8859-1?Q?bGEtcXiCmdT2pFexitVgRKK4Xq5B2FFyAkAORDS97FxePfUId5vifFHa+3?=
 =?iso-8859-1?Q?zijjcp3E6G/RvORc3GFtNKXc/noA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR17MB7435.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wf9J5MDDAgbzbA5R0SNkw0ylWPU38G+k/znPnx3zw42Tynpjaqde6XuPLw?=
 =?iso-8859-1?Q?wz0cjN0c4HKFvHoOQ46v0dxJ1QrbXaRBOo9YaUwySUuxmXEvYig2phm4Jj?=
 =?iso-8859-1?Q?tJvPZox6OIOvDf93CXuTlVw9E2ncPd/5EzYsxpnAlvwS86DrV8oD8PyWxg?=
 =?iso-8859-1?Q?AdbkBBA/ANvwh89Mv0oeTRIrN9BcB3XFWJ3ag6R/irlaZZCZh9FUf3lN1d?=
 =?iso-8859-1?Q?vUXNPU6Eqx/r0mR3Nu/vnfHEXdEZzC5mtWfNwbvJNkyQa5v+deQckUcLv5?=
 =?iso-8859-1?Q?83PLaMtka76MbPrD8a2va9oGJ6Qb0sj60Oj3rr0BCdByqazr9IWyMyFML0?=
 =?iso-8859-1?Q?p1CWexes09mvi/kpOkkX5dmaxyL+mcX4Jr7O6/zlvatZYIK+8n2Pqot3zV?=
 =?iso-8859-1?Q?5EdLlSYEax33wKAUJOKsjWS4DaY8bXqst4IjQpoH6yYVy8aiwT6jCISC5m?=
 =?iso-8859-1?Q?sHaAyvDZw1Z4NV2OV4wDb+AKb1RR3chtC6zO4sPumZyBe84xFiqwP4y99x?=
 =?iso-8859-1?Q?jzyVmXiZVjOtj/XptXeKIqubg7t/caFl/ZJBgcefAlJLbTQFcnOAJz+sa1?=
 =?iso-8859-1?Q?Os109uqzckbhbP4eqQ3RqAHbU4WgcWU+HgcuVNO+Hsek8J+XPAQYK86kO1?=
 =?iso-8859-1?Q?CTbdSxSYz6+kUcVh082VM2zJXZB/PFfV6AlY2zKOthQsv6MYvValbxSsUh?=
 =?iso-8859-1?Q?k4iEXFX65OX/fdn1SKS1y0p4tIA1L/qCo5vTDMGr0dg3MWz+ska7weEXQh?=
 =?iso-8859-1?Q?z4sCOPdqNFzK/0C3hr4IUtNF/q2UbqCta7iGZk3xOcwUrB3EDwL7PGqvyW?=
 =?iso-8859-1?Q?F2gV6Fmf4xOfQ1nJId9qrMQa+iITldaqKpkvGSXrJMzN1CPvppKsI87UzX?=
 =?iso-8859-1?Q?SDM88l3vlrITkdHfuQL0PNebbdu+bTp5lr9iKF0KxFrHsku9h3mDTYL8zg?=
 =?iso-8859-1?Q?W+GGDXYoUD6W0cU3HSRDY8fa+LmB9wXMyCQlwNN70HD+1V5WloIvbcK5OF?=
 =?iso-8859-1?Q?fySe6gs/OKzIwrMdp6T/cnXs9ZlP9Gf1hEaqehWWWYCnsOTxL3OUfjBQN4?=
 =?iso-8859-1?Q?7Po3AmDKIUX0DHbM12crlXW2kOGeP/cyA9uqy1B4oa5gQpR+3ugitEciOD?=
 =?iso-8859-1?Q?MWMEKKLDa1xcxn6EysUpbio+/Uo5fGbJIYDr0wXFysKzdfs/Ngs9FfYANO?=
 =?iso-8859-1?Q?BVFTeZY01TUs330ue1ocurQb69j7Ef6l8npNDFSvXn3nLQEZf4KIS2dLqv?=
 =?iso-8859-1?Q?yFNrokxmxHCNYiEwsTQqAUfSve+a5N6EdKxNACQ4bcweso+UXYuw7kIpH9?=
 =?iso-8859-1?Q?GWo2Xa1g4xMkyB9vzagaBv4EJy0bl5SjB/nvdbmnVBtvWOpNdc2JGq1lmA?=
 =?iso-8859-1?Q?dElYAv78PWTuvJoJSUx0IDW+41CT6tw75HTtbnM6rIzIY1EN3KYoJ4VVM6?=
 =?iso-8859-1?Q?O4htzJcLLdKDlNapyJsAHvC8bC60MHd863cEsyj4DIDlt9UTmbDZbusrxD?=
 =?iso-8859-1?Q?F39FNLgE6ljyODhh6+i5NZ5PGZjBmu3PVpyVuL4p1oGM2tNiFSrJoSrbza?=
 =?iso-8859-1?Q?hfqfOirxR4AasXb1IuQw4aHH58rjPauhgod66cmBjGukahjt0iCYok/d66?=
 =?iso-8859-1?Q?NfJsm0wl4mOZRRnO3D+VyfiRCt/gKO3m7J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kgcTQ35rYw9BlqwG+H9+S+1m3/J4eaW5VeLDkFEchv7/tI5rDcxYyK7SN743XcHA3i3GdSOWam0Vnn161AJYr1RAig0N6e+uP5itXRQ3xKU0XycBZLgAGKoJmPUTIJETaS3lWXc3MMl2r9UvALheL2/HxD4SxjocVHacivnc+fkT4OMK/8e/kiQ2EbbE49DG+/LLo/8cCuOlrGn3+BZEN8rMS6BySiTRthWesobetSjoVAacwdLsDf1hzHiECMtk4288NUAPXih8UWqAVsyVcukRUJrGfV/Xns25Mhj+8+Ox56DZcij8I+eLeVzYfvm6BBbyNx/0PAY80W9DtfRC+IPojwyK+lYcRUW7bkqgcAPKjIyxWtBHpRW60c319Eyc9a1pJFUml4dci6rfAiZIE2qWR/S03BS/+dxUld04r2prRwy7jdMHWdqvlSPiwG06NDnmfh5rqul0OKrZW62w8ohIOsatwYd4n0H1PhnUPT1Yp+zNgSOfO9p506ksMDwrZNdfJDo2auruWMIT8QfcoPhjqjKnwHtkPwANnarIoktbGNLxM+dLEMou/FjTKsN3XLsw4lYj0oVC5qMiJ3AeFhE3AwtxzsbVZRuh5ldgqztRLabKkptojq+lIZAIHP3chdfyb1t3yqmV6zs/xjQIkQ==
X-OriginatorOrg: 32bjfunds.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR17MB7435.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec26fb5-4520-4e2e-d722-08de26d6c4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 19:15:00.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76af9776-67a0-4cb6-b165-503ce5b744c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7sv0KovsP8NtjA6JOYJreA+sgsT1bvYRoZsb0KIrRewD7WdumgaDz06uJE3v8t4omJbbzzS7c+mC8OIvVQAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR17MB3939
X-Proofpoint-ORIG-GUID: cb_QvLeus6ZatS7P-WgODNHYy96jhq7_
X-Proofpoint-GUID: cb_QvLeus6ZatS7P-WgODNHYy96jhq7_
X-Authority-Analysis: v=2.4 cv=CI0nnBrD c=1 sm=1 tr=0 ts=691cc5b7 cx=c_pps
 a=dV5UnTNaioTBtvBhj0ZdMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=jZ2KSSaOu8wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0BQYGEzyAAAA:8 a=efKjWf9asAPhlIcYy0wA:9 a=wPNLvfGTeEIA:10
 a=8wsKLG1rLaeZuy_0NIh-:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDE1NCBTYWx0ZWRfX0i0qUbJTZm/z
 NfP/LLfLjtefxRVySizQRrWrLfDbZTBZWTv31dtYjmu+HRT0IWx6fP9GYFxRZlVupQIAYI2IF8H
 YcsYir7QWfnJgh7rLvWvTlZYRdqIcf4d3IAZPyoStMFi73hlNU1D/vl1phtJRWBho+Cbwyr7azo
 HryrF/Iryntgk+jF7fMCn46twttWODYdIoxogZQyCCSj6fvZroE9KMqtSzkK9yK7tRfwfDY28iW
 7TyhBGODH2X+eMF8wjGh5rE8FCZqVJp3fglGD38I4l8QqXrKoiaLXiClm2PTMxILQz+tJAKhQyH
 dvoKC5USTMuH9X7IPl8s7aONvVvQxxFPR/CYllO07nWDYm/6z016q5q9tZ/R1nOotrI9GKNrs+8
 KYXHRrSjLzBKDQMmM9Q1Wl3+nRKZsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180154

Hello,

I believe I found a bug in git. The output from `git bugreport` is below:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I ran `git rebase -i --rebase-merges {commit hash}`, then changed the
command for one of my merge commits from "merge -C ..." to "drop ..."
expecting it to remove the merge commit entirely
What happened instead? (Actual behavior)
It output the statement "BUG: sequencer.c:2695: unexpected todo_command"
and remained in an interactive rebase state until I ran "git rebase --abort=
"
What's different between what you expected and what actually happened?
I expected it to act the way it would if I deleted the entire merge
commit line: remove the merge and keep both branches of the merge
otherwise the same
Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0.windows.1
cpu: x86_64
built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.12.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
uname: Windows 10.0 19045=20
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]


Thank you,

Bailey Muckel=A0(he/him)
Data Engineer
Building Service 32BJ Health Fund
23 West 18th=A0Street, 8th=A0Floor | New York, NY 10011-4676
Email: bmuckel@32bjfunds.com
=A0
