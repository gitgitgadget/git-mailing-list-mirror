Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021124.outbound.protection.outlook.com [40.107.51.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B12D9EDC
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001906; cv=fail; b=HDAnqE3vNSHOLIGZp1Ql/e8KtTbzNM6GGpFuX0Hh3P6fHfxyxqYapvikWHhO4UTfBNr4wMecwj78mB2RGnqPktMH4SiIzkxeZURIzq5h9syDg3FADvo7W+9rrs9vJ7VSAXri/dwwPuVmvYe2s935Wk2OKt6KGtlsSM7YwaUc1hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001906; c=relaxed/simple;
	bh=dx2w1xJWGtXja6Ij9eHTqWmyN9o5qxsdXjZwi/Gx+1c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lYpxCk26WVAjURdnAL9QE0PIC3IWknUVtR73eOkukxxeBGG2tjcUly2eW5+8cVPG0Mp+YP/dUBefF4eNkg6yNayIHq2e1nNHCiP0ZOtTrtozCky3OftJSiJd99P1xDxCMCU45cVdTtMLR0N7pRvaIUwj8kV9CnFV4boZHU4TZ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cctech.co.in; spf=pass smtp.mailfrom=cctech.co.in; dkim=pass (1024-bit key) header.d=puneoffice.onmicrosoft.com header.i=@puneoffice.onmicrosoft.com header.b=d4Y+bhms; arc=fail smtp.client-ip=40.107.51.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cctech.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cctech.co.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=puneoffice.onmicrosoft.com header.i=@puneoffice.onmicrosoft.com header.b="d4Y+bhms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7MJwjDnbRG7tr9BiU6hx3RI309iSFw9tmvGaqwrP6TWVnlwXqZidwUCRFzEjtsir3uXiw5gMR8AGMmno7yS0yWl+uVUKv82Ynk4grmESF5pf1vHftvUO7Ka0SITFwG75RZdIDfB9u2kbERwa4fjkJO5YHvWwzuXfbDNGDc34QOcYHM60ARpHjH8mDfnrGVZkHmrx1ddJfeRZVxRurfopWBhX83M1Up1OsN53JCfmFgAOLfLaRDSZXQJNXHNdH7Tw4MLWKKTfNDfpza1wC+FI0spIDyPDPZPUYhT+TPqOzQs+jCpQBmZuR9JeI+o7inKeGsqyfxrgXT7hYDb5hwmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzXi5dpCFTvD1ZrFpm9LYXM9PKG+8jUMk+cJKZ/mK+s=;
 b=HHvzQkckfo/Q599dFG5alc6H1p7dd9KNy4p7gwi4q4cRcVlmqq2eXx/hoA/ByGxFuZ0lJ5jGIn9ji0mlbarHosKzdvZiT7I3SVQP1KOxJg5xzvQOGgBZ/LXYYpollC63U1v8saWFz3D76TcB8e5a+aaTqeyN/LMIgqYmyQF6Yv5kzqofhXLTdp6FPbiixMHG2D7qyDjPWSjxlin32fDViPX36Vx8GJcv91vEzZarnxxp/p6RjXYI6B765rwrBjw7J51dtG3fIMb3JrKFw7ctHtql/GoSQiYvLn381hhd1l+Hc5GxdE4NeCfiDfVodwnmJAMidLlFNM5H+fCDb9eX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cctech.co.in; dmarc=pass action=none header.from=cctech.co.in;
 dkim=pass header.d=cctech.co.in; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=puneoffice.onmicrosoft.com; s=selector1-puneoffice-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzXi5dpCFTvD1ZrFpm9LYXM9PKG+8jUMk+cJKZ/mK+s=;
 b=d4Y+bhmsjCdc0zHC7KpqFCd0RlmzItOBSyIBd0tgTyAgBdJTeRDMRSO5QFKlAqNnyhWcByVzlikLuT5yVa2EYrOTtzYguzXv5yWlMWvKVUZqMPN1UXIvGA9D16/a1+rSzqtU2yHQR7NRiPtO9ahm58g7tAXl9lu/ydvACZ3xKkU=
Received: from MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ef::12)
 by PN2PR01MB4138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 04:04:59 +0000
Received: from MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::39ba:3a56:d32c:726c]) by MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::39ba:3a56:d32c:726c%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 04:04:59 +0000
From: N.S Kishore <n.s.kishore@cctech.co.in>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: local mistake - need help in recover
Thread-Topic: local mistake - need help in recover
Thread-Index: AQHdE0UaezcAzPePVEqcZpABQjk6LQ==
Date: Tue, 14 Jul 2026 04:04:59 +0000
Message-ID:
 <MA0PR01MB9857F8757F67BD2F8FF358CF97F92@MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cctech.co.in;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB9857:EE_|PN2PR01MB4138:EE_
x-ms-office365-filtering-correlation-id: e9fe64d0-df0d-4274-bc3b-08dee15d12c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|10070799003|23010399003|376014|1800799024|38070700021|4053099003|18002099003|56012099006|8096899003;
x-microsoft-antispam-message-info:
 Z0TID6V7iEheOn2AmBrfu/AfiCMpScP+eOV6NWTJun/9UuOzNR6dRav6uLKtj+HYF/fctjc+w90hrLJvQqTcLLjRRiOzm4L+UYcMgn+9zwUe3u9hF/oC5hrosa6cE3BgE0t1vf+08HimcDhkhLWB2BeXWBtDaXQwqRV2tCPZwhdfSd3LMQupDBhCzh61y59EAKMAgxzCbCBPyOPK8fJmmAMWrN4RJxxHQ3OcVlZ/Ehjeg8Amn1H3i5612dxzW4kYXa4sr1mR6bSF8irmKnQrOTnKcmwujZp5yOqhr9l7jHmJfGOb8JaeH/r3txILcsxhcjQyRh3nSdnmXcN+9Lqahqn7mnuDVnkjrjUGbcETQtToYd/uqxOoV1U2OnwC1G+Sh1RTNWuX7frYBb9RsheExnmFNX3skJu1Ko46fHKJVrh1UalzhB9R43xZ4hF3QxJ+bHe7fql2p/+iweqPpfLpa2nAREybhUq+aL5w/utjPsDOIJhcilBtxUo7hQ3jWrC/HkqYoPStFYH87wcdHdQrMFaS+oxgtJZi5TECQ3P36AQrfkQwJ3XPsm4L8Fgt+GSGqFfffCLPEm4rWAo9axiYtLd5Qd9P5NNziphSkBz9TBpyDfOTwH4CvmUl5W4FEK+yPHRPxD8Bmhjfy4qNRJ3LYH0wan8m4UT4MohelCaaL5WvESQjxSBD86fs9bGMUD6BIgibypt4XrlTnYL54VG79CqOOc0lziAGRFhDaJblfcg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(10070799003)(23010399003)(376014)(1800799024)(38070700021)(4053099003)(18002099003)(56012099006)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Djl5n1sJrAWHcZ5zWfGyv1kO4vWJBsc5PPLsFsuxJH8CSbM3cQBKwO1c4BjS?=
 =?us-ascii?Q?gexKE3IbgPkJllDOnh4I3ScnhrkZynrrKGSxSKyXkuTb1ON8GlAZ/QhIg3eS?=
 =?us-ascii?Q?jvLcEwlAT/7WfeHtqikPXzXzu822cXkLKmLkABFLFjFyckQZxws+WCjakNgl?=
 =?us-ascii?Q?L0WnHvwy3cpcp4gsyQyMkKYeOKJCcumZ6kIfxtojpjezGBSXTxhJbOhw4wMC?=
 =?us-ascii?Q?UXx+MJm9RUoWMyFiPeiYvQdLpKbv8JQpYUsdY/FXDuEklT6dY5KJlAzMO9zl?=
 =?us-ascii?Q?92J3Cf1GlfebIFzNYNnqIAmmeVfkUAuqZqRsAdeXP+U8AFccV0OU/oGYk6KB?=
 =?us-ascii?Q?XhnonYAG86kgFE+MkLJ6anO+/Hl2kV/xtOWHZ47AaDRS9qclCLaCNOKEfQki?=
 =?us-ascii?Q?6iObwb9EXq3TuNkaghZaflJ71F2FLBE1lQfUhaPsABUVfvz2J1Hera5v2kia?=
 =?us-ascii?Q?22CxbUkPv+x3kZp6dVqD5fieaD2NiJS0+LDvXRhk5p2W+ZEwLUA3kY38Y09a?=
 =?us-ascii?Q?wRmcKNKEQw/jh+pess29LjGV3ZhZzRbWI/2o6Qz4pikRz0ZlsCFNfmASAdVA?=
 =?us-ascii?Q?+Y8+i5SVFphkYMs3oMEsV+Zu0N5izOMht8g9GSY9Jkgl01TEjmi8/fySof31?=
 =?us-ascii?Q?a+G5ILWzj6+6lus8qrQ7W7ziwQcNpZ6Jn2C0YXt6q0oQrDLLj5giC7QMkUIW?=
 =?us-ascii?Q?c04EVSUBrFXqV37BUgT+fQmA+bbifLJiFRelQDbqHar6HufM60fbSEFEw7Uj?=
 =?us-ascii?Q?s7bQqUOCTPBQldS+cMuOQPB23ZKkBWPzI3D1D1cDWfAvelHi0w7dEaMOyQlN?=
 =?us-ascii?Q?owTW/vJiCOXSKsrpTdfTIgn23GEHTCGWxPUlI+Raat3v91Yr3y+WqOO76Mze?=
 =?us-ascii?Q?W18D63W+UdTO9dUBN4SytcxuPBBuWQ45FVHzZnH7F5PDGQZfoNauuuILDkFI?=
 =?us-ascii?Q?N9sPHSN/khpT6Q7K0seWLYkz5Fa0h5spTOfZrgytLvhssRNKw2dvzC+sr6AC?=
 =?us-ascii?Q?g0mbwryxLh9JCPXeD5hmJVBBM7KWDNyeMeaIW1DjaW3Jc0uJZHgC57R99Ork?=
 =?us-ascii?Q?GyDfbmrL3o4fS47LojchMC/au59x4IKmL26sC2NJlkmJKHmEbTYTli14DrNv?=
 =?us-ascii?Q?TKUfHLjYwnzhor2nxo+u63FPs+iPeBv7bKQh9iHMuu0VVBJFYAT03DMBUCi6?=
 =?us-ascii?Q?MAU9h1d1Ki9J6KUszOF23i5g2b4zH4eZqcaF5qdZxEIiJNAuZy73cAPna6TD?=
 =?us-ascii?Q?QOAEFutBa1sS4X5HEmgXkcoSAd28OdWo56dAb6wdQyiz36HOECa4EOXXa833?=
 =?us-ascii?Q?HQ1nW9QQASZRe9Z2y5OM7yuVwlzQXbVI0zsic9fUBvH/4zFqGjguN08z/vJ6?=
 =?us-ascii?Q?/57pv/Q3bFsgsKECK1YZyyb6pajVthgm8N1eV6Dq43JdpvLoXnNVbMMMLtUA?=
 =?us-ascii?Q?B+cUSp92t3vTOQoG+P8Hgif+PzVANAnNU8Dxdjyqj5lzQnMK5xqYdSr5MO06?=
 =?us-ascii?Q?y5LNyXB4YR6fiN0teL+8IIXofJLGNEytYj0NONjDeenlfAZP+spJuk+3BMOe?=
 =?us-ascii?Q?msWXsYpD+WSeQM6sRiyYI7tz71Hhxuy33WJbL1Rkn0gmaK2YFYKQP323DF75?=
 =?us-ascii?Q?aiXmFVwGfJeFG+nCGwxvRWPqicdSHwJL/92Uzv/sMd4irDA35gqggomw9XrD?=
 =?us-ascii?Q?LPjoDYopDl/2ui/BbZM1KUlyGeNV7HLlhKbhXr/Mj9HmxaU6RDcWbcFAHq7K?=
 =?us-ascii?Q?BnsyFQ+AYeJGRPnYNCQhEkr2SHLX9dO73w4hrsl2oqCo8sHXmuva53LjohGr?=
x-ms-exchange-antispam-messagedata-1: isL/ogTXGaFOk4Y5bJjo4IyjUDdpaCNyYj0=
Content-Type: multipart/mixed;
	boundary="_004_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cctech.co.in
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB9857.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fe64d0-df0d-4274-bc3b-08dee15d12c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 04:04:59.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dbb488b6-7147-4fd8-b195-3bf51fab7f68
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LohvSnQysC78oRC7LGgRkmLor7Bkr+qO9eJyhK1d6U2YBK+JkLNubkDS6mOKZqS4Ur+GMSQ0mEQN8J3L6+T0Ss0ZAI9bI2cpswDadXO6cNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4138

--_004_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_"

--_000_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Need help to recover files from local mistake.

Regards,
Kishore N S.

--_000_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
Hi Team,</div>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
Need help to recover files from local mistake.</div>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
<br>
</div>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
Regards,</div>
<div style=3D"direction: ltr; font-family: &quot;&amp;quot;Aptos&amp;quot;&=
quot;, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"=
>
Kishore N S.</div>
</body>
</html>

--_000_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_--

--_004_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_
Content-Type: text/plain; name="git-bugreport-2026-07-14-0922.txt"
Content-Description: git-bugreport-2026-07-14-0922.txt
Content-Disposition: attachment; filename="git-bugreport-2026-07-14-0922.txt";
	size=3839; creation-date="Tue, 14 Jul 2026 04:04:54 GMT";
	modification-date="Tue, 14 Jul 2026 04:04:54 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgoxLiBXb3JraW5nIG9uIGEgZmVhdHVyZSBicmFuY2ggd2l0aCBz
ZXZlcmFsIGRvY3VtZW50YXRpb24gZmlsZXMuCjIuIEhFQUQgY29udGFpbmVkIG9ubHkgYSBzdWJz
ZXQgb2YgdGhvc2UgZmlsZXMgKGFscmVhZHkgY29tbWl0dGVkIGVhcmxpZXIpLgozLiBDcmVhdGVk
IGFkZGl0aW9uYWwgZmlsZXMgbG9jYWxseSBhbmQgZWRpdGVkIGV4aXN0aW5nIG9uZXMuCjQuIFN0
YWdlZCB0aGUgbmV3IGFuZCBtb2RpZmllZCBmaWxlcyB3aXRoIGBnaXQgYWRkYCBmcm9tIHRoZSBJ
REUgKFZTIENvZGUgLyBDdXJzb3IgR2l0IGV4dGVuc2lvbiksIG92ZXIgYSBwZXJpb2Qgb2Ygcm91
Z2hseSAyMOKAkzMwIG1pbnV0ZXMuCjUuIERpZCBOT1QgY29tbWl0IGJlZm9yZSBkb2luZyBvdGhl
ciBnaXQgb3BlcmF0aW9ucy4KNi4gTGF0ZXIgcmFuIGBnaXQgbWVyZ2UgPHJlbW90ZS1icmFuY2g+
YCBpbnRvIHRoZSBmZWF0dXJlIGJyYW5jaC4gUmVmbG9nIGFsc28gc2hvd3MgYSBgcmVzZXQ6IG1v
dmluZyB0byBIRUFEYCBzaG9ydGx5IGJlZm9yZSBtZXJnZSAvIGJyYW5jaCBhY3Rpdml0eS4KNy4g
Tm90aWNlZCB0aGF0IHByZXZpb3VzbHkgc3RhZ2VkIGZpbGVzIHdlcmUgbm8gbG9uZ2VyIGluIHRo
ZSBpbmRleCBhbmQgd2VyZSBub3QgaW4gYW55IGNvbW1pdC4KCgpXaGF0IGRpZCB5b3UgZXhwZWN0
IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQoKLSBTdGFnZWQgY2hhbmdlcyBzaG91bGQg
cmVtYWluIGluIHRoZSBpbmRleCB1bnRpbCBleHBsaWNpdGx5IHVuc3RhZ2VkLCBjb21taXR0ZWQs
IG9yIGRpc2NhcmRlZC4KLSBgZ2l0IG1lcmdlYCBzaG91bGQgbm90IHNpbGVudGx5IGRyb3AgdW5y
ZWxhdGVkIHN0YWdlZC1idXQtdW5jb21taXR0ZWQgd29yay4KLSBTdGFnZWQgZmlsZXMgc2hvdWxk
IHN0aWxsIGFwcGVhciB1bmRlciAiQ2hhbmdlcyB0byBiZSBjb21taXR0ZWQiIGFmdGVyIHRoZSBt
ZXJnZS4KLSBUaGUgSURFIHNob3VsZCBjb250aW51ZSB0byBzaG93IHN0YWdlZCBmaWxlcyBhbmQg
YWxsb3cgY29tbWl0LgoKCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikK
Ci0gQWZ0ZXIgbWVyZ2UgKGFuZC9vciByZWxhdGVkIG9wZXJhdGlvbnMgaW4gdGhlIHNhbWUgc2Vz
c2lvbiksIHN0YWdlZCBmaWxlcyBkaXNhcHBlYXJlZCBmcm9tIHRoZSBpbmRleC4KLSBgZ2l0IHN0
YXR1c2Agbm8gbG9uZ2VyIGxpc3RlZCB0aGUgZmlsZXMgYXMgc3RhZ2VkLgotIE5ldyBmaWxlcyB0
aGF0IGhhZCBiZWVuIGBnaXQgYWRkYGVkIHdlcmUgdW50cmFja2VkIGFnYWluIG9yIG1pc3Npbmcg
ZnJvbSBzdGFnaW5nLgotIFRoZSBJREUgbG9nZ2VkIHdhcm5pbmdzIGxpa2UgIkZpbGUgbm90IGZv
dW5kIiB3aGVuIGNvbXBhcmluZyBhZ2FpbnN0IEhFQUQsIGJlY2F1c2UgdGhvc2UgcGF0aHMgb25s
eSBleGlzdGVkIGluIHRoZSBpbmRleCwgbm90IGluIGFueSBjb21taXQuCi0gQXQgb25lIHBvaW50
LCBpbmRleCBlbnRyaWVzIGZvciBzdGFnZWQgZmlsZXMgc3VkZGVubHkgZGlzYXBwZWFyZWQgKHZp
c2libGUgaW4gSURFIEdpdCBsb2dzKS4KLSBGaWxlIGNvbnRlbnQgd2FzIG5vdCBmdWxseSBsb3N0
OiBibG9icyB3ZXJlIHJlY292ZXJhYmxlIHZpYSBgZ2l0IGZzY2sgLS1sb3N0LWZvdW5kYCBhbmQg
YC5naXQvbG9zdC1mb3VuZC9vdGhlci9gLCBidXQgbWFudWFsIHJlY292ZXJ5IHdhcyByZXF1aXJl
ZCAoY29weSBibG9icywgcmUtYXBwbHkgZWRpdHMsIHJlY29tbWl0KS4KCgpXaGF0J3MgZGlmZmVy
ZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/
CgpFeHBlY3RlZDogc3RhZ2luZyBpcyBhIHNhZmUgaG9sZGluZyBhcmVhIHVudGlsIGNvbW1pdDsg
bWVyZ2Ugc2hvdWxkIG5vdCB3aXBlIGl0LgpBY3R1YWw6IHN0YWdpbmcgd2FzIGNsZWFyZWQgd2l0
aG91dCBjb21taXQ7IElERSBzaG93ZWQgY29uZnVzaW5nIGVycm9yczsgd29yayBoYWQgdG8gYmUg
cmVjb25zdHJ1Y3RlZCBmcm9tIGxvc3QtZm91bmQgYmxvYnMuCgpUaGUgbWVyZ2Ugb25seSB0b3Vj
aGVkIHVucmVsYXRlZCBwYXRocyAobm8gY29udGVudCBjb25mbGljdCBvbiB0aGUgc3RhZ2VkIGZp
bGVzKSwgeWV0IHN0YWdlZCB3b3JrIHN0aWxsIHZhbmlzaGVkIGZyb20gdGhlIGluZGV4LgoKCkFu
eXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgoKRWRpdG9yOiBDdXJzb3IgKFZTIENvZGUtYmFz
ZWQpLCBHaXQgZXh0ZW5zaW9uIHVzZWQgZm9yIHN0YWdpbmcuCgpSb3VnaCB0aW1lbGluZToKLSBT
dGFnZWQgbXVsdGlwbGUgZmlsZXMgb3ZlciB+MjDigJMzMCBtaW51dGVzCi0gSW5kZXggZW50cmll
cyBkaXNhcHBlYXJlZCBzaG9ydGx5IGFmdGVyIGxhc3QgYGdpdCBhZGRgCi0gYGdpdCByZXNldGAg
YW5kIGBnaXQgbWVyZ2VgIG9jY3VycmVkIGluIHRoZSBzYW1lIHNlc3Npb24KLSBSZWNvdmVyeSBy
ZXF1aXJlZCBjb3B5aW5nIGZyb20gbG9zdC1mb3VuZCBibG9icyBhbmQgcmVjb21taXR0aW5nCgpT
dWdnZXN0ZWQgcmVwcm9kdWN0aW9uOgoxLiBTdGFnZSBzZXZlcmFsIE5FVyB1bnRyYWNrZWQgZmls
ZXMgKG5vdCBpbiBIRUFEKSB3aXRoIGBnaXQgYWRkYC4KMi4gRG8gTk9UIGNvbW1pdC4KMy4gUnVu
IGBnaXQgbWVyZ2UgPG90aGVyLWJyYW5jaD5gIG9yIGBnaXQgcmVzZXRgIC8gYnJhbmNoIGNoZWNr
b3V0IGluIHRoZSBzYW1lIHJlcG8uCjQuIENoZWNrIHdoZXRoZXIgdGhlIGluZGV4IHN0aWxsIGNv
bnRhaW5zIHRoZSBzdGFnZWQgbmV3IGZpbGVzLgoKSW1wYWN0OiB0aW1lIGxvc3QgcmVjb25zdHJ1
Y3Rpbmcgd29yazsgcmlzayBvZiBkYXRhIGxvc3MgaWYgYmxvYnMgaGFkIGJlZW4gZ2FyYmFnZS1j
b2xsZWN0ZWQuCgpXb3JrYXJvdW5kOiBgZ2l0IGZzY2sgLS1sb3N0LWZvdW5kYCwgYGdpdCBzaG93
IDxibG9iPmAsIGNvcHkgZnJvbSBgLmdpdC9sb3N0LWZvdW5kL290aGVyL2AsIHJlY29tbWl0LgoK
ClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4g
ZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCgpbU3lzdGVtIEluZm9d
CmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjU0LjAKY3B1OiBhcm02NApubyBjb21taXQgYXNz
b2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNpemVfdDogOApz
aGVsbC1wYXRoOiAvYmluL3NoCnJ1c3Q6IGRpc2FibGVkCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFl
bW9uCmdldHRleHQ6IGVuYWJsZWQKbGliY3VybDogOC43LjEKemxpYjogMS4yLjEyClNIQS0xOiBT
SEExX0RDClNIQS0yNTY6IFNIQTI1Nl9CTEsKZGVmYXVsdC1yZWYtZm9ybWF0OiBmaWxlcwpkZWZh
dWx0LWhhc2g6IHNoYTEKdW5hbWU6IERhcndpbiAyNS41LjAgRGFyd2luIEtlcm5lbCBWZXJzaW9u
IDI1LjUuMDogVHVlIEp1biAgOSAyMjoyODozNCBQRFQgMjAyNjsgcm9vdDp4bnUtMTIzNzcuMTIx
LjEwfjEvUkVMRUFTRV9BUk02NF9UNjA0MSBhcm02NApjb21waWxlciBpbmZvOiBjbGFuZzogMjEu
MC4wIChjbGFuZy0yMTAwLjAuMTIzLjEwMikKbGliYyBpbmZvOiBubyBsaWJjIGluZm9ybWF0aW9u
IGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL3pz
aAoKCltFbmFibGVkIEhvb2tzXQo=

--_004_MA0PR01MB9857F8757F67BD2F8FF358CF97F92MA0PR01MB9857INDP_--
