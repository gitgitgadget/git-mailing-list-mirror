Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2106.outbound.protection.outlook.com [40.107.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC32E11BB
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842811; cv=fail; b=ei2sizLXxvIm25ARZ7MSwtTiueqN5fG1tSxJfmS9Eqwv45+WZ+U5/5XGhYVOjWSTv+vbCasLwb5JAWgaaKokeGV2wCvBKuUHsgJ1pt5Zs2Bw1XJdnDe+XonEmBe78XVAlY8nr3+MRtq9BYXmHtXh5tq+xvMM6fAa/F15I4OK1EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842811; c=relaxed/simple;
	bh=u7w93C6mTGLp+aBFTo+3xjfzHi+DmprxTcVKUI+4lJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKMxFBrQEI3PkWyK1KSWuubXXh9J4oaynzQKWB/r1YgnvJcWXSEjjFoi+UtSvNAsKRvQwp1k81EdTZzBhmefRmu9UnwOtR2z1GnLJuNnjh5Sv+gQkq1UKTnZqLiI6JhMBXFyHLe8i5+Jgx54oN1cJGwtXe633sv8RCAlrN9yVXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=D0eVgBzo; arc=fail smtp.client-ip=40.107.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="D0eVgBzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApX7E6yd8qOS9yHXDZd2MKidmlF2FOUJPigc4P5GYx0+DcH42N4JvywTU3y3S+7QLaDmZYi3S2nVp4iuq2Jg+sBO/rJVOCpw5COkY+7uTsmRl7UdMPC1M+BmI9OewKWf6fRQXAldnoUsE8UkJZQAZUmmRk60er2X62e6Z3ZETSEVAT2+ISnYW1bb4b6Lf4+/T4+x3QHqlRJ2adD9MmDc74t5DhdVDM3xfhx9lihxAk9J02gA2UDsvbQBdp1V5BFNfmaavWYUrUWliq3xGIjk4xfyPIu87RPDFTOgvLDO7HJiui9IJr/dhv65UgfRXr7cS3AzacYHzu2w4ktG2pVl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR5tMAk98WuWz+bFiTr3NkVTYmJXD9+vk+quFCrI2a0=;
 b=hdWHT+VRSWpIsczJIyWL6FG61Kv7UNfbiFcQhE08aQpOxpvjVnB0o+rdt3/yQNfc7ZqZNwjoWRbHkvutBMCrDDjYMsVvpOtUSlVjoII5Ucg5Axsj2AdYNS3V5+tu2rmbx7fRpSRENPnr1Fr/6miC9XM2nDAkm5wT35xHFJxGqihp3U3KPiOzOAY6ZPFrk7jIhLkeOf8o0wU1oBTWKeT79M32g6lJ7pq0jTrqj8J/S6UgRkcdGdwkfQnKDCsfjTQLhqMHEfbBlcEW0Vee9HkV4GLKTe/tbQpJdVDRi9/qgA/P6eXgOCLGxJzwYNl5iBR33kcx18KLpXGagbjOkLgrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR5tMAk98WuWz+bFiTr3NkVTYmJXD9+vk+quFCrI2a0=;
 b=D0eVgBzoQBHF8M15HBR2/oawCs+y3SZiaHomhwkV4HIjl6Kgcg+X9kc/UcRTooOriIwf4i20GMRr43McnpjC58csDZd71G6+1LjVp3jZ5KPDQ8Ts5xdjSCEeovdzRJv09kPi7G8rXFdUe+Qhrp3WPFjTgT+VklrbJxDLSPUD4Bk=
Received: from SA1PR22MB3999.namprd22.prod.outlook.com (2603:10b6:806:324::10)
 by MN0PR22MB5514.namprd22.prod.outlook.com (2603:10b6:208:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 19:26:45 +0000
Received: from SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392]) by SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 19:26:45 +0000
From: Jinyao Guo <guo846@purdue.edu>
To: Junio C Hamano <gitster@pobox.com>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref
	<gitgitgadget@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, Alex
	<alexguo1023@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
Thread-Topic: [PATCH] Fix memory leak in function handle_content_type
Thread-Index: AQHb3IOhQX43U8e0oEaowihCWzyL+rQBUBwAgAAaWcKAAAkjR4AABKmP
Date: Fri, 13 Jun 2025 19:26:45 +0000
Message-ID:
 <SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
	<44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
	<SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
 <xmqq7c1f8nr2.fsf@gitster.g>
In-Reply-To: <xmqq7c1f8nr2.fsf@gitster.g>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3999:EE_|MN0PR22MB5514:EE_
x-ms-office365-filtering-correlation-id: db707222-ae58-418f-ac19-08ddaab03bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?bQ8lE0h/EtNcSYebYNyAVy9t1ABxi32hNcWcZYAMCAFJRfPkMtZYDkFi?=
 =?Windows-1252?Q?VW7v2LrNF19TXSrYYkJ7iGz4MyoHVdbKtjsJuAmkauXAaG/J7AxSQPUf?=
 =?Windows-1252?Q?emkkxN06rg2jUL+3VI2xQq9O8b2hsjKQlcTe2A0WyyDqjQaS/yZNp7Ru?=
 =?Windows-1252?Q?kk7nDz1uUJVv9FEnty7+8h7IHmSbI7LKP3m91gkCRjHabkMOro6Tq7HO?=
 =?Windows-1252?Q?iYDEakKWQ20UpWr6rPb37ALjcF0lv1Yb/Inl8cA1AWZfLDXRPG47bOdF?=
 =?Windows-1252?Q?hXhN5hcq3xkpDh98nPvSPLOfIJt7lJ/1YwcUHi6MgARsuvTMqDiWgaXl?=
 =?Windows-1252?Q?wzlLVafsb5mX0YkDJeL87w7Nq682BEvm7zioxeyaN0KUUSeKlyHptNlI?=
 =?Windows-1252?Q?B6OD7tCFDpdpaOngB5nBggpAvW6AnzWN4unqBKpBdK/6hysFORuSZzlS?=
 =?Windows-1252?Q?G4Fonn0OaK4RqTLI84cc0KJZwQrzHOr07lBgGiJehf8SVmYKZwOq5hX8?=
 =?Windows-1252?Q?UtsSyEGbzwyhtLKux9C5FF4Ysx7b+8KvYwe/lSYgCxemRQZ6ocrBw4oJ?=
 =?Windows-1252?Q?mJ9lWrFd5zFoYS64DsPyc/OIQdJFmK4VTC93ppaFDMOc5u//bKNJToRm?=
 =?Windows-1252?Q?NeEp2SeIIj3THxRbu/IdQKim0wQUvGJk0+pb9wAq2PXYfYIU6Of0Gg94?=
 =?Windows-1252?Q?hu9Snsq8zXfEDp0YVJS1PEBG+a9X04BY+WsPYUEVhAGIQSSmcWOA6nVM?=
 =?Windows-1252?Q?kd3PWVzIr7kPGBSOXYAM7WLHSHpanPk4TPnbW/LujzFuxSguHcnRCONd?=
 =?Windows-1252?Q?RESXXeAQ6X0Lbi0F5jc6TWKtJGkTqoVTCZ44YdTtTEvnYR4Cfo4L3w3K?=
 =?Windows-1252?Q?bK/2EH6fzmomQ+lm3mmYJJEFHJN577Ptn7Eick0muIajUWogOIh4AsJV?=
 =?Windows-1252?Q?YZmbu60SQC+1DJ6B3rFuxP/uf+yYZ8akeSzO5IlSmz1VZLcYz9DQJ8yM?=
 =?Windows-1252?Q?Aknk7BGFipYmghox0TVduczvdlX3pV1Cqw8RUGq9jQIDWjkSVDfqQIHM?=
 =?Windows-1252?Q?7scN/uU6C3y5eJnM68UJYUrblkM5h4xXZm9NfgoRhIql+hi5i/nz39Ov?=
 =?Windows-1252?Q?kuRBjWMMG1UGmSmo+ZzuzB4GI1fCUab8kld8uzRStStQKo2TT0HT6+mo?=
 =?Windows-1252?Q?oJwxIUtWdgud59Ffyen9nrSiljOU9RdZPDMrWihNRHHBjTgAAbGRRHHI?=
 =?Windows-1252?Q?bAL8njNR4wwVuqSeytAGpbrYwLNYb7jwdTEILVfiO4WWi6MCKdzH697G?=
 =?Windows-1252?Q?q1ees6YyJ7JvYyGXqkISUGMQAK+PL3eXd6XEYOIHP2SMtXirx9pEu6aN?=
 =?Windows-1252?Q?dpvJ5DXaarVwqul5ggEyheofBAUw9DJaeaUFg074s9F0ei5KoT0cet4a?=
 =?Windows-1252?Q?UNb4RSQXjzk3o55Do7a7UMgQ+jo0lOUQsSbmoQ+j+lrUrSWv3+IAh5uw?=
 =?Windows-1252?Q?i163c8Cv32jIIivr/98BRpf1m+fdgOiD5CtiSVUeK7EIFkH5CfRY82ir?=
 =?Windows-1252?Q?ViKD+k1zv3gS2x+FqReXu6yQA70TNdFGcM4KMQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3999.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?6ONpkq6BD02bsL2DXUMpTyrKKV8IKgJMHifDHamooDgfb/PSu2iBTx1d?=
 =?Windows-1252?Q?cL80htej258B8TV3dYJJSX094ABZPA0SVWlRRese4/+esTIBI8FDptiu?=
 =?Windows-1252?Q?+k7cBU3rDJDLblCuZ6aHbu2o7AGD2KxxxF0WAGUT09bkynJ+O8yapzwF?=
 =?Windows-1252?Q?loxzo5g3XFER5X567Hn002o4s0dJH5VcCgl2zMVekwZOQHtxXfoheZBx?=
 =?Windows-1252?Q?+QXTwtXGLIV0dqihq3f+IFXwLnKReFjb7G9y/KPf0/ljvoWGVDJ77FI7?=
 =?Windows-1252?Q?22Ol9cTmrchyUGhwtwn4a0ycf6fbWPVkuKLc3Pa/+Po0W/Mzu9w0Tkdf?=
 =?Windows-1252?Q?YtlJrEcPy25Qcm70fi6inbDMCcrHHUFUbJXqgiVIcxCeOr5T2ZnQw0MW?=
 =?Windows-1252?Q?uqpwsHg0nj8nrf9JFBd+jX1q3W/JS7i8iOzhyhXdBH9fVjzLCslu2pqR?=
 =?Windows-1252?Q?uX1bO0uBzoP6ZGXE8zSVvlNyASg+bccxqb82Wynn//51h0FFwJMSNHCx?=
 =?Windows-1252?Q?sFUhWBBzrgDGQ+W6rcAqJ6XYpjPa4S0xESglCq6Bm2Li/EjaROkQJ8eb?=
 =?Windows-1252?Q?6lNYpvy5+Cy9lTFpOAU4UanifBPAPIPZPn0dXxwKoora7Yp951w914po?=
 =?Windows-1252?Q?Ci5X5KT12XWnHYt3F3JB28X+cyS0Xt0wmsCkQCFAz0WCj5xri9bxwR0+?=
 =?Windows-1252?Q?bHZ46IEOvOraHI5DhZMU4zR3b61NBMQq4kqXGvIdlme3Qg2DdE7/D/e0?=
 =?Windows-1252?Q?mFAYO8YrbPtJJQukga64G4HrzFZlKBiM+HtPuDH0ySDKCysTmnlfcmcR?=
 =?Windows-1252?Q?0Fs45nUXCZAr5F/4lCYyDoxDRbVR1Bmk0WH6/zTCNevD7ANaxC0e6J13?=
 =?Windows-1252?Q?yqC1ldu/yv5lEFrMV1biM0bKjgawTzr5eDN8+QyLVXpezqylzDRUMPUN?=
 =?Windows-1252?Q?/jUBEZpAMhx67JDDN3F79YZtZUGoa/iYkBK0t6khVd0U/u9me6epb7Vo?=
 =?Windows-1252?Q?94Z4h52rJ3048XkqTNmJJvEhPGJ3ZUG+FPRco3E9eUGhGcUt0bFr2yTe?=
 =?Windows-1252?Q?dm9DWyTFTrM2FrHymGAQef5GYV7xvaIrbSs40afOJIaXKP1OgN6BRIo8?=
 =?Windows-1252?Q?odB8YrgL9worJk6KCJB3MuHJgFhVD4Ce/x7xMjpKcoi1rJ7W/V6+sN2Z?=
 =?Windows-1252?Q?DyVrsUHwadUCqllkTEzzzlebIfn2dbjlh3OjvKMnkiEy0sdvQW4eVf1j?=
 =?Windows-1252?Q?uvMiuwJFMUPYKfxhGNodoZeqNzfos+RaUZhz7hY6ePo3kO/9QT8N3SN+?=
 =?Windows-1252?Q?SBafmjGMWftAqVGi9VkL0c3nTQ0iKWmUj5nnpmHTuCNfoD6R17BpNhqk?=
 =?Windows-1252?Q?+3aV/f3fWgl8Sxba5keELwo765Imyp0DoFaQJ7AVj6qsV3dNK9pi2MeL?=
 =?Windows-1252?Q?gvLmMb++XO/wCGgLqzHLijDAJQVZAz2qfk2876XLC+OhUqJJk/cazkn1?=
 =?Windows-1252?Q?01Q3KK47VnJmLxzNn7FjOL+WwOVw1m1W3zy/NJm2q1cdK5ujVYuOhqi5?=
 =?Windows-1252?Q?9n/fIFLJiHmjoV9lzc+4DAt9zJJYORNr2T6dYnQSeUqBRCXR7TS5mw9L?=
 =?Windows-1252?Q?6Gx0FWj9OQckWRLlKdlt+eMpkhFe/T7M7kAom84AmSLURA+PaQp+5P4v?=
 =?Windows-1252?Q?sUMxiadsWVc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db707222-ae58-418f-ac19-08ddaab03bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 19:26:45.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vs8D1d5XaL3oMgVJ4jKSRSRpcB2JGIioCNL1WRqhE+21Nn5/txpaRGuEOSWMIQ0r/OiJfmJHFILuLqEZNQhCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5514

Sure. I'll choose one account and use it consistently.=0A=
=0A=
Here is the edited patch:=0A=
=0A=
From 04b286cb2e736c3a53287b6ddf406e704f19fb2e Mon Sep 17 00:00:00 2001=0A=
From: jinyaoguo <guo846@purdue.edu>=0A=
Date: Thu, 12 Jun 2025 18:48:24 -0400=0A=
Subject: [PATCH] Fix memory leak in function handle_content_type=0A=
=0A=
The function handle_content_type allocates memory for boundary=0A=
using xmalloc(sizeof(struct strbuf)). If (++mi->content_top >=3D=0A=
&mi->content[MAX_BOUNDARIES]) is true, the function returns=0A=
without freeing boundary.=0A=
=0A=
Signed-off-by: jinyaoguo <guo846@purdue.edu>=0A=
---=0A=
 mailinfo.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/mailinfo.c b/mailinfo.c=0A=
index ee4597da6b..e0ea358311 100644=0A=
--- a/mailinfo.c=0A=
+++ b/mailinfo.c=0A=
@@ -266,6 +266,9 @@ static void handle_content_type(struct mailinfo *mi, st=
ruct strbuf *line)=0A=
 			error("Too many boundaries to handle");=0A=
 			mi->input_error =3D -1;=0A=
 			mi->content_top =3D &mi->content[MAX_BOUNDARIES] - 1;=0A=
+			strbuf_release(boundary);=0A=
+			free(boundary);=0A=
+			boundary =3D NULL;=0A=
 			return;=0A=
 		}=0A=
 		*(mi->content_top) =3D boundary;=0A=
-- =0A=
2.34.1 =0A=
=0A=
=0A=
Best,=0A=
Jinyao=0A=
________________________________________=0A=
From:=A0Junio C Hamano <gitster@pobox.com>=0A=
Sent:=A0Friday, June 13, 2025 15:06=0A=
To:=A0Jinyao Guo <guo846@purdue.edu>=0A=
Cc:=A0Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>; Josh Soref <=
gitgitgadget@gmail.com>; git@vger.kernel.org <git@vger.kernel.org>; Alex <a=
lexguo1023@gmail.com>=0A=
Subject:=A0Re: [PATCH] Fix memory leak in function handle_content_type=0A=
=A0=0A=
---- External Email: Use caution with attachments, links, or sharing data -=
---=0A=
=0A=
=0A=
Jinyao Guo <guo846@purdue.edu> writes:=0A=
=0A=
> ... I believe=0A=
> the confusion came from using two different Git identities.=A0 I=92ve=0A=
> now added individual =93Signed-off-by=94 lines for both accounts.=0A=
=0A=
Please do not do this, if these two are the same single person.=0A=
=0A=
Instead, pick the one you want to be known as to this community, and=0A=
use that consistently while working on this project.=0A=
=0A=
Thanks.=
