Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE42224256
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081628; cv=fail; b=UzuSynZBYgwx31pMddB/C/G3C9H7/wFSUIFJ7isnFkwAR+mOjC60X01YzO3523pGZhGyF/cHidyUAeYF+Pu8T4aB/piPCTLcmcJimxtQk4AEtQnKpYfWW03anA/7cWGQAI6GMiKurvPs8qzJcZhqLQvWjaVrbpjhDRfWWNRoWdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081628; c=relaxed/simple;
	bh=VHDw/gipUebLWLs1VfB7ojQGjlLH7dYepCweAIQ1R8o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oRtg4mXaKOIl+0Ab33bPbDlBPvX8drryOi9AdgO1CL4tjmrKuVm2l2JPPJ8QxTiQH7n7ZKteYfeN2T6T1t7IBNspr8MZzvQSEGv2ETjiroTGX7EPecQNRDcInyAoOgaMVmgdOXvjNhnymmEHo0x/XKu1eaNHdWTHF8vpPiiuNh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onegas.com; spf=pass smtp.mailfrom=onegas.com; dkim=pass (1024-bit key) header.d=onegas.com header.i=@onegas.com header.b=Yj6+7gxO; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onegas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onegas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onegas.com header.i=@onegas.com header.b="Yj6+7gxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg/LFXwgFN1wNrzSCENTVfjhDjBbACh9Fbx3p9Ub7AZ4xcOy9D/21JCcWX7nAh3ArrfFsv1u0OAsCMtRDLxeeex+lxPcYyyElSN8rsgjkyrgd/nJIw6S+z0nhr9AoA1SlpgXe3rQcxsR8482QmrSL2TFV/DvCbKWkU0kqxXqBbWJ4inZKR4Czqa5Ub5W6iytK7NcGGAwIKU7+7bduQ2Kt5jRZS6RP3X272rFZHMVSEr7UAQbk79uR98IKaj57fYFDshV1qw8PwCRHMWm8UrfuxyqZG+9505guLgPjFtyVJsJCIoZP+S29X0ZhQyIv7NvMWJz6AOmU4Pdco/Ph+T9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH88sUrg7rlK/mV+Vgh3R0UytbHHIdEuMoCs7mO90PQ=;
 b=FcI5uZJzteDdpe7M900+4263LWoPqzt5lgzHlEB/+rIs+jLH9WnyMgONKaf1MMZ9zRNk3kyRAJVcQecbRe6E4ADWmCw10rNsVXotps/Z7HxeeLSI9OiJ7SSyM6szVUhKdKe/fgk2UgXWhf2uELj24LXh2kIUC+fsK7W5Vojk+Wz8SgCLWan+yf79SHvJhrh9M86K5w/FTm9ssi3khwg8Q3nCt8S5PJInc2BkusJuc0K6KeZv9sbmv+K8U9lSwxgi5/1xrXk+LQjvYgjRnpoakV3zGUtt0fRx2H/XGCogGiCCPnDVpSk6glZb1bFpR0m1zsmvH0NYVeOZNvtcnL3zXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onegas.com; dmarc=pass action=none header.from=onegas.com;
 dkim=pass header.d=onegas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onegas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH88sUrg7rlK/mV+Vgh3R0UytbHHIdEuMoCs7mO90PQ=;
 b=Yj6+7gxOniOgk/qmTo8E26DecakukRavTBoyNwLS2OAZwm+cdkE+Ub+uB3IfNAa/T6ttQctAAU2bzJtCBu2CTYuS2IYLe38cHBsL/JJNQsvuKF3M1mXfUIP4HZMqX3M3nIaScUXQGec7//LRmxzeJ0uwArYwp2Ck+BZj3kRiyVQ=
Received: from PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 17:20:22 +0000
Received: from PH7PR11MB6546.namprd11.prod.outlook.com
 ([fe80::c892:2100:6b6a:1248]) by PH7PR11MB6546.namprd11.prod.outlook.com
 ([fe80::c892:2100:6b6a:1248%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 17:20:22 +0000
From: "Preston, David J." <David.Preston@onegas.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git bash bug
Thread-Topic: git bash bug
Thread-Index: Advw9YPcq6kAzMn0R2qEr2oYh5ELDg==
Date: Wed, 9 Jul 2025 17:20:22 +0000
Message-ID:
 <PH7PR11MB65466DEE20BA470C600C7B9B9549A@PH7PR11MB6546.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=onegas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6546:EE_|CO1PR11MB5140:EE_
x-ms-office365-filtering-correlation-id: bf04de56-a12d-418a-38e3-08ddbf0ce2c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BnAtPSomElggn8lYXZGgnePLErPRc2wOj8mdoLKFeqB3/KNMALgGkC8r8Z0y?=
 =?us-ascii?Q?FGmk1UgWmnCVI/Sm0gcQPkZvnmOZcc9w+PjYcaJo5f/n0qa9QAhPnad83UIU?=
 =?us-ascii?Q?I4ARkQHRksZ/7hudaedscaUt5k286gwsur1390sHQK3j/HCOefvA9Ul3RPKt?=
 =?us-ascii?Q?BgBnGdV+RYMycuGBJd835BrFqUJn4KnS7LQGAXmliRCtCkgUzayjVCFEh/pG?=
 =?us-ascii?Q?f9hegoJscRJeJkUMOskCloBNgS0VSnCrSENWhPq7gcj/3XmiHfLDASE+rUJt?=
 =?us-ascii?Q?p8Wp+lP5VAVqufqGsCQvRpXPzBsWurQZecWz9iXIKzyEtPJdjyAm6NvsVCmM?=
 =?us-ascii?Q?BH6YdBB+J6geGrpYfylWAPgPOJi0q293YaZzwjmvCoXxq8cnCBJERjShZsYI?=
 =?us-ascii?Q?1b7Bbk4n6VY11kx9Xzs97K7+/t+orhdaDcOeLtMnXBfFI/bnpQfhqer0WcBz?=
 =?us-ascii?Q?XqAg2D5GzCvAc/AhGCT7I59eKHc0aLiNtT/vEGwz4yaSAceP8A/URUqSRafq?=
 =?us-ascii?Q?xSBuMGMLGJ+HM6CHXzunxtL3sVpgcZIohJj6UxQVPUMxdcHtOjCMeAI29nX1?=
 =?us-ascii?Q?5SZQ25LAkMAfUi/75q9vl1/NisSHuVA83w33P6hAvX2zG3awHY03JPhm2ZsS?=
 =?us-ascii?Q?ME1XgAAzI0DgaMAwe6jI9w6CZsC4tO2ihvJ1sTBiCpnRdnEDaYw0iQU3GmXL?=
 =?us-ascii?Q?a0GFgVXAnWjYTBvzDaQa1ES780XgKIG0vI83f/B3PHnkQJwh7BrOUhEf845B?=
 =?us-ascii?Q?IqVk7EPgLbGjeMoAQkkJTUbyUOioYd7JRooEMcYHPVC8a2An1CzFsZLy4GXu?=
 =?us-ascii?Q?PIImM+iMS0MEwypPazEctcyeDft4eb280cdKa2a087HQvj6eih4qzrJTYi09?=
 =?us-ascii?Q?g4oFHjkN88g0kyLhF7XdTfKv7G8HuWppfam75xl6V69FvHXWCrs+KXut7RHY?=
 =?us-ascii?Q?7NITEuTDywvTjDJtR0RE/MS1+LUws+RrmOESBHaW5IJYVwFikBz2uzuPJdWC?=
 =?us-ascii?Q?S+O4amAcS3EYVNxcOQI0SD40Q1+3SYPNlljzpY0JeWZ3FX8NPCVY+u71dULA?=
 =?us-ascii?Q?mpRaylQS4lGIE6QR0oHkOIWPlM+gUKh6M2NNU2NcvjgKDmDAUP1BrUAO2V+F?=
 =?us-ascii?Q?GfTyFSEu0lhdgAZT6RHiWOaGO5YbAn0751UOS5MrEUEW7aj0yatF7gF25RdO?=
 =?us-ascii?Q?fnhVKg6YC7laZrHTKrblg6mkPVfXmP4kxUu1aOvvPubZlsv+SMnw3uMg+f63?=
 =?us-ascii?Q?e28sqw+uF05b2icPyf36ETRsocdhFhiIFuMR9VYi2RoKGYj/WrpAS8XWMI/p?=
 =?us-ascii?Q?kdMPyHQdjvrIgo1+riT8Qh4h4RSbluU6Ou1OlgMrdZJiOHa3yW0GmC7Q7kuT?=
 =?us-ascii?Q?uoNayBRdupNqUeak3nTyqNpkeVn6T4M7YLa6/+ntua8nO2vOI2xOoiBTYLVD?=
 =?us-ascii?Q?KcNeRV5ABl6JM0JsUqfOJ4eZ67Z0xyNfJu/jLPGddgt7G3L7PXqHSSo1bWQJ?=
 =?us-ascii?Q?OUxq/kFKUl2cEJs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6K3xevN/4EvdCfPsXf9KvcAiMclERmxHEqAwtUq/Mb6T31ORvmgQIWzgaI4f?=
 =?us-ascii?Q?pM2YI/p9hBqbwrbVeXJKe9jUgtoxDKt850ptfyyHGh4m9qS2iEDMlfckTfAV?=
 =?us-ascii?Q?Uf1ptJvvhzzKGLvycShHW42Xf1XqYNMZlkp3SjwG6cv7WM5qIQ2/lDELxcLy?=
 =?us-ascii?Q?U6I5j8+HhWjf9L5oV6k7dTuLT3p5iDRycD3wwDaiWUFutMPmKT/wptqTM49L?=
 =?us-ascii?Q?H1OTSN5xMElDD+l3R7cY2+hKxUNXy+sPn60xNBdyPMXyaPZRExVVzfhL433H?=
 =?us-ascii?Q?vfiVrq7xJgGRXSMqg4AWzvy4hXgO6gMoTWsIkdjQx41NHSp+OXkxflU21geQ?=
 =?us-ascii?Q?JFIlvMMfebBAAtnwziNzdqv7pKLRrLKfSaD3977wX1oQvbkE1onJkt5l95vw?=
 =?us-ascii?Q?9kTMS6Nn20k7V0U+HoiSnLogQiH7Jxj9BwWDbvNbMRg/V4gpjIwW9h/MC1E2?=
 =?us-ascii?Q?Snf/rmj6F0oQTpyHJvPw+WCMZA5/Avl94a99otuZoLn7X8bVl2GQJLmb/+He?=
 =?us-ascii?Q?fYUQdxKljWwFuyMrZ/IAITBcp363PUZcIyubPZOqu+RIR8p3Q6ZB+KnkOXoH?=
 =?us-ascii?Q?IhV/jkcpWYuyrzg8YHTr4nh9HJLQKM2KZ6B28jABzZ0RoXNhvYLx2Ns+ojUT?=
 =?us-ascii?Q?QXUULuugiEeUYxuR182eCuCH+mGhi079zoF9slup+70GGQl+iQElo5ijjhFR?=
 =?us-ascii?Q?vePYIcqcucDcHrg8OZ3gefbT6vAqDNBpfryVQbtwdj4Y0erQ0x2G1YOaOkVP?=
 =?us-ascii?Q?1DaxZWqmWAyQ1eRUqKfK55TsZ2Qh0WfrzJaF1DGBb5qOXHi3oxW8Jai3FIjd?=
 =?us-ascii?Q?pwLj1t6OQghnRjfEoFgXdjyT/y5QIlX7seZYLewV/nKoqztUNZlBVAo09cxQ?=
 =?us-ascii?Q?i1c6zdmjLL+WGb7hrJt08fC8EEqrIRmKF4kAnfdVm432M7xglmwqNBKiNwBs?=
 =?us-ascii?Q?HI97eg+WSaF+Nu4Yc1bPpJN3kCsvfFsGGaNf1G+IDWqLyl92EQCl+TEgVGN+?=
 =?us-ascii?Q?up+C7yaboaXb1Zl4qcn8qHNUQohxpO7oTKFxqmF9nT/FUdeyYKxyqrVvfXHp?=
 =?us-ascii?Q?nuNj3qLhkBu4BoXuLCJ/9ISIjhWw3SKI9ddcWOTMKQBe7Nuj3Ipj3T7JoGK8?=
 =?us-ascii?Q?nehbaecwVwwJdpLPWe+TEQtf1QeNxOrm1Ewj8z4lZI3qDokeTAqFpFxBdx7o?=
 =?us-ascii?Q?3GYVDfjUScxWoEIEyEfB02sai115OUqoFlHOS+6AxCnt4+Y0t5gUE8HXN+ej?=
 =?us-ascii?Q?NTh7bVF7slugQl60/6kr99lwjq0l2KRbbjY2F5P2btU/cWaUE4vzp87XjDVM?=
 =?us-ascii?Q?tokPrbx7az9WXs5aVwX55X9gEhrW56tVuf/YTBG/tQFIhiDlDKW8ZljP9qbv?=
 =?us-ascii?Q?11OP4kr8DV7wAGCpXOgMAJin74waIyy+4xQYgyJD8z5eCy1j1g/w0G0LDxnG?=
 =?us-ascii?Q?DhS9Yfd6ReRAvFK/v/kLpr00dvTEA4DgZLnN8oM3rFGk+zI6vS+mNq4HsxUC?=
 =?us-ascii?Q?jSaFrSNC7o7b1pfMN7ut56gq6nCrDhJQU+dTMx7zRkMJkfnJdsSNGsuKd9+D?=
 =?us-ascii?Q?WxTN/BgFzEJ6WU8higHPfmbMcprCOK/bfyiw4ig1?=
Content-Type: multipart/mixed;
	boundary="_004_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onegas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf04de56-a12d-418a-38e3-08ddbf0ce2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 17:20:22.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1cac1176-089b-4bcd-aa37-24195cff538e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIq1PkqQ5oK3DkelSIfLGLnAxNYKIOcQZN514EAVeU2RpLBqAqskiYQAqnCpHYqvyvZGcbDfzOsUkpsd/o4hlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140

--_004_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_
Content-Type: multipart/alternative;
	boundary="_000_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_"

--_000_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bug report attached.

--_000_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Bug report attached=
.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_--

--_004_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_
Content-Type: text/plain; name="git-bugreport-2025-07-09-1206.txt"
Content-Description: git-bugreport-2025-07-09-1206.txt
Content-Disposition: attachment; filename="git-bugreport-2025-07-09-1206.txt";
	size=1723; creation-date="Wed, 09 Jul 2025 17:06:34 GMT";
	modification-date="Wed, 09 Jul 2025 17:20:21 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCnN0YXJ0ZWQgaGFwcGVuaW5nIGFmdGVyIGFuIHVwZGF0ZSB0byBh
IG5ld2VyIHZlcnNpb24gb2YgZ2l0Li4uIGhhcyBiZWVuIGhhcHBlbmluZyBmb3IgYSB3aGlsZSwg
c28gaSBhbSBub3Qgc3VyZSB3aGF0IHZlcnNpb24gaXQgc3RhcnRlZCB3aXRoCgpXaGF0IGRpZCB5
b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQp3aGVuIHVzaW5nIGdpdCBi
YXNoIGluIHdpbmRvd3MgZW52aXJvbm1lbnQsIHdoZW4gYSBwcmV2aW91c2x5IHR5cGVkIGNvbW1h
bmQgaXMgZXhlY3V0aW5nIGFuZCBpIHN0YXJ0IHR5cGluZywgaSBleHBlY3QgdGhhdCB3aGF0IGkg
dHlwZSB3aWxsIGV2ZW50dWFsbHkgc2hvdyB1cCBvbiB0aGUgY29tbWFuZCBsaW5lLCBpbiB0aGUg
b3JkZXIgaSB0eXBlZCBpdCwgb25jZSB0aGUgZXhlY3V0aW5nIGNvbW1hbmQgY29tcGxldGVzLgoK
V2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQpsZXR0ZXJzIHRoYXQgaSBo
YXZlIHR5cGVkIHNob3cgdXAgaW4gYSBkaWZmZXJlbnQgb3JkZXIgdGhhbiBpIHR5cGVkIHRoZW0u
ICBiYXNpY2FsbHksIGkgdGhpbmsgdGhlcmUgaXMgc29tZSBhc3luYyBwcm9jZXNzaW5nIGdvaW5n
IG9uLCBhbmQga2V5Ym9hcmQgaW5wdXQgaXMgYmVpbmcgaGFuZGxlZCBpbiBzdWNoIGEgd2F5IHRo
YXQgdGhlIGtleXN0cm9rZXMgYXJlIG91dHB1dCB0byB0aGUgY29uc29sZSBpbiBhbiBvcmRlciB0
aGF0IGlzIHJhbmRvbSBiYXNlZCBvbiByYWNlIGNvbmRpdGlvbnMgaW4gdGhlIGFzeW5jIGNvZGUu
CgpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0
dWFsbHkgaGFwcGVuZWQ/CmtleXMgb3V0cHV0IGluIGEgZGlmZmVyZW50IG9yZGVyIHRoYW4gaSB0
eXBlZCB0aGVtIGluLgoKQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6CgpQbGVhc2UgcmV2
aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkg
bGluZXMgeW91IGRvbid0IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lv
bjoKZ2l0IHZlcnNpb24gMi40OS4wLndpbmRvd3MuMQpjcHU6IHg4Nl82NApidWlsdCBmcm9tIGNv
bW1pdDogY2NhMWYzODcwMjczMGIzNWY1MmMyOWVmZDYyODY0Yjg1ZTg1ZGRjYwpzaXplb2YtbG9u
ZzogNApzaXplb2Ytc2l6ZV90OiA4CnNoZWxsLXBhdGg6IEQ6L2dpdC1zZGstNjQtYnVpbGQtaW5z
dGFsbGVycy91c3IvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCmxpYmN1cmw6IDgu
MTIuMQpPcGVuU1NMOiBPcGVuU1NMIDMuMi40IDExIEZlYiAyMDI1CnpsaWI6IDEuMy4xCnVuYW1l
OiBXaW5kb3dzIDEwLjAgMjI2MzEgCmNvbXBpbGVyIGluZm86IGdudWM6IDE0LjIKbGliYyBpbmZv
OiBubyBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJh
Y3RpdmUgc2hlbGwpOiBDOlxQcm9ncmFtIEZpbGVzXEdpdFx1c3JcYmluXGJhc2guZXhlCgoKW0Vu
YWJsZWQgSG9va3NdCg==

--_004_PH7PR11MB65466DEE20BA470C600C7B9B9549APH7PR11MB6546namp_--
