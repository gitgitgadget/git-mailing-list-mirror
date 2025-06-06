Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE8218821
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240547; cv=fail; b=UQd2xenPI95+lnZYJmdgsiPzgTh5Xbu/LLB+lVlnkhbW1VDb4EN5RxeokYp/RXrlKg7RG6PFyBNVl1z8KoqY3VnBeqgUTNaHZ2yo0H6xVURjisu5nsJjvP7c2ogNXThSNaGLiyA2c4/mKHZTe808k/JAwp5wbDAZrMhPiGQwoSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240547; c=relaxed/simple;
	bh=vnGKV+o0MPCug1b0nCz5KSW9eULT05n/2eVT4xaTlWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSn3krvEMwVJgb49OgPk5jPXWEMqaKRJRmJ9j47vX0/LKp/1wHSzP9Lwnh9mUXKRrrqZ27avmsG4KATHNjOCORpO2miBRwS8doaXOZSNJWvCs8hzjRmlgC7F/0MCDvXrjVTZ6uvGNv6ivhTAY38kAoJvVdX1lrXJ3HxdEfIT6pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CTgEA5ho; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CTgEA5ho"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrbPYl3LPwW/Oi7zJBUVZQZLNw7LheINQpjeuKrK5cR50CE9ugSNz0B7j79JncYEi7nz00I6jVkSG+SX0E3gMIscz6xGOiT76hviLEdlMeA4HIPmBRvxH9xwMW11LPKuYvy5cbQx3xAagYlwQnpFgIdmI3J7vKOWg7ZB/FKW1jfJujKMZqmwZXqaA1q7hY6RLMhCr9YH+syzjzFFVC4BTsISZuOt1A5SSTBpjVGXrSpURfY1ZR9J5CNbmTiPUF+g/v9OKvkir1xeDn/ekE7CqNyF48UoAHFIGHRd6WuKipC38Vb+q2mC6W9BVxGl1DksMqLhNywtCoNHiOWSvn2o1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlb9Xf+bSbPqaGqx3X6k6rlbSwvzYF/nJvoxTZDX4XA=;
 b=BLaF6MojHEeogBHSzajntdSMKJQVlYZkNuVHEM2mbh/rarshFQLa9uQSRwdmeC40pU83Amxy6gbWp3CrXeFoQuF0UzZiFZmNq9bbw0cgjOEYgFVXTDFP8C4eUUQuzQgunarg8y3Jdo5tI/9Ahe4WMnn7PjPlgIHKIfTEQTG+Pj/Ja7oSENCaQW05tuqaayqsLM0gVC+7VW9Q1HzXW38otrAMbq47r+/NpdlvfvHsHfTTmsAD/TXgOiAhAZ/VYEIqF04fSy52K5OKhjRJ7a02spGP/lFxkTg3s+357mRw3IxmSyxNMblBmOal9as8/bG5u/U9P5dgHBQSSBEvMLXmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlb9Xf+bSbPqaGqx3X6k6rlbSwvzYF/nJvoxTZDX4XA=;
 b=CTgEA5ho8rjO9cr1vJY42NPErxcYk4sTNaQxV3IOFU4wdu7sVCfYS9Mu5jPU/bCKJedI83q3a7Y20Kp6tx85CTNY4Cw3ZtLhCQaRWA/52AOKGitGRJtVpnumr1pRH0CuyoXnwoEaR6hvuU2YFQEx1Tnjrinfx93NycsGbucTbViY/ruqz9MTNi46dWad9ruqsk1Zni1IH776vyeFChf16pVuGSw6hSnCag41vc4E+cDSgGCQsfP0UH2ZADMdjx5+mWSmh4Q6TLUOcOpIi7oWZ6SUm93sk/u/KeseQk33qC38attLvz99jnJ2+mqpj9O6Kh/Hjhc9YCkeChHzuZnc2w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Fri,  6 Jun 2025 20:06:30 +0000
Message-ID:
 <PN3PR01MB9597D20BB80F413A7E4FAC7BB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: d46d1c8b-5e52-422d-6606-08dda535f438
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkOBXeDYqBm2Kntmb4NBOXFjJZSR5dn+qVOMGY1Lwtdzpli/6UzDB5sdXYTXjx5bt/afyrvA9dCaPZUBlAvncKLjdt5ciTNbZXTFH6rdwZLoN674HFnu3QSMQGjHm1r2mE/j+iUD3fCnwJFY0ek7JyABXzn+wNJr7wUjQ4uqontURn2TDJ54CeP2CNSFLwlZ1gKxPelK/oXfgOmgG7m4OTHrEoh8xsj+5vatvbSWzr9FDaOOznr+pRkPrSqcHn+ONTM80SCp1uJLrgYVq2kDzgRW3qoawVFJKZ2xxM68fUBIDiOFzCz87W1ObnR4d0MVRejdzLtHUA/cGVHI5rzZY2OBiElA4J+HfkjQ7G6WkwWv4HS4u/KB2+fd7ZRpsMT6Qi3uydnW25zS6XoM3jPpKdSCAFqnOBbJr0YzQo/4xpnTUlwOOyARwpx/PWAzN1KKaBWpL7hhmDXoz2/lLNRYq/2NAUlqsSyMSkpgkaUkRxgUmV6lVNHPkIYqZqnZNnwT5TRVpP9be54f1pQWytQP4EjJB5LIWSUdL53GQcJqIgR4m2OLpFCxkea+E+3TBRV5M8g6Sy7GcnWVbekC/mR2ZoXQA+DS+W1pAQ4ZMy1BeR5YvpmEti1SuNW8W86YFi8/CUepSo3XDM/7OcJIhtLnGw1x7U1TU0RukBGIS+HTnku1Aldc5iD+yeJ5xPGkpL1Nazfgvu3sl5vDZltszj2+NSLXQw4ClATwtN/C6f03pjaH0I=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPN15XB5Bj9yM45VdPYPBSkG1s+hX8INmNxcEI3cDBwLgqFTGCNTtE2Wp4PN?=
 =?us-ascii?Q?x6pUVc17GaImvEtGyRRsB8b0AVxFffea1laYPBztaaV+vwa9RYmHJjX8tld6?=
 =?us-ascii?Q?sDwr6XiWmMInN+OKEQAoNb0aL9SOmaTAs5QnLwFQiLvgMT+Eb6M16nx6rJGT?=
 =?us-ascii?Q?k1KqHXaw9S5YGpmj8/Y6WS4BVVT9aubQvD2oW3j4anN5fj9h/QynjaH6zXYN?=
 =?us-ascii?Q?cyQi6TAkIGNB9lzBz8NSlxEiO6TdapPCg66CIKKofSUfGSLU5hYCkh3prdrd?=
 =?us-ascii?Q?0FH/l3JbNibzakSv3n3n0BWvKWf+9LJ2JZZ6o0gip9qHugYrtWpCqrzirKCB?=
 =?us-ascii?Q?GHQ+XS2E5GcANjiIGcUBC21XZq29CPdXjdP04fM3tJ37iGy5x9VR3fl3IZ2K?=
 =?us-ascii?Q?AZwkGxmtzXwBaiTFparVm41eYKo8dYGFtmLeDlPwGpT9iI0yV1jAvdQ01p4z?=
 =?us-ascii?Q?OHx/7tMCReX3GcOhDgGYFMbNuyx7RK93z5Zcjwcvn2fLm0f47evXmCfVII9l?=
 =?us-ascii?Q?RQVUsMwovinb9BXnSQycW32TgGGDUM0RKuJPa6DG2HPHtVgpYupaBMOrJ/38?=
 =?us-ascii?Q?DBYBh+WIEhgAosrLShavNbh+d3OnZaXgop71yKRJJYd05Xq9jxfQ3hfu03BO?=
 =?us-ascii?Q?6FfEUKOaOwZybHmfamZYFOQiYv6agcDHmN8AwIi6NO/CiKCRBJq86D5Nw4gZ?=
 =?us-ascii?Q?MWvISNmbogfuUyCQCXzjhZ51IdL4ApxsAvov5N7s3HTVT3AcEX1NNCjn10eC?=
 =?us-ascii?Q?r3rBAYBMno6jcbQzMPruINK7kKPRhPVaQtH020GPkXdMKJeFf7fhB/OBvuC7?=
 =?us-ascii?Q?dpr/jKrq9qjpA/25mnARNLbCe4thZ4RhPFYCk5ORsHmZASpzVWQZfrTZ4dVL?=
 =?us-ascii?Q?MoipxgPz52PaYDo4TezcLWlMwbs8e3I+J66FDUIp4RkYalS7jOZHQT9e8d+4?=
 =?us-ascii?Q?Y/RN2pCmP+UCp6JHnzdpR/TGwjlYL2JXvspsJEA5uJUjM6H4tmQmEspcfpQx?=
 =?us-ascii?Q?hY1IoTyishwAjzmtXRfpRLzJ2mdaFQMGq49boZU2rYCuZcJhfO5DJfTrLSRL?=
 =?us-ascii?Q?mVqfCLLbeBBSmGZ2Gt9e7QHtJbAY0c4uoH/oaiWLQMOTdhyCBZqydE3cxWXy?=
 =?us-ascii?Q?wpMvg1VelfOHFHLPbKZj0UBkvT66JuF7nA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nxyn/gCNPCzRLe9D1VrMDe7lGeNgCiqR0UyPOvaD/UdQDZJ1Y9pDa6WtflOU?=
 =?us-ascii?Q?VgDCfHlh0P53hArDl3Q9adb80iYuHGUOTbThaTGZHtF4AX3wGtXZ7194XKOx?=
 =?us-ascii?Q?qUDcNY6nEaQhQ8etCDjTs9CcXFxUKXu8qih+/w4xcTbU1A3ALfdYQcJ/H973?=
 =?us-ascii?Q?Ezj3oJ4PiCndj13zjW5IWrK7RHld2jmdn21QagUFVKic+p+wV7rfJm8BZ4eK?=
 =?us-ascii?Q?S5vRm0oFTPck5SJNl3VQj+oh2f4iefAhpZ47iGwslefcjqQ5eV9PlLGtaw+w?=
 =?us-ascii?Q?52dGhhlTZI+ZGRLmlVd8GXu2Ad5QhUBYEoJ1fODQMT7CTze1U9/riJOd2ZUk?=
 =?us-ascii?Q?GcwQvN7z4EdgfkTVJd9MwUfmnHROblNScJ4KtvI5mCr8bi59rkMcxkNuLiU6?=
 =?us-ascii?Q?/oIKvCdNJ3U3lFKwBhT5gx3VtzBTqixt7r5Un8IXPmWVpQnpc2R0eJUSH3UX?=
 =?us-ascii?Q?0LxsZnlnCoa3gwsUkntVell03s9GxFrRWzXmre/i0GAGyRyR008FbX9FNgTe?=
 =?us-ascii?Q?XqUaguzMV2L7rCIeD3sm3HgGSc8lllF+GsitSCaBhg/e2GFxc6z2oCfnH4z2?=
 =?us-ascii?Q?yhJEJn7Wmkk173/N1J9WC07UO2R1d/LZ1xqyrq1Lq4f2wNSQb6F7bgNRkJ/e?=
 =?us-ascii?Q?L8d2pXoF0KOdpcdJ1LqS3uqinhY2fLW1y2/k1ynjfg8y11syd+ZYoJmnQ9gq?=
 =?us-ascii?Q?MwVtI2gE8FpHXhtMNCYY+hHrUHGmuPPTsu43Q1VxEckru/sFd/IZInEWd1ik?=
 =?us-ascii?Q?DVDof5ZkMPq7/uY2NaCNXS+rw+qnnaJqeddd87+7eGeWL+Ry9U0vEEwrFWpD?=
 =?us-ascii?Q?IqI+sKqb4UePWrW1SiYBWNXPOL9PRwqRUDjghc6efLY3LNIrlQQcoPkFhDeK?=
 =?us-ascii?Q?fqRyMXJUZKAGl0KME96tGJ44LCMKSmrmP6OVgt/KioI8jH8rugoc1EGVp+/H?=
 =?us-ascii?Q?S8Pyi1qHdaehbhKWr7/6U426TgSuYHuB9rH+fIOgwmnyGAeE+q+cTK1YGlpd?=
 =?us-ascii?Q?RnIaVI5LskhEuKSuN0UaUPOAyDf+LcdcMuQXI9U+7m0hVUqHDvjVCya+oFvh?=
 =?us-ascii?Q?avFWWXyRwARNP/59Mnl+ghlCaEe8DFbIe9VP7GiYCtifkg0BfCrur0QLxevx?=
 =?us-ascii?Q?A3LhaWrbGtecBBEFFHA+Owto/aTb4jz8EScN2yyCqLnXx3hkF4UmmVqI8RXW?=
 =?us-ascii?Q?4rGq1+YvWVmBvYpfBjiynrpNFn1KzGptkKu7sTeF+zJGhxsXX2T/LRpaOhw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d1c8b-5e52-422d-6606-08dda535f438
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:50.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index a9dc6cfad6..e3068ef1fe 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1083,7 +1083,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0

