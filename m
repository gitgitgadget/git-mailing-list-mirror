Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022101.outbound.protection.outlook.com [40.107.200.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA6379C2A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708222; cv=fail; b=mqj/kwn02cQlMiqVW4qC44dr3vasMG8LxSJfP/1iyKqzBpkJYhUC2oIYO196Wjxo5wPaggSJoQREb/eRuXAXa7fvUsV57Hv6t1Lb9fcm5erFae0lbFAyJZmDoIuu3moG7iUcK8+mvaWnQo4KOUMCa7KUhubEOuA2OGQzIzMHAao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708222; c=relaxed/simple;
	bh=YwcYK9318/0cMUSXip+a/xCtt6rzdS/LJOUr98sI4wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHLQJThdtgWfG4JzWUpdNb+pYCpW5QNJG0HXyHlkgCX4hAnJdWucrY33U4zd08apueWO3gG4JiNzTo3gXSZSlhW+J0kS94/Is/b03rWiIglk4wRdQ+MPqzS8V7nEYVEY+pZDL6smDxLfg/iHjDziu6kcQge5UdpBUn3ZWmGQQWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yuxuan.ch; spf=pass smtp.mailfrom=yuxuan.ch; arc=fail smtp.client-ip=40.107.200.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yuxuan.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuxuan.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLoTzZc+SshlQTWYwASssVaHwJqRwXrp7SvP4OvigbNKBP9og9yUSr9IDZD3vxCZ0vzJ3Z6rryqubsrS0b4mHxKw87uKB27xAnkOBDTMfQkyTw9YJZpAdginUYmTOU0dNPI3QxqxX5+lY8r4hhTkPTBrgwR6C/eBkGizZ/+ucmFKxVkWP6zUnSIXOLnTRNzDieCMOhcN78cU69KwUNu5iQeYaxVmNTqCuFFj5yFZDSMM7QCDuF3FUU7nj65ADuptGNKRAqzUblVjh/tcP8PAmaohy7LVbYOrySD2oCVeb0uzKOU+bfbuavEDzIouYJpEzijypsgw7cpDdQQzLUCLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwcYK9318/0cMUSXip+a/xCtt6rzdS/LJOUr98sI4wU=;
 b=KR5bDYK6f7t+RYJ+oysJkJitDxcMrqpbgbXdMgHLcsRoJOq1PwjrjEyappQq5rZ/eptBcGK0s1k82Shosehy8sIFmHceQ3SkqUac09gNGZZplynU3/1SoecqbnE3dXNihMiuQG3ktH8Pkt1GkGRu3bYval3vN2yRAA7Vreh0IPAEXmQaVW4eGd6FaouoJCKeeVAeZFyvhJ5ZT5V7EQkqNLVQXLHWwpsGpUnRfDVcONjEL1JZ7Yf/xZ4ZXJnruoROhr+FsuHRZUlF7vhpmixic42liPbBa0IgP/CTn0D21OmJSz5GS829pbC+FM6HTGuPRy3CVX1QO1oqNK4ujEz9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yuxuan.ch; dmarc=pass action=none header.from=yuxuan.ch;
 dkim=pass header.d=yuxuan.ch; arc=none
Received: from DS7PR15MB5351.namprd15.prod.outlook.com (2603:10b6:8:72::6) by
 BY3PR15MB4881.namprd15.prod.outlook.com (2603:10b6:a03:3c0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.18; Fri, 10 Jul 2026 18:30:14 +0000
Received: from DS7PR15MB5351.namprd15.prod.outlook.com
 ([fe80::3eba:9867:ea41:c42c]) by DS7PR15MB5351.namprd15.prod.outlook.com
 ([fe80::3eba:9867:ea41:c42c%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 18:30:14 +0000
From: Yuxuan Chen <i@yuxuan.ch>
To: "phillip.wood123@gmail.com" <phillip.wood123@gmail.com>
CC: "farid.m.zakaria@gmail.com" <farid.m.zakaria@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, "gitster@pobox.com"
	<gitster@pobox.com>, "newren@gmail.com" <newren@gmail.com>,
	"phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>, "ps@pks.im"
	<ps@pks.im>, Yuxuan Chen <i@yuxuan.ch>
Subject: Re: [PATCH] sequencer: honor --empty when a fixup!/squash! empties
 its target
Thread-Topic: [PATCH] sequencer: honor --empty when a fixup!/squash! empties
 its target
Thread-Index: AQHdEJom6SdC0shX00adRh0gBYB3pg==
Date: Fri, 10 Jul 2026 18:30:14 +0000
Message-ID: <20260710182937.716304-1-i@yuxuan.ch>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
 <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>
In-Reply-To: <afb76b98-661a-4663-8e8b-fd00572db5ba@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yuxuan.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR15MB5351:EE_|BY3PR15MB4881:EE_
x-ms-office365-filtering-correlation-id: a94aab90-0e1e-4a52-d160-08dedeb1488c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7055299009|5023799004|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 pNPvzS8VQsoea7JuxH4K4wghRd4WrmvzQeoGAz8dvznZbULeY3qwOGmAIwq9oVdsH/5gUu25phdK9x7QlCvqPqUrQnpSot+rSXVzDLQx6NpC7JeZPnt9f5/QYpQwM2hU8PHe6s16jTowhzUfvJF8pZeKeapHSj0vUAkSCgl/nDXsWurgRJwJP0r3g1Ij34bgpMZPzNrCuknius18kWq5Bc8ZAGlKJHVI4t6J4x8Wlt/hh76oZuWUKZ2buLuusoG0SLKCEKNidSt/v+CjqZc7HEjQAryXrK5/03LrgxJEAyecxy3xLTGXAz6gD2UcEW/MBKKhRtvRbkDF5i9RQhrxPOPufxFWS2yYKrDwYjY3+Mm9n97a6uHJtwR86oUgKljUUegLR5W8mDOGWGCmDjJsEdefQgK6y8ME5Tez3l+Y4kiX4WHu8ctBslfvMyGyTdbS3rEU9EAdbxZPiGkSkFzGpmQ1eNwiAfdSThFg6zvajDGzJdpz2nHNLl5f+YrZEcYclGgTO6NBWw/amL7iwSIMqhaZvCZyJHCAnr+kk3aOd8gXY5iYO1XkqJxcsTP0oEpH0g4STQzQIKNfg0awS2vQPYcep7vJRQb7auBF/I0PyUu0qjZWp8H+i/BUImRUR9jXJulr/jLa6gw1Pmx2cqBdySG7SuPjAKA86AgJEGfAhHyZlNMFbxhmyrArLQPvWa2TG5aDNbLuRzSCD1L9PPylPU38kFhYVItvMu4vJY61DrAbaeaP5XPsgCbRg7zp2/J3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR15MB5351.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7055299009)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jNZmPExNSXGQShvh2bi4xzKZHv++wVrE2MpxyI37bbXp8btr3/sQoEP97D?=
 =?iso-8859-1?Q?q+MlmhXVFt/RmR/e2BOZjmYBKc6M4RT4dVjyTFYY6bNNu8Ye57F6byvf14?=
 =?iso-8859-1?Q?EodkOrghRKdMorofOL0Of/OBE+L/M8Sz3d9j4lXL0EJ4272awg5+Kez1so?=
 =?iso-8859-1?Q?v1uKMcwOvwj2nvlidPGxNtW7+Eb6F3pz4m/fYxvg8QpD/vaw7qWMIbbwav?=
 =?iso-8859-1?Q?P9JwQorR3PSGsbLH5YGGC9TnmB4Hq3P8sKRVpnXGRfGruzm0UlmJUOqkG7?=
 =?iso-8859-1?Q?biW6h7g8qH1aCP8VklLFFKAiMPgV15GdXfk/Jmu668dujCx53JC8tcqkrj?=
 =?iso-8859-1?Q?zgMrphnyZaJsIWzM3jOsL3AXi9pla/lSdL3isVV8VBtbjp1p8qA2XH+J48?=
 =?iso-8859-1?Q?63p73vIrkw64DoyalW0Dr8JzKXK/YXXrDwCaQqIQ+7En6ikvjDrAzEmHPB?=
 =?iso-8859-1?Q?K38R1ydW9csQT3UXhJpDeUT4qi23RwhQVtPDG4iJoMSChvDa+GzBefg5yW?=
 =?iso-8859-1?Q?vdco0w/wwyn5L4Ko/PEL4aa5rWssaJ8EZU8DrV6kFrp268bwqUOhMlA1nn?=
 =?iso-8859-1?Q?rBQ2ySSoZ8E5/g+MGam3fqHhwpxtDrAyoVs8m/G0QbNLnGDenPaz5I/NAe?=
 =?iso-8859-1?Q?VhDKTRqCXGfqD47ePkJQHTr8wOcqk2Rbi7uNOk3MRvyc4+t93sB8wervR1?=
 =?iso-8859-1?Q?kTcRChLzM2ra8PIvntkfpg8H4ch3ejkTZgD9KHp+fQAMh7j47Ecqqr3lrv?=
 =?iso-8859-1?Q?cDYypoZ1bKUqBn+QkMnZrE1f/c/XbH+0p3Eti1SIg9ma87McM6DmZY444d?=
 =?iso-8859-1?Q?te6sv+a1jog2Ke9mZWf5hVuh2OG3KPM4z7XKPo5Kty/5MnUPNWtVJxTRVa?=
 =?iso-8859-1?Q?ybGHp2z2PP1LOy2KlmMJD2co2vlGDg+t82OM3CjaoJQTFIkhJPXxKOAKBc?=
 =?iso-8859-1?Q?celK760Om7WqdRObGmwtW+LDFM2WbzuNxIpVfBoxQhJs910hGPdX4MO37Y?=
 =?iso-8859-1?Q?r423xGws/NItzBpWXx8NCje30eq9TPjvmQPmRZVYmmiPOpnWMeZQmvvtO2?=
 =?iso-8859-1?Q?fdKj8Ys5omvDz0bUOH7A8dfNItHih84703iNmPosgMa0BffTQXPGvRYCtD?=
 =?iso-8859-1?Q?wcNOhZ2F2xfmcJ2vwLDJYQCiOJPr3sl0W3PP1wEWR+EQ7g3ttbVJgNlaRi?=
 =?iso-8859-1?Q?Ico6ac4IBSd/p/oYuhEuWbLeIwbiQ3k8gjrJqrASgEu/lSnZxuoklM25nC?=
 =?iso-8859-1?Q?MZ2ehWYU6bFNsKYPhT5uQLSbiok2yphY2TZj3dsYAZs55JLgYpADOQrdAu?=
 =?iso-8859-1?Q?BVW56jHdX6/r50RpwhjmKx1SxshgWRpfTz2NXIS5gpMepZ7s8yyEHfwlkI?=
 =?iso-8859-1?Q?+CxNOc9JS0K/qTgMerqanv7fXewe3boBrwgk0acdKzff8MuhHOjBEQBCtQ?=
 =?iso-8859-1?Q?hTTgKpnhnab0nbSA7eSJPPrlmh1UbZshHugqhELZMg82vInVutab4cNcA5?=
 =?iso-8859-1?Q?pteUZZSptP7B+iASCMIbeKhgJVOCYu3DWEGfJSgzXFSdRNXiBrNJ9V500X?=
 =?iso-8859-1?Q?SKyUDq/+K5+f0FevyJlkyfTEessr5hv0BAVE3Dt+eoeeeYHMN5xvY76k0+?=
 =?iso-8859-1?Q?fmTGKXBM6clOQUTKiTlr7U3S5q9/2mChj1SK0OASVj8fnEQYCGqzxPwuUQ?=
 =?iso-8859-1?Q?vD0H5eUBpgD0U5x6b/1FeG9KR64NIQsJ3f2w3sVd2XiJ8INDD4O+a7rnga?=
 =?iso-8859-1?Q?u+Z5su5ZlCEqPo+9ZF2/LfOI8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: yuxuan.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR15MB5351.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94aab90-0e1e-4a52-d160-08dedeb1488c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 18:30:14.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f65352e9-0dec-453a-946c-e154687f7702
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZVJrzieEBt8mJb8Iyx88gtMmRDZLnUZcAa6tiy2qUy8q3M8wOcoxDpXymf6egyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4881

From: Yuxuan Chen <i@yuxuan.ch>=0A=
=0A=
Hi Phillip,=0A=
=0A=
I'm Yuxuan, and I work with Farid at Meta. Thank you for reviewing this pat=
ch.=0A=
It addresses a workflow problem for us, and we appreciate your feedback.=0A=
=0A=
Regarding=0A=
=0A=
> Using an empty commit has a marker has the advantage that applying it can=
not=0A=
> create conflicts, so you only have to deal with the conflicts caused by t=
he=0A=
> commit being dropped, not the by fixup not applying cleanly.=0A=
=0A=
I am concerned, however, that representing a `drop!` commit as an empty mar=
ker=0A=
would be semantically unsound. We expect `rebase --autosquash` to drop the=
=0A=
target commit, but until that rebase happens, the repository is not in a st=
ate=0A=
where we consider the target commit dropped: the target's changes are still=
=0A=
present, and the empty marker changes nothing. Therefore, I think a `drop!`=
=0A=
commit should contain the inverse of the patch we intend to drop. That way,=
=0A=
the repository state reflects the intended removal even before autosquash=
=0A=
rewrites the history.=0A=
=0A=
I recognize that applying the inverse patch may cause conflicts. However,=
=0A=
this is not a new problem; `git revert` has the same issue when the inverse=
=0A=
patch does not apply cleanly. Such conflicts reflect the actual difficulty =
of=0A=
undoing the change at that point in the history.=0A=
=0A=
Thanks,=0A=
Yuxuan=0A=
