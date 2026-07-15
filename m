Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010006.outbound.protection.outlook.com [52.103.20.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2453EFD2D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106718; cv=fail; b=U87TMYDIYKE5oEr/RQY/h7JJzzu7sHSQK0PsRbifuPcQZz/UaW9Ji8IUVdIPFuZIl0SYBGKGZx+JV2730hcbKKMKJKT4SXpvmARdvyClZE0uyN6+OK4SXfBotEzskObOkHKnZ/jdtqHqS1dODVOwjugj9t7wb0uhLtDA2MYFh/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106718; c=relaxed/simple;
	bh=CiSf/XQmejh6EkHOVzBjDJqHuVxvEXQ5BQbFQhJXf0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3CEwmr3NH6spcLm8yb00mn0dY/Bnkp5KNDLMbAJAvfZHKPk4k7gH+WSMcwpW5cvIftQYSs3mb7OvBb579cVqPWtH+4lTobSoYZwt0Dlih53A5eusJ3VVVR3xH5F2XRyCw7HQ/5SpyZ31hV8O9Xa1Y1A6B0n2QlTBhPoooSwiyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TjZzVYm3; arc=fail smtp.client-ip=52.103.20.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TjZzVYm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ6g15gIPAUyPArMblXobbC5uHVheR2FrBDk6U0ljkAMfBOm0nDETlm6jozLrUKblF7PalWFe3R0ex2+5hDPCZ4794g77MC+Zluf5tSaAcN91u2h4q7J4oXhEZaBY+ZJSDETo8oDRKlQb6lrFjbbjKhJv7zEjFl1GgWpel6KrgNikabVe2H3gw3S9bgWdbH1uuS2BG3lXVwT9gnodtYtngUnx2jL670wWLXxSROUSY0Toc49FIGN/smqYeuQ0RqlVflLp0zknmj0Gr1UDuCwoqE6hk4JedVP7gQJ7yCRAomAwL4TxFLMTJIZOKJJGEjMayQvksRfFWdEfjEQtN6cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6jWbFv+S/kTtNxXcdqBNKN4qI4ZZK23LI5TmZE+748=;
 b=jzz9q6Bps0YupPP9oKltLgaJmh1WGul4Fu3IRka3nkr9bnpGX3TRFrwgiMtEb/Se2alC6PFSphh7lNMz2/Q/GTlRovCIMl+EX5bxbcD/vnPGcICe9K0E5cbibae9lUDDK/2GSnhBSZ+s7PWdeaELgXX+vp05MIz8eAasymrKbO/i+69Qxabwa/6HWUM012KokiwE3dexIL3eorqoMhgxX5fHvM4sSOEeHCGQQ683fPyZfEIOf34KOEKNpm0NcgKrIxviPMCyPVD3INVsodmecExE51NFpa3LBt3l58PV9rc3BGQC9jSdHer77/YG6xjw+OC3SfEvEYOwMAuMRcNzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6jWbFv+S/kTtNxXcdqBNKN4qI4ZZK23LI5TmZE+748=;
 b=TjZzVYm3tOJtpeklCR5A7N4l/Q/8lRTXo9o4x4Lmf/EnHYfQpWdu1XDJeVBobLujkcADTW/BXBFWBm26B95GQCUEUdhU0zQ75HY2w/SuVIijF+HvJTE+uPPMz/UmH45HvpB6jxqoZV/vIgcis/lOYaCLuCpKKI+CTJVkcLaey0gaADXUi0UZuMG7AIrcRM+CWViBMf8AJiIIcGwF0aSZPQn4txdtmIUyn16Hy9NCYaC93XimMivFSfbbY0M0K1XSgvPcJjlr2Mg9FQfLr3QROZCx1vcsrWsWxajn8y3mHMIwnkm35i390a0ysXTcl+zbRIGirpZf/aWVdD5pWOFdKQ==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by CO1PR10MB4658.namprd10.prod.outlook.com
 (2603:10b6:303:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 09:11:49 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0181.017; Wed, 15 Jul 2026
 09:11:49 +0000
From: Travor Liu <travor_lzh@outlook.com
To: git@vger.kernel.org
Cc: Travor Liu <travor_lzh@outlook.com>
Subject: [PATCH 1/2] gitweb: shorten index hashes with trailing file modes
Date: Wed, 15 Jul 2026 17:11:29 +0800
Message-ID:
 <SA1PR10MB997715CF1DAE615A9C166BE3ABF1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
References: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0080.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::16) To SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9)
X-Microsoft-Original-Message-ID:
 <20260715091130.83934-2-travor_lzh@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB997715:EE_|CO1PR10MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e03ef63-0bce-4b67-c871-08dee25119f3
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRboKkWKHDBilO6HR4POzbB70rb0sNxuEidfH3Mzfd1Ye0DBzaEmXjutxDkF2T94vNQ+VhdtXwdvNrsd5qXsjN+r5AK48YTYnfrvq5UCkXDkLlSImo1EibzadXcMzpekuAYfsViG8MAW38RrIQcsG+CSsrpQo4EPj+kLJ1iCQZtKi6vC0JLFv6mMUMN2pcA+QrtoqY465qmRTiMhKsxnLKZqhb491b/EI3YKUwk7taK2U0YW+mu8VjldN+bSHLgYELItc/sp98z+yOT9wxNhRUgCjoxIe5+mUp8+PVDlT9Z4vPGFkjFSp28s0sF67wuBLmy70HdNF4mVSb4e3Oe/3AKCQ+modOF/9DfoO03R/jF7VlSvjEOEEHbRNUzA5ALc3/ILgZTXIOB6nva1ZlkxPKoNNcxetjbS573hf8zEGoV+fK5WZiG1YHlghVvMBWmgxFodgH1jTTy5dqA+3IghGiRdJhrBgV6GOT7vgTOU0agFJ6f6s1/MOwFFs3e01n96nYelkiB8vxZBi2tujngV81w6OejzWv26Xs6noOuZbENTTubcpGmDDoLrSAXpDqMR/EQ0u+vaz7byYA1t2ZR1+r9PQR0gZzkUS4UZNlH3NyFyH/hWIX4WO+/eBItXucjvWc4QEw/Ma77QYCxrmZspdGZYz/3Y072z/oJae437D7zuJJQ9/XDAXP2UbrsSJJ2KfGlX6EFbRgUfTmT8wte/+oFRHQcb/jAX+UorcQTKPCahY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|19110799012|41001999006|8060799015|24021099003|25010399006|23021999003|25031999004|15080799012|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pI3VLwKVOEeohi5mrGabW6JMXHfTKhl4e5BwKVSL0DnRNDMBSHoZII7bvnes?=
 =?us-ascii?Q?gOfv04ReWAveVMnvfZmejf/g52ni0a5JqCQ4gS87aPXeGBdrlxOAYd4W1ndZ?=
 =?us-ascii?Q?UHh0xuUV1C6Iy94iPh8GWO6tV+QlGMzcj9lEtfyC95Sffc4HlSuilvP9Luzt?=
 =?us-ascii?Q?NWKLrmFllf6DbgVAP4Kq0anh1xO2zV9LuSfcB8h2ai7lq5Q2x7p08cUZGX4N?=
 =?us-ascii?Q?s+G42Yv/04hHyqf+D4XBGHI5iuZaJx8tPRVSSg59h+0qtFMNYWF+8fDBL4L6?=
 =?us-ascii?Q?n7N30Olo+M2Lbj9rPoqUXLZ+Z7lTrzqpTCA7SqfmDYiIaiF4A4Y2fFFAVvkE?=
 =?us-ascii?Q?FDZ3w6x1r9RO+eZFIx3sOiI6hTWRFOsaW320omkI+I2QehXFvNjrxdnyCKS0?=
 =?us-ascii?Q?k97X189yZjd74R/Vhkp3NngWUEi7a/WLTsFCpY+xfAf+qP2/d8//f/90aw8H?=
 =?us-ascii?Q?zXB7YVj1XPkHLTaqDG0rSQoKpkcRpcR1KUUcb9Pg8nxsgFodukDBdusWS6pn?=
 =?us-ascii?Q?yFu7vW/BIBzlj9jqlWtqKkNzc4DQsYXp3lZLHBWEkArODZq0QH99ajFDZCS+?=
 =?us-ascii?Q?CEQYDRZZB/30jY5+UA4cCg1xFA1oXcI//Dg7mUHsG9xkxC0cdRMckgqsg9ov?=
 =?us-ascii?Q?/ScuHtn6SWtZ0IAdllg2wdX6naVf0a9nEjLVLcDS8yQJRLkZV9944fPuhFRg?=
 =?us-ascii?Q?lvyhhZndRM495W2jnEPHmT9cBUlEl5bsrHmVZstmB/17e6M+suYpj2KeEZbr?=
 =?us-ascii?Q?GGRz1uOTR3wREmLhZh2nfsQooV3nezlUMq4K2lXKgoCC4tzNtEuHCCRKfpTr?=
 =?us-ascii?Q?VyWHgFkmGq2pNB+owiUpDcHJQFdLTPhvdmR9jfYyYlnPQbpUNCJlyM0ombPM?=
 =?us-ascii?Q?gxF8xCUbyR2eGXScDlGWN+HZLVD+6AciNyvAGqC6h/y5YH6fdlgk8PtFRLRR?=
 =?us-ascii?Q?ief6LXWwh+UP+J1Z+UIyUT/H0Wbq70T1jJYssLv6gDe2Mo4Ugneiq9IZLqkT?=
 =?us-ascii?Q?zFX/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dezm7D0jxvNp10h2pG00mNS+3xmUwHPvXb1ynBYB1CpGJI0FWQLL7bNgd4W4?=
 =?us-ascii?Q?sjn9JQC0iLDa9UGhMECv7XOqSwzSppNmF0iCiobJPujR0cVZNJqpRKQG6cop?=
 =?us-ascii?Q?tLqRSke4gBGkXTY33707vGV/IPT2CFg7A/5Jx3Mbm+6Ybv09MEi91gub6QMU?=
 =?us-ascii?Q?R0zL9pws+pT3qVuo/MuRBrcJvfyJeeRtHqGfDNbOV7C3q7V3mbQtL/P4uml8?=
 =?us-ascii?Q?QlBrx5HKFkGgHPcqE8AvM/8o7iJ7EjqgREEB3rb+3guW8JlQ8bNsd0CFyMPe?=
 =?us-ascii?Q?SUjuTU1Zp0bPxGTl1y4qTcXOqsjPPlBFc6Xkw3nfcHs4Vu6JpJIdlQCcANZb?=
 =?us-ascii?Q?4rmKe5ynxmVe0Bo0IG/IglsWRrlLlajXil7HMgUWXlZJcyFOHhreUMzg1B/s?=
 =?us-ascii?Q?rqvYWV6O3npPVpYMD6RzcU4iO+FNSejvCmAeWT/z2KLvKVAx1mlqRUNiWqIW?=
 =?us-ascii?Q?sdGjUbhG3H7kjp3ynHkevtuu0CP1+vUIiUQ1/mvkYfbtkPIMpfMRim+Axzd/?=
 =?us-ascii?Q?EnCWZT8ezNrjv6pPBCmwmMkfmPIHoxHKHa+AH5TERnWTekaBks6iQzFKa4OS?=
 =?us-ascii?Q?rFhXfeMBYaMBCihbkCRHc9vGHtaSBBcEBL7RKz2IgOy3BjY4w0ywOa+EBXI5?=
 =?us-ascii?Q?7ouEaJoYX80NKtDqFOZZW22iCWCNUw4Os+yQvggyDdeS2qlmNIutluUuByTv?=
 =?us-ascii?Q?KXXMfIBGUUc7hsn1JjQ2JSKMTBz3xOPm+RywVS8u51GUgLC6IADL56VCvosm?=
 =?us-ascii?Q?XnWjKm+mBThH10hMDPXceOJnwOnO02Ozy4YiBKK9uMs9b1XOEhTuWFrceqNL?=
 =?us-ascii?Q?AN98NDWg8GmH+On04UP/qOV4xaGrfUnWyd9qATPIhyY1vubDOnMQQpPT8npY?=
 =?us-ascii?Q?HEoE9K5sqRkuP4ZjofP1daAb4kftlvwG+ZVp83s4GLfrgAKd0vPOalMsJ2uo?=
 =?us-ascii?Q?E/kz7CpwTU5Aytvdd8LvDVXK48VjtpvFqSQ7+miFK1Ls5mWSI60FBmzXmxXR?=
 =?us-ascii?Q?Egt2zxUGw343pip4KJMkY2WIIbb/QBLwfwMsHayYpUdoAUy4RoOs6yV7Ce2R?=
 =?us-ascii?Q?JwfX4ZKrWjkU4jXirdy4jD/CqrA2VXgIbvD6cTvvMJZOb5ATEhIWk+XMNZG1?=
 =?us-ascii?Q?CZUWaF0TBtPcPlzQHVM8r+gulenPinO94yiMAqEtGEjU4jFbj0l3gjPrbQSg?=
 =?us-ascii?Q?lwNvTVTAiYm2nH6cPUf4bM/kUQmEzwHVwMEC7EevBFRcuNwJLh2Yhl808AnN?=
 =?us-ascii?Q?WH6JZux9+Xd/JPQ47gwiX3tlRU+9G6Dm8dN0UMLD5ox2VqrBAgG+c7p8iE/c?=
 =?us-ascii?Q?0r1oFSSFRJ43MQ5RJjQoeT7rOapiC28gez/ydI+aBfAZSbDbm30kAjLgg93J?=
 =?us-ascii?Q?NS4dfmRnxLHwdLxRLIphy7uTjnT8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e03ef63-0bce-4b67-c871-08dee25119f3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:11:49.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658

From: Travor Liu <travor_lzh@outlook.com>

Diff index lines have included a trailing file mode since ec1fcc16af
(Show original and resulting blob object info in diff output,
2005-10-07) when the old and new file modes match:

    index <old>..<new> 100644

gitweb recognizes that trailing mode before it tries to shorten and
link the object IDs.  This appends the file-type annotation first, but
the object-ID matcher requires the ID range to end the line.  As a
result, this common form keeps both full object IDs as plain text.

That is inconsistent with other hash displays and makes commitdiff
output wider than necessary.  Recent gitweb changes have fixed mobile
overflow in log, commit, blob and diff views; leaving two full object
IDs in this header preserves an avoidable long line in the diff header.

Remove the trailing mode before matching the index IDs, then append it
again after the IDs have been shortened and linked.  This preserves the
mode display while letting ordinary and combined index lines use the
existing object-ID formatting paths.

Signed-off-by: Travor Liu <travor_lzh@outlook.com>
---
 gitweb/gitweb.perl | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fde8045..8c2d9b8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2339,12 +2339,14 @@ sub format_extended_diff_header_line {
 		$line .= $cgi->a({-href=>$to->{'href'}, -class=>"path"},
 		                 esc_path($to->{'file'}));
 	}
-	# match single <mode>
-	if ($line =~ m/\s(\d{6})$/) {
-		$line .= '<span class="info"> (' .
-		         file_type_long($1) .
-		         ')</span>';
+
+	# Temporarily remove a trailing <mode> so an index line ends with its
+	# object IDs and can be shortened below.
+	my $mode;
+	if ($line =~ s/\s(\d{6})$//) {
+		$mode = $1;
 	}
+
 	# match <hash>
 	if ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", ",") |
 	    $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", ",")) {
@@ -2388,6 +2390,12 @@ sub format_extended_diff_header_line {
 		my ($from_id, $to_id) = ($diffinfo->{'from_id'}, $diffinfo->{'to_id'});
 		$line =~ s!$from_id\.\.$to_id!$from_link..$to_link!;
 	}
+	if (defined $mode) {
+		$line .= " $mode" .
+		         '<span class="info"> (' .
+		         file_type_long($mode) .
+		         ')</span>';
+	}
 
 	return $line . "<br/>\n";
 }
-- 
2.52.0

