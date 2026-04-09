Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A72D7817
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740171; cv=fail; b=fSpI2cUWOdWexBiHiCboYIt5AoAOfrD9o/HpQdczwhviX190K+0s7LaPVakblTFPXtmlySZLBcvqQspbHX3NRVgwpWZKIni4TW5XSYU2SFzdTFEGg35q6YWAmn/Yf4jktV7NQW9kEU1zIKpWxkC/W9ltlFbJ9CFEPn3FSZijSOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740171; c=relaxed/simple;
	bh=0lMFK1rb1vc3f6fsKcSOdBRG9tQxpOGy5GZErEaNwyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAm/6UlwbjLocN5l861BM/ONC7j7dnvQmC501PKDmM9xzjIbP+IDwhV/LcqEal+aWUiqqRPQeP5/NLF7N+HCRNbcs65UmsCO2bSm/Kzj5SRTWhf07lyqk4PG8TcvgWbUL2R4UJS+f8FDflCW0AxjgU/foMXNlODEIvsw5wYecKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=GPy0QnSI; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="GPy0QnSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXCK3JdKO3Nt6cQyYw4N6JyIPhW6mXYlq/VFJRJ9muUy1LWZeO3H9I1V5pkg03nSkZggSFP/MHjbktZVbE+reBtadfNsUEgkaabaljmkx/dAFmhcmnZ2shirSbQv1pseJ5/YJm+o0a72DnlRJ2x52WBHV70Y98QdNNqz5CgiIOlOdZBFfSV6xl7UQ2sgkPntArOj7tB45gPyJ05m0iw/oxVLXka18MPzmg4Wpt/NW3LGHzCTclrwGup0wHiBZ46GW3kSSB8bpQBXKjKRQIpTRe9nySv9kD/oPtxF0ukfEBQm62ogeIf/jEVZK9hCJCDXhcHFF6Upb2JCwL5LfA+iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4DoecnManV27X8Z1egNxIzBiTopJ2sXW9nKLfmd3ss=;
 b=OV26BBqGJIj4vQEn6leuViC4e89MsP0aCPmwOtZDG1qADkXkS+gPpDMe/NTsRf/PdwlCXQWPTPPMRpziwet3uK6YSG3Upkq/venwsHt9En6/z+JUUh6ye0pPYYom7SOwkUpnkd420XTXKKhwRITanqHgl2tcjTN8hAUrgC8ugiTNTgkznwu516GCPqZ0CsXxtdeldP6O2YRZaJsNeRtZSWDxkRj4C1wh5RYI/h28Pm73+zytDxH7QFc0aECj93a/dlkPQh9uFlWNMsJRVSXYVp+ot+hABvJBoRk8J+gLCSCgRgZBH/KZ30K05tLSMzOUZUV7DvtvIqZqniu34/yGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4DoecnManV27X8Z1egNxIzBiTopJ2sXW9nKLfmd3ss=;
 b=GPy0QnSIOrAbdx7zsWCg0gd8I6UEdOVpeDWWnTngsNhVb9hACR+vIzVclKkUqaSZWIAerw0exkWSXb80FfVsGe+M2UVv3enldtaoW5+HKje08SYV4WMJtvaO71CNEM3du8+AfcHqMCKY/SVbjyuVLr/QHqekPditmssAzBLpsXg+3FITX7BLRIw3vpwhYhzmjcSu7KolijQbeVrvqjXJeQ2TtPcDKn5Vs7i4tPiLnAWHEuvHXUYkXyt8XWfnKNeCHQQU7LXXkRuy/3cSQ863+zVdkKn2sIRBHYGqnQabIF8OqYpZ6hkawPcqPSj12bYCIrvtbFh+Q00QYHoxdQ5jLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com (2603:10a6:10:479::19)
 by AS8PR03MB7521.eurprd03.prod.outlook.com (2603:10a6:20b:344::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Thu, 9 Apr
 2026 13:09:26 +0000
Received: from DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671]) by DU0PR03MB10187.eurprd03.prod.outlook.com
 ([fe80::764a:3e10:9b21:5671%3]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 13:09:26 +0000
From: Adrian Friedli <adrian.friedli@mt.com>
To: adrian.friedli@mt.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH] builtin/clone: fix segfault when using --revision on some servers
Date: Thu,  9 Apr 2026 15:09:04 +0200
Message-ID: <20260409130904.1811-1-adrian.friedli@mt.com>
X-Mailer: git-send-email 2.53.0.393.g795c338de7
In-Reply-To: <DB8SPR01MB0009F61C462C819CDFF80ED7EA44A@DB8SPR01MB0009.eurprd03.prod.outlook.com>
References: <DB8SPR01MB0009F61C462C819CDFF80ED7EA44A@DB8SPR01MB0009.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0128.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::7) To DU0PR03MB10187.eurprd03.prod.outlook.com
 (2603:10a6:10:479::19)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR03MB10187:EE_|AS8PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7c418a-8214-42fa-cd98-08de963939de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yrg1DO852j204hjx5tijrFhbAEI61+kboDwTUEvAEy4uk6usqTfmOMxrAe+hcaac+WlESA9h+2xK9i5pb4QYXcgDkvm9S4UwFhF6EI6nRKnpm926b+UpA0+kD7i/gyy0ADmrAXIk7nBKGjrRMOPzjhHmCRPebAGuVUZw6yzkV9CmaiyEb2iIfF83rvs8w6A5Me+Q+Mvo1gikuuzTiaEhdXDR3hi4VC8ktXk+Q2hIZ3lAULNMqn2fqPKiym455u0l/djpdACk19pu7uTuhmJ0CnQ6NKwZUG69eN9GM2EgaZNnAWHmmFg2oRkR1AULxYMxqL0lIwpNS50/ik6nDhTFrvx0E3oThht8s1DjW+WPcCi/PgBjHCN5U9EeLp1Nt/YwZ2YBirwEsue+BWfNwXOhZXHT0pRm9XAVjgZPzCQUFmXpprul/oiVt2RSqNCVoWed5GD+tER71PeBo1/w/ua1u9zB/QYv2nMHppbzoGEm+1UBEKuCh5xJZHnBKJVAz2uyer8CrbYWTy5zgVEvrKWobiwHUoP+XkzmTo7dmONC8k6d1XHAEpM1HM+3Nen4DnGzfviJYh7eRLk9fG1QLUV1q7IXJWLywR3WoEZrcQupP3aB4aPm3S8KQnkq/d0S9mNtPnIf6nTih/+xKpnDF+dRDJzSq0OfcK1KaQJJbSlIbWLRvyTw9jHCnjgpWTpNd/gWP33dkAeHu8gQLfuNpU+MreZUntpGAuzyVCCLRAruCio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR03MB10187.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNmjQnwmDbr+JfhgD9PgiLdhmPkhuM/SsjIbBS5KMT5PWCV3rGHi6RT4q50K?=
 =?us-ascii?Q?4a/MO2674VtkLoKxXdaSiU9b9F0qlr75nB55xk0hHEi7lYxld0qOnB9b2Exj?=
 =?us-ascii?Q?hxN4wqHinBZvrTD2txfFzqcevYa4l0ZaXOCXYakJ4hYLL/SXzgo8zd8wZcjS?=
 =?us-ascii?Q?t7AE+Dml7JDkOKkbRT5ZQcOgeWoe/arsuD29uU05kR0gYXXID/q/W3w+IYuE?=
 =?us-ascii?Q?s3/JQsjJLaWuOweWQ2nwaIwIkcHiZg6cynrH2T5vbqLgJuSNLgie9cBqoF9x?=
 =?us-ascii?Q?ovG3zUZ6oozWeMxrZmCHFwLivDS2lxwQlDBn3bJ1Ch8kbEGTrPCGauAyAS23?=
 =?us-ascii?Q?Q83ggnmHkP0ndGPdCThUkSkXOa+ShV6o5lrMNWWGdQdSizGDsAypKR8SA4IL?=
 =?us-ascii?Q?vFr8SmksHHsrNv2DpSJ5ZekWbcjYbUrlGKrF/t846fMcTrcnIKg+1g8e2X7c?=
 =?us-ascii?Q?Ux9gwwbjdnlluNuyKLwc9+XoUTxITfPY0dHce63FNpI3iMqfR2hSoexPDwF6?=
 =?us-ascii?Q?z5Sewm/oAd7+6o0tKMYYpSViQUYGjWfZBqxgaB1iPqIgWhRwNjFMRANE50xe?=
 =?us-ascii?Q?edwV8vGKPfT6qwxD3sLXxf9dZfYVbp/e5UjuBr1ky6500W6CtP5z+5+KXQju?=
 =?us-ascii?Q?xxmUypTOrZIkNExoit207T9RKhzQagSEiyFg0sx2tD5oD1e6Y/NoVtSjBMRC?=
 =?us-ascii?Q?Xv8Dl6gLBRW+rOARGllW1ABayXDxaQlUWfO5P6XgpJnLN520kzdpaLJaLvZL?=
 =?us-ascii?Q?zkLqUuaW1bLQuitjOf09AEWFWO9FFszPe7CWV10Mj7E+mtxGnT4I8SsnoHpW?=
 =?us-ascii?Q?dlRrrlPDFNoGlPPtIM1dfbUBJ1z4+z9rmEYda92aqdOeNPbeCHPqzNB3mJzF?=
 =?us-ascii?Q?24pUXRzRstfvn2pIxpOshlz+BUzM7rL0nbIcYQbPXmgTiKzZ6RP5rksfSvyt?=
 =?us-ascii?Q?sCd0xJ4jxKsUoA5snRWibxifW4y5nA6jTEB6aAuOu2LaCTBqRrjSNLWF1xVm?=
 =?us-ascii?Q?KqoIuHJGVPo0mgo/Bxg+i7i9KylM8mgHPgc+sruRFs16V9YZSu1vvHTbGFtq?=
 =?us-ascii?Q?ZEJycTz1ibTfNJVzeAwBB3SDF3X/jdNIsbzrvT+RQ6LJOk0IwqhQnX9thjGw?=
 =?us-ascii?Q?qfl2KhVME047tPNtckixOXT1qlJK5ZCIE2xhMrGfJZ2WFArsum6PAKjhod+r?=
 =?us-ascii?Q?aN+D5KqTCdrAk9xFk6tQ6hyz2iH7kyhPvv1vGSBxKq0rHEP0CRzzeF/xOuNY?=
 =?us-ascii?Q?HbOTEs8T9dI3fjbdfPdz3bEAG3hppCwzAxKw2nUSxs9uGdmdj1o4qPW2FzBW?=
 =?us-ascii?Q?bDBHV/aQhu37oTKi2WWwq/641hR+pmaFrEQBVABQZQOPC7WpR16uxnIFrkZX?=
 =?us-ascii?Q?4Hkt66e0razmWcZb8BCKSmsanhuxAYRDH2mgcoDvVXwE2eDPpELuatGseeOz?=
 =?us-ascii?Q?oy2mRQFzEXlmCSTzmJ4/VqwzWLiUz/+3fUMvKbYCPaXONfwoIHwccGhQ+rX1?=
 =?us-ascii?Q?IeQ0pDm6oJTBiE2EF1+1JstIuzT4PXYZKp1TaZgD0DCZO5WLyAbWJzXM79BG?=
 =?us-ascii?Q?60+DB2nOM8oO+dEiVxmY3dktv2iDZdJiexORWtEtQ5JkNPy+HXysGlWNk1u/?=
 =?us-ascii?Q?eLxk/MyqJlBzNTRm0iIyiotOQdJmTZbBmn6nVhvFBXlTOuccTu0XKY5Ksaf8?=
 =?us-ascii?Q?x7u/3nACcmMqKT8+EM9ikmzA7JJADP2r3rWhU2Db4C6IWuqRR7f89BkeFWja?=
 =?us-ascii?Q?6vOpI/2IrQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7c418a-8214-42fa-cd98-08de963939de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB10187.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:09:26.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUF/i79qNJpx5WJJYeZaNs2u3rqTApbYGTPoeJUlRi367cxi/UIKKDawk1lWMEMGaj4FjxFDcx00xde8qIgbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7521

> > > In the bad case the server ignores
> > > `transport_ls_refs_options.ref_prefixes` and in `cmd_clone()` the
> > > linked list `refs` returned by `transport_get_remote_refs()` contains
> > > many items, amongst others "HEAD". `remote_head` returned by
> > > `find_ref_by_name()` is not NULL and `remote_head_points_at` returned
> > > by `guess_remote_head()` is not NULL but its field `peer_ref` is NULL.
> > > Because `remote_head_points_at` is not NULL the guard in
> > > `update_remote_refs()` does not skip the affected code and
> > > `remote_head_points_at->peer_ref->name` is accessed, which causes a
> > > segfault later on.
> >
> > The description makes it sound more like this code is perfectly fine, and the
> > problem is in guess_remote_head() that reads the refs list and includes such a
> > bogus thing with no peer_ref in the result of its guessing.  There are 4 direct
> > callers to guess_remote_head() including this one---wouldn't they also obtain
> > a list with such a ref entry?
> 
> I traced the 3 other callers to guess_remote_head() and none of them has a
> problem if peer_ref is NULL. In get_expanded_map() there is even a condition
> `if (cpy->peer_ref)`, which indicates peer_ref is allowed to be NULL.

The details of the 4 callers to guess_remote_head()

builtin/fetch.c:set_head()
builtin/remote.c:get_head_names()

  refs from guess_remote_head() are only used with ref->name

builtin/clone.c:wanted_peer_refs()

  Does not use REMOTE_GUESS_HEAD_ALL flag in guess_remote_head() call. So only one ref is returned.

  calls get_fetch_map() with refs from guess_remote_head().
    may call get_expanded_map()
      safe if peer_ref is NULL, has a guard on the copy of ref `if (cpy->peer_ref)`.
    may call get_remote_ref()
      calls get_remote_ref()
        calls find_ref_by_name_abbrev()
	  only looks at name and next

builtin/clone.c:cmd_clone()

  Does not use REMOTE_GUESS_HEAD_ALL flag in guess_remote_head() call. So only one ref is returned.

  may call write_refspec_config() with refs from guess_remote_head()
    only uses name from refs

  calls update_remote_refs() with refs from guess_remote_head() 
  -> thats the failing one, no other uses

  may call update_head() with refs from guess_remote_head()
    only uses name and old_oid from refs

Kind regards
Adrian
