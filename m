Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E628505D
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266876; cv=fail; b=Mq8DRel3Cx7NrtLqv+NLqn6eEjopGujUFCRUJqenrNB/vVKvx+pyEfMrU3q6xUUJfhGgJ7TqN+BEmxuQOpsvEK4SnSO3X1NiVQnlbs2fCCf9JLmOe3pkqGvQShusR/bFCmShfiOgIE5VvJqfaalVSKOh63bhGGlbhfidWmiJfWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266876; c=relaxed/simple;
	bh=YhYy0sPUKnLo2RGh0/tXsdHuSa0HWA4EeL2R4Snq/oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4KgqUPFRo7KE32odt+G3+zTpV7tEfdXOdhkoT1wSv1H9SjaSVrl8CqmjT8SGRqp12ld7CK078tlT2TH2Z7DsvxhuHaK7Y1ZCoh8oyJQuFHUoc35LzGPhfBqTcVdHS+nCH/ZQ7eelUMkJgbnXUpa2vMfmoi04gCz8entyJyUqrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Sngb8m4m; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Sngb8m4m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX96F0sYlsdST5E3b3t5Ad1YPF1v7CbIxIo5z1hml3I9+oL9lDYntMgYsIEThRu++XBhux59VurGGMkH9W/VdMze0PDPS5rz9/i2/vjKktroDqGWweEqOwhcKEqKMCJXhiU5GZLJyxT3NI5LQcfZmBj334XKZbS/A9jmWH8geQ+wYf3LHI3MGOVSidLt6jRxi+Ey0RceqGqjZLbghOfDcjkQsXK+VZSmW+QSFe+S90oVlMsPe1003ZyGUAQ+CUbAd6rfYn5mTvJZJtnI9TDCXlhoyHq5FlQxsbJNjehgjZ8BXiYbVplKHF5HUMOk3zX9F1FynDn3raqYqpIy2nijLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4xOQTq45Rk9xRFMtkC9lKFmVnd/gdOfyQqdtFL6BsI=;
 b=fcdlLTFwmdKarHkOdP8lQVq60rmQU//JaR2wLyANrqV76SkyciKt6U1bSyxmPjeBB+8A4P14uUcCOC99FzcjOBM3mBz1g58loN4DyoeBf0N/gn/ews6mZiGnq/nDoDNg915077qOEWwPfRVG2rLutvJXTGwq5L1kxKbzhJh5zif0T3sxyah+yyYad8VQiJLFCS228jAZBz+Dt9ga9J5ftGjWXSOMJ0Cys/UT04nNKUWUDKEYWrptVPiDanWzj5RMP7oL2i6H8R3o5esC1+RNeQQQH4mDWvmy0sndRUui1/wK5jAkAQ8m3Lvi3kD9G7TClsJiFCqqtAH07BBoT6+1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4xOQTq45Rk9xRFMtkC9lKFmVnd/gdOfyQqdtFL6BsI=;
 b=Sngb8m4mqV5geTf3EWf5kKlvNUkkCJi5Am4EA2cp/U7s9l29+Ha0QI/+wXIA3ePCyCYHsWhw3htcbvCE/C5V9/hYu8qYLuGgd1GlbO3h13CKqsEDgDLhL15pne+yjKQdoffmjpzwT/fny1WJUPC6nlChZP/ZReOcVJqZpKmsFsJcSbRAlbCqqvMFmx8ZWHrhl7Skagi/5U2h4Tus23YxIUVt0LTkHOAZz3Sdv8QPB1LrM8+TUwnlbYfLDnzz+NsfZ1y84Enm3AW81EI6OyBSCEcnCkBnROW1aTqNH9Eai++xkAhfJOqrWV8cQKp9nOiyQ1FvZ0XeVMzl7Zr7FhQsiQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7838.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:34:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:34:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/2] send-email: integrate with git imap-send
Date: Wed, 23 Jul 2025 16:03:49 +0530
Message-ID:
 <PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1.320.g2ad311502d
In-Reply-To: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250723103351.17560-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f743ef-e713-4498-ab1b-08ddc9d47ec3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799015|15080799012|19110799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tl5jy/AT2wm81WWDr8l5Zmg+JoyavN2x8VspbouyH98ZkHdMmuxaVnbDYDSv?=
 =?us-ascii?Q?jUxsmtnYNSPlpCB4amh2zzydEJvJhD7erSTC6RP+R6vJop4M/7igAu2CK8Cj?=
 =?us-ascii?Q?7zuBeheTJj0zqT1R6ZwsMbChyjSFLWwjV6L99uYPb2DEqlBLAXiZriLrRCAs?=
 =?us-ascii?Q?hdmul6uNMvGcNTEH+JwPfDw6XT8xN66dgqW34E17RXEiVzFOtZEQSQWChvhq?=
 =?us-ascii?Q?CNuK7zLxM0QpMMRS8xlfou2cz2jqXC55K6+UssfpWm7uDo9dh456VrXHBJR0?=
 =?us-ascii?Q?eZX2yYdS/v4NQMxHRy1RdpH+Msjb39ggq+jdbI3YYxArXy4qB/ySqPdYJFiM?=
 =?us-ascii?Q?AgA6bcC/hpTEUzlN77CZDlmFwaeQnJXzOSdgQwpmTOJgnuzNSWtiLBi+UDrh?=
 =?us-ascii?Q?zcOxbKKhCs34D2l2Ac9U1UxxaxklQFwdvYMpVeTAd8NTditMpNs05uLaEcUz?=
 =?us-ascii?Q?iHyB/mdoIVaGyJJddBRN8KHuqGRsYqX6DE8M8Ka4JOnXE+YEDxFG1pDMHLWn?=
 =?us-ascii?Q?8wErIyOM7Wq7YBGO2nQ8QWKeUSmMi9ae8dW6E/pC2odzoSBGrXn5vVJxo28E?=
 =?us-ascii?Q?aRgnPkNKygonJ4QB2lvmUmw6PcmXYODDS5X7WsMop6h0NZs4RDuUS45N2JGi?=
 =?us-ascii?Q?MO7MQiceieXydoESbp4XvRVMAZhfT+kCRYP5Kk4I+daI6L5Rt/L7IHstpHz0?=
 =?us-ascii?Q?zNhB00iCDJsNpZom4eL0FMJg5/rXuXc8pbAFhOnhadD6RdXOjvrb19kUpjo0?=
 =?us-ascii?Q?yR3PtzJDBbnUbuyvA5hXgdfbfDIkFZS1ygNemm8/qDAB+amjViz8WthIYMLd?=
 =?us-ascii?Q?EGTl1W7ssV+tJRw0Yv50ZwwWk9QVgE34T+Klu/+iNGWdZKenqBC/yufzev4Z?=
 =?us-ascii?Q?hQdv/MzQKhAOuyH9vIX7BS62UTcE/fU6jjpOyhjbt9RmW4+cHdpW/LPEZSDo?=
 =?us-ascii?Q?sBZvEvrRtCDcg50qKazca8xVLGYu63eiML8TxY7Mkl0kXr4dKdwG35G7ucoK?=
 =?us-ascii?Q?0I6VZTjR7UmqBJGcxI1MDGudPh6F6RbFot1zRBR3iM8YA2dPbpK32bfxeYvM?=
 =?us-ascii?Q?+UKqu2tGY1tz/8J7yeAW7I+9zGqs5Zs4ofZfjxwgRL35vSLtV30/455ZLWEF?=
 =?us-ascii?Q?fQwbaw4CAEby?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Su80VZcmnAQeQC4SQRJ0s/r0LcCktcp6ECnZLM136+w3xKpFxEerAX2cmOJc?=
 =?us-ascii?Q?AJ0EMhXzvEr1KWsQn4dG4Gn97+91yOJR1QuGZjUHPTCgM5LAjUTkBR7fNju8?=
 =?us-ascii?Q?9o2MBvQdbEhn9A4dsf2q3eDtraARtnI56PH7/eJvbyAWXlFOXoIQ/fb2Y+9R?=
 =?us-ascii?Q?piDZVmhf+kr4yF3GJRxlCXhbhJp7EmdTu25nbIXtbfKmD5fBwXnFEZcIenjh?=
 =?us-ascii?Q?vnEts2HyiLhYRDj8vOQubVbwf2tB9MEDKPp9XNuAGwonSW38Jl0r8EkZ1UvV?=
 =?us-ascii?Q?BsNlAxTLTodxqvZVA4fe4i8i6r9Xvfku85jl1MZJ6C98H0ZCk+SKCs5oYkPz?=
 =?us-ascii?Q?vP3+QdUBtSIBNBx5WjeaKOGuHWwu6Y1Er9Rm9RWXBKhvtsVle5hcuNCPzChP?=
 =?us-ascii?Q?HeYzG7oJ3gKsPVQBcyhjZ30TzPes7eJu2OPcjprLKxZTQ8y2Rxj7dTCDsRET?=
 =?us-ascii?Q?LeYq0Qws4ELBj9dGMwHN9ZxwCrqiug8Es5ya3ncg28o80bNwhIYMYeEi6T/X?=
 =?us-ascii?Q?eu1nxuotUFqxcFC7q3Tq1XsunTlud/zYLBxiAs/eOT3ooOY1AHbqomOiolwY?=
 =?us-ascii?Q?vWk4mHaoQZw48fYJYk3MI3rTTOStyga9OC0R3DTyDNj58AnE/CrfnZtVtMOl?=
 =?us-ascii?Q?2fhYrtyXU4bzc2EVwbC/E6kI4Frnv3lSjnXUoV9TOTf3vtr3Y0S1rRDzs/XX?=
 =?us-ascii?Q?azLlO44X6i2aVBkIP8lYatQidPaivnMeIPBxDF8bwkKbTrxJfRrJ0vCIzESG?=
 =?us-ascii?Q?zIeL7/DcrkjW9FzAfUsnL9FHR+ALY/RSOedLnI8if+JtIG6SBay9SVTxhcK5?=
 =?us-ascii?Q?lkFn2rOHBd07xSRaqKqeuBaONX7VYLJ40isqju7aSLzL/IHgOAFuuVx9xBGk?=
 =?us-ascii?Q?1/dVr9lgdroX2INxOvnfQ4TiLhbIjlCmn6uSBP+6AqT2GnyPwFQopmy0ii3Y?=
 =?us-ascii?Q?F+5cjF26fchue6MX486sLENc5zVm5zoRjxEA41liZDZs634S/7F2ngwXtNas?=
 =?us-ascii?Q?IgGh4WnjESMHr8+D4vNTz4gBYr6lni4bQ6T4oaMOR3T852LQ0/yJkg9EOxce?=
 =?us-ascii?Q?sekOEeB540UCUY4LxkAcpVJNrISP6gKGXAlLJQbwL2/QVIayhD7MljKyAEAV?=
 =?us-ascii?Q?OWr+lznJt+1+kTf0Z4CKfu2RU1z1OPIuey1XZYKPJDwOVn7BxwpaqkXRxUQa?=
 =?us-ascii?Q?FzOsMJqDcM16dW8ZTFDG8VXHCqsN7DHOUaUQFk+XW34fWOu+ATQcz8UUun8C?=
 =?us-ascii?Q?FX072mV8O9febmFKiVuU4vEtb/hEiqRzqQQ6HTp92ttDGNeDPDc1OEaY7Qyb?=
 =?us-ascii?Q?M7H920yq6sjtVIeKV6QptXRw?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f743ef-e713-4498-ab1b-08ddc9d47ec3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:34:25.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7838

Hi all

This patch series introduces integration of `git send-email` with `git imap-send`.

The first patch adds the ability to send a copy of sent emails to an IMAP folder
specified by the user, which is useful for email providers that do not support
sending a copy of sent emails to the "Sent" folder via SMTP.

The second patch allows users to copy emails to an IMAP folder without actually
sending them.

v2 - Fix indentation in patch for imap-send.c
   - Minor edits to commit message

v3 - Rename imap folder to imap sent folder
   - Make an error message shorter by removing unecessary details

v4 - Fix a bug causing emails to be copied to an IMAP folder even if
     --dry-run is specified.
   - Minor edits to commit messages and docs.
   - Add another patch that enables copying emails to an IMAP folder
     without actually sending them.

Aditya Garg (2):
  send-email: add ability to send a copy of sent emails to an IMAP
    folder
  send-email: enable copying emails to IMAP folder without actually
    sending them

 Documentation/config/sendemail.adoc |  2 ++
 Documentation/git-send-email.adoc   | 25 ++++++++++++++++++
 git-send-email.perl                 | 40 +++++++++++++++++++++++++++--
 imap-send.c                         | 26 +++++++++++++------
 4 files changed, 83 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  da7cee769f ! 1:  27b5eb33bb send-email: add ability to send a copy of sent emails to an IMAP folder
    @@ Commit message
         configuration variable `sendemail.imapfolder` and command line option
         `--imap-folder` which specifies the IMAP folder to send a copy of the
         sent emails to. If specified, a copy of the sent emails will be sent
    -    by piping the emails to `git imap-send` command, after the all emails are
    +    by piping the emails to `git imap-send` command, after all emails are
         sent via SMTP and the SMTP server has been closed.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
    @@ Documentation/git-send-email.adoc: must be used for each option.
     +	IMAP folder of your choice.
     ++
     +This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
    -+to get instructions for the same.
    ++for instructions.
     +
      --batch-size=<num>::
      	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
    @@ git-send-email.perl: sub usage {
                                           `--smtp-auth=none`
          --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
     +    --imap-sent-folder      <str>  * IMAP folder where a copy of the emails should be sent.
    -+                                     Make sure `git imap-send` is setup to use this feature.
    ++                                     Make sure `git imap-send` is set up to use this feature.
      
          --batch-size            <int>  * send max <int> message per connection.
          --relogin-delay         <int>  * delay <int> seconds between two successive login.
    @@ git-send-email.perl: sub send_message {
      		print "\n";
      	}
      
    -+	if ($imap_sent_folder) {
    ++	if ($imap_sent_folder && !$dry_run) {
     +		my $imap_header = $header;
     +		if (@initial_bcc) {
     +			# Bcc is not a part of $header, so we add it here.
    @@ git-send-email.perl: sub cleanup_compose_files {
      
      $smtp->quit if $smtp;
      
    -+if ($imap_sent_folder && @imap_copy) {
    ++if ($imap_sent_folder && @imap_copy && !$dry_run) {
     +	my $imap_input = join("\n", @imap_copy);
     +	eval {
     +		print "\nStarting git imap-send...\n";
-:  ---------- > 2:  2ad311502d send-email: enable copying emails to IMAP folder without actually sending them
-- 
2.50.1.320.g2ad311502d

