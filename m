Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A236C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 14:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiDZOI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbiDZOI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 10:08:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2130.outbound.protection.outlook.com [40.107.20.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039855F4A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=carlgerhardt.onmicrosoft.com; s=selector2-carlgerhardt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyN+DWA4S9abtwi1bAVEgKqIJmFZaAo2UgRFxEhckok=;
 b=R9OlB3TxTUOjB1lfjxnldgw+6MfX4o35fkohqnhkRmLQS4STzikCMqSSEY5h/F6i1qu1iTd3ujq09cMwNEdo4lV+wbOEKjgFfq8y2tMG+6p3wJLN3Fj1Z5VWZ0UAqIWJEZHrBxVfNOPKTkgCnXj7gYKfPKp+G9Xt30ANOtisuLc=
Received: from VI1PR05MB6495.eurprd05.prod.outlook.com (2603:10a6:803:f2::18)
 by AM9PR05MB7587.eurprd05.prod.outlook.com (2603:10a6:20b:2cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:05:15 +0000
Received: from VI1PR05MB6495.eurprd05.prod.outlook.com
 ([fe80::e41e:2498:60e6:6789]) by VI1PR05MB6495.eurprd05.prod.outlook.com
 ([fe80::e41e:2498:60e6:6789%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:05:14 +0000
From:   "Elektronik (C.Gerhardt GmbH & Co. KG)" <elektronik@gerhardt.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "CRM (C.Gerhardt GmbH & Co. KG)" <crm@gerhardt.de>
Subject: Error after update from 2.31.1 -> 2.36: Unable to negotiate with IP
 port X: no matching host key type found.
Thread-Topic: Error after update from 2.31.1 -> 2.36: Unable to negotiate with
 IP port X: no matching host key type found.
Thread-Index: AdhZZNr5llfjS8asSEWIrpXAwpcyhw==
Date:   Tue, 26 Apr 2022 14:05:14 +0000
Message-ID: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR05MB3302:EE_|VI1PR05MB6495:EE_|VI1PR05MB4672:EE_|VI1PR05MB6495:EE_|AM9PR05MB7587:EE_
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB6495.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(366004)(396003)(39830400003)(6916009)(2906002)(37630700001)(55016003)(66446008)(66476007)(122000001)(8676002)(9686003)(5660300002)(38100700002)(83380400001)(52536014)(38070700005)(15650500001)(86362001)(8936002)(6506007)(508600001)(66556008)(4326008)(64756008)(66574015)(107886003)(66946007)(186003)(76116006)(33656002)(966005)(316002)(71200400001)(26005)(7696005)(47845001);DIR:OUT;SFP:1102;
x-ms-exchange-crosstenant-originalarrivaltime: 26 Apr 2022 13:12:36.7147 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-network-message-id: 3d302085-6214-47f7-0ccc-08da27866efc
x-ms-exchange-transport-crosstenantheadersstamped: VI1PR05MB4672
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gerhardt.de;
x-ms-office365-filtering-correlation-id: 80718cd4-2ccb-420c-8201-08da278dc94f
x-microsoft-antispam-prvs: <AM9PR05MB758795433CFF91975C45C123CCFB9@AM9PR05MB7587.eurprd05.prod.outlook.com>
x-microsoft-antispam-message-info: oHoWaE/lhqLwXIeoN4fDexukChJraTmGLY8GKfntIOeogRPpgWJ1x6tdxkzByDr9utc8D4eijWOC+IZEbKj1e/KnF3yTNYPwnSqkpdxOTBo2f0p4v3bVwRj8pZTuoo2DU/AK+UyP7bHRyAaVlDDsOE0vcVjQDR2L3QtD2QKpfuY5VerCd1EOTj8XeBd5uIelCUzvm89jP+NByPnS4xpD9xiWrOCEi3su+eKiERhS1Y3AM2AFKIC8kWlbODesSfoJGbx7jRflAjjztacd98kCrvsKlrDhtkIkxZ73ewe0E2Kt5544sx/UaJ2W75O+0w8Qc7XJDV55fJS2J1u196oabObnMw/aP0oqM0N/A++5KlWc2R1VixY3fN7cA8LOcP5mMzEBbDr+fhI+6OIaIpIe7sELJIUuIusswmfMvKGGig2O3GwXP8Bg/splX6rHNOs9q43tLKbfGlPwsJwHbJNUQWF1BwhjkAyDVT49dFOnQEeuJZYvHvmxaOgEGeOnQpZUP77EAOHANy9KtkNDcffbm24KjA4gzUmLmIxo5LCWfcHgL0iOoh2JtcBh55EgpXTvlNfupWbEgbKFwzSardLOuC8v0brPRNAtIdBf4D55jdxttdYNpdrqCKjqfxSo1o6318kFbO3Ein6AhMnkIofhZeu/kBverNRROgC2GinLtOD9Y5MjfgNUkodAgN+lYyujpw9Pc2YoqIjW/Xo/wSBYrz9GUq4WahlDFaChj238OqDJ5AG6GbZjqPpeKZ91zCggZFlwLnhkUtSQQi08XeLRrxun0YdQqe3qw8YXqe9RRGQNRjKwdmeae7T6O/O5gLnJ
x-ms-exchange-crosstenant-id: 29fe33a3-8fb6-4fcd-983a-533675a91271
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: wrYQvN0FfBIVbaTWd5yDCC1WAI2ovZ+HGENj3ic3ExKaJosW427lzSRzdJWj2wfn1bc4gGfhR5QhY4HMsLWAVw==
x-ms-exchange-crosstenant-authsource: VI1PR05MB6495.eurprd05.prod.outlook.com
x-ms-exchange-crosstenant-authas: Internal
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcSuAx4EOhoDmHvn+hkjoHmv3OViRDqK0zXSVoa059npOIsLOyOUglSPySdJwu6YDCY1NUQYB4wBbA8ledr/5/Yk5ZVIbQ5juHjRqGcG1QpcHjkTqAPFpTyqrVmEY4VqKO125ZmzkHzytedyu8WNRqIcpCdLtV2IbFOL7QzWwECVV/GCWZIKVIE6eLmMSCSCxWUIwEOHh+Fy6fNP45ufSJ+RCIZUEVH/fi1sChwlfl1arTqu81ibLmTRnk56QyyWII3UBuwy14mulDLE/v3lffr5utoWbzQP0+6AbtpVtSuix7eNbeVMRRe1Lflkd8iAs6iNBbFui8uu9JnDA+imXA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vscCzsi0QiycaBZOy+95xyVr9+prDWyNzR9C73V9nrs=;
 b=hpdXNJYf0N9nrh49vX1URd5EOtSS3jtYGZUjPlW7qZzJJ7hb32fqfC6zP8JCvmn+C6dC3v4LsPm5rpdFzlpsvr+9Vcw9/Mhd5RtlTdM0YQuIPNt1cEJfifrhrTkcQbFRD+ITsWAjoDZ8ajY1Xkzp5wcFPzjL+xSaMqzt64hxr7TrVKiviylY6MKT9IXGnJU2sMGTi1/HBe+9lt1DegLR3RKvIXw1yGig2eb6KN5ynnoF/oPm+3JltDkDoG8eub3J5iroqeNKWAY+rBO/nsMCeC1LA68SXOtiZUR0KguSLn/DsdbFdCAimCiIrAR2t0Y5eqhQQnO/TH6w3mbsvhbMJw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gerhardt.de; dmarc=pass action=none header.from=gerhardt.de;
 dkim=pass header.d=gerhardt.de; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=carlgerhardt.onmicrosoft.com; s=selector2-carlgerhardt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vscCzsi0QiycaBZOy+95xyVr9+prDWyNzR9C73V9nrs=;
 b=mK7Hom8qv3vHv6dO1pG3qRgVp+t4MlLtekv4xPTAyb9j1Mu65j+UMJNUowumYaXGqxvohErofuXVb2o/wQLYgFEt8t6mOttoX9WXNBhosbetSm3dREXjRXweTB62KJSgqjBwnOLCWCAOny8rHePLGqFD5AH00I/Z3DtccGILVfc=
x-ms-exchange-senderadcheck: 1
x-ms-office365-filtering-correlation-id-prvs: 3d302085-6214-47f7-0ccc-08da27866efc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gw5efS3pU8B8zjdZAhe95eXbSwYHnsJnwJOQSA3dRfV0aihNKpE0oiTpOT?=
 =?iso-8859-1?Q?HhDwRBCYFl3SjdIWwb6FXNbIAnWNzKyhFInw8nDy3PaUeEyU0UMAzjylQR?=
 =?iso-8859-1?Q?8Nzuz8tj4vi2IRrs5r3uFCcjXFPi6zni4gjnC2DvNyHg7iFaFULtzu8bPJ?=
 =?iso-8859-1?Q?yKm+itnylIuBuXLq9cCZvQjY/iRL8q18E1UgIIvS6hvX8TYLRyfxymhzzj?=
 =?iso-8859-1?Q?LExyvbjSc8zJ3c7/1djEiDjj2r6UxjfYE4+v/crYpAaQrCdtgL3RjWphbE?=
 =?iso-8859-1?Q?Sy6NQGUmwG8HRA4VkM/eVU0X+Lo9+7Vf/TDLhXCakbKylpzxs8BB3+lQxt?=
 =?iso-8859-1?Q?iautVmlHfVzOas8CahNUyzbmaqYLpbyzEjcox6WkdeerFd4U4l2BUuDbhq?=
 =?iso-8859-1?Q?865LOpNWUIsB9tSZErStNvR6P0WDN3Qn1AHTL+7K+48VgCSKiJmyd+uph6?=
 =?iso-8859-1?Q?yDRW6LC2n4Ln/PcqHQ0aPIThuJWbS09OZRGVs2T6V451Da4IjQ7njQFfZ/?=
 =?iso-8859-1?Q?5wQ93Bm/QeAGJ6b6V/1UK+zI63BDAw8In4EA9H//zL6nMsPi63FjowIt0X?=
 =?iso-8859-1?Q?3brkVuCJjDkmTU9nZ7e9G82cSH2HCkjbyV1wKr4Ug9bIgwu1Mds1OtRfb/?=
 =?iso-8859-1?Q?+UJ2UKxzWL+Pw2vsd1CEDGOzS12BLEAZ9wMzUVrLIBTbV8Z8f9AQCrv2Ez?=
 =?iso-8859-1?Q?w2clPp6TBbOivb4rcDL3LLS0mklCQQsoeDUuu+upk5LgqOKaKccMWL/Bet?=
 =?iso-8859-1?Q?4++IFYYNZqhlky4hhhie56OjPGoeg5osqKobv9UDLjgYLAVlAGnEVlh/Qo?=
 =?iso-8859-1?Q?kWtJaTrDoold2kKN2cMGPQpAHSlc9G8m7R1P9GQ3gGZyuqpgNQP/35wj6s?=
 =?iso-8859-1?Q?iQJl12Y7XGQzECMqDdPDUZYQ8AkB/ryHxEu+KZvAShEn7tekYvLYX1yXlW?=
 =?iso-8859-1?Q?1/OtWv6ywvPP0bLBlkTJZ0f/rFKBBHJdyF+0Ru/7/iluaZodYJGw58+MiL?=
 =?iso-8859-1?Q?pJHZg+oFcn9LCUkJatMJfG/DDdPczHdMpSYNHQWF5t6gbFr9ekjyqh+2DU?=
 =?iso-8859-1?Q?c/eqap0iSRrOVc6dMK1TVf5YMTlrSq4ik6wFVx3iLOjuetc3VYw84nQXp4?=
 =?iso-8859-1?Q?a1xFizyDAXPadoB3uL2IV/452x7xR0NkHWJ7n3jvEq3Q+E+nnIDz2I6FNs?=
 =?iso-8859-1?Q?NpHt+h/m5/Ys31I9tEOslem3KH/SVzS1zY2n6rM4NUYteyxeB5VvWlL0uZ?=
 =?iso-8859-1?Q?VHvPSi8aEGrgA5YHVbrEJzpMY2yT6yCWbiCFPsVDPTu/HmAkjzz5A/YHJ/?=
 =?iso-8859-1?Q?ntsiOFOPwGZeo8GD8yebU5LjG/YXx8mchgURgmFUJYW6rEpk/eEjLQ/jIj?=
 =?iso-8859-1?Q?c0AIw5ofDCiLUXXULopuVFnlSwAap9/01rLAlXWYmm0ciJVDwoWrklcnTc?=
 =?iso-8859-1?Q?tH7FWg+nxASKyXdW2vmjVVOdpONSRlJZg/xU+rGwMkYwPPntpENom21Zsc?=
 =?iso-8859-1?Q?21a6ajeLTtLD4gAKo/YXmje6i7UMOPCjOlE9CpVbRg+rpDqPIFqOWdV0qX?=
 =?iso-8859-1?Q?7PAShZDDObKWbCu9qsMrBTbkoT0nclMYQxjPCXNVE/H3I7IsS4ip55ZD3O?=
 =?iso-8859-1?Q?/G8U3On/warS3l2hKWxQyKYDgMO2sRyiP9YFyLASMKPTn1KKkYChcJbFQ8?=
 =?iso-8859-1?Q?MeheJj6bUbckgzwA6+UBUVJDf8KjSW9hR6bmzm4S2eIKKG0+xesaWqXb0r?=
 =?iso-8859-1?Q?0fB46U3Oha2Hc3f+mUc5R5SrDDXxEYvZn9LexyWR9KJUifBaIPGKOXRQP9?=
 =?iso-8859-1?Q?6X55KQruFQ=3D=3D?=
x-ms-exchange-antispam-relay: 0
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1EC4595B554CC641AA4BA3E6C51EF45E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: gerhardt.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB6495.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80718cd4-2ccb-420c-8201-08da278dc94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 14:05:14.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 29fe33a3-8fb6-4fcd-983a-533675a91271
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gBF4hMGW9OSU6VD3GWxZR5rTiuXU0nuVmbf2Pozo0VnroulPvkzANIrtEkZ/JRBrFYPU05awBOLGQQgKcjbRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB7587
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey at all,=20
=A0
don't know if this is the right way to report a bug although I read so in h=
ttps://git-scm.com/community. Never used mailing lists before so I hope I a=
m doing well...=20
=A0
I found that after an update from git 2.31.1. to 2.36 the authentication to=
 our git server (running gitea 1.13.1) fails. We are getting the following =
error:=20
=A0
$ git clone ssh://git@192.168.101.69:4711/CG/DT_installer_script.git
Cloning into 'DT_installer_script'...
Unable to negotiate with 192.168.101.69 port 4711: no matching host key typ=
e found. Their offer: ssh-rsa
fatal: Could not read from remote repository.
=A0
Please make sure you have the correct access rights
and the repository exists.
=A0
The SSH keys were generated with Puttygen, converted to openSSH format and =
are stored in c:\users\USER\.ssh\
The keys have not been changed after the update.=20
=A0
With Version 2.31.1 it is working fine but after upgrading to 2.36 I get th=
e above error.=20
Am I doing something wrong or is this a buggy behaviour?=20
OS: Win 10
=A0
Best regards,=20
=A0

i.A.=A0Stefan Mayrhofer=20
C. Gerhardt GmbH & Co. KG=20
C=E4sariusstra=DFe 97=20
D-53639 K=F6nigswinter=20

Tel.: +49 2223 2999 513=20
Fax: +49 2223 2999 99=20
Mail: mailto:elektronik@gerhardt.deWeb: https://www.gerhardt.de
=A0=A0=20
---------------------------------------------------------------------------=
--------=20
Pers=F6nlich haftende Gesellschafter: Dr. Macke GmbH, K=F6nigswinter - Vert=
retungsberechtigte Gesch=E4ftsf=FChrer: Jan Macke, Tom Macke=20
Registergericht: Amtsgericht Siegburg - Registernummer: HRA4275 - WEEE: Reg=
.-Nr. DE 54940101=20

Aus Rechts- und Sicherheitsgruenden ist die in dieser E-Mail gegebene Infor=
mation nicht rechtsverbindlich. Eine rechtsverbindliche Bestaetigung reiche=
n wir Ihnen gerne auf Anforderung in schriftlicher Form nach.Beachten Sie b=
itte, dass jede Form der unautorisierten Nutzung, Veroeffentlichung, Vervie=
lfaeltigung oder Weitergabe des Inhalts dieser E-Mail nicht gestattet ist. =
Diese Nachricht ist ausschliesslich fuer den bezeichneten Adressaten oder d=
essen Vertreter bestimmt. Sollten Sie nicht der vorgesehene Adressat dieser=
 E-Mail oder dessen Vertreter sein, so bitten wir Sie, sich mit dem Absende=
r der E-Mail in Verbindung zu setzen.=20
For legal and security reasons the information provided in this e-mail is n=
ot legally binding. Upon request we would be pleased to provide you with a =
legally binding confirmation in written form. Any form of unauthorised use,=
 publication, reproduction, copying or disclosure of the content of this em=
ail is not permitted. This message is exclusively for the person addressed =
or their representative. If you are not the intended recipient of this mess=
age and its contents, please notify the sender immediately.=20
