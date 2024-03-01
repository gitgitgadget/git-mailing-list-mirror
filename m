Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A499848E
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319995; cv=fail; b=i94ddUwy99uHIid/ArBTOTYeCA0hiz9pQtsUEWA68x7c49aQXPcrDDc0zh5Xpnt4iX0PkKcXpFSekJCCXvnXlNY4rM5Vmc0sw+dCmEXTlsqLTayXDMDtQcW3YIlo0CJxHuQ80v8CSSSpr6vFKGmqYhy6fUkkgxHc6bg6sZfos50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319995; c=relaxed/simple;
	bh=ed55HqX37RTkg7ldisMh0OUG7VPRvGX2Gm3FWqbmtQE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U2tnCYejOR2BTocDHBK1VWxzMoTbMV6oa/Ol+lGkJlGOIMQ22nGOlfeGtZoMQV8w1ChvryocZuthO/FT2DgvoQ5oZKs24zVeV6YZ5W+ibGxxmBUUMJNfKGJLE0aCqkjleO/FU8AzUnGRDzfyUfiy8GW8OqBct+HkvZb3qNsSs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com; spf=pass smtp.mailfrom=philips.com; dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b=NEQg6Fxc; arc=fail smtp.client-ip=40.107.247.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philips.com header.i=@philips.com header.b="NEQg6Fxc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVS8NvHrJOplu29cnom/OmK66+OpucHTFE/o3WzRiosnjpkpmpsDY9Ukg+x9F8OwcssJ056kYTRE4/GCoQZDjXySwY+tiyO4jqiujessKVqhxKF8nEkECL8sPRx2zAa/JoZi2DKKy9zzz7noKr+n9l3xw+4XEy8YA6nbuHLpPueIhZETJKAGSHTsNaWGa97WlHzpzuqMXIv/44s0cdZqVespRXdYb5oDUMUrRqeqBCHsJ91SnRbNyfdOkxMUeO2ncsTTWVz/zbEyA4sp0w0MTsPbMcL2aoKO5mb2ekaGiKQm7x1N5bxyhYGTAcPiFfFr51mIhRaCsCGjyEb/BnabNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLz5xIpLtc3TF5kYF3Bu1HYRV7SRop6yJxiuQ+6tOZw=;
 b=Guu9cHpNefd/LmFkz+HgaWLy9tvl5vk/ZPPra+c/SrYTk4x6vy24q7IEu6+uhVny/n0pL83et8+Kj9TK3F/6NyWhxvjBxVAs4ZlK/7fd7WnDhsl521NNaLREk1Vkk5dhy3+DEKrB0aJE5D/cvUYVWaQeTbzTDAxhfbx1Xg6SlVV1gOANn4e1BnID1sUz+zziyo4GLmcl5wS/Y1hmaZRQND0AEEMz4RSXJ0dV1F6rNYcdsvty6WcEvM2Jho0zsyFNBlP/aa7YQAixY1JIPUNR8ysMAjUakjBLSVsBgQ084METO4NuIdJ4JAtUdEse1OUKDvMYBIe1eJy5AVnSP0cpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLz5xIpLtc3TF5kYF3Bu1HYRV7SRop6yJxiuQ+6tOZw=;
 b=NEQg6FxcZS7U2SX+ylGRI8FU31E0BE9G3//aWRZu+5jgKCVw2DqLN3DYEWY7D9MoJdbL1w5KBv8rJWBalrfsS15v8by6fhGhzuZUMgJBOoaB5UXL6/1fRyCNZuzmPzmsoiXwmzlnAwBT8QvyWkcKem8u5vrphX+jkWqWC0IFJe0=
Received: from AMXP122MB0181.EURP122.PROD.OUTLOOK.COM (2603:10a6:209:99::30)
 by DBBP122MB0249.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:174::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 19:06:29 +0000
Received: from AMXP122MB0181.EURP122.PROD.OUTLOOK.COM
 ([fe80::1ea5:9f3b:a2cb:68d5]) by AMXP122MB0181.EURP122.PROD.OUTLOOK.COM
 ([fe80::1ea5:9f3b:a2cb:68d5%6]) with mapi id 15.20.7316.042; Fri, 1 Mar 2024
 19:06:29 +0000
From: "Ayoub, Toufic" <toufic.ayoub@philips.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Support with finding git objects
Thread-Topic: Support with finding git objects
Thread-Index: AdpsC5AWT1wB5TdrQR6XleVJjC9OgQ==
Date: Fri, 1 Mar 2024 19:06:29 +0000
Message-ID:
 <AMXP122MB01810E9B1195953D9AD0C8C48E5E2@AMXP122MB0181.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMXP122MB0181:EE_|DBBP122MB0249:EE_
x-ms-office365-filtering-correlation-id: 4445074c-866f-4170-7df1-08dc3a22b35c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ibzgxPXzMf3e0beYZFgifukWbayl4qOSMgHRrmaFN2AthwiivT5ETjjGCN0OfAqIf5wYT2p+dVAvWSoT1GdeGH+Hf7u9TsQJXleYZXkx+i+j/lcA1Plij3DG5OTT21jb8e4qiOMA1OpfYZiDZq2DM8VivgCZhegY5eaLux6K5BQEMo06LutZWlTe2D6sVqv7QwvqslHPpjpbNNCdgsIc8mwACk6MBWct8qkEflaW7EculVqOZmioM9SMZXFrCcC9kmtiHjoyfjhA4u2/Qt149nQDi5TrX+kMEdGLC2TElXrxPYi7MtcwOKOuGlVP6h+eOvAS3BZIn5pqmS/xceY2Ddcpetm/1QyFxLPuEw4CYJ6qMGIm8NOgtx98fLCG/dQLWHmVs37Aq53dP/AYlMAepkJvQkcBqsSaLd/Wctsfe4o2+eMvuLK0RpU5aIM44F+AjjKvNaiPS6O/AbMd6nxlwJ9BnQK8lSuPAjAh4z9cXZPMeEcDNMGkExHivtw+Rwnx+G6svPSwvEgehfLu53m3cLLr3DCfEsTuH8XJcPrBaSPerfB5LcN3URCgy8bjiTy5x9KFawVvC7hpbBHO1iX143suEA+3eksbECX62a/a8sW6a/mM2hVBYCB2kgMqAqFxovaEzTI8+L+Qpg2VXkzvHoEK+EHRhDu7SZuGt5TiVYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMXP122MB0181.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Rnniqk78Et4RCLxbm857B4OHLdG825jebHDFqnX/cnQKBTq4WO8BY5rsm0?=
 =?iso-8859-1?Q?5JW6GredlGkagMMqCgeXalwL2LxtWQPuEAM2CZGwKbwTDK3vAXhr/c2nmc?=
 =?iso-8859-1?Q?A5+hG3J+U8rfpUknmgztES8tIJc9ZLlKlLj8rVJMK3BhQqIk8hOl2l1Oee?=
 =?iso-8859-1?Q?w/8SJqNP0gqxG85Tl+6QgpQls8EyQHVORu129DR5s8dMwU5MJ08BpofxVW?=
 =?iso-8859-1?Q?+opGuS863OBj+vPaEsqSJMmA0WYghfUhisrHWkq1R6vgZG9c7WUBJZb/NP?=
 =?iso-8859-1?Q?aXJyjx6MRKTB8ZxeVgkd7ay38TbedJpgi7QgB3nlEBTQ9YcE+9dGb1hdTn?=
 =?iso-8859-1?Q?m+u7+uddIFZDeqHdd+Gp1TkGGiFrClrySHvBcV7tu0VS9cdxjkWs1nGX81?=
 =?iso-8859-1?Q?vgr25caN57HWlw4iXss81F+btr1PSOx2fLEcb5jRxeX05XJKr9vg/g1jWz?=
 =?iso-8859-1?Q?mb1TsaJgav+8D3xtO7XKsKQ+401fpCxaFQWn6V+NHmtL+8FylnsEwrqK0t?=
 =?iso-8859-1?Q?JHFKnJ3QM9w4snt9SZTaKmqKf5YcQIOUNgPqPx/KlR5FW6vVuorm71Dd5v?=
 =?iso-8859-1?Q?PP9MStATRUcsXmG9pSjfGMtRBich2Tow5mBdIKk/oIzSKCQRUA/X74bjVI?=
 =?iso-8859-1?Q?CfM+8PT5Joyk4A5JpetDNLOdv6O7kwjCdIr4Xt5muXW/tuVOSaLT9BRkqM?=
 =?iso-8859-1?Q?jiMg1F56RIRiNgVSCw328dS2CqdwitV/mLyQXUK7/J2D4mIEHynEkjn3Bc?=
 =?iso-8859-1?Q?/3Devp7d4Ql673+Ejcn7gPX0mDkK6T41jUryunBF6zPCSW0+drIXppFee1?=
 =?iso-8859-1?Q?Rk3jZQz+lj4G4NixdtfNeTDPxiy6km9RIYcO/ihowRaJrrXKX+ZVBJiRdo?=
 =?iso-8859-1?Q?D5gHBN5XDkcub2cBkF90DbX/svKymzPWW4EyK1Hg6qsYaL8oxXKDLPMj29?=
 =?iso-8859-1?Q?Lk6f53kLnGdhPRbmy50gARq2TIe1fLCTRWqPmtVsPwJbJALyGgISBS/run?=
 =?iso-8859-1?Q?TcJIiqVDOGHTrZT0y6V3j+fbyIaPW0JaIA3Sh64Y9MXYSECWC6xkwlUEF1?=
 =?iso-8859-1?Q?8+FkrA3ot6yrTj2jw/ulw+p2YjR2bzkzZEA0KDSiKfN5SD16Z/LEOw6yxc?=
 =?iso-8859-1?Q?9dLGQ6wPbSa0Ko5HprCoaKf6XNv8xUVH3jRj1ISHV2GaSmBjJI5mhtVoaU?=
 =?iso-8859-1?Q?c4TISfSVIb3ZpNEc2X6MO24E3JfCVX91dvlYtjWOWcW+NNthGdMPFfaA+M?=
 =?iso-8859-1?Q?Pxe98IkeF4KiiROwMLREbrwMTyqHNHnQSro4cuD8gEDGe84pa7VS7lOVJD?=
 =?iso-8859-1?Q?VQtfZE8Dd4efMT76aqKKdBbb3tvCKfBfYqvUgWxKUuxMHOGLBA8XXiPALU?=
 =?iso-8859-1?Q?njoUpA/ZtzkK4IB7f4Jc62mBgWCA0jtRuWkZXvk6m9oSxuy8BMgkZeeBx5?=
 =?iso-8859-1?Q?xhI7VQur8WJBDmBmzQUMfetJzm9MXHNT3E0WWtoNlBUKkyYMIZUXDR+MGx?=
 =?iso-8859-1?Q?vJJjqbI5MVUJvF771EKtKLBcX6zeQ4oRcAc0Hkv8ujEezQu5gAzuFPwmQf?=
 =?iso-8859-1?Q?GDvwfwiz8BGa+OUtTv6ZHF23O08b0NgL6t4bNpW1Uimg6KEq32AZQUlbjX?=
 =?iso-8859-1?Q?/FI2l8Lk9g0N4hU+eDvaRx7Iv1pAdH5uEswMzz8wDMFOsjIo32hwUV72jp?=
 =?iso-8859-1?Q?6vz21+nhgntiKFUZ+uu2/qwZ4VfSNXTAa7S5Gc1I?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMXP122MB0181.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4445074c-866f-4170-7df1-08dc3a22b35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 19:06:29.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E13b7qLy/4kpHclBV8BQ2Ve+m6m8I4FqSJPdlzY/kM39VS0nVZykfQtA7ITPbBeehKWHwW4cImTYlIqkQQ7PK2bMyMEg7ror6szIuk/m0Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP122MB0249

Hello everyone,

Hope this message finds you. I need your support regarding an issue my team=
 is facing.
We have a code in our SW which shall display the date of the git commit. Th=
ere is a path in the code that if it is executed on a platform where git is=
 not installed, that this commit date shall be found by looking at:
1.      Reading from HEAD file the commit hash
2.      Searching for this commit hash under .git/objects
The problem we are facing is that sometimes, when the default master branch=
 is updated with the newest commit, this commit will not be found locally, =
even after doing git pull and so on...
The commit can be found with:
1.      git log
2.      git cat-file -t <commit hash> -> it returns "commit"
3.      git reflog

but the strange thing is that we can neither find it under .git/objects/ no=
r under .git/objects/pack (although that is the newest commit and shall not=
 be packed).

Can you please provide support by:
1.      telling me it that is an issue or is it expected?
2.      If that is expected, where shall we find this commit object to retr=
ieve the commit message and date from it (without running git commands)?
3.      Or recommending me some other solution

I would appreciate that.

Best regards,

Toufic Ayoub
Software Developer
Hemodynamic Algorithms
Hospital Patient Monitoring
Philips

Philips Medizin Systeme B=F6blingen GmbH, Hewlett-Packard-Strasse 2, 71034 =
Boeblingen, Germany
Email toufic.ayoub@philips.com |www.philips.com/healthcare
Gesch=E4ftsf=FChrer: Dr. Dieter Haase (Sprecher), G=FCnter Gegner, Sang Do =
Kim, Florian Kuhn
Registergericht Stuttgart Reg.-Nr. HRB 245187, Sitz der Gesellschaft: B=F6b=
lingen

Simply switch to printing double-sided and printing less.



________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.
