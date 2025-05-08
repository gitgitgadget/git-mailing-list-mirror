Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4D221714
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700459; cv=fail; b=Y+CKXdhgLAgHdMJIxJ5JYjfinJvRHWIPkP8hIRK8oc/RK20TBvjTMYrocSqi+oGt2FoUqqgBA7R7Sb6VHmLyt/uHOB29lZHr2wVjn7+ptvPHPtQOZEfcG5vqBy9fJT9d2OXKXrtGsOG2FACM/AOYqjqQrBFREU14ZgqL1EsKwBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700459; c=relaxed/simple;
	bh=+A6Ccsjg/lGqxlJbXgNL8JtRo+xlskZAe2UizyxLiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJ8G/ylO46JkVcmcKUT0pSr2uej4vriGTr2ZNBqqFSwXErgMSTlGaGGz9xjG6Hlo+N71c4H/zJ9Yk/MTwLjKr7v1kTQN0o8QUhgtENf3sQzXPLmrmNM5cpvbCS+kavkwfTguYIiniOThGsVOXFQWOJ4aGLZCPo8ZqMJi8N/KFus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=n/lcRBpJ; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="n/lcRBpJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPpwjmCdkeUXUVXIlBGsO8TROMDUNTb30+nH3ATd1itzDZ3Owo9feave1gDohoEl/mn8hRcGVYpsTFUu6eUaKSAEncmtpi3znTmGMIR8NxbFINW0lvJVtqcW2fTtBbN4ROIr70e25aJ6P2munVJuc51OZ6qFIqFG4c2mAyk8g3nkzKSRl0wy71VqrDq6QvUCC/NEly+diSOjvJ9DhrPil3q2rWQ3m/aoIPYVvkErDQbL8fS9WXjCVL8his/V5Mjn9oRlUTwvcFno7/yg9qn9X9FIPhw9rvJaWnsUPnIG6a+vuCK3OkjeJz2BG/86ANnFVDxju9LpHCn+Gqo/7zxVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=vPuUl0MYewvPA21/ULomfKBkBp7PRXeaCUKnt+M0pkIuN/QW9v1o0naSFMAo32mYZmIZBv8ljoEevfI4BAGwY1pnNe/O33ccP0h7mXnqnY8UtAJvJAouRzH5czC8gKaLL1ZNKE/9FItF/GlFjC73SLxnSBZjJhWCtEdmFg1+QrpD3rBjn6AzfBtons8kvM6hNhneZv7K+1ctH2HtdeRNh7UuinC7Sm+EZ65+cVi2Z62b39TDGYPGqOYN5cY7Nrvuo1BVKWWg0lsYSuTJ4mrPLujVNQr7WaAFIsTWDk1lkQgXmTEwErWpgjbTfEDrfPSje4ukYJLsfDPHveVKLoINDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUkydggf1TkQmPlfi2lXMoQ+5vAkdhaXRECIOyFHZk=;
 b=n/lcRBpJ9UbxrgGy2vFYFwl25E6Q/G1zV0htAMobRnoNvEOAH9UmhsXo63TfesmPu5pJoREl1ABDDrVhFhNqLk7kpRBDMcXbLZYkVY3eeqgqJpc9avtUtcyyFIeEbrvfLtoijQ234JMYJacELTS8qyHtCbzbb7IoMcSRz16/UbdgTBQDAGFyhldG9PTGWgjEloAgx9I3nE/ayAeJIR3MS8shuh9WYwWcQcjmTO5HsBg+c36aK4CwUlTcwcbOHPzh0MdC2f5BMRTn8PNkykK5xPWmAdbcnJy450bom7lHpjYDI7jMR22FU6jVxj/pwUGviVGW5gpXFPQP5WBYLAax0g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9409.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 10:34:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 10:34:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 1/3] send-mail: improve checks for valid_fqdn
Date: Thu,  8 May 2025 10:31:56 +0000
Message-ID:
 <PN3PR01MB9597C59F6CA7D9D40B09966AB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250508103358.15409-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: a84dbe73-0ade-47d4-ab08-08dd8e1bde09
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCovr/S0ACg5+jIvVMM6V5NJnQlH9OAa7yVTFDMtPZ9GFYpcHERWosmIUwfcmCXEcRgmdW1wKrY7KDkySjVj3yp1fnB+seldN/xlG+1YdZfG5WwOgdQX6bbF7fJH2Mpo35TIQDhBqTCbHQQztV7sWxKJM1DNr1ha8DiL/2axv19qaC4I957bqTln4LtR4Kyyz582Wgn3PZm+Do5sb4McRD4dde5dQBMH8cvqoqT+G/n3PoQGK09byEEL+9Jq5X/7qJszQmM+ojupk6Z20Xj3O/L0XFxaZaAfikdFptbyVmVx2J+s1nAcHckTmEf3vzBpZtOAeM1GkKK4VCRo3k9QB1ZughaHDfcGYpnuWe0tdVZBbwnra5wQ7WH7+lsMhySS+awhUBvoMKbvaghcTQqzyeA9iN/lZ6DsF795hUkmImoWMnTEfFNCaGGR6i4jWnq1wHharSTN0PAv9Sil1rJiWotBjtwiLTwrCK3Twx6Oxtx7GGn1Qxejg7x2sgmEX0mV7M9esnEgLBTjlIU/zEupR5JfCXYfMmGR3szpgXx3Xuj6h+GhzCM93EnMo4mtG8a3Mev4WirVDYBaVcRyCrgOR7dTmrGwkkCOGBvGSQR6N6mT1ijLLnVokyYr3428gEfHvu/4+/RfcDsP5vlzZd2JjyQB6/Qjwp0KJsgwUTr5YScSvrA3kqsVbKayXQiNCjSir7OSsCZzQr9Zq0rHmjImjTkDmufsRxagd/hifWhYYkM9/US87Nw0ESpe3hJXx3A/xf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|15080799009|19110799006|41001999006|8060799009|5072599009|1602099012|440099028|4302099013|3412199025|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQOE3SBSpzfXw4KbRDrI+tV/C8PJMsAKJGHGLVgezAEN3tvx6og2jVOdDdST?=
 =?us-ascii?Q?ooxrZd0n1NYyM/iMYlSh3AEApV4RkwMAF7XHzX1uz9BkucKvSGLl15qQ0Wjc?=
 =?us-ascii?Q?NnK+tbAjsBTqm0xL047c+25zzCdDfgV1UOFlP5dibPfbPfb8f4+IgcWiP2MZ?=
 =?us-ascii?Q?guexbS9f3lr32CljECsjXwRxUedsFnhZVCTUnrMXSKSjgu/fZ9XO/MLM1lFX?=
 =?us-ascii?Q?2agEDQwcPvzYRBXqg386q/vKfcu+vfoNQ/2Nqs9NaG6tqMNLQOoU3q9+TN/+?=
 =?us-ascii?Q?Xuw8JLxLrDbArRva1Tb2yNDhUKPKg9R97iFY6ReI78D3KANJ42n9xvWvhrcV?=
 =?us-ascii?Q?gXcpwqm9EfpABciZWdmZ8O2GdrdneLw/s4YldyFrzJ4BARz4EzpVW9edpt7Q?=
 =?us-ascii?Q?taadXvPfJa5nHeCa6zAF3EU6DbPwCE+M+WM+dQYs8zPPYWzmkwAoQfn31BsD?=
 =?us-ascii?Q?WofI7dva4O/2piZRJOaaMLTPGT1ktw1L4G6cHIxnjdReeTEFK7BrVhpyplCe?=
 =?us-ascii?Q?fH30KI9Is2g7TF1CTcfbisdTzbmOQhvoOaXRwKS+IslIzhvRwqlNKhp6Y9OJ?=
 =?us-ascii?Q?lFGEH1pLwYh53YTjHhnv0VJORhklEAF4ZeoF5CU3LU9572by6v/GumTHN3U3?=
 =?us-ascii?Q?k/lzYmt6Mrks7luYO+kjg8K05wfdIJ9d5Ev7J/1XAzXC0zioWulqKSJD5j5E?=
 =?us-ascii?Q?fs20i2vtuJ6VHWrLawFHmbcHOXh4C7OzXfME+r8pEOIJneP0oCMOZsW81Lp+?=
 =?us-ascii?Q?hBPJVsWyUF2FpjmeeEtw75AlBL+q+F8L70CqCbD8p7RWJxJX6Hi4u24wisxr?=
 =?us-ascii?Q?hU0MF49+4Hs+di9VuZ82uR2/R9fi+05fb8R5BJr7ZIwTFohikKK8g+dUCddY?=
 =?us-ascii?Q?nye0drRpXwgjhsbhLUJhk5wCDeRlxOXaY67sZ9AJoy4vQGPbQQEdz5R1qaFV?=
 =?us-ascii?Q?IXjC4AxFerjrnSl78czLQJS1D62+eFDZ4l+UxARkkyhC82m3P8878iGe4gVq?=
 =?us-ascii?Q?TvWp8mxORVG/gnWK3xpTyhGLbYhBeT2wDEuSWTAvKUkDODeuN4PHo5WrQSqd?=
 =?us-ascii?Q?t2Sl9rNz7PJd+i4PN7ot5vYfB/jHngPhBGex/2g2lMFE2A3SWrRm4oj+dOo9?=
 =?us-ascii?Q?Ry8uCEraxdta1GDnT0zDAvK8yeobv79gx4WAl//ZZzbeM+KbQLIz3wXMwt96?=
 =?us-ascii?Q?/UH2fi3Qd9oAcw5FQ5doBma8aUyw+ZfZ7bAHzTUQ2AK2PcSk4ViFmpNvuvWk?=
 =?us-ascii?Q?bBljDN12ky8gKliQBJCl+dGFZr/4wrkxEl7mH4FEfGzVBsA/R798H9EJ6V8E?=
 =?us-ascii?Q?cS6MAz/1MVVDl15TSnc/NxsO7b3Wm90ZHfZ5KRgWT7ve0Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tqs2pV9pAi7Rftj6vSUzVUCueKO6EOEJgQz/FtLdMmGEDFSNgbn+lO7H1Jze?=
 =?us-ascii?Q?AXW+TyvDZ6bFgzGB5OyB5WVuZIJx9j6uqGFsqlM8sr74Xx3fTIpY6K8zDDUA?=
 =?us-ascii?Q?48/OZXBfTvJrzRD4efAJDL3B+Jl/6DO8H/Qn6x9BM4N0RNDvG6eBamQ+snE7?=
 =?us-ascii?Q?qy3TzxGRm3z6Juc0+64zkF2Rf2oB/6K+QOc12TCwsjqN6tPSv0DT+LHMCOAf?=
 =?us-ascii?Q?butWwbkeBZN7Bn5neITFlV5ANcDJlMYVnyzPLG4Ga+gqaJBkfxPvlwbvJzqZ?=
 =?us-ascii?Q?8PakMClIdgcR4KNqYwo7sMDVpOGpuDvlrESxHpa/t4XUeNazzP7o2q2z0tEt?=
 =?us-ascii?Q?37a2ondg9fuFpvxfDLKlIGhdEGwpQfGQ4eRu1VwF8Mp6snCUoCxUBh+VwN1w?=
 =?us-ascii?Q?uOw13j6jVwMnqKMYBNHrCfxJtOvIVUtjTlYXmV90epEvJSO3C9YpuhvDi5jJ?=
 =?us-ascii?Q?HX8Bd7Z2VBOrmL87xcajO+U5rjJZcFWsBnGq0WnzmFgYNL5jyglZL43ksstj?=
 =?us-ascii?Q?JS9myKL4lu9vTxK++1tygbdcxRpkk003ruaK+9dTu2LKg05AQhJvwf432WFU?=
 =?us-ascii?Q?HNzQ6wLZu9r7Y85NbjT0ZRVD6ye/gm14YgIEU0JWzhsLMV7RrZChag2BBlAO?=
 =?us-ascii?Q?goDwxXzzhdPQAc1g+m+SrVZKjBHbYMfprT3d95uGgH6sqa1lITxwheHCUyS7?=
 =?us-ascii?Q?6Ta+qwgGXhE+p68lYyLgllI7M2167wMmhGRC+WPiazFjSD5nXL2YzQYm1qaP?=
 =?us-ascii?Q?BK87i9+cjd/NBxHARWAAdueEPTG/LLmZVQH5fqGCB2lnXBZ4kbOJCZAC0m1i?=
 =?us-ascii?Q?s5cAen1RewbrF5OC/c6cjHO5EN5roISoLHfo91gJViO9ApLPgzKtlq75ozz7?=
 =?us-ascii?Q?dPcjabonB+V+DrJ5P1H45LiGJqh0cOuYGrvO+hDHrc4lFucOEsBDNCQlNaGq?=
 =?us-ascii?Q?bNEW2op3xU+/nc5KfPvCGoNXZrG9u1C6DljK7og8EHw+3DeqkBQdCbd4oU1E?=
 =?us-ascii?Q?J0jtkqgYlMXWv/X0hRiVMYDhNIFIJO+bpIXpptW1M0KhZyIFBlgSmqzp50pa?=
 =?us-ascii?Q?l/cmQAe2gWGwryLf4Jqh98gBibHgOV9MlK5K1awTOrr4D4WTCv7a30oWb6Xp?=
 =?us-ascii?Q?auDl4H1eASAvAdLQVPSARmhmff+OIT4CDn2/vYcRBnGMNHQ5Pc0zpmgEvaCW?=
 =?us-ascii?Q?hQkz+b//Adhj3E97nzNcKKuqkd0vbN/2r3Y8Ptae5KYYTY0L0RB5d0hZrw8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a84dbe73-0ade-47d4-ab08-08dd8e1bde09
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:34:09.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9409

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

