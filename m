Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E661DED4C
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875453; cv=fail; b=KsHceEkEoO0oGAtxnS7AqW4fxY/vCDKoEOjnjKnU/zm0NQExqv+eo0r5TW+1Gy2XRV+MjYLe2u3Zzg6phsXDvpQnmknjs8R+pJC/AY7Cg5q71i+DeJnSDvmKmShlc3eOhCSlgy44MKxdGhOofIjxya9Q+Y794WNKSE9A6D3g2v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875453; c=relaxed/simple;
	bh=Y7O/l/TiS0F5c1UWX8tXZib7vViKbtb85vI8U6Mwf7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EgbuF3tDcnt4Fuho8H5BAMwtYwTCfPSMjqoJNv+SyewhUNK0oLnfudRGVW4uGYoAZ4NUqpWyVZLVgm1H6uzYeWI88FCfDthvxVjJYSemhqe3Vpbg7lc5x2Y5Cq0kTI5BTGpO6mrVqTLhxkGqo01qeTm7RqeZHDDJPcnUK48OhPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AlkmPCke; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AlkmPCke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4qJcREeGPR0w4lMBit2DYkCp3W2307OwFxJHFHqOZcQuDqJsVRCUMO8Lg1slw+UVJYH9CYjSADLYDnbtwf2TCE5jO1hAqitckCrBqK0ceyqNCZnmve4pm84eUMR0FCOvBzLudQog2UKza9gYbE9n88nqhIvJU9MNjrWUSv36zJ5UvujXMd//yqrcBRk2URznyGgUh+nlkcWQSCQoFFOiJx+Ymj1fCZ1leuyh1Wpl20b4re7wiM0cFCLYbJPBiVNK7SS6Yl0c94iWlwZvND7aHdSrk7L96BAdXPf3KNBATFx0dIys2iegskhu9Y2E+Z8zhzfnzxVYUA84tCnb3BzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6mnvo5WwKUxZTJpruWujnIJrEgYzwuzgEqhkXfNQuU=;
 b=uuboSay2oz/1+/imHOoxjsVUcFCHdx/oegNZR/8f8CNPBzdZndyGstUxHXmpz1ZKJH8eLWTd1yrRgqUECLmFPBgN/Px9d7kHqZ78G7ndEqkLrcpF8WbdRQBrWqBmr6/8TSNe3PH6umgcIsoaVCLABkHWtl6++L/qnkuCSlwwyC+bmFyT48Za+2LxSSBfexhnGm980md+ET6wfcDcLEZVnIZ78VMLh2sbEoVtnKHaPzJy7AGPOVpS/9dCilbX1oPfemIKoBOwW+9q+rBXhA9yAD/RZoG7BTx/UT2EcJc7+yU3s4t5JjsUGJekDj/HOho9flAoFOzD+tY9Fo31w2pIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6mnvo5WwKUxZTJpruWujnIJrEgYzwuzgEqhkXfNQuU=;
 b=AlkmPCkeZy+mQC2bMlhuUjiX4uQXqpaV2iWUCtkubEJKLkG9Vx5WVjZ0kmhXKrBZLLo9uIqLB9sij5BDrhjfgtdniiRBDZ7nVVbqgm96kQSb7XbfW/ckTJ2ODMD5fkL+XbReeB43qkaPgDK7dhMVRINRmwLrznjc5709aTYHH+k0wE/9O/9LbfWeHlFQxd5DdIl7OHTtTh6WtXcVZC42MZUdkUWkjZo4aqHpX39ue5SUXvyWQteAdA9fEuZDZPBuk47ZiXyEsCqX/eAQ9Fe0JA5ZOUVQs09wJWe0ygP8RBY9C2h0G1/A775PHXlgQpqfkTDEX4l46HfHP4WEUsK3uQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB11372.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:10:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:10:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m . carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers
	<julian@swagemakers.org>
Subject: [PATCH v3] send-email: add --get-smtp-server option to fetch SMTP
 settings
Thread-Topic: [PATCH v3] send-email: add --get-smtp-server option to fetch
 SMTP settings
Thread-Index: AQHcE3bvySpTMPqD10yRcaMXV7bhuQ==
Date: Fri, 22 Aug 2025 15:10:45 +0000
Message-ID: <20250822151039.36006-1-gargaditya08@live.com>
References: <20250730151227.12389-1-gargaditya08@live.com>
In-Reply-To: <20250730151227.12389-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNYPR01MB11372:EE_
x-ms-office365-filtering-correlation-id: c0caac0c-102e-4321-d059-08dde18e119c
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|38102599003|8060799015|8062599012|31061999003|461199028|15080799012|4302099013|3412199025|440099028|40105399003|12091999003|19111999003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6SnyEqyLQJxTCl00wY4dRJR5yME59ex2z2F8/foIMANfrStSeZn5/GWqTW?=
 =?iso-8859-1?Q?E6JB9qqJo8X2Aa2dQmiAJCR8RDAvmgdWo96wOHqUTfXbFgVv7FbiG/iu6x?=
 =?iso-8859-1?Q?vNcSa4WuEleL1szjRd+SAO6cCE0CCFkv2b12e42RyBGF1KFfuvbAPwtWNV?=
 =?iso-8859-1?Q?JWrzAhEL4JC/l5WoCdVH1AEgqDnX20cCi7n7vntW7S2lgT/BNj5eCFJOjc?=
 =?iso-8859-1?Q?z1rErSZxmq/isSyxtGeYP4pRrFi2YUmJkbfXPXHEd0K/DpnIyruz+T4ffC?=
 =?iso-8859-1?Q?h2tsmATh9qvUyifPs3mzvY4YIcpdLSj0k7gy7dK8CKF4McMOLNtw6f2+lf?=
 =?iso-8859-1?Q?Vd1QY5QEGaW+lE0eMmJP46LPmLF0jIulevzVrftFdB2UKDDFLmUiO1T/AG?=
 =?iso-8859-1?Q?m/iG4Sze4X89IhGakO2ZN9MVD0kYycC5HjrnHLSWvxh8ciPwODzIvHI3DF?=
 =?iso-8859-1?Q?Yb43ilaSrB7Yqz9C8WHOkf3vmDRD1FrzMYA2505MvkkcDVVZ23SPUSC+oS?=
 =?iso-8859-1?Q?9MjuTaR313zEQ/lnnkDzPDz42RgoTEXX/mpZAGrDzncasc+4DJXoKB4YNO?=
 =?iso-8859-1?Q?F4aVdRV2a0SQvoaJwsRpSjdB0xPRE2HiN1aMj4dszGcqgxcP1WU3+fuleN?=
 =?iso-8859-1?Q?knLHiUZQJ+E3sDarco4rL5awPDH3JxwqDGXkfDkkzB95w1hxwDwCL8rsxx?=
 =?iso-8859-1?Q?X7tG9hgVdGeqZV2HDKVDP7hdxfKYR0QcHdURTTyM+ZMbxHWOeHvS9P0Hdk?=
 =?iso-8859-1?Q?l8J8PPWBBwAeppcH+vFwNFzWiHOeJLt1L784XTpqNH4MtbIydw/7mOe9LA?=
 =?iso-8859-1?Q?U/dfXvXoXi+HRcYX4ePg1DgnEU7Sg9oAoyTgLVA5DV5cvtjeNMnuBt50l7?=
 =?iso-8859-1?Q?n24OrEa1kLZoYujz+Ri0Qryb2i3qij1eoUhwK8hFxKYAqyPFgcOgvHHoZW?=
 =?iso-8859-1?Q?bXhDrdwSzSxG1ApIpk2InIkvRhuFv5GmVcHmU7E2ebWK6VFtnuwtLOp7ev?=
 =?iso-8859-1?Q?ut9qUak5N1b4NSjWEv72xcXQu0NJQEvB2gwCx6IbtWElQAYuoO0SjZ5C/n?=
 =?iso-8859-1?Q?r+uXOVwlf7Q20ZJgAaH2nZQUJz+vrATtEd7E/cG4ijxew1uYVglRPYmrqn?=
 =?iso-8859-1?Q?yv5M0fWx2m1TvNS799qJE0T2l+hP9e511zpNoHibiCCIri7Bexayv0LyiE?=
 =?iso-8859-1?Q?so1E5cYoUVSXf3A8efuvcJ6quWyMrl3K6vVEdbtpkt8iem6srnwbMDKHB1?=
 =?iso-8859-1?Q?7Kn2j/yS+X3uZLP0LT6z0okqXTjfwd5oxciiqOXvd1QerXHr+ecgW4Fime?=
 =?iso-8859-1?Q?JfNDAQE6RwSPczVSO+CsAVsrNNRRFWPF6WjWn3GXKK3qIqDBKtOTtCFPPt?=
 =?iso-8859-1?Q?dfN6P2vRiKt/jcYIpDdycwi5EYfA937ninvogpGL6JxmnBvuux4To=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M5Rtjr7Zc1/Tikw/zPpRnExT6vUW2C2kuUrRfkHup38OIrnFICLg4DRU9M?=
 =?iso-8859-1?Q?ls5n53msIgKxTrQb2Lp0SDQIicENKXXjw9k0N0hdJCiQvV9kTPtBTrSWRf?=
 =?iso-8859-1?Q?IbOfBxT3EbPw8lOnOyTd84o2VIROQTQQky/KsrlB2wMRG10jbPlQ08szpU?=
 =?iso-8859-1?Q?ihSHbhALOsJYEpObGRoEpHppRjOeYS6c1lDO1R4ZedjPMtJBnJqY092NUt?=
 =?iso-8859-1?Q?3f9upjyWc5oSVec5S6xv17ur9Bh7coQMad+bbJE6IcvkF3L7G2Ink0IR2S?=
 =?iso-8859-1?Q?ltlC1a9E5Ck4t8uyULfof8AXWSqZ/YApPXJzRThSG9wrQsdfU1rQN4wLAT?=
 =?iso-8859-1?Q?5DxeB8hB0YB2QjhNeqNa7H2M9jVOzDVEnXd+on3dsw4woAZu6uK0mRve+s?=
 =?iso-8859-1?Q?KtHwq1L5MEHPtscQqfPo6nuMjVGWmmBM9lYmOKGrzmWy9i7PTbuOusm5P7?=
 =?iso-8859-1?Q?QdIo77JjC2WtfTa4MqbT0Z8qI5GyBxbrScb/TRa18MsQ74pgFUmUTefIFJ?=
 =?iso-8859-1?Q?JpwjUuzsr4c5uBWNUML6VzSLNsnAg2AM2hDLKkTEsJExiESPnfH6WDJEpJ?=
 =?iso-8859-1?Q?E49SkIwxc6V5MWIeAEks7nj+odxAbzTqucr/dHbXkrwC3GBTWqkR7Eg6jx?=
 =?iso-8859-1?Q?7cD5NEL0JpFIhRRvSx09LNFTTOaWIIVKzZLKb8I1+X7tAvMgAqkESsSLxK?=
 =?iso-8859-1?Q?HLhiKqkjjv5MIpoE7CxUeXNM6nyGdmH7KlWguZfyF8Mo9N1zYolf5hVoZb?=
 =?iso-8859-1?Q?/ZE6jwfzFfo/X8AuAiYMgeqi5lFiUa9NZDh07ZBacIwmNLe+SwuORKX5Oe?=
 =?iso-8859-1?Q?fb9ZvHXCwieolReA1u6VhVWiSl836arenaSZnyeJ3/UL3jCkOhhDllfYWz?=
 =?iso-8859-1?Q?QrrG3UlTsBLffZOocSj4on2/S+FyIVBAsH+i6RjDkq6eOKNHhvVhCpl9t3?=
 =?iso-8859-1?Q?c2v2G0yqQaPPooYhPNA5iHqDCMz2ZPhcYzUXbVTji3WwhA1WAvpHDtSduB?=
 =?iso-8859-1?Q?QO5sAQimWyBK+bJAbbYns7HIgG1W4wn6Mpa9bv6cqB0CFaUWlMUSt7dSsB?=
 =?iso-8859-1?Q?RrnLsCK49o4AZOB/76BhxUMs4jE600OEvJz6FkPFqkzprxh1iwjNsaASL2?=
 =?iso-8859-1?Q?z7iCZNc3xgkJUaQvUcm2/vBMJp0LNVYCoEEY4lVUoFNDIlunq++LkpEh5A?=
 =?iso-8859-1?Q?jSh8cDZ9+Ih9kVqFDScDeu8u4LdU2rwpX6R4O7OmpLa21ap86hE18CIcmO?=
 =?iso-8859-1?Q?wDoxgPQUj43yINRatSd98RQxO5r1FNPK5ZpT5Hd4M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c0caac0c-102e-4321-d059-08dde18e119c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 15:10:45.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB11372

Autoconfiguring SMTP server settings is a common feature present in many=0A=
email clients. In order to get the correct SMTP server settings easily,=0A=
this commit adds a `--get-smtp-server` option to `git send-email`. This=0A=
option attempts to fetch the SMTP server settings for a given email address=
=0A=
via the following steps:=0A=
=0A=
1. It first attempts to fetch the autoconfig file from the email=0A=
   provider's autoconfig URL, which is typically in the format=0A=
   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[email]=
`=0A=
   or `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`=0A=
=0A=
2. If that fails, it tries to fetch the settings from Mozilla's ISPDB at=0A=
   `https://autoconfig.thunderbird.net/v1.1/[domain]`.=0A=
=0A=
3. If that also fails, it falls back to checking the MX records of the=0A=
   domain used in the email address to find the SMTP server. It can be=0A=
   useful in case of emails with custom domains. It attempts to guess=0A=
   the correct domain for the email from the MX records, and repeats the=0A=
   first 2 steps with the guessed domain.=0A=
=0A=
This feature is heavily inspired by the autoconfig feature in Mozilla=0A=
Thunderbird. A detailed documentation about how thunderbird fetches the=0A=
autoconfig settings can be found at:=0A=
=0A=
https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/=0A=
---=0A=
=0A=
v2: - Improved checks for valid email address.=0A=
=0A=
v3: - Try to get settings from email provider's autoconfig URL first,=0A=
      followed by Mozilla ISPDB, then MX records.=0A=
    - Add support for another variant of autoconfig URL:=0A=
      `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`=0A=
    - Added support to list supported auth mechanisms.=0A=
    - Added warning if encryption is plain (unencrypted).=0A=
    - Suggest user to read the docs for OAuth2.=0A=
    - Give instructions on how to apply the settings.=0A=
=0A=
 Documentation/git-send-email.adoc |  51 ++++++-=0A=
 git-send-email.perl               | 219 +++++++++++++++++++++++++++++-=0A=
 2 files changed, 266 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc=0A=
index 5335502d68..daddaae36d 100644=0A=
--- a/Documentation/git-send-email.adoc=0A=
+++ b/Documentation/git-send-email.adoc=0A=
@@ -13,6 +13,7 @@ SYNOPSIS=0A=
 'git send-email' [<options>] <format-patch-options>=0A=
 'git send-email' --dump-aliases=0A=
 'git send-email' --translate-aliases=0A=
+'git send-email' --get-smtp-server=0A=
 =0A=
 =0A=
 DESCRIPTION=0A=
@@ -505,6 +506,14 @@ Information=0A=
 	address to standard output, one per line. See `sendemail.aliasFile`=0A=
 	for more information about aliases.=0A=
 =0A=
+--get-smtp-server::=0A=
+	Attempt to get the correct SMTP server settings by entering an email=0A=
+	address. Once an email address is entered, it will first attempt to check=
=0A=
+	for an autoconfig file hosted by the email provider, followed=0A=
+	by attempting to get the correct settings from=0A=
+	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], finally fallin=
g=0A=
+	back to the MX records of the domain used by the email address.=0A=
+=0A=
 CONFIGURATION=0A=
 -------------=0A=
 =0A=
@@ -512,6 +521,41 @@ include::includes/cmd-config-section-all.adoc[]=0A=
 =0A=
 include::config/sendemail.adoc[]=0A=
 =0A=
+GETTING THE CORRECT SMTP SERVER SETTINGS=0A=
+----------------------------------------=0A=
+=0A=
+You can attempt to get the correct SMTP server settings by using=0A=
+the `--get-smtp-server` command line option with `git send-email`.=0A=
+It will ask you for your email address, then attempt to get the=0A=
+correct SMTP server settings for that email address. An email=0A=
+address may have more than one configuration. In that case, any of=0A=
+them can be used.=0A=
+=0A=
+For example, an output with email `someone@gmail.com` yields:=0A=
+=0A=
+----=0A=
+Configuration 1:=0A=
+  Server: smtp.gmail.com=0A=
+  Port: 465=0A=
+  Encryption: ssl=0A=
+  Username: jhk@gmail.com=0A=
+  Authentication: Normal Password=0A=
+  Authentication: OAuth2=0A=
+----=0A=
+=0A=
+Here the value of:=0A=
++=0A=
+- `Server` corresponds to `sendmail.smtpServer`.=0A=
+- `Port` corresponds to `sendmail.smtpServerPort`.=0A=
+- `Encryption` corresponds to `sendmail.smtpEncryption`.=0A=
+- `Username` corresponds to `sendmail.smtpUser`.=0A=
+- `Authentication` indicates supported authentication methods.=0A=
++=0A=
+=0A=
+This method should work well for almost all large email providers in the=
=0A=
+world. If it provides invalid settings or cannot retrieve them, contact=0A=
+your email provider.=0A=
+=0A=
 EXAMPLES OF SMTP SERVERS=0A=
 ------------------------=0A=
 Use Gmail as the SMTP Server=0A=
@@ -624,8 +668,11 @@ https://metacpan.org/pod/Net::SMTP[Net::SMTP].=0A=
 =0A=
 These additional Perl modules are also required:=0A=
 =0A=
-https://metacpan.org/pod/Authen::SASL[Authen::SASL] and=0A=
-https://metacpan.org/pod/Mail::Address[Mail::Address].=0A=
+https://metacpan.org/pod/Authen::SASL[Authen::SASL],=0A=
+https://metacpan.org/pod/Mail::Address[Mail::Address],=0A=
+https://metacpan.org/pod/Net::DNS[Net::DNS],=0A=
+https://metacpan.org/pod/URI::Escape[URI::Escape] and=0A=
+https://metacpan.org/dist/XML-LibXML[XML::LibXML].=0A=
 =0A=
 Exploiting the `sendmailCmd` option of `git send-email`=0A=
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0A=
diff --git a/git-send-email.perl b/git-send-email.perl=0A=
index 437f8ac46a..9f4b6faf08 100755=0A=
--- a/git-send-email.perl=0A=
+++ b/git-send-email.perl=0A=
@@ -32,6 +32,7 @@ sub usage {=0A=
 git send-email [<options>] <format-patch options>=0A=
 git send-email --dump-aliases=0A=
 git send-email --translate-aliases=0A=
+git send-email --get-smtp-server=0A=
 =0A=
   Composing:=0A=
     --from                  <str>  * Email From:=0A=
@@ -108,6 +109,7 @@ sub usage {=0A=
                                      input according to the configured ema=
il=0A=
                                      alias file(s), outputting the result =
to=0A=
                                      standard output.=0A=
+    --get-smtp-server              * Print the SMTP server settings for a =
given email.=0A=
 =0A=
 EOT=0A=
 	exit(1);=0A=
@@ -222,6 +224,7 @@ sub format_2822_time {=0A=
 my $force =3D 0;=0A=
 my $dump_aliases =3D 0;=0A=
 my $translate_aliases =3D 0;=0A=
+my $get_smtp_server =3D 0;=0A=
 =0A=
 # Variables to prevent short format-patch options from being captured=0A=
 # as abbreviated send-email options=0A=
@@ -501,6 +504,15 @@ sub config_regexp {=0A=
     if !$help and ($dump_aliases or $translate_aliases) and @ARGV;=0A=
 die __("--dump-aliases and --translate-aliases are mutually exclusive\n")=
=0A=
     if !$help and $dump_aliases and $translate_aliases;=0A=
+=0A=
+my %get_smtp_server_options =3D (=0A=
+	"get-smtp-server" =3D> \$get_smtp_server,=0A=
+);=0A=
+$rc =3D GetOptions(%get_smtp_server_options);=0A=
+usage() unless $rc;=0A=
+die __("--get-smtp-server incompatible with other options\n")=0A=
+	if !$help and $get_smtp_server and @ARGV;=0A=
+=0A=
 my %options =3D (=0A=
 		    "sender|from=3Ds" =3D> \$sender,=0A=
 		    "in-reply-to=3Ds" =3D> \$initial_in_reply_to,=0A=
@@ -565,7 +577,7 @@ sub config_regexp {=0A=
 my @initial_bcc =3D @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bc=
c);=0A=
 =0A=
 usage() if $help;=0A=
-my %all_options =3D (%options, %dump_aliases_options, %identity_options);=
=0A=
+my %all_options =3D (%options, %dump_aliases_options, %identity_options, %=
get_smtp_server_options);=0A=
 completion_helper(\%all_options) if $git_completion_helper;=0A=
 unless ($rc) {=0A=
     usage();=0A=
@@ -757,6 +769,208 @@ sub parse_sendmail_aliases {=0A=
 	exit(0);=0A=
 }=0A=
 =0A=
+our $doc;=0A=
+=0A=
+sub fetch_config_domain_autoconfig {=0A=
+	require XML::LibXML;=0A=
+	my ($domain, $email_enc) =3D @_;=0A=
+	my $parser =3D XML::LibXML->new;=0A=
+	my $autoconfig_url =3D "https://autoconfig.$domain/mail/config-v1.1.xml?e=
mailaddress=3D$email_enc";=0A=
+	my $xml =3D fetch_config($autoconfig_url);=0A=
+	if ($xml) {=0A=
+		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+		return $doc if $doc;=0A=
+	}=0A=
+	if (!$xml || !$doc) {=0A=
+		$autoconfig_url =3D "http://$domain/.well-known/autoconfig/mail/config-v=
1.1.xml";=0A=
+		$xml =3D fetch_config($autoconfig_url);=0A=
+		if ($xml) {=0A=
+			$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+			return $doc if $doc;=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+sub fetch_config_mozilla_ispdb {=0A=
+	require XML::LibXML;=0A=
+	my ($domain) =3D @_;=0A=
+	my $parser =3D XML::LibXML->new;=0A=
+	my $ispdb_url =3D "https://autoconfig.thunderbird.net/v1.1/$domain";=0A=
+	my $xml =3D fetch_config($ispdb_url);=0A=
+	if ($xml) {=0A=
+		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
+		return $doc if $doc;=0A=
+	}=0A=
+}=0A=
+=0A=
+sub fetch_config {=0A=
+	require HTTP::Tiny;=0A=
+	my ($url) =3D @_;=0A=
+	my $http =3D HTTP::Tiny->new(timeout =3D> 10);=0A=
+	my $res =3D $http->get($url);=0A=
+=0A=
+	return unless $res->{success};=0A=
+	return $res->{content};=0A=
+}=0A=
+=0A=
+sub extract_base_domain {=0A=
+	require IO::Socket::SSL::PublicSuffix;=0A=
+	my ($host) =3D @_;=0A=
+	my $ps =3D IO::Socket::SSL::PublicSuffix->default;=0A=
+=0A=
+	my $public_suffix =3D $ps->public_suffix($host);=0A=
+	return $host unless defined $public_suffix;=0A=
+=0A=
+	my @host_parts =3D split(/\./, lc($host));=0A=
+	my @suffix_parts =3D split(/\./, $public_suffix);=0A=
+=0A=
+	# Find where the suffix starts in the host=0A=
+	for (my $i =3D 0; $i <=3D $#host_parts - $#suffix_parts; $i++) {=0A=
+		if (join('.', @host_parts[$i .. $#host_parts]) eq $public_suffix) {=0A=
+			# Precursor + suffix =3D base domain=0A=
+			return join('.', $host_parts[$i - 1], @host_parts[$i .. $#host_parts]) =
if $i > 0;=0A=
+			return $public_suffix;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return $host;=0A=
+}=0A=
+=0A=
+sub get_mx_base_domain {=0A=
+	require Net::DNS;=0A=
+	my ($domain) =3D @_;=0A=
+	my $resolver =3D Net::DNS::Resolver->new;=0A=
+	my $query =3D $resolver->query($domain, "MX");=0A=
+=0A=
+	if ($query) {=0A=
+		my @mx_hosts =3D sort { $a->preference <=3D> $b->preference } grep { $_-=
>type eq "MX" } $query->answer;=0A=
+		if (@mx_hosts) {=0A=
+			my $mx_host =3D $mx_hosts[0]->exchange;=0A=
+			$mx_host =3D~ s/\.$//;  # Remove trailing dot=0A=
+			return extract_base_domain($mx_host);=0A=
+		}=0A=
+	}=0A=
+	return;=0A=
+}=0A=
+=0A=
+sub parse_config {=0A=
+	my ($doc_parsed, $email) =3D @_;=0A=
+	my $config_num =3D 0;=0A=
+	my $smtp_encryption_config;=0A=
+	my $smtp_user_config;=0A=
+	my $supports_oauth2 =3D 0;=0A=
+=0A=
+	foreach my $outgoing ($doc_parsed->findnodes('//outgoingServer')) {=0A=
+		$config_num++;=0A=
+		if ($outgoing->findvalue('./socketType') eq 'SSL') {=0A=
+			$smtp_encryption_config =3D 'ssl';=0A=
+		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {=0A=
+			$smtp_encryption_config =3D 'tls';=0A=
+		} else {=0A=
+			$smtp_encryption_config =3D 'plain';=0A=
+		}=0A=
+=0A=
+		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {=0A=
+			$smtp_user_config =3D $email;=0A=
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {=0A=
+			$smtp_user_config =3D (split /@/, $email)[0];=0A=
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {=0A=
+			$smtp_user_config =3D (split /@/, $email)[1];=0A=
+		} else {=0A=
+			$smtp_user_config =3D $outgoing->findvalue('./username');=0A=
+		}=0A=
+=0A=
+		my $auth_mechanisms =3D $outgoing->findvalue('./authentication');=0A=
+=0A=
+		print "\nConfiguration $config_num:\n";=0A=
+		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";=0A=
+		print "  Port: ", $outgoing->findvalue('./port'), "\n";=0A=
+		print "  Encryption: ", $smtp_encryption_config, "\n";=0A=
+		print "  Username: ", $smtp_user_config, "\n";=0A=
+		if ($auth_mechanisms =3D~ /password-cleartext/i) {=0A=
+			print "  Authentication: Normal Password\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /password-encrypted/i) {=0A=
+			print "  Authentication: Encrypted Password\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /NTLM/i) {=0A=
+			print "  Authentication: NTLM\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /GSSAPI/i) {=0A=
+			print "  Authentication: Kerberos / GSSAPI\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /client-IP-address/i) {=0A=
+			print "  Authentication: Client IP Address\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /TLS-client-cert/i) {=0A=
+			print "  Authentication: TLS Certificate\n";=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /OAuth2/i) {=0A=
+			print "  Authentication: OAuth2\n";=0A=
+			$supports_oauth2 =3D 1;=0A=
+		}=0A=
+		if ($auth_mechanisms =3D~ /none/i) {=0A=
+			print "  Authentication: No Authentication\n";=0A=
+		}=0A=
+		if ($smtp_encryption_config eq 'plain') {=0A=
+			print "\nWarning: Encryption plain is unencrypted!\n";=0A=
+		}=0A=
+	}=0A=
+	if ($supports_oauth2) {=0A=
+		print "\nThe SMTP server supports OAuth2 authentication. If you want to =
use OAuth2,\n";=0A=
+		print "please review the git-send-email man pages for more details.\n";=
=0A=
+	}=0A=
+	print "\e[33m"; # yellow=0A=
+	print "\nTo apply the settings use:\n";=0A=
+	print "  git config --global sendmail.smtpServer VALUE\n";=0A=
+	print "  git config --global sendmail.smtpServerPort VALUE\n";=0A=
+	print "  git config --global sendmail.smtpEncryption VALUE\n";=0A=
+	print "  git config --global sendmail.smtpUser VALUE\n";=0A=
+	print "\nOmit --global to set the configuration only in this repository.\=
n";=0A=
+	print "\e[0m"; # reset=0A=
+}=0A=
+=0A=
+if ($get_smtp_server) {=0A=
+	require URI::Escape;=0A=
+	print "Enter your email address: ";=0A=
+	chomp(my $email =3D <STDIN>);=0A=
+	$email =3D extract_valid_address($email);=0A=
+	if (!$email) {=0A=
+		die __("Invalid email format.\n");=0A=
+	}=0A=
+	$email =3D~ /@(.+)$/;=0A=
+	my $domain =3D $1;=0A=
+	my $email_enc =3D URI::Escape::uri_escape($email);=0A=
+=0A=
+	# 1. Try domain autoconfig if ISPDB fails=0A=
+	$doc =3D fetch_config_domain_autoconfig($domain, $email_enc);=0A=
+=0A=
+	# 2. Try Mozilla ISPDB if domain autoconfig fails=0A=
+	if (!$doc) {=0A=
+		$doc =3D fetch_config_mozilla_ispdb($domain);=0A=
+	}=0A=
+=0A=
+	# 3. Try MX record lookup=0A=
+	if (!$doc) {=0A=
+		my $base_domain =3D get_mx_base_domain($domain);=0A=
+		if ($base_domain && $base_domain ne $domain) {=0A=
+			$doc =3D fetch_config_domain_autoconfig($base_domain, $email_enc);=0A=
+=0A=
+			if (!$doc) {=0A=
+				$doc =3D fetch_config_mozilla_ispdb($base_domain);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if ($doc) {=0A=
+		print "\nFound SMTP server settings for $email:\n";=0A=
+		parse_config($doc, $email);=0A=
+	} else {=0A=
+		print "\nUnable to find SMTP server settings for $email\n";=0A=
+	}=0A=
+	exit(0);=0A=
+}=0A=
+=0A=
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if=0A=
 # $f is a revision list specification to be passed to format-patch.=0A=
 sub is_format_patch_arg {=0A=
@@ -1760,7 +1974,8 @@ sub send_message {=0A=
 		}=0A=
 =0A=
 		if (!$smtp) {=0A=
-			die __("Unable to initialize SMTP properly. Check config and use --smtp=
-debug."),=0A=
+			die __("Unable to initialize SMTP properly. Check config and use --smtp=
-debug.\n"),=0A=
+			    __("Use --get-smtp-server to get correct settings for your SMTP ser=
ver if needed.\n"),=0A=
 			    " VALUES: server=3D$smtp_server ",=0A=
 			    "encryption=3D$smtp_encryption ",=0A=
 			    "hello=3D$smtp_domain",=0A=
=0A=
Range-diff against v2:=0A=
1:  0db913ba39 ! 1:  63f9c628ac send-email: add --get-smtp-server option to=
 fetch SMTP settings=0A=
    @@ Commit message=0A=
         option attempts to fetch the SMTP server settings for a given emai=
l address=0A=
         via the following steps:=0A=
     =0A=
    -    1. It first tries to fetch the settings from Mozilla's ISPDB at=0A=
    -       `https://autoconfig.thunderbird.net/v1.1/[domain]`.=0A=
    -=0A=
    -    2. If that fails, it attempts to fetch the autoconfig file from th=
e email=0A=
    +    1. It first attempts to fetch the autoconfig file from the email=
=0A=
            provider's autoconfig URL, which is typically in the format=0A=
    -       `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=
=3D[email]`.=0A=
    +       `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=
=3D[email]`=0A=
    +       or `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xm=
l`=0A=
    +=0A=
    +    2. If that fails, it tries to fetch the settings from Mozilla's IS=
PDB at=0A=
    +       `https://autoconfig.thunderbird.net/v1.1/[domain]`.=0A=
     =0A=
         3. If that also fails, it falls back to checking the MX records of=
 the=0A=
            domain used in the email address to find the SMTP server. It ca=
n be=0A=
    @@ Commit message=0A=
            the correct domain for the email from the MX records, and repea=
ts the=0A=
            first 2 steps with the guessed domain.=0A=
     =0A=
    -    This feature is heavily inpired by the autoconfig feature in Mozil=
la=0A=
    +    This feature is heavily inspired by the autoconfig feature in Mozi=
lla=0A=
         Thunderbird. A detailed documentation about how thunderbird fetche=
s the=0A=
         autoconfig settings can be found at:=0A=
     =0A=
    @@ Documentation/git-send-email.adoc: Information=0A=
      =0A=
     +--get-smtp-server::=0A=
     +	Attempt to get the correct SMTP server settings by entering an email=
=0A=
    -+	address. Once an email address is entered, it will first try to get=
=0A=
    -+	the correct settings from=0A=
    -+	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], followed=
=0A=
    -+	by attempting to check for an autoconfig file hosted by the email=0A=
    -+	provider, finally falling back to the MX records of the domain used=
=0A=
    -+	by the email address.=0A=
    ++	address. Once an email address is entered, it will first attempt to =
check=0A=
    ++	for an autoconfig file hosted by the email provider, followed=0A=
    ++	by attempting to get the correct settings from=0A=
    ++	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], finally f=
alling=0A=
    ++	back to the MX records of the domain used by the email address.=0A=
     +=0A=
      CONFIGURATION=0A=
      -------------=0A=
    @@ Documentation/git-send-email.adoc: include::includes/cmd-config-sect=
ion-all.adoc=0A=
     +address may have more than one configuration. In that case, any of=0A=
     +them can be used.=0A=
     +=0A=
    -+For example, an output with email `someone@pobox.com` yields:=0A=
    ++For example, an output with email `someone@gmail.com` yields:=0A=
     +=0A=
     +----=0A=
     +Configuration 1:=0A=
    -+  Server: smtp.pobox.com=0A=
    ++  Server: smtp.gmail.com=0A=
     +  Port: 465=0A=
     +  Encryption: ssl=0A=
    -+  Username: ssw@pobox.com=0A=
    -+=0A=
    -+Configuration 2:=0A=
    -+  Server: smtp.pobox.com=0A=
    -+  Port: 587=0A=
    -+  Encryption: tls=0A=
    -+  Username: ssw@pobox.com=0A=
    ++  Username: jhk@gmail.com=0A=
    ++  Authentication: Normal Password=0A=
    ++  Authentication: OAuth2=0A=
     +----=0A=
     +=0A=
     +Here the value of:=0A=
    @@ Documentation/git-send-email.adoc: include::includes/cmd-config-sect=
ion-all.adoc=0A=
     +- `Port` corresponds to `sendmail.smtpServerPort`.=0A=
     +- `Encryption` corresponds to `sendmail.smtpEncryption`.=0A=
     +- `Username` corresponds to `sendmail.smtpUser`.=0A=
    ++- `Authentication` indicates supported authentication methods.=0A=
     ++=0A=
     +=0A=
     +This method should work well for almost all large email providers in =
the=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
      	exit(0);=0A=
      }=0A=
      =0A=
    -+sub fetch_config_mozilla_ispdb {=0A=
    -+	my ($domain) =3D @_;=0A=
    -+	my $ispdb_url =3D "https://autoconfig.thunderbird.net/v1.1/$domain";=
=0A=
    -+	my $xml =3D fetch_config($ispdb_url);=0A=
    -+	return $xml if $xml;=0A=
    -+}=0A=
    ++our $doc;=0A=
     +=0A=
     +sub fetch_config_domain_autoconfig {=0A=
    ++	require XML::LibXML;=0A=
     +	my ($domain, $email_enc) =3D @_;=0A=
    ++	my $parser =3D XML::LibXML->new;=0A=
     +	my $autoconfig_url =3D "https://autoconfig.$domain/mail/config-v1.1.=
xml?emailaddress=3D$email_enc";=0A=
     +	my $xml =3D fetch_config($autoconfig_url);=0A=
    -+	return $xml if $xml;=0A=
    ++	if ($xml) {=0A=
    ++		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
    ++		return $doc if $doc;=0A=
    ++	}=0A=
    ++	if (!$xml || !$doc) {=0A=
    ++		$autoconfig_url =3D "http://$domain/.well-known/autoconfig/mail/con=
fig-v1.1.xml";=0A=
    ++		$xml =3D fetch_config($autoconfig_url);=0A=
    ++		if ($xml) {=0A=
    ++			$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
    ++			return $doc if $doc;=0A=
    ++		}=0A=
    ++	}=0A=
    ++}=0A=
    ++=0A=
    ++sub fetch_config_mozilla_ispdb {=0A=
    ++	require XML::LibXML;=0A=
    ++	my ($domain) =3D @_;=0A=
    ++	my $parser =3D XML::LibXML->new;=0A=
    ++	my $ispdb_url =3D "https://autoconfig.thunderbird.net/v1.1/$domain";=
=0A=
    ++	my $xml =3D fetch_config($ispdb_url);=0A=
    ++	if ($xml) {=0A=
    ++		$doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
    ++		return $doc if $doc;=0A=
    ++	}=0A=
     +}=0A=
     +=0A=
     +sub fetch_config {=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
     +}=0A=
     +=0A=
     +sub parse_config {=0A=
    -+	require XML::LibXML;=0A=
    -+	my ($xml, $email) =3D @_;=0A=
    -+	my $parser =3D XML::LibXML->new;=0A=
    -+	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };=0A=
    -+	die "Failed to parse XML\n" unless $doc;=0A=
    ++	my ($doc_parsed, $email) =3D @_;=0A=
     +	my $config_num =3D 0;=0A=
     +	my $smtp_encryption_config;=0A=
     +	my $smtp_user_config;=0A=
    ++	my $supports_oauth2 =3D 0;=0A=
     +=0A=
    -+	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {=0A=
    ++	foreach my $outgoing ($doc_parsed->findnodes('//outgoingServer')) {=
=0A=
     +		$config_num++;=0A=
     +		if ($outgoing->findvalue('./socketType') eq 'SSL') {=0A=
     +			$smtp_encryption_config =3D 'ssl';=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
     +			$smtp_user_config =3D $outgoing->findvalue('./username');=0A=
     +		}=0A=
     +=0A=
    ++		my $auth_mechanisms =3D $outgoing->findvalue('./authentication');=
=0A=
    ++=0A=
     +		print "\nConfiguration $config_num:\n";=0A=
     +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";=0A=
     +		print "  Port: ", $outgoing->findvalue('./port'), "\n";=0A=
     +		print "  Encryption: ", $smtp_encryption_config, "\n";=0A=
     +		print "  Username: ", $smtp_user_config, "\n";=0A=
    ++		if ($auth_mechanisms =3D~ /password-cleartext/i) {=0A=
    ++			print "  Authentication: Normal Password\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /password-encrypted/i) {=0A=
    ++			print "  Authentication: Encrypted Password\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /NTLM/i) {=0A=
    ++			print "  Authentication: NTLM\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /GSSAPI/i) {=0A=
    ++			print "  Authentication: Kerberos / GSSAPI\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /client-IP-address/i) {=0A=
    ++			print "  Authentication: Client IP Address\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /TLS-client-cert/i) {=0A=
    ++			print "  Authentication: TLS Certificate\n";=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /OAuth2/i) {=0A=
    ++			print "  Authentication: OAuth2\n";=0A=
    ++			$supports_oauth2 =3D 1;=0A=
    ++		}=0A=
    ++		if ($auth_mechanisms =3D~ /none/i) {=0A=
    ++			print "  Authentication: No Authentication\n";=0A=
    ++		}=0A=
    ++		if ($smtp_encryption_config eq 'plain') {=0A=
    ++			print "\nWarning: Encryption plain is unencrypted!\n";=0A=
    ++		}=0A=
    ++	}=0A=
    ++	if ($supports_oauth2) {=0A=
    ++		print "\nThe SMTP server supports OAuth2 authentication. If you wan=
t to use OAuth2,\n";=0A=
    ++		print "please review the git-send-email man pages for more details.=
\n";=0A=
     +	}=0A=
    ++	print "\e[33m"; # yellow=0A=
    ++	print "\nTo apply the settings use:\n";=0A=
    ++	print "  git config --global sendmail.smtpServer VALUE\n";=0A=
    ++	print "  git config --global sendmail.smtpServerPort VALUE\n";=0A=
    ++	print "  git config --global sendmail.smtpEncryption VALUE\n";=0A=
    ++	print "  git config --global sendmail.smtpUser VALUE\n";=0A=
    ++	print "\nOmit --global to set the configuration only in this reposit=
ory.\n";=0A=
    ++	print "\e[0m"; # reset=0A=
     +}=0A=
     +=0A=
     +if ($get_smtp_server) {=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
     +	my $domain =3D $1;=0A=
     +	my $email_enc =3D URI::Escape::uri_escape($email);=0A=
     +=0A=
    -+	# 1. Try Mozilla ISPDB=0A=
    -+	my $xml =3D fetch_config_mozilla_ispdb($domain);=0A=
    ++	# 1. Try domain autoconfig if ISPDB fails=0A=
    ++	$doc =3D fetch_config_domain_autoconfig($domain, $email_enc);=0A=
     +=0A=
    -+	# 2. Try domain autoconfig if ISPDB fails=0A=
    -+	if (!$xml) {=0A=
    -+		$xml =3D fetch_config_domain_autoconfig($domain, $email_enc);=0A=
    ++	# 2. Try Mozilla ISPDB if domain autoconfig fails=0A=
    ++	if (!$doc) {=0A=
    ++		$doc =3D fetch_config_mozilla_ispdb($domain);=0A=
     +	}=0A=
     +=0A=
     +	# 3. Try MX record lookup=0A=
    -+	if (!$xml) {=0A=
    ++	if (!$doc) {=0A=
     +		my $base_domain =3D get_mx_base_domain($domain);=0A=
     +		if ($base_domain && $base_domain ne $domain) {=0A=
    -+			$xml =3D fetch_config_mozilla_ispdb($base_domain);=0A=
    ++			$doc =3D fetch_config_domain_autoconfig($base_domain, $email_enc);=
=0A=
     +=0A=
    -+			if (!$xml) {=0A=
    -+				$xml =3D fetch_config_domain_autoconfig($base_domain, $email_enc)=
;=0A=
    ++			if (!$doc) {=0A=
    ++				$doc =3D fetch_config_mozilla_ispdb($base_domain);=0A=
     +			}=0A=
     +		}=0A=
     +	}=0A=
     +=0A=
    -+	if ($xml) {=0A=
    ++	if ($doc) {=0A=
     +		print "\nFound SMTP server settings for $email:\n";=0A=
    -+		parse_config($xml, $email);=0A=
    ++		parse_config($doc, $email);=0A=
     +	} else {=0A=
     +		print "\nUnable to find SMTP server settings for $email\n";=0A=
     +	}=0A=
    @@ git-send-email.perl: sub parse_sendmail_aliases {=0A=
      # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if=0A=
      # $f is a revision list specification to be passed to format-patch.=
=0A=
      sub is_format_patch_arg {=0A=
    +@@ git-send-email.perl: sub send_message {=0A=
    + 		}=0A=
    + =0A=
    + 		if (!$smtp) {=0A=
    +-			die __("Unable to initialize SMTP properly. Check config and use -=
-smtp-debug."),=0A=
    ++			die __("Unable to initialize SMTP properly. Check config and use -=
-smtp-debug.\n"),=0A=
    ++			    __("Use --get-smtp-server to get correct settings for your SMT=
P server if needed.\n"),=0A=
    + 			    " VALUES: server=3D$smtp_server ",=0A=
    + 			    "encryption=3D$smtp_encryption ",=0A=
    + 			    "hello=3D$smtp_domain",=0A=
-- =0A=
2.50.1.320.g2ad311502d=0A=
=0A=
