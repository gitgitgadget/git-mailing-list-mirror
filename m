Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4521F4188
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481469; cv=fail; b=UPjJojb6gx/mHsTf1VfTRlhSPqPFE7yoEKw3mS/Wqr8e77cnf0Qvgooo3qMK6umQDWhlZ/zeUm4W5Yg6Bpf3ufHwPHzzx7sQ5ZKXGc/fKrl1xdWRikCd/3ExHm0BSVqM6toJLw1fbZo3R4Ibm7DDsh/jDjarPq/43NOKDdC0+4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481469; c=relaxed/simple;
	bh=S73jCqq97iFq6ZzmRYMqAnt5QhURq2FPDah08nHauhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/wc5Fv+2iJhtvVqTKgWHW2jC4HYZx+H0E7h7/HIKmSlDjMuTjE9oR+665H6O/Gkvz/iwOoKNx7GP9WfYDThZ3AB64eND6JzyuVlXV99vV0l0T3bMOV9Y9L7tqeqN1qKm595TnDBtnRZfBU311sQlEBU7eeOgrwHPLhT7dVjraA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=R2pJlkGX; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="R2pJlkGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO66P2iWWsGXjBp4n7bcQrsehl4LPxb5GGrQmoxiCToEV/19Q5apxUf8djFfCIvmgeHQazYDIu49ApnpMEfkEUf623KZ/Ja4ZoEjbQWP30Ko5pQFWlR8AtsCgz1djWb5Vdz/5X35ClZv9RlOS1fIfxx42t+neXP9If+eFR9pFEQxKGcpgT+WjkgRkx/kT3HdRi4yeYf//Dvu8d6rbNaUQJnQsuh397KVxanz0nyy8e9eiGQGUvaL4m+Ljp3NV14rMX8qu0ZAGcvbd3w/CtvxS6J6HfeZTuV7JgnX91MelfxgFNNJCFZ/lW0XcdY6ho/LvEuOkeZr1HUi7aebxiP+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BePqwzfSMFzwnOZI7bNLqDJJGwrNeQM5zMHwqySSmTk=;
 b=XvUAIoN9mJx1gNEaVlLiCxRlaE2hHE7zkvcVmJZx1SEo2kcTZLI37ZkR+fgmoRgYQGw/wY4jD07DstW6Pk1bprA6XP4qwyWhy8ekr6xUt0ElLNfefl3gUh/cqRmNnCSVzzZUXkvoGSU+U02Fka+ZXrHG4vHYdYzrngZpLapOx6ONsRq3OjUpN5Vo1H5vkIS0TwSXboPCLA76PqBbDBhgvV3KT3Men96qOtFIbSDZBmFUWTY7qVOY/Wk78EZZ+FIe9POlIiYcr0EkV5KS7yvad+jgKub0MoiDTgOMbmXWrA5ms+D0RcU/5tqlD4Z8PxYNH/1BVHT3+dB3y4s4CsvRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BePqwzfSMFzwnOZI7bNLqDJJGwrNeQM5zMHwqySSmTk=;
 b=R2pJlkGXRTnxy0cHAXSXczVCXTSwvj4bXlUGUklrawc3n1qg0UfrL7ew5+mjSQm5J1WCqFciVemTZEGWFhsPmQW+GCJRj7Jv/j7rLSyLHLFQla2LWrwW1B87/HbnF+zjd3TU6CcTMAg0jWJY1muAGgZ5tEbWBjZVxODS897eq+uC+Cy6xaSJRAmNAhBSK9+XXgprELyiX36BWRAumiSQ5u51mFm7Ky/pCs0L/ELGnMa4iIRFlT3EoiIKJ2J8rQbbNLVHYG5Wf9nA9oqPerlbEDSz/L506Owi+pHrr63PfJWvJ59VH6cB7XBmq2XRGYBXRYqGzj90p2A1NNdpeH7b4Q==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MAZPR01MB7099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 07:57:42 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:57:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v5 0/3] send-email: add oauth2 support and fix outlook breaking threads
Date: Thu, 24 Apr 2025 07:53:52 +0000
Message-ID:
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::8) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250424075735.32601-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|MAZPR01MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 189a4f91-fe11-43fd-7651-08dd8305b0cb
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd/FtG3ZuYWkIgKnu5PRi5PJ4FGNLYA0IDLi0GICEHisq+Trpc4ih/qriXfwLoHR1cf/VsSSSGiBcjrfVt3PD54Hvdu4HM0L9oDLauV+ZJfW3CApnuMe0e9xZ6MuhuDK6HnaVcKC85IVWPWIVo89hURHVkFaF/3NxLqpdDqfp6blzSLAXI583TeUtROuVCANyVaPSadsfUc1x0EWAjRqgs+i5diJLpNGAkjLqX0KuUKmGV6Y1bYGTTyG0agHJPIRw/+8ZUsceUbQCvpD8mxjhXprFdGyo57EJpYiF0wlV05ry1S/miblSdmPhUo7FrEomZeCYycJDZDbeYhXVT+2UdGEbCaI9J4Z1XXUf8oMo4WxnBYx/uG8T8G8OTXIdOCKRszP5UgEs/tN8Yr4jQ+OZcm7LcaxQKc97vWouS4+QoHU7ED/Y+5DL5oR1iKCi48bc2RRjm6tLWavP333pfpIIZZTmvi0XRFrbNUgWeNFSEYOgAjTPdcM0GwMWUY7xCkxsoPJ8/Hvt6knSbaHmSeFiXUZt6Myrs5JW9rtbsoARrRekND1/R6bjA2O3Zm91dwoiwkfHpl/aUXYb8mHfEQPLBxPnD5vApJUmbVNcYwhqSN40do115odKxhVx5pwUC0NcwNdAv4LnZwGIDKxXmlyCwgERQbazqMTme3yZ9wKzMozmYgLDFniJ3+RZv56yU0JOKUoR0zCyq3KLEf6Oe8+mtRTPiDbQjL0XRkmw1RwErCDkI8A1PRIFP6OgoOIotNKcY+YFAwKPUu5D86OHFfU60eVwsb4XM9xJC0NHu5Vyo5NNA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|7092599003|15080799006|461199028|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoyoYao/8ggAoJoFkqURSo1vSVF9bxDVCXUe8NAzEE8NlHFQw5zxKmShd/vj?=
 =?us-ascii?Q?KTePO0TIamfWfhEahQgX5EOHP4bcWZVoUJlf/etJvUxI7gV4JJm/06GYAbA8?=
 =?us-ascii?Q?zElrkoj+NNFIrjfBH6wx9UlOqyGLGBn+t6u3qb29jGnRJV+/x9GECK66rZAp?=
 =?us-ascii?Q?Bm1y0L3mEybz+alqSxvU5Q1imwcvwT/JC7jsZuO1ldVFHf2RQrVCl/bv2G7l?=
 =?us-ascii?Q?smSUbFvC4Tb8l9vYNMGBZu1hbWWpkTF1NbZgn1VnaUAWC/8nxfPE2MFCw5JH?=
 =?us-ascii?Q?OZqtAE7j0h01yh903RnhOw7SFrZ7TwIybSztajyRcSLnh5JdSkRkhMESRFUg?=
 =?us-ascii?Q?/fNTeUrBw4C/ravgSsBOtxlG2PQNQ2geKuy1iX1BhU45iWUtk4rX+hIHmr2k?=
 =?us-ascii?Q?TDutES9z8LqTF0lCIUZ/H7btbbm3yv+XaS1EXX7Ep7cZa5D1akfaA1SSAbly?=
 =?us-ascii?Q?5NTr528I47kCkKWGwjFXxvlYSBogQKEEPyHHQLd+Us/cClkSYiy7zd4fdZCo?=
 =?us-ascii?Q?gQI9Ybg8a/STruRH7tqMjH3Il+xoKQS2N4pAPhapRxz5G90Q+Ub422ByI9AF?=
 =?us-ascii?Q?s/VfCSXaM/HZd8ThUA3pLOxRdmsNIg79ViNg/FugoTS8yvNglrwmewcp1Pgq?=
 =?us-ascii?Q?BB77w/ueqdc1ygZt34NR/sU4gdGJk13XKVj6p6jSR8tMi4dgaZk1FDQeDcs6?=
 =?us-ascii?Q?bAyGN2BZ+3dIRWfwKNQJPSRxPE5Qpv1UL0vngYiomzsmopkzDcve/aHmAtHA?=
 =?us-ascii?Q?MKlXpwf7urBQ5SDVTLvGIkM5u2IjZH4b2/SiFAXmU3Rj6j+kMUpRZePE7VhS?=
 =?us-ascii?Q?24h+OypSpz8wdfcQxZI0WpmQeRpTqteoHlLqLxYJcqOvcswbkXlWatjQo+ls?=
 =?us-ascii?Q?eiuyrI3H0dFQngxzlpktn13dAOumiP9pNSg9Mpmv1MUnrcAFWibuns4My4xB?=
 =?us-ascii?Q?e2vv2Y7bm4UKA3oryUaGw3sG0ybBZ401JpIeVlO+VB8JpypBzX9oiolfJIm+?=
 =?us-ascii?Q?5e9CLpiaxrqcVlqWxXCa9yJ8buCGUYkNl4ZxtQdjnHuJhH2gIqYwrCX9ITwC?=
 =?us-ascii?Q?Qllnb6SedPSrt6VnxZMwRo6Jfmb7HB7yOPHnTD7SxVNqjkGTmWSNzaH/PPCN?=
 =?us-ascii?Q?tkQM5cXevTFhAjaIgUg/gyPnhmNJUl7cpQMLiNpe3uCvLvE3sHXFT66z4KjX?=
 =?us-ascii?Q?QedVrumOjVhbb1CGF87THyvXDE5EmKqXZ798zR/Sa7HMRHBuF+k9psCrQ22q?=
 =?us-ascii?Q?svgmkLFJ6HJyYs5tIIniywcHhq+bfeKP7E7eL54ndw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ryXyNL29uAx2fX2WZ0NdLCyBCUuJ1lRenjV1Lpdg1vwQha5QX7Zu0uZgkGc?=
 =?us-ascii?Q?0MXrWys8AaaUtTJ31zG54r4ZBz/C/owz6nhZdBV1ZqFw1Ga7UfygDCyL7k+3?=
 =?us-ascii?Q?iHTo/0IaUNs+96Sd93LE/klkwvTNLC8ddZvOJxWIl460PZGeXseHHv18ljbH?=
 =?us-ascii?Q?fLVNlBQSFO6psr1XvLpZ2xUQCd9gJxe5FL+5NRBbB/oz04JD0OKPQzhf04F2?=
 =?us-ascii?Q?AXvIoX1VxtzaR/PUx2JOZzD2l7Mp51L+XUlseswJTWKybnwvL0Y/AuycaLaN?=
 =?us-ascii?Q?KIUUIRBKGVrNAvPosG/h96fCNKDpDqmCX/6Uu71dxcHqoCnSgn/7Ydm6JnkJ?=
 =?us-ascii?Q?OJ17e1nAniFi1XwiuVGx2DeVayjI8qCt68OaYsM83CZgMOHnppJYZC/mgq1/?=
 =?us-ascii?Q?scogqjBnrnMPsXEAgIeC+tBFAveKSPuig5Qq7iMiaj/EsJDOL9zUUEYVVFes?=
 =?us-ascii?Q?qwRFrT0QXrjzMLwuVfoxX2fVHuff8pPoHFBYZQ3Mm1kFc6vHRftBijEniEqA?=
 =?us-ascii?Q?Swa62OmHuOaNsvNTH8uQG2zKHet98yeZ8JNW/lYQt4ZEn80fXVTHRua2ARCu?=
 =?us-ascii?Q?ICI/T69+Qi/IBBCic9qmShj/8v3B1ECFsqHYFVX4L3C3yznHXdciOqrHDRNm?=
 =?us-ascii?Q?ACzPRvU+yN4QgQEHcK4KtxkMNgwEtSu2Zx4WoCRrkcqegC2BGiZQXvuhtYhB?=
 =?us-ascii?Q?zsrx6cVUBpdJONOBUdPf1HBe0kwFMpjM5Pw9SNWb9SuLyOAYv3HgbbHSNpez?=
 =?us-ascii?Q?idEPKBoeia3JYSqGZz2c65D7tfDLHtDPEEy987oAuLmpnUOqS0GQ5gesNUbc?=
 =?us-ascii?Q?00rwPwWe8E+sj229TreEdQZgpcqVyif/B9tKzYMlTASirURqm/uOwdkLIHTe?=
 =?us-ascii?Q?L/yYp+5tUQ1VxUO4TvI9m9rHY1GvyI+GK72uh/aHD+iulI35rEq+gLQeYD9C?=
 =?us-ascii?Q?f/E5H01gBfLtI22QAzi4gn0opK4iUnOCht1CdztHMuXWjUqkFpampj8riUoj?=
 =?us-ascii?Q?jNkU5T7/PQNRasqk1iDkzf4Qdv3CAXkKWXUrDmJmH8N5UI5GiwyyPRoMvUf1?=
 =?us-ascii?Q?3Y7AEp8lAHHHmj9g5DsPbvVN0PB3iA4mnUBHIGd7HeviFGvmLkC4oen66+zl?=
 =?us-ascii?Q?zescuYl8Zuxe4/MHh5mQck/PMTWd7GGmEHjdKo4jJpZzF0JqrAeKuPZzvTNV?=
 =?us-ascii?Q?iQz8wDq/7e5379TeN6apKvIEn/jXx0+8ZuMBFkfnZtIhpUTwj8TWks4/occ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 189a4f91-fe11-43fd-7651-08dd8305b0cb
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:57:42.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7099

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

v2:
- Fix errors flagged by the CI

v3:
- Add third patch to generate passwords like OAuth2 tokens

v4:
- Make log message of the second patch more clear.
- Change "Outlook: Retrieved Message-ID:" to "Outlook reassigned Message-ID to:"
- Update documentation for smtp-passeval.

v5:
- Fix minor grammar issues in the commit messages.
- Attempt to wrap code in 80 characters in 1st patch.
- Create additional sub to check whether we are using OAuth2 authentication

Aditya Garg (2):
  send-email: retrieve Message-ID from outlook SMTP server
  send-email: add option to generate passswords like OAuth2 tokens

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc |  13 +++-
 git-send-email.perl               | 107 +++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 2 deletions(-)

-- 
2.49.0

