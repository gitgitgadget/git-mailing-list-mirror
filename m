Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958771B812
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926339; cv=fail; b=ckdD2dmHfrTMBFtxohceCzMZNN0cvIydcOvGLjT4YgdnLk1eNd5fxQSd89HXYZcNBmO+/gIE5TkqDdLxYhSlQDaNVQqBuF0baDFiaBprIRHTxU1yyhiDmMUi3+zQfsrHcY/COWmEu5s1BH0F/HdPlr+lgrY558fDa4caORj012Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926339; c=relaxed/simple;
	bh=iZma5ap/fLAKQ5UXo8R/J3uuNJOcCSTdYQwqCdJh8Mg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r9nVL2ezLY/GdTdG+tn1igmPT6dRxRSuK8I4FzNrElwSihLnae/mZhUTx4NrQT/HKkfHYIdb+PipWKGu9Jgg3G2WlZfrar+AcMXwvp0xMNmwOEB+TSBrmh/h9Sdfc6GtbMyQ8m7uD/NI0BZ24RIb8Ryd8AkfLMJvtKVLtbeYNRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXMvW+nI; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXMvW+nI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VekMeWoNWdtPJn9PhvXEJtNP16M+HLrr337PW98SywokZYvjhMVpUiU7wIFYZAfiofY4DZ2DqMeqbmIO1yhP5uUtw5rwodG6WSG/eETbD0Prj3b3JqmcTTQSlVTFDskVHH486D7QJ+Ziw17QSXUKzH+YdJyn64q+/70jqx2jPKhUFDu3Q4i6yCIsfbesaU7CffJsn/MkNIUH7RfRC3aXMzt2EFDhF6tFCrNuXHKgQdhlirRa60C6e+gzQd9BdiVlb4cSwqI99JFTIF4iay7YUKZgXXTOyxRwpVuCw/BpSXrlfF3scjfcAFyvQAFXuPkZ2j9TV3Qha9OOmdfEfwy3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+30m1mmwXva+7Nm5pi79BNlDo924yjcSMSUbWYCYjNI=;
 b=deODWfN0nqSvQvdzA8x7WwtlK5oJAiC7XluPa7yBUT8t0G195GuDcX4fHDUf8Lk+0paN4u0CMZm5tYZv6Fpj3um953KMRDWgfI2MGsshl/FErZruMXVd/okw6wE7Eq6lspZLUWKfsZqlih7OJ09f89AkVGFDgHuQIsnkO7OMGHE4BPZQi92eLUoVhcIAvl6aCSt2jCkNfmww9AZ9xVW0P4nRgciQoCjLKs3EeZ8kSuu7qe9k02cqJFDP14DTll/rsemJr9ymM/h3NXoCfnGHaXK/gNEMlCR8LwoeqKEynZL0ExhhzbYcqCGt2qrM144nTwP2Vt+Dm+tnr130f8MwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+30m1mmwXva+7Nm5pi79BNlDo924yjcSMSUbWYCYjNI=;
 b=FXMvW+nIYVWXUo2UqwFteeg9FbUyPTM2KK8vYL6EJFk6Qe1r1nxJeBehgisdYtd3TtlYKyZXedrpT675nNRvWU0jdxQHy4txqWd1lyxXyKvOlqqIJF446EsQ2yjl9CoIwBoefFS0+Pk92mauaglUeub1jU5Q3p5O53lq1pHtDU0=
Received: from IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 05:45:35 +0000
Received: from IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2]) by IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2%2]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 05:45:35 +0000
From: "Chen, Boyang" <Boyang.Chen@amd.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: CR position changed in exported patch file subject section 
Thread-Topic: CR position changed in exported patch file subject section 
Thread-Index: AdpodqbkA4hz7K8wQAmbgWkFliNmbA==
Date: Mon, 26 Feb 2024 05:45:35 +0000
Message-ID:
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
x-ms-traffictypediagnostic: IA0PR12MB8227:EE_|IA0PR12MB8087:EE_
x-ms-office365-filtering-correlation-id: 85268871-5901-4445-6e69-08dc368e2753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jDcnijF5EPdQN/pd5B7igDwLlRdEDgi0OG9Q/XPv/K+xbjLng5hTYUT0Q66nWOY/+A34CltBbS8FYnxOGKykDOj62OTako66t2W/6qscweWayTTESwnX9wKolvDNkMaAOIH1KsWcdr/lbkK56NlneoCooYHTdTA7IXZ0KQ0WOToEfxBW2WgtZgBUwpgJ/WC5ti0WpCOkKfh3AC8Gqo3uxeViI194R5g2H/MXHNUiOSv2pMFimpPeugFGm3QkNYlb7BDbo4EQ38h7+n7Cjc+gQZAgh20m4V8c7S7xlQzJl6f/6BZruz/ehgwxX0NeNvTey/x57IRxquE0NG71PQkgYB4voW4hfJvK7tJ9b+A4AiJIQafFShfO3omFIeVk1uPkXF6/W7Gdixu6pGWQUEA0YRAe4d2n09Lbq3m3pbRzoiPlsjCXw6FH4Gg2r8/klGsVIqyoTRVYqVMulzaKAxuMQ05sW3P+gWziL2zCRMF55fCYDVSG3lm5uhSaaJL85YuNz/qQ4aiFvxaN3uuVjyxlne4o8GIvRvoKiIi/UtPO0Vym9k6RhokHU5py68Cizw50zLg3NtGa3CDxZoxeh7gKuPoHDLvrVJOozyUe1NV5uoivfUaxEYSygRnAf9MRTtCH2qc6++J2WNhWtNKo+b2XoU/N59j5mbQU8CmX2Xq39P63YpdqkqzSB/rseCLJ5IND0+6D6NmErIvYqzjFNUudJwGSqE84PKNwXqVNcgNEEnU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8227.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?saWcwkH7pvLn+1Yw1XA0hVmCLdSNx4BgyNnvcbVyy6KRJKagtuU0dku8nBi1?=
 =?us-ascii?Q?EaG5w0gDGUx1T2ch1wzOp7So6i7pasLcOtVZx5ji8yQA6amymwUhheUa4gei?=
 =?us-ascii?Q?QvwkDpzd7ou0pMFe/UY7l2w/x5WIWO0oceFk1oLP3HWldQzwaT1eeF+8Lwnf?=
 =?us-ascii?Q?e8qOuViPbKBLC17/lhQfVSdGEH1y3IbTbNtwUogYLSUrx4EwP4vOtkELdpMi?=
 =?us-ascii?Q?VK3WpOjep7otAYYdH+WaoDUeGOg02+In0b8uPid9BVOwdN2D+ehK+5CT+Rcw?=
 =?us-ascii?Q?vjBw332QWcFGK/EvlrA4Mqj4KheljGhXllm6tzQSWsrHbv3ykeAeRMhKoB+U?=
 =?us-ascii?Q?YNscOIzI47f/FQYx5OaH8hvysGZblk6z0IX9d6a5N6iWYA47TH3brGuiKhJS?=
 =?us-ascii?Q?hlJgbsIiC29A+fLU5q4EOMY+eXv3SghW4GMY1GluM88cTsXji00l8k0HiUyU?=
 =?us-ascii?Q?dP9JtkDanyqwiE4BGbYBc2QMi7kXan9uR9Od9BTLi7p2kO2jDa9ggTlgKmf4?=
 =?us-ascii?Q?S9bC3h0bNbkznxcW9zKkozuGjoAxknVHWDBmZZDG/YUTPYkY7f7W0L7CV7py?=
 =?us-ascii?Q?G6go8N1jOebHjfsdI7kNPci8COioMLHA078YBUYlAmqiBO92uL3oRF6KZvmw?=
 =?us-ascii?Q?ZDiz0TMupcylGDk2fzNYmvamFmEERfFUWaNqtT/0YoO73xlXgnGPS2ew0qn9?=
 =?us-ascii?Q?V1HYDMHugnVpvIaOXGAtns+vlbVLpqwvPxFc6RJBZBnA5ECmv1W+kshhis+j?=
 =?us-ascii?Q?4gjWugMj5QM9yLNudnOXSqsVQWeysrEaYPOVvjr03+buDMrq1HUDEeWw+gil?=
 =?us-ascii?Q?X11ettLDYkpIn8FCknWGXr1lbOocApL6UbcK4n4L42rXeAsi2guMh/LvCNoo?=
 =?us-ascii?Q?VXzr6gO99Ays7CqCVFE/8V0/mS7KmDim29p2rsjj2N2+7x4hg09YWgNncHzw?=
 =?us-ascii?Q?iWZdJdaeSSbRdAyvHC4fbWOZ/GwdnhbkCmlx7zVHCGlBL++0XOToDrr/xq4u?=
 =?us-ascii?Q?8pZgrzqFNqr8VYGFlDJzw60b1/p38aiU3UUExZse8SVKf9GTohqE0Ypr74Kf?=
 =?us-ascii?Q?ijJmeaVQM5HzU1I4L5nb2pzO3dYZXHaZiHmgiMPU7DmPgnr0njPP7yLX3pXj?=
 =?us-ascii?Q?zDfwFGeiXWR8mK1jfwbfPllIfB13hW+6vYCNhI1L1P47YkoI2cX9AK5lVmxt?=
 =?us-ascii?Q?53vdfmPSTJfNylong8jLDLudPVtY5uOpXv3mSLXqMJ29B/j9CcTaTbN1w5pI?=
 =?us-ascii?Q?16RQW1+6HMpo17b9bxW3PfIk1IQsXCspgH/hlpsI9IUywqpHKYpJ+G4r+xIs?=
 =?us-ascii?Q?Gavl9Xbv824bpANU2+A7h8DY7Fb3cHcStjU2Umve7Lwc94G/PKQYmdUCR49T?=
 =?us-ascii?Q?Oy1dT2/i/lIcPw2bofTvpMZ0CrOLlPxBJ2Ki19R9PGikWhRui2PHPGOV/ECY?=
 =?us-ascii?Q?YnT8Loa8YHdKCMaLnzGU8rRljnDpma8OmJgNHROrO/H8vhABB5fhaeOfWVoN?=
 =?us-ascii?Q?thzQfD/MNG8G4DflI3sNeGuPSL+IvDHx5VGvYccdYdqDm+U2fFOUvSJj0a/4?=
 =?us-ascii?Q?jn8MDFNHtRtg941gXwY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85268871-5901-4445-6e69-08dc368e2753
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 05:45:35.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcLMKLif4kqAENixxeWC/zpvPF+/V03LlvvJ7C/eSLgIRpKQgH1LOeu+VCD+CEIWSytjZeV9bh6uSSjsZ9XXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

[AMD Official Use Only - General]

Hi guys,

Recently I faced a question that the CR position in the patch is not in lin=
e with the git log.
Below are the steps to reproduce.

touch aaa
git add aaa
git commit -m "Add a file to test, make sure that the message is a bit long=
 but in a single line"

D:\Source\CustomerRepoTest\Platform1>git log -3
commit 0c9f8555c55c73fd4e5392c8f8516c389f362d17 (HEAD -> test)
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
