Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D91F3D44
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481470; cv=fail; b=DfNFlTc0A4Mi+6IU18V//UOD71M2KPKO0JbZdKF+VWSzU8JcLRedo9grOxa2beweGyP5zIInCZuSOrJS3dLp18Nh3hGRJGEYsjXYrK359UQ8Ka4rOVu8Ib6kBWtRKh4FGoKd6zpR/01EBfUUVfJJqO8J3fgS5VcaZc/p2gXMPxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481470; c=relaxed/simple;
	bh=EBVzdXScmXJZkUHgvmju4Q+sLXqODTCOlRTLJ6L3b/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdNIDZZQK62c85z+/qAd7mcYwV6cgvJKL0Xm9X0wU/61gBPDD802UcOaJ2+OyVEB+vgy8G1bCqvAMUzli83fCxGfmf0n4Pc65OYHns7H8u/dhFw8NqKJc9rbyTLHNOmqHYUvMPTDaQNSL/ijCZiVujPZMVDXPtlZPCWmyJyhFDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sdprSnc0; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sdprSnc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHbOCpHl7WdzLoZpUBpTfhYeWg7wpKI2edyr3CYdpGtfzT7NpnKn4BLw9aKTU4w9MNw611Y/dGc7HkLVgVVWNY/mTNh+i6eb6ciR7SNQK4/heNPnudR0gXwzg1f6AbVkLYOz3adeFymEQr+vkPyf/jogx5oNyF8H1PPGHUTJFCnW0C0SpZgMawDikKDUS9FxgK3XDAj/eNduJIdsKXW5W3RtHDSmyyIf1hXDDP6nCL3ELgrEIU1i1oZOccHO65JRJfH+X2oOgRXqTP5dy/A11lVL7jsKwsYUQJyNoo2/wGl+kbkcOgROR59ZfFZHxhERZQgEmqYsSDe7FGGNPuXCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xNFXCwWnvyDqL2HNXO4nUb48bLPixnx4NQsZNoThEc=;
 b=kwOnuK+1GBJJ713RNK7v5oUkrQwaMN9KT7jySMfvBzdEZ1VX5qKQ9NYjwFso3KxL9XrRcCCU3a0QLBc5wYHyPdQKWZuviRGGdmMOSO+Uhw59eitUhsgZXQYVjY2APZD1jJufi3wYXDxC9cCg2rWslhiGw7tir9VAsoKjnE7RMqiimsunCLMJ66aWUrpA2KCtLHDstGTkWbWU6rO4j8Ie76flObDoB9wWo36hVokxckwlGHWUSxN2GITInk5yUkC24S2JZBf+AvafAiI6lNVfKDGNoA47wtvELGnir/rmkE4tEE4Gnyc5Q2vB8CCAhzfqWYhaYtiwXbAp6Db/tUc9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xNFXCwWnvyDqL2HNXO4nUb48bLPixnx4NQsZNoThEc=;
 b=sdprSnc0ld0dMtDl4lx9q6Q1WmCARrHQSXqy2/YOLJ4kYTjoArHfOBW3/H6Bg2Ie4GoY/mmRYKQ4Qb+TXCTvBBh3y1g1exR6fNrUHJMs3pE08wu9hnD+MJNDUvArscTRU4PWoP4e3Skw+JLFcdQscLzk6sFyU3Hfa5qwxvNGNZ87mnOs/ZmMg/8g6cGvL4DmJKQeVkxtcUcKRMf/ClR+xD0YVhRCu3JJI5L1JYVCIV/buMKTxHz9IXiDFhnYanpV/ZcxBJFzSReXpSSOweNmFzk6qIWLTAHpiWhlNBso5N/zbOJodxwkWgvzoBI3xZ7pSirZxr8tckX4J+hFFC+m7w==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7808.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 07:57:43 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:57:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
Date: Thu, 24 Apr 2025 07:53:53 +0000
Message-ID:
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::8) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250424075735.32601-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 45381d66-5f42-40d3-fd99-08dd8305b0fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|5072599009|19110799003|8060799006|1602099012|10035399004|3412199025|4302099013|440099028|19111999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NceFjPIXfTTjDHjE1VttqOLKW0dffhDpJUwCW4QBgTx/g+v08ICuwQHvPKbr?=
 =?us-ascii?Q?sHkdQYyaSsWrLw41TJDKWk4NpXF2dtpYuNgcdlhhrfBo+NG6a0I/3vLIOZAL?=
 =?us-ascii?Q?SIi3Jyyb/bXnCCb5tMH5yA1TqQhNqrAu/9N5Gp+joxpbA8GgcobeVjK0vhta?=
 =?us-ascii?Q?B97oVx8I7aWvRCFLJL1d79uI2cBMVAw5CkAwunepgX0R37azijWM0Dr6As5a?=
 =?us-ascii?Q?fNMZc3SiVbDOKTtKlHgNZxH3MuGPOVkTuF9xxYdajqX7/q6XD7kyMU1PenVU?=
 =?us-ascii?Q?nN4HSrIGjb9Pnv4lzfptMrNIHa6GDJ/EUuFdifqkNbhCbsC4h6WBw+iQP08N?=
 =?us-ascii?Q?A4v4s1G3hbQtoA9gqI4lldvSJ++Eqt6lnUTu+w2bMWtSGXiDaiDgU8SZDiGH?=
 =?us-ascii?Q?dLfzs4BN5IOX6OQiXjmlHUTrhKOEqlg2kBRsxFe2CS06LY7QXnIn08hKqHI6?=
 =?us-ascii?Q?TrUVkK6OYg6oxKmtAT6QxmU9b+ftOGCn3bU3M4Jm59sT7fLq6BSTlOEeaBWA?=
 =?us-ascii?Q?AhpGfRJfoAv6FFJBnjNEM0u/EPRJ3uv+O5WD6n1T8s2XeRORJ21t9UjSGB8G?=
 =?us-ascii?Q?VbzNVN4Kt7J7mGB4ATLq4nnyo2UhG82TNBztFuwCote3x+/7xWIrR3COEmJv?=
 =?us-ascii?Q?Ajci73sOSpKZfWsb9lpZrXZoBOAi6lUadpa+Qm+kBa5N3kq6JwJvXmzrt07a?=
 =?us-ascii?Q?eh9QY9wIXBwWHHq+pCvm64oPydENzAchywvJ1Tw+4c8E2erZpmb5Bvbu5jhW?=
 =?us-ascii?Q?6ZVdZtPbuwNMMIXNg+PySaAz+Xgl7+mBAJtovcaG60smPASnUc+FM0atyqYk?=
 =?us-ascii?Q?x/IqMEC4NtOL/Cyxt0N3aWA0rEbS+ci1ziWmy9wv5HnZVsg/TpBQRobGDsyE?=
 =?us-ascii?Q?Xjf8WWyFkpkqEZ+1hxiGQgvfKRv+9AWpKY6HhgHUrayIwH4a1NZadymPpE2p?=
 =?us-ascii?Q?RQqQhfxwxbtE2LNncCkI9HKI9r6viuL8Jloo5lOVvmdiJwbgG2guY/GKbJL3?=
 =?us-ascii?Q?q0JDlH2PBeJp606ABGVzSfYQFx+yfV45D6mRykVugFf0USTjBqHz7RVFICGG?=
 =?us-ascii?Q?JYNKp/F1EbN+SYYbJTGIbWiZVg9Fs9PEVU5JPjMy/LxAWaMGzgD43UUr/KBA?=
 =?us-ascii?Q?TDowRbOT+3Mg+hCJ1x1j5Ld14lAZigEcIrHbp/dJslGhGj8sW46N/OdrKL40?=
 =?us-ascii?Q?UJNQDj6gRNCDeoUHfIFsVtCvv1tRxfwtDRc5suUocvuuMKAN9I6D77u+K5d7?=
 =?us-ascii?Q?uxYafO+9g18DVQRYJF+9b4MrwqxIU9N5kBDLi1UIJat2Q2+WfN6/aHGRNgb7?=
 =?us-ascii?Q?Wn0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vqef+cBftO4mq9Gci7oSqoi6YatM4C20K5EXPcpE29iEq9VJzTLMlRdhj8g9?=
 =?us-ascii?Q?EePp34MpfoVBUSZn4kcYf2rEtF+k0Jlv58I9Hyx/cNgfoGKRs255/XZ9E+uG?=
 =?us-ascii?Q?6loHc42anYZJ4OiWYQoH++GXYx5H992SaclbWdiFcNk+qjxavEvok5bKUwCI?=
 =?us-ascii?Q?e656kERGkRykXcOsrq7T37V45Qvu0XCyinkliGLOV8SV1PnylIfJunXUGl/E?=
 =?us-ascii?Q?/De81CNp4MlCrF9kR5PW80FtKdm3Emn7biAzrO6JSYqApel2pbxE2VCpt6M5?=
 =?us-ascii?Q?zQ0gKu6R4Nb62/+9zPijGIxmwFqjk7Ria1ijsPHYRL3OthN/EXuhDVKmvqzN?=
 =?us-ascii?Q?npsEvFqb7ZT/DdMqX2Z5iKHF98HTjE1eaqZvcfRtxULCBneHvgILv18cCcUl?=
 =?us-ascii?Q?uqrzcIrzGwhWP5PIClYWiTnKtdSipJqTSR8ndHk0WgwZ4IaKC2NX3yCM0VtR?=
 =?us-ascii?Q?edLWDTF7+vPahZPwWUMksCXU95FOdZZTCMr1xczGWrVUzeVBw2nmZFoD6+re?=
 =?us-ascii?Q?oU4mvgVluY5H9bFk2B3GeO4MoTIZ69IagRS57ro9+/YFa6ibLDrgRM+3z0/Y?=
 =?us-ascii?Q?aYz+RL67pA3iyMj41GIzyO8+MzuuyoWKWrdjyjvvsWQCI+IYEtog3c9BdkGn?=
 =?us-ascii?Q?rpbYtct8UyHEcJTgYlUKoQyo21Nx1pF7Rt/cav35XrNhHoZzNFnkE7d7pu7E?=
 =?us-ascii?Q?0NjlXIo7l44KLnf+Cw/CR/w5LoPWaYZ/hCIEbeVmJ93rl0gIpU8GTUUr41DF?=
 =?us-ascii?Q?99Ri6aWUspAjjtbDkgxNFYGcWxjOaxBGzVt4euE9ZUwM58hpNkrhsE8Y2bf+?=
 =?us-ascii?Q?RPLh9JIDdSrsCwoyE1Wa7x22HTQRKFhxgNRVGdl8+cipZqzLBU4C82102ZPv?=
 =?us-ascii?Q?Uxn9SaNrGjAutjSMPemr/UMt7wtdiMdNxfNKLtV3jX16QPoxjokPbHgavhH/?=
 =?us-ascii?Q?gUGKPBrcknA64bfa8T9G4gdocwkqKW8Rxix2WVaqk4CMfhMfHZY4k6w1sqkm?=
 =?us-ascii?Q?ACDcGMOY9g9UvR+nPIE3/8g4ijEGJp5cwkzsxntk7FqsHqeblBEe8qTcvMLl?=
 =?us-ascii?Q?ct8wbbSzYNpwhklQ7LkL1FYLbVhDlgdHaWzkcL+6ClEoNIdwhP+Y9/efBGWY?=
 =?us-ascii?Q?WgxMK3hw0MPVmcRyFewvUx3KZaHgAsVJhG9AFv2ZYmuHTZ+xN3yhqerPFyh8?=
 =?us-ascii?Q?9eYvCTn3zozi8LNcjhwqnKeZq9Sy1Nsqk+KdFsGg81C1PnnrU5mKnVwlmVI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 45381d66-5f42-40d3-fd99-08dd8305b0fa
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:57:42.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7808

From: Julian Swagemakers <julian@swagemakers.org>

Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
This is necessary since they are currently not supported by the Perls
Authen::SASL module.

The bearer token needs to be passed in as the password. This can be done
with git-credential-oauth[0] after minor modifications[1]. Which will
allow using git send-email with Gmail and oauth2 authentication:

    [credential]
        helper = cache --timeout 7200    # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.gmail.com
        smtpUser = example@gmail.com
        smtpServerPort = 587
        smtpauth = OAUTHBEARER

As well as Office 365 accounts:

    [credential]
        helper = cache --timeout 7200   # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.office365.com
        smtpUser = example@example.com
        smtpServerPort = 587
        smtpauth = XOAUTH2

[0] https://github.com/hickford/git-credential-oauth
[1] https://github.com/hickford/git-credential-oauth/issues/48

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 71 ++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..1bf75c060d 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -213,7 +213,10 @@ SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+independently of `--smtp-user`. Specifying `OAUTHBEARER` or `XOAUTH2` will
+bypass SASL negotiation and force bearer authentication. In this case the
+bearer token must be provided with `--smtp-pass` or using a credential helper
+and `--smtp-encryption=tls` must be set.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 1f613fa979..9ba47a6f38 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1398,6 +1398,70 @@ sub smtp_host_string {
 	}
 }
 
+sub generate_oauthbearer_string {
+	# This will generate the oauthbearer string used for authentication.
+	#
+	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	#
+	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	# * gs2-cb-flag `n` -> client does not support CB
+	# * gs2-authzid `a=" {User} "`
+	#
+	# The second part are key value pairs containing host, port and auth as
+	# described in RFC7628.
+	#
+	# https://datatracker.ietf.org/doc/html/rfc5801
+	# https://datatracker.ietf.org/doc/html/rfc7628
+	my $username = shift;
+	my $token = shift;
+	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
+}
+
+sub generate_xoauth2_string {
+	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
+	my $username = shift;
+	my $token = shift;
+	return "user=$username\001auth=Bearer $token\001\001";
+}
+
+sub smtp_bearer_auth {
+	my $username = shift;
+	my $token = shift;
+	my $auth_string;
+	if ($smtp_encryption ne "tls") {
+		# As described in RFC7628 TLS is required and will be enforced
+		# at this point.
+		#
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
+		die sprintf(__("For %s TLS is required."), $smtp_auth);
+	}
+	if ($smtp_auth eq "OAUTHBEARER") {
+		$auth_string = generate_oauthbearer_string($username, $token);
+	} elsif ($smtp_auth eq "XOAUTH2") {
+		$auth_string = generate_xoauth2_string($username, $token);
+	}
+	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
+	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
+	use Net::Cmd qw(CMD_OK);
+	if ($smtp->response() == CMD_OK){
+		return 1;
+	} else {
+		# Send dummy request on authentication failure according to rfc7628.
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
+		$smtp->command(MIME::Base64::encode("\001"));
+		$smtp->response();
+		return 0;
+	}
+}
+
+# Check if we are using OAuth2.0 tokens
+
+sub is_smtp_bearer_auth {
+	my ($auth_method) = @_;
+	return ($auth_method eq "OAUTHBEARER" || $auth_method eq "XOAUTH2");
+}
+
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1436,7 +1500,12 @@ sub smtp_auth_maybe {
 
 		# catch all SMTP auth error in a unified eval block
 		eval {
-			if ($smtp_auth) {
+			if (defined $smtp_auth && (is_smtp_bearer_auth($smtp_auth))) {
+				# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we
+				# will manually authenticate for these types. The password field
+				# should contain the auth token at this point.
+				$result = smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+			} elsif ($smtp_auth) {
 				my $sasl = Authen::SASL->new(
 					mechanism => $smtp_auth,
 					callback => {
-- 
2.49.0

