Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C209C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 10:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiEILDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiEILDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 07:03:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140119.outbound.protection.outlook.com [40.107.14.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32B197F75
        for <git@vger.kernel.org>; Mon,  9 May 2022 03:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMBZOdW0o0oTYnIV6/A9GzdbMJB0i8PThtL2bwcB/Bwu+WYcaC82/tnFFD3LZSZA0i606WkwpPoNij3KyJNO2IEvUXR+4Qn9OorEAYxSCmDb3VcOVjiDZhxxOulD/c7VOkHDJgY55DjjssmR3Tgji3r3ou8++/17xgrLwZRx/9STawZTFUlLW1w5QZxdtY96Tk7nGTHFiCa08j7/+bOdDt9Gop+ZHPTFjS0SRs5lXNKFYem3isVKj0sYJnn8mDrbTWA0YqIrqCpa9gbdjAqbKbzA1Ahyc9T3Z99SgyAppvAOd+7sq1yxnt+e3Ytssk2GxMald87QdDfozvM4mCJyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkXVUbTnhfnzJI5x6yB2E7klvhq6YxJOzmwePkN7AzQ=;
 b=kR6i+4Un/crGS1WZlfqaNY4q95YJ0DK6iOqwUzXd+v9+Chepndy/m1H996hiHC8M35di5LMho/aBgq0ZInkvXdazdDThwryUOSrPApJSDac0yOQBeoR1yYfLHUBhzTDgBpV5Sd913eBi/v/5rC+qmI4ETTBMTA3MDLapEqUBnh/XcojWJHUj9hgysF0F93Pe8C1Tq8SraN643dlrobV0qCDyvVx2eauQmwNIZ5XgVib8giLMB3k8s7uge7zyRqI+/4IRmOeJXISuVOnLhSRD6MoBHIIL91EZNmNnJRH+CWTB1zbkrHOac47nCelINeOb0TSlr247pNDIwu/0kkwgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=generationdesign.de; dmarc=pass action=none
 header.from=generationdesign.de; dkim=pass header.d=generationdesign.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUECP.onmicrosoft.com;
 s=selector2-OUECP-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkXVUbTnhfnzJI5x6yB2E7klvhq6YxJOzmwePkN7AzQ=;
 b=psKt/tz53MG5TmDJDGcJ2jDAOr/qQwOBVaHz4N6iXOGQqH59y3kt+SiDVD+Vc6BrEBDa1Qn5SfOS2+qCKIKl1GYYxzW2p3TXZl+ue2M1t8Bs6iEjkypPDjCrQ7olww9MaRuqbZFg17X5DCNRwtyzIcpC2eduM3Qs8Ba+YS4SaOM=
Received: from AM6PR03MB5444.eurprd03.prod.outlook.com (2603:10a6:20b:cb::13)
 by DB8PR03MB6297.eurprd03.prod.outlook.com (2603:10a6:10:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 10:59:08 +0000
Received: from AM6PR03MB5444.eurprd03.prod.outlook.com
 ([fe80::8c8d:5fc9:3527:fbbd]) by AM6PR03MB5444.eurprd03.prod.outlook.com
 ([fe80::8c8d:5fc9:3527:fbbd%2]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:59:08 +0000
From:   "Hebrock, Christoph" <ch@generationdesign.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Confusing note in "gitattributes text=auto" discription
Thread-Topic: Confusing note in "gitattributes text=auto" discription
Thread-Index: Adhjk3YrlXZE//rVTsKSoJKB3SzZ7Q==
Date:   Mon, 9 May 2022 10:59:08 +0000
Message-ID: <AM6PR03MB5444D37306312CE538C9BD1BCAC69@AM6PR03MB5444.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=generationdesign.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 327d90a9-54d9-404e-4665-08da31aaf144
x-ms-traffictypediagnostic: DB8PR03MB6297:EE_
x-microsoft-antispam-prvs: <DB8PR03MB6297355A77F678EDD47695BACAC69@DB8PR03MB6297.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyRuqSt5gDllKeP49FwG2mL4f/PgWdkvi5Af55d53E3kDYx9ESKIateQVpk9C9B+mR/t/Hwa2EP45wDslBjlpVdm+GpcWdlNHOSUPN58NgCK+tl7d6rPu7YUee0hKg1otmQFCqd1xGQzsScVnqXDJFlk6rnLhu15WdiTJYhywmLLej99O1AG6emxfzRc6hCQnRfvCy4nFz+XpEpSojVTaXH6uKKJ/yr1w+dhREnEArtbygyaSWWkxpJ6FkGsheqUCqXpey1LNxdpY/3byu8ecGPJ+X0fJcptMwGKhHW4OVB7kKPIOnP1DMU2Cv1q7eZ83eUuJCNhK6VS5ZaGx3/tR5nAdlkeo9bgek1VM/kPaXWzw5uxm/5Qhq/mVNlEsUgwQ+k3glWl56rOibhbEQATicp1v6iuMiaKbFG6k5YJ2zJXd0lTOYvIU/FpAZerIVMVJeQdYHG0EuEvB/rOir4XD9ehA6MuMRBhS9ME7o7+fjmVvzJqSMEluHuuShRHtv/9Cu6xDgY5KzhGI5Dqqhlmhw/fDK51CcKK0Fb9MSY05jCWibaeVMoMk4gmwYuDE8XY2olgLiuh1uIyP8atpxS01wEYbexrzXt2HDEmsvx5wo333lbw2/hbz4cFPbD0Fv3bBiD+Ag1hFtPtiKTcfOI3VKU5JDU6UAZdI4HggdMqiSl1xCX3cb3OJTzLZxqaXOFKsdFQ/WWjWLNfSmPz2mYHyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5444.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(39830400003)(42606007)(136003)(376002)(346002)(5660300002)(33656002)(86362001)(66446008)(83380400001)(64756008)(66556008)(66476007)(66946007)(4744005)(76116006)(8676002)(186003)(2906002)(316002)(52536014)(8936002)(6916009)(26005)(7696005)(122000001)(508600001)(71200400001)(9686003)(6506007)(55016003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fxRQ5ie8dvFlyj4jA1emvpe3VhlQhgiYSZg33rcdTirrYcNi+6brkZhCG4?=
 =?iso-8859-1?Q?wKbumXiZdE30++upLiodnnJSiDNefTXe7Sz2eGEdA9f8PGrJF1ZKQQJEKc?=
 =?iso-8859-1?Q?Va1kN/eVreksvJTtA0NREu1mBPWKIWF85iqNTsNKfaQqOekODGDXsUmGbp?=
 =?iso-8859-1?Q?F04X2kri/YKHebTXxABhTHv5d3iciqzxjFdLJb6mEjVOZmzo3vLdYErsA1?=
 =?iso-8859-1?Q?+we5Fce8YEqhj43xK6bv3F/VHs2i890cOpqsjOkLjXOJZCEiqBiU2ifu57?=
 =?iso-8859-1?Q?bQZl6LFF7GQnqVKS+fFVH3VtHhbd+/DfIFl5p89pSoXbo6/NfKI6zKoSU8?=
 =?iso-8859-1?Q?IYlkfeb1Gmcz5oAy69CQpFPFNOfm6fi/YB9RttGF982lvYgSPUarWbp6eO?=
 =?iso-8859-1?Q?AUGEU4ImNnE6AYJ3ldRAe9fZIqXg2eO2NemifSBRB/jJ4XiUDKW00UCOTW?=
 =?iso-8859-1?Q?y3neEHa9QqYm9CenYjsJb9J1mJe3OXBFYWtIfBar3h27uBkDnnhMmTb9aq?=
 =?iso-8859-1?Q?0Ycfxro4ECXAgI4BQDpSRPW4roWtNsEEGxa9CqC7v02xFRiivVvHkLxr4u?=
 =?iso-8859-1?Q?5bkjZqTWGU7P6/f9AYjaWfjRgAPRQCdq4FDRq+gUWTr/R4XemItC35BvzH?=
 =?iso-8859-1?Q?5BiLIaR2f5oWP5YYuAgBZIc8MPh9C3UqeYugqtACYeJlqa34+TUe310My3?=
 =?iso-8859-1?Q?xqgcMa3sRTPAhrty4dlrV4tMeRNWMjQBBCokD9zD0EBzpp3Myj1AclpKmB?=
 =?iso-8859-1?Q?3qxp5UGo3GiuKRKBNVMKP0frnHqWHACm9NIEt5jXs0XegxdDhGLRYaReS6?=
 =?iso-8859-1?Q?HoEEz6cACAUINriUbAo98iIhU/kYpPahomDVMgrM2ceRT01exrsVoS60BE?=
 =?iso-8859-1?Q?6xb6gcbY4A5/pE0YVs0OrhDuJhntr7OrQpsUae6I3iYTZh7TO1G4PC4b3P?=
 =?iso-8859-1?Q?QXVxd/n8cWGy+ojX9c89xeI80WY+MFM5Wx6t89fHjxPaed5PxnaPp5Aokp?=
 =?iso-8859-1?Q?zfboDp5I9TPLhojWSiu3SyzzIYonUVsJ2mN6+q2ty4hDB9xE69iLt46Dfd?=
 =?iso-8859-1?Q?+nj5uaY4WBQG9W26hUNx095UVTtz6O0kgS4duGSCai4KD7qyjMHfeI8fbS?=
 =?iso-8859-1?Q?W6gEGVQ0N8LSYB5SW12HVbeRvr/IzwFdEWhiJD2kk+Ux8lWoPzZTQ46UIl?=
 =?iso-8859-1?Q?glTqbY+jn2A76/lQ0RxQm9eQtBdkH0wsJO554E+tp61E0L3Q/SjSCOm9yZ?=
 =?iso-8859-1?Q?oQx2k4C6aZNtzTbc8khg4QsZVSRUzba0kI8tWj6jazDkkOzV+Z+H9SKXKO?=
 =?iso-8859-1?Q?T222IT+A7p6up2ZTr3ahXE6uCvmJMmLJPXBRgFC1i8f0cu+KmPBD0DI6vs?=
 =?iso-8859-1?Q?fPbQ7NM8ZR9fwGQRuYL2knTxmqSw5pSUgT6zj5NehFgKYP0muZtYY9XqIm?=
 =?iso-8859-1?Q?91GdtusCXyJiSNGwarcn3xEx9WXBCaxYRfNDnjsJsImSGo71TGwTUPVHc6?=
 =?iso-8859-1?Q?SkY527S/MEuK3h52gKmW8v4LCYdGVmlHMsU/hyfztJWqZOIxTm/L9kEjpm?=
 =?iso-8859-1?Q?H5PV+1fmoolMMadD8tBMo4BpH9+tCHL0onUruenRcbpJYotxctZuIgQ7X3?=
 =?iso-8859-1?Q?ZqXW41zBk28pppcYJ5DCnXptD0VlXRgQLORjAyo0UGR3xrymNYyeOlv2LB?=
 =?iso-8859-1?Q?E2flRAZiZZ0+XuXlQwqfQ/6696uTI1YG6G4YlsUt4xjh56iQ7ixrBW84iv?=
 =?iso-8859-1?Q?804p9ywIPJTFlOkaiYX8Rnplsm9fWMk1Yl2iK9gwJ+lO1qM3yiY25nyKxY?=
 =?iso-8859-1?Q?0YO9l8bIjg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: generationdesign.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5444.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327d90a9-54d9-404e-4665-08da31aaf144
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:59:08.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 398b5a73-8271-4d30-a0a5-3af16b1d91fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcuFkK7GzkvanPDc/6e0leS/WNlQvdka1mfw2TX97gAaloE4/QPC4TfKxFJbmMTjfjZHb4iruuNlNrqLTUgyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6297
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sir or Madam,
I have a question about "gitattributes text".

I find the sentence "When the file has been committed with CRLF, no convers=
ion is done" somewhat confusing in the context descibed above.
How is this possible when "text=3Dauto" is active to commit/checkin CRLF?

Set to string value "auto"
When=A0text=A0is set to "auto", the path is marked for automatic end-of-lin=
e conversion. If Git decides that the content is text, its line endings are=
 converted to LF on checkin.=20
"When the file has been committed with CRLF, no conversion is done."


With kind regards
Christoph Hebrock
