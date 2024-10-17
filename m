Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC21D8E01
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169336; cv=fail; b=UZcJW4IdtyYgfSxU7a6Ep3eDVWTT63Evx594ARzXI37DCJapiPRLJYaqBLwBV6pO1SpnubYpoUV9Xna5FliQh33mEe8soUeQk/ivSL4TmCfeEg1b21TNt4jOEaetVv4kblsW/hETje5g9ysY9I2b4ctltkwV0yKN3OKMO9npxfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169336; c=relaxed/simple;
	bh=wNRYO+YXJScv4i7zcnrqTBovpbdDxy4aCS5g9av5clc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=glarhcJh3zdi9RDIESR1MhMLDEjGJQ4StieD6f1QNmyMQphJ6m1T2Sw5gFhJ+CE4nxGW1poLoWECdVV+e6yVwGmwZ5DkHDZD326Qwc1/SbV9xPYNncJ8C0ymSF2EzmGPDrxT0L0WQdlS80J0PVXRCVcvt+mEbr3o3WOoWtSzZVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=electrolux.com; spf=pass smtp.mailfrom=electrolux.com; dkim=pass (1024-bit key) header.d=electrolux.com header.i=@electrolux.com header.b=I/rktdVM; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=electrolux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrolux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=electrolux.com header.i=@electrolux.com header.b="I/rktdVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLz91Mm4J02320BgZdQdMFBp2mFYT+3lHyozh+pyv3qyFgLCeUyxsYiEC7EBtOo67VaNyUTdg5ZVA2/aDo+uul8njVK/1u1IJ8IqWyvyGb2MsPLzus7zMiBc4FgCYedsDfljhioXu7iRoQrULQir6aGZXCstl7tVUPUkpggHJs5+L746eYpK9UpDPi15Q3tNKX9+Nlk4PnoUwshB/Ul4puTTGLWVJEfKZ/BhetTvJNUU+tayTzbl9kob1M2lcCnvkrJ/FqK3ZxDktcucnEiE8XCLFoDasTRStuzEZw9Bur/7IiZDPnCUhcZxoUKebhUcNNVqUBwXj5g7MHn599t4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNRYO+YXJScv4i7zcnrqTBovpbdDxy4aCS5g9av5clc=;
 b=eoztA7iyZzjVGdMVMuZx081+EBcpdIVwc2IyTmpQL/kMpaD8oLFWnAdzvah6+BGrzaFWpA6XW4SAPWZVr7p0OmKn04o+jruyVcVyBPcgYCqIoXyyhT2EatPoPvgTeaJj4aVgBQmuc77jhrohle6OeXdks1MHIijfPSTBGOP3u5QsXtU7dcBjEQxIggBu7PKhUg1rEgx6a6IrCyS9sYy98z/MMJmbjFv+cwPquec/j9x1zIt1jSWmt1Q4dEx6E8H0Gx3rXsl+wEacwpm95IhT+hWauJ1U7EQl3t3UW60Y0sQ9nvShcW2j8w2MksB4zYGpHQblP0BFigcSNxbBXpTcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrolux.com; dmarc=pass action=none
 header.from=electrolux.com; dkim=pass header.d=electrolux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=electrolux.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNRYO+YXJScv4i7zcnrqTBovpbdDxy4aCS5g9av5clc=;
 b=I/rktdVMTseWYVPfsCZbY3H8l5C9loVXy76sSwYSQScOl73f31VJbHS+OralucEy/N+qvBIfICxyrxl2KxrC2f9PvNx8itQ7oe+SXK0fwa1hNW0/MUBhfOKZZqgwpp4YRUeAoybb3EfUFjOZiKaclg36pRhpeL1MsXq3j/f10Gs=
Received: from VE1PR06MB7070.eurprd06.prod.outlook.com (2603:10a6:800:1a1::7)
 by DBAPR06MB7015.eurprd06.prod.outlook.com (2603:10a6:10:1ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 12:48:49 +0000
Received: from VE1PR06MB7070.eurprd06.prod.outlook.com
 ([fe80::e921:fd86:a964:53a]) by VE1PR06MB7070.eurprd06.prod.outlook.com
 ([fe80::e921:fd86:a964:53a%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:48:49 +0000
From: Dario Esposito <dario.esposito@electrolux.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: fetch and pull commands not working with latest git version +
 BitBucket
Thread-Topic: fetch and pull commands not working with latest git version +
 BitBucket
Thread-Index: AdsgkuIRs8FkeoySTxWzjkKEb8zsvA==
Date: Thu, 17 Oct 2024 12:48:49 +0000
Message-ID:
 <VE1PR06MB707063B6C98798EF8AD9EF00E5472@VE1PR06MB7070.eurprd06.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_ActionId=e27e049c-e432-498d-90f1-5b4f8397f753;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_ContentBits=0;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Enabled=true;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Method=Standard;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Name=477eab6e-04c6-4822-9252-98ab9f25736b;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_SetDate=2024-10-17T12:43:39Z;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_SiteId=d2007bef-127d-4591-97ac-10d72fe28031;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrolux.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB7070:EE_|DBAPR06MB7015:EE_
x-ms-office365-filtering-correlation-id: 84178857-b560-4d64-602d-08dceeaa0c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?757CFvuzln76+tlL8n5+xpwfV8dcLCQSKZwEped5tWcgDCrj2udEiY1RxZdj?=
 =?us-ascii?Q?EDvoTJ+iedNd6fdBwbczSir+C/aQjc23VgMIRYUkjoC8N70IsrAxRkEojixF?=
 =?us-ascii?Q?jpqLO2qcdaQqiwwjM1nYT29aRkuFA7pZoQmXvehkNr+X00gxg1JK8wEklMzI?=
 =?us-ascii?Q?NDT/Skjz90e+ozJID/7OihFhLzL4EtxnOzHAE68FxWO9SLVkkWSHx57Lvhe0?=
 =?us-ascii?Q?bUZdY6BIT9og6botvl0KNTGI8XMWGJQxu8gy9VwTSxWM0hJw97U38F4C7GWX?=
 =?us-ascii?Q?y5I4gaRZmMG+dySaen5XvQfOwd6WKdfQmQH4dSPHEohdC6kamhipnqg+fB97?=
 =?us-ascii?Q?wTUcjdYzJeRBKjhUxS2I+LOeWNL/iJmwiXtuxU/vd44XH8h3YANcylzbbFWV?=
 =?us-ascii?Q?7gtghnDp5h1ls92JOaoAbybEQtRjozack8oQRs0ElYfQe+opX6fqVerQ+P3N?=
 =?us-ascii?Q?BZt8HLXEWV306aVbKXPi4UWtS5bYJR/ELTBA5mG0P4BxRc+GfN2Rf56vjT6p?=
 =?us-ascii?Q?C9GhH/O2VMgCKGqhcFGTOYfIE0QVa2aO5NUJxoNAN2F0hTQOL8GEXoWEiOFT?=
 =?us-ascii?Q?hL86UfveRY0ZrdDDX7kQ7EHgKvVKuL7qgGXhh0/d0NmsVMb1As6Y4h2ICNWp?=
 =?us-ascii?Q?wMCU7U6ZgFGsz8ay7d0MjbjmNfAv6P/6uYYkGQvg+0rGs4sM/RDaEkT3gGWI?=
 =?us-ascii?Q?MyPkb+nQy5ps++KbsPwGTvR16Dc/mbRfW3piNDV9Nx8OTg7ui+17gbyAZTNe?=
 =?us-ascii?Q?fiCXFIGYCcokskpBvLW1XR4zf7DRqoMO2KJn+cx8U+jVOOyacDmcwReYLFiW?=
 =?us-ascii?Q?hyBTUNJNOJt29JOmdLiEZEB3ZHVB1YRvhCV0utItX5M96J7qO0ZKx5LuS2l7?=
 =?us-ascii?Q?J0h8L+V881X2cWedq7fkMw544LWknOMCT9hSjqK5HVy/pLYm2ArarkVkatZ+?=
 =?us-ascii?Q?TElq21f7Je1pk/ASZ+kPCtWPWSKwz3Wul0iQqnQrGssBvgmwampc3cSsX9c1?=
 =?us-ascii?Q?AmpN8U3UmzvCeYXPdagvwsiRHwi7s9zKFbukriKQkxz8XEzLV7ZkNlzdLc1H?=
 =?us-ascii?Q?/TIQdwqZKMAG9uOMoRuy/LRLbeAMawqbhU64OYbstKONTGv8qAntcQnsiteA?=
 =?us-ascii?Q?OB2/7hzm/ZLRUa3EOpPXun+GDu8EFYEegMahlwd+P7LcBuSSUo1Kz9r9b2TD?=
 =?us-ascii?Q?VNBxPWYPl/mFrvc+ZpySaGCJ46VdULpyZouYOY/c27q3kqY6TCHHu9Mjbqk7?=
 =?us-ascii?Q?QIpkwPFXd8uQTUs4yVYoQorhVG8csB5UH9Ul/5z+goywUnqOxsHSAZJXHwc9?=
 =?us-ascii?Q?aZMNPNfNuGYQ93kVdrO/fKcv5dNjNHTA/z5F0vSbtEskbjAV5KkKlV3e98xZ?=
 =?us-ascii?Q?a2LMEs/ohGl/6yOpoI+PkItewUsz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB7070.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g2L1zpipI/O7cbpPLW74EvkbTgYidFuNtheay3hwp9AaIu9EefELOCHL5Kd/?=
 =?us-ascii?Q?of+/7Bl5/LHKFUgwLiHhXGBT7wqTAgkHQo6q5qYzXFRRLjLdq+BAxT7RWsLj?=
 =?us-ascii?Q?Fp/zcTZVgHiwRNPoDnON9kaHNIFGIGoWzjhVowh8JVOVvIlVzQvPEVGMzWVI?=
 =?us-ascii?Q?Z+QR7TBLNsLbnjN9SBOUbxdRNMuJSpXi2C+ZNyQtsSaO/T70r+byRuCeddy4?=
 =?us-ascii?Q?pU918AmXIHsi1Hnpnenr5eO8LZntfmEq07drkBkohq12HC96E8ngoB10XMT+?=
 =?us-ascii?Q?a1CpxvQbXGFr5hJ+ZW3f/Gbcm1IymJiOo/WUNDT3N072uFgq2hhPRcB85E5W?=
 =?us-ascii?Q?SOmNMq5TDSAku+FTWjqWFy+JuH6oK5dHrE8PxQPPTwYFVLVAUoZ7ZLZRRamN?=
 =?us-ascii?Q?iwiAZ9oP0dAkM7Cqd8cMUBdd+269T4v9Q8jB7OUzqBiTSp/vOkqoiSIqom/R?=
 =?us-ascii?Q?waCmmOozKtf3rEUSNKyhIkjxmH+hzUPyu8UHIRd4jmYBuOGHJod5R4NV3d5u?=
 =?us-ascii?Q?K4WzpjtwcBkjjgjom5noM5sNBl/gSZhsaMSOEyiZsk5EdNVu2U3PbRw8TY5E?=
 =?us-ascii?Q?TFVZwyCm8DBSShFvVprIP6KsnVremfw0wIg+kQsKAmE5I7K4lIKrtUyqCEKH?=
 =?us-ascii?Q?5kKjX8IRJfDjlhhUrzbnl/+1Z/8UAjnwhleleAilQL/8MOb25Wfps080aQas?=
 =?us-ascii?Q?m+g0pHY9Bedoz+JP0n/4t7dpwXmOf5D2ZSl59MI0tQX5lB7eLBew0darTYaP?=
 =?us-ascii?Q?awmvK3oeNSPQdUfrsJtaTDaPk5TsbjBafLj8/+6r3XVs2jdqD78GPyzSsxao?=
 =?us-ascii?Q?iA0zUh/3R4TIB30oIs/vcAGsSox02Q6j6hN7NtSvKAlRRu53c8bS5ZEExFg5?=
 =?us-ascii?Q?a20zX+7AOT/tM4ukxIxUL8H66/dhqa+lUHac6owhFMh2zLvesHiiSeYbruZP?=
 =?us-ascii?Q?IqmiyJOrtwnqRir2s9Ih/lxVjFIEtznWEvVURZCTPlQ7LcaJbDUVMB9MyDQa?=
 =?us-ascii?Q?w/spJhWdnFq17shTuecHKnePhOnMOaBU8b8BnuQ2IqWU2fzI1MzHza8renE/?=
 =?us-ascii?Q?8/di8npgMfg+FwZa12uMWz4UcSx9iG1yP+JgxEmb/+6dBZUeDFqeczsd3fOl?=
 =?us-ascii?Q?jxVZf7ZDuvXR7eDFm0Ftv2+8bAAsGlK10O3rBiKoCvUXFQI9LqxeSOU7ZJ9u?=
 =?us-ascii?Q?dUTMizeqzMTJYS0AQgHU+VeREfwLU+K7NlDkul18mGFAWmAwPfVSfVbOXL4+?=
 =?us-ascii?Q?0qBFgMqDGEwzkSoumgTXT7bqfi3XAdou5fzfxBkV1harXIPLEovmZq4OkDxq?=
 =?us-ascii?Q?9xzadXHH7ThEu7hbn7HQ9Xrzpwu+m32ILi6yfa+kqrbDRpexL98WI3qgxSzw?=
 =?us-ascii?Q?Z7eM16QU5h+ixTPJCW/qNFbGupzjQ0ljyHmcnZPYbR44FU5lpRd+4JjZ+doH?=
 =?us-ascii?Q?mbntvVnRqjTRfKrBYcIl2NVPMjg9OlcWh1yGU278G3osx9MgdsZkEuVYq/Ti?=
 =?us-ascii?Q?JT74AGpcVgfR/92S4yXRBotqKp583uYuKYxFwN+7qyMEUjO2p43uzUOEHLq7?=
 =?us-ascii?Q?TZapqjBMue8xfs3pdMgb+6MQTtqJ9ii/Q6emFBZDORHYTv0MXGZZcMctigQK?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: electrolux.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB7070.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84178857-b560-4d64-602d-08dceeaa0c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 12:48:49.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2007bef-127d-4591-97ac-10d72fe28031
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4yNCwrbeyF8cBxHnCsVkjXQpjGlYV52WQQR4rf1njOgnDRTqZd2h6dgOO0cnZ66nOHeLeU3MIP6JTxphvV1Y3uqV1YmR3MBw3s5TQ2E8QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7015

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened?
I updated from git version 2.46.2 to version 2.47.0.

What did you expect to happen?
I expected git fetch and pull commands to work as usual.

What happened instead?
Git fetch and pull commands get stuck and never complete.

What's different between what you expected and what actually happened?
I expected the commands to work as before updating git.

Anything else you want to add:
After reverting to git 2.46.2, fetch and pull commands are working again.
Our remote repositories are on an Atlassian BitBucket server on premise ver=
sion v8.5.1.
I use SSH with ED25519 cypher.
It seems others have the same issue when using git latest version with BitB=
ucket, see https://jira.atlassian.com/browse/BSERV-19682

[System Info]
git version:
git version 2.47.0.windows.1
cpu: x86_64
built from commit: d53e4648cb65eb75dd8d8a093d17400a18a9a15d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.10.1
OpenSSL: OpenSSL 3.2.3 3 Sep 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
This email and any attached files are for the attention of the intended rec=
ipient. The email and any attachments may contain material that is confiden=
tial, privileged and/or attorney work product. If you are not the intended =
recipient: (a) contact the sender immediately and delete from your system, =
all copies of the email including any attachments. (b) do not read, print, =
retain, copy or disseminate this message or any part of it. Any such unauth=
orized use may be unlawful. Email transmission cannot be guaranteed to be s=
ecure or error-free as information could be intercepted, corrupted, lost, d=
estroyed, arrive late or incomplete, or contain viruses. The sender therefo=
re cannot accept liability for any errors or omissions in the contents of t=
his message, which arise as a result of email transmission. If verification=
 is required, please request a hard-copy version. The protection of your pe=
rsonal data matters to us. Please find relevant information relating to Art=
. 13 GDPR on https://www.electroluxgroup.com/privacy/en/. The Electrolux Gr=
oup www.electroluxgroup.com

Classified as Internal
