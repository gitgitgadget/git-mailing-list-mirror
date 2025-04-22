Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7D1EB187
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304948; cv=fail; b=UWtIB7LOTl4mkc4Sn2qem9poNLjoPcckc7qOAIke484tLDYpQDEhpDoMO1JKzNuUkm8/SCZQpb/c9232m84dNQPVR8nPDoyuMqn+cwZ8I09lcp2l12w/D3SD2NfW0aPd41Hiuve0bRijfijLehJN8vKL7EOosfiDFIWlXOrubRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304948; c=relaxed/simple;
	bh=Uk/ySxyTKwZuwYqlW/sBOFFFEL2lKojCM7NYtTmlbag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl6hpTBQ63gf3C/zWU17h3juwGSJKvyJlLXTfoVevgS489Z/wjPqFAanRN/0zHR2/PdQBdsoelO61j4zwwn/bdFDFkEDe+Bm8GvyYI2jCV5+5oRJ3e4Ns6vL/CJ4v4wd5YA36shvsvGrZw/UIoZwJQ/FikXXc1XYM9u6VYntxDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Y4zKcLiu; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Y4zKcLiu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3dsmolgrES2XABEv+/EtYaKULFSYsZM6W6mwSdk5l4Nh2O4IKThbnDxE7CgWn6H5VnBPttC9I41yWRmx7F3TwXd1eSJMjZ7ufYfYjD/9xO2i4HJD0H33iIQB161yfBtKvdpLy9s964IKAUSOYR9Xi5WSZ9uGXlxqIkRztPsc6IiBbMjChXofsEP+Z25TSn2QnS8XVdsRySXjsqK/jbw4K6TU3rF9/QpZ0lJqlFGOVc0DQaHT0D2/R4pgfMZKP15q3q9FdgyTVq+ZDfEnxqfP/Pm3RSr4A0ik8NWxCq28SHgvBqw2o3eKs+5YrEbDgfLpFwdCeaWON5/lQUvj/koQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QOTbWH1ZRLg2gVVlwHkfR9j2joS6SyJ6rTYSPPFT9Y=;
 b=wQI/SInHZ+dKS9Z0p/69EylLfMl4YpQXP8/E+byY/i//XsZ5vuNF0b0gGjZDtCh0gVwbLd3Wr5L0UZ2O6lDUaUJnZz675BQbwTs0ncCwlTV1jXyDA+U5QGmpRgq5sdJg6Q4yGjRd6VgM+WV0y3tCOUmtOtRAJGVIGx613jgxIr3oX4SKezxTN5Wdsx+z5GuZpAtuPkFJhDtkr94RAGJhC+biv0utVhj4ElnhiA9a+nFNF/qQ66nddLGCJFPg2EBgG/LT9X+mN1j8lBmgJEhCgHG779RZKcCcqAd6gchO1J+T8BxZIBZZwcmeXP7uHfabeaXs+QLKlTR7ITSxLlsy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QOTbWH1ZRLg2gVVlwHkfR9j2joS6SyJ6rTYSPPFT9Y=;
 b=Y4zKcLiuh++eedzchi1LIlCZD+TaOrCdpEc4CWsuyq7zo5mUba9IPCFNeHwxy28Vo5VbRrJS7dVB4k335Y61BE7vfJivcAfWm0V5qoO7HoOUneQifVkarCoZDydeEEjhtoPy/iwb337H7QrvTP1yVyAb7fECbOfMSMFPpSC7paLrXxu/7OZS0eDMMffUoBCIDg+q+FfO9SIQ1bWA10In26YXdXrC06BG/OMaU3f6tqIMzmZsc+shnGH2U/xr6xEvolcsTATBiQKhlD7J0HczTimmtqaW+4+Yf9DfsA1S1MHZU8jJP3TVLwvG/XGKqjqPyQvNTL5rZAX0xss0z0nZ2Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8199.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:55:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 06:55:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Shengyu Qu <wiagn233@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Aditya Garg <gargaditya08@live.com>
Subject: [PATCH 1/2] send-email: implement SMTP bearer authentication
Date: Tue, 22 Apr 2025 06:55:00 +0000
Message-ID:
 <PN3PR01MB95970BE1414A760592A0C391B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95979D98917E3986E37267A5B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95979D98917E3986E37267A5B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001A8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::e) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422065518.96853-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f430c2-b01f-4fc4-b5d3-08dd816ab0da
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|15080799006|7092599003|461199028|10035399004|4302099013|440099028|3412199025|41001999003|19111999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcrwKJWIdgKVxoLQxkKfss5axbjfAkwdJaUNRTJTcSrJhpPdFtdZ4AZU4+BK?=
 =?us-ascii?Q?FrHIRVnLnuspJRLcBBha3QHAwZezDsCh48y3WZPnaPUQM1j9rWu/NYzu7sBn?=
 =?us-ascii?Q?7eESUkg7FG9csK26P2T8SsJEdGmT0Xu3qxh6qJE6ZUtH23a9FGL15SKVI62A?=
 =?us-ascii?Q?jks81TVbn83dxXMnEy20I2lfktNcxLF3QaXe1JYGvAtmejozpMV6bt1wiwvh?=
 =?us-ascii?Q?oSsEpMN69BBi/UMoCtJB9T5ftLH9tlc72YN0mo0pvYPkw1GBPBoD/N6wGKgw?=
 =?us-ascii?Q?hz9JntMLiW3IyXqJ59trCkURlJscXm7d7V+QGkn239R5E/CUaSU5RhYJ5S24?=
 =?us-ascii?Q?DaJjd0xZI3H528Q1ijN4u+jmZx75GzKFhGC8TFKM3OmlcnANfOm9nq1j9g9G?=
 =?us-ascii?Q?+zrYa6ZhvM2EUCva1vbg+Owec6Wmel1wSWhefcAeK0ZbSucBCG1uk/5gQds3?=
 =?us-ascii?Q?FQBBNjWTmHvBn5IozwJ5EPEd1nO7J8hjJGARtYGtsqoQNjIpJhiqSVLpWcwo?=
 =?us-ascii?Q?Sv7HD38SyY+hMQRmFx8P2tkK7BwHlViiJ+GfBo24Py04JHotK8Tm7olIFLhv?=
 =?us-ascii?Q?mJyDV2eeb4qCueIDNPtAD/OxiRqOsWyhhCvuLCkzg3qmtK7lrkW0xASsvmOr?=
 =?us-ascii?Q?8/uBaJjwBJF6QsuuXoCE59+hokFQxWD3M513DHvq0a5soxBYBh736+QYm+Hx?=
 =?us-ascii?Q?qoZmaSD3LtkOQ3iakUc+tDId4dcuGl/6n4NmnUWKhfnjtyHIu0HzgBufVbYo?=
 =?us-ascii?Q?ubuv70IXSNrsh20aCEuxauv8zdsIkNExrQdjfUFL1UhC7K6U7DN7aMrQ4Jtg?=
 =?us-ascii?Q?Beh26OxMv9XV2DO5oNdp6bVj03G+UQcLoOJqpdIkLJ51gZnNxqW1co1dNV54?=
 =?us-ascii?Q?Bx6Lk5ealxN/PyWZEZeR00EcGLiKKrsKBXcQsraRMtxmorXa6M4VAsoZWxNF?=
 =?us-ascii?Q?eHN1ZHTGsT1Q7u3CgYWFxzW6icmIiCqPrxBGrHdDzRJ8FdIoDkZzuE0Shcal?=
 =?us-ascii?Q?zX+tzNOl5pZOJ+7mHregaup4/XRppnk0dLMvgzkhwEzYyw7ZorIJmVuIVBy1?=
 =?us-ascii?Q?DKH4e5o5CTvV1KjE2G53uA5p2gvJRboBzTrE7ntVn0CAnHSmyAdx6TUfJjOk?=
 =?us-ascii?Q?EPhPW4ZOjffaCgiWF0uL2CzZe3e7v+/fEwQ9O3Q9hNIlS6HXlN6VJZnnrGMl?=
 =?us-ascii?Q?K85Z9NNpqlJyEmnGj9mjmDVfc7RMNpLfL01D6G/p0WAeF0x+7QTyYx5u3fMc?=
 =?us-ascii?Q?2KwT0L2bgJ6Bi+izQgcRbNRUDFSVLOr0yRYBbZsXfvhnBrXj/VWtDSiwYGmx?=
 =?us-ascii?Q?fjtfNdfZa4dZtPUSRcfRxKQ5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+oCa/97u+JgfiX4pqoh+GzkTwhp6jk19yibW6xcoJRKtpHhr2Aodt2IdBYYz?=
 =?us-ascii?Q?3pzc2zr9lsaM/Apk7DhUB6H69Zy+pFNSgEbtuI+nWCp7qKwzKdC7wsD105aQ?=
 =?us-ascii?Q?SJ3z1d73R+LQFXvAbbyNRQalUUnDmvOVpUoLuZ7KSy2cy0ykev1k7MO0go4w?=
 =?us-ascii?Q?5FnJ/KsDWcCAp1nkKIUWTwYNOosCtrcBbQc8gRhbRDciv2ZPa278x8wplNHu?=
 =?us-ascii?Q?IXKUPx42+fRda5RkuDEFqqyuk8I4h/6vTRbpSTbM3rMPd6sxu31spbuYyBlG?=
 =?us-ascii?Q?RRHGYlhprCXWVBFuWbQFIBUuS1NjyNfhigZwfLBFl/A/DajnPmThYUxOwUW5?=
 =?us-ascii?Q?d89Qqnxb1dFSRJFAZpTiWHrFgviSKVclSaQUm5WpIaalDCo09Yl9xi0MqXES?=
 =?us-ascii?Q?MQ2pZM95lPzmkKyQXjy/wbUEnQ/CxOWDkCRnlU71i+1McpVn89C1ofYnWg1+?=
 =?us-ascii?Q?8Yj0l5IUGqy3+9zB1wJ05lLQKAC6s+6C3g54AK57QY/exiaWJYXKRzt08FJA?=
 =?us-ascii?Q?WF1+pE8e++QrIqwKbyNKPmtFyf1CqACZnI+Bm3GV1QzI2gcpnaefa3UxEVRb?=
 =?us-ascii?Q?Ywp5pL1qztwT1As2LdiOY8zWhSCKsR5oTVRIQ2sL01hTz1ssquPkS3gmY32B?=
 =?us-ascii?Q?CqPXxfTeAw/erCdDXZup8MZDjfG192Zw4JGzfCZKNQDx4G0wl71yqzbXvAtf?=
 =?us-ascii?Q?iWihMl/qIaTm8mN26VmCYmtQTpNCewfDpsMLv8q+sF6HSLioxS6LxuG5ezOE?=
 =?us-ascii?Q?mbSeYk2Rbh289Gcyap0FMhTFClsoOJwlAXC1Hy+3hJjiF/OS+jtwv9v6RPPt?=
 =?us-ascii?Q?jk2eFGEGHCJ7VB/CzFvaVffcMKp1VN5uV6sVZO9/m0bGbvCAI/tBtcfYaQ8j?=
 =?us-ascii?Q?U1vXY0YiUt82XZpd+cooryH8J1pD2pAkORvN3PoqfYlHlNmf3s6ddbkAIumF?=
 =?us-ascii?Q?zaqeArf/jIfBrfncPr+In4b33h93WK5bfUhFBDC2rJOvGa2rbgUan2Jpu8PE?=
 =?us-ascii?Q?HpJh1SzXGl1BPVT83I5FqoOgJbohwlUHHJ6/zNoi6scNoYCTGoUZDrcIGHAW?=
 =?us-ascii?Q?Wd2y68d6Zm/NfrEk51E/eSpQnJW6+z2bJjzAt2L2r8f9fyXf8sPxsykggRf/?=
 =?us-ascii?Q?IyC4q/P0ipEnUnrsRkc9fBSbqKRwdWdr/mu2OXJo3IthAJ3H7SAu85hAQoCH?=
 =?us-ascii?Q?bmt+EDufa7kGG0w8h01W8A/biYXiGDIHwlP4zF5bX3Ofecq2aj6l59kptao?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f430c2-b01f-4fc4-b5d3-08dd816ab0da
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:55:39.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8199

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
index 1f613fa979..aa6aad596f 100755
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
+		die __("For $smtp_auth TLS is required.")
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

