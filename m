Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D041F731
	for <e@80x24.org>; Sat, 10 Aug 2019 16:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfHJQdw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 10 Aug 2019 12:33:52 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:10684 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbfHJQdw (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Aug 2019 12:33:52 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7AGWNEM005784
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 16:33:51 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2u9m48u0fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 16:33:51 +0000
Received: from G4W10205.americas.hpqcorp.net (g4w10205.houston.hpecorp.net [16.207.82.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 8791362
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 16:33:50 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Sat, 10 Aug 2019 16:33:50 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sat, 10 Aug 2019 16:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX7sjfkr7P7EAdAWYNViJEJQoSQeEQQfy6hKsweW64EgipQjAgSD6qauZoiCboTETTIdWngpTFnsqybjVQJQI2OINx4pZ7CRxXCw4lA9o8LyKvEEz++Y59kQp21NDKuYd350A5GvJ0PICFWdEWInE4gdTack72LT1Cz5ec/QZ1vqE6Rk3GfFq2b2gdFTlZ0hppoJQCEM84x5jJ1GQQfIb7x2CpVh0URtuDbb03I91pgiM+T2TvPpDDcfkv9flQP7asa8SxFVGe0QkIe97kL2yKxTWPlL2G4xUWG6CHvqLtImayWAvCgL2UGtOt2cF3KGmCH7FTV2dLjOOrNeMNbFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGOM2lMoRKKYjvorsgH9IXBPG658BRICWsiPdTO8slU=;
 b=kT3uhC1QkWgzojLK2sWdCsS2/cFpOvHZYpGc6S+KVd9tfVv424mYO+ylHSBw+70EYAbJMK5r7ylR5fJYqm7XSow4nu90fUeZ74mZepexOM/Etw1HEPW3UqiAafA7zjXbmLgFu9H+tFR/cgpuS8aWgG+0kBYsdgq05WOxf0+CLEiH3vdEX9taWzQ41EU8JVMYKDG5JBszz91sXWGkG1DC8aicPowygWhdJRBfti5zl+XmIXBIosBDffQUctJkRhzljd4UL09w/DvHw5d2PMluemMijEFpPxNXeCWT7WX93ZBvyg+d0oPzjIE7O/grNZ7ZKoNPJFvFdKJLJDrR0TzdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.13) by
 TU4PR8401MB0719.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Sat, 10 Aug 2019 16:33:49 +0000
Received: from TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4024:f7f1:9dc1:d80d]) by TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4024:f7f1:9dc1:d80d%3]) with mapi id 15.20.2157.022; Sat, 10 Aug 2019
 16:33:49 +0000
From:   "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-svn help for non-standard tags/branches !!
Thread-Topic: git-svn help for non-standard tags/branches !!
Thread-Index: AdVPmGscU9JlqtSTSiScmOEE2jDdjgAAOYfw
Date:   Sat, 10 Aug 2019 16:33:48 +0000
Message-ID: <TU4PR8401MB1216C124AC71846834527C5BE1D10@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB12164299DDBEA3A7EBD7D040E1D10@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <TU4PR8401MB12164299DDBEA3A7EBD7D040E1D10@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.172.56.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9fdd40-0adf-4000-83d8-08d71db085a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0719;
x-ms-traffictypediagnostic: TU4PR8401MB0719:
x-microsoft-antispam-prvs: <TU4PR8401MB07196384FAB3CE4DCBC001E6E1D10@TU4PR8401MB0719.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(8676002)(55016002)(8936002)(5640700003)(6436002)(66066001)(53936002)(81166006)(81156014)(1730700003)(6116002)(3846002)(99286004)(2940100002)(476003)(76116006)(486006)(186003)(446003)(11346002)(6916009)(86362001)(66446008)(64756008)(66556008)(66476007)(66946007)(256004)(102836004)(25786009)(478600001)(316002)(6506007)(7736002)(71200400001)(9686003)(305945005)(71190400001)(2906002)(2501003)(76176011)(52536014)(14454004)(7696005)(26005)(5660300002)(33656002)(74316002)(2351001)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0719;H:TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OwqC7rIj/qisO5GjAHXTQxOJf9y85fQ2XglJbaedPhH5C5SoFn2VOXmp4UZ+VGmMY8jqJqDQoi++shQYG5OO2pPnECSmfI9CyfPO4vVrdvHRBZYmm5IP6StEf6ttQgHyi0r95J66ajHu8oaErk2n8FRR/ALcf+CjSJrypo9v99EBClno5zXM3++amd55pqtqaltFxPMGOseA5UgvcXwXJBvRdO6rJh+2bYjwlL5SPXOHnm64lAFBSp5ZH1urmmlGuJjh4jW7CzDPgWHVG94Uc5hgaqBEFBaPw//23F7skbJQ4fNcxkAX0QGHK1XVQtRD1Sz8RA0YzHrBrO6Pw0a1MBRWcmdzz8dBPa9I9f9lIzrfKvLD26d51uiHGgpDuzEgqW4KY9gSV6a9K4A6Yzw3N9DDvR7m6/vuyRucT+C2oVI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9fdd40-0adf-4000-83d8-08d71db085a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 16:33:48.8842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyROPoJVJuXrjjNUM//zoGqfezkli8LRk7PXK6ehIk7B+tY0RyF/HUXB+ERcGpNwG1H3tAoxViHcLoNmCLC/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0719
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=769 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908100184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have been using git-svn tool for SVN to GIT migration. I see issues in migration of branches/tags located in SVN at different level of hierarchy. To some extent I can define the layout in config file but it's difficult in few cases. like https:<svn_repo_url>/svnrepo

a/b/branches/<actual_branches>
a/b/c/branches/<actual_branches>
a/b/c//d/e/branches/<actual_branches>

a/b/c/d/tags/<tags>
a/tags/<tags>

How to manage this ? Is there any wildcard or regular expression support that be used in config file.

Thanks
Ibrahim

