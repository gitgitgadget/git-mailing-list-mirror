Received: from mail4.state.or.us (mail4.state.or.us [159.121.109.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD519DF80
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=159.121.109.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929693; cv=fail; b=oI7HN9aMliQkTM5mh7auQWzQYFwFzAbqq4RVuO3j5m79TdLejiX1OswK4ky4F1dHQdHuKZka+sft3wNhFdTKIoJdIuV5AYTEghnJRm2EnXbb08gH8NdHASG6tm0ADpfvlBu7u/ci5b2AMWutaFlVrfEP05tc7t1C3hqQ4q9e46Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929693; c=relaxed/simple;
	bh=hsYnTmxBHoJmvSMTyjrp2AR+KlTfK5RFKsnoZ4s+fMk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MAmrDpAk3dDQTdHs0ams6kAnHfCVjJqL/HYp8b8r42hE7YKkjLX+WI3WiEORe/G+WnfQ62pf+vCPmQ80BNzPmPwyfW6XRNmLtOh8/qAopvbnJWPzYVqIOsN5gPUYwkjW0weqtr2SyFSsb+3WMPwwKabhXQ9znj8lBQtgR4gRLzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dcbs.oregon.gov; spf=pass smtp.mailfrom=dcbs.oregon.gov; dkim=pass (1024-bit key) header.d=dcbs.oregon.gov header.i=@dcbs.oregon.gov header.b=ug3F9WgN; arc=fail smtp.client-ip=159.121.109.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dcbs.oregon.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dcbs.oregon.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dcbs.oregon.gov header.i=@dcbs.oregon.gov header.b="ug3F9WgN"
Received: from aspam2.ets.oregon.gov (aspam2.entss.or.gov [198.177.17.224])
	by mail4.state.or.us  with ESMTPS id 46PHc6We026090-46PHc6Wg026090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 10:38:06 -0700
Received: from wporgexcl11.ENTSS.OR.GOV (wporgexcl11.entss.or.gov [198.177.16.66])
	by aspam2.ets.oregon.gov  with ESMTPS id 46PHc6IK010610-46PHc6IM010610
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL)
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 10:38:06 -0700
Received: from WPORGEXCL12.ENTSS.OR.GOV (198.177.16.67) by
 wporgexcl11.ENTSS.OR.GOV (198.177.16.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 10:38:06 -0700
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (159.121.201.68)
 by WPORGEXCL12.ENTSS.OR.GOV (198.177.16.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 10:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqxn/PAJ0tJq38NPwzvguPitM7NJzwqd7a5DxyhkOmU8IDGWQzhapoO3H90JDyuurKqF3mS3K+CYLicPSJODkte+C6bF1bwEZSCL0xv8WusiLXS0pf0aF8zYHo7l7YOA8AKti8drxBocTGFtAntX+EZzTvYjtQo4h8QV0L4SZECPWbGh/3wU+PktP8MvO2/IgPHEbnUhzgbgTqms7NjY9Khl4Ukh3ENHXhoWGyrg6Oomu4RlFmRGMfwUDcS5TEKfcMYaPfWnoTTHetIrEwS/m14RnYsfOM028dVeKC8hPsn+hmtYhHChplJ5Kru/V2lZrduH+gmokfD4fv1wr6dAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+VmdxOwxYzfZqZGwnK059WGaP+tbrHJxkgD/21Le0k=;
 b=Rp6TLiArHQDsuwlZPucU1/kO4mnWQwxVYsGU704PACuzPYDMCV/TOpHn+m0nfxB3tfq88fC3XUwi4x3FYoCNcegcG0jLDhLN0yq9m+LqUH4Qf7CQnkrtFt+cSjz5nZ5LQyBqaA5cGrF1r2TeBITpMmeVKQ4T3foTEHwXcrKAAQd5xInz+MK7kasWskfAQNbKXsYiGc3odJlnUvj6DScm+c5udS3xcgZ+c3qg9sFVMb4aVgvB58LJVW99RCpGNrTERloqDAsZyYnzBvgvqmgKhJwYwIVSdH1ZAJl6V/R9HUTwl2Ctfwt5oXiVt4o1TeJr4xaz64dVvguOcI6fi+DqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dcbs.oregon.gov; dmarc=pass action=none
 header.from=dcbs.oregon.gov; dkim=pass header.d=dcbs.oregon.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dcbs.oregon.gov;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+VmdxOwxYzfZqZGwnK059WGaP+tbrHJxkgD/21Le0k=;
 b=ug3F9WgNpYMvlvBthl+XluOS/YP9yQNarlB0NbpNmLSLWWleBOP5gXBTt+7amE91n1PBS/duXADRYjb6d0cHcPo6JRHox0GHVDTAmBv1kSWP0Xf4w/BsSkKGgKpkqBftnIZwsEBgl0aBKqbas0MB+3Tjm36k7oAKibc8axC+jes=
Received: from CO6PR09MB7381.namprd09.prod.outlook.com (2603:10b6:303:cd::8)
 by SJ0PR09MB9063.namprd09.prod.outlook.com (2603:10b6:a03:445::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 17:38:04 +0000
Received: from CO6PR09MB7381.namprd09.prod.outlook.com
 ([fe80::b984:521f:7ee:c9f8]) by CO6PR09MB7381.namprd09.prod.outlook.com
 ([fe80::b984:521f:7ee:c9f8%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 17:38:04 +0000
From: PEMBERTON Brian D * DCBS <Brian.D.PEMBERTON@dcbs.oregon.gov>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Technical information about http.sslBackend schannel
Thread-Topic: Technical information about http.sslBackend schannel
Thread-Index: AdreuII2JsKxtCWFR9KQDm/uANjMVQ==
Date: Thu, 25 Jul 2024 17:38:03 +0000
Message-ID: <CO6PR09MB7381B7819CC314C878A73FF2E6AB2@CO6PR09MB7381.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dcbs.oregon.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR09MB7381:EE_|SJ0PR09MB9063:EE_
x-ms-office365-filtering-correlation-id: aa5442ab-422d-42d6-5821-08dcacd0897b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AsNfpBXy8uvJGLyuigz/fyHKbC4yCtdMRC1fTIIAmDaVfQmbWnCpSEU5P2Ix?=
 =?us-ascii?Q?y/09tqyVaaxp+ZjBvGR1RBWdJl4MhQt4w75Se92Ms+4S0MVtfOPDdfNC7Ozd?=
 =?us-ascii?Q?vul85Pn73P3WBGf/rC1isoOcD83xMympdPDTlOTYreZgwm7HiKzkjrK1EeJR?=
 =?us-ascii?Q?tW9zX0u8d6tg3pilRXa17LtkZY08oRMHLGXDQSEQGNaZwlDixQoN+abMuOKT?=
 =?us-ascii?Q?/6XM3nSJa2+xVDuS8uojhh2wYCS1op3lv0TpVYNtGjKLrmgdC6JqVJFV2Rsq?=
 =?us-ascii?Q?JGYVrnS/LxNVQVyADNPvbJlNmTPzwYj+6IFuN+mftc+indRaRaFGnIfAPYkO?=
 =?us-ascii?Q?8X+VtM48tA3kW7PFtpNqszK+FpARwbZXIffcoCLkIH6Cd0lqccmTCTgAHgj+?=
 =?us-ascii?Q?PQYP25BweL11tdDxBjNxibxtidbuJ+XU0MUNIfyq54gQdXZfrKNRNRlFzQ6U?=
 =?us-ascii?Q?VfagyrbVtQJwvS54LYpD0QyKf2T29N3YL38YUswRhYdkV6uxFZzY5xnZELLi?=
 =?us-ascii?Q?SBC8K+NDpu2wWcfYQK9LgFFepPeVfhm9ZTbJF/RqNBO2JxfSKXqjuXdpugV5?=
 =?us-ascii?Q?SbuJRqErEHasZDRDK7poTCb/uOqcNC3jCuyooxhIq0/p1QKGxdS0vDpdPsKE?=
 =?us-ascii?Q?UMX2x5wf1ptfpXHgb/Q2ZwzcA+LtYtNG2VRZjW2dMLUrltR3XCQUGztw1OVk?=
 =?us-ascii?Q?8b+NCZztUDgvjeFj6qSclZbJ1QIM+EAMIuySoup7xr6Rwg8dscB5v5L53q4K?=
 =?us-ascii?Q?E2m807BZeo0afMelQZxJv3XeZxRQsHLRgRGeHnYJGH5st4mUKQYTQ6Hygola?=
 =?us-ascii?Q?sTVTdhPxE8AD5rWyg9veWJfLEkb34jBM49gyKMqPloHypxupd1Du8OO8K4G8?=
 =?us-ascii?Q?T4B3UnX1RAjtni6t9XN6lvFbaRwIjrJnJD2TjCzsoWVxzK3n7Q0qYQKQnUlT?=
 =?us-ascii?Q?2ouA8KCw4eSvN6GxbCGcgckwuukAB0Wo5CxSJ4AHBRsyCpZin8K5BPfzE3Yf?=
 =?us-ascii?Q?RBtl/bLhRkgI3vu1OPUz956AkjLXAdSMmPcSSObtB6LGU9R0L0kyFI4pZAG4?=
 =?us-ascii?Q?15tQJh/JT6jzn6avoKemYZsfrXidDsBvylaIapeeAxDjLaPn8M3RRl+b100e?=
 =?us-ascii?Q?PpnO2nE/mh5dQxOLqEyhvVejAc/oF4K8EtvtsMYyZJDHLAqgSu57kqAY0cOh?=
 =?us-ascii?Q?H9om0VwCVCQ7acj3CcJiEJi9G6r+qTqhN3YEpUDUCPfJ7QmBnxvK2bOGUEag?=
 =?us-ascii?Q?DPiuYejA5KXkZKyVPK3kLRLk9HA6hTE+770RQfLDxMJHHFV7H3OGmIDH9tTB?=
 =?us-ascii?Q?07n3Pkn5JoVZeROFoy792gHL6wikUdqCPJy/dG5taNr2df301j2qEY8ovIB5?=
 =?us-ascii?Q?Kg5JpIWrM9xh62ZFJvs7Y8lrXP8+k+hDGowZOZiwvzGWKI3Q0Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR09MB7381.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IZF1A6OzVNjWfZN1mzmSipOhJbv9TeAD77aQQIYoyZyQM1ZDwhs9Kid433PG?=
 =?us-ascii?Q?9wLQZsmFBMpJn2T4FXC5hueQ60KpDhuNqMWajj7H+muxLoJIl6gry1Qfs7qr?=
 =?us-ascii?Q?9LkWR+v6ydvNS60vhhDtU5I9S2xr4o0rxfVxEG4rGaAmYancWLPNIc3nGfLY?=
 =?us-ascii?Q?XCeAkIyBx+OJbiYOPejErF9VJj8yVqiozS8FRi69GRV2EfAh1j7PAQdjj4Pl?=
 =?us-ascii?Q?fUeRdUUNEwv1hGRi/PVmLgBusAMRPGsxJWzSIc+kILUHvUpe6HX43PzCUot1?=
 =?us-ascii?Q?T5MmD5y8AWO3JPLmIrslZEcgoRDrdUbpsYrZ4Ox8AWsR1xl7UXv/0mujUSpb?=
 =?us-ascii?Q?GWUUXMulbeSRjSOWdVOMswejhG1MzRLBURYaV7lLVwpAxxwuaCT8UmlRJPxs?=
 =?us-ascii?Q?ocSnQD7Z7KCulY6t+dtThinXnI3Ve7qcM4NWPKVBFg1opxNaRmaIlJ4p2Iez?=
 =?us-ascii?Q?K6gWtfu2tmmGyrLqgKWSHj/It6vf1irXM5amc2QzUD1dAlPcoPFycTcfj49F?=
 =?us-ascii?Q?xLAh7pJJ6BpambnIgK74xFw/khefkC/q/evCuZcg9FYc48zOir3dhvaIo0yQ?=
 =?us-ascii?Q?NI7rDe0MbW1UglcEUQwRFhSIJ4pJ7Ng25O8r/8DZ/DWD+7FgSrgEgRJbAn7m?=
 =?us-ascii?Q?qc2YQ1yKP5slud3/8gEydp7BayNgxTTUkd7QOdSZ5vCNmv/4nbwpyeoajEDo?=
 =?us-ascii?Q?Xk5jaZ15E0LWVVP4YnZvS5gjoPtczqCBV4S4CNjBtwbVdkgp4mL8KTGQNpzg?=
 =?us-ascii?Q?N/0MhKNomBtULO2Sw10zUfaM0K//MkRYlqyIAyVgqi398JMetB3zS6GSb7ti?=
 =?us-ascii?Q?swW3E6qCsTguyBji5mf1HXI0eRMBbesjYKeV7uFUD4oQnwQ3hkO2L1DPy/6H?=
 =?us-ascii?Q?AYN/lRB/BEfPt7I8se0BrUti3sjLBEwn2FUK2Xw0FluEyRPqMezqNLXlr1Mn?=
 =?us-ascii?Q?EsyQfuKdAJh1y+4qeJOnRWys1185X8hhVVDnc8kOEA/Y7Z8Tc8D9yA+f9W2i?=
 =?us-ascii?Q?auaM64KBfFIHEoeemgZVYs/+vwv6CwKrrcAuumBI/TePrrteAta0p2/WtcC3?=
 =?us-ascii?Q?zZ9Bd8p76julrrAI396iYUMnwwhmdE/GPaoIr2psUMAypnK1GGrxxsmEmw06?=
 =?us-ascii?Q?zN9t5ecx4WmX//cJQMj/XVQ3KpijCcKbJRoAuUsF9lz0zu4iqtb2PzCwx60T?=
 =?us-ascii?Q?4R/dil/iM+FacqkRBY1x1IP43Dz7NGx7LJXcqufV6tLbyZZwWwL7r4PFblkW?=
 =?us-ascii?Q?0RFiGnItGaW6VJK6/SnjeCBQSNglRGlyXx4xA12OxovoxESohmZbxukJeJw9?=
 =?us-ascii?Q?0qZcNPUkK+N7JQInEi0sWxz5ZqHbL/B8A5uiKPtIkB8y/2kZmAhWdatkNnFy?=
 =?us-ascii?Q?QFDjRqi8sr2RAh18OOtvkBxc9Orupbw0e+aJNXLFaIlkUpzhHopiU1PAjuxd?=
 =?us-ascii?Q?EmMv052QLdVTgD9UgOTMliRUXX3N+ImoohPYr5HYEN+g3m6U+YRxYoobRJnS?=
 =?us-ascii?Q?Pnt46e882DqTSQIDH/28AlSAygl+jixFJ3HBRYiqfVTEoKwMkOvgc5wjtTze?=
 =?us-ascii?Q?wwMfyXzUfLc83qlmyib2xl+IZxt+pIbltT9c6Am/YaDkDNet7LqE5IJSF3/p?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR09MB7381.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5442ab-422d-42d6-5821-08dcacd0897b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 17:38:03.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aa3f6932-fa7c-47b4-a0ce-a598cad161cf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB9063
X-OriginatorOrg: dcbs.oregon.gov
X-FEAS-Client-IP: 198.177.17.224
X-FE-Last-Public-Client-IP: 198.177.17.224
X-FE-Policy-ID: 3:3:5:SYSTEM
X-FE-Policy-ID: 2:76:1:SYSTEM

Hi,

I am in the process of migrating our SVN repos to Git for my agency.  Our i=
nfrastructure team is requesting to have more information about what the ht=
tp.sslBackend schannel setting does than what it stated in the documentatio=
n, as it seems necessary to connect (clone,push) to our remote.=20

`
http.sslBackend
Name of the SSL backend to use (e.g. "openssl" or "schannel"). This option =
is ignored if cURL lacks support for choosing the SSL backend at runtime.
`

My understanding is that it enables Git to connect to the Windows cert stor=
e, (sorry if this is windows specific, I thought to start here, sense the s=
ubject is SSL)=20

I wanted to reach out to the mailing list to see if I can draw on your know=
ledge about this setting and about it's technical details that I can commun=
icate to my infrastructure team.=20




