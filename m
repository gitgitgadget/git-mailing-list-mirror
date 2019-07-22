Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A031F1F461
	for <e@80x24.org>; Mon, 22 Jul 2019 20:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfGVUJ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 16:09:28 -0400
Received: from mx0a-00103a01.pphosted.com ([67.231.144.234]:10976 "EHLO
        mx0a-00103a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfGVUJ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jul 2019 16:09:28 -0400
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 16:09:27 EDT
Received: from pps.filterd (m0174892.ppops.net [127.0.0.1])
        by mx0a-00103a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6MJiZWd009787
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 15:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciena.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=06252019; bh=BpeRSqXygAYHCpmr2n/jnvJAssrbFVJEi11HNzRRjZ4=;
 b=Z0dnSIh5svKxULQGhq/dGIsr6Wi6sjmKW6KH/mdhpMz8b7AxoeQeW8dmYyVsUAbNjBIv
 mb6AokXEcPEhjJPRDXb4/HHusxl7Hon8FwLPMNGfFmuVraFj5960/7o2YQmQR8mMXi67
 7y4m3u+Tuqt332p9mbF26k1LpvYu+608UHBCzy8ZUdEpBjRMgD5COiEvPnlSfx8NqZ1v
 zNW6fta2jlKgvoTHw5iTSFXLN0CiErRCj2YzSMv0LvaHt8a6R5HFNXnygqtvAUqF3Ghz
 U83Q/+9aHMZSEFj1TzEdxHP/HkFFG/C1x+sDTmcZuZCznbrDohfvEYNSNvVO/LclZKgQ dg== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-00103a01.pphosted.com with ESMTP id 2twd58t38g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 15:46:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1XsWxuNE4BpimXhiTg9GCYw4DMWDyYAjIWWxrrvBqNDCv9AshCxtxQD7kfbgBBUN0sq74e0agZ4XuG1f+3fhegLI4EK1r29c3mDr+4NYSXLFeSh09Ze3D9idEUytsj/PjVoF7Z9JZALe7EtUobSYSMGwx6WYA3vz15v8WGsNoQTJTGZ+SfpqjDTwqxqHPKNJ85IGW27NJ6i+Njim6B5184pyKt6iS5O3u11NQ7fc0LUXFEu5Lhvd8smZvekwNiK3a/wKTkNjwSoGU6YPMdsZ1C5oNDn0pF+7urJ4ymXUXVk3b5TcPppfE6dM3am5v+o8DPLLnCrOP2PbGd85p2rAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpeRSqXygAYHCpmr2n/jnvJAssrbFVJEi11HNzRRjZ4=;
 b=DvYwfxlWjUGyWqnnJmWI77Qieg2nK1AdVLb3aGYKh6rWggDewKjAtHOpF71qrtQaqG5ZnPfcxVBIIxjavcgjBKIqzM4ot3HJSdgGdfbjCmrnxBFGdtCeCZ5PWg3Ms/0EPfRNp9uUmR27QRb06rvgnFgITvNkxrMfYtwZv6vZGxGGGfvwSd3InAaOL5mip8NV37IOBdiINsVupLVWMjeUjzhBI4dF6/t/K5Q1wH6a1/6xpssBO8F0kkxrCj4y+88W7KSgQvL/hg/Rxc61rS0kP2MeCmz3rdiNjFavnD6jserYqNQxMwO0nyhQfQxmorHvTNVRCHQQR60icA6cI4rs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=ciena.com;dmarc=pass action=none
 header.from=ciena.com;dkim=pass header.d=ciena.com;arc=none
Received: from DM6PR04MB4793.namprd04.prod.outlook.com (20.176.107.210) by
 DM6PR04MB5180.namprd04.prod.outlook.com (20.178.24.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 19:46:38 +0000
Received: from DM6PR04MB4793.namprd04.prod.outlook.com
 ([fe80::a023:f649:f717:6068]) by DM6PR04MB4793.namprd04.prod.outlook.com
 ([fe80::a023:f649:f717:6068%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 19:46:38 +0000
From:   "Raitanen, Adam" <araitane@ciena.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Possible bug in Makefile when executing curl-config
Thread-Topic: Possible bug in Makefile when executing curl-config
Thread-Index: AdVAxiwguVNvTN0bQWKLWMnA3UfWZQ==
Date:   Mon, 22 Jul 2019 19:46:37 +0000
Message-ID: <DM6PR04MB47939645A97D099241AD25F0D0C40@DM6PR04MB4793.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.48.12.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d30e147-c2db-452b-290b-08d70edd4f79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR04MB5180;
x-ms-traffictypediagnostic: DM6PR04MB5180:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR04MB5180004AE06EE2F354E82C98D0C40@DM6PR04MB5180.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(66066001)(7736002)(316002)(74316002)(6436002)(2501003)(256004)(2906002)(5640700003)(26005)(478600001)(966005)(4744005)(102836004)(86362001)(305945005)(6506007)(2351001)(6916009)(486006)(7696005)(186003)(99286004)(476003)(25786009)(33656002)(6116002)(8676002)(66446008)(52536014)(3846002)(64756008)(14454004)(66476007)(8936002)(1730700003)(76116006)(66946007)(66556008)(81166006)(81156014)(5660300002)(71190400001)(55016002)(53936002)(68736007)(6306002)(9686003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR04MB5180;H:DM6PR04MB4793.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ciena.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yX04gHnnypzLiK0bET8sA/6Nv22rPMCTyGa1Y0KlfkWRdNoa1tpS2lvfUab7ldCdZ/23/6E3L8jjwDd64KuXcHnHlbRPA9uLeXooP/Yob9pZzxew9EX+xoUYYoYpOFADHaPHrW9GnC82+Lugo2TnWQj6K7HfmYvRamGJOkl3jZDuGw3vVrJI5G5yVfgl1l3krtREouo44CHf/Sr2XJ2F3pd36lh+YQgZDIbuDk38Lj/8I22Y8NBlPLdxvHKMQ5PREhoNg9344dK37vufigWtNKdSnoaUlYKpMatV6akZMmCqY+2W+0EHLTtY3Ntj+DAgGl7kTq3iHQFzH/SYze+noT0GRTkC/9fxQM6ub3V7qvvEU1UibL0VNhH3RhwwS9CeayGTYv+EFNyrWt2CtAFioom2MARhwRsuSH10VeEGBuQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ciena.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d30e147-c2db-452b-290b-08d70edd4f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 19:46:37.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: araitane@ciena.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5180
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-22_14:2019-07-22,2019-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1904300001 definitions=main-1907220216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe there may be a bug in the Makefile introduced by the following co=
mmit:

https://github.com/git/git/commit/23c4bbe28e61974577164db09cbd1d1c7e568ca4

The commit was merged in 2.20.0:

* The way -lcurl library gets linked has been simplified by taking
=A0=A0 advantage of the fact that we can just ask curl-config command how.

Unfortunately it assumes that curl-config is in the path which is not alway=
s the case. When using "--with-curl=3D/path/to/curl" in the configure comma=
nd, the path to the actual curl-config executable is ignored and the build =
fails around here:

=A0=A0=A0 CC http-fetch.o
make: curl-config: Command not found
=A0=A0=A0 LINK git-http-fetch
http.o: In function `fill_active_slots':
/tmp/git-2.21.0/http.c:1385: undefined reference to `curl_easy_cleanup'
.

We were able to workaround this by forcing the correct path into the make e=
nv:

make CURL_LDFLAGS=3D"$(/path/to/curl/curl-config --libs)".

I reproduced the problem in the latest version 2.22.0.

Thanks,
Adam

