Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB0C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 19:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356538AbiDTTsW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 Apr 2022 15:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiDTTsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 15:48:21 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-oln040092068049.outbound.protection.outlook.com [40.92.68.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C421C901
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 12:45:34 -0700 (PDT)
Received: from AS1P190MB1750.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::21)
 by PA4P190MB1264.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 19:45:32 +0000
Received: from AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
 ([fe80::196:7c98:c780:69af]) by AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
 ([fe80::196:7c98:c780:69af%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 19:45:32 +0000
From:   Daniel Habenicht <daniel-habenicht@outlook.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug Report
Thread-Topic: Bug Report
Thread-Index: AQHYVNg8CVcF5Kz/l02dcun2ZjqvYQ==
Date:   Wed, 20 Apr 2022 19:45:32 +0000
Message-ID: <f1647260b37d492d96ac92f8ef30a087AS1P190MB1750B08CC923A45E2C959250ECF59@AS1P190MB1750.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
msip_labels: 
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIsle24nROWzZ3573Mx3PU3hwFDc6MTesgkQOc+Oy4bKLm5ut7qEmQ1LCLOBXpM7bd1otNeYmapXwDjBhrHXmCY+4pHqlsiPWQqrx7UONZQnGbJIEIrEjvQLn5xDvETK66IQBdaOLpVGXhGeod3oaDTL9+2FcuU/+pfGJIVJ4NT6Z4zEH+quN82hRcI4ggKU02rAQHIUURRSEWPmxN/omNfP3MykpVRbf4qMBaQnjRI14hBiKtjRQ44mQVteDOIyv08BV0iGS8klrQAfS3ISY1alLdhRpy/WZZ8QvQbOPpaTHdhkwO1rLAObxtLqBXSqEU/Tbtkuz1ws/AQqqE9NlQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pku+pS5eF/JkYjQ9vi5Auq3Sh8wznQqUKcdcKZTAZlA=;
 b=mULrPKRYGAD7Co8+Yr4uTKP5p6NkevD0fH4p9P8J4JqFe5MOQkvvINpFTmljCW9jCq9nJxDjZZ1hcZNi8ThPeiGjxnhiStXGRaUqYDUrcs3kb/PJMYL6v1v3cyQVENUPrgRs4vfaDbTUZE1WCWZikEHpiiUEI7IPjlTKC7sRvG8yvLKviggpkoPqxKjQGozUyIo5g05ZO9eosf9uiYhJ5rRqaQpaW5ypw9lBrzvMrZXLRuV1vs7hZyQB/g4O9yQWrLiq0ZMPVHN3N/PGAB16akyUFUAoP4B5yMBPyOFL3QnvApcrPuOfkYvBOvnINZlCiby60kKmpSdP7KFjsiJDYw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dbavH2TWemJf3dzgIt10yLgSewF7/6tUNvZipgQLIs8=]
x-ms-office365-filtering-correlation-id: 2656fd15-3330-4cea-3c68-08da230654a6
x-ms-traffictypediagnostic: DU0P190MB1954:EE_|AS1P190MB1750:EE_|PA4P190MB1264:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jPJnTZafktc3syd/iUPbj99jTEBJpNbyFTbNIfF3xbSnl6uxZ8cyySDdsH4C+/ax4dHonkFV9qvSOKFQVtLc03udCWHb4o7WIcM2o4CtIhYYsPs/je1hakggfqLFodaY9RIk7LRyoxOIFJvGWMrcs32dK/AXWd4SNmXhtrfYsKGC9Gpv1TF/gWx/qOw8eTwP7JOig/Qwa5YuSIGKlcpzkhcdHMEahkhbmWYbpCgHFA8B2UDOB8HjYE2peMPXmpscHaJbq/TdKNvR/L7Opu1bw8mDDxdL2xKvjq4SB1LDQR8smHBsLZ7kBDgh3WINAdY0uM7J0fDhm9/u2zx1hxwZgUIKtxT/4qIsf5X86B2/yWCw+uPrrb3f+TftXKPylgk48DxZp3lGjWsHVTJG6V8xB7IycIfmbmmHUffARjrLo10CUhHQzSCZ8pRcBuVOs21xc/9cWUoVbtkkcGSECOU22k9CaCavSkuzE/bx/M8qzLpYXN4Xal1CQV5n3mkhignztjOKpx8hA0QjPcesqkA7WgzxbqLmwQPA3QtKh5dV9akj6unIX6tWOZe/GoyJBKkf9rlWpra2OQhHZxCaepYNE2Wlbc2eXel2+kl7avexCNVbu678yUib7ZFS1CnYIsO
x-ms-exchange-crosstenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
x-ms-exchange-crosstenant-network-message-id: ca4b5697-6b69-4656-ec8a-08da22f03449
x-ms-exchange-crosstenant-originalarrivaltime: 20 Apr 2022 17:07:09.0789 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
x-ms-exchange-transport-crosstenantheadersstamped: DU0P190MB1954
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
x-ms-office365-filtering-correlation-id-prvs: ca4b5697-6b69-4656-ec8a-08da22f03449
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4vESfnlUrre9GeA35SxUqa10uFROurLTkhtUOWS3IV1GbhX1LC0FwQWTcT?=
 =?iso-8859-1?Q?yjfaVWoQt/TZxlb6fhxo66vVkuN+vqNpmfipW7OIxSXgZNss0x3RC0bQbV?=
 =?iso-8859-1?Q?UccskxF4xXH7lwPNrKbKok5pvRtGj260vlm7knJY4DQGvk5SJoXb0dIw0I?=
 =?iso-8859-1?Q?ZESQfnt6UbjegpGIBNDXVWudKuwGD4xLzbsBd2E94tCBdzZF3NWVf40YXX?=
 =?iso-8859-1?Q?74yAT7+UyyOfTHy2QG196u0X0dCb7lxn8MCwfyiz8zqv53ACmIpuTNF0Lc?=
 =?iso-8859-1?Q?Ak4dZy3yRpiFFVC79f0G3S0NjlCOSex8Ce4oFmTOki/3pDsFLi2Gv9IMRk?=
 =?iso-8859-1?Q?dmI2glL2egAHdBYTllSfUOMXtmPEPnWFwC0hyqdKMQUWIPJli1T3PesNeR?=
 =?iso-8859-1?Q?rQmjm4ncpSeVRsUXtbUsffFn0Y5gwce7PvLSRzyJsAE/nECPijkoTMnv0R?=
 =?iso-8859-1?Q?xcSA/gOzbD6kBSmK8PKLocAmDpKDawrpdd+B8pNUxiSHOVhXiO/rwcoHXs?=
 =?iso-8859-1?Q?uph2OcSsIYv8H7hQ5Z/W+rYGQf/jD67qdtdDL8IWwIWQfbLk0TiSm0yhXC?=
 =?iso-8859-1?Q?rzmy+dwU8s9WnaGONfdi385EgYMqEHYGyfBPmnfdDEgjpmMXqNEtKJKsbi?=
 =?iso-8859-1?Q?wLvff1d7aKG36yv93Jn/hyD58EDHCguRlL2Wh4m87iYaz5kSemxa2V7MsW?=
 =?iso-8859-1?Q?u/1lRH96nJ3lf1je94LV33mQ58EecwtE9SiOBQ7+24D9hS1mmKeSSuy79Z?=
 =?iso-8859-1?Q?d4YKgMxtyMAHxtkEqMr56rNn4BjxrNQHGxtSOtvigsUwt17J2CnnLFaq68?=
 =?iso-8859-1?Q?oS+gITd+H2VzJ4v1vjkCCvdsOqiHjGnAwxwVepXNuBxQkXqdGKfSo55Z80?=
 =?iso-8859-1?Q?QkTXEglyXNDE4f+o/KJlK0hNGjZc4tKGC2sostAkKKsiDTBa3Uvv8K2dIo?=
 =?iso-8859-1?Q?AoB74XUiEKWXgY5grus0Et7WIbm+PEUEJsKBv0b0h9Jt+f9WfiAh7jD4H3?=
 =?iso-8859-1?Q?98AsYe0NbNbpITP01vOb9mJA9U7sZJz5nCo4raG4MzdAT/Lu/8V9CjHxdS?=
 =?iso-8859-1?Q?TBfrz6sQgSqhe3C/A9HI0p+Zj/i+y1c+RL73Qf/C1aXxQVaTmgvK/YVOYQ?=
 =?iso-8859-1?Q?pA5ktiJZSqb7PVHs0i0sq2o+8STIhHNBeDzl6+dfdbl7mXrpd7Ze0g32kA?=
 =?iso-8859-1?Q?ajAaErm4brjjLKJSw+tfT+GlsU9OefAkUqTN4urnPZzeKLhwTzh5pjggxV?=
 =?iso-8859-1?Q?mxD4PWsrCpMqoSjnxLJfcqsmAz0H1vAdXhJzw15b4VxII8WwKorM92BNez?=
 =?iso-8859-1?Q?Ls3JpFeV8J7xvmfBeJoc3WNLrwdkUTFrrwF/l8MFIGtlw9Dt+OX5YqFJlO?=
 =?iso-8859-1?Q?rWNbWqovCRd/lMUiK4IxE/C/K9qjZ5Df29fj0n20A0wSajIjNnH/Zi2y4A?=
 =?iso-8859-1?Q?xbWRtClhLZsDF8nDjgDS3Sqk6j2EUTDmpMGRKNQOeWjdfvTT9MYIhkd70a?=
 =?iso-8859-1?Q?MqEsAb2XiHPoh1PIajz1To?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D80557DBC110F04088207D5A3D351219@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-91991.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P190MB1750.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2656fd15-3330-4cea-3c68-08da230654a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 19:45:32.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1264
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I think I found a bug or at least some unexpected behavior. 
Please have a look at the following reproduction repo: 

https://github.com/DanielHabenicht/bug-reproduction.git-repo/blob/main/README.md



[System Info]
git version:
git version 2.33.1.windows.1
cpu: x86_64
built from commit: 05d80adb775077d673fab685009ede4a1003ed92
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19042 
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
None

Also reproduced on: 
[System Info] 
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-1074-azure #77~18.04.1-Ubuntu SMP Wed Mar 30 15:36:02 UTC 2022 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


Cheers,
Daniel
