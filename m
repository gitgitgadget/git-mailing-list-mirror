Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4C1220248
	for <e@80x24.org>; Sat,  9 Mar 2019 10:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfCIKTK (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 05:19:10 -0500
Received: from au-smtp-delivery-112.mimecast.com ([180.189.28.112]:57547 "EHLO
        au-smtp-delivery-112.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfCIKTK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Mar 2019 05:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=griffithuni.edu.au; s=mimecast20181013; t=1552126746; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references; bh=zEWajDDUX5fotsHgeaaBfsbnBUE7tGEbJfTzniEIiu8=; b=AZcRhFc+JtUEvG56a5IVwv41GF3JgmbH+UM+5D3hXbM5wO6Ui1Rx0O7HlaWgLN2ySWsm7fCWWVw8Y/RSwPv3+cXrQYyjxOf1PEMIihohcZYUCUXd3dcmM97i2mLPHBBQRi5BkRhWKBU0wadXdQh3Q0cGCeZqzG68IUHLOIpD6ZQ=
Received: from AUS01-ME1-obe.outbound.protection.outlook.com
 (mail-me1aus01lp2058.outbound.protection.outlook.com [104.47.116.58])
 (Using TLS) by relay.mimecast.com with ESMTP id
 au-mta-19-39KK2jbWN0eicnIM4-BSuw-1; Sat, 09 Mar 2019 21:19:05 +1100
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com (10.169.178.15) by
 SYXPR01MB1039.ausprd01.prod.outlook.com (10.169.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19; Sat, 9 Mar 2019 10:19:03 +0000
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67]) by SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67%5]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 10:19:03 +0000
From:   Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git MUST notify user when files will be deleted or overwritten by
 command
Thread-Topic: git MUST notify user when files will be deleted or overwritten
 by command
Thread-Index: AQHU1mGFLEB8MsC0EUaBLXkd5CBm8w==
Date:   Sat, 9 Mar 2019 10:19:03 +0000
Message-ID: <SYXPR01MB09577F5C4555C9068B606E11DD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [1.132.105.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05623762-e234-4beb-7b9e-08d6a478a7d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SYXPR01MB1039;
x-ms-traffictypediagnostic: SYXPR01MB1039:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SYXPR01MB1039;23:owvKWkHpqhkNKF4I/eq+CBArzETSyV9C2ZgvQ9tOg?=
 =?us-ascii?Q?dE/1eal1gjTnxSTsDhN0qTG9YJVntrOkLNTVZTe/WtG7W7R9tcjbyPrwyScR?=
 =?us-ascii?Q?vBpQrM3AlBX82UFs9V4jXtl5vJdSY9Nswn9dVRWkz9Dk8+sL1geg+ZI3DD7M?=
 =?us-ascii?Q?x1QP7QiRUm1IBYUBoAz7vZYbQOD6IhkU2Jnv2AwH82Jh82pjHsN/hWOcvZfQ?=
 =?us-ascii?Q?liAyk9dYWzPXeQWwKZfJM37yYkEGXaV+2CWS4pbQI2DPZ+BOUaLccBA5WgOH?=
 =?us-ascii?Q?icUJGnjG3NsZ9DFlhOwmgBDIR2Mf/F4lRh/ZiiFgHW7rEoOGLBWc0rMCW5lW?=
 =?us-ascii?Q?R9qgkkOCr0RgHIGFiT8NCmrcnQN5fwIL10Yc+woJQ/x9nQHHt2bR7GrIxQOr?=
 =?us-ascii?Q?Qw84WWsyQ9A0apl6RRZEepH07jrl6d4kR+iafDMGIa95vYrCWVcsR1h7LdjW?=
 =?us-ascii?Q?1ZntSPHC2XNU/k6UoBxmg7ajW9h8HU9ZCtGbtyXgg6HqL/9514K+PNQw4Hlg?=
 =?us-ascii?Q?EsMmCOgai2mT3GKZZm4YVgiz0UuVR8C9wmZAQbM7u8WHP+fNB22426kvBkRK?=
 =?us-ascii?Q?mdSNFoYeU5XIYx2nuxr9o2Ra/fTdpHUhEkz0vZiA8Qi4n+7GptZoIr1yI2/p?=
 =?us-ascii?Q?ZWqivtj/geFEzMXyb2mt9KD8hKwRfvSMNkpyB3HJoRHmM8qFJAejn8tJHSZf?=
 =?us-ascii?Q?YrqqHzDG3EACc4rHRj97h13tQydxJVY34aWljMsikDSZnYwlKoUIlAqNmM+I?=
 =?us-ascii?Q?MPyd+1hPnIpBrWkL5i+EN/1jL2xKlgYKOO/XPmZs6huoD9ejb1XuJQ3Ds3jA?=
 =?us-ascii?Q?NDmldnDD5xMXld78ja2VUtOuEFL8gwhBkhtSzLq4rGbD4OeNfmqSxTRazyq0?=
 =?us-ascii?Q?A9aDVFZLy66BWpIx8w4u8kELq5y7Tz9tuMCJCjNDXRTwe443xH6DzNXtT/aF?=
 =?us-ascii?Q?Ftqs4mMDEIxnQdF7pyGdrbUHzUciBFTw1cWsAqR3xUa+ZgK0O77rajUACY2A?=
 =?us-ascii?Q?DCK+SIbXMtfrf8vjapPlPrU/QtQrrOCbC9RtEgOgDEEScsR7v1njVINC3mio?=
 =?us-ascii?Q?Tcs4GYrICNQbFeVT5fyf3IdJqFGHBxmeM5WexQyS+8FCLioITiEu6rmWJ3+p?=
 =?us-ascii?Q?9GLOcBQnhZ0/zBRfJWywzLlp+X7PkeGF88mQisswDRCTA6EB8s6riEtVPoni?=
 =?us-ascii?Q?O0EQLJQN2GJ/ee0XDAKL6u8nsOIz5i/JFWoJLghVRFxUpZRoBSpF91Cqy+Qq?=
 =?us-ascii?Q?JFDL9AI7gSh7YjxSUqHbK5Ltv336ravdPmfRMxV/oAwz6iBNX4GYxMlzhHZy?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <SYXPR01MB1039FC6B72FA6C34AD561568DD4E0@SYXPR01MB1039.ausprd01.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(189003)(199004)(14444005)(561944003)(2501003)(3846002)(88552002)(33656002)(256004)(81166006)(8676002)(81156014)(1730700003)(2906002)(7696005)(6116002)(99286004)(102836004)(26005)(186003)(5640700003)(786003)(9686003)(55016002)(6506007)(53936002)(6436002)(97736004)(8936002)(74482002)(316002)(476003)(478600001)(44832011)(86362001)(486006)(71200400001)(66066001)(71190400001)(25786009)(68736007)(106356001)(14454004)(52536013)(105586002)(5660300002)(74316002)(305945005)(6916009)(2351001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB1039;H:SYXPR01MB0957.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UB5Ji1OMJmCRC6hX7Vn3N6Iem/Tgc656vtb6W7gfiVVLZVnbZ4yZWHLJt2v9r+fJVS/d5/Twhy0zThoslSFBJuLIqA3GRKmyv/awvunaS83NXNXVA6+8Uya+2PjO7Ym9Hfyp0CzpPaDzt7bLbDv6riVdHgWub8CFtO+iA3QunqcPl46/zwziM3zIi9lrgeCaHyNv0KUHTyqbAQ1g42hGYf51KGMsD9UNS2GlVvgtyTzUPdWEPruJJySQUF6kaWSnXD0FnqX+su61h/YZ5FC5rquCqyene+QdHL6ZL+ZACpMBz1vNyqTIQ+XVHphxQXyeT1H8lWu0a8Zvs8Va+YNz6+ziU+KIhzSitr7XzjNTgC+HnzZk60jjSqVhVTLTKCZaLV1eW3df8KeXPedLLqpoa1T8IvFVEvUM7FpY4kWYfaw=
MIME-Version: 1.0
X-OriginatorOrg: griffithuni.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 05623762-e234-4beb-7b9e-08d6a478a7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 10:19:03.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a7cc8ab-a4dc-4f9b-bf60-66714049ad62
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1039
X-MC-Unique: 39KK2jbWN0eicnIM4-BSuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=0AAs a relatively novice user of git, there have been far too many t=
imes=0Athat I have lost data, sometimes quite a lot.  So this proposal is a=
bout=0Acatering for the less experienced users and averting fits of anger a=
nd=0Afrustration.  The only reason my computer still works is because my=0A=
sub-conscious mind stops me from smashing it or throwing it against a=0Awal=
l.  It seems my sub-conscious mind has a pragmatic view of the world=0Aand =
understands that whilst I may receive instantaneous satisfaction at=0Athe t=
ime, in the long term, the pain will be far worse, and thus=0Aprevents me f=
rom doing something rash.=0A=0A=0ABelow is the detail of my proposal:=0A=0A=
Whenever a command is issued in git that will cause git to overwrite or=0Ad=
elete *ANY* files whose current state isn't already recorded in the=0Arepos=
itory, git should prompt the user to confirm the operation. This=0Aincludes=
 untracked files as well as files that are in the 'not staged'=0Aand 'stage=
d' lists.=0A=0ATo make the consequences of the command transparent, the con=
firmation=0Ashould include a list of files that will be affected (perhaps i=
n a=0Asimilar way to how git status works).  The scope of the files listed=
=0Amust match the scope of the command to be executed.  No hidden changes,=
=0Ano side-effects.=0A=0ASaying no to the confirmation should abort the com=
mand.=0A=0AIt may be useful to allow confirmation of individual files, but =
as a=0Anovice user, I can't argue this point objectively, nor reason about =
its=0Aimplications and complexity.=0A=0AThis feature should be enabled by d=
efault whenever a clone or init=0Aoperation are performed.=0A=0AThe user sh=
ould be able to progressively reduce the range of commands=0Aand amount of =
confirmation interactions that take place.  The=0Aconfiguration technique c=
ould follow the already established procedure=0Afor other configurable data=
 in git.  So this could be done globally for=0Athe user, or locally within =
each repository.=0A=0A=0AAs a novice user, there may be further useful exte=
nsions of this idea,=0Aabout which I'm unable to reason.  So I welcome furt=
her elaboration of=0Athe idea discussed above.=0A=0A=0ABest regards,=0ADimi=
tri.=0A=0A=0A=0A

