Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021131.outbound.protection.outlook.com [40.93.199.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF901EDA33
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812266; cv=fail; b=gTP6NYYkDKUmQzSqPyNyyE4oMFNUZqjaMaVDv9A8s0gWB9Jo/EtFobcvrLUKNZVs5R5THyG4jFJZAVJBJI1nTjS8ocFHU25zMv0vBWOj4oWI8RAm6M8m2Qurwyv04xk54kZRQOirgcsFlp+J4I/+vXjpo/Xm8HDEHCuRG9alna0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812266; c=relaxed/simple;
	bh=Nm6c9p1x6d4JMJ5EPr+wnT3XQYQhGhaGE4CSyK4cClY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jj+bsAg5V2yiHZqkN9fI2Rw1ezTsNb7NTB/0Ad7FarU8ydeubPgf+8ep6ogo3FunJbxfvll5FzMwyukuV4mihTjEOC8FH++xO5i2YnMAp4oxOZAgC+52AkZIg2dKGsaBVYgfytRPN/rbU+oDiBQRkC5XWpKLDltAtzr3uwcIDKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gXAejc04; arc=fail smtp.client-ip=40.93.199.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gXAejc04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzxACqligzJOFMGTGHHNxfGVNJVrP5HPesD87ciCDE5IdBIi7MCvwKxUJ9H08zX6Z6PZtJBSdl72w9GB5t7TAGWhCleBpnGvrV9PDDRoLVE7ouHpt3jBQsgULvRDqVeDVwXTr5RszThXp4QH1ZrPBaNLHfwd5hr4VUuNB4+ZywYCTaFutUzeX6DR9MNttrX75t9xHc3pXRsKIMuoComhNDIsWXfyLqcjSREF5whGNKK4YtLdfCtt3VAVxNigXSpzPQKVbb2ZzSuZmi9myzc3jz1fLvE/T48O073Mg0tyoGOveF4IQPU1Ozi4ePGIuIRlKTxcVmmwHHAMI2OA6Dz/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm6c9p1x6d4JMJ5EPr+wnT3XQYQhGhaGE4CSyK4cClY=;
 b=YcHzARuRV1CUdSGbNfv1KYjsEny0SjQYpmKPERl9axZfgPZak9XynuBJ1hkTKmYQz50l3fGyAocz8m4ZtNrU5q5sPPM6k/ZHxBtYR74YkGc++bxUAFlEYUy+4sqt1Pbxw0TAfj6l/d0H/oTVOcT2PdWKtjIDBtcq1tknO9g6RKdlOq2s55KT3jQkfm2TCrgasJWObgieXb7kWVQWAOjg7bpOQOVK6i3IukFOB4NsCh478rwQ1uBnp3c7Vj77EXHiQ60YEZ1Vx+SyLpcpKHX+q7VY55sElmis5Xf/SoEhrllXSBNt4J+ha7fNqw7TfFrFJTONYctY+wlNBkMzh4/eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm6c9p1x6d4JMJ5EPr+wnT3XQYQhGhaGE4CSyK4cClY=;
 b=gXAejc04LRsLjw00ZJJQkG1f8b1EvbXkB8JrsLhgNt8MPJX0mKY4d1+icw0RMUx7cvJGuwFmf2NDu1ERwN3c504qP/NgAAY9t4jj9gbxs142VAjdf76U6aGg04QKb9cb3XqImHQxDj83UzA/GnqgAz3A6SElA2RikqbnewZWkx0=
Received: from DM6PR21MB1291.namprd21.prod.outlook.com (2603:10b6:5:161::27)
 by DM4PR21MB3418.namprd21.prod.outlook.com (2603:10b6:8:a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.25; Wed, 12 Mar 2025 20:44:22 +0000
Received: from DM6PR21MB1291.namprd21.prod.outlook.com
 ([fe80::e20:a64e:f835:1a6f]) by DM6PR21MB1291.namprd21.prod.outlook.com
 ([fe80::e20:a64e:f835:1a6f%2]) with mapi id 15.20.8511.000; Wed, 12 Mar 2025
 20:44:21 +0000
From: "Haifang Wang (Centific Technologies Inc)" <v-haiwang@microsoft.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Windows Application Issue | Git | REF # 56282410
Thread-Topic: Windows Application Issue | Git | REF # 56282410
Thread-Index: AQHbk40/kc6f216w7k+hrNR1Nzo7P7Nv98JA
Date: Wed, 12 Mar 2025 20:44:21 +0000
Message-ID:
 <DM6PR21MB129127285D6FDFF80A1AE87CE5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
References:
 <CH2PR00MB0812B85F95651EC133D38264D255A@CH2PR00MB0812.namprd00.prod.outlook.com>
 <BYAPR02MB49983AE922A5690EB86BFD2DA155A@BYAPR02MB4998.namprd02.prod.outlook.com>
 <CY8PR00MB1459EF0E020DABD52F63460AD20BA@CY8PR00MB1459.namprd00.prod.outlook.com>
 <BL1PR21MB320858BAF11193AB06109B2DE50BA@BL1PR21MB3208.namprd21.prod.outlook.com>
 <DM8PR02MB80213198F9A71571EB92D989CD08A@DM8PR02MB8021.namprd02.prod.outlook.com>
 <PH7PR21MB3263AB0D6C1DE7D56E9613AEE5F12@PH7PR21MB3263.namprd21.prod.outlook.com>
 <DM8PR02MB802134089B95821DF4174A14CDF22@DM8PR02MB8021.namprd02.prod.outlook.com>
 <DM6PR21MB12917960F9D9D488A03FCF19E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
 <DM6PR21MB129188369F4FE0C0DF306B80E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
In-Reply-To:
 <DM6PR21MB129188369F4FE0C0DF306B80E5D02@DM6PR21MB1291.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T15:42:32.0000000Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1291:EE_|DM4PR21MB3418:EE_
x-ms-office365-filtering-correlation-id: d357c032-3c27-42cc-d98d-08dd61a6ab13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KC4GgZms1hDfRiFDK221ekB51kRizefStNshiAYtTx9wz6ONneSkyPH5Pu?=
 =?iso-8859-1?Q?exBXReUbBDWQ0ECivNjpCuC1tpCCeC/E6nZXHyNt/zKAcAvS6SwF2HIvZT?=
 =?iso-8859-1?Q?8WOWwxPQb7G18U+gf4n87rbbrcGmdwh7pLLXOLHByguOewP1okaXvkcvkQ?=
 =?iso-8859-1?Q?j0Uc+R/tMPVaK20DgKG/GGnt4NEZJxPSc6gm1wBjY6xZrF4z2PWnq05tGb?=
 =?iso-8859-1?Q?fWaix+5wxTX62XbeJD2eevaJ6TW4ZBIw+LA1Sx0Q+A0aX+l2sLMfEeciXO?=
 =?iso-8859-1?Q?fr5TYydPNofpyolOSej1FUb22AoQJ30lMDSL4p1CBMLRCNRAEG4srT/XvG?=
 =?iso-8859-1?Q?OX5DRGfvuBbunzNMw3J39ZCxlG3h4ls51IZX3plEx6VAiDhlTTuiWG47Us?=
 =?iso-8859-1?Q?9DT4iVy2lFWGVc6xNMPakIliagwyibaw8rPXXCwh5e1cvfc0YJM9dCbP2Y?=
 =?iso-8859-1?Q?YhJHOm4IBg//8onl5HAg2nkXLmRSgI0rx6V1c1eBnQFCY/PhZZg8+WgRzQ?=
 =?iso-8859-1?Q?8k2zdj8w9X6Vce1FjqafzaLiCVFQV2xQKZXNWbVpKHEuDeRZlL9v8M4saY?=
 =?iso-8859-1?Q?gfd6pih89HoyROUXXNDYZteJtqqLAoQpMd0qw75k0frj/xiJJFWQU8KLqX?=
 =?iso-8859-1?Q?Y98UJLks5OYNgWpvjKd7Hej7yO799AM+7XNh3CH189g3pw+aysrF5BcE6c?=
 =?iso-8859-1?Q?U1MsE6SsBXa54YIRkv4sGyu7bViwuuO62rlqI8KrE1TBAWMUuLkQdxWn6j?=
 =?iso-8859-1?Q?Yocfj1g/vY7Beh1BNz/cnt+f1nLnf3BwdJPJHw4ox+acO8BJDPdn/J1r+I?=
 =?iso-8859-1?Q?FLVIaSst/cgMuIzfbYJeiaC90GWZYMPHCfnN6YZ9+NCXUZPhITH52x3wX5?=
 =?iso-8859-1?Q?1Uvq5Vc0Ka9seaF0So1Rf3RuZQyPPuMK/mRMkbNlFZ6Wo2qhLDU9EkzBn1?=
 =?iso-8859-1?Q?yyRjBhDdDW0WFsHtrewozHCoSP6OA1SQxJf2o54Rv68e3ZHYhtr9XOUCOV?=
 =?iso-8859-1?Q?lB32/mYNg/DB7Aax6JVltfitSpWdO5HtkbVQIyAwA+dY4ZtOOByfvczsCq?=
 =?iso-8859-1?Q?E1wNb6oToDwQM5VtY02yNAIA96/hJspN0zb7KjdUH4wWo0zdEX7t9jxE1r?=
 =?iso-8859-1?Q?x7y3chk5FuczuEGX0woGdV3X3Db8shv5egHIMB+7QmL0Oxvom924mtypjS?=
 =?iso-8859-1?Q?ES5cONc6MlnyDR+B2/9ET5wwClujBPImpLWUA2tE5skxe3sJbCGP0iV6l+?=
 =?iso-8859-1?Q?o1xk2OnQ89BdICTmHchtYzWWsBSKUhftJKq8P4MBRDD+AbuqiCF2r5Catu?=
 =?iso-8859-1?Q?IU/LzRFZAOrwMmYAUFGhWpnwgV3ynJJNHw9vhDnQVtRuba4wQIX8okWwSa?=
 =?iso-8859-1?Q?4L/EAr6VG+cbUS6+FqrnXrnEumkq5SAJGv73oBZGVbwqDz617/VhWL/Wa/?=
 =?iso-8859-1?Q?KHi0GimF/K/zaUm4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1291.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hjSjzpRZhGZ0UfUnQxCu2zk9HwBZHnnk3kswiUinho+rzEAG6chiIEpFuZ?=
 =?iso-8859-1?Q?UvaSb0FTwtW04tgSZWwtEPpMOvyyi/nTG/+DDQ1ps7jwjlKBKR2DtmxRiD?=
 =?iso-8859-1?Q?vYP/RkdDxtocPHGND2SzQXoXSA9HDB9t9p+teM/m9innbbsp6xrftCx0dw?=
 =?iso-8859-1?Q?NOH/ricmtJ9+yRMvcbqxg3XbK6IbV0Ptd3CIde9F510Ce1oNhD5n93ILbM?=
 =?iso-8859-1?Q?OSjs5nNefSTG3IPTKACFfYhfH6Ke4rhxPyN58y6KfdpQrt6xk/r2BUBwIi?=
 =?iso-8859-1?Q?8+h413uPAf0kfqaCoVZ/yf5qJTFn6b6l8AznmwwIz2tuP6FL9oinJ8VkME?=
 =?iso-8859-1?Q?rgSmGrudRkRjZhGYyCXR4zFvGpNOMQAKKB7xbCJUTty0H6WTq3eha9kQSd?=
 =?iso-8859-1?Q?eE7kBjbjAIaUOtsf741/baiQPr1UhhVamA2sk92PRa3k58i6OmwUC3yUT+?=
 =?iso-8859-1?Q?gCPRcHTa3ft1MeGJeZhtOlKkwnP3jC9ZzlGpv6f8nADtvSzxUpGIEDIsbW?=
 =?iso-8859-1?Q?7U1teNtzHCmg6nP0fRa1nWMJRQnKBVG43lx2SSDO9VKSACKPYraIkLuWem?=
 =?iso-8859-1?Q?GFHji+O3rz4gcFMt9OBgg07MquNB+zMbojrJY72q26wOa9vTKuajBNjr9O?=
 =?iso-8859-1?Q?3Dimxz39Mr6B7o2/9qcHqFyoKaL5odpZrOpQ8QVurh3kebRLihrJQkPQuQ?=
 =?iso-8859-1?Q?Qts+XDe8Lo9SJf8ZuT8rUUT1PPE+kuwVtEIHKWEg/TXsMliAV+gsXYYa5I?=
 =?iso-8859-1?Q?RNWWPVKy50sTgnJLW0MfdEvFhm6D/yJkOVr0n5Pg/0NddVfBy58ZQlJ62Q?=
 =?iso-8859-1?Q?4kiicU5A1ThpnWaMcmoL7poWXJRPO25t1/12bQIucJpcw5vagC2b/WGFaf?=
 =?iso-8859-1?Q?6aBbm+uflugNFxz1cl63A7EAl+0GYzoRT+MV10gy/4nsBAxG5IkxVLYo+w?=
 =?iso-8859-1?Q?6kt437VZMm7QWAAowNw8ufTgEOPH6YGTuxZ7KkI9aauwhXWEJ/gwl8GiHE?=
 =?iso-8859-1?Q?xR8qKnJn919V3bQk8NeDJlu53ryjRlNyHgBBCjYuRZ5eHC123bQzF/7qjQ?=
 =?iso-8859-1?Q?tyGm6daoBVPplsKjGDt+KujMiuWbyHobi9VfFuK4R2E88A1ezRo5QaI2d8?=
 =?iso-8859-1?Q?euLm5cb8vbgseyNdRgeazp952q7arAleVhz5mBVPrvzk2xE++6wKM8fSbx?=
 =?iso-8859-1?Q?8sdpUq4P0niBKHESyb7HKQrctWaYKrKTT4e0iaVVGxPcBBaSYyBYOJhTaD?=
 =?iso-8859-1?Q?orHDNm6TygPDblCFilUDy5GbIWCNnL6EyvHm01dNlAYsXwikW9NdF3br4v?=
 =?iso-8859-1?Q?rE7ZmzF3c2WrEe2PFd0JGl6eBxwByEauuvuspaJCgDKHPGMphSo5HIF/X5?=
 =?iso-8859-1?Q?RdPhVI713p7aJ4KOfRwZ3pj9TdGz9F7gKdqwPCHJjWfiEDmZl8VyTQsCsL?=
 =?iso-8859-1?Q?blGjqkZ1XBiXYUV+j8y6GZr586cMJNvrdGJfCS+GqmbwYifl0OpdmY7m5N?=
 =?iso-8859-1?Q?1T5qY4lxJYwz67Q198ZAHISN24WyxdwTesxFZeeIgW6olzXgRb2RwOKemg?=
 =?iso-8859-1?Q?j9kkxkRaWUDv+PbiZPNAt82qkREfqanhEqxHeNZORvNM6vLN13gv7HEN24?=
 =?iso-8859-1?Q?XQUW76K7wvHM4nHZiNwENlsrIpM6ntHWBD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1291.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d357c032-3c27-42cc-d98d-08dd61a6ab13
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 20:44:21.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0QNTElA60ni2RpRHsmslkBAhSod5aKRI1y1CHpSHcJPEtrfYMM67mO9g5igvq5HcqrOwJm62h/+epACgpOWuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3418

Hi Team

I'm a program manager in the Windows App Compatibility Team at Microsoft. W=
e work with Microsoft's test organization to notify developers when issues =
have been identified in their applications. We're reaching out to notify yo=
u of a potential issue in one of your applications.

The issue details are below, please review it when you have a moment. Our g=
oal is to work with you to address this issue and to understand what your e=
xpected timeline to address this issue might be. If you have any questions =
about the details below or have already addressed this issue in a forthcomi=
ng update, please let me know.
=A0
Account: The git development community
Product: Git
Reference #56282410
Issue

Encountered an error prompt observed in foreground when clicking on Help Do=
cumentation.

Environment: Desktop
OS: Windows 11
App Version: 2.48.1

Repro Steps:
1. Deploy latest OS
2. Perform Windows and Store updates=20
3. Download the application from vendor(https://git-scm.com/downloads/win).
4. Install the application by Default Next Steps.
5. Launch Git Gui and Create a new Repository.
6. Click on help and click on Online Documentation .
7. Observe=A0
=A0
Observations:=A0=A0=A0=20
Encountered an error prompt observed in foreground when clicking on Help Do=
cumentation.=20

Expected Results:
No Error prompt should be observed while redirecting to edge
=A0
Thanks!
Haifang
