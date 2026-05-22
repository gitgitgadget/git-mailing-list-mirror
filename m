Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207937A485
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466247; cv=fail; b=bXzeVxRohwSU1F7Zeg7kIf0+qEdVrzyUjQ6U4KMoX1OIb3ymyMh0a4Eg51gn7Rhl56ar6088xYQCKAePZ4j7ga6/nJKS8h/GQeq6wj3rIKEsR+WzTuTwMDUAJG/SU5Fp7t1WxwbS8hJFXWFJ9hFuhK+W080oZ8YxjwswnV2ofYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466247; c=relaxed/simple;
	bh=oN/bYL8VwcXhQc0zbU37UhFYds3Dibdn7ld7g0Jg308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDczu3alVoB9u5zMSNZaHsNLMnfHbhO1BxGAatSs7nfp7GytDvJoPU6NpNePx8+uUmhlkLvs1vjCqjEeJLwR2+dNdDwk7frKq6JKa6TzrBlTkb/EHvq/8MLWrKBTfBSLdzYhyoUmFLppHAoXWtj9NqiU++uWSQ0GRxksNj+BkTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LpqVOxQr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mYOGe55W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpqVOxQr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mYOGe55W"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MD8QAq3752884;
	Fri, 22 May 2026 16:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=; b=
	LpqVOxQrr3i2W9KC6hD8O0iG3Ai7Umy4D2DYXpm4p9EEh0G1k6vXISG7f7tUUIzc
	h+JbAhx1hh5eqDzhotSEQ+q/3HJOlCqOrsfANGQQzrC52hIWtRgRuGzfQmhZRq2F
	XJemGfc+2Tfd+39Un7oZN5aoIi9ICUOtuQr9kdHgvXYM5WicAvPE6hdTIfLwoSqQ
	wrqTBVHAtiQ5mCg/YG+CCxwhutBxMAWy5BpMHjjlY/yMKIOK/FjnGEDCsFSzk6+C
	FfG8EgjQwnvAN/Un7t+MjDKy5JJfYA4hzVm+OhRifQIVXLozrYQ0tNuIyGNlwHzP
	WmBDpIwtofrvvqnYVP5W9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t36da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64MGANiS026158;
	Fri, 22 May 2026 16:10:31 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1m79ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:10:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izG27OK/CID1EpDtYtqQwY5+lgiGYVcAow4h8nHNkhQcEbzg2aQO2Xh4+1i/qRApYkAD+oZMrFqpnWzjdrl4PPYzotP2OQTyhCqVgN26MBkFqUvWxIvoWqSFV/54im+fMCTTIJw/xY26pdYHvGgWmUMBE4flInSrhSZxVKem2wkb0ikaie9k70v/Jm2jgBku1giilocmvyRMSY5VyBOExj0McFqkWj/EKBv6qI6okoWL7TP0BlbXXCHuC2HCi56V6E0ivfFQyirLLvMkm2GPfN7Bd7oipM8kJLkeQGSnQmxW8TXkGCwuuDH3hRsh3WDaTb+HDFegEtjL9ICi9b+RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=EGadoHFBi3t/4sndEcfIRws/vD2LikMb9Im/DNY9UlXrfTVeJig7eZhk7aY4VgWqT2fW2wkrXPHwDU/FyeL+uPsjbdrkX8I7ISwftFhjcLTqi8whDe7ogK37+M6eLjBc5rpvkxOo/NDGRWPjXWsPKVo9v1rB7ZFEGTq9MD/1oOuUAf6zGyLdRwh7zK7NEGC6ST2EhLG+V9DRzkFRQ4o0D6tWohN9EkQXPbDBBNaZIAHcEfQ+bio7aVaMpedDBFuDJbc3yd2DaykP/35QbYERKx7ybAtO3x4u+PKQFcf4M/jO3cN4kjOCV17/w3Dhcl41ZicFCqjDUEzrykIyMnWIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=mYOGe55Wjst/m3XaHzMHTHGo3AS5EYHv8KBnyG/HpnWft2zsAHVN++QeIVeGQ265/XglCN8ETaO4AamDRCmKAbmdDAfFlWyVZIPobdcKXdQP6j0vlRfT6n/OEQLuRaxfnje23tieaR87ZvuquUW3e4/yvAH5SNcnuGJBiK8Kyx4=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS4PPF18D5A7206.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 16:09:51 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 16:09:50 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 1/4] notes: convert raw arg in format_display_notes() to bool
Date: Fri, 22 May 2026 21:39:35 +0530
Message-ID: <f5199e24faddbef3edcc69bd627590c9fccf0db6.1779464886.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779464886.git.siddh.raman.pant@oracle.com>
References: <cover.1779464886.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS4PPF18D5A7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 01430a64-c231-4745-d113-08deb81c8d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Hl08jvcVF9NxkgPPot29Ba7K7ejJPymXhJZYAvxY2Q/KpnX1JtsIbvMysWTq9zjSE3vc2iSMNXo7dAmP5xTuolwFUMqTCEHcBgyJNdV59xz70YPbnLY3Ucfe8bUtBABZryKBipnslZyELj56PDDN+6ORW05aXxHPOJXQS2w7bp3Vhl5qN5LUYXK7xkjUZHAXXYD4k/pY3aF7sgxEe459xGVnkoUCdOEkwEwOdVf1kH+VEVbdbQfUFUHltQZoFnfSTArMQjjuqzNIF/tQBA3EP+qGLAcP01IHZhtoY4buHhDSNJ59dAT3yoyI//gLcVsUzjxsEP4kKoVGXIQtfGkloIPJgu1fvU2PUU/ZT2q+FimskJ7EsL2RSj+YFfdRk2bAdIiQHVYtsRCUnaGjFtZMI3yfHvVRvOYX84/FR8KZpDCc2ce/Ny9CfC3lbnzc+3wu0Yrho0bbv4Jybtemem28i4W2fopsh+gSvSND4I7GO+5fYUBoiggMH/ypgBYPVCB9rXR2Y46TcN90AozlbtHcYusQE/yw1gkYV2rQKAlixuxACDHCYY3hPpD6bj1S7i7kEz3vA3iT4YE63FxZUm4vzHearjvBCSl/pSlSbc/AafBdrlt251utObcUDVp8zbuqnOfbI2T8loPGyMqmVM2aKeYWnkXsNtLrcu06AUekllv+N3rqY/iYc2g3jQEhHm3g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(3023799007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IwNv3GI7ajqurYQX4qbjv8V+8zUb2wTBv/0EFvX9nGLLEGFNtl9krMNiaQFe?=
 =?us-ascii?Q?a3U8bXLYbGSc/sp1gQ3BiMOunw7QEWoB9p+WnlcSxejnws4C+OV3emI245+3?=
 =?us-ascii?Q?+bxD7ZdlMFISobtrtp2JXNimXQ+Qo/QC95dFhV8mhluNnrAOmK3mt9ICXsNM?=
 =?us-ascii?Q?9WnoXW6/GM/45nz5hkDzKKNb1XUX7mdGYGt8Fqb5i3l+zPrbHYMpi+v4enbu?=
 =?us-ascii?Q?md4qmO6Q99uJ7cKy2xpYGiAj/fpg4IFRj4AYwn0YCoUvnsjp+dWcn+/Pktzj?=
 =?us-ascii?Q?GvD/7+bpIN43ADvQ70h+I93llqnCuJTgjWRc59rC7lsK7k4W9XXhzVJCKxsF?=
 =?us-ascii?Q?UpZ/qQJgLJl6PFIJqCtING9p/i8qpmWewcurDFb9aiIGorS3KQs3hfI2ihQ4?=
 =?us-ascii?Q?LmHCt8O1L4L3lOfME3hLbg9/Bdztvv5eWgW4bMXppUXLHhpau+yYAZNXd31C?=
 =?us-ascii?Q?by6Nc+OPG3vvo7Z9/Gi7+67cpoNJ3Axgo79HaPkGArZdo+pzZpfru3h2Cri6?=
 =?us-ascii?Q?utBCer5OmOWktKp2LXi1GLdNcrDKxY/HkdFur9KfHuTeutDg42lwONpLlvwZ?=
 =?us-ascii?Q?Wv+cr1xTPDY3oVuxw9p18op8gYu7PnCKAYXuWAHkaoA1TR1g2c13FhpdaEKJ?=
 =?us-ascii?Q?sthi35vTzHlYUzVZCLlN2iGQNnxHxwSmNXfuADuumuZb1wJIQsq95jOM/mlz?=
 =?us-ascii?Q?lVRaJvQfpC42zLAcKlauwKjy/mfhkAoGxyr0zb8V+wZp6Q3wkqUklyiI+w6J?=
 =?us-ascii?Q?XM7lCp/00dnwsMdT2P/L5PwLMGczeGU3ueh4wTnRL0RiU9xUD0E+tMtu4UaI?=
 =?us-ascii?Q?IZZ0g4tg+9+XepZX8BYLjKLg0xPcg0nyTyftxOGdqt1Nh2PIcaKq8a/6WpJZ?=
 =?us-ascii?Q?1zdbnu0cWqOLwmoXSLS1wtOp6WPJnvED6WsUUCoiiIP8VCCnN+9lraJQlAWJ?=
 =?us-ascii?Q?Ulc47QubNf7t+YrJvWveSwK0wq7ZLDpV8+CpQBNu0fOLh5q9I0DL4HDHeI8W?=
 =?us-ascii?Q?SE8yo79EdjwpabyyW9vaMwJWvvU6KZEs8NxJ5XSzOrvd+WCt20m0LUtDEtAm?=
 =?us-ascii?Q?HxDPra8A0vK8mxa8TPU26iEdvsKIhmIcVHOo4zgW6lnhyy9zbBYgnIdwI6mn?=
 =?us-ascii?Q?JGa9kZEzXXn6kKjIOedrGlO4C5KBwQXCjyTQzGO58rtpZIqF16/3qCQESyew?=
 =?us-ascii?Q?nhtQq2+oBJ++nQy0VQeoNaADIeXtbdzCu9Pc/rJE+NhEtt1SzrqU/9AXI1EK?=
 =?us-ascii?Q?Mi2qWTGFWRfNANcttj6NYHHNQbIPS5ORb7718HHwjAdDiW3lOF7C2qntsrbe?=
 =?us-ascii?Q?w2x7s0LmwCPKabtlTKF0dum+y5fw5R8/vJ9PO/+I+u+T2cDUe1J09+0vykOy?=
 =?us-ascii?Q?wXtUswzrG7VNAVGbMgCLYEwf36wE+dSrAMrsxfuK7GsXvhV9khQW+IPfi7rE?=
 =?us-ascii?Q?JXyQdg8gV+4vm4pf+VkYkHw4EeEMgy87qS3MEe5VSPTqwSYnet/T12mOz859?=
 =?us-ascii?Q?XoUvo+mCNzl/04r7JA9VM4DesU3nEAWZ1O2j3z/tDbmyo2/lOzQ6BL+0+o0h?=
 =?us-ascii?Q?XdROAFRHzjWA2ywN+Y47xZa+krWrXbEHIOC8GwZOPbGngaq7DxwO+f970IF4?=
 =?us-ascii?Q?yOjdeRIVEis61g8JR7/QlVcuTtElzWrtk5rOINTp/+I95VgjA47rHlTsslEk?=
 =?us-ascii?Q?9YumK/pbG3KmL3anlvg52+XZiJeFpMzn78OfUJJ7g+qTpVnU9pmeHHkLJk7v?=
 =?us-ascii?Q?rXjUrmMOpGwE/VIL8+Zu/DTHHldPgM3LzfW9r2eB5ls2TX0undzVUJSErrTG?=
X-MS-Exchange-AntiSpam-MessageData-1: LFnATTMLhVsOFhAvQQydPY7VtTcHPKuPwK8=
X-Exchange-RoutingPolicyChecked:
	Ufl2tQW7h8QVqBYL2RTka5g6rqAc/vouc3WK9QoeZhdFMQi9Tz2RFSRCOLd76SQzPY6/G9JDjSAJL9+5nJfvpPdEoq37ZKZOESebz1u4V3Pxrf2lxsdk51cGdNkh4Mbl3pKj0TVFuBsQXZMnlsfjZap3kd6J7IQLALnXkwjbHj6G+StsGPhexUtKhDneRF10Pb4eO48v3tlTuUOFjXZHgbxK8+RKyGIAno0Ys7txs/1K3YLFWSR1eAvG5cTN9KupGIrNbXS2u3IAcXXg4u50AK6djtUldGOSCWz+m9FIMAWkEDXUVXFGH9luLQAz5yI1Y/331zGDKXs6qLtdTd5ldQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kgXIRXb7+8iqmYbtmiBwnzG2b35Fln98hwjSHWT1kXZrGoXOhnuWEln0HMjM37tN37eexurWc8mY328joYl/OdHGD7OV6xqIbNw4Nm9dkEVhC3n0IOZ/9zOfx3bGhKAuma/7WoMkS+dXGMRF3u/4fYgFVMegthN8rNbkzS9m1XVn7xTWQmurukzsLNkLvpgcPRcza0zrm7GzB8B3c5T9/pBB+ooAB+3ju1QJyNSwLSv7vj+P9kwYCUA4mdlScFxUXIoEVHkAjrbzVuOcDwEh5uDH6JgkcozlLZFlOWOZYISRL5wAzWB+aqGn6kV90mixa8cyzQPsWxnUml09ZKRUrotcPJRKUF9Mo/2cdV++QHYjWfiT7HjT7TZjSJeuX3syQAqLNkYf1bGfeiebV3zrTLw3lcLSMM6B/8gReGfKjhgTU0hOqXptUf3AduAdpWGvOGhrEO1SNb5BoMbq75g8p1fz9iN073fh37AznulBbXlEtW9u1jjo7vxMdPGdgUAVtUGTKh9xJLV3MN9omV4p1ywBU9os2OG3KSnCa+doKMVQkbz9slejgcf+F2b2gFfVYy4iTaoIwpf+0OFe7uWEwtBdDQt+/+28aj4QelQ9uME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01430a64-c231-4745-d113-08deb81c8d78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 16:09:50.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1mL5JOQ1/ZLyomETjT18WvwgeqiB+xIi0yRRDJyoYUd6StKDb0nrlhI3jEmKVLqeq3gp6SzI/5XpcnqjDW+9wzgQ4UiVtu56R2CDfg6CFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF18D5A7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605220161
X-Proofpoint-ORIG-GUID: RUbMuvTmZ92AMQFMgKH26UKAxydB-bQY
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a107ff7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=5U6ET3mjoD1Y2LAbGjMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX/EKcM4x02NMF
 rA+GWtFAabEmI+SI4jb6VsHfv/8KDLHCLm9EzUgXn588L8eiqnLJMCVAfIxPCDjY1O4sYt3ISlF
 tIeiA6Z2a1jHbBPljgamzuJgW0SxF/2gooerYgBGw/czBqBH+ErmsIJvBTzuBF1IZIkLMDyAS5y
 ZX4nmWR+z0ECX5oGUtxmLWpHgoFOKIEVwpfO2D6zessswblOlFPtgihiFqq6hW6nIF8OgOmHqRC
 /oKCDNZoYaaygEC9vKAWM3Vfx8bRgNow+owGfatws65WdacXjqQNINXO8OIUNPxXlKZc9eU70FR
 VDXe+HuhXVGpb+U1guZ91UxAeCDdWCapAr10x6avvgg03XiXUu8n9GYKZBMTHnBvMaYSYSVY1wG
 GiXD+JE09EosBJhkT2tbllubETkoDKdT+RwoCTItcIMEK2v7D2U7mfuhKmt3h6cUZXYWBkaQF+2
 afCcyYuNx02MMfOZ9U/qKpbivLx/htyTdyCHdeZs=
X-Proofpoint-GUID: RUbMuvTmZ92AMQFMgKH26UKAxydB-bQY

It's used as a boolean flag, let's not use an int.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 log-tree.c | 3 +--
 notes.c    | 6 +++---
 notes.h    | 2 +-
 revision.c | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7e048701d0c5..4503a42dde6b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -854,10 +854,9 @@ void show_log(struct rev_info *opt)
 	}
 
 	if (opt->show_notes) {
-		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
+		bool raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 
-		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
diff --git a/notes.c b/notes.c
index 8f315e2a00d2..201f1df3dc29 100644
--- a/notes.c
+++ b/notes.c
@@ -1273,11 +1273,11 @@ void free_notes(struct notes_tree *t)
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
- * (raw != 0) gives the %N userformat; otherwise, the note message is given
+ * (raw == true) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
 static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, int raw)
+			struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
@@ -1338,7 +1338,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 }
 
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw)
+			  struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	int i;
 	assert(display_notes_trees);
diff --git a/notes.h b/notes.h
index 6dc6d7b26548..f6410b31e1c9 100644
--- a/notes.h
+++ b/notes.h
@@ -313,7 +313,7 @@ void load_display_notes(struct display_notes_opt *opt);
  * You *must* call load_display_notes() before using this function.
  */
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw);
+			  struct strbuf *sb, const char *output_encoding, bool raw);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/revision.c b/revision.c
index 599b3a66c369..cd9fcefa0a88 100644
--- a/revision.c
+++ b/revision.c
@@ -4107,7 +4107,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (opt->show_notes) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(&commit->object.oid, &buf, encoding, 1);
+		format_display_notes(&commit->object.oid, &buf, encoding, true);
 	}
 
 	/*
-- 
2.53.0

