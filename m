Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFD433056
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896948; cv=fail; b=BCzdQI00JKR3sRsO3sfaxrQnADv3HxwudzSk1EeIMOIkrF4+9/ihkbg0ikKODF+H0653T91I/v+Y3wsNn1B4LXK4Yl5Xpd1IcUFGNZWg/GuuKMOIIH+H0X8DGH6XLhMT7wnsurBVdozfB5FDRKwjdKJgc74Vb+02SakVrfxw/wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896948; c=relaxed/simple;
	bh=oaK88sgQ7HR4uHh54mfpoAG8Tnrw4gk4xbdcAuQ5xRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cllLWjWqmxWB21bLSBvMX8mOtzi4W+Wr54U+hei41L0jTfDeOjfcHrT+7LVbxP9DYAKkuTVe7ZOeavWgdZw4Th5YDWuCnrIZVeT8GI/WFReqjnpwcsxfQCFwEFIhygdNxiL/Uq5Fi0Evkx7j60dkOTK2ZykOmVlUg9kpScYgS7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=BCauJ4DO; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="BCauJ4DO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OybVmK8r883oE6bynIZ04MyHanUt2YEv1d4F/ps3J7HyoDPw+gg1KfzGFnoG7KjpD8dL9upNBfGWxq+m6/6gUXbmWeloejgYT0BC7yVkqIxaH1JlCP+TPrK4FYRj66LcMloWGhkH0n5EuU74e8u2if/7vcRc0nZHk1YkxWu+CREoSqqTZBYmBLWxu/jblmsFOEF8SJ5FWY9duC50Npa3srOTWSQDRrBobQliOP7Pp1QgXlW3SwNfhupjtXQkUxM0yHNFbZ7KddAGqjvTLTHeKgnIrEFYG833zy2t1vA9ZQImiKU4Tu4juRtBEgSPSV0S7wVgamdM5cF4Q4Ul4KU11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC3msqukNnFfqPig736nfemZ8Aiu8G3U3zqZpx3QG+E=;
 b=DPdaAhE3S2EjPrC6bmAInV06wnPePT4UOBDpHlkaTDwt3V50wWRZanWdsErSuqW/k+4QImEHNo82x/CHQJKdMPM/lbYfDAEcaUUyh7eBYEJ3wUDxKHuAg7kA+w5vrU6WE7QsWBWBuG+SnrRY0QBRl5AiBocfUCnpGpAyEJCT/8Tb6EC/mxh/6vwnuVUMR0mTqAH3HzWiI8OXXbf1SR8V0gAbywWfDrMg5qh4d64o/+UCSVQ+ylcnhdiauGhkDJRT7sli6gdyTBXCDM9bVmDh/dOg9wG2AFTUnwSZm6z+TNjmdsxMsyimTVBNN6Yc9av9yitokU/sxPnnKkNHOxMOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC3msqukNnFfqPig736nfemZ8Aiu8G3U3zqZpx3QG+E=;
 b=BCauJ4DOaTZIeNw71shAd9vBWcGEEeb0csYO4aGJlOjyW8pfTZ1xLCnuRL2/VGPkUAFrKC8ih5pN/YtUtl/tEMXDX1XqaPhzQn6iq2gvvqRGHXhbYySiZtf2BEv3BIw0P4mt4gWaU1QE9Sq8BAbeuv3CGaWL07YZvEqOkFEGAQgCEjLWSAMwCrgtx7gn1XY80kefVlqY7Q6Z+Nndd1SxsfJ6Uxlnqy8QbfbcLQe4JFM8ADiX1NVplD9pJgA9jKcILgMj5wX5nPE3DcE/5K0A1OdHc0sCyJZQuQCiAXvIHm2lKVpBOkHpD+91TE6tjZ8jgKR0J+5e2SZgwRy9M1ivcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com (2603:10a6:10:479::19)
 by AS8PR03MB6999.eurprd03.prod.outlook.com (2603:10a6:20b:296::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:42:22 +0000
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671]) by DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:42:21 +0000
From: Adrian Friedli <adrian.friedli@mt.com>
To: git@vger.kernel.org
Cc: adrian.friedli@mt.com,
	gitster@pobox.com
Subject: [PATCH v2] builtin/clone: fix segfault when using --revision with protocol v0
Date: Fri, 24 Jul 2026 14:41:38 +0200
Message-ID: <20260724124138.666877-1-adrian.friedli@mt.com>
X-Mailer: git-send-email 2.55.0.379.g6d629a7221
In-Reply-To: <20260723144318.69007-1-adrian.friedli@mt.com>
References: <20260723144318.69007-1-adrian.friedli@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To DU0PR03MB10187.eurprd03.prod.outlook.com
 (2603:10a6:10:479::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR03MB10187:EE_|AS8PR03MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 060f3cab-b4aa-49dc-70e7-08dee981010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|19092799006|376014|1800799024|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4bd5GSmmThpcx/5oIMurzkGqew5jzRqhAT14WCNNksoJdo09djgIY8EPvsu0TRaTo6hNXS5hfMwknoq00hiyIqEVIF2WGjylHMTklvCATA4gf2Gl0sE/hVK/2F29oQElWrJEq0ESiahxEEPsTYIBA8OcprMvwrXYDk4jkKEEFnrbAD31ODZ4rcZ9Vq+9QXN2GdXbhn8aRg+U+r3Oxppy4A8qsJCTwkswU8h6QvhHVJhvkQ0V1VFtQitDIajqBBsQtYa0U3r2t3ZO/4D4DCpdNvHMHFStBtq8/pdkG0PHXRP7D1Rp/G7kbQhPahE1Kyx/T8O8ELUuMttom34qJMzQa7KGT03gZH4jFq3oyz7X/IWkFFE6LhshzOoKhu+6LirPX5MRsHK4fADpv+csZJpdAhcPgOfUJZmGdHkE+9rPW9wm2X1PJ59TAe0vGiGFBurQnbZYoAc6fW+t4pTJwPkDuJ/zhVIozpIDw+MfYCO+DCvnGoeTC0xfOZ+NuCh4IAnYnBLPZ9j3q7MCSTBWWpA/TOves1wHoIOkHkGXjLz2KEqEe27dWRonJbB395xCozUk4+0cHaZqbKKgcE/lgsKaLLo6b485xOGoLv2My3s82Y4ovrxr7zSJU6Fiv5eL78daKlazWWA9QJ6OkHmaTBEp/yGI9+/jBX4ZSZ42OyV8iC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB10187.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B29cmxnWwrdwdcJ1FzN6fX1jyQ5bZJwy73ETGToHACOKToSndKozeZvPoJPd?=
 =?us-ascii?Q?+4XtlKZB6uxDM6QpDhcc1TQVg+48oZ7xHV2i+7LDRmRnCIgVGih2lTr7cYHo?=
 =?us-ascii?Q?YOzzq+NBQWPehsA9k3FQsRsT9Oga+OAB8KOk+2dE6t3VEcUUg/ABSeLRSylk?=
 =?us-ascii?Q?FJZq+XwzDVcGj2BqdHWLMBWvVEesPviLIDI4jproeXj5TzmHAxtNsF1LYe6Y?=
 =?us-ascii?Q?+jxKsCurD3PMdN8sskPTBfAEwrE6eDB4xlKgTLdDRvtsB49r+hKThaBZad4x?=
 =?us-ascii?Q?+pDOsRBvVIGs5b3E5JjnKqA/SwmeOSHDh75v9NMEVblIZweOY8O2cQ/r4PWE?=
 =?us-ascii?Q?f/RU19PTPbmdF9onLIrDEWNDuPQC68xTjtryKArCF6avMvp3QsnPBUHm1Hig?=
 =?us-ascii?Q?bL/qy+y+R96/1v2Ut59HRh7xrzjfyUKbfz5YVGUqT6yzhFDbIDHzz8w4DWF2?=
 =?us-ascii?Q?zPZG6bln5XLJ4I5N8xz2hpOVTbe36OMMv2lcrtAXm7c3tGWLk/vWwC0YbsS3?=
 =?us-ascii?Q?9SeWUqUdAJUzzT+XJdWmfVmLZwmGqgX7jrjFmofC8wYYbeqNF6Us8uQhJO0t?=
 =?us-ascii?Q?WiGj1+ACkXGFlvPUKFChmZabq0IMXY34lAf0AzRnh7NP9hIA9RvqPiql5+dK?=
 =?us-ascii?Q?5hS0q7v1Y5WKmgkupoqpBWC6/NSaMaKhjfZDgXjhSee/IbC73/nJ0dUac6Fb?=
 =?us-ascii?Q?z7q/S2371UuZ26MJIcnqbRmI3NRyueocbA9fqEiWHXBOChegDmuiB/MPDkIx?=
 =?us-ascii?Q?7HgOIiwlF7PpygXzHP4jGV/xxStRWRom518vb7nQxWnIOLI1muAxPMRYQdi2?=
 =?us-ascii?Q?tFmltrLb1s/sOCSplZp9NxFtIW7akFuDqHnICDfyfYgR4pTT56Nq310p1clJ?=
 =?us-ascii?Q?3xf/N9d0eq8kZQvWMaAWXrEpcxce7tlysdOuU0S8mQBgcsEiJ9gyuQOtIUFl?=
 =?us-ascii?Q?uRcAbT0iMqA50ZgW+5FC0jTsjcs0QirKzlFe5BXUKxieP3l+dOI5va5mn7+E?=
 =?us-ascii?Q?FNHBUfrKoYE7eEM30F1olWJ8coVDbEdXVAQebSBZIDRR+momO5yJe+XC+Sdl?=
 =?us-ascii?Q?7FvToiqIpwEBhdHm9dAAfmxB6EOEXLc/e1aI/zKYNH4ROBtXYg1ulENG3bp4?=
 =?us-ascii?Q?N2gRAM517BJhmxFrGtqzfk47wi876JsTlwTj9Wq5ev3n8fbg4ovqDpKwYI9X?=
 =?us-ascii?Q?M6aJKIDIFDOW3miq08a7BIXwNz0S6P0Z/spvH10wzbN3pF7KNSaLJ28ze6XG?=
 =?us-ascii?Q?749+vwBPeiG/mxVtoZbE2KllDSWhRdhz8MTt+U0iag+x3r+BiF42DzWz+v6l?=
 =?us-ascii?Q?aT4mGESm5N4SDA3yejiTrlhlYN7y7wU73uQpQmplZWVg1i6NnbdjbwueOJJ0?=
 =?us-ascii?Q?gf0e2yKO4/O3nkFXkA6FAEcCXSx4M9bSOSbceAKTGJwL2lKuBLsG/fUbTrfw?=
 =?us-ascii?Q?gtffWb1vPP+Ki7z3SAJ2h1bHQvk4RRW5iJ1AfTsObFviOlLwU95LISOUbxDV?=
 =?us-ascii?Q?fL6EW3DYw+xtT/2eo/LxNoAY23HU2xgqqGp72LXIOaEMrPxw5tc/shKo6/ab?=
 =?us-ascii?Q?Kddoo9fkLvIk+ekC63w6lJMAHfs/o1DcqPmbZfETuOokD/r4UZHPlnHNaCDt?=
 =?us-ascii?Q?FjQIzhpDH+CMh50t8QlTI6V0fDy5dZVCwofSiVQXEOyQ2EWbxQrs3+sdtFxr?=
 =?us-ascii?Q?02rYxR2EL7Rt4ng6+/lxhyTRP0a0v+i/iIR1I7s97wR1IdSFormt7SjVaknH?=
 =?us-ascii?Q?sXstpAZJww=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f3cab-b4aa-49dc-70e7-08dee981010b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB10187.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:42:21.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/gdiw6kmxgVnvfgoJsV9FRVYcLUTmt19g0M22fZmVAQcUuTJnmd4bjMdU5SxkT6sDqi3zjzwld3XLDb35G5tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6999

Servers supporting protocol v2 do not advertise excess refs and honor
`transport_ls_refs_options.ref_prefixes` when

    $ git clone --revision=refs/heads/main $URL

contacts them, but when talking to a server that does not support
protocol v2 the client segfaults. This can also be observed when v0 is
enforced for example by

    $ git -c protocol.version=0 clone --revision=refs/heads/main $URL

In the protocol v2 case the server honors
`transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
list `refs` returned by `transport_get_remote_refs()` only contains a
single item, which is the ref requested with the --revision argument.
Both `remote_head` returned by `find_ref_by_name()` and
`remote_head_points_at` returned by `guess_remote_head()` are NULL. The
guard in `update_remote_refs()` skips a the affected code because
`remote_head_points_at` is NULL.

In the protocol v0 case in `cmd_clone()` the linked list `refs` returned
by `transport_get_remote_refs()` contains many items, amongst others
"HEAD". `remote_head` returned by `find_ref_by_name()` is not NULL and
`remote_head_points_at` returned by `guess_remote_head()` is not NULL
but its field `peer_ref` is NULL. Because `remote_head_points_at` is not
NULL the guard in `update_remote_refs()` does not skip the affected code
and `remote_head_points_at->peer_ref->name` is accessed, which causes a
segfault later on.

Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
---
 builtin/clone.c           | 2 +-
 t/t5621-clone-revision.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9d08cd8722..bd0c6f5d56 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -557,7 +557,7 @@ static void update_remote_refs(const struct ref *refs,
 			write_followtags(refs, msg);
 	}
 
-	if (remote_head_points_at && !option_bare) {
+	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");
diff --git a/t/t5621-clone-revision.sh b/t/t5621-clone-revision.sh
index db3b8cff55..54789423f8 100755
--- a/t/t5621-clone-revision.sh
+++ b/t/t5621-clone-revision.sh
@@ -90,6 +90,14 @@ test_expect_success 'clone with --revision and --bare' '
 	test_must_fail git -C dst config remote.origin.fetch
 '
 
+test_expect_success 'clone with --revision and protocol v0' '
+	test_when_finished "rm -rf dst" &&
+	git -c protocol.version=0 clone --no-local --revision=refs/heads/main . dst &&
+	git rev-parse refs/heads/main >expect &&
+	git -C dst rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone with --revision being a short raw commit hash' '
 	test_when_finished "rm -rf dst" &&
 	oid=$(git rev-parse --short refs/heads/feature) &&

Range-diff against v1:
1:  f300b7b968 ! 1:  1a7cd98b7a builtin/clone: fix segfault when using --revision on some servers
    @@ Metadata
     Author: Adrian Friedli <adrian.friedli@mt.com>
     
      ## Commit message ##
    -    builtin/clone: fix segfault when using --revision on some servers
    +    builtin/clone: fix segfault when using --revision with protocol v0
     
    -    Fix a segfault when a server advertises more refs than requested when
    -    using the --revision argument.
    +    Servers supporting protocol v2 do not advertise excess refs and honor
    +    `transport_ls_refs_options.ref_prefixes` when
    +
    +        $ git clone --revision=refs/heads/main $URL
    +
    +    contacts them, but when talking to a server that does not support
    +    protocol v2 the client segfaults. This can also be observed when v0 is
    +    enforced for example by
    +
    +        $ git -c protocol.version=0 clone --revision=refs/heads/main $URL
    +
    +    In the protocol v2 case the server honors
    +    `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the linked
    +    list `refs` returned by `transport_get_remote_refs()` only contains a
    +    single item, which is the ref requested with the --revision argument.
    +    Both `remote_head` returned by `find_ref_by_name()` and
    +    `remote_head_points_at` returned by `guess_remote_head()` are NULL. The
    +    guard in `update_remote_refs()` skips a the affected code because
    +    `remote_head_points_at` is NULL.
    +
    +    In the protocol v0 case in `cmd_clone()` the linked list `refs` returned
    +    by `transport_get_remote_refs()` contains many items, amongst others
    +    "HEAD". `remote_head` returned by `find_ref_by_name()` is not NULL and
    +    `remote_head_points_at` returned by `guess_remote_head()` is not NULL
    +    but its field `peer_ref` is NULL. Because `remote_head_points_at` is not
    +    NULL the guard in `update_remote_refs()` does not skip the affected code
    +    and `remote_head_points_at->peer_ref->name` is accessed, which causes a
    +    segfault later on.
     
         Signed-off-by: Adrian Friedli <adrian.friedli@mt.com>
     
    @@ builtin/clone.c: static void update_remote_refs(const struct ref *refs,
      		struct strbuf head_ref = STRBUF_INIT;
      		strbuf_addstr(&head_ref, branch_top);
      		strbuf_addstr(&head_ref, "HEAD");
    +
    + ## t/t5621-clone-revision.sh ##
    +@@ t/t5621-clone-revision.sh: test_expect_success 'clone with --revision and --bare' '
    + 	test_must_fail git -C dst config remote.origin.fetch
    + '
    + 
    ++test_expect_success 'clone with --revision and protocol v0' '
    ++	test_when_finished "rm -rf dst" &&
    ++	git -c protocol.version=0 clone --no-local --revision=refs/heads/main . dst &&
    ++	git rev-parse refs/heads/main >expect &&
    ++	git -C dst rev-parse HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'clone with --revision being a short raw commit hash' '
    + 	test_when_finished "rm -rf dst" &&
    + 	oid=$(git rev-parse --short refs/heads/feature) &&
-- 
2.55.0.379.g6d629a7221

