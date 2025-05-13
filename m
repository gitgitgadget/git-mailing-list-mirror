Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2090.outbound.protection.outlook.com [40.107.241.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC282AF1C
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159760; cv=fail; b=RpIVS0frAmkovVTNFTeNwagEMiEixes3KRiucWSPN3PQjKR32VCfkBQCdHjhS3ukDzLuEGRcVbXt0LRAwFBSIm9hvWgHJ6mAT3eRSc3BLi3fw6qXfQ/yLh35Di3d316CuBQxYH6Eb5VE2/IIbDG2oVrQnAxU5aMfdEU169vz3pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159760; c=relaxed/simple;
	bh=EatHPWN7oiedhJqytd6Vie1FHkhjvUIQ3zPShQUJDzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GjPV0GH7KkKGiKtUJEo08Gqoxg4mZJUR99uFygMnX+m1/nQ6XQvd1QBvVltmRQUC+HjLpn46ekPS3sqAuLLtRvJh3NAV5cXMR60iJ8QAMQ8BaHtcUXIj+8qI/bWY4R8mVIT/6LmsUmeMBKu53a1i6/Oj+kj5eZUzLrIUEPIJBkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee; spf=fail smtp.mailfrom=proekspert.ee; dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b=EoET+RfY; arc=fail smtp.client-ip=40.107.241.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b="EoET+RfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWopfdAEw5Nmjw8iApOYYStP7rWhKi9B0CAurYhRep2Gx/mDHwzZuMQao7EhInVitC6XUqpPzHHVagLhLe8E1bO5jpzqxOexGtslKXBinT4McvKJTPf3wkGvVw4G7ApdyMWkt+Pybtvs50ym6h5s2NeYAZaTIpHjNHBN++wwfp+xTZKE8pOX8wVuZPn+cyHPgq32rGJKjuEx5vkxDRae87g+fsqcz591118yHi6hcM+tiPAAXadvpV8LkOtNxjVMckAQlJaBeFk4Xl7ZLzxIPjJWLq8cuqFvuDQrHRsY1tS5F6KtZEW+hwggl6S6rIsJ9z8VRgUw8NbbiI/HyO+IyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EatHPWN7oiedhJqytd6Vie1FHkhjvUIQ3zPShQUJDzo=;
 b=JVapStQ1ASGSn6SLjzZgJ2nYJewkIAp2IYPA1YBq9zYdT0m71FPBx/UIRRNIbpZ5Qc4g9m8a+b/h8K0JTHYiAz5ooYvC/37mzuT0kwf9++Y2u3Bn/OHP7ZGpRp3kRT4FkXrk+FElKzzHPfk5xNxxJNZBF3zVi63YG52KTWdGAYFEc13fyrY+6OynYek4qm98aP+G0FYtJ29dfcjo37LdsQdDo9OnLLvUrBSa9UC3qbKC4iZuZvGWq/uktqNaAv3Xace2QH/RPVBnvmZXlGheHuHLU+oKBrnj3Mn41dp27iMWQGZk+EcT/C+Fpz9rDmMnTWAvY7whmQ2upI9wtqhCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=proekspert.ee; dmarc=pass action=none
 header.from=proekspert.ee; dkim=pass header.d=proekspert.ee; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proekspert.ee;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EatHPWN7oiedhJqytd6Vie1FHkhjvUIQ3zPShQUJDzo=;
 b=EoET+RfYn/YyPJJJcDxdRVI1WNpOpGJXdhqbu73Tsk+HtTEvro8y8C2pML1imnJNa9Tkd/Qy9gYa63lSwa9qpa6DZrsTMnDH9YFVP7RN0H3ZBgRST4yEm10qFAFFS/8PR6MaZpWHEfUiOHhVafAwkNPhpg0LBRW7TwP89AhvEuE=
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:539::16)
 by DB8P191MB0904.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:165::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 13 May
 2025 18:09:13 +0000
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a]) by AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:09:12 +0000
From: Lauri Reilson <Lauri.Reilson@proekspert.ee>
To: Eric Sunshine <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Possible git-gui bug
Thread-Topic: Possible git-gui bug
Thread-Index: AdupPkrODeM5biBoRQ6P7hGlivxuEAAR54MABqEe6uA=
Date: Tue, 13 May 2025 18:09:11 +0000
Message-ID:
 <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
References:
 <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
In-Reply-To:
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=proekspert.ee;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P191MB2174:EE_|DB8P191MB0904:EE_
x-ms-office365-filtering-correlation-id: 6e51f038-03e1-4895-4581-08dd924943aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1Q1U1VTZHFQbWhaNFM2N1B5TXpzSVdkbkU1NjBEcGhXQ01QTjBGT2hVY2NS?=
 =?utf-8?B?dG5admQvekdiZGYyOUJ1TVZKK2tja2NOem84aG9ZODBqTHptL1dOdGorbDFF?=
 =?utf-8?B?RkpXQXNNM0d1VWZQM0h1dUt2VFFmbVRDc3oxNWhFMG5LY3hXNk1OMGZ4TGhY?=
 =?utf-8?B?cjdyNGpKK0lwSFJqV0Q5dS9EWWVNR05lTUUwNElPR1JxRUpnWXIraVJsUnN0?=
 =?utf-8?B?YzhDT3lNRHA2YlNZSERjdGdCTXloSHlhTmJueHl0dDhPa2tJM3I2bEVwbWww?=
 =?utf-8?B?UTJEbWFnK1pjVWgrSFVBNGlLbEZ3T1ZFNE12cGJYeDdjSG5UZHNXZjVWZmJH?=
 =?utf-8?B?c2tDM1BwUThhZGJnZy9oWmZSNWNQSHYwY245MUpteFZWdHluMzJwblM1TjZE?=
 =?utf-8?B?clhSUXJDalZpeGxwdkNpSW1VK3FGK2pDN3lWM3VIRGxicnArcmRieWdPUVkx?=
 =?utf-8?B?amZTazhmRXJid3d3eWQxaVFlZWVvRlhwTXIwQ0MzTDg3QXN1Y3RNT0FWUk5C?=
 =?utf-8?B?Zlh1azlaMG5LZmNYTjBVR2JyMGc5emQwampMcm5WbUg0ZnFiblV6SGFaWkJl?=
 =?utf-8?B?ZVM3MFdEc3JUUHRZQjllQk5pVy92UDRnVWUzVU9XRXJsbkFyZS9SZ3hoY3pD?=
 =?utf-8?B?YmpHT1ZuY0ptZlZTRnlUelRFZlg4UzBYaXl5UjlycnZOK01KcGcvYjlKMTV5?=
 =?utf-8?B?Tys3S1kwd2RYYUxNUWh1S2h2NzV0bExWRFl2dTFEeVVqZy9IT0h4S3dGRnFK?=
 =?utf-8?B?SDZRemxIQm9ySnhDdGNDc05sa051RWJmS3RzMGZSemJSODRXVEdaQ1FINDBz?=
 =?utf-8?B?dGJvM3o4UWRmZDZ4dWgzTmY3WjErNmxEK3FoNHA4bXJZamVNVUhMZm5BbjBI?=
 =?utf-8?B?b2RxWEF5SGd3bDI3cTJUN3pwRXo5ck9TVFZsNHMyM0tnVFZXSXRUWEhRZlpl?=
 =?utf-8?B?NmFQU1d6MkdieURqODJaOFR3OHFPSUFxQXFoZHNuQjZwL2hwNUh3ci9ITXRC?=
 =?utf-8?B?cjlWV0RqWkFvdGFkRkFCSGVxSjZ5M01EWVovSnFqK1ZLaUIvZVpjU3FRaWI3?=
 =?utf-8?B?ZmVjUUZjTGRCMXNsQjc4TlBPQW0yb1o4MWNEUUlvdGRpUFVSeExVV2JlMVNB?=
 =?utf-8?B?djZaZzR1Yk9DaFA5UGErbTg4OUtleXpxK0RMR3crdnlicFo2YTNYZXFwdGZD?=
 =?utf-8?B?OXFFbkpNUnVENnNLRlFUSG5MK2J5dzZKRnhRQ2hIT0lHSmdzeWFPZCtBSXVI?=
 =?utf-8?B?bHIwUmhRWXZ2R3VFQ3F4MnpjYnRCaFdpUWZ6Y1lUNENPYzRnTGd5VitYajBn?=
 =?utf-8?B?SjJQenlTc0J6ZFRoamlJUlhreVl0NCtWMVlkRGNTWU5haUkzelpQQmNoOTFM?=
 =?utf-8?B?b3hOZEZReEMxd002MHp2ZU1heE90dFN4MTFQeGV4Mk1sS0xmTk9uZFJtcEI1?=
 =?utf-8?B?c1NwRHh6cVkwNVU5dEhpZnRIclR5SmNkcnY4bVpSY1d1NlVETGpBYzVCVSs1?=
 =?utf-8?B?S1pMYTNGaktpM2RmN3B6R3FEMVloWGh0cHVESHpQL0VGM0s2YzVwSWQxQ3Z2?=
 =?utf-8?B?cGJPUTczY1daZzhtSTFmTTJhT29DeHVkVHZva0xYdk05ZlZCbzB6ZWVXYTFy?=
 =?utf-8?B?Z3Nudjg3OXNxY1orODYwZDFqdlBiWkMzeVlENHEzR2JuYkcrL0g0M2xEMHNv?=
 =?utf-8?B?NzJNaGVld0tMcXluRllaUDU0aTZGS0t4MlNkN210NVFTeVNXejkxaU0vYWxM?=
 =?utf-8?B?RVBFd0cwUE9pQTF5MTUxQ09HV2gyODErSmxCdGFPWmhzbE8wKzA4RUw0YlA5?=
 =?utf-8?B?eXBFR20rZGJ1dnB3cS9TV3ZkWEpKNXVCbHVOcC80Q0NoSXNVTWl2a24rV1lh?=
 =?utf-8?B?RjY1RHdFUXhJa2dLN0pMbmlodWJBWk05STZCK0xtU3dFb3Z2bGorQmdlc2ZO?=
 =?utf-8?B?TXd4NDdrQ0NwQ0lmWFNlTTBTSEloNVBxSlA3WFNEWFdieFdmQTFISkkzVWFY?=
 =?utf-8?Q?q3JCRCyHV6KQDfI9YK3D4mHXVWVzsE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P191MB2174.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bSs4amF0eitVOW9pcVF0dTA0TlZoMzVCTmtqVjZDeFRhQ29JdWlnZUNOOFJZ?=
 =?utf-8?B?VlpLTjc1Rk03ZDhvYnUydXY0ZnBMbGpTcE5udGZ5R00rUEpQMkl4MWZwc096?=
 =?utf-8?B?SHgxK1hSbHF2aml2RHM4b0ZIVHJlZ1N6ZnVveFRtdnhTUC9RTGhuWmN3bTVp?=
 =?utf-8?B?SE9JUTdTV0Z6ZWxqKzFNREJzaDVRZDd5T3RZYnhRRGJYbHBBUGF1eExab25n?=
 =?utf-8?B?TjhXQjRMKzVPZWNTUWFFNHF0RW1ZbE1kN2VhMWcyblkrWjB2NVM4S3hhdlpK?=
 =?utf-8?B?VitQM0tKQ0gyS1JXZTJYaTdPYkl2ZVNBclR4Ui80bWRURHNGN2hHbGtyN29s?=
 =?utf-8?B?b29ta1psTGtyUGtGRzBIZGlTR004U25zN0dDbGtacXl4eEIrdjZoWlNLNE5h?=
 =?utf-8?B?V0JaSHZsQWpZSVFOL1d3dzhpQWMrQlZWM0MrQ1JMR3VGajVRRlpOeEErazI1?=
 =?utf-8?B?eXBJQWxsSWo0Z0QxYUdyQ3F4UDlEekdRTGdDUVZEZVRTclZTV2psOTRmY0o5?=
 =?utf-8?B?SE43SVp2d1phbzdNVFB3bVkrNXJYS2pWdmtaSENZWTVRT3NCR1NEYU1HOHFx?=
 =?utf-8?B?aXdwZWNhTjRJMU9IOGg3aGk4NTRLanZoZjE5VzlXSUtiQXJkajVSV1N6eG9j?=
 =?utf-8?B?bnFaZzdyTVhMcnF3WUVzNU1DSWpSekZMWklxTWRabzF4ZlZzMGQyUDY0T2VO?=
 =?utf-8?B?M3JXNVF3L29LalNESE1tNEhNdFJOejV1ejM5TWZhYVR2Q3ErYWc3K0luUk1P?=
 =?utf-8?B?YTVkbmNzeGlPWllQVk1ZYU5YaFoyZm4rVVVGQjg2MzZGZDhDSS9mWHFYTHJx?=
 =?utf-8?B?Q21vOS9vaFhvTDQ2LzVYUkNMSjBSdVdleWdvaDFLOUg2WWRNZWI3Z29CYStq?=
 =?utf-8?B?ZFlua1p4VW9XcUVSNS9ESGZrR0FqL25TaDAxQnNFMFFsQ0FjNHluWkZ5MkQ5?=
 =?utf-8?B?NzFaT201L3l2dDIvU3M4SnpsanNyYXlwQ21QZ0F3c08wOFM0K1FsUG1zWlEz?=
 =?utf-8?B?MlZYWE5tRE1CeDNrR0FlQ3lqMG9nWW5MdXo0M2w4THZVOVdTZEE0TnZ2U0pt?=
 =?utf-8?B?cXhiUnR4N2kySmJ5ZlprYWRscXpadVRlSzU0NGxPYm9DZVNDOXM1MFgzdjJP?=
 =?utf-8?B?RUhPSXRBb3MwcEhORXRNTGVPa1RzRU0zcGVpZ3lpd1JSZUNiNVVPKzdqbGt6?=
 =?utf-8?B?YWFUZkNZYng2bGZZdVVoM0RzeDhFUXJyRXJiYUNqZlFNaVJIVmQvMkY2T1Z0?=
 =?utf-8?B?Rjg4a25NUXhweE9MV0Z2M1Awd2xUVExGSlY5S2dQVXNmZk4wYWgrRVFMWlox?=
 =?utf-8?B?aDR3djFYcG9jT29adjNJamh2OG5VQU1DcUlsQVBFWm1MMTdjUWIwYUFRa0cx?=
 =?utf-8?B?YkN6aGo4bDlaQkh1Vzd2YVQ3L1hKWEIwa1Z2bHVQUmJYY2pZTkhjcjUwZ3lU?=
 =?utf-8?B?L0F6NzhKVnkzdG5YNUM5RU10ZHQ2cEhITHhTZjNTSkdYY01RNTUrK1NFcU1F?=
 =?utf-8?B?bXlMLzdJLzJDd3dwcGJzN1hyc2dBNUkzbktCUFlCd0ZvelJEUjFjMEdkdUZL?=
 =?utf-8?B?QW1UbXpQTmdEMnhyd096bVlVQUxQZUVlOU1IVVp0b0o5OVNNU0h6V3hTM0Nl?=
 =?utf-8?B?QkF5SHRqWmpFaGJ3N0JkU0lJT2tmbGg4bDYyV25ncVdDK0FCMWV3TVdSM3pl?=
 =?utf-8?B?cVhhVHhIa0xMNmsrbUhNTzdXTTRaeTBVMVF2NElkZitmYTlqTUdQMUphNGlM?=
 =?utf-8?B?UDNKYTBxSDlYdDNBY09wcXRBQTM5aGtJMkhPd21yc1hqRUZKOFBzb1RrNUVE?=
 =?utf-8?B?QUJTd3RxSlFCV1dGQnhDTHl6ZEtjV01OODlabU92NG9OWXFaQlFVc05LYStC?=
 =?utf-8?B?YWZjaVRROEhnYUc4b1I3UUFSd1dUdEptSGEwUWpDaGpLTU1sZnh0M3JCL2ht?=
 =?utf-8?B?QUVLVDBqcWwzNWoydVprSjdqamVCbS9NcjFXQlY1NHpBdGVWdG1NSEpsd3NU?=
 =?utf-8?B?S2xVb3g2YW9GSnJNdHRTenFIRlcrVGhwL0p4bmp2TFhxZFlhRmNnODRNT1dT?=
 =?utf-8?B?d3JqMkZDbGc5WnZHY0RhOTF4ZENxMnhiQWZHMUU2ZVhiTHFTOVh4UHFJa2xO?=
 =?utf-8?Q?k17rLbnhJRJ6y9UZP2uuppj/Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: proekspert.ee
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e51f038-03e1-4895-4581-08dd924943aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 18:09:12.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4fc69ca6-ce6b-4059-8ad9-2049c3c135b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYinnQ6nG8/3pPyzjX2MkSjhARandZoP2QkjM9V6+PbYN4V3M1XzcVZwwf8wRvaxwRobOh5B1vgWIhMx1CGnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P191MB0904

SGksIEVyaWMhDQoNClNvcnJ5IGZvciB0aGlzIGxvbmcgcmVzcG9uc2UuIFRoYW5rIHlvdSBmb3Ig
dGhlIGluZm9ybWF0aW9uLiBVbmZvcnR1bmF0ZWx5LCBJIGRvbid0IGZvbGxvdyBxdWl0ZSB3ZWxs
LiBJcyB0aGlzIHRoaW5nIGdvaW5nIHRvIGJlIGZpeGVkIG9yIG5vdD8NCkl0IGhhcyBiZWNvbWUg
cXVpdGUgYW5ub3lpbmcgdGhhdCBJIGNhbm5vdCBtYWtlIGNvbW1pdHMgd2l0aCBnaXQtZ3VpIGFu
ZCB0aGVyZSBoYXNuJ3QgYmVlbiBhbnkgdXBkYXRlcy4NCg0KQmVzdCByZWdhcmRzLA0KDQpMYXVy
aSBSZWlsc29uwqDigKLCoFNvZnR3YXJlIEVuZ2luZWVyDQpsYXVyaS5yZWlsc29uQHByb2Vrc3Bl
cnQuZWUNClBST0VLU1BFUlTCoOKAosKgU8O1cHJ1c2UgcHN0IDE1NywgMTM0MTcgVGFsbGlubiwg
RXN0b25pYSwgRVUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEVyaWMgU3Vu
c2hpbmUgPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPiANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwg
OSwgMjAyNSAxMDozMSBQTQ0KVG86IExhdXJpIFJlaWxzb24gPExhdXJpLlJlaWxzb25AcHJvZWtz
cGVydC5lZT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogUG9zc2libGUg
Z2l0LWd1aSBidWcNCg0KT24gV2VkLCBBcHIgOSwgMjAyNSBhdCA3OjEx4oCvQU0gTGF1cmkgUmVp
bHNvbiA8TGF1cmkuUmVpbHNvbkBwcm9la3NwZXJ0LmVlPiB3cm90ZToNCj4gSSBoYXZlIGEgc21h
bGwgaXNzdWUgd2l0aCBnaXQtZ3VpLiBJIGFkZGVkIHRoZSBnaXQtYnVncmVwb3J0IHRvIHRoZSBh
dHRhY2hlbWVudC4NCj4NCj4gPiBXaGF0ZCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBl
Y3RlZCBiZWhhdmlvcikNCj4gRXhwZWN0ZWQgdG8gY29tbWl0IHVzaW5nIGdpdC1ndWkuIENvbW1p
dCBtZXNzYWdlIHdhcyBpbiB0aGUgZm9ybWF0IDwjdGFzay1pZCBtZXNzYWdlPi4gSSB1c2UgIjsi
IGluc3RlYWQgb2YgY29tbWVudCBzeW1ib2wgYXMgIiMiIGlzIHVzZWQgYXMgYSBtZWFucyB0byB0
cmFjayB0YXNrIGlkLg0KPg0KPiA+IFdoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhh
dmlvcikNCj4gR2l0LWd1aSBnYXZlIGVycm9yIG1lc3NhZ2UsIHRoYXQgSSBuZWVkIHRvIHByb3Zp
ZGUgY29tbWl0IG1lc3NhZ2UuIFRyaWVkIG9uZSBsaW5lLCBmb2xsZWQgdGhlIGVycm9yIG1lc3Nh
Z2UgKGZpcnN0IGxpbmUsIGJsYW5rIGxpbmUsIHJlbWFpbmluZyBsaW5lcykuDQoNClRoaXMgc291
bmRzIGxpa2UgdGhlIHByb2JsZW0gYWRkcmVzc2VkIGJ5IFsxXS4NCg0KWzFdOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9naXQvMjAyNTAzMTUxNDA5MTMuNTc3NDIyLTEtb3N3YWxkLmJ1ZGRlbmhh
Z2VuQGdteC5kZS8NCg==
