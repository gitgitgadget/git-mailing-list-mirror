Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EE1F4E57
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481472; cv=fail; b=QpY42SStO3rt63PfmJAu7yQIxXT794s/m8am2KFJjwG8HQElZDvpqeChFff/n1KBd49ne8O/PpIB/GRrJ/MNMLCplWTmSFK0c07zseQMYWUydNnepobFnKiL7h+HOL9BxboKZWwOHhl6cOGF1gOc7MniQ8gswFJWp5iPshEudRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481472; c=relaxed/simple;
	bh=eOgIZZN1T1uzNoRkLqAxK+W1qUFL0wyp4CwFVJhV8C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAlCzzRMmN5ENAiYT8JEd35uD3QExRl9hfsNODHvhyUCZblrHadCQtG+086aCmN9ZWCGLZoiuahT9RDkd8u7YrMsNSsK2r13bU9wMlja3kyBHBwdKwSs5lvEf1XTkmU7ecEcr0Qb4EC2Rf5SfI5JII7nF8n1J69uzUhzoZAr73Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=imw14GER; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="imw14GER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4BEXYmD/VFwYTRbbWpEqVg8PEX9La1zssvrzPVZMWajXvOJzoUOPauIwAopu7wzvGESrXl8JvnsxENvZaJ8cLWObvtxxjKyWPdrWY89brOIuYxDT/lFbsA5Sj9lYq0lUhv7JgY0I6Nmqw4UlTCfsHtapKJW4mumVmznUisRlboqZ/vWslfTpX4vWaPhj0yxZSvJAMLEUnmJJrahn4DuHSkB1skMR4eD41HgL5nWsC4TPIyWqjK7OqQmFouQFC9amL25eWJbSMk9Xnug4qmipgWzvXFyDtbvAoPaZTjLm2/IqcmRFUzqEyrMZIadNA9o5s23AHBG5IQHJRS7bWG7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvIrSTQMvzzaCNPZPtl7hpx+CQsoBvHZIN/7jJx80bM=;
 b=En8kffaULk5XIqMap3PCV5otZgkFbpRlbqeg0XdKIKNKliMOQzyeuL0NtM2D634yKTdPvYkV13b9kOh3yGWOuZON0dVPoLqdA7w0TjUHZNnUqN37oVLb1UH8ovU8LzX2QRfqqAENWwPC3rrCd7ARchUBqHgRLDGuijxOt8r4mLCwXQHD4jK0RBMtZkDxuELmVun7l2vFo/4sDmFvrNLINmZHIQEuKQqfa/95R+1uCKZ9aaCPj+IPQC+tr5NBIEZ0jz2SHvTJK2H1ice5PoCF4O7EccRYfOGLLCQmoK5jJXbiNQYTWF0rJbRBvfg1anNhDiOc7xOeFrDadZrFrAg5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvIrSTQMvzzaCNPZPtl7hpx+CQsoBvHZIN/7jJx80bM=;
 b=imw14GERTRQgye2E0jx5OiRC6ITnai/WxA7X5zZTE3/xHQgXzjMBSb0ohAyBI4JAMb955FSx6v8WUTeiWCQg9wvPLNrF79wQc9NikrVvijyGgr2hwqkS8B6i4HjKSXQa0RPxTV88Iel8DClLFfZXkTtuqwfjnk6m6ECYpzw+dnEC0Ph7X8QsoUgyezDmIVdnM6qxpZBTKZ/q2CuZsJEmO9qQlVeOULeES9Vj/vhf/+QGGTlEsqRqtpkD1L17aMYunre6x+tZibicocQyD58xr80DxgHxy4evDT7uynpgNCw9utzz4/xmARTXt0ywUPq93t6tqNGsQg1ObXGYNq13rw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7808.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 07:57:43 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:57:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP server
Date: Thu, 24 Apr 2025 07:53:54 +0000
Message-ID:
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::8) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250424075735.32601-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb46bc4-5b50-4d0c-c666-08dd8305b122
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|5072599009|19110799003|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+v6NX/ESpGuCPk1l+anIE4/UouILTcFVqNItLm0OWIRNrSAw2pd5AR0fp9/w?=
 =?us-ascii?Q?xgxDz4zW9PLs3CtzNGf2urguNaJnoFtTb0hlVPgyU/DkVs2gp3Ua1whRI3Nb?=
 =?us-ascii?Q?NLO8MHgEmnInzee4Et6ojTLJGOyeVLqprrzIy72lzDpJbBjfPOtfNHeNfSnj?=
 =?us-ascii?Q?bUUOo4HzPdbG9utY0Z5JxH7+i1KPg6eeUdORfQvSp8OlRdgnXQZ8HZFvLui7?=
 =?us-ascii?Q?uPf88uLbcZ5pz1cZTrocwB0X+SnU/Pj5g7wmty60bCcb48Vjg97FOKtTVBUN?=
 =?us-ascii?Q?UVZXA6/16foNslOszBmojJP7Q2dHWSrZ62edeVBHi8cAET7Zt44xOU2OvSNf?=
 =?us-ascii?Q?sm07Icvvoiv5RMczEIRtuaJBGwunI0qTAyFuVrQRQubVwEFeY5f+geDfLoPv?=
 =?us-ascii?Q?9saKS47uIJ7oSCrK6DYy96KzSUT31SFrksTMJfFe8W5mVMhrKFnYU70wLoo3?=
 =?us-ascii?Q?p0TMg2wjPu3o5SzfjvDmN1fL8okvjSZmJrslPjMQMeHy7bVhSKJM5QLO0r3b?=
 =?us-ascii?Q?2R+8jI9M7IigyoyfEaUDVqUaGlD5chK3q4u4eKKgmItJgEuH7onQCFs4+az+?=
 =?us-ascii?Q?pZNifJyuJmuyOkrupZzcGmkVlOgmtaaT6sFZuTo+M3W3rKI0NS8xRU6V8d+2?=
 =?us-ascii?Q?YOpV2NI27dEvBkUufhc3EwsfO2D6nXztUcEPs7Hf71YWnt4/fW381HTb2aHd?=
 =?us-ascii?Q?XhL+QuHFkov1qiUVhLzznZJaUzPXZdjhCIhTOdFxyHHpvM+F8Saq3yhw/NNh?=
 =?us-ascii?Q?mbrFT7hJtuWK4AbpaNGvRu7rbqzmo1SJwpug1ZmtWedMaQ818tltaRaDJGyA?=
 =?us-ascii?Q?26wg0OHVhOwQYKScWvw/RkpKiRBPxATcuYd3YVYKPvOipyEIj8P/T1j/CNZ8?=
 =?us-ascii?Q?zb8wvep0aaBFdjua6KdH1HyGp4E6AoxXoItdy2M1oNBnE4IiZzkieIoOjkXX?=
 =?us-ascii?Q?UY44mdoG4bSV1nWgImAYebdkG41JaJ13KnMmcvQq0uFHv14iV/MxVw9HZVub?=
 =?us-ascii?Q?ejvrL+8rxK4Hqau/BY6uzfgwdVdGyJd+YV02am9vsUaIZayel8XuuxW9f646?=
 =?us-ascii?Q?Rvbt05NJ2MACEjiavSMrkOPfPkfs0wt1lV0vskHcsPaP8zY7mLWmfS80Hopt?=
 =?us-ascii?Q?OlopbUm1dzotOuk+5+8vd55E9k5dGSxg9w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YUKBtINhIK+cISO5PgM6kpUY3XqXKJR5d+W6VHDqIgK4pK0+QUPz62FeP4RS?=
 =?us-ascii?Q?W7ImDT1yjJwO7DuWq8y0TmGtH2CZRc4Eb1OSHaOli87/M6VD/IxsG/TOMwoT?=
 =?us-ascii?Q?lUaAyaH8kpRDpqt+tiYuPr2EnLS6urtdPRsrsd/9kvW7qgOHMUG/xLyMgpyn?=
 =?us-ascii?Q?jamyRsaO0JVlhNbdXBqVOo6N3aG4oYPWdQ3s7iaN2mNFyhyA6PEXlfZjKB8+?=
 =?us-ascii?Q?E1nwEnCgHxvjV27RiDT3JvEMWk8Ld+E9QtgedKdteHF8rRpTSvoDwFfi+WKu?=
 =?us-ascii?Q?QVHmVGjwf1Tj1YugQ3HmKPAF9gwmlBEjq7q2Eqwyrcx1ezRBbHVwLBFoNVR9?=
 =?us-ascii?Q?UH6tdVX1f6T/3IYkBlPBIRdMvcEJJwoWVMey4xmjDiAPFjIePZRAKBPgkTUk?=
 =?us-ascii?Q?K0PdBD/SxHqUE7ggi9h96U4UyMfJNyduxM+gemYVtAVf+RLlGLBnr5LJe9zI?=
 =?us-ascii?Q?IiG3mgZ10Xi9m+oARb6e9XFrqkLssYi4ccCoqpTA0U1rfap75y8DlMaM5vyQ?=
 =?us-ascii?Q?6SP8/ComVpvHzlI8UWajVCFvDwTGx5SkT4fcPs49hE3TULo0kYLxoZWUYL65?=
 =?us-ascii?Q?aPzucgZBcCD8k19dgUoExhiDARuEf2sVglNmto72xG+jVpzlK74JEMoBgqYc?=
 =?us-ascii?Q?38BTKAa1WyOoNqd0njxtSNWfZ6JlQ3KjCurTghb6n05w7vmJ65Of4DrFKkpA?=
 =?us-ascii?Q?fHIFcbsEpoGCfuXgUpPRGcWtEYpfj4FjQSz2f5Bm5xbrXxaEJuhhyCJ8Y/M/?=
 =?us-ascii?Q?TpEnTUG1Zbf8h7dziTa5EJmBc1z0IikEz/F6FRncQTK3M3kLvbzrjfkHuy+M?=
 =?us-ascii?Q?Hf5ft5vlyjrsoQ30NvbO5AFPI/ybvpsw/EYecNDs236NQVJfXfHDEhNcgjV8?=
 =?us-ascii?Q?jBYErnBFgzJ5tk+3zI5tmG+UPsvS2iEGvsxIqYZEwWgnpKL9weEBwOgWAOTQ?=
 =?us-ascii?Q?+7jIzDLYn0+ZGuQgbSIr26WpvkvJ0wbBHOVD93UZtJJw65sbfkC53x1H9gaB?=
 =?us-ascii?Q?A4401VjckFZOhRnrp0MxpnUZVerlWXGuGINYdJpUs5OHV9HoeZJzdP3qkopH?=
 =?us-ascii?Q?95p193Bi72PE1ufFXgBvAogf9kB2gK0GK+VeoxRcpm8AHwG1fdZUkNIHm0+L?=
 =?us-ascii?Q?oS2XmOjOvEDDJzxisSdl/8PHQGvxqOnvalMxjZGp3Y9wO59p7QVzFKCSytt0?=
 =?us-ascii?Q?+/xYg3imWS4UITmN29HBiOCM1ZWqshdaTZjlE7ByYzt+oxWNPJ5i1NvulBA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb46bc4-5b50-4d0c-c666-08dd8305b122
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:57:42.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7808

The script generates a Message-ID alongwith the other headers when
gen_header is called, and is sent alongwith the email. For most email
providers, including gmail, the Message-ID goes unchanged to the
recipient.

But, this does not seem to be a case with Outlook. In Outlook, when we
send our own Message-ID as a part of the headers, it discards it. Then
it generates a new random Message-ID and that is what the recipient
gets.

This is a problem because the Message-ID is crucial when we are sending
multiple emails in a thread. The current implementation for threads in
the script replies to the Message-ID it generated, but due to Outlook's
behavior, it is not the same as the one that the recipient got, thus
breaking threads. So a need arises to retrieve the Message-ID from the
server response and set it in the In-Reply-To and References email
headers instead of using the self generated one for the purpose of
replies.

The $smtp->message variable in this script for outlook is something like
this:

2.0.0 OK <Message-ID> [Hostname=Some-hostname]

The Message-ID here is the one the recipient gets, rather than the one
the script generated.

This patch uses the fact above and retrieves the Message-ID from the
server response. It then changes the value of the $message_id variable
to the one received from the server. This value will be used when next
and subsequent messages are sent as replies to the message, thus
preserving the threading of the messages.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9ba47a6f38..8c8544f120 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1643,6 +1643,11 @@ sub gen_header {
 	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
 }
 
+sub is_outlook {
+	my ($host) = @_;
+	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+}
+
 # Prepares the email, then asks the user what to do.
 #
 # If the user chooses to send the email, it's sent and 1 is returned.
@@ -1806,6 +1811,22 @@ sub send_message {
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Outlook discards the Message-ID header we set while sending the email
+		# and generates a new random Message-ID. So in order to avoid breaking
+		# threads, we simply retrieve the Message-ID from the server response
+		# and assign it to the $message_id variable, which will then be
+		# assigned to $in_reply_to by the caller when the next message is sent
+		# as a response to this message.
+		if (is_outlook($smtp_server)) {
+			if ($smtp->message =~ /<([^>]+)>/) {
+				$message_id = "<$1>";
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
+			} else {
+				warn __("Warning: Could not retrieve Message-ID from server response.\n");
+			}
+		}
+
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-- 
2.49.0

