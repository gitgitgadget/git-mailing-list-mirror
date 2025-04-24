Received: from esa7.dsv.c3s2.iphmx.com (esa7.dsv.c3s2.iphmx.com [216.71.156.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53C7E0E4
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480096; cv=fail; b=LemyDgz6/e6hVIKldzmpMTJTjw/ul1yNXL95DrjTh5mER1PCzowlrMPkyj442M/BpL9lCK8fWWPI66vD8bNzDmXLOBZZu1wwo9Mg0d10D3MRLtNbesWxe8J7IDbPkdpdRPAqg30nUBZVhv3EncEtATxJxWiGt/3yPtyxB01Ft1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480096; c=relaxed/simple;
	bh=DAg0dzU7xQu2zbQCmxbZiR6/V5k5ZEgdBmLi5QeDSSc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PlTi1QCbWH9KSt2Rmws/c+NyqLdiBZN3G9N6wC0igbsOqsKvNb64eRsfJPNDT9iY7FKRXmBoVxpsBm+J64jfGkgyIG0cVscUmPfGR34H/wMBGVFWaXwJzmjyazqNIxIDt8vd8rvTWgO/7hYUyYYIgg8V5xj0ZjN+Gb6aJr3CExE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com; spf=pass smtp.mailfrom=dsv.com; dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b=FOgpOMfL; dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b=O7JWhBLp; arc=fail smtp.client-ip=216.71.156.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b="FOgpOMfL";
	dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b="O7JWhBLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dsv.com; i=@dsv.com; q=dns/txt; s=dsv13122017;
  t=1745480095; x=1777016095;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=DAg0dzU7xQu2zbQCmxbZiR6/V5k5ZEgdBmLi5QeDSSc=;
  b=FOgpOMfLG1hehRog1DyfVG/rkMoIZ8gpyquGSYoQyiOF7rHeMAVgm3e3
   lK8oWtkVJdbN+5f7+7F/FvV+EKXlFDqnSADQnvTYUfQiQ233CYwKaoL+F
   ZwQY2dKA0/U+8W9+jpo4dC1eVnmMs7FqnI57uC4LNPcaj1Dqrr5W4QEuA
   V/g6BaSl1XKfH6zOYJliGCehiGArDz7QNYS4R4ZcK+LrOTxopu0vLtcJW
   a7VylQQYHbYpptPp2aHfgo0b39MoDoqNQO7ntSdVBTr2YHHgoRvbpTl5H
   FwOEsmy/EmiZWFfIc+JoKNflm7yyIE2OloNMUp2TeoKC6/o8q9rUTPp1t
   w==;
X-CSE-ConnectionGUID: duSQgeitTjaL2Ryc89h5LA==
X-CSE-MsgGUID: 1DTt0USaRQyNoaoVIqedGQ==
X-IronPort-AV: E=Sophos;i="6.15,235,1739833200"; 
   d="scan'208";a="362591629"
Received: from mail-westeuropeazlp17010010.outbound.protection.outlook.com (HELO AM0PR83CU005.outbound.protection.outlook.com) ([40.93.65.10])
  by ob1.dsv.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2025 09:27:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sksnCoXzBvaTUfu1wgMMh1zMKpPFGji+6509bh0fzpXNJNXVs2RtGWMOLCTLaFwYQ1gGXxthjAUwU/qwELg22d07cU36H25IrszVbph6FA//EdlnOSFOs3mRrPPrMt3Cg1B4anjcKBEzgY9RLO2FHVZj6qZlViEiMqN42GREjRySxKMZ3PQ2D/COyOwKSKkHO1NR7qekxgLnW7qqV5eMFZFWs/0LWb/6wriUhv/973QmdIczjRGh25P3Y7kR0bjydWhZEstbyD+s3BR6TPa6PFIWQEuN9v1UbwSiS0r1MsBn1J3Sh2qN2AQ6nti9GIJcu9VArFnUdSj4MSpH3T8i6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAg0dzU7xQu2zbQCmxbZiR6/V5k5ZEgdBmLi5QeDSSc=;
 b=zBB8g0BQNNNt6e3m36DbTbqkL8ucq5C3jgdzk5mTg2U7wG85otjFa3QrAiy2+3apGevyhvaFctqs0xtIUAPsIcwFAgE71HXBVBq4TIbdK6kutBIg4bubalpJjoEVsiaEyhDdENTnWfWgqNBaDWQ7YR8TViv1k+6h4bIWTKdHn4xgIWrXo4lVmGQJFFUfkAznODrDFiuvFfLM81umWLsxLJO9vgOIDVgvhXs6fV9FSneCBXm+6BjYsMHXPY212VAuWg5ayGo36H+56B+uWVEzwbx5BsKuxNmnq5HJfilTVrhmn6kviiR8Im4V+HyVfLpbJ+XtbARpLtpoRu6+nAsvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dsv.com; dmarc=pass action=none header.from=dsv.com; dkim=pass
 header.d=dsv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=DSV.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAg0dzU7xQu2zbQCmxbZiR6/V5k5ZEgdBmLi5QeDSSc=;
 b=O7JWhBLpVUInLCb7eCcCVhE9KhH6blChZu8eCSG1mNsqn+qT7PuPCW5cG8PawM1kIfQxx41ObSsc/H+NjKSIu+YSzKwXRd4WrOdtb1fNyzEUIdgYhkQqUYJNJOB0H0Qh5uKsHBQXFzWeTjI+Xs3KN1YpG3u2y5cw/1tpWeH1pq+uiPTbzqOaTQMNcLSdeBQxqUjEXEOwZY26a2rmMrPYb8z08r1z+55EXTbl39hm0MbxDZEg2iBtPPXEdexAs+dWb2kwp82bTm7WAQk58ovULDmTCoc3Jkm4qflgKZMLNCgYdb7Lfl5t59Qf8cddIuF15SUGh0KWkW/kgQeQ2jzoMQ==
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::13)
 by GV1PR10MB5841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 07:27:28 +0000
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5]) by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 07:27:28 +0000
From: Lars Eriksen - DSV <lars.eriksen@dsv.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: cURL in git for windows does not support HTTP/2 anymore
Thread-Topic: cURL in git for windows does not support HTTP/2 anymore
Thread-Index: Adu06jewhtBLBy4JSwGSMq19l6V9Jw==
Date: Thu, 24 Apr 2025 07:27:28 +0000
Message-ID:
 <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ActionId=3e8beef1-3fb0-45bd-9621-6bc5e55e584c;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ContentBits=0;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Enabled=true;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Method=Standard;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Name=Internal;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SetDate=2025-04-24T07:23:16Z;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SiteId=4a90c23a-3ece-4ef2-b857-522f23b8204c;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dsv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB7600:EE_|GV1PR10MB5841:EE_
x-ms-office365-filtering-correlation-id: 9a6f967a-0f7a-41d7-8dbf-08dd830177d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MiMjtKQbEMCzciCytNrcqu1tHQj++dXkOTpKemVpgWH1v/HP2xY7tP2XtroV?=
 =?us-ascii?Q?0APM2G4wbXmfD/0EDKq3vO7Y5vBJUfyRQ5IRtuGMC1mnimSJvXkuYDwQzpSK?=
 =?us-ascii?Q?UdpLmIw3qPtMBy28jbOSwavi9hOkmVHi24d+L2egYweKfi4BjRCllOvEIQwi?=
 =?us-ascii?Q?WDmWcu4QKXZeajYXLSFuPJLOfGvKPPf1PM617mpFG7vt5XrJiQ7yQeA0K3lH?=
 =?us-ascii?Q?fHacpTqvIiszxVkxVAYma9yAKKL1bmWAj4xQVKU7BYWY74ZmOgssKt557nBx?=
 =?us-ascii?Q?UBAaK4ERZFsEI2yt4+hvzpNS6JYax4jqRMFmaBTw32tFicKvRHkhDKpQ2XP7?=
 =?us-ascii?Q?N+Y0e7ZIImWV+osxvHt9yK862QhzauFUwRCbjMz+hnXGO0IaJXDoKpi67K8d?=
 =?us-ascii?Q?QfgN+pd4Ox9SLyFqhR4B58H6Ekt4UV8ITwh8fWDBZRxvvg7P81pwJjq2AOTw?=
 =?us-ascii?Q?JOH0+OO9RF5uDeFULh6SiUanGVXLaZCdqYB19YUB2HrzJSM1Ewg65Y0yANYL?=
 =?us-ascii?Q?+CC+79e9vhvbHc++bQUW5Cz+aXqLAF5emToaadtaIl35UbfEJEXn43td4Elw?=
 =?us-ascii?Q?Gpo9f8hpXHlp89V3rSQkBUceDVaL+PVT/6Y38fEz/RhQ9ExjzvFN4uL7hSwS?=
 =?us-ascii?Q?NZn/tAs1BHgLu0fBWgOnjYNMOaeEXcHQmBvCC0ZGzbGI1eAHxcaRt0bq/IFH?=
 =?us-ascii?Q?3UXdV87lWdMV5rCVMVz7+RF77ltCr4CnQkwwbZDlMIrk/9bPeWWBV9X1Ez0a?=
 =?us-ascii?Q?phUTfPwijua7SX9E7EbOdQNgs57Thda+ptQ7sz2z1i2neh7qJDfg2zp14/G7?=
 =?us-ascii?Q?wwVyQIuzBGrARF79vJsSsg3uZzARh6tW2l195b+ccKiF5ApF5rPrDYkP4+Ix?=
 =?us-ascii?Q?T2jIPf85aK/0lXLct/uxxejtJtp8Rz1uikG0JW34HUrfC2YzHpL4TNTxauHS?=
 =?us-ascii?Q?eYW4yyVzcoUA8j3r9YlLKMj8IcUoBL/InGHVt+2cjoGQoOFRMG7hO1SU03bW?=
 =?us-ascii?Q?SoJ3ZJrxkiLaD3cq1Dwr5cxqjn4U5mccVprcvju6KddrxPVn9fC23XnzVeMV?=
 =?us-ascii?Q?LzLFGjmXYd0y2zG9KqIa9IQh4DMdwkyjQh0CCDXrPXPDvA4GuQd2gGMexyK3?=
 =?us-ascii?Q?hLFimei4FUpsShFWay71IVy3ASENc/JVkoeSHRZnvx2r3srTEEyUm0Y0YP8y?=
 =?us-ascii?Q?zPBsWhDVD/ufMh4gWQvGVRl7Cpcd7HSFoSkmYhT/Z894b1COeVJlgShNg/3S?=
 =?us-ascii?Q?l8wlyGvCWXeoCpld6Bdvk7j41hF1YGeBZRpWKc8kdLBoy5NV+uSI1DrlfcOg?=
 =?us-ascii?Q?X8gSnziO280SUzZhK/O64+WyF+hctadqf/22+M758ImHAfA7R+Oc8RBflNM4?=
 =?us-ascii?Q?ErZvC1YKtPl59G/RmBjHGO5DHnoFs1p3BWU6mhst8KrvYKvwjiU+vgtNE7Bu?=
 =?us-ascii?Q?cMScD3kuucY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XjEKKN8ctmjL80wh7zs/+kyp6CG7Q6TbuT5t1rKmSLMzXkuUxEJ9KXE96NN4?=
 =?us-ascii?Q?EiXYHazk1IlXO6cMyT1HtfeCRgRaEarNYTBNN3sG/LWRrwreScqhX0k9K8h8?=
 =?us-ascii?Q?7HXWt5t6IluzmzrO7YPHVfp9i2tU4Ve96y2CfvK4vQAi72467SIsBHGswIB2?=
 =?us-ascii?Q?oHb0SBLVwQGABxQil0sUvL1OujjFxh1gKeX6egaPwPp/l8vqz2UZfDdL6N0R?=
 =?us-ascii?Q?HevxFYN6f8qxGE9doLiAKwz/PcQVjtLtWPCn4ji2NI5H0CAYkSTG9BzPTuYs?=
 =?us-ascii?Q?TyRZNJJKBP1xjwMqJUvgX5BuMOkyM7O9faP2dIypoLUQE3pRpWrEKBvjVLUK?=
 =?us-ascii?Q?rIx/FBiUTl3dxw4AAyNLyJ4di71d4L/k5ZbJ8TejacP+2AwdJBBmygrdFPQ5?=
 =?us-ascii?Q?8pgD5ohoYRpdW62CWcYW6AWjaglzV8VVEzBpfZMnPbKSLxpsDkqqGh4pXHb+?=
 =?us-ascii?Q?HkEZ7+zE2BN4bKQtbgM3Zvuy/xkAO/7w9LiEhu1CF/xL0FwoUMF0J9vEe1Oc?=
 =?us-ascii?Q?Mq/aHwW6lnbgg6u/848MfLsrHXQULntGQZNez5shdyv1XzWzVwXvSxfKdg9y?=
 =?us-ascii?Q?OlaE9jB25aN1FCTb/GtnT7mf0xp+C0EEV4SEoFr+Cw2vPB96IcpONCp8muDf?=
 =?us-ascii?Q?h4qfujgfQ5mhX83bXb9u47ddSo8PXEdBe1ZtBHnaatp4IYA0in9SZEUKx8zY?=
 =?us-ascii?Q?st9sDl20+fboQTEtboLmwELK5n4eXRmdYmFjYmPcqbpOxbC/Tmy2QomXAhKv?=
 =?us-ascii?Q?m4bokOeuCkzWZ5ljOBJazHSfnnt3cJzn5seIuZS+M1E29czbABb/cEbC5/2P?=
 =?us-ascii?Q?glEkaHZ9AgjfPQx+tfvwuFFxezRKyw+vO/inFMOEqFEMeG+a73H+vJCXgKOT?=
 =?us-ascii?Q?PmNnAVCI48a8gxwX2iw4QODL/YEu9TNzRmyO+dVMVE5TvAa6hrDuhpVqbUHo?=
 =?us-ascii?Q?2DQM41Q518zNvhDJhP30BJ5ED/hH9vyE6YV7mFopVv0ruDDmzYPZc9N3AE7G?=
 =?us-ascii?Q?SdTPY82WJruCPPyOVfKfp+2iQAvzGCMjiYmQD/5BTYIOSwNZD02AOxIJvuOg?=
 =?us-ascii?Q?7OGUAAMUh+R1JwI276OQshjzlklQjigqMLvdmElobZ2TrbelhNub/GIae/5y?=
 =?us-ascii?Q?SP1s5Thp2acLT7kgQHlhGsdkuz1M53qCDuYsqf1rakry/pn6ZyU/Ju8G1mS5?=
 =?us-ascii?Q?OfaCZswLQ55FG8n8FWVgx4IcsFbUcB83KIfVkFa0xB9oLkHHfX1cuek0zrYc?=
 =?us-ascii?Q?/4jWCjfCUQvcvnjWz7ETSGNAwiGmjQRNTRTqsFx8TdwO0ApINOlxXFTEUcqD?=
 =?us-ascii?Q?w36sDcJ/DDfXydBxixgWpicw4XvYOIyVjRqVVXYIibYTt6LNnIxxl2siVPch?=
 =?us-ascii?Q?wlP3r/dsuZZJBH7ygTPkHkunZBXJsRZAp9FP5LyD1gEMGOGt1TY76s4yt3O1?=
 =?us-ascii?Q?BYrQVBKEqoIsXdc1lU4Qaa1r5NhYprCnZd6pYdcRa9p1dADfnbx8NZ0KSlqU?=
 =?us-ascii?Q?ZgYXdtUa9A5J3HDUUDRli7H0oKmCMltnUDztFo/hjjwgPzILDorChrkPJt5i?=
 =?us-ascii?Q?IQKyFQ+XxlPkdSvwT5KyGKLWni3OPFQa5fuoNrJr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C+XiI3Q/v76Zn+RAf9xKSznGelZta+bDBANe/7gdfSZQS1lSoZx5ZtNFUSwjnReVpvItf6N2bmD5PCPVI6xMM4zyrSWPyi6IGv3mhapX7kEQDqdNndbpbH5yzHoinSYWbdshw6ZpTs7KXDh1iBiq/Rqc3CZliwEkTUPvHDIEP3Puv44IWFH4zU9QG4VuV+MxThqeLHz9BwWlMb2NWjedHSZE4SsnFMsTRrzxRjgVwo1VZpm65YMDY4tSdx7+qDWF9/WDYJzD2jk+ZruOhKXUx9pKqptcmoqMMeQvQvvYk5Dv42SxovpbtpeYUfVodo45FpsAXx7WUpzwkxaBnTBTbXc6RhjJvQbNHRa3ukELtYVXgSObfGpo1iGmGH/xWHAATPO/6k8nYdoTvNNL/pYaPWhhfTNu57tYrBrXe6Jy6iX5mrXAHIfTD9Tbv8nbZ1gSaCPa7Vx4v3xwZ+Hvugb045yC8K3xerD/nkXf9TZDYmH2p8Z4u0kfPXp0+VhvNoyPEpoFKqCmPaYt6MSYt55dfYGhdsnLrudAPvxSD2a1cDpZh9lzDm1DMd385AN9GdcblBiRAGMnzwNaaQZ42orNC4Hh9xHJvrNOyGdtOPlA0TVzvOymvKNociEpKjQ7sgpzfNqyOCi7G4U7dz75snI5W8zszjCKeKDpYD5TItFI51Noqnnkod+1pivI9Z0mOTWr
X-OriginatorOrg: DSV.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6f967a-0f7a-41d7-8dbf-08dd830177d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 07:27:28.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a90c23a-3ece-4ef2-b857-522f23b8204c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4UgAnJz6lEgD8PcImnfY4/T5AuNY1JOQaUgpSwzpE8Ymdi8R5OdFG8NAaC2mSB33JJ2sA58bcWKcEDcYnlquTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5841

 Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Upgraded to a recent git for windows found here: https://git-scm.com/downlo=
ads

What did you expect to happen? (Expected behavior)
The embedded curl should be able to use HTTP/2 against our backend.

What happened instead? (Actual behavior)
After updating git for windows curl is unable to authenticate to our backen=
d that requires HTTP/2. curl --version shows it is not compiled in. It work=
ed in the prior version, 2.39.0.windows.2

What's different between what you expected and what actually happened?
I expected curl to be able to run as before when contacting our backend in =
our maintenance scripts. I'm not allowed to install a custom curl on our co=
rporate network, and the windows version does not support HTTP/2 either. Bu=
t the git version used to.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0.windows.1
cpu: x86_64
built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.12.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
uname: Windows 10.0 20348
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
not run from a git repository - no hooks to show

DSV internal
