Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8B548EE
	for <git@vger.kernel.org>; Mon, 19 May 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659198; cv=fail; b=EsWbIAG0DHbFDALUL4CdTEh76Odul0o9yu64BEr2JJNtRoyYln3lHDDmQbTmiB5haWP4zjUbUswPp7KNh7rNHToBsWxVN5Lysn00OhgDdy/GIqis/isR/ZDD9Olr1giSfm09ahw+jZiyQ3SRcSf1PJWzyXa/gH/UpJ6B4sl4rrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659198; c=relaxed/simple;
	bh=4osxrKODCtsmDWxSOZaMIpE4tMdpI8VYybZjcB1Ws9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCB+av9NfxBkFMU+VdkwuxroU4ASDzHrGWwvLOWC9SKxSDX1J2X9QwGhpUT9NsreTulwAT0y87HyK/6ocliQrTA8sobgi3MxQSAyCMY/ONmv2tcA3ofZiSZ4i1w4dy4BkmcGrtmQoZu8spTdwVgNTpTqF/fmOy3eClZfo4Nckr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t+YJZL0f; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t+YJZL0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDcn50YIOmzxd4Ljyc03GGZfHAdM0Hs21A8/X3v6lYhVAtWXNEbuNO1BIaW+JRJccab2KxEb+hUoXqhHFAXlAUCAlE7ep/bCOrJWPUO203kjtrdAAnZepKi5quJU/+y0obCR1/iz4bDnCrhkIo3D9YMMphN58lITn7KnWdf0UB8eN28DaAneYCLo7F0PbEcpCB468aCvQKSiz8Dvz0V6fFEiEpAKD75JIMNTwFDQNejgX6M0IVVA3Vn05Y5bD+/oiB0+WhzMlrDjvndWLl746Qhx+UeKNKXn9Rw3l+K78T1/am7wfmbBqe8t7spsUa1aQobhLI9Dfwu5el4wDPaPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj+dJCEFxVYKcVW82werJX1Hi5pqYezUQl5f6bOpZuc=;
 b=bdmCKIQ4tkPMqVUnnT4wim/UeO4jK/h5dqugzR+A52rnsT/MDSioVUcixGBFKzMAeF1XnealyoN6RGYgw+VZkGQifrJiJr2ooSY6WxJjkQ6OGFew8L291T+MzZ1y5cZgLJMyCacDFbe8962stzJslBo4VEzO3+oFJJzW2fwXOLhvwXWzb0fS0mZejVEJ3vnND28t511yU7Kg5EIIMudD1OP7qB6jP2eN7tEap+kE3JQiJ+ZPVAfrSawHeqo7I8anJRgyd+e5fqc6oj+TklpByfDwXE1X/Ul24FxHPO8xpUIplriJv1asbRGwrNauvIqGd4ChzivhuND69WjHFlocaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj+dJCEFxVYKcVW82werJX1Hi5pqYezUQl5f6bOpZuc=;
 b=t+YJZL0fld9OV/ILAh8nP4daHUGFUtbf4IUWWNY542dolJMdAWvpgayVPBU8uXx5A8CxevCKjMsNyrYqpSuhV1f+uGmEX4s6bmy+GwMO2TFSrwEfLj7W01kVRlp5YNEaMqq1ayIf1RXFQ8uWi+2rSCTlyg+enQXtfSV429reLWaLDKfn1uqlKBKCSaC1QCkPa6iZyc6zfWFFZywWrvMWlTTahLNNEhPDicZyBKu5ZPl+Ikv4UarEO02nxBuAHaGMiQSRxx1ABxixUpjoYy0tkaCbt8uwxvjGPr3MavFt6vmU+WXa3yAQZudR28Q4xNDv8kPcvUMSaKfEzJLeQ/6VIw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:53:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:53:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 3/3] docs: remove credential helper links for emails from
 gitcredentials
Thread-Topic: [PATCH v4 3/3] docs: remove credential helper links for emails
 from gitcredentials
Thread-Index: AQHbyLz67mRnLzxxV0CNdudtoAHO6A==
Date: Mon, 19 May 2025 12:53:12 +0000
Message-ID: <E988D11E-04BC-4126-A1EE-B64F79412161@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <A84F634C-3423-48E2-B648-068A75423037@live.com>
In-Reply-To: <A84F634C-3423-48E2-B648-068A75423037@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB8026:EE_
x-ms-office365-filtering-correlation-id: cbaf5be0-63a5-4a97-1fe5-08dd96d41d03
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzZx5fYXqP7epOz858UK+BQT68MrkJ41VnOq1XjTgxFgK1uJ8mNtkhHUjNybOmH1ChsC3FxBA98sjQMaVm9+Mg4K+Nr/wQvEk4dTSfvDOQK34Da60HIE7hF/iAaBf+vXjvfs1td8mTtfFzL6TQFXPRvrHNIUbwwKEzlsttNLUnA9qjOYcSUDX/0ginFEH6nfKZ1Ffy93XY0Uq7eWqKmaFc5fvH0hSdgInI6xx5wXGMBnvQJvxVw5TugYhMmxqoLAqn7Y8Xq7G2AB6EEObQEWOCge7vgD/tx3X8mFmYL2z2Jlzsn72wylJGxF7etO8zQVa0S4d7q8dd8DA5gb6JFfXaJaiOKOo+ACkaD1HzjGFXuX/rMpQFOIfjs1DAuiK3xRsvGHLPzT2IrSSzDy/RAhOz/Wr6kDdTy1sKL3XdDfrJkrUnEaEDZB3L+SpDPv0EFuPV/aD6KUTwQv2HdH6vJ4O2R05Gk0g60tm31+YQxdwUCJZcX5mlBE0dVSkTA9ZosReLAv3273bhN8dolKA5z5y3GG3R33wekUQxjUUnUSAIo8YmWx/eyJ6wnYz9bzx09Rv1iXIB36HHjKOPwnYB61shybkErZPrfOXopnwOExzN1KyapCZlTtoMuzciSJhZ4hocDaXvr2G8Pfx4GMPsNGA3R1gSD91nJg7jvgax3jrCz/eBLqiU6L7V5Zxm4fMNM18ux+tvPaBE4n0nl5srXCelvuMhdICLqlO6Ya/Uga9bEEcOp42FZCPFOFzaJbiUcIExp/ibxl9XYCQiie3ucHG+bY
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|19110799006|7092599006|8060799009|8062599006|1602099012|4302099013|3412199025|440099028|10035399007|34005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/BDAXQqWMs1nTieehhm2haBZi56tWa2nK2g3iRJZKPTIIs73cLXtiAR1j1kS?=
 =?us-ascii?Q?A2+iUFIcDjsNF6NC7xQXi9cLN2rboVPqgw3HZsr5hfuO6Cx51Ke3zhrWKY+T?=
 =?us-ascii?Q?gYX9nlC0rsWDS2kwyT38oJmRnLK0V7Up5BRgEYCfG97fq2kT4nxTzPvoQkiL?=
 =?us-ascii?Q?YKXeyrpT1zGumQXO2wtIThjXW3MUqLoP2M06QZC/IuJBd2WW32M13Y7eml7B?=
 =?us-ascii?Q?YPQmZGbNqcgmM1LrwJcoCTxQqriKtt6KPH4CAEibefbojYgBhdtEWHTdQwor?=
 =?us-ascii?Q?35gr48GJLLUKSJegFtnlqbz1sqZKIjpx279miW2+wpm+kczQPWpC+BO39E+t?=
 =?us-ascii?Q?o8qYexwqop6yr2MT9EqTV5RmplfVDOZm7sK3RfYUANN/Dm5WayGg2/CQWfHR?=
 =?us-ascii?Q?FqyAyIx1CuJ4J0anY6ysoh0LxcRLmmsoMx2j6XmRubqEIf7TTw9LJYJjpy1p?=
 =?us-ascii?Q?fbX6/ILrEMF85Ux84ah637Da++GAedMEgsP+AXYw+FWWk12cwMqp4adhbOcl?=
 =?us-ascii?Q?1rmO8US2m3Dkhj7yu1e3fScJIZST3lnuja9MIiRTnyAPtXLk3WCgH7VmU4JM?=
 =?us-ascii?Q?1JH9KIopeyYEmIcAMHfVrAf5YqfPSO/7B84vOXz+ikoc2prudvPO++EqOaTv?=
 =?us-ascii?Q?pZ/AWmluNqRiVcV2ZRFydsr2JV7pH2EbfQyqQ5Bto+0vSrIUa4Iq9/Ax4PhR?=
 =?us-ascii?Q?zTjFQIptygMs6B0wWlSCQjItmUBAZf1PT1i6k/zoWRx/AP3ZB6WGa2e2SLds?=
 =?us-ascii?Q?tdj09zWJQ7yuNICcQ47+2QVX5qxfelrnT5t33I6869T8MKtcEMs0ERvLIZcs?=
 =?us-ascii?Q?lpIRPydtL25b9zadQpvWn7e1SWJx9mThdMMQkYaXJ2cR5pOFtWgwunB6pG3N?=
 =?us-ascii?Q?8rs7AO1RV/We11v6eXfOOe3AXQjlLkRFDfiaApRpJGyw2P99PCOjQ7bwBNIt?=
 =?us-ascii?Q?Rv5fXGFZiOIBV/rJWAS/3kvL7hGZRrkuhkLug3A4+hd3gukQsKcY03UacJYY?=
 =?us-ascii?Q?Zhncrz39XjjH0yPY3q3nd5nQ6yipjmnFERsiIwCvbK/q2x76QiIBUYP/usmE?=
 =?us-ascii?Q?gFhiCoheAEiEIWEeRlwh0WitUSvXt02/G3BQo9/LLft/oAmnkOIyzQymmSWZ?=
 =?us-ascii?Q?9HmJ5k0cNOlTHmOppa9AJW/jMtmAmdGSnUK2HMZSsw/T7wtKQ0vQRquF0q+u?=
 =?us-ascii?Q?yT614WadkL5m8ZQu1xEPH57mno52P0FYgiBhapiH23qjuQLNsCIZLW9XHEIK?=
 =?us-ascii?Q?ySA5qymUEE0sh/Y1975pqqbhnqMg5qqqCXaG3eOKNw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h59wEUa1ktEQwa+gi+gmIaPKZG5dVbWbVH2kLs9nhf2w8OzEjMLw4yhW2243?=
 =?us-ascii?Q?A05DFY9Mza1e4NMc2LPAT8MrDr/kD0ZEBqlX9CqHxZNgTCqNsM6OHoJPXhRL?=
 =?us-ascii?Q?kI2Gn/ylkVRFlv5n7QPGuOYkJq3QHDy2+2rhRnbkVO/Hc1Hlj+2V7NH/nGvg?=
 =?us-ascii?Q?iGqY1Wdi17etPfmy3NChYtEknLqp53mYaduA3QP22jVT1beLeTxC9xdsscm0?=
 =?us-ascii?Q?ohwDt/NrxZcwt/3W/1iNOzSYqupWXxMsxOtdxXVN+sBeKscA58gwGs2Sajpv?=
 =?us-ascii?Q?oY4T3+pitDUnQmlsDb/QR0tjtvusXC9Ab8qv94zxN31urjBiGSChLTVu2+N5?=
 =?us-ascii?Q?C7p7si5ylGvy1zInUV7pbXeOzpI0VgXGyzkPyYZCLPAk3i3QSUpQrNH1hnlA?=
 =?us-ascii?Q?5gYGXC4azvY3ddvEu41ujQY34Nfkhbu5TNF0KAUdhOUHesIsAdsTG4P87J6d?=
 =?us-ascii?Q?OSjtDOAAPa6ytc6ibhsB7LwbL6JccL6Ov0oD7IvOT6d4kgUur6r/WoRJT65Y?=
 =?us-ascii?Q?B3uPbt3bHx4q34xhLf+IA0VtOSDnzItVNhpzOgDcAUjPfIhF+m3O69Y5HFqI?=
 =?us-ascii?Q?Vd0fkI1g1j4hiT3wHpD/RD4DfIhE4Yi9iNNHSPGTGnv5k6qri0NASJFBudub?=
 =?us-ascii?Q?WVvXnM38hzMQjh/gAPLxwaxztkticgs+tqNJFbNWEY+Elxk0Rc10nkkCzti6?=
 =?us-ascii?Q?qRz6f/xwa2vUD40UIAN/i5NxlTThThZmB8FiYtgMdVYENZ1ko21JqcP73yHH?=
 =?us-ascii?Q?/lc2GjIhv6fy2JuVJU53kvv5pAEyRSun55owyUG6qNFyLm1dEPYuk9vQ1lnH?=
 =?us-ascii?Q?28o0BpMfSTVKaWaqrCL1vv7jSnPcwcmBVwV7AHwPuHstYnX4m2qXzlVj/IHE?=
 =?us-ascii?Q?U9UDydt3LgIOnlMuouXWJP6+K9Z8pVlh6CVHG4ns1vOhX4r41SUjkx7G2xwr?=
 =?us-ascii?Q?kGQoSdbGDIZKUUNkDd2Fnx8mnFK67Xvxf4Itm/4cq9sbUHGe9fJjlcCnz9Ex?=
 =?us-ascii?Q?JGe7mITZX2byHxwC8FSqumqvZcXZ5jUmO0szVurd7KtEw2d47ElyQRzOruye?=
 =?us-ascii?Q?NTTOImI/ngMSnWugQGdwnNfNmlECXyngCscSZ5wsRyOGJ61JcUSp3AtuZ4Ym?=
 =?us-ascii?Q?Gg73k6Og5ZfliVPwk22tErNV8e57G83satWde3sNR0xJ+dSnzZHTw72uX64U?=
 =?us-ascii?Q?0xxslOvmQYncqp+k8t1LyULFiPLQeBJJqC4jOqgJ7ChRwzSPvLJnMACGEXbc?=
 =?us-ascii?Q?0ljWv3yno+QxT2/rpD/5w3dofyR4Qm7JNrUKfoCepC/phn+O+mDmsh3tYCHF?=
 =?us-ascii?Q?M7WCj0DJ2VCbpKQggbabQkya?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9679B559B3CA4A4DB108E5EEDB23613F@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cbaf5be0-63a5-4a97-1fe5-08dd96d41d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:53:12.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8026

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
2.49.0

