Received: from s2asicseg.secureintellicentre.net.au (s2asicseg.secureintellicentre.net.au [124.47.137.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D4175A68
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=124.47.137.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964823; cv=fail; b=jQRs+I2mAkkPRG7hPF08+0U6w3fEeNg9JOPkre/5jus72TOjf+OP8XFXwxiBYbHlNrzoieHje3ueegt89RQtdYjiktkDV2R4HZtUFEoPlxK1D2xttvSz5ur5qLugOdIvPa/03ihzCP8Oi5V8msVyU9xOciE3+lg/MfgtZFmg0kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964823; c=relaxed/simple;
	bh=sUhZegpbAOTJRQ+sNnxBOOijVBfMjFAgAAKl0vGEL7k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XWnD3e+e46nL8VO01vAcNd2LmTVydIg0Gxw0r6YIHqd6nylU0t4Qq7PPlMwJuyBzzjXD4uk919L4ih27DZ3Nx/xiaUyBdo2ff8URPzwogcxp4RZyKJYhRnoFxNIy8blsRYz4w2rMmKkoz5DaLqAFXy/3FiW3cQfTwscICrwulqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asic.gov.au; spf=pass smtp.mailfrom=asic.gov.au; dkim=pass (1024-bit key) header.d=asic.gov.au header.i=@asic.gov.au header.b=OR/r0J6k; arc=fail smtp.client-ip=124.47.137.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=asic.gov.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asic.gov.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asic.gov.au header.i=@asic.gov.au header.b="OR/r0J6k"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asic.gov.au; i=@asic.gov.au; q=dns/txt; s=asic;
  t=1782964819; x=1814500819;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sUhZegpbAOTJRQ+sNnxBOOijVBfMjFAgAAKl0vGEL7k=;
  b=OR/r0J6kZpLNBKjifIqcTPt28cEvjEN9CHW4+60a8UizqnbB6a4uQYlY
   gH1PqaRf/hJJXEv1TkgrAxOTp72ddqOH+XgfaD+nPK6wtiVioY2792zvM
   P2uBhaueUDX6AAZldLVqVIA5Ny88wKDr5bIhRZGG8qf9BrVChhNR2E2Uk
   s=;
X-CSE-ConnectionGUID: 51JsFPrBSTa9Pe+fCA5lyA==
X-CSE-MsgGUID: WBEMo2p/SZWOdLwO/Dq2+Q==
X-SEG-AV: None
X-SEG-AV: None
x-seg-msip: true
X-Protective-Marking: VER=2018.2, NS=gov.au, SEC=UNOFFICIAL, ORIGIN=Michael.Hore@asic.gov.au
x-seg-msip: true
msip_labels: MSIP_Label_425c8099-8bb5-4208-a7fb-18c77e40dc98_Enabled=True;
 MSIP_Label_425c8099-8bb5-4208-a7fb-18c77e40dc98_Name=UNOFFICIAL;
 MSIP_Label_425c8099-8bb5-4208-a7fb-18c77e40dc98_SiteId=5f1de7c6-55cd-4bb2-902d-514c78cf10f4;
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="11641584"
X-IronPort-AV: E=Sophos;i="6.25,143,1779112800"; 
   d="scan'208";a="11641584"
Received: from mail-australiaeastazon11010058.outbound.protection.outlook.com (HELO SY8PR01CU002.outbound.protection.outlook.com) ([52.101.150.58])
  by s2asicseg.secureintellicentre.net.au with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jul 2026 13:59:07 +1000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfdhlXOc5nc4GmSi1yDfQZh8IYGtl41gFFMpGxJ+eQHr8mNnHqmU3DfO0tYuLHqyM6lAlJdIXAfFxYvp1lTMo2YvdVZ9MOm6NhSUvXyHkslxu3oLAd0HntRYjTil5OYL4pyLCD37lfwxySlSrjhoV+Ik/QzatDLApn0Px/wB1XPJ/jj678WE7mT+5FS0w0fwN7EEimkPBtCar1sQBmcEoik8XfcazWnuM6ZhMa/AE2/7S6oAZC63YfQP3HgN751dXvqRE50hDurD8YkkGvDmzOXTAyNjNtdXkWBN3IgvEWrZI8WGMEkN5ghw8vj003ZDk5CDJxXTfCjjhIYvStrxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUhZegpbAOTJRQ+sNnxBOOijVBfMjFAgAAKl0vGEL7k=;
 b=dGE+eqBMYusPtRClkg34hQ5mql/PdEy6sixJxfs0V6ILJHujdRm/ppv7+otad51/VTc5Ke9i+U2YEcTTVYGv1usTx2bLt2+umlzTtTH71OXEnEQ5C+Pm+njQyO87nVGPiiW4fzx7NEYOova810chzMGyJk46cCv3snBOMa9XdlxGHda9rD2T3+Rv7W02u938XCocGfd4Z7pqhdGPURJYhYQz7BTWcsA16SsHUSFntXeuDobpQmlulH1ZDcTg4WO8H5gHl08x2mn08vcu4n8LTHoYbzP/ADHWnrF7oNYprT3KGgogRqOTagy3Lbf7GKW29fDBcC+ZSGaR9iKQVanAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asic.gov.au; dmarc=pass action=none header.from=asic.gov.au;
 dkim=pass header.d=asic.gov.au; arc=none
Received: from ME2PR01MB5490.ausprd01.prod.outlook.com (2603:10c6:220:d1::10)
 by SY9PR01MB10159.ausprd01.prod.outlook.com (2603:10c6:10:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 03:59:04 +0000
Received: from ME2PR01MB5490.ausprd01.prod.outlook.com
 ([fe80::24a1:65b4:acc2:d2e3]) by ME2PR01MB5490.ausprd01.prod.outlook.com
 ([fe80::24a1:65b4:acc2:d2e3%2]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:59:04 +0000
From: Michael Hore <Michael.Hore@asic.gov.au>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug report - git rev-list --exclude-first-parent-only
 [SEC=UNOFFICIAL]
Thread-Topic: Bug report - git rev-list --exclude-first-parent-only
 [SEC=UNOFFICIAL]
Thread-Index: Ad0J1x7XxnQAIxwjRmu2hbGTh453Ow==
Date: Thu, 2 Jul 2026 03:59:04 +0000
Message-ID:
 <ME2PR01MB5490E3CE825C83474D1573CED1F52@ME2PR01MB5490.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-seg-msip: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asic.gov.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME2PR01MB5490:EE_|SY9PR01MB10159:EE_
x-ms-office365-filtering-correlation-id: 35284263-b655-4e2a-78ee-08ded7ee422f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|11063799006|5023799004|56012099006|6133799003;
x-microsoft-antispam-message-info:
 LQgNUoJs7qLbqTgsPH9uFoIos5JH7i+oV3FaKkqOOIJfJ9vFN0nmmxoWsh7c0IOMjqOZQf++oBLPX/SkYR+atZVKRU4pZWOzfdakbQKVFfHkEiNBNNwshg4NFEEg069ukUm96Vy/ChsNbAb4hAfHvH86JBXcC6wL9y4OQSJGDnZN+egMGLvI7RXNi6/46jYm1NhyfrsGV0y1xx04YiD5KPpCDbk2AJVaPWNDfnx+l9DiKpkwuJvlLKRrb3hHbqNQgxFgfpEBL8YESe5yCehIYpAbZ4tr5piBYN2CQxFvk55HLEH67vOEylT6pl7JNaFhBuTSUCjIYOGFjaKZrxUoOaSg9DO1fT4WhZhIrO2Q9SliVw1vEd1T8eMnJZjtb2KDEVy0JpabIZrK+kc+nJKHRswuX6QDtpwapFh2eK3g1zONhl98tkTumeZ6yWdX5CkzaPTMPSADuvJ2J57pipw0vyC2R7Nx4Iwz78nvNycwXNxz7WLNnp1pzOYzCX3o4MZtVxG9W/4cCZfMxuAR+aCeO4yOMCVcBUx/qYf/Z30Rq/FGhiXsq/ifuUfKy0lcjqzylhcW8IQ0Bs8hel+qSt/XZZmujdcS7eyND4te8yb96YLu480XhFAkqXDHkpQMztFefjzLSkAcwYziXxcdwooxGUzSVPi8lhGzY74zfgiW+ZNd03cu0UO/2oT4g0CrDN6FaUjT+ZuHzrrHOsAcyySmmg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME2PR01MB5490.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T214VpUu93au4D7CZl1sEehQyZC7KZ+cvGwiBYCH7xKC5CfTnsCf3shvmHCw?=
 =?us-ascii?Q?ahGccPCZLnEl009UyJdgSY1Dnh5Pwf8puPjOVgmnLI2+CEK5ypiMuoSYYEDf?=
 =?us-ascii?Q?2mRfy3mz+CS4xqZw+a4qHofQRkVpomED8Ep7R1s+9lPjqrPySUw4HutxmOF1?=
 =?us-ascii?Q?8NswR4luCCTON1xVZ3veG+ZbMoUg6wAgPRUXh/uTEwNHyndEP320/gZ/oHY0?=
 =?us-ascii?Q?q7dqjQkkFQUPQIMVI8SGvzlLTmDM85GL90lpZ4VBchyudRG1kE/YfXWPg++j?=
 =?us-ascii?Q?Z8PvBkyNdjNpKPortVZm477Ppkk8fyFs/wlE3kGdkg1S3a/DUMopSCqQh+lM?=
 =?us-ascii?Q?xeHql7X2qRaw+iuYEptfaORnFMqT+UUG/kicfjTXMHSbt/rC/Uymkt92dyiq?=
 =?us-ascii?Q?6h3ole2OmcG2oDye3sR3MhqeC0oMrQQJ1VUOBgHMHZF8Igybi4NupQQCLeXh?=
 =?us-ascii?Q?34CjKz1VMI6R+AVDWLIh90MOIxIDSoQOKppFZlIIcTXA8reWeNasQ2DG0U0C?=
 =?us-ascii?Q?VES9VKvkmDJPKj0voG6qXNdnaFTjXRwBlKIBkvRMUr5AsiBQ9OsoF7HtSbIk?=
 =?us-ascii?Q?3iDyDc3KSSy/1izvew6FRnKtSpQwwCGEKO//ovbHuagttDw99jnj/zcnlv/C?=
 =?us-ascii?Q?M4JIWxaU/PDWsk7f4uA5wNcCy1BB/aPTMyA2M15vTPtDvRXf/SjtOPfKoP4T?=
 =?us-ascii?Q?xTvyczN/h9LMr/M8ylXocGTqs0ywoKd0pXp1ZeiKhnV7UA9ceDHBBqzs9qzR?=
 =?us-ascii?Q?5rOb0SGsUrF566aZSPGS4s444uO4OlbTNpxQXwH9dMnm2StBrDpfrcVfKh5W?=
 =?us-ascii?Q?j7bUpShTCqHh3q/f0jyfwnr2ik+/T5WKVseIRa9MQvy1PQPlVJGLthDU8JYA?=
 =?us-ascii?Q?pNhdGVcecklONuJa7Mno2eECc8W8ZeJ7beff9ZQbgXvX9a2s3j6MODpMvrzW?=
 =?us-ascii?Q?kzjaktIPqyFmDpwnElpAPdcUeejRx+B86c5n0gS9IS42eY5VNsxv1h++OfWx?=
 =?us-ascii?Q?gRJ2w9FHXCldbSkJBZNJSJvqJM6inWPvKMeHpWswgCyzmrGDSWfjv89LxDQ4?=
 =?us-ascii?Q?sqGFoliJ5S+FWL1ymFKihVKYuxf8ZwzvdOokmKMvI6p6D/vb74RtoEWnDWns?=
 =?us-ascii?Q?O7L8GZNrslkl+NTe/hRc4oyGJKXStqawlhjfP5YZ+vil2+zjegKe/1ymnoZg?=
 =?us-ascii?Q?594ZIb6rsK69duNm8irEFiLxMunIUBAyxo0WUaYuuuH10/ZpP07Wsa00HTEM?=
 =?us-ascii?Q?nKixs87Ol+NdugHorFn6iVLTDI3hNmaX+Buu7A/kpguuoxtAPE7BW64BATER?=
 =?us-ascii?Q?0xGCWBQyXmZcbQJECyBc+2nI9XET3YVrCSysNn6l4XOHzB97KksZkWyQz6Ov?=
 =?us-ascii?Q?fM9FpoBAQfNHkeNp8tMFLWVo/srr2IYok3Zz8sQwaArorPJ3qdVyt4I0SHlW?=
 =?us-ascii?Q?VpWLoK4+gjMP6ZrJCNCHB7RFCbpDJJwU/X+gzsS10SUzk8X1eWdFRx1hOh83?=
 =?us-ascii?Q?6Fc7pPxV1bBIuFFF5H5YguqRGFjee/x/C9ng0QWGvEtEJG26/THLgS/iBTQg?=
 =?us-ascii?Q?sgKXUcECoiw10zxEY3Oc71pNj8tjnYezDXSO0CRi+Fzdm8iyUN24Wm/1dbz0?=
 =?us-ascii?Q?YsdurVbx8yIakHbm9SqKUuzNAm5Pf1gWM8s7KXO7cUfEUOczQnMkilODx8/S?=
 =?us-ascii?Q?C/6VX6X4jz49j7bNSSnunNzQ7AvRxonZUIcKFO3ULQBhwNU2GQM+V4laD+lE?=
 =?us-ascii?Q?ki1IPPnQ/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SC0fRBkhlbaobDFfXjx7ZZHwtU+LVHUcYmdNP8igotekiHAKfjeOx/do/bt2hEAkuKj6xGNntbHjH/jBEGtAnPgS81fgEP6xcYwBye2ecOD4swJlremec9T/evp4l+/Q+O7fiP+wdP8s5qh2OBTJYb1tA4z+mfqLbCI2dYkdVNvAQSsvqoj/td4EeVNI0qinLjRxtYBCIcwkquNSBKtFGsgnM72xlQruGyE0nt7+2iNf/8kCgdTAW2fQRKXwzLBqtR4GieKtZPdK7nCmTPD54VbYQzgQ7kt7+gr36AT+MUZ+qU2N8A5o0v/YK4h0oop3t9nj7dKujU8Ux7u7ESwKMQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3bxhog/jsUJSzN/6cSa/QdQWjV0wraC+VYaw6fbvaizZd55FkFx9kuGj9jgvR+5EX5MPCHSaJl9CqIfQsfa62pl+ufsvvMeRDLGznPc0/PgwrzhZNfqMcC+mUYSeUj2Ajd5ZO7HxZIRtcvasgyP6skm32UELiGnFa0M/pieszBLsVbix82GfT0y0m4frLuv+dn8Ly9s9rM23+hVs8qFKrk+fnSWXqYpYc3p9HlVrNeH10YLOL4SPVpgf4DWYCv6rsfgoimSJsuJwKnVGtMZ1EJTblc5lNSohk9f8cqCeC0UpOQkqSQpc2QIWhlaaAh6baXfjdXeQvV4tKx/HTlsSyS5dDeksAizWAlM52bW2/BDpV8JRbGsgirH/lnnF+P7gQLEjU1kLJottpoGxXgA9rBcGh5NuvHwawNJpmg7vUX+3w7g08EApMDfGjdo7wAmIqApwtjjHP0QeN6AWW+RpC9M6zA6VteKF4lMlpInz4aw7Hb0VnOiWChRXv2WjYm785INfkLXy5aa3OZANR1jkrkXdVUaV3ySRmrzEtftlgHSUzXcpsRQnWyOg46TbMjCQYcBy6EpbAp/Sy/KJDeDjXZLrjEr7W10x9EVAcsB5QEIws0U1HxG/DcbJuUIckMLL
X-OriginatorOrg: asic.gov.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME2PR01MB5490.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35284263-b655-4e2a-78ee-08ded7ee422f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 03:59:04.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f1de7c6-55cd-4bb2-902d-514c78cf10f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvWZ0YZpLpAuWu6+SmVfV9LIBRA/d2pxKz6sU9zEd+QMJNQ4FlWyqztMU2F4WyNKbErv5hSlGP2gj59AgO3bartiFCFsE+Mj0gelDFHvKFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB10159

I believe I have found a bug -

My repo has a commit structure like

R2
|\
| F
|/
R1

i.e.
 - there is a merge commit R2 with parents R1 and F
 - the parent of F is R1

I ran "git rev-list --exclude-first-parent-only F ^R2"

it gave the expected result: "F"

I ran "git rev-list --exclude-first-parent-only F R1 ^R2"

I expected the same result, but I got an unexpected result - nothing at all

Suspected cause - I had a look at the code, and it looks like process_paren=
ts() in revision.c, when processing uninteresting flags, will skip the 1st =
parent and mark the 2nd parent as uninteresting if the 1st parent is alread=
y SEEN, even with the flag exclude-first-parent-only. I think maybe explici=
tly selecting R1 on the command line causes it to be marked SEEN before ^R2=
 is processed, thus resulting in F being marked uninteresting.

[System Info]
git version:
git version 2.54.0.windows.1
cpu: x86_64
built from commit: 2b8a3ab140826ac423c2845ef81d4c6ac4f7bf3c
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1


[Enabled Hooks]

Regards,
Michael

Please consider the environment before printing this document.

Information collected by ASIC may contain personal information. Please refe=
r to our Privacy Policy<https://asic.gov.au/privacy/> for information about=
 how we handle your personal information, your rights to seek access to and=
 correct your personal information, and how to complain about breaches of y=
our privacy by ASIC.

This e-mail and any attachments are intended for the addressee(s) only and =
may be confidential. They may contain legally privileged, copyright materia=
l or personal and /or confidential information. You should not read, copy, =
use or disclose the content without authorisation. If you have received thi=
s email in error, please notify the sender as soon as possible, delete the =
email and destroy any copies. This notice should not be removed.
