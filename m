Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF31FDA
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088433; cv=fail; b=RK+t6TzRvsJJo0SnxXNrSZN73HLuu2ZMSOigBZWw22gbbdpHlm8r6VLtMr2E8X8XEOP2WH+M65sjiJiumaMNiV256tPvarRVH5rUl/ePWlcAJA5fZFMgFGVLrpOOFSF6RsEImsPjpKjdLuZRYqkbjs7k9HBZLXXQ4OByns6QwQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088433; c=relaxed/simple;
	bh=uEwnnGs1ox71wqZ+LECC0HE5QhnCfD8KxSmqHwxO5UE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OsfpZFlpAVuiSaCHD+05fuWD2Y7o2mQ2UTHoFiM9dXNEg51O+XWpTIbNmm3j8p8Zr+VHGHtjfMRlhp8FZUxggovU09XAV05/52i0VgSMSBoA8FMHc8pav2L/QWDxFP6vBoSsUYj+ogbSyni08l8o5yiJPJwYiIHAg1uRZfsolCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fc99bQzQ; arc=fail smtp.client-ip=40.107.255.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fc99bQzQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwHYiVhWpfpjtJGXHujopl0ucGYbIhkuEaTGu2zOfUY1051R0iI2rtiEsp+tu8Q/6dC6uTkBhp09lyXxEMiy0Pze77tAXnKdgPXGophqiqcLznCRg/uyaeoFRmzEx+2uJdEYS0mj8v7ilJkh/XthOkoL00oPC5FHZC/0ii1tw3ZQuJynCNYNLn2T9Opk4+Eem2R2p/DoOBV9enMSeiMra89pNLkB1F2F/7CWxSwHv+uQ0cflPMsKlNsXmU0bDkTfuj70kEw/iueNlKw65yX8mVywhjWBnzeZvWXJcO/I/+QPjw0hGzD48/3n+/wBpXyF/1G+kYKSdBhoZUToTTzlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEwnnGs1ox71wqZ+LECC0HE5QhnCfD8KxSmqHwxO5UE=;
 b=TpZwx2akEHueFoZhXDAX4jnvuFsVn3uLoCXpgTr6ymjKvUfSVfwu8l5jtVfBaWveztg/ePpFVV+op9zfhDX97A/cUFElX+TEhdaF7wUT2iT5Y13fAb1W/nwYjOuNCwmvfoiLHWzhdDAUai0G4O1vTBqzY1li6LAEZHW3zcFbnFXl86oo0M2ooeFgMptwG4qJNcy8j9w2H8i5QTP/+CovvI0hsqtUpTXQ4rrctpHxh1BiT7wzm92tl5/g74u4KtOzYT2ZrPGuwwd3wic/zI99sS7ewVT/08lCuQKIGDZKTC5k/blVrkDvVQRGCuBh+JFJuSicnFsqGt9t3iC7PRLb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEwnnGs1ox71wqZ+LECC0HE5QhnCfD8KxSmqHwxO5UE=;
 b=fc99bQzQ4ColYjOc9L8pZKombW748yTLLhOaXwrfkl0VCRfUr7vcjY7kklFBRda7UaVv2MWj8XZR5iFdzbFYIQgkRLut5DIwn08nt1nFWL4mO9JTVXT1mSCqNDE3l36LdsKTSC5V3U0XUilfhqbukXrrSZfqjLmk39vBN9yPkwk=
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::8) by
 KL1P153MB1001.APCP153.PROD.OUTLOOK.COM (2603:1096:820:128::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.3; Mon, 23 Sep 2024 10:47:09 +0000
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35]) by SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35%6]) with mapi id 15.20.8026.000; Mon, 23 Sep 2024
 10:47:09 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git clone failure
Thread-Topic: Git clone failure
Thread-Index: AdsNpfAbFAaj1HJpTgym8QYEmPxgqw==
Date: Mon, 23 Sep 2024 10:47:08 +0000
Message-ID:
 <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1350c830-3ce2-4874-9ca3-85a622ca752b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-23T10:32:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0718:EE_|KL1P153MB1001:EE_
x-ms-office365-filtering-correlation-id: f1c0d7c0-b52f-4d37-d198-08dcdbbd12b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VZb+LsVSsQsTmDB9njN+PK/BlcU3aFMC6efEQE9Hiuj62ACzLmv1ShBxLCuu?=
 =?us-ascii?Q?hCUW1QCNVI+nuQ+WvB17WQg37XyMIMtYvWiaulloHYpVY4t3xxyq7EEByEW/?=
 =?us-ascii?Q?rlj4mXZGqBRZ2/EFJkDQ4mZGhl9NeCf9SQL9Ob05wr15kDg1kyuC5REzHQHD?=
 =?us-ascii?Q?jX2Jz0aO4ZOxPUbuC5bU8xlAt5l3yxCw2GpVzx+zz3cVY9r60sVgN4Twmyt9?=
 =?us-ascii?Q?ZvMAtmJm9bzvfOvdnQg0ljl5BuG8EWs5v8w0W1aanwJNDB3QSJEuxrxv/Oe/?=
 =?us-ascii?Q?gc5cPQ2gm8j+jy3c0Youtu2bbDswtvn0YaBp1w3MUreCx/wC+1NU3WIrMrzM?=
 =?us-ascii?Q?a8DtH+vzlYh57YTWMe+ZpC19RGq9wucvtYF+zzQT/mTqBe6atiTwhFl/mKHk?=
 =?us-ascii?Q?KdRCuIqzNfOgtWXLn+SG8qbjFJ3zgILAXuuUvG5RS+gAbpWhLdJigoT97QSH?=
 =?us-ascii?Q?UKowW5a/Z7KZUUeD6oS9mYBu+Kv5Ezm5aZl5goBmkhB8N47Yiz58euIqe0rV?=
 =?us-ascii?Q?EsvF1eB/MEjiIKIbOM4qWOaKt9uN7Up6qr99u9TVvGCwXjQ4bZEvY65psTrf?=
 =?us-ascii?Q?F+7WzaS+v3ew/CfyLwiphJPVEWy5w+Lz3QXgp9Gb70gy44ml+J6MnQKtsQxs?=
 =?us-ascii?Q?IFMgW0yTpaU7L9IzrozTFh4xpcec6X15r3xqTKgrP2NemXLJ32hqGpS3UiBZ?=
 =?us-ascii?Q?0Dku2/oeMseTcHde2bZH94QEYR49+1tRr7cXHx21tRc8drc0p0/4GM9P16z+?=
 =?us-ascii?Q?NlgI4CsoHimamsNWmAS1fa9fKig/ts/RXn9sjm+YGbNU4KNHDWRwFF2YXknl?=
 =?us-ascii?Q?J9Px+E4jx+I5ZLJKp2UEwItT9VAwCZ6st4or2UB+PaSYTIevy3s14MIpOx3M?=
 =?us-ascii?Q?ifpAPJExDG47UUbCUyjTT7SKoXcH4HqlWt4GwHkC3ovzQq5XwUthxNXabyKO?=
 =?us-ascii?Q?30ma9gzxDiTeLpb1FVs0pIjC01S/FZa1j1+itZ5DnkWZ1ge4zxAMA/LqU8Np?=
 =?us-ascii?Q?Hiw8oJVeLtUNzlVqdi8UYMZrvk6Wl37h7vRMnpGcRu+Thdcwuc1YrmGAQ0Zr?=
 =?us-ascii?Q?hL5204kXlPZBUJIqzfQfzkEnaSdY/1+IP79Ua44Vnu4d6/84R7rBjW674axV?=
 =?us-ascii?Q?7CSJ0DWrh0zateAGYoPtd0ygeBI75CtMTA1oT4SPJJxTt738jiXyldRc6jz6?=
 =?us-ascii?Q?aEObc+pfcfA/3O1p+Xg2X4N4ZFwjCBGu3RqJ2x1MSddmdcOi/TqkQjVRA7pO?=
 =?us-ascii?Q?wG976kxPtjJxXSgfhGCpxXwGv5oxB8DUKOHLnurvyJhotIUF2c5enzu1hWYU?=
 =?us-ascii?Q?hzQC7Soh86Ok18x5+pEGxnb8pIdRaEAFirRFDP9AhJdJNA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0718.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BYwrdYacCu6kPVZzaA+wiMKqqHyj4Rkmhz/S4+ropoRJJxb4iawygylV4FSV?=
 =?us-ascii?Q?3s4kXAv7WZekrgzXxd1Q5vUrCLqcpAjj1Exk21mPD8jJo0Hjruz8KE6w6vGM?=
 =?us-ascii?Q?nhfKJjAXmEtyrjGKSuWNFUKa1GAM3Qq1eUsReKKhzY3FAV52oQU9WG2JkvNO?=
 =?us-ascii?Q?W7YhGVJrHoQmbliiu7OqppW41CnozRFYKKskgYJFzZbCYtLHOM2V9h3qVkR4?=
 =?us-ascii?Q?C3SJ4YnVkH1ov/SwkWDAWBai2VLSPM92vJKgJz75d9qyPAJr6OlMrXHp1YPX?=
 =?us-ascii?Q?7yRFs6/J1fBnMp7AEy1vNze1PhauAWYHrKQzR2XLU0oN+4VLxZURU70Hmx0p?=
 =?us-ascii?Q?JRF9UrGsphmd2wr08yv1T2HA4gDUBkLGbw8OIs98ukpxoK4LbbCpA/ICYKO9?=
 =?us-ascii?Q?dom/7Vk91Dn87aLQO1xoHkDyPwfjU/1hxJSHVFhTxFaZ5Z4m1ixUorML0uCu?=
 =?us-ascii?Q?QG75UZf0Ky5npqSQxKXKFHs+K4NXj56CZ+oOei/C/yZerJo2o9f1uuUbpJ4l?=
 =?us-ascii?Q?H/I7ThHp//9QXt0Caf5YCx1gQT+DahXWhFzsiyl7YOr9WNpp0wWnSp0kWgt3?=
 =?us-ascii?Q?79Z6yju2XUrPjwuHOTsUR1s73uQ/Nl9/r90IgOUMDo0+kehs5nmT/jmywd0l?=
 =?us-ascii?Q?RtEZa8CKPsAgxqEqkCxufICosgSD2bhBKAHB5H+o6l+WdvVa83mhi9tsN6JO?=
 =?us-ascii?Q?Yyx6uST29FD98vN5fBKf15uJ85amvHbtSeaWSM/xMimV/rEQWh3MCAl6W+Qa?=
 =?us-ascii?Q?zgBWwyBoGeL/PLM489fP0oK85nXkhmCTdsMyPrIzTRsknJeyKveJOSylFlnG?=
 =?us-ascii?Q?YrhlxbUrDEfi8CK6s/E3Wk2c+gNPju3W7R3cT/wwQ4CHX9jwZcBsg0tuQRG1?=
 =?us-ascii?Q?t/pY++OdpmedLD8xWJM5KL0bZpb0EZDWU1mJExR3iitX3JsUoLaqzlZuZby8?=
 =?us-ascii?Q?d+kOKp/NavvL47lYbbKoPvyI6HBWvZuTmgDCOlhY6nNBKSo82P/2PPlll2vd?=
 =?us-ascii?Q?QI8tnCo7uX7gGBqSJDnBvbHVy6bFzO5yaTSKI6zdiroDTWFQtThTf8AoXmD0?=
 =?us-ascii?Q?dQQN/SPzzrVLgMI29lGbgG2O9+YYvZKqrk35Nea/Mg4tt3d9kGW0cT1PM0UA?=
 =?us-ascii?Q?sPUm1SXIBme3FGIED45J5MimpkmUa9FLuuHzpN8wuJGU0t2bLwRijxZ2Qay9?=
 =?us-ascii?Q?m0c/VsOm+tgSriKRD3PwKhIlW6PGsyPOeVOOqmoxD5BrSWQHe8wUNrtm7Nf7?=
 =?us-ascii?Q?r9yuHrHUbkXlnR5cZns0WiAd7BEUtoFPPVm1Q5JPgsz88olSbv7NQVbvixcX?=
 =?us-ascii?Q?UCntXZ7+M3oXIvdhhoPI3eHOp3poz1cdEqHJHm8cZbrbUcgmiwAqNU6yl7z1?=
 =?us-ascii?Q?k/5QaGzLHx1TMPCSUTlEfH+7DoU1U5Q04fbFRuPeib6V1Tb3wnLwfz5Hjekw?=
 =?us-ascii?Q?VmAoH/VyYrygdqQ3fJ4KFxU8DfsLnKP6R5JScWFdonwLkcJQDu7wbLVloddx?=
 =?us-ascii?Q?IrjoJywt+cjy7UM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0d7c0-b52f-4d37-d198-08dcdbbd12b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 10:47:08.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjfXQEo1cqsTujE0Nydd+KvCVG9iEcQr40fYLUfO0Plq46R9IkLeWXBsVAIMXXSccb+FfV6N07oGrd1i7PAViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB1001

Hi experts

Need your help in identifying the root cause for issue.

We've seen multiple reports of git repositories failing to clone / getting =
corrupted in p9 file system. The mount points under this file system are ma=
rked for FANOTIFY to intercept file system events

When we remove the marking on these mount points, git clone succeeds.

Following is the error message:
kvitta@DESKTOP-OOHD5UG:/mnt/c/Users/Krishna Vivek$ git clone https://github=
.com/zlatko-michailov/abc.git gtest Cloning into 'gtest'...
fatal: unknown error occurred while reading the configuration files

Any reason why it is failing ? Any help in this regard would be highly appr=
eciated.


Thank you,
Krishna Vivek

