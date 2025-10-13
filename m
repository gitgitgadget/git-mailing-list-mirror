Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022090.outbound.protection.outlook.com [52.101.53.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665F2C3242
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381715; cv=fail; b=mm853e7WG/n5t8hWZe/O8fduZi3TDoe9AjRRpYYsM1cloCabRlC/1pOl++1wfmDdzfewxcgE9JTXjPS5pkyjA18Wpv+nDOc7Gi1Lna8V4Zm9ZJGEQ293IR9GoHcd0A3FNsvbA0lEQYXzrezgJUG3xKZwvsygKfzgDnuLjGl/fTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381715; c=relaxed/simple;
	bh=dQ0i7cc0Zc1gdc9QFs1hexAcOSgdXvXS/5hxjRByR8g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXuZB4kCr16v1Emh8rL91sYQWXWUlloG6Yvd5bi9m8uaMKUwugPWGjAiiYMG4qYisldgQ0JEPqIeX6AF+FslmMk94ufkwOMgYk5wmscBHf2EF5TTpg9957wgipWORBUlq9uDOQDrjpLEgoL7dg8EE4QXIWUbuB+RbnVubjqIC0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=concord.net; spf=pass smtp.mailfrom=concord.net; dkim=pass (1024-bit key) header.d=concord.onmicrosoft.com header.i=@concord.onmicrosoft.com header.b=HFhKg967; arc=fail smtp.client-ip=52.101.53.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=concord.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=concord.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=concord.onmicrosoft.com header.i=@concord.onmicrosoft.com header.b="HFhKg967"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr644Yak0xbBYqmAp7kSOZL+NRK7NHwrA8T+A9qq7xQmkwdRj9ja6H/Wqpe/7m/lYQDei/iTdAXA//8iX/H1aGzwamiQPZhjM1wTmI3a3b9ohLuXrpke1oVIzHOaqh8awrlZ5zdtiTukiJF8vy9dXzTfaddt8Mi+HTsqlq4sb5NezDFFeVp5vU96idJa4D287+ueHT3Aj5u/MXcrR+wtawgE4FQeMbFjn5R3oARU+5/XUG2+K0Dedr/UOsHN5adJM3imBNPpf5in+CTzJOz3L0QRgyvqu7B0G5Q3c+LH8l+lZHuQslqoBRxOtD3tDoEv/LSSY7UKqvnxETHZ2Apf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ0i7cc0Zc1gdc9QFs1hexAcOSgdXvXS/5hxjRByR8g=;
 b=yTt8Uqy7vIoiBnkIsyjI0dl/RBm+kh/3ZVhIZfiMW6Mo5zLZtsbd0fN41lX+rMHSsfABQo5WGp76Vt8gnv1pvDAbmZI28Wnn8xBI+9dsqJztSXlCMzsnft3QbrSEWQzEUqX42BBBe8XDQoMap/LT1X/QyFjhLPEc+OFRLm6m/N9y8SpYYp9ntNbTbl/q3yrS51y4/zQhWDwL8DnDCBGPekjABOD0Cq/XRcCzuzs8hstkrkxXPjAZdNCk6H6ly9q81K8JoMia0VjErhP826gl9bWB1OuqOSmoUn+ClNkqY/zAV+w0llUBHGNxvWeEI2tYIh+xw8ugn0BpH+ufM3syvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concord.net; dmarc=pass action=none header.from=concord.net;
 dkim=pass header.d=concord.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concord.onmicrosoft.com; s=selector2-concord-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ0i7cc0Zc1gdc9QFs1hexAcOSgdXvXS/5hxjRByR8g=;
 b=HFhKg967nWhETyaPYu6GmaFghH/V6iZOQcc3q1zFqmLniW1FDfOZQQHezDSdPFT7FPyuQj4udA5/lhJy4pinHF5SyAGVyRBMpbqiniGy5zUbn/ndmCjCHu5Nk4SljBAeE9e+Krd8K0DybwHb5y4Z3+rYdTcjA5gbzcfnHcmyh7k=
Received: from SJ2PR03MB7043.namprd03.prod.outlook.com (2603:10b6:a03:4fa::12)
 by MN2PR03MB5104.namprd03.prod.outlook.com (2603:10b6:208:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 18:55:10 +0000
Received: from SJ2PR03MB7043.namprd03.prod.outlook.com
 ([fe80::435e:6c11:4c53:b365]) by SJ2PR03MB7043.namprd03.prod.outlook.com
 ([fe80::435e:6c11:4c53:b365%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:55:10 +0000
From: Roy Lomicka <rlomicka@concord.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git whatchanged --i-still-use-this
Thread-Topic: git whatchanged --i-still-use-this
Thread-Index: Adw8Zn5uZbUPziY5Tmyvj9l7tIPFsQADDmRw
Date: Mon, 13 Oct 2025 18:55:10 +0000
Message-ID:
 <SJ2PR03MB7043AA590AD8D80DB4EC7B73CFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
References:
 <SJ2PR03MB704376284D14F92B54139BFBCFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
In-Reply-To:
 <SJ2PR03MB704376284D14F92B54139BFBCFEAA@SJ2PR03MB7043.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concord.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR03MB7043:EE_|MN2PR03MB5104:EE_
x-ms-office365-filtering-correlation-id: efa3491d-77dc-4cb8-1246-08de0a8a0913
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sBHtzxcisl8ybYwvxS5WNoRowY9uXn6KjlDtFR+3a03pJiFFGaFRhesuYq?=
 =?iso-8859-1?Q?Rkl6D67dBZlT3bBXPB8keqOrX1E+s7Kcm2OYPz73uLH5Ri3emj6BXnzBOd?=
 =?iso-8859-1?Q?1eq9Nqxe4Y3XzFHQEecCZhVExAkgTG3X4QGq1GY6nU2slt7qh3B3F/S66b?=
 =?iso-8859-1?Q?skcj69lV5TBzmJqtx6awXLipvGHsPaOjzFBEddoVGm8eoWDXu//nmq2sF5?=
 =?iso-8859-1?Q?x6nl+VmV0RnbU5P70EK8fVrXd9G7kj2FoYwPW9tw5KBzqNUq2Idl+xsP3+?=
 =?iso-8859-1?Q?Fntlbp/bHRgNFbAlhQvwJ1H9DwyzIItoZhnnrwpupbT6fEAmZ738pd2IJW?=
 =?iso-8859-1?Q?v9ultO48P0D8lRHZeGvdcaCr7f9/Xz5LfXOiQ9TergggvStju9iKsuQ1yY?=
 =?iso-8859-1?Q?LQ6OyWIE1maB0J2PcPYmfUoN9f4Pvay2UBglXbYCjzoOcVeZmpgbZTzjZg?=
 =?iso-8859-1?Q?n+YcMCokyxm27CEaSvmvyqGzVeKK9bsf/q+FqykHgtoOAtW2UU9NDAwkNo?=
 =?iso-8859-1?Q?sGyu6eGh66GJ/njLI2yJSFTiZo4MH2jVfTgKBtd4VmU6NLOzbUm2y+NxcC?=
 =?iso-8859-1?Q?OAwbY+QC9GMwE58ucYSN1JzYlM9HDMbGbD4mmZoOjLAPDccH79hYvkJhi1?=
 =?iso-8859-1?Q?UyQqE/BbiwuyLRtVYfQyY78PjU7jlMeGKtqkw0Pse2yQk9to5vEydxX5QV?=
 =?iso-8859-1?Q?1v6iKT3JEsg9+CZ0qUcGMUPaul0gTPjTU0zyyM0mVtvP1SCO1Yw0rM6EBp?=
 =?iso-8859-1?Q?dEb7sszdkLPI8vlkp4JvxQ8Hcgp2GV+3/Gp83Euw9yhkt8lQavNOx/7f68?=
 =?iso-8859-1?Q?8+bVRsIMm3ga7Fj/+1cw50x4/Qy9z/9zFK4bJOCVa8TzOgITy/Tilbafv2?=
 =?iso-8859-1?Q?pJqlKLf9iaECe0tYOiYgIVVacN7QFZloauEBiHdP6woFYQo2W/IWCVYQDB?=
 =?iso-8859-1?Q?TavJyAotGSrU0t2H+Wk1ikR07WKoZ8SWEyBuuHrg/sGOUiw1sHS1RwDaCT?=
 =?iso-8859-1?Q?P2KZmlTEx8uK+VzjpbgJFBnlyzDXyOTZExw6bV5tWQhucTctE8QXjJSh9J?=
 =?iso-8859-1?Q?ePcBospYZgZTd2/joGcJOqYRZ2PIDUO7NpN7QRZ77d6j7l5zCDllhVzVTu?=
 =?iso-8859-1?Q?SGfwa7S3mKdADVkzmHqL2zYa5noeo9/zD8lZadlLbrQhI1yn5KxnwKg4TQ?=
 =?iso-8859-1?Q?aY7cYGyLj9P8OXEnyYnKZbHlKI0ZinaFaQPEJ5SLMP4gGeYSOYRE18WGIL?=
 =?iso-8859-1?Q?0TW5DdYfqjlrestZFy3Qa4R6i9n2ZWH3VyI0wWrBZqqjlf6cxWuTHR3mTp?=
 =?iso-8859-1?Q?e9sQ+/zQIFLILt9fi0pOf9ets6b+8YnWAsN37kilgbPvDuTSarcmGJx6bp?=
 =?iso-8859-1?Q?nmsFa0YILdCb1r9BFavKgzedFO1KSsAzuiuOG4rH3DWRYbXP5AzpfwmcEj?=
 =?iso-8859-1?Q?eq1wcQMr43LwA6klbAQhgPJBD6JxLecUA5hpuMOPSotAvRdgkzXCEbJKvP?=
 =?iso-8859-1?Q?93oMaUdbpHnuWuvQxJNZcSA4Ue1qysmcm1hljNr6QMbA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR03MB7043.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pHqtweAbBc2Bf6abKZOQMT8u7w/eUOn7aDqaFVnZhf5JSO8Cteu27DXg27?=
 =?iso-8859-1?Q?B2PO/jS+BmAGgrebuITjHO3HOCmZi4SsiBizUlxec+GuKntEawika7+a1y?=
 =?iso-8859-1?Q?KUFs5PtwfZ3lT6Q+OW22MU2GGIkJ5jTxVdr5PTi1kKnimOlRD+llrMMc+E?=
 =?iso-8859-1?Q?FkNhlpTjJVcyIBcbOwZrLhCIkQjqv9VEEaKywViVJvNHEaoCv9jd2uHaxK?=
 =?iso-8859-1?Q?Po43d0CeuMtuh6f6m9dr/2/x53UxoQqvK13xkAb8+EpLjsHWP2oxV/WLax?=
 =?iso-8859-1?Q?J/zYPWhZaOMhQJkHT19hoi/CD3fgIPw0dYpz9iX3j/vmbb/h130AWstiTO?=
 =?iso-8859-1?Q?LKRf/NTRu7HVhWrV65zRxQX7d9RJ5jLmxCsxdz2A7GMMw9IsoPCkbLtNJt?=
 =?iso-8859-1?Q?G3qi3HXwOIaEN2nyY20QlIscYQJiLAeX5Ngmh5kNnELBlxMz7Vgo+Fyzjn?=
 =?iso-8859-1?Q?zMEq5995nnIt5BmWwyzkX9PX0tMlz7lInisSGOmt/Rw3oJp06u/eukHol1?=
 =?iso-8859-1?Q?lRASc52VQHBeO3oGNtK5vKGtvXsOl4gfsTzHKNL7HJS7sbi41xHxAZr8v+?=
 =?iso-8859-1?Q?tM8WsxBnh4zV12uWhsa3Io4lyDdH8F2WLHtHO74hMEgnj7QrO0RMeOaeBc?=
 =?iso-8859-1?Q?BybnSSpt4064i6/9IHiXd7pXTmcRtxRp6ieJ+pTcbF1vkQRidkpMoYcxkG?=
 =?iso-8859-1?Q?LYjpx1vGcicSvu2GTOEckDoqbwXcy+VIMDUGv2T8b+nKYWHGndtrnX278k?=
 =?iso-8859-1?Q?vH8HcZIkm7JAxACThmkcMrc/OAZNmVPQ5hbTAP9vdW8sCbD91fBGDwjmRh?=
 =?iso-8859-1?Q?DX3SP6d3lzgm1/lJ/TRqKaqC5AKbS7dBS9rFH5XCxraRkyU0f3jyyRDybQ?=
 =?iso-8859-1?Q?uB70WaAKQfHlpqSJOupGJlNptshORX1LPwihi9WWZGsK0SybxF3JLAng84?=
 =?iso-8859-1?Q?SbbB1a2+te3Um6PveUEpiD3OJOUmr/wDdWYo5+wbr4YdoVcJduibt2MVuF?=
 =?iso-8859-1?Q?NXQYgUVu3ZQIBBiXzeKxg0qmWhOsOP/KLz0cY2M3uVroMeT9UB1HrpPYLq?=
 =?iso-8859-1?Q?K6CiZmzxYJNOZb/gTR11ejN+KN+4E4f1NdB+ASzCmxPJTA4I3h8JbHnKK1?=
 =?iso-8859-1?Q?4O6np1V5uLckNYnhNtzz7U/o6BEDgthcRs/tazCHea2FIg1KRlhqisD+4J?=
 =?iso-8859-1?Q?+PVVYk5eyYA9Jh3HSNg3fVuW6bxc9gjJeTV8zuxUnpEvjQc5+vWS2Ty66l?=
 =?iso-8859-1?Q?DIK4eVAsWixox/rmz5R4Jjl7Zc8YFnZaj3E8Ptf71p/wDdMNOqwTtDvdSL?=
 =?iso-8859-1?Q?KjpIfhMqCNInEm1AtocmGofTv+IbN9RjAtNxJGfvQed2j2f4ifk/Kxs3rW?=
 =?iso-8859-1?Q?K1+GK/hn9AyXLLkLs97amabHRcpLgLj/clDoGVktcG5hhEidkxc816N9Aq?=
 =?iso-8859-1?Q?hC3y4EG7FeHIcALZp9sVM9yvJz/UMtQhAHz6KW04RZTrvevn2We8S5yLa7?=
 =?iso-8859-1?Q?LkP1h8DZKubCiHQBrtckJN/9jug4Sv6eFBKVmzLEymDvosYvvAWmO8HNLP?=
 =?iso-8859-1?Q?aj387VXs/5B3uRjRKtlnLk3+hwDrOLZkLmQ4BvZ0OF7M4NqPx8cFKDE6Y8?=
 =?iso-8859-1?Q?058hZou1o0qD8sTjc5uRKjUuhS++mEILY7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: concord.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7043.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa3491d-77dc-4cb8-1246-08de0a8a0913
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 18:55:10.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7674c0a1-b7aa-4472-babe-e8c09210b014
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7++P6axUte0leS+I4sJZgXEaSnvRM3RHuuQpCvHU3nAnqXWlyolw0d2l06tmqR4a7hG3xuhq09nFUvEMmKqUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5104

This is one way I deal with the fact that git has no option to respect mtim=
e.

powershell use-commit-times.ps1

'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <mailto:git@vger.kernel.org>.=A0 Thanks.
fatal: refusing to run without --i-still-use-this

use-commit-times.ps1:

#use-commit-times
[string[]]$changes =3D &git whatchanged --reverse --pretty=3D%at
$mtime =3D [DateTime]::Now;
[string]$change =3D $null;
foreach($change in $changes)
{
=A0=A0=A0 if($change.Length -eq 0) { continue; }
=A0=A0=A0 if($change[0] -eq ":")
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 $parts =3D $change.Split("`t");
=A0=A0=A0=A0=A0=A0=A0 $file =3D $parts[$parts.Length - 1];
=A0=A0=A0=A0=A0=A0=A0 if([System.IO.File]::Exists($file))
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [System.IO.File]::SetLastWriteTimeUtc($fi=
le, $mtime);
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0 }
=A0=A0=A0 else
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 $mtime =3D [DateTimeOffset]::FromUnixTimeSeconds([Int=
64]::Parse($change)).DateTime;
=A0=A0=A0 }
}

Roy Lomicka
Software Developer
p: (978) 367-3518
e: mailto:rlomicka@concord.net=20
w: http://www.concord.net/

Concord Technologies and Biscom have come together to better serve you, htt=
ps://concord.net/concord-technologies-acquires-biscom/.

