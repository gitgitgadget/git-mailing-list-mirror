Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36871AAA5
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926803; cv=fail; b=HhBaek+iKsBGsERZyhsuiELxu2ad7OJK1Z0SiqePedNn11N2eIn+ac4veG14+Rqi/9kQqul0ENC4KPUSpN6Qfsjtrk7u40sVp3bRJ/9ZQqb5f9DCSjN37m4wG1y6VCRoL36UeXt91C4FqYZ00N1GqgYlCwnyGZBt2slEA43osxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926803; c=relaxed/simple;
	bh=J7Gwrx/i7+NfXbb78YRRZufHw9lev8PrEkgXFJ4X0ik=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P4OOKQyCItjOwMWDbppQXWUjm7UoB0Pz95U4vVXxWb5bgiIh8xAN1CJctSKvtT/jahC91/V3bE35s400mJjPlnC+0coJ2p9wluJ5VW9YgNqJwBL4haJQLYP5qOmBgcnKks5YobWbEGZ9lrYyD95cv2GNH6Izg/UCkVVRmIyZJMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hpoe3Klo; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hpoe3Klo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHYppbmN0rIzKY65BGNsO7v2zSg55K9DDcvnSd7jlyElwlfgIJkyliFMShAImbkvBvoTbavf/Rai3l6yY16/6/wA3SHz3PmZTzI0HRMBwvtbEja2UvwwvyrX9U+2NvIgvJ/YEHwlE5EmTx+XaKnywEaMauv57WnHaZrkag5KfeeszYtlI3znJHzhR/NELLkTJr9l4+z+gOtNU1+RCky+YKJ2/iTn6YtTeTqzhWF50Ut4u6K9V1ITLkghcdA8Ut8TYUJCGBffFGTgb6g6SYd7dKfDkhNiAJMmilEaI9UuZ8JIANYwb+jzsgebvnNU6LBFFvzWvzipLjFYj8kNXv8dgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+jiFpaub+ZM1fqYV/IPRI6O/V0GpItnXpQL7ffWDNo=;
 b=QFcFXvQleMYjke3dSCTAgqfoKOQHBm9FLwuAyYNc09W3xEqMFf4+YE8kltNqFtF/GgMaiCICn/NpStQRJx2h1/lq0tANQi570Bw+kb/cr4FOR3EJNKTYzcE4XuZY6vTQRo60uKCiO7cDkMJhTwQlS7vO9eT9x6l82ui/HZFliW5BLueY1ZzsCGheJwm0hHzljiIBeaW+hlqvu5GZ3E+GCX3H+zUNR+WeSsZBn8LVoyZvvmr1OYuvInJEqEFiH8epISC7qwmy8OPGLaEh5SPwgLX2rBuB2rabvn3elv9Js+uOUkEblMOT+UhDX5p5kpw8snilSTDo+SurtI764fTdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jiFpaub+ZM1fqYV/IPRI6O/V0GpItnXpQL7ffWDNo=;
 b=hpoe3KloeddwrgB13vLEpLb36MLseUlrw27d1rr4PoithGc7b5WM1sMYxYn1z3zkPyKgHs768yPx43mmXpkm308R13gw25XWTffDLKSxEzaA54urGUSL3Wh7G219G9XMMxhNuTgurPrhV2O++GBmzIDD2jiuslOyi4W78E+rZ+U=
Received: from IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Mon, 26 Feb
 2024 05:53:19 +0000
Received: from IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2]) by IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2%2]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 05:53:19 +0000
From: "Chen, Boyang" <Boyang.Chen@amd.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: CR position changed in exported patch file subject section 
Thread-Topic: CR position changed in exported patch file subject section 
Thread-Index: AdpodqbkA4hz7K8wQAmbgWkFliNmbAAAQYMw
Date: Mon, 26 Feb 2024 05:53:19 +0000
Message-ID:
 <IA0PR12MB822712F1B3E5205711493D55EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
References:
 <IA0PR12MB822711B89738EDA0E2F25150EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
In-Reply-To:
 <IA0PR12MB822711B89738EDA0E2F25150EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d4eb1329-bbdd-4523-bfc0-5d1a53c0af3f;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-26T05:42:33Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8227:EE_|SA3PR12MB8439:EE_
x-ms-office365-filtering-correlation-id: dd7fe3f8-b5ac-4990-f256-08dc368f3c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LPYeEdlM1N/vssjPhodebKAMPnM8DKGHeCYsq6G3NLHU5xdemV9TAPCEYfhGcaXA6lZlURboBBWtotKAwxu5+ViTVABHhO8ixdt8K7bcamJ+lHz8quylHdhZabKr2j9grNkABQATaJhFYTPdagPOcj0S8DQyeyostaKqx1f+jqNWFO6HqarXY80orxFDl6Z83QFINW6Uex6sWwPHG4lfWhnmJlFt3d/rTHF+4DljK3K8uoW4AnYqIl5u8zBbGUWyzVYYBK1Xaa29KbUQ+mkSlo0YRgnimD82JxNr/DeQnbV2STmNqrfnvCEcCWTcMXxGzmimUytTkN8ROCoiqbyw9mlRbd/VSahZAnbWjTJtpCpV8aX2mE2bXMNHxEkG5FXgRup9aNYZYQ4CsYfwKuCqJlivqsAtT0i3roSIrLLOAaTCrAJwUL3+Xo3OErWk0Tb3NPlKIjg0jVvWgumPbKutTyFdv1Vr2z/Q2ubTzcyUZhNMoxme7hSLG3r+r6gAeiV1VnhPxI+ZFd0HAtaADobNHb2Vnluob0G0wP4iKe1G2UgXC7OAk6eLMxeSTgNpGST6Q8bUu5j5Nn2mP9f7FiBEUjftxvQGxT+rvq4CbF8KsadBPGxDFChpEvZ3Fcx7gQkRb4+VlAK97zsjZWocIlallTEeK2rFdIWpSnGjcJstpkB+b5MQBpSS8yl+5sIxQQ8MBTz5H6wRL2mCyDDm6zSneO8HjhLMwJSKzpmKrpY+okc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8227.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nSbgYoQd1umWpCZueUiq5TOsGfWHU9+2VNyhow6YtaCEgIkHGd8mwpmXBaNn?=
 =?us-ascii?Q?a5yXaPmj+tH0CdEx9G5dDLk93mHv6wl73hn770V/3T4vwNK8QUOO8RT2Tea7?=
 =?us-ascii?Q?NTh4dt3N3bfqqng4or5Ul+WtqO8AYOfVBYNuAI1saKpiJWFCIYS9CLGOKGx8?=
 =?us-ascii?Q?Du4TuGzkCrx6kNBtLnmWFsN/7yPrQPuU6yXZWQDTt/ofnwc31jTSJC+w9KEY?=
 =?us-ascii?Q?ge1fG6d6xNs2J+bWx923SWGGM3VBVnoQklQa3Or+FdIcY951/mIWBOdSrd1w?=
 =?us-ascii?Q?b1ngnmfAeOJUf4V+bNU6Nt7wsX9hKcLuBv8nMvZyNgH+WjNOqTE6pMiyhIYz?=
 =?us-ascii?Q?pla5khjS1t9lK3ByughgELJHUwXyshyf0IdixRJ1Wgm1yacXvPiNaMXvf/Mv?=
 =?us-ascii?Q?n/7WgFV+bhZkV2rf8PdZSngqekK/eQaJDP0raED9aQ46czXFzfkUU5XK2oQu?=
 =?us-ascii?Q?KS3NTMVuRCbD6bsxLB3sl1nVim6m3VRCzRUbu5k3F5o6RUmFCzdKepNwK0W/?=
 =?us-ascii?Q?38KHTGPUTwItiS9fSXdHfKxMb2Ti8paz1NnVzu+GgQmFpH5zhxReGvAGHQ0T?=
 =?us-ascii?Q?z25yOLR/Sc3TABu58XNgzpxckBhMbiisd9OoQkcEDP7NFD+RxwGBZlhifkap?=
 =?us-ascii?Q?lxJk9b88dN1NM2DE6P8p4Qbyt4SwGsFPAxKm8ZjApMx9ykysLxo0EKw0Gi7n?=
 =?us-ascii?Q?o7idX7rJwKcmWSRUWK73CrfXplSiPLkhrJiIrtJPG1s06zybAiJnNz7fV22l?=
 =?us-ascii?Q?yAss067XmTuiV2kc1drvWTG04Eo5sH1H0WYHAa9bcUv+0rcDPyk9W9KL/ltM?=
 =?us-ascii?Q?GOWSgp9RBGzkGc1QyxlpT6B6+FtypRuEcsviKVpFGzY7GanudzjOYrwRGMJz?=
 =?us-ascii?Q?NpVs3yKiFOc+MWiJa99ebFSPEmwrSiba6hQ3FhcNBlnLAQcy2jpQb36JKgMo?=
 =?us-ascii?Q?ez+a4DBdpMd1w+y4dK17cB977VEpbLl8hmoGb9T75b5Jqb6urj+Sluje5FSh?=
 =?us-ascii?Q?2CWz1CHMQrMWtzfxA9Du4jAn4gGwGjHaLZtRqUJ4igUGiZGI9C2dtvWdLxkl?=
 =?us-ascii?Q?Xf8rm8W6RUh2ge1zq+e5UKXDZRObRo1n69fWphFXMeySG7kHyEpxKHh+25wy?=
 =?us-ascii?Q?LN9YaIMEZLX0XSwdmk/tMoQkN9pk0Uh4mGTjKPVS5IoMal2hbtBPts4kT2mG?=
 =?us-ascii?Q?wlIEntMwEVMZoIFCnA4lyWKS2DbSeg5TDvtj5srgcX4GTzC4Jo82aEADN3al?=
 =?us-ascii?Q?F72UjfAF4oWs33/AI6CyEEId6aoHvMxrri4D1YYc/2O5gCojew+LSHircWDV?=
 =?us-ascii?Q?/ZjtYH0cc1E4rBQw2xZ3vQ4waZki7ugHY4Er5u3v46hvBOZDmsvgGdTNXxfV?=
 =?us-ascii?Q?o2TYgLiKH1YumF4WJ8ERErn4MfetpIQPFF7pZI9bwVDEoVXxlAhNV98NR6l5?=
 =?us-ascii?Q?+TdvPqXFN9Ausu1yzpkjbVTtDqyByyqlmW/ST+GxoBdwW/gFvgbSN/6DxtkB?=
 =?us-ascii?Q?RWJc9rntwr/MoqD1TVsITMAexFHe+7QkrG5KgnW9cm/+hRBqDsNU6vsTEDbn?=
 =?us-ascii?Q?S5tujh/wE1oIYK189A8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8227.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7fe3f8-b5ac-4990-f256-08dc368f3c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 05:53:19.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uYZWMf5ZrSoirrRYSg+kM6WR+DqAx4o6Qepj+wr+vWtVmMwcfdLukNXs5DBDkVxPAHKhe+LE4CAsHT9KSTycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

[AMD Official Use Only - General]

Hi guys,
Pls ignore the first email as there is some format mistake in it and pick t=
his one.
Recently I faced a question that the CR position in the patch is not in lin=
e with the git log.
Below are the steps to reproduce.

touch aaa
git add aaa
git commit -m "Add a file to test, make sure that the message is a bit long=
 but in a single line"

D:\Source\CustomerRepoTest\Platform1>git log -3 commit 0c9f8555c55c73fd4e53=
92c8f8516c389f362d17 (HEAD -> test)
Author: Boyang Chen
Date:   Mon Feb 26 11:16:00 2024 +0800

    Add a file to test, make make sure that the message is a bit long but i=
n a single line

We can confirm that the commit message is in a single line in the output of=
 git log command(pls refer to above output).

And use below command to generate a patch file.
git format-patch -3 --stdout  >  exported_3.patch

We can observe that the commit message's CR position is changed in the expo=
rted patch, the subject section is split to two lines(pls refer to below ou=
tput).

From 0c9f8555c55c73fd4e5392c8f8516c389f362d17 Mon Sep 17 00:00:00 2001
From: Boyang Chen
Date: Mon, 26 Feb 2024 11:16:00 +0800
Subject: [PATCH 3/3] Add a file to test, make make sure that the message is=
 a
bit long but in a single line

---
aaa | 0
1 file changed, 0 insertions(+), 0 deletions(-)


Actually,  we want to keep the commit message format(subject section) in th=
e patch same as the git log output.
I have tried most of arguments of git format-patch and even upgrade the git=
 version.
But no good result is observed.

Could you please help to look at this question? Thanks a lot!

BR
Boyang
