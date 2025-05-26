Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE31F582A
	for <git@vger.kernel.org>; Mon, 26 May 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274709; cv=fail; b=OWYfv23zXwL+MFsNoSgMTheDVD2oFTlHGdvJm5i/7AuTnYTr1WCQ2I0u1dH0gKNAI6EhaziZh7JqiT3+mKOCXHtSSlpvnRtf4uVh31pYIwC04UgBB8qE2vfElF8RMxOqInzmEcNg2HVClMpZOVWJ1SO9Fua5oHh6kq5qg+Ayryo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274709; c=relaxed/simple;
	bh=huEMHekBXWe0LiJol6vrKF932BKw5v2JlqSqre4ur64=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=smbyaOoKT0l5ph6qFhAZSyOD17DTKtkcF6TL7jf3AlOfj1B1bQzjER9iPMncfjd2yMSRZZUTJ+tOaye2kZ5dIEW1UkN/5edJqBHZQoIuUpH5G9fmDR421g+nVKhz8wzTTgxJ9jTzXsL4ND5xSA3sudCiNl3bd5hoLMd/JQhzDxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ACqlvsqU; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ACqlvsqU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNgniZnw1O8NLD1XGmqBgOBAsxJBpL/KCieFkWDXoXpNByFvwXL2Vuk9V4WthFRTybLkyxz5CHZSaiYP2kgvn+7yto29UjUAkpD13/aunC7H38d+mnB0Sz9nZBqmNTa4lgZ+xbZpHr0Pji/GN7mQEQDbVgBVZSDemC6ucBHlvcZtDGJgaOKZ/Tqaw85M0h/vG6FqYE4qWX3I6R0/sRn4yuQBOFkGg7Q6YChgE1yvS+QCJBbsoURDt8VctSwf/lsqtNZWy7o5fNk4YA50s6vFy5JCkNb43KalCnQIeWKZLrsdXl0ofkUwJWn9t2SKm6PXkUVl5jka2x7ApgOVzeNqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5fShwbggR6UWYUzvrEwSDMGbsdeeX1CKk5CaxPkjOA=;
 b=EHp/6BSW6zaaWVKtAaBA5VCrG9EWMrB6ldzyyXAbSwpLhyuB5dl5o+NFlC2S7W5WnB04wcgEc2VjzAexCSLkyGwDOppAXPu477O3/Yg9Ij2y2vahlY7XKm0D+sc/pwyKrj8uIhjUXAvGB501OIyj5vPj7rGmL/NkCIudEYjBhcgW7+8sjS37Ej6ApgrQd7LZZ/IUxnrsRw0DgcaxC0TwuE5qClog0sbzotT78SklOh/Pws181czDWFKqrCwdwyLYAIf9RZ0s7auC5kICIVz1VA08AxPogWow24P3mB5fPcjPN8LwmtiMaZFg7JbtCBtmVXMxErTTwzcEN+roct9Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5fShwbggR6UWYUzvrEwSDMGbsdeeX1CKk5CaxPkjOA=;
 b=ACqlvsqUAr/6WLnUv4Pua+mlnODThKb+EoBkUxhmVrZcv1xl3vrcGIZ1oVbLr29WyyulspIyYVHcA7SiZ3xvlr90vm59MtMxDzf+9H0KmbKvHrxTm37TOaGKO5SZjHzsHFnjMnWKClMo1HvHggvu+Q3d+geTnaIDbCrFycnajmLodTrja5f2vlu5djO4AAYI2Gt6GqxIHRPz6byFhIyHM4jn/zYAlUsdpAczI/UwwHa1tvGPWSFZBk5qzHSUuz6DD+lywa91KAFNdlNPKSocbQzQzSyzp1B5jihpyWmTqgBBuqvuxEMLjO41C7jOgGPwCuD+oPCq8Ga/vEqocLrcEg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 15:51:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 15:51:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 0/2] send-email: fix threads breaking in case user edits
 emails and improvements to outlook ID fix.
Thread-Topic: [PATCH v4 0/2] send-email: fix threads breaking in case user
 edits emails and improvements to outlook ID fix.
Thread-Index: AQHbzlYTxtWHM/6THUucxl4iBeuG7A==
Date: Mon, 26 May 2025 15:51:41 +0000
Message-ID: <cover.1748274404.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8258:EE_
x-ms-office365-filtering-correlation-id: 1b48de80-34fd-4bc8-4b7a-08dd9c6d3586
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6gQ9Hzl90DR0bZvPgEBdB0r4cdXz9do/jx5FR5Ax73kB67YVYLXVcC7527DNmL8pNjDGdHTV7zshyyA5NHeyQ4Y2HGpV4sGqo0jGW69cqUHXpODSLhMyTK/A8fkflZudkOwA7kPg5WfSkpG3ezUnOPNwHJKlucTySb+VXnCgd9KqrbYr7Vw0I48gHjW0T4XWOd3kImdVlJ4Lf7xBv0Nf6AxTEBv9QSwVUR1hQskv0HH0zJ0Zd/P7UF9wuq2fU0FvDpG2ATcF1RvN1UocV4AVPWeF+X/x43VNox36lqYNtHYeI4yK00OWxeJ0pYjH6X7XskBY/G/QwJSRUMqmGMW971B+NIGEdQg9ps9oTxWIqlJ8rj+B2I664euUnCDENNKof2KzYwVi9oRb0nyrjv9vl0lwUIjgPQZjg3d26ihP5jibjYk3s/jMWiMhJHT8zhIqh+zn9y4p4+yA4Pite5IkC/x2AEjqsRxpM/FY4sUPPJjSjBmaaTQXCyyGeloqwptjnuTzoHFr4xbGhmId5n4JkhHJmjgUJgC0oIl9aSysNiioIW4NFhyzEwlqTovS3jxainaRb7NWcxYsKbLshOu+ZFuYMI78yTP++iHskg1cw+cjvNo1sd1qjCDnp1FGNqglyg0QlP4itheWQgAe+xQr9Os/AkkGf3P1dOeJyGw6BBrwgKiQoGi/1T335k4E7gCGPsO9mf4s3YHQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|38102599003|5062599005|12121999007|19110799006|7092599006|8060799009|41001999006|8062599006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?usVbtcJoc8QjiOXrF6xMjKlZgxotJIYhDZAXec23iuPSHCAcg/YaKzQa6m?=
 =?iso-8859-1?Q?ajFRvBK5NPUrmSm6vhvYnDSMQkeQU5QRAcOROj4nVJZVamCJwb0NL89iX6?=
 =?iso-8859-1?Q?6IR3JBLPmRrSL7TpSJ4pR4CCezc36i6S+Io6QjE9UIqDwEKS16gMZLZJMJ?=
 =?iso-8859-1?Q?yk7Msgfbq/uAOOE+leRptdOql2fwEYCOBZk7ucdVHMFEbiFeYVa4k50Xhf?=
 =?iso-8859-1?Q?J6HqdYiO7uFLKe7PRDrHVsrKkW5VtgwF+e/vYBMOiiYGYPpxh4IXq3x8hu?=
 =?iso-8859-1?Q?0QgqVO7GsQ/rzQYIwGz0RCTWrsY/IZpO45TN4QWJEwqjTooSDjV5j9po6b?=
 =?iso-8859-1?Q?NWzdoeIJbZk/eSvqtVPBvNDM+c1lhJ0Io54LByRv82/Zci6OAisSu2J3N/?=
 =?iso-8859-1?Q?mx15ehg62/kQ/9v4QuPOm0OopbqsRLUre7pTTv2TWSQEfgPgMtzwTN4ui1?=
 =?iso-8859-1?Q?FAOeYjQDWX6Hp6f+1V5KittTgI4nUFurMHcFzMk3gQeqWywQa+g6gdLwGg?=
 =?iso-8859-1?Q?OQjR9Uj89pdkz+gl5yDvTSnA2jHxVEHlzD7ua9+JcN+jlQ6A5jSONFGDLK?=
 =?iso-8859-1?Q?lwZw1t36sxf0Xes9q4wEbeJL8F+yyAIaEyVK/1BCEdzigtj0m6GUdN89Vj?=
 =?iso-8859-1?Q?dPIxdkjG0FK8duoz/ASrPqkfxVj8XloYr4eSEgpdo7RLj+NWdQzZ/Jfa+z?=
 =?iso-8859-1?Q?6GA8S3g+c2rHU2eFO57b+fLZAohNr7gtn4DjtDQRygsGfDWhbiVqWd45Ic?=
 =?iso-8859-1?Q?i7MTa9fxVxgR/18QbeHWaCVKQeVVGdlJBpyLytljuhMrHK/HRftaAgAuP/?=
 =?iso-8859-1?Q?rKxncCIr6j8KLg93Z8aCimibXmqZ+4dPiVRwGCrpN+IrBr20LOQ8leuRCz?=
 =?iso-8859-1?Q?ziNfWbOlvec/Sv83Mqcy0fB4FY5iUFF20/a0FP2qnKrHo1rmbAx9Rr6zEh?=
 =?iso-8859-1?Q?HGqwpNWPgDRC1z/68KcunLgbykgeCzWDaczcHbpiRKM91wKEevBhsDzuLz?=
 =?iso-8859-1?Q?GsEwnPhbKKOxUH//QNk7ofktkKRPMHjVqSYuCDEcjrZ+lXWVN9MXFvELEB?=
 =?iso-8859-1?Q?DdMmfSUBDMaqpr+Rxjw4lpdx1p0yxaLF6IuIG3EGPrJz8sPIHxm6hxH2bT?=
 =?iso-8859-1?Q?qKHFTl4/N2dmfpE33Nvk5WMyOFTX0Wdy13agSCjGSC/GR5bUKSyFZHMY8P?=
 =?iso-8859-1?Q?T6pa66dAGtNlBn2VZSg4nQeKsmhvCwBjUdz9C4TiNMkRxRGowpi1NF2Mbt?=
 =?iso-8859-1?Q?BUYrC/5juXmwRtKPkG+qW5a+J4zpCNWMXcr8lwqxE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Xb3yrO8GmB6rPZ4ZLJnAHYFoiPZ9H7/V1Ad/RWrw/A3YpIwxu2aoxuMaNs?=
 =?iso-8859-1?Q?Q1gcoB+l940nq8S248BUeMsGOSGwc2/0yugMQw5ZgRXNIR3QhXC94broFp?=
 =?iso-8859-1?Q?dJ60IAfNUY2biwUIyS0sgejThD9JLRn2pJjIN/dPpu7yqd2tAhKsIlg44l?=
 =?iso-8859-1?Q?mA+UK0VJDj1mlMDIyR68EqhAaqr3iVQadJ7JofmiSgoprNNQHlgvdr+9Tm?=
 =?iso-8859-1?Q?BGJ4xMoSCJeFS69amQerUDL9BO75dG72aynX3m/FLyoEn7esxYD/uuEEoy?=
 =?iso-8859-1?Q?2BPTrsgGlIrg5LW8uxFhhum4m6s3gDTZkn2tSsm9E2l2PjiSbj0Sg1DZFb?=
 =?iso-8859-1?Q?qrETEtCFMkXSD4SjH1yEOimFE0NQFzL7zbUyAPcU84ZNfMB4XfN2QL07qt?=
 =?iso-8859-1?Q?NtmB02na1E+H6RS/oPkfXneYu1AXqt2rsJ41ZCsl5WAFiu0WEBCgA2cstY?=
 =?iso-8859-1?Q?UEz6ZwrS+b3SC11gZL18Hz6VXGiHY7O3k191HHuYlQfeJQ16N9cxfTrDGq?=
 =?iso-8859-1?Q?c86fpC1/jIpRgwZzTQ6eu5ZNwxRbWMnhVfx5vrBFPM962DprtngXdxuqn4?=
 =?iso-8859-1?Q?CBrjVFBrvzc9kj/B4JGNc611E5sJgrnISACrAXbUxiDYp8rWPLgJ8F/Oih?=
 =?iso-8859-1?Q?qubvTIqp69UHAMQpNvwaK7DjZTZDRFx681HSylnlbJ2LzkW60ezKA1Z5gk?=
 =?iso-8859-1?Q?PWf3zqLLLfE6gJTizCeK6d4NJ0EY8UKeAJwH6S/E6Ri0zQHau14XDDk05k?=
 =?iso-8859-1?Q?Gm0cKNEHk8jVeocxH3f6WGL1Pfi64tt3s4zALwVEGXgS0/m5S0CeArpuYs?=
 =?iso-8859-1?Q?vkXCoOS/YhXsoxz1mZGoZynJpwqrkGHgBoCLRY/CecyPjvrUh5PPpAkh+J?=
 =?iso-8859-1?Q?v2o4PHkcxKl6xvFBQGZbf9ten9FfDcl8vCqCfr59+1cncakJrK1yAKxXuC?=
 =?iso-8859-1?Q?UUm5l300Jy52fTGGr5qylmB8MBzwV4cd+wsC6gO5lIT2GoYkEAUwkqNYS2?=
 =?iso-8859-1?Q?9yaN7q8nH6e8G/WSQ9P8MN2t6yNFPnGuelj7qVXxL0nfWFBwCIEBTtFuEE?=
 =?iso-8859-1?Q?lLpw4lYey11ezVn4RQt9sFMRtCYG1NnbImM8zD1KEB7y6lBLQzdQLc7znH?=
 =?iso-8859-1?Q?RwjrHmxigYomoWn7T6uv9TziKuuMZdv4akvsevl7uZWeJttTsVCKguP6Rw?=
 =?iso-8859-1?Q?LFR/KC8zxRH3PTsUxStf83EIOyEXUKLhn1jOyQoocvj9Rc6cq39f7mAAnz?=
 =?iso-8859-1?Q?tPyFjS392CDS5I30UZ3kcv0AlYk6l7o81u1r/IG0c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b48de80-34fd-4bc8-4b7a-08dd9c6d3586
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 15:51:41.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8258

Hi all,=0A=
=0A=
This patch series fixes two minor issues with git-send-email.=0A=
=0A=
The first patch fixes a bug that caused the message number to increase=0A=
when a user edits an email. As a result of this bug, threads would=0A=
break when a user edits an email.=0A=
=0A=
The second patch improves the logging of the new message ID assigned by=0A=
Outlook when a user edits an email.=0A=
=0A=
v2 - Change the bugfix logic used to fix the threading bug.=0A=
v3 - Add additional patch to improve the logging of the new=0A=
     message ID assigned by Outlook.=0A=
v4 - Completely rewrite the commit message of the first patch to=0A=
     explain the bug in detail and how it is fixed. Also, add=0A=
     example logs to explain the second patch.=0A=
=0A=
Aditya Garg (2):=0A=
  send-email: fix bug resulting in increased message number if a message=0A=
    is edited=0A=
  send-email: show the new message id assigned by outlook in the logs=0A=
=0A=
 git-send-email.perl | 16 +++++++++++++++-=0A=
 1 file changed, 15 insertions(+), 1 deletion(-)=0A=
=0A=
Range-diff:=0A=
1:  259e20261e ! 1:  63addf9d9b send-email: fix bug resulting in increased =
message number if a message is edited=0A=
    @@ Metadata=0A=
      ## Commit message ##=0A=
         send-email: fix bug resulting in increased message number if a mes=
sage is edited=0A=
     =0A=
    -    In case a message is edited before it is sent, its message number =
gets=0A=
    -    increased by 1, and so does its order in the message id. The cause=
 of=0A=
    -    this bug was that when a person attempts to edit the message, the =
whole=0A=
    -    sub process_file gets terminated, and the user is asked to edit th=
e message.=0A=
    -    After necessary edits are done, the whole sub process_file is exec=
uted again.=0A=
    -    The way sub process_file is designed, every time is runs, it incre=
ases the=0A=
    -    $message_num variable by 1. The reason for this was that the funct=
ion ran=0A=
    -    again everytime a next message was sent in a thread, and thus we n=
eed to=0A=
    -    increase the message number for that message. In case a user edits=
 the message,=0A=
    -    there is no check for the same and the new message gets treated as=
 a subsequent=0A=
    -    message of a thread, therefore increasing its message number by on=
e. This=0A=
    -    breaks the shallow thread logic which relies on $message_num being=
 1 for the=0A=
    -    first message, and it gets changed in case the user edits the firs=
t message.=0A=
    -=0A=
    -    So, upon scanning the whole code, there are two significant variab=
les at play=0A=
    -    here. First is $message_num, responsible for the message number an=
d second=0A=
    -    is $message_id_serial, responsible for showing the message number =
in the=0A=
    -    Message-ID header. So, whenever we edit a message, lets just decre=
ase them=0A=
    -    by 1, so that when the whole process to compose and send the messa=
ge starts,=0A=
    -    these variables increase by 1 again, thus get set to the original =
values for=0A=
    -    that message.=0A=
    -=0A=
    -    We also are doing the same thing in case the user chooses to not s=
end a message=0A=
    -    out of many messages in a thread. By doing so, we will simply decr=
ease these=0A=
    -    variables by 1 for further messages, thus ensuring the whole threa=
d doesn't=0A=
    -    break.=0A=
    +    Whenever we send a thread of emails using send-email, a message nu=
mber=0A=
    +    is internally assigned to each email. This number is used to track=
 the=0A=
    +    order of the emails in the thread. Whenever a new message is proce=
ssed=0A=
    +    in a thread, the current script logic increases the message number=
 by=0A=
    +    one, which is intended.=0A=
    +=0A=
    +    But, if a message is edited and then resent, its message number ag=
ain=0A=
    +    gets increased. This is because the script uses the same logic to=
=0A=
    +    process the edited message, which is uses the send the next messag=
e.=0A=
    +=0A=
    +    This minor bug is usually harmless unless some special situations =
arise.=0A=
    +    One such situation is when the first message in a thread is edited=
=0A=
    +    and resent, and an `--in-reply-to` argument is also passed to send=
-email.=0A=
    +    In this case if the user has chosen shallow threading, the threadi=
ng=0A=
    +    does not work as expected, and all messaged become as replies to t=
he=0A=
    +    Message-ID specified in the `--in-reply-to` argument.=0A=
    +=0A=
    +    The reason for this bug is hidden in the code for threading itself=
.=0A=
    +=0A=
    +    if ($thread) {=0A=
    +            if ($message_was_sent &&=0A=
    +              ($chain_reply_to || !defined $in_reply_to || length($in_=
reply_to) =3D=3D 0 ||=0A=
    +              $message_num =3D=3D 1)) {=0A=
    +                    $in_reply_to =3D $message_id;=0A=
    +                    if (length $references > 0) {=0A=
    +                            $references .=3D "\n $message_id";=0A=
    +                    } else {=0A=
    +                            $references =3D "$message_id";=0A=
    +                    }=0A=
    +            }=0A=
    +    }=0A=
    +=0A=
    +    Here $message_num is the current message number, and $in_reply_to =
is=0A=
    +    the Message-ID of the message to which the current message is a re=
ply.=0A=
    +    In case `--in-reply-to` is specified, the `$in_reply_to` variable=
=0A=
    +    is set to the value of the `--in-reply-to` argument.=0A=
    +=0A=
    +    Whenever this whole set of conditions is true, the script sets the=
=0A=
    +    `$in_reply_to` variable to the current message's ID. This is done =
to=0A=
    +    ensure that the next message in the thread is a reply to this mess=
age.=0A=
    +=0A=
    +    In case we specify an `--in-reply-to` argument, and have shallow=
=0A=
    +    threading, the only condition that can make this true is=0A=
    +    `$message_num =3D=3D 1`, which is true for the first message in a =
thread.=0A=
    +    Thus the $in_reply_to variable gets set to the first message's ID.=
=0A=
    +    For subsequent messages, the `$message_num` variable is always=0A=
    +    greater than 1, and the whole set of conditions is false, and thus=
 the=0A=
    +    $in_reply_to variable remains as the first message's ID. This is w=
hat=0A=
    +    we expect in shallow threading. But, in case the user edits the fi=
rst=0A=
    +    message and resends it, the `$message_num` variable gets increased=
 by 1,=0A=
    +    and thus the condition `$message_num =3D=3D 1` becomes false. This=
 means=0A=
    +    that the `$in_reply_to` variable is not set to the first message's=
 ID,=0A=
    +    and thus the next message in the thread is not a reply to the firs=
t=0A=
    +    message, but to the `--in-reply-to` argument, effectively breaking=
=0A=
    +    the threading.=0A=
    +=0A=
    +    In case the user does not specify an `--in-reply-to` argument, the=
=0A=
    +    !defined $in_reply_to condition is true, and thus the `$in_reply_t=
o`=0A=
    +    variable is set to the first message's ID, and the threading works=
=0A=
    +    as expected, irrespective of what the message number is.=0A=
    +=0A=
    +    Just like $message_num, $message_id_serial variable also increases=
 by 1=0A=
    +    whenever a new message is sent. This variable displays the message=
=0A=
    +    number is the Message-ID of the email.=0A=
    +=0A=
    +    So, in order to fix this bug, we need to ensure that the $message_=
num=0A=
    +    variable is not increased by 1 when a message is edited and resent=
.=0A=
    +    We do this by decreasing the $message_num and $message_id_serial=
=0A=
    +    variable by 1 whenever the request to edit a message is received. =
This=0A=
    +    way, the next message in the thread will have the same message num=
ber as=0A=
    +    the edited message, and thus the threading will work as expected.=
=0A=
    +=0A=
    +    The same logic has also been applied in case the user drops a sing=
le=0A=
    +    message from the thread by choosing the "[n]o" option during=0A=
    +    confirmation. By doing this, the next message in the thread is ass=
igned=0A=
    +    the message number of the dropped message, and thus the threading=
=0A=
    +    works as expected.=0A=
     =0A=
         Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
     =0A=
2:  65619ac4d7 ! 2:  72b3cd1bfb send-email: show the new message id assigne=
d by outlook in the logs=0A=
    @@ Commit message=0A=
         send-email: show the new message id assigned by outlook in the log=
s=0A=
     =0A=
         Whenever an email is sent, send-email shows a log at last, which=
=0A=
    -    contains all the headers of the email that was send successfully.=
=0A=
    -    In case outlook changes the Message-ID, a log for the same is=0A=
    -    shown to the user, but that change is not reflected when the log=
=0A=
    -    containing all the headers is displayed.=0A=
    +    contains all the headers of the email that were received by the=0A=
    +    receipients.=0A=
    +=0A=
    +    In case outlook changes the Message-ID, a log for the same is show=
n to=0A=
    +    the user, but that change is not reflected when the log containing=
 all=0A=
    +    the headers is displayed. Here is an example of the log that is sh=
own=0A=
    +    when outlook changes the Message-ID:=0A=
    +=0A=
    +    Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E29=
8CB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>=0A=
    +    OK. Log says:=0A=
    +    Server: smtp.office365.com=0A=
    +    MAIL FROM:<gargaditya08@live.com>=0A=
    +    RCPT TO:<negahe7142@nomrista.com>=0A=
    +    From: Aditya Garg <gargaditya08@live.com>=0A=
    +    To: negahe7142@nomrista.com=0A=
    +    Subject: [PATCH] send-email: show the new message id assigned by o=
utlook in the logs=0A=
    +    Date: Mon, 26 May 2025 20:28:36 +0530=0A=
    +    Message-ID: <20250526145836.4825-1-gargaditya08@live.com>=0A=
    +    X-Mailer: git-send-email @GIT_VERSION@=0A=
    +    MIME-Version: 1.0=0A=
    +    Content-Transfer-Encoding: 8bit=0A=
    +=0A=
    +    Result: 250=0A=
     =0A=
         This patch fixes this by modifying the $header variable, which is=
=0A=
    -    responsible for showing the logs at the end. Also, the log which=
=0A=
    -    states that the Message-ID has been changed will now be shown only=
=0A=
    -    when smtp-debug is enabled, since the main log having all of the=
=0A=
    -    headers is anyways displaying the new Message-ID.=0A=
    +    responsible for showing the logs at the end. Also, the log which s=
tates=0A=
    +    that the Message-ID has been changed will now be shown only when=
=0A=
    +    smtp-debug is enabled, since the main log having all of the header=
s is=0A=
    +    anyways displaying the new Message-ID. It should look like this af=
ter=0A=
    +    this patch:=0A=
    +=0A=
    +    OK. Log says:=0A=
    +    Server: smtp.office365.com=0A=
    +    MAIL FROM:<gargaditya08@live.com>=0A=
    +    RCPT TO:<negahe7142@nomrista.com>=0A=
    +    From: Aditya Garg <gargaditya08@live.com>=0A=
    +    To: negahe7142@nomrista.com=0A=
    +    Subject: [PATCH] send-email: show the new message id assigned by o=
utlook in the logs=0A=
    +    Date: Mon, 26 May 2025 20:29:22 +0530=0A=
    +    Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.=
INDPRD01.PROD.OUTLOOK.COM>=0A=
    +    X-Mailer: git-send-email @GIT_VERSION@=0A=
    +    MIME-Version: 1.0=0A=
    +    Content-Transfer-Encoding: 8bit=0A=
    +=0A=
    +    Result: 250=0A=
     =0A=
         Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
     =0A=
-- =0A=
2.43.0=0A=
=0A=
