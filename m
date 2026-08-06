Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC4448B98
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012781; cv=fail; b=naJwVSnyjhdkqg/A+09kMxMZg2yvwb+iVoDDw595TP0Q+unkloQkxUFLGoVmOLEi//44E+IgDb35dw+Kyn0EEwTc2k0O7jSFZgYbn/+47KduuF/rlTqi8XB2juLj7LaxyWPSGSr4WWJZu4Rvzt+2JYU8bFvciSSy4WMrwK852wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012781; c=relaxed/simple;
	bh=u2uAR2N4AA+In6foNmplsDAvY92fsHPYTNrit0jf2mI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DSLtsy+YN0Sq6NaoA/LhP9KuOHOkeRpqY76vQjT5iWgqRIccch1ei4NgRBffiXcuxf7Ix7ojX6Ed1Da5N3Vt1XpEw7plyszrUgKUgE+jIWCEooq7/rsSmunV1LcqfDyFJ2/JGBb2V6w97eEzmAZGoAEABpuKyszZDKA3WTdRr4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bentley.com; spf=pass smtp.mailfrom=bentley.com; dkim=pass (2048-bit key) header.d=bentley.com header.i=@bentley.com header.b=FmgDT7qD; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bentley.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bentley.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bentley.com header.i=@bentley.com header.b="FmgDT7qD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xx80pB+RqwgTZCzJFscqIbWyyV2t6XOoXONNNdrdZG/QeaBWslITwllpaH4VunXZEqTgQCStrwpqFm4sxCKhFzJtL8Gnuqu1jeT1zS03RIR+ng/xvH5eI/m/vtaxQZIZLPI3Jze/Vr5H+2yOYBtLGXUSi0ev7ZpsNL0+owVka07yXr3fxzAJDv7bk8pimjsAVvOPIZZ23VNVTR8Esu4eUEcc1S0fpWvWmcW1hpAi0vu12KSiIdMtBv5FBCraAK8rN6Y1HnLX3wdmPap8XCaHsx/Zz8BC6asLaQGtryidGIHnuZl1eb3PnFZ2VkFjYX6UILj4GMON3DJh6tlQ2SrtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2uAR2N4AA+In6foNmplsDAvY92fsHPYTNrit0jf2mI=;
 b=LQswm3UoX5mdwChtMOnqcqqUajAnb414lSlVV8nkYV4PtcsQgWKZwY3uTvR71OfsHLDxsaQj9j0GOJ9/VjRBa1XEc3qlUrDhjY+SidB7A2+eBfVflsx+PiktZx1Jwq+yv50t4K2dlfR1bHUC7RPSWtRMU7g+vLEz2LC/y6/FlNQdBNsVO45sJhSIABJkSXpR5o4751qnujK0PKaZUklfrMBKIrWzZ8M8EKoro5NbJYSjxrtCEGdpzZ+s1VizGBDqTVSJGZw3vy0Amrwx77sf68yaKNfoqFTjpVNakdIu0S8bN+He5yHHj1cJtuckGT+PONuBjmKb3P2qzKcv1DjZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bentley.com; dmarc=pass action=none header.from=bentley.com;
 dkim=pass header.d=bentley.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bentley.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2uAR2N4AA+In6foNmplsDAvY92fsHPYTNrit0jf2mI=;
 b=FmgDT7qD2RTAEwsD4JINRPkoRGDFBciLZ6aYiPecmOlGZECOGXdtUQ91JnLKcMAYrWK6Zo0mHMIEtZXkU3KsUII9Sy/RfaQBDP7llES7gm49rtiTLZ9UQ8rN7Tkd6Ow3OCbLJNTvTOlEFIIYRKB1YIZtJFktkVpFeoAg7rLgWezVvmCNTT8YgH9HHhcGj/dbjem5R6ht5L/kNxshdAGzncBtKRhv7+khAheB1qnaoI+qw686Yxq9eBIqaYgKBIkrutCTPErfZn+iQC85mmll5AZSZ+0XxEffbA547a/67yUF5NWH3c2px/MJ1NO/OwNYtIrPMjyq2Lx9ktXiyQ+ARg==
Received: from LV9PR19MB9133.namprd19.prod.outlook.com (2603:10b6:408:2f0::14)
 by EAYPR19MB997486.namprd19.prod.outlook.com (2603:10b6:303:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 10:39:31 +0000
Received: from LV9PR19MB9133.namprd19.prod.outlook.com
 ([fe80::8350:a62c:409f:22df]) by LV9PR19MB9133.namprd19.prod.outlook.com
 ([fe80::8350:a62c:409f:22df%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 10:39:31 +0000
From: Piotr Slowinski <Piotr.Slowinski@bentley.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Branch renaming shortage
Thread-Topic: Branch renaming shortage
Thread-Index: Ad0ljoZvdbUJiiphT5+5vJiZ1xcVxQ==
Date: Thu, 6 Aug 2026 10:39:31 +0000
Message-ID:
 <LV9PR19MB913344C2C359F1A86C329B3DF7D22@LV9PR19MB9133.namprd19.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bentley.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR19MB9133:EE_|EAYPR19MB997486:EE_
x-ms-office365-filtering-correlation-id: 5a529ca5-6f36-422b-84a1-08def3a6ff8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 zJ5yR3Ax8rJwPfUs1UMUKVNPt6tehjlyt8QDI/jMJJcSP01xmFjA8WJ9EfKy1tFnaaRaklT5EytWihZcSZeS2aV3iNAuXytBTLXDRKb02/IxNJqVRHxxvoa80RHyDEFIYWy3leyAnppC1d7E46E5rBC42wqNd0auk/0PLpU90npEfF6QSgS2LXYzcJXwaGQnlibalwgPccg9em+WS3R28kneuKy0IzQiU/X34sm9hPVTsdxIP9M2iPPAOWDSOu96qf2r/L9Dn8LgSNw6eqTV3X3h7/66ejID6ZibRfbSmwCLOStE5eqfgOa988+IsBfZb1DN0Nq30OHuleoeHp5v9ERi3rYdgthtGtyY8vA3VD6uc+GxIDyHWGhZgRf7ux2n1BJInCYz9RGbrlLQyshj6J9O0JPiSJIwL7H6lxurXjIxrbZ8L3PoF0lz1723um1m9uePSwYe95MxLnujKWNYaLQRYeJbWQCw0UI5u4fspQpd8FbyLvgqeUCjWZ1t0WoJNov5W/3w6NHb7J7gil4DZ5eMYYkY/Pts94B5Wr197ky/ETNXJD6sMTg2wqOyJYU5mh87yfTn6c8GErhAIne24QwYLrBLiiwlf23lFbuDUL4vZUyawruUZwZn6IQNeZtCyzaUMg8hidP68/FRJdwLuK1WxxLudx1kls1MOBGHp3oxLOseMvfz26JSkPfiw25HbG7pm4l322uVwPPHYJD0YcLR6ZUNWgk44KJBweMPCcE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR19MB9133.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7d8db8H7wd0wPEFPw+SuQVf8caK+oRzA3/DgNWJ8JekfQtJb6OV8oqzgqNlk?=
 =?us-ascii?Q?OWnMLO1bkzsk/QDKdku9jx3GU48PE3ny02NTDOMaTG/OQDP2g7tvpPMuRGz5?=
 =?us-ascii?Q?zYFnOODS6HhLk9XvYCIOUfYWy8VeESGwXsJCcCVjjUR9M6JXOGkIpUa7p0oe?=
 =?us-ascii?Q?kkQJd2d4GkOaE7ZZO30Y/76h+lCK6tIk7nbVZAVmSizqdn+7fkvbsQl4Mwim?=
 =?us-ascii?Q?2Vdq/LtRZgycaHYriOfDWtljvhefQCgBgkbDFPhXkor7+H7g23uKhaJQN4/A?=
 =?us-ascii?Q?TOla4uuD9TVhqMlUgZ8SGuMMLMBgsKjI2ifUtSdoZmgneNJvm7TGIv9SZw1N?=
 =?us-ascii?Q?OY8xBDMAGneni0CyurYjyFa52Vvg4bv/8bBTP/Jxk0fIatnziAaIuU6V7BVf?=
 =?us-ascii?Q?OYIetE6rC8AHW3CXr69WkAgxVLKKbW5Qy8SZqKiY041kmi9GXo/mYO8tdKfP?=
 =?us-ascii?Q?+4ZBxFsTxisL+Iinyxo6rfAU2sqNTVsbLi9AYB/b3kBGdhgH7BASg9Ej4gDX?=
 =?us-ascii?Q?RVKsLcr5GPsHKeCn9GRTl3osKNjMkc6fF4qStcTLUGDy6ooEKrh7gz4b+dzf?=
 =?us-ascii?Q?zn+IPBG2STWzJ9V3afUlf8csW4kCu0X3U82Z8vgjkFr+QY0/1Pp25aeDZhas?=
 =?us-ascii?Q?/Q4h7OjW2T5aH0LEP4R9vFvlYUAxVEz8+L2ooN+wXX+0Njo8KJAV3Rn5owZs?=
 =?us-ascii?Q?Je3EfehfAqs4fXbjs/Ejgd9bP5kMO4UC7L2u3qSTu4TIZUxXWRkFYcYShPDO?=
 =?us-ascii?Q?2PfV/clc5uzzTILn+NTwx1HugYVSoetSHZ7lY35v7wy8apxxh2RqETgrpFy+?=
 =?us-ascii?Q?oj7u2lKOBgZlPQnf252B86AdqDGB4B9Mo4wfItYXjgKIw1wxrIK6Lkreneoy?=
 =?us-ascii?Q?6oi6umNjPABYSbOig2W95lop7vEz8s1NtzsNdUFNBw80hBhGg512L+pbf4Je?=
 =?us-ascii?Q?+T71CN2E5q8elFhIC5T35FSV6GoeBpGb2Ag6v7OBnxeLNfHDpgxyGSft5++u?=
 =?us-ascii?Q?WfJEsT8ISN78WS5Da++lwsDP08kS6SedfjsXe+vU01fd13AjAJXR4h2BFTw+?=
 =?us-ascii?Q?pbtWy2p0bDY10oGjbLMyQngiWt27YyqQzZp+KBpXtLHB+nxhZGj7+o+7/noJ?=
 =?us-ascii?Q?zB2J7NGJn9XsC6rkd52wbdlulmpeTMhX8ev6ClzWzh4LhdUq9QXkKLTfa9aA?=
 =?us-ascii?Q?nNx4gRIQAc7l5GIyCv1c49maHwxBYs/bAhjF7zzafep64+KOIR7OAOwbxr6s?=
 =?us-ascii?Q?6Fs0nmuElVSoRmXcCp9WfPtrNOd/c9g6A3PW2TvCcO+aN7YUVHZFeYsIQLdn?=
 =?us-ascii?Q?9X6FSwkPYGhT+0lO9UD7nik2SBAnJO9JqhtRB+ukiS2hRUNc/yjNORUqaWsK?=
 =?us-ascii?Q?d+beT9ZfvpRPk57SHWFdPBugz8bMZohixB1EyFGQ+S4RoJzyHlG/1Csr1tNl?=
 =?us-ascii?Q?Z1CbhFqulz/g03CBmc2lD3Xt1LOg2h+Fc4wLajE7apIQh7mQ18buHzL8WR5n?=
 =?us-ascii?Q?i2ZLdioYxwqjOmFuKBtvM46nkaqppATkfrho6yM69zSwVQwgE299YG7F2B9t?=
 =?us-ascii?Q?NUsyMuPiWJZTsm+GuLQmodDvp4W79Y2vtV2Fh8GijSebO5HNTxYmTGtHtn37?=
 =?us-ascii?Q?n6yVfPra5/4LdvI8HRjvhop/5fq/JFB1XtFNvIu9SctKc2qvsuryjnecsgYH?=
 =?us-ascii?Q?IFNDF0qoGVW4gpyDr/DwLEG5pAewtexplNEy05Ch+RBOAYb2unfGr3C7R7E4?=
 =?us-ascii?Q?rRaKO17WkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bentley.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR19MB9133.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a529ca5-6f36-422b-84a1-08def3a6ff8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 10:39:31.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 067e9632-ea4c-4ed9-9e6d-e294956e284b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDUXA2D8NZteeCdOEPtH+mdNPtSUw8Z+nQCmwb4Pvk83KpOxCOs3fIu9MzP4/dAHzQdThN5/ipe1HnCqv6iSTReXN95bJgNP5EleYVn2jDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR19MB997486

Hi,

I found an issue with local repo update.
Have one remote Repo and 2 local copies of it: Local1 and Local2.
On Local1 create branch "mybranch", so some modifications and push to remot=
e.
Fetch/pull on Local2, relevant file ".git\logs\refs\remotes\origin\mybranch=
" file is created.
Now on any local, but let's stay with Local1 change character of that branc=
h to root of subbranches.
Eg. Rename "mybranch" to " mybranch/WIP".
Probably this will likely suffice, but I also added another node and sub-no=
des, like
mybranch/archive/branch1
mybranch/archive/branch2.
Commit and push - all fine.
Now try to fetch/pull on Local2 - GIT complains about ".git\logs\refs\remot=
es\origin\mybranch" and that is because locally it is a file whilst GIT ass=
umes it to be no folder and want to write into.

git version 2.51.0.windows.2

Manual delete on Local2 ".git\logs\refs\remotes\origin\mybranch" file and g=
it fetch/pull creates relevant structure.

TIA,
P

________________________________



This email, including any attachments, may contain confidential and/or prop=
rietary information intended only for the use of the recipient. If you are =
not the intended recipient, any distribution, copying, or use of this email=
 or its attachments is prohibited. If you received this email in error, ple=
ase reply to the sender immediately and delete this message and any copies.

Bentley Systems has taken all reasonable steps to ensure that this communic=
ation is free from viruses, data corruption, and unauthorized alteration. B=
entley Systems does not accept liability for any damages that may be incurr=
ed as a result of this or any communication by email


[https://cdn2.webdamdb.com/220th_sm_EdpYPzNrja101cmW.jpg?1691764309]
