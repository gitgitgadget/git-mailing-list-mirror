Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010009.outbound.protection.outlook.com [52.103.68.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81E28EA72
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041760; cv=fail; b=X0NXrzCXvZT7bCJes584u6Ts7o1fsSphaooXxtEyWMJyBV+CaX7vWS7FJOHSnLaBxPtf5pIizhB895K/VTKC0l8jEq60gQxOgWGSuTLdGrVq7ZHEPu/kykE+q+qx0DKEgQRwxjH5O64etRuMuQzzLNakRxw9GrMQlB50QD+MrIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041760; c=relaxed/simple;
	bh=Vw1u6YewZypSSXJUT5kHHULx2JmMfb5/uyfKztwSy20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KR5d5MBXi8WqM6M4/vECIDQvpiNhML+AVa9UvTrkcMUEUrpcueAqYyWoYkE2Y8fD3kUMvwN1sJebMeNa82Q7YnpRXcYJhO7gn3Jle4nZb/4x7NIv0mMof5jdkb/zJScGSYECd0tzHTpwigbkVGe81tg3/uzUQUuN/EYIdNyb5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pok+E4Nz; arc=fail smtp.client-ip=52.103.68.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pok+E4Nz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8FL6TMRb0bcmZF77C6wT7TcvHLlvFOVhdEnZtIuCnTq/XIYCy19Yt2JthS5JXr9L826bgPaH8eID7N1Nh8PvCNHHvRx127Tqe+ihwgBeQb62E3dCt3OR3I5RWQS8IacNEwEh7J3U7Jw7LJ2KoNpuvz6qsTvyRWgpwu/Crj/ltklDIxvz2Dp8y3AsN/9LmREXIyq6McFXzRDmSM/gtdHK6GCVN24paCpR6Dcre76KUroul49Bb/rsNY+IBiIuZPfPbmLBAdk9nTGLrDc/TIBhiWtoNcYMAY04tOBitcvyZFbot7dHc0KowGTzDInZJNBBLIgm7zP+r33Fx5o4kjj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HU1JzH5B0w8AKZqezI4/LZiLVydfNmdXl+McbOcRHo=;
 b=hf2FbXE61eP5h37vVy13zYiUFLTcjG1vjxG/yjhAQ260TbfJIBhKvGbkv9CvzbdDTRyuuR+UfshHJy1LLDLkdoqhEeZBWamm2Qdwf6Zr8Yux/0cUvv6DV6Lc5akE7ry/9jbkOe9TSGeP610Pz7dbGX0XisM50OSIsqAtDrxbzZsgXtxFKgolJPmxvPorXNxwT6q7tfHyPJUrh45njwEeeyxvOOThwq4Y8J7KSnWFO/nkGU7MWTOguJAtKa9ZubFsaR68H2U1ZekIbG73swI+4f9pb/A2zj0jsnhlNyTIPaJbiZd9zRJlIjOgO0FBpxpQF5b+Jomq9emSyZrpzso59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HU1JzH5B0w8AKZqezI4/LZiLVydfNmdXl+McbOcRHo=;
 b=pok+E4NzAW5jSsntMrl9cxmTczLQeZkvqXs79NXIBCu8BpLH1IwAT2k7Q6i8SF7S01vAM6Lpy/BIW+1cas/hgqTg83otIZhLcDJroNt+tsnavWsUx732Ks4dHyfPYx+4b2qodgRmzdIzrQJ/vRTA0vXJNGGa2NAr4bL1Eu8rA9NgdjqYsJG6gIKuURxFJIxcC3KQPGIqF0yO2hS2sRdqVfKSraqLcf/cHfH3nzlCt0GxQ0iiyE3ut7wPFtibdYTsH7Nsm957+zPgUmW7khff4Sz43wLN9r//G/JdJOrgvo6v0DSzJg+t6g5Fkn/SRM8TBq0OybzMfjhOHdGVceWX4A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFC2BBD9DFD.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:55:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 12:55:47 +0000
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
Subject: [PATCH v7 1/2] send-email: fix bug resulting in broken threads if a message is edited
Date: Wed,  4 Jun 2025 18:25:13 +0530
Message-ID:
 <PN3PR01MB95977671AA4500599872A1A3B86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <cover.1748274404.git.gargaditya08@live.com>
 <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250604125514.1059-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PPFC2BBD9DFD:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3766ff-4bc6-4a9c-90a0-08dda367200c
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrNdc8DETGAAJcvdIs2iN1hw9DBPuezNroZng4NQUJ9gAzaGDbyC+9FShUBTqq+URQwttg0EjzXy9AmgTKaLIvJOhTcFK1yjtIQMLgfoFxl46Q7wtBwBV4dxQ7uGbSNqm+aJjAHG4Xr2VonyR5Zqt8NEQ+pXOuh5BoAF6PH7/g3sMLolvL5G6sf4dFOnUAxIc3bWt0jLeq5yKBvP/8vuDa2rmcc4EMjwDYrsXJUH962KneNz/kwWSbVX7jrUOMjzM8/bezCQEsBvUq2OMoCxk5oP/p/H0wi+q9XzbmX3HIaYtNKVLujJsgulPPuxk4XREJ/nvKLLtRs/RzfmuisydOsUtiWi7licG9wZuNuwa82DbYgEU9El3hccbS1TH5PGR8VrMTBN7Tk7g4tTJxtxdCQvjlLXwr82/BtpBBb82MdBCOrcV2LzB8nt1y3yoD8ZinH8aHGljZvf+uhZpGcAHLwX4QOmOB4xa1pEZAIAsw9pjFHLOuZXr08aW9bYv8kkiUw2+ZUvUcmjmeJt5rRusiu86lh8yVo2hp4Kwc7U++xdAmkhQSbOxIBZUBt3ICfW6EoieUkLNhUU9B3Tcsp+3t1gdObQaiSPeGUqxcqISR/0VkYgwl/w6WYxkgNmuYyjaToivQia/2etJ3EXlbnV0JTwaePwX6elVLxfZwcGbbJSsFjDlEL/s8ixG/XMO7eaVutC0iamLhI92QmyU/vUkV9q0i5ZBe+EMF8nZdS3MnDq/Jekqz1fjFK8t7FfF97IFgU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|41001999006|19110799006|15080799009|8060799009|7092599006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V95P7fa95JfkRpdABlJcF1CLvkoBPvXP4BDf0zrPT0HEgywu9cE6SDbiIh7j?=
 =?us-ascii?Q?vLtmLVGyeDiquy4AhHTxpsjNHLvHHNwCjZHag8pqtW5nV8rCamWBEkPJb/bs?=
 =?us-ascii?Q?ygQ4HE7X0JZqsjT6f+oPNFjRlExsGYQhmOBRfffTufw3yEAejk1smLkbtwS0?=
 =?us-ascii?Q?oblIZrJtL/7uVWJrcgdq2ESUsb00qMB2COfn6ssHuFiFsk8fSjgfjp/DFgaA?=
 =?us-ascii?Q?auJN0aqV/Rm4vePHMoldePFk5+/1CoHpSB8fov6Oe095pWYQywyrcTIa/pVJ?=
 =?us-ascii?Q?scPBm0tjWwWS+m1a+7BkmDnbD65PAQfNMpYAMa522wIU0iEQPSOP0R+csXlB?=
 =?us-ascii?Q?oe+8x+cDWyfdyIX/vS96Br2+gFJbNRIr5vuRuaBiDY9bdzl54Xc8hiea0TL3?=
 =?us-ascii?Q?N9xeJnJtc07bUTS23vYMqHFyXPfepJ6WJ3Ji7NNGKgAeow+37vHSSbjg1CCT?=
 =?us-ascii?Q?zJxO8hbx7a4YnSIqQPjP2kEyjPz0VRdbcRIxz/KVONHBECbMsSN8/SSfDlC4?=
 =?us-ascii?Q?4wTBizmJggus24sb+Pp3C/RuDp3FBfeipVfr7iKf7dXsM9CuaOiW9S4LCezP?=
 =?us-ascii?Q?Of4zbgOPvsI47Bz+YjklQgI/ReiWF0rAIMBS4DQBnAjtOjnTw7SCiNz1xsoZ?=
 =?us-ascii?Q?GHcVtXzh5L1UkiaAkvciO0L/IKsNioPKXx9mgNtQ5zBit9HBdQ3bj4pYFyfh?=
 =?us-ascii?Q?vkWog8emUnimTC1LW8+8y5ji0e/BmDLL9dNF/Eb7/Gw2d42hYddyIxqcysee?=
 =?us-ascii?Q?gXr5W/s3s5K3gMNu3d5FEn+o+N+FQeeL8x/eIVuDFkOxHpD9DYQTEnHCka/j?=
 =?us-ascii?Q?yiHW297wPk1A2vB4O+nWfrBREv5VnmH52W2DH2OXRIBpu9rzVVd4txwfDZ+O?=
 =?us-ascii?Q?IGcAggvrYvXAg/JaQOxppaIEo/JM7FPqCwCqzBBKz7dwJg8YJmho7UQh2INl?=
 =?us-ascii?Q?wRtzPCK4xFZR7sw8oqgp/FsSJXndkxVEdCqPZOR9YxWJHetB6GIjrZRq+dP5?=
 =?us-ascii?Q?q4uf3QmYvSz3179gBtNEPZU/GND5QwfGRuYNW/UL5OE0+zH0ishHKaTjC0w+?=
 =?us-ascii?Q?Zc6pjd0aSb/5aoHUDJg/w7cAWztGF51LPOlkS1HXmBRQfGKVKjyxDk7y7P11?=
 =?us-ascii?Q?2SHGECmAbxxugrqcGZn+dksxnlFIGN/BWw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nMwIyYHNtk2c8lPMFhcFZ9jBa3gAsVNh5ejZ8L+3pWtNxdg5s6AlbWFBmaMd?=
 =?us-ascii?Q?xU6D8TDxxRAzRKDiqGd8L0tb6l8JTa1qTwAerLQYfL7Y90ykEpkWHe1crWoc?=
 =?us-ascii?Q?drUZ/7P11w5M5behnDw6bL8g9xDgNS2hDibDJAq5BVuBjjIFOkTUo8XGxE7H?=
 =?us-ascii?Q?/k8Sjrrqb5vuuRf7Pq/XiQkYEFxj6hRX5s/nSKaiwrVrYKPnYzvWY9K83xuA?=
 =?us-ascii?Q?keOfl/WP/warO9rsnrjPqi9oY/kmSVRjYvjw2api1aYA1zCysPC9lKZ74O28?=
 =?us-ascii?Q?rYYuJ4FCR4U8UIHQ/GhrH1CreciwY5nUwg31YETHvNukwrE+EXlfG0QAtpCY?=
 =?us-ascii?Q?t4qjhaISvWlnu0iv1K747Z+VxW//z/bcfxBSsu5zugpjwHOCakLN2uE0bcgt?=
 =?us-ascii?Q?2nJuPNaFJjityOV9ZQEGG6TGam6CV4RqsBAHBMdnHWlCojTO+TyjE1IeObna?=
 =?us-ascii?Q?q3WJQBYUREQY4d5d1uETc2oQuGGfdcS4/DgmzNyyXugJYPWxCEvpRDR9T6hB?=
 =?us-ascii?Q?HeZldllckvIgm5awRSMr3Fnffbu1yFnPnFvtDOKT5koVx4Jq32TmBnq19roA?=
 =?us-ascii?Q?omqs/BUwCaDUbYdvsstUWItrlElc4QySqoswTAklHQ/77XtgP+FCxOFRKbIg?=
 =?us-ascii?Q?kL7IPoLaJ6qo/ItHfaAwQ/P94E5WGFiU7xx8Hgh9N02ZOIZZ8MOmAN94+bdR?=
 =?us-ascii?Q?EvxZHVmJYA4Zt1N2IF9Xra/vuDNsny995irYRxRuZkUNPiyhqOmDt0nFM5tj?=
 =?us-ascii?Q?9WSeAh8XS6Xe20ca2XfzbjevZN2hjF99FYjpBjo/rmCbDb6WFM5F2M4gV7o0?=
 =?us-ascii?Q?wsVF/UhEDYqAXTeR39sVqomA/ipAjEAfkXCJjd01i7nmvD6KJutD8tMO5m5g?=
 =?us-ascii?Q?HpwCXIaPYDYj2nPEfFKV92XMziHf4+y57AU5tBQC/IXzzy7emGRGTNfKhE2q?=
 =?us-ascii?Q?Nf/hYqamyeNj0hI2c0biQ25Tt1Lj893zCcEsiREXUiCEbQN/cByei3+KdZUM?=
 =?us-ascii?Q?kWsl/mHgzXFrlitVIi0AOyqcHZCUt4wV1+WrWAnFj6qtXj4AzBZcjj0kMkdp?=
 =?us-ascii?Q?r3zvH4H6dGMlrO/3eiWbfMEpFCGVXHTr5AcZET34nKOCc6ZPfZraWkF7CqgJ?=
 =?us-ascii?Q?brrQ0+C+eP2ius+Pvy6Cfcb6YCV69zPbSrZgCkTSVJNQt11T5cPuiKO38k/S?=
 =?us-ascii?Q?nX6h2/UbkR4bRVP2730LL8MR6o98TAvQlTtFP2NAZhAdH4YlcsVMmSsGVmdy?=
 =?us-ascii?Q?wQoLmc1RppNJekX85JOAqHPuXijGwAU3HkF/Vxn80bV1p1OWNHMUErJwYalT?=
 =?us-ascii?Q?StA=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3766ff-4bc6-4a9c-90a0-08dda367200c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:55:47.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFC2BBD9DFD

Whenever we send a thread of emails using send-email, a message number
is internally assigned to each email. This number is used to track the
order of the emails in the thread. Whenever a new message is processed
in a thread, the current script logic increments the message number by
one, which is intended.

But, if a message is edited and then resent, its message number again
gets incremented. This is because the script uses the same logic to
process the edited message, which it uses to send the next message.

This minor bug is usually harmless, unless a special situations arises.
That situation is when the first message in a thread is edited and
resent, and an `--in-reply-to` argument is also passed to send-email.
In this case, if the user has chosen shallow threading, the threading
does not work as expected, and all messages become replies to the
Message-ID specified in the `--in-reply-to` argument.

The reason for this bug is hidden in the code for threading itself.

if ($thread) {
	if ($message_was_sent &&
	  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
	  $message_num == 1)) {
		$in_reply_to = $message_id;
		if (length $references > 0) {
			$references .= "\n $message_id";
		} else {
			$references = "$message_id";
		}
	}
}

Here `$message_num` is the current message number, and `$in_reply_to` is
the Message-ID of the message to which the current message is a reply.
In case `--in-reply-to` is specified, the `$in_reply_to` variable
is set to the value of the `--in-reply-to` argument.

Whenever this whole set of conditions is true, the script sets the
`$in_reply_to` variable to the current message's ID. This is done to
ensure that the next message in the thread is a reply to this message.

In case we specify an `--in-reply-to` argument, and have shallow
threading, the only condition that can make this true is
`$message_num == 1`, which is true for the first message in a thread.
Thus, the `$in_reply_to` variable gets set to the first message's ID.
For subsequent messages, the `$message_num` variable is always
greater than 1, and the whole set of conditions is false. Therefore, the
`$in_reply_to` variable remains as the first message's ID. This is what
we expect in shallow threading. But if the user edits the first message
and resends it, the `$message_num` variable gets incremented by 1, and
thus the condition `$message_num == 1` becomes false. This means that
the `$in_reply_to` variable is not set to the first message's ID. As a
result the next message in the thread is not a reply to the first
message, but to the `--in-reply-to` argument, effectively breaking the
threading.

In case the user does not specify an `--in-reply-to` argument, the
`!defined $in_reply_to` condition is true, and thus the `$in_reply_to`
variable is set to the first message's ID, and the threading works
as expected, regardless of the message number.

To fix this bug, we need to ensure that the `$message_num` variable is
not incremented by 1 when a message is edited and resent. We do this by
decreasing the `$message_num` variable by 1 whenever the request to edit
a message is received. This way, the next message in the thread will
have the same message number as the edited message. Therefore the
threading will work as expected.

The same logic has also been applied in case the user drops a single
message from the thread by choosing the "[n]o" option during
confirmation. By doing this, the next message in the thread is assigned
the message number of the dropped message, and thus the threading
works as expected.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..ac1d5b7070 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1639,8 +1639,18 @@ sub send_message {
 		         default => $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
+			# If we are skipping a message, we should make sure that
+			# the next message is treated as the successor to the
+			# previously sent message, and not the skipped message.
+			$message_num--;
 			return 0;
 		} elsif (/^e/i) {
+			# Since the same message will be sent again, we need to
+			# decrement the message number to the previous message.
+			# Otherwise, the edited message will be treated as a
+			# different message sent after the original non-edited
+			# message.
+			$message_num--;
 			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
-- 
2.49.0.windows.1

