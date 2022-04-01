Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE6C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 21:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiDAVbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 17:31:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2114.outbound.protection.outlook.com [40.107.237.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001F25C5A4
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 14:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsmzACBuRy0ZE2dL1xOXnaegy6dDJWK1mxgoBPUBL4zs9uJEbYGlkjjMo09AiRiYmvYcUs1t2BbBr/1MH3sEOoJBMlV+rN3wiBCGVuq1jzM7WRhFxUmvhgdaSS2wGp54TAdfr+RWJ+cmtdy5Rt0W11WHKWvXl3BmPJHATsS+IX8nO64rM/kpF+0UPvfOA3V5ya1/qLD83R3ayBanSXf7HNeyqaF595/lkv1Vum7sHGr6VhRD9EDchgq4gxe/uEmYptg2l0Iw/Ay/oKteF8UUrc3jWwFXFybQ2L0PuG5g1KCtrdmdGOjSux4LQzx1l78heBAj8O9him04Xv2q5i2Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aERGFu6qPg9H3U7vVagW7SmjWYVNdUc0MKwSIn1EdG0=;
 b=TRRFdrw1rJkKpYGTpArAt3u0KYg2KGlkbSoLXqD/hTBHwglJN3CeE+SypRR5+557zZYQbnaxeI6IFEFSuhI+VLNopJssWQDQTLHjxKojByTNGf8YBoMZqxWkpkHW0/x04PSPLa0idDYdH+Tq+xIJsf3LRKWn8M15D0+c+tpXseHHRpMrU9bYrlX2iVvkcHBY+FwJkh1dxeOaaIT78ZV8a0qOxO+hsWWXyZwGBX8HKuOFZfjlHaVBZibd7ZV+8BP6Bkok1h6FFCZpvA2WmBf1ZNpP8OTYs9DY458o8JRWAU0EmgYACA+WMN1c8pFUD+lym/o6QIXxNbkEuXom2I4OIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucmerced.edu; dmarc=pass action=none header.from=ucmerced.edu;
 dkim=pass header.d=ucmerced.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucmerced.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aERGFu6qPg9H3U7vVagW7SmjWYVNdUc0MKwSIn1EdG0=;
 b=dKWIZQttN3Ao6Kl6lE6U6LdhYJ2mBmM79LkircGKkFAbzHbWjHPZ/i6Cr52naYfEEhycOMdLOejgs1MoLD7ysBDrB2+Q/RFIw7W5nGkHBCFJ7MNxEj+QrCdvK1D83ha5Ae8txIrLJo4zTJ/yTli89VpsBuBLsVTz+Rb3vzM9uSo=
Received: from BYAPR06MB4517.namprd06.prod.outlook.com (2603:10b6:a03:49::15)
 by DM5PR0601MB3656.namprd06.prod.outlook.com (2603:10b6:4:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Fri, 1 Apr
 2022 21:29:10 +0000
Received: from BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::a1ff:2dc9:cf62:c268]) by BYAPR06MB4517.namprd06.prod.outlook.com
 ([fe80::a1ff:2dc9:cf62:c268%5]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 21:29:10 +0000
From:   Jack McGuinness <jmcguinness2@ucmerced.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC] Applicant Introduction, Microproject Selection
Thread-Topic: [GSoC] Applicant Introduction, Microproject Selection
Thread-Index: AQHYRg9JFsI/dNsb6U6gGOHrYY1NIA==
Date:   Fri, 1 Apr 2022 21:29:10 +0000
Message-ID: <BYAPR06MB4517DD6F852491B795FBC922E6E09@BYAPR06MB4517.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9b56d22d-f6fb-fe29-da5b-6532da5132c1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucmerced.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d91f71f8-28d1-43ef-a27e-08da1426a930
x-ms-traffictypediagnostic: DM5PR0601MB3656:EE_
x-microsoft-antispam-prvs: <DM5PR0601MB3656F0D85EAD5796E8FAFE95E6E09@DM5PR0601MB3656.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dvgkh18CDs7IR5eg4I84D1ojD0u+/uEdvv2rt75CWe/7CgDLHBzJvpikfui5Om0GCjNzzXxWvuY2sY2Df9mQMx150ArhEn/q5tSho4ohYYfJXOYqj3f8y0Y8OlRxVjKlm7VXR4W0O0fFYYv7HWzuTESH9le/9OSrQa7cYN/WMDXuRrAx8Xsc+uaPJ+NPgTspwS2PqnHWStiKs9S0eyYMFyt9RizD7/C63YBZGhccgrFjsj4QksO4PHtHL9mgSo4IGA1cXJxJRCVAfcLhaXNgzp2o9D4dZNo80vxmvDnD/TeBsrCM351RDEEd+7RyS5WSdT7Y42HkI27GuyTcfcP+msyc4C+dvh1nGuWBimSp0bppU+hiLUluF9qaTVv4Ey4JpZYvEacCkKaCwcI/QqDPcAxEuWJb3DXHIjwovDjB3FkGdreOcPrlc4U/z2sZ7051l4T9iq4bEwCeDprHGZeCh8NiAVJle8LcXZTEbxAoD4+jz8JTnIZO9km0i1asDETDvTEgiBYaH9ySXnVn+aJtb1c1EqUn4/3O1QwcZ25vgyfXTpnPHPDoyr9cw1QC6mRwSF/YKTliSQljeM+VbIlTC4VIV5yBLLvWlnewV7Nu+YCFKHwMDud6yQlyaViHWEI363zw83iJrr6W+y7CaYT56CmvD+er4tfOMQE7W4pGr42ofcsM64gjD5/whLYFZHcpBxHdkf49mUfusky9U4JXDitrimJxUMVMgLccxje7FRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4517.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(64756008)(8676002)(4744005)(122000001)(33656002)(66446008)(75432002)(26005)(83380400001)(52536014)(8936002)(66946007)(66556008)(66476007)(71200400001)(9686003)(5660300002)(786003)(76116006)(508600001)(6506007)(7696005)(316002)(38070700005)(38100700002)(2906002)(6916009)(86362001)(55016003)(36394005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Cr5PlH13duUfKUQrXpmq/lA4L+h7gP2aXINOfP6n6V3YpVcsjf8EVG1K8?=
 =?iso-8859-1?Q?+YPGL2vpj5ialJFYPMKGuiBDbKi3S7GKdOLsIP7dMraIMyXGRtSi/Dr/Tx?=
 =?iso-8859-1?Q?qUXPIbN+cU1HiNR0kS2xq3/n7anMDs91ozNJZ48koIpniRv3oCMW1TRlvu?=
 =?iso-8859-1?Q?8seuAk89Xw+iBpLiXZB+CYaNM30fejUNQ7/J4pNATou/snqtHNaPxMPcDt?=
 =?iso-8859-1?Q?ExbxfqIhWmJPnJQdX2ACeid7BbWSQkT+ZqLOCOQ69GV6ubAWGOYHyr1aj8?=
 =?iso-8859-1?Q?KQ1Lvk4Zl81yCmcV3yYZ3JfBuJnXUdl5IXq7M0IViklyoH0zNLyqJczo0n?=
 =?iso-8859-1?Q?ECltqsPfuiZIjvzC67nZNQsEzf8HDESVb97YJeVojb8mP53DFCkWw0yw4S?=
 =?iso-8859-1?Q?3iRrSbsLzpeFyWXKYU6zyvb4bLsEMekVbdcty8KjkW+DRtKTGt6Ux+s0gT?=
 =?iso-8859-1?Q?M+XZ8lOzhmVkTvoHBp6rWIpkmZED5LXyIWXoQ20xIS4QL0DGGWikXl8100?=
 =?iso-8859-1?Q?3CZq3x7RTRK9FObhqfex8zkr1Fc8UKIBl+PNVdV7DCyFme9+nRkW+x59cU?=
 =?iso-8859-1?Q?ebzKWc3DYi8Eu22czau/dmmbcF7TQcIMvnKiLYfbnxLpCSqUsFzzGG8sRc?=
 =?iso-8859-1?Q?2e2K8ZyM9rYy76cTFDN83iYbWgngAmoFKXWLDwL5wms+7d+Spc+5BDlzXj?=
 =?iso-8859-1?Q?GyPxXTgln0lFcDIAbHCN3qPmA1wlnFhbq7/QNbHNrSGnEkLUCds/lJztvS?=
 =?iso-8859-1?Q?3tZM3O7vG/MJs3Pghc+W04Iq97SpMeAe+YTsGWb1cXA7zKECdbsPfpTiLf?=
 =?iso-8859-1?Q?No5s7+9EIFyebnacYi9Z7CsCsA+14X4OOLUX+zxS4ZqMtUYkqUF0cZoeBX?=
 =?iso-8859-1?Q?PwVr1FxSdXUh/84SvKpTzhVdhCxSwUI11E+rzMYQ+wncIvxmbnwd3SM2Qz?=
 =?iso-8859-1?Q?+ST3KrZlQ5KhoHiU76f4zU7eL2/DcPWyzbdQxQ8YyZniViKafaS8s2XqsK?=
 =?iso-8859-1?Q?SFTs8fyF2i8mGJzdiutpjtmUR4IWKMsy1swzRYSoMDx3eTyWz0myEUK3K2?=
 =?iso-8859-1?Q?9fY2V3G55NrwdcdlWVJBTVAsGgzCORW6/o38GyUsrPL3KhxNBpcFMU07At?=
 =?iso-8859-1?Q?IL/H96mHt3obUrTbFuLZYiaXFQqhd+c+TU5sB0NME30L3UBMxCj5XgbXe3?=
 =?iso-8859-1?Q?9Wr+z1YmtMabHFGkfHOEpgywK927yZYXesYi4o+TUHLTmKeN5r3SEhZ6g0?=
 =?iso-8859-1?Q?dMo1NVTF9sN4C7mBvHMwcQtAwqSRiu5KBr1cRV3FNnhQDAOnfLPjz7j3Yo?=
 =?iso-8859-1?Q?u77uNAgt+WNKogB7/88730VYHHcmW4vRZQgGJESzZ7Uddb3ip9WF4nNo5O?=
 =?iso-8859-1?Q?2UT/oq5y7XOgsdh5NPb6KypulQmok5naFN1bC5adXEkCfgETgXQfUC86Il?=
 =?iso-8859-1?Q?uzT5XcYge70/cV/IcqE5NUBbcAnAGMHjFgG/gpwf/w4bdLNxIRXt328kK6?=
 =?iso-8859-1?Q?EkckE8BntWpPfXcAcvPI4xhXemOaOeRiyJ3JyyzQ5rqzt9JTmzc9Wucqnd?=
 =?iso-8859-1?Q?83rgbJBE8is2JGdaOmYRkmJ7OLY9JSL6YOH5OTNtu5yW6rIpxxbNs3LWxB?=
 =?iso-8859-1?Q?WtaauH2bVfehJXO1gH1yJIRmukayXKL65QcGMqbqjIzQ+LkyaoFjfTta8J?=
 =?iso-8859-1?Q?4CHT2rLrfz3ifwP/xhP0NloGnZ30PgDV+Ztzcb95yr8WVfNJmeAEQ6fjcn?=
 =?iso-8859-1?Q?ql06zm4nCqhhw+mXkNZFdo5k2/RvzhwI6a7jgNy9ttRR3gXBfz64InbWC6?=
 =?iso-8859-1?Q?Sv1MUd59Tg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucmerced.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB4517.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91f71f8-28d1-43ef-a27e-08da1426a930
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 21:29:10.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f4dfe9a3-ca78-4998-b7a7-e6d0692eace6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m8m4bmM0jvbBHeP6tJbwU5JF+zhOZFmUIupq7jpou4FxQxWIPKrG5z20EMxscnpqHtEOiBCXSuH/2QYmGwVA3x3w3EBz4G7pTscF6w3QqCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3656
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
My name is Jack McGuinness, I'm an undergraduate at U.C. Merced, majoring i=
n Computer Science & Engineering. I very recently found out about Google Su=
mmer of Code, and as someone who has been very interested in the concepts o=
f open-source software for a while, I thought it would be a great opportuni=
ty to get involved and start learning more. The git-scm organization immedi=
ately stuck out to me, due to both its widespread use and my personal use. =
I've looked through the idea list and I plan to apply for the "Unify ref-fi=
lter formats with other pretty formats" project. In preparation for this, I=
 want to do the "Modernize a test script" microproject, but I wasn't sure i=
f someone else was working on this already, so following the recommendation=
 from the description, I want to instead modernize t4202. However, I want t=
o check beforehand that someone else isn't already working on this, or if t=
here is a better test script I could modernize.=0A=
=0A=
Thanks for your time,=0A=
Jack=0A=
