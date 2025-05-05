Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925B25A33E
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458779; cv=fail; b=q+x6GbxaQFH7niVupn7yi6UdXoyU57oWFZnP2GkHBE7iPyvSvxecKTbVXHsGDzQVWen+wXHhVza1nXww6xgfvB5Z9SgqqNESsizbBBrOva/fAc/4ZWL/LzN5Oq3n9VQz8C8JaAMxT0RysChzk0AEavCsb0av6IIaOT5Th6WnsAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458779; c=relaxed/simple;
	bh=hPFtp/qwQCKTgF9VQoA1L9zNJsHgiYOcWR1djO3uSGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nM9PmwgHCcAgMlp9x0aMkMHuldAOZwIlbE+W1MIABjAKe1imKsyJkXlraIkjfGdy2U4xuEOx1t9bKKZPqsYctI84Py3I748ZpBHhPJLBVDKy6mK5D7+OieJ4hu4uZXPsFdLm1a9xF+0y095zMYIk6iqQItv9dIuIk3/IygJW97g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=i7mzX48Y; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="i7mzX48Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7aLInZU2fEzdsg2tvgFErg5ZLb25V9dS9uFdLJRnjIvTUB+hjmq9v1VGtryg6s6eKBQdxslbkZEf/jVAWFSCLmgolc2f+RFsoiQ6LDEWpm3NwZWpylCt2zHYpZYNbZHwF5AT3mKO8WhBX0+eJzAFBbdIJi1hpA186/7OgjtSD7DGpTEXTM0/6BK6P6mppQVePmPfHmdHqfata3CksE5RLHTQ0axxRuwgWu8clxiM76mwRIOtv6FkudGg2S/sPNZO/88X1U99HnrkUdQaL8RaTi6DpLqC9mdYbVBjZ5pkd8UYonQsaGFJ3QMI6lMhnLh9O/+3CMoskFJzKD/8lEUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSOr+NPIQfAp477fiVBopKKNrPnZvtZntQOHF+cabSs=;
 b=D2B8W0zDWDiX0auKBNMUFeWGJXkrl1jeAE6YcXmMn88GXHdzKKNxUSqKev4mXkVANWiL/2eKGv6co+KwefqVaihEjYFbzr8IYvk7I1vUamNdas9oE4BfsrdVh4hm4WVvEev4VLi09gXzZCVZzSXhcbYcrFlXCRW5apRZCexy93EIIFZuKLtnMQcK9ih4Xkzc94WQ7lGY02AbxYl47yRh/NX/YZyq2yOjvQL3QiBM2f1ZZS8ug1njZsv5jWzdHLVVvD520auVU59mue+a5erEhgKoJVrpyT96DVJrK3JIse8O8yn/EVDV3Pe+PdStBJW+K13F5yjSabEICG+mFZxFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSOr+NPIQfAp477fiVBopKKNrPnZvtZntQOHF+cabSs=;
 b=i7mzX48YIqmTMTb2wH01/xOJ5nd1+U9A5BFlZyewNmW4Tqe8l6hEZrgIQv0yY6hHzOJZ/W63o83VaCH5Gz9Yvss4m/5qTTmd63R7qg8iJSz6czlA550FGcj6rll2HaSD5R4lFFMyIsc6yIVeehluCbXKIpfm9vfrEz/cPeEEbeaNhQT45cnSlCsjeOs5Z85Ow7TkECmEwyvKBF0/6TPW4O5wVj8IZ+Nm5cv3feJDzZqQ8yilit5fJviJ595SaWu+4v4qjrF3JlCTD+mkpl+sHhxwH9tjlSOO4VQRE3uiNy27eEgf7tSKKkxT5rJ3ZrEzu13t8HeGpuq660sMGTNIIA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7742.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 15:26:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 15:26:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Mon,  5 May 2025 15:23:02 +0000
Message-ID:
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250505152557.4937-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9198fffe-c9ec-40fa-03a6-08dd8be9292b
X-MS-Exchange-SLBlob-MailProps:
	igNrEvV8uhGWyMBLe+TGnny3ryXEVKor+3WL/7DqTlWYHyD/sHn7AqZ4h84T7AyhoAhLbVkBENTxgdM56nyBnqGg9RbAUp3N1MDkP11v5bRaGMssunubyT2NgwMlafJUN4/tN8Gf3nn9D7tDl82UhncVQHoeteAiUg6aLfzYP5e1u97DEZrkCxPHUEL95/EKOQ72Tke9PVdrVz9sQL+HPLy7/oxv3uBHKUQ/NmC6Qs3fiBv+G+IYv/c2U09vP1m2CjpAoHFFItIgOgjDLS+CPRAUS/T42ooRiStfAgs6ZheVnUU+2XrJCLbXDi/9rbcp/wzF+y2SbHaqtyA8hu9LDFDutd2ipl1001fdmSu5z8mHebWLwUPUZ1qeneYd2eKvdiBN26jnrSkqtrYMqCCc5TTvzyvVSkXe9utKbf3gK5pHlVxtvUr4e52L7SvUngiCA0eLjVZhZCeY+rzaoyvXby0x70F/9uAMgKpahpQVmH5rh6USXHU4kIStXh9DHG7oUCIhbCzfeU/tXj21kBZcFveiREuk/OYh7+5QNN2I7CZH0/Rd1vLnh1L1rNiJNVhcIdK986073s0KLao/cD9V7I9q9hL1ocZ4n3VoaoV1V2Fn7zuXTwVrZ+2BpT1KPQANgxA/itiLextWO9w9v1UMwYVar1pvuNlXAyxDTfN7B2M9mceAo2ewpn7x1Kb3z6DB9f7Jxsat+x0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7092599003|19110799003|461199028|8060799006|440099028|3412199025|21061999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBq1klcyHQcwW7dlwKuv+wQOBxpTiyf6NW2uQiOXuU3qhIfw0gmBizsXmETy?=
 =?us-ascii?Q?9r41Giw1+nIrfAr0tgDAeNetnydRMJYRotB30XI9kpexsu4GOH4AwyShjorw?=
 =?us-ascii?Q?E7vY9b9vTKdW7rb6iXdKzb1CilQhsqTOAoeyaBSs3btWX0kNP6U2sq9MbxH9?=
 =?us-ascii?Q?/+EnL7B+WgCAJFtWTFeF4Q4t+rsRyoglcz3WvUH5NDzIWgDvBuzc1OHHj1BA?=
 =?us-ascii?Q?CEd/WkxM9aC0gTvSfAHvmUgERJovaGw85JqAIe9+HddLB4sTO6R6bEEmG04i?=
 =?us-ascii?Q?gb2clUOtgOtoLuxEiRQdgS3K+X3KcdwcLM9SrU+mbnJMMDZmdXTkBTVd38a4?=
 =?us-ascii?Q?HigTat4UQ+NsqLdGgvA3uOTfqJst2mmo6JrrM6Fw0Eq3SAdMwz+0AykTTuHL?=
 =?us-ascii?Q?2BJrClRlez3RxFwhH5ZeWCHkqRUFF0pZlNdiMMyme4DCRTuNCiFLsfkgNyt0?=
 =?us-ascii?Q?OB1MYRqIc9nKcKjZv/CCI6oIHk0uKR4JLRKk9waZoe6Dt9I7Ox9XZ3aXIcUn?=
 =?us-ascii?Q?0laswOmkKZvznt1IsgghQJe231OU7IWAC4kF4vmpa7/FN3pm2Qvz3Lo3FTV4?=
 =?us-ascii?Q?55uJ90eSePJthedraB1yJTdpNw1wUr8bTYy5CrIeDmkD2vdfGQlOyN1iQa0d?=
 =?us-ascii?Q?Tzppq4sJVdipDIftTm2m9EVMvv6KDXfhEqQiEZs/i06a4balyowQTbnQZG+x?=
 =?us-ascii?Q?hIKt5FhIHDsXM+tgJ01Me8l+YSjY8Fog70OFpG3PLRbcCLLS5piWI/Xpbac7?=
 =?us-ascii?Q?2Vou5DvNUFq5XO2O7ApOdCMiT28sSjshfdkAUEbdwcew6CIHGQgzcLLVigOz?=
 =?us-ascii?Q?xsU+LIsGRQ2x8iG1Jye5/ra4vIGUmmcZOA5bukm2BJVVqdAzcJcO1mnLz2gc?=
 =?us-ascii?Q?+PZtztTEYHcU2JRaS9rUN9OWejdE4TCG/bGj0xovWcjfCmZyGOwCijv01wf5?=
 =?us-ascii?Q?91a6ItDmy9YG1z9RT1dptLDBKsaOv6Fe0HmbWgJEPAM7rB55b22BFjpWKusZ?=
 =?us-ascii?Q?A42L+zQR8dDcKR+zhaio3kH3S3Q4gKGLSsfIGw6tmqj8gNN00utp8D49Kl03?=
 =?us-ascii?Q?VVstxjx1txdDAEaeY/aXM7lI3T1A6ZCCDyR3TaD+bJXmruB84eJenM3pyx5w?=
 =?us-ascii?Q?GmkAAJgAQi6bhEpA0t+L8zOQPPIIQIWai5HE/OU9OEgl52uYMSDoRLU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOp7c8giuX0s5kKYmvZXNpZHji0uDgiGB2HgXZYr+j1N0qWnicndYVRaxTuw?=
 =?us-ascii?Q?gsUjHuSfaTzPnEF3vq+kyvWEdfXqPrW99kiDmToSsLSNXL00hIQAZ9bWA5qq?=
 =?us-ascii?Q?Wzv5iVroW6v700Jy57YwknN7P02XhM8XS0Y7Gc74P0ymO+k/rqJHM6SSY7Fc?=
 =?us-ascii?Q?YH52BVrnbIrtqIOGj2OcO9g1UeIpPT5F4Td3VPCyXAwtP52rCSd5WC3yK2ri?=
 =?us-ascii?Q?rZfaBCH2s8B7evEEZ2pqG6++pztLePlqmYnkMj8xVfh/4Eub0cAukswLt3Ux?=
 =?us-ascii?Q?H2D2d/PemClQLlaY+2J4CRwmugPWk6lKFUWh3J93McQDNArLnuizuLGmj96W?=
 =?us-ascii?Q?8KH5hXVM49cQMG3rz06gLB6TSmCbnWObsqUkrTaGv2esQqOgRAYwbbf08GlZ?=
 =?us-ascii?Q?kCYw0FjAXaZIA1lRaRFYEaFkL192TnyBfu67oeVvtsxTwi9Num31G3pA4+Ex?=
 =?us-ascii?Q?ByeKIl/bSUDTN4b8/FQwXdl7vXTsCVKMBSKVNi8A/QHCcqKxp+c5OwmlkTKm?=
 =?us-ascii?Q?+qYMW6JvG/56nirCkXmcmHLWssahwds7Zz1RrFaz59LpENbtCn36fTdF5XHY?=
 =?us-ascii?Q?dVJbCqNQsLt6XgKeihBr/U2Oeb2YoR0Ujt8kKdOVNx9vooR48cc55+82bhLp?=
 =?us-ascii?Q?OEayyzdY/eo0AsksGJIsrZnOUbw4wFqP3pHzAobBpuAJWVtarP2STitwvFZs?=
 =?us-ascii?Q?7mHKvO0NCnG/qYZDLFnyba4wC50qE+UUwXqm9+OFbGf+5AratDmLuUhGYQOe?=
 =?us-ascii?Q?aZAtjI6sQhZNZmma6ITJ0c1T2H0SPM4joY5cOLl6jN/sUa5KZKxVqKslnfv+?=
 =?us-ascii?Q?Yu1DAnL059zbr59wsZyUmGEk16WUoj5VZwf3PR71thshcjhUuPZy1YOR1h6y?=
 =?us-ascii?Q?onAPLxAyqHj3EYvCsl1+u+1CFzTdu/NYMWO0BqZ8BCrOnquj/9rWA0hE+pN9?=
 =?us-ascii?Q?3Aie/UkJ5YK2QVsQiQgR9CDpeU6Sf6qlqw8VqNFENrFyHzSSjvYeKYHd/78Z?=
 =?us-ascii?Q?pCmnE+BtJMZAGodHMByDvDHoN3/r7AHR5XAD9qa0hRzK7oig7ZqayByLqKHP?=
 =?us-ascii?Q?TP42kDpThwBvcBe45m2O9uqe4XSa6InWH+jXveC7bInAvKFrrzjlSZRdevxU?=
 =?us-ascii?Q?oP9UAP9wo4Srik28kAvjooZF8yo/nroV2DfmSwfgP4109xMbhkNKx2K4RS3e?=
 =?us-ascii?Q?oj3MX5ug1g1lFgw8ZXtDuDnp3mcTU5j8XXejiV/810/g5kzSJrO7L4oc56Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9198fffe-c9ec-40fa-03a6-08dd8be9292b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:26:09.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7742

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

P.S. I have used `git-credential-outlook` linked in the second and third
patch for this email!

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first patch.

v3: - Change link for email helpers since old one was too long.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 106 ++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |   4 ++
 git-send-email.perl               |   3 +-
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.49.0

