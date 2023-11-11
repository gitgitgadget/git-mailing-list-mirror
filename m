Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6318E23
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b="PZnOKUBs";
	dkim=pass (1024-bit key) header.d=epic1.onmicrosoft.com header.i=@epic1.onmicrosoft.com header.b="vVhrY5EY"
X-Greylist: delayed 1750 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 08:46:33 PST
Received: from mx0b-002b1501.pphosted.com (mx0b-002b1501.pphosted.com [148.163.154.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378AC258D
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 08:46:33 -0800 (PST)
Received: from pps.filterd (m0119678.ppops.net [127.0.0.1])
	by mx0b-002b1501.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABFoGT8032152;
	Sat, 11 Nov 2023 10:17:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=dkim202106;
 bh=eRJTmlEixR9eNkD/up1yuGiFwZBWrVbwrLBwdgo4qn4=;
 b=PZnOKUBsAvroHDekAJkCNBqNOOwxNg8bMZjGqtWtIvHVkZI2lmITBI8JkGE3a6PhDMUf
 SSdNe/YrgMeOjPVje3BY40yFJ3A/pbNj5Xab+8yxkHqZJCpY50blKHlqwzigJ72ZmY4/
 eC5TOqglTXuGMbto4KFDIQKPee4LVmzIiYXYCKIUlz7H7hpjUzbKZq7zEsvMT9wqQ1Wh
 N704O8Xx5PZRe9ZhRFd1OUEJ0K3xmlOIJWgcWgZg+2yjsFRlIsJUYU54Tmjrq8yBv0vT
 XQCkvrtUp7j/SaGARf1xaRLqoAeQZusDnt9lXThmK3E/k3LJlwrDpLVXqSMu7COD5WtZ 4g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-002b1501.pphosted.com (PPS) with ESMTPS id 3ua5vgrp7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Nov 2023 10:17:21 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6uh38KldCiTpeKdj2bRo4xTeluzVnt/Zrm5ntpKK5YokCXJReijrIbjd+F0643pZdI3kxHbHO62FNN93p7wlZhZtbj6hXYrzFz8Gk1Sve4/YONi8hddBAkWxQK7aSWtMtbgspFMqTf5KaAY/0Pe4YS8oRnP+4PPyMnx4fGNNX+Do6iMGZiM6UJZnK9jskf1X45YQadGMQFmu5hyjzrYv9AyxYVdEtfafJ7oLn/Bx7mjTPRogtvxpXwA2eS+xoFear1KNdgZWxN6PJHdzT3gN03sNbFmRVAxcyOrg/OYNx694XxFglBNE7CK9DcyCHy0wuJnLzR5qKWdgR9EUaFsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRJTmlEixR9eNkD/up1yuGiFwZBWrVbwrLBwdgo4qn4=;
 b=ei4IDsPeib2f0wlKzWjBH4GKRe8UmErJpvib28a4gNnmWmhcDiTbc28fkaPt4tXHj4ARpxhUetN9+2L1fA4ARhIPLRHJN3RslyLTR8QnsI6a27bG01kYSwOwAL9VG6C34XSU5QLgan2tOb1CsvfpjX/t+yAikYfTYvRYbZhKQ82vbusLSkOcyNrWpaAGo3s9gZIqHQ2Qqy2gGqEpPxZdmLsANJvvZhKriPSp+nncK9DIEFf/blQVKus/yo6zlT3Q9i/avKS27QSSsv8OnUmehvqZX/Y/eGa2/Lil5PaD/T7vb0XW97FEmdPlCBCV6iz8Ub1NNX59RDk2yHp0AL8tcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic1.onmicrosoft.com;
 s=selector2-epic1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRJTmlEixR9eNkD/up1yuGiFwZBWrVbwrLBwdgo4qn4=;
 b=vVhrY5EYFsiCq7Iq8VRIpoiTTkqV3Au0php1etNzhxAXzTYMtFuqaJcifJ9Che6uJaMhqfpfeLWcNpeOXNzFYM435ydo9qgRThpTSADeEfpVr0P+ZGViDqeGL8sjOqZ0/HJAYCBqUrmVX6OBlqZiGl0HICuxlMIssGStnZdS4WM=
Received: from DM6PR17MB2475.namprd17.prod.outlook.com (2603:10b6:5:72::18) by
 BL3PR17MB6089.namprd17.prod.outlook.com (2603:10b6:208:3b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.13; Sat, 11 Nov
 2023 16:17:18 +0000
Received: from DM6PR17MB2475.namprd17.prod.outlook.com
 ([fe80::ff08:ce97:a0af:9aa]) by DM6PR17MB2475.namprd17.prod.outlook.com
 ([fe80::ff08:ce97:a0af:9aa%3]) with mapi id 15.20.7002.007; Sat, 11 Nov 2023
 16:17:18 +0000
From: Kevin Lyles <klyles@epic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "allred.sean@gmail.com" <allred.sean@gmail.com>
Subject: rev-list default order sometimes very slow (size and metadata
 dependent)
Thread-Topic: rev-list default order sometimes very slow (size and metadata
 dependent)
Thread-Index: AdoUua0kMk0EHJIXQBWey3SyicMK7w==
Date: Sat, 11 Nov 2023 16:17:17 +0000
Message-ID: 
 <DM6PR17MB247594CF3A0511EF95893935AEADA@DM6PR17MB2475.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR17MB2475:EE_|BL3PR17MB6089:EE_
x-ms-office365-filtering-correlation-id: 9d1a403c-7d82-416e-1f75-08dbe2d1acd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w41sQenPiHj0oMvpjcu/9nFg6LMC8JvM4LogNyr0+H43jzJO5mshaz6XXfXiuokMoG20vBQp2b/2BWsqBjQzOhSGcCKuIljrhq1ETo0GRbjlLheDLZp9/Qrz2m9PnY/KUZDYjaXoIamp6wpEDZ6OluXvk73k/KwtXjoeBhiN26kwm6APdNHCmeUzO2Qyi9xlYCBltuuaBU3XoYxNXIlxQP5N526i/9ZTwqAXK4e/Jea5It1aYc3rt4KHQJX4mHuM5duQ6520tMlLWqa6WE8/hyjuA8awl07J3ei/VWqzGgausuxlei9ab41PE+grZwUDzGhXTQ8KyAJR6JcabUJZ+JKd0gbqT65FNqWLjbipUShiK58YgQY30Va8RE4Yoh6kX+iByZjuAkSFOFseG4IRCZjsO0kc4rzwvLDODbG9PrPCscOPSFceHilrnzxKv9bcApFPDyqe2+Ivlrt/tCI2eT1U4h+rfLUGHpnXXiwZkcyd7pPqsbMDBx+b+6MTwSsg4RZkD6Mj7rCHBkfmZEs4h1rbJmarUsYc+rXUalaKxcsJDazFzi5dnHs664kV2V/ijugn+qqu+3Ifyv3bVTOLctHVQCXpIYGbR1rkxbmPNh2VWZR2PwTsIRWzzfC4bxeKjvDYtupOBLGEer4xvkaGLQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB2475.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(64756008)(6916009)(76116006)(66946007)(66446008)(66476007)(66556008)(316002)(478600001)(71200400001)(86362001)(5660300002)(41300700001)(33656002)(38070700009)(2906002)(52536014)(4326008)(8676002)(8936002)(9326002)(82960400001)(122000001)(38100700002)(99936003)(83380400001)(55016003)(9686003)(7696005)(6506007)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?SIkCdYpmb10phaW+hPVL2jSdIcZntdxxREHdcIXU/tRQpSYschsYsHGO1y?=
 =?iso-8859-1?Q?XIfhXNGDAZB97Bi8p2jkDgur1Pl5mTZ6HOo1BbUGWChah4KT7KOgUIip/N?=
 =?iso-8859-1?Q?AqUSbHx7Ldp0jK8/z0AjIVXN0oCxsKOyXJNO2ig+Y3riMiD5xp8GlrtHge?=
 =?iso-8859-1?Q?SfYDQrZvAnX5BP01BTdWmxPEAF+RZ3+B78MLj4Vp3Ds6pna+c5no/pu+S5?=
 =?iso-8859-1?Q?WshHtS2xv4DW5rz//IfZ5RPbMdDMHdJlG4PEDQY3tXBiudgkrg702cmlX+?=
 =?iso-8859-1?Q?LnYBWncGoj7KMnX66Q+xh3hTjZTezNEeBKtyLbkZ2ZpCmKLxQgAjfzBHpi?=
 =?iso-8859-1?Q?u+balVFO8rQgFEZgscOhAESBxS+md0OCTcuwSFLQF+lmmzqnm+rxxtKRfm?=
 =?iso-8859-1?Q?7c/3gObtc7nAkCkieYpZA3+bH4wqY7Ge+l+Yx3P0nh3dPpvee+cQWsLHgr?=
 =?iso-8859-1?Q?wtHs+SgnbR5sP1GJrSiDDgNWi9JEnL84GqB0rfVwqJTRyvDyI2T77OMYtL?=
 =?iso-8859-1?Q?HkpxXLSXuVVPLR1op/N3VenE7nh6tM5q9Dk0BPVanVpySbuP01KLn/se12?=
 =?iso-8859-1?Q?S6cw1Gs3G0YX1RwvUyo05bknupudPyIivOEOQlyQh2KlhZCX2uZAj34PDj?=
 =?iso-8859-1?Q?9GbnlTKPCNvTXG2HsHw7PNNxzj0Pyx0eqqlwjgwXswc+vS1JiyPgqmpJNC?=
 =?iso-8859-1?Q?d8DDDjCDpO6WxkYQyICbt/JNNoZ+wkn2hLbnzLL1c21WSdRe11o1ut4nnZ?=
 =?iso-8859-1?Q?sKU1Y5m9xfsSHs/aDQVLFSTvC0GJsh3HBDQtKxOHnrSsSGaNQ52tT9/jKK?=
 =?iso-8859-1?Q?rssSbmirD0ZZwkomnEZJJfGBdULOka4q4A49197qeEhQMmExQlX3nkbekd?=
 =?iso-8859-1?Q?kUshWAVogPCW0tw21GCIyyH1WDZEkOwiBBimC/ykLX2M1EsxHwrTrc0ZKr?=
 =?iso-8859-1?Q?EAJPBNCoiupk31/cFnrRzXTNNUId1cG+bqMOlvXkpmlvyRBhN3SimBakyR?=
 =?iso-8859-1?Q?1XHEO96CHNs1PawCxlmiAKhjLsvXDDSa2Fvq/AvQhf/xFIWRznIFY3IVJk?=
 =?iso-8859-1?Q?DFyOICt0bG7AnjAmAf8nMdWPWLNoQx2A9RDAoLalfchMmNXY3Zj+sOGiI+?=
 =?iso-8859-1?Q?bjlSKp5C8mVpnruKgKIwetnK34TuD9wLCcJvBN1S/exAGx96pNjhU5rv1G?=
 =?iso-8859-1?Q?oGyQUIgnMOTfQ0bh/5+BbZXU8Xzk2szDuaLPdj+jofu7f9EDNlyjHtwMvJ?=
 =?iso-8859-1?Q?zjmUvwtr7+AxAHQEhBsjh14xwsnNPcDS7EbPV2+pG3elBvsvwfEdSjqKfM?=
 =?iso-8859-1?Q?SJakygVgV0IBkHzOJ0eyaApRt0ttToZjzJ9L6T/ZzWhFMdxwlYtcyD8Lbz?=
 =?iso-8859-1?Q?8+17bKPaSPPEkyaQMYJ/WTspcl8uT+G2e4L2sYbO3WRC2wXKacqEIgm/VT?=
 =?iso-8859-1?Q?p3WFSsaBHg/y1Im5IbTwaJfLCnjZXfCnYhYJBx87N+CjNGepgB3n9Cgg1x?=
 =?iso-8859-1?Q?Re6J69mD9V9ecj/k15gBpZJ7nKHeGmMvLY+GANlt+T0NqsHWAtbLVnelrW?=
 =?iso-8859-1?Q?Zbpuuq9CiYZ9HLZty4+dXMSst5+bDM+fnd7t1CrBezQdbqz5vipLaXTaun?=
 =?iso-8859-1?Q?c7jlBPzZQy4Q/Rql8xBLtGq2xfrDreGAN5lmGx644mHuUrLjr5F1q8dD9d?=
 =?iso-8859-1?Q?Vv5inxPmZsWeg44U0ig=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_000A_01DA1488.3ED56090"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR17MB2475.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1a403c-7d82-416e-1f75-08dbe2d1acd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2023 16:17:17.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GEP7+4wA8VeorvZbDHORYu/MWaY0pSICPXLAVO6vhScV9qdv91By2wAhtOujRPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6089
X-Proofpoint-GUID: CtRRVb0nRv9WT4eQyHWPjS8q8SjGtasY
X-Proofpoint-ORIG-GUID: CtRRVb0nRv9WT4eQyHWPjS8q8SjGtasY
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311110140
X-Proofpoint-SSN: Sensitivity3

------=_NextPart_000_000A_01DA1488.3ED56090
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_000B_01DA1488.3ED56090"


------=_NextPart_001_000B_01DA1488.3ED56090
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

As part of my company's migration from SVN to git, we discovered a

performance issue in rev-list with large repositories.  The issue =
appears to

be metadata-dependent; we were able to work around it (completely =
avoiding

any performance penalty) by changing the date of certain commits.

=20

The general structure of our repository is I think fairly normal (if =
large

-- we have >5.5 million commits total).  We have a handful of trunk

branches, and ~10k total refs.  To reduce the ref count (we hit other

performance issues when we had significantly more refs), we remove refs =
as

we're done with them.  Any code that doesn't make it into a trunk is

preserved in an archive branch.  The archive branch has no content, and

consists entirely of octopus merges with 50-500 parents.

=20

If the archive branch is created with author/commit dates older than the

rest of the repository, we're able to run:

  $ git rev-list --count --all

in ~9-10 seconds on a mirror clone with a commit-graph.  However, if the

archive branch is instead created with author/commit dates newer than =
the

rest of the repository, it takes 4-5 minutes.

=20

Using any order other than the default or --reverse removes the =
disparity.

All orders except --author-date-order bring things much closer to the =
~9-10

seconds we see with the workaround, and --author-date-order is still =
under a

minute (though not by much).

=20

System info from git bugreport:

  [System Info]

  git version:

  git version 2.42.0.windows.2

  cpu: x86_64

  built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3

  sizeof-long: 4

  sizeof-size_t: 8

  shell-path: /bin/sh

  feature: fsmonitor--daemon

  uname: Windows 10.0 19044

  compiler info: gnuc: 13.2

  libc info: no libc information available

  $SHELL (typically, interactive shell): C:\Program =
Files\Git\usr\bin\bash.exe

=20

  (no enabled hooks)

=20

Note that we first realized this was an issue on our GitLab instance, =
which

runs on Linux, so this is not a Windows-specific bug.

=20

I created a bash script to create very similar repositories that are/are =
not

affected by the issue; it follows.  The issue starts to become visible =
at 1

million commits (the default), where the difference is ~2x.  5 million

commits is roughly equivalent performance-wise to what we saw in our

repository, with a difference of ~33x.  Note that with 5 million =
commits,

each repository is ~1.2 GB and takes 7-8 minutes to create on an i9-9900

with NVMe storage.

=20

Once you create a fast and a slow repo with the script, try the =
following

commands in each one:

  # Shows the performance difference

  $ time git rev-list --count =E2=80=93all

  # Shows very similar performance across both repos

  $ time git rev-list --count --all --topo-order

=20

Thank you,

Kevin Lyles

klyles@epic.com <mailto:klyles@epic.com>=20

----------------------------------------

=20

#!/bin/bash

=20

usage=3D"Usage: $0 <destination folder> <--fast|--slow> [Number of =
commits (default: 1000000)]"

destinationFolder=3D${1:?$usage}

=20

oldTimestamp=3D315554400 # 1980-01-01 midnight

newTimestamp=3D1672552800 # 2023-01-01 midnight

if [ "$2" =3D=3D "--fast" ]

then

    archiveTimestamp=3D$oldTimestamp

elif [ "$2" =3D=3D "--slow" ]

then

    archiveTimestamp=3D$newTimestamp

else

    echo "$usage" >&2

    exit 1

fi

=20

numberOfCommits=3D${3:-1000000}

if ! [[ "$numberOfCommits" =3D~ ^[0-9]+$ ]]

then

    echo "$usage" >&2

    exit 1

fi

=20

increment=3D$(( (newTimestamp - oldTimestamp) / (numberOfCommits + 2) ))

=20

timestamp=3D$oldTimestamp

=20

rm -rf "$destinationFolder"

git init "$destinationFolder"

=20

echo "Fast-importing repo, please wait..."

{

    echo "feature done"

    echo "reset refs/heads/main"

    echo ""

=20

    for count in $(seq "$numberOfCommits")

    do

        timestamp=3D$(( timestamp + increment ))

        echo "commit refs/heads/main"

        echo "mark :$count"

        echo "committer Test Test <test@test.com <mailto:test@test.com> =
> $timestamp -0500"

        echo "data <<|"

        echo "Main branch commit #$count"

        echo "|"

        echo ""

    done

=20

    parentMark=3D0

    echo "reset refs/archive"

    for count in $(seq $(( numberOfCommits / 1000 )))

    do

        echo "commit refs/archive"

        echo "committer Test Test <test@test.com <mailto:test@test.com> =
> $archiveTimestamp -0500"

        echo "data <<|"

        echo "Archive branch commit #$count"

        echo "|"

        for parentCount in {1..50}

        do

            parentMark=3D$(( (parentMark + 99991) % numberOfCommits + 1 =
))

            echo "merge :$parentMark"

        done

        echo ""

    done

=20

    echo "done"

} | git -C "$destinationFolder" fast-import

=20

git -C "$destinationFolder" commit-graph write


------=_NextPart_001_000B_01DA1488.3ED56090
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 15 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>As part of =
my company's migration from SVN to git, we discovered a<o:p></o:p></p><p =
class=3DMsoNormal>performance issue in rev-list with large =
repositories.&nbsp;&nbsp;The issue appears to<o:p></o:p></p><p =
class=3DMsoNormal>be metadata-dependent; we were able to work around it =
(completely avoiding<o:p></o:p></p><p class=3DMsoNormal>any performance =
penalty) by changing the date of certain commits.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The general =
structure of our repository is I think fairly normal (if =
large<o:p></o:p></p><p class=3DMsoNormal>-- we have &gt;5.5 million =
commits total).&nbsp;&nbsp;We have a handful of trunk<o:p></o:p></p><p =
class=3DMsoNormal>branches, and ~10k total refs.&nbsp;&nbsp;To reduce =
the ref count (we hit other<o:p></o:p></p><p =
class=3DMsoNormal>performance issues when we had significantly more =
refs), we remove refs as<o:p></o:p></p><p class=3DMsoNormal>we're done =
with them.&nbsp;&nbsp;Any code that doesn't make it into a trunk =
is<o:p></o:p></p><p class=3DMsoNormal>preserved in an archive =
branch.&nbsp;&nbsp;The archive branch has no content, =
and<o:p></o:p></p><p class=3DMsoNormal>consists entirely of octopus =
merges with 50-500 parents.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>If the =
archive branch is created with author/commit dates older than =
the<o:p></o:p></p><p class=3DMsoNormal>rest of the repository, we're =
able to run:<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;$ git =
rev-list --count --all<o:p></o:p></p><p class=3DMsoNormal>in ~9-10 =
seconds on a mirror clone with a commit-graph.&nbsp;&nbsp;However, if =
the<o:p></o:p></p><p class=3DMsoNormal>archive branch is instead created =
with author/commit dates newer than the<o:p></o:p></p><p =
class=3DMsoNormal>rest of the repository, it takes 4-5 =
minutes.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Using any order other than the default or --reverse =
removes the disparity.<o:p></o:p></p><p class=3DMsoNormal>All orders =
except --author-date-order bring things much closer to the =
~9-10<o:p></o:p></p><p class=3DMsoNormal>seconds we see with the =
workaround, and --author-date-order is still under a<o:p></o:p></p><p =
class=3DMsoNormal>minute (though not by much).<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>System info =
from git bugreport:<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;[System Info]<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;git version:<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;git version =
2.42.0.windows.2<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;cpu: =
x86_64<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;built from commit: =
2f819d1670fff9a1818f63b6722e9959405378e3<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;sizeof-long: 4<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;sizeof-size_t: 8<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;shell-path: /bin/sh<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;feature: =
fsmonitor--daemon<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;uname: =
Windows 10.0 19044<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;compiler info: gnuc: 13.2<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;libc info: no libc information =
available<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;$SHELL =
(typically, interactive shell): C:\Program =
Files\Git\usr\bin\bash.exe<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;(no enabled hooks)<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Note that we =
first realized this was an issue on our GitLab instance, =
which<o:p></o:p></p><p class=3DMsoNormal>runs on Linux, so this is not a =
Windows-specific bug.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I created a =
bash script to create very similar repositories that are/are =
not<o:p></o:p></p><p class=3DMsoNormal>affected by the issue; it =
follows.&nbsp;&nbsp;The issue starts to become visible at =
1<o:p></o:p></p><p class=3DMsoNormal>million commits (the default), =
where the difference is ~2x.&nbsp;&nbsp;5 million<o:p></o:p></p><p =
class=3DMsoNormal>commits is roughly equivalent performance-wise to what =
we saw in our<o:p></o:p></p><p class=3DMsoNormal>repository, with a =
difference of ~33x.&nbsp;&nbsp;Note that with 5 million =
commits,<o:p></o:p></p><p class=3DMsoNormal>each repository is ~1.2 GB =
and takes 7-8 minutes to create on an i9-9900<o:p></o:p></p><p =
class=3DMsoNormal>with NVMe storage.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Once you =
create a fast and a slow repo with the script, try the =
following<o:p></o:p></p><p class=3DMsoNormal>commands in each =
one:<o:p></o:p></p><p class=3DMsoNormal>=C2=A0 # Shows the performance =
difference<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;$ time git =
rev-list --count =E2=80=93all<o:p></o:p></p><p class=3DMsoNormal>=C2=A0 =
# Shows very similar performance across both repos<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;$ time git rev-list --count --all =
--topo-order<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thank you,<o:p></o:p></p><p class=3DMsoNormal>Kevin =
Lyles<o:p></o:p></p><p class=3DMsoNormal><a =
href=3D"mailto:klyles@epic.com">klyles@epic.com</a><o:p></o:p></p><p =
class=3DMsoNormal>----------------------------------------<o:p></o:p></p>=
<p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>#!/bin/bash<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>usage=3D&quot;Usage: $0 &lt;destination folder&gt; =
&lt;--fast|--slow&gt; [Number of commits (default: =
1000000)]&quot;<o:p></o:p></p><p =
class=3DMsoNormal>destinationFolder=3D${1:?$usage}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>oldTimestamp=3D315554400 # 1980-01-01 =
midnight<o:p></o:p></p><p class=3DMsoNormal>newTimestamp=3D1672552800 # =
2023-01-01 midnight<o:p></o:p></p><p class=3DMsoNormal>if [ =
&quot;$2&quot; =3D=3D &quot;--fast&quot; ]<o:p></o:p></p><p =
class=3DMsoNormal>then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;archiveTimestamp=3D$oldTimestam=
p<o:p></o:p></p><p class=3DMsoNormal>elif [ &quot;$2&quot; =3D=3D =
&quot;--slow&quot; ]<o:p></o:p></p><p =
class=3DMsoNormal>then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;archiveTimestamp=3D$newTimestam=
p<o:p></o:p></p><p class=3DMsoNormal>else<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo &quot;$usage&quot; =
&gt;&amp;2<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;exit 1<o:p></o:p></p><p =
class=3DMsoNormal>fi<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>numberOfCommits=3D${3:-1000000}<o:p></o:p></p><p =
class=3DMsoNormal>if ! [[ &quot;$numberOfCommits&quot; =3D~ ^[0-9]+$ =
]]<o:p></o:p></p><p class=3DMsoNormal>then<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo &quot;$usage&quot; =
&gt;&amp;2<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;exit 1<o:p></o:p></p><p =
class=3DMsoNormal>fi<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>increment=3D$(( (newTimestamp - oldTimestamp) / =
(numberOfCommits + 2) ))<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>timestamp=3D$oldTimestamp<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>rm -rf =
&quot;$destinationFolder&quot;<o:p></o:p></p><p class=3DMsoNormal>git =
init &quot;$destinationFolder&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>echo =
&quot;Fast-importing repo, please wait...&quot;<o:p></o:p></p><p =
class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo &quot;feature =
done&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo &quot;reset =
refs/heads/main&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;&quot;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;for count in $(seq =
&quot;$numberOfCommits&quot;)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;do<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;timesta=
mp=3D$(( timestamp + increment ))<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;commit refs/heads/main&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;mark :$count&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;committer Test Test &lt;<a =
href=3D"mailto:test@test.com">test@test.com</a>&gt; $timestamp =
-0500&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;data &lt;&lt;|&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;Main branch commit #$count&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;|&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;done<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;parentMark=3D0<o:p></o:p></p><p=
 class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo &quot;reset =
refs/archive&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;for count in $(seq $(( =
numberOfCommits / 1000 )))<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;do<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;commit refs/archive&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;committer Test Test &lt;<a =
href=3D"mailto:test@test.com">test@test.com</a>&gt; $archiveTimestamp =
-0500&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;data &lt;&lt;|&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;Archive branch commit #$count&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;|&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for =
parentCount in {1..50}<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;do<o:p>=
</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;parentMark=3D$(( (parentMark + 99991) % numberOfCommits =
+ 1 ))<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;echo &quot;merge :$parentMark&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;done<o:=
p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;&quot;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;done<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;echo =
&quot;done&quot;<o:p></o:p></p><p class=3DMsoNormal>} | git -C =
&quot;$destinationFolder&quot; fast-import<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>git -C =
&quot;$destinationFolder&quot; commit-graph =
write<o:p></o:p></p></div></body></html>
------=_NextPart_001_000B_01DA1488.3ED56090--

------=_NextPart_000_000A_01DA1488.3ED56090
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
lvN8hpWsTIfhgQ6Go4M1h6qWeyyGzqBRho2nJgIBZAIBBDApBgNVHSUEIjAgBggrBgEFBQcDAgYI
KwYBBQUHAwQGCisGAQQBgjcKAwQwDgYDVR0PAQH/BAQDAgWgMDUGCSsGAQQBgjcVCgQoMCYwCgYI
KwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqG
SIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwOwYDVR0RBDQw
MqAfBgorBgEEAYI3FAIDoBEMD2tseWxlc0BlcGljLmNvbYEPa2x5bGVzQGVwaWMuY29tMB0GA1Ud
DgQWBBR0ikFo64YusMi/AQPG+NbvrSyl9DAfBgNVHSMEGDAWgBQFr+YhdOoikFkfjRuV2E05BtxV
CTCCAS8GA1UdHwSCASYwggEiMIIBHqCCARqgggEWhoHHbGRhcDovLy9DTj1FcGljJTIwSXNzdWlu
ZyUyMENBJTIwRmlzaHN0aWNrcyxDTj1maXNoc3RpY2tzLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWVwaWMsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIZKaHR0cDovL2Zpc2hzdGlja3MuZXBpYy5jb20vQ2VydEVucm9sbC9FcGljJTIwSXNzdWlu
ZyUyMENBJTIwRmlzaHN0aWNrcy5jcmwwgc8GCCsGAQUFBwEBBIHCMIG/MIG8BggrBgEFBQcwAoaB
r2xkYXA6Ly8vQ049RXBpYyUyMElzc3VpbmclMjBDQSUyMEZpc2hzdGlja3MsQ049QUlBLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9ZXBp
YyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRo
b3JpdHkwTwYJKwYBBAGCNxkCBEIwQKA+BgorBgEEAYI3GQIBoDAELlMtMS01LTIxLTQwNzIyNzYx
NDUtMTE0MzEwOTY4MC0xNjA2OTcwNTcyLTYzNTkwDQYJKoZIhvcNAQELBQADggIBAJxE8ITndATV
NhVLk7rs8vg06CUy/uAMcHA0x4UtulE5DnHYejff5/1XNzrq/pw2KyCVZ0W8ylV1oDNrI2pqbdkd
XNsWXq7CQbQnMUDT52cTGVHOOZ8O0eHT0VjOGD1lJHh637dCRAEZjLgfzGE6zc/k/fS+FekvOoQJ
wMUSpoRDnws6hToCxfgTP0x+puvM0hbULRemTyQHejpXKCUu1DT8Mlu9/KbZxVB/BvttRXobkkSZ
noc5L+u2A388PZbcPoh355iVfMPF7tns95cCEgYj/9xnas9Y4uoHyzKvCPzgtlLMN+vt2muDDsZ0
WyPFK4Winia/fz28TMbSNsJiuKooewdOdf0Q04eudw+qfgngDQMiwEkHKyNUk8CgJD2qLe69/Z5X
4E7VvXSlOxEJ77I73HyEFLewPtoKv4u8ZreLtAwKHjpYckuddczo3P989+IjkmAYCRKW0rwK7oOr
VpYVSVcZBl8xVoP9zh+rzXxTL+yYoCcczMgK8hDvsOCma6sVubii7JeIQVVC/aBiJZMarWxpF3O7
WTrtW+raPEMSpFtfH4rsVkvMSF+CwiEEnGj7PXpaz9APumSL2UAtX+M86lO+xnYYKGwwEiRclBDm
3F9B6lqXWQ0R8krpnmJOz93vnoaD9n5c8p40PIuBA4bgQlB86MLLU2Jy53GDIWRhMYIDhzCCA4MC
AQEwZzBQMRMwEQYKCZImiZPyLGQBGRYDY29tMRQwEgYKCZImiZPyLGQBGRYEZXBpYzEjMCEGA1UE
AxMaRXBpYyBJc3N1aW5nIENBIEZpc2hzdGlja3MCE00ASlBq0oqSNaQwpukAAQBKUGowDQYJYIZI
AWUDBAIBBQCgggHxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MTExMTE2MTcxNlowLwYJKoZIhvcNAQkEMSIEIJIIco4oK9D+4cIFEPNwGV0yLVPkcC+IlW1b/2cP
r9K7MHYGCSsGAQQBgjcQBDFpMGcwUDETMBEGCgmSJomT8ixkARkWA2NvbTEUMBIGCgmSJomT8ixk
ARkWBGVwaWMxIzAhBgNVBAMTGkVwaWMgSXNzdWluZyBDQSBGaXNoc3RpY2tzAhNNAEpQatKKkjWk
MKbpAAEASlBqMHgGCyqGSIb3DQEJEAILMWmgZzBQMRMwEQYKCZImiZPyLGQBGRYDY29tMRQwEgYK
CZImiZPyLGQBGRYEZXBpYzEjMCEGA1UEAxMaRXBpYyBJc3N1aW5nIENBIEZpc2hzdGlja3MCE00A
SlBq0oqSNaQwpukAAQBKUGowgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowDQYJ
KoZIhvcNAQEBBQAEggEAywGqSQaRlr6cKwkYXm07RMqdn9ssghKdZ44GVsoS2Ws6pUJfiuAmASY5
jy8mwasdyzpA7CR1GG8RdfauB91410RiDvodYraMgzV+Ui8BSdfmyqL/adUA0VWpqUQhHmbiS3Cu
Jua8DddCfyRI99OA5t2NQWwT8evnldnIZS7vaE3X4LFBIxzCoCbDlW9XyE5ziZpG5goHrKFBWGqh
hfh6Q3cCHeAa08EZ0ZIK7tDdyNiVA+mP04noh2Z+iwK93Jwg3IfDaYPvOsYF5q4qXEmnC170Vy1b
asudHvTOB+9zFIIt+XKmw8f4s8/SC+g4CWLjMn1gkD3Zaed7w6FI3YrxggAAAAAAAA==

------=_NextPart_000_000A_01DA1488.3ED56090--
