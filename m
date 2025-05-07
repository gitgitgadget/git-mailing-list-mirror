Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA11AA1D5
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621448; cv=fail; b=bT1DqFyBXtjlnfhTza9Io4pFefN17UULdB0vU2XkM6PGQCk7aLW37lgqz6ilSpKAthek3hhiAR40wL0VFm3yUPSDPuQtXgkCOcNB+VRwV+0YL9JWXR4UfFNfRV48LsSij2jBF+rsgoCf5xNntVY4P7bJrUTqPxF7pRWSQ7MIKg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621448; c=relaxed/simple;
	bh=L3Scsn/GdSSMkPzbO1BkUINOFNM/rs6+QJbxGKlDfPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RU5mCsBuKbZME53dCsDMWbXmT41RkHXjcBtBXPADfSFkUMPgzA9V1xWX4RD2lfUzLBxgK4KTtdoK5G5HNnRXN2cOMCBaypvRjIz61HqvvLD1BKmi0IlZFMIG9r+zcZaRFu5RO4oxt0UGOb/0beKBqp6fjrsnJ3+meJwWm2GtK68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gmobU40A; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gmobU40A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqOsJ1d0Gpuu5QKPcEMBChDRTBAsvck7fzrelxtr4smE/wMTyTGYQGo+8HfJlWxQ7SloLpBdsC0VJcGyHzYvv7zvKJSm8RHjUFaB2fu7WT2G7VhrBjZMVGZdG6r+yKujtk1zLyeA4/MVvrA3KFY3S3JSxiJBQCayMz/ZTblRYqOK5j/6NaJr39wE1U28fKVjS2laZr/88Cpi6IH1eKazCMAJM0vwaFzsFf5xxzMVD1McRLtjP8DhMKa9l2gy1rfsylpIHsK6B0P+I2quW8D0dHYotOrifGC2JLt7UThnOYLfGRFlialUkZft+rMNX7ggyxYTA8DACOMrP+i/RzfUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzcCCvtn0JIBzMBvgw/6CN38+S5/nYUGQCODgiIcAN8=;
 b=I0XuyvtD4RgsBPu1EGID2ILbQSujK3vRc3I7ihtLU5doLz7UkJfY8WY3GwJ3AZvKE3y5LdssCppAdZYPKaKcWiVcs7Ob7h/RkUMhlngHCzKjZH5ly6B8M7Vkkl8kH4lgFPb5zBa3dkStuTej+CnzthxhWvl4QyXIT7TAbBR1jqINQqTy7cSbSlp+i6Rz0F8Cz1DCNzCzG/i+0GYN0saWknl3SKlG1QodGYepx4HblE82EKH+7KHQTYn7WHe2ELyWD5Jitxw7+3baZG6sKh5taY2KUuM7aUwroUojg7YQESdeBSzzviYir4YfmeHQ6Vm4v/li/xfaJiikjlYsqZ+MdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzcCCvtn0JIBzMBvgw/6CN38+S5/nYUGQCODgiIcAN8=;
 b=gmobU40AA3qQDM8iE3RHGF4gTTuiuIeaCd8twYlvRkKnH2+Pzn5jxVZRtM/omrYGmjy3Nz7neKiMw5+Mt3I7viOjJzPeBtq+4gIZj2CM6j23PmeZM/w5DCMIIbH/ISaX4FlSEloZuNj+mgiL39zIqDzYaLs9LpjqwM/BdfQ/fdxrpomDv4N9w8/ojCOouTJEyAP69UDaSG3BYIwYrICwGj08ne8sr/nj3cIpcoH8jJnSwhjWln0e1dBSDtmTX5GuQewV+DRtKsqZrcxYlLMOq4eOdRySSgI2C2VuOqiTPw9Z6nBfC75hpuroGjPGB0q2lasXK3fsV6O4k0kQtbfReg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9910.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 12:37:19 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 12:37:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 1/3] send-mail: improve checks for valid_fqdn
Date: Wed,  7 May 2025 12:33:05 +0000
Message-ID:
 <PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250507123704.18348-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1427756f-2f23-4f2e-626f-08dd8d63e7dd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|8060799009|19110799006|41001999006|461199028|7092599006|5072599009|1602099012|440099028|3412199025|4302099013|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pm7oAQ50YjDQ4v6Naf+EgWaG8O+IJREwyIYi0OWeWt1tHpxEMYJe1NAjZt5n?=
 =?us-ascii?Q?h4raei5p1nE6QKRk6kfYSSpG/ohu8qPuj3SERHMJfD3GRrnq9Ehl2ibk9Du/?=
 =?us-ascii?Q?3Lfep55SmRfefiXkigxAtRjl/sYE5/+mYbWhj+8GYygPpYAF8mBBDqm/EDdZ?=
 =?us-ascii?Q?B7S2A+DZdw/RZ4q338D7us8I7VcNLXNn0/Lb0iba8xtk7gcNHXyzxhqsYKSR?=
 =?us-ascii?Q?8LkG6VlDHsqST0qGqEF1owP2xeZievkVUZEt+hSsUfAPmrwRFQYX2mMK/u94?=
 =?us-ascii?Q?Fw5nhdognaIidghj8ujwdsDcCnRI3OX3nxtqg50i9HUxom2i57wN7m8DYklu?=
 =?us-ascii?Q?Xxk9wZ9HkFscnrMyugBNCuZZLbuSEaf/XAIRrsXrCUSFeUWIBy7a3n7zWDve?=
 =?us-ascii?Q?FjXybaj/gzHIShyzTRGx4Y9UQFxpZ8tovKauksuxRDV4uozQyMaofAWl5Aq4?=
 =?us-ascii?Q?WwNW6TlvSAWfnTrewADyJsV8n/3vcvNGRsyocLFPeo6o3hEW+NPsufqp5uOK?=
 =?us-ascii?Q?h4xdoAsZ4GSHzD1YlmV88W2oX4S6n1U0u9UMK8HHaU19uimw5XJKPdtYxTsg?=
 =?us-ascii?Q?hCOs/yGH+xG09M+meMCgu5fIRsPrayV9jBOu3Gvp3JTULZQkbwuhrFSX0sxQ?=
 =?us-ascii?Q?41tj85n5Ep3io3TKuGQ6NeanRfFFhhUsUofyAIt7/Kn8GGaKByQZmgmmYNMy?=
 =?us-ascii?Q?Pr2H9dTFKQGEpe+1tHC+EZZ4oTYuvhCF4SvY5FOrYsJj7XaC2CN7nyjeGRSV?=
 =?us-ascii?Q?hzNlU1HYGT5K7/qDFBCBliHm8LuEnPP0sm54qJmlUtHYiH1Umh3opD028OdL?=
 =?us-ascii?Q?FxVvyaSJMPI5nflGadUEZFlumvR3KaVOQQ89s1qk2kW3OE1RcGd69HkJm0MO?=
 =?us-ascii?Q?F88D3yTqk1zDLUHTyuIcfJssEI5g2+xcp2+lfy2bSPQydB9jwXAmEeXO+pxP?=
 =?us-ascii?Q?HQfVHwYAtN6svhwwjj78+hAWPc3jtuQwyFI3ZoEkuS2Hi8+j5WO0p3roViPW?=
 =?us-ascii?Q?sHe4H6/3PQ5brfV3qPv+j1Bfm6RKKGqqqF2RJdVd3cGtl2kqFCiUQTsvT0iN?=
 =?us-ascii?Q?aTtoWHFFxz87gEp2ssR324aFN2vLDH4UROAa6/SKuUEAM/pgPRQMcyeqIFl3?=
 =?us-ascii?Q?rFK4q7x90GTsj4zBBEWJdxcCFMXllbVcuiPF9Pfbkajb8lLwUscvMufNUvrq?=
 =?us-ascii?Q?e+VepKJDcRvBEAS8X/QPeXTfa6MznvUTfKSfCi8j6aaT7Q10vv2cmDkzHTQd?=
 =?us-ascii?Q?Cb+GQHxT0y7S74l9XDVk9Bh3C8mAgeaaYgNhI8o4jqkLrFeEaii0lIHrM/n0?=
 =?us-ascii?Q?GcQ1zQ2lNnWu//OdIXdEUzLTVThjn6k2nZWF6VbRiL1aTQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smepbqbNeIwa5vj61AP+HIIB5Dkuej6M7uU13tME1QE3K1NCbv3DZGTIfS+P?=
 =?us-ascii?Q?5fxH0Lq9AVwvfKM2DCrqTNR4pq9f1iK6HXyzG6zr/rq7w7glzTyWamFOlISu?=
 =?us-ascii?Q?kGVZVGyYzxw8kO8iGgCURELvkY5o3bXWTZ5t2J/wegfgs1aBOR5dqaUJaOO9?=
 =?us-ascii?Q?LBduDHuBtPQqMihDRMBSuK4J6DzTlUu+oH7azlh3/Eve2vs8c+qD/+bAyuhY?=
 =?us-ascii?Q?UrEcqg55dG4NGjtJ4q+iYY1aTKNNpBkNG4WSVoJHJF6gzzkYyRBzroJgp5JZ?=
 =?us-ascii?Q?Evpd5Yth2Xe92b9TXu4H8f7fU5n9XPd/t7IU5CWNPYRqCdSXn8kPfOlzr+PV?=
 =?us-ascii?Q?aH1vAqEtxuDMfqSzJT8vfQFy39GYRm8H48hdax/kmBn1jv4KLC8Y1lrvstqR?=
 =?us-ascii?Q?H8rQVxdfBCMUlzfwCdGqtcgEPL+ZcP7gZbfsIuUuyWJXpeADu9BiC/m8Ys4y?=
 =?us-ascii?Q?kHgJYTr47NsWtbLPL+0ui5vQcNZ43hcRlTtx4So5aFQQwr8HS4/zeOYi6BfA?=
 =?us-ascii?Q?M2um3ccyz0O1oMvFAAWG4CrBf7KfKts88LvR/LC6NnjzndnMp3s1IfPbchk0?=
 =?us-ascii?Q?FP9xFtdIMu+b/TeEdgM26rSAsOMNLWYUTx83EnqBGH7Enkj9OLJJ0pjx8stC?=
 =?us-ascii?Q?UYQh2+Li+pgilcli0Sr7e2T8folONmDycfdp9BF9uu6OBzuBy9w4jqbIrTy0?=
 =?us-ascii?Q?l3Bf2KvSh/ttxfjiD31l+nenf6pEF1c1ISWvj6MyBwO6r8397lQ5lZEed+xW?=
 =?us-ascii?Q?4B9WVGUpl1OojKG4LYNCmJgYhHDa99MhW32W6rN2y3TJasn+t6l68AcDpAyB?=
 =?us-ascii?Q?4vqTAyXKv/9ljnGjkwfcHsEEiDPy4znWHKoO3Oo+AhURX6u3wCIsV8dUxKVa?=
 =?us-ascii?Q?YPQYwLtRX/kXt1Q0Nd0MP+FEVnvSlwWzXrOpVsF5m9M7Zcd76UJA8o0k5ny3?=
 =?us-ascii?Q?TbnUG+w2m7Mql8d+FYDAbApmiC5Ci6g1U+yHRC7pj0yg3QIxmdTRRIZijaCn?=
 =?us-ascii?Q?3g5Vu1I1qmNtG9jTgEYvK5Yy7MsteXlj2YpS7wXQ+fGNQr63NZU8YY0kcWR0?=
 =?us-ascii?Q?GYJBRsaFJ2NJmsDmORICOxDmFHXyHoZoIwhXk+pFdm+2jpUMssYK0CHJaOvl?=
 =?us-ascii?Q?1qamBFpHI9jF7VuS6cWgswhC0G8MGk6XlgHQJUHjzLJljLIFRoWOHdbp6s/H?=
 =?us-ascii?Q?B5oC1bQ1xhpAbrfDckzHCMSEfpdijgJ2atBFbloFhcCk1AUp2YI5DB7ur8Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1427756f-2f23-4f2e-626f-08dd8d63e7dd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:37:19.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9910

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
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4215f8f7e9..17d26dffde 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,8 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.(?!-)[A-Za-z0-9-]{1,63}(?<!-))*$/;
 }
 
 sub maildomain_net {
-- 
2.49.0

