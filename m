Received: from BN8PR09CU001.outbound.protection.outlook.com (mail-eastus2azon11012056.outbound.protection.outlook.com [52.101.58.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12290CA6F
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.58.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685086; cv=fail; b=RbQbI0vhsdDAK0I014oeMmI3UagitDa/+MWRbvzLDoXR+xOv3w8zLOBxwOaAUszQZi7NwhemhFSV0kr33PEtZMec+9+LiaKgGGdDnyLs7KkWnMOtkHHznBLfMXFTy5ng7xPVRH2//LF/1f4nqJnIkvthDcl1xvv+u8Vh+5cvtf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685086; c=relaxed/simple;
	bh=LL1lGG6QVrfm4PrlmoJJAzBAo2QmerEuPEAZKBIFF6Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AwCPSx78gy+dBoSEEI4sOmkpQhXtS+gBbK4+i/UmUD6rzKd+WxdsIDMEdK+boG4KViwW0upAXvbkfHMO75GE6+C+anRDSbwquUPp6TSnxXpfyTd83nu+P0DrndnJwtuJU0KnnC89U4TG23yo0QrSN5BPwZgENeTlJT0SBvj9wWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcfl.gov; spf=pass smtp.mailfrom=hcfl.gov; dkim=pass (2048-bit key) header.d=hcfl.gov header.i=@hcfl.gov header.b=tc0QRtyV; arc=fail smtp.client-ip=52.101.58.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcfl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hcfl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hcfl.gov header.i=@hcfl.gov header.b="tc0QRtyV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5Ik5dWTPoOpYVUa08XJOY8Kv7OZUi9hEnYr9QP9P2hUW2gRU0A0yTE9Ejiz5SJ/w6EK1WjechpJD8xzBfuNDtTC/BUypmTeSX+BMBsREyzuXW1sYBiZA6BGPRtbnjPJigDX1U2yOmuXwYfhrJEFaCDp2+skLoC1m1a2Tf6XcQ8ByNLgs9KGSLndKhlLT9YvZ4FHz2aGnqpWu0T7sUF4Y9NowXNWAA6aMecaw7hNQdykLdLUZ1F9cZjLO7eBXy9u3grOIaT/SI4hH1Iw8OAJoyHEBx/HTUYA/Hhc6zQKr1PJ4/VFSHsAuofYBJEsv9/kIAPT/ZzedUixDIbkcM1hLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQIWBdOxq/uUKrMf1VrCt98RX3xnGi5lNplOJ+7Yvwo=;
 b=jkuabPE3minqG5f6F3c06xDkBg/z5LCJ3GUmIFoq9+3kb+K0BUh3ClC514TIbxe7J9v12TpUsMhTNitUlviU+qRJcAUvx+HqfvMJcVlSXPQECWJpImJ83JqIgXcX4kVorpM7JF+cgK/7V2ygw2HqPbdc508AuvxvL9F1Gl5BkeyLsBOvQqsA2JzQzGIHq5uVdQGbJ5pTJymeEk6KlcrFBkgR6ccxoTE7/xWtaMFRrG8lNB39pdcRjaWKHgzmh7UUZYdqw54Gh4B9RUPJ1HIIbl7wNJgHQyrxkncSAx6vmslc9lMdio2Ios/yN91v2ZNpopKRcHkprWMuwNb6oYiliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcfl.gov; dmarc=pass action=none header.from=hcfl.gov;
 dkim=pass header.d=hcfl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcfl.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQIWBdOxq/uUKrMf1VrCt98RX3xnGi5lNplOJ+7Yvwo=;
 b=tc0QRtyVLdKHQ+hQdFlD6uupGNxi92Dz9AH1cOAScs8lbGs1/ILBaGwhuwPHgwaR3uXdotPRrCpgXBtCmlfgY623aZoEpDHJDJ0OlbRkUm6Kcf6k8LQwYi7izxTHMpel7XKgFOU3JAMWfdq9b2Wi6jP9tufsORRDIqmDJHJnb8bYNhlF58WsFHQQzARz832NfdjOudEN35n7hX/wyMLXix8XW2bfl0Ki9dB3IcUT4A9JaqtffmT0yTs/e8ZavZZDqsIgjUuHB3KRUtfVumL9xk/M7/ejd0g37YE6mm43paYV4S2DLSgxjob4P+YVKev44P19jWx+Qe7/V9p1vAotsQ==
Received: from DM8PR09MB6549.namprd09.prod.outlook.com (2603:10b6:5:2eb::8) by
 DM8PR09MB6840.namprd09.prod.outlook.com (2603:10b6:5:2e5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.33; Wed, 16 Jul 2025 16:57:59 +0000
Received: from DM8PR09MB6549.namprd09.prod.outlook.com
 ([fe80::8665:5590:8753:ea17]) by DM8PR09MB6549.namprd09.prod.outlook.com
 ([fe80::8665:5590:8753:ea17%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 16:57:59 +0000
From: "Harrison, Latasha" <HarrisonL@hcfl.gov>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject:
 =?Windows-1252?Q?Security_Questionnaires_for_Software_Installation_=96_Hi?=
 =?Windows-1252?Q?llsborough_County_Public_Libraries?=
Thread-Topic:
 =?Windows-1252?Q?Security_Questionnaires_for_Software_Installation_=96_Hi?=
 =?Windows-1252?Q?llsborough_County_Public_Libraries?=
Thread-Index: AQHb9nJoC3g0En9vdkmBshOAT3diyA==
Date: Wed, 16 Jul 2025 16:57:59 +0000
Message-ID:
 <DM8PR09MB65497709DE3054423B2FFDFFD556A@DM8PR09MB6549.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcfl.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR09MB6549:EE_|DM8PR09MB6840:EE_
x-ms-office365-filtering-correlation-id: b8d0f97a-5d3f-4ce2-2c4e-08ddc489eb8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?umW4wCqFhr8AGpMYIQkBVFde2CBE6z9OHP2cpdEKGr//DjpZwYXVeXyY?=
 =?Windows-1252?Q?tUM5Ccla7bq1BY6f10ipTpXIy4rEd+YfAJIcLaEKJQgZNlq5DUPxcjwu?=
 =?Windows-1252?Q?vSoK6ig7/aNClEJpnEpn01Ah1z+xj+cZHUGEzIeNFTKMY0WR7IhoIpqw?=
 =?Windows-1252?Q?MdxbPjNKUI734JZiYMmXniaiX+VymMYlkBg1hmVbMRIZQfu7KKwp2Web?=
 =?Windows-1252?Q?n/6wTNmvp8iMqWNdJSmlVQOpvFrB03WgTElevBg5oWE9WeUmtQnz4W+V?=
 =?Windows-1252?Q?63cYnCetC7xGoLASvzrsKkheOLisoyiyvyfgcArx7zZIA901cd2gl2uw?=
 =?Windows-1252?Q?kCWROJHD5471TmtJ9VQcDUaf5Vd7TCHcQHZCjD2Sz7J8SrRcfy3vyHrB?=
 =?Windows-1252?Q?/V56RW380XRfItpoAUk4snZc55PunTQ6rMY/JcS0nuSK8HmSAfBigGVN?=
 =?Windows-1252?Q?4kLt4ePs6I5OhEkIx+U8kY3mBCDHbo+ReljFr3tsG7U/mwe2U47PDMkD?=
 =?Windows-1252?Q?6tuLbFwKTaNj1prkOO5fkJTsata5znA252hg+2PVGIsh+ziMG2NQxUmX?=
 =?Windows-1252?Q?YuwaH7KRLeZCubxU6sYtZuC18qg2iG2K1pkQ9gMu1VTYJRSUedBKRgkk?=
 =?Windows-1252?Q?qjPIjCFD2KZ6ZLik0YT6guDB52JwudxusWDfpCpPuBQfhh83NmKpYSol?=
 =?Windows-1252?Q?5lIixTU1ffzKD51UJNWm0MD9U46LVSqsRbOmLISWP3c5262XOQfulXyb?=
 =?Windows-1252?Q?82SE/x2PCZCcbYKLXlYBiOXGTFsketyu47rkLtSq5lXqkg+Lh61jeKvX?=
 =?Windows-1252?Q?oyGlRvyY2Pqouxcwk1RNKc7E6kHG64IExAUI2b0MTzVLtJWj1rYxodPw?=
 =?Windows-1252?Q?Ed/qCmYt96Spb6VOq3fyhpakJvDv9fEZnZyyUhjZCIW6AvcYoi8JeEeR?=
 =?Windows-1252?Q?JlsNJoLzYo2JlytaMlfMvdtjfNi0C3+q751fLo2rhfvReok2SP/I/UR+?=
 =?Windows-1252?Q?avfJenmdT3yADuKNY7eJ3PCl7efpz6IiUQxMkZjKKaUH1uBdUjuEkDg3?=
 =?Windows-1252?Q?9o1X53P/hTE/A58inUrCsQuUDCcImdSxF1wbnmyHbcfgkDnYPMtq9Qoh?=
 =?Windows-1252?Q?yM8jxkTSOXmXWJRIVdrO+WY0EBm8ON0xZ1UdUcojP9r0MGy/ElekliBm?=
 =?Windows-1252?Q?RX+8PFafTtlDmIeTwsHOtlcvZQABOrVtTQXO6XYIQYmOjPZ8Vu2gLLaf?=
 =?Windows-1252?Q?GxPnG8mTr9Qgj5VzgLcZN0PX7xO3fWdf2I/LQQQma1lOlDpyoVrwlHS/?=
 =?Windows-1252?Q?+Jt4AgswdSw3tPUZpL84UEqf1UD9fpw6an30WuzDxRs5WSfFu01NXq+O?=
 =?Windows-1252?Q?cMQfcKLC1r3khZDbGpy22lv0VOULrClRnd6X8oRx+BOTYVZaiqzZCfWb?=
 =?Windows-1252?Q?RFQGwwpnBnWdEED1JK0956FvemTC69Yyd0qqW0xP7U3h7LWOX5WH3vy5?=
 =?Windows-1252?Q?WE/KZ188x1uKSH2W1mjpAMyW2+OMRu+CjSBORThuajca0JEiF0qtOz94?=
 =?Windows-1252?Q?OoW1i/vh4s18hSqqZaYiIJAxbxRzZU43UyuQ1Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR09MB6549.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?PAkKOQQVoI2cFvT5a0cFkahb3EMvw036+f9UNI5C3xDzLAZP6cKZ4h3e?=
 =?Windows-1252?Q?tpRBgg2FwSBKe94JucULnbvCy946ZP8feHBLOcyB7sP53TIPZ9czsAEX?=
 =?Windows-1252?Q?UbDXreofHAoWURgkuWm+DNbasVSCYZKaUhfWnruaKeqBHN9P4h/ZdW+W?=
 =?Windows-1252?Q?UsUkmLbHMwkZ4oMerflIEHaysXC2Iety136jq7BxpzIPxyCpCZrvbe5R?=
 =?Windows-1252?Q?POhC49LFeWB5eIpIwetB11EXOJQuDKqvudW7Cz8bSgqMtPRA5Ske8+1T?=
 =?Windows-1252?Q?W1hKRSCWn43IRnEpgdU1W6bznQ6vQ7zKuKpbt8v77DXZe/ryoOIUBWzQ?=
 =?Windows-1252?Q?OjLD+tamaepfHssfUDRkgFelVOCAqEdaXCmAOfe+Vh3sCrr1ySbF+oUy?=
 =?Windows-1252?Q?zYDb7uRgoIzNBayuqCYygRlrhaqCyhhC/8B7b12Riu12LSPmKvK19Eiq?=
 =?Windows-1252?Q?2xciRoBKWy0gGTbCVwGIE3uyRzmyhDH0yeXy6leZdEqs+1sPmG5MDEzy?=
 =?Windows-1252?Q?HnY+w2oiujJ8fF5INQqu2h2/TRgjBVXrx6OOaYs7qjRQaIux/Btbf8T3?=
 =?Windows-1252?Q?WjFu0fj0QDXCPgGSp3H9iDNxbkw9K5Pm5pXJD6cMcOwX6wfZ7EF5pTza?=
 =?Windows-1252?Q?e3ywLIXGvEO8fKVicJbCgV1Jr6Jc8w4oOhgL94IKyvxg4W3QX9ap9xI+?=
 =?Windows-1252?Q?UYpA+URsgS/akTSwBpk1q3w6BCbR2ayCKIJwEos36J4AnvgI3QsEaJwG?=
 =?Windows-1252?Q?NXnHhTaleM3/DEQq8dFe6Y3qixduVA9+n/5yexdGUbo/KRO3frmimP5u?=
 =?Windows-1252?Q?ayq7kGPB6XnMuaJ4unPW7OKorENeqJqV+uwQ6vXB53aTk1twf7Z4Tywk?=
 =?Windows-1252?Q?59QzdotdlOD01OUkPXxDFdp7Yo4BeF4CIaIGc9JEIl0nodIlmTeoV/vn?=
 =?Windows-1252?Q?7iwmCd4dUhfB+T9RqCr6XswHhKOTugeEtKtlHbiA+dlVtoWIgNtmhmcZ?=
 =?Windows-1252?Q?WzmT74gCB5pS3bWOT/BsoeecrhIeimsbIcNVwRAUZjI0rNhGb+83PD29?=
 =?Windows-1252?Q?W4VpDMPTu75cJBwGuPNGxK+Va+T7Ho5YNgXR3ND11m5Q/PhPmMtXzFcu?=
 =?Windows-1252?Q?dHtn+sPiSVO8uxxZB8tuMWSBNxIUGmOGN43m/XwdNO1n2AEGBSQ9Xif6?=
 =?Windows-1252?Q?GfyqWKcIcfvtX3RBEZCfcJkKp+GEnYzxdX4WB8V2x+jviTjTWEkF1Kec?=
 =?Windows-1252?Q?X13JFngIBg+sh/ikEV2d2MYM1DqJXDkFQsHkxHE6jc3SEJesA7u4W3Mb?=
 =?Windows-1252?Q?7nwTrg6E58wSAEEEYMPf5tuibkjai+blD0lrWMXiUTCVWWj/KZmwiDF/?=
 =?Windows-1252?Q?Q5AuHbVEhOsmcx4rZgbgm52iY6qs90BAU9AzOXg/xkNTho6WNF0XPRT+?=
 =?Windows-1252?Q?IQCeAwummB2W+V+dRN6y0OKRksjXuE8hSPh2NJRHaQ9SCS9A8pdyuCzT?=
 =?Windows-1252?Q?hoBJ2GehIG/OzrgmYRMbqOu2cyyJgAqgeIzbUsi8cBwaX18C9g2gML9x?=
 =?Windows-1252?Q?wjfIibi6mx4Lkbd0TrNjrz8iEXzp1Qwno7BExrVF7koi9fToP1SdqKYA?=
 =?Windows-1252?Q?/pz2e7Mq6ijWTDmm0U0snPs2LrRUoOjOfQSzDd+jbMYqZ2utY6s0yRj9?=
 =?Windows-1252?Q?wEtPQqb7kdlFFzOu1hGcBPg6ETgs5UU9tO4fZn7lMDZVYtMCXurfbQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hcfl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB6549.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d0f97a-5d3f-4ce2-2c4e-08ddc489eb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 16:57:59.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 81fe4c9d-9bb8-49bd-90ed-89b8063f4c8a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6840

Hello,=0A=
I hope this message finds you well. My name is Latasha Harrison, and I=92m =
a Project Manager with Hillsborough County Public Libraries.=0A=
We are planning to install your software on select staff computers, and as =
part of our standard procedure, our IT department requires completion of tw=
o brief documents: a Cybersecurity Questionnaire and software questions. I =
can attach both forms for your review. If there's a specific team member wh=
o handles these requests, please let me know, or feel free to forward this =
directly to them. We appreciate your help in supporting our security compli=
ance process and look forward to moving ahead with the installation. Let me=
 know if you have any questions.=A0=0A=
Thank you,=A0=0A=
Latasha Harrison=0A=
Project Manager=0A=
Library Services=0A=
=A0=0A=
E: HarrisonL@HCFL.gov=0A=
P: (813) 276-2160 | M: (813)=0A=
  352-1273=0A=
=A0=0A=
102 E. 7th=A0Ave., Tampa, FL 33602=0A=
HCFL.gov=0A=
=A0=0A=
Facebook=A0 |=A0=0A=
 X=A0 |=A0=0A=
 YouTube=A0 |=A0=0A=
 LinkedIn=A0 |=A0=0A=
 Instagram=A0=0A=
 | =A0HCFL Stay Safe=0A=
=A0=0A=
Hillsborough County Florida=0A=
=0A=
=0A=
  Please note: All correspondence to or from this office is subject to=0A=
  Florida=92s Public Records law.=0A=
=A0=0A=
=A0=0A=
=A0=
