Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A014B086
	for <git@vger.kernel.org>; Sun, 25 May 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193144; cv=fail; b=iMMejhwy13ByDHOymHWrguCydEbtamrx0LoMwc/WA7YS4Xwc9oKBzma0WvyCQ+EfMCY5/AOkq0g+1NW1+M2mRtzOmScdXikkurMPuDOe0pq2WZf9xA+xkcZkGQSe+HTuJrlTiolG5qm28yHs9v1nAW0d5AUnnxZ5Q3oqgSVBwWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193144; c=relaxed/simple;
	bh=riWvlmArkS+4+e9qXMH9K82bkyN+RWBhBre7QLFe3S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXVw1+K7aE92aM6oniEUSZE+aJbjol3z3huzY00q903VvwLfBRcnX2SjVqJGYAjhezWy3upD0nHMyonj8gfg6AhqHgGrdU7fXlgDzJ+AM6pwqPMufJjJ6osCOoSMYofciBM9/uZDD79FVm8UtJCsHVmJQf2k7UIsiDWsiqOiF/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=h1GZs9hz; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="h1GZs9hz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5UNHLVUc97thxZEDjz1t0WzuyE/Dr9Qj5cqMNpnq389uTsh0S49YO79sHE7mvPJfz4wDxddwzf8nJTymgHmGsq0/VfXV60hNBn+IFwQoKa/qBGk6HHrCOZrL8gghxEJNAG73STHWRSEThWaeGdTWhy4pQXzahPusIslCqEXQ9BT8zHTktkMw2Qb0rLtpV2guLr45JyNRVpvFx8G6ZdEB1tv72sKahPVThVziB6/Xx3FZqe6WCcyHtAVtSErU/Vj9nlc7mT4oXFlGJhF4Ue0ShlagE33kLfb28L3njECxyt0ElBN5tqgqJXR+jAOtfKdz2UtJa2zMDAyr3DhoZVNzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmdOH30SIQg9Lz0PtSTDGGK4Q5ZBwLE4/kLp6x/g8Eg=;
 b=yA1Ulhe66xOSJGmZ0DRsvbodqKcSkFKNmWJLPnWKqeF+UTKsgCTSIa/pXFJLNpYvR6oVRruvFAhbbhPSRJbFNZ0hdv3hSbfKfXvDchlSGUdsxeuCA4YgQb6ioL5e/4sKRkTbcGnG/AHUiUpwbSWRbDTkUbcXu+29WiXKzIf46YYGbwhxCsGpVt4kNZJzWhwQ25TDD44XMwdFG4IbHpp1Qg+Gw5ppmsGob3OgeoJh1h5wAoSjkqgshg8KImD1htxVr+fy59dyki/+GznFDfKyVoiJPC2ntWXNeT5DTPTHkDqXSeY8HI3wpj46iiGF8no3UeYpxZC4aZrLmVv26U5D/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmdOH30SIQg9Lz0PtSTDGGK4Q5ZBwLE4/kLp6x/g8Eg=;
 b=h1GZs9hzCNB4Hu5siaI+e6u9MpddpXwa3znaN8563PLjcjB8bvhVXeToPl2VdqyRVeD3T6OJStJfjZZhMbPy+c+5ocQnsG2f9jXOFrELfGLFeeEcGjo+B8uex3avjQB9xPyqIe3fqsRkvawbMVSklluf3xB7pODQ9tCYzLVeLIYWFxa/QWScXzZ5U2JiC07TdQMvTKgetx85vv+ZPX8hnNfl0Bk2+U3x1Ei7MdzrmfN85PuRKq5T6t5aAjjmu7pPY1zyv89+b/uvKJUeQ4a2vD7Ckq3qz6NCtOAQ3tuSO4TNcTeawwag8gELfYodzKviK707vx4+Xa66xk2wvftOvA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6803.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 17:12:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 17:12:17 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH v3 0/2] send-email: fix threads breaking in case user edits
 emails and improvements to outlook ID fix.
Thread-Topic: [PATCH v3 0/2] send-email: fix threads breaking in case user
 edits emails and improvements to outlook ID fix.
Thread-Index: AQHbzZgq4nUk74uLpk2oTl9TF7Z+nA==
Date: Sun, 25 May 2025 17:12:16 +0000
Message-ID: <cover.1748192784.git.gargaditya08@live.com>
References: <20250524123911.1160-1-gargaditya08@live.com>
In-Reply-To: <20250524123911.1160-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB6803:EE_
x-ms-office365-filtering-correlation-id: c504ff4c-3d79-4c3d-e7dd-08dd9baf4cff
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|7092599006|19110799006|15080799009|461199028|38102599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aYjUCwyIMGspJvCkjlEYxmjqCfZuZvVL3vO8kqOi2wNLl+9V/O1/LVEvb0?=
 =?iso-8859-1?Q?nJiLPo20OZvZchqKdzOD9pK8f4naq1/hIcNQ1zbS8XDHqWn41BnOjRsbgU?=
 =?iso-8859-1?Q?Y+p5LOfB2x52PN/FeZunLp7UHNvWGfNOeBTW5LQm4MnaouWlR6RI6EL7KE?=
 =?iso-8859-1?Q?+f6tmVnDuWXFA+6t+n/WWGij76Vsaaah7haAqqd6+TRIPM0KHlJFqCeOkj?=
 =?iso-8859-1?Q?q05MHBujiHGix20xc9luo0/luYwSPFMKTnGuqLKSscA34t9T8gYpq85/Tm?=
 =?iso-8859-1?Q?ghN/xxdPdkIT9U7lMagNeoiIfOcZihx2/zhP1R4HQBUQt90iC793Ooy/RC?=
 =?iso-8859-1?Q?zBPx/0V7Jm3yTHEV2Ek/3oJn6unZ/D/r+HE3kmKWMtnZFoZNuYAoRplzc7?=
 =?iso-8859-1?Q?6wjlzzzWVY/C7kNQmC8+wjbb7c8KnUbrwXNqp5RSyyHqQco5HrU6M4PzK9?=
 =?iso-8859-1?Q?bmR/O7V8ZlvMqlHrS/DyHQZsT2ZcbXt7KT9Q8bBxoxBS7JN2eE7idLPjZw?=
 =?iso-8859-1?Q?eM0Isv+9wfZyzhbMS0EPQuILq5+FBKoYcTsr9DpQbNH0fBDnwGKPrUeF36?=
 =?iso-8859-1?Q?sxpx7zdnKIjh/w9fMgxCzeMXqlLSx9j+95hhivVAsStJcJzBHEsiHCBurF?=
 =?iso-8859-1?Q?R5CADBgIMDsr4FCVCIqev/DepOxCMOw6hDIU1Q3mHozpIrnuKCgaSJWWNb?=
 =?iso-8859-1?Q?sdffjQ1sHMa1CrP9WY0Mu/V1GgJ89jC+ehCvQtx6HxdTMEfo/rawX3SoCB?=
 =?iso-8859-1?Q?9h8eb6aa0DG+KZSiyQBXZcJALv7zzCz82YpN9KfbC1Tn6CwRXsEP0JYO9H?=
 =?iso-8859-1?Q?ktguGTEIYLjcShdKIVsXwg8hDgQYumkew8BUgt9JGOtfvbfPn19/Rvme+D?=
 =?iso-8859-1?Q?Ax+cui60MjpDQh4TP51kEEGfSHbowFX0F/Z+88ExdjowcwR14geEYhltYj?=
 =?iso-8859-1?Q?WODJbMyUMPveiadwhAPm7l2HI82H6Me985kp5qlPEVfNpyUKpvngqO78Cl?=
 =?iso-8859-1?Q?uTqU/kdE4+sWL3eQYmmwcBBpX6m8t13rPHfEuaFGWa5kHLKpAI5oPfEbUZ?=
 =?iso-8859-1?Q?4e9WbiASsQR3GRaiN6rom/sohD6dl13QQHLHuWBXoAnJIpUlFtZc7RqU5b?=
 =?iso-8859-1?Q?K7UA9jfBaTJUDmyJoDCtzGJLqxeY4An0xrqs4TywUe5BF12rZdGmpXoIZs?=
 =?iso-8859-1?Q?pykjy7zJjGQPUQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XGotYMEDs0O2Tndvf3EDnpqalxeghHecO5Ad4useM9qHc6NUQsuLhECSZa?=
 =?iso-8859-1?Q?ubRlQaWrVS4m9bCILj5pCLR0sP7i1muTACFWIhV6r6jdJ8NyR5iK7JaQZN?=
 =?iso-8859-1?Q?bGesZN985YpQvzjsg/vu00hriE4ZoIKtFn43F4LEkp3qeB3yOOQ/IKmZAg?=
 =?iso-8859-1?Q?wrgVrH3EXq9enqSrnz+rDGsrJ2i8WKsU39RrulOHjrMhDrBrsLstvJgdO3?=
 =?iso-8859-1?Q?ejwxF3Nlc46AmCrT1uX9CqVn6RCvhoacpDY9/sd3CCRp/FlFbxAN+a25hw?=
 =?iso-8859-1?Q?IS5qidC/ti4OmI6ii4YToXhuifRFX/YqaL3kLlpz2dTH45QLK8p9HnTaMo?=
 =?iso-8859-1?Q?H+KRDvg9UGFmLegj3RTZFs497TMqqGc8iZzuf6QeQKV2Vz5TpJJGnfYATr?=
 =?iso-8859-1?Q?k7c0sTBuD5k8i2hhMIubMOegszyyH2rppp41irpB6TOkMeSyS03VNsqnsr?=
 =?iso-8859-1?Q?FhDkJt6HOW3Kk8eQQDorVEY3h9zQjY/w81flqv8ySVWfJ+DAzItvooUGTo?=
 =?iso-8859-1?Q?krTXsGKljVcefMHIK23Z8QfP3I6KU6Ugy8q9Iz/MwDrxGhxcXvBk0MYxpz?=
 =?iso-8859-1?Q?QcCbREYeMtQ8u9FAQ/OSFxxm2cCibfAGtonBd4/FMuWbFyOgKRRdvyXwsn?=
 =?iso-8859-1?Q?WKkSq9jJTexdhDkzJH0T0Kk0wPDDXkVzuJjX7tyMo/HWoMzZwY+b4WGShz?=
 =?iso-8859-1?Q?H2SgrbHmcR8wXony9LpknSDWd/2yNGvXNfugtNTbb/NxdbJme8OPI2GvsP?=
 =?iso-8859-1?Q?GKjDsGiZcoiDrPfQhvsQ9Ahxp/Wlv/jiyBLAL6o66ue0L1HkVkAYeOYHwk?=
 =?iso-8859-1?Q?xvAJUHYkBmglQnVk1FRH00Y9SSHln6i5XHZc27rIrPEzoPPrdATF/bKjQc?=
 =?iso-8859-1?Q?ES5frZf6F9LATGbGji+t5oz0df5/dWNTgH3RHpFheA+UHkiV0TMbgmrNDd?=
 =?iso-8859-1?Q?6raFbRbqKIC3MeUpRYWVvFv0n7H5qoKR5e1sDNGpRHRK/MZUcI0hy2HAQj?=
 =?iso-8859-1?Q?pzMoZWQAdxjDg8qFQBQLz04ZB4HLY2DZO+9AmhmQM2c33keKgn3KuIFVUB?=
 =?iso-8859-1?Q?U/g2CVtYrQbrHIjNAEJxGCS0zrUi/6kmflTFT603kknGeVU3pX08Rd/Tnn?=
 =?iso-8859-1?Q?/6jFKaXppwc0KNcMUy8XrHuvuSQ9cAuWPpa+o2CYLvHvnY8KLCP/seQ7+7?=
 =?iso-8859-1?Q?v+AYBShpnSrjqQAMECIASU2cW3KtLco8xwt5VI6ydZUyZBMS1TMuUTHFPg?=
 =?iso-8859-1?Q?i0R0R5h1IvePuB/tyM13AA8SmDeyDOSsvlj6wydKc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c504ff4c-3d79-4c3d-e7dd-08dd9baf4cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 17:12:16.9649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6803

Hi all,

This patch series fixes two minor issues with git-send-email.

The first patch fixes a bug that caused the message number to increase
when a user edits an email. As a result of this bug, threads would
break when a user edits an email.

The second patch improves the logging of the new message ID assigned by
Outlook when a user edits an email.

Aditya Garg (2):
  send-email: fix bug resulting in increased message number if a message
    is edited
  send-email: show the new message id assigned by outlook in the logs

 git-send-email.perl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--=20
2.43.0


