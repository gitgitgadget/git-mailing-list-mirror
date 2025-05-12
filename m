Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7C25A2C5
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070328; cv=fail; b=PVF4B9x+tv0kf+WlOVvsWhpfFouaoPQUS7FUFXYZd/lpzqfCeckTUm2mGueeQMDCI8nhmmQftXTcIELTzEFW9+sMDFuMEY79u+QgkT/z7ZhOCQXkuAOR1QDP/2yo2jOMnNA2QXYFzyAU6qPZO+cfL6Pd3YL/OuXxEirW/WEGZeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070328; c=relaxed/simple;
	bh=KKCteSIuI4RpNcurphjYr2DOzMLu67dgMwDBXTlrGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8TsYx3gK9w2ItPRi4wLjIGdwILYcNc6LptI1r3gaw72HQnnYtSyefd0DY6qiXcJmK/WfSsRkKMUwA6dGYLx5SxPXaqp6DtipRrppwSfBMN3JOh08KoV4GYQGz+yn8Z8ytitGnEHRIaRYI/fBSCp7d6OBD3K0JlFfCM0Jerf8GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=czScf1O1; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="czScf1O1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/7YkEon6nM8gdcaMBQ5V1kp8g2L52VnopoC31y0qQ2X7JUEmpUlU8+IgF1eI0EYHfJuWNKIduFibKHiADXzokO7u408ZNez3giomt5JhEEogp/2oUZUrUS0YSi4ZXPl4OtR/vSqzVjrZmBbyDUSWReqZZj4cj0014QXEP/vUFWNtw/Tt4r8GSIk2ruJuu+PieLFqZHIKlmB7QlwEXJwQnm9wlzj9l5bXpi62wTJgC1kf3V/jZR0DOoydrz03rS37lOOfDivbbIvJuz6YtfToZkvZ0iZ4PQlCRR5mzR0SOrYcXmgjdGcgnUqal16MLuiBI0qpPNNP/JCpZevSOHvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0DGFwuzkKBkZiauJpR9HfU2J0YiJ/z0SoiXAjOCBbM=;
 b=s6UI0MefgeQZJSFoD/ri4vD64eC15NM1cjbCldcXXyNSECT/sIvq8KWRs7IbkQ6EgP/csvdyy/grxrJpuRdmO1S+WcOe2QmT5U3jIUa5q+IcKXxeQmwwL+2u24wKSBfRo6EgFF5JQNc7+jkqzp1dnjCT0z8VLVlQ3Tfkg4Wv/qnM7vikujVrXNgzh0S2kdcCTC3AO7kx6MwKdXVMtLRyoRTlkjUuhPM0xP8e1l91d17KMCJNWPbYCHxUc+A5GdtkXBBdOM9y27b+tV+w8ys7a2OCi4IUxBpJ2ByE4hRMQ4/dI/cqFNg1EjzCAKmRcACfL5bk2OBJq5dsnprljgRE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0DGFwuzkKBkZiauJpR9HfU2J0YiJ/z0SoiXAjOCBbM=;
 b=czScf1O1I9fE3ojTEAHoKBjnsXQYkQGAv9po4JD/jC2iZqdTX2LCZ7B0x+yROQBaCLFamYAfrDH6KuDEiEJuaBCWCSQAId3XZCXy7qaWXedU7rA6f5HC7wjYNuXUEcw3gX2b9QZAqKkZV0QbbaVcJQDmv1HCRK2C8W2Z3QgrGLJcv5vTWcj+2O65+5XV/WDP7vxhUnp7qoRzsCD/mCDIBt7zBCpAkSG1KOMGexAS+OYsDbQOTY9BeBLEgMs5d/K5rGx529p6W5LdmcNLkoVp9qL8ytbnQcYTxOBoHWTkol1NHGeSyAZTL1c1aRCiT30kkjgCMzAww1wht12dT/jTlg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7262.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 17:18:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 17:18:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Julian Swagemakers <julian@swagemakers.org>
Cc: sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4] send-email: try to get fqdn by running hostname -f on Linux and macOS
Date: Mon, 12 May 2025 17:16:48 +0000
Message-ID:
 <PN3PR01MB959755FD34845EC9026EFAA7B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250512171647.14525-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2d3a54-6e76-4b43-926b-08dd91790a89
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQkIb+q6ygzN9Y2Hj/nd9HxnRglps/T7pnq2hHfwW4dkTDXejJI3xr7xEH68xpWfyABnTY33V/xts8T4gAriXCEvz3MIaWQmcHlZY/xs/23xc8mH2YDiItt36a7Ljf6IIx867DQ58WZZjH7aQPpM6Y1IEvl8j8cpMGHQXsvdUQJmBOVAuMevlhU75t1HTo5xYZDZPbd+hgA8yFtXAwhft1ZgV/oVHmf9wiaRp49QorZP/tRFsAdBnCIKCBRn3NUP+up6pXWxqGbm3dGYjYUNVcwzoiE7nLKC9djke2yOkpoNp00Kl0/HQmfxqCSGsnvYP3GxMISDPfmMr5esFUxkPBvPbgQLOvJHeQQyN97DhTuIfrdpJhN+CsAfk4BR3e4d8dREKVBhkdkkFyAViEqSLeyQugqhNIJLZsCnSh1O42S3KszIWOohz8XIWIfWOEQDE0ai27uTn38uuGhiI86hldbaPFNnVfVJtxlWb21VcI6VSgOdF2+zjYwA5LRMHRfJAe1Q8ketHiFRJ3+rHOySYaZdXDg2SekhO/SDZuUXXKp3dCq7Sp0gZJ+q1B3pdQe4a7r/8tclinF8aEP2G070kV+dJ0lggV7p6aCxomSJW7xu/03YxL0xvqkwVVnLEWn9fjy0sA/OUNCEnWJKcpWg2ryVzyHp78KseGcq1LjlaZXDuakaz37BMY3H78qLkl2eEwHmvw6VJyXJpcPZiPIZxXQ/C02h8qM215Y+hhvc+swp4Kb76VciAzY51w2lugccYEeQBCpy199qek8Q+C6cBDfqdjLeiuKCaT3/2yV4Ruv26xJk5b4WXiYZPwmFaSs8V1eVlIW2hWr5pw2t7193yUSCw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|8060799009|5072599009|7092599006|19110799006|15080799009|3412199025|440099028|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vheb1Y+Wysu23Xua4RhpJecb95/5GC7wpcaPl4rh1V10TkJKpyAceXNPAbSS?=
 =?us-ascii?Q?piKioEVww1BI6U186Sqh9kUWMw/V+a2BVRfiC3yUWD1CHV5o6/7MHdFjfvhE?=
 =?us-ascii?Q?/DDlOdXIaRxLNupDoff8JEFIs2Ws5ODm1YZ8o0ye13Ot7V2tFAcVj7GxEBxC?=
 =?us-ascii?Q?jCvI16Nc7zEnigDKoUYZIAHlND0137FeypH8zzRcIUJTyVIjYnCmV5iPrsVX?=
 =?us-ascii?Q?2ON8w/bbywboSgYEfqti9UF8DMwbmf8UUdLNGbKjoT719vlQigCEw+O8J0sR?=
 =?us-ascii?Q?zfUK34JAYKE7LPfOJIsKp+tszeWEnyjm5xlhKf62llB2wqhPtwelf3/yieOA?=
 =?us-ascii?Q?Mr9MAXrURozlqpHRXmDCuy8kFHjyRnxaShmZk8HwymgSR2Y4YLBukb+Sm3Z6?=
 =?us-ascii?Q?CZ5H7KMO3hlxBFQBmL3mhjIvj4ZTZ32NAWhU48Gjgm6I0Vrmc4RETMyQcq2h?=
 =?us-ascii?Q?8iiSOAjN40lBTH1LXVXn7g0epbPNv6nfKwg6CX/mzPMgESoZB+XPny5ZKmec?=
 =?us-ascii?Q?4qXjVNK1g85LIPqR54P5IquCdOrUzPx/BV+Oce/PTtX/SPAuC8jXSd6FYgb4?=
 =?us-ascii?Q?YUZl1/7BYlCONFnceWz2/cOA3g9eC+ZKkyhuHiazOJLvhA7RJ3rw7s0xJbTO?=
 =?us-ascii?Q?bCrS7ldY9f2/q6YB0JVSChzq6Hjl6h7u3ookpqkkeJ7v4kRwyKYnFdWmiFuG?=
 =?us-ascii?Q?/XwmxyVvnUuVtzCbETXEI0b0Pub6GzrEUNRwlFhdgVybey5bzeKSTwmyaSGF?=
 =?us-ascii?Q?0HJAmKczhPPtXyp2icWj5s8J9kLK/PZ08fCZnS0HqojfdkwFNV7lsE7+dvuK?=
 =?us-ascii?Q?5j3XHg/ZuvT9JdCCKMfS47Wjz9sBqHp2CGu1+DRjsDGez7xdAi/fFe/jrGYW?=
 =?us-ascii?Q?aJoJMIFmigM1CLsPu2pbgyCCSg/caOJn+n+XvmBBM0UfRmckJbuivSS3tacP?=
 =?us-ascii?Q?x6IZpDq+a5Bj2g0CYMpfZA+3FC9FGfJIKCdG/G58wE0H3cqFijSPiBn7xX9g?=
 =?us-ascii?Q?lMxBtT7VEtgYZPkmjD4f7qyaKLbpnSvTE9iiS7Pxam2IBoF5Q33DnTuHPTXP?=
 =?us-ascii?Q?WjMsM1CPmIPTv//bVuYkTLO2x1OKlnOfQhPIqqmQmegOlnLAnQYcBVP2YZBj?=
 =?us-ascii?Q?pdJsq2erc/BMMHUOMAWU0d1d3+vSd07EO7VVUoPik+Vl0JidJARLdFXqWZa9?=
 =?us-ascii?Q?1n36UpePERntAFLGYC45BUKaUgumIoA6eLIENB3UAtWAiEU9nt5yMwHaRPs?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y26LJcO7bdOmXW8tlU41x7zPaShnxrlIzPx/FB2NbP1WqTgI8o2I+X7bCBg6?=
 =?us-ascii?Q?WWLleEr9izKX43Jb/psFB8mT5wBSdfwCgh5IkhElGxlBmsg2XznG+LAJBHvq?=
 =?us-ascii?Q?b+Lsgvvc6VS3Lk2J54ONOj1g+pDGCxJgOMW8jvymw0BBELKUnwhcL8sjCEsO?=
 =?us-ascii?Q?s4Vxitp65/89WiKZcwZuUSKTkfyM6HjVQcBDg0QveIUsNIY6YyOSBq+u8vuR?=
 =?us-ascii?Q?vcMwNm696egNYz9LhhLju2ILWbdHc6+2r0UqotoNrX5ijW6lPvhAIkM+am+1?=
 =?us-ascii?Q?5f0bKLfuuvAy5HPAkwLxrRV9SKzgotA/abOSeVW3BH9I7lbMzwQfXy0hUpZe?=
 =?us-ascii?Q?/EVjYkld+1uQ1mi+yJ1oaxWh8XBm3eCZVHnqAdIMZW8ItCaAuhVw8MIl5YdW?=
 =?us-ascii?Q?3Zm1xVpD0w8x/RAtbTHws8iIzapPQRM9MUXMDQvTdRFP09iHgswQirzj7gOi?=
 =?us-ascii?Q?9m31rI/UqLrNYjwebh9s/ccc9wikO1ErURFuG66Tjwjq3WXs3KZdjMz20A50?=
 =?us-ascii?Q?eGT59dkq1G4ACxiL1PfCV/G/VO7tfHbanKhsJ1AusZ/C+4ZI8yvG8yYT0h9t?=
 =?us-ascii?Q?uko0R8vhOmPhKmUXVY8UidU6kCHF9t2ShZMh6JfbB0XQnnBNkl4MIPC4dMXl?=
 =?us-ascii?Q?GBH247avdSdzvidtVeS9TgsWd4nY6iDlpX75z639DIi1vKcDD+gdYKBDstk2?=
 =?us-ascii?Q?fDppDK9TINrTpwRCHP0Q4hIrAlPgqWOBjvWSFXFvogNzIwL8R1DnnLwDVG+I?=
 =?us-ascii?Q?KOJs3DJjQD1iw2V5jmvEERS1GS/GfSeY+lrhKcAyIQDM0vMmOo7K5VONLov7?=
 =?us-ascii?Q?z967s/dv7UYh1wXN8ijOUE3vhUIbvyxKRpfc74dawyFv8SF1AW3QyxKoQO8U?=
 =?us-ascii?Q?q5pC90uTfDaurLd7F6f9SX2h4I0f4YWDeTYABT8CbVyBKcBDH+du4UTrvQsv?=
 =?us-ascii?Q?ZlRh10EVQ6cF3VVRUtyWT/MCuWQfONPI2yKjOCth4XYJ6tyg3e89oCLgl3lB?=
 =?us-ascii?Q?Sl7EoX2GvR0YvEtiBMg6v/ta9nqw+jrTecp9nDee2qd9ZxPcu+g9SzewpC78?=
 =?us-ascii?Q?fR+AwOwt6I4Cv04cYkcRzQFezBH6Zat9wf69sqsX+jx9b56T7a34dJkq5U4u?=
 =?us-ascii?Q?2+GUAlendnufCd63EKuvcy08FpTgpzmHssUM8YWqLZnb9kCe56f4l3YrQJNW?=
 =?us-ascii?Q?idveeQFBihOc9KL1v/std/YeiRS6pAG6Bb9kcXYIeSkMl+Mc4Pwgwpj78Jg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2d3a54-6e76-4b43-926b-08dd91790a89
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 17:18:41.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7262

`hostname` is a popular command available on both Linux and macOS. As
per the man-page[1], `hostname -f` command returns the fully qualified
domain name (FQDN) of the system. The current Net::Domain perl module
being used in the script for the same has been quite unrealiable in many
cases. Thankfully, we now have a better check for valid_fqdn, which does
reject the invalid FQDNs given by this module properly, but at the same
time, it will result in a fallback to 'localhost.localdomain' being
used. `hostname -f` has been quite reliable (probably even more reliable
than the Net::Domain module) and before falling back to
'localhost.localdomain', we should try to use it.

In this patch we shall be using `hostname --fqdn` command on Linux
instead of `hostname -f`. This is because `hostname -f` could output
something else in case a Linux distro uses some other implementation of
`hostname`. On the other hand, `hostname --fqdn` is not valid on macOS,
so we shall be using `hostname -f` there.

Interestingly, the `hostname` command is actually used by perl modules
like Net::Domain[2] and Sys::Hostname[3] to get the hostname. So, lets
give `hostname -f` a chance as well!

[1]: https://man7.org/linux/man-pages/man1/hostname.1.html
[2]: https://github.com/Perl/perl5/blob/blead/cpan/libnet/lib/Net/Domain.pm#L88
[3]: https://github.com/Perl/perl5/blob/blead/ext/Sys-Hostname/Hostname.pm#L93

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2: Avoid chomping $domain and assigning it to $maildomain if the command fails.
v3: Use `hostname -f` instead of `hostname --fqdn` since -f is supported everywhere.
v4: Use `hostname --fqdn` on Linux and `hostname -f` on macOS.

 git-send-email.perl | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..bdbc7f8149 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1393,8 +1393,24 @@ sub maildomain_mta {
 	return $maildomain;
 }
 
+sub maildomain_hostname_command {
+	my $maildomain;
+
+	if ($^O eq 'linux' || $^O eq 'darwin') {
+		my $domain = ($^O eq 'darwin') ?
+			`(hostname -f) 2>/dev/null` :
+			`(hostname --fqdn) 2>/dev/null`;
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

