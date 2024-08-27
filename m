Received: from mx-relay139-hz1.antispameurope.com (mx-relay139-hz1.antispameurope.com [94.100.133.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FE1C2DD2
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.133.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766846; cv=fail; b=KfDy1+x7Gg0keDgdguWkQaRi2LpSsAID6o9mPhV1ELEHR4KSs/QkWMbMil0M8rNqOy1ibg0LyMc1+ljiwRG6I+XK1Cawx9fRer0cscEeQqjngemK5KEW2ahJ9mY/EyD8WO+GQ7ev87hA2Xc5KVfp40Id2f91cZZDQMZlH6KMsRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766846; c=relaxed/simple;
	bh=ozvhEWGrkonQvspw8iENIUAOMp8SgDX8FL7wVe+Trt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCrbQwXLfaQbbJ1J/3AdGWREf8cuScYYUhW1MVdCC2Kr+Tb9fDa6/F7oEhQpf7QITvkGhhyVfZVueXP7cOBpJ3kv0k1Mvmv62hKZ6xPVivzmIP4EjUEIEHDgcB7R0RBPgQBWa+jOVPVsC04MIhLausZqXBqo3PGo6ynxE/2Z4F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=K17BS2wf; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=iSmvddcW; arc=fail smtp.client-ip=94.100.133.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="K17BS2wf";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="iSmvddcW"
Received: from mail-vi1eur02lp2044.outbound.protection.outlook.com ([104.47.11.44]) by mx-relay139-hz1.antispameurope.com;
 Tue, 27 Aug 2024 15:53:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMSzypNRlVwv9oReu3oaCxVbLbKjydnD//r/+CTlt/xIDxP3j9Lkh2a3fu9k/onjMBj0njDbUJW+kvHP/tiO+Lv0EP5kW2qdqRrW06mKfqUUTBTnkqXGIU6rBu053UBnSK46MMy2m8hYLT3PwhjAVQ/fhQ6LYwYZk0MS7R2htxZA8bZJKL81IEWC+Jo9PAXDoOZ1e17OXyd5eFvEAJWo1Aes1AUnBGHl8XC57PVUQhc5JFvkOpJFTqvHvcr8n3j+oAVBfRL7ApjJ4F1+3V05oOBK97XoURgLDKO8S+bxLE+17ssZm3gatov4zrwtH+HyTkQieaEri2EZC4Y2CxfojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozvhEWGrkonQvspw8iENIUAOMp8SgDX8FL7wVe+Trt8=;
 b=w/eyKjvLPusiGy93F/7b50yAR6Ah9iVsj+mg3jsCrqagSTJKXpZazUWfzBv/xRCNrahbgTf6jNRMgVtFytFgLVFWbe16oYf/p7WFSroZVugzqLMTyGL27SpGLaW7qg4D24CINX4LZWfBLWMkCCyegQaDH+77G6AhwiGFY258M/DOR2vnIaMuS2L3inQWG7e6fbNScv908+C2z3XPDoWNxkyWRSzk+lJMk14J8UjvI4qUVgdPvail1H2MfmRD/eXff+WekH6TsO68LgHlE3h24j+QSRL6X9fmO6q6W0tMWqVsbMNNHZIX7CvKxhEOxYytVasGyFtBfyrU5hSlExPoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozvhEWGrkonQvspw8iENIUAOMp8SgDX8FL7wVe+Trt8=;
 b=K17BS2wfRBtFwhRRepDrVviJSeN0xlvDtQpyRQsQ4ljRODzi6cFuNS6cBgnvI/Zqn6s6ZoJ409LQUPbwYxwgqVbPcZLz4Vn/kewJGgeIh5DN68Swlb7/3KptMdfxlABei2dUHu3ATBcNUFfT8WDG5Msj5gCxzax6zi2PGHRAFBE=
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by AS4PR08MB7831.eurprd08.prod.outlook.com (2603:10a6:20b:51b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 13:53:13 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.7897.010; Tue, 27 Aug 2024
 13:53:13 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Johannes Sixt <j6t@kdbg.org>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, ToBoMi via GitGitGadget
	<gitgitgadget@gmail.com>
Subject: AW: [PATCH] git gui: add directly calling merge tool from gitconfig
Thread-Topic: [PATCH] git gui: add directly calling merge tool from gitconfig
Thread-Index: AQHa8isNcDAOYkBM+ESeg1p1+Xz1YrI2cXGAgASqjBA=
Date: Tue, 27 Aug 2024 13:53:13 +0000
Message-ID: 
 <AS2PR08MB8288FC89C781619E82C2A96BE1942@AS2PR08MB8288.eurprd08.prod.outlook.com>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
 <57d00f50-c652-4357-bf9b-02b93f99cfb5@kdbg.org>
In-Reply-To: <57d00f50-c652-4357-bf9b-02b93f99cfb5@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=19998a03-1123-4624-9c80-d4eed9889c50;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2024-08-27T12:53:49Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8288:EE_|AS4PR08MB7831:EE_
x-ms-office365-filtering-correlation-id: 57fa7602-533a-4d43-1b64-08dcc69f97f4
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cUFqUVRCM2loRUp3TEd5b2VmY1h4cUxRWFQ5SHhXTEJYak5pdW85blJuN3lR?=
 =?utf-8?B?OHJGWjRlWnlSU3ltd2dDbGxxd2EyTEE1ZWlSR2FRODNLM28wTFR3VVFRTWRy?=
 =?utf-8?B?SGl6V0JYckFFOUhqWkh6TnYzS2E1bHFER0tEaDdoR3pWT0h3SW1pcGxId3dp?=
 =?utf-8?B?clEwRVk0UmJnTkR5cWM4YitUM1htNmxwblRhaUtoTWtvN2tZWTNUcW1XcFI4?=
 =?utf-8?B?aERqSnkxYjR4QlN0ODlZVHhqclNibTVjVWxyTjBhQVl0VXpZL3U2eUVFSDlh?=
 =?utf-8?B?RmFIeFppTUg0N3RUdFdqRmN5TkVYZit3ZDF2ajI3aHdnZEpSNnQxY1kwMWk2?=
 =?utf-8?B?Sko2aDc2VHgzM3Z5MzBqcUpHcTlweDYzK0NKWjhXTWFWTEZsWUhhVjA1QU0r?=
 =?utf-8?B?YXlCeTQzb1BBR0tUbkluM2tIdGllTkh3SVVCWlRxWWg4QUR2Ylc0VXhTOUg5?=
 =?utf-8?B?cGRJNXU4cEx6VGd2L05ZZkxNZ0N5alprcW5Ud2RYTmVXcTBSQTBNZW1qZzZW?=
 =?utf-8?B?ck1xMlBBOG5tUUJqNlNoay9wWmdqRUhkUWZvckpOTHk3U2FrRWxzQm5zN0Vm?=
 =?utf-8?B?SFp1YnowTmFFcFZiSXZyUGhESUFoSjB4SjlkWTZjdExQRFRQenoxcmxWTHJQ?=
 =?utf-8?B?SnVpVENBcW1rT0YrZGg2ZzhoaUpQWE1qaTZ4YUpZOWFwOTV1V1M4clFtTFlH?=
 =?utf-8?B?MExKbVFiRWFMbEpFUUl1MWVRS3VKZmtaUStBYmFFU2JkVUN4VUpnYTM3cmZH?=
 =?utf-8?B?cXJaZW9wdytUQXViSGhIVTRkT3hyUzZGTzZRYStObUhxRzArS25DV3pOVFNI?=
 =?utf-8?B?ODgzc2JzN3o3M3hwVzlTczNyZnEvT3k1Rm1Wb1l0VWVvRTdyK2FhQ2kvTmFU?=
 =?utf-8?B?dURuQlBCRml1UDRxQkxicldjYVlJQ2Ewc0s4dHpDWEN0b2czNXRsS3ZxM0Zi?=
 =?utf-8?B?Z1R5NFdSZy9RMHJNb05qOHltQTRsYWlkTitFMndZS0czZmJqcnJQWDFJNDIr?=
 =?utf-8?B?NGQyLzlrSlplSlUveWpncGdESnV6SVM2cFFiSUc5U0J6MjFJN0lMS242VXEw?=
 =?utf-8?B?UU9wb3ZKRVU2VDdyd3lvOHJIK1ErN2IvOUtZNFRXUG1mKzJCM2ZPeUp2QUJr?=
 =?utf-8?B?d3ZKdDF2S1kwQmRYMmpLL2g2OGNvZkcwMzNRVmx4bFVtRFNDYUdwSURmWW5i?=
 =?utf-8?B?UG1sdmRCN2wwVVFyczJCWTRhMTQ3YXVzTDhYSWU0ZVFrYk5tcGN4cFMzMlRt?=
 =?utf-8?B?d0xBRXVYZmVHSzJndGV6TFBpMUx5cytBY3NlMHJkL0o0Rm5aNnlEVUlKNXB6?=
 =?utf-8?B?RUQwV1k0Mnovb0RzNVB5Y2RRMjFvVXRreUxvMUJDMVBCT2EyaFlTVWFicFFS?=
 =?utf-8?B?akMxQjNwK0VxdHZsSXF4L2VQMTlqVUorZmtNSSt0aURwS0RVbytJbjE4ZHB3?=
 =?utf-8?B?RmxmanpNN1RiZXgzOGJSSFM4Z3JGR2NZK202ZThWQkE2ZWRva1V4Sk44Q3p5?=
 =?utf-8?B?eEpLM3RBbEpoQ3RJRXc5RExiQVhtVUg5aTFsTkJmdVVHQityNVZaZXQwdVlj?=
 =?utf-8?B?ZHREcHR1QTdmWFZQOWtVR0NBUXU0d3VBcStxK2lZSjF3S2ZGM20rUkxFOEdx?=
 =?utf-8?B?NUxkZTBPMFJCRitxVnc4blhjN1JFNmp4RjJOSmtqcm8rOWxwWHRyN3Zsb0VB?=
 =?utf-8?B?dTVRdldZSXplK2tUdHJuYUFWbWNyNCtkTGtVRGUwR0lqMHBNMkhmOW94bEdn?=
 =?utf-8?B?L1ZQS01SakE3VlpwYWVyWW0ydGIrZHphV3F5MFZPb1h4Y05xS2MvTDdlR0dE?=
 =?utf-8?Q?gVemsSL+kC4SWkediSGjyljST7pL1JJcKblXQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bTNSQlZpUXpOZWorWURLVE5EaGR5bHdHcldEOThVTlV6ZVRna3p2ZmVzeHUv?=
 =?utf-8?B?bzZ0cE1TaVliN0YyZkFiUkl0QzZKb3RRSE9mL0JmWTBlNmJkMDZleVNteGd0?=
 =?utf-8?B?c0o2a1dRYVhicnZVQlQva0JqbW01N04yb1p2cUtuQWNRNTk0UjlvV3Q0NUhw?=
 =?utf-8?B?OHRMRWpjWnl2UkUxY216Vmp2dmpNeEpvTENZTE90U0Q3WWV5RCtrdjVGR0FI?=
 =?utf-8?B?cU1DOEhpSks0a3pDUGZGYzh1clIwT2NpRzBhSnZDQ2s5NTBldnRCQ3NDeTJI?=
 =?utf-8?B?bE5RNEd6RnpqbUZodEVQK1lsN2VlM0ZhaTZkWDB6Sis1b1dGOHZ3bXlSc1dV?=
 =?utf-8?B?MHAzM3JlcVFWSWlMZElOdHRBUGVmYVV5azVYcDNxZGp2dkV1SVB4TkpoRUFs?=
 =?utf-8?B?WW1KRExFNEV2TndrR3Q5V0FnYUlONnNhdlhYaE1CQ1dTN2xGM3JFeFp2ZGw0?=
 =?utf-8?B?MENoMlJDekJFempibEFWc1R5UEM5TFRCbUhXTWxwRnB2dmxOd2pJaUtYZFox?=
 =?utf-8?B?QnNURTI3WVFpcTVlc0d2UWFraXFWOHNyUEg2Sm1xSjkzdHpaZGdnL21wdVlw?=
 =?utf-8?B?c2RUSDd5MlgrTy9rdHRwSEEyNnBKaHYxUndzNHdIZ2N6Z1RNTG1zM3FYdG0y?=
 =?utf-8?B?SzZKNlozL1F6V3U0NDdCUUFJVjk4ejRKbythSTZPcU1mWnVkZlo4ODlIeWd5?=
 =?utf-8?B?S3NwRzVUb2hEZmZrRS9mci83NWdjS1pzVWMyc1dUa2E4MS9NVG1iNHVScHEw?=
 =?utf-8?B?MmRhWk9pRW5MVnVKTTlHNjc0WWIwMnlzOGJJdDdRNGtDMHJ0Y0tZcnNLb1N5?=
 =?utf-8?B?ZUNYUHVMNlc5OElaU1RwZjBsbjFMZ244V3dRdnViT3NjMnczK1JYUnk3bW9N?=
 =?utf-8?B?WnRhWUFIWnkydit4emxacFVVcWdFbFpqQmlFTVJ3QVUzQzFML1lOWURmRGlB?=
 =?utf-8?B?djlaT1plRGhDdWIvTjcvWkludDZzVEFmMGtDVmp2R0R4dDdKaWloMTFYdHFT?=
 =?utf-8?B?d2dIWTM3NStreGxKTzdDcC9RdnBWdmprVWtGbXFsV0Q0cUlFdUZZV1k3VnpG?=
 =?utf-8?B?WExyYkxPNnRzVU1jeEFvUURTcjRaeHRzNDRTSW84Zk9zQ2xMS1N2c1RaalhW?=
 =?utf-8?B?MC90ZnZEK0s3d2VTbFNZUG9Sd3dqUzlBcXA4V3J3Qy9tQW9BaC8rSFQxdnBS?=
 =?utf-8?B?R1hUeXM5TWp6WkZoS29xRW5QNWlDQmVoL2lNT1c1c1FxZmJLNERtNzdsRG4v?=
 =?utf-8?B?Z3hOSjB6dldwZlJNbWVPNjU1SUNwNk96SjREYWFlYkttRXBXU1NqRHhQNVZj?=
 =?utf-8?B?NnBvYmNTMzEwTE1vOWt1N2JGOE9lUVBkeTNnRHlMYndML2pndmtIWUZiWUZV?=
 =?utf-8?B?RXhsTGVKZ1l6Mk1xQkFSL2creW5IcjFrK0twbVR0Q3hVRU9uNEM1eVFuYk04?=
 =?utf-8?B?KzU4VDAwTThsWEw5RlBaOGVyMHY1WUYyM05hc3VPQWZVOXQxY1dPUWljN2RO?=
 =?utf-8?B?SkltRmk2eEZra1ZuZlJnTzg4akt6YUpwZkpZcEFJSHZmZkZtM2poUG1JcGkw?=
 =?utf-8?B?UTFqMXkwODExWUFuaHVESkwyS1c3NXE2QWFMTnNtenIrbE80VkJvYWtJREk3?=
 =?utf-8?B?UURleTFpbWRCdWEvbEU4U0hPbktlVWJLeGZiMGhPSjdMYzFMVWQ2YXV3bjJJ?=
 =?utf-8?B?VDVPdEZXR0IvRjZjUWFoS0RFRmQzSG5lK3hXTHIwTDdtTXJWVXNudCt4dE4r?=
 =?utf-8?B?UHhvWjBqbFljRGFNajZ0ajZvdEtlNkFibkNvY01nTkxxY3g0QkgwSlNEVXhB?=
 =?utf-8?B?YVl3eUkwaGNnSW5EcFB4L2Zqd2RySFdiZmJ3U2JsdDc0Y0Q0cVZ6V0ljdkZD?=
 =?utf-8?B?YlY4V2wvNFNSZXRpRTZIY1NuSENlMmVLaktTZEVsOGxtZHhmcEh1b0k5U2p3?=
 =?utf-8?B?cDhkdDJ5dGNkRHJjeXRpN1M4R1VzYVUxODlkK09VaXBzUjRIY2VRR05ESzdS?=
 =?utf-8?B?djZkVTdZYXEveFBQT1I5ZUtPb2V6NlNCclhjRDVjOU80OXFmelczL010ci9G?=
 =?utf-8?B?UnErWmw2ZWV6V2ZINHFQTVk0TFUxTFk5VEh1eFpTbmR4OWVYQkhKc09RRXBz?=
 =?utf-8?Q?9u6KHXLXvV9LrvDUHZjiSUE79?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8288.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fa7602-533a-4d43-1b64-08dcc69f97f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 13:53:13.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irJCS6Y3rrHUp7/kd3mq4SWoEdfMesTYGAoqffGWZrNpLZhon1TrGCDYYN0UN1OdB7gYYYRq/VuXPVPsfvuLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7831
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay139-hz1.antispameurope.com with 4WtTXC1W2KzNptW
X-cloud-security-connect: mail-vi1eur02lp2044.outbound.protection.outlook.com[104.47.11.44], TLS=1, IP=104.47.11.44
X-cloud-security-Digest:5fad697cae2642fbe1031515d80e0b8c
X-cloud-security:scantime:1.774
DKIM-Signature: a=rsa-sha256;
 bh=ozvhEWGrkonQvspw8iENIUAOMp8SgDX8FL7wVe+Trt8=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1724766807; v=1;
 b=iSmvddcWcHadrp/2LuH8zYjS1SfPmNp/cHqbHSQ4152SzDUXXow0o3b1/3AkDa8PGRXAnzea
 AEsTC22devYIb4iDFu7xX1zriyVrW25KYP085tqf1IkFu4gXPnQQJww868+Ij+dr/AcwKd+MIiL
 WMfNvQ9sJZiAR4XEdcr3M1m2SlrCoRByeWtuj/dtoOquxZaKxPEafHLU+kLN+3jqS+xMSpmi7Ir
 lFzTVzxzv8PvMkV9hcVo0MCuy9hUviwcMz7eMQSw+EhRFUEb0WqbUNiTLiAJvoK0BI7oaw+H54C
 BXVgWcWwFdxqGuua2hKg5o9EClN/z1tLDgTCCj+UCgNVA==

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogSm9oYW5uZXMgU2l4
dCA8ajZ0QGtkYmcub3JnPg0KPiBHZXNlbmRldDogU2Ftc3RhZywgMjQuIEF1Z3VzdCAyMDI0IDE1
OjM4DQo+IEFuOiBCb2VzY2gsIFRvYmlhcyA8dG9iaWFzLmJvZXNjaEBtaWVsZS5jb20+DQo+IENj
OiBnaXRAdmdlci5rZXJuZWwub3JnOyBUb0JvTWkgdmlhIEdpdEdpdEdhZGdldCA8Z2l0Z2l0Z2Fk
Z2V0QGdtYWlsLmNvbT4NCj4gQmV0cmVmZjogUmU6IFtQQVRDSF0gZ2l0IGd1aTogYWRkIGRpcmVj
dGx5IGNhbGxpbmcgbWVyZ2UgdG9vbCBmcm9tIGdpdGNvbmZpZw0KPg0KDQpDb250aW51aW5nIG15
IGluY29tcGxldGUgbGFzdCByZXBseToNCg0KPiBBbSAxOS4wOC4yNCB1bSAxMzoyOSBzY2hyaWVi
IFRvQm9NaSB2aWEgR2l0R2l0R2FkZ2V0Og0KPiA+IEZyb206IGRlYm9ldG8gPHRvYmlhcy5ib2Vz
Y2hAbWllbGUuY29tPg0KPiA+DQo+ID4gKiBnaXQgR3VpIGNhbiBvcGVuIGEgbWVyZ2UgdG9vbCB3
aGVuIGNvbmZsaWN0cyBhcmUNCj4gPiAgICAgZGV0ZWN0ZWQuIFRoZSBtZXJnZSB0b29scyB0aGF0
IGFyZSBhbGxvd2VkIHRvDQo+ID4gICAgIGNhbGwgaGF2ZSB0byBiZSBoYXJkIGNvZGVkIGludG8g
Z2l0IEd1aQ0KPiA+ICAgICBhbHRoZ291Z2ggdGhlcmUgYXJlIGNvbmZpZ3VyYXRpb24gb3B0aW9u
cyBmb3INCj4gPiAgICAgbWVyZ2UgdG9vbHMgZ2l0IGluIHRoZSBnaXQgY29uZmlnLiBHaXQgY2Fs
bHMNCj4gPiAgICAgdGhlIGNvbmZpZ3VyZWQgbWVyZ2UgdG9vbHMgZGlyZWN0bHkgZnJvbSB0aGUN
Cj4gPiAgICAgY29uZmlnIHdoaWxlIGdpdCBHdWkgZG9lc24ndC4NCj4gPiAqIGdpdCBHdWkgY2Fu
IG5vdyBjYWxsIHRoZSB0b29sIGNvbmZpZ3VyZWQgaW4gdGhlDQo+ID4gICAgIGdpdGNvbmZpZyBk
aXJlY3RseS4NCj4gPiAqIENhbiBiZSBlbmFibGVkIHRocm91Z2ggc2V0dGluZw0KPiA+ICAgICBn
dWkubWVyZ2VUb29sRnJvbUNvbmZpZw0KPg0KPiBDYW4gd2UgZG8gYmV0dGVyIHRoYW4gaGF2aW5n
IGEgbmV3IGNvbmZpZ3VyYXRpb24gdmFyaWFibGU/IExldCdzIHNheSB5b3UgaGF2ZQ0KPiBjb25m
aWd1cmVkIG1lcmdlLnRvb2w9dnNjb2RlLiBUaGlzIHRvb2wgaXMgbm90IHN1cHBvcnRlZCwgYnV0
IHlvdSBoYXZlDQo+IGNvbmZpZ3VyZWQgbWVyZ2V0b29sLnZzY29kZS5jbWQgc3VpdGFibHkuIENh
biB3ZSBub3QgdXNlIHRoZSBsYXR0ZXINCj4gY29uZmlndXJhdGlvbiB2YXJpYWJsZSB1bmNvbmRp
dGlvbmFsbHk/DQo+DQo+IExpa2V3aXNlLCBzYXksIHlvdSBoYXZlIGNvbmZpZ3VyZWQgbWVyZ2Uu
dG9vbD1iYzMuIFRoaXMgb25lICppcyogc3VwcG9ydGVkLg0KPiBXaGF0IGNvdWxkIGdvIHdyb25n
IGlmIG1lcmdldG9vbC5iYzMuY21kIGlzIHVzZWQgaW5zdGVhZCBvZiB0aGUgYnVpbHQtaW4NCj4g
Y29tbWFuZCBsaW5lPyBUaGUgYmVoYXZpb3Igd291bGQgY2hhbmdlIGZvciB1c2VycyB0aGF0IGNv
bmZpZ3VyZWQNCj4gbWVyZ2V0b29sLiR0b29sLmNtZCBmb3IgYSBzdXBwb3J0ZWQgdG9vbC4gQnV0
IHdvdWxkIGl0IGNoYW5nZSBmb3IgdGhlIHdvcnNlPw0KPg0KPiBCVFcsIHRoZSBjb2RlIGJ1aWxk
cyBkaWZmZXJlbnQgY29tbWFuZCBsaW5lcyBkZXBlbmRpbmcgb24gd2hldGhlciBhIGJhc2UNCj4g
ZmlsZSBpcyBhdmFpbGFibGUgb3Igbm90LiBIb3cgZG9lcyBtZXJnZXRvb2wuJHRvb2wuY21kIGhh
bmRsZSB0aGUgY2FzZXM/DQo+DQo+ID4gKiBEaXNhYmxlZCBieSBkZWZhdWx0LCBzaW5jZSBvcHRp
b24gaXMgbW9zdCBsaWtlbHkNCj4gPiAgICAgbmV2ZXIgc2V0DQo+ID4gKiBiYzMgYW5kIHZzY29k
ZSB0ZXN0ZWQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGRlYm9ldG8gPHRvYmlhcy5ib2VzY2hA
bWllbGUuY29tPg0KPg0KPiBTb21lIHJlbWFya3Mgb24gdGhlIGNvbW1pdCBtZXNzYWdlOg0KPg0K
PiAtIFRoZSBTaWduZWQtb2ZmLWJ5IGxpbmUgaGFzIGxlZ2FsIGNvbnNlcXVlbmNlcy4gVGhlcmVm
b3JlLCB3ZSByZXF1aXJlIHRoYXQNCj4gYXV0aG9ycyB1c2UgdGhlaXIgZ2VudWluZSBuYW1lLCBu
b3QgYW4gYWxpYXMuIEFsc28sIHRoZSBGcm9tIGxpbmUgbXVzdCBtYXRjaA0KPiB0aGUgU2lnbmVk
LW9mZi1ieSBsaW5lLg0KPg0KPiAtIFBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGUgY29tbWl0IG1l
c3NhZ2VzIGluIHRoZSBjb2RlIGJhc2UuIFRoZSBmb3JtYXR0aW5nDQo+IHByZXNlbnRlZCBoZXJl
IGlzIHZlcnkgdW51c3VhbC4gUGxlYXNlIHdyaXRlIGluIGZ1bGwgc2VudGVuY2VzIGluY2x1ZGlu
Zw0KPiBwdW5jdHVhdGlvbiwgYW5kIHVzZSBwYXJhZ3JhcGhzIHdoZXJlIG5lZWRlZC4NCj4NCj4g
LSBQbGVhc2Ugc3RhdGUgdGhlIHByb2JsZW0gdGhhdCBpcyBiZWluZyBzb2x2ZWQgKGluIHByZXNl
bnQgdGVuc2UpLiBUaGlzIHNob3VsZA0KPiBtb3RpdmF0ZSB0aGUgY2hhbmdlLCBpLmUuLCBwcm92
aWRlIGEgY29udmluY2luZyBhcmd1bWVudCB3aHkgdGhlIGNoYW5nZSBpcw0KPiBuZWVkZWQuIFRo
ZW4gc3RhdGUgd2hhdCB0aGUgc29sdXRpb24gaXMgaW4gaW1wZXJhdGl2ZSBtb29kLCB0aGF0IGlz
LCBhbg0KPiBpbnN0cnVjdGlvbiB0byB0aGUgY29kZSB0byBjaGFuZ2UgaW4gc3VjaCBhbmQgc3Vj
aCB3YXkuIFVzZSBleGFtcGxlcyB0bw0KPiBjbGFyaWZ5IGhvdyB0aGUgbmV3IGZlYXR1cmUgY2Fu
IGJlIHVzZWQuDQo+DQo+ID4gLS0tDQo+ID4gICAgIGdpdCBndWk6IGFkZCBkaXJlY3RseSBjYWxs
aW5nIG1lcmdlIHRvb2wgZnJvbSBnaXRjb25maWcNCj4gPg0KPiA+IFB1Ymxpc2hlZC1BczoNCj4g
PiBodHRwczovL2dpdGh1Yi5jb20vZ2l0Z2l0Z2FkZ2V0L2dpdC9yZWxlYXNlcy90YWcvcHItDQo+
IDE3NzMlMkZUb0JvTWklMkZhZA0KPiA+IGRfbWVyZ2VfdG9vbF9mcm9tX2NvbmZpZ19maWxlLXYx
DQo+ID4gRmV0Y2gtSXQtVmlhOiBnaXQgZmV0Y2ggaHR0cHM6Ly9naXRodWIuY29tL2dpdGdpdGdh
ZGdldC9naXQNCj4gPiBwci0xNzczL1RvQm9NaS9hZGRfbWVyZ2VfdG9vbF9mcm9tX2NvbmZpZ19m
aWxlLXYxDQo+ID4gUHVsbC1SZXF1ZXN0OiBodHRwczovL2dpdGh1Yi5jb20vZ2l0Z2l0Z2FkZ2V0
L2dpdC9wdWxsLzE3NzMNCj4gPg0KPiA+ICBEb2N1bWVudGF0aW9uL2NvbmZpZy9ndWkudHh0IHwg
IDQgKysrKw0KPiA+ICBnaXQtZ3VpL2xpYi9tZXJnZXRvb2wudGNsICAgIHwgMTEgKysrKysrKysr
LS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vY29uZmlnL2d1aS50eHQNCj4g
PiBiL0RvY3VtZW50YXRpb24vY29uZmlnL2d1aS50eHQgaW5kZXggMTcxYmU3NzRkMjQuLmU2M2Qw
YjQ2ZTdjDQo+IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnL2d1aS50eHQN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy9ndWkudHh0DQo+ID4gQEAgLTU1LDMgKzU1
LDcgQEAgZ3VpLmJsYW1laGlzdG9yeWN0eDo6DQo+ID4gICAgIGxpbmtnaXQ6Z2l0a1sxXSBmb3Ig
dGhlIHNlbGVjdGVkIGNvbW1pdCwgd2hlbiB0aGUgYFNob3cgSGlzdG9yeQ0KPiA+ICAgICBDb250
ZXh0YCBtZW51IGl0ZW0gaXMgaW52b2tlZCBmcm9tICdnaXQgZ3VpIGJsYW1lJy4gSWYgdGhpcw0K
PiA+ICAgICB2YXJpYWJsZSBpcyBzZXQgdG8gemVybywgdGhlIHdob2xlIGhpc3RvcnkgaXMgc2hv
d24uDQo+ID4gKw0KPiA+ICtndWkubWVyZ2VUb29sRnJvbUNvbmZpZzo6DQo+ID4gKyAgIElmIHRy
dWUsIGFsbG93IHRvIGNhbGwgdGhlIG1lcmdlIHRvb2wgY29uZmlndXJlZCBpbiBnaXRjb25maWcN
Cj4gPiArICAgaW4gZ2l0IGd1aSBkaXJlY3RseS4NCj4gPiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9m
IGZpbGUNCj4NCj4gVW5mb3J0dW5hdGVseSwgRG9jdW1lbnRhdGlvbi9jb25maWcvZ3VpLnR4dCBp
cyBub3QgcGFydCBvZiB0aGUgR2l0IEdVSQ0KPiByZXBvc2l0b3J5LiBBbnkgY2hhbmdlcyB0byB0
aGUgZG9jdW1lbnRhdGlvbiBtdXN0IGJlIHN1Ym1pdHRlZCBhcyBzZXBhcmF0ZQ0KPiBwYXRjaC4N
Cj4NCg0KQ29uZmlndXJhdGlvbiBvcHRpb24gd2lsbCBiZSByZW1vdmVkIGluIHRoZSBuZXh0IHBh
dGNoIHZlcnNpb24uIFRoZXJlZm9yZSB0aGUNCmRvY3VtZW50YXRpb24gY2hhbmdlIGlzIG5vIGxv
bmdlciBuZWVkZWQuDQoNCj4gUGxlYXNlIGJlIGNhcmVmdWwgbm90IHRvIGludHJvZHVjZSBhbiBp
bmNvbXBsZXRlIGxhc3QgbGluZXMuIFRha2Ugbm90ZSBvZiAiTm8NCj4gbmV3bGluZSBhdCBlbmQg
b2YgZmlsZSIuIEl0IHNob3VsZCBub3QgYmUgdGhlcmUuDQo+DQoNClNlZSBhYm92ZS4NCg0KPiA+
IGRpZmYgLS1naXQgYS9naXQtZ3VpL2xpYi9tZXJnZXRvb2wudGNsIGIvZ2l0LWd1aS9saWIvbWVy
Z2V0b29sLnRjbA0KPiA+IGluZGV4IGU2ODhiMDE2ZWY2Li5mYmQwODg5NjEyYSAxMDA2NDQNCj4g
PiAtLS0gYS9naXQtZ3VpL2xpYi9tZXJnZXRvb2wudGNsDQo+ID4gKysrIGIvZ2l0LWd1aS9saWIv
bWVyZ2V0b29sLnRjbA0KPiA+IEBAIC0yNzIsOCArMjcyLDE1IEBAIHByb2MgbWVyZ2VfcmVzb2x2
ZV90b29sMiB7fSB7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4gICAgIGRlZmF1
bHQgew0KPiA+IC0gICAgICAgICAgIGVycm9yX3BvcHVwIFttYyAiVW5zdXBwb3J0ZWQgbWVyZ2Ug
dG9vbCAnJXMnIiAkdG9vbF0NCj4gPiAtICAgICAgICAgICByZXR1cm4NCj4gPiArICAgICAgICAg
ICBpZiB7W2lzX2NvbmZpZ190cnVlIGd1aS5tZXJnZXRvb2xmcm9tY29uZmlnXX0gew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgc2V0IHBhdGggW2dldF9jb25maWcgbWVyZ2V0b29sLiR0b29sLnBh
dGhdDQo+DQo+IEF0IHRoaXMgcG9pbnQsIHRoZSB2YWx1ZSBhc3NpZ25lZCB0byAkcGF0aCBoZXJl
IGlzIGFscmVhZHkgYXZhaWxhYmxlIGluDQo+ICRtZXJnZV90b29sX3BhdGguDQo+DQoNClRydWUg
LSBjb3JyZWN0ZWQgaW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gPiArICAgICAgICAgICAgICAgICAg
IHNldCBjbWRsaW5lX2NvbmZpZyBbZ2V0X2NvbmZpZyBtZXJnZXRvb2wuJHRvb2wuY21kXQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgc2V0IGNtZGxpbmVfc3Vic3RpdHV0ZWQgW3N1YnN0IC1ub2Jh
Y2tzbGFzaGVzIC0NCj4gbm9jb21tYW5kcyAkY21kbGluZV9jb25maWddDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICBzZXQgY21kbGluZSBbbHJlcGxhY2UgJGNtZGxpbmVfc3Vic3RpdHV0ZWQgMCAw
ICRwYXRoXQ0KPg0KPiBJIGhhdmVuJ3QgeWV0IHRha2VuIHRoZSB0aW1lIHRvIHN0dWR5IHdoYXQg
dGhlc2UgbGluZXMgZG8gKEkgYW0gZmFyIGZyb20gZmx1ZW50DQo+IGluIFRjbCkgYW5kIGhhdmUg
bm8gb3BpbmlvbiwgeWV0Lg0KPg0KDQpUaGV5IHJlcGxhY2UgdGhlIHZhcmlhYmxlcyBvbmUgY2Fu
IHB1dCBpbnRvIG1lcmdldG9vbC5jbWQgbGlrZSAkUkVNT1RFIG9yDQokTE9DQUwuDQpXaXRob3V0
IHRoaXMgc3Vic3RpdHV0aW9uIGNvbW1hbmQgdGhleSBhcmUgbm90IHJlcGxhY2VkIHdpdGggdGhl
IHJlYWwgZmlsZQ0KcGF0aHMuDQpTZWUgdGhpcyBleGFtcGxlIGZvciB2c2NvZGU6DQpjbWQgPSBc
IkNvZGUuZXhlXCIgLS13YWl0IC0tbWVyZ2UgXCIkTE9DQUxcIiBcIiRSRU1PVEVcIiBcIiRCQVNF
XCIgXCIkTUVSR0VEXCINCg0KPiA+ICsgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICBlcnJvcl9wb3B1cCBbbWMgIlVuc3VwcG9ydGVkIG1lcmdlIHRvb2wgJyVzJyIN
Cj4gJHRvb2xdDQo+ID4gKyAgICAgICAgICAgICAgICAgICByZXR1cm4NCj4gPiArICAgICAgICAg
ICB9DQo+ID4gICAgIH0NCj4gPiAgICAgfQ0KPiA+DQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogYjk4
NDllNGY3NjMxZDgwZjE0NmQxNTliZjdiNjAyNjNiMzIwNTYzMg0KPg0KPiAtLSBIYW5uZXMNCg0K
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmltcGVyaWFsLVdl
cmtlIG9IRywgU2l0eiBCw7xuZGUsIFJlZ2lzdGVyZ2VyaWNodCBCYWQgT2V5bmhhdXNlbiAtIEhS
QSA0ODI1DQo=
