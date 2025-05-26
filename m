Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED7213E61
	for <git@vger.kernel.org>; Mon, 26 May 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274714; cv=fail; b=jFbk44iomzXLkL9/LzJg3cwfRHQGjWH8piqyfxG4P5bMiXxelA2UnWNfQvmJensTC/h99/jHO81L7FF4XcXtBp7694wRcBmx9EnXWWipJdcNLwdsbY9tOOFTfrZ9ZmpY5fV+imxmUjD1KuHQM+3+l0g+ushu0AK3aLDbm/VrI4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274714; c=relaxed/simple;
	bh=BnHeMHISHLW/fS0M+CAX+O2x2sy4BC73U32ZL5n1ZaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lv+UZvNXWOXL09EIN7bvXgvW+fZcglbPbb0Hdupnssi3fbq8FOOeG2w4BV/lIP+PYSH+T6twWam9U93hs3MfpLS8OmkvlG41cT4u8+fRjsmCo8vAyWo/LcinKSU1ExYrUIoiMbJGoZ94r3Is6NxZiRkMMSsbpoT4YIwgY08KTuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CvvTI2Ks; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CvvTI2Ks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At/liGahoes6djQveke/pZSQQ2frXefem9bCjD6wnhYSvRR+cC0Jh2ykDqq2uh7c+t57f3bKWTISbDELvk+gzf1I/q854qHDqP+RfYUxbjbdYfBCRkXgBlj8QFK1rFl/9vKnaIuCxobUulYs8pV/7zW5SJ185gT5S5EvXGu0MGs8IJCzqKANu1NINdfqJipfJIVLuNfMAuYuc1OBAIvNFuuXAg29jRAQSvicYZ4E/smctw88/17fam1vRqV+QCODzcCZFQd30D/q2sIIJYpZh651ou3SKQm0fC7+Omxguu5BhxkwsCgzaH+PKFINPdWBFN/dOvB13aJrrhfUZYx5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VoXv+1RTytb8zCLwk/hpX/AJT8mRtoSdNknDmbCtyg=;
 b=oom8j9Ua5ajTm9AQGp/xKhJrHYj4JC7d/dU59O8IpSuFRh0rteL2GveD07UBDXUxrQ7nc3bEyqNzMeF5521n6EQztDMK2vgn6go2nY9rvnQ+T5ftpqK5b/o8UbweY6W9o2m4EyGVgP9v0v8zyDPG2Mp0M17EZFFe2B6ReSrug+LCGQwRC1spSzJv7MFz8RQdPVKqX4EetmvHXIeUeTaWkRWjcCE7/OXPGyxRK4TjvultAxnYfPj37YlFvxlrDJi7au3uz+LDMgJM17fMY/IH4OxQm4mwCCsy28WMKYHsv8agC3ayJd1C6Ux5RFGXGFSdmAkY/S9UDF9itNzzi0K7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VoXv+1RTytb8zCLwk/hpX/AJT8mRtoSdNknDmbCtyg=;
 b=CvvTI2Ks09JoDRkfb9C1Q3FXc+gGXc1OhpmlB9dlqsziKHbSqlob8QOf2jgW2iEg4xZwXatzw6aPhOOHprk0ePDAJidr+17vr5b1jyc0ibHlN8JCrZkCtQk1IzZjUFqkFVHzqdN7glZRh30uvQDlwqvcd0UV/yeBqaI4VrS+gr4IShBf06kqWCRfLF68fqTbWNdfK49rkxCLVjy6aNDcyU2CbT9FXTZerrAxrZTY6mpOzxCQG9zJKbua84LN7cPEtZkLurf1n+NSN2cJBG3G2axyUyEMh0jLxb0vweCzyGNoJjv6db8tZZW0Komb0LYYXP4+WMTh7uAp/11FQLFAgg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 15:51:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 15:51:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Topic: [PATCH v4 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Index: AQHbzlYVSJk3LNskwESa3DNjAvbRPg==
Date: Mon, 26 May 2025 15:51:45 +0000
Message-ID:
 <72b3cd1bfbce5ce6d82ea549445732b0caa02bbf.1748274404.git.gargaditya08@live.com>
References: <cover.1748274404.git.gargaditya08@live.com>
In-Reply-To: <cover.1748274404.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8258:EE_
x-ms-office365-filtering-correlation-id: 072d96a8-ab80-4787-c2ca-08dd9c6d37bb
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnTsIneCeLMabZSXvknuFjxbW+Fq4iY/VYXkyEu2tHBttNMRCXhQgamsk6GDL9oe3cZQNde7/845Qgf4wdSIcVNHNNT58ICpl9gU+JSbqU+wERDdkzZNFaYjrlDrlLJCtkyhjQgpeNpk0wrlqpl6fzNFq+q/F97pLZnnXTeBx16V02fZGq6jo84Azii+VZq9cMl+7Nfxj6U3Use79ELkaNkjK+qJc8MRNnuSRhjck0Cn1koIs893V3OPWy0ZRaA7RA9KqMppy8ZtYQkjbT+pCVLeJy7720Vd34/VQaDaYnW1EHPF3X+9BPswlEUD34kwJ7yH5rPe/kwsKMNZ1aUz77O0M/sjOM5NXmAIHuRN/aulHHHD67QLAPAwZIpwg9F2SfPBZ/3/YlP6YdlJ5+P1mWCjJHfncBae7p9OWUag0wTgcoo8EE7hseftYbq9W7WV6jSdHCXMLJ5FN95XI390cPFXUOP3BUDe+B3wgOIwfzePZRhKDM1t/xZCerRXtmHjRvb+Sti2yq+DJEjrbzGbyQKXp/7Y3t7AkJqa6TGGIyqvG/m76LP0sEDND9xFAGAOmDYg7h2LSIOoe4mlVQjR5mDAZ1Js3l8ncfpZv9KXBzRmuC9NewVtmTsQuV1XBfR0aGQTDMOi06Y+f4QFaBD9KeRE8XDjuPqvxu+kQIPzKKIIKpBRvXewe4owCqUK0DOSEQvYHeQDls/CJf+B4cjG24HwnV+48lgzssRQSTF1+gdDE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|38102599003|12121999007|19110799006|7092599006|8060799009|8062599006|461199028|19061999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X1nBoFSqDy0S5Z8vdNaBy3IkI4SYMjzRWnNN9y9XRGDh4wD+R4YWjbryzt?=
 =?iso-8859-1?Q?XXlKFRzjZGi65wnbjWc28Cdl3FoMMdxL7FnSyvB5AZC4bHYTKqN6ZBt7jb?=
 =?iso-8859-1?Q?vQc/uLablM6V2yLNl72TPCGTE4nCZjKJDJ1b/S+hBqkTSGu3Na4k8kDfdN?=
 =?iso-8859-1?Q?or2ouoxgFYKSOKYH6L+cnbQcbGKJL2t8UP/26WHJV6I/RV5ZC6tPY8aJ7R?=
 =?iso-8859-1?Q?fAv31lCGj9NuxEi4uO2owy5ALMYlUiW4TEQtqjZWhpJTYhQyROlOyFE2Yv?=
 =?iso-8859-1?Q?bT9Kd0YxX/LLFhFExuHwtKOqzFLzDbvp8Q/zhIox19pCEIEOCmkn9wShBW?=
 =?iso-8859-1?Q?AN6t0Unr36qz4BukrJ0/x1y/5qvMP0CuYj1dMCfgIizLV/XEXDYcZt45/h?=
 =?iso-8859-1?Q?ZtqSAV2hWK1DY4wqYSyG77m6i6fMYSRXUwn3/57c49Pl0mBIUPC0pKbGpE?=
 =?iso-8859-1?Q?zXSDwJ89EO7/qDnk5L42HFwf5qD+STvN0vh2lhsm+pjeKzMalRnjSPdhJ+?=
 =?iso-8859-1?Q?cCxRf5OJpSRqmFsu/FP7JabOdDckdS066eJdDUt//gFX3U3Ubf1imTt/uR?=
 =?iso-8859-1?Q?dW6W6z+LLRSPj57uLBUxATb4HyDj/QHzz0Bzp9Kh6IjdlBtgj0zUknzKcV?=
 =?iso-8859-1?Q?8/LXN5VRqQE3fDfGJoN9zzxiXgs6IYu00yfevnYO5b5D9RTvDfZrbDfB5J?=
 =?iso-8859-1?Q?lDEmCGDcsjQp8NNqRw6YjQaAqO8y8mBw0TlD/6XfNw9fF4GjWaTXQSnFhu?=
 =?iso-8859-1?Q?RfmympdVOEYLhB+UaBNrknuMutkPhE8rU5XMYfJARz2ZXdaQcCEtVIr69e?=
 =?iso-8859-1?Q?TCNV+bNllUQKe8uokP4EMtmuwWxM1cP19akTL4hs6xFIJTgT4KzRjJly+B?=
 =?iso-8859-1?Q?eZqfB9a8X7iw7po8J0Veoz9xNmGcBRQJt32ymOoe6Zgw40qnvQ7o+LlKGN?=
 =?iso-8859-1?Q?jY7PPnd8NZWOI8EFpAp37j7kR3aHy6Y2b9cTzd+5eoUJsQwUDLLr9pgt89?=
 =?iso-8859-1?Q?VND/HMnZ2NPt8mASXkqh/HDisWS36FM85Sev6096sXCUa7Pl19zDGCvxHY?=
 =?iso-8859-1?Q?0qQBRtY2NYcyAx1KilHlTgu1NVv23WnmHrBA+DrNRK8ETqghAKYBXbnLVE?=
 =?iso-8859-1?Q?7FpTm68Jampp1Mo6MoFPyhDpZbodGsDP7tvheg7U0tsa/SNAe+wQQUsRRo?=
 =?iso-8859-1?Q?pqVUyvu4R1q3GMFOCG5pPYGylgrNV9cFawGRDzUTSgnWZWlil4zvR69ZSB?=
 =?iso-8859-1?Q?awR0Uc35JFIAsgKtsBlA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uyfjByhnuii7dGp+bqJzZq567cNKGFe8ThDd2jiIYICVuAhCYUG8AZuihf?=
 =?iso-8859-1?Q?cXD+WgUa7nUMf9/kyvKNHlksaJAQfY8kg+Vne7k4vvmnF+xfjBpAQGF3Q4?=
 =?iso-8859-1?Q?T9TfGqIr9HfXHhTe2XjDNXuDq5vgCXwyVA+/WMJc//Al8BTpeLOQVgtYEA?=
 =?iso-8859-1?Q?ZUIgXAo/LJsnE5AksyYWE11lHRraaWF9fRj1Dc3luEbupS4+3sgDfUX0Jr?=
 =?iso-8859-1?Q?hMn6LM96xqYfNXxB2JvMECf1SSJ//JJe/1aFAhH+yO4cBLK/mVHzDqxfts?=
 =?iso-8859-1?Q?WejDyqi0EdPCMKr3geO2E7G1d7zWbMZC6kYll6RyiFAHXjTeFMjJWa8BBX?=
 =?iso-8859-1?Q?mBWZMADzaSy/hXFUMcKx86MkF5HTGzQZydDgPT5OVydS3aWfMFZQa+e5rC?=
 =?iso-8859-1?Q?j9XIPMXzS6b2Ft3S0Di25Ce5Z3Uy+UulOXpySldEGPKRGqx8vYYpJA6FuJ?=
 =?iso-8859-1?Q?MAcNx3RhE7RV74u+CvNVG6XIXgV7C6ZGSiae77Vve5FTKllL/23kvUF13W?=
 =?iso-8859-1?Q?v0ePHV/QMlxw7vl/lVBCLRnPHZksL5CfTnfWiFsWAl2q30ALO/ri5+GWMi?=
 =?iso-8859-1?Q?RWFY7sG/QVMlledog5SvCzS3e4TSw2/RXA3D96HS7TMbo+CKdzTN7T/RZs?=
 =?iso-8859-1?Q?ZGZoL5IXyvbpTn3t2H90iOSJwmgdo2JerOy/5rvVUvWetpFI8eUFNUBOgu?=
 =?iso-8859-1?Q?UeNgsxyS0W9B9uhVv8ARqo8bVxnz6EGK3C0B1zQdQr1/VKmIWyCw8mZLfA?=
 =?iso-8859-1?Q?Bf/IHexv2sAnYJXIkS3qeQ7qhg2KUH1RoqB878CW/JGzpzc+ZXub3/7aRq?=
 =?iso-8859-1?Q?VY51k7ZeORRzNgg6frq4hvNKCSEeqVYOdegAzATK2asKB9rYqaVQ6qRP0c?=
 =?iso-8859-1?Q?yTHead+51L82pWukYAWaWof8tJC8FHRCvVBMZlp6ys4sbHre8lshg6QWSt?=
 =?iso-8859-1?Q?bEQVY/9XfD7Oy1xE0irMRlD/shLTkc3k1cGan7jRNJrin8RkwVHh7y3Om4?=
 =?iso-8859-1?Q?xZGB1WtBaW1GZtH7oDxcZ0/ithOpjqD8qD0bP0IaWHQUEI9Zn3h7SsaHD5?=
 =?iso-8859-1?Q?9EebZi+r038ORrobyiIV+tSDeI7qiXuSpIvvDikGgWIStYcfRp0PoC3MJa?=
 =?iso-8859-1?Q?q53ERayXkXQGYroBF+g8kKamoj2qWmomIz6ndToLEA87hh08ahwoTU/YsY?=
 =?iso-8859-1?Q?nRodq3169xFJOWrp7OKR7Zkyn4Y2wJ4jUIksBa5L5zVln9i2o5y5Jx2eEZ?=
 =?iso-8859-1?Q?q6KRRMdgUCm6RqgmqMaJbfWV4qMOWu36HBgObnmb8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 072d96a8-ab80-4787-c2ca-08dd9c6d37bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 15:51:45.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8258

Whenever an email is sent, send-email shows a log at last, which=0A=
contains all the headers of the email that were received by the=0A=
receipients.=0A=
=0A=
In case outlook changes the Message-ID, a log for the same is shown to=0A=
the user, but that change is not reflected when the log containing all=0A=
the headers is displayed. Here is an example of the log that is shown=0A=
when outlook changes the Message-ID:=0A=
=0A=
Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E298CB865A@P=
N3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>=0A=
OK. Log says:=0A=
Server: smtp.office365.com=0A=
MAIL FROM:<gargaditya08@live.com>=0A=
RCPT TO:<negahe7142@nomrista.com>=0A=
From: Aditya Garg <gargaditya08@live.com>=0A=
To: negahe7142@nomrista.com=0A=
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs=0A=
Date: Mon, 26 May 2025 20:28:36 +0530=0A=
Message-ID: <20250526145836.4825-1-gargaditya08@live.com>=0A=
X-Mailer: git-send-email @GIT_VERSION@=0A=
MIME-Version: 1.0=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Result: 250=0A=
=0A=
This patch fixes this by modifying the $header variable, which is=0A=
responsible for showing the logs at the end. Also, the log which states=0A=
that the Message-ID has been changed will now be shown only when=0A=
smtp-debug is enabled, since the main log having all of the headers is=0A=
anyways displaying the new Message-ID. It should look like this after=0A=
this patch:=0A=
=0A=
OK. Log says:=0A=
Server: smtp.office365.com=0A=
MAIL FROM:<gargaditya08@live.com>=0A=
RCPT TO:<negahe7142@nomrista.com>=0A=
From: Aditya Garg <gargaditya08@live.com>=0A=
To: negahe7142@nomrista.com=0A=
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs=0A=
Date: Mon, 26 May 2025 20:29:22 +0530=0A=
Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.INDPRD01.=
PROD.OUTLOOK.COM>=0A=
X-Mailer: git-send-email @GIT_VERSION@=0A=
MIME-Version: 1.0=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Result: 250=0A=
=0A=
Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
---=0A=
 git-send-email.perl | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/git-send-email.perl b/git-send-email.perl=0A=
index b09251c4fc..e8019c40ba 100755=0A=
--- a/git-send-email.perl=0A=
+++ b/git-send-email.perl=0A=
@@ -1776,7 +1776,9 @@ sub send_message {=0A=
 		if (is_outlook($smtp_server)) {=0A=
 			if ($smtp->message =3D~ /<([^>]+)>/) {=0A=
 				$message_id =3D "<$1>";=0A=
-				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;=0A=
+				# Replace the original Message-ID in $header with the new one=0A=
+				$header =3D~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;=0A=
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $s=
mtp->debug;=0A=
 			} else {=0A=
 				warn __("Warning: Could not retrieve Message-ID from server response.\=
n");=0A=
 			}=0A=
-- =0A=
2.43.0=0A=
=0A=
