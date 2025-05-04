Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533F4315A
	for <git@vger.kernel.org>; Sun,  4 May 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746367115; cv=fail; b=LQcFuAepS23bitY4vzkM26tjLlTsfdAU/B/vNDkI9QOLiOsTHxSn803v+gtQ+JoYKPf/HjWnu2trHKo54Qo8vklB2TNCN2tVQWMiVZ4p7EqWuUQbCNvTNCqpTWZTm0eHWU/IPeyikcKK/BdAoljmt1ws0okrwPbflNxt5D926F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746367115; c=relaxed/simple;
	bh=mTpFbLRA7O4abPJhaMVyhbaDvdLFCFYAI18vLXdFufw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WRoe3t1RQVasNtvEi3f7VHn8GW7gs06MY7XMwWDFUrkK84WFjwV1NykpxvV8XT/KB7tZkjRzgG0y47LliDa5fdq2w8oh3b8r4YdkiZPio3L1dyXtgK3b4n4eHiqz9N3dGB8Ei+25L57xgpKrAFXD05PrySsTkQQtstnArKQeGNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=B1pjjKRN; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="B1pjjKRN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FY53JvF4dJY1zcH+f9F9/iARYP9STep1BXtZvhdFmFkmeXURtqnfqAkWd22FZN7AYSkYt+YMBW7/sfrBhoC3nh9buXy/sflJmu6tIm6/2+37cZ6KNc/+oaQJBFEzX7ukV8YYSjGO1EI3OoShqqFASBi8T4fHZUdmnPJcFCzcLXTOfePNEkfjDM74cT1Vnu2/qhoaZbVmX8c0jFBgNYsd6ezvQtXf/+K4d0Q2QusL6CspoA/bRD3ztNH/3kigRFCdLHDUBxIxjDhc9iOZEQ57BpVeLuq4afSEMu+3VCn5zHvPD3JKXSWPsV888VdfuoA6mz+SXYruCULzxICxbmNlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJBDEazQ4lLNs0uq4NmKKsWdFgp70nkFoQDw/rnANn8=;
 b=RSbCg6CVU9lf6CpXUkp7LhBSiRKk6UJeo8WgWX+OkwO+QfzE2O8KGltIMrtO2jSBpzw9vs2nlDzN9zxWSOafQuu5igkKRCiIdMeuZSmFz8+eygN5WuLT0wk+yI3RDBro0cvgd15/SSSYO7RkyRsfkZHznWMuGJZhb7AsPfxtZEu3NvZb4D2azUjh9z6GwD1My+Tr6nTGHXqI00XuzJZOKSPYS0fYel3ZtKxamS1MUpVkND8HFGkxRVjjhXCKSOjYDTFNatm6GEFjBGjMxyOan4wyMl0gVGU+nAN1Ns+hMXlpWul3B+nGCrWLOBZJWriDySXv3AMPh+7/21a5OOZYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJBDEazQ4lLNs0uq4NmKKsWdFgp70nkFoQDw/rnANn8=;
 b=B1pjjKRNEt+TWhC85VZDYHWEkApG+erZBdhML7HSeUOV1N5Dgd5wEznFgeOQcENlRigz723gpZCYHIeRQ2/aIkk5GcO/UQc/rEYuHV7sRR7+b0OICNfZph3rynkrQEqzSSApJOHPMxQtymI8/6ACjrmJPb9xb0C+3e0lqtZnZT6NhrVv8lWJ6D8gKCjqI/DJcnEq+IV1Kqcrfezw6bXmsaEmqn8QBkqD7Z7rVr777UY/mjacwx5hGagd0ebGqqyxr/e9BeU/UrSW0tF3m0xVXc51MCF89A4myz4iNZChp5hng8HClkErwTWbg3zYsDPS3HOI+aPGh7chN+u2Q5KgkQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB8169.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 4 May
 2025 13:58:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 13:58:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Sun,  4 May 2025 13:54:55 +0000
Message-ID:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::20) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250504135816.6575-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNZPR01MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f0c9c3-7eb2-44e2-21c2-08dd8b13be87
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASIScjX/aS/OnauL17RJFM5JXWRbs2Zd46xeEkqxQITTunls5Co60q8pShaD9ahPOPRQ2jxQwvvll7AJa20jtt0xgKNTQKcY1iH9fBpEnOi9zORqV8xixcywcOIgvBb6AkJ33ttRgr9j6S+i3Xe/3uGvin+R+y4DX61F1xugCD/PvGZBPkNzhs956bQlLu2Gv82VkEK33PMN0JjhStYpZw3MXQw82/A3Y/ULQOQASBJSCcSVBFzbFl1T3hdRzvOaijX5Ki0qXfOBjp+I2gbZ7355O29z7/mttr0fHTMOjIuwUBGVQRqGy6aTjUmcWcZX6DGf4V4bKcNRDZOYqB9P/roqpNtmHr23eWruWXX6C1dnd2w1devp1IHi/YDOrG5QdnEhDqZbCi7a4o24WpJ7ahi7enHJGFV3bje+sswi12AcamurKxjrxPQ6wCO6fpq4GRUbsecKG1T2gV3rKZbXcZJU9SdzGX85deRT9m0C8n8muJIg4fF138do7JIUpFldj6SQovEiMYXVV7SevJ7cre2ZJeKyw34diAFRvknbPHqcIvGG/Of3M5CahOonDOAYlBk1sPtgBWX4J/IeZJV6SMhAOQdsfuKDTRwXhMw2+/ky7WdOkvSHwzgPRwy61z/DKqMsuQxi2sh2f9rtBx2wWWlCseA/hUbdT/03pFxIjLzcq3ll+6d9D1uQZ3BaugZKq3ndxos8fthdbA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|15080799006|7092599003|461199028|3412199025|440099028|21061999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOQcdss40x62i/iRKP0BJysTdvHQWTuBI8wQ1ic5/XdF2dT6MbSnyMz7tCHy?=
 =?us-ascii?Q?1uBT5HHxGJHs77q6rcdXhlKYccb9oDE+rDAOaHv2TWsfQoumg76M3r3hq+Rn?=
 =?us-ascii?Q?ONtn1RguliXqaLH11POhUvbCAyOlLuGmrG5kOS5cTT5xdHC+pZkdajY58vXa?=
 =?us-ascii?Q?d/abgCpEWGlG1dmJ9galSOQbDD83YowxhYXuBejxa38X8kTxUJOWIoTeipA5?=
 =?us-ascii?Q?rhh1bQy05NFv3fue2G2ZtyMqAsuef024Ule0krfse1aIwn90trFMPC3JsdJ5?=
 =?us-ascii?Q?9xkg7pwqoVVktKYoe1c4nVcSxpGPa8f1omVrOtfXi5oDXqTYIir914RS5Qe/?=
 =?us-ascii?Q?AlQCbaqgePS/Ix1hqIfgOUaoOXxPhXidRaNxFkef6aqkmsatsLaBYJeV+s25?=
 =?us-ascii?Q?4rFcfZFAqKvEJn6nmtbvU2QpcSIR5quszKNR/20fOODggLhNMP+usQu+reQo?=
 =?us-ascii?Q?u18VjqutnmBbRQqjSSdRTBsHBf76uYbk9Ninq+aHMlVy/L6b00YyU4Hm5IV8?=
 =?us-ascii?Q?DeEwSJLUBZO8FPC1eieXadqFEUP48DR4qTFXTnd3+CMHni97zdG+cnYKBoYz?=
 =?us-ascii?Q?or5vGvCQ37GkSYAt8PONSZ3sGT/xb6Mba6LymAtdR8aV8ninjio8pbQPo7gB?=
 =?us-ascii?Q?3/Jz6giApPVWrLr2TtD7w42iBQagYyWQ3Ijimt709aCjSPI96WZQh56HtAAV?=
 =?us-ascii?Q?z32W3mJdKRzw+rj3n/ICRvozqdqIMcSvuhK/PQer8P8ggdcjYbjrfhYeG5Fw?=
 =?us-ascii?Q?siKbnVZtVYOTKEW1Hi1avOH1fvY5u8wYb6WaopI9PrMFNgU0Wjv9t2E0lhRR?=
 =?us-ascii?Q?WelrYiBgxRLSQNUFsoQ6STP3nMI35Zp7swtA2+uYwoEPWVonNMCy9fIMjzJD?=
 =?us-ascii?Q?qs7Kv/WXuMoBZGxtcCg13SkRH3WbUeUwhH0Iwz8HEBPnYtR87NF6e0ODJOg8?=
 =?us-ascii?Q?k0GMUnwrgoWrNwBXgeYI1VuyaNySlW95T6/6baR484L9cwr2EseVAQv9n2ru?=
 =?us-ascii?Q?E2KkL51Eh7rNQBtoVfCm7cB1CFNohLO7/ebZVSraPK6XumVjMETZz/8x0t+G?=
 =?us-ascii?Q?iKsrTzQzORq3DQaJQlXARGMXUkBh860rWn4TzRKso+9XfGrlFNk6TMDe7HIl?=
 =?us-ascii?Q?y2PCRF9mGp5MVN7Ne5cRYsLjEckFhirlNGuR0pwPRL6++9dhqQ5e52g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KnS8lTOnuG3S6AMDvPLhpUSSJDlQlZCpe/ge/XkyU//AfE6I9VfzBO4bWSNB?=
 =?us-ascii?Q?+cw+jKKU82RhkIkXZWGOXJ74siC8iNuDjN5n+FSCpuBln3pXOz3dHQ/SGffs?=
 =?us-ascii?Q?fONifeihDl9iSZaVvbEYkwMizqeZH46U5iUQxYCank9NezZw+9R1zPC9kWt8?=
 =?us-ascii?Q?1aKxjpfLVS8v8v46rILXTnAlhPkXdZkIEm3n5JG6wMm45y8G/As2gaKS8kSg?=
 =?us-ascii?Q?kY3HydrS83iFk68f03yzPneVCFC+f8+EB93Cw7bIyJSjBKyQAqgIFo9gFTfO?=
 =?us-ascii?Q?9WSwSoy13WarpJ0wJ+ABoIxE9OR4KcKe3kmeU2jHHECQPXx+m+pglwJCW6Se?=
 =?us-ascii?Q?GX1i5qXtWymvHtihoEtxvcZf3G8BcZvJYud5T4VJgyVouNijxGuIJNOmaegb?=
 =?us-ascii?Q?Ee3DCt4lY7cujV7/lnECK4MOX/WoRATyN8XBsWyQAXb2VSXKftxC5fg8Kd3E?=
 =?us-ascii?Q?Ydt/AnQzwpSyRug2UsLj6z8B/QL1VVg1MB2VjtywVnwlrzi3l2gAEPOckm8x?=
 =?us-ascii?Q?Ghz+CQY9IltZBE0RmIaSIJ7ZXMemuqCbPe4VagoxgyWfLJMvxPHR+Pr06ZOc?=
 =?us-ascii?Q?tXtP3nHmHW+18MYLWF7wN3dRY51j6y7we89ZU/K114z2Hi5zxbKkgcSfBp35?=
 =?us-ascii?Q?JjxY722fJI4pycGQUS78qHfpRDHNClZSvKAG3OZN7k50UD8CtftvXWY/DYRL?=
 =?us-ascii?Q?8dSyOd1qBZWdooODxh59lYPny98IIP1YFd0BFndKw+vcX8kRjK3Hb/kaZtSt?=
 =?us-ascii?Q?KXcG+DsOxuDjkwziMwt/H7MDo5fXp8cALi2sPYIptTyK7GoO1D2VKg4sfKtc?=
 =?us-ascii?Q?OQ0ZPvzmzhTBT1gy5uEw3qdAQI3qTt0pEZVVDHrrUo9nmqhB/Vzgy1gLF/Er?=
 =?us-ascii?Q?No2jNbv16/PMsaZOfyNiFNGPh99ixLIp86vd/oou0o+Cpr958v5/d3RBTW5z?=
 =?us-ascii?Q?pfzjj2hrQcvcGpNlb6crYIKRT9ARC8gRV/jezxhNxBHxOr5rmCkWkQaWQjfk?=
 =?us-ascii?Q?TIWKNHx4du2Ufpi9Mpy73jFFk3NNR5+bvFAwGcx4OvmRfmUj5uFtTuVBXjiM?=
 =?us-ascii?Q?cW8cfCeR00rki8d0jAtjg/jY1+kIVMJGSYmtA1l5jZOqAkZG4xYDQMUIREc5?=
 =?us-ascii?Q?rbYJxu2VpDrJCMMIO5X+PCPwpaLJGzH2Bretej8lvqiRk+b53Ld/Iy5BGUAc?=
 =?us-ascii?Q?DpA03K3WUwRrvqQxv9bYPnOf4TVQNsw/goaarTJnnYnwdk9bARFX7299fWA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f0c9c3-7eb2-44e2-21c2-08dd8b13be87
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 13:58:27.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8169

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

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

