Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0573220699
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700456; cv=fail; b=at1635QxkcDz8g9uGAkkkkQIVLVp7qGtx5/uZ8wzZGSL5BmmGgPg7J8OzDYBdxpNLZ69MyDMr14ztq6xXFh13IrE15ZQsQJTN5cVHzAVhGCrw6dDo9bN2sGZHv8vnG8NxY0Sw+pD2ItepDhUf1qFDH6347uVE3XA61dY8T2wdOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700456; c=relaxed/simple;
	bh=XcM48xhn0d4bWl/LqHMkZ0Fm2sh//8OFTKR1Znwk4+k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=auvQc3PPSjc+i9VbUtg6BfV7gJ3HMDiCnwP5in8PCrEJWvgkM0sylGOi5oI3zwv0a8/5OFijZSQtsio5KwIjuSRZURnBuid3TwUTnuZ0Pf1fgt8Na2rWAfpMfl3u5FVYwtw48j6EZSA9RfXiulMUsvMY7xZdbeM8Bg8u0HCe9WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=A0bBsisX; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="A0bBsisX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3d0LKh6zHB8I6rvAwENdVNVeQ/bY4CRnhIdI0h4F+zFrNOZyJ4OH+B6o8gJlNDQ8JnsO+HUJSEX8cHKpUYZOnaO/7+cBfLSDMzpZCdRVgllYR9t+1xNbhibKuvy5ImoPwnBQS4Oz5eKjg78w08+lJkJfPae88dxILKQd9Ah18XU4Xqg1YYPdnSm69Axzaaiz7X1fVzq8FzDZpcGiziyiQvDsrcD+La6rSFzvjEmKJkdxjlL1uuv1X0hgZA+B+4wbxnZkZLv2qMkxlv7Rtmrxxsd4DwLk0i0JcBvWjKcOc++m3+fg4nwGJ4TXtS7D3XWHZAhDusVeV82x3+lMeUX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+8ifD2SljnUElTRBL8FHYcUMmPVu/HQbjZxtc2S+xA=;
 b=SQsmywD7dd7RTtqF/+5upZtJM+0fLzq9qAB71w/6YGg1A3klN/TffeSXt8Dz6eOGtjOK2ZbXYCp+PnzvSWlBLiP6XE2Et+PMNRr+o8t6lJjm0cXScLnhK1lJU8a2vWoQ90KHyVsDVnC5h8HjnMqgJxLZJzF1R1UMMZBZupYM11+uCGWisvIy6R/ekZzyV/5lT1BHMbQir3a0Vz5MK8/I02538IQ1Mt3xYEgh73nUUU6tUhWRqyBU77UyGhxZ7qCR5uV2b817C9twzji2M5iiE+8LSH27tKaeXzIL0SaUIybTJTsUFJ+8YbzVPKhNKUGN92rSe5YXMY3OT9LaWvIpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+8ifD2SljnUElTRBL8FHYcUMmPVu/HQbjZxtc2S+xA=;
 b=A0bBsisXqPER2OI+q8haYtHOEmXE9qbwUxi29er20iDB75NF0OmkElA6oop4MdS2SXAPoodUR1oc1Y6yKN86nJ7S6vzmP+jbzJCICXHGXFeT17f29jbe9HcFjHLzBGYlC4N3f9gIBw4tZpfDOel+ZNdN28p0czt+cMGXUsDkrzClLAtXrzESKh69asyymW8gVKlfvd4o4stNUT4/VUTEDumpgPEi9yuTJbms7HGS7aGoHlyys7ZcF7rqzWEygzD26BEn5qjaW3Wg0mbXkdG/PLLHRBYU1jrymEzjThTjyE44GHa/Hsqct67hBGIZDxtpYQ6gUZA1lDFUg7aTYVLgrA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9409.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 10:34:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 10:34:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Thu,  8 May 2025 10:31:55 +0000
Message-ID:
 <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250508103358.15409-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e04191-7606-422c-c8b2-08dd8e1bddd4
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6ketNNKUQnLSznkos01rEDq1x121/roB5bItWzvjaVI49nUCBiGGulOBsxkks2fSw9U78Lx2lKr6NwlM/w5+HsvxIjUUMs1nXX5M7BfkquQ8MVpYqC+sVagHTBJVjZDQtLik+EpRmHBRORigsrVEiOwjb9Ar1bTMpWfYoNJOJ9vrNQBA1ecWLt/7l46maP/DS/5sAiKfR27S1wqbcO81YwHj6FDVxfUWERhpo6oMdP+2fBgKfEI/RlJJC71WKqSLi7CGRXI/1KdI6yzrRMvNPLNvl7VqxEcWiBSiqfqYxmMQxcKUb01s4D83ma6Geluq6/+z+o1GD3hGiec7owIRZn9V8SF+lcayjUyJqAIQUbxuRr/r0IMNQJRfZCwLtSC9AdIJ0PC7dHbMT8j8VLNOdJeS5KqCiXCepk63cJynTm/e+cVGu12jyPG+itPjG58T37kgf/gb6kIdjIm1ZpOmp30tP3j7p4J0aAIEWQCp6wqECYFpbptGNE47MJRzQjjxUZCK2ph0rizNonDvdU/RR3g1pbkNgCPrbvUj2YqSOtjnuqKZoyFA/E2cyaLIeTcxFYATzDD+rakDYYtQJ4kJatq6ZQfiKCELbvhS3IJ1bGqQC2ami1fUAvohHpwHtWU2YyBL7K6Am04ULWQidccrn7TWDbDm6RwNfKHBvNDL5TYqU6cTaEW4yEAdufx55YF9s8IDd1nqfDcc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|461199028|7092599006|15080799009|19110799006|8060799009|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2O3RLc5hZ2VvPtiRm3khg1tz25+h8ROfvjrC95ZhYUmS4Nz7+79sMt14yKv?=
 =?us-ascii?Q?mW2DnjfDma4h544e+LYOGtK8gqiE2L2NfZ3MqFI8qpcYxXFlCyltDoJrK9Ut?=
 =?us-ascii?Q?FGqZE9xUzRnv4WBXI+h3yJrldHfoZA/VyX6CBxNvj0qw51OFwY/PdNwfIwzS?=
 =?us-ascii?Q?dPE5/1fY7KrlZxBqa4reDzvRrJJCm+mANPyBwHDs0mH0aMW+vzvNDlcVgNPj?=
 =?us-ascii?Q?AMHTOksjauGhFk7EVi6f81ajWGL3AESYc1ZYtknOIJEa4F1pWTI7HufIQsz9?=
 =?us-ascii?Q?Qm8V5kQWfIFPL24RdTHMwjyQ8g1dTR6g8ddYlGNFgkOo4b3QytzsGxV6w/Ak?=
 =?us-ascii?Q?OSMYTSuxunp/6j5ga+6KDOWSE7z+LPg4KgFLNxdAAChfKjLB6nmHM9MaPgKm?=
 =?us-ascii?Q?jW8WS6RpojIP75vvooS4eOIpIq6PbEvHlFOpSpW3E7xPV2xrrQNe3sqdrqBK?=
 =?us-ascii?Q?yzpDh5tdzAuQjVxYsU5p0XWBTekVvdSE3J0a7mgpvUoyUmUjRLMK3w9L43Ch?=
 =?us-ascii?Q?y2bR2J8FK/LJM/WKzpJk9x5+s7zhUyWJZ6K5XmidC0tjkVqraFXdzPftfnYw?=
 =?us-ascii?Q?8xm5rH9jKWfyuJbRTIoanV6mMPX8EJFr0jLu6T2h7ZgpwRdk51cR0lsccGJ2?=
 =?us-ascii?Q?U5N3z7aC/RsM+We/psOi10xIh8hkY0ik8rv7YYvyS8pLqDtG6R2pG+uvvrpJ?=
 =?us-ascii?Q?izx8ACkJgr+3TVXWH6/BiopWYh3ar3jz/iLIt7Xa2eCThC20FPDzKNQiEpjL?=
 =?us-ascii?Q?hINy3+mdfFXtg/K9W8QabiIFL/dcLltMfpYMIiCXwslCSE/rTkM704JlVotn?=
 =?us-ascii?Q?exRM6yUAVjN62n+Bo3vjNFzUQJAIxyZcwdnNvb86tXRJ44pAhDDmHqmM6XKl?=
 =?us-ascii?Q?IVoQVt+kFUkIJhnqdGYbpx2zqzcvpKzqkObU55JFyVVsofdEeRT2lGhUN73Z?=
 =?us-ascii?Q?khU7gP0ivURaJk6Jtamo1khff9PNAgjkOzxTqOn4dP7loLewMfZEYXSxqg99?=
 =?us-ascii?Q?OlJJexxUuFKADBhSzB/6+yqViLpKJ43Z2EvO3hldyi+fAP9TTsn1uDNMsaBA?=
 =?us-ascii?Q?X6VOobIaJNkltaZNAt0Fh2HUxbCVXl4WAuCmzm5FaIbGYb7X3xGYHLqa5M9L?=
 =?us-ascii?Q?5PqxDQFVY6enLBkHbjJ6bulSGaW912J+Iw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sl09lKQndtg8TX+jsAO7ILgaTV+L1OPv8bbevkMEjHCgk6+bB5uJtr6aMw7?=
 =?us-ascii?Q?mnOqzIGqyj3MPeaidlqWcSE8L2qwdy1OQFhdzrMPaOkP1VFpuHas3IY6//or?=
 =?us-ascii?Q?kJT1LYpKD7fdCVdh77ebQSQqg0PFkrSCMsuVL2dOtTtmdL1+MbeOgL2RbeL9?=
 =?us-ascii?Q?uxnOVdR2Shsqk6BR7+xkt6WcjBkeaUfO5hP7JyF3ZfJqeGs09EkcfLtR3kOY?=
 =?us-ascii?Q?1Qh6dFPBN4ATrpJ/jH/+T/GRQU+6jpHXzjyLgA0r//oWrxVq5SFDgoH0OXY/?=
 =?us-ascii?Q?+pAUoNggDkxl0y35hD3py+A2XBujggDb1mTb6Jg6LL+Fo6DXNaFmf2wcjLE+?=
 =?us-ascii?Q?/taRGDHtsobCy6DxcAq0jGN+0ZpUq+wXKZV2j8RMeHe6zE5MjI+HSTeug0Ja?=
 =?us-ascii?Q?m2lg9X7hC/B93Z5rGHWHDisBZ6n7LlNUkhYCbxP9pJIhOnVdZsmliZ94PKZf?=
 =?us-ascii?Q?Y/BPU8qx5vzmDZ49uMgEJnXBlBb9E7/GFaxkq2bSvAkUqVNNg9Y17JwNsiML?=
 =?us-ascii?Q?bx8S6PXk5RlDQbzwF6668u40iO4bUvwdLbyFFMMzLk4Sa5szpopHnyCJx2in?=
 =?us-ascii?Q?/HmxLs7JYCYX6jvEevDXA+KILszfmfkXdHAhZLaKLv+5G0S5QmjyxM84as7n?=
 =?us-ascii?Q?8IKkky3MQ2SF/mcYDoY2CGbmwAo+BZZQKgKvt2mKFmgaVu74BCY/4Ev+iyRH?=
 =?us-ascii?Q?2napwrVgTRO40p8RdiesUtN/m3iHO4ysCpOoVJej1BJ0UVilpLOB7iE+jpDT?=
 =?us-ascii?Q?Ts9gKwMVrlfJv/pDH+15dUq9REgLUFbAqD0un8BAJoOaIRswLmopB0BYZ8VN?=
 =?us-ascii?Q?36osszi4mZJdJu5IyMb2RQw80RCF85aAkhynWKKfZTcBSdHvJCZL5oPV0rGe?=
 =?us-ascii?Q?IrCt7bql9HUfYPLHNHhgvUNlN+mCSyCs8sfrUU1sVG0+OuDdhoTn6hkHBkhU?=
 =?us-ascii?Q?j30fyFZO3HE7j7oPxTZTw31Ce4clSNx397GMxHuHu0f0SXB0VOp2waug3M9z?=
 =?us-ascii?Q?JPApqYIryVlzGSNzjKgqx7pbe270oDRsCV/gjlM2n4Hgk3KUyVjhtYRQ4VC7?=
 =?us-ascii?Q?/bzGuYrRNqrAwXCDL8+eV1zX1kN5i8Z0AxxuLW8e0covCKg1O8u7ZdiJcNSN?=
 =?us-ascii?Q?VT3s6k8AZZCCTYGtxDFo+/pvPIAdZJShHsDM/ktjCOYlmcWFy4+sBi1QdHIa?=
 =?us-ascii?Q?3MNao56wPmzD0b2ihTOIAxryQdVA+aaOf1xpek38eaPZ1z/P0+Si5ADxx1o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e04191-7606-422c-c8b2-08dd8e1bddd4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:34:09.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9409

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

P.S. I have used `git-credential-outlook` linked in the second and third
patch for this email!

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first
      patch.

v3: - Change link for email helpers since old one was too long.

v4: - Improve log message of first and second patch.
    - Update valid_fqdn check in first patch to allow one or more <upto 63
      octet run of alnum or hyphen that does not begin or end with hyphen>,
      separated by a single dot in between each.
    - Revert the documentation regarding sending patches to a mailing list
      in the second patch.

v5: - Simplify the regex in the first patch to check for valid FQDN.
    - Fix formatting in the second patch to make it more readable.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 63 +++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |  4 ++
 git-send-email.perl               |  4 +-
 3 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.49.0

