Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08922DA01
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535688; cv=fail; b=S1tu4N40HIPjvI3yW1/EG7i/ymCXJRw0yLRQvmzY7SdoHWvtrgDmMHiau1YtWrpLQfVTguGxTQUu007Md/dLdNTLhI/xYxbnhRm8uY+qvM8uUIFVfIEUFrRJWPIaTt/M4+mZoX9Z74Xk7PYmxKhFSDna66Zp5/ZSyV6mIW59C7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535688; c=relaxed/simple;
	bh=wDA7JQLDk2yy2iyByN3+8dSso0h13A4Pnwe82RYOiJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odP5v8sm1ZioAj1RStQXXxDFXFaMQpGutYQg+z8kE64DVOcqXTxwM67nNLHbZwgeXCdxjA+qZn5XmKL33wWHBl0kog6CtDdFWBBL+h3IJHGbMZahwxJx+bjUbR/bludfTBLQwmghdbVcvNwMN/fQItRkR8B6QTU1JfTanFJCM6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MNVrLpMc; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MNVrLpMc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQN1nPrOAje41c9Z3dy4mqXpZ6cO0pra+YRdHo/NJxgF1hvMYov2sMVDlGJj4W8KPRHyIk/ycI569rXuHBTE11UhMopgcBcxStwHo3O9dJchCKCUgtZ54ARBAqlvVd09QrxiVg1kQpZVX3sR3KVISEwdWEexd180LexHZLypJWHXvmU34s2fYf2/avRxptQWbq/4jyoPb2xxSmoBZVo/kjahiy1hVaWET5iSUlY0X00861SFSNe9riRzK8OQGV0yQv9EY0MS54rumln52f+lHiOn6jOv/K6EtjHGWGnTepgR8CAOCFJLmLQHi4UohM1dSFEQMHCxYp4NvDuIVJyk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nURCxVBPv4cnvRRSUOE48eH5faQdEVpOdKylFkxTeQw=;
 b=rVdI1SJIBiI2brF27O74mRLYrpyBtglxsmrKbGmIK9GfpuQk6gb/HOzjKvuN4v5DPfG9Txl1NMLOgW2SEGfXdnWc0DmXZB7pJENdL9C/GJE1AHZKyqF9Ic4muYcpigrhpO7slCuG4M76h3RBFdnA2fokJxNtCoHJbmy8ZRBz1yNgqeemE6BrFXpUjs9HKT+6flafLNHvj8R99H3/5nrXYPlwyqijsgmqZKJT9/8J14Yc7/uWVeqBmXgQ3yrVgMHjKcoK58P2R3hJL6ymFYYluws0mZtZ7sfxT8/C5+HnUAsIkk/k7Txc6xuhijW2KvCUAsJtq9/PoHadgXVT5PR6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nURCxVBPv4cnvRRSUOE48eH5faQdEVpOdKylFkxTeQw=;
 b=MNVrLpMcvkH+1V1FLLYnxKpEmXW78N7y9i4GQ3/gsZw/ynMv2d8+yZsbyt6mcYwzBcECCMIT7ipVdkN+KFHIQxAHQBYT/ZO1i76whGk/TrcgMZJPHkLBagu3VopswnAOzMI2mR3QX/0+KZb4n41C+4ry0jopU+0fcTBE62k3ZxWH6Le6v+kpcebEzbNixtFAq8xhDOP5Z85SDBi6bA/TkS00UPyGjDT8S5flEOXm3Vy8Nds7HVo3h/RjHCcbA6HqyBQxqov6Qz9cXYMix1Iqjqltr1isFxqHrXjTdgWxmjzT7oTwM23MnFq2xCxCEaqQH9uIyLnBrVty6dJbhT12QQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:16 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 9/9] imap-send: add ability to list the available folders
Thread-Topic: [PATCH v8 9/9] imap-send: add ability to list the available
 folders
Thread-Index: AQHb0LWzIhSGBJkerUW762vjDhdcxw==
Date: Thu, 29 May 2025 16:21:15 +0000
Message-ID: <20250529162020.45187-10-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250529162020.45187-1-gargaditya08@live.com>
In-Reply-To: <20250529162020.45187-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: 03ba8882-d15d-4ed6-d7ba-08dd9eccd623
x-ms-exchange-slblob-mailprops:
 BP6inkMtVg5OhxqEuIe+Toz6TZPlcmhHdlngZuR5j7tJduWncUS6wnvtOCxSNujbOmPVPkumf+vIIND5BDUPj3CKZUPvVLBCkpYs7vD0MoxVpCsN8kXn1oP+W5ev4vVQp2On3h5bwQh/O9SO3nJi6SOc3loTE9lbn2VsxdKYBiSWOFoSkOEVnxB91FKQPLbXQ/BIM5e3QysoDO1HDHpjhaAFq2fRfiLEuIIsCmCa9sQI5KTRUuBckxkVED8Ij1j6oXxjLkQz8KMEyHRUN5N7z1//2TNsYBWN3xVvGqeJBSWS866Gj/hJTrtcKJjrC8dcS9DQqoNAJ+YaVUZAA6nXv0TUZiULHYx4lX2hMqCi25k4zB87SEZmdQwYpFetMc/JP62fOUxz/lk+ENt1+wB/BD08Jl7NeY/l/aSX5l3gt5TsXEc1D1IY/Tbrs6Ta0SFsqtdKXWIqGBXfoYj7qT2S1OgdWBF4tVVmRRsuYKQ0ydVRWDWVlSWfMbZbQSs/44AOa/tDjteApnizoSpTeP/mWQF9Kd9Qq3dyiJPdJ1MTltZwQ1j/EHGpQx0ob5BdF9mvRmGSJoS0xuDDdgUAcl9QWQQf6p8fvHYBzwe3j5vlwm2Xb5lSXX9Tpnx0zPKvdQMwYM9nPoaIOTMOSg5Y4N7VG2pBJwJE/AEhREONdgWCfspUWVTcnGlJ0boWCm7F5ne2oR6L5mwtczpSnk8Jntb2LrekSrLHFz7TxquztG/sc7QKEEaI2fZircUO29VNWHO8BQjXZhV+4cMYPvxEEYRlYepEI5JJkumI1Qv5jHfDzMhJ+XOsVaxmfh8J8amUn1vAJpHFGV1kqh3hneHM6AccuN46MQ1uphkBoYjLBxvKR2w=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|12121999007|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|1602099012|440099028|4302099013|3412199025|10035399007|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SATsQQbM270XsJBoFQh5/z9CWypgP/mmmGgro81ebD0DfrMI5W+FAH6NBZ?=
 =?iso-8859-1?Q?rASpRbP5OjmUqMg7gtR4cJt84Zc9DLhsGn6wrgsl4Nuff2rYFzr3dZq5eW?=
 =?iso-8859-1?Q?IFpeY2nVlyRhuEQOKYIyV3XoYbTZIPcAuJHbSgIImV25k//JNImZSkYwol?=
 =?iso-8859-1?Q?Krq1xaRqNP4lEYfbFg10waUCAr3n+JGG8bOtTbFJxFbvjEFwrhNADD0O12?=
 =?iso-8859-1?Q?J6tJ8ZxvJkL6N5NtGLtYqqHGDXIC6vHsLFksUCr4na0df8X3Uqu5E+ILSS?=
 =?iso-8859-1?Q?3NrY1Tc3GThdB+/GszMoL9MbjusXxbGbyEpNcfhIs6TU6IyUzO8FhJp+Y9?=
 =?iso-8859-1?Q?BRkTEKD9ZaGGyljujJfb9rqxMq22S1GZz5q0asjh8ip7AGp/s9nf4fJMDi?=
 =?iso-8859-1?Q?A7vT9qCPEOLWSzlAUscwDopncDPKxDFs0knoF1IqTcRBZz4id/p0XAlUXp?=
 =?iso-8859-1?Q?IiySDHJsc0BOcSrF4GtQvLG4owUICZWbnvPT+2/b0ud9GrNh8z2AYRe4Jj?=
 =?iso-8859-1?Q?zVEwGRSWL0iit5Ti1ovdtGeo4cPS2JZ40KqjJ9i4n9anUFE8mHa+IMheuf?=
 =?iso-8859-1?Q?wFIpHygwy8iHC0SJAZ3bkt/uhZPWhjSExa8SrCARPAnlsrBIm0ZTL/c+8o?=
 =?iso-8859-1?Q?CQO2ZinUCnOrajtcrJTOwiGEMwOJLKejeJAIilP5PufibVVAXOahtIjbg3?=
 =?iso-8859-1?Q?DkzQT5GJdFVDpvDgGGaMwY773bWD2f9r/R1FTDwriKe6U2Ox4Eeevr9sDX?=
 =?iso-8859-1?Q?k8XvlO4SAYsQ7MSHbt9Ay/lXW8TR42RvzvFralmxfa0UxUXE47tLtrnIW1?=
 =?iso-8859-1?Q?ejjxcIcz88cjM8yyFszvISpmH8osR6d4CSo84JW3GdlsGOaKCgB35GIvtU?=
 =?iso-8859-1?Q?FtJj9lWoAEImpnbT1xJsecd5c5a431rabi4kfSB0jlk3Zow9VsXaDRiDWD?=
 =?iso-8859-1?Q?IWpXsieNXx2skmqRS1MXZhLrYZEUrCqgRgEzs/DD31ljHQLVdl53TcVn2B?=
 =?iso-8859-1?Q?wMgKRsYIK4vzWX24iNKEfor05lFiQlxZYRdpUZ/4SN/KqMzqgOo/NZ/HJy?=
 =?iso-8859-1?Q?FLJt49f7tFWK0amBg7Q+wr+tp8IXpo7Bh+/tLJkUMRORYLu6UwAQx31c94?=
 =?iso-8859-1?Q?CsaPI5N/Xpniy98/qL2glqX0srw5WeEBKDSsVS3q1roTdlN+U8SBSsVWXh?=
 =?iso-8859-1?Q?H0vvkFZTRRa6PoIHBvBxfrf+/39WgPXx+44asm9ie3Col+onlNYvGfqVD4?=
 =?iso-8859-1?Q?cE4wp1bav69mERJpSFFHxR012UTBpK1MW8LpEnZ1pZ94CtHY9pvy6Ci783?=
 =?iso-8859-1?Q?U12WLCZ6LY7jV45uzQJ7DlmrDXcvuqOhH4AyDkPBVBpbenCgzuPYESy9WY?=
 =?iso-8859-1?Q?VoAQr5TcVeVTUEajbwlJiCpDGp7I7hlAk+TXGcPlSi2LHTLJ+pJZU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vZ/5ou7RP6LW5fzOe3uJLFDfS6AYjS639lW4rXG5huUamHwPzOXXbwDmUm?=
 =?iso-8859-1?Q?6p+1rwJ1J4sXK5+YOvNRY7oYXPffvds7hPAVUgVzlNFsCmUksLyC/xX/ea?=
 =?iso-8859-1?Q?ETr+3nG2AbKl1HA+qPEChKcQzue/xIT9AhZVpnlwipC0DujwqsT4vkfm3t?=
 =?iso-8859-1?Q?ut7Iy5TOiRLbqnp9GMIbe3YR78y7AyAm94Y8XuTo3+7wiHE7ALl/R0ijkE?=
 =?iso-8859-1?Q?iT/gi8PDjS4jp5jiEFTrjf6H2dKypOkPQv+5BIKZ6Z/iNvxpe+fTOu6+Mv?=
 =?iso-8859-1?Q?9fqRoA4Ckx7MbB8MsyewvUiHMoaGbhYeaX1ZMwT/ciU604Lxs6N83rgyAu?=
 =?iso-8859-1?Q?6W+lpBteLGT2flVoUSQgEIfvP7a9MS7VzmROQsrsX3le3ixB405wkioEnp?=
 =?iso-8859-1?Q?LyGRULrvBBMTllNs4FRDSKjvd/fomFZolocvsMdYKiSupbrGdLlcWkkcqZ?=
 =?iso-8859-1?Q?rXQp70TUSVx/hXgrglX0x4fPK1RUcNev+o9vBQ6uKVTQTP6/3wQpy/BS5r?=
 =?iso-8859-1?Q?V133RjkPzbD8LFq5z5maQLU7aryAPs8wwQp8vGnQ7qeK3h/30fuPSwn4iA?=
 =?iso-8859-1?Q?u/Nwy+jwzrdM4iKR/UDYNf8k5auHtRPsog2LJ+X25M9lhhsQIntvHwCnnI?=
 =?iso-8859-1?Q?u0HdpG1oPd0BlW34BxZFwqdJ9zEL6hHXTwPPIy8AX2GxCkC+QfBS3fjwwx?=
 =?iso-8859-1?Q?v6BldZM7Pt/VUiSWsbqA5DgfPC0OWqfHHwsP93JP0RIBPBphrcE04tVK0V?=
 =?iso-8859-1?Q?fIE6kp7Tl2hDSuC4m228AejkEsulMgrq108Celbc9M5yYxOZJck3FvlXeL?=
 =?iso-8859-1?Q?+29o2nN7ZtKsQkkUoypUNij14DyNnPzb7UDcoPma2vkFXU0NOLizQe/VB7?=
 =?iso-8859-1?Q?83UpTXUI1KVXlHhIF+tO3lakfb1IQ7V9t9cNB6rr8tMDONQjFPjAr/R8np?=
 =?iso-8859-1?Q?WOb8XjUGrvx4o83kt7XRjsDem+vpkT+4Tu7Tvf4zASnUooRwA5qYUxBxJC?=
 =?iso-8859-1?Q?zFlD1SELcqdNQfeRZ3WasmXrJk1J8acWKYjHymcWGzObRdw10JANK2Es7B?=
 =?iso-8859-1?Q?Lksf5UalacELyfTB029JZ53+9ofHbRLzipAYHdS4g+cVJoV/Ujm7eD41eo?=
 =?iso-8859-1?Q?3RYeOhepdwf7eLy8iVxZmMkwg5a9omYyQn14hecFGi9u05CFYhSBHBd19f?=
 =?iso-8859-1?Q?snqoo2Y9PCPh8gFFhb9phkEIc7aoBjQwxTfiar5R+kqJxndYrP87xIVYip?=
 =?iso-8859-1?Q?JUjlWtqnGxObPLNyCFqjlTONzqT/pYePJ44PLNR+I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ba8882-d15d-4ed6-d7ba-08dd9eccd623
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:15.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

Various IMAP servers have different ways to name common folders.
For example, the folder where all deleted messages are stored is often
named "[Gmail]/Trash" on Gmail servers, and "Deleted" on Outlook.
Similarly, the Drafts folder is simply named "Drafts" on Outlook, but
on Gmail it is named "[Gmail]/Drafts".

This commit adds a `--list` command to the `imap-send` tool that lists
the available folders on the IMAP server, allowing users to see
which folders are available and how they are named. A sample output
looks like this when run against a Gmail server:

    Fetching the list of available folders...
    * LIST (\HasNoChildren) "/" "INBOX"
    * LIST (\HasChildren \Noselect) "/" "[Gmail]"
    * LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
    * LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
    * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
    * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
    * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
    * LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
    * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"

For OpenSSL, this is achived by running the 'IMAP LIST' command and
parsing the response. This command is specified in RFC6154:
https://datatracker.ietf.org/doc/html/rfc6154#section-5.1

For libcurl, the example code published in the libcurl documentation
is used to implement this functionality:
https://curl.se/libcurl/c/imap-list.html

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc |  6 +-
 imap-send.c                      | 98 ++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index a35f278baf..24e1459f5c 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' --list
=20
=20
 DESCRIPTION
@@ -54,6 +55,8 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
=20
+--list::
+	Run the IMAP LIST command to output a list of all the folders present.
=20
 CONFIGURATION
 -------------
@@ -124,7 +127,8 @@ authentication as described below.
=20
 [NOTE]
 You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if you =
get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` t=
o get a
+list of available folders.
=20
 [NOTE]
 If your Gmail account is set to another language than English, the name of=
 the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index 95b78fda42..60562dc9b8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
=20
 static int verbosity;
+static int list_folders =3D 0;
 static int use_curl =3D USE_CURL_DEFAULT;
 static char *opt_folder =3D NULL;
=20
-static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
+static char const * const imap_send_usage[] =3D {
+	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbo=
x>"),
+	"git imap-send --list",
+	NULL
+};
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
+	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server")=
,
 	OPT_END()
 };
=20
@@ -429,7 +435,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] =3D=3D '\n') {
 				b->buf[b->offset] =3D 0;  /* terminate the string */
 				b->offset +=3D 2; /* next line */
-				if (0 < verbosity)
+				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
 					puts(*s);
 				return 0;
 			}
@@ -1619,6 +1625,26 @@ static int append_msgs_to_imap(struct imap_server_co=
nf *server,
 	return 0;
 }
=20
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx =3D imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "Failed to connect to IMAP server.\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") !=3D RESP_OK) {
+		fprintf(stderr, "Failed to list folders.\n");
+		imap_close_store(ctx);
+		return 1;
+	}
+
+	imap_close_store(ctx);
+	return 0;
+}
+
 #ifdef USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *=
cred)
 {
@@ -1647,11 +1673,13 @@ static CURL *setup_curl(struct imap_server_conf *sr=
vc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] !=3D '/')
 		strbuf_addch(&path, '/');
=20
-	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("Failed to encode server folder.");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("Failed to encode server folder.");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
=20
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1681,10 +1709,6 @@ static CURL *setup_curl(struct imap_server_conf *srv=
c, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
=20
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1703,6 +1727,10 @@ static int curl_append_msgs_to_imap(struct imap_serv=
er_conf *server,
 	struct credential cred =3D CREDENTIAL_INIT;
=20
 	curl =3D setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1749,6 +1777,31 @@ static int curl_append_msgs_to_imap(struct imap_serv=
er_conf *server,
=20
 	return res !=3D CURLE_OK;
 }
+
+static int curl_list_imap_folders(struct imap_server_conf *server)
+{
+	CURL *curl;
+	CURLcode res =3D CURLE_OK;
+	struct credential cred =3D CREDENTIAL_INIT;
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	curl =3D setup_curl(server, &cred);
+	res =3D curl_easy_perform(curl);
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	if (cred.username) {
+		if (res =3D=3D CURLE_OK)
+			credential_approve(the_repository, &cred);
+		else if (res =3D=3D CURLE_LOGIN_DENIED)
+			credential_reject(the_repository, &cred);
+	}
+
+	credential_clear(&cred);
+
+	return res !=3D CURLE_OK;
+}
 #endif
=20
 int cmd_main(int argc, const char **argv)
@@ -1789,11 +1842,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
-	if (!server.folder) {
-		fprintf(stderr, "No IMAP store specified.\n");
-		ret =3D 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "No IMAP host specified.\n");
@@ -1803,6 +1851,24 @@ int cmd_main(int argc, const char **argv)
 		server.host =3D xstrdup("tunnel");
 	}
=20
+	if (list_folders) {
+		if (server.tunnel)
+			ret =3D list_imap_folders(&server);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		else if (use_curl)
+			ret =3D curl_list_imap_folders(&server);
+#endif
+		else
+			ret =3D list_imap_folders(&server);
+		goto out;
+	}
+
+	if (!server.folder) {
+		fprintf(stderr, "No IMAP store specified.\n");
+		ret =3D 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("Could not read from stdin."));
--=20
2.49.0.638.g602e07a80b.dirty

