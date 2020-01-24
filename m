Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2CC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA6B2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbgAXSH7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Jan 2020 13:07:59 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34678 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388558AbgAXSH6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Jan 2020 13:07:58 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OI3Ukd027639
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 18:07:57 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2xr4wc0buc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 18:07:57 +0000
Received: from G4W9121.americas.hpqcorp.net (g4w9121.houston.hp.com [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 0ADE491
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 18:07:57 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 24 Jan 2020 18:07:57 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.11) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 24 Jan 2020 18:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9EmZMM+IJCNl0WW4tCNDf3igcTYs1MLk1b1MgZTB8m5T8CD+P1FtwbJ9jvxYGbw7Vx1DCjmjUkfTXtzGmW1tDJ6xwN/Mv/QObMqmNR35Jm4wu+wzO6J1B2wJ8m011W2yepzIH4SjY6MTyY/J5GwUes8E2VzD6HG5JG7bdcgve3URccWIZLm5/4RBCnRvQDRT6DG4opUebXVYEKE2sgUw9VrsYofVx4LoQknanNDNzZZyTyWyw8zWd4m5OI8oPGCulsc1LGReAL74xbv7Q3Lewpt/6ATKq5jrEWjrwUrlatIixOhX5CjMnHRheT/v6y8wmZswyrfBuZwEcQS9/OS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMWsXRnl4jyD2xTtCZ+jIi1HNax+LTcQqR3Xb8Tv1D8=;
 b=i5xXBuDqpybLHsIvFQBlxiMDhC7tL9ysGTNIkC98XqgL/eSatyGt5zh6YKI4EoV4UJUC7t5isheYLf3bgyeT/Dd7RdyYiNqo8QD5IuaekNTGAj9BjJfaPxPEiM8F4s4KXaqX836rC91WxOeAXnsA20VyR43bMJn1oBrG3iEEdts24Cd0Imi8d6Vq1DlOly/RfcQReI7QuKEBy3DFUPBcOQgEwNJueC+w6lLW+UmqtDkX2YWBI/Pv2qYywgpkHFRLV/ym91vkeD2atTT0mJ8RkS5JKplvO+QKci5gId9+v4RYo/BGrVy3IN6Z8bKC0W8LFwYiiustKqGpJwxW9PJkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.136) by
 TU4PR8401MB0541.NAMPRD84.PROD.OUTLOOK.COM (10.169.51.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 18:07:55 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::acc0:c9be:d2fd:2dce%8]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 18:07:55 +0000
From:   "Crabtree, Andrew" <andrew.crabtree@hpe.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Inconsistent results from git rev-parse --show-toplevel
Thread-Topic: Inconsistent results from git rev-parse --show-toplevel
Thread-Index: AdXS4BNVVmw1+EsZS66tVrOnfS2Q2Q==
Date:   Fri, 24 Jan 2020 18:07:55 +0000
Message-ID: <TU4PR8401MB111758B9513DD7D8B96CBFAAF90E0@TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [104.220.13.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4ce1fc1-d6fe-45ae-04bb-08d7a0f85628
x-ms-traffictypediagnostic: TU4PR8401MB0541:
x-microsoft-antispam-prvs: <TU4PR8401MB05412A02792F9C7BEDA407A5F90E0@TU4PR8401MB0541.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(478600001)(52536014)(33656002)(66476007)(6506007)(66446008)(76116006)(71200400001)(66946007)(66556008)(7696005)(6916009)(64756008)(9686003)(55016002)(186003)(2906002)(5660300002)(55236004)(26005)(8936002)(8676002)(86362001)(81156014)(81166006)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0541;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvFUTeTRImcbRg0g53rTRxLWiWclXwTYoA5QoCI2w6Hmg8Nsk8USc5uRDL5WBy7uuyp0hl5HAWrR93GfjCsBhoZjvaoHEWqdNy7n0N6IAGS/qiUjgIRizCeYKxGGsoICHBJRc7zliyH+zN0TiqL3SlJ4i28QRd7vpvYPwYK/9kJKEhV2dbptGRaDuV/zbxHgsKZk/0lQonAPFtWN6v9upagZqIQlpz4J1T9DykLEWi0cIbXYScZMVLpvGaLtY7KXlvc4PQnYqlaih/sbOMxizat7C2Y7VH5mafJ4NRYrZcZ/oJvWP2dKJ9+Ps33DY5CtUW+LIrYxslc58yNFxN3qL+gP6mYLeADW/vs+DwkeniwnI9Bgg3gOKRsa57mSXnU08UlmmYicp4SDwzwgEGHiVy4Ac9U39i9cEMotjikFMGgInUeB2pBwzgTjB1cbCHUM
x-ms-exchange-antispam-messagedata: 3ZM18vihDhWug2dHWZdHUAeyQkvE7G1clTE5m4kGdq8M2bXTXwZhdcDyuasOP/hIJmgmvHhc/KIKauI89vhd5nBPj2e9b/EFAINYVTowIKVp/STx704fVqJ+LUVSuuCzIcfRwV9ahf9doKhp7CeBOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce1fc1-d6fe-45ae-04bb-08d7a0f85628
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 18:07:55.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +x25FK0BnaAOcqSd6Hw5FcuQRcQS+ofSg/uyzNdjCr4B0PpFNF/I6thwXSpRVRUS0NJ+vjh2bUiJvWX/e4sfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0541
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_06:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 mlxlogscore=797
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001240148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into an issue where 'git rev-parse --show-toplevel' is reporting the current directory instead of the root of the repository.
In my case I'm running it from within the pre-commit hook, and it seems like it might be related to GIT_DIR being set. 
It may also be related to using worktrees.  Haven't had a chance to test thoroughly.

Regards,
-Andrew

Git Version -  2.25.0

pre-commit hook

#!/bin/bash
env
pwd
git rev-parse --show-toplevel
cd subdir
pwd
git-rev-parse --show-toplevel

Create a repo with a subdirectory.   Commit as normal.  Output from the hook looks as expected.  Create a worktree, and commit there and it appears as though it is returning incorrect results after changing directory.

Git repo is in /tmp/revparse_test
Worktree is in /tmp/revparse_test_worktree

Committing in /tmp/revparse_test yields the below, as expected 
/tmp/revparse_test
/tmp/revparse_test
/tmp/revparse_test/subdir
/tmp/revparse_test


Committing in the worktree yields below, with the final line seeming incorrect.
/tmp/revparse_test_worktree
/tmp/revparse_test_worktree
/tmp/revparse_test_worktree/subdir
/tmp/revparse_test_worktree/subdir
