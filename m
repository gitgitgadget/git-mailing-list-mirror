Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14919DFAB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335598; cv=fail; b=dDHnV5THkskKf0jMpjoNH9v/0UordbQgVDw+JN+4EXw0WlQQG9x2Jk8TQcF/42mhfgwBl5Oc7CWEB3Z1nkQeQT3VU0H8o9rdts5w/ou7wFu71A4Au7QA4G1M/1MRA8kocLOnOI+zjudy2jC6d27fPB/haUsSsSs67DdyP9YrfeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335598; c=relaxed/simple;
	bh=RCy+ZXbqZDzojPGs1P9DJqQpxFCeZVhWQD+4109HWbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fXNLn0+lwevxwZrFQyN9SNaq1rV5dyX/jDW4l8r4N/ZJLBRLNNkaIh0VERoAGYHzxE1YRj39dn1zMqcgF+Bp+vFy4b0btzts0eNmOgsLcGM1C5Izn3I2aZGZc76VsUpfD+5HD10R6gmXNkqCez1nDLyemL900fQZI1CUPg+ggQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Az3KPxEA; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Az3KPxEA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/Ix4ic7vBfrM3ntxsll/hTwJYoYTubvfP+uhVdq5ywP+zAR0H5GYe/3SzJ9wOGytXylp7Ov18DwCaamomYRO7aP1e1lLNvKAeWjvzIeoUQeCPMSWqLGVt6NGahR7P3v12ZF4LY4bgqStQKAH47uPgXe7NtYMXyu026OzB+J4QOSTVrb+cZUwIoA1feOZXmlulWlQMBnGhPNrHZRrJsTEONerbHo+PaGzfcp1x5JMyM1OeJv6RA9O2nJmFLHfam7LzJYGO+RB/m+R93s5atM0tTpOPW0ENwp9moYFgh30prxWuSvSVUQdCSkhafJwRUcnFCZCIV7j69VjGz1iPdjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrvMsNQdhXh/3Evp4i5YHjNHuxwu16rOCFJg5d63V7E=;
 b=Xvw0C1taODZRdXmtMCPdZ4M7jIeTVU70G+a1GIvHbSjHIIHCokjqm7jTRZyBVfgzI9PPRaNMvXkWu2SC8iphIAVl4J8bewjCLkF9J3d08C03+kJZdJysS/H3qwFb84VF9VLqkAxjwyCov/Q6KPUQxnLiwANbLrTRTMwvt1esHoP167V0qSn9QFEOf8VYFSjwRrtfz2/jz8oT16Zem19b495qCl3sk1frASXqrtB8SObwAShWAcmrGDIxU76BBuR2fufHuEL5EmWMrjjOo7uhS8AHiOjbmEK5agxj4kVkkBBKywLK5OOgerfy8q3c/tF/5QHn+vMugnCl/qAoDdgDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrvMsNQdhXh/3Evp4i5YHjNHuxwu16rOCFJg5d63V7E=;
 b=Az3KPxEAlgYh69F9Bdm9jZ8CU0PpwXOJ3Qel6vlnTohfiEeVCa6B4yky3OgKuIxXNlSCWWVv8befbqoqfqxEXtt/t4kEQKraHURWu8PDDg8Iks5aZSJAS0+AaARVfnIvw34XWiAEl2ZjCo0thDvH4uamR7WgS17Uqsum39L7Y+XvgMd9jh0MtcZNLsg7IlStz6kFH4hF0xljU8Ue4vfUW0zgtrC40sKkOX5OLBGQpPW+qZnK/7lUnsaYWQe09NgvVomLb1udxSQB+fiTUkDng9B/LWIesYA1AWuo1TlxTMAopvaXvhmlWAHlct7bjazjSOz7YWZS/JowE6nP1xBaUg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6777.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:26:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 15:26:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 0/3] send-email: add oauth2 support and fix outlook breaking threads
Date: Tue, 22 Apr 2025 15:23:18 +0000
Message-ID:
 <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422152624.19037-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 16329360-9140-4e59-8a6a-08dd81b20ee2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|5062599005|8060799006|15080799006|7092599003|461199028|19110799003|10035399004|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2b8Z5LyVONSxAgaiJ/2pu9CfqHsIF6HL9iukJI8q4EyHfCm6k63nLRURX8yN?=
 =?us-ascii?Q?CVHNw2jmbe6SsIF8SL2Dh+BLhHpl9H+8vL99mf5Ukz1hxgqofZo4EzpQ5J98?=
 =?us-ascii?Q?uj35ZVLUVlDnATOWjiJpAWVPSTqUl9cWsaki5YIDACpMAB/nKFYKuvg5+vtr?=
 =?us-ascii?Q?HQIsTQAbq0AlquTyBZjgp7tlkVAJ27gGJ7Dve3Ieqc3eg7zVRBld0I+Kj639?=
 =?us-ascii?Q?Kyd6t/H5zRxQKNltkXZSqjDQnaybqeB+VUWW1LG9sUlnExaLR+jq5i4bE9yY?=
 =?us-ascii?Q?V9dPOJVy+R6zCzUXcYcohxPN0rkOUhyF5ty209Q4AZOysZTsJQonIi+hSFGE?=
 =?us-ascii?Q?lBlZj1Ymk0T6+Dm2hx2oTVR4k3yfSIHvuRI4Ny15dnTFDQwDSEXauaVvVYz+?=
 =?us-ascii?Q?xHT4Up6Nrbr4kWB029IlAZ+wQHMRxjVHeryXKqyCYn61t1wgX4pieErNdHAi?=
 =?us-ascii?Q?ungCPcMRpFExjTD4G1/9ePLbZW/Bz0S7xwlE63vyYtFgPjdTDpg0aT9M/sK/?=
 =?us-ascii?Q?q0mFXO+JiixgnXyn7hQoLrHIbBI0Q7HOJ7ZSLl0B00LJ6EIwG9s2hcMM6lbl?=
 =?us-ascii?Q?aapWR+EtOtCJJYkQFxfCIFJhqsvO/JkwKpawl1vxwii2oJiXKMZPXqkQLYRB?=
 =?us-ascii?Q?A3eWfn+hPT0rnmC3XZgoOmf1mUwJAvhMAOl1ynySZERJy/WXJyzc2lA0yu4L?=
 =?us-ascii?Q?tABgaCPwgexBCyiZcKRD8356+ESP6PY8XF2KEi2HaLbrAY+K5IpEWIGkYwRv?=
 =?us-ascii?Q?32UGxlVYlb01EQC0DLpRQXAlw2mWtk+/bPmjUwngHIrGbScEGKRMZ5xgcj6X?=
 =?us-ascii?Q?DjwbPPNNzfOhbaprgyp7yzKp8w5Z17Yk4oBmAOd1CTARp7B85j6VSQEQZ1E7?=
 =?us-ascii?Q?sanzCBHRIVXi9WM+xtzVGAQiWfrFHUrrlQdVNunMBKWlQo1a7lXg4b2m3WNN?=
 =?us-ascii?Q?X6ALS/j/XXaXSwUVl5TL54gm0Ae4KJBF0FU0cYxuzIloDbRnTRMjWU0NjU/m?=
 =?us-ascii?Q?OnXyHutabE0qmh4w8x3OB3kASawCj00eX+XtV6/VMNYeKvRtoGZZSHJe0tJR?=
 =?us-ascii?Q?0ogcA0X3A1pPLMNzC4VCIwj0AArRXXXVCbJVA5rTTeQAczhhP9plsuqicCPC?=
 =?us-ascii?Q?O0sLk7EzIyJTHxggIqMNJcj96U4N0ow9H4h/a5ls2QkIeRzTK8r4wQaFjnTV?=
 =?us-ascii?Q?g7XCaBCiZZUOR9S8J4czx8dNbpvQHmjxo3ok20Kg2C9EtHuDMV6zV5c3wriT?=
 =?us-ascii?Q?AQvMUi/qTK9AyCxUYO22ZnimXf2MsSUOIv6PkEr2AQz9Eq8QQJoa8NQO51Em?=
 =?us-ascii?Q?j9o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kwh9kNwm7zXzDYNRFEZCsE2xwfgJDRaTbgn1jjA8RCcjnAJOdll949fo9f6l?=
 =?us-ascii?Q?epb4E1phzT3pNTpI2mhlf0DfD/F/JUXj17MKUz/oDHHipo+mzRxj27SSJ5Rb?=
 =?us-ascii?Q?pOYWQITlDm5FvkrngVtoYf77QdnnVFmc/7p9hM8TqXL7ZsrKRF4KxFWc5O2b?=
 =?us-ascii?Q?QQI2TnC735vHF+y5YI6BD+xe6tATJ8tfO28wrNyXuhbELw1r7PpHII1yVg0h?=
 =?us-ascii?Q?s7yySqPNBWhBdE1j4/DFfE053v2wZXJ5jscn5dBUcRx0rGYOv1FaSTXWi3G4?=
 =?us-ascii?Q?GWYZ4KmQx7UCZ0GBi2pOr+bFlbUISqFtVne/cxklettTykrT7anfanUFwB9p?=
 =?us-ascii?Q?w8cxAzzDtCmbiv4aju94cEbkkd3Y5ooOfhAdcFl0nfEWx4J9pRKfoM14D2r+?=
 =?us-ascii?Q?Zv1w0yaV5zu2yTYkwFdEDgQkN++QBjiCTW9BIvciqqCZJlfSeSqqHbMDJXJG?=
 =?us-ascii?Q?HrlcXmNpGltczjkJPtSg+xhwIr3B7k0NBg0Fsmcpa0hPN+DUPt/kMN6h7kWn?=
 =?us-ascii?Q?1u4WKdhoO69n9Z/JMtfgMQYkkGazfFEFO143AKBWecT0Ti0gdMzolBtZnmAr?=
 =?us-ascii?Q?GcOnkGPC72qNg/c0wRMb8NPakNcsKavISy4EHJmiXu50oqatQRQjHwVixnLv?=
 =?us-ascii?Q?RdRFF/Ezr6VXum9/kTrczpuofs+6BI0WxiPwJ1nQmxY5ZvRosK5bPBtycpjR?=
 =?us-ascii?Q?TX3kL2qd6Fn5U0I4zsIt608t3E0ZvTZGDVH5Gqlk4HQzeajSLjaHp9U+FYCK?=
 =?us-ascii?Q?3/wu1wtTIZbMK59H1jZxCv1MhhTQgu8UFfqI2q0RvoRekNzneyrOnNQ6X37J?=
 =?us-ascii?Q?u99hvktq/fROqhryLE2+B9lvoywAmajMJAQy4Uq6DdaEXuMQ7zxYYSeQjja3?=
 =?us-ascii?Q?Gu+IfayLf16ZCn0nyAsV2vWfKXITnaPQHZXTPc3MXRCLOxruScqqmc8h6ps6?=
 =?us-ascii?Q?RLI8s38FohLJjpdo+8XW/BCPDXdx3Cgb51WlOhfUwuAK56GGYhko+1df4Px4?=
 =?us-ascii?Q?uDlkE2i/dwbYE1glTVVXecU+57eUv4vhPAhpI6DPVACS/HZewGOg6DbyCukC?=
 =?us-ascii?Q?/UWgpG7PZDX3Opp6EDbqVTby7gqDGz4rLixvjoOvAZ9LcKuawaT6fWslp8hf?=
 =?us-ascii?Q?J+ooWI/t1DMUMf/2FNNA89v43LJ0DYHlI908AyqsVqCPcn62MivAFzs3Lq2e?=
 =?us-ascii?Q?yA020WllgWkjgugs/q0+F1LeXRsk6v5uIVTrJXtYwslA+NN+mhdNMlmsP18?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16329360-9140-4e59-8a6a-08dd81b20ee2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:26:31.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6777

Hi all!

This patch series includes three changes:

1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
   This patch has been rebased to the latest version from the original version
   at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

2. The second patch makes the script reply to the message id set by the outlook,
   since outlook has its own proprietary way to handle message ids,
   and does not allow user to set their own. As a result, threads were breaking.

3. The final patch adds a new option to generate passwords like OAuth2 tokens.
   This is useful for users who want to use a script which generates tokens for
   OAuth2 authentication.

Detailed description of each patch has been done in the respective patches

BTW, I am sending this series using the patched send-email by these patches from
Outlook!

v2: Fix errors flagged by the CI
v3: Add third patch to generate passwords like OAuth2 tokens

Aditya Garg (2):
  send-email: retrieve Message-ID from outlook SMTP server
  send-email: add option to generate passswords like OAuth2 tokens

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc | 13 ++++-
 git-send-email.perl               | 90 ++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.49.0

