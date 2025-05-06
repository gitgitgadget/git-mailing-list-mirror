Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EB27CCD3
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746535483; cv=fail; b=nOnuvNqaTCELHVCDCx+zyx/BREFLQtKrAAS2m/w/W6RiYXAazrzhKTXfhgbYXnZ3cOawGcWXfco558uav0CRFxoTx6fYGLeRvQPadL7HZ+nrnPdamZzspGEJrPAfUzNJHStprCilFkD7tv5MLz3rkLYyVAY8kGJ77u9oBaG81Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746535483; c=relaxed/simple;
	bh=iJuOvjGUmiVfYzWBtMAt6is+VEnV7i1O1Es49Whpo5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMRt3njT27roHa0kQ9JJsiQDAo7dOmJR/NZz1KtaXCwjR2E1CiUrRYTfnSxF8ZKV3h9kZdAC5S/xUjPorOhZI2bLlqlFxUZ1RoaZxWFHS6Hh6NY3O+xyvicA/2YSabrbfz5xIhklEUlio0Ot0zB+SGTke6pG+Qt9+efYiGvKzv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=SzmlAiHw; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="SzmlAiHw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDijf7QPexefEzkXtL310y5dVFXccxOe9fPc5tA15g7DUUOxPujnhsiQRHTO2/994rSGGphAJkrDMoc7CmoLQlaayDMUxVa2w5dxLHfG+5V6YSLfdmwfGexpoeWjWS7oyL5AKd/gi+ITvYZN6idzZzY8WGEzfjo+s8bSU9ZE8rHBesNnXqh3dO8id3+J7ZvCoHLxEnQwOPNBxATZBVsp5DMRNJUMBPWzBj2LrZk4YFn1B12fDE5UNA8BPL4pX7+uNkmi4Cq+x6aCxkVw+EFPo6N4yJnpOH4umnEcieTWrqqfhcvKe2BYATLj5LLIBwdUo9iUt7483Bu4BhYEF5Cc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XX1Nz6yFIOIk8WkEEexZjOx8zsabjKU3Zu0Ye7Sp/w=;
 b=rA751TY+GKdc2R4r4l6U30S8JDkiGSI3FqR+acpy1AN4StGWlESrUE18ih7nb+C8UcDgRhC2Bbm25G9zlPUriHSXT7QLMQT1cMQrfrxvDl+h8oWN6jTXase3z4eDXZMIIahB+dbGRQ8uQyohzcoLIhGzmcXHdBv3TW+918M4BRyy34zetOlf3obl2o7pU1iSLdscQO8b30RhDIzqdxsI9jaja4R3llIb9GiMIOYbNR1GDdSPL52YSdsInKFPtO3o8Oo6v6WTZqjg5Bk0q0GBCdmF80blNJBExBnwFs8ihfQvRD0/wIaTgyr9yeZEg+vCF9rfo++eRWceaKjkF+/3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XX1Nz6yFIOIk8WkEEexZjOx8zsabjKU3Zu0Ye7Sp/w=;
 b=SzmlAiHwVIlH/gLGdplOJxQmtYGYckH3NzieTSoHS5ETCXpnVEUMA8FJxhfnz3+B+2vL28Y49QGff6FUFQQIu017OG81FG9qpk5OUCzu/jJMHcurc5S7y80UXFAviMpfsNTIJckkqfl5kGClqj9FjMtZ7AIc8rA4yilmBp7u0PHf8jNxcJCCCELImMAdsyY1v3EqSVvLXMwrgyxnnv2DJHgStTmoFio/hYSFiCQww9qZZmo4M5mQUK++Q9IATYJ+zirBYFQB/tYD8dP1GjJy1S9LxsWf2haeEk3NlmW7sW0lWx/CgGvBDmkotVjlRW1EqlLRMjv3EFveQffbdV+3iw==
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com (2603:10b6:a03:458::14)
 by SJ2PR19MB7439.namprd19.prod.outlook.com (2603:10b6:a03:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 12:44:35 +0000
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291]) by SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 12:44:34 +0000
From: Abhishek Dalmia <adalmia@commvault.com>
To: Justin Tobler <jltobler@gmail.com>, Akash S <akashs@commvault.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Adithya Urugudige
	<aurugudige@commvault.com>, Abhishek Dalmia <adalmia@commvault.com>
Subject: RE: Incremental Backup of repositories using Git
Thread-Topic: Incremental Backup of repositories using Git
Thread-Index: Adu9yuZ7Kg9IZ5BOSWCrIQPM1Q8FHgADnPsAACq806A=
Date: Tue, 6 May 2025 12:44:34 +0000
Message-ID:
 <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>
References:
 <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
In-Reply-To: <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
Accept-Language: en-GB, en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR19MB6401:EE_|SJ2PR19MB7439:EE_
x-ms-office365-filtering-correlation-id: c8f8e39c-52f2-4145-4187-08dd8c9bc120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uLm+h/ZS+noxcCnTWlQmMA8sgPVsF34PQQ3xJ0PHukGbzBHMpeWIXRbAwgKQ?=
 =?us-ascii?Q?++K/j/wdDcI7Ob8+AiH5GOP7r9e8zppV5Wh1kB9F/m7s1Z1pUiaDpXyoB/0p?=
 =?us-ascii?Q?LDsVo5jvJjsfpQEwdtwBvT44aMUsieUVEAnUf7s9M9KJ3plS77wEsVqKvsx7?=
 =?us-ascii?Q?alo3PDaS3dzzRDbbXHfjmuFhc+eTTjeewT0TCmkxE686Mji7B/qZIGl0pBcE?=
 =?us-ascii?Q?mVdKRTZHmwdRquHRuhxGkkB+vckYvmBsfquSY0qHxBKYjA9IZL99KDc7WtYm?=
 =?us-ascii?Q?k46nTSy/bekwpiLQS4bYYbv4A9RZSGiHMqTK2qhy1JqjsIZbOiwwPX2LwXwJ?=
 =?us-ascii?Q?cjA+lXBQBB6qDRFPrieaD6q8sIdFU6X9b9lVejZGBTdvl0IcbfAoGhrZWHrV?=
 =?us-ascii?Q?Uunr6FrRrypqijei5rtocd9x6nmrGD5XI6Ne7t22t9Q+vM8LAwT7fYJFVddP?=
 =?us-ascii?Q?Xo2uJ2JzJnqFGfiWNuKDH1ivSkvnxGjp58Qug5BxKCK4NNxxOf1Wnfp/W+mM?=
 =?us-ascii?Q?Q/gj79VWyVmGs0o7xQn9pNJnhgjc1qB60ulwSaQeTGYq1os1/Q+HEiHwQQVh?=
 =?us-ascii?Q?e41J0JQyq5GI/egpReqzK00KPdtirJ0epC1CZQmf9SOQ54TcHPOVZHe4j3G4?=
 =?us-ascii?Q?P2ewO3VBrMr3hgJON50LCGctfb0SBQ8dxiZtE96zgbzPgIvLP/nhA1F1R4NT?=
 =?us-ascii?Q?GsdW3CiHn+fyTw84b7X/wbf9fLPAkq47luBCAmaGPjmAAgHzs2JjCRyDMy5C?=
 =?us-ascii?Q?3yxlZCcG6r1v5GzYhN61prjskz6lGvV98gf3SOmFqGCK6jtqAhD++7PH6sps?=
 =?us-ascii?Q?BxxYw+2cU1pBDh9UPgGnbJhQdD1T7eTu4tfaulzX3upV1Mvd/stdG9dRStaH?=
 =?us-ascii?Q?Ry7ZRMVmq4ZBNrLnu25izXDW9MaW9ULQGNWCxzvUIhozjRVr9ZKvfs9FNDRe?=
 =?us-ascii?Q?w2sK1TeoH2pAm0Lqgcr201AKmRWLWfW5bA1Y4cVmpW+8rs4c+I+SXxctYymC?=
 =?us-ascii?Q?LkL4XcgRBvoSmVd4UsAhCJXrMvtISiTCrYSJp+nrqlchg/Iq6+TuOvFQWVQd?=
 =?us-ascii?Q?A9662zvUpnCYs9hND88JP+mBKrIPWiEGxghtcHBTamK7tSEd73IF57CLH04U?=
 =?us-ascii?Q?KwY4/cqShncPLg86APx4ypuX97z/lsAZza5BEKYMEZGDo6fH3EXTnvleB4t8?=
 =?us-ascii?Q?/vLTqaa49W4i0heqLHYQuBHz1CJoh0No/5aP+314KUw4zr6WVxqjt0HH5fRe?=
 =?us-ascii?Q?izwFxSSz20Uo1QKNzDyD0CnE9icLD6Gm+Z1exsCVQ7XL+q2/mTvzVmcPZM6F?=
 =?us-ascii?Q?i6bmdsheXWz4U7eTgCsLXM7lBXsNqtrDwkMLejbREpHF2eX9eBAqi8FAr20k?=
 =?us-ascii?Q?FXTjlRshwkQqSpXG3Drg69XxBnV9nxOy0LraSswId1j0EANscYURAETCmVp5?=
 =?us-ascii?Q?Vc6vICFJ1Eep0nzDy5BO+GKa8TlCF2V8LpkWBXbrbv4PznRYl2mSeQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR19MB6401.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cz/KzL4yXZJXijagk9eTAySqslw1s3nV8+6lRDmmqG2cyK2VKWgqdSg/ctCh?=
 =?us-ascii?Q?b9DoghG7oCqx92NZ7QcfvKAaKQtKTmySVfGXbIVduZWXoLtL/N/iZtlTYjYE?=
 =?us-ascii?Q?ArCxzXDFORopJMREj0hOfpLtwS6kzkU53GTUCjl27o/iNfBxRzxBt66nld3k?=
 =?us-ascii?Q?F/6bF0hDN3qbf77T9j96dBW1oRPB4wH/9+C5kR2h7QA4zWwoT6spZ8R0TThS?=
 =?us-ascii?Q?oJJHR1vNmhm3RsgUH7muW0VIpgkSgIfK5BWQf/GfSqAoHAlkhKnU3FPdouqE?=
 =?us-ascii?Q?bR7KEO0JhFp2PCU+wYz3gGxQ45wbLCTKo2qS294enpKfzpBotiIa83/Yt8OR?=
 =?us-ascii?Q?vXOOy1KRQ3wYW8wTVNL8r9YxE1H+FqFSad0OTL9lWNiNWRCWVFJPwMyKjonK?=
 =?us-ascii?Q?AOGUcmEj20idKdGaz4ozJP9AZV7cuuswZLHNvC6I5WcadnwFtc/t6IXDlbrD?=
 =?us-ascii?Q?gY8CPrmxtMaosLALLGVAyqeLOIa0J98V8M/EebEU4lLa8ip+harJ0nYSbbM/?=
 =?us-ascii?Q?iyJxqWt1KW+SEs8yPpRMiNjv8gffDSDkHu6RyE7MXmVRNJu3GGHV06058vz0?=
 =?us-ascii?Q?yymlVrnnrw3sE/neOoj3jVVqoVpAS+VzwZJFlB5M0qqGsPCCmZMNfQLskpM6?=
 =?us-ascii?Q?juOim3qN/rNpd+Mto0srJ2pu0Remf/s0XyQHZod/WjiXSjBjdHXjGEiuz0mm?=
 =?us-ascii?Q?zrfOla8ST2a2buTxefYxaek3n4RKLrEh98cGr4ceF3pmLR+L4bA+e1pwZYP8?=
 =?us-ascii?Q?8slT2o2AeaupIXjCWYCCmPt/Xb0bW+t4HDwgW1DzXLkkPuXGYWQP2ph7ZzPV?=
 =?us-ascii?Q?BMiMALpXCOPhQ+UecBIzzo1B5ZI6s6a+652ibPI7KtFyMRqRRxGEKzV2pLLp?=
 =?us-ascii?Q?jNhDY+ckReXQgtymMJte01VlSZgyNYP8SNrqjc9ygFARYyebrfh4x+aQLnRr?=
 =?us-ascii?Q?/6UdT6YRzRylHv0AjBZhXD6rw4OaoKR4kb9o9OiCmwJfp/bFeHPxqsyiEnAC?=
 =?us-ascii?Q?jFUfdT36aJJsLBkiYivk4lp51YGsE+y+N1jWUXACh06mX9aQzQGFzbN1KptN?=
 =?us-ascii?Q?YPgNf9JWGQk7CJLOOKLX1KtLR80dIi1ROFVX0oacuorHjRsO1HKOX44cOYRM?=
 =?us-ascii?Q?d4Aqyyq0SI92hTxxT9b0KzusMqbTDqu9tCjpT2Aw9gFpo736rW+jTMoB7BLx?=
 =?us-ascii?Q?MzIa6UDhm3lK2Cj6A2+veEFSLHN3ebHDUZPjhuvxtrKitLDXlee6dtJW49jR?=
 =?us-ascii?Q?Qj4uO6QiUfqvvXf+K7HAMGZRSvCpSdVLxfFjfF/n3n2tfjUukq+eQZ2aqIl0?=
 =?us-ascii?Q?K0fTKJLPbP8PMhaNKSt+XUBVB/v1Lpdfndj2nnoFVLBHLYiHL5Kz6MOsnVy8?=
 =?us-ascii?Q?d9M0ssQKHN2WfNcTf9hcwH90vvk1qFaAXkAyX0eR83hkCMO5DtOwD5I4I3wD?=
 =?us-ascii?Q?JYsPJ57HrLVIjJrcY0D2wmSJ29+jEDILvA1lbQL70Jk1J1LUq8tFKEAVBola?=
 =?us-ascii?Q?00JjACHRwO5t0aQZWayW70WQGsWjQUe25FORtBs8B6eKfnK08uOYFQ9h37fP?=
 =?us-ascii?Q?GeYXwFOgQ4IvcyINuxn9ryvr0gJwsJU42/Zq2fc8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR19MB6401.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f8e39c-52f2-4145-4187-08dd8c9bc120
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 12:44:34.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfuY4fcmrK+z/VJqVMhhCVdPK0s3SrUxQRSkNUedSVLwBZOzUtSblJTt7VZPOY4lxYkySW86o8KBu9bIYm4+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7439

Hi Justin

(My previous email got blocked due to HTML content)

Thanks for the recommendation. We want to backup all the repo contents, so =
could you please comment if the following steps will help us backup and res=
tore everything, or we might miss some tags/references?

During backup:
- Create full bundle first time using: git bundle create <full-bundle-file-=
path> --all
- Create further incremental bundles using: git bundle create <inc-bundle-f=
ile-path> --since=3D"<last-backup-time>" -all
	- making sure we don't miss out any time

During restore:
- Create the initial repo with: git clone -bare <full-bundle-file-path> - u=
sing the full bundle we created earlier
- For restoring further incremental bundle files
	- git fetch <inc-bundle-file-path> 'refs/*:refs/*'
	- I can't use --all here, that works only with remote repos

Will using 'refs/*:refs/*' restore everything, or is it possible any git da=
ta might get missed out?

Regards,
Abhishek

-----Original Message-----
From: Justin Tobler <jltobler@gmail.com>=20
Sent: 05 May 2025 21:49
To: Akash S <akashs@commvault.com>
Cc: git@vger.kernel.org; Adithya Urugudige <aurugudige@commvault.com>; Abhi=
shek Dalmia <adalmia@commvault.com>
Subject: Re: Incremental Backup of repositories using Git

[Some people who received this message don't often get email from jltobler@=
gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification ]

External email. Inspect before opening.



On 25/05/05 02:35PM, Akash S wrote:
> Hi,
>
> Currently we are backing up repositories using the "git clone -bare" comm=
and and save it to disk. If we want to restore, we just run git push -mirro=
r from the repo that was saved during the backup.
>
> Currently we are running full backups (run git clone -bare) everyday, whi=
ch is taking a lot of disk space and time.
>
> Are there any possible ways to backup only the incremental changes of a r=
epository? And somehow construct the whole repository when we want to do a =
restore from the incremental backups?

You could look into using git-bundle(1) to create incremental bundles using=
 exclusions. Examples:

  # Creates a bundle containing the last 10 commits for main.
  $ git bundle create inc-backup main~10..main

  # Creates incremental bundle based on time for all references.
  $ git bundle create inc-backup --all --since=3D7.days

These bundles can then be "unbundled" into a repository as long as the repo=
 contains the required prerequisite objects.

-Justin

>
> Thanks,
> Akash
>
