Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B3243376
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171932; cv=fail; b=eVDrQXNIglj8ItkqYNE4A3CseUSO4ntNN/XgVnNCOxdMXZGBlyoe+QvK0q+cngBSkX26yiW9nQ1kM6mZ/Vrf3OGaeJKDJnwTQkCroWKE1JGMwsWZUWu1VnPPFi8epy5CYZ1zgU6Ho5vhUDtgDxHZ/Hab/Wm9bm7JRkg0ApEQThs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171932; c=relaxed/simple;
	bh=hh48+z8tnlB0wydcPBwocTE7y34PhRNrWB8lIlR37mQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Q0T89C0Ae54nIskIpE8jP/Yi5y19hguegMD/XhOTS4lM5+eTNs0jjzITORheZLPtAHvkg3ot7CTdF2VrVH4OD4dZQoUsIV4zv9/U5boy9G0VX42BLE0KMrfaVPUGYGhLOlMDJj3PLnMxPPtEeEmAf6CPzEyLXfrM5VmXTq2l/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=HuOWmocD; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="HuOWmocD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWuLKyYolk6qh/QtOE1/UEvdA/Cnn0ReqN1pqDj8CKoIVuZzP0mSXrKY1jj4QH2feT/gZNbvZ56fAcKr+INPlXyjxBT7awxlT/W5J2D8FxKezl+b+ibnfDMV/SJig8lcgtwpbqxBHV84eO/ExHYkQkXLQNkXw8XvVE1qkUwVD07wYe+fPW3mcI4mwDodsKgnAAAbw6TmQq3AWGuOOYSnY8SWWCGMFyEOvQxEOSkVWrxvPer3W9wN9+hK7XGY/Kp+UG/ZoA3FXuEEZGQGhnnvm6Z1cU0IBZgG1+V6eJb+oKSzUISmUzuVsze2dzZYDMbYZNgOsVenzJCkNEj3Q1TO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlu+OM/eQArNPZ2QkshKK64Des8H9rbdiwLo1yNb0nU=;
 b=xHA/fJiaxIIq1uxNnhIpn7qm4PN95ASrgMaHayUD4CPEdxKcmjEW8CqJ1bzRBrGYPAAiZDLfL2I2epzOK1QBbLwOIEuDlXMC9FevGWusETqThLt5Ttv+LWsbkz1cCJaXjoGBviNQ3bTGa9At6SIMUVRMI3B0129j5IC8vSC3y+NckJ2lxQrWkPcEmHM/pdZ1StOH5U4FiHT/6Pq+UFjeeVS0/qFcK+6izEaz/0sn8zPRIvPx6oQ4jGjrzqNjRN14F955cW6YEuUxy1SYbZmCMPMh3M+p53j5hGWW9px416fMfiyyxzLqE503TIUfm/Vdtjiq1LSOyo+7fxX9VqNxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlu+OM/eQArNPZ2QkshKK64Des8H9rbdiwLo1yNb0nU=;
 b=HuOWmocDeUg3JIdyI6CsonsCGEwXf8GgO2VGiVn5x4cCUurh/tRkVzxWUvfCsp4bJKVBk9Ie8LyhyrsBZkvxrYvirvsdIiRjhd/HdnoKLCLlbgI8mvn97U2Cc/alTfE3WbUBudl5J5EacYwhG5h7U03D0suYf4nrLw9NMOfMO9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5894.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:516::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 06:25:24 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:25:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Daniel Mach <daniel.mach@suse.com>
Subject: Re: [PATCH] commit: fall back to full read when maybe_tree is NULL
In-Reply-To: <20260519050513.GA1635924@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 May 2026 01:05:13 -0400")
References: <20260519050513.GA1635924@coredump.intra.peff.net>
Date: Tue, 19 May 2026 08:25:21 +0200
Message-ID: <87o6ibex0u.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBFE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::319) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 19114b8e-be0c-4ba7-361d-08deb56f68e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|11063799003|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	138PlcxajdebEqE5KJS5S2rlbOOefFCURBCR+IeRXYHc/YtkQZEA7bNmIZPAJfoziOwlWeIiFBIl2IClGgSKo6n5qq3vRmLmaQN5exl5yxcTvsUEJzFAXAbgv8TF6c5bGXhdM6JHHosHdMEMf8JLwBJ+2XH+WshWp9CJfdAPXfWSXHuE6hyGUhMXmic7vlq/QCccEr9t3JOjUeFz6vT+ef2RgG8oBenP24Z2tcYu7EEWJhgyEkioTBaWL2B6xo/HLezSmK/fjNlbcJV99OPmAUgBLv4LaChwaiKOUZCt1yVb22bTu6SoKfBITwPK+p96KtEHKZB69JpER4VEXa+jcBwdd7GBT+eWr+vsLPM9y5G1rFv+4tr9aBJqig7M5MBZcVjJ84iDmwqAsdcDnqvDyb4vk3ocofeFkjDvw24l2JTO8kx1E36gQvfVHhaL1jI6liCaZst4gE2hX6XSd+FObfZnGrejgdGMPFoO1TKW3qCMm5GDeBFhCNojUSGX+fMEy4eX1Eas/JG8b4wQD1JIkZc+Zksjs9ZwbfAmhlazWpqlJJSIQTsrz0eC30hoagX6419U7EwybvxSEuC7WsQHpQLvOCk+BbunZb+ScTqkA+Anyl25ARaPk+JQXrn5qKLN4OvvHYW+DJA6mutC/JsKZp1neG/nn/fyFBWhUvJEtYTPjhEUr/89sWP1J1/bAmZpz2CYMMCHw5gDSTJ/cuOe7Pg5dsgz7b2crQ+UM0IsmreTt0ApXwB1BJNnSpjhA6+N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(11063799003)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wyd9jd0iJXGCuVz1oge/t3Si5TPvd5TdD4QDf1GIQGx/rrM85c6l/A83OqpQ?=
 =?us-ascii?Q?IUQCwUfEPKawBPG1GceLg6T+VMUk8xALLUSUG8AZgVrfhQ0jf1vP5wWSE31v?=
 =?us-ascii?Q?Qq0Fn4bUOCYr8WYBvSR7BtS0HpJAQ+9Be22hhz7qxoaQdt7PyKiBujaS84RV?=
 =?us-ascii?Q?PbYWHp2QYzrFX2Fo5jjNZNZAS4Wgu2Fs82E0xpJdHsrfwgW00R0P/xMrooAL?=
 =?us-ascii?Q?To6FYTTZJZwcYWKlhRuIPpYu3MrAaAR44GHffPnaYnFjdj9Bj4xn0849SOMf?=
 =?us-ascii?Q?dVRSEX4+al0gGHFL4VGWubbi1DKheaRnJ1e7bgd6ZwKewt07hj+F6VUPlFec?=
 =?us-ascii?Q?Yf+f0JfGY18oxa+nwC+VTR8ItzUBVKRizRnDCJuH1wCwRu9SoSKr6GV05jeT?=
 =?us-ascii?Q?xq4iRD549Qotncs5oZlry9mE/ztOJPK2G0BC9ck+tofKblIRAAZmz44SS5p6?=
 =?us-ascii?Q?D8/AO399EvlsZ1nSxj5gsS0qHdQPF84S1MPl9DkRy/XPyfEwVbn+vbApoCaF?=
 =?us-ascii?Q?KJINuNfy+GMEQDvEm55tDMQraHngKiLryZadV1qdI4SYqMvsWkEshPT1IeBR?=
 =?us-ascii?Q?F/J0NgUajE8F6uj3Abh9jXCGbHETklB9K82LyBWCbPBIVdJUKuqGK0NUn5m3?=
 =?us-ascii?Q?SOrNQJidMzwsz8jjCWK4gz8P7G6RyjCg9GG4V8JUAaXGTiUq5OkT5pcLky0Y?=
 =?us-ascii?Q?MKpsh8oDyn6QiIDIyB4paJBQ2HDJaa4AoqrXWdWgl9u1GBCbcMLnPVTXqHkh?=
 =?us-ascii?Q?UPPCRFeeIcBUV+xTkolFYyKMidRjwPEymArhqjkpm7C1KmWWeLEjP4oTyPcq?=
 =?us-ascii?Q?kO2YRMbUu5QicaRe1rqJNXazxvq1fKC15/5O5bvi9s4F5HFBFw0V+FirX7fD?=
 =?us-ascii?Q?S/E/Lod/uypE9pdFXHtomli9YYXl5qbmzRR2UxkU0ejRLIGyOmNdU6yeKFPQ?=
 =?us-ascii?Q?abzShSCw9zHdXWC+czrY82p2yuUtZWZW6L51PTbbtAwSOECCG21/T/+g1b18?=
 =?us-ascii?Q?lj2d/nZeTn+KSloSYwB++vNsIKVxEp7bZfMBrPR0ai9gZPSJynCin+DJM+6/?=
 =?us-ascii?Q?d6qcJG4fWFJVZovvfQfdrGNT68rLROZZmLNthxATkNWwuKwAtFpgX+A5zUKg?=
 =?us-ascii?Q?0KfBa1QkK0P5mNoihpSDbxofGJk2TR7LKkrLXVILtGdywYX+oBL/ilOy6LZt?=
 =?us-ascii?Q?KRmETAhf3fvq1wQqFQCr+CZuxNxRkE0PNnWOHm2+fOA8bcgouLDPjTfgma2o?=
 =?us-ascii?Q?2SZVKnWejDlqRazF6p8kj7n4fCkV6gKxRODCalc0joAcuwJIgoQi84gdvGsF?=
 =?us-ascii?Q?J3ONui/AH4tcVF8HWDREZKZBpEAEBYiZF7cqcwNHbdp/+c5HoVrXdQmbkKXT?=
 =?us-ascii?Q?xe/R4RMB1An4qO45TGdtxbhzwJKjIW5HVPWQk9+bdf8/QNbk3R9JK3b6y4Yu?=
 =?us-ascii?Q?YkytYKFEEeK+bMSM1+DaxID8QHA0bcOjFBwqvFfWlOi7PqyN8QCS0f5OltsE?=
 =?us-ascii?Q?T9Bcq+7pQ7x4x8yTm9qR+eauIRfWAzvrKTdDy5Ca0i1/4U+voEweSS3pyP1Q?=
 =?us-ascii?Q?eKI5kHIL9mdph4C6oUvaAFKKkf7hmX9KiRM5p3GodITaiYuAP3Jk4eUXNvPv?=
 =?us-ascii?Q?VIH2uqZ45ynplV6HWDBLM9IzYWN5ejXXApavigd7ddKffpjnPt9mqHHpnd6/?=
 =?us-ascii?Q?koH2wpcj6tKkn+wchNwfWskKCf6meojMHljwD+uOE8hZSYL4OgIqqnifAKAy?=
 =?us-ascii?Q?FyH96JdGedP3EqSHO5t8TpJo7n+yMMI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 19114b8e-be0c-4ba7-361d-08deb56f68e8
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:25:24.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkeTR+l0/hFAHongYCqMtP1HMrbZ060U2BEOU83wewDGWsH3N8QduuNQfmHCADJNNcjlyCUCVPspwhbAswYRZpNIiB5DU8COUQCkT6X58lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5894

On Tue, May 19 2026, Jeff King <peff@peff.net> wrote:

> When we load a commit object from the commit graph (rather than reading
> the object contents), we don't fill in its "maybe_tree" entry, but
> rather wait to lazy-load it. This goes back to 7b8a21dba1 (commit-graph:
> lazy-load trees for commits, 2018-04-06), and saves the work of
> instantiating tree objects that nobody cares about.
>
> But it creates a data dependency: now the commit struct depends on the
> graph file to do that lazy load. This is a problem if we close the graph
> file; now we have a commit struct that claims to be parsed but is
> missing some of its data.
>
> It's rare for this to be a problem in practice, because we don't tend to
> close the graph files at all, and if we do we don't tend to look at
> their commits afterward. But there is one case that is easy to trigger:
> git-clone's --dissociate option will close the object database before
> running the dissociate repack, and then afterwards still try to check
> out the working tree. This will yield an error like:
>
>   fatal: unable to parse commit b29edc0babef41810f7b1c9ee1d74058f22e4080
>   warning: Clone succeeded, but checkout failed.
>
> What happens is that we expect repo_get_commit_tree() to lazy-load the
> tree, but commit_graph_position() returns COMMIT_NOT_FROM_GRAPH because
> the position slab has gone away (and even if it hadn't, we don't have
> the graph file itself available anymore).
>
> Let's try harder to find the tree in repo_get_commit_tree() by actually
> opening the commit object and parsing the tree line. This is extra work,
> but no more than we'd have to go to if we hadn't done the initial graph
> load in the first place.

I can confirm that this, applied on top of v2.54.0, fixes the problem
for the instance I had.

Tested-by: Rasmus Villemoes <ravi@prevas.dk>

Thanks,
Rasmus
