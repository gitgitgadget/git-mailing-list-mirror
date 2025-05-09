Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94B230981
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809419; cv=fail; b=MA/DpL6S/kMQur19+ljP7C4ugGCiu3Xfcb9j3bs49HwMv106FLPUgvnLGfTYeZP/Mf1bygHbX6vSMZoLMtWiskWdxdM0Cz4vyXCXar6wzIuMt4BoRyLuPSpxs0xjMtvopJyukO1WehAmkxMIa+ZYceay1MJ2JuurGePP8BoEGxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809419; c=relaxed/simple;
	bh=BzZKiN3+LeCAN9mOSneb4zclSQhSmMJ6BGJP61/QoPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8j7466YSCimxV8ET7x3CRp0iYI9jkJAXLdhhzd7YCRekGEL23fqsB3JXf8QsX9g+yajRzXSekmq7z7droxrirJdGiL2wFKmZ/6PvOvg/sG0W2JR4qkQh70ENBWLILSvbQTe4bI1/M3HIeU5Yj6K3ALXy9cXbZ8PzrUjlOvb8+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aZVBDakj; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aZVBDakj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GacfMdn1KuX76C8xfLPp35Ky4mL5ue670wfaxWSU1WhJH96DdTcowhY7FOAbHCLMV4fTMICSIE4tHrb1vRiFL21vjXQDdGiT9v7skJ5rYB/y5oMP+V9Zrfxu7ZxMa0dz3rHSbygeW73K5N29WVEdKOKOFE/Mq06oJ483hyJ/uGUZqBYvfHd6oENfmRoFa1Tz+m/qgEhMdxizButlT3xUfWUrs4jsvr8MKpGH2GOjwhWCeRCGk/XjEgylrFkyoUNyuisLP0jovC14hTBe/yzDi0uLsUvJCbawwnI1keMUL11nd4ZkqTh9F6WbUhsXJhgAQ37ztKe+Aaz91oU6zz9pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lv6voos5JkTVvl3vDafhvD8YkmGTnaF0OCtxRy7jdU=;
 b=ZuRjoz3drTO1XbvUrJGXfXWw4dXRTEqRGpI1Mtyt5R1aQMjkrtRfJ/DRPbXouihZXoDL7JRSP844ys2Q8W309DBMI3O1nRxgmw6J4C5f3xAmXGj+lv2IxzUn/3g/90MKdTUKNaSVcVCCG56lu7cFTcNafnTpr4GuKR6tNkbostkJcaZmzed2pjjK7+4vdBI8txOT1hNOa9DRyAxoGPv6cKGgPzJ4qazUP48Y1vwxLrTp+hxugTtfTylZr8k0t2EQ6WJ3AmbEh4lRs7T8j9e7jkfia9G/e6haxjLNrM8OJrK/A33K9nl14/amUWiS0MykvFUorpQ4S2Xh9OnvGF+bHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lv6voos5JkTVvl3vDafhvD8YkmGTnaF0OCtxRy7jdU=;
 b=aZVBDakjGIp/JVhFTED9ygb3RicJ/Fv7IY+028bTPcgwb1m9gGe2jQY+eflRWGprdTPVpbrtvfo2cwx52CwXZoBmR/Rjc2o16Z1Jj7QuqRHpv5g4KIoiNpWm7II67T8COlm4tAl+qzS1WvJWFmsZsRJYetRA/q7b2k259gpcQQox4C+VyLtlUngejnzhEF3shZJ2Wcy+ohFXwcD7i/vjS/rlySlc7wzVQhZmTgwMfJq4HOTf5OegXVoIVKtWSpRH+c5i/hHT5qfHJ3D4Fc9TcTIWT3FrHz0Ll0bAi9oJNomZO15mu1ZVB/mDIchtwsS9jqYToqLBVzxd43UwDEGIxg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9600.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 16:50:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 16:50:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH] send-email: try to get fqdn by running hostname --fqdn on Linux and macOS
Date: Fri,  9 May 2025 16:49:58 +0000
Message-ID:
 <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0092.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250509164958.4369-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 229be32d-411c-42b3-563c-08dd8f199014
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQk2NW1V8jhOymIUXmW/iM6DVaBnDKa8PEueM/3WYD5vQdZjuSoFWEBeAswWq20y3gSkriR1T/IqiYP0m65LQFYSX+I/ruK0QwTUEluJ74hiASC3ZgtZMHBuPCF+CCaIhXJxamOlmkheet8z4WIItCEFWeuwlHrAL3UOITAi4bk+wnnMuYT8dwmzKWI0J0yD4q4OLXdXbpdpI5G766QOuUq1wb/5xGSkcUoh+3/yD6rcQsQqzVo75vvmNeRzmWa2K9ko0hm8DH6uZ5QndzNynrDf5mBJz4xi92FcurFLG0W81eknz5FWnZQ05lIDIV46JOqhxoe2rGSiGrEKPQPH949G8+JcSceNynRsEXizYQ7bCz0gZLw9Tg6NzLZtWZVGLB14lzhzqrHlsjkBR9C3xZrXcKEuKTwOHdXZ9gSCmk9NRSwPbp755Yz20c7Lu5GvtiXug1uuhKWp72TG9tynLy1Vg4sPvZN0a3XR/q+CrmlWNQRi5ug206gWenbvYJO6SAEjNy1XXFkea4WLRlD1AHQA3CSWUWV948Q8+zQHfhMb4xf7FE87NujBynviIa5mSuNKVmT28SAvUoaNqBZZ40HTJQuJ9nrx1NCDt752TI8CG1uww0D6kXiPX2zRv4TmVieO1X+ow6K4ocgFL/uU8MRr4JuytK4/wb05HRjck/qh+q085CCRV2xZHGRPbPpvt2EhLMp0qQJocJWoGKApjSdG2CJjOKekpmmKxf7n1Ibv9HnbmJ9UP61ej7/dPvC0g8ukxzpNJaL82Eor4C2S1MX2Xc+HRNOA5tSsFx8uAfvnfxARib6DmjBYWTbPFEpZzXVmd+x3+w15hztWLYIaMyocA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|15080799009|461199028|5072599009|440099028|3412199025|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDETq9lkr+LuRpTH3dIq89izOOlYY7UkVjIRlNDjMmWkpucWN5za5AVzul6E?=
 =?us-ascii?Q?PCEBl+63lLmIMIClTzfdNJsQJu3ZkIEEKyHck5Blav5f3a8vk5XpbVL4bEr1?=
 =?us-ascii?Q?KmLVMAbyF14D9m0ovlCym0DSq0R3IjC8whjuHLc8ha2TCV2lJVZhSblLebXg?=
 =?us-ascii?Q?F5l9sJF5KrufTPkgEtnXFabXdrQeewSxuY4m1HtRgGDR7VAuu+OI44ZGoDbQ?=
 =?us-ascii?Q?yfmkk49LSe6BpErD/nrjKV9geLEP/Om8kz3ur3y1/Y05/2zn+f/xz7ix8v2q?=
 =?us-ascii?Q?pRbX8WGLTJWWlgAoBezOP2ZyhIoPBK6cAE//XbEd2gufO1VgvjpfVSkta1sV?=
 =?us-ascii?Q?rv5waGuQ5n6SuvKtOXgWo/MWpHzqaCPOf5Qy6RaeGYlbRLm+2RKjYIc34ycI?=
 =?us-ascii?Q?LiPfIGzKWvbuRSSVOvvZWyolczCblt6h6YDIJVI78BQ4Ji32JxMCdodBWqw9?=
 =?us-ascii?Q?hEoSA7niOL+QAnsmxt9+txJmfTcJa58mSJtbBqhQKXJOsj2pF3ZdenwDrF49?=
 =?us-ascii?Q?Es+9AjeKWvEnXqz3vntRbgR/B4GWLo6smSJh77nv6y3oFha6ueOL57eKTSYo?=
 =?us-ascii?Q?LMaR+EkkTgEnF26YcH59THaFYyZGabRayq0JsOdjKF8p0CuHD/UkifaQzO5S?=
 =?us-ascii?Q?NlwvsfYAvC21MApvDDpqhgITfHfwmh8HOMK80vswWj18bBfy8rugn0A3K3MU?=
 =?us-ascii?Q?u/AfTZbUu4PTBtfUsmEntgHxw9gpSTqJijHi3ckmHQNMxMKAm/4eAe6Qn9EW?=
 =?us-ascii?Q?Rh9FAOr1cHa2zjePyXuEnVQSGrklFWU4xWLc32xpNKoIW8kshgpFJCDFiA6l?=
 =?us-ascii?Q?JWx4aRnFhDWCPeRE8S3lf2x8wUNXnwDUnL6AsLGzUdrRlm5Yt2SwgKVrZ+f9?=
 =?us-ascii?Q?qIoreyDEZyYZxJGCJuX6piLG2O7l4W6Ucu5f4RzlFjXw+1eRatPZHPuBd/yo?=
 =?us-ascii?Q?SnFBRmWijtmI37N3I0BSRNgL5M5gDHV4QlE5JO7r59r63Clq8ru07ij8MrfY?=
 =?us-ascii?Q?zEKuG2aLlJg9DjoOzgQMHg2ryw/Ya9MJUR0E/R6Mz3wJ2gVnilPwj8vaOAHU?=
 =?us-ascii?Q?6Hu2TMH53PBX4YIJfUiLqnkzQfgA+haEx35LnLlHdiiMgNTXIjnIF6xqF+BA?=
 =?us-ascii?Q?Ku0ipotY/UnJKUQfTATIOX6KJgE1aX/erfGWUytqoC5z630+cW1ha0buXLer?=
 =?us-ascii?Q?hKtJE2iF6E647s97FFhz57axjJT17FVLsY810lO18WOvJMBWGW/VON+cfXw?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISIjcMpFVQTfvaWlPXzMdhTAfhAQ8/Azh1IPUtd1J0ZVcXF9bFq13t3ScNkV?=
 =?us-ascii?Q?BeU2JNQAM0fq0UXvo1qtGU9/pkjAGWw/JFJrgAGo3+HYqNZRB/LvEOMsOYT6?=
 =?us-ascii?Q?ZRKnSdMOTjeGRyJcF00QwrU5Td1MXXC7nofCzojztVsqxbYJEhcHH9qSjSbl?=
 =?us-ascii?Q?6L5ufsXGhw1nuPYDGYEkX9PAKhxw+hcr9GxLCI1RTZZWFxvh1ggpMuGaOqVK?=
 =?us-ascii?Q?havmbmYJH6u1keKSvCRUySl/fZJicy0ZJ0fKRp9eZEBXmDqu1rZHko4sQN6a?=
 =?us-ascii?Q?9e5bPVRQItwO9Zt3SChtINFIIAk3QTeDObieiuBmIbJrCEHqMiT+lYYlJml2?=
 =?us-ascii?Q?3ijxfjul8JYkefQx8TEN/59K7lqIe75wlGMEZP6RTTzqzyH8p6rpn78bTXsr?=
 =?us-ascii?Q?FUlxNh1Ji5oBuGPKwT6tvfPyBhvXrsWZFZz8HtUevZM3cZ1Mzi9rASuPi7DG?=
 =?us-ascii?Q?Ou6eKD0cO0xPTyh/DUc//+OrtvfNOnJ8r4MKxBWnKNuCsVK4nPr1o5MU2/Dg?=
 =?us-ascii?Q?pKWShHTL35NlLjP+URWGD5YrmcbVSRU39vHjI7F0FnY6kZn1vRmrStlOXTWa?=
 =?us-ascii?Q?XUOg5EMzjKRV+/3SO1rKudXQ0AwuAhCmjb9dLrWWnD6lRHZF+dgX3/DFw9Tw?=
 =?us-ascii?Q?1cgJ6BrRW8LnxSDApja66vDv/8cCFhfIBk6Yqx7TGgWr1bwmvrQwLtK0g+cV?=
 =?us-ascii?Q?S1Gez1jTJwurZoEnWRUq1IAQLMJ7QguBAItEhpMqMx9QYEt5m1YZjJDd95AI?=
 =?us-ascii?Q?Cu5y0WvelYr/tvMr4lrNXC29ROQ/t8cirN91sHlJPO7WHszH+YXOjWYqu+HG?=
 =?us-ascii?Q?qyFmsoshUUzOXCkI/1Xp+wJ1isKtfBy0daEWTF7nTidn8L9IPcn2dTWCjvKL?=
 =?us-ascii?Q?Rpjg6pzhcIe/cTa2bYYMkuv1dLmXEwqGaM5KCiHLDXlYgoXif9S9QtFHCA/6?=
 =?us-ascii?Q?UGj4zFHU13CJdf6rco30DFnIjZFa1o/kFYFV524QMC3WyQbloFfswZRQfUKP?=
 =?us-ascii?Q?+YJrPfPHlWtgC6hPARhLmq5IztUl9tcVU7Tajxv7rSqqqtBZkcEIEYDy858u?=
 =?us-ascii?Q?B5CQmjc9YCdiZEnwjO13CS+342UPegwNmyERT785ZIWNGChlryuNQrwqzLHb?=
 =?us-ascii?Q?moIevSHwiOeFVunrLQZ4efSLBDn5xTuZsijis5ERVaSPL+Rf9cmWscgvFzFo?=
 =?us-ascii?Q?Pg9OnWMx1dcLUE5X+JTIzuPC2fA2mvYjvISCqvbCIBOgaEWFIfd9wBwCAR0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 229be32d-411c-42b3-563c-08dd8f199014
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 16:50:11.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9600

`hostname` is a popular command available on both Linux and macOS. As
per the man-page[1], `hostname --fqdn` command returns the fully
qualified domain name (FQDN) of the system. The current Net::Domain
perl module being used in the script for the same has been quite
unrealiable in many cases. Thankfully, we now have a better check for
valid_fqdn, which does reject the invalid FQDNs given by this module
properly, but at the same time, it will result in a fallback to
'localhost.localdomain' being used. `hostname --fqdn` has been quite
reliable (probably even more reliable than the Net::Domain module) and
before falling back to 'localhost.localdomain', we should try to use it.
Interestingly, the `hostname` command is actually used by perl modules
like Net::Domain[2] and Sys::Hostname[3] to get the hostname. So, lets
give `hostname --fqdn` a chance as well!

[1]: https://man7.org/linux/man-pages/man1/hostname.1.html
[2]: https://github.com/Perl/perl5/blob/blead/cpan/libnet/lib/Net/Domain.pm#L88
[3]: https://github.com/Perl/perl5/blob/blead/ext/Sys-Hostname/Hostname.pm#L93

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..735d8abc12 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1393,8 +1393,20 @@ sub maildomain_mta {
 	return $maildomain;
 }
 
+sub maildomain_hostname_command {
+	my $maildomain;
+
+	if ($^O eq 'linux' || $^O eq 'darwin') {
+		my $domain = `(hostname --fqdn) 2>/dev/null`;
+		chomp($domain);
+		$maildomain = $domain if valid_fqdn($domain);
+	}
+	return $maildomain;
+}
+
 sub maildomain {
-	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
+	return maildomain_net() || maildomain_mta() ||
+		maildomain_hostname_command || 'localhost.localdomain';
 }
 
 sub smtp_host_string {
-- 
2.49.0

