Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE0274FC1
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141531; cv=fail; b=JYZ/4onjD8wUUBWhrqvMONeVQXxatXm4vtwThc9x4lsgrljD490bXH6+f5RD1bhdv+938piZSNSiylt4wOMRsKDr6asB7y0F7HxEUWfs1MQJg0AL/PzIjY9tedNj/XMqZ8QiOC7gIUQ53GKEtB+MoaERDdDkGH8CNwLxX4EAF0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141531; c=relaxed/simple;
	bh=rOSGewhBD1ljaiJ03oQlWcqAxwJcg/WkOjvKAszVtEg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hQE+G7QaORSD9ys79BBMzXuoV7xZ+lIwi8QkB4juSE1PKzJmcrMA9/zzVPLwshyXPK5RgM6SfxsDFbqZXI5oZ5EC+H2h6oe1ana8/xgFGbtVRG6ttwQiwMbFnTZk5Ir1td1aBICq403/AlfJRJknjI1oAxz9Jl9a3SwQpBRldKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=temple.edu; spf=fail smtp.mailfrom=temple.edu; dkim=pass (2048-bit key) header.d=temple.edu header.i=@temple.edu header.b=iz292Xww; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=temple.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=temple.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=temple.edu header.i=@temple.edu header.b="iz292Xww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA9+NYlO7PDUVnTiHGZgfQAglr/816zeFO/waPfsbtUGpiT5tP6toVLCK6gKFeu/0K/fTkVpQkoIvihXWpaArvB10jeg7BwxzRNUq1IzLVX6ODSmnXl8GT0T/0nbPt2AOnsU6r2nfnuFQlNWV4jY+s5Lbjb4gNndZCiqGDQ3Qo861OYELJ+b+ztgASbUaR2j+zre3LTOaY69dF7jF3kAx+6F5vcFd4nduVKS1qNHLz84e9rNP1WmA+GrBziMHZjG+EmKXZw9nZ4BUqCfRO8yTjiHa6FTEnfmCmng1IotXm5EaWaPwoynQBK8cVKy0aI1xJgtyai9rL4wKlW1PoX3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hOKe+ezvSMOjDhJ+VUyuZ0Sqq9bO5poJ2zVHiC47RA=;
 b=rFK7Bel1C3LLIItz++4H9NNJGUNwQfXa88ZjAj/csAmixlZLBnfaUGZr5MNonINixxAPzw7RmC41TLTWl6wCnDBW4YF1eCT5rcvnYfIHJtqi7eECHjQ+tbBiN4H4mjM3tfgSmU42MtydYoTtxZbHIrfALyXBa/DtZVWPOFRKq7Qh4oE+J+OEmP1a3xFHIM/YJo4Dw3j8/Thh/O160Ve58ZXXKYpxNHp3JbdoM4O5WSemP2qH9IgVr1uLqJDrAw2hMeR4LrXEbrKRmDaM9KCYrIEkQ/yO8l+IdjUT+V1HOu0VBqH2pafJ+bE1NEmJqKZM0O5yALaHSlRQZXsTRIMqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=temple.edu; dmarc=pass action=none header.from=temple.edu;
 dkim=pass header.d=temple.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=temple.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hOKe+ezvSMOjDhJ+VUyuZ0Sqq9bO5poJ2zVHiC47RA=;
 b=iz292Xwwdo03MjtEJwmg2OyISjUkCmDk54RGU8tUAZpsN+B/JQv4g0XSyNDfcd99CZocqap4yTa/yzLw4YJ9d8y/sEdM7yOR6Uvec/F93f+vn2/I43viKEBi1Vtyghcvq6gOF5Iu4dhJGlBfP51p6UybFl7WakXT18XvZwdffTsOtbcBAZDpPfDlqpSOFvTcX8GOLKO7EAqB+P2QCw7gvU2zk2p7hTMw2g8ssIOA16G3iq5QCgMV1hamB90Y1rUUjvnQCdWeyN+Af9Luu7YihziGmsaGuUSbm6YrQzrqwqagUXrUA9bov0j3S28TlTcX4hEKzVPAZayD0qNetUtvPQ==
Received: from MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 16:38:48 +0000
Received: from MW3PR11MB4763.namprd11.prod.outlook.com
 ([fe80::f730:f6c2:565b:a3ce]) by MW3PR11MB4763.namprd11.prod.outlook.com
 ([fe80::f730:f6c2:565b:a3ce%6]) with mapi id 15.20.8746.030; Thu, 5 Jun 2025
 16:38:48 +0000
From: "Scott Birl (Temple Univ)" <sbirl@temple.edu>
To: 'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: [External] Re: "git config get" returns "error: key does not
 contain a section: get"
Thread-Topic: [External] Re: "git config get" returns "error: key does not
 contain a section: get"
Thread-Index: AQHb1jevXh6bWNXwrUqxERI0zROwt7P0w40g
Date: Thu, 5 Jun 2025 16:38:47 +0000
Message-ID:
 <MW3PR11MB47631ACCE4347984E192026BC36FA@MW3PR11MB4763.namprd11.prod.outlook.com>
References:
 <MW3PR11MB47638E3211C195DC1C032DB9C36FA@MW3PR11MB4763.namprd11.prod.outlook.com>
 <d2829090-de29-466f-b17a-734c5e8bf59a@app.fastmail.com>
In-Reply-To: <d2829090-de29-466f-b17a-734c5e8bf59a@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=temple.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4763:EE_|SN7PR11MB7509:EE_
x-ms-office365-filtering-correlation-id: 45a542c6-cfff-4b37-248b-08dda44f721a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7fVdLsGBqWiOIV3gJJeTQxlWGJ+PrK/cAU/RxR5mK56pv4CQYvqP7hNVBaZM?=
 =?us-ascii?Q?lPkrxD6XbEHY3UKLiOOZqhf6h24EBCBAXK619I5wmoVu2Nkz+ztRUZ5IlamY?=
 =?us-ascii?Q?iIAj03m2uUiy1i3sLfdzpsC2r3yO9g65QUsCB4+j3w9xBexZYAJ0VqxaI0XM?=
 =?us-ascii?Q?kISLaEBhLdkBiMRAVXyIcP08eOggDjiRsf9SG0dlZamfroEz3HrRImyqZ8Ny?=
 =?us-ascii?Q?CWwiGNiYBr12C7ZIA3hMRSSFYNsB3zQTBsF4Aotm/Owcv74nlPFjQ6w7FB6b?=
 =?us-ascii?Q?38r4q9elo9Hn6vnf1+3l+JppSJq1UBY9mBXS80uNELZSRBfz4VroKVflQ+ul?=
 =?us-ascii?Q?1ciBYIl/zTj557fvCw00Vf517/B9cZpgVA83EM2otjP5dOB7IDIFpwIR7EON?=
 =?us-ascii?Q?CiQ2veZ0xgTM4oyALBLz3KElrwcst3Yh6TMr7R8Y6fH2bZinJ3UUA8jUV15I?=
 =?us-ascii?Q?iSdZAEWILeCmEezHVwRaB197zqxx2jnzRMBOQEmbpiRewov5UMLkk8nBRCfy?=
 =?us-ascii?Q?9XNwm0xciHsbn2gdGuL/GK6V6v+kQrYdlN/Yb13yOHTO5SXSW0nvzx2+jl3T?=
 =?us-ascii?Q?DWbV4pjP2u4HXAy0/2H50kRHxcnCN0ZcOakUBGAumaox1dZQuadCC9nFJybQ?=
 =?us-ascii?Q?sA33VcXi/CkdMqmgEB5c5LhB8DDWYTs7662TDOiXempFadEdxeiRSAHOQ2n1?=
 =?us-ascii?Q?PTqd0n+wijZBU71fSsnomOsq4JjzU+4NWXMYLbi16YB9paoqW+EBF1su9epN?=
 =?us-ascii?Q?OZL+6jS3X5n/Tdldu/Gi2Y+GUa9kirXVl1u6NSS1q3KVvTUoPtg3yn5nHxbY?=
 =?us-ascii?Q?aInPe4Ykq2FsGKltKQqm9kf0UL4h70TeD5JlALoz8J6s9pTMAyyZlWjO3xqx?=
 =?us-ascii?Q?PGCZrtqj5B0ISlFILzJ3ADBxDJON/CSzTBWXTaidpxJ+6/oqCLs9nuvpTRYp?=
 =?us-ascii?Q?ed2WTv2yZ+yiLbhapjcEDEpLcKm/GJnpqLzhLveMl/itizzSu6BUAYGQbSkR?=
 =?us-ascii?Q?1qqEJTxdeUtL91/BPTnJ0GiT6ivgKghOil/kr3+XlefSUswZfObSkuZFI41L?=
 =?us-ascii?Q?IsdRSG3nqNxBYSCNYXiz2YSDEK0OJCRS3pAdVntoyvgNX5hyJPk78eRxqH0i?=
 =?us-ascii?Q?cV5pmNeXJZXWMMO8BtzLmSNP6IAkI08Nw+9T/pj+1ymmyaL3sn3UlmrwswWn?=
 =?us-ascii?Q?TgbI/+42YhykkuB+64JjMOCrKS41yrk8nlOHegcjnIKeWW6T2GbbdGscQBwP?=
 =?us-ascii?Q?AzCqwQsascQZkmIA/ZVGsF+vqnbFKJjhkGaXcsuo3sxb5we/N0+mZwdPdSUk?=
 =?us-ascii?Q?wN4ZbBBsOTKdfQKzFv2oT137x70IFkTreZwpaIQmEyUs1/a1fJSI7Syf44XO?=
 =?us-ascii?Q?WJNeo+hH2lvCKKLiCWkGy0M0d69M6kFit5w9IJVWLMlNWv1R85NPJZZraDIX?=
 =?us-ascii?Q?5jvoVdZxjpULXPYh+YOCnr0vmRrujwRclfqqYr2353+IrLHsXTIvYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wKzgUXuyboM1iuN5v8VVJ/34m9LsPl34Xa8YZrVJ7mdRR9WA3qwY/nckCGSN?=
 =?us-ascii?Q?/cRXAG6DJFgZxjse491xGUOM6qE/8JKYWSeW7C5bQ/80giiG51pNve1ZuCp2?=
 =?us-ascii?Q?C/JLTMMHfGuwjA8JzHJf6z7vMsbv/XfEgm1pvc2iSz1TLLPWkVu9lwZFo2Ey?=
 =?us-ascii?Q?L96Aykc7NzfYVtIFIJx1MJ+KHo30AlN+4gTKw328u3zT3OTJrkE/ttS24Mlp?=
 =?us-ascii?Q?v15iew6Sw2uBGN3QYyVolidoOJIMA9upSJuMtBZeIoHfTBy6nSDpypp3UKH3?=
 =?us-ascii?Q?0MFfjPmZc70qrNnt/cO/hHuTkwM3idqUheCefkgp3zlUIHPPyzzyWfxWpl14?=
 =?us-ascii?Q?Usz9dsbUTmyJHBn1OUUDfxcNuJmgasGnSPOEC6B/jf3WHk36dqpzHvr+Iv+2?=
 =?us-ascii?Q?/6ckvf9AHz3yXqym9RZ32bSfO1Gh0QqB4bPQZu9KiqfUGoKWUqYlTPK3Flrb?=
 =?us-ascii?Q?D6VQrC73HjMzZqfVeLcz0Wm351HySLQswBBgxQHq8Ln30KqZcWRBbH5usyiW?=
 =?us-ascii?Q?vtCIs4qEg8/IDZ6zFQhdAd3JdmyF2LN89Rxj+37mqkbRTDcENKzgvsWTec5o?=
 =?us-ascii?Q?8LWNyOC1aXLQR9rz8TSyHHB6cO3oZhdFvsinbVyXHJ4mI1vdvc33yft0ki5C?=
 =?us-ascii?Q?N+8iWA1fNd8TV5xLwJnrFwGdX7mL9LAZEX35O005PLz7dprgbjpv70jTcCMW?=
 =?us-ascii?Q?OjRP6rJ0zwaxdL5RgTWSnvLIDAc+V7CCuHDcXe5wOtkJwhafBqgfQlxmVrtZ?=
 =?us-ascii?Q?d8OHJmzveG5agJLygYG9t3zPKRJBGNpWxBL+m8cJNJWxq1tb/iygQiVb30cs?=
 =?us-ascii?Q?G6LWnB9DPUZ5QhHHWW6cjhhoi7M6Xi3Op/FJRVPxu+fSiYSSmTIKGvwmXoIi?=
 =?us-ascii?Q?lQjgFHu4gw+pZt3olx9ikpTWdmGjGEYiDgk/+RJbMgdjsAnqgrvX+ab6rnqS?=
 =?us-ascii?Q?SSC8qx5NmdHJlJtsLxktsNgEauDY3M5O108nlkAuyf3efSkIGBj7gYzZfgPo?=
 =?us-ascii?Q?Os/XAoi84VN7rndQHjHo/nBqJ7wl9PUXvtyq5FBAiwKt+DeWIeHWyd43R/f8?=
 =?us-ascii?Q?s2Ls9QY0C9V7kOOkRDjsKnh4BcDcQ13jUIgYi+THUhYxquDUDRnTLLXWUxwY?=
 =?us-ascii?Q?Dpsc/e8WmuU6aU00dXzkVBkq0fIiTQQc+eN/oK2Zf9CqtZsTpVAiw/FSPzdV?=
 =?us-ascii?Q?AwMZyEdBcEdIY94W+3deEW89O/6Cz+pMQcGvR2FAqZbP81oFBi+pJeDo8H53?=
 =?us-ascii?Q?3htPnzYenLGChyXjUXerwLtSctDU+lXW/JMmbxrGUu1tI+0vuD/p1j0mf8VC?=
 =?us-ascii?Q?IkWPoTHLiUT+KmarQvzQMQ5QmCESeTKcFxRHfejT16RR8JaHXHdrmZpS4F3D?=
 =?us-ascii?Q?Uu2bUlZQrpxL0WR5oZ+KfuJnFJkgKE8wb4t/5knr0Oh9DsrV9rcTcGVtU3Kh?=
 =?us-ascii?Q?n7NadIrdvC7oMvT1SCqLWKi0PIWlrnusILCm8OAovVuJiJrfVkQLWUdi6maC?=
 =?us-ascii?Q?2KofVhhcwg0Bgwhh8x3nlGZXE8eLJ9vcLnlF0A1Ay/G1E1WeB6zt7WqnoLox?=
 =?us-ascii?Q?3xnwYaOLoujpmdfmQoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: temple.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a542c6-cfff-4b37-248b-08dda44f721a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 16:38:47.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 716e81ef-b522-4473-8e31-10bd02ccf6e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Es66i4mFjeVcSv2F8V5brusay7LK2tQ/ehMMQSJ6YmrwhX3x1K6dgd8yELl2fxNC/t7i1lIgxwK0Xlego68gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509

> `git config get` is from Git 2.46.0.
>=20
> I get the same error on 2.40.0.
>=20
> You need `git config --get`. That's the old syntax.

Understood.  Thanks.

