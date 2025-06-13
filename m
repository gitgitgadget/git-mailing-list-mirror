Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16588757EA
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749839807; cv=fail; b=NLbVO3z8aWVsiI1hXvYy3SN1cC+flDZoCl3x5Ub6EQTElavvvcAs50/hSgUsPOJySK72WG6XyPf0GrIxo5GdeuTzE84OzqZcfiWVmf9oBqo85sEmbo8gXb7fl/LhfBtOkx9bEh5M6X6XnE6OJbx+ofWSSZyVeCwkg4YvNmJKjpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749839807; c=relaxed/simple;
	bh=sl/x4pxZiUUrzzUn2uKi2bnAvy6J7UlQ1P51oIQvuMk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GryKiMhRzNEir9m5FnptOllMrKWaUmyv8jQLHo9wAh9aOgIZlJO42rwv4umqc1o6e+6Q4yKm7z1eZruENledUtGkUpgbeCJ60+ycMKIKs2gs9V/TByt4rIMg20gylOznQoy7GSQbqM9bJ7oN7OBLdKD3mwyKBdOLqGCVt6ICH60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=JalRQHjF; arc=fail smtp.client-ip=40.107.237.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="JalRQHjF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljj1jW5AqDQaUcfEmL3x+j/EWsckxMpabCcTCpI4VorQtt3Uf6G4ULS22rVm10UYKpkOwlAyeAFhcljuYMSn+j0k/RPHOc5ULEnlGobXASOTgH7IV6kL9lP4uvd49xXeyTL3VV5KccVNV2o3ZthA1kmw01/JnbqudD+UBAFvg31jPbuIFd3PqEkD3nMRCR1d/1nqBUPQ67TC6Rtbgs9Vewo5PFUDWbl4EbCLf0BDQ2tuhZo/bxOEvlr7lr5tN+fy3f9cL/fK6RDeMT+XeY06Tk41yXDvOOZ+pB6xMt8NU9lMvO5ZtzBPhHbF5iTInVvn+T/G+mKQT4vlrZJvyUPnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aR+z4364tfBsV6Z1lZRaNpOSMbpk0qF5+N89GtRu1E=;
 b=xzMAD2Z4xkpcoDLBDoYTnNJGtpwh7Xm1Ue6te1lM0sZrEOO52f+sD+aFlDg60m/BLPEbSereqJLYWJqMeVmlB2C/NCoSgpzBhRhUbdTm5nfovsxhjM8egjvhINEmrZwQeLB3IZ9UwxQUNG6ntA0dm4CNBe32hwlYuT4F7999+iMVQ3ct6QIvmW64/PTW8Lwuou1Y/JdehbGSFmY3qHNlWlLfKBZeIYP0SS3MrEdpyiW9z/tITNDfYTD3Cep+axPikWxMNX7IB2f7J5p0KL5to7LZWvpId53o3TY+TpHuEgyQ2QjbLwh1X8jLAbeD5AQ3JEpoUUgYjJcWcAhu/P4Ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aR+z4364tfBsV6Z1lZRaNpOSMbpk0qF5+N89GtRu1E=;
 b=JalRQHjFvwODkd1ywq7qEYzORAyuu3BRc2tLShoZZ7F5/vIjWihC4F58q6DTXfYHgh2a4XFrknRnUQWoUxLKl5lGxE7I6VqIZyL6i6ie/sVGMoVFu0MRGiZatfBnrKjV+lrOdLKB763rXP7TwHWpKs+/1UbJ/4mHTyfFjYj9nuE=
Received: from SA1PR22MB3999.namprd22.prod.outlook.com (2603:10b6:806:324::10)
 by BL1PPF7E7860BFD.namprd22.prod.outlook.com (2603:10b6:20f:fc04::f36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 18:36:42 +0000
Received: from SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392]) by SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 18:36:42 +0000
From: Jinyao Guo <guo846@purdue.edu>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref
	<gitgitgadget@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, Alex
	<alexguo1023@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
Thread-Topic: [PATCH] Fix memory leak in function handle_content_type
Thread-Index: AQHb3IOhQX43U8e0oEaowihCWzyL+rQBUBwAgAAaWcI=
Date: Fri, 13 Jun 2025 18:36:42 +0000
Message-ID:
 <SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
 <44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
In-Reply-To: <44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3999:EE_|BL1PPF7E7860BFD:EE_
x-ms-office365-filtering-correlation-id: 185104f4-8b87-432d-4661-08ddaaa93e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?rUTeoymPFhQLQgTpKpFlt9C96O9wRR4P9AurbzTNUqxNkU0vbbFAaeMy?=
 =?Windows-1252?Q?yjlhPVPBJzKvVgBEmQP2lL1U0nXDNQHsX9LiVz5cArQUa3RszzKTqw67?=
 =?Windows-1252?Q?beVvlA06UNxPHREbBITnCePLfyPRwMC541xpZDS5EokS7porgRFyAVe0?=
 =?Windows-1252?Q?08wanKxatjYhgmKnMYRZKbMgQCBmsW0TYcM7HyRFL2vybrkm+HEJqFx+?=
 =?Windows-1252?Q?bk1V0Bj7Ya60VdMhGAu1XJRLSzIaIugo+ouFOo4bFi86UT5kJsFP5vDY?=
 =?Windows-1252?Q?/rfUmy9TAoHwQDRvsZvcO26iLfaJaDC2ZdqWbOhZiADoj/wRjj+kFzcZ?=
 =?Windows-1252?Q?O82DtHny3gfEZW64U/Ns/HPD5VzEjnfb/QIbryGxEuMcvmWnx9ynFzMg?=
 =?Windows-1252?Q?OAsMXtcbLPkxEfeTn0UkjgNQ1bouLaPZbrjLZqfencQ++LLcT6i71Gzv?=
 =?Windows-1252?Q?2SIZA7HyT1ilT9JjuRnkNqWiizOQA7dbB1XH0HRORugOxLRqDjwXjqsh?=
 =?Windows-1252?Q?Kjd9jVQIQdLhps0v7ZvIhGiLW/g/EnEJu+hQiNKQgkeSV6wm+5AIL/UO?=
 =?Windows-1252?Q?SLql6HwvwBwoHWbh4np9ZqKupqxTPUzTZ5h/Uv9HCZLgGKe9EUcGOavM?=
 =?Windows-1252?Q?Fag52/zk4gnCr8VYPubepQiZPwVVEdSEbeZo+rScxrXTdUIGnZTSMlT4?=
 =?Windows-1252?Q?9o0yMNSaPtxaRd4WbxVyQe1YVmY4+fDUztjNpZxIdqMSzZ8yoNd3Z7dI?=
 =?Windows-1252?Q?8quGF5QQjPeGHzngUfwnclBAxEz2Hu+h3H0APX9J1Cft8zJl09ClSI7/?=
 =?Windows-1252?Q?fswl0/JLOIBzbk7Ahnl7eZo2oRVz/scWHRqLh6d/c7qUliDDbimQoBnj?=
 =?Windows-1252?Q?XB1AVYgW6GJGvgwaOhmgK5PHX247g+F+p8XlfwS64b+3+SPRihKQvSY6?=
 =?Windows-1252?Q?rQfh8njOlG3JsiABCMFoe65Ddz8ONCoQLCjEr+godHOrxbrvROAqHQsx?=
 =?Windows-1252?Q?HQ/8GQFyHTjwYbgJ7nBCp8VTlABmUQr7JLIbTWVZvBIxPqd3OFLWe00H?=
 =?Windows-1252?Q?2Kyk3mbP1KC1UZMlPhAQ5ui7aVsyQLY3Ltss2GvmpMFM60xa2SG9Ie4k?=
 =?Windows-1252?Q?CtPwwzJYg1XM9/rrYjiQ/5OmsHytDGhUXuxj7HvDbgkIezbi7DjASH36?=
 =?Windows-1252?Q?4KYM2Tj+2VuMAfdHuZlhC8QDxMumhfUs9GCWYZMWboI9C5KNqKenCYAm?=
 =?Windows-1252?Q?umh9/b7Mzir/K+Mk720by+qLzdgJ0irVIqVObaQJr0je9piHRHZdBYLU?=
 =?Windows-1252?Q?Fu0OkUgseYHfBYRCxojOkERVg8Cg/YG9eQZv9x5DsUtQaU1EWwFTRHlV?=
 =?Windows-1252?Q?fnI0P/OgqGlYvuUMgw6VBYMHigCXKiP9xSuKn0oWXQ77qi8+rdws75ss?=
 =?Windows-1252?Q?I1R5IjprcFXbtZuMocW4ctW+srMCpMfOJYmFf7WESsQTz/rGkmDhkWQO?=
 =?Windows-1252?Q?y3UPQ2B1qf88sUwdKjU9ZlrGO5UKxroUh4NWDLUtxrjR8rC788YXzmiO?=
 =?Windows-1252?Q?2r2UqCFEaCjoictRerrwD2ATgvYudobmX6WQKocH8f57DFMj5yjwvxJa?=
 =?Windows-1252?Q?bqw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3999.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?oCVas4Ak8E0TSa3lfXLNJ2YFMRyuQrmtidqsiPRNY1rfRAC3mV+c1b8E?=
 =?Windows-1252?Q?eCW0Adft+6GEYXstS+dlpUgB6NRXTV9u+vxHCrLHfiPvVuutFW35/63K?=
 =?Windows-1252?Q?CzYVvMf00hKOtHaou9WHzkGoA0qxpayvmr+QKpl7oc578CjG7Olzqm9I?=
 =?Windows-1252?Q?ME3ES2+jQIkU5sYtNQe01Ea+DRhGihbPaio14DGWx+XBbEONihH35mRj?=
 =?Windows-1252?Q?IZ0H3py2+ewONatvL/Kt5dGkK8IrI//M9l8PhNdcE9ce/RpdAbvQsNcq?=
 =?Windows-1252?Q?oQs2wzWi4KAY95Ac05uwPNDTLgQzOisOkegcMDhfh1bV418ijzg0UvtF?=
 =?Windows-1252?Q?JpPIN+WN+C3wxkkceFNxzZ7Srx9rw0yRoymPCHF0CKCw1Xzax/DxylJ9?=
 =?Windows-1252?Q?8UiNgdSRuB0843CbNybt3T1u6hWjKUZeMwUVG79GHYVQdaAbkolqJlJD?=
 =?Windows-1252?Q?22wytSRCWGgemYmEVmfVSfwOy2XbWeGYP2b0qW1FNeiar6NCY5/B4Ynr?=
 =?Windows-1252?Q?C3rNXuTBEpS0KKU0FU9dL9rjJ/yrriaGhPluweW3LH/cWcqICUob3uyO?=
 =?Windows-1252?Q?yTMwxdcZvo+wkZMs/nvxQZ0S1GZ9SCEvoXtGkrg/30O34jRuQYQM4ayN?=
 =?Windows-1252?Q?lLSF3FEknGVGlkY3ojEWiW99l5FNVqtqZFbvEmugPkiksGIIEOFuJ3dp?=
 =?Windows-1252?Q?q84O/uwKHvsux4gHlCCjSHi9tAJHCm4vDYKCYotxs+63ON8rutMpfnoy?=
 =?Windows-1252?Q?CjO4KfemaTJDEJG2bbTziKai27a/T9/nxXeMdlnkSGEtf0vvJ5q4McSu?=
 =?Windows-1252?Q?cAvVgly+6wdr1hzAGA7snuoAV0rv1NaiLP3poapPicbXTwOu15wU5gcB?=
 =?Windows-1252?Q?WL88x8SyfasIv9BofG9aKxSsynPzYKpltBVAk/1CUrgpoZWdRGJI3Wi1?=
 =?Windows-1252?Q?5RsoC+TcX4ouJoQtPM/CxdkzRxIZHDr9DuzEFKXQht5Dv4O7nNSlhL6S?=
 =?Windows-1252?Q?OGAuEYnk1IsND0aIKMuGy7dgo4n57hKachrOQmTQB8w3OTcuOGqs5zZu?=
 =?Windows-1252?Q?mWNLzjrsN/J54BIEgrtlKfeYSTpQ9QtA9Oz8ytsEJ2YuwE2+Bw0SMMgq?=
 =?Windows-1252?Q?jswrNHEocFvJHbGm/FDtklNrQ1MC3YAycGhRDaUxqrBAK4yn8RsJXLf+?=
 =?Windows-1252?Q?U0w8j9cy2ybDBr5rts9s4P8oiGjFhvkeEjBOeVST5BdCfFHUHDRtltqe?=
 =?Windows-1252?Q?IWGuqebz2fo+RtLZgMvtobJ3ywdNp3hORtMOGxBYW/d3q4WOmDJPGSCE?=
 =?Windows-1252?Q?5xctJb30gsCJ6IkAa8mRrADL+poERlIPyugno0Nlw79EQMFeNyJCwz47?=
 =?Windows-1252?Q?M1x/VlJRNwFaGE1R70k0HkYk1jSyTX7v6XMPGQ5XdzhvcP8CVOVTWbfi?=
 =?Windows-1252?Q?O94yM+/8SGI9lyBBUARY3JybUkHvrO0+mX2GIGCbpGyqpwvG2iGPNeqO?=
 =?Windows-1252?Q?DErP0e/J/WhsVSEbGP2I1CvZ+jpIbOL7PETCAwqzuokkqF0qI9ssNd8o?=
 =?Windows-1252?Q?ckDJK2jTn8QjdCyxTW8ORdEB92Y+3CoZQxxGoHgWVyw1QwBhHhIKXphx?=
 =?Windows-1252?Q?4LMqdUBGamERFbi+jeDFIzPd+g8LsgJmIad6b6fpZPEK4KSKzUwApQ2Z?=
 =?Windows-1252?Q?+aVxyT9i0Yk=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3999.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185104f4-8b87-432d-4661-08ddaaa93e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 18:36:42.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1QxSLPXzpstFSnuFDfbuJE7Q+hvJhzvqvHHlo4rySe79pKgo1jtAx/CNv6GPNiL2DKfEnkVI4iuZJSRvgWpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF7E7860BFD

Hi Kristoffer,

Sorry for that. I=92m still getting familiar with the Git patch submission =
workflow and missed the sign-off requirement. I believe the confusion came =
from using two different Git identities.
I=92ve now added individual =93Signed-off-by=94 lines for both accounts.

From b39b1a8176a344a2fa2c46a6d0ffc27a7bfd9edd Mon Sep 17 00:00:00 2001
From: jinyaoguo <guo846@purdue.edu>
Date: Thu, 12 Jun 2025 18:48:24 -0400
Subject: [PATCH] Fix memory leak in function handle_content_type

The function handle_content_type allocates memory for boundary
using xmalloc(sizeof(struct strbuf)). If (++mi->content_top >=3D
&mi->content[MAX_BOUNDARIES]) is true, the function returns
without freeing boundary.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
Signed-off-by: jinyaoguo <guo846@purdue.edu>
---
 mailinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mailinfo.c b/mailinfo.c
index ee4597da6b..e0ea358311 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -266,6 +266,9 @@ static void handle_content_type(struct mailinfo *mi, st=
ruct strbuf *line)
                        error("Too many boundaries to handle");
                        mi->input_error =3D -1;
                        mi->content_top =3D &mi->content[MAX_BOUNDARIES] - =
1;
+                       strbuf_release(boundary);
+                       free(boundary);
+                       boundary =3D NULL;
                        return;
                }
                *(mi->content_top) =3D boundary;
--
2.34.1

________________________________________
From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Sent: Friday, June 13, 2025 12:59
To: Josh Soref <gitgitgadget@gmail.com>; git@vger.kernel.org <git@vger.kern=
el.org>
Cc: Alex <alexguo1023@gmail.com>; Jinyao Guo <guo846@purdue.edu>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type

[You don't often get email from kristofferhaugsbakk@fastmail.com. Learn why=
 this is important at https://aka.ms/LearnAboutSenderIdentification ]

---- External Email: Use caution with attachments, links, or sharing data -=
---


On Fri, Jun 13, 2025, at 18:52, Alex via GitGitGadget wrote:
> From: jinyaoguo <guo846@purdue.edu>
>
> [snip]
>
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>

Like what was said on another patch[1] the From and Signed-off-by names
need to match.  I didn=92t see a resolution to that?

If forwarding you need to add your signoff after theirs.

[1]: https://lore.kernel.org/git/xmqq1psfxgyv.fsf@gitster.g/

--
Kristoffer Haugsbakk
