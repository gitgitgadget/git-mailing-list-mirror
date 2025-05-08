Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3D25291C
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717746; cv=fail; b=uymCo6ya3WV//Ub7E8COmyL6m7UOJsbWTHZQR1euilJprJKQQHw7VNnAMaZxRvsBZL5kOcUfP4hvwxa9hE4iYEG5B8YIPxAdWz8Y7CBk45nwTrVD0J1hbFhdAsDBHls4PtLGkmMNlr4x0XUZlTDFVf/ofkhOPX4QwkRZJHwgyF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717746; c=relaxed/simple;
	bh=+A6Ccsjg/lGqxlJbXgNL8JtRo+xlskZAe2UizyxLiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq38bN7L9L0Yv3VXyVY76nfAGdwWdsB7qukmqNO4cCI4McpkjCGbQQpmLwMp9fyQR0+cMTbVxzVyWrWA/qK1AapI6HVGMFSNzOpLCL1obYK/jMor0ioyIxA7z8kj4tCfkq/f2zos1DuzhqJ5ra3hU7ubG23X3CltpjDCDzCHAsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=J/EzEgTY; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="J/EzEgTY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRkOLnWNC007ZeorKud2D0scS6JdRElmgmgRsFevDwlK2/Z+PpZDkOQLN3xGskGcgwFZ8xiGICWcEoevGMOVcCPUSt1eQ+LuKPvHMDw8FHxWq6JvHuXe4/tlTqEVrfjVFejpfS5Z8OwTtwF3Wx54AJp1x+h+2t3AoC4dtWeYW9lW2Co7z5w67Dx+T29REYKNJ0TPoRnXzuQaOCbIILoPC+kFqjcqJ7pOAtTp1+nCHWlRMZkAewVjRemFwOlg1Tj9hA2mzn7QW88XPauTfgrt5OvgqueUFhgTUGNEHEpRqInznDgqH0brEHv/3za2DNlRCVdBfOWupGn6wwWUXuPrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=C8harPmf4wOPw2VbProoThTZQw7FkUmPd7T/prMlkWixsENM0JyecYDQsKzaynxa3i4kRXb0x6Vt1X1WzRk5u81AA2EY5s8mpvU4eOOVX6H7gHJYghfcbt3Ysnm9zOY37JLlmUtfEiSl72Nk9hDzvcr8wx/4yvqoQPHAOjy7AER9cxo4GHIOXFAPF1SwdrZdfnqogPTT4JAWLSj6BR/f1zUD8ewoq2hh1axa4+o9pC57SKGenQmnp6xD72Z+Db/46muZRUiiIBb6/W7SXh0B6DJ/oQ+utHGQTC7341R2D1ossybP95yX/wchVfiqoxLJtlOLqmBmPCf3Gn+TWu3H5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=J/EzEgTYPLSqtdtwVMTq+i4qGolccL/De5p9r+NWBuxmujMf82/I5fQBhJD61+/3B7rxR6bQFP61SO3mZnOwi5Bx5vlJqWH/KEMPLLpBV2vvNNAByw0YAsanzYF4F+/hU8VeZ2FOArw/f2X/36bpojho2n4o7t6+9KbLWv1+yI1qSgQQHoALhpTMnZ36um1kf4WvwOiEmKmxX/5z2SPVMVAIBXyQUtBdj1mQjGGAuhq+BGM836+wEEofARVs/Id47JJrtH71TpWLxU1OyVB+FJOONNTUF4IAg5mM7pH6sneNfZ/2DzAwz+r3qmFP/z+rLHdKanP9/0VQaVeoEnqgwQ==
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
Subject: [PATCH v6 1/3] send-mail: improve checks for valid_fqdn
Date: Thu,  8 May 2025 15:18:41 +0000
Message-ID:
 <PN0PR01MB958852DAEEB74C087D43FFECB88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::11) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID: <20250508152203.7173-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PPFB4730D036:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bcf8bc-314e-4282-18b3-08dd8e441e2f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799009|41001999006|19110799006|15080799009|7092599006|3412199025|4302099013|440099028|10035399007|19111999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyabfgqwMH8kGH5ukfhtLuoa85Py4D19BpK7CMGl/GEcOgjzdu3OhxAXXRiR?=
 =?us-ascii?Q?tcGqb1b3HJZi0Lw++GliMLrjeBw013ysEecjrSA+9EAHrKqXBUGv5p+PCVef?=
 =?us-ascii?Q?tOYZy6IBs55bACTr4ZYW7nQDi3MCSi4ZfEH4S+PF52SWM8zaviL3Za2Fjfym?=
 =?us-ascii?Q?NcSrD+0g/nQ2sVPvRZvMhXadmw6x/HVqHVSuJJpY9VJuyOfARfTgKQ7QMfgp?=
 =?us-ascii?Q?shrqqpRNeAxW2sMSTFWLax2TnfdXVcwZrpiOUdC84eR+Yp8KCG6U0lE2x+ve?=
 =?us-ascii?Q?yeXMqwwVcmz4xVUfBVQjfP0Aw6JbdG56LjSAyURAd+q/aGPOcNXnvjjS0qoZ?=
 =?us-ascii?Q?53B2oFYnoKHYl0CIgZFmkCPp4RWJqNV9rxQOMK+2HMnJmhOLinGtpqbQyRmt?=
 =?us-ascii?Q?+OI21DQyydWsCgKyWMn9ZYFGRxV0XvAX78tnpWI9/A3Pq1UFBFzkhR4TBZHi?=
 =?us-ascii?Q?b7r0DhPXPdKR1yd+0pp4tp7iO+jej2QsCWBMaImcEhcWMbNLmXHQ9pmsD8rO?=
 =?us-ascii?Q?mRh/wBWZeYg+5aK7tzmQ5+d55TVo7Hn/+CP874BN66PhlQ/uHV9kG76RRc2u?=
 =?us-ascii?Q?2u3Ik4OKKdphL2o5x3U1W9j7SWvvC4LsZt4/AjE8SDExZELCIst4ZbjF4qEn?=
 =?us-ascii?Q?jMUL0dQ8GMi9xDcv6LTFJOt6Z7Lyg6kM6xuCidoWYjBcwRaLzZxAylf4hEvE?=
 =?us-ascii?Q?ZHHICSqUC9//xJG503RhupNBb3SPSR5jyH1en87FHyrsYuBwiGIHpz6T46Gt?=
 =?us-ascii?Q?ikmSLmv6tyXnANSGxMK3HeiMiDQ5AEW51Yg1Ay4X6Iz95aw9DGN+DJsBAAMd?=
 =?us-ascii?Q?VGHGqpvB+gu5+dw+hFayRA0TEKQrFIIsQ2bxitaqGxJw3RyCodud+/Ai25cO?=
 =?us-ascii?Q?Rx860ooD+MmqP/UkPLRA7Gm29qYUHsQYjXKhgoYz08zn3lp5k5RbuYU6/mNv?=
 =?us-ascii?Q?j6bRpAGJyV8YGZK7aXVzwEZ23VZr2y4OVntpRjW1TDuFID8/VOBY8M6g6BVa?=
 =?us-ascii?Q?xKnt3JEpK6fbYsWnP/vjCg/YJp1ey5kmc52X4CC1Aytpb8LJib+TVcf2fVPe?=
 =?us-ascii?Q?7RBO/YwfLlySZMYhcHZIFE+QA1IrewC9BRE97OXlpsV4BJf+V7UWt+EmUW9E?=
 =?us-ascii?Q?Pe7nNTC4SrEz2Ua+Y/pKIiQ8x9lPY8WvS2mgBeRgZeyCWgr7yis1m23ma4tn?=
 =?us-ascii?Q?j/ID00FnDDdU2K3BiD7WH15eq6sgR6rb4vdEQNKDWdQu/bGb22OhJomJFo2C?=
 =?us-ascii?Q?Fp2+2KA3kvAaq8h74pJ/DK0/4gog5qNfcznMkZHDOdam/w/R4prQFJABQaBo?=
 =?us-ascii?Q?eok71/bc8jxOORQ5GvSO65YaHySdTBBgTZEE20PmS0zN/A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GroTxCDuk5ETntjZcwiK+S01jS6CAmgPb4p/S+X5iJowlglAv5Xg8DvUmgJq?=
 =?us-ascii?Q?CIr8jgwA0TmG27vF/u9cGrIKUxJdfcdBF6DSzvtUxc38pgw2PDv39npWxLXf?=
 =?us-ascii?Q?73ZA7ayGowf2trNaQgbA/EH0YufclVpJAltHSwPIr0Q3xwf0OSvMcgwUfRZb?=
 =?us-ascii?Q?VdJTOuXopijPZvs0Q9NpMV+GFpOIgFHrmuaPumdt54bIK0bS0rY8T9BH64BQ?=
 =?us-ascii?Q?RYYE0SlNCaV4+eTj9kWEXdPw7JrySu5AmZVTa3875/aEhOoJ5G1pi+TpAfqI?=
 =?us-ascii?Q?WtD8yrHNJq8OVDyyBSXYbGoJpZq6uAht/j7oRaim6v4AnVj5NjrLOSOSrimS?=
 =?us-ascii?Q?+gYA0qmNVVjU5/TUQAEQdL3lOl2zQP9GmPKVxv65wDlRwPs/O3gD28CTOb//?=
 =?us-ascii?Q?f5KMV6Z2USCvGXZ6M8x3QVOxCKQY/CONR2sTtauSpZWDDme7O/PWS+gFTNIE?=
 =?us-ascii?Q?tpd+n+iQ8qh8snBo9wFo8o4ao12C+MDKoZuHPZyT9q77FR0SWTcHRtBRx7ZG?=
 =?us-ascii?Q?2v7t6olAK7armUX+iG1pIZrNx0+4sZkHrtkWM7VNX/6S1HPJgn+pZnYdDOAR?=
 =?us-ascii?Q?47RP5HfqU73dKwYdfpbiPdal8LJtrM+PNrbAdfmrnCvtIGL2iqpT8amV938t?=
 =?us-ascii?Q?HhBP1DiuGAk7GN9VGjE/KDqcU3uDA2caikiMj5BbznfSZ171Mrk+kgmq1s3g?=
 =?us-ascii?Q?TgO2l2wZZGsLcSXsGFMK/oG+G29BSeVifS2YlOETIbacRWi4KB+NpObegx09?=
 =?us-ascii?Q?y1SIuTxRcI9N+/PDGY0l4Wf2S7NxRHWh+oBoa0jPIo8hxttAxsa/nTTMCn36?=
 =?us-ascii?Q?Ut1Qjya4NuoGBga+LQRMQU0c9xbqLY4ou6yfPqsazNAq1CVJiwAoPHXK1U/H?=
 =?us-ascii?Q?X9JeOgZEUrJozoQHWHhnp+Q5kLRdyHpZqVXhbeiUuKC2uzejAwObXxXPEJ3m?=
 =?us-ascii?Q?zXI84ZtTBDq2ojHSDOZ+7O7zOA9ZDlcG+jpI+h0j8TWtwCSmRQVxCOsqWm5j?=
 =?us-ascii?Q?SvXfwhTRfuaveq0F4TESxMsyIN52vfMttLxohc17P3L9U47znyi0kpzL6Q3G?=
 =?us-ascii?Q?3b7/Zpvx7//COMz+vBSQI65ZxKbYHtSUS/0YYNjgFju/G9bNygP9UdzfJT81?=
 =?us-ascii?Q?LhpBwElRzbr0y3MVy/mxjpJnljIZ6bOnULddHEjYbyQN2EL5NkFCICc3VjkM?=
 =?us-ascii?Q?pqPQ45mO8MjERV0ehUgk84RzVmtcdjlsQqhe64xW6mFVres9RnDOiLumyiU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bcf8bc-314e-4282-18b3-08dd8e441e2f
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:22:17.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFB4730D036

The current implementation of a valid Fully Qualified Domain Name
is not that strict. It just checks whether it has a dot (.) and
if using macOS, it should not end with .local. As per RFC1035[1],
from what I understood, the following checks need to be done:

- The domain must contain atleast one dot
- Each label (separated by dots) must be 1-63 characters long
- Labels must start and end with an alphanumeric character
- Labels can contain alphanumeric characters and hyphens

Here are some examples of valid and invalid labels:

'example.com',          # Valid
'sub.example.com',      # Valid
'my-domain.org',        # Valid
'localhost',            # Invalid (no dot)
'MacBook..',            # Invalid (double dots)
'-example.com',         # Invalid (starts with a hyphen)
'example-.com',         # Invalid (ends with a hyphen)
'example..com',         # Invalid (double dots)
'example',              # Invalid (no TLD)
'example.local',        # Invalid on macOS
'valid-domain.co.uk',   # Valid
'123.example.com',      # Valid
'example.com.',         # Invalid (trailing dot)
'toolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabel.com', # Invalid (label > 63 chars)

Due to current implementation, I was not able to send emails from
Ubuntu. Upon debugging, I found that the SMTP domain being passed
to Outlook's servers was not valid.

Net::SMTP=GLOB(0x5db4351225f8)>>> EHLO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name
Net::SMTP=GLOB(0x5db4351225f8)>>> HELO MacBook..

Notice that an invalid domain name "MacBook.." is sent by git-send-email.
We have a fallback code that checks output from Net::Domain::domainname()
or asking domain method of an Net::SMTP instance to detect a misconfigured
hostname and replace it with fallback "localhost.localdomain", but the
valid_fqdn apparently is failing to say "MacBook.." is not a valid fqdn.

With this patch, the rule used in valid_fqdn is tightened, the beginning
part of the SMTP exchange looked like this:

Net::SMTP=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello

[1]: https://datatracker.ietf.org/doc/html/rfc1035

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4215f8f7e9..55b7e00d29 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,9 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	my $subdomain = '(?!-)[A-Za-z0-9-]{1,63}(?<!-)';
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^$subdomain(?:\.$subdomain)*$/;
 }
 
 sub maildomain_net {
-- 
2.49.0

