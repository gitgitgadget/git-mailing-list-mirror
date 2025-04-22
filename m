Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244928CF50
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335600; cv=fail; b=dO2ECVHaN5Q9ARX/GOhPKn9J5z1si1/ZW4vyCe7llF7S2Num8iLhVqM1o9RWeECw8d/xb+q+QAStSE2ko44RAdfvVFbhr356UDh4RSYojiP6NAadprJ+ZaUY+D1nMDUSeUWRd4Q4sd4yfO18ZnelaKni8nvZrKDdaylpQN+Cg+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335600; c=relaxed/simple;
	bh=Uhofx1yVK+E42A9CXBhyp55BFvMP9fYRaMplPqYd2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o23diouzDXia6wLuQCugaGWU0QBN8CQKCFyQwInquDAYKqIha5umSx1KuIkFQpJ/pRFQseI/Qf07xxjL1eDWmXQEJGmTLW3xEx5zloS/VaRSfP8CfOIMiVaPyH2Xo2HRctoKBck034s8+xCn/jFqIumR2zu6c29PENHa2OSYK7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sBjsw88+; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sBjsw88+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czeYVKqAXMoecKlTmmaVk+h75wGrWpQoPuvEhQ9SlApPSW6x1fCxL+3eN6NW3+PBtBro0YgggmM1hFS7yip61BH3Okxo0qev4j+miac+rXO7wU+zsO/KVb7nLMNOBgF1pfyBoNKhKuAIpv9+wlD+Yq/DFL/s8fZG8As5GVe7A4OsAcJkt3TZiGBpkUiIYuniWLpZtQVPLwh3cLsaXc2LjfTCcackGW2B5JlKU4KB7uc7MvNemcK5fO+Qv5oiQ/XfuHlarLdinKAoUqXRyppBrbGxZW33gTbL8pabgP77OA0JBKfwbxnTpM8rFW5jGTS3vksWdhC+Z353zK+iUy7Zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=Ins1ZqpfASzY+fx5dQV457HWsExs/t+r125WtexODYp+0mzeK3BDmIR6pROWrHVCiOa/3guOdPTzU+SSQVJc7z28Wvyj0+8sKSV4Rw7cmTQdHhFSa2pE4f26QIKk+oPIWQTvYlHVL8y7Iux5o8pBTnG0L6RMO8nsnjrrwcdQlQVCOna29BjXUl5W0jhkESv5xsYq/Ngv7FVDzrQ5+gB+x6NMgCqLtavg+u719m67UzlD51/4isXc6ehPmo3OxKay2pNHS3OCXKZWAPX9BKqUuiCr3r+SqVGitVmDivqKm38WZFIQnz2J9BBfkciLCU/TBzvjMfSXO1/74+Vth91zEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=sBjsw88+vjA4p4LeIz5vC5dPT6uig9e0cy6Y28Z8B0ZidyvyI1DBWwlWi6I9EwGw3oalsvOdDUyVvPNybtPobnXKIOMvMzkHSASJbgNcZyOUNZZ+JQKKaduYWabcHgwFrhUIguHW2q7/45DUmA2aTMued6xfQ/IqnKTCtFWfnBbRtt89AVCyjxNEYlwzEwJPD+6pPb1W8smUJ0HHzvu1MrswXidZtw/IAIprSlD0Sh4g6UEW6lrge4qPdsdY2Fh42HwGla2PNptI7d54aldLbXkz740JBpnRZ+CGT0eJrgdraLJ4J2rDtbFUplY6PNlGa3V4rxK2T6Au8fxBxo/vQw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6777.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:26:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 15:26:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 1/3] send-email: implement SMTP bearer authentication
Date: Tue, 22 Apr 2025 15:23:19 +0000
Message-ID:
 <PN3PR01MB959738CC031F383746224F78B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422152624.19037-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a02ae2-387a-4403-c977-08dd81b20f38
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|461199028|19110799003|10035399004|3412199025|4302099013|440099028|41001999003|19111999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCW24jVmJgPaVRGSlyBB3PyRoutNXRRBa050Y5/xzOgCRlawIgcwVIao3+MW?=
 =?us-ascii?Q?FsglOtmp3HUsrkEx2bPkAW/0BcPmPofkjdpNqiZDlASoqr+71p5QRpXkJTmu?=
 =?us-ascii?Q?UkGGyZyj0NLltpzRKxDpZpjN7JSa+vdNopaPhmRPrr52nC3ifwS0qB4eyfKU?=
 =?us-ascii?Q?0kgRlDuL7Cx2ROijws47F/K7veQv6e05bVAMaMmUmZd/L0d6tWpDPW/GKBMJ?=
 =?us-ascii?Q?+k8OGbqEMkXLMRwmujMzU7AabV09kbVEhKjDm9kA8AFeHKHYDn9DRTfjw/vh?=
 =?us-ascii?Q?V8JIsgXzc+UgJB8PQaJVpv69ozFzVFCNWdIcxPqw8PBiWmWLJKR4DG9T+prA?=
 =?us-ascii?Q?8IRJCm/FKRoeJC+HShR1k1uvEdQo5AtpNcARHDMy0NlL3oGllsCeLLmSHuOi?=
 =?us-ascii?Q?9QJvELmYpunT98hCwTQw3Nd2doyHfdtsTHYXK9GUNLMEskxoObjJbo8uClMq?=
 =?us-ascii?Q?vEjXmmMo6Z2kuFZbH3BQ//atEe9+Iikd9DBYd2shRxAzAqAEfZJuuiI/Be/i?=
 =?us-ascii?Q?ck/dk73gFUR+0XirrzsieCkCOEyf3csyOECvJ3ukAUIkFRyIgoNVaQfbMkBu?=
 =?us-ascii?Q?YJhzm9m+ZadkcfaerOqJlc4WRYnYI2ygRBTcecw4JUDaKoWr1loFQ63EC22t?=
 =?us-ascii?Q?AHmu3vBrKW9mm8305XExKOE7GWqFuiSWq9CwZ5R9Ujw7X50vGKhRP59bfQeO?=
 =?us-ascii?Q?SJztUiAgtQxeUc1XRPoGzsHFHO/lCpZIBUlv3t4pRZSHYX7DJHSZjnKi+5EU?=
 =?us-ascii?Q?o8/eCsZWvGGhFXYbk62R/Vuf5r1yDfsDVQRmYTEVuiUs2Y0LWIZOsPqCgt1y?=
 =?us-ascii?Q?aG7LPgbia5gbBOD2Vzawt6vXdoTBEcL/dwCA5P8Gi3zT/eOaI2L//or2WcER?=
 =?us-ascii?Q?wA+lhShSuxKcytrF3RZlQQxfqa17Vp7j6dnNoJEhDpfceoosj/2OB/YjEWNW?=
 =?us-ascii?Q?347ZRAedxGd0vklPcs7VQ8TTlJ/1qy6euffXlsyYOAeVYvYeedgoQsdygzeO?=
 =?us-ascii?Q?yDSVTOhfehPxAYnE4UwTP1M/KDHqyxfX22zsOYVvh+SRoWGiQuArtdfm5FB1?=
 =?us-ascii?Q?mYx35gtBzeZeHXZU3YroYkwD1fmpkC6tM5g+qncy4kMOJAS92rZoRt3SHFz6?=
 =?us-ascii?Q?ugtZjuywPmxs6yRgg4FohHi8qWr47Z0mJ2waKow0HLiZxlK2bFF4L7nqf7kk?=
 =?us-ascii?Q?G48ZQe38KCGAzgDb8UPZFw8yeMPeuFh3nb7teoBfIFC6Sh4OVfKljZsXu+1U?=
 =?us-ascii?Q?qsVyvXERojyutOFy1S9kbSKgkI+//0djlBFL8q+qPHXkumLwZKkzLIs4PWlz?=
 =?us-ascii?Q?A70=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1SKAOwLo3bng/Wuc5+GJCSBlOObKyV7a6i67kuAfDZlOzcZqAVmraUZuN4vr?=
 =?us-ascii?Q?LREwd09dbWJWub1LZky6H1+r1KDA4SG085JpoK0LdhSzYnEiKIHkTkrsSpxj?=
 =?us-ascii?Q?sColpzVncBcRMNiUqGnpj+C7e9It5GQVctFlJrR8qcZOoRISEpZPESrgZLGU?=
 =?us-ascii?Q?Udj+XT8TIwnwVUsrYY1N7hZmLyYkdvQJMRdev26ofNmLgTVzj5i01MlfD273?=
 =?us-ascii?Q?zHO/Gr/MzOxJM3nDO7rKcON5KrwMYkWdoVqYseCcj0VjgICk9Lv8kx0qWPKQ?=
 =?us-ascii?Q?bUi2akZ3HqcYnLT3tEfYEnKLAK2ZOpxEaQ0QOay0v9i6+K9dr8gDz8CA27bc?=
 =?us-ascii?Q?+StKaBHA+xRWnL84w1VkYzRQHhyWQleyPdL1ZCiAz6ZnU3sTxd+0b0OTnB1a?=
 =?us-ascii?Q?eHqfOxGYjLpymmHXyMy+BljduLtxWsHI7I+cZfpnA383gax763+T0I1+/OJk?=
 =?us-ascii?Q?oblyRX+udvqa7B9r3EVYAjwBzLnFDjYENJb/cD0JxLGitxXUMAlZYE2Xf4lh?=
 =?us-ascii?Q?QcnFfRRRTMC3rV2uri0ofjvLBA5U+9aMTmLOg9hLcUS4+CTu2EF/cBYXm33E?=
 =?us-ascii?Q?R979WmvjhKrxsUzeTdG4xMjeBOurzPAgHAv+SSUGNObXwE5KIDQ50Z39X4JO?=
 =?us-ascii?Q?h9vpM6FJxURw9wiGk73xsp9fFFxmrvr6exVG0/2e9M3d+YGs8B0s7iRGRo8m?=
 =?us-ascii?Q?CcIsgj2Hj/qwnySBYhL0OBpr0pMVZMARBHs+7qcv2FaS3GTAY067L21KBq4m?=
 =?us-ascii?Q?omuTZTosbGZGKeNBDl76YoeM4OgOLHxqEhWAxGtmp84kJA6sB653RnNII0ub?=
 =?us-ascii?Q?6jYROG862Z74L45tD06cOCFtqTce6PRUTF3bu/X1Z+jICL1/pBT66yUzgjgC?=
 =?us-ascii?Q?RUivlQOkAxUm5fkK0rboRHDsopky551S2xz+krrB6Vjs917Fl2Ro2LRwUzBs?=
 =?us-ascii?Q?+bwNYyFxquJBd40Jm9lnpZkKBJZ30sqWt2+LicmoAFMVSeCP1lJgZqbtfhKL?=
 =?us-ascii?Q?c2pCPFFI1IaAbfzIfoqpvJ3ZxkdvXrVsB/aUZIHdggCQcYmKVrkG30XHLkIz?=
 =?us-ascii?Q?hxHld6Wcsk/irRNXrXnKJfCr2GHByL8G45h+UFQaOGFeCmwCp0ZbsdSBOhdF?=
 =?us-ascii?Q?0HHgqopzUSeGtQsi8AdL3BXaLiXhQyCABgAXarD27Dq2HxWz1LmEN5/BlyJz?=
 =?us-ascii?Q?XqA+BIqz6tUkEaJ9eIGFiO660gjHMAqEiSaiwqWcjAb2E8cLrMN1OvIDGdk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a02ae2-387a-4403-c977-08dd81b20f38
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:26:32.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6777

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
 git-send-email.perl               | 64 ++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

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
index 1f613fa979..a6cafda29c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1398,6 +1398,63 @@ sub smtp_host_string {
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
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1436,7 +1493,12 @@ sub smtp_auth_maybe {
 
 		# catch all SMTP auth error in a unified eval block
 		eval {
-			if ($smtp_auth) {
+			if (defined $smtp_auth && ($smtp_auth eq "OAUTHBEARER" || $smtp_auth eq "XOAUTH2")) {
+				# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
+				# manually authenticate for these types. The password field should
+				# contain the auth token at this point.
+				$result = smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+			} elsif ($smtp_auth) {
 				my $sasl = Authen::SASL->new(
 					mechanism => $smtp_auth,
 					callback => {
-- 
2.49.0

