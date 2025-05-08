Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32201278169
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717749; cv=fail; b=CmpMYzgERPTHiw5uLZx0PV2MN/MpACAwFYgO72hahT7gyTUjS0F3/yGzHUSqpvPnyDkzyfCyyHsTjmCbw6/5nRRs0B90OJFZtG+Lo1u8aEv11NoWC7M/EvUqfugeQsiRh5sO0GICFUTbAb/jL3M+FwNbFNjz1qCm80kruXRxkWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717749; c=relaxed/simple;
	bh=0TbHFVC+GtNOoGjBrA3UsEE6u1nUx7dlYujEwCLBxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M02SjKUzIprC24LdKAfCs5lFTDNKu+AuBS9Y8OnMNvIaex9KE1nFAv3jxQXQ2BNYThDDU7jocyX5NOEBiK/3WTN2Ibbmb+b1KBXDqdL8DT+BFzCkGgqdxwhVvtkaILh0vlN9Kasqick2QhULg7VLaqT/DcKv6VE9c51sj1EiLII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Mp1Sb8J8; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Mp1Sb8J8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfz66BeOyJd1apn6Mcg43NijYRtV7qzGvxADrzRT6zxoEfgr70f71ZlWTmPIaqt8NEn3i/JwOK738X1tUtbRtiI+zyEvt43kMgG5qAzfrSVvbRrZy9Wq00X+ffcucFoyyYnBF7KxFqM9TylPRfCMX2WZBw3hUyP2wdqkfBdWYt5pCwOrNB026AreCb+SU2ZuriE8F5LNo4BwJ8BZQAUKTcpFCfewITAUCXiY9AxhX09gFDnQnPNZDVepZ7w2kuvVqqFWCr0BI99yqe3/m8LP2bExRVnHKvIZHYldxgmQodFG+lT47BH7QmywKD2PXmCGRLevHhIIIVurY1xRbGo8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0u4W13PT7WSA8loGN04TF2v5Gch42+jQQM/oh7xjFE=;
 b=B1WXqRta7/UyXJGo/1gL4n/+O+M4FaZR+lJT9n93D9VVZupRpFF6p0xfdHyawh8s6dqcThFgGqzSbdgSBMRLBQhLVIiLFf1GyModl/9iN0qHSD96PBHFZDJFj4SfDJI4XbSPYFRolvR7I9e1kP2ypysuMFh40ZbjBBAPUgyIqVdwYlWAT0joJAoTDlMDDT3ga1rIjbt4A/d6eVMx2wJmfRq4reL2RQ4Sh+Dx5xrjZRd/qQq29Ko95uKWi2Y+TT8dm+UrBiR0OnA4RdnTN9cPiH+w8YRD94JhO9UaD5kW3MLHQwkJGhdoOzCzFWnuYix1PAcYTc8vse2SJnnKhUA90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0u4W13PT7WSA8loGN04TF2v5Gch42+jQQM/oh7xjFE=;
 b=Mp1Sb8J8xGdYd9ZsQaq65pMs7CgyV7zxiPGjHroZbSkYripRovml33KLZX2JOWDhckrvgPyOH9puLWsuEok/U7DQVNCBQFdF0VcZdRttm1gqAj/uJdqqQjhKPWadU4sq7H5jTbPzSq7njKY/GUa2ww6++hAl2mEYSvJ3kunmwjNY56q6qDJ/psmQJhHMHpVr3KJFm2vT1q9PVRxNMcA9+apqqQKx+5vE8fnLL5+e8dBaNIrjBZRGKrjIMk0Kr405UggHHpnRjTzCT6JJDOW0C6jN9mw6l5jlWRXFidUkoC+b+QZDRzwWm1hKufql5JxXzbi0BO7UttaMFm1qm6fKHA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PPFB4730D036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::4a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:22:18 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:22:18 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 2/3] docs: improve send-email documentation
Date: Thu,  8 May 2025 15:18:42 +0000
Message-ID:
 <PN0PR01MB9588D67C07DF041A8CB5FF12B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::11) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID: <20250508152203.7173-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PPFB4730D036:EE_
X-MS-Office365-Filtering-Correlation-Id: 073b47f6-26fe-4f22-ebe1-08dd8e441e81
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799009|19110799006|15080799009|12121999007|7092599006|3412199025|440099028|10035399007|19111999003|34005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JGxUag9Zg4ij4HaB6ZNvJnd6oZaLcD55bf1TEl9tY51woICmBOiwL2bHo+iF?=
 =?us-ascii?Q?YBHCjNcXsOsdt42XmPB8eh3R2ZQrggzKGz4C85sda6fLgjkCd415YXdmqXwZ?=
 =?us-ascii?Q?X7vb7hLgjIJ6dW1BObz5Xobu7FWDFlZw2ekvH4FA0yU5NDZe2W6o3TzyUgK+?=
 =?us-ascii?Q?5xVy8qdWhirThu8HT/FIOw2nIDorvvBaCpY0LhCiY6g+eRnys8Cm9hGIUf33?=
 =?us-ascii?Q?4Qch5UCXXxXx7SE6Fb0ODG2RNYZAdzmYNu+jsH2gSoKFG7cx8wHEhEL2Dfl8?=
 =?us-ascii?Q?yQef8yoSj0jyuS8DyvVK8hrtYyJ00EDpXydNMp/5QzofiXcPZWbGZBkjc4Gn?=
 =?us-ascii?Q?yYtToMVXQaWuiWHAw5itND7zjztVbaVmfAVxT46X4eEp1wiYqwmLrNLeSa8d?=
 =?us-ascii?Q?Lcgy+6N7v7U1boSflGgE1E/bowsG3pLUKqTrAZ3jwOok7oX75isvOckd1wff?=
 =?us-ascii?Q?dBiKZBdhmpA7PTMeWbhzANVqPdVEv2NCIDKnbQJIKpDm+aomD6SuMmGLlRUK?=
 =?us-ascii?Q?u4nvfe5ubNGr7C0FkPo2AXEvI8bzbfBu18J6lkiAz27TxJ7pCQO6Cpd5MFmH?=
 =?us-ascii?Q?IJbIIUXR9RzNJshNMDuuwIkhq5Y4YUceJDZwS64zDv5jlFWpwbL2Ex+zBiJO?=
 =?us-ascii?Q?cKP1xu23M0TXi1hbKpq+6YHwKfsltY63epPASLD0qOLaXGM6ZvZ81yu3G+lS?=
 =?us-ascii?Q?RvpzmZ/Xzgwm0pEGc/dh6jEpqMcoxkOh+GeyB3qGPRBHQFAwrsOmvWOICoOe?=
 =?us-ascii?Q?JQcO9702RHKetAK4j5nChJeIC8AhGyECs5yTW1NGCUg5jTvOTyxxtr0vG4hj?=
 =?us-ascii?Q?doycdOOvzs7bJ92yH8Wliv7l+8fqCvuyEv6KkeBZ6WkuD81j0gQYL3ONJfOC?=
 =?us-ascii?Q?TPnAarAwqQr6o+L9qWcQ7i7UpQUXVqlywOs0Pm5QPtIuJ8dQF/wcuyWphl8d?=
 =?us-ascii?Q?A6jnFDj1Sto7Kq2RBai7z+Bfp1UYaJAg5ayzdJFgjn9xfxnhlt67Bp/O8QHm?=
 =?us-ascii?Q?SQHcgMFRtprYl6Eo/eG9Ks1oRKN091nUYRBGWAGH/m1oOd6Deo3AmpcZSy6q?=
 =?us-ascii?Q?aBZgoF5bZgauS5RWor5uNDPwbSxv+qaK1tOwLoPkh/CO/JugzO2UkxC+VFU7?=
 =?us-ascii?Q?8zBktp84pg1HsvwNBYKMtjhqgCBLmk3e7H457j3Eeo4J8mzd/aelyImGNHny?=
 =?us-ascii?Q?JI9OjVNvQYGEXfujq08JLfJ7W1EDDF+h5pNpaQKkYtasd/nz+vK0CcSo6ALm?=
 =?us-ascii?Q?GuXLQj7ZLC5FhJBnfjmuxxzzffD330ZfEECR8cIqLg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aa9b6Vp/rJffV5QbpXDdCygyRdofhpfd8A0XId+2b0G5o/lawZvfxk7y0HFS?=
 =?us-ascii?Q?HlfdWUbKmGNLK5rlplDlbJFNgo5U4lXCO9/4TV1Wk63T/QTAkgo8xM2BAxYv?=
 =?us-ascii?Q?tZ890XrJgLAoq/XhBa/QM1IFSJu4QQJJ16JQVTkwWpSZp3yth//2DGbEHyEr?=
 =?us-ascii?Q?VHQh6SIS/9ZTtC7P669A7rVej0BPT5q2PWT7jxI+H1yS7imjHdnxaR7xvuOk?=
 =?us-ascii?Q?+nK+DLaLmpLFyStDpHNIVqeany3E8nH4en4XcNpigRieG85GqYr5F9xLzBS5?=
 =?us-ascii?Q?UApego999GbzdSIkkX57ALvnUcmLCm8Xvw6nsOsM/v7oPBnHaincT+HygYdj?=
 =?us-ascii?Q?K3fx415aTBVzbtsRLQQUOgoG0jets43IZa8SwUHvDwKDk8YzqhqtvuL3H105?=
 =?us-ascii?Q?hejZWMhdKbUS6ctC3qTIugLKsaTVZ3XpcY2VMqrEVGH8Yi5MyVv6PxVVhD1a?=
 =?us-ascii?Q?4WnuoWj4Ebo5Hg+mHtNFgIryEt/eUdokjODd9U/lYIP0eiD2J1usU4G3akpg?=
 =?us-ascii?Q?OLrkoi7gMaLRW1v7C94Le5CcBYnfAe8g+o8V0jmW23QabuAPwiwW+r4uzVha?=
 =?us-ascii?Q?legXTtjg4ivkESMg/73t3H0c0gs1r8JmeF+T+L4r4SSvllZjqEIUUqiGqCbN?=
 =?us-ascii?Q?AIAbf7H8HntxWadirbQPLZpbL2tIOQEY3ulUZ4XbGDmQOtysYLVrG3HcEAY5?=
 =?us-ascii?Q?gH/B8EU+ue2jL3pg5+MI95xoHII1vXxIwyUJbDnTeplN02eXwOtB+eY+vSu5?=
 =?us-ascii?Q?V8ho9LaojZury+ys3t+Q+YNK0YOgQ0QYctbg3cOsMbI0PBVcOtEs73xL6nDp?=
 =?us-ascii?Q?hV+tVy6aOGc9GMC7bNYx6XPx93kzYy2Nple4XVdiEfnIVYOtBBCcddvaOwN6?=
 =?us-ascii?Q?U2s5SWe3H8aaw7A6EZMnxfljb+ZyhnJkxlRewLBLLk7OOHWTGARENQ84Hm7E?=
 =?us-ascii?Q?gc/ekkVAGoCS2h98EiXwhLRb3K6+O9e79ichFlbmJTxyOmHlJtdCFsZKsJN7?=
 =?us-ascii?Q?jGnpWLVE26vSbhNEZ7579yRJQC5K9uaoxC3VIg6l0Dsr3VILEAyFZ8j+K1TL?=
 =?us-ascii?Q?MQCWXMDkB4HfgB14SPA/xB0yD5ARpxsnkOOdRCtuh3BFri3bMfNVtmoXl9wC?=
 =?us-ascii?Q?tRuvZyLgBfsaB96B6w/newNPQhARhsjI02wOItupb6KoFYk4teRxFkQlthYM?=
 =?us-ascii?Q?R1xznMuJ1DaBCSgiJqFv/b5yhrtI7VtpTlLmQYut2vtw45iWzh7E4WVRMFA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 073b47f6-26fe-4f22-ebe1-08dd8e441e81
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:22:18.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFB4730D036

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
index 92389036fa..f4503a776d 100644
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
+edit `~/.gitconfig` to specify your account settings:
 
 ----
 [sendemail]
@@ -528,6 +528,37 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
+You can also use OAuth2.0 authentication with Gmail. To do this, edit your
+`~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account settings:
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
+Edit `~/.gitconfig` to specify your account settings for Outlook and use its
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

