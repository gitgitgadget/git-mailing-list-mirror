Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919732798ED
	for <git@vger.kernel.org>; Thu,  8 May 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724700; cv=fail; b=hJlFOpGfd9Y6iB+ub5BkTPvHdOy20PD8PqDgZAb8vFCjqM88d+Fk+vctX4qFIeKYoikSPSAUdzLsqAqUPqEfPzFHcJNqyhOTVDIv4n+ybw9IVQtw2XiRptJ0SWVPJtY7/BGyOGg8QNRp9c+1Wb3bHDp/mORO5F2EvU3FVCIH3LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724700; c=relaxed/simple;
	bh=+A6Ccsjg/lGqxlJbXgNL8JtRo+xlskZAe2UizyxLiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGJP2daYS1UzBJODH2byaTLwi+xJWi3LNsTQl5t8itsDlKRETaIW+HSXPJ9CFAmyepwsknNJokZ0+y0yFVLvLJan/brGf4QojZ04WdZFz3RgEoNypPwwNsMg5FK4+rbE/Y34fDmpjX+IinLsLPpXJIWEDGI7CodLwD89no+oWHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AdSzV51A; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AdSzV51A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs+LaPoMhDRZ/EVFPWxTxjLEOIswY2m3waxo/JfAr5rR32LsTGEl21UVtfNzM/GqNB5DEyBHTVliV0m5QyafoxF+D/XNpiAiDO7TuLrkKN16+Po/p9Gvl3Tm0kw2y9zuHzZEPSVUI0QJ0i53UCbG7vKNMM88hI4BOcKzvlGgO7Rcz/5Ss6E9Kdx4k4RjVFqGCQxFg4dkHhOLScpWP4XNmdsGc+Nmfr3IxgrrOvH6Dmo+BydPaarOBrQBrtsQr+nu6CCAXXD1SpWnWpu2GQadGTIbDbiFim+/H/hvjSZKDmvpAVJlsy1Ki3exrwY90Kz1AXlM3mB2+bFWUsmEbrG6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=flRgqxL+ivIk1onEO/BPYG+5wYT7PID0Yhp+jR5NHiwXPFzmPleBttrZlMclF0sbTemY+KHTcc3AJmLRhH2qt4GTPHFHw7DVPUH6FJT1ONKG9kZrJv3CwWhv2NVzDsZ7bxY1tRpJxySgcASxsxfhACpzGnifWH5dLRr2HezjxJxzK5b+9j9V+xsnidK26EBWAWAJVkOH0lpeNIR4D7OgDjzwTUc72TdDwdjr49onXGhQ6o1uOUp+6OxObajSgdDexp5jyNpsIqbmPDRj33u2lFkeiID3ZDvk+clVBSLHPdy9TsaJ0xRnlorBTA8+mZbKiig8byP6/xS9IvdMdnsZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=AdSzV51A7mCc4KToDRM3yvSwQlzHVbTcLWmRSIwTmkGC5ZZX5u3t1aYDR8JGSXwCpgq0Rn10RxJ5/5Bb1XRvtph0nU1rfLhzow088r7LLWBpF+eVNFkMaSV5V150F3rQDeuFPaxCq5LQUunyne7h3riRmYrIDvyG42k6aQI0yOyi3MrVd3BsiDLR9KAkaBol0lLQgLBT20YZALU9X78/q2Sr55HgVz24Wk1Wu5012hbwuygGbMdiDsE3CQ43ETJRapo5S2vYjW7ObNsiHr/O0cWlHRGrJ8i32UP5hBEga0QkgxQZ1RMBQw4FnaxfzyCJ83O8dPW1tLyFlC66fvNjZg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7253.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:18:11 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:18:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 1/3] send-mail: improve checks for valid_fqdn
Date: Thu,  8 May 2025 17:14:27 +0000
Message-ID:
 <PN0PR01MB958809A9F52D140ABD917881B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::6) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250508171758.19119-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: e585825d-329e-4bab-cb91-08dd8e544e91
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCovr/S0ACg5/Ay1HfqoMkzaqcJEflG3My8+yz9H7E2Pb7k5VgqUDJiQU1QXIu/w4iX2yrdjc4rVg4NrO4OllbtELblJ7t6eTCKwbvkj26+bqQWdS1pkjFaQUoBtGd7n7UPyGI3ipUmJGtvEZNIW2Wsit6yrocAxMnLRHXaAHvo2pzcOM45+OjvO5qK/C4VFxqlDpEB790gYOQ25BmUleEnICOuhqbb049WgMRVfQeq5+UNiPipJOlNJEJl4DP1SuUO+uib7L8crbEK7ApWncKKvgeUFRH3qgmBuQlkkSVqZcVybx+HUHMsNLWp/MXc7AU/NZjCzwYeoDgtcAGrBj6WKkfREUZfIepL5uWkdJseiSgZ9+riIEmL9B17FE5MwzMmKQmkV1Abm7yD5w8uYxe7E3x18hWt9y64h7kNkWutxmXVXhjDHe5734fhLatUxlQTmGK3Hh5b1j9RZlPWcP5p5tpp0Yj9wNOFogC/Tv1+xcvQ/3p3cUQg1/Znej5xXL6s0VwtWb6n0BjRZLJbfFVvbOl6mj9xvgjfj+6ytofmoTYYoRTZezkvyIdkazh/f15O9R+1rFfAA0U7RMTc/bsaA9sN4nwif8DKndWRwfOEdXwYjOTUHwrFOpYCqmSTcKwY4ko+39PJ7lgI8gDZ6mCmxRYYSk1QHIjJmaomnd5KzLr3n7Fl4mnudIe6ixZKwsmj2mBFuY+pXiH88T2Q4beDZNqPHN1Q98+VMxpDx4I/qSG6I5SRUpLbvS6hCnrxE2n
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|5072599009|8060799009|7092599006|461199028|41001999006|1602099012|4302099013|3412199025|440099028|10035399007|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpKSGiA0GoqpAYUcjS8U7aEXodS9asp0e1tcDF2NcB+LmyzKbfHjpgIMVf4/?=
 =?us-ascii?Q?cjuR/ukWCDeQ+qxCtdM0ies3D66ej1gZEMWHm+NVINbNHoOyW/L1/5Ng56Da?=
 =?us-ascii?Q?gWQajbLfmJ8uReUv2S7MJNt6TWaZokq9ldwQF3bPr+cEQaXWsB6BDGcOfhVg?=
 =?us-ascii?Q?WLpmw44Rt2gtv2iUZWZ8N4VVymwpdnUmhQWzJcnXuw+jNSFaHi38rdzbPehb?=
 =?us-ascii?Q?JyLjsmA6KH44nny/+A+LWmunL/zNo5Zw6oNf99tBA62jAodfQUt9kKyc0a0S?=
 =?us-ascii?Q?Fzb2DtP1DeTPzzo+MBS3pVAHHpGvcwEJM4SgRgwnPQdnF7GmTRcQTjvUpCV0?=
 =?us-ascii?Q?oHtCrzUHepz+IyLvLOxbyIpTGuJgY5faq4vhIjPDvBBaxnp6WE8UE2s8mOeS?=
 =?us-ascii?Q?NzLokyjID0CbqZrw1J8NldyRHqgaN5jWIQtFrJ2O4ow5fCYgKK6Kh/TfFVFh?=
 =?us-ascii?Q?q6D7744YFDdPEGkghKItZPqnQlIsYas+1Texk/fMdTJGs4CtU6Lj1NV39Sxq?=
 =?us-ascii?Q?x9lJ3XoBONX3FtEceOVJHbNUvGrWfAq9QSALqQlu+RgHX+tVHWQ98EU1L5rE?=
 =?us-ascii?Q?tTjvwHIbrPhd/O6tytB6S6gTkMwMLQKpWc+/Gmj7NfKF++PxQGfqUPO4PArh?=
 =?us-ascii?Q?Bk5jBQY+HJ9s9mH20r7uvVCKW8uCp2zsm9Clm2quQLOZO/XVO0cbC+jAE9+o?=
 =?us-ascii?Q?SZr0IAmVm3vId9r3yjSkAnXGjwwf5nP+wv+tBm/hLyCe69WOZxYQu/V8mEcI?=
 =?us-ascii?Q?CirL3nuplfaXsniP7QDsd0eRQtGJ20zF2O49Y92AKKvOJHeC0fzxtzWWjxSV?=
 =?us-ascii?Q?W5ABL50vf/kbwpGCPhrNAgWGVcvrTDXY+rbpAQiy31aDB6cANa2RSKapUjzn?=
 =?us-ascii?Q?p+KH1DegQ+eprUpgdVidYADD0Kr0TltJZOjnGtMRX10dctZH2gI1lQ4KmXJY?=
 =?us-ascii?Q?Luf9hAQJJ3daX3eey/OuaFO+97RxNIWFQLxKN30URyEsawcz0wlr2utyq8jr?=
 =?us-ascii?Q?VrF9608Qrpw5Jj0mdHaWQp9Eo9RWAr5hNpwSNQpX6fsq8uShkxL/5yEe7Lb6?=
 =?us-ascii?Q?vqfVRo5nff0mjQIJPnyjRG8r6MtUcD2s2qPEll3Ye9ibb4AtNHUbfHd0glk0?=
 =?us-ascii?Q?q42SdgspHn5jlB4R172Q8eqlRqTklWUrsNgTnDfD1OyKbjtg/QCRE81nn+lw?=
 =?us-ascii?Q?Cl/T8hf5SspJqKVawZ7mXROCjGDlkbOvLxIOl7NdF9vBcy2l4EiUMKJ7ZX0q?=
 =?us-ascii?Q?M9YT0r2ntI9a9dxLM9MyCnrrH7FsjPJmkbNTHrCkXRCB/OaAE8J+KqeiELfV?=
 =?us-ascii?Q?DQVObl7ZRozNnFssDgfSoROioSD6URqu1196Rp63pERlXw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWF+iTr0NrRZk0Ves+rOxuUh43InxbR3pb9V6iY3B5Hte5YJQdDxC3r/x/LW?=
 =?us-ascii?Q?j+zn6oYARNywkW6BLHJ+oj3otVwhy3EgY08acp2SuLBs7mgxKeLkzbirUVyD?=
 =?us-ascii?Q?RA3fhf4Up4CezbJ4Szgoy94rfw18ZpUCQko+awdcD12LXuvmsrXZs/Z/imFh?=
 =?us-ascii?Q?3wm9scuxJnf/H4eIhOQeBvk4NRchfVUB6LTM772oNSaG7uah30KrABStkRoz?=
 =?us-ascii?Q?LKeLQIK07ucstbFFQ+mUlUW0crVyNw//tJ4nIAIrO0sgbiFFPKf7uOT8+heY?=
 =?us-ascii?Q?O/bR8QOIvpicmFU0u1RkSbYRwiOFLsEt3D/3Wvcfv0Hrsycu1GhNTgXauRKp?=
 =?us-ascii?Q?lcBAifBlLSLqmacP6fq6JRxAc4zQ7beOWKhXnRZBXDzon1qNdwR7RmJkHqD5?=
 =?us-ascii?Q?PRRMNt68TwsRjtif+3K1pBNtayKFZdkHioOiLKeM724PgJDaWzYcKfvFo1ei?=
 =?us-ascii?Q?BsebRcSaHpBRf/dYVdMv8W3lkHjaMtaNGgOeqcvtOnIJ4ReCVGyV77O8QbfZ?=
 =?us-ascii?Q?3DzBSN1utLIJe0ie+muqPrjBYwNpG0yuNkI37ffpxHyfKWgE7VQEQv37mISB?=
 =?us-ascii?Q?6Y4TrqB5e9MmJpwoh5/8CE9yjAgUHt+XSqy9Y3/sbMNl/YhUHLDHqJD/oaXi?=
 =?us-ascii?Q?pAfxTwvbWg4RxCri1+CGYW3Y7o5WWOiPXeGf9zoKkXOE5zwHPl4rABoof0X6?=
 =?us-ascii?Q?hSpYFh7yw54tTbT7ItMF/TpqfHIBSySpCrE/PH532ClviXONOalshLvF3W9U?=
 =?us-ascii?Q?50Z6gNUVCQMIn8M2A3c9D+QFPKeiPetmYGFPPKCRPooV9XmT5tDm/cQ4oepD?=
 =?us-ascii?Q?ljdmTOwA43NNaEs6FaEo+iq5/S58zE9bTWthPsdRJ+2I69gQEF8ci0xpsHgw?=
 =?us-ascii?Q?BLjM2FptC9fv0twAl1gPqLlY1lxF1p1AKW0B6nCtl8GQ2J4nwT0WJ/l4Tq4g?=
 =?us-ascii?Q?u6NXb2ouTP4GgXfdMbISfww39thuU51b66Shwu1WwE1kbB5gwnJE1t9tB8py?=
 =?us-ascii?Q?9a8cmi08/f1Svca4BTc7WMJ8E2eI8JCh1IBrUT8TvqGJfq3bpAWUACtjsgqI?=
 =?us-ascii?Q?d2RhXgOI877Suxk1vaTlWd3V0bYIXKQ79O/4gxyYuerI+BafyHSKww12d2An?=
 =?us-ascii?Q?g1egia+xW4esN8U4CzuQfOKUsUQvYBQ5o9syKnH0ANdgSkpSDAlkz/cHEbBL?=
 =?us-ascii?Q?XTc/Oq6A4QfZQ2nnmZMgTkroRtYs1rBEpiPDXrfzUKcv8HuSPpnolGJMye8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e585825d-329e-4bab-cb91-08dd8e544e91
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:18:10.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7253

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

