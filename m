Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2133.outbound.protection.outlook.com [40.107.212.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD239FD8
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909290; cv=fail; b=fPEQFehthCOyBMcekhD6tbTFGflha7oFZNxPuehDn64OCYgU9Vn130z2vp7e3oTQjzswx1vaUnUksLCESFZCNxsKOeXBfdmvfS8t22pMaHTOW8ZBGtToMiY79mUbwR9rhtE+2D+mH237jOBui6fb3XdR2uEVlrA+Om54KgAvAUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909290; c=relaxed/simple;
	bh=ihweUl4k8rooKsyY4RM08ozOUnLPep3ryFTpu5n0rcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBE9OQKrWEYCtxtqSnBZ9crGQMLc/fjh2giAWY1thzEtFemPrRTUP354B4Yt7O7Ee6B+lGB+XYEGoVXICmxTq9aUxDaT6RTJzdTjOu9RuXVE923IrO1yBKCg53fccPOkZOK3QSQ9INQb7ZfMyEKTICKeHfurAqXQc/EcOF9ccRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=ZyFI2khE; arc=fail smtp.client-ip=40.107.212.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="ZyFI2khE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9qlzZhyuSoksCs+H11mofk0hpKmiZpNYeR+Tp9hkTGiq6JURRNhimCqPF0mpr1/hasn3LuzVLw23D6pBiPeKQwyVqMYmAXWpteEYPe8hjkdnbAUVfsNu9xsASY984x9K1+pvYbs65RnFBgrBqdIQ4E81L3uhNeuAywsfyw/lqcRWku5U/mxfQpezf+txpHBhm8BNORD87JO5LGzh+uthgo0nCZuVOEIN8Qp4tagwB/Nj+MJDHCF+e99Sl7QFVrnVqh1VY6k2TGMVCdtg8L5lNogV02QUHb+LIYHrH7oyiCikjRcm3lcOfMChipckpCmX3tsrthKu4whyFrhs8qMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhPy7dpLBEvwgy/FEYFUd6j9FJ6WO45Z7Sj3rvfAt+I=;
 b=WmfvmhwXcwEQ08wqAxv/uKC0s1Cr/+lVQa7tffco8UTDyCTLG/Elz5m6CqDCG8eeJh5XLkVI9uywkJZh9/pmMZnHnJUn5xyPzN8pj3K8Vf4KeWUvib6yaqYs/A8t1XO7giCsludZJ3sPvbTghpaT1dowQlHtM0RICg5/fJJUjd7jVhypy8CgjlgxrhJNgyi1aHhjMZwRCJvMxoy9BULSO1dtEfKl/DpnhTHdCdnQO0JpPSjTXQaoJz6SuJhUC0CZ5vEr8DdMtibI0otvZeUyhh4EVupv5jRouofreu5a72SluxfNzkylGAT35M/BT0H4jj+21M65DOd7Pr0AUXyMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhPy7dpLBEvwgy/FEYFUd6j9FJ6WO45Z7Sj3rvfAt+I=;
 b=ZyFI2khEWXcYs8HoNJrzm2jGZTcLC987daqxUlk/TaNBRI9bA+mWix4vj/ylBOs1I3V8RZprO/cQmE6vZ+kQ2mh93bTnnQKH3wilQ0SbLmtcHgaJnZYk84HDXw75X8b1Bxby7OioA6CXgCcMfRV3XS+B5QVNOMh35mDy9+nUGsw=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 SA1PR17MB4753.namprd17.prod.outlook.com (2603:10b6:806:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 18:48:04 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 18:48:04 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Junio C Hamano <gitster@pobox.com>, "Randall S. Becker"
	<the.n.e.key@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "Randall S . Becker"
	<rsbecker@nexbridge.com>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Thread-Topic: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Thread-Index: AQHawz9/8R0mygVoxk20McqKZnBxUbHQ+rV9gAAAegA=
Date: Thu, 20 Jun 2024 18:48:04 +0000
Message-ID:
 <DS0PR17MB60311D246BF2E89FAEB3C64DF4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
	<xmqq8qyzv5a3.fsf@gitster.g> <xmqq34p7v4x1.fsf@gitster.g>
In-Reply-To: <xmqq34p7v4x1.fsf@gitster.g>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|SA1PR17MB4753:EE_
x-ms-office365-filtering-correlation-id: 5eb08852-e0ce-4b20-d2d8-08dc9159848d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OOKCmMMFhTn7xCvRKcqfP8KUbRFT7Z1vC+BEC0/fmeOWUmuM/Rfw0kqw+0v/?=
 =?us-ascii?Q?nUBF33N4xTRAIbPIdZkraca1NNXRKBQB1996yZgWu6QjIaxcaYqGi4D3LbaH?=
 =?us-ascii?Q?vQePZ1OcebQTZl1q//RODlcyD5XbEt3KYvPVNbl9MiL+iRO9Orsmc6EhGGKw?=
 =?us-ascii?Q?2ZaItSecmo1PYyi9LP5kiomKiedKKdncgsplZFe6gTY3BbvDK9ODd6slUipD?=
 =?us-ascii?Q?xNl6JqbOssxiSHfcRpilbrh/uroJh5qVro6tCJ2XRVtbSE7Ghy7WgESUGLr5?=
 =?us-ascii?Q?2fwgZ0C3IGUd6qTZYzsr7B7a8ugJV2AHVZXz0ORaSL3TcJo+4b3STBR9OHAC?=
 =?us-ascii?Q?C+M28McdUWqJaCEZnQ3wxkvNO5UMX0Gk19zrNRoXcU/cXZRiklWPLukICrDC?=
 =?us-ascii?Q?h9iiXEVl/3xiiIq0HfNLlQEONw9M651lgketIbgHiiAwqHVud6I05BUonr++?=
 =?us-ascii?Q?0sYfF0HvbQRAYy0vnwtzCvFVWCiGeW5B7avyEYsLlPHwmxtkC+t+CwfoOmHR?=
 =?us-ascii?Q?yTMhNkNOKp+jz0kgAiDDlgM7dqk41bgR+uYGlX+SFVCN9/0rz/QFDTie8Qr2?=
 =?us-ascii?Q?n7lbd3WNljlLc9tuB5tTjL9igUE2D1HOsKn7ilgPwlt/LBgJiPHN9nvovew5?=
 =?us-ascii?Q?m1bC2kvHsVzAq00wTFpTdc8BaHM4xnmtTTPHgp+lJ+MLXfuuMf/jnnU4x61T?=
 =?us-ascii?Q?2/RBREA9tVMsXmZM4fAyRx+n/gc+7hZDv0ilDXOv9utMgjVR1GVHFuSqFUUo?=
 =?us-ascii?Q?NpKvXdC9sO0txH4yvt6lsqb+CY1h0FvHSNeBwP7zfPOeCU79HbkondzgOki0?=
 =?us-ascii?Q?2jRrdfSoVvhBnoCvcVvY+AT/hYSm3nwBznt3UyDKxFEqZUqElfJFh0J2P2E8?=
 =?us-ascii?Q?Ryr1lC64ho9yQnSVXdFLYu8AKsUvPjUGRxrQCRt+AZT1tjuNBYS1uXzRPfaD?=
 =?us-ascii?Q?+uzFWgNgAy/xMqzXOKjGtDI5RF321gbjFa2Vst2HA6glOaQm6XYuAVmvhW+U?=
 =?us-ascii?Q?AIJEN5J7Q6AkigbftnoATPOj5Ah8f0tSR08hwyR5N2bk+TnWut7QMmr0/4FL?=
 =?us-ascii?Q?Wg16RCv9I3PqHhCluncBXH45AfkfxNmyMUJJFCMSnhNtNfcjDGPEnFNcYUPk?=
 =?us-ascii?Q?J2KMCM34rweT0CQZfy4sKlvewjpBzN5lo+Wi/htNRnudcBCBrbe+LrjrPZjE?=
 =?us-ascii?Q?vyK6jZ28YhSkJ5Fzb120lmqH6mxPBtE+qfoqtQ8/wf8w0Iga9MxfXasZW5m4?=
 =?us-ascii?Q?Zu8QcRkLpPcxOsqzVf3niyCxTv6ux75WIV6+QtFNEVTHpNTwAUt1AzR1idUI?=
 =?us-ascii?Q?L30UY4jwf1WBqS8YSDJZPPY8H557c9HERQ/OoifntUeCeL6XIWX5Moz04a+D?=
 =?us-ascii?Q?AJUghxM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EtXUf3SezOKf8WwlGjdQZqV2OHZjMt1G8+stX0NFzrNiGqyK+Eq9ZmQiGFkQ?=
 =?us-ascii?Q?VLMbZdQqSNODhRHY9nThZGGzGubihrHBzUBbzuAy8OTHAcvfwPOCRa5uetIq?=
 =?us-ascii?Q?lu9CQuYU/jn60VdOvoZ4IQl8FyyKgKYR0AN0GXEOeuN4O/j4e5LR+5YeqyNV?=
 =?us-ascii?Q?mfDuks90cJOgZOCixRPGLkP6diU0Mo5cfq82FKPHF8pjrJfSNsdk4phJlWFJ?=
 =?us-ascii?Q?VzzJ7/lY+F3Ft+hU5t9pDFZ2RESDmUVrK25ziUxlUUNVSf+uMn3Di2r2zOi4?=
 =?us-ascii?Q?yDXTuFGourpjMHGG9lTfuCdwnjo9iBCoN96mf2VKTj+pmgxTnwvI4oep99Ts?=
 =?us-ascii?Q?p99nnmO6pBNTIt/eNyodJKRSRTQYidXqeRbJX7KCJV6P2wT5VKGl40Ta6mfO?=
 =?us-ascii?Q?b2f6eTRnQHnqykpkLfeXVO2nlmQ/Qy188CRrM6bVXIKAS4MBkYFha7HSGw2b?=
 =?us-ascii?Q?+zCsvLWdeYgs4le3okVsycrBJ2pmVN+qVECd4Y7nFzolFSSsDFBP8ubuERmP?=
 =?us-ascii?Q?r0b5ZcNeyppFzISeERwq5DrDi2JXgwz2R4ruxeQpGuI2b6jzgrpeAJ4L6xZ5?=
 =?us-ascii?Q?j6mBsEPrhI4kiQsZfBPvxuTGxygsxoS9C2xS/LV8p0cPtG/44+JBL0i2qCqI?=
 =?us-ascii?Q?wXK+p4i0v5qMPOPD+WRPySYHGSEhi7pjz/mjktTc/dn7LXaM8CBtrpgdVhyd?=
 =?us-ascii?Q?iXjV16Ml6etbjbHugd4A2/6F1brfehkuEGWQYbTmGOMr56zyhuHgosJiluf/?=
 =?us-ascii?Q?96muSfc8yGHfdHT3zyZlbCpquQyDaDO2K4GJOTnc5FK1yst7vIPZDGJbvb3z?=
 =?us-ascii?Q?IEyiIAloVfXuTbJWGElWeX2MR13eP2pDnzX9STSvfA0HNDnL73Tu6B2s8iYI?=
 =?us-ascii?Q?RVleqcZERiIB3141t6gCtnDyRet1UwnGAHnhp6OLBaoFsI2jgb1GK5yshiX2?=
 =?us-ascii?Q?5n7GllNDP6S4/4QCQkLjGSL6htaeSzTfE71QcWmHOim3RDN6kCCqD3pJRTXv?=
 =?us-ascii?Q?o9lKQMPxHreX9fFkQR8+O43XlGs7KFCoP0A8Pgtoz1OsVFxf3TIOsfXBmVuk?=
 =?us-ascii?Q?o6GX8/ov+xe1OaqHWY1Z/Az5uxlqQnSp3h4e6MWK4Y+8O3+7GjyzeFbVj2SK?=
 =?us-ascii?Q?qE/WqMw4dBRGbfNoLYPW5r6DnPI+gcAhyBOL4CIDYDWqAVMR5Vm3aROkUeW+?=
 =?us-ascii?Q?e1//aLTdQsbjk6uDe5DDynTCoJq14bBXmpl29g2fqhf5vsnXlt0F2xVBR4D2?=
 =?us-ascii?Q?UApx3KjW2LT3004/vH5ByCPTWWZIUzEm4EeeV850tphx2KAJ25zY8BFXGVj4?=
 =?us-ascii?Q?imBu8Pw1Geo+C+g/hpWWtjThSuqBxZ0zZ/y31HDpGXr1domYkAC+p8/726lO?=
 =?us-ascii?Q?yKGfw1FWyGJWSzM6RIVB2Ux6BH3CPUAwVFvLnGoGS93cpeDIrwqS3CLpQYiy?=
 =?us-ascii?Q?uUSvdaOc3aNAnzQ7izMxAah4BblsrYvezsAmTIUyRUWY8ncBXyBMmcAImIw0?=
 =?us-ascii?Q?yVKmzx1d4K1jymm6XGGOfj/0nhvLmKlYu5TeJkIsnXgneCzVyTNgcruvoBlX?=
 =?us-ascii?Q?86LfoJ1YG3VHoP+99ebX8+jW+58ql+0WAZ2XEwEPLoe/wJBaKGyAgp2raqOf?=
 =?us-ascii?Q?YBPgua6Gou+YWGuv+PdkjIKuSZMVOjqCkCRqO+2W7HV/vEluA+HAJvKt9yGb?=
 =?us-ascii?Q?fZ6WpQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR17MB6031.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb08852-e0ce-4b20-d2d8-08dc9159848d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 18:48:04.1396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AA36kD6xo6+YHHOQSeX+66hvXICVYTRMKI4Wu5v8pnl4LjzJgbPwxPenMTacHNyoUeZXSKGbpAUR2URVR/eVF4eFXOq1i7bPcHwHPIwEbi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4753

On Thursday, June 20, 2024 2:35 PM, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> "Randall S. Becker" <the.n.e.key@gmail.com> writes:
>>
>>> This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define
>>> supplied for this purpose by that project. If the #define is not
>>> present, the version is not reported.
>> ...
>> If some unknown version of OpenSSL does define it but not as a string
>> constant, it would break the build, e.g.,
>>
>> 	#define OPENSSL_VERSION_TEXT 2 plus 4 is 6
>>
>> We could stringify it ourselves, but that is probably not worth
>> worrying about.
>>
>> Will queue.  Thanks.
>
>Having said that, we do link with and depend on libraries like libcURL, li=
bPCRE, libz,
>etc.  I wonder if they are also worth reporting, and if so how?
>
>We can leave it just like any other new features, "if you have an itch to =
see it, you
>can offer a patch", but I am wondering if we are going to get a several mo=
re, we'd at
>least want to standardize the process and the output (e.g., do we limit th=
e line
>counts to 1 and line length to some reasonably low number?).

I was thinking about those also, but this was a minimalist implementation (=
opensslv.h comes in via git-compat-util.h - so I did not need to bring anyt=
hing else into the code). If anyone is interested, the libcurl version is i=
n curlver.h (LIBCURL_VERSION) - but I think it is more important to have th=
e OpenSSL version as this is an important compatibility indicator. zlib.h h=
as ZLIB_VERSION (text form). I don't have libPCRE, so can't tell. I can do =
another series for the others, but those would impact help.c includes, unli=
ke this one.

