Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18801A23B5
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837374; cv=fail; b=MzjctWAOYk+iKt41t1TXw/am6PS/HX7PEdH6sxCuPatp48U2GeI9mFQBKa8H5KYKz8b0TEU9Mg3LRqyzp+2WDT6YcKe7i2tyhcaSc3b1KggebLbv4aS9OchRYfZk+mBzAMJFjUyOAt/FqOMPdei2Ouyv6k9fYkdf7yrzzHeN/70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837374; c=relaxed/simple;
	bh=evMSKsbS4hbnP2OU2XRRZ5kFHhIA14fQD0Jy88B6u1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWQ+QlSdbeQ3M9N5bTntPr34N+mYazwM8YR1bXAC+aVtd+BAbbOqd+juO9Y6uVyASWsO5MtlbxjnyqodOi1kicCU71gfC4KSQnncx4Nbcd+9eFc5TzwfG4uHEgm4Dl4Kl5YJbVXOUefsmSqTgIszsSKnK+CYc5EoMUmlUCZdmNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ip6ddhIL; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ip6ddhIL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph7DyI6adXvDs7ByS89NllAdJtZyqPi4rb+qrjEYRi8uCGmlPXiWL11OnzXOzbj6Jdjknm+AoAlUQiMzEpHUZs8oNVx4CgqnqTh0QALqGRHIj2xPfYSIjkHNt6knAZ27wF79oxYMTi83y8JzKHBgBxV1YBCSvfD/WqF6n26apSzf5M/E6F/nshtpnNPTYGmQDCRMju5m9KtimptHf8fgFYkDV2DCt8RJCIuqSckdq0pf2nLf+IaxABeykhnxwBQeZveuueMYZcPIEjBLJIg4ofK+jZBD1ad7Px13KYa5x67ytkZxm8HBp7iMp/Fdq3axMXV9inHmarYS3NlNozCowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQv1PEM5o7ocgKz5PhhkTUx5LRsJ1lHs6uA1OV5FVkE=;
 b=dBDctImgLPwIIEXDw1BcToepXxOYpOcym2qFjCSvvsWYfpuzS93TSUcwRACjoC4MaXlVdbfSp7mmvFe1GdUwgptR5xO4yb1nhpWgch5IGs8XsVVOqUIV3xkJxp8OMmOyyDj/+FhNhx1zEulWT0nshR/h9ILRuWf3BuwMMytxysH0g43an5VXr27Mg4RVJidldU8Hkf11DCh23u1H+VJyTSdqsy3JAJ8ytNb4XrNRgyQ07I1DOiK3eQW1u4COJk2FRfTcIrPDovT4SjgHEBEHbwO8/uIeukVViBh9DueSi6TFaChlL11hKx8wOdfqHX1IeCTOWVyeoUDYoFnwrQFO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQv1PEM5o7ocgKz5PhhkTUx5LRsJ1lHs6uA1OV5FVkE=;
 b=Ip6ddhILrn30AO/bjC4cKDtjv0FfA+DdNjwpV3hblcEjAnAOAX6kpwWytRlEov1uoQrUbDr13z7Xcjz99ZLkGZamqwG6D6Eyl20n/U+wwHKCmKxSbVqbkcqhb+KEPZsLbfJUyOAg4FM+r48cP51YNKOrpE4ThfUrYqufX+0wOXSBpFCZKq2P75L9uQYXdEthdZLtrcF/sbEqImjXjbPeYSzm8wE/vGddou9k93AvoLA+CphWC7vM91lSbqm5GOBNx8ehcTgm+XEgQoINDGoBMdNnXXQbi3iRsVTOvfImIZ4t8dIlPPHdC50NClQwtk+6CC9gok8WDJvJVpVDy3Nemg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8943.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:120::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Wed, 21 May
 2025 14:22:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:22:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net
Subject: [PATCH] help: inform about 'git update-git-for-windows' on Windows
Date: Wed, 21 May 2025 19:52:29 +0530
Message-ID:
 <PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250521142230.14066-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d47498-ca5b-475f-6546-08dd9872f577
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|41001999006|21061999006|19110799006|461199028|15080799009|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZxGtm/1T0p8f60xmXKvmDJCd/l59NG3s94BUku154zVP9nUR2fBUmM5U158?=
 =?us-ascii?Q?xlmx2aCoailVWQ7lbcibKWFPM0tMAfCHHJnwRL4sbXQ3flVxtOm3+0yBlPOn?=
 =?us-ascii?Q?wo8iLXM41bN+HRUwB0peY3paNU0V1sOOtG+s5PdG0jYBJu/xeIQnSshMNUV2?=
 =?us-ascii?Q?Ns0uB18ngH0CCe1D9QGymVgrZ3I0cvU0PTrq1EhIoE48hW/jRbdUhamuF6la?=
 =?us-ascii?Q?WWXRGQtBgvSBcgC3it13i+a3yErkuN5Ws9nIdBu2KAY4SdGJB4VSLhLJ5hLv?=
 =?us-ascii?Q?eMpGV94hUWlTh6fKwikNl0hKe0FBW+tBjkZZf7zXMtQwNUf6FgTorYNZgKTI?=
 =?us-ascii?Q?10bbG8lAZ7hJU2z/BIRLsbaWdX7oY8nJV/bByn0C1wqwnJNszZjLMVHYQloW?=
 =?us-ascii?Q?IKFtyIk80mRm/22GU0RT7qnAmfYBxqOD5KcD5iGA8Jp1+g5Q1pl3FxRtmA/a?=
 =?us-ascii?Q?Pzre/47qRbTgkWZFlbvWG8cZqSFmaZ/c30zyqfiF0N6Qt53PszM7cuAgeJ/p?=
 =?us-ascii?Q?NMw5v0WdCOYzHAQfKg0hvDUgs82X770bKkSnz1C2ZRy4nvbr1VbsIzxGTfN7?=
 =?us-ascii?Q?g+TJPo0UmN3QxgomoLSSMp+z9LEmwi+2zWnbqEkFFjba1QSxT1fWgf1eWp+Z?=
 =?us-ascii?Q?bZ4Qk1vBcJ6JO9Xwx0oXjN90PchYAFcKLLQIjl1LyWY/+cuc15RykUZAOO2J?=
 =?us-ascii?Q?0emQPhL1Yu5KQK7P5vsYfxDnesAUP4YG4z+GpUNGzTLwsYf99cswfmA8Hh32?=
 =?us-ascii?Q?FquuBNkx19XehrGOXzfXaNyn0rWbiA2La7WIs997yxrM/f29jOYnqig7Hiyb?=
 =?us-ascii?Q?OrOAOSAL168c6x1OcZmjm2FXGqzZNVeC1xs0+NJD3Z3Q9TJLXFj2cgv0njGs?=
 =?us-ascii?Q?Em7IpEkJQ1WqWgtRCKYdrm3FSnvDl6mCBfgf/4RbVl2E+eJlZw9yocNIT9Ue?=
 =?us-ascii?Q?xPdJVik2rGtOg/j31+Pasz1HKDIGpwRcGJFkMmgVrIcf0LilUYumELLAoJnY?=
 =?us-ascii?Q?PzFbwjL/j6iT8ByxBM5Fec78dDQvEgfeHxcJVMm/k/utw+5t2xzcI6TZApns?=
 =?us-ascii?Q?VZ6uMYYHGkEgJo2r190cxTlEFfOheuzACQFlEz2MQtB2THQk5U+1tErh1lMv?=
 =?us-ascii?Q?PqqH/h3jHrKv4RsKmTvt4lG0sT2O75vuk7y+CzwrrDW1dJRMxh3Yrfw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywEP/wRBNRCQFsSNmsjfrav0uluWgJrGV8s2tF4DLyPTxY8e+BSgHyg//WbF?=
 =?us-ascii?Q?bXM9FLSKPKqH77zZdx6fLvGfl2IcjXpKKgoFZOqqmSgSnswFDn7bi3I4QSlh?=
 =?us-ascii?Q?NOrOVRKz3fgtcZKvdrDFOoimmf4sH3Kh/wumEzqS6IryJsBHXY7Q5t7Qd88h?=
 =?us-ascii?Q?8ipusQzv4+GJw7tzPleNjP+SzrTPu8avj+B6L8ggxJbq1ylDUwKwta5zS05E?=
 =?us-ascii?Q?aceoWpyWd0qXpp5j2j0Qcya1nYG+GQt2NE+w8E8vOvilqOAknZaE2cyeeWAi?=
 =?us-ascii?Q?wBDr0qpYnjWWqX3hodTdB8jNveRjwwqsO1B+Z9+QGx38B0GJlAWaKGWk1YqA?=
 =?us-ascii?Q?4YCUdxRbEk/OqGskiiqbxbi/TjBKWCYzIKWCAGIYkY4TYIiGLwwH3hu9gVqi?=
 =?us-ascii?Q?yq0Kn+OcT+/4UIizEH2xqCTbA8814yzyGYcsgbWMgMSn5wjRU/KHOO7lY/DG?=
 =?us-ascii?Q?9xNJoZPMlWu8qr2E6d5O4/St7O77S0LNX8o399VkJ8LCkxSewmzWUdmDUN6W?=
 =?us-ascii?Q?gGf9Rg3z80QLooFBrLi+2v4hu+l6dArq+uAeh2eL+tEcUcae9374XxMoB+Su?=
 =?us-ascii?Q?GT+mWDvzVsGsxlhHurQtxC9yby8ABx5cpz849KgncWoB0otp4d8a2bZKw7lx?=
 =?us-ascii?Q?MPT8CfCJs+/uk9nYTvdfFnUnUF7roKRI5S0KF9tMZYDhQpV+YaAtzvnw3vSn?=
 =?us-ascii?Q?w3h5qItHDQAN7R8FV2pMLnbWE3J/j+fk3UND0qBny5sZfuio8LgVvbWghFuD?=
 =?us-ascii?Q?8NsNfCw7UFIvWzEUlocTzSCF+C23I772jfkGmkQGZwt22UOL5lNW9CvHNwLM?=
 =?us-ascii?Q?2/nnSq5zWm4kHldfleVkd5zd0yQ23bcmSY6l45xqHdETCwV5T1GFRlLrpFzD?=
 =?us-ascii?Q?SGzWdUSTBZgNx+PcQfo0Laow4gmpuwmf86FBnoOWUnJsoi/wFd7fOj2KpIm6?=
 =?us-ascii?Q?m1nov4iH6cO8j8l5ljQI64UblguGVksVRflm0n/ega1Lw9IVlwwgBLCcS/qM?=
 =?us-ascii?Q?At52XPmgZCbx1BYSmqqc3TFPwdNmuoDJKVqmhokxAMzxdGBx4lRp1BqnFSXn?=
 =?us-ascii?Q?pRF/4GQu+zRovnnNep+n6zxlZVImaA9/1N7s2Tti/3OUV3wcP077U6w8yUCv?=
 =?us-ascii?Q?qEnZae4x40e3Ipx7Ns/tmKyDPQIxptqXTuaDnr0wPVWt1j83kCqd0b6XaCC3?=
 =?us-ascii?Q?F9z4dlAEr7ub3sHadeM1UAZk5Kraa8jOLa6ikO9McVSSTg+9SPuOQcQ3Jk2q?=
 =?us-ascii?Q?aq/F574KkqMxiFGEk04/Vir9ly5GfqcHcLUpQU31b9A3DoHHRsAq7pxBsYm4?=
 =?us-ascii?Q?ur0=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d47498-ca5b-475f-6546-08dd9872f577
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:22:47.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8943

Not only there is a nice installer to install git on Windows, there
is also a very nice command, git update-git-for-windows that makes
updating git easy. But what I have noticed is that many people,
which also included me, are not aware of this command.

Linux (and to some extend macOS) have awesome package managers, that
can handle updates very well, but on Windows, the preferred way of
installation remains using an installer.

Adding a little line indicating its existance and use while running
git help should be nice way to inform users of the same. This commit
exactly does that. git help should output the following on windows
after this patch:

usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
           [--no-optional-locks] [--no-advice] [--bare] [--git-dir=<path>]
           [--work-tree=<path>] [--namespace=<name>] [--config-env=<name>=<envvar>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   restore    Restore working tree files
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   diff       Show changes between commits, commit and working tree, etc
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   backfill   Download missing objects in a partial clone
   branch     List, create, or delete branches
   commit     Record changes to the repository
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   reset      Reset current HEAD to the specified state
   switch     Switch branches
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git update-git-for-windows' can be used to update git.

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
See 'git help git' for an overview of the system.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/help.c b/help.c
index 6ef90838f1..238ed1913c 100644
--- a/help.c
+++ b/help.c
@@ -355,6 +355,9 @@ void list_common_cmds_help(void)
 	puts(_("These are common Git commands used in various situations:"));
 	putchar('\n');
 	print_cmd_by_category(common_categories, NULL);
+#ifdef _WIN32
+	printf("\n'git update-git-for-windows' can be used to update git.\n");
+#endif
 }
 
 void list_all_main_cmds(struct string_list *list)
-- 
2.43.0

