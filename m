Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010001.outbound.protection.outlook.com [52.103.33.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9A10F2
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822468; cv=fail; b=IdsLEYknn2CWeLr4YTd9fFbm9EycExsb5vcCq1wSstyw2QT4kiGIz4aPXfOfuywmmZejW+v4MenU6rbluEv7py6NqvS++TaKn65VUyE1dpSMfSpttb8wZw3La2HfyMzNcnXimaxzP6aY1wYjt0KCy3faGqbXz3p30kiNe+CqU3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822468; c=relaxed/simple;
	bh=prm8Z9U5BNd56bhzJhdPplS9K5f7IWV6VtE/z78w+gc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BosUqQs1sDHpybRNSMpAMeVFIkiXwr1U1ifLqhqrKIJpq3hhZQAF+kaCGxYST5hBYEOiwStg6yT3E0kLClSTjz+6mQspRt7X+dY/4uRdu92AMYwKbg7PGnfbUVJVFZmhcg0VESmTh7vXFhRP448DbOghxuyvyDFYM0W1o8Chlyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BqhCNAf6; arc=fail smtp.client-ip=52.103.33.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BqhCNAf6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzSr4+sT30PF40vsT4qxmKxiCmeRwH0rOkmDsWoZRSM1mCvrpNX+FQvzNzNlbttJ3WTz2ZXZtBQ9wL2I/8CAXOYOdgYAvySZ2e26pPS4fuBNwDlBQfkpzS6Q46wxtyHh72yyFrR+RhSsENZAr6EnzHIUa1A7fmne48qY2NfC/GGnoujA+TkDqVov483obRdcZkgzBZR1m4in1oikszWP4SkLjR9q6qyvHCYF5tGvUi1p4Z4H3IcgnpkteiETKmc52pHju3LwMhy8o115tqN4MaGFKl9857x/sVrKw33WHjFcMOcrxSy+cSEQEoGi1Klg4HhzBdAg1asJ9RscGXcLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prm8Z9U5BNd56bhzJhdPplS9K5f7IWV6VtE/z78w+gc=;
 b=F9XmpwkOI/mlrMl8pzadg6hBg9td+wnM6Dz1kANHp7NLRKiSuVd0ne3DljqPnlSvWEN4U/TjrrNOSkt5SS27HE1T5imLIGCSVWsxupfqhF6PTmCTEXmNdhCduhRG2AwY3UARetjgTBfWvwngQV+KNhVTn3MtZP0WqyWpMGSGWgktSr1NYxA3KiBzhBpM87kmhU5WwK3W4DWA1L7mwB2S5ghU4QVOP/z8X6DkwiFq3bWBYkMRxj/0NbjFqrWTFxapoxTHLW3mZsP73ktsJzU3s75px80IxIe0uxAdzp/NIjEsUWZf5GyIv2weza3YgZE1c+WhE4lnupJMKi+svyxaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prm8Z9U5BNd56bhzJhdPplS9K5f7IWV6VtE/z78w+gc=;
 b=BqhCNAf6Rax+X2Pr1+QXnfVgBsJMnOoEg7vPhWCQTh6Tr3bWgD3UmIz1jYtWjoEAWfAp1WzHcfWDPDHEch9s/xEx1/l5T+1iM6UeWDYB34tHBc6JfTn1X9/8KoxqrUizEjAbnGQsL5C+6Gd4DZlBEqEKbGDCyQmjgHbXdFFU8t0pYa0OHCdcimL3xIwaeVYRd82c4635f2jIVER2wHtXcfhTuPelZnFLXbmR+nUbbp4Ay+9veyWS7EifW8NPhdLEqWUixk+4OtYiLtU4qs/o7fHYcHCXcwVFI/YMzAkK6Ak6h5zPsJGb0E7UxKs0T1sSJ0cveFo9TC/ejs4At4QwmQ==
Received: from DB8PR10MB2618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a5::27)
 by AS8PR10MB6336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:522::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 21:47:44 +0000
Received: from DB8PR10MB2618.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b0e:8fb8:230d:541c]) by DB8PR10MB2618.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b0e:8fb8:230d:541c%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 21:47:44 +0000
From: =?iso-8859-1?Q?Max_Br=E9h=E9ret?= <MaxBreheret@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: What are the changes that mingw-w64-x86_64-git-extra.
Thread-Topic: What are the changes that mingw-w64-x86_64-git-extra.
Thread-Index: AdyAHjvPI81dXq3ER3mtI87nd6N1Dw==
Date: Wed, 7 Jan 2026 21:47:44 +0000
Message-ID:
 <DB8PR10MB26185FD948E083E20E69A39AB384A@DB8PR10MB2618.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB2618:EE_|AS8PR10MB6336:EE_
x-ms-office365-filtering-correlation-id: 841ca16b-ebed-4c83-6d05-08de4e366417
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VYv3c8Emt0jD2wdZaenNeU3k+w8c5aKsr+uYndjTQ8DuBSfOM86lRoAfniDm3Q6qFP75yTX0YsZIps01CHMlqJNJLLy43c75+2h5VBXRYI/Wg5bzVDalmFdgwT206MofrS7MxT3p5abiGUFOVPeDDkD8/p5sOfcdGJYhKHqmCnnTz6Cj6n/zWhtcsYZg1U+EWuWeLsUcv+X1AjlVQCCNRRKKyO+nKPTuYpNXCpKBjFagE7KNtbaxF0F10giyKHWA3TXJT9g3S/gEazWRdrVuERz7++/+NeFCPv0EqB+1xLacA27ethR1/QnYMnmVAl9lw9s2S5tkXsSCffQfqYLOIIEKb6SCdZaOkKucoCRUUsBxr7GGqKUO4VnPp11+CehhC/zjAGIxwhNkKCTproEMeogGbqrZdprKeWvtjWbzg0C0ssGRUUgJHQe8KTEFYtkiI8rteFb1IzVY8NZoVuvZqJ53wkGHlKuVxZIzKAzryWUpc8EDMOm9SW+HnfEvmz2Vj0EsF+eGxJIx3U+jXyABVR6cWWqro1gzwI25H3SXL+JxC4/ZQuAmZapi+SnUNYOghx40eiNqY8bHldqoLVfeSAzV/Y77FkeiCG3E0mjigyoX6+ubEFTkdD4wEvbt3H0PAmXx+VnqgTWez90L50YE7ArwIBF4hW4itMqnA3sdV09yWARKW2B+VRjjEAcFuyfs4K2q6uQwPSSGg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|39105399006|19110799012|8062599012|8060799015|20031999003|31061999003|55001999003|15080799012|461199028|102099032|440099028|3412199025|40105399003|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qdbKHiq35x6QJbZ+tnE76VqeOrPg39u0UFz9F5x/sRlm3ierewBm15hIRU?=
 =?iso-8859-1?Q?EDIo+7BpqcbMgbyrDH1xIq+EhYbwcNdnduTg+pjg8ihnL8WsaOsN8ppk/m?=
 =?iso-8859-1?Q?6bD6LN8JhUqmZcAcCQX+DKxLpmRiAsUCY7IXwAmmmPsoR6ZWrG0hK9q+0E?=
 =?iso-8859-1?Q?vN+4ZVBERqlo1kjqtVM0n3OIJvSPDRf/BAz51SyBLj0mLwwNGsCy7YVxKc?=
 =?iso-8859-1?Q?C7Llo+oevMyzxvNqusVJSUje8NS9+XAJH3xnfGX0n5THIsQEA/yaq0cQf+?=
 =?iso-8859-1?Q?pRcQWf/PqQ8y0JA2GAz2b1PBxMtZPO+Kq0zwvewFDUG22iergH3Kg/6kBx?=
 =?iso-8859-1?Q?DDFGz8e2zyWrvLcp6VQHVE25WN1QsDwykMTDy/Jywzlu3rSgwplPG/sNwf?=
 =?iso-8859-1?Q?YyoS6SA10BZhAPsIlNDpqzpvaN7jfT4ca4G/HP4GXFlw39/hMCgNAQQY0H?=
 =?iso-8859-1?Q?kh8aq16I+tB0uASg5vA+1+kUBMAY+iy00GkTvK2Il8LIepxLjM1DCyFgek?=
 =?iso-8859-1?Q?vQKywFSIO7iWL7fqQyVmijJTKHXxNfjcKx0YimR/Xg1EEM77Y1Qye3mHb1?=
 =?iso-8859-1?Q?kMHXJx7UaieVeGRiSBkHPd5mNwZgSKBS0t1vXGBVS8IGquk496DWZCq/3e?=
 =?iso-8859-1?Q?VdOO5hga/y6/dtzgjMTkGUOR6J6lDgbPV4YIc3iqsi1rdl4HIlvrs/Voxc?=
 =?iso-8859-1?Q?sIA6MDEk3PpYeC2sNWOY2CVc8foh5k5QICmgWMjvPZUxkwwI6nHjh8Lraw?=
 =?iso-8859-1?Q?yVn3M6p0EFSj6A6TmJzNwd1gWC8lg5D3SLhu8WYgyHJaRi5Fqzo0LXIv/o?=
 =?iso-8859-1?Q?WRmAkrEMRfWXf9ZANnYmDtEQ5KY0zXccOF5jNlAUQEf99p8a7FQI2pfKdJ?=
 =?iso-8859-1?Q?rDtSNu84KVbUKBg3aDqWoK/SRxo5DS9LL3P3yJ/eVLGr5Aw+8XLTH5i92G?=
 =?iso-8859-1?Q?PybnuUgrVa8UwaLc1+fyeKDPDDX/5HsdXKh10v2YmeThFWAowK2n41YQlV?=
 =?iso-8859-1?Q?lknPcb16MHqnKV9z/8h9kdv/+xNXn4nrWv1hToluIte0kfGbgU3r4w+d7h?=
 =?iso-8859-1?Q?WktqgBWvS+qbKHyftWvOILPULozFD47tHh6AM9QQZTeeV6ROnmfm2pYDYD?=
 =?iso-8859-1?Q?48+9X6KqAXjVGq+R0Pa26cYX66FViRAZin1buzuIOZkPBF7XNQXp2B+66H?=
 =?iso-8859-1?Q?DrYhFvvPtOkXQNU4U22l53pcXa+dM7BEdrYyeM+8Lvo/wGoW7S2TIm2zfg?=
 =?iso-8859-1?Q?XYeZN2tIf2FuX5SuBaxPOYLx4fQ8IOg/DjmEptcP+HcKL20z1a+/j+6/wp?=
 =?iso-8859-1?Q?WC2M79Gbi0xR+YzpcnnzsSKJf8IPF9fdlqM0AmgI/jS7w+DiqbsaisYZa1?=
 =?iso-8859-1?Q?1LuCt2omXa?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2+5eruWcvTHaFgTuUflRatHv2WjdbxX1B0G82KOXUx18RLXPvan0vl9WCA?=
 =?iso-8859-1?Q?EUaEdiogGxJV/kaT9gRQdqo9fjjevJeBJd2vEb7rDGXMIXsFKjSQFO6Rp4?=
 =?iso-8859-1?Q?voBc0dO3N0VP0Q6B+/4Vjldjag9oVr2qond147AoJ7dPm40XtSxEPJ4mas?=
 =?iso-8859-1?Q?az6MyPM80Su/9vM5W1XZkGGl8bMuGQ7LPkwP4q59jC8mzr7QEb9lFqP6A9?=
 =?iso-8859-1?Q?WGWo5V2XhBNk9YEXzm1yzmz3ZClJ/liwXgjiUAqD5lFtTTxsKaCy/kOD1G?=
 =?iso-8859-1?Q?nqIh/enCHAXqPhDi+5GoIQ1Azh40RIVXDwY8LFzM1GFMyXwqslRwsrEmTa?=
 =?iso-8859-1?Q?zwQixV4RDLtkLAd0cmVqQmP4GHcPYRWrbZRxezq6mP6N4nB1ljhM3zJqdm?=
 =?iso-8859-1?Q?MVQjdq0b3dzALH48/mgGp51E56IL5a7ykgJHIiMd2zT/NPRH15eos8L8iL?=
 =?iso-8859-1?Q?69a/GW92O87HnUUkFS+6b5JOYtDV9A9yFMYTS2VmWYUiox3I/DBrnehxz4?=
 =?iso-8859-1?Q?Xs1wOpO7ZxZJG8fIXpkm0hYAPfsMPUkY3ZIen9Gnu+ULOxomBhKh3vNGFD?=
 =?iso-8859-1?Q?rAaLu36jjFVV1RDO9R7ghfo/7aZrBHqNV6mdBWtyXnHSNvvPHwMWjOi6s/?=
 =?iso-8859-1?Q?vzKjySpcCns2K20luXYHeRZC1KS3L4UOEpLhViI9RA4dB6ZpEyY/DRbCJY?=
 =?iso-8859-1?Q?0boHU54nm1LGajP3jn80hkPBY1AZafDATddVVaf13MCdCOo4JkJdfDGXt8?=
 =?iso-8859-1?Q?RstjUoxZwFXwJzKsfmJF/ebydVqQRO8Kdb2sPSZEllFnBXydhSzCs+DGSI?=
 =?iso-8859-1?Q?tkeLMdhYIBiYDIFDD7ezMLxQKizjZIBhj5NKt4zkwlhPuz2uUNWso4P3nB?=
 =?iso-8859-1?Q?cphkYGXSRwLKI7LvcwwgcJM+nGiDg9lCvAF7q+sdiXeYKDtX6AOP1R7dY8?=
 =?iso-8859-1?Q?Be5iwiYLZfg46qFNufGsrzR6lLda1KahBqljs/HcRvz+nfkgkwfVMYMJ5h?=
 =?iso-8859-1?Q?qi9nzsK6QtuykbNAd1sieNJCnil4+e1fYbZjjEo7NBaUEvpoM3HlbodlNO?=
 =?iso-8859-1?Q?s6n9grNgm+/rRQExMJ6ej/LJyXFMnjDpWDMfgjYVV+HK80wkTr8Y0Mc0T5?=
 =?iso-8859-1?Q?H9eheHdgD7CAkmWYPrhDSGDZJUm2pbESdp0esbkVxg3zzKCed5BL4WxFtN?=
 =?iso-8859-1?Q?mPulK58BIwsKo/sUW23b+4nvOs0zVpu0kbKggAWofH4HFcBMe6NB920jHr?=
 =?iso-8859-1?Q?7wqD9rzjR9XOWTCPV9LztkojIgOD02y95d6Kmy0O+DTMpAdf12ES4Djc+t?=
 =?iso-8859-1?Q?2XhVZ1u6og5ouvJtbBXCFa6F7YvOfDxX8SqkcbkTrh0zFmzYKGuynSmB1/?=
 =?iso-8859-1?Q?tBpyMVdqBbmRQr/SU7Vzk091ylY6grNI30Hs97HMRQteU2C6tgld3/hJWD?=
 =?iso-8859-1?Q?6t6+tHF/0p27nKIN8OVczs3LLU1ZgxMRNZT4L8zeA02e0A9+uw62MrECi1?=
 =?iso-8859-1?Q?0rTbwtvrJjdC6xD5V1aUs5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB2618.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 841ca16b-ebed-4c83-6d05-08de4e366417
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 21:47:44.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6336

Dear sir/madam.
I have forgotten to read the warning about installing mingw-w64-x86_64-git-=
extra and am now in a pickle about it's modifications. Please can you send =
me an exhaustive list of its' modifications and/or how they can be fixed.
Yours sincerely and sorrowfully for pushing my mistake unto you,
Max Br=E9h=E9ret
