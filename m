Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020003.outbound.protection.outlook.com [52.101.165.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEC4D9FD
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753159; cv=fail; b=AEsB502dLGc5UZHp+ZVjfHuiUgU5ehDP6365aqVB6LGA7rlcHEMFeBv5nKTflHSIDzIXX8z+7ttiGzaiQOujqYkW+cHvKb2IfpdYFRb4mfQSwrmY1pYRXIc/JhwfPW/STTXcq7jUpR80S9DoM0qcpvgvL3Vnz4YIY6OQX518F3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753159; c=relaxed/simple;
	bh=O59KLgiIgpefS1nztEaSI0SnDnjfElEJ+eXBZ1/tLhc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wwbr639FTx9xYQmXbdV/+BP5pCGnSj+BYplOek4mIZ7ZDFdu2H6duac9DX0PhuOKgjLgu+H3qHlcW6emeQkudW0QJdzPx62yZiK48bU0PGHmuQp/NPb9O6JfpehI+wBxDrvh/sEhDyojyfvVjoFBOFapSaXrTzuVc78qzLWxDrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lebasic.com; spf=pass smtp.mailfrom=lebasic.com; dkim=pass (1024-bit key) header.d=lebasic.onmicrosoft.com header.i=@lebasic.onmicrosoft.com header.b=DIIdvFAh; arc=fail smtp.client-ip=52.101.165.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lebasic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lebasic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lebasic.onmicrosoft.com header.i=@lebasic.onmicrosoft.com header.b="DIIdvFAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIiJoJ47359VZL1wL43n7s380Qt5XTPl44QqT6uJLdJvwXrZzzmvutjmB2h1lB7kPoWM0TrwExvvfBSxfxcj5Uh4F/5KXN+MGpIjG4XBAjlp0C56+WEKJmJgykEOC5RyNoov1nXGE1Th3JaSuwquhu4PVZqGoVAgCgLAh/zHf70gYjd7ftvXXE3H55v0UEZs7CGlx/LSl/9x28WiVlss5aav2QRt4in+56TqQylkqxYVXfutHxNs1b97qq133blSx6haxBHSITYrniG7nnkwJJ9QZq98/ya4qgRSPHcAoX72PGQfnLI0sKI8Z6Qh6VMheOma+hHnVh/GMqipmRsyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIY+OIwuISzbeWRN9O80iajD1RMK+mCgCdchd9kEQzQ=;
 b=JeuFVYTJYrb0cBatTY4ZSNCNsekl+c1bFGIrGfeTVkxnwNd2RnAk5wMwYxKZW1G2948wocsqpfprVjpIO8wOFIJ1T3KB848B5ErbBjXyanoN7v2VPTCaUacH0yGnyd3Bp0Ee5fNRqApEOpay4UMnZR3uFNgI/2+Q1lsTpfey6XRxE45XcS7dsuT5+vf0l+QBEp8NX1QYYhbdgeecITZsV5fPXm9ze/YXGElxBBaALFL6jRTCmOETiFp4EByEaZprylwurp6qEBqb5RZY7yDxNOMTboDQIQMpOBtKbHwM3G15SEjQ4TU9AUtgn5uloWZrtlX9SlryLAgQg+cEq3JVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lebasic.com; dmarc=pass action=none header.from=lebasic.com;
 dkim=pass header.d=lebasic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lebasic.onmicrosoft.com; s=selector1-lebasic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIY+OIwuISzbeWRN9O80iajD1RMK+mCgCdchd9kEQzQ=;
 b=DIIdvFAh3493btGQeQwI89vthEBi+tRqEJD4KYJUI7hnnMu6jH8RJjAH3jV7b1x/HmbT6NaVRvX6rLkHFnGNImJoHZ4xrZmx3ukHufnLJEDA7DNtTRcNrNeiWyJjf+hK5QjOtusw1TVQw8LSKkCvpK8xblpr1xJ63X4g0s/FExE=
Received: from PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::22)
 by PR0P264MB2010.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 16:19:14 +0000
Received: from PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM
 ([fe80::694c:54e9:fe37:91fd]) by PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM
 ([fe80::694c:54e9:fe37:91fd%3]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 16:19:14 +0000
From: =?iso-8859-1?Q?L=E9onard_Michelet?= <leonard@lebasic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Spelling mistake in git-gui in french
Thread-Topic: Spelling mistake in git-gui in french
Thread-Index: AQHanXVot9k+eUDZI0ehQAe8UBoAXg==
Date: Fri, 3 May 2024 16:19:14 +0000
Message-ID:
 <PR1P264MB1728F9D69ECF4026725143B5B91F2@PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lebasic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB1728:EE_|PR0P264MB2010:EE_
x-ms-office365-filtering-correlation-id: 40b08c9f-9224-4d2f-0555-08dc6b8cc600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jlNQZgSCkissysNFc3tOmSouHwN7ILdw1lJO7ng68hWKCPdpJ0ubtYustP?=
 =?iso-8859-1?Q?TVJxrAIgWYlDGUgBDFxQ3g8sjdKIaHIAi5vp1WbrTGC3r5hR6zfZYWtmjH?=
 =?iso-8859-1?Q?TA5PQ6Aczt5KFV9ruJpN8QqiWrr4IdrpNKHXPhvfCNcbX6DTWhZik/3pka?=
 =?iso-8859-1?Q?rz4uZeepiaJsykSCKc7woWjJrv5MkUo/Ax8JsN3EmkmHzRPOt0CdHBLnoy?=
 =?iso-8859-1?Q?XoCWbnmGjy1JA+aOzmzJ3vL1oPHLG8kYFZHX+fdspM0JEVu+/TiFFLOAek?=
 =?iso-8859-1?Q?oKluD+7dAua9gYjgvjLNy9CupIJNAyx5w6SexXNDTfFlVmzTtVbe0tYJ2b?=
 =?iso-8859-1?Q?P8OtA0k2UcytUQ8gnPq/XKqpUB+iM9nfyPvvuXHm7XCVNu0pev2us21XGq?=
 =?iso-8859-1?Q?iJrVxv2Xc7rXRjcOJOfJo64GqseDfY+O7ZeKweSdaQhX7EF6NGhBtlJgUz?=
 =?iso-8859-1?Q?Myti9eRtLObDNLWBz5UuqC9w5TijFMhqh4exQha5RKX+8S41pGabkeI4+H?=
 =?iso-8859-1?Q?EDcOUcPK61KXR78M+lMEPa4Ixc5pqPhKT4rE0fO0O3dBmJVXbis3gw6Kh2?=
 =?iso-8859-1?Q?t3oot9QsAjZIdz6zEhU2qS0wPc6mIeyI4zUWrFMkWQCTpXnTtF6PjbDa7N?=
 =?iso-8859-1?Q?pV/BZ19TgfKq1KJ1xJi1l2O3jX3M8WOH+tA2s8c3gUB5zmBpm3zaZOVq9Y?=
 =?iso-8859-1?Q?x2eMRehbWJSic83qezpcxJFNgo9k6Sre/trcuFF5y4CVcfxlEoMWkoSUXy?=
 =?iso-8859-1?Q?/PekM3tQgT3fVK/RZbfNUW3Ctuo9Y8n7ic/5vJ5BktpA3hHBPC230tDUZi?=
 =?iso-8859-1?Q?ZZdP5nozfoXh5l+KGcT9rAPBxWRAbHfHsJdlrVcCZFVRe3o28Slmn5zpfB?=
 =?iso-8859-1?Q?QarSQZFw4Dtu2f1bDlFbDaAVKLCEtGKp52QpZN9nanVTzw7gjatckrn4vm?=
 =?iso-8859-1?Q?yT8Qnbbfrz1fYdvihsUoVrPLdWTZhmPY2jY5LuAwlcVxC+jf9h4EkSY3UZ?=
 =?iso-8859-1?Q?eQG4JNfpeihWq5RmeqhsvXPFRZR38CgtSH62twU18pL6J4TKEUzyZnchZo?=
 =?iso-8859-1?Q?vsKH3rloJu0E4PktnYjzBJNRH64E0S5XzrUI6KvAmyVNf56kgbWHECBlQP?=
 =?iso-8859-1?Q?IrN+9QrODGebdKfTOUhZ0Knc3kOOgzWrN/0ywu+xKPLaarZ2nbRRjBPEnX?=
 =?iso-8859-1?Q?fw317cS8e3BL8UWsyWhV1oShoT3qVOedM41p+FH6s8HXskCfkYODfsSwH0?=
 =?iso-8859-1?Q?14dX4Twiwt1pdri5DvBe0zEmRDREWBEzGOdGFyc6PHIP/trPjWs8L5PcgQ?=
 =?iso-8859-1?Q?OqeSLJKbb/363/LT4ReK0AEO9H7+yVKZG5v7tRnmvaoPdfWH6JyWdVoW5U?=
 =?iso-8859-1?Q?FaETgefYE6bwLApKjj1XfaYTKfqEICgA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:fr;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Rj8okC/fVQPO8LFp1vzYRwD2zhbzCiRljMbQ87sm+0iHFXWPPMrcKNgH/?=
 =?iso-8859-1?Q?hP2wPKQd3slZ0zJwnPVqdJU71VPLqbNRntz6D41scMaKm0JNQg+A/WNs7i?=
 =?iso-8859-1?Q?FaG5pfpvHU8ocaqXnTmwtQFyhuxopYUuVkZV9gil9XowmgbvoUjlF9uH9W?=
 =?iso-8859-1?Q?0J2rtF/iFaP05MKjo2RGagQ4+kxAaP6HFBVOS+ju6Zmqdn7oKk+PA0M8Pi?=
 =?iso-8859-1?Q?IN3Oj0pvD9DrWbeiWKh9jEtvO0pWE5sb1XYAM+99uPcApdg83wqBCXN//S?=
 =?iso-8859-1?Q?cnALrtS5kPenZvxME/Di9v1Eo5PyfWdF/jlKp+Ep9IuVCywPwjg0zOYP+N?=
 =?iso-8859-1?Q?YA8T/i1uyIzepI8qbWfbDACQwHW5EGVWk47zCmyBCf6XTj75qazeafN1j+?=
 =?iso-8859-1?Q?4EwEhLaykq/Yv8pMesowIRVFXHVt0lhuqEXMWTVyYN4NGFGpKmxTzVQecI?=
 =?iso-8859-1?Q?jyfR/eBBPBbYhyUY5IvwmGsHLEDkIXRz4fli4xVvNChOYEKu40bCdzzScs?=
 =?iso-8859-1?Q?0pldm8Fa9GFIw7gVoZNDAxpcSElbu979D9peoZzKn42M+JiXhLyun4z279?=
 =?iso-8859-1?Q?51dBekwUsZKWjYMG0dFnJ4aDqtG2R5Ewqd3NWtVZPApmBCIwN9J/84wItg?=
 =?iso-8859-1?Q?DySkjZLQoVQzOJl2bYHP97/dQyDXKEbB6TAAw/bi8wZEQ+9VotdUOXbLqd?=
 =?iso-8859-1?Q?NtSlWUEVIvaMM0p9rumu3mq25Jj0AeZrAL+PIxX+0I+fWu78Q9c+EEP/iU?=
 =?iso-8859-1?Q?9MesVAuTpfOjhxaEWSaM6ualhM4l4neykrKefapqb3ntdfgRZG17kiSq7n?=
 =?iso-8859-1?Q?QCfvYHbOPibXldhZu+jIY7jRFWrCrJGLcxuDrrvBtmCxUgEa7w40UElc7C?=
 =?iso-8859-1?Q?Uajl1XO4nOtygha3m10eUg+4kgffdcuy/G30AxZtozHNAhZRjBEkpCftaj?=
 =?iso-8859-1?Q?WvxBd/NrVqIGRbsJZy2if+mjTULEvBPACInB3+4QR/SQ+PVA1wCQb4FLkS?=
 =?iso-8859-1?Q?7kIps76/NvbDlrWAaKR1UI1gbKvTfxQkz/IVC5oofE79GVVAW2BCmGsoDg?=
 =?iso-8859-1?Q?MgCyh/VZGCUhy5gZq/z7e3FcRiefGMTUc0FrY/w7PpoTVUJ659LJ2pIMCo?=
 =?iso-8859-1?Q?L2aX0hiDvLswgJs6XT0WroIq2rUihGc3G2IjJV4PPisoaG3uxUY0IA3B5W?=
 =?iso-8859-1?Q?Ph6WTMv6/GvjFlvB3sQeCcZ/O1/SlLkfH6Wee0k0+UcLpUDWbk7001Rldu?=
 =?iso-8859-1?Q?yg8L115E9cs4E5MRVslbvsHkpPRVcMtU9QqnH1Se7iix/+lvCR48CEuhxk?=
 =?iso-8859-1?Q?9pmd8i9Q4g0FkQrafoLxVSmKKvbc7aBcZQeSDtIoqC1er673JZ1zOxwKrd?=
 =?iso-8859-1?Q?EppoPU+xC4tqatRosHIb+TnX1RvAZlTwFaoB6d1/DcPeAjtLd4J20fPmSO?=
 =?iso-8859-1?Q?gejFNpfS9njyY4uIsjW320byWQbepnpmsAa+IVLIj88psbs1ZP3BjLC1I9?=
 =?iso-8859-1?Q?gipC/qc52xOzJs2k9dqUANRSU/1XEPvBhVNKkIWu2mpPPxs7ZpqltmGo6T?=
 =?iso-8859-1?Q?9nGesxAkqr5Bj5hYkzUU7mMkzuk7rIJQyau5CJKlEmzd+mkeBNIIMgW+N9?=
 =?iso-8859-1?Q?UOSNoDsBbA72o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lebasic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB1728.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b08c9f-9224-4d2f-0555-08dc6b8cc600
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 16:19:14.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 196f23b7-c1ab-4a4c-b1ea-63a43201222c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZG04ZULSNN1ChfjIpLDTOusKOxVxNnp+kH9zEa5X8UvIXdvLSTB4tjjJaggby/b32V+EKhnGnDBM+63ByU5VyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2010

Hello I've noticed a spelling mistake in git-gui in french.=0A=
Details below in french.=0A=
=0A=
Autres remarques :=0A=
il y a une faute d'orthographe dans un message de git-gui.=0A=
Dans le fichier source git-gui/po/fr.po, il y a la phrase 'Fichier binaire =
(pas d'apper=E7u du contenu).'=0A=
Aper=E7u s'=E9crit avec un seul 'p'=0A=
=0A=
[Info syst=E8me]=0A=
version git ::=0A=
git version 2.34.1=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 6.5.0-28-generic #29~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Ap=
r  4 14:39:20 UTC 2 x86_64=0A=
info compilateur : gnuc: 11.4=0A=
info libc : glibc: 2.35=0A=
$SHELL (typically, interactive shell): /bin/bash=0A=
=0A=
=0A=
[Crochets activ=E9s]=
