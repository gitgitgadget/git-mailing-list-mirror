Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2084.outbound.protection.outlook.com [40.107.113.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793332C6D
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ntt.com header.i=@ntt.com header.b="Va9UfV8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgIpKeE2EUMNwxHKyO5C5Xcqiy8X53iqu5sclRqP12ZjGdyi3xAgfjdFOHFgT8GSkDMoQo3tcJ+1taGrokGczgTdGgvV6FgcwMRCJn/tO1Fz/ikrYQMNJBm6419UQ/gWyFmy4W6ge3zTHuzC1Ieo4SHdgOJdANWN7HEEHH/TSa+MW8sNrhZXvE0SFDymC7oZES3rU36L+la0IHLazGqN1LTgOa6V4/vZOs9/D74MxwYkEPb4HtUcASn29T0I7iCSGpmVlWyMtlon9uAL5V3lAOvHpnHLmq6P3cTmAjE6eDXpyIyb2n6H/STnbcUeO6hwmzD2/i5ee181ra4k9ccRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMpTFtYG7MgVuG+4Cl/9nbzvey+NkGYVgQ0deD3DRY4=;
 b=fm3JRJ+Hv66I+XaHis5mroLwlVydCp0YVapPADdZTqOXw81LuH6wGqbDzhoEoYslxarIIexXRjpH8QEBM0ZVvu1x2FjjPurPkbZZPCLEh3ASNMc3ksmNVQ3VsX75+F/gHAiQ2cawBGZOAEPO4RE+/pqV4faw0kntLp4x7B0vmtHOBN9fH8ClJG0PcLdxDXCTxNOLZML5ltVEPl4FD/ojoAQm+hOu4ZXeO80PkOcrmixoGO5LwLlG8wgqOgWcQk409r6FwiHSFSvuCSu+rOtQxctEnX0QA801AkBqLy0b7dAikN1FUHOsTL94o/ZY+EZ8jtp91p/PBjEMhCMNrHzcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntt.com; dmarc=pass action=none header.from=ntt.com; dkim=pass
 header.d=ntt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMpTFtYG7MgVuG+4Cl/9nbzvey+NkGYVgQ0deD3DRY4=;
 b=Va9UfV8H3V1rTZ2Kk6nv6ko94d8uviqhkNkAovuX3g0Q6Wu5zBFISZrvMcZcO38LLkYsJSxDrfTeI9Syr/WLgR8LNvxUZ5s2IP/XbRsgi36uK2R8kWTLwO9VL08CSbmtlX44jwBmV2Q73vE3WTYuM8Omyq1AY05IZGMgDWmfXVs=
Received: from TYYPR01MB6713.jpnprd01.prod.outlook.com (2603:1096:400:ca::5)
 by TYVPR01MB11116.jpnprd01.prod.outlook.com (2603:1096:400:368::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 06:47:23 +0000
Received: from TYYPR01MB6713.jpnprd01.prod.outlook.com
 ([fe80::7d7:3793:f517:c84b]) by TYYPR01MB6713.jpnprd01.prod.outlook.com
 ([fe80::7d7:3793:f517:c84b%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 06:47:23 +0000
From: Reika Arakawa <reika.arakawa@ntt.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "vuls@jpcert.or.jp" <vuls@jpcert.or.jp>
Subject: Request fixing a vulnerability for git project 
Thread-Topic: Request fixing a vulnerability for git project 
Thread-Index: AdpDkF+FDhqOn25hQWWAp4TkjEzr6Q==
Date: Wed, 10 Jan 2024 06:47:22 +0000
Message-ID:
 <TYYPR01MB671359306E4A73100356714EEF692@TYYPR01MB6713.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6713:EE_|TYVPR01MB11116:EE_
x-ms-office365-filtering-correlation-id: 15c38d85-a0d9-48ae-d032-08dc11a7ffe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mGw0vL9XJ7FHe+xPNxj9xTmW0ZlylMtmtHYWX+OCiIhKny7SJrzKDa3pbEA9Ooe2DXz7gVUfCB1Y9Em4eG3t21FJZfrhSZTym1YCiyE0LOWIltKtYXr4YcxgyjhcXRQ2R8Fu4GnJ/E/F6zXnIJHgYAwNxYHH1Es3omImu/XO53dohIocpwgi5YuxbdFbVva9qq4d0J7pRAkigV6pHMvMxtyc19y1pfIXsSsWabXz75+bI4qYSjzdPpAGBd130IxEuTQfLGxPORz3iCk8M4YiBoxKOvCstIqsxh0Pv5tUt8Ne755dHfRli25IT4ET5jsSGfu+NWZg+6reXRMmN1+ra/pFe5odq/umkGwyqgs29sOjYHtwo3l+7K865hOTSi0EClY62s4GZOdQRyjFtHucHVKC/PkVAW54ul57uS8PBz2qQ51KDDm/s10ryvvo8B3hDKJjXCKBzqFrLy8zTwrgWmu+s/i20O7PeXRDPpcxZj24ID7aOsfxStKNt7BtsJRPUw6Pr6RHNKN5xe4iC9BRa3m1UOqU7gG+7YLxZQj4dKUyTVU+BBURRcA5cOHHk0tLcelGIbP+V7Xgv/cn0thmXTomeQKtsI/sZ3tkCUV6q1Be7fyxxUhax/MLN/69L+nha1GcixsvJxO8l7ShfMbO5w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6713.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6506007)(9686003)(5660300002)(4743002)(26005)(122000001)(38100700002)(4326008)(52536014)(8936002)(8676002)(2906002)(7696005)(966005)(64756008)(478600001)(71200400001)(6916009)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(41300700001)(166002)(38070700009)(99936003)(82960400001)(86362001)(33656002)(85182001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RVE5VXo4RXJhOVFPQXVwalZmcDlIaStrSmdaaG16d01SQVFuUXhzVGJG?=
 =?iso-2022-jp?B?cWQwbS9EbXdMZ0FuSktRcFZycUlWT3R6WkhkRWR3M3hES2lGenM1Y1pU?=
 =?iso-2022-jp?B?VjNNUEdrdzZOQUtoOE84b3pxeUdwZWxLTzRSSHpudndleC9jdWs3Y3A2?=
 =?iso-2022-jp?B?akZtQkEvdjQxK2FXc3lXVDg3eTF1enhaSUlOVjhWUnBnZmc2R2hEc0M2?=
 =?iso-2022-jp?B?TG1UVml4aGRybFQwSnQrQk93MTdPaXJkRXFZWGZiaFpUSjhZWDE3Y1o1?=
 =?iso-2022-jp?B?Slg2VHlvVlBabTRob1c3a3Z0amlMVDZ0U09vZzN1WTE2WmYvckdycTdJ?=
 =?iso-2022-jp?B?ZXgreGlzNzBycDR6UmtGNFNXbGNhK25sTWd0UU1HSEJuYzlWSnB6aFlC?=
 =?iso-2022-jp?B?L05STEx2RGlHMFlxaXM5anlyVnVES3VxVFJoYWxzYmpUUTRESzBERlNW?=
 =?iso-2022-jp?B?Z1gxeG1HOFBZS2RmY1FPRWQzQ0hrVURsek52MWRiVmV5dzRnU1F2NmI4?=
 =?iso-2022-jp?B?eDlHMkwwcFRmQ2d6b0dia2h1Z1dVd2hVOHU3amFGNjVHbWkvaUhzbGFS?=
 =?iso-2022-jp?B?ZThOc21MQ0Z3WnhnM2Q3S3o1eWU4V2xGZE1TWVdaV3N6elZta2hJcnQ5?=
 =?iso-2022-jp?B?cWdrZEpPVVhmZ0t4RVQ3dG0yd0VsT1NpczlkWEpMTEUzNUpNY0x3ZGFi?=
 =?iso-2022-jp?B?ZkRhRklPWFdkU0Y2ZThveHp3bk80M3Q4aTZ5dkNJWUVPcDd3akxVcVA3?=
 =?iso-2022-jp?B?ZVhlaFpTVnpVNE9XSlFTdDRiMHFoNnVMbHVpQmpwdVJnU0g4aC8rTHlE?=
 =?iso-2022-jp?B?Uk16RVVvcHF0OGxyRzJEQnZ6T3NEVEVwUEl2enVCQWR1U2I2Vmt6cEtY?=
 =?iso-2022-jp?B?OSs4MWVYTHhpd3NjYnQ3Yms2eWlFRHVPTG04MDE4TVpwRlF3cVNkVHAv?=
 =?iso-2022-jp?B?MjlHcUwzNFVpWmcxaXJHUzJZOEo5eitiSGI1ZTNuaTA3K01Rb3M3MWlz?=
 =?iso-2022-jp?B?bE9IdEZITGJtWFRLL2dVeVV2QXdMRUlSdVBNYkhxVWk3d1VERXFSYUlw?=
 =?iso-2022-jp?B?QlRXQ0ZlVVk2N3hUaForTnpNM1ZlQzZKNWhjclVNZkdSWUNGZFBiV05a?=
 =?iso-2022-jp?B?bE85Y1dzVjRuK1U4T283QUFnVzhYMVhGSzB6Ti8rcDNRWkZNV0lDS1ow?=
 =?iso-2022-jp?B?endHS2Jzdlh5MGtEc204SU5kNE1YbXFNUlRBcnFGMUVGLzUwNFhNdGhO?=
 =?iso-2022-jp?B?SExaZzdTUE8ySWNQbjRMSUtINVMwdGpUTmU4M3ZSRjFLUkt1UWVxVWs3?=
 =?iso-2022-jp?B?QnhSYXpWOXUzV0pjOWVQbnR6eEpRdWJJbVNLeXh4RUtqUTNrSlZTV0o5?=
 =?iso-2022-jp?B?QUJPc0hndGFiRUl0NThCN2R0NXdock13bUlUTGpCcEw1cXBSUTlIMzBG?=
 =?iso-2022-jp?B?M2llZ3V5cWtqbXZpYWlsWnpxYkpTbnc0bjRZY1hqM1hEbndJYmlJS3dT?=
 =?iso-2022-jp?B?T0htWXhDYld6NEV0QVpyZmwxTHAyTnJLcVhFT2VtMUtJOHB2akozU0t6?=
 =?iso-2022-jp?B?dk9nMGFPdTFYcVAwZk1Md0J0VDExRDUxaEVEQUdRVk9qZUg1Z0dNQXNM?=
 =?iso-2022-jp?B?M2xMa284a25zYlpiS3VMMW1FcmlBNldzNTFGZE5TTTd1U2ozMW45RGlL?=
 =?iso-2022-jp?B?aWFPcXpDMGVsSHVTRFNnWXgvMGVDdzRPQjBPMEw0OVc0anpWb3RCam03?=
 =?iso-2022-jp?B?VzE0UUkyUHE4NUh6Y2dVQkVnN2tkVWFTSGtxSXV3MVU0NDAvU1E0Q25H?=
 =?iso-2022-jp?B?VU93VGxlZ3FnY3JwZm1aOGk2ZjdBbE0xaktPYVphRjRLbUVsYUJudURF?=
 =?iso-2022-jp?B?akdHeGFSWXlPVERXSjYyY0hOTjZUNXJCd3A2ZUwzSGVZZUQycHNZcmJy?=
 =?iso-2022-jp?B?b2pXRTM4N2xKdndVdmRRdTdkY1MxdGlTTTYzRFFQdm43bURwWVlDZmZv?=
 =?iso-2022-jp?B?VE5NOEFTWklIVzA3azVUdnlNQVlsZ0pyMHZBUzZZZXdQY1FYSGxTdGJn?=
 =?iso-2022-jp?B?ckF0Q3lYdEJWNWVTMVJhYnFXOGhhdTZpMytJUVZEOUU5ejRYSEVKQ1k5?=
 =?iso-2022-jp?B?ckpqdzZhcXpRTE9tc2U4NGMwcGdIYm14RzRYTjV2QjNHMGtZZHl4VUtU?=
 =?iso-2022-jp?B?N1Y0M0FxWVMzK3B1TzJ3Vi9MSzVHVVB5aUlXWlZqbFZqQ1htTWpLUUtR?=
 =?iso-2022-jp?B?a2dET3ljQ3B4UE5hREJJZXgzM2xZOGxZZz0=?=
Content-Type: multipart/mixed;
	boundary="_004_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ntt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6713.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c38d85-a0d9-48ae-d032-08dc11a7ffe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 06:47:22.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a629ef32-67ba-47a6-8eb3-ec43935644fc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOrQlfE7isG4U6VUYruksKDNJU7q+m2RzqCsAfDoFTp0J+03Zo6jRbzMw5GGdDqAQ+kDr9rpBsunoEJwaq/Apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11116

--_004_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_"

--_000_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

To Whom it May Concern: git Product Development Manager,

We are a cybersecurity research team affiliated with NTT in Japan, and are =
engaged in research related to vulnerability detection, analysis, and modif=
ication.

We investigated git (https://github.com/git/git) released as OSS. A known v=
ulnerability and known code were found, so please fix them with a patch. We=
 hope to prevent cyber-attacks from occurring by working together with Japa=
n's representative, JPCERT/CC (vuls@jpcert.or.jp<mailto:vuls@jpcert.or.jp>)=
.

How to discover vulnerabilities:
We inspected all function codes for OSS software code using patch informati=
on and code information (2000-2023) for known vulnerabilities. We would lik=
e to inform you of the code information for which there is a high possibili=
ty that a public patch has not been applied with high severity. Vulnerabili=
ty code information and countermeasures are listed in the attached file =1B=
$B!F=1B(Bgit@@git_vulnerability_details.txt=1B$B!G=1B(B.
Please note that in the real world, a vulnerable state may not necessarily =
be true, as it may become a vulnerable state under certain combinations of =
conditions in the real world.


Additional confirmation details:
We are planning to submit a paper on this content between January and March=
, and we would like to include the source code characteristics in the paper=
 without revealing the OSS name or file name. Are there any concerns about =
this?


--
Best regards, NTT Social Informatics Laboratories=1B$B!J=1B(B https://www.r=
d.ntt/e/sil/=1B$B!K=1B(B
E-mail: reika.arakawa@ntt.com<mailto:reika.arakawa@ntt.com>


--_000_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.17
	{mso-style-type:personal-compose;
	font-family:=1B$B^b%4%7%C%/=1B(B;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">To W=
hom it May Concern: git Product Development Manager,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">We a=
re a cybersecurity research team affiliated with NTT in Japan, and are enga=
ged in research related to vulnerability detection, analysis, and modificat=
ion.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">We i=
nvestigated git (<a href=3D"https://github.com/git/git">https://github.com/=
git/git</a>) released as OSS. A known vulnerability and known code were fou=
nd, so please fix them with a patch. We
 hope to prevent cyber-attacks from occurring by working together with Japa=
n's representative, JPCERT/CC (<a href=3D"mailto:vuls@jpcert.or.jp">vuls@jp=
cert.or.jp</a>).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt">H=
ow to discover vulnerabilities:</span></b><span lang=3D"EN-US" style=3D"fon=
t-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">We i=
nspected all function codes for OSS software code using patch information a=
nd code information (2000-2023) for known vulnerabilities. We would like to=
 inform you of the code information for
 which there is a high possibility that a public patch has not been applied=
 with high severity. Vulnerability code information and countermeasures are=
 listed in the attached file =1B$B!F=1B(Bgit@@git_vulnerability_details.txt=
=1B$B!G=1B(B.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Plea=
se note that in the real world, a vulnerable state may not necessarily be t=
rue, as it may become a vulnerable state under certain combinations of cond=
itions in the real world.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt">A=
dditional confirmation details:</span></b><span lang=3D"EN-US" style=3D"fon=
t-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">We a=
re planning to submit a paper on this content between January and March, an=
d we would like to include the source code characteristics in the paper wit=
hout revealing the OSS name or file name.
 Are there any concerns about this?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">--<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Best=
 regards, NTT Social Informatics Laboratories</span><span style=3D"font-siz=
e:11.0pt">=1B$B!J=1B(B
<span lang=3D"EN-US"><a href=3D"https://www.rd.ntt/e/sil/">https://www.rd.n=
tt/e/sil/</a></span>=1B$B!K=1B(B<span lang=3D"EN-US"><o:p></o:p></span></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">E-ma=
il: <a href=3D"mailto:reika.arakawa@ntt.com">
reika.arakawa@ntt.com</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_--

--_004_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_
Content-Type: text/plain; name="git@@git_vulnerability_details.txt"
Content-Description: git@@git_vulnerability_details.txt
Content-Disposition: attachment;
	filename="git@@git_vulnerability_details.txt"; size=370;
	creation-date="Thu, 07 Dec 2023 04:47:23 GMT";
	modification-date="Wed, 10 Jan 2024 06:47:22 GMT"
Content-Transfer-Encoding: base64

U29mdHdhcmUgbmFtZe+8mmdpdEBAZ2l0DQpWZXJzaW9uIHRhZ++8mnYyLjQzLjANCg0KSG93IHRv
IGZpeDogU2VhcmNoIGJ5IENWRSBudW1iZXIsIHJlZmVyIHRvIHRoZSBjb21taXQgbGlzdGVkIGlu
IHJlZmVyZW5jZSBvbiB0aGUgTlZEL0NWRSBzaXRlLCBhbmQgZml4IGl0Lg0KDQoNCk5WRDpodHRw
czovL252ZC5uaXN0Lmdvdi92dWxuL2RldGFpbC9DVkUtMjAwOS01MTU1DQoNCg0KDQrikaAgZ2l0
QEBnaXQvY29tcGF0L3JlZ2V4L3JlZ2NvbXAuYyBbcGFyc2VfcmVnX2V4cF0gDQoJ44O7Q1ZFLTIw
MDktNTE1Ne+8jENXRS0xOV81LjBfMA0KCeODu2dpdC5zYXZhbm5haC5nbnUub3JnIyNnbnVsaWJf
cmVnY29tcC5jLCBbcGFyc2VfcmVnX2V4cF0NCg==

--_004_TYYPR01MB671359306E4A73100356714EEF692TYYPR01MB6713jpnp_--
