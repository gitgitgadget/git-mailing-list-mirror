Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BD305968
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186441; cv=fail; b=LVouskH9hXTu6caGNpOdodocsfWI3aVpdjmHU/G2lSUHwIk6w6CMM9/c/SYEH/J6v0aX3PnikfifUwEm+08LnIa21y3334z1HyYqNqfdFsK7L/cgr0NbAA9ud3BqUwFUSeAcjI7pOjUpnq11FDW57CkDV7dKZ86WFjxHPygjCf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186441; c=relaxed/simple;
	bh=mOjCasL5Fq074cjQowkawJ2dkvy9xhpaX9Btk7W1VSM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ptes9+oSh2ETwVp10nzuRzQf3IJFLaThDxEPvp6LSbKNpxYqbub4kH0fyLL00uestDGQccCiJ4uJV1SbEfioINYAQZknLHG7/I55upRTgbl8JHUsMc3v/iJ1snnH3zgPaGyuOJg24cAh1Qwlm6lyK6fRx1pfwPSOvfuGcC5KSpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.tudelft.nl; spf=pass smtp.mailfrom=student.tudelft.nl; dkim=pass (2048-bit key) header.d=student.tudelft.nl header.i=@student.tudelft.nl header.b=akGf1mBE; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.tudelft.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.tudelft.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student.tudelft.nl header.i=@student.tudelft.nl header.b="akGf1mBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUsuvaC4xtsaUb60AgZDVuY/MlKH/XkT9dLJfBXFv48Oablqbgi25C9P212WQOXJIGd5hCRIGFmji3u4Ru6fbbP4rslwSFbZOCmD8YUMFT1A6/6aDl7swuXEZ8G2vyL3XcW72odFr6u10NnE9xKUT/iHo4Y8+oDJ0gAcjDYTJeTJuev21Z+Zrf1giONp/a1X5vWRWeQkHdAuJQokdHkE2W8ZdAF9pelQLBYoVdZYVbe3p4PRuS1SG3rKVltwYhMKKcmeblpyXUPUFiebrMnqi5aqLG+WfcqdPMWGHSwu2G33a1A1NuJ1BKYGbw9tgCH4g6EwBcjoevDZ7ykpA9jgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XthGU9xoqOI6uMd1FYDPau6NMl+pYCYwAmQQasDMsk=;
 b=ZK9T6p4TT5fsGHxpSjPvjJYiSKN5CWJ+kRUFZTCggjJQQCit4vmfwXztg3C3ZXrGDw9r2mFcGSTNevQw+mzuSNu39u70s+RYNwkMfC0q0WtDNtmnt6nLQq4mgzY03NZsrPDZDv5vLoMGUThRG+PgHeLMGpZsw5EPs79gDEclGdMqLrNcZQjtc51L96r2n7Fxjdl/vcP1uhL0wDRXnxO816TorJNPlk1bbGtwOFXXH6d1lSV8blYPe/wcPVqgU5/19KpEguhh0jGxdTvS5WLj5x9nFERGcIIDb0rfIEQMPeEojhvdg1A0d6C1kuZJco4K8nL9FwagqN5yWxBrTc4rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.tudelft.nl; dmarc=pass action=none
 header.from=student.tudelft.nl; dkim=pass header.d=student.tudelft.nl;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.tudelft.nl;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XthGU9xoqOI6uMd1FYDPau6NMl+pYCYwAmQQasDMsk=;
 b=akGf1mBEUM3L3FWTG28BAGedCSeMV/geHDushWXIIJcIqz76QTHZ1GAAHBb/CZjI7GuIhXjWFmJ190APDDVzOfvxwgSMswt5/gPdnSk5O8fQ56mGIZ6P50bIEDmtvv921zYqaaJyo2wWDpcrgy16VrSwVB8K9DAaNDwzwWTXebLio+oSdoZvaGmkzxhxwDQT8Zl9hN28O48TBeguCYgrpPOWZD9c5PI4F1VdkYs15SKzRwHtxYnKd7clhenIUAGtFeNq9Gv/HHnhY0DCO56i/GZ96rNvzpUEknjHY24jWUI/1OQnjgmJdNCgCpODBadO6js4N6m1HG+36pVuHfj2bw==
Received: from DU0PR09MB8272.eurprd09.prod.outlook.com (2603:10a6:10:59e::17)
 by GVXPR09MB7727.eurprd09.prod.outlook.com (2603:10a6:150:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 02:53:49 +0000
Received: from DU0PR09MB8272.eurprd09.prod.outlook.com
 ([fe80::574d:a413:7bd9:fd3d]) by DU0PR09MB8272.eurprd09.prod.outlook.com
 ([fe80::574d:a413:7bd9:fd3d%4]) with mapi id 15.20.9499.002; Mon, 12 Jan 2026
 02:53:49 +0000
From: =?iso-8859-2?Q?Krzysztof_Zab=B3ocki?= <K.Zablocki@student.tudelft.nl>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Idea regarding GIT
Thread-Topic: Idea regarding GIT
Thread-Index: AdyDbTOglccWnGwJRvOo2Lj/nAgaBg==
Date: Mon, 12 Jan 2026 02:53:49 +0000
Message-ID:
 <DU0PR09MB8272C80E049596044EF581C2B181A@DU0PR09MB8272.eurprd09.prod.outlook.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.tudelft.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR09MB8272:EE_|GVXPR09MB7727:EE_
x-ms-office365-filtering-correlation-id: 00a13e94-39a5-487b-2ac0-08de5185cffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|376014|1800799024|10070799003|42112799006|366016|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?AHxSGjvQnQ0IpHo6beECJDh+6ZZd+WIDbvVJT7/11HtgnRAcyQqyqUPqCj?=
 =?iso-8859-2?Q?do9KVN5/vb+RP3gRS1vhKkr+g+juv+aPiwK0pekxGIlrCD7OttiGqqyGQD?=
 =?iso-8859-2?Q?lHk6Du8wLUy4emWhUO6bcYsfUf6sqrE5u2ZjnYmfmpQmdVnabmY3Awaacv?=
 =?iso-8859-2?Q?KWwJee2X7/dueDSbmOAds+isxtoG1P0iSIw78bffN5+IeuXQIfQIqLMKrT?=
 =?iso-8859-2?Q?4cjthP6Ocs57+Gax83jErahWg+ufOiG7hVnUvMUvJfmW1qMKdJIz8Oh5KM?=
 =?iso-8859-2?Q?u9VxaWvuatT6ywYk+6JIYLkK9cEF7Ju2j9CBeCd5doB/0QTgkll7r394ub?=
 =?iso-8859-2?Q?GWP4FYifUxIXEnV1OaoyDitV6luBkmDnPLz38hkt3uccmVtPIs4+Id/aEW?=
 =?iso-8859-2?Q?ay0KCWGyr/fr0ARxrE9SdE1bLamkzddR+R0AsPCCbE2A36g/LjUmMTeQer?=
 =?iso-8859-2?Q?AyEmfcCIRk31T+KU68ylKrvq3AkIyxuhclggFA0foFuLnZPx5DrVRaE3LY?=
 =?iso-8859-2?Q?QaaGkg3TjF0P2Vf/uJguX0qhNbR3BYZLoXS9+c5rFawyERlKeZlHQ8PqXY?=
 =?iso-8859-2?Q?cZv+1JGlTSoeULkTyDYdQtxSLmqmcX2cnIGTkUmgHQCbuOHou4pW0jjIIl?=
 =?iso-8859-2?Q?ASVsQ5LhwNsHS2QPdm3u2H2J7dCalUjb7f/Qm+qJGjvmKtEUZeiq1Pdxek?=
 =?iso-8859-2?Q?6Hv9PxoEHMzMfYsFItHQtTarnpUWJsqlDg4IFKJykq5uDpjRNvWZnDXAtP?=
 =?iso-8859-2?Q?vZd7vioOwDmqo7JmHYHaeu0Oe1NT3ITxokGdPinWUd4M7gMTUbRIVzPtaP?=
 =?iso-8859-2?Q?zBM1prxusR+oI6a1FqMcDNbPs9nGqJ07+1ZGqCcvcwXS8jwTa2Dx3xTa4v?=
 =?iso-8859-2?Q?jAxUID3Y+vu0/ovX1yOsLAi/M6WuJuiDLxIwLIIDya02vSul9Af+QWHmew?=
 =?iso-8859-2?Q?MnHriQAuDGRyN1kqz+ztONqahLSWR4qE2/ozqIuX8IiPMzFHPPXr9zzIfL?=
 =?iso-8859-2?Q?bkHW9pQu1wPEvFgBlagzWlq9cied8t480HvEXl2UBaThVDV00sZzuRhzhU?=
 =?iso-8859-2?Q?EsTtZQ2kKAX4+/tA00Lk3BgAoG/vp9UxpxQuTMp0HuuRqmF3iDEtS8SLwE?=
 =?iso-8859-2?Q?7zmt/0ZZQ9+G2Ss6F7UkVZrMlyKVmoshlkPGQgZzevECgxiwQx4kif5D66?=
 =?iso-8859-2?Q?33FlIMvzTAtR9uLWfRNfh+6qwiqEXfxPwTDLBzZDeR+83FIsd6+mQAWm5b?=
 =?iso-8859-2?Q?ajlrx1K+fraZ5F11F2ddXCZeGvzuNSfv8cgV1LQPzRWlKCBriiMb+v8xyy?=
 =?iso-8859-2?Q?QVmht5jqjZ/RuRNK/Dz13xW1IIjcxZRqedavOgbyDassvBIjIBGU2NWALZ?=
 =?iso-8859-2?Q?L0jyxn05IdiTJKnxFAVIwOm1uR1nVqe6wWwjMdCGRLY5UUgAaOilC8p5Mi?=
 =?iso-8859-2?Q?iDVAd78Gs7IPCa7GbNekKJvGvssGqol4YDCFC3yNmxGWzScYg24D9Vm/84?=
 =?iso-8859-2?Q?Pd6r+Wz/KMMJk7viH5bt76i98djk1JpVWrZU+o8AlagdQaUibLVdf8Cgco?=
 =?iso-8859-2?Q?PhS0DaTddNESNlG+cK3GAD7A8A04?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR09MB8272.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(376014)(1800799024)(10070799003)(42112799006)(366016)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?2PwNstrbl0IbTw+SYTpzyjYsHgtBcUdImpLLKOlo6qa03m21gQ76p98y1z?=
 =?iso-8859-2?Q?+pOMw30b8WXalH2vRfjth9vzFooA65EKm81ZDkipuna6n3CEjN69AZCQ+v?=
 =?iso-8859-2?Q?LzPhhlXPOeTMJvfPsZlVKnJXgE3wsbVukW+W+mvBhpx8pOrjwnzcZT5o/s?=
 =?iso-8859-2?Q?IS29HQRVoY+nWbIsQ1HMqz/LaPUH/QltoBbV8a1J4zAKIZWxrfOp7az0iE?=
 =?iso-8859-2?Q?LGSxyC+hkp2OasfJ9/AQTh9LLi8LJpXD6NAYnmu6e894HPhw5UlXV9qjGZ?=
 =?iso-8859-2?Q?C2JNSPucTBymS6N1z5RMLX6GpTi59a/IT8bGTJj8EYTL/ssrXXw6k7oyVU?=
 =?iso-8859-2?Q?cnFeNTGFVZP2zecKWOB+LmOo2RyRUNS8M526I9grfTD7Lfxa0dUUfDBbHV?=
 =?iso-8859-2?Q?fyFeJqGuW1hEalptmFXpTMGr/+b1PovcT8U1D78wKSauF5/5eO5GxgGYUj?=
 =?iso-8859-2?Q?FNux67/M0GbeBBnLjJeP/uLaaIeRMVaBJEaioJmpsHp+E+mS6Cro8iSq63?=
 =?iso-8859-2?Q?iplQKHCaOv/RDS/hZZ7UsGNKw4+zn4yFiVMJ/6xe9gJDKVSBacwxNyToQ7?=
 =?iso-8859-2?Q?uzwdTjrAVbtfS7XbBLcBArZ0jO3JYRhOQxCbPu24BbB/xPWPZxNPN7ANv+?=
 =?iso-8859-2?Q?hPGyYIVnho/E8fFpoclVlziGWneXfgAtKkr5hCXJE5oR+uwu5Iym1B6wJg?=
 =?iso-8859-2?Q?gvRtj89+f8LhmvYQdjFmGqVnpaSJE7qNRdlhyENbXhMWOUJNFCreB0ui4H?=
 =?iso-8859-2?Q?xmlW5XOokCVRHPwnCyrWT+jJ3onc1qqjcJQ3xQiDuC9OPQfobsbrrMc3Wg?=
 =?iso-8859-2?Q?T+TuMSaG2gucMJhoG0vtoDbD2U7KtHOqpZhHLD025kKsxe66/ik96FOUhj?=
 =?iso-8859-2?Q?XBkYLVdRiwL45eX12ecJVI2t4wACkbKupTRjI6Gu8c4UMXejOwAU1BPBIH?=
 =?iso-8859-2?Q?VRiY908O0yh2RCmuGHXpqcwGrnTyuheAxM7BTCho9jBIif8sZoR2XpceEw?=
 =?iso-8859-2?Q?MH6Dxy/PtclKdaFJlpfMB5f/0wWgCIqBziceUAkzwVleDDhKTSvjeBmmP4?=
 =?iso-8859-2?Q?Qq5HhdW2AGyz2+mvOvlnJw7DaDqDfCB1raZ3E78deNxkjiYSsDXfFx2Vsr?=
 =?iso-8859-2?Q?85QHlPsB5oA7SnHh7DA7n9dVtBYq0UAjyxjHzPlUHm8TbTYVcqYFTI0yY5?=
 =?iso-8859-2?Q?gAqj+ZImueJnQmrInX1ScsdtFAsh3YTZgLh5kHl3RahFbPlYP5Wmz5/xsD?=
 =?iso-8859-2?Q?Q6zJUjr8h1iUMCCvgm2LbqAAjEQieUhVMYdeJDPXT4iLvvjXUR8epEgGeM?=
 =?iso-8859-2?Q?G4MA6rInxkPj+1TuHqhF0wowwNYc2zMfZx/dJaIFpdhp7kviU3KW0Hnq0a?=
 =?iso-8859-2?Q?Pe4asmx/UgAdJWsLStUM542WH/Vww2zTkCoIbgZHcWvgPBPfisCmlxO5tv?=
 =?iso-8859-2?Q?rt7hbX6rCANgdm1R9vY9a7WR36x6zRJUnuAyGBWYTTXydvE8KVvckMd2wE?=
 =?iso-8859-2?Q?2ayP7iHrDJi+sPBNlf0T00yb7fiI0RX/9/vj05g4N04DWSQq+gBfpjLx7A?=
 =?iso-8859-2?Q?a1En1NXTbkrl6yDzGvGiI5EBmY3jiPTzUWJRjsZiFXEUm+UIEz3/pKvEXa?=
 =?iso-8859-2?Q?IFTIkFKouAJC3w1fXJHblQgkHth04XNYMbTC8Kf+ep+UdnBQLGMMwy9Oah?=
 =?iso-8859-2?Q?fs3jbJ8vhQhS/lK4tFlXpNGrW55FzEPWV0GzqIWnBYVFOOtQqHcRnJw2Q7?=
 =?iso-8859-2?Q?HrApsEr5osGsTNgpaInccV2juwwojFKCAyQLIIbVl1B2dj1FX73gLjFzle?=
 =?iso-8859-2?Q?eUqaDWc7fGWv4paBX48Wk9wmDQ5NKaS7Wqn4OKGHO2B46+HhbZxuYi7M6E?=
 =?iso-8859-2?Q?xI?=
x-ms-exchange-antispam-messagedata-1: qtI7+vWOPucQ8g==
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0000_01DC8377.0EEBE600"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: student.tudelft.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR09MB8272.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a13e94-39a5-487b-2ac0-08de5185cffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 02:53:49.5135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 096e524d-6929-4030-8cd3-8ab42de0887b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdKWjCOWoJIPZnbWXWpd01NrPJ2UXdiytgA6w6ZlqcEyQ6fWo1Gka8mTm/mpWf6tzE9dC6MS+u3rDTqPZWlICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7727

------=_NextPart_000_0000_01DC8377.0EEBE600
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Dear all,
I'm emailing to suggest feature for git. It can be useful for ppl working
with pipelines and having extensive personalized configs. I propose adding
new configuration file (or parameter in .gitconfig) .gittemplates. Files
listed in there had to be indexed before adding them to that file, otherwise
it would work like .gitignore, but difference is if file was added git will
not track changes in it and won't commit them. It can be useful with .env
files, using this feature their empty, template version can be committed and
frozen where local version can be edited. Same with configs requiring local,
machine specific paths. Now there is need to keep template version committed
with different name and proper one recreated locally and ignored which adds
extra work each time. 
Thanks for ur time, lmk ur thoughts.

Kind regards,
Kris

------=_NextPart_000_0000_01DC8377.0EEBE600
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEzMw
ggW7MIIDo6ADAgECAghXChGXQsTjzDANBgkqhkiG9w0BAQsFADBrMQswCQYDVQQGEwJJVDEOMAwG
A1UEBwwFTWlsYW4xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MScwJQYDVQQD
DB5BY3RhbGlzIEF1dGhlbnRpY2F0aW9uIFJvb3QgQ0EwHhcNMTEwOTIyMTEyMjAyWhcNMzAwOTIy
MTEyMjAyWjBrMQswCQYDVQQGEwJJVDEOMAwGA1UEBwwFTWlsYW4xIzAhBgNVBAoMGkFjdGFsaXMg
Uy5wLkEuLzAzMzU4NTIwOTY3MScwJQYDVQQDDB5BY3RhbGlzIEF1dGhlbnRpY2F0aW9uIFJvb3Qg
Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCnxsSlKaQs7+UYxbBQo29RO58KWsnC
SDgKwhygGH+RtYe5QD/dHWgfCIPVLR6IoPiPVo9tmQKSkBbVXwhsidfhrLwgwrHgg1GKaU0Allpv
L8BEfqMO5JHNWO7c+8ceRUfdJ7kIAZ+mIR31QS0vTP0oreCKrSK0VmWOhlSPk0Mp3jlGeKMwI7rN
8H0TV8Bd0oNrSEzEq5+AWls6vcmnIj+AJzNbDreKDF0HNwjLbNJ6RyJENcXMzC6O3Srtt31mDV9h
USJVG+NG4+M90DVimtuvFMhbocyJG+EwJvygmx+Bp0cfBOujOZIGn5nTv9PqT1CcGf6Whx48Zfaj
GCSDhhDnVD6oOnYkT4EhxeMPAviTlEcgu/7UDtNoud3EeoSC41NUed3bnNLyB5sutrw+7YVt7yUR
8pcaQmH3Spfoi7EQB/plgbKiOc/3PP8Y+8bxWotZ4gKse5LQThRPWUX2DF4oX7DoP0XPz6+bb/uE
03dalW+slISe7rzASo9Kk/hEIeIxRWFQThDY4zV8TBm03gW/owafyLXN5B/XFwYNepV0VQ1oGvwQ
G2JknW3glaDDlAdXDRTmvQX7uJ/m34vixud+lvZTxYA0UChY8BJQcRcwuuZ4Y7z0sq2bK7L+4TmM
XroLIJTee4O4/+NWjbcR6TuM8rHBXZ2kC0wr2bIY9bWfSwIDAQABo2MwYTAdBgNVHQ4EFgQUUtiI
OsifeGbtifN7OHCUyQICNtAwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS2Ig6yJ94Zu2J
83s4cJTJAgI20DAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZIhvcNAQELBQADggIBAAt7cofAYKZJTIhY
5h2I9xRkSKbYWAoOTxM13zUd1O0GMciBPmrV3TsaMu6QPRHSLvSOw2MuI2awZ75vtsATOWCqojQl
k3VS3qedrQ6HiVJxahY8GR2D+JopZb70P5rZ8PNahyFxgE3L4DibP7v64DBNz4bTZRAZGNGXArEr
ckJorKC9TlraGL9rmIHQ/Zq+XhVIzREVucApXLToiPc+Nq63Yv0eYt5weBAcSFvavKQ4umftVT5e
V9/UA0BMgaTST2OnCUIJFPwAqcKAc08uwEDZEXtI6noCwNPrKAEmWHTBwHMibZOV/Tl9uyrj9oLj
LJdfTh+RlPr+LKPYdhq4TbI4T5v6HUhgeSbi8/2p0JrocI9JetblvQoO2y3zjb/r46R9y8eVceja
o3zFwvh0kgQbhqykIlNAtqz+THbP+5QywDWfdj9u5ZBuoKYmorgsvtErhf2naMi6ASuxbHQduHOV
5+63xyXwAEwAsn62C4sc88BQniW54AjeNmb/N6XRu1RkLMkntUuSfmX/0y3huU68f6RBIZBBd6Y5
H+qe45/QZm8F7Kp2fr9rFqDrtcf8klQvKxEnJTd4TFFqsPPMWF0U8WpIFf/CB7axjQ+OXFBGsz2/
AZhPsllURz40e3htVpMuc+pmKHjNHRS/oI8vLrgujvIUiszptXz7bJ0MpeGWMIIF/zCCA+egAwIB
AgIQULbgl2X7oPM0S/UBLCaCSzANBgkqhkiG9w0BAQsFADCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMg
Uy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMzAeFw0y
NTAxMTMxMTM0MzhaFw0yNjAxMTMxMTM0MzhaMCgxJjAkBgNVBAMMHUsuWmFibG9ja2lAc3R1ZGVu
dC50dWRlbGZ0Lm5sMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvbgRU8eZLFQtVsLr
K+lq0AKd+h05lD9r0E8GyMJjVC74MM9O7n1fKbMAQwYjcvBgxJfBxo0n9mK/4h7YhkqnC9r75yVl
J8PB955hhhlDhmXeB9OWm9LxYqEHlF9TKgzNV+yAjJHh37P7kirwz40nSADOdRggMDLwAJaabRVe
H5DOCke3WEhfC4XPG1337aHxOgC0iqlzCXD80iouahlx78NRiO7SYQFvMJH/WVNWJmQSXUsWfycj
ZADyHVlZkDrnJek8lNDehTBMdvDMOChNIaA15GIztmghMa0fCMQhTu36lAsRjR+OHDS9GB8fuEdt
icixtwjExL86kgY3Qy9/8QIDAQABo4IByTCCAcUwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBS+
l6mqhL+AvxBTfQky+eEuMhvPdzB+BggrBgEFBQcBAQRyMHAwOwYIKwYBBQUHMAKGL2h0dHA6Ly9j
YWNlcnQuYWN0YWxpcy5pdC9jZXJ0cy9hY3RhbGlzLWF1dGNsaWczMDEGCCsGAQUFBzABhiVodHRw
Oi8vb2NzcDA5LmFjdGFsaXMuaXQvVkEvQVVUSENMLUczMCgGA1UdEQQhMB+BHUsuWmFibG9ja2lA
c3R1ZGVudC50dWRlbGZ0Lm5sMFIGA1UdIARLMEkwPAYGK4EfEAEBMDIwMAYIKwYBBQUHAgEWJGh0
dHBzOi8vd3d3LmFjdGFsaXMuaXQvYXJlYS1kb3dubG9hZDAJBgdngQwBBQEBMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDBIBgNVHR8EQTA/MD2gO6A5hjdodHRwOi8vY3JsMDkuYWN0YWxp
cy5pdC9SZXBvc2l0b3J5L0FVVEhDTC1HMy9nZXRMYXN0Q1JMMB0GA1UdDgQWBBS5gLr8lFEOa7ra
8it1w9JaBHJ0uDAOBgNVHQ8BAf8EBAMCBaAwDQYJKoZIhvcNAQELBQADggIBAAqbqNR/NuI6Acht
n2i5XN/NwBcPqHZ/m5ayiYP9kVxTNIK7Rx4/fCj3f8ODBSw7phxvPQQYdfARWKrSQ5uZja+2KX2W
gncZKhNn8b9YeJmb1v3KtZcSknXiueb5aKvu68KBdUNewA0SgjmZDJRueP3b1E0zN2kIsWKhnB/C
jXiOWztyJjx+auYACIIjNMwR5GN6a0s3m7u/jEEyJirk6+A8mbwTLsg0L0pP7vgSKfx8AOdaxA0s
40VO3OYkKCI0H8HV97hz/IFAYwLlZjlQ2fYufANIq9lb1tTnCfKaKa1ywjQxX26IlfTauPs3mZ5v
dDfEiK2jgiFzXJGOhpFXSkZH4GDeU5N5ojruJyOs85/jjaT90Ik4XNVImLwkvtLxkb/In1cIV7eP
HqFpktGuGgyT8xWcRAPgpJOvD0IoubqMHEYGLFKPQdXs3N4JtA+yASp7m7TAQ9CozqIyXWIs5Zk5
aSTHEYEi/MN/rzI1pbOP55CMAtZJErZYyLg3l3/EdJKBiDHIQPh0CyA5PwZnQk4OmVQRBGX3MJ0m
YdKOdxaJI2c79yPGRKDsrVsIj+xhzIVP88C3XuS7O/gczzmwcJ2lleKy3i1kcQFKhJ4Mt5JO4J7/
O9RFDf3G7GOkq62YC91UMPtEFBPXDknt23DAOcLc2B7Y/dxDXrnRWndP/68pMIIHbTCCBVWgAwIB
AgIQFxA+3j2KHLXKBlGT58pDazANBgkqhkiG9w0BAQsFADBrMQswCQYDVQQGEwJJVDEOMAwGA1UE
BwwFTWlsYW4xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MScwJQYDVQQDDB5B
Y3RhbGlzIEF1dGhlbnRpY2F0aW9uIFJvb3QgQ0EwHhcNMjAwNzA2MDg0NTQ3WhcNMzAwOTIyMTEy
MjAyWjCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNh
biBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBDQSBHMzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAO3m
h5ahwaS27cJCVfc/Dw8iYF8T4KZDiIZJkXkcGy8aUA/cRgHu9ro6hsxRYe/ED4AIcSlarRh82Hqt
FSVQs4ZwikQW1V/icCIS91C2IVAGa1YlKfedqgweqky+bBniUvRevVT0keZOqRTcO5hw007dL6Fh
YNmlZBt5IaJs1V6IniRjokOHR++qWgrUGy5LefY6ACs9gZ8Bi0OMK9PZ37pibeQCsdmMRytl4Ej7
JVWeM/BtNIIprHwO1LY0/8InpGOmdG+5LC6xHLzg53B0HvVUqzUQNePUhNwJZFmmTP46FXovxmH4
/SuY5IkXop0eJqjN+dxRHHizngYUk1EaTHUOcLFy4vQ0kxgbjb+GsNg6M2/6gZZIRk78JPdpotIw
HnBNtkp9wPVH61NqdcP7kbPkyLXkNMTtAfydpmNnGqqHLEvUrK4iBpUPG9C09KOjm9OyhrT2uf5S
LzJsee9g79r/rw4hAgcsZtR3YI6fCbROJncmD+hgbHCck+9TWcNc1x5xZMgm8UXmoPamkkfceAlV
V49QQ5jUTgqneTQHyF1F2ExXmf47pEIoJMVxloRIXywQuB2uqcIs8/X6tfsMDynFmhfT/0mTrgQ6
xt9DIsgmWuuhvZhLReWS7oeKxnyqscuGeTMXnLs7fjGZq0inyhnlznhA/4rl+WdNjNaO4jEvAgMB
AAGjggH0MIIB8DAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFFLYiDrIn3hm7YnzezhwlMkC
AjbQMEEGCCsGAQUFBwEBBDUwMzAxBggrBgEFBQcwAYYlaHR0cDovL29jc3AwNS5hY3RhbGlzLml0
L1ZBL0FVVEgtUk9PVDBFBgNVHSAEPjA8MDoGBFUdIAAwMjAwBggrBgEFBQcCARYkaHR0cHM6Ly93
d3cuYWN0YWxpcy5pdC9hcmVhLWRvd25sb2FkMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcD
BDCB4wYDVR0fBIHbMIHYMIGWoIGToIGQhoGNbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0L2NuJTNk
QWN0YWxpcyUyMEF1dGhlbnRpY2F0aW9uJTIwUm9vdCUyMENBLG8lM2RBY3RhbGlzJTIwUy5wLkEu
JTJmMDMzNTg1MjA5NjcsYyUzZElUP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q7YmluYXJ5MD2g
O6A5hjdodHRwOi8vY3JsMDUuYWN0YWxpcy5pdC9SZXBvc2l0b3J5L0FVVEgtUk9PVC9nZXRMYXN0
Q1JMMB0GA1UdDgQWBBS+l6mqhL+AvxBTfQky+eEuMhvPdzAOBgNVHQ8BAf8EBAMCAQYwDQYJKoZI
hvcNAQELBQADggIBACab5xtZDXSzEgPp51X3hICFzULDO2EcV8em5hLfSCKxZR9amCnjcODVfMba
KfdUZXtevMIIZmHgkz9dBan7ijGbJXjZCPP29zwZGSyCjpfadg5s9hnNCN1r3DGwIHfyLgbcfffD
yV/2wW+XTGbhldnazZsX892q+srRmC8XnX4ygg+eWL/AkHDenvbFuTlJvUyd5I7e1nb3dYXMObPu
24ZTQ9/K1hSQbs7pqecaptTUjoIDpBUpSp4Us+h1I4MAWonemKYoPS9f0y65JrRCKcfsKSI+1kwP
SanDDMiydKzeo46XrS0hlA5NzQjqUJ7UsuGvPtDvknqc0v03nNXBnUjejYtvwO3sEDXdUW5m9kjN
qlQZXzdHumZJVqPUGKTWcn9Hf3d7qbCmmxPXjQoNUuHg56fLCanZWkEO4SP1GAgIA7SyJu/yffv0
ts7sBFrSTD3L2mCAXM3Y8BfblvvDSf2bvySm/fPe9brmuzrCXsTxUQc1+/z5ydvzV3E3cLnUoSXP
6XfXNyEVO6sPkcUSnISHM798xLkCTB5EkjPCjPE2zs4v9L9JVOkkskvW6RnWWccdfR3fELNHL/ke
p8re6IbbYs8Hn5GM0Ohs8CMDPYEox+QX/6/SnOfyaqqSilBonMQBstsymBBgdEKO+tTHHCMnJQVv
Zn7jRQ20wXgxMrvNMYIEGzCCBBcCAQEwgZYwgYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJn
YW1vMRkwFwYDVQQHDBBQb250ZSBTYW4gUGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEs
MCoGA1UEAwwjQWN0YWxpcyBDbGllbnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEFC24Jdl+6DzNEv1
ASwmgkswDQYJYIZIAWUDBAIBBQCgggJVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDExMjAyNTM0OFowLwYJKoZIhvcNAQkEMSIEIO7lN12nHiY5gXkoljwRWnnc
xx0Oz/VWuqQQHISuu5VxMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAsGCWCGSAFlAwQCATALBglghkgBZQMEAgMwCwYJYIZIAWUDBAICMAcGBSsOAwIaMIGnBgkr
BgEEAYI3EAQxgZkwgZYwgYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQH
DBBQb250ZSBTYW4gUGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0
YWxpcyBDbGllbnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEFC24Jdl+6DzNEv1ASwmgkswgakGCyqG
SIb3DQEJEAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UE
BwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBQtuCXZfug8zRL9QEsJoJLMA0GCSqG
SIb3DQEBAQUABIIBABQtXcXen6wtY0Ur0TP7nfAlI8HLQsH9mRQ1jUc4BKYYgOrhU5M1MNeww9Oy
j6opqq9R1pd63xl3kMudD4ju6ItoPQzhGKxavEI4puUS2ts7r03SLcHwHj/qoyoLXJAkAprfAHrk
yE/N+BCgDff7LOvGr47Y3r44ONE5waSkZ7+vNBGvWq9jaslzSjdElJcOFrfHNHXR8CIx7LiItROl
mu3eFX2yvE5qTeogejESvXCitmUKCFOKwzlX4v4Om+0c4E6jKn5feN+nVFNALVfMi8By8oypyIpC
snzODDLx+aZh4SVlrTsJeCWnPt4hg7MmOfvZ9RixC8HI8boNYoVQnUIAAAAAAAA=

------=_NextPart_000_0000_01DC8377.0EEBE600--
