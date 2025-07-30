Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FC2DC323
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888373; cv=fail; b=dMM/dOVmfnJD4202dNxNfk2Rfgip4+6rVqwxKy5uIzkmcdo5uj19EeolJUHIw912CYc4mIWDV9b06lfk4ncTeYQX82VhisQp/fwmbkXaXs4uCGykTUlMiiKoybKBBy69pRTH9ctNHju4d4mA0Bg7i5pIPNi7QIY8ngCebFt7Vbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888373; c=relaxed/simple;
	bh=meEAkFelw+SbcJY1WsXH639xfsxYGYih2i1WYoNQxzs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hgLg3TbRsZ6PTZ+/tQzrHpjgnzDPAuWu9nWhHj4VJay8mWnL2R6jnZfk/EQxr1m1vdhfCYNWnoXenf7l0cMNB7VVoqiczfdBlnx/SxSgyz09R69sxebIjWrM4eYz2krpBaJP2ggeKwPqD8ADqakWf93SkTnRNtMVRtXGRTrKxLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TxGeFhuc; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TxGeFhuc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f35q2WHsi7atkLzqbohZdI5evw2fMwfcx/kD3RS8SQwuPRKxs/DTXPtdS7SK+eFQ4/W6BmC1avcs4bmkc7L9dI3EktwWpVFV33V/i/1HnOFIVCHbITTmhmcJICvkxjg2Y2JOKvXIPDFcYhwtXveJ+1dih2pQxQvrNj6YsVsKAM+jDzfmjKgUal+W8Ux2XN6ZnYHt2B8lg+aktXIfIQfapFR8FN8UKzGC/W4DoAeBaH5Tft7TM3rvJoAsP2jHY1v3E0oJFqBCSyA9UOj0ghbajk1XI2j91awuw7kZkz6khNe+iCvwsKN5sSuEG6tOcIOH3JrKeScBBS1KhTtM8/67ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiDxEfVE47W1ADULPk69gKWyI9mM8YM8HhLxUsrL8aA=;
 b=Iu7/CNb0z8LYQbLpFSTBsT5s6FsSX55Yl3lZYGuEc+wG/YFDeGWUAfhW07LsFCL/q+VoOhoFLW1tAHHn4StJNHhCP0Cu0zoushKbdpxFDYIAxw81lshsDvuNvHMF4Ee44U4+6h4SbgmbvFWLVGHJwFVs8epp2h39eOYbc1LWL5vq99vejb4nBPc9RYnvmjxbPNao/6UmkZ6isvbemdPAzzyRUoBD08EeZsERs/SUJdHeNe0HQrMXAkn11G27BA8I3xzpCqb18aDIZo9sJ2uvSMWoKCLDqAS3WqGfRhrvIAhXzGvbM3LHZ3CahSu6tDK1AfnGA4HbTkbQog6d+FPGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiDxEfVE47W1ADULPk69gKWyI9mM8YM8HhLxUsrL8aA=;
 b=TxGeFhucDyyQ74iylTnRKfyNku+qfg/5Tuo72S+w2LprJVIjAbjHhf9AZChY02do34IJHBn6nZkwnZpWDApCf5WnLBuaI7LwXm7CdB3AmaoOfh/k+VCf3/zc5UIWz43o6WvhF0TstFKOd6iI9fnxWiTY6K62hEXoQjrtsZE2g8Yi6xgfmf34rxEExglf6lF+RP2kw2VjV/iyx0ZeuxBAQkVHhZk2r+AAFLZIWi5Il1y7Pg7im07KGRYDLtVTffd61JDz6FPax3wlpBDw1g1NWbDDYdZOpBaT0a96noXxYipbdgQpBC7tL6N6YDqxFYNXw7ucobYvDMnlIb+29pL7EQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 15:12:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 15:12:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] send-email: add --get-smtp-server option to fetch SMTP
 settings
Thread-Topic: [PATCH v2] send-email: add --get-smtp-server option to fetch
 SMTP settings
Thread-Index: AQHcAWRimBaHkan2W0SdeBogO+mWgA==
Date: Wed, 30 Jul 2025 15:12:36 +0000
Message-ID: <20250730151227.12389-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB6036:EE_
x-ms-office365-filtering-correlation-id: 6ba4ab3e-1c90-452a-5ff6-08ddcf7b84ac
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|38102599003|461199028|19110799012|41001999006|15080799012|8060799015|8062599012|440099028|40105399003|3412199025|4302099013|10035399007|12091999003|19111999003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?E27WtkptmpJStK8mfILAAmd9KkgkvFH7DybYkCS+y0OIARzUDiUe753Uwn?=
 =?iso-8859-1?Q?Pn6NaKOngyB4BBRo63OCM/CHMExpiL4pLMonhgDm4hcLIlqzybxZvcaeO9?=
 =?iso-8859-1?Q?mk2DnK2atJCKLU/FEO7DB8Mn0FamM5wTnRv6MU5gEqx1LrjBh1ci8XvUjZ?=
 =?iso-8859-1?Q?EKi7fL+Tk+lTWLmloLqyF4+NRerpyQSDAhu9CoLRA9AXjV8O8VcA9FCfbQ?=
 =?iso-8859-1?Q?FMLIvd1kJ0BC/wImSvaWtKbxsbte1qG1gut+roBjrE/tr9pXT3F/x3TeM4?=
 =?iso-8859-1?Q?2b7fHjDus+b5EtSYkX53QyUF7srFRq6WLbmzR0Lo8gLWFOe380SENP3mWK?=
 =?iso-8859-1?Q?jIp8V4ZrbO8Gp5aDitefGcgyeAlhZjQO0Q86s+kbxqjs2NnQy4w5qvljAr?=
 =?iso-8859-1?Q?v/zefPY5Idydp4aTvB72keXQeyZxXs872mhFVTcTdgw7jxeuqrRZWse9jc?=
 =?iso-8859-1?Q?lws2PF3WDGHUvbS0m1YoPorIERCVHDjQnF65yVJjlZR+vPu0qM+ocawIyw?=
 =?iso-8859-1?Q?ztWr7dY6oZk6koPbtJlJloIHs7kgCQM51ajfFE3tJ3Fq2Waf+NIw69+t8/?=
 =?iso-8859-1?Q?BymTnN6OAG5YZV+hDixelA6dUURgq6oG2OXftTEe+oFJ7Cn3gKM5KK84Tl?=
 =?iso-8859-1?Q?lk/vKaKSj79QQMzW8Aw22plOP+/0IqXmg/Zqb1Digu7oyrJMOk8vbm+H73?=
 =?iso-8859-1?Q?IdMc/hPLdhWuGZn+p4FjrgjAovjbyNq7tV5hCdOgIogHXQeKWSo0M3IjwW?=
 =?iso-8859-1?Q?NEoC3YmmWKjB5VGMGscGtjx+/8cLZ9F7dym85t+x8bVwES0h9vmVtffAgd?=
 =?iso-8859-1?Q?S8w5dpZ1DtrxwEvltVUqigCBAhvy+JtMgNDkQz0gfzyPvKAQeYVFg4b1mY?=
 =?iso-8859-1?Q?n7kRfUfljVnJeS0YBYr/Y8VqDyQg3W9XkS80RIBMvneG9M1JLQOp0WlFBX?=
 =?iso-8859-1?Q?FC4erQhNJJSt1wDgiT1HWaSh4RnZis+NwsLKFSi6qZ/0m01iorSeD3cLrz?=
 =?iso-8859-1?Q?fQGxPq8WrBU2EJDgsAOx7fXahMxjlW2qncIhNuDYU5Gvtc2P9k/jt9UvVb?=
 =?iso-8859-1?Q?sWGrC45nHRsb17bBOAOANdn7kafcw9z++9PpJQTIWGTPb9XlyD2vwzQzi1?=
 =?iso-8859-1?Q?4/2nvQLWBzPtlK8OiQ1BZy8O+DqIc0cNdsnjHYfBAmYDSF8BXGDJJU6t29?=
 =?iso-8859-1?Q?sHSmToQcX/UKMfZDbfaJmlVdurYFUhN4TbiKwZPQY5iFObWXmI5RObUP7e?=
 =?iso-8859-1?Q?iD415ha8rTjA7yHntictCYf7kKH5CjRVI6NKMHWozoSpKkAeFofsqfyDwE?=
 =?iso-8859-1?Q?yQ02cp8kj5Rfp40GvvX1bCveer4iA/jtATv2zXIUDP+J33uh1xt3R/++q/?=
 =?iso-8859-1?Q?6gdo+j9ntS213nM1l1VoLbh96bial3WA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qytLsUnw/Oh29qd1FPB2aooVjJbYIj/A/x/JVlk74f8DHnrqFUORUWE5up?=
 =?iso-8859-1?Q?K/J4KSeXe/wLy+OpO8bU+ZlRxiHU2f3yhxgWy7zjd4FK1Eb697q0mzpCgp?=
 =?iso-8859-1?Q?cCnyt617MfykJAISvMdCCOZ4yjV+5a46/FN/fB9gyPwBezbG5mFGXxlU6D?=
 =?iso-8859-1?Q?JMr2rVCf89QBoieZgVNhV2Qw1cZGz0uMD9MkzkdPjF08IzLGjoc1TrMSAR?=
 =?iso-8859-1?Q?IVe3W4YJb5Ct57Q38y/sSe5081Lbb9ze2X9ZJmrVvCLuEyidnrdDr88xwo?=
 =?iso-8859-1?Q?+gK/MxO7yVn6o7lxUCeGPTEX9ZW140z1iGdSgA0jCA7wAgpMCYY8OGB7Uj?=
 =?iso-8859-1?Q?HjyyAI1iFEztCyPdbTJgF8292b6ranAAzXexJbPOe0yRr5JAo3qQwgnMLS?=
 =?iso-8859-1?Q?4tAgaV7u7Qmpu7WmI4fbqwf4B/vLomQzEii/O+MlFJdkR3hnPmcAesfQKW?=
 =?iso-8859-1?Q?N+yZLur0pr6eDSZJsLKbGKUelKc41298CxLz1tF1PHtuDjKlr7+qC5UDYT?=
 =?iso-8859-1?Q?/rE930bc4sCmkIQ+AKQLgQWzROpQttcBs0x+6kN69VjYHqQK+DIhnm9K30?=
 =?iso-8859-1?Q?SfyPAaBfDLsg8NzawEK+pRFLxlRsD63rz1OAJK3Mr5UiRGCoSATDv3JwxQ?=
 =?iso-8859-1?Q?g4BwL5FLDuSJTfsERRMWh7gnt47nwUe5WKUYkGwmZ+qj9duUFPiyYjGP5r?=
 =?iso-8859-1?Q?duXWe1UxUpqbt0tPWLoRgJgSSv2W1wgmJ8DasLeToEnWZk6D5Axhu8fGYk?=
 =?iso-8859-1?Q?wHsQ1ZJOTs4RMJGtUg9oXyPds7pFffq7NpLCmIGQ4PGnHJd2pNHRs/BhsV?=
 =?iso-8859-1?Q?eRSrJIvqVi7hi42gqajubJKXL5nDSSCo9/w/D1KVOZBtQ/S0blAsPgfN0Z?=
 =?iso-8859-1?Q?31L5ewzz1vDXihxIuOEPNPjOExo4ck3cV+wKR/wP5qvjupXpAF/azwq3t2?=
 =?iso-8859-1?Q?SbGTtjahvZEBqQdYkdbXjbap84gErBS1DBEW7F3Y4o0qLmaez5jLNK7udi?=
 =?iso-8859-1?Q?zM9zXW0UJ+ubN+7l4vwyBdiWa04V76FKtmr0TshTHcgMaMMUNpysGy3hvq?=
 =?iso-8859-1?Q?evkRor9/S+NRiGq3k6RqdRcmJVQTJ6NFPNKdLCxciM/1RqpuIAjSDCDSGI?=
 =?iso-8859-1?Q?Gk0X/f4JIAl9ZoWW6xL82GufdscmWPpLw0SfTvNzvGnFxKWMZvdGlijvis?=
 =?iso-8859-1?Q?ueAnCtdigLhSZ1Al282OYvwdfmaDpeM+Cn29I9RPiuvdc6cgru7w2Wb4eZ?=
 =?iso-8859-1?Q?tswmZMycXLccAleYgblZRIe5GT9Yd77NrvGTjLUZQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4ab3e-1c90-452a-5ff6-08ddcf7b84ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 15:12:36.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6036

Autoconfiguring SMTP server settings is a common feature present in many
email clients. In order to get the correct SMTP server settings easily,
this commit adds a `--get-smtp-server` option to `git send-email`. This
option attempts to fetch the SMTP server settings for a given email address
via the following steps:

1. It first tries to fetch the settings from Mozilla's ISPDB at
   `https://autoconfig.thunderbird.net/v1.1/[domain]`.

2. If that fails, it attempts to fetch the autoconfig file from the email
   provider's autoconfig URL, which is typically in the format
   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[email]=
`.

3. If that also fails, it falls back to checking the MX records of the
   domain used in the email address to find the SMTP server. It can be
   useful in case of emails with custom domains. It attempts to guess
   the correct domain for the email from the MX records, and repeats the
   first 2 steps with the guessed domain.

This feature is heavily inpired by the autoconfig feature in Mozilla
Thunderbird. A detailed documentation about how thunderbird fetches the
autoconfig settings can be found at:

https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/
---

v2: - Improved checks for valid email address.

 Documentation/git-send-email.adoc |  55 ++++++++++-
 git-send-email.perl               | 157 +++++++++++++++++++++++++++++-
 2 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 5335502d68..d4fb761b4f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -13,6 +13,7 @@ SYNOPSIS
 'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
 'git send-email' --translate-aliases
+'git send-email' --get-smtp-server
=20
=20
 DESCRIPTION
@@ -505,6 +506,15 @@ Information
 	address to standard output, one per line. See `sendemail.aliasFile`
 	for more information about aliases.
=20
+--get-smtp-server::
+	Attempt to get the correct SMTP server settings by entering an email
+	address. Once an email address is entered, it will first try to get
+	the correct settings from
+	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], followed
+	by attempting to check for an autoconfig file hosted by the email
+	provider, finally falling back to the MX records of the domain used
+	by the email address.
+
 CONFIGURATION
 -------------
=20
@@ -512,6 +522,44 @@ include::includes/cmd-config-section-all.adoc[]
=20
 include::config/sendemail.adoc[]
=20
+GETTING THE CORRECT SMTP SERVER SETTINGS
+----------------------------------------
+
+You can attempt to get the correct SMTP server settings by using
+the `--get-smtp-server` command line option with `git send-email`.
+It will ask you for your email address, then attempt to get the
+correct SMTP server settings for that email address. An email
+address may have more than one configuration. In that case, any of
+them can be used.
+
+For example, an output with email `someone@pobox.com` yields:
+
+----
+Configuration 1:
+  Server: smtp.pobox.com
+  Port: 465
+  Encryption: ssl
+  Username: ssw@pobox.com
+
+Configuration 2:
+  Server: smtp.pobox.com
+  Port: 587
+  Encryption: tls
+  Username: ssw@pobox.com
+----
+
+Here the value of:
++
+- `Server` corresponds to `sendmail.smtpServer`.
+- `Port` corresponds to `sendmail.smtpServerPort`.
+- `Encryption` corresponds to `sendmail.smtpEncryption`.
+- `Username` corresponds to `sendmail.smtpUser`.
++
+
+This method should work well for almost all large email providers in the
+world. If it provides invalid settings or cannot retrieve them, contact
+your email provider.
+
 EXAMPLES OF SMTP SERVERS
 ------------------------
 Use Gmail as the SMTP Server
@@ -624,8 +672,11 @@ https://metacpan.org/pod/Net::SMTP[Net::SMTP].
=20
 These additional Perl modules are also required:
=20
-https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
-https://metacpan.org/pod/Mail::Address[Mail::Address].
+https://metacpan.org/pod/Authen::SASL[Authen::SASL],
+https://metacpan.org/pod/Mail::Address[Mail::Address],
+https://metacpan.org/pod/Net::DNS[Net::DNS],
+https://metacpan.org/pod/URI::Escape[URI::Escape] and
+https://metacpan.org/dist/XML-LibXML[XML::LibXML].
=20
 Exploiting the `sendmailCmd` option of `git send-email`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 437f8ac46a..580e272139 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -32,6 +32,7 @@ sub usage {
 git send-email [<options>] <format-patch options>
 git send-email --dump-aliases
 git send-email --translate-aliases
+git send-email --get-smtp-server
=20
   Composing:
     --from                  <str>  * Email From:
@@ -108,6 +109,7 @@ sub usage {
                                      input according to the configured ema=
il
                                      alias file(s), outputting the result =
to
                                      standard output.
+    --get-smtp-server              * Print the SMTP server settings for a =
given email.
=20
 EOT
 	exit(1);
@@ -222,6 +224,7 @@ sub format_2822_time {
 my $force =3D 0;
 my $dump_aliases =3D 0;
 my $translate_aliases =3D 0;
+my $get_smtp_server =3D 0;
=20
 # Variables to prevent short format-patch options from being captured
 # as abbreviated send-email options
@@ -501,6 +504,15 @@ sub config_regexp {
     if !$help and ($dump_aliases or $translate_aliases) and @ARGV;
 die __("--dump-aliases and --translate-aliases are mutually exclusive\n")
     if !$help and $dump_aliases and $translate_aliases;
+
+my %get_smtp_server_options =3D (
+	"get-smtp-server" =3D> \$get_smtp_server,
+);
+$rc =3D GetOptions(%get_smtp_server_options);
+usage() unless $rc;
+die __("--get-smtp-server incompatible with other options\n")
+	if !$help and $get_smtp_server and @ARGV;
+
 my %options =3D (
 		    "sender|from=3Ds" =3D> \$sender,
 		    "in-reply-to=3Ds" =3D> \$initial_in_reply_to,
@@ -565,7 +577,7 @@ sub config_regexp {
 my @initial_bcc =3D @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bc=
c);
=20
 usage() if $help;
-my %all_options =3D (%options, %dump_aliases_options, %identity_options);
+my %all_options =3D (%options, %dump_aliases_options, %identity_options, %=
get_smtp_server_options);
 completion_helper(\%all_options) if $git_completion_helper;
 unless ($rc) {
     usage();
@@ -757,6 +769,149 @@ sub parse_sendmail_aliases {
 	exit(0);
 }
=20
+sub fetch_config_mozilla_ispdb {
+	my ($domain) =3D @_;
+	my $ispdb_url =3D "https://autoconfig.thunderbird.net/v1.1/$domain";
+	my $xml =3D fetch_config($ispdb_url);
+	return $xml if $xml;
+}
+
+sub fetch_config_domain_autoconfig {
+	my ($domain, $email_enc) =3D @_;
+	my $autoconfig_url =3D "https://autoconfig.$domain/mail/config-v1.1.xml?e=
mailaddress=3D$email_enc";
+	my $xml =3D fetch_config($autoconfig_url);
+	return $xml if $xml;
+}
+
+sub fetch_config {
+	require HTTP::Tiny;
+	my ($url) =3D @_;
+	my $http =3D HTTP::Tiny->new(timeout =3D> 10);
+	my $res =3D $http->get($url);
+
+	return unless $res->{success};
+	return $res->{content};
+}
+
+sub extract_base_domain {
+	require IO::Socket::SSL::PublicSuffix;
+	my ($host) =3D @_;
+	my $ps =3D IO::Socket::SSL::PublicSuffix->default;
+
+	my $public_suffix =3D $ps->public_suffix($host);
+	return $host unless defined $public_suffix;
+
+	my @host_parts =3D split(/\./, lc($host));
+	my @suffix_parts =3D split(/\./, $public_suffix);
+
+	# Find where the suffix starts in the host
+	for (my $i =3D 0; $i <=3D $#host_parts - $#suffix_parts; $i++) {
+		if (join('.', @host_parts[$i .. $#host_parts]) eq $public_suffix) {
+			# Precursor + suffix =3D base domain
+			return join('.', $host_parts[$i - 1], @host_parts[$i .. $#host_parts]) =
if $i > 0;
+			return $public_suffix;
+		}
+	}
+
+	return $host;
+}
+
+sub get_mx_base_domain {
+	require Net::DNS;
+	my ($domain) =3D @_;
+	my $resolver =3D Net::DNS::Resolver->new;
+	my $query =3D $resolver->query($domain, "MX");
+
+	if ($query) {
+		my @mx_hosts =3D sort { $a->preference <=3D> $b->preference } grep { $_-=
>type eq "MX" } $query->answer;
+		if (@mx_hosts) {
+			my $mx_host =3D $mx_hosts[0]->exchange;
+			$mx_host =3D~ s/\.$//;  # Remove trailing dot
+			return extract_base_domain($mx_host);
+		}
+	}
+	return;
+}
+
+sub parse_config {
+	require XML::LibXML;
+	my ($xml, $email) =3D @_;
+	my $parser =3D XML::LibXML->new;
+	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };
+	die "Failed to parse XML\n" unless $doc;
+	my $config_num =3D 0;
+	my $smtp_encryption_config;
+	my $smtp_user_config;
+
+	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
+		$config_num++;
+		if ($outgoing->findvalue('./socketType') eq 'SSL') {
+			$smtp_encryption_config =3D 'ssl';
+		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
+			$smtp_encryption_config =3D 'tls';
+		} else {
+			$smtp_encryption_config =3D 'plain';
+		}
+
+		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
+			$smtp_user_config =3D $email;
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
+			$smtp_user_config =3D (split /@/, $email)[0];
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
+			$smtp_user_config =3D (split /@/, $email)[1];
+		} else {
+			$smtp_user_config =3D $outgoing->findvalue('./username');
+		}
+
+		print "\nConfiguration $config_num:\n";
+		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
+		print "  Port: ", $outgoing->findvalue('./port'), "\n";
+		print "  Encryption: ", $smtp_encryption_config, "\n";
+		print "  Username: ", $smtp_user_config, "\n";
+	}
+}
+
+if ($get_smtp_server) {
+	require URI::Escape;
+	print "Enter your email address: ";
+	chomp(my $email =3D <STDIN>);
+	$email =3D extract_valid_address($email);
+	if (!$email) {
+		die __("Invalid email format.\n");
+	}
+	$email =3D~ /@(.+)$/;
+	my $domain =3D $1;
+	my $email_enc =3D URI::Escape::uri_escape($email);
+
+	# 1. Try Mozilla ISPDB
+	my $xml =3D fetch_config_mozilla_ispdb($domain);
+
+	# 2. Try domain autoconfig if ISPDB fails
+	if (!$xml) {
+		$xml =3D fetch_config_domain_autoconfig($domain, $email_enc);
+	}
+
+	# 3. Try MX record lookup
+	if (!$xml) {
+		my $base_domain =3D get_mx_base_domain($domain);
+		if ($base_domain && $base_domain ne $domain) {
+			$xml =3D fetch_config_mozilla_ispdb($base_domain);
+
+			if (!$xml) {
+				$xml =3D fetch_config_domain_autoconfig($base_domain, $email_enc);
+			}
+		}
+	}
+
+	if ($xml) {
+		print "\nFound SMTP server settings for $email:\n";
+		parse_config($xml, $email);
+	} else {
+		print "\nUnable to find SMTP server settings for $email\n";
+	}
+	exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {

Range-diff against v1:
1:  5e32982219 ! 1:  0db913ba39 send-email: add --get-smtp-server option to=
 fetch SMTP settings
    @@ git-send-email.perl: sub parse_sendmail_aliases {
     +	require URI::Escape;
     +	print "Enter your email address: ";
     +	chomp(my $email =3D <STDIN>);
    -+	$email =3D~ /@(.+)$/ or die "Invalid email format.\n";
    ++	$email =3D extract_valid_address($email);
    ++	if (!$email) {
    ++		die __("Invalid email format.\n");
    ++	}
    ++	$email =3D~ /@(.+)$/;
     +	my $domain =3D $1;
     +	my $email_enc =3D URI::Escape::uri_escape($email);
     +
--=20
2.50.1.320.g2ad311502d

