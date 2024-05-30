Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2092.outbound.protection.outlook.com [40.107.108.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD61B7E9
	for <git@vger.kernel.org>; Thu, 30 May 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.108.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717036792; cv=fail; b=DRuSK599jWL+Bsi/6LzN1xBjtlV5cCnYmSX/jV2IsCHz/HILz928LdONSXPOcxowfP1BZYjHzzP+RtxAaV1zb1UrSyfLvpPOgCrMNlEoA3vOb7yuFShdCqmq0/XJUh1pW6Y9HQT5ODLORlfFb0qtsrH4S31pDeozIH0thsAw1/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717036792; c=relaxed/simple;
	bh=KzQTZ4HO4o+Z2CSOhYxHVEAoXPr6xYwZ9y2ywaIt63o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qYr+ChTIwWMOm0iVqyu5cWvhPaXJHgX7VldxrY/2fFOy70OIQzGYBRLiFVIoiRTF/ol0gKGicFusMLV6VRdmh+ZINEWrJCWw8nvt7clC3bronzS/Ngzy4igSyFZk0A2rdspYwqSeZcytcaQ+dOonGjHXtvz7B0oCm7TqyAi2Iow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hardcat.com; spf=pass smtp.mailfrom=hardcat.com; dkim=fail (0-bit key) header.d=hardcat.com header.i=@hardcat.com header.b=hRmXJ3oR reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.108.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hardcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardcat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hardcat.com header.i=@hardcat.com header.b="hRmXJ3oR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlGPyvu0TNJb0a/KDLX2UEi+HCL1YlRVLcItrQMxgufmn/J4y//fdXGHFy71w+3q9eDKVe0XYUhe8Py6PSGIowlnkZHXoNDTvL8OT9IUt4QPgiFAycaKzafDXu65n+te4RE5/XDzi+PjRsU4/30ogmcLGOGibR4E2WLdv0nreESC5JhKTi/mMBpZIYL8laXev7fLOsMePWEh9qeVfBH8DkaNncHgwMAqrM/Dbp0V2uI1zO6YvHcogLOr6YErm3WzDc/a+a/SoR4nabdjW+8hPKN6Xi2pgNcBjMbAsJxTDMCKe4OdSZtOwRI7K41GhlfxSG5+YT3YGdx4aK0QthO8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIlehtnC59/SKDkSH0ola461LwxvzMAwvNvBZi3XMjQ=;
 b=O7C0u/qeNxEYVKoTxnuJom3DFzaxRVPRmwhsCK3I2eFJCSD8PMB2CoEMV2QRW4JxLK8rJnu+J1KkPvHvsyxIThD0whAnykPhA8vhsQTs276oeVLINyeJjiQbeykAH4HDj0z/uCo5s7+vIrJU2Jv0EAFsCS3UKgXNBXIJn4sFEwAZIOKkOS/Sw4SLMDW5hfk1BbE3bgurF38U5ACQc3n35AoYHJrzo4WXFt+CcnAxZxU2Te5F0wDIl2lp90QOt0UI33FmbfPhuotviaHY1iI5y5XjuKHKjyflsDYnHd+FILui3IMxNE1tYxouRZMIOb0bx0VLBg9p8xLC7vUzyDVHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hardcat.com; dmarc=pass action=none header.from=hardcat.com;
 dkim=pass header.d=hardcat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardcat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIlehtnC59/SKDkSH0ola461LwxvzMAwvNvBZi3XMjQ=;
 b=hRmXJ3oRn7El5lmyh+GmuglTWybdYBtWDQVepN34if1WR0fcOrDy4ixvNJkaJ2K33CgmoJOjCANpojewKM6xQyAGuNFSctmQrwWrFUmc3ldFWJwMQctrwJ7vzcTBSeWsogiwKT5PK4AEKcth4nNaRQQuQqLR2auQCtbh5rwCnlQje8Jqrcj739mlA3dgg+/5dYRDfsAGbPwG/AcePV7060/g+yDfnICFOk1IjeVeamdnfNTStLsON+ZshvwKrNUDoz33XuzYlNFK1cxGK7EVR9PCmuSAoQPLBvx1bQhE8twD321T0Vzj9DNIvu6kSTh30ffmYoTvSI18zk00MRPtGw==
Received: from ME3PR01MB7142.ausprd01.prod.outlook.com (2603:10c6:220:16e::8)
 by ME2PR01MB5793.ausprd01.prod.outlook.com (2603:10c6:220:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 02:39:45 +0000
Received: from ME3PR01MB7142.ausprd01.prod.outlook.com
 ([fe80::7263:4124:fc90:3871]) by ME3PR01MB7142.ausprd01.prod.outlook.com
 ([fe80::7263:4124:fc90:3871%7]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 02:39:45 +0000
From: Lou Rech <lrech@hardcat.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Alistair Wilson <awilson@hardcat.com>
Subject: Git update 1:2.34.1-1ubuntu1.11 for Ubuntu Server 22.04 breaks access
 to shared repositories
Thread-Topic: Git update 1:2.34.1-1ubuntu1.11 for Ubuntu Server 22.04 breaks
 access to shared repositories
Thread-Index: AdqyOBEBIUWdnIxlTwyXH+L586AwMA==
Date: Thu, 30 May 2024 02:39:45 +0000
Message-ID:
 <ME3PR01MB7142AD152E97A36EFFB5A8AFACF32@ME3PR01MB7142.ausprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hardcat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3PR01MB7142:EE_|ME2PR01MB5793:EE_
x-ms-office365-filtering-correlation-id: 804f7d1d-cbc1-4226-aafc-08dc8051c48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H64hA307OXjYs0Vhrok18yIkG0fLW/UgWQX9wQGGn3BNWdIBn5qyH5hKdrIN?=
 =?us-ascii?Q?eRovI0KHPrQ62YY7gn59DcFn2wPVKDTllJyf376n6CeREpuBuowKGyZ/kFvA?=
 =?us-ascii?Q?rrgALb/nMKMPqCqXPj9INoZrLEBNAfp8cE0bP+t/HhC8+SV61yhg+0O85dsd?=
 =?us-ascii?Q?nql4bKSpPOreqe1nGVJS69d8oDmUQhFPvk96xOfqu/mM/h8PnHmrJDm13iHL?=
 =?us-ascii?Q?0ufxLRLh99lQUiHJq52wFnFdpaT3QIu1YpiNZcVKx1y+KlO65jBOywGbwqZS?=
 =?us-ascii?Q?mFspEIem3KFSfaKjHtGDwtqrBdMBtLxKGBfrGGxta4PdBeUZO6M96j6+M8W7?=
 =?us-ascii?Q?7/yXVt8aZjbNk+IFqnQ4iZjhRjdTWzT8pQgOj+7MfyNSdgEqORFOCNTJRDtR?=
 =?us-ascii?Q?zZP4qMjIQnYwRmZCcFU1IXQ8rJoTXPkL5uGtR4Dub4SBxavDNH+xaLNZdo4Y?=
 =?us-ascii?Q?6JefW5o9EtLCE4z38MX9mOVHF/OEFPmtcSUOKnaKQa7+EYPySoMGDj/uKIyO?=
 =?us-ascii?Q?fB9FMyB/rVKUMGpdULv8BN6BAl7hQH6R3blJh8veAbdn7GWkNfqBCy8KML8a?=
 =?us-ascii?Q?Mnso1Vu7t6UcL/EnPpWSrQUHDqXgBdoa24Oca1zgQ/rdyiRkHGxdDq8P87E2?=
 =?us-ascii?Q?LwwxRFM1nLoixGSkCMjaGRXK12HQfcGq+NXpRLYoBwj7foaJmcUOjoddj1m3?=
 =?us-ascii?Q?2Wlkln2Tby3fgGIgAYOCTGYXwhXjJCTVo9BCtZ/W+KAg4eVheNESl3CLk1kN?=
 =?us-ascii?Q?9sP2Up0aOzESpsraBVfhic6/xnE/X6qa6Mt1m2/aC/6vyVLuHAWtAES7jaln?=
 =?us-ascii?Q?HtzWNmVDEK1rah8JdvehVxb173zRw8wW5BhgGy0AMCvpMVw9YYn64ltJ+aKp?=
 =?us-ascii?Q?DDUqb1R5Rgo5s41/ru3NH7LsRpnOGleh4mksKVzovFlDpdlATNxRJBFrfs9c?=
 =?us-ascii?Q?QLniHbglJ06tIOWo+nRMObk7SUK6XzgLIXLDH+U08ne9ML6fAW2oQrSrpBx8?=
 =?us-ascii?Q?lrjk3K/UPF6G5yTt8cXmLqtGZKdzXNa2M7OZGsUNq+uxNQMMps2bzDmbl7aH?=
 =?us-ascii?Q?5fLDJi8xUxAtRu/9kBA9CscfCuoVDZKf9roFkdd2LBgF4takEK+74W/A7ja+?=
 =?us-ascii?Q?TJvZu3N3Xt9IQMYio+1KrnM29hND1+yxs+9CLtzJPTyz/L7hOdfrbAZWKOe4?=
 =?us-ascii?Q?vLqAW8Q5Z6c64uhTFso+iSEaQ/p26/bp6ZcQV0MEuBI1+0WHJNKhmlgW1gwH?=
 =?us-ascii?Q?Hkm35xOVC3WpYLkLGWyzhMjJw/r1NP7FrlMTo+UrvenOBxz+QaKtJvaQwP9A?=
 =?us-ascii?Q?auQmNgF6Qp9aPY/HeNbXKmmqheJ8Urx8ZoqypKJMpC9nMQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3PR01MB7142.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qrVMy1XJ130ZBOn3oPaES8+nIfbBIef8jteELleGQY4TRPQKCs+lG6Oroc0I?=
 =?us-ascii?Q?DfpP3NJKnzMkDUeV5wMWPju7X1kJWTb97utEA00EW7r2L++1j45l58PqAOdn?=
 =?us-ascii?Q?qifqPEB41ffmjbCu8eZlR+NOWtTy/xHCDHLSuNXjZK0L5OJv53sUfRFf9zfI?=
 =?us-ascii?Q?dqRAahYsDUx7Q+YHkf6psMJ0vTE5YCGmRURmKjm7PIWTBiXLREMMIb+7rVlr?=
 =?us-ascii?Q?E7Sax/t2D6it9w/iAHGwBBx0na8NcIPizu03kUcEHz6PJ7MIWHDtfBIfb1uk?=
 =?us-ascii?Q?wXiN0MrHGxfU9+19GI2CyJmJ7nia46BOb4X5T7Uxtp9lF/XQSuRRbTQxHy/Z?=
 =?us-ascii?Q?DWOL7rfO48Ku7UlEfmiqx49xXFWGH8zBEq5Q0jEufARc/2AcMvM5jNpnxBKz?=
 =?us-ascii?Q?LV3SJFU85KZ5bNwiSm85vxZtJ03qZRZ9Gi4SZdJ+3nLI1FwNZIxFagdQOPKT?=
 =?us-ascii?Q?eWpRrDhKQUX0Cl3rPllIkIEV6S53W8BPO33RiiwD00CoAJ+b91ngm/xHltQe?=
 =?us-ascii?Q?zGq9sZhBWKnbN7akHQKnEHVE66/c0OBASoklqIt0MQeOAhqMymWaQmmYHX/f?=
 =?us-ascii?Q?RsnS9AsCZlFgUOstLvxk15Nv7ucAOBqW0OYg+X8gwfrnABpgLGuq+ElY6pWA?=
 =?us-ascii?Q?lAjtUpWJHGwh/IeeQFhin+6TVcp1omD2Z9VGcTfg/YWn88eCvDpkC03uBLDu?=
 =?us-ascii?Q?izOFId8GJCAIqCgEgHvvH6voQjP0SByACcosBWmzr703s3W07LsCxwOYUiUg?=
 =?us-ascii?Q?d9vF8hxx/SdPmtXfXLPMIpqUwrDfB5al8DfpL+fGaFf4V38/oUkVb7YjZGFV?=
 =?us-ascii?Q?vXtiRmGJfzVYeyVFd4yh4MI7BCEr57aoTa74qslWIK6C2DlKlFczPYmz89c1?=
 =?us-ascii?Q?XJUsadajTgng9QO8nyyjb/ySxicxUkE6mfPCyVyyD6hl2e86hsOWKcZTQ3f8?=
 =?us-ascii?Q?c5aSFNb9xk+hVQ3KiEzDC/kkrTvFE8IitS1kQmKez+DCgdGYDFmJA5D0Lg/G?=
 =?us-ascii?Q?u0O+0+RY4dBFDp8eJP9h9dQq56muxaFGRX2m1YHDpUohyhOBGIiEt0iWT4o+?=
 =?us-ascii?Q?s5OhnSHGa2cOv4wEEUx1Y1nW3ZDa7ZduFEDOxjaHLZPfQnM+O8gMXdhL+Un8?=
 =?us-ascii?Q?4TJtB2d/Kk98a5Td8Nk+h9igEcLbgNTkMT/v0tsLGJMfL2HLsiGaD3TI97je?=
 =?us-ascii?Q?rcJr0MhrZblZ9HoG3s3MLxKaQOuhqfLC9HeQlvbry2F8sgmMWBBlPLMaqiMH?=
 =?us-ascii?Q?UUNKTI7nirWoDFvHfMfTtWMeb9E7dz4OPhP9HVG3BYENgbNNf/A9TZ1N+X1E?=
 =?us-ascii?Q?oN8ZWLoro4CPNRtJjpHZF/LgUuB8DyDDQpEdhVQ+P1UQgRC3I7tLT4RPuIU7?=
 =?us-ascii?Q?OXdeNurTkeiVQpOFF5JNV+ILaqBubT2+Yqiut69mJgBw5qmZG/JYxYsxgmDo?=
 =?us-ascii?Q?hFqwqLJR/5yZfWiwTE/N+4x44TQIGSldotKZC+WIaiLENu7o4V/E1DqUybCh?=
 =?us-ascii?Q?cKekJQBx7igWlOkYm7QMrcHMgBh42K2Nc7hkqh7i+Toxuc+g608a2kg+BXkg?=
 =?us-ascii?Q?dgqbg/n7oDk7rnfA8FOotFAtg0A9e46HHiqWGGjL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hardcat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3PR01MB7142.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804f7d1d-cbc1-4226-aafc-08dc8051c48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 02:39:45.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c644582d-586d-4239-8964-54a78b734027
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 310N4ARJ9URMUtRO7FBB+PIRqjueFbNyY6NbnlznCRJIPSgeO5Twlz05VgXv0rqDc0ZUMH6Q27ryNRIxvY9sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB5793

Hi,

As of this latest update to Git on our in-house repository server we can't =
perform any git commands to our repositories. All commands report "detected=
 dubious ownership in repository".

These shared repositories have been in place for years and now can't be acc=
essed.

We even created a new shared repository owned by our Support person 'awilso=
n' to test this behaviour. Only the owner of the repository can perform any=
 commands on the repository.

Case 1 - Clone new repository owned by 'awilson':

Git repository created by 'awilson' with the following commands:
mkdir awlr.git
cd awlr.git
git init --bare --shared
chgrp -R 'Git Users' .
chmod -R g+rwX .
find . -type d -exec chmod g+s '{}' +
cd ../

Git clone attempted by user 'lrech':
git clone ssh://reposerver/usr/gitroot/awlr.git
Cloning into 'awlr'...
fatal: detected dubious ownership in repository at '/usr/gitroot/awlr.git'
To add an exception for this directory, call:

        git config --global --add safe.directory /usr/gitroot/awlr.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

Conversely, all other repositories were created by me, 'lrech', in the same=
 manner as outlined above and can no longer be accessed by anyone expect me=
.

Case 2 - Perform git fetch on existing repository owned by 'lrech', fetch p=
erformed by 'awilson'.

C:\work\Tiger> git fetch
fatal: detected dubious ownership in repository at '/usr/gitroot/Tiger.git'
To add an exception for this directory, call:

        git config --global --add safe.directory /usr/gitroot/Tiger.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

Please let me know if there are any further details you require for this is=
sue.

Regards

Lou Rech.

