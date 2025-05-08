Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC6221DBA
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700461; cv=fail; b=kykxFekVAe4d8Lv2sUIZ47sEbVajejelrBwCcaxhbZ6UocU+Wg/uhJNezoQDbOQHN1BGcU/YMcxTfRkAGsk2wSAJ7/72SKbfw1dvSKl7EXmykzmE93wi3/mfSfG70WTRdHbVEG4MLwS0ZWUwUyeaYSSQ/DJTpXQgzBGA5QBITFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700461; c=relaxed/simple;
	bh=0wQNDruKIBTzCYyYhUPUBXf9UtyfSpuAAkFzdeoDyro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eCJUDTu839tLFL8hpMGyCCH0b5+EcDzrBlSEK/YW0N1RxpsKAeSYFac1xuDbpnowhYGK7mVPWAJmytgcPMv+VU0ULg6DDAryRrYomvVudfOlw8DSi/nsV/UziwJqI0QOxkVzhIz7oLtbcEgcfe8m3+VvksX1fMD7qQGg5hp1d6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LVmmamb+; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LVmmamb+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuNioSDGwKnKqGWmZXTylO82tQbOEH9l2Tn0pF9JIpKDo4nQnR18fHz2RgcRLO0+azBpEGDUMojltfw7rWUSNbjW7heJz5T2nqDIUgx59zmrDA0ZJM7kYSCPwzAulPVa5G3+9romRiBLWcykl2C5Nf0JVTSZu8zWj9wzNSB1tnv44yCiJbfnjsvSUnKvrPRjdXvaJRFG/vNDvyIfrZWPTGvW4yR2x/f7z7kNtz4SkoDrZaW+GN2EAR7zsG9IInfy5Wb2vstfY2jPjdOCIE0+kqhZE8AuVJd2qomK+UGm1csN3iXRYQCwkeJE+1SeSgq5mZInPnLZAfwGYcL5uTOmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNdQNGZVWIBO329lraON46/xW8kEYtIXudZzcTTIyyw=;
 b=vZrR2r565IS+2zd9ablXhzEDmsvgUcUM/gnQE/6kNaNVJRfwESEZmvd4N1F/BU0NcArCzWO9Z5GoNmaF9ulQ455Avyf5wuj3FSf3zZKxHYq3RCmLSD7tVhImtaifxiVakPMUxLPsjxc7YnDv3e5UqE2gxFNXJO/r9Wk8OTzIJy/t3sfJ8z6Sl2U8t4/yaXxaQ6gKj+W1KHPug8A58tirA/kHTfGLdwekYRSidY01pstoD1pOy1BWMn9G+Je5yQFzNbUgj50L5KAFFrcLx1l/IxeDhgx5Kmw1tnZ4lM/GzbS/MBKaBgohFXX6SeOjA/Cfj8xem9qfY2DQP9DM3pkNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdQNGZVWIBO329lraON46/xW8kEYtIXudZzcTTIyyw=;
 b=LVmmamb+H7pVBTBn8XX5DxldMra4NTwo+awhLAnzkGUGvWkyv11FZadcKyf+xj2oqtUi5c7NWdWdaOJs/jh+bc6OGLTc1cLkAiLf4InWOaaorMOVmvDUl/6k/E6/E0lotS6foQhwQbKoayLgX2lZTkXs9rJ9j8+pbuLqxZw22PEjn26JQKs4lecQ1avxX7tEryw8ske+bAjj5lXpadcyXeeUgYq5vF4lFQMhDYN3ljXreMxevZPxgrTFmJc987onDgdSOQnphZhpMwkqTHubHUdH+LX8qBlpfy/VkPludbYzcDyRtGaZ66mQEpZeqQyCKb3oouosRfRhePg8uy6plA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9409.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 10:34:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 10:34:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 2/3] docs: improve send-email documentation
Date: Thu,  8 May 2025 10:31:57 +0000
Message-ID:
 <PN3PR01MB9597FB82424820EAB5D4D2EAB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250508103358.15409-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 19df8223-751e-4095-1995-08dd8e1bde34
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZlTCb19IcwxWRBJYK03wWzGLNKCZYezGU9ni3RpR4qw8n/U1hueKU4fDcw2xWVL0SQL8yAETEfPCafISNRmEaJDUFlMJUFOopcWL4mfMi2RiMAut6V8cGspIp2YoE6EkPlbYtGfSedZ93PsQfJCW15pXVLR9Frv200eQSO2PXIHJacT7K7WxTJd30QXPmKVIG8YtifHszvrZe+iIIPZUj7TPEDdDUN2UEzcHbl2VPezto29zJtQ9to5GIU88rYXdq3DoVHBEG6/f7O80c3yxRfaB8V5t9I35CfjN7cne69m6+ODv5HwXFj/9LgMw/V81CY2qzdlnTl27mN0SbGOy6eC1jd13Jv1dVcw2b4fHSIO3rquoy9vOxC4IScHF94ZSW81/iPsZTRRAlq04x0M57EYO6RljkkAW3LGA7SRJXPF7LIGFC5SVsqEF8P9yKiL9ziQlSygbdrz+LN1kul9hy46LaMoozXd0PsJU1/7n+S3fpRkwAR6N7ARNKE3m6ET8QYrxXOStUBkzlO64jqvRoD1b9vHeqsH3hr1S9i5OKkD4CZyqemmsW1Wzyzd19ouYUbPx9Ez6g5wbwa1yLeQpw8midAwHHhE7wvBuTZBoK86acK51hSbiSPFY8XE4ISBkzLtuSmngeQqYxTiNF6FdV3NZQfLsmgdIY/hlfRifKHV7u+A3z5+3u0sFfeOqOYIgcjw2NgFdMhIg+WlYgqRZS68dTFrpdtOY3FBxk7BY/9GZ4CHpZcft+IglISy/V1w/pToUF0hdD0hZMfwiuAm581ZXUlXvMtnMZ6U/YxKm0iSEE7fCoZ5NZgH
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|12121999007|15080799009|19110799006|8060799009|5072599009|440099028|3412199025|34005399003|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7A/UWx0PouNI5E4/c+uM1OFIU6wE8eMNsPAyg5f95s2RJAQAoFu+6Sk6/h2?=
 =?us-ascii?Q?9OSD3oFrE8gZXXhS2m3TbeGKbBDJva5zJgP/qC6wKyaq+EQOoy6SyDRKNV8a?=
 =?us-ascii?Q?CuqFgH0JAQuL6FT975cRLZtHXAIEOIMYFhXVCs8hu9RfXoMLFhx/SwvtbPJv?=
 =?us-ascii?Q?7DrovkGfDvYrQNYEzhZhBj0pnFPE31YIKtfsHt2cugred2RUOC43ZTUMPNZk?=
 =?us-ascii?Q?Zx2k8Zymakh3mCzU1h8CI2ISdsET/JJsMKkQtUzj5f+b/cfwL/qI7FZKP6nk?=
 =?us-ascii?Q?jyHuoS6OBm0ck5j/p2PW6afsEWq4nlgF3WtdpgpYTfLUkx9z6hbJY9MOgz4t?=
 =?us-ascii?Q?vq+yQGIr7EzIVNxfWBoqSJC2ZIdDdWOFVDo+lm8dUDc7A9fERuR/vxbkwjLK?=
 =?us-ascii?Q?ZeZ8rXTMehLu9TnOBfnJ2d4zDcmj/SnN9UW5GOxGX+EEs4r9K0ssjWH1Q4Yo?=
 =?us-ascii?Q?qv7sbQbqrWA3hn8BqzTo4T2oxTzXhzrpnqRW7hYcTsOHr7kEzsftjkVaYQc8?=
 =?us-ascii?Q?VkMVxWIKCmiP6Ceu1glPtgF7UppeNfwiS57dzJxM4eeldCWNfN+wEkCt1K/F?=
 =?us-ascii?Q?dA9g2JTqhfOl3dgLjCE9ekeq7+c5C0JuNoMWqZqlHbb8aOtOIqBsbMWHyG0P?=
 =?us-ascii?Q?DDMhIplj+54ifBxgrDV5Y86QKQRwXeB937wPFocf3UOCXquXgkOmI88ErTXN?=
 =?us-ascii?Q?FIz41UEfhHWqdZd9AA3VmrzdJRGbEUni/6yAPv+XK9AOugerdIsAfSfFtqP/?=
 =?us-ascii?Q?Triw8yZN0MTVtuK2WrdQbAhAQLqie4PbvkX1uj72TPDeOfxAhP22tOQD82Lr?=
 =?us-ascii?Q?xlJRbV8zL+NHP3/4uq4tPt2oevtMEotrD+9R5Ujyz/5qNECW4nu8y6Gcxc8r?=
 =?us-ascii?Q?d8jXx3J/aes4gE6QVPF7VLGINoBmEqmwQjdhsLXzO7PieM+caqkth+wFdatT?=
 =?us-ascii?Q?/zGTLm++w9lDh12pIBauD7FE6/8VF1FtrMWRcOoTqVdsmDBH9JPwJE7wT/rg?=
 =?us-ascii?Q?YuA5NuXGGEeS83x3UEhuy+OWRrjrmOxNIlkZfDBCshqeaesif+aMZ4VZB5bm?=
 =?us-ascii?Q?GQ1LjOovbLwwzDPQs7MQ3uUqpZPwbzsctkgpGg3DdmuiYoyNoXbBBv6Jla02?=
 =?us-ascii?Q?J5FebyfRQTkTPnKJYfe4rJGt2+fRVP9vAudiSSItL4CTNA/uXjgLG/GzIQJF?=
 =?us-ascii?Q?LwXNhU8ag6PimP8WlRt0h6xKoZCClTwNat8zbXxWmE1BFd5dtzJHyp/zTzVW?=
 =?us-ascii?Q?dHLcgj/88v4mGbDcLWuST5kfmRlAVhWaQCIr3IhS7w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lr8tz6Pa9llNcu4uUqLfnuzebJ/aWZlOco0Ii/AyOIn1yLHlHhHtg9EPS2+c?=
 =?us-ascii?Q?ujKN521usH6l1VESROOUk6pf3Xcq7PoiNoglm+KV3LHcyJfa1YzAJZKHysdM?=
 =?us-ascii?Q?lcPBbOG2dyjkNX2MXQxL8Rb06WiIMdSAu9TDKppOfJ/26GlqzvuULclW7RoV?=
 =?us-ascii?Q?Q314SLYLSdBcZzK9M823oACSztIP/4LeqaJR1sqH1qu/UqVhsF7H55epQwi1?=
 =?us-ascii?Q?9PCwGWrstRnsBd3qeOlC0+29bjkXLKPC8mC2HLAw7z/azhqVeYu36fdja4a3?=
 =?us-ascii?Q?wSjWvuEn45s+xFp8DQC2dMEmEt/fJZD6aWyAeBxLjzgT4mj4KLdAl8o6tOqZ?=
 =?us-ascii?Q?WxAPE7nFhXoX57AyDdnkvhdxFMukTak9fdoqWS9RzoS1EOzNJ3E2x6t16suP?=
 =?us-ascii?Q?v2Nz63sH+QlxTbL1f/HhVI7/wGNLP/88rfpNQ2xFKD7irZTiCv77I5ykASio?=
 =?us-ascii?Q?A7YP6pzV840/AVtGqMA0TtQeeKkbEXinXwJh5oQUw+wiG5QIgvZCtSERKNfA?=
 =?us-ascii?Q?y56VL9DfOC8H/iso6Aro6t2uNkN/CTaucJFUHwvszw8e4+kLS+XAjgGrIC2C?=
 =?us-ascii?Q?hVy39HlvLmTzf5OsAHgavw9Qdrz2Dhm/g0wdY2Jss2x9g0VFqa0A29LnQs8X?=
 =?us-ascii?Q?gRveqqEIRvCHySGEq1qrF6+kC6oeQXMPLvRt4F7yZblKskeejmpuzKriTKS9?=
 =?us-ascii?Q?BJmJbMUN9QEebwh3iBz56NlNymjyaK7Axg1deMaPoe0z5gFwoerilOUI2Ieo?=
 =?us-ascii?Q?tc8jtezeiJfzv3hSkGK3V6wDj5+Z5c1nrzei8BhtIEJ5jqjynCTHGt9/pMak?=
 =?us-ascii?Q?evT8xXYLEcecc5WIyu7BsLMOqTp5kNVY/RyL3cEgOsnN6wWrDUaNWi4Y5WzT?=
 =?us-ascii?Q?H9i6/EEgB/3uzYdWmyKHgR35RN6fVNUei9uUbZDJOSRQ/soIRs1sY1ePS8Cc?=
 =?us-ascii?Q?IVUEUPY5nEYCBs9zq65U5/9iu2zTsgDAy6aEtK1NKf5GVjvsTnKyW4wjfmBs?=
 =?us-ascii?Q?6TDAAQA0DgtR38Z4cPm0h+GTp57rv9LdRzWeaeBF/3B9uNaFpvipsEAgGx9b?=
 =?us-ascii?Q?zW6BHXQWO/kJZB0wOKfoaUWD83euIV5enY6dVEnLkG4fv1G2a4tctLcG1Ckn?=
 =?us-ascii?Q?vme/M1j75UPIaQzMNVUm004tTjGqWdO6oKEO5TCxImWFM1eFxF3qoQaa1xGh?=
 =?us-ascii?Q?iGjPiSUB6xmT9hOVDEDbu+xA9bxR5ed9T8VRTktiOXwI54BcSQTnlLIyLiU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df8223-751e-4095-1995-08dd8e1bde34
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:34:10.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9409

OAuth2.0 is a new authentication method that is being used by many email
providers, including Outlook and Gmail. Recently, the Authen::SASL perl
module has been updated to support OAuth2.0 authentication, thus making
the git-send-email script be able to use this authentication method as
well. So lets improve the documentation to reflect this change.

I also had a hard time finding a reliable OAuth2.0 access token
generator for Outlook and Gmail. So I added a link to the such
generators which I developed myself after seaching through lots of code
and API documentation to make things easier for others.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 63 +++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..d232e109a1 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -509,12 +509,12 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sendemail.adoc[]
 
-EXAMPLES
---------
-Use gmail as the smtp server
+EXAMPLES OF SMTP SERVERS
+------------------------
+Use Gmail as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To use 'git send-email' to send your patches through the GMail SMTP server,
-edit ~/.gitconfig to specify your account settings:
+To use `git send-email` to send your patches through the Gmail SMTP server,
+edit '~/.gitconfig' to specify your account settings:
 
 ----
 [sendemail]
@@ -528,6 +528,37 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
+You can also use OAuth2.0 authentication with Gmail. To do this, edit your
+'~/.gitconfig' file and add `smtpAuth = OAUTHBEARER` to your account settings:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.gmail.com
+	smtpUser = yourname@gmail.com
+	smtpServerPort = 587
+	smtpAuth = OAUTHBEARER
+----
+
+Use Microsoft Outlook as the SMTP Server
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
+Therefore, OAuth2.0 authentication must be used for Outlook.
+
+Edit '~/.gitconfig' to specify your account settings for Outlook and use its
+SMTP server with `git send-email`:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.office365.com
+	smtpUser = yourname@outlook.com
+	smtpServerPort = 587
+	smtpAuth = XOAUTH2
+----
+
+SENDING PATCHES
+---------------
 Once your commits are ready to be sent to the mailing list, run the
 following commands:
 
@@ -536,9 +567,25 @@ following commands:
 	$ git send-email outgoing/*
 
 The first time you run it, you will be prompted for your credentials.  Enter the
-app-specific or your regular password as appropriate.  If you have credential
-helper configured (see linkgit:git-credential[1]), the password will be saved in
-the credential store so you won't have to type it the next time.
+app-specific or your regular password as appropriate.
+
+If you have a credential helper configured (see linkgit:git-credential[1]), the
+password will be saved in the credential store so you won't have to type it the
+next time.
+
+If you are using OAuth2.0 authentication, you need to use an access token in
+place of a password when prompted. Various OAuth2.0 token generators are
+available online. Community maintained credential helpers for Gmail and Outlook
+are also available:
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail]
+	  (cross platform, dedicated helper for authenticating Gmail accounts)
+
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
+	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
+
+You can also see linkgit:gitcredentials[7] for more OAuth based authentication
+helpers.
 
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-- 
2.49.0

