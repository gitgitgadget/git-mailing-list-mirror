Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817812F5A5
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325308; cv=fail; b=CJzwsSo2V1vaYXICKhJsu+e0smXUIzbbHRnwydffOCmG5XqlJ4eKjaTwzVVPAGt5a7Ugv3dn94zMltU3ekHsOtrZFGKPROMpUDJD9yh8EAlE1/hhRIj5jjqy3T7WntFbBi5IGrQNSobWObhSqHNNaViYskqPdoudpT+9iNeOt2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325308; c=relaxed/simple;
	bh=Lsah8q/lgWZtkIIbb+Fgbsg8aj71E9NnvAc63hdbiQQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVYPWYCFVTyNa9ng6LiwaYemywti0lnVCHiL9JGztM1MwFF8ey0aoOEAIXJnQ+jDWxP3PsNjQkjNra03TXg/l8rGqLVEkqIWYmObmvVqC/TRbICQ5NJTWtohXUDYrtN0x5VWEN1nsOJZYqDBZtRgODFUc+EjC2AZjMpmfKsAvKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vpw0ZjZe; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vpw0ZjZe"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBbGm2016755
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O5tRyk
	XRkooY7jTx4dMdCdrufeehBH5XsFWP/iWsCMw=; b=Vpw0ZjZeLfD++xCjdkEWYJ
	EzTP7kQLtij0e2I8V+XNOzDQBTiZqOhF9U5/IXQ38AUBWtMOMrh2LlR3LkUiAgEG
	VbwAsbz/F5DIayqK8uBw38PUO/QhqQeOaVYYYuDWiYtVO4IBaH325tw6h9nD+F1J
	s1xhL46T+YYDDMjBsGF2EfN+OU2AD4rOE0UEpf2Je63wlmGlB4ahJxjO69SLZ+GH
	ZPm6QjDj7CM3OfBZ3zd1tV90ZT7jTbBe1y0wKputxKLQgEfAZapc9A1xB5uWhsFW
	pMzTNTk+NiAdimemZ5WNs6C+fnmA395zADFJuzWERp3tIQErEtsWTUcNv99HAm0g
	==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466ad3r94s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:35:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOQrpaEW3kJwO8qz90ynAKqNU/JJigm/uCGcZX3HrMZWJUPuc5TJou8pQJ/FNA5XmJwEv9thG1De4txhOpBA+fghevGd5KgAu5pGtF5w46OyT9VLV/L52o8mdENSY8iq6lIPDE9sI22YHI9e6G1MaARrOpvVCsWyGsODWSAa+0yaeFyO5na030EW/hZu51HDU1LrQaWCSpRCIWYr0Ww1o5QsxVLvpZab7DdD3+ysNAw8kNrmUTF4u4fFw2/JZ4vvTIQOFQ1LmjyReoxBUv8X6eINBhtWiEqrMDUZ7I9oauwrVu1BMED18E2andotJCu96QkPMJE5qcIXnwzAR5zqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5tRykXRkooY7jTx4dMdCdrufeehBH5XsFWP/iWsCMw=;
 b=juGOKzwnmkANEzPSuiUYA9w6ermsyrz4fREkMvVmagZ51SbUN0F3peTGqEeIet/xt/f5HFJ/ItuGo3uL0Xs++7C2b34iagXrWgKCS5foJuJo3NxlKgIJgiTmaaRar5TWrmjbXLx6GJVZQgZkjRTi8XMhYGsnJBF06oOPi7z7JB7Izf4zYSk/0FV+VZxS5BRvqDi6QSgyhWHXODApvYZKfTPZcSrcaGGKIveBmeEH1Hzm/PeE/ubV3PpBvuq5MB/byMehjyRLBZJKx7dpEnHGItZeaHFII8Y9pC3K3dBdSsJM5eKtq0joCwyInrAoH29nUPS+qTlrZZtw33k4/IxQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from BY5PR15MB3539.namprd15.prod.outlook.com (2603:10b6:a03:1ff::19)
 by BY3PR15MB4881.namprd15.prod.outlook.com (2603:10b6:a03:3c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 12:35:01 +0000
Received: from BY5PR15MB3539.namprd15.prod.outlook.com
 ([fe80::5fc4:a5ff:a7c9:8976]) by BY5PR15MB3539.namprd15.prod.outlook.com
 ([fe80::5fc4:a5ff:a7c9:8976%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:35:01 +0000
From: Pranav P <pranav.p7@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG]: backfill min batch size test case failure on s390x
Thread-Topic: [BUG]: backfill min batch size test case failure on s390x
Thread-Index: AQHbs4FgkKgS/Qv0gESRvGDx8/ewfrOvnrDW
Date: Tue, 22 Apr 2025 12:35:01 +0000
Message-ID:
 <BY5PR15MB35398BF51EAFC520421163AFA0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>
References:
 <BY5PR15MB35396BEBCAB2C559080F08C6A0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>
In-Reply-To:
 <BY5PR15MB35396BEBCAB2C559080F08C6A0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3539:EE_|BY3PR15MB4881:EE_
x-ms-office365-filtering-correlation-id: 1f6fea35-e33e-4c8a-cc1d-08dd819a19d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w8v4fmmxgONwMNK3kYgWMJWlKMKHDgL1TkWpQVolBFO56c9b1B8BkdWpERgp?=
 =?us-ascii?Q?Pih5oE4PXo3dUlJ12qiAy5jdSvUguJcQjJERb43YNShV8axEnDjv7/QKA0F+?=
 =?us-ascii?Q?L/5NoXtYoJcR2SmefOJT3J/frUDVyFNslvReAdPo5pIMfj5Cr8/Dti0mU2aK?=
 =?us-ascii?Q?MyDZqE8GaQXRMuorZYG4tszHtE6VRJG8ohu9281BqF0cB2DdNqUgc0BLT5t+?=
 =?us-ascii?Q?f27o7Zrt90F0B83hIZxI4UPYzugbd2tHhpKALoXVyGhQUphmxtxoKBF1pHrs?=
 =?us-ascii?Q?ffj8h8vVKQzRV9IUNF9UPTMzN7MyqI8mCzz399mc9eEbkZK2Y2btNwFC0lIv?=
 =?us-ascii?Q?4oCV+68axgYp+uK11qAX0B6PEQmPxtMK5JAuDBfmksl2MfTsO8reJEM41nNf?=
 =?us-ascii?Q?t9uhzo7YBovPdPgrp1ml1jo/jNqOkvpvUYGIhQnSWeTdFjegcBecbCjbgRgd?=
 =?us-ascii?Q?gHm4YBT3DpOgGF1baskSId7hCEDHVPFwUT1DMvu/0a985QZo20BqQ6KrBkll?=
 =?us-ascii?Q?81N4MiI0Ccu8z9DvEqpEdmQSmkOvETj475QSkBdsoR+yTN5PweKH5DAOfdCz?=
 =?us-ascii?Q?FmaEWgICDfQ70rve5yx13qekY4eMyBvrXZCFdzVEbt918FR9zgmjOGPtJptf?=
 =?us-ascii?Q?UMfimrH64aUeBtFqvsILQdxqR6QWl6VzW+H6FTJoOvGO5/HcnCxiyOfhnp5p?=
 =?us-ascii?Q?f4lFWsV6SAe0DUeIaCaYO40bZEzrqJRh9XqnrL094bMR7b68wZ9f1r2612NP?=
 =?us-ascii?Q?DyvVDxtQyVQ6baAmipO+Kk0H5ZbzZyVEE05nzF+3QDwGDSzoDXFbnVYHdOp4?=
 =?us-ascii?Q?coxYYkIP0D6sIBlUWO1W4q6oo9oWgT8NVd4QYKFACBwV5TgK0+wmUUz/Zk1g?=
 =?us-ascii?Q?p79KvSz/1ZlwZw3GLnqBPiENIO8LyOcpa2CAUb+2joHCDDVtit0WHIfFftev?=
 =?us-ascii?Q?oW3545eAUwNEEtVazeJewADUtrBVRGgvRxkgXoFX0cYJbioxqyxaQrWXfJp3?=
 =?us-ascii?Q?+13zw5QyyMJQO6EezR+N865RS4i3h4cuxuLTlgAl4K2O6Ffb0hZp3RbPqDyU?=
 =?us-ascii?Q?/WQ9rc9xzkhWHelQi4BHtgm+uryeyWUPdly3+ZDyXiYgh3TSKOoMfTqoY6Q1?=
 =?us-ascii?Q?eF+QPdUI1zC+VuWkLSOYlia4L3VFaTisDEg6sHDB7FaVm9KOf7w9Doih4xGy?=
 =?us-ascii?Q?2w8lpViayokC+rNNOowwdF1spl7jggoL8lSHfm/zdDcY7nRgwXHkS22rIJ4P?=
 =?us-ascii?Q?bLS/SDASV7H163zF/rCd5KDvy3Mmf+ftf6hftERmE/y1oA2NVGRxvLDCO4zO?=
 =?us-ascii?Q?eys46HdZYwADArl1VCaNKQw2uuChydxc+aUYkOn+YyVIlpv1Y4tb6gzKaIpL?=
 =?us-ascii?Q?FcBSbMO8Jx0KIk51qkR+tuIkwma8HYyOTvm/7AOeZBlX7MjdobnWw38CrlAV?=
 =?us-ascii?Q?1mZo67XvNo1/AOIpTTRXqMOewJcJ4E+EXvxfFJUIwdkKKYIRIFHRbbLnrgN9?=
 =?us-ascii?Q?qh+0e06JLT8IvFE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3539.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vUCd32/DXrctnf0fQqVoKQ6zypoBunccrsMMB3xBuH8XYS3Cbbhk09TAvKzX?=
 =?us-ascii?Q?EGiLr4r4c/7jAWx+FWBQ5qMWGo5tH+qdhEXr7dUXI53YkKJTMr+pk4yudiw/?=
 =?us-ascii?Q?77xrTUWJwttje0CrEOVg4HJrooiuUuI/kfxAr6iOIry4qZfKbTIIKVcTiiUa?=
 =?us-ascii?Q?wPtf2Gf9gs34paaFpu1xl+MpjtBos8Jfbxflxs4Y4id1BVrlWrmVclWQAmpg?=
 =?us-ascii?Q?9wVZqxb3iCKnbdhZ6wUfS6rnORL2Dq6gBbfFXOIFXmi1tpLXu8p5bxEdG1cn?=
 =?us-ascii?Q?K4le8wk7XY4FvoS6zg2FajRALcn9X3SkTECU82pUbBXUlkra/FxsBW1oco8l?=
 =?us-ascii?Q?myKdzVdXqX1AE+Plva0J0dSe0GTd60lT+Wr9pwvA99miEzj462HdTFM/7dOO?=
 =?us-ascii?Q?Y15izWhOqj6Q/7B8uvAfsHOtULr6OdSlvsOIRl7WTuWdnNukwofSDUA6JQnt?=
 =?us-ascii?Q?v907W119V1y/38aX2ugww9+Cf1jkUJ3s1bw3OMglhYQKeSWiq1QUsM2SCFVr?=
 =?us-ascii?Q?G5321H3ixk3gVctL3jEnaorWRtOAgzpLqNuKFazfk5RnvoDILpDxNgJV3ZMl?=
 =?us-ascii?Q?J8XXS/hxde/W81TLbN2iMlsBVbnw6Y74uU/aBfpNiXOh9kct2vp+F99W0eXP?=
 =?us-ascii?Q?efvyISb6VrmN3UtQUWVHoByfKF/3adX1uIZHhbueYKvsbyjyFZ4SdwXA+Nfy?=
 =?us-ascii?Q?g92aLiu+7/8c36mbOoHBhvQo+IetlQfdhNYZ5ZK/oR84eS4BivT+I9CzS51q?=
 =?us-ascii?Q?34sQuTumkwmNhSkVBfYIqmAy3dhiasRoF4IshtHG36KIbRSBqzJJKGt3sK74?=
 =?us-ascii?Q?4qRAtTaJLOyKvh93kWBoGmE3OsQK/9MCgg5keqWPcRDcCVcuXGqVHXxEDYm4?=
 =?us-ascii?Q?9VL+qZiCQoSqfw2ZPdkMoQvJ3IWqc2YiMRKpwP/wmfGwr1So0AqoRlkjaESK?=
 =?us-ascii?Q?PfXQl+TF0v0EyrtW/MSHagkcIXK74yqXm4ZLMCKv8DdgOGyChVgi3q0aehTn?=
 =?us-ascii?Q?LS/9oRQQM2PaHtwo1dS4vJ3XtnfwicGjqa+4fU1fIzOQOCnuT+jvrugSciGq?=
 =?us-ascii?Q?EFpeVsk8P1EzGmCTIPvdBvsioXPYsA2t1GlQKIAYbFAneo+RP+QR8ysS3yJx?=
 =?us-ascii?Q?vS2mysI3PRw5JZFUv1HHq+7se+9WdT3K1cJWLEoHCtsNOpcz4weCIolrZmkv?=
 =?us-ascii?Q?eZlqr+fIunE7+CxFlvixpRx4orwFzNto7gOdsN0bIShRUbiOnzCOUSu82kBz?=
 =?us-ascii?Q?FaHtG6WPs0ah4HzEEYqRwoy/RSfqQYOaUXYk8mqoO7AHeC9pUlFuPkiOWUi1?=
 =?us-ascii?Q?qzNqamco9vxpz0a0puQvMyuveuBSyO/AJZ+Rqn9Q4VA6UFGKFZfLIBE1x/RH?=
 =?us-ascii?Q?uu4m0BCpUtwn+lJJnUovKWIUqWBpdi/sFmHC7eFkETQ9DcY/zLwBDzWy2wCI?=
 =?us-ascii?Q?sDAE1xIeIRa7FDkOInzWstyjLFcWAhca18uc1jaRRsk6zjkFe/gafEfvqCRP?=
 =?us-ascii?Q?IciS/loo8joR1J/f7paIOsf1rMB9qYGD5wS1HZQxfj0r62hu/H0u7tW42a5o?=
 =?us-ascii?Q?YsJADikZBuMW8T0a/r0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3539.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6fea35-e33e-4c8a-cc1d-08dd819a19d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 12:35:01.4193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hz301PGgPdOOBnLSRIqm6W30lZp/gY9UpTJjSIKWEUmXhOradGfSVvGDc7WAXES7TULSSbETd15fEdklIAgLXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4881
X-Proofpoint-GUID: Ft3n-qyE1nBVB6nsvLSj0C1Ps-xztKkk
X-Proofpoint-ORIG-GUID: Ft3n-qyE1nBVB6nsvLSj0C1Ps-xztKkk
X-Authority-Analysis: v=2.4 cv=eKcTjGp1 c=1 sm=1 tr=0 ts=68078cf8 cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8 a=iCvlqqGVoizrXp1gVrgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220095

Hi,

Sorry I had pasted the wrong git diff.
The corrected one is mentioned below.

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 33e1ea2f84..18f9701487 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -123,7 +123,7 @@ int cmd_backfill(int argc, const char **argv, const cha=
r *prefix, struct reposit
                .sparse =3D 0,
        };
        struct option options[] =3D {
-               OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
+               OPT_MAGNITUDE(0, "min-batch-size", &ctx.min_batch_size,
                            N_("Minimum number of objects to request at a t=
ime")),
                OPT_BOOL(0, "sparse", &ctx.sparse,
                         N_("Restrict the missing objects to the current sp=
arse-checkout")),
--

Thanks,
Pranav

________________________________________
From: Pranav P
Sent: Tuesday, April 22, 2025 6:01 PM
To: git@vger.kernel.org
Subject: [BUG]: backfill min batch size test case failure on s390x

Hi,

When running `make test` on an s390x machine in Debian it is failing on 'do=
 partial clone 2, backfill min batch size'
Reference: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1102106

After processing the command line arguments structure member min_batch_size=
 should have had the value 20

Instead of having the value 20 (--min-batch-size=3D20) it was having a very=
 large value

min_batch_size in `struct backfill_context` is of type `size_t` and since i=
n the function cmd_backfill, in the
options struct it is passed on to OPT_INTEGER, which eventually causes

```
*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
```
in parse-options.c line 188. This is writing the data in the first 4 bytes =
of min_batch_size and on big endian
systems this will lead min_batch_size to be a big number. This issue is imm=
ediately visible in little endian systems.

Changing OPT_INTEGER to OPT_MAGNITUDE seems to be working on x86 and s390x

```
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 18f9701487..33e1ea2f84 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -123,7 +123,7 @@ int cmd_backfill(int argc, const char **argv, const cha=
r *prefix, struct reposit
                .sparse =3D 0,
        };
        struct option options[] =3D {
-               OPT_MAGNITUDE(0, "min-batch-size", &ctx.min_batch_size,
+               OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
                            N_("Minimum number of objects to request at a t=
ime")),
                OPT_BOOL(0, "sparse", &ctx.sparse,
                         N_("Restrict the missing objects to the current sp=
arse-checkout")),
```

But on systems where size_t which not be unsigned long, this might lead to =
an issue.
So, one other suggestion I have is to change the data type of min_batch_siz=
e from size_t to int. But I am not able to
determine whether a practical upper bound for min_batch_size would exceed w=
hat an int variable can store.
With that clarification, I can a raise patch for the issue.

Please review the rest of the bug report below.

[System Info]
git version:
git version 2.49.0.391.g4bbb303af6
cpu: s390x
built from commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.13.0
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Linux 6.1.0-31-s390x #1 SMP Debian 6.1.128-1 (2025-02-07) s390x
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

I am fairly new to opensource and was following the `git bugreport`. So I a=
m extremely sorry for any lack of clarity in the report.

Thanks,
Pranav
