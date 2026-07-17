Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020530E835
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296397; cv=fail; b=qHIGXUrQQo+A15f2Cw51l0wMm75L3u8MaonaZL7AarW2myEuA+i16TRTjgoTmfxd0Ti3KXWNeqlOTM2XXwo5+Hm8qSy9r2Bypuca0w5srGlFkKNMaSCgd+ORwjQDpNOFpmgpM0+1JIBqGRHkXnBq3pc9sPcykvDQfHorkhdYeWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296397; c=relaxed/simple;
	bh=AzMDArr+vZJuyh9dMIi37Qbdk08LGoGKORu6fN0h+es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKt1a/6hkW8WQYjezCz4gp64cq51g/ymssuVcqRNX1c1TnvXEnD/7i7iqZRiMqHQcplMzuGoWdHY8d3MWuDAU14/fmaHdteseS1rKEnu/EJnAIugjEWZCcga6Yls4ZnIperLSbBL64zDcnqUg2tPattDXcuUt3IUanl/Lw4tU1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sYHEk4N3; arc=fail smtp.client-ip=52.103.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sYHEk4N3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab/QSZx+0Uz3WJhodlxi6g6bxtQMYr1EYPQp1M5+X6c7mGCpaQt46SfpNSaFuhN1AoWk9BFHFbwA1qaJ3DYmLhQCwq/FnmN5KqWHsGEhtTO3ccho0A20xjX6CW7O6f80hz1H38Q2DhlnEVdU4uWJucPsHtn/3pxcgui8QaEvL9HpZd552zbviNUm4NgsJX9TfIbW6OKaO1Sz+T/oCj4+8NtCde5Ra+EQFboxxJxlg1uXkul3KtN/v04mZxJwF6YGmuZmqhyNadeXHsqWHj2bfBLD3LDcNmufcO5HTzZ5UZss/g4x/Z6bdiGtft2OeMesn2QPe5DRR4FqDuY2C97tIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuy6sOv0bpt17ek+sBVjTIZ2Ofx2jiawuwnKQscuBVM=;
 b=kcmES3xOFg5mwy4Pb7LEy5VlsX82nLloZZbw8dyHGjL3hpLXwMUUBG7zcBMEI59vpNrY2LqDOuKGKDq/gnT8mTDfFYfmzTNAOQs0FwH66TPKplMQ8YeB9Qkv1CovIu3rMIRZzvVs64pcajiBYSe6T5Ei1+ffkVWfxcVV8fmc27rX08KJ0rXbPGzDTesTmi9OyfBFyp9HefDByJcPsAQehxPLM0jOdUtLyTubDnT7Ahhdhw7MoptjOgGAVtkovFy5etI+8ngDkm3PZ0TK2RwONdObV5LwZXsXuQMoAMOYhr0ijphPi3BtmQXXK+0nyMArnF7UGUl8agpDiikg7mUQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuy6sOv0bpt17ek+sBVjTIZ2Ofx2jiawuwnKQscuBVM=;
 b=sYHEk4N38SCAaJmIFBtHbI4cJaNi/EnLTfy2aSlUUwdM/5EKmmqamXVdMJBUh17218piOMmo5Px1s3D4voVBN5yEf0ghpRHyzf28nX+d5Y3p4E0wQZDqRRuCP6NyZIFniTHC7VPEokDQmHWYsN6zMnN7hRAJaxNPcz55jPy5dlQP9EomF8DTMfaXc/eA2fUz4K6R/2uBCYrCgTt+DXG7+t/umyDfVHefxnBYVltn7NRFj873hdWuCD0PWWjhArPX7irBoO+z74jN8sQlr+g8eCke3JNs4ULN5C1Xv2NkEx+NQXmBi5jPw5WoyQ+1+YgmednLft88waJnat2N55mQsw==
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9) by BLAPR10MB4980.namprd10.prod.outlook.com
 (2603:10b6:208:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 13:53:13 +0000
Received: from SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f]) by SA1PR10MB997715.namprd10.prod.outlook.com
 ([fe80::4963:e69b:5c7f:404f%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:13 +0000
From: Travor Liu <travor_lzh@outlook.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Travor Liu <travor_lzh@outlook.com>
Subject: [PATCH v2] gitweb: shorten index hashes with trailing file modes
Date: Fri, 17 Jul 2026 21:52:45 +0800
Message-ID:
 <SA1PR10MB9977150C823C0751E53B150D5AF1C62@SA1PR10MB997715.namprd10.prod.outlook.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
References: <SA1PR10MB997715AD62D7F2AF64EB1A9887F1F82@SA1PR10MB997715.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0147.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::12) To SA1PR10MB997715.namprd10.prod.outlook.com
 (2603:10b6:806:4c0::9)
X-Microsoft-Original-Message-ID:
 <20260717135245.22452-1-travor_lzh@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB997715:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bab902-e379-4f0f-1fb5-08dee40abea2
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRoSyndlTT92K84OJqLUkneIMcigVYzdWPzVpqIU0M9EUDOQc3imVu/obGLPU+Nbq3WZ+53QbBl/bv1MKUM016nSbYTntC+I1vrBeyhu0HIdUcUMvpVGpykteTzAk4gM5AIPBpBcJrsS1HRUq6j2f4EKijsFynZUGsq8opPYpcDE5MjEBPzASSpTlr+vs0m/W3XZgWJOP6DRc6ZfOz/1AirXE9xu781aJ8d/SBzDVd0envw4fkBwibR1Ak6GE57hnz/CA+B0pA6Byc0U2/xYVZzyBk1NZvtyL7MvUW4JKTm4Jlny6g7dwTwNWPtZ+CWXYbOu8PeCViXjimV235heKE1i1Hb9vPvaONfaIwvC+okB87WkzZS3jOySB9Cf30RiB0DtbcRAVJNu7ofHqMq5VICTu1B9hJLw22XbKDexJpzueSh0Q8vibG6xFEb69e6PPBMKD/MUPMjI4w9zTfQHrAOg9oQMNVoMKiPZZSGAfbXYu1CYrN5Qi5EbrIH1cI13lZh5ButPJ1zzPs1ZoqiaMmaNLLz3URmQIggHHOx8dpwwrf9HHRlVh6/Nl2hmxK/pkGbebPdbsbkawENaVxXAXbVbn+H3XAUCyX50zgSh8rYchL/mbgr+PHWd48jAOAdzxmMaFE8Bnv69+CL0mbsnzW/PWYxQlgrh+mZ3LWci0+JcqYE7+leUf78fCRzH97lEe7Pt5pu27HdnV8SzQ1Mifct5N6MzHvBSZIlKFvG87UHoY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|19110799012|15080799012|5072599009|25010399006|24021099003|23021999003|41001999006|51005399006|8060799015|12121999013|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DnMCMxd9jaIqqImfnr9wrtbr8kx2xd3B+8FPQWE5V+zTz9FbncLtpLTcsazj?=
 =?us-ascii?Q?nZ/7GQfQXebXxUcgJR2H6mSINOCVqF/uirqTE1lljoPjNdNXvqmotnuoA8yx?=
 =?us-ascii?Q?dxIVqXPFwys3A3VzvecEKzTz+ZqpF4eaN44PBpG7Otkrjyt/d0q8H+3P8jXL?=
 =?us-ascii?Q?V6c/9doNq/uAV3QM39SzJaWmRuqF4ICW6qKIVBeHAgljHD0Fmc7l2910wYjU?=
 =?us-ascii?Q?rkfn6yR2bX2Wmy1ElFuFlIvaTWHSx07chb4RxrFRsvGj33NIrb2vHJm3exK8?=
 =?us-ascii?Q?utH2vJ1FtCykT2WiUFEIDwNypzr/0YSKppGT9XW6xgxVr2chihshv3wKzlPL?=
 =?us-ascii?Q?aa+2bP45dkjEeQ0RiTaEsl7zaWzDpAGEc1cPVPhAsSL2lHpHBYTk7Mu6QviC?=
 =?us-ascii?Q?YV0Ln8ZPL1gCvuG6bxyGgGmzYBmTJn3xJARZ3PmUGsFbGKxHj54Wcvlj4vzT?=
 =?us-ascii?Q?rttGOhn0nzoeGx/lDjhriFPIvtZgEYDqWe/yHmlc8hyCiFyCYyMZuPQiPqe/?=
 =?us-ascii?Q?j7Rlc7Y0+jSPInn6pbXbGaEPTtJUuAcQ4Tx+CVyMVeImevRzAplgqvk1QR0E?=
 =?us-ascii?Q?JeYhJKQI22wHCEqd+AuB49XIeoQv1tnb+ws8Dwh7KCP89o4BLDgMfEMsAFEU?=
 =?us-ascii?Q?lFsBRNN65Ytwuqxal0LrB4CzAQhQWw0J4SeAX2Nsaf3VgcsC+hEClxFhox1L?=
 =?us-ascii?Q?fmiECWoWc0g7QYgaxz9495RRdU+9My8vN5YJYQ0L9HPO5C4M684ivQ4KCvL/?=
 =?us-ascii?Q?27RbwfNT1EyTCB+/RTIOIxz2/qK+3yu+JK6bs8dwxZ27RzXwQCzAOvg57T8p?=
 =?us-ascii?Q?GbwUrqcaKq+7wmNkOzgL80TVNtqd6R0Gw2M9u/QajeJqnLId6n8ZVw0GSLx7?=
 =?us-ascii?Q?mcMwaSVZ1Sd/7KHl5h6waOTKgClRhaVg9R34lt5mU08a7HT1WhU0ro9tjWv9?=
 =?us-ascii?Q?PyOlsc6fs6SGMFBzbDzLEcvw4jf863dcC788GVNW5M+tLDd7Q0gHIReGR2hB?=
 =?us-ascii?Q?Q2CbwBbhsAHrRCIRIaxcfJHB8lnGwcOZlSfV2In6uR0JNzw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwnvZppzfbNseWvARDz9W99rDBST+qY90M+0e+MLxhNiXypH5+kgt7L0k7Nj?=
 =?us-ascii?Q?tp5WMDLDPwBEZqN6SfX41rO7rMSoWGFthNbgXUfMIPv7Sbma5/kMCILZ6GST?=
 =?us-ascii?Q?F/M2rdjyFHJ3qUAsIN67q3VYsNFbixIbvQgdvwI0h23aDeMBYZ09baqlTzuI?=
 =?us-ascii?Q?1e9eUXb0ShDACvv59gd2Fy7SAftnUBbvHXj6Bbw2ujC2Ao6ubGToiAzfiJ7S?=
 =?us-ascii?Q?v0LgpLg06fcYbmMkDmytIJpj4VWiUvf93jy+fzch4/dzodeZqoH7fTJBcoKT?=
 =?us-ascii?Q?zYSRUhZyoIOmJSRIYPSdli4qk3ao1J/RJ+qOg4jM+5LT/d7F+LeseD15OJJy?=
 =?us-ascii?Q?2KDunrOpcQxdZQHpSt2pW2epV2kFgzKkkdrTOCerZXl8U7pc+Vo3XMusG4u9?=
 =?us-ascii?Q?1ayb9rsN2JDPhmGoCgE+WEkOaxG6B0MevtYfTZzUICRDIso0ZtOXtf4VX5rn?=
 =?us-ascii?Q?JjZtRaokLmdeJHFYEOWweggXkPitT6v6w3EkfdEKvPcjMnnjrtjamj+t2Mtv?=
 =?us-ascii?Q?IRHfmRJo4kU0PD7yqk0dd3VTVoFju9x3jpSw/bsETgjuMZQp5LuwQoddoeTK?=
 =?us-ascii?Q?zgBj+uU7G7TFz9+1pmXL86Nya60nTnwNmLviHmBDZ1tWIB7lh4MzoFfrWaVM?=
 =?us-ascii?Q?vlMO+Qoy0j1yBkuiNswf7ICK3FJbxTY/Z5rll//5Pk3NUvkxy+asvrBodRv4?=
 =?us-ascii?Q?Q3wZlQGx1LVONnyMW6XRMUdmvndIsP+ecNTe3vRauWl39hpDMurT4/pw3F7M?=
 =?us-ascii?Q?c3JA0vKLo99zXK/saFnq3T5CgU3+ugI6w8Q4YqIkGnOB1vlem9bVfJ8NKJ30?=
 =?us-ascii?Q?vGGrDIvcBlQSF0DjhzT+PsemHZ4qvqyeK1hEaBaYstKYJfeSmbbgUvei04QF?=
 =?us-ascii?Q?qRS0WHutH6jx2o9ToCSlqv5Fhevzqa2SNZKFuGb2i8q+P4fG4xYrcciNI2Wb?=
 =?us-ascii?Q?oR6UYViUSXQ4wA6f/gLi0S9Ws+l7hnVG7i3nee2iVjFM+HuVHIOtrIL0jxfF?=
 =?us-ascii?Q?SG6XeJbFc9Y6jk/Y4g9W1Gxcvw5lt0ew9o+PwiOlpSZJKCUytxfJ2gRx1UsJ?=
 =?us-ascii?Q?74NSJ+i+kRIb7QRMWiRQUlNckYSJY7N8W3Q9RMBQMeBfP9CXWIYMpjRU4hHg?=
 =?us-ascii?Q?6CiKZAjU+eunps0cKZePq+GqgrGr71YPY3Po7eSW+IuMN62//0bCxjJxFhEI?=
 =?us-ascii?Q?tgvyoj+SYM0BhpCqSkg7CjlV1aR7PWRhTsaBSC2lAuoE3xyPKGrVbA78jI3h?=
 =?us-ascii?Q?TuLlZLwhdF50/d7vaOGCrK835uw0JCYLqGKuOLoSFhVA0WebdkuS2t7/Ct1L?=
 =?us-ascii?Q?tbfS22/h4EiSX/3myzgQRDuYxKAgbc8k6jAKI31MdXE4H/65abAGQI+agsyp?=
 =?us-ascii?Q?dDDE8+ukdfsKqGIHqNCzgFTtWZ/i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bab902-e379-4f0f-1fb5-08dee40abea2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB997715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:13.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980

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

* gitweb/gitweb.perl: Remove the trailing mode before matching the index
IDs, then append it again after the IDs have been shortened and linked.
This preserves the mode display while letting ordinary and combined
index lines use the existing object-ID formatting paths.

* t/t9502-gitweb-standalone-parse-output.sh: Add coverage for that
common form by rendering a commitdiff for a regular file modification.
Check that the visible index line contains linked short blob IDs
followed by the mode and file-type annotation, and that the full
unlinked form is not emitted.

Signed-off-by: Travor Liu <travor_lzh@outlook.com>
---
Changes since v1:
- Squashed the regression test into the implementation patch.
- Replaced raw grep invocations with test_grep.

 gitweb/gitweb.perl                        | 18 +++++++++++++-----
 t/t9502-gitweb-standalone-parse-output.sh | 13 +++++++++++++
 2 files changed, 26 insertions(+), 5 deletions(-)

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
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 81d5625..85f7716 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -115,6 +115,19 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+test_expect_success 'commitdiff: index line shortens hashes with mode' '
+	old_blob=$(git rev-parse HEAD:foo) &&
+	old_short=$(git rev-parse --short=7 HEAD:foo) &&
+	echo changed >foo &&
+	git commit -am "change foo" &&
+	new_blob=$(git rev-parse HEAD:foo) &&
+	new_short=$(git rev-parse --short=7 HEAD:foo) &&
+	gitweb_run "p=.git;a=commitdiff;h=HEAD" &&
+	test_grep ">${old_short}</a>\\.\\.<a [^>]*>${new_short}</a> 100644<span class=\"info\"> (file)</span>" \
+		gitweb.body &&
+	test_grep ! "index ${old_blob}\\.\\.${new_blob} 100644" gitweb.body
+'
+
 # ----------------------------------------------------------------------
 # forks of projects
 
-- 
2.52.0

