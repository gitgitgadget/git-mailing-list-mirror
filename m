Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DF255F4A
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037586; cv=fail; b=cqPLaYuEl9iu2lKen9lM/XMpP34TcrOe4dqOf6aI90ilPGkE0xf9IvuRIRa6zdur0Ubq8+gA96E7Hv2zJe0qrY5MvMX0rQoERkjOTnAT5+y+bJfpVgqr0Yai+hs60ylBMSp9gtyFJpYqGTS0gkOnKV2f7+gpV1amgYceRyZ/FpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037586; c=relaxed/simple;
	bh=dJWxHJ+hOk3gJy+iJjETDNicUbVAXy3iVvpfMlP2Iyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCCqavE7BUEBUVjcBNST/N+EjbRmzbwrbosKOk2gyzZLU5tEEiSgNvX8zz3Lzksvjv9kAqcTXclXOR9XKbrc4Y+/1QJxv+o/OrhMYO194BvNA2d31ola+0xLl2TZJTx/c1o1BLOeEpX+TlJSbiOW+pMLrwLg81yQLezyg5KyLpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=skguz4zd; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="skguz4zd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI0MaHnARGe4b1mPFYZZOBU7F1k9a2OToC8A6L8Wh5alX8KIVjxxWnKNaB68BYHHrHEZxSobiC9EX06ewTcbf4YOmoLb01JXlgpQ3eLl3D1nJ9QTyZcDoBb+Lgk7ZRm88kfYlJpr6NX5ATRBHnuqcHMTdqx0d+OEVU2fPzugDgALFijDjpOohVeVqYDtaBpmv6OHEjBRx/G/HYnKCPwoNQB5K2O6cf/Iobg/TnziErgBATGCsPsCNkkrsifQBAPqoJAbEA96oHSNJmHLXUeEMTVhM2s/thaQ5Q1AuQLkwf/OJhXp9L0P0XULzamb5kH2SOx3HFRw/1do63KflvEf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoVHTi96cQ6h3AOo5OXlJsKM7cSvX2OvWUG5IJqK6xM=;
 b=rvHt8okbkgLxisFY1ADwU6pqOe/GJFhJw55jUOM5asFyq+K9a0+w5P8rck2JDNDr/jZfV8fsy7DeQlTbYvEuImBQIlvuCczFE8duhKKqLf1d+eB54hOu88zCKqCIuClHf4aBhBgPRlY+tGut8PH8COjn3Zq5Nh2KpnFjo+TBenL11J7Ca8a/zvYZWxSvEw3/EWY+XkeYiC/OdVH6DW0agReraLnDR+/c6L5//HgMqJimNTsWSYNq69ZSwMckgu5bqG2Vo8nOIlm5Jls9WMWUGOcb5orzfFWuwKMi0b1UZho/lV/WDP7g5oF3OBzIycVzZ0LEKwQJ4Hobcpi3bt7rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoVHTi96cQ6h3AOo5OXlJsKM7cSvX2OvWUG5IJqK6xM=;
 b=skguz4zdNJiCcA0oqSEkLs+bDEDVMyedf8z68nWCtRPWhcJB0ZM9x/Qdsh9FLOPsSw5qFB9EPv73bq/wSjfoTShe2sLLROT0uAq9G1tiy9Le2sQvEVXtWOM8cYziLeB2ZZ/JqRAiCx3zDe4vdvJq7t2qk7kWat0zSrdXvQw45UWZ2TbV8ZE4lvTc036N+Rub42VVqDbEVnoVFUlA6h9Km+HrxqRGIZTq+gOZSm4iq4IMh4/LU0NQuAgIRLDZlJct+lcY5vRkcgd9GX5yGPaCZjdRZKGYFhViI+3+wkirh+Kh17P3EV80qgzpGiy0sfEcAkPwl/Btmd4MU9uQHXxZEg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7638.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 08:12:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 08:12:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH v3] send-email: try to get fqdn by running hostname -f on Linux and macOS
Date: Mon, 12 May 2025 08:11:19 +0000
Message-ID:
 <PN3PR01MB959701F40F805351472EA4CCB897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250512081248.15657-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 470d49e2-1692-4919-e597-08dd912cced7
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQkIb+q6ygzN9ZaBXnEHQ4oU5LZwtuC7OA0K5X7ctYI1aCIGqEDS/DNxFQHfGsDtPzv8zwW2XWt39R2wbEaKf4ns5EHXioF5KzcJ4CE0vs+s9p31xkYqbAwo8zNkHSpF2MhtavSMXKTnJBmrgEIfR7dCzKTL1iuTIxdSi2cTLhXtZk1XMiRcYFI59DkZEVpt9wtfrnig9EL6WAAAXULL35Oe8V/6UIZ8wLduI612HMe7laux3XsithaKfaKrPidTb0HhYSBSGSHyUo5hWvEaLCIl9nYun24v281/KD+oN7xGUvpeNarrGzToKtpaiBEeh4cPtL2m4rEH/BlV6WZ+MuMQdJTIpXvuSiNxmq3cIO9527pAXE/jb/tLeqJkk7+1qhATSCs/i5IU5BORWY8/o1hGL5SSnZJ+XS8aKdkqHBz3hEsQ/6wYqxHpDW6OgLh/CrXDDU0IpHMHE9uXRfMnLoU9u5EXlT6thNp9yZRmEidZq2L4WaHxEQ6X8QE8CCD3wuMob7w/FDCZcM+dcdqMrkw1ViY7SbhViqQtlwYsBCu2UIqlW4Nt/uzaVCcauRMrbrFiftWgMP2ooAq4yld5IvuT87bodTIc7zwS0yEATnuuTDWfLdoAZ4bZ7eBerjsbPlA2jViZzI9NsiaDLkeiVso2s/6yFuweYKouNT1gynqXshNDhyLsnUv5U3yGW/+z82xzjQ5pK4OGgYsAhM/yZW8LYGVkQXAma8O3HEvOihs4rvLVx6EbWspGn5sfwO6Dto2Jdmg3fu/VZ/9zhq9+/ldyp7KWvN40Toq/DAjVjzZUv58ic7S9VPXLabwgjXncBz+xzpUzey1JArSc1OaQJJ93A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|461199028|19110799006|15080799009|8060799009|5072599009|7092599006|3412199025|440099028|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ah8K/1763rNPNhbQQytMpYMFU7tj1Tm1wZncX7LNvweE7Ts0UuqhUU1DgTI3?=
 =?us-ascii?Q?5mitp3A7pKOiXGhU/NDOoP0Pxp0UncPYUTkb/NexcpuUJEAYbLetqUK6Lrq9?=
 =?us-ascii?Q?bNVtNNT5i+dZNdZFT6ad6wsQfqjJaffPwY9k3METQ2Q7Gwm686iOovHWsKnG?=
 =?us-ascii?Q?eV2DAA7973w15SgpvQ6SOiGchJhnR1aGL4cdz1D3p3oZJDy13gwSvJMkkwRf?=
 =?us-ascii?Q?D+sMuwFC9Xd8PIuX8XbEY7uFvHCqajH4ycUZPSpj2HhFu4+TJa/uQjGR6bCa?=
 =?us-ascii?Q?srajpeV73Y8s+en9uuWV5Zvv+ssRpPCi2DBLbuvJ9sPW/IgvwJt9UJDfs2oW?=
 =?us-ascii?Q?ywlviZTHjaXxHbPhKo6XPZabXGpsv2Zwj9tVyH+2/8DN/AUWQA2nTK3WMDlW?=
 =?us-ascii?Q?zll4iEs92F7r1o6bjmMBornSXitDlJ7idKShWP8vMz58lTD27ycGQ12jqFnJ?=
 =?us-ascii?Q?0x64MDsSrGVE7h99VJHwicDkmikyeilTm8gmLgG14TYgRPbzBgsTz0SnoPLS?=
 =?us-ascii?Q?aUwhnF4U+ZOCPoZ5IdJOo/+fzNpYt//A4A1yiqQXu2l7mpeWdpF1Jm4R8zj2?=
 =?us-ascii?Q?qv78X6nojkT2miLsnLzl4MtP9eILhxywsnAuN7xgIxdU9KGAphvu/iFWJuFD?=
 =?us-ascii?Q?Y1ImfdZTDuYM32sZcbrZuubepVRaKJjOH544DqJdo0qd58xEqZW8g9h+e75N?=
 =?us-ascii?Q?yeABXcMJtWYtNkua7nMyp1PmgG0Sb3iSDYsajGZlGJ3gmRuin+/jm/PCHNRJ?=
 =?us-ascii?Q?U99c2w18rFMGwo186wxodhc7DCt1N6O2+VswWTQIbrLfXy1cmhMaN5iKW6PS?=
 =?us-ascii?Q?1SN85NBPK4e5XDsUVpt2dp9gQjH6BN8cs/K/mahMh6bKrY/JcleqZuMrtn2D?=
 =?us-ascii?Q?h1+z2QhWPGMljgSg4cNSNCVwB3Z+u6MVTtHuHIZN6grvkqfg8iVxWLs6fZt2?=
 =?us-ascii?Q?9eI33Yyrm2DnsAAIN4gjUI1+Jo5EPRgIQUKUORv9AOmyusWLSbqAxGZJ45oV?=
 =?us-ascii?Q?QA/jVCKyhW413B6QA/QtwGvOvVyxxd2KejXI0C1HQ4Yyr2L5cy2xvqcYEdC3?=
 =?us-ascii?Q?nb0ia6bvV2XzQ4HteiJ3gsvnNMXqlQO+A1CvEag+n187JahIq5XV5PKGib+0?=
 =?us-ascii?Q?rknf8FHEDocn6a0V2DVDFKYPWb3b5cq84lI8ktpcW8ml7qHCFPveZWOSRi6r?=
 =?us-ascii?Q?atlAKICb2myXanan4nf+eNef2mhXlu5ar7BVmDuaE8TBgdCCaj6FS8Oy3dw?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1v2CrbHH3d1r05J6X5bTnedavTto2a+yzfc8TcFm5B3CDx58NVuaSizZY3ly?=
 =?us-ascii?Q?/cft2pnpfzcOK5bJKy+as+sURGizuQhvGHjeecZYu0xStRWK9PMkYM1ZCUCb?=
 =?us-ascii?Q?oLaN8kULo+38I4c1UgLptPEjrV6krwhCd/ihSR0QsJY/cLzovJRj7OzyVifs?=
 =?us-ascii?Q?4PJ0OgWjU5HoaAYGAw5H9ZZPCIxubkgeXwSdbbZ2whXVCFfnN3RkqraVxrCx?=
 =?us-ascii?Q?2M+qIXvls7aPx2CMpxNY+VW9VBuA8uz4vVoQ1MXGShrGF3yEivpExmlFZFJD?=
 =?us-ascii?Q?6pGDJEBaDnoA8JdEhnG0YH32YC4Nj8wKDG4sCEkc/HcnI1VpSa0KGUstvewm?=
 =?us-ascii?Q?3CJgr4BxAP1a43W2m1F8OQHjhC8MwJ9PFi9BR53keN0e3MLmmJuP5SldNPUw?=
 =?us-ascii?Q?j5gb9SE31Nm0iSK03TEsqKNjCbG6iLLPrTToDI3vq/KgbeL1sQhmGyghHZaD?=
 =?us-ascii?Q?BPfQQ5+F9azSiZj0OYKssQdp+/fO89pbcO/zieA6qiK+Pr8nYFycuSFxnj1a?=
 =?us-ascii?Q?vIZ8/iMSn1o1Ujsf4OSEaNCFLQAsB2iJTkB1XNlKXFvVSpxoLhvWSpA2e9HQ?=
 =?us-ascii?Q?EHu9uc2buRANFSd+l+9IaUQebK3xCjj/ELUAqYKpxrUA3ehYhZNFHBJKSNXP?=
 =?us-ascii?Q?+iCUZ53XIUx6qnCgE5TIPF3Wp6alLAlAB5X9WA7J5mIto0SfELoyHzKlOwl0?=
 =?us-ascii?Q?ds/r3ai9MEL13H2MOjD8awWrbh8v3yWlqyQesfmU6P0g8Ah8U4/9gF5Z7QI0?=
 =?us-ascii?Q?ExLzn6K39Py6ozCB271TCMwRc2jdUTcT4l3/nwGzNsv386ltLkkF80LzG5Nj?=
 =?us-ascii?Q?waImPm5jrfLH1BLj0n0C9X/Q+/5pHrugt23uCOvKQNep16DsJrjr1zHSPWlh?=
 =?us-ascii?Q?zeVAj0U311ts0YaWrGVpJTN27rJuoNhlnaxGWepVmozo3COhfwAd6yxMeJAr?=
 =?us-ascii?Q?LPYomkgO2dWzevX+8rHJKU8AtrkOuW78G3MZ5Ked3mnU/mCpkBgQrrxVq5Mf?=
 =?us-ascii?Q?2yN1FjOPCM3gLZmJC4Gz/lSojmd0JyHznLG1nfRfN3XP8c9zRC3fjzedplkc?=
 =?us-ascii?Q?misNmfEJpHfmKvbrDjtiHtefp+7BTQR4FGh5GOkEUo6Km6LrI7dNGjrAP8xB?=
 =?us-ascii?Q?3OjPEU+RzfM6awvst64YiPSaTFkLGMD5SjiW7eSxGMbSQhJg1yD/4Qu9Ep1O?=
 =?us-ascii?Q?Q4dNCFIzRlUsMQeyZxn4rHzn+wIx3yFTroq6oV/AGMluyGNjsMZytqwCuF4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 470d49e2-1692-4919-e597-08dd912cced7
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 08:12:59.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7638

`hostname` is a popular command available on both Linux and macOS. As
per the man-page[1], `hostname -f` command returns the fully qualified
domain name (FQDN) of the system. The current Net::Domain perl module
being used in the script for the same has been quite unrealiable in many
cases. Thankfully, we now have a better check for valid_fqdn, which does
reject the invalid FQDNs given by this module properly, but at the same
time, it will result in a fallback to 'localhost.localdomain' being
used. `hostname -f` has been quite reliable (probably even more reliable
than the Net::Domain module) and before falling back to
'localhost.localdomain', we should try to use it. Interestingly, the
`hostname` command is actually used by perl modules like Net::Domain[2]
and Sys::Hostname[3] to get the hostname. So, lets give `hostname -f` a
chance as well!

[1]: https://man7.org/linux/man-pages/man1/hostname.1.html
[2]: https://github.com/Perl/perl5/blob/blead/cpan/libnet/lib/Net/Domain.pm#L88
[3]: https://github.com/Perl/perl5/blob/blead/ext/Sys-Hostname/Hostname.pm#L93

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2: Avoid chomping $domain and assigning it to $maildomain if the command fails.
v3: Use `hostname -f` instead of `hostname --fqdn` since -f is supported everywhere.

 git-send-email.perl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..659e6c588b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1393,8 +1393,22 @@ sub maildomain_mta {
 	return $maildomain;
 }
 
+sub maildomain_hostname_command {
+	my $maildomain;
+
+	if ($^O eq 'linux' || $^O eq 'darwin') {
+		my $domain = `(hostname -f) 2>/dev/null`;
+		if (!$?) {
+			chomp($domain);
+			$maildomain = $domain if valid_fqdn($domain);
+		}
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

