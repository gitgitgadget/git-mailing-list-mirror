Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869828ED
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuix.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nuix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="De7GF9nE";
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="De7GF9nE"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=aFlXPRib7flXS7i2Pjie/0rpipeQgR+yuMaSyMVG42H4c77Uno4Wau0Du+kCSZL6Yt88lvJmy1CPcjq1AMvSyfPtZTlwbLa1dYVgCmyHFvZbC3R9wo61tjGOteeAf65D6brWXIpV4KZArPh6zMY7kRdw38lL4At6SgReqZTRUJVkP8MDo1KgWLlC/gfnGbAgqgVkixm8kWdsH4X/3SNkJHPjjzdcfTqK1Ko31VeDceqW8hxbs2CEDJAwqwbCJVFHcQ528iiHRW8c+FD8PgXQKtz6DUI8NR7i08NmkW63fKrhXxi+mb7BBBdJmjztdwrkholGEi2UOb4pRn71uRYp7w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99TYoVSB/975svgbuAwdXhKL3qd3mMyj4ofl9WWat7o=;
 b=JpD4V2xExlMvyFU5gu9vt3FceEInHpz0YNcOqHE5Sc6IozdlXVIQ9mQWqXOGexYrhK1DSlX5PNRukkzrYw6Ds5jVEHiMYxRlcjT9G7J8GIKis/B3ksMV0R8Oc2KOvWzkB0AW2CdNXIS9kOA7yHFG7YRo5R6OQWIV2f2irD7atrM+Bk+9Tht0tmD4vbYavrmCLN51+mfSxcbbg+/oNaRA3cYoWs3aeh/lfNdHKLIrLbADvAikAYNCRx8eXUAPaIufRQZa272UCLsEgVaNu4bOD1188cQfH9UHOcZ/tIwFLZAxilhPsNmTtXgIf4+4BbMgNO8Kh8dJQy1jgfzF+ChhiA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.98.2.159) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuix.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nuix.com;
 dkim=pass (signature was verified) header.d=nuix.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=nuix.com] dkim=[1,1,header.d=nuix.com]
 dmarc=[1,1,header.from=nuix.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99TYoVSB/975svgbuAwdXhKL3qd3mMyj4ofl9WWat7o=;
 b=De7GF9nEocU+jHUYKPxV76uSxAyzRLPpT+zjHtOCeSM7qfCqNc5K3OhmbxTPhNKn5nNu+rTdMZ5/KWhJ//Ax1xg8S89XACSUWO8lk3LAZ07rYZYR6/CLcLKf5QEZ/AiMQGVMzCRknF7e67j2CXxU1QrnPg5SBi4Qv5wzxLz711I=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 20:34:35 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::d4) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Fri, 12 Jan 2024 20:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.98.2.159)
 smtp.mailfrom=nuix.com; dkim=pass (signature was verified)
 header.d=Nuix.com;dmarc=pass action=none header.from=nuix.com;
Received-SPF: Pass (protection.outlook.com: domain of nuix.com designates
 20.98.2.159 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.98.2.159; helo=us1-emailsignatures-cloud.codetwo.com; pr=C
Received: from us1-emailsignatures-cloud.codetwo.com (20.98.2.159) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 20:34:34 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101) by us1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 12 Jan 2024 20:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLPd5htUAHwf5NB22404WQuiSl0nWjphGqJ/PlHnESlsXf4dWD2RcGQV57GdPuP/t+/GSn/A9ueai81OrYFNjKi0xrNZqw5zfKVAg5rMqPt4YntNu0dDkrjXVC7KQGigZCvcadS3gDI8hxNulwy1FUP8cvdhMfcM3eqDQrzGRKnm4uutqYLGx+tmewk8O2A6GZpKGDTRk5kbwtoQFsdq/BuFx2oEAbD/zUucvUd1NSIooKnCoETIcVUyLXQeyFBx/ZKP5t1G8Bd9Kbk86G/ScVF/Hmy+HuQSC2YHthEOWqo4YqASPWi1mcOo6KC+TCA1hNFzac7mMRsD449bNrekHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99TYoVSB/975svgbuAwdXhKL3qd3mMyj4ofl9WWat7o=;
 b=OSCpWcLAEgoFSImIoxm0bOuwUUXZk7N+OB17mxPrYuBn5nqPxtMy4wlevDwYbdKAjcAnO/wJoCl6UIZ0/rZunKxN3ag12viNBsa20GDx+oqLTXVhptg1243ZeLTLHT4upBZjTNzcSqjez8rQBu2USCtzeLpMhWz0puujuhn35tmVhnCUU3wMRaKGUTLLeJSAmLpAr1q3oQXwWZ1VlcyP7CNcuSs0UDpmAQTsM4AYuCQeupRF5jIdtU20vNd8CZkGDFR8xh+ehfl/5++sg3imgLAb+OCv80hIewdUY+wEHR6nlKpvUIiwhudxVwLXM9wOlR5QQJ8AO93vmoTzrsiPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuix.com; dmarc=pass action=none header.from=nuix.com;
 dkim=pass header.d=nuix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99TYoVSB/975svgbuAwdXhKL3qd3mMyj4ofl9WWat7o=;
 b=De7GF9nEocU+jHUYKPxV76uSxAyzRLPpT+zjHtOCeSM7qfCqNc5K3OhmbxTPhNKn5nNu+rTdMZ5/KWhJ//Ax1xg8S89XACSUWO8lk3LAZ07rYZYR6/CLcLKf5QEZ/AiMQGVMzCRknF7e67j2CXxU1QrnPg5SBi4Qv5wzxLz711I=
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16)
 by PH7PR10MB7011.namprd10.prod.outlook.com (2603:10b6:510:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 20:34:29 +0000
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6]) by SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 20:34:29 +0000
From: Michael Litwak <michael.litwak@nuix.com>
To: "kioplato@gmail.com" <kioplato@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "kevinlong206@gmail.com"
	<kevinlong206@gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
Thread-Topic: Re: help request: unable to merge UTF-16-LE "text" file
Thread-Index: AdpFlb185RvAtdssTZmbSakMI/giFg==
Date: Fri, 12 Jan 2024 20:34:28 +0000
Message-ID: <SJ0PR10MB569341D4236E1438E49EA1D9FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuix.com;
x-ms-traffictypediagnostic:
	SJ0PR10MB5693:EE_|PH7PR10MB7011:EE_|CY4PEPF0000E9DB:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d669870-93a1-4f8c-8275-08dc13ade38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 4+YI0wDZixFjXlsUwOh2Z3I31BQIntJJhmZ9zNA8+o3wjBYIN8A7HxWeMe7H+tFR4ktozu4fz4tW/LbbPrhluJxPkpXJZLwnaiRl956/KPxzpPeQ135Xl0tqUS0JHwqGBUHuq5KXexzbZiITFOx4PfxmUlRB1pS4VilVeao/JBLxoN5jOfkDLz2YA8nA18kad6a8ixqQyyjfMbTbgzNpz4qnTFP5KKfZWDJg0jroc+EcA7MeTq0GRBMLemfIqkDQLkIoHAuadICMjfs/lE+TIBr/RUWa5zs3fQsYe7nHcPxXMbY27D48AGPLlwYtLLkgiV+4ACx8KCpogOBNdRhyesOUo+6nf802Derok7mvZ5F6+xBp4PbXMmNP92Bgmle6FZaky9PxfUSmjtR2HdYXS+oFkc9n+m8mviLFgUBJTRAvKa0XMC38TtDkYVCbIqBQkRvFDHpGzKUyBfwxbC5KoJCfwZTo5i18MRiM26GeXSlo1PtNU3bxLm7uwoAux2V8LRLCVBRIuKVwHwx2euUVBrGtPsHf88KWX5iqjGmKEd7rV3tf5QsWmWmYImenUajqQn9x+jFfJbwo81K3P9v7zQdCepTsLQHmHa35KxelzQMYVclAbd6NosCkNA+Xffh1
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5693.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(86362001)(38070700009)(41300700001)(33656002)(122000001)(8936002)(478600001)(966005)(66446008)(6916009)(66946007)(83380400001)(7696005)(26005)(66556008)(54906003)(5660300002)(9686003)(64756008)(316002)(8676002)(38100700002)(66476007)(76116006)(6506007)(4326008)(2906002)(71200400001)(52536014)(45080400002)(4744005)(44832011)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7011
X-CodeTwo-MessageID: 9045769a-fe66-4d04-b165-8cd87e9c76e5.20240112203433@us1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	400322ae-ca58-42ff-c4cf-08dc13ade020
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X2RnnHR0I13zwCB5lo0e8vr+8WVAbQ71ZhDP6PwgbkwwbcOlk6BikyLaOeLSC7HHejqIrlCptMth5Pt2Iywrwp9B1DiYYGgmZ2XhPY8Fls5cktB9GBG5hH5+3qpxyUhKtaKkSF9Y4jezU7A452H1NBr3Che3OsmiB9FBWwqgyFQ81ACc5AnK2ciL/9wdaOj+ycJBC+hCX6I55lrTK3MpvN/FxWiT0B0sT+xdeXxJ0cJQp17kWRm+K5caBidHkkpH3n6PkqfPEzobF+W6t3cGgc8obveN4RRAkVO+/TZRZblLgkjwzSEQA4iz57tEkNnpEqs0mRhx0plERdHcFwygBihYdcZOfRj0ohchBebcXShqtMWQBK8ndK9HfFXd5HrVEKfjBox3sAG7FatHT8Y8gTPN1f8F0yV+XistZgJMIwoJz6GMnXW/+1YuKBTcmHH20s3gBIMljjNT5Wfv82pVodgcFFXU7oYuDRsjDD2MlDs2CCEyDc5iYpDXFj71/sE1lDg6dsUZgGsn1pbPZ/SWJsqWUf9uH6DCeNOHyUecA70dkNnYZrxW8Zmo9mFBYCL6KFXHu5VR4ZMI2ZBz0GDpueifsWdENYaaoLT1GeGKrz4H5DsoVlfiEQzeCSswwVGZw6LG5VmFFMDLFn0GyqfdRxj0FQprFR7NF4wJgE/cGLGipKc1TFWlq63tScLps2MKUDKyDgJDvmT7ydqipKcyq8WaJmk3J1HKqZMR7WrQwkY=
X-Forefront-Antispam-Report:
	CIP:20.98.2.159;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:us1-emailsignatures-cloud.codetwo.com;PTR:us1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(36840700001)(52536014)(4326008)(8936002)(8676002)(2906002)(4744005)(44832011)(5660300002)(45080400002)(9686003)(6506007)(7696005)(316002)(6916009)(70206006)(70586007)(54906003)(478600001)(966005)(41300700001)(82740400003)(36860700001)(40480700001)(86362001)(7596003)(356005)(7636003)(55016003)(33656002)(83380400001)(47076005)(26005)(336012)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: Nuix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 20:34:34.4927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d669870-93a1-4f8c-8275-08dc13ade38d
X-MS-Exchange-CrossTenant-Id: a00035bc-d628-4788-97c4-bbfbf70f3e7a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a00035bc-d628-4788-97c4-bbfbf70f3e7a;Ip=[20.98.2.159];Helo=[us1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915


This is in reply to the message at=20
https://lore.kernel.org/all/20220422184211.5z67sxrgq2zm3tvd@compass/#t

Sent via MS Outlook - hope this reaches the online thread.

------------------------------------------------------------------------

On Windows, if you do

    git add

from an ordinary Command Prompt, it will fail to call iconv.exe to perform
the necessary text conversion.  I.E. your UTF-16LE with BOM file will not b=
e
properly converted by Git to UTF-8 for its internal storage, leading to
subsequent encoding errors.

So, in addition to setting the working-tree-encoding of the file to=20
UTF-16LE-BOM in .gitattributes prior to adding the file, be sure to run:

    git add  =20

from a git bash console when adding such files.

- Michael

