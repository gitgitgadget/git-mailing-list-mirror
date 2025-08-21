Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72326F2B2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779138; cv=fail; b=Fw6xUdQsUEzKbWoXKBB5qSw/8nGbosvHbrLosWEwLE/NF51McEY6YO1llYRkTKrEWaHjcXisPE93sYn9De4NKx40iIJW8ydJ6ABdMKFT17ApTAfgh38wNtCTwZO26Nu6Aht9kHVzfvr/F8+hkNTOEv//z/hfk1V5sR7ieeixTMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779138; c=relaxed/simple;
	bh=GGHYqqyxTpNZEqPasoFmSBcmdkuAeI6lKN7TJJCwTNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6glfEvTQVdOL8rPtzhAfkh/BXeQIO4bZeUYn27spsCzEu+SJZQ8MZl9ZkxdD3zv6BaGedsmPpslA7Q6Y9S7Bhutyl8MT+9DQVdlVUgFkUvOPrU3az6GZ9QDjAZukheMRyted1WUvQRbUaBZz/OPfmrI1QNznJxCeQWPf5CMbjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dataventures.com; spf=pass smtp.mailfrom=dataventures.com; dkim=pass (1024-bit key) header.d=dataventures.com header.i=@dataventures.com header.b=VVbsgmq/; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dataventures.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dataventures.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dataventures.com header.i=@dataventures.com header.b="VVbsgmq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R76aJ5iXprU0+bZzSCAzHvkGxgvabf5aoP3f2S+DrMaqVJUygWufDk47deMQbP6+2il2yrIilXjnZLraJ9uT0xpHlPwpPwZwcsbiI7ctroODTkNilRXNZXppMBkOmWjpzSTTaNRGv5wjAKIRo08AhGS5CdlecEf/Tl55E+Lvg+5wTVx+guSlCAl3HmbDNeZna37A3Xj/Cb4Tk6As/CrHFVPUcQO88vaDD7haE+zYoB5QipX34yYroEflkz4jQVpETxp7XXt6plsor1EmT87QIFy9ijL8cWiH5R9jCULgmRBTr8dnYEcLgVqTPVgcfcHBH9lvpihCn2acRRVISFF5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGHYqqyxTpNZEqPasoFmSBcmdkuAeI6lKN7TJJCwTNs=;
 b=YfbZR2e5cpOJncAO5mQuJa4xn9ru/9jOOlBBBGSgcE329NCYSXtUAn83jY1+CIM+fm9C64c6PrrH8bGMD6cZ1HlghmSzIHOnIvQfdt5oIn21fcTg/KhNHdq6t0+B6mCsFYqArGrQfW24zdNymlTsXAJshexWg9D/V52rL289xXiOXqwudd+y2AIEZIbGUQfuG+DMuvtPH6qzQwzaSVOEeyky9PbbBz9jZRwkLc9NSdXlWlJGCqhEWvojHuTyqa0BJrY1v3AoLl0j1erzp1fN8dLCM5P8QG5otd3bRqVX9WuEhsatlKPWliowvYkEo6lL2ySN+yoWWRpKqXk5bxXp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dataventures.com; dmarc=pass action=none
 header.from=dataventures.com; dkim=pass header.d=dataventures.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dataventures.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGHYqqyxTpNZEqPasoFmSBcmdkuAeI6lKN7TJJCwTNs=;
 b=VVbsgmq/pPWXUi5gN4k4MNv+QMdnK1zU6R9FKDn9zD/boMuFVieWCN4mISWyaPtljpvotn50c7GQ4auS3tkZsypxpcnCf1RJv5yoWlsSU2Ww8RdE7OLqWm8xlmHXggxLUnYEeCezL2QQFmqU/jg7s5fYuRzBnB9n9oeGB0p+9Gw=
Received: from DS0PR15MB5854.namprd15.prod.outlook.com (2603:10b6:8:f4::17) by
 SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 12:25:31 +0000
Received: from DS0PR15MB5854.namprd15.prod.outlook.com
 ([fe80::c05b:dbf:886a:b329]) by DS0PR15MB5854.namprd15.prod.outlook.com
 ([fe80::c05b:dbf:886a:b329%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 12:25:31 +0000
From: Frank Thompson <Frank.Thompson@dataventures.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Scott Walnum <Scott.Walnum@dataventures.com>
Subject: JENKINS-76004 - Git changelog is missing when CLI git 2.51.0 is on
 the controller
Thread-Topic: JENKINS-76004 - Git changelog is missing when CLI git 2.51.0 is
 on the controller
Thread-Index: AdwSlC5gRKMPuJLXTEipRiYI/EWEDAAAlHxg
Date: Thu, 21 Aug 2025 12:25:31 +0000
Message-ID:
 <DS0PR15MB5854DA8B2E8181A3F046A3D1FF32A@DS0PR15MB5854.namprd15.prod.outlook.com>
References:
 <DS0PR15MB5854E8F8C95581DABFD8FB37FF32A@DS0PR15MB5854.namprd15.prod.outlook.com>
In-Reply-To:
 <DS0PR15MB5854E8F8C95581DABFD8FB37FF32A@DS0PR15MB5854.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dataventures.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR15MB5854:EE_|SA0PR15MB3839:EE_
x-ms-office365-filtering-correlation-id: 72fca0ad-6e7d-4b06-e96b-08dde0add206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WQ+lGb4no4HKCgIw6qengekOBrykk9T0AoW728c+RUf/7y+8Ch6J5jkfkh?=
 =?iso-8859-1?Q?J1shF5CeaBRKGhEOg42c4NFokFGxoLnhWU7bZoGVpNF36TU7yGlTOmArJ/?=
 =?iso-8859-1?Q?XW410LjhAGvdzuNvHJOLXT31VQwkxmWZhyb6dBXwfJbCyeWRrUS+2NYUCg?=
 =?iso-8859-1?Q?5VeLwvTVUEZ8Hg6doMU9xia0jf38ixyuPPW3PcjOcTlVe8B/LTuO9e49RL?=
 =?iso-8859-1?Q?6AaaRP1wzElZwHx8PKKDRGJT452ms2xJxJS/05e8aviBNu4opJ+TQmL1Bu?=
 =?iso-8859-1?Q?Dja0zI1uBkJy5advs9VKms43kLuEY0yvNV5BOehDjMMBfACT6jUMC1MFVi?=
 =?iso-8859-1?Q?Zjl64npyqi1JD8W4BDfMGKunuyr805taZjLoNUD11uyn9Frh9CPmoa28tA?=
 =?iso-8859-1?Q?NM30gnUL28ybEYQFVnsxpnhhFp1tb10q9BSS682fI2SDEhjyYyRZJ1fq1O?=
 =?iso-8859-1?Q?vg7wof3mdDRTCC8d9xOoVk3sKQtYR+cTyZDZl8cu4HiQJ1E6lCoA5lmxIJ?=
 =?iso-8859-1?Q?T9FXGin+Yidq0NAT/VsuFH0tv7tFaWNGtf2DT5SYxhsMX9eYgiIRxsIq4r?=
 =?iso-8859-1?Q?oFDCaS8SylFOqsxRcSGWvQwJXIqNc32B7CIOA/Jd2eihHcnlr381zO31ft?=
 =?iso-8859-1?Q?HyrF6ic0HLm5yL/7T5qqnNhXpcExMGSHXOtDh3HUX9PqEKUQ5WUbqmpMoN?=
 =?iso-8859-1?Q?QNYyOKkh0Y1g7AaCMnnCGoxF0CZldf1vmVONXkTxodthLgkARcIlnvMMCm?=
 =?iso-8859-1?Q?SilF3g0r8wS8sPcxPCj4OCc3rlCs7kUiCd/Su2nR06KQeF7Gh+x9FCc04I?=
 =?iso-8859-1?Q?ARYwtXeFhDKWnjjCtZQSPWNO9tFR65DFlR46tnnBHD7uLxBP+S0GnY4x3s?=
 =?iso-8859-1?Q?r5GjhlQ5ZBtyQ1WPVq3XjCakF6mhxV0aglIjHLmk6stxhUJ6SNjmt2ybmr?=
 =?iso-8859-1?Q?ZIiVCVwQwiGLRYzkxG5vNHycTWNzpdTzL5vfBgzGYeZprr0H74mpa0h3kH?=
 =?iso-8859-1?Q?sJv5ZahVYxNuZcP04NuV8PBxqp/HnMNuDaXj9WmGQEvtH8+z0YkjCdXcp+?=
 =?iso-8859-1?Q?+ePHrfrini26LLQoTIO3mF+SK65RCF8+XfqENhnJgBoCCEgyA6/vCaTyRM?=
 =?iso-8859-1?Q?q8rzb24teM9906EvZ5Bl6WLSY0INwfklmTFAjJ4fjzKpdEfzAfZAvb2SqK?=
 =?iso-8859-1?Q?sCRSSamNUoXBLIc96PaWkZK6juu8aGxhfp5lIwnfWvPrYOYFzax1QcdaS5?=
 =?iso-8859-1?Q?RHtgFGlAhyIlAH9zyTpVsILSND6JrsZlFB0pmAh5lYhT0ahrGxeD4WhsZe?=
 =?iso-8859-1?Q?TuBF8d3fgE5RQm5+Q4soi0Fzc2XfL1NE2CQfTYDZrWPAtHghKOQSVhR8nU?=
 =?iso-8859-1?Q?Kae2Yv94P/yP4TEMRE4yFZsaVDJLaLnlDeAOaTqHVtdBr3feUuxcY1Y7cD?=
 =?iso-8859-1?Q?G4SrpAudqb/DHZI/9dwXjugA32iEUfii9cDPuHVOG7HqE3ZtNxN+J3q8fe?=
 =?iso-8859-1?Q?Dw5P72tBsCsfheUMJ/deua+m4ecBAzeZ4BX9UOpZHM0dxQygmqzJTO0aBJ?=
 =?iso-8859-1?Q?CLAUZ/Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR15MB5854.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DWulMvThLbv1uDQWIkJWBjUf2io3sUJtv6CVkz7R8grXK4fwqFazfdN7sG?=
 =?iso-8859-1?Q?+4rAVBnhUgAzMzyhOi45FXUmhzGQ02JJOocTPg6bS5scs7PhFXFygch1HT?=
 =?iso-8859-1?Q?H2K4rwumMNQ2+izqV00JYPGkrs2swPB8nTPJfKRJIqDJfypUQbRlYnMAqz?=
 =?iso-8859-1?Q?Ax7BL3gEkjWB18+Z5PBHZeNViwGm7MkbrwSSXHYRA1UXBt1n8HRK7wONYx?=
 =?iso-8859-1?Q?rluqrwjzk4TcLiG0B2oHJiwAgLvvhRI7RMXo+XqZS4b0ZVxg4VMDhjJsl9?=
 =?iso-8859-1?Q?kngK060ASG4XOlBtFHwZjBH1bol8DphAB/w4KPNjEXtG+9RE2QRdhjlK0K?=
 =?iso-8859-1?Q?RJWrN83qe5Zgp6i/0zCH9N2RSDyRDXAY+QeW9A1u6+kREXiEvYLVT1Epk6?=
 =?iso-8859-1?Q?7beFH1/qBXownRKLKu7hqpEo4NFrYe4ClyTL7cstuhPwTpiAgtpNF4AEat?=
 =?iso-8859-1?Q?Q58FDh3j9QU7N1zEjEC9gePTTxZ7yfYwPL8+F1pPEpHsRvmZFd4SW1daxc?=
 =?iso-8859-1?Q?f3L+9q94XpcEQh/guyiJgBwkUS6XmQC2wftClVY3MJayI13+ey39EqI0pl?=
 =?iso-8859-1?Q?8G85HgREkdPFY0NNDIYj8eG+pdfi3kXPTxnr31GpWPzCrBfOd7UJoHha+Z?=
 =?iso-8859-1?Q?YkSi3Kh4+hfdos15OmULOUcVBU6RnaD8S01tvi6riRRP0hPDsNqf/E5xsH?=
 =?iso-8859-1?Q?mwBD1F3FqrMMO4e8yt5Na4fMmeGi9AKRS4jKdX2OELhFnwq8ykwztw6s2q?=
 =?iso-8859-1?Q?LXJdHZd0BZClo86D/4Vqxm/F5WRJ6Kc+ZZiHbIUj5qrW1li6Pd4qDnLY9q?=
 =?iso-8859-1?Q?VlqUqIEwXRARvNYhOW+3Z9i/9/tMm4LZV6z1ub33aCQOBxfwiCAlSG4KsX?=
 =?iso-8859-1?Q?qk4J+QV5nC1CJC+v3kwBebGHZMzkh5l56J7ugf4tsb1aW1ppFs3aVRcIKL?=
 =?iso-8859-1?Q?io7m5L2iy9+oJz97qP2ITCQ+KcUQjdvufG1eaWeGmmlzFiVGbA1DQannPo?=
 =?iso-8859-1?Q?5rk24tumMNy/zlGRGYnM0R0GAEFQd8wD4bpx+jjbdUTWpHwJd64DSUdqK7?=
 =?iso-8859-1?Q?7M5zlJ7HeHl4n7XyDFKogxCcqbk7/iWgqgNKfOklF3iYsx3xUVjcp65emp?=
 =?iso-8859-1?Q?lZ5dGghcRo3iuORg4Ffx9JSBdurk0sIYrAMfogUdHTGNwpGeUZ9ZwWz7r3?=
 =?iso-8859-1?Q?vXdx8D7cgmTJINCtJwIG2ODr1OwE30O/2NPWWpC395aXPOdPZyxoqC1vIq?=
 =?iso-8859-1?Q?jOZQA2S2qy/qRjgEFyi9H5viIj2X0E1wE9ZZcYrh1zjGVLYWrSqAL2I/Xm?=
 =?iso-8859-1?Q?Tp9/AdxMR+nVLL3H2Pjugksm60rurh3uFRBbkveoyqg/OFVN5SkC42I0Zl?=
 =?iso-8859-1?Q?RXrnI7SREnV1GQzWwSyp2Mpg2hYXFhPsC7POUdpE/X0pr68LSsQ0xpenk+?=
 =?iso-8859-1?Q?JSEW3Urxl6NOU9xhcM8RxxA6MQPB+z2XZOpy7UXyQv8nwPkYBbV10hCMVX?=
 =?iso-8859-1?Q?uh5eFgLdXkl9txqPHGvY8eupvqA86NPQ1FSY4Ukk2KnNtcrenZiLarsKYj?=
 =?iso-8859-1?Q?7Yxl68iM8ZNLs9LxOtLcim06ezHQwvtVaYLPYIstJ7UHjDQHBsvJnBLnVg?=
 =?iso-8859-1?Q?Bv7o6++Is5xZ3HmG/489y0PP5Yh6KCSojfTrRUYKAYQO7mYh4aKzo7Sg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dataventures.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR15MB5854.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fca0ad-6e7d-4b06-e96b-08dde0add206
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 12:25:31.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b892114-cd02-4067-8489-1b3b2440e1d9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSwkhhbHPNpVsoHHXkH09XVDQnvTDRoYZ0A4pwDi/FEWyDQSP1+pgVx8HY6X+11bt1K9wWgtvycPFzJQrrlgoQ9SoQit5ArHCxq2MiZzOqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3839

We still use it

After updating to git-client 6.3.1, builds were failing.=A0 I rolled back t=
o git-client 6.3.0 and builds began working again.

Frank Thompson
Systems Manager
Data Ventures, Inc.
4100 Coca-Cola Plaza
Charlotte, NC, 28211

