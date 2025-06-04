Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C128DEF4
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041753; cv=fail; b=osEWm2rC0HKJgF1lw+RI3UTO10G1YxQ1Dz/jeRLX32uxQQ5t0MHiJ089aczQX7ly+8empZqtZkmujgzKJoWA4tV5CZYMX4UmLat+78/AnVGHXhRdKuSe7MLuWUztGOq4LqoXnwFFRRxKTsqFYKcXNQkKM4TJVQKOhkidBuC8mZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041753; c=relaxed/simple;
	bh=gHXtn9SA5M2e30Yme7I5InxGMk9BHLWBlnLwn+dWeL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vs72+T5wHKNP09KJsUueETtx19gS5gM7dr40Dce2Onan6GQwv6vn4nkaytb3SDLbAk1QvEkFc7glzd9hGj8FR8km/y/b6q0pBtzfKKVrIV/oEE88xc+kuWCQ08KImRSdC/hx6kmzJ0AK8j4R4E9DNHTJjyxRYPab5w3MsTtqTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kyO9dj8f; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kyO9dj8f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l24hi99r1ICJZO4COJ9oZzSM33SqNaBlnnAD5GHSbnv9MpnZeV88pK5H1yO5ye0/8xfIXUjcwJz00gv6QyyCrr69W1iN5+AWnNTC/XZcumyksT//2H44TGBYuCaSY39DuCic0ys/lPILRRCy9e1BvIj21FV59eXcsgLVWvbJHIcISONFtWokvcgSeY1J7Vhh7aY5ZbXTIy4Jjw456/FQ8jR/TwoHb7mME1C4jVv6zRQSpsAj6Xkm/woEYd5MUmlEiov8gNPKFsEqz6sfOD0iMJzTffSFjo2Ve3vw5llEkUk+Eu0wbCYjWD/JwwM3CCAed9lug2U6uflMwlWVi51sHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex+Q0vgAB4/DkOBMU7IPzvcFT8yATmoWGmWD5sj3RxY=;
 b=Nf9Jjpr4sT+ru8a9Z2K0UHzDCM2xpg6Qz29K5wKZJdKQBmwBkgseUu0tyPm0t1Lvth3tusAy07Q2R0sAbpL2JZN1wCNkW8OutSo9g2NawpWKSXIhTxKjJ/5tlckeIx9y13406Odl2+1woXSX0te/MyAcvK+1lPPTUzxwSdb555NISia/bQw/NBm9TZiyL5hofR3pZAQThTdq6m3Ypus82XdFUcWJI2Saoq3uLskv7sL3ZVM/DEnRR+s7fUv/6aue48D62lQvst+JBZHp0VUBM6XIUpNWpnCMFRk7VZJfvAh4GEW5j+5HKrPyT170+KweYY71Sk+rPR/mNIrC5hr4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex+Q0vgAB4/DkOBMU7IPzvcFT8yATmoWGmWD5sj3RxY=;
 b=kyO9dj8femWWGCAxyUiW2EmqBv3+8NmxuXC67uQddYLg0gQxdU/d25u8kC0rK90AxnhN+5tcNfX2be/1NCafcNxbETtKGaOTsZ8e0RKMC8wyNZdnDIdGR3UEdoXfYoP7L8D1qpB2tDwZQnH2O8foxF2wEMAZ5iZrSzDPbF44Ef+GAWm3feM96QCWRAQ4cU3/3p+UtonD0vrTh3SsEcz8di0fduSuifOeiFgmKUt46sF0bdThsGBf9FRFmfvEReKDWam9BDWNEpZjKWQBailcabFctC7GprNVYUliy7EbklXUYBYX+VdtpM4ulLol07Jqk1UPNPbq9pBwx+s/9LlQYA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFC2BBD9DFD.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:55:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 12:55:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 0/2] send-email: fix threads breaking in case user edits emails and improvements to outlook ID fix.
Date: Wed,  4 Jun 2025 18:25:12 +0530
Message-ID:
 <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <cover.1748274404.git.gargaditya08@live.com>
References: <cover.1748274404.git.gargaditya08@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250604125514.1059-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PPFC2BBD9DFD:EE_
X-MS-Office365-Filtering-Correlation-Id: 548af998-90d3-46e0-bdbe-08dda3671f47
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1cExVdjXhOoRdEbNE4IE0VVlZ7SS9ELNdCYPob6BuZ0zkIBqgFB+xO0fpE/1QaO+mY7u5ZV88tK0mutx+fKZ1WgppYL+7REvjv2SKhGtvjeaQGRp+S8ijOhVYJ6SBzxpyFxiVSQMxCgKLMhHTgTf+AgOVmoS6CMJ9qNY4gLc7rIRN3ZM06hRvOm7QX/F+8Buaap9vRFAOUKq7p7kJ1fREzAEREGEfqY9+RWCN1dc8dAV26jN/C4ToBElnrOMpo6ZprT/aVQxObUakU7ZGYxu+lvodWov0nqqLdWeyZO8hPI+5XldA/cSQlecSlFRxkJ+FLNpZmHkWbD+oLPOeZiDVgQ25IS70khyyoWenwz8NUPv3NnEPP3l1Y01pCTpDk6GC+DD0ESZQv7u9oftrM0s40UMisvLMi6KcI3pNUIU2FTxkdK1e0YazERyLdDhnP2MAOp0hICGpIf5RtWXsTSvO+Ye26g+xXsZXg1+yPyUDjm5SWivYdU5SxvLX5KQRHyykHIR8uii3IBTGdvTs8D7SOcgle4pixtiMU9BTa7Xpugz9HcvdC0yHag3GEUTpSPLYbPMDByJGtKqedbQ6quF4uDX5EE9JS0tW5ot6u9BoNI0IHcrgF0YtChD/0Mf43kc+4nxqkZUtNHRCj5Uutv+OQBr/i+SJzVbw6gnqNmrQAXO8i47oPyOg1LnJVVKsJqmFguMComTo4soDti3YkxtogvfV1zo5ocXGs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799006|15080799009|8060799009|7092599006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1R8vFEpdbtuthlHUufmnrfWZotY0CxxFlIDAMzo/eUHjLlJEmA406OJeW1X?=
 =?us-ascii?Q?BW5hHnS2fNSIVAbPLAKUPCBqV8yXPsXrAWFcCIgHU4epuGtDHrAnaqyVscSW?=
 =?us-ascii?Q?iExFjZK8noFnT+Z37EdcMl9wrdB7izjDIn9ebS+jm41WvLW5G5vxPnuuO8pp?=
 =?us-ascii?Q?dnrfDSZzGneFdX8uZnHi0kdNrtlsy7drQ0bzNs5XPeak7iYzO1vZKdTpc/ka?=
 =?us-ascii?Q?ntDhu3M8FScQXAqL0KKhKJyJWdXJ8GOOWQqVYwvD85o42bi0vqoa/f474Ojs?=
 =?us-ascii?Q?y0QAuv7lZlANsRBgk8YwXHobkcrDjqu6h+ojMElQmN+e/9PVcumwsT2wcOB8?=
 =?us-ascii?Q?Lc7VDeEc4kMQWYHlk3dz6jEbhcnuuk0dEQg412SItYN0SA9tJ78vS3LfiDd+?=
 =?us-ascii?Q?SFyL85a1tTowu1PEwopBK5HPhOmdiJtroOL+Y6dy30Jxg+HAhJ3BZJ/cJd2K?=
 =?us-ascii?Q?o9MzlzhEuUgoBsAXI3insopJdmWoOk69+1zrWeyydl/aA6F8I/FPfB7Mc3UA?=
 =?us-ascii?Q?+9i9xhMbvzAWUbxigEkEXYKAJFwGOoRVbkEpf8ygLVx1GNhON9PUKAN7ryjI?=
 =?us-ascii?Q?5cAuUwGRHYH4dXKDeW/83hkZGkTnF9YisEyXGWcolkpICuwgLLE7Fr3pe10o?=
 =?us-ascii?Q?aHrNZqF2k9rQHUY87dQOjf4+9HiM9zxoyUywSdRVgw01bEnRgq4wVrxc+xru?=
 =?us-ascii?Q?NtW3FtcyUP1ZJvoH631RkSpDxDTsLfAFbJ2A+K7VHrmGQ2WVR5fbWdqIyccm?=
 =?us-ascii?Q?xiKPyoT1cP0Qw/MvBaWDWXXlPoTjgNSl9VFOtZZwxQ/I7/YM/GkJpnGjQFNO?=
 =?us-ascii?Q?UUruJMkZsAXhdI0Lr43aXqEYRBGH60O4rb2QaMvroGAET/AKbsePyPmCD689?=
 =?us-ascii?Q?jgCm4UzI5FOJ6L/7JiGxdmKMSbhp1PBIOSHjhnpZiCqYUUZ6v1LEnE+nIKyu?=
 =?us-ascii?Q?G+xHkRRlIUnkwcEnrvJoAh7/Pq119bZzFv+jMVrTxQDX4ulxj0lpANehLrsD?=
 =?us-ascii?Q?NwzD/QVIFNoHxPPCPgFZMlO6ohuFGTUSdqcosS3Nprad11+Ylsd86HD/OVjp?=
 =?us-ascii?Q?RJBUAoGDv3XX2R5ruF+J1aonQMNeUSTmcQYasCcS0naXcD7OSGY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PQDbXUNuf+iGzSBDbWsDjhxU8TW1/o6TX0y9WrGk8hJg4rjLUw2T7odwhP2?=
 =?us-ascii?Q?KnGeoBZdXpMkb5UhnqXQmbFR0BYykpkOTbZpeIs7Nytti/77QxI8tW/VFzD0?=
 =?us-ascii?Q?8ox/BmSHamf8rM1+E8tOA6QRF3NLy6xNpx35uA8HD8+0qhxURonP56gNXAGn?=
 =?us-ascii?Q?YEG+GnHPfVtu5YFl7HzSQyp93snwW9Uj3XzsldeoLT9o3m0zdZ1Nymu/AeOj?=
 =?us-ascii?Q?L899FF/BWUAlw3DrnCy6fiR+NSJCb6fVK/p/AYrfOmp7DoYDzwcPLSkv8jrN?=
 =?us-ascii?Q?ukrX32A+hm74im9rE424x0ia5Maml6oKQAqzpmlmcirF1b7h/OfuuacmhA1W?=
 =?us-ascii?Q?5ZE0RBc8iDsuM255WHZirq4+ywKSSj5/Qc3L501djzNLokPRX66HOuCQF/yH?=
 =?us-ascii?Q?8sxqtCiMU8tGe+bFtDQzBBmUhF3bx5Y3s/aKIpj6pvSA7sm47HjwJ1a1OoEg?=
 =?us-ascii?Q?KaFwMFmHKBTFlsZf1moRvVI5a/10X8eyiJrk5jVcJfW17mQbQx3aefqbb4vd?=
 =?us-ascii?Q?26wOsP9yoi+j8MlFgUvFELhMiyMFGMFTvUcA+07elC/kxZB7wCTviRUE7J9m?=
 =?us-ascii?Q?dHTErrrnwfk3r6RHHdkJWZHdkVGmag+ozB2ArsR4eTcXGQI5IUn6Y3jdn9BN?=
 =?us-ascii?Q?NRe9KO+9DZnFaxHGE2k3thrrH0ldzZxwNESK2ygBqG7B3S/Y9zh4HlB9sbwL?=
 =?us-ascii?Q?pH0lJ2UxK4a7YQcdWN99Qc8xH1SCrcgFKZ1GBVvzzS6J2GG4RKsmgXg+TZp/?=
 =?us-ascii?Q?J41FzoWH+3bsi6XLVjwb1P9vTDLTGnVCM9j82ECWZDesxtYXY+K9Idd+oBwd?=
 =?us-ascii?Q?G4cKFTTg+b6ufij7ZX4d/GTvjVSzw287FaIVmtH/czT6uuQpvbuHdtxptmDV?=
 =?us-ascii?Q?JBNM7fZWBRiXqYINYQVAnwEBhRghGBaAc1oMq8UjGynhl+Wb9t2lXnpw2QZC?=
 =?us-ascii?Q?rVVjTAiZYwhnTG9DJICombiEixTVc7ww+1A+O1fxXY5SKfx17KnTKVE3+yQ1?=
 =?us-ascii?Q?4+lSRMifiIKZakst57Os4isWWH15l1mx1/XTM+wDZG70QWN6Pom2AHRntg5/?=
 =?us-ascii?Q?aCBFpgezACGLZ4dcMMjJFhzbSK1/tdSa7g6YWucmNd2AQ0RzdgSOXeq/tq9P?=
 =?us-ascii?Q?PF5apqFtzMb2Su6A0e2aY4cQtGiQqcxg8rRCL3Nvf4bxJXEsH6+8vQ1N2Rvk?=
 =?us-ascii?Q?rfbqr1s30E0NsLjZBYsv+6h/RqrMM6Z4QNhKusey11kTEjRXlXzeSje/rL0m?=
 =?us-ascii?Q?hzN7R6tSLYHewHVOcnQEns79y6g6pzcpUt6eCOuDlIu29RugdTCuEFk2qiG6?=
 =?us-ascii?Q?S5g=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 548af998-90d3-46e0-bdbe-08dda3671f47
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:55:46.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFC2BBD9DFD

Hi all,

This patch series fixes two minor issues with git-send-email.

The first patch fixes a bug that caused the message number to increase
when a user edits an email. As a result of this bug, threads would
break when a user edits an email.

The second patch improves the logging of the new message ID assigned by
Outlook when a user edits an email.

v2 - Change the bugfix logic used to fix the threading bug.
v3 - Add additional patch to improve the logging of the new
     message ID assigned by Outlook.
v4 - Completely rewrite the commit message of the first patch to
     explain the bug in detail and how it is fixed. Also, add
     example logs to explain the second patch.
v5 - Fix numerous spelling and grammatical errors in the commit
     message of the first patch.
v6 - Change the subject of the first patch.
   - Prefer using "increment" instead of "increase" in the commit
     message of the first patch.
   - Avoid decreasing the `$message_id_serial` variable in the first patch.
v7 - Remove unecessary comment in the second patch.
   - Mild rewording of the commit message of the second patch.
   - Fix incrmented -> incremented

Aditya Garg (2):
  send-email: fix bug resulting in broken threads if a message is edited
  send-email: show the new message id assigned by outlook in the logs

 git-send-email.perl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Range-diff against v6:
1:  a5dcec5428 ! 1:  05724ae6d3 send-email: fix bug resulting in broken threads if a message is edited
    @@ Commit message
         one, which is intended.
     
         But, if a message is edited and then resent, its message number again
    -    gets incrmented. This is because the script uses the same logic to
    +    gets incremented. This is because the script uses the same logic to
         process the edited message, which it uses to send the next message.
     
         This minor bug is usually harmless, unless a special situations arises.
2:  43227e8a5e ! 2:  360391c8e2 send-email: show the new message id assigned by outlook in the logs
    @@ Commit message
     
         Result: 250
     
    -    This patch fixes this by modifying the $header variable, which is
    -    responsible for showing the logs at the end. Also, the log which states
    -    that the Message-ID has been changed will now be shown only when
    -    smtp-debug is enabled, since the main log having all of the headers is
    -    anyways displaying the new Message-ID. It should look like this after
    -    this patch:
    +    Fix this by updating the $header variable, which has the message ID we
    +    internally assigned on the "Message-ID:" header, with the message ID the
    +    Outlook server assigned. It should look like this after this patch:
     
         OK. Log says:
         Server: smtp.office365.com
    @@ git-send-email.perl: sub send_message {
      			if ($smtp->message =~ /<([^>]+)>/) {
      				$message_id = "<$1>";
     -				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
    -+				# Replace the original Message-ID in $header with the new one
     +				$header =~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
     +				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $smtp->debug;
      			} else {
-- 
2.49.0.windows.1

