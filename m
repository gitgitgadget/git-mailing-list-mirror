Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BACF22A7E6
	for <git@vger.kernel.org>; Fri, 30 May 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605042; cv=fail; b=pxqhVAO3NJlp1RIkIF0dpjhkuvQQTVkyBX9Xhlnplnt96JdpPai3weEC3drib9NCshS97Pn7RusD47lBUjc0HCE/NVjxo8g4nujmsNsBEz0WGdi8zoQtRojJvr0rzSTlyoQgt8HAjJ6E1y8TgeaXI9FaGFMZN8lYi+jkph+iVuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605042; c=relaxed/simple;
	bh=shO72rCxgSKZdy5kvDKTRT2J5dRidGAlhJN+EBMIJEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxQIcRnt4FxkweOyFQ1q3liiew2A/K9UpujrRImBO7x07j3NXtAeqk2oLbyUddFQEA+/Qr7e6/0Qpo33GGdbviFbJOLOZ7NiOCXDKx5keTV+eVtUOlfvilOccIRjcYrnQ8zPR38YS7jZzg9H6b0pweOt+egEMOiJw5cMb9zA1x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pKppI7G/; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pKppI7G/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxhRT1rdmv9yjvhR09V8AvjNprKC899wCZ9dltvVNLJJfmFocalRq5qK2UMdslZ2XE8t9hvnMG13KHnOMQx1XWZWowLp7Pj61nLPHW+aYNu0Qw+nq5hmLQcZNE8EAudiQPq04PhIT6FomdFA/hrs3kDj9B+C+xULJso6f53tOTKdAWEVRdXcfM1Np4s3KnuB1G3ApPDDJBp/F/W1D5yq63mrKD1ySUFOOdZ132eHOGaZbrjOuNCV4QKIpM2ti1lCYocJir60F6pD3ksuAVW3hx8UI/umxKuNwyNgnKaFKbpK+PZPVD2uX63S95cn2xF9VvHVO47G1vpOm/b2anpchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7cH5qJeuzm6OcpbHB/+/+CrwzYNd+wXJeN03LxtG1I=;
 b=IfYO0CxOUFRApOaCkZtmnhs0D94R00OoKVXg5Z0+l8HTbzkV/WckGhvn69lQ9itzwlrsO5BSyboDRgKvNCfyROf6fZ7EPmU9mXgZcNmJT+9LnGN6mwlBtsviAC7hnOE0Xbm+LKgqa+2y0JJIXFIYIddPzEfS3Jm0eKtdKaivmXdrdeqhypAuq1fKwlExCcwRyo6JQVJxEtbEpn7bfpFnG3bXAmJ1opaDDQdRz2E5CD+LciSJNcxEPyYPlLDhTeRxYFbFM4Z3hyS+y/2MKyypeT8uUAm0HLbXbK51OaIGXGRERVyAhnAQ9OK1M9CiotO+K2GTW3KWOtxiGD8N5EOm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7cH5qJeuzm6OcpbHB/+/+CrwzYNd+wXJeN03LxtG1I=;
 b=pKppI7G/YjmkMgIV1dLjUedlnz3dUFb+preB4NtfjkicFOm/hH/BIpLXWJXTr58+/PyW4/fTy+CtZOZT1NBOdH6t4hAP1Eue2PGAfZ7rtQrR9ws3Jd0lYZibXk9cHNmTxMQnaOYLbUYt8vJD+rgD5NVDrKcleswA8Fssjqh5b4RXs6J0yMBpce85b/fay+S65HM3aJf7lRicqUUUAtRW57spjcb9QGhElAVuxq7Q8uKHzwguETvrGqdRIUs60d0hUf9ols5/4X7LlxWPbGSVo9BqIWUx8kuaqbYp6Mhfwp3y3GbbPrbNvsHrpiEOgZ5WblD9IbiqiF9R6CwVlob/Cg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:37:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 11:37:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v6 3/4] docs: remove credential helper links for emails from
 gitcredentials
Thread-Topic: [PATCH v6 3/4] docs: remove credential helper links for emails
 from gitcredentials
Thread-Index: AQHb0Vcvs1WMA0do00GF5E5Zv15W5Q==
Date: Fri, 30 May 2025 11:37:12 +0000
Message-ID: <20250530113627.8639-4-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530113627.8639-1-gargaditya08@live.com>
In-Reply-To: <20250530113627.8639-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4415:EE_
x-ms-office365-filtering-correlation-id: 07e0d19d-907d-42e7-b61e-08dd9f6e51f2
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndlmbqnVVkeM2BobHaL9MaaalYSq1lQ4fPhkdJbBiP10uL5/cZ2H+1bDayqVijVywEbC8+UxaFWM96rXC7Em5yyypBMyyGj6SSBN6erFlEf0E8/rvIyTyvDaHDldBfPFsQCmnX18fUMVkwW0P7NnT4eD8x4/CZ3N5nJ+twAjQ8tud/oW0Y043+jkqG08yoggrPxdgUKDB/UbiBcGWD55YM1ddfJS4Dpc8j0qZE2JWCdP1hFEii8sHxgzvVu1PS4QjsAYckjEeLwLJCNmbDgbyi2O581o3nkHajXd836oqCdOTAfUn8QmT+5ePYyPjvvJgD/FiYH038tFgvqsCUG41nsx4CFAJ01Yvhy1tijnQr5cpa13IV1Wt/TX+Gt9wSI7fTXWMoKg/MEWdZhWv7epU3nVNfQGb9bOyr+nsb3Ab1R8c/dQEdF+fS/YFlJP+SW520RQsGPAu+3P3QDTomM+UxWqgjjLnTkG41yGZg5r7zHHJcduB1U4HonLiTdyxmpdf/yp0Fn6OaRs5V6dJ06UGqki+k5fbnAOCCaxY8Gn5qJydwA0xsfNFGi0GlYCu7gRYSNqhe/oaNUxBUd4mzL0gFco2W/ZDlePaknSNCvq/+hPhVxEy+SKAkhYXXYsC7zK3956ru5OPt6gBEdtAeKdbtOciBq+d7FlJP7QsA7Gh2SjRrQuX6y/+Yj65kdO9jFNFbCTwN8nyEsLI1vOi3Rv9OSLE7jIejTHTF5+6WmPnGu0bcPEvx+Ezj2Bua6bH0ZpLqe+JZS5BjPDsnj5e5+6UV89
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|461199028|38102599003|19110799006|8062599006|15080799009|1602099012|3412199025|4302099013|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yV4utGYtv2ECN9z81Ar2hnIaxPMJIAnSrA2vSYJ64lbmJ3K/jtSlgJpWT8?=
 =?iso-8859-1?Q?mZVqZOS3gyEq3vENl80r8fJbgbSYuDjNaDXEY2mfvMR2RddASBHtaG20ez?=
 =?iso-8859-1?Q?BbM1wdW4hZFX8VHg9MMcqzEtlHuO3hMfyC4r/kJPe42Sr4ARKkREePascw?=
 =?iso-8859-1?Q?d6lWVswZbfkA64YyO5NtP2Yg2y4C3WVi5kw/juu+z9M0AWZ7m/DkzSRNex?=
 =?iso-8859-1?Q?szm9pQZtC5OI+BBITEO43I+mrDYUaU2BVpyBr71uqHC6IK2LHKVA2YL3dv?=
 =?iso-8859-1?Q?WQok+aTbxJ7qdgbiVPfSbJ5t20iK5zWn1RWGg9MDevFrd7g0Cx7Y7GDd0S?=
 =?iso-8859-1?Q?X1oR/KTR3aMc3jyagB674p65aEYUb80Hiza9k8vNEjOwFgG9VzJNuDceAK?=
 =?iso-8859-1?Q?9G14zCTSNVWSufqpHRpsRhQXegRCsvKmWW0rT3YHYA8K9/qmsECne4w3lD?=
 =?iso-8859-1?Q?5L5wpd4qhUipgEHZ4w17pRn9qaCFGeyCPmVSwaKIdhRlOY/yLgo5CTVr7o?=
 =?iso-8859-1?Q?6j6rnDaXL14Ksm4cdmgYhonV4ZSj/m3ibnRJd9ZX2dvqtlo5n9X7JX59u6?=
 =?iso-8859-1?Q?V8QEIcrQFiVH4HRpme2cACVfQCHiyVgN89H7ywtacIS48lltq9gTVuWlBd?=
 =?iso-8859-1?Q?zWwRLyzXg67RxHpnDqisZBCbHOVsP+PYR60/uJDOY4syxDrB4d0JKwmKxn?=
 =?iso-8859-1?Q?pLxWa/geMu/0IpZ/VFZRuPv4ZbKoHbaIBAiZwcUQb++Twl0BCqYBspzQ/u?=
 =?iso-8859-1?Q?zzCvVj38Ejuabl7a/D+iiJ2CW0F0LwEp5EYekrTysIpMF5bcMq0Gvkw9Sp?=
 =?iso-8859-1?Q?CBwtr/jG8j21tK6qglTDKYJ58WV5Xluy9vrj8lQbRvASnXYrlZcC4VSqr/?=
 =?iso-8859-1?Q?lff4D2EqECiFGHzI/x9e9zzMioNa3bB6aQQX5Zv63SduTEX39vUhslyY69?=
 =?iso-8859-1?Q?749dp0CjtBpvqovbP+tpagoe5LHRmoGI4WU/TnAeYasdLRVsYeEn/ICu+K?=
 =?iso-8859-1?Q?70rlJoGjYMGIxGA1HcgSZWwAOYB/77Iq0lV5ibea24qXH6w5BI1dvVceQD?=
 =?iso-8859-1?Q?qQDi9iXlnRm8IxGJ9NHfAD3mdhR1Jl0EV0NGUj7f2gUMQfMSlxM+xruhGK?=
 =?iso-8859-1?Q?nfpoNssQjG67wMmYHdWe5AxlcJZsVJ2PPjSDEzk0gpI/TMOD5I1oWpFrsb?=
 =?iso-8859-1?Q?6KIdKlHPg5rW702vdsM6gckcg0PcJxH8easSwnVkYxpdY741hGmnCISwxW?=
 =?iso-8859-1?Q?LErnLwo3Jve7qBb8/AOEqHO5GwzmbNs9K4/vIRrMbCtcR9br26i3ksZK1d?=
 =?iso-8859-1?Q?S+Zfw7DnW1ks8BrKmJX6Sd+Pgg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oViBL3Pkz8hdSOjg8PcF7Sa/p5kHuy7ePuqi4XjwHR+X3e6CdHBPBXWFYP?=
 =?iso-8859-1?Q?6lv4PoVCu4DC+BFUl3JeJlsb7aEFLmKwq7GUJU/aOMv/L9i/sXxWknP61r?=
 =?iso-8859-1?Q?daZAEvzvJCdGMxfNVLTxPW150mOuYmhL7LCEhd9E6uWAJbb46K40MHyVGQ?=
 =?iso-8859-1?Q?K2AWWPUcMO9vnUlM+IJjwreJgnAB9CeYCgTIPiTXUn7NkuQDPj9LMWy5q8?=
 =?iso-8859-1?Q?FOfgCJchn7G49viSuqhRGhJBi3q8M9mRQYoDVfoJ3h0uPvdZflX4hkeUZ5?=
 =?iso-8859-1?Q?dMRetpL1HWV64CgQnzhKEf+iQWjtjgb1mbtIm6akvTvpOTN7azXwqNiQhd?=
 =?iso-8859-1?Q?Y2TmuUWwOIVXopxFFaRVfmSflxJvqUY05vgj57lEbjGKF36S1G5Q8E8Flb?=
 =?iso-8859-1?Q?llg8iRfdd32/AdHVdsnAkwvk6Sbjl3DLSMxqRlxnCoJD2K5e/KK7ycP+mn?=
 =?iso-8859-1?Q?Vfh/WKdkee6oVWZdEU++WRu2SHuhkNSJMwY0ypDlpJ/yZU7GZYmhj7Gazc?=
 =?iso-8859-1?Q?W4KNyzLtYpEGJfD4X4z2TO3uAh8Emyxefbuh+4sq7SIwAuayOHhZsBZzEk?=
 =?iso-8859-1?Q?RSufwQ3vXMCLva5MdwVr1UDC1ORW/1Xizo+9q5xCCzwcl1FRCzqA144Bau?=
 =?iso-8859-1?Q?s+NKgNFcAWx9XEheGCPKYdiUV7HTRcdMg1mSiJjVW0ulC0/skJXh+K65Hb?=
 =?iso-8859-1?Q?YVwgODNr8OQq651O76IeVAUFwEzrlyGo2dnKnnqnRbFWEaMwDRUXR2ozcA?=
 =?iso-8859-1?Q?1RcSvJek4TL/ehw47TF1cM8rrLdFB3sC/Vewi1HEJSc1fSQ8QDZJYcsNxC?=
 =?iso-8859-1?Q?hahGJtBKIdrA78W1d612QlC2lu0OYnag7DIvXNaJw+4N0oZuwBcEGgReVl?=
 =?iso-8859-1?Q?cwZvWwNpBmJckB38bfayq7R7yOHCfojoLYL0ucoF2aUaHY2+I0pQnp/52v?=
 =?iso-8859-1?Q?KHL5mHJLKpp1CbU+U/sRqKUIPbKaYEIiayrSA1RZgVUokz6HBcCfK3AJRJ?=
 =?iso-8859-1?Q?koiJ9FbW0z7odkQYiiIr+JDjVD+gO1lrR3sCiHosSYUalGQfLrjVWM9Ji8?=
 =?iso-8859-1?Q?z8RPkw8GJQxpGr03sRqNvSQUXGsdsJLCTE2YIwHWjbW/o9iixMbO9lmMtb?=
 =?iso-8859-1?Q?WmqoaSvxhkn2+jZMcZ2V5IcpQQFZfDs1Xc8srm+8MKAZG33fM5h3wEBUI8?=
 =?iso-8859-1?Q?1Dse+rJ6jLlgrSjKln+9ilsdGW/B1nRjBcOnrc92gtV9IEQlxnLStogpu7?=
 =?iso-8859-1?Q?II4SV9mqyGjZ+XJPnAzhgTDi+BHPyC4js3rvQXg+k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e0d19d-907d-42e7-b61e-08dd9f6e51f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:37:12.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415

In a recent attempt to add links of email helpers to git-scm.com [1], I
came to a conclusion that the links in the gitcredentials page are meant
for people needing credential helpers for cloning, fetching and pushing
repositories to remote hosts, and not sending emails. gitcredentials
docs don't even talk about send emails, thus confirming this view.

So, lets remove these links from the gitcredentials page. The links are
still available in the git-send-email documentation, which is the right
place for them.

[1]: https://github.com/git/git-scm.com/pull/2005

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentia=
ls.adoc
index b49923db02..3337bb475d 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,10 +133,6 @@ Popular helpers with OAuth support include:
=20
     - https://github.com/hickford/git-credential-oauth[git-credential-oaut=
h] (cross platform, included in many Linux distributions)
=20
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-g=
mail] (cross platform, dedicated helper to authenticate Gmail accounts for =
linkgit:git-send-email[1])
-
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-o=
utlook] (cross platform, dedicated helper to authenticate Microsoft Outlook=
 accounts for linkgit:git-send-email[1])
-
 CREDENTIAL CONTEXTS
 -------------------
=20
--=20
2.49.0.638.g03d7d6a772

