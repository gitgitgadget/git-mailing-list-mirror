Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37E4D599
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981111; cv=fail; b=pNFEbH2Ew1Kr/bl4D28aiXDvyv3Q3XYxqaOrj/lnHqNL88LbpqCHSQ8rNk6xc3l8wfiDtcOB7A1u0eVejTAZSDTPXUkv6IW4AZOrCp4w6KSJcQTtvxOQ9mRhDn84BJTuydZKNmOaDF8h/7AUtzKlFtTDahd46YsX3RdXjJJICqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981111; c=relaxed/simple;
	bh=AW5MWcah7VNyZsXoBDhldIJmlPphkeMRPLKcMAk9sE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQ9IUOudwtsRxyOppuMHSFw3NDAhl+Bw2OyRHXScr/c/fAu3yfAUMdQXrWZ2Xf8FUpwXhIg8UMUW6y7+BoKB5ZQoP7wjhBSOmb/Vxi3+KZhHeKxsfZLbJW4/fZXBmyJX0d/o9ynjumvtqFa1tmd6ISM1N0cHS58gSJgmTvJh3Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QmrTJ6ru; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QmrTJ6ru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQlAxOR/8wpQhwpITuj58Hty+bybZyZ432LVEWGQRrWUw4h5URb8VEDXepRrjJ9PzMV3ax9QQqBripmvc2LLV5Jvr+mp5w6J6BPX50h4Djz7v5WfwlsifRHWRlwgxELgu2xSBcO+W6qmj+0C7DDMeOIB/QWNmxUAuyif2lV/ba7i01OOr8u8m5bpKYBsi+dDuV8tOElWLH4NMpZI3IBsq+A4o1ICJeZjb8uuBp4I4VDTfekX54vhIbVkGWdiQbdyDuGLXnpNfJhAeZ/8ijlwjCZOrACZUa7mizk1IwkLDMVywop/YpIEBiZ1tL7nnVpNA8kIVY3vwyJVbnVM2+udrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPOQlGeivVeTP1JUDdOgw+2WQA7j2u/tsjOm0FzFNwk=;
 b=xtmKnPKUeJQuXYuSluYt+u04kqYop26Fcwjb43EYRbxwt4Kq1aUzM8P4AW/5Vuzm5Fq4t5MSl0WBCwMknHeZREUkGXQNKYn23zZR+dt1eZATmaQzSS45L/Mo4XPDXh8BqoQNaKJijF4nhpV88J3zJLizp9JdpcpH09laxhmmc6rYNauQhqwf4GIt87v5hmmPTkCSc6/4UQLZX61Ucfuy5O8beSxJFlRzSDyVfDCSBSQGraaQmuSYKY9aSQQOgAizTBMslVH+l7B/8+XyIqVpM7CNYd6OFkqyyXJH8A+u6fXQqR54RxxigySYdMCZE3vRu74rPntBdjMvlj03d1cceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPOQlGeivVeTP1JUDdOgw+2WQA7j2u/tsjOm0FzFNwk=;
 b=QmrTJ6ruEZCEPBTYx2aE88yM1wp8bkbboN8/xDcsTnFUOoK8+NA96Z9MIR/+fv/Tqomskm7hfNTiPj+dptRROuADIf8bQFjG5rpRcfbkjHw3p6PZYFf8mv/8pT3IicI3DDg0ok3mj9ABqt+/0kRpDxkduoH/+vK8mHfaV/xmtMS6mi1B6u0hmc0+V/hfq1zSTZDqTdOkYsioBXzpOiYvWSz3V0y7ExRKLskMV7yXTLg7eaZrBv9eMTvcypYAUuPCniWgI7iAMnU794BSXq2hJPy1Ft6pCTU30B95Q2QKyjv/A4XYwdIOuFF56OX6NOwXDMRvqyvN59vilG221UabrQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10175.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:45:03 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 06:45:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 0/2] send-email: integrate with git imap-send
Date: Tue, 12 Aug 2025 06:44:34 +0000
Message-ID:
 <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250812064436.9643-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10175:EE_
X-MS-Office365-Filtering-Correlation-Id: a54cd0c7-a901-418b-b506-08ddd96bc434
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|461199028|5072599009|41001999006|15080799012|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RReEqFOLi3KRLrm3ZqaXcm7Em3pX2WrSlufKMgB/mD5x8DGWSj9ybZi8ML2B?=
 =?us-ascii?Q?M0xk3vIz+wTdQkiq+6/yCvSae2XivJNXwEoGc0ZIdo0KImNAUmSb2YUyVj/+?=
 =?us-ascii?Q?wfmlA2kyeW27in3ouCHnV29Wub6ZhKLoTdjk/sLyoRRTWBWzkuSY++HYj9Nl?=
 =?us-ascii?Q?2nuCwS2s36VlzSQdVgV1V2ny2Htf5H6GiYXvkoQDOhELxPcbi1Gx8vtYe2v0?=
 =?us-ascii?Q?/Gj5IKA8eo5CKVp+RXcIahS+U3ULsxXaF4HPmheLH48VhCN1vq9Oc+lO8sfv?=
 =?us-ascii?Q?ea3ENqoSlNFJdg+FDCgSqsE5hyzfYdEatp1i4dAaKBq5TD2XxfACPze3eOcD?=
 =?us-ascii?Q?/NbI5ujKfSyxYU5MwOVgPkGMO53NTYcbCfwgwuNCN2ozjp4TzD8p6woRVPFY?=
 =?us-ascii?Q?pE9WRtEJLGHo/hzNt1r7YOVaLT9h6O+umTv40Yu1CpT00tJSoFHoUlOLvU8u?=
 =?us-ascii?Q?DhNosLE91J+xOEOqfj7u1CzO6O9S9uTOM2+WnP1WhILJsln/57aVQiV9QGzG?=
 =?us-ascii?Q?5utHJfiu2GDKHt35s+k+2ctA7oHlzjjChVVE+tDRLvWNieOo/ymxbWMZ8TNq?=
 =?us-ascii?Q?1eTAkiEasOvnF0etOVg7yVWHdBxLTjS/3TacGj9g93Bvlcqx/r0gNqif/onE?=
 =?us-ascii?Q?l+e2/WZwhK2L6KBYWQdziWMS4gTrRu+ESLpN8obKQlRBdGwNWr5BnD5sgMxZ?=
 =?us-ascii?Q?dG8Df8rzSbG7J0nPHIxK4/wSledrEiGHCQBpQAUfBWAwJZkT6bW6OJprmhAu?=
 =?us-ascii?Q?OTW3WVVEXXbq016KNZXYugbl9LAkzK4mysz7CwTBsU1vsSYzDmj/U+/kkmH2?=
 =?us-ascii?Q?En52TBMluG36/AYmVh8Osi+VLE1L/0mXr3UMw2NNqLMkIMun6qo6eCqulI05?=
 =?us-ascii?Q?sW/+skjurwNSfJSGWPH9A/vmPY1y0IhqHVGTTk6GffSyvJrLOH6zovSzBVRi?=
 =?us-ascii?Q?Y571Zg96GMjgXTdKi0fb0USfWAbBqQUDnwh+6msPyxdYRu+BdEDoFK2+d4M0?=
 =?us-ascii?Q?sAnSNdd4aUUbXaaNgm/LaRagzvlGTaQ9SWEkA/YL6HE2f3PdoVNvXy3J6WFt?=
 =?us-ascii?Q?BfsP5+IBumrNbstjwG6HnqlJQ36l+/sy18l6HOcGgDm7HSsYkro3FjZUX/Kw?=
 =?us-ascii?Q?booYPorB+xTsMkW1LJsUGderGn9Q1Qt1ww=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g/Gx6RJcTygKjHzlUPu0nYcLGYaEv4IizhxZy6ibQKqnP2aXRXPcXNbwPIwt?=
 =?us-ascii?Q?GzgtbbVD7TnHRdk3vQWlByGTPTSwXPlsw4vTRXdxaUKMOvFA5JuMfqfdzbmZ?=
 =?us-ascii?Q?4z5+DZVBsgbZCvVAa5JzLwo1LfBqmq43KinmAeVALIdMe6aqo4gj39BwG2WF?=
 =?us-ascii?Q?CZ6VD4Aiym8ynV36ew7cZuaQisTjliYJbaefKPwjnc15bKgP8PRoQKVb75V7?=
 =?us-ascii?Q?2FvVWK/LCwycNFPXt/yeiO9i9l1E6E9MqsgbGMtTVCbrrsLJkKcKUU/9QlsX?=
 =?us-ascii?Q?/B/e5XG1hBgJzFhLGjswJeygeeegGNf2wcrsWS/ToRA0lg2K2k0W/gfUGePu?=
 =?us-ascii?Q?7CiABI0FXW4itB0N24gvQ847fmmaf869rXaMigU0h6ZePhs8PF/94rL8CzsH?=
 =?us-ascii?Q?2VrcGm92O+V+fpIpsweJukdIXCk4iquLwUTKhnqJpr6/I73rUTYN/ulAf77L?=
 =?us-ascii?Q?i18oqhSyR9GYxj03Xr+rC25aLslYsh546infJT183eU2KiJ0rCYUksfFp71B?=
 =?us-ascii?Q?1Sc7h5lpjp8ayO+iaSwjQiL2Gi0cKl6DHl4WDbPdVUguBlZR+k+KNSEjXEqQ?=
 =?us-ascii?Q?mp5RXKLIm6rvzWAErNTshXgHyBX+1+ApnPEr8MlrmrGhVpNj2CEw4orHLbqB?=
 =?us-ascii?Q?zEqThmZ8hZIGUG4jXluczjrLdxukj5ImVSkIiFwtSVlhigB17c8Q/9DkAQPl?=
 =?us-ascii?Q?x2bn1wbuswV8G1pO65Er2+eOQQlZ83zfWzflI9FhGeTiK1fQVCHQv/exDafd?=
 =?us-ascii?Q?cXw8ssiZZam8QBYL+Z51R03+wXYzQeeXlZf1LPpEXIl0aqk8Vmt0wT0agnA7?=
 =?us-ascii?Q?Bl9KL4N2Bv0shrKDgdmX3gt/U0uuooXnZl6k9pxO/n0l5NAmTpV0St6TiNl5?=
 =?us-ascii?Q?8FuNmVKsr7+mXJzQn0B3FxmcK9UY25bT0Pgav/A96lejwSf4rgy++wCFu/cc?=
 =?us-ascii?Q?/4ieauMdz5U6mpdov52S0OlF8angP/isO3TdoiyOBKq3lZ5LprYMNy7Au1hN?=
 =?us-ascii?Q?+k4rpZy/j9/sKqEg4Yp7kQAnD7KrQAx9XOJasbDWUwa9tWYiqBuJ4E7ypP+q?=
 =?us-ascii?Q?ULCWaJCQBj/jNtYRzCoBdYXvAx8Fl03yYex8o6jeJtkYGKdsGBBy067Zeast?=
 =?us-ascii?Q?aqojw32tP+OGpFPqCMIuM3PyDFVa6+YSo3zl0jcb58pnbkB3Ql2JHmvlWxrS?=
 =?us-ascii?Q?YKvZo22WALBZ4/jcGlZIYBWTDMnB1J5B6dgyXn6rxx176NjqZsP5Hk6ARUc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a54cd0c7-a901-418b-b506-08ddd96bc434
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:45:03.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10175

Hi all

This patch series introduces integration of `git send-email` with `git imap-send`.

The first patch adds the ability to send a copy of sent emails to an IMAP folder
specified by the user, which is useful for email providers that do not support
sending a copy of sent emails to the "Sent" folder via SMTP.

The second patch allows users to copy emails to an IMAP folder without actually
sending them.

v2 - Fix indentation in patch for imap-send.c
   - Minor edits to commit message

v3 - Rename imap folder to imap sent folder
   - Make an error message shorter by removing unecessary details

v4 - Fix a bug causing emails to be copied to an IMAP folder even if
     --dry-run is specified.
   - Minor edits to commit messages and docs.
   - Add another patch that enables copying emails to an IMAP folder
     without actually sending them.

v5 - Avoid using -[no-]parameter.

Aditya Garg (2):
  send-email: add ability to send a copy of sent emails to an IMAP
    folder
  send-email: enable copying emails to an IMAP folder without actually
    sending them

 Documentation/config/sendemail.adoc |  2 ++
 Documentation/git-send-email.adoc   | 26 +++++++++++++++++++
 git-send-email.perl                 | 40 +++++++++++++++++++++++++++--
 imap-send.c                         | 26 +++++++++++++------
 4 files changed, 84 insertions(+), 10 deletions(-)

Range-diff against v4:
1:  2ad311502d ! 1:  27b5eb33bb send-email: enable copying emails to IMAP folder without actually sending them
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    send-email: enable copying emails to IMAP folder without actually sending them
    +    send-email: add ability to send a copy of sent emails to an IMAP folder
     
    -    `git imap-send` was built on the idea of copying emails to an IMAP folder
    -    like drafts, and sending them later using an email client. Currently
    -    the only way to do it is by piping output of `git format-patch` to IMAP
    -    send.
    +    Some email providers like Apple iCloud Mail do not support sending a copy
    +    of sent emails to the "Sent" folder if SMTP server is used. As a
    +    workaround, various email clients like Thunderbird which rely on SMTP,
    +    use IMAP to send a copy of sent emails to the "Sent" folder. Something
    +    similar can be done if sending emails via `git send-email`, by using
    +    the `git imap-send` command to send a copy of the sent email to an IMAP
    +    folder specified by the user.
     
    -    Add another way to do it by using `git send-email` with the
    -    `--use-imap-only` or `sendmail.useImapOnly` option. This allows users to
    -    use the advanced features of `git send-email` like tweaking Cc: list
    -    programmatically, compose the cover letter, etc. and then send the well
    -    formatted emails to an IMAP folder using `git imap-send`.
    -
    -    While at it, use `` instead of '' for --smtp-encryption ssl in help
    -    section of `git send-email`.
    +    Add this functionality to `git send-email` by introducing a new
    +    configuration variable `sendemail.imapfolder` and command line option
    +    `--imap-folder` which specifies the IMAP folder to send a copy of the
    +    sent emails to. If specified, a copy of the sent emails will be sent
    +    by piping the emails to `git imap-send` command, after all emails are
    +    sent via SMTP and the SMTP server has been closed.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
      ## Documentation/config/sendemail.adoc ##
    -@@ Documentation/config/sendemail.adoc: sendemail.smtpServerPort::
    +@@ Documentation/config/sendemail.adoc: sendemail.smtpServer::
    + sendemail.smtpServerPort::
      sendemail.smtpServerOption::
      sendemail.smtpUser::
    - sendemail.imapSentFolder::
    -+sendemail.useImapOnly::
    ++sendemail.imapSentFolder::
      sendemail.thread::
      sendemail.transferEncoding::
      sendemail.validate::
     
      ## Documentation/git-send-email.adoc ##
     @@ Documentation/git-send-email.adoc: must be used for each option.
    - This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
    - for instructions.
    + 	commands and replies will be printed. Useful to debug TLS
    + 	connection and authentication problems.
      
    -+--[no-]use-imap-only::
    -+	If this is set, all emails will only be copied to the IMAP folder specified
    -+	with `--imap-sent-folder` or `sendemail.imapSentFolder` and will not be sent
    -+	to the recipients. Useful if you just want to create a draft of the emails
    -+	and use another email client to send them.
    -+	If disabled with `--no-use-imap-only`, the emails will be sent like usual.
    -+	Disabled by default, but the `sendemail.useImapOnly` configuration
    -+	variable can be used to enable it.
    -+
    ++--imap-sent-folder=<folder>::
    ++	Some email providers (e.g. iCloud) do not send a copy of the emails sent
    ++	using SMTP to the `Sent` folder or similar in your mailbox. Use this option
    ++	to use `git imap-send` to send a copy of the emails to the folder specified
    ++	using this option. You can run `git imap-send --list` to get a list of
    ++	valid folder names, including the correct name of the `Sent` folder in
    ++	your mailbox. You can also use this option to send emails to a dedicated
    ++	IMAP folder of your choice.
     ++
     +This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
     +for instructions.
    @@ Documentation/git-send-email.adoc: must be used for each option.
     
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub usage {
    -     --smtp-user             <str>  * Username for SMTP-AUTH.
    -     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
    -     --smtp-encryption       <str>  * tls or ssl; anything else disables.
    --    --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
    -+    --smtp-ssl                     * Deprecated. Use `--smtp-encryption ssl`.
    -     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
    -                                      Pass an empty string to disable certificate
    -                                      verification.
    -@@ git-send-email.perl: sub usage {
    +     --no-smtp-auth                 * Disable SMTP authentication. Shorthand for
    +                                      `--smtp-auth=none`
          --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
    -     --imap-sent-folder      <str>  * IMAP folder where a copy of the emails should be sent.
    -                                      Make sure `git imap-send` is set up to use this feature.
    -+    --[no-]use-imap-only           * Only copy emails to the IMAP folder specified by
    -+                                     `--imap-sent-folder` instead of actually sending them.
    ++    --imap-sent-folder      <str>  * IMAP folder where a copy of the emails should be sent.
    ++                                     Make sure `git imap-send` is set up to use this feature.
      
          --batch-size            <int>  * send max <int> message per connection.
          --relogin-delay         <int>  * delay <int> seconds between two successive login.
    -@@ git-send-email.perl: sub do_edit {
    - my $target_xfer_encoding = 'auto';
    - my $forbid_sendmail_variables = 1;
    - my $outlook_id_fix = 'auto';
    -+my $use_imap_only = 0;
    +@@ git-send-email.perl: sub format_2822_time {
      
    - my %config_bool_settings = (
    -     "thread" => \$thread,
    + # Variables we fill in automatically, or via prompting:
    + my (@to,@cc,@xh,$envelope_sender,
    +-	$initial_in_reply_to,$reply_to,$initial_subject,@files,
    ++	$initial_in_reply_to,$reply_to,$initial_subject,@files,@imap_copy,
    + 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
    + # Things we either get from config, *or* are overridden on the
    + # command-line.
     @@ git-send-email.perl: sub do_edit {
    -     "forbidsendmailvariables" => \$forbid_sendmail_variables,
    -     "mailmap" => \$mailmap,
    -     "outlookidfix" => \$outlook_id_fix,
    -+    "useimaponly" => \$use_imap_only,
    - );
    - 
    - my %config_settings = (
    + my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
    + my ($batch_size, $relogin_delay);
    + my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
    ++my ($imap_sent_folder);
    + my ($confirm);
    + my (@suppress_cc);
    + my ($auto_8bit_encoding);
    +@@ git-send-email.perl: sub do_edit {
    +     "smtpauth" => \$smtp_auth,
    +     "smtpbatchsize" => \$batch_size,
    +     "smtprelogindelay" => \$relogin_delay,
    ++    "imapsentfolder" => \$imap_sent_folder,
    +     "to" => \@config_to,
    +     "tocmd" => \$to_cmd,
    +     "cc" => \@config_cc,
     @@ git-send-email.perl: sub config_regexp {
    + 		    "smtp-domain:s" => \$smtp_domain,
      		    "smtp-auth=s" => \$smtp_auth,
      		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
    - 		    "imap-sent-folder=s" => \$imap_sent_folder,
    -+		    "use-imap-only!" => \$use_imap_only,
    ++		    "imap-sent-folder=s" => \$imap_sent_folder,
      		    "annotate!" => \$annotate,
      		    "compose" => \$compose,
      		    "quiet" => \$quiet,
     @@ git-send-email.perl: sub send_message {
    + 		print "\n";
    + 	}
    + 
    ++	if ($imap_sent_folder && !$dry_run) {
    ++		my $imap_header = $header;
    ++		if (@initial_bcc) {
    ++			# Bcc is not a part of $header, so we add it here.
    ++			# This is only for the IMAP copy, not for the actual email
    ++			# sent to the recipients.
    ++			$imap_header .= "Bcc: " . join(", ", @initial_bcc) . "\n";
    ++		}
    ++		push @imap_copy, "From git-send-email\n$imap_header\n$message";
    ++	}
    ++
    + 	return 1;
    + }
    + 
    +@@ git-send-email.perl: sub cleanup_compose_files {
    + 
    + $smtp->quit if $smtp;
    + 
    ++if ($imap_sent_folder && @imap_copy && !$dry_run) {
    ++	my $imap_input = join("\n", @imap_copy);
    ++	eval {
    ++		print "\nStarting git imap-send...\n";
    ++		my ($fh, $ctx) = Git::command_input_pipe(['imap-send', '-f', $imap_sent_folder]);
    ++		print $fh $imap_input;
    ++		Git::command_close_pipe($fh, $ctx);
    ++		1;
    ++	} or do {
    ++		warn "Warning: failed to send messages to IMAP folder $imap_sent_folder: $@";
    ++	};
    ++}
    ++
    + sub apply_transfer_encoding {
    + 	my $message = shift;
    + 	my $from = shift;
    +
    + ## imap-send.c ##
    +@@ imap-send.c: static int count_messages(struct strbuf *all_msgs)
      
    - 	if ($dry_run) {
    - 		# We don't want to send the email.
    -+	} elsif ($use_imap_only) {
    -+		die __("The destination IMAP folder is not properly defined.") if !defined $imap_sent_folder;
    - 	} elsif (defined $sendmail_cmd || file_name_is_absolute($smtp_server)) {
    - 		my $pid = open my $sm, '|-';
    - 		defined $pid or die $!;
    + 	while (1) {
    + 		if (starts_with(p, "From ")) {
    +-			p = strstr(p+5, "\nFrom: ");
    +-			if (!p) break;
    +-			p = strstr(p+7, "\nDate: ");
    +-			if (!p) break;
    +-			p = strstr(p+7, "\nSubject: ");
    +-			if (!p) break;
    +-			p += 10;
    +-			count++;
    ++			if (starts_with(p, "From git-send-email")) {
    ++				p = strstr(p+5, "\nFrom: ");
    ++				if (!p) break;
    ++				p += 7;
    ++				p = strstr(p, "\nTo: ");
    ++				if (!p) break;
    ++				p += 5;
    ++				count++;
    ++			} else {
    ++				p = strstr(p+5, "\nFrom: ");
    ++				if (!p) break;
    ++				p = strstr(p+7, "\nDate: ");
    ++				if (!p) break;
    ++				p = strstr(p+7, "\nSubject: ");
    ++				if (!p) break;
    ++				p += 10;
    ++				count++;
    ++			}
    + 		}
    + 		p = strstr(p+5, "\nFrom ");
    + 		if (!p)
-:  ---------- > 2:  1d74a857df send-email: enable copying emails to an IMAP folder without actually sending them
-- 
2.50.1

