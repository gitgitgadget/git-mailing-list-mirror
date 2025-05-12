Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020135.outbound.protection.outlook.com [52.101.189.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916A19ABD4
	for <git@vger.kernel.org>; Mon, 12 May 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063177; cv=fail; b=uzVfrSsvSv6O7p59iDfVwCp+aXj+wXa1WSHUmsenkA2XQmSZxAng8qwa05/UxTdZv6vJI9hA3PIp14BMgGAV6+ac3htLFdh9QDZp9tnY2Z9XVARKZLaY5S1wMOY2b38rqN0qkB4vK2l+2zT/TwB77MQeVdyjBqFCArmdHY2JEH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063177; c=relaxed/simple;
	bh=upEyAZBZ6JDOsaW8Zw/Ams0vIJFDjsJ0Q2Dn4gvW21Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kTMq+BtaJwG8NcewzSmNZnrTufqHUcZJCbHfTwBZcOnPHC1kmU+BUyHO04FC+HSA9Zc6kvnX8iRTdkoMS0OZEHF9qEjN9qrQdNS+2nHobut5SGNKik8mz9Q4WaoXhc+d7e0vqGRXULH002KvBK/VWnOiEnzjNOptOs/+D3COzuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com; spf=pass smtp.mailfrom=kaimaging.com; dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b=Z1DYbEhD; arc=fail smtp.client-ip=52.101.189.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b="Z1DYbEhD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vogXha5rwRzBgvpTNy0wuhI1H3aias7sFuJztUue6iEtS+nmVRcrLpeNiF80SvB+wztjHnLRrQuZ3tWUjgsw5KQYyv3+ntfDNX+vxK0nlnMK5TSFtLdj5EoRMJazA2og2be7FdzGVQXC9VhfGchyVIuvaGx6BZTi0WBkIQ2Ip5BGhb1f8Zh2erTpW7aBOJ7MGU35FsR6/CWsEU5EZjqnvVQs4cejC570Xb/tBuGe1NCw5PKyTGacoJ1DeCxnEvyTyAFjTl9RlSItyRrWOipnwSACVsiI5dr43L/jPk+RAcFN/ExoxixREO7NvFCcLkWtTyV74x+HLF6O7UX1lzHNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upEyAZBZ6JDOsaW8Zw/Ams0vIJFDjsJ0Q2Dn4gvW21Y=;
 b=mb2tI6mKHtoPnIIPsEIaLNLE2psLr5iiPBppvR9LabFwCXZ2YYGjJRESF2otuxe4K5wn7QMznz9PbgkHVHFQDt07YrcZz4k+j4TTQgoeEQDv3MakzvaBS1N22yQVBfVicW9zoMS3FNb6CBU1+MqfSf/fwS/tPHnBfxZu5z4LJKZQPIZc+b4egETI5MscefN/k47TIEJ//lQwpTNf35hGN92QeSIf11KEeZX+KSvGfy6k6MOxLkW2jLRw67S6NYEyIQzt4NfWEAJnswXbODyyCHNOJ7BqNNqZ8gMIcyA5L+23CMQDtMpBADOy68x65cEh5DJTdmm7tttiETg7vvJxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kaimaging.com; dmarc=pass action=none
 header.from=kaimaging.com; dkim=pass header.d=kaimaging.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaimaging.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upEyAZBZ6JDOsaW8Zw/Ams0vIJFDjsJ0Q2Dn4gvW21Y=;
 b=Z1DYbEhD64EnSi3MhG6aitZj/+F1dvag6gYSKs64O9l7DUcXXjXAKBumV2a7BUIJQKRDA6DNYjOabCbUN85eyVlJ28/NKoh6AsIRFiUNRS4pboNXH/EulX30AwNA8bFihJ15oGyQ44tGRaCY+tkDRZrr6t+yxbLoz5bD7Wlt7Vo=
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::626)
 by YT1PPF6999298D4.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::546) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 15:19:30 +0000
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e]) by TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e%8]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:19:30 +0000
From: Stuart MacDonald <SMacDonald@kaimaging.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git stash incorrectly showing submodule branch instead of
 superproject branch
Thread-Topic: [BUG] git stash incorrectly showing submodule branch instead of
 superproject branch
Thread-Index: AQHbw1B4HYk/J1c6sUuEX9hsh2ifmQ==
Date: Mon, 12 May 2025 15:19:30 +0000
Message-ID:
 <TO1PPF29324B4CE6D3518208073452C3C51CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kaimaging.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TO1PPF29324B4CE:EE_|YT1PPF6999298D4:EE_
x-ms-office365-filtering-correlation-id: b92336ed-4366-466c-7d06-08dd91686440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?y7CtjTDciIINyfCImyJNc7lBZ+avDVwtLaX3cjKoM4GaKuDAPxqFLdGA1/?=
 =?iso-8859-1?Q?6R7BRZJai8nHBZaHg/mg1mjTkZtBEhEUc5Rmg9Jd+cMS8Ro9tVFQFwYt40?=
 =?iso-8859-1?Q?Ubg4K+9E1KtZYSKOaEm5HtYtkES1saRAKQGRIVGhWsZ1xYzWLacFsUIJh5?=
 =?iso-8859-1?Q?fzFfmE0sjnBAm6qbeA32Eiq7g/YbGq2iJ9l7E37XZsNoFz685QGcsu5Ol3?=
 =?iso-8859-1?Q?lZdSBMAsteEh8Ds4Hp/XUgA55oBFPwUfkWL04406zES5pkxkwapTnS9Az9?=
 =?iso-8859-1?Q?TeD45jZqbOr5mQZOC/fBdUF7gSwMWwlDJbIfvpluObAX2sxRxkVlwC6Xwg?=
 =?iso-8859-1?Q?IC6YDsQOehb/3TI1u0hIOpCZR6LPXC9ZVT/JD0loZ0ma50CFeqG/4HJ3PV?=
 =?iso-8859-1?Q?XAGEP6szXV1zg80oDtq7OArpJBCani7vD8Ql4iYq4mFvDERYy+9Hj+18QY?=
 =?iso-8859-1?Q?n/74veasVD+dMMCTxp0VlGfFlzInbHYxPODOposIduCX2GQnI6bi1W76LH?=
 =?iso-8859-1?Q?1Hjc+LM9w7S3Q/sJYVNkiDSpAIduSrHWqoZVXO0EoxJQHte4i4dq7u6Ndc?=
 =?iso-8859-1?Q?5rxUoCIUvcwcvyDCz2okvl3XTBWxeE+LSQJhmILvsyd+OMY4tdtw6plfrs?=
 =?iso-8859-1?Q?Rhkr5ebMKkdDqoVv8p2ud5FVly4uEqWNJIK49cz84XvondsFvw1Ml+H20g?=
 =?iso-8859-1?Q?0gM54cbRtDfKldRuV+GzxrGWK4RiVlwOHCTn/DY8vPg2bJW7/i5mtLrS/l?=
 =?iso-8859-1?Q?6v/ssJKOxWVQeUfWgtoXcPgR/z0WuqLjl5zYIvS7pJdHxALZllcDS2ZW8B?=
 =?iso-8859-1?Q?qSpROb/NposzmAc27tQrsuj+thF/0Fz4xscjkLujwD9Iw2NedgbGXtYunw?=
 =?iso-8859-1?Q?XEaY3UzeG7ivbx02Yj0cy1IJHaHAQMvTNyta+6miGYy0wMyU3kDL5cj4eb?=
 =?iso-8859-1?Q?9A0af1JPb+ZdpE3tDq91H4J3HDM8ZTbn4tbsHY5NLrQTZKX7OXtdxAduEc?=
 =?iso-8859-1?Q?cUS5nCX/e1XWAqJcojxstvvwn9K2ILIJDcL4Cqmt6iJ3MypfCb/Q2ycryo?=
 =?iso-8859-1?Q?usoL3U0a28r3F9hWO95Jw7rx99i771tILxU8QPPWhBHNMXVY/I9RtCHE0e?=
 =?iso-8859-1?Q?VZS6Ylz8Vvxfej7YrXrLk/mk/9aV/DSOlsZYEvLKpGQQQ/DPUP65c+3NlG?=
 =?iso-8859-1?Q?r9JWPLvyVXiocq4qJo+LS1lbRnnfSW6D02UVA39FKdbpqAPE/au1zRQ6jC?=
 =?iso-8859-1?Q?COTYSML3egDrNMG4BKHii+R1npQmVmFUiM3zYwd7AJ4fWUntlXX8uytPaG?=
 =?iso-8859-1?Q?58abMafpAFrOYxVDx/AwCVpaHzQg/G+g6rhAFCWUjl7dm01wLif030ZKCK?=
 =?iso-8859-1?Q?9v1wlH21EtRyKhw5lbtUVULeWTO/NlNydmuwrqXLAl1w2R3EUnprtVRw95?=
 =?iso-8859-1?Q?Tgw/dRMjBWmZk+FqXxzhQ4optAs9fE4NOAAa7CXTqP3lumZuof/4FQwO3c?=
 =?iso-8859-1?Q?MR6S1h3vDUIPlXbY48NicV6dqy9CQnmMFk2EAbMEeGLg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oOz76MOwiSgqjZ61gc1nsAJkmL+Xm3KlzeN3lQZC4nbmvk8Mcb0wYtHQ7e?=
 =?iso-8859-1?Q?W9h7ZsV58C9793ttwRiwVgYhgS/6FN2iDya4MJ05XvJMdvLx4txGubhcsH?=
 =?iso-8859-1?Q?k3flE9AFAVxTUBZGsTGW4D5pv9HZgGvAdFXnq+AwGkqLDVUW2xrF17QTY4?=
 =?iso-8859-1?Q?+TRHtjdxd4Z0RTRhgXefxDQ06m5QVKaz2ETFmRxT2vk8rjNJa0SFItA3pK?=
 =?iso-8859-1?Q?GfMG+v3t20TpJvtV77PQBiiZGr4rKdtjLgMOUKgn41WyuAxurJq6FAclMl?=
 =?iso-8859-1?Q?5obopWONbF3gNa0TebF5mvVcCwBLiBwdfB6ahrDVG0o8AtukF2FeZsIi+u?=
 =?iso-8859-1?Q?kO9uHGGOwYTJhEkuUNrh6SXixaYFzFBtdD/2hNdkwknnZy+qexkz4e35I2?=
 =?iso-8859-1?Q?9YQVR1PXikWwr1USQTWqsxu5fipBwNdawyPGg9c64WqqGeaJQSIvx/iuYr?=
 =?iso-8859-1?Q?pi3xe13vVr4+JNDfhE1sZRZ+V9EXD1eWTB+N0lyVS35SWzI2dBiKxUCiqT?=
 =?iso-8859-1?Q?T7tstX08SS6iMcdFWuo80yg0O8gyU0NxU0mmmJweg6HQONeO0Eq/ZVh2X7?=
 =?iso-8859-1?Q?eqxSFcOPgiSScmS7+0/G8UPaJyjpjdFHA7TrKEjO15PwRt7rQg+JRWHj03?=
 =?iso-8859-1?Q?yySUZgyoDrTc/0aa+0ckx1wBD4HrkWAZBpfpvFvCDfME+jxKaDAmXw1mRp?=
 =?iso-8859-1?Q?unS2PoMonJkwRfMftvGdBaAoB29nkWfuTwPTncBspCEpBOrvsPoFrlkQds?=
 =?iso-8859-1?Q?I5xEKgnVX38tPX7pY1le3ldy6X/SG784I1LyZyDt8f/t20UM++2APrmt02?=
 =?iso-8859-1?Q?gGt3h/pN4Vtkim2zPNDL0cIBcvnUETpOi0SwyRsGC3ujuVCmkFnuGxks+S?=
 =?iso-8859-1?Q?sAqp0yurdktrruZXGnXnM4gStIx+WAoLF+X31g84fig2phA8vpQZVCyy0b?=
 =?iso-8859-1?Q?0Ru0PaXbPD7d1yeXW/xUZEd3DPlH1suGKAGOSaOqej2bDxRfcVp9MHJxqu?=
 =?iso-8859-1?Q?UmYeWKxuxcDAi7zkg2RGya5tVmkygOMTiqnBDgfja8uVSgjjzlTYXIn5BV?=
 =?iso-8859-1?Q?urNidr6ZW+lpjvTCBJNASfep6OjnzyYCzhG1Xdi60dPP3OHeWgJe5Lh39U?=
 =?iso-8859-1?Q?BHstDBribvkHc3oh45QOJPEZpOX5Aa3c6WfeDPUQlCbdtZuioqQWJ/TpQ7?=
 =?iso-8859-1?Q?MX0Qmec0Jx0/Rsv0A0JgCru3ez9BXp6A/mJqOwReG2hqIQPWh8fCPmZ7A+?=
 =?iso-8859-1?Q?gl5Uzh767GEmdNkUrN7DJHESjEeRh7ox6rGKLJ0LnviN5lBvKEVzWV2Uxm?=
 =?iso-8859-1?Q?D5guoB0Nb8EN35nTKmx59dHL9d6J2RBPdKJZN3IbWTc158nNfWrTT69Gx/?=
 =?iso-8859-1?Q?x6whO1+Ddy4JFjnFvZbLEYViavQ034IeTelyAujsxfIPCzNd9LERx4x2H8?=
 =?iso-8859-1?Q?o5Af+H1pNZIzxlKfIOsmB1VE85CyChJJ7yLlQc80+45o7SGVK51zgOwnL/?=
 =?iso-8859-1?Q?VJ2mJDpN7DQNndHhn77w/z3UE0aaxzRInQ/GI7Vr5XgF+/CGD3G7j4gVjK?=
 =?iso-8859-1?Q?R8FNw5l2Uq3DMms9aBTkG/ZAMetL+JsYdia2ACYWuNHZDYKgPajMDt/TUP?=
 =?iso-8859-1?Q?8UwngbNVXIf16qV3F+RtG/N74PbX46Ow5V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kaimaging.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b92336ed-4366-466c-7d06-08dd91686440
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 15:19:30.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd646163-ccd8-44eb-b4ed-abc194a640ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6nCUNzRKgGaWXlF+xktJSsSfqBSJxPed4Nm0LbKgSaf1Rf8rcTefB1Ecgm7JBVc/dzBjUMAfi11prqoDNNGRx21W68ZKHDX5Q3HqN+hikc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF6999298D4

Bug report inline below. I am willing to provide further information but I =
am not subscribed to this list.




Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I am working on a UI that includes the hardware's SDK as a submodule.
Both the UI and the SDK are our own code. A colleague is working on the
SDK.

- clone out a project that has a submodule
- set up submodule properly
- create feature branch 'feature_foo'
- move submodule to colleague's feature branch 'feature_sdk_foo'
- develop for a while

- in superproject discover bug, fix bug
- create new superproject branch to contain bug fix 'bugfix_bar'
- leave submodule branch as is; I'm intending to return to it momentarily
- commit fix via 'git add --patch file1 file2 ...'
- save bugfix debugging via 'git stash push -m "debugging" file1 file2 ...'

What did you expect to happen? (Expected behavior)

'git stash list' shows
stash@{0}: On bugfix_bar: debugging

What happened instead? (Actual behavior)

'git stash list' shows
stash@{0}: On feature_sdk_foo: debugging

What's different between what you expected and what actually happened?

The "On <branch>" says the wrong branch; specifically it's the
submodule's currently checked out branch. I have a number of branches on
the go, and need to rely on stash telling me the branch I was on when
pushing to determine when I no longer need the debugging.
The said branch doesn't even exist in the superproject.

Anything else you want to add:

Using Git For Windows on Windows 10. Using the "git bash" command line
git, not the UI git.

I'm pretty sure this used to work correctly, but it's been several years
since my last repo with a submodule (circa 2021).

The Git For Windows bash PS1 prompt lists the current branch I'm on in the
superproject, so the error is quite visible.

Reading the 'git stash' documentation didn't shed any light.
Googling didn't reveal anyone encountering this problem.
Searching git@vger.kernel.org didn't reveal anyone reporting this.

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
uname: Windows 10.0 26100
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
CONFIDENTIALITY NOTICE: The contents of this email, including any attachmen=
ts, may contain private and confidential information intended to be reviewe=
d only by the individual(s) or organization to whom it is addressed and may=
 be legally protected from disclosure. If you are not the intended recipien=
t or an authorized representative of the intended recipient, please be noti=
fied that any review, distribution, copying, saving or disclosure is strict=
ly prohibited. If you have received this email in error, please immediately=
 notify the sender by return email and delete this email from your system, =
including from the deleted items folder. Thank you for your cooperation.
