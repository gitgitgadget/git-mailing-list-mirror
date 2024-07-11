Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022107.outbound.protection.outlook.com [40.93.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624716D9A9
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721553; cv=fail; b=afHgmt4VeMcz74AP2huYNdCIEyef4UqU7b254HcGzDeibt3tEIJNf+rY4tGcOEXjMCqzNU/mZyUTceAs0G2hq7F4Tr9hVHSolN4On/fXJg/5pODI1EGb7uwq88edYGtQhybU/sICsAxWu9P3G+ZJZD0DjTHS+zw7qwTOQb5ArPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721553; c=relaxed/simple;
	bh=j+jrJV9hIBOgh5k/AL+SEaAjV9xGmQBCgrQLceaYN9U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OuCv29052ZpNOqldNr2AKYITy9FQtGutqKqLeYnu5p/cMCM7sQu7MCgLpeWLvCcoux1LqS+++gez8Bf9Wl60bdKFdB0BVs7FlJw4fv23pnxCumPxHhBY4z8XkBzZah3KOXLL1t2Ai5qmZ+VfRkx9CEeh+UkyS8/RqC3aoeO5p8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aRo8cWRF; arc=fail smtp.client-ip=40.93.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aRo8cWRF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjcqny8JYt6zHJLNRUJr7otZw/+SlHcRQ03EKI0rAwJJkr7reXa5Khy83eK4XQHBByxOnrGIv3hH3EI0KV4kI9oIoX9ANhe6Lib35R2sL3yskxtiWFOO49IFfdUW67YR174HHLU0AHntHhC0yfHltS0//O12j/w+RBu5HyWmb++2rUv36JmMvMth4FicxYA5ov2rOyKz3Cb73NjxDaFY3NUO0FCmPZvBbeDZHRm7Q8fNEHw/hn8Kxv0lcllHytuCDY6l9cIoLTNMxU0YQCsS4QaAD0sqHtM1lVrSnKy+RU/V2RwZlj/TnQR7Iqb3s283GC/zxBJx4Bes7jwHSYQNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+jrJV9hIBOgh5k/AL+SEaAjV9xGmQBCgrQLceaYN9U=;
 b=wZzLcriubAmHdHxaQB1yGcwhGRED/44V3kq5ht+39CrsZK2dQCnrZ+yf6IhAeZz35FUslq3ovKm+RBVCamk/NfBd1Ffe3s6ica/L6QbAOXLeStE0bLWBillgEoZXm1/MFb5IWcFUrq+LsXTwerRVrm3A5ceXVYeNAuDdP5SR7/bD766FnjfEfF1IKbAjEkMtPXI6lcZ66cfn9mSm2pcqYhSQ06nJcSFCj+az5C5X/cswhtx0AwceNyyWjKIQavJmUzKFjKDy8F0X67u9W8v8uwlbxM9ygqpvv41Y+xomqh+fTnKRsig5iYQ+nWlM8UeiEP/yCGf4ODoe0wD5/Gx8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+jrJV9hIBOgh5k/AL+SEaAjV9xGmQBCgrQLceaYN9U=;
 b=aRo8cWRFkotDrw/ohyCdcEf3gPBuerRq/4VHq7jTGKUk4nlQsIwrAbQAmPVE4yznptirIULwZ7Tu+ral0Kgyguz3OrJ5wM/16EEbg5x+hvHGbRvp722BhHFj/ZUw/ml+nRBRqXsQYGzJnne4y9FdojjzlzI2dqSopLnoDhmRyyY=
Received: from DM4PR21MB3537.namprd21.prod.outlook.com (2603:10b6:8:a3::20) by
 PH0PR21MB4529.namprd21.prod.outlook.com (2603:10b6:510:331::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.6; Thu, 11 Jul
 2024 18:12:16 +0000
Received: from DM4PR21MB3537.namprd21.prod.outlook.com
 ([fe80::26e9:3a97:ac05:72f3]) by DM4PR21MB3537.namprd21.prod.outlook.com
 ([fe80::26e9:3a97:ac05:72f3%7]) with mapi id 15.20.7784.005; Thu, 11 Jul 2024
 18:12:16 +0000
From: Jullyana Ramos <jullyana.ramos@microsoft.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: rev-list does not output commit metadata (nor honor --format) when
 --use-bitmap-index is on
Thread-Topic: rev-list does not output commit metadata (nor honor --format)
 when --use-bitmap-index is on
Thread-Index: AQHa072wM6Y7JBROdUC6cQdtw7wpVw==
Date: Thu, 11 Jul 2024 18:12:16 +0000
Message-ID:
 <DM4PR21MB3537F74639094ECFA909880C85A52@DM4PR21MB3537.namprd21.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-11T18:12:15.454Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3537:EE_|PH0PR21MB4529:EE_
x-ms-office365-filtering-correlation-id: 1712f955-84ce-4b04-e641-08dca1d4ff4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3druqVbYu0eda2XXeb1Euw7pFogAkBXzDkks4jAkEWw/3MFhbnKu4SXTx1?=
 =?iso-8859-1?Q?fCPBhwd0PjvMCXSKctI/Nh4mfJ00A0YFxTlh+p73o8LZXblEX8HpdCR5NW?=
 =?iso-8859-1?Q?P9k/XvWQ5KgYFZPZtX/G4ehAxzgCC0/sRFB1SV69Y1wlN9mcLhCo0dbmpU?=
 =?iso-8859-1?Q?eQh47asFM5/z+BbfYQTCaQKcS20uhcPIRhQMgAtXPaOTqiOvKmJ+ag3zmy?=
 =?iso-8859-1?Q?o46fMIcAuPpNpcj49QaXioo80pUSBjqr++aQPtstV8Ug2HToHCy6ctaR6J?=
 =?iso-8859-1?Q?hF4LUnL5OqubmhWtYtsmI4iobp4cAUBUV09v6BbVfa6SZsat4XuEqekCt4?=
 =?iso-8859-1?Q?ZIpdv/JByAtYpeLBFofgoFqmKkfOpVS0QqP/x5mn1QRhYWTP/aMYU884Qm?=
 =?iso-8859-1?Q?xHJIFToW/J+LyJI/ojMj2aesjyTzvjmhlhpjLeVy27sXxmBHvFKNS6hd94?=
 =?iso-8859-1?Q?bmBRj0v/FbTLps1EC4kcxZLlSLl7gUZWCT0XKHKqFUXevdWvsit6wAzGvx?=
 =?iso-8859-1?Q?8lr27WauChgX9tD6pTF3Vw3ndMpKXyCKdVA7GZPyi2S3t8Dv3esau0mFVB?=
 =?iso-8859-1?Q?2h+7f6FqWknEZf/lqKdlgnspHdVHQO/qG94bx8ilnEr0S3u7OeLE0p4NnI?=
 =?iso-8859-1?Q?uhsuYF2+j5KxVjsEScXVMGWRwH3DbHsU7KvCof6a7PvkTLjpJPUofyYwFF?=
 =?iso-8859-1?Q?aBB8nGsT29j7tThluWjrIeAiBNsf8YrdpGtdB0B5jYJMdW7DEh4LCJK+8G?=
 =?iso-8859-1?Q?4kpZg8XEzXaRfCxegTr5Vgt+wXgvUG73P87gla0umLP5kFO4E6NA+702OY?=
 =?iso-8859-1?Q?7mXiEHNsF/EleY0+cnbX1WazFqicGuZK/gZH/3eJL+uxCub7CDJdxXgF+3?=
 =?iso-8859-1?Q?zkN7/iMWCmDFt+Ark11lMYd125EJCp3IMxCSW0mFqx3+fxtLQHFCqFpldF?=
 =?iso-8859-1?Q?jrq9dVWh1QK9E0PqElgq62oIubyyTEdFx89gv7Cww3DCYZWDfKapTAZF0x?=
 =?iso-8859-1?Q?l5rZLffAdovN8aZUSaMOBd2B8HgH6NElLnWr/laVREBKOqwNdzp0UHwaPP?=
 =?iso-8859-1?Q?cCkC1QfbaLnElgiVPyjFkEBgIkWXAgbCzNI1w0joNWkOmpg5Xi9V41BhFZ?=
 =?iso-8859-1?Q?/rs6vWLxc4Cpzcu9/UkfafAmtFIAGXVLqav1yIDWbJTrx4qXrt1TdNClvq?=
 =?iso-8859-1?Q?UK7K2+nb9vqQnLnXWL82Dhb3OpQBDMBmv+ZRIuH0MWhHecBkffP0eAWqTz?=
 =?iso-8859-1?Q?XPr//zZyBVQlzpxpuYc+n6Ta+dmENuDxfZxN6AFEB5NgGhaxEB5LSkxW2L?=
 =?iso-8859-1?Q?jfPJA+xaF1C89rl/9wg6CWFwq97n2oPp2+cFViHIESYrMmH6NtJb5ngoet?=
 =?iso-8859-1?Q?OMaQRivkY1cvVQy1VM0VVQbPX5J8wIo/qADLuGFXQoL9WTGLu+liq5PLwx?=
 =?iso-8859-1?Q?WUJdeCoiAR93Ev1SMJPbYc8JZteXsiBrnIfYvA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3537.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wh1G5FT9m3Tp+v5IDlttHGJdkXZXqK1bpvi5HHx3SoeYY6JMohlPsO03PF?=
 =?iso-8859-1?Q?H2LOM4+B+BX+4/hvjtjrs3iEz+zJzjov2FDLT8qM/dlRvCgWWvt/AnenGZ?=
 =?iso-8859-1?Q?32xqO7jI398T8EKccktGKVR1oL/pm3IN6xFsUxt7JOkg/4qsJsnU9hG/qt?=
 =?iso-8859-1?Q?w1jH+505doE2/f4KpSqgYOHO0EPcYc5+9XT5CHLtSB4s1WIvkTWqjaGbdU?=
 =?iso-8859-1?Q?QXINBH8VbbsauUXY5d/xphxAQVMG12rMm7A9fJYaKQCITbcwun1okaNMR3?=
 =?iso-8859-1?Q?p37Gc3nkif0MVvTxW2AH12QUyXYku+PbACBrA39GtqKS0jykdl0NFnNzMT?=
 =?iso-8859-1?Q?0Yy01u4F/7PTUSxkQAqGllUB3a6RWV1Hj+mv0IEw7Z5v8pbsmipD+LEWk8?=
 =?iso-8859-1?Q?aL45kkLFoiUE7L6Bmql12hr0OVPNqvTBsI8Yk7/YWOPa/9Mm/noo5W9ynz?=
 =?iso-8859-1?Q?jKe7KQLKPtzES79xzfkRe99KYGhXlf21YGSWZZ3s4V4dIlhBv3CzrXCvm8?=
 =?iso-8859-1?Q?oMpMdS/iUgus5GZ5LZaUEAao327n9NnhtZPAQhmYamOVkGC4TD7fz+hQ/K?=
 =?iso-8859-1?Q?XuQDAX+Sbfx9OGD6rb73L0PCVqK2xTSNAnh0UqS3VUWLZmYTsr2bPinpwU?=
 =?iso-8859-1?Q?9sJVHaB5BJfHl5hkS3YkIZm6oEQKaQHFrgDtPU5QPMYBP5Q1gh0bVCrCRt?=
 =?iso-8859-1?Q?JD5Egf3k3zy9bHu2AJcVL+JfOUt9YZ0EMP/JNtszpIa3DouciAv6P1OqvB?=
 =?iso-8859-1?Q?+f8E8r5V8Fyi81GvstXdNFBCntTPxJpyxLCcrWubho37oWrqMqKcdY5o6c?=
 =?iso-8859-1?Q?Zttmhxc/XxBamZ5f/dysJ/znukslj7k+n060kD0yYFhHNfNax6iRAu2tQm?=
 =?iso-8859-1?Q?e2+2BPhhnlF56nv0PmaE3sFXkkPSBljKthHTjGcShn66YDpDD9E5kQSqQO?=
 =?iso-8859-1?Q?xO7gA8YD1XkMEgPZY9y1jJIFBX8RO8M9gc3pcxx8izBfLLXEdBfTNFg5sI?=
 =?iso-8859-1?Q?Xz591IlzYLFZAgtfKttLAVseyFkOtQM65E9oXWNc1rHlk4ovdQF7E8dfzp?=
 =?iso-8859-1?Q?nZ3ENEafm3Gp3pK+qmT7mqNw12B1NaP35GuFX7Dr1kL1UdwDgZmIfVc1lE?=
 =?iso-8859-1?Q?E92sfHcavqQStBJC7hQAqL0UO3d3vSc57CYycw9AxROvbLwXyNfbR3VjSN?=
 =?iso-8859-1?Q?t/MzNjf8TxiE7LlW50OvEg8uonlpObOXzMJC2Yl4/wdAzQm5kbP/GhoEEW?=
 =?iso-8859-1?Q?MMBLs9AR5mAduK1Fwl5pPYtCxCJNmqXhp02bLQXhSsejHLPS0mYQV1u+DM?=
 =?iso-8859-1?Q?v0qzxJdI8MMXCFszx4Sp/bnzfkuvox3DEt3uWeZ0qeIWVpLC/Usr7AZhRk?=
 =?iso-8859-1?Q?0awTz93FQRnMznkOW0rDwa+XnRVJznfCJr1+ai9HfLSoLiNIVdkUXcvSJi?=
 =?iso-8859-1?Q?FRKRvFtlYvRYTZ+a5AbuaKp6Y8hcUVqWCu04MZbef21m83EKwfHj7Z4BV6?=
 =?iso-8859-1?Q?sg8GMM3B9WbZcoUTHsIJePfuiRe+KtX2nfyPNVRVyLVj6NGsXIhEjShQF/?=
 =?iso-8859-1?Q?QIep8knvfBgnKnYdSxzNUNh9BNQFQJmHqrmTROiYpY55ASIuCUF1dAmcYw?=
 =?iso-8859-1?Q?XrNoOqlhHYJpjX1K857IOZDKIACqpHou92rG7UDmTFMFrcjCzukwSvGT7p?=
 =?iso-8859-1?Q?/J47rZRulckRU08DJk4EeS2SbQiL/jpJ0ottqMt8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3537.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712f955-84ce-4b04-e641-08dca1d4ff4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 18:12:16.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ev0liVLHFr2nm7Ixxk4rDkyyiIWbUcd3oPkcmQTNp9oxtyFaqM5J5CZR+NOONUfpT4s1OafHcFbAAx9KRhjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB4529

What did you do before the bug happened? (Steps to reproduce your issue)=0A=
I ran "git rev-list --use-bitmap-index HEAD" to see history while taking ad=
vantage of bitmap index.=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
A list of commits to be output, including their metadata (message, author, =
etc.)=0A=
=0A=
What happened instead? (Actual behavior)=0A=
Only the commit SHAs are being output, no matter what I pass to --format.=
=0A=
Note that this only reproduces if bitmap index has been created for the rep=
ository.=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
The commit metadata is missing.=0A=
=0A=
Anything else you want to add:=0A=
I work for Microsoft at Visual Studio Git integration and I rely on the out=
put of rev-list to populate commit data into the IDE.=0A=
I do not know if this change was intentional, but I can reproduce the issue=
 with version 2.34.1 (Ubuntu) and 2.45.2 (Windows) and I could not reproduc=
e it with version 2.3.5 (Windows). (I know, huge gap, my apologies) I did m=
ake sure this was a Git issue, not a Git for Windows issue.=0A=
I can reproduce it with a brand new repository. Create a commit, run rev-li=
st, commit metadata is there. Generate bitmap index and metadata goes missi=
ng.=0A=
=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.45.2.windows.1=0A=
cpu: x86_64=0A=
built from commit: 91d03cb2e4fbf6ad961ace739b8a646868cb154d=0A=
sizeof-long: 4=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
feature: fsmonitor--daemon=0A=
uname: Windows 10.0 22631 =0A=
compiler info: gnuc: 14.1=0A=
libc info: no libc information available=0A=
$SHELL (typically, interactive shell): <unset>=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=
