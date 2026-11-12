Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498774;
	b=cSjKHbfEpnOLbaVYEAlb91vY/jeVM1PRqbCip2J/in6954ww8L3dUGLDnCLvXt7GCLsX
	 qOS9Hu3QP0gGa73siuOqWz3J2Wv945duEqilLlIxubDWCwUfJguSFL5cDLj1c8z4Ex924
	 KRQY1eu8fKQKE7KgVy3sn0GjJ9qtUj056Fi+OcC+qX5hs065nOTinhyANfph/5+7cG3JB
	 N1Z9LehHlOX3JukV2Cr9M9y2NbsgfE44D2jKdNMjlalOXYF+waGtZqv9Ru3SVcPgZ81SX
	 aRslp9OLn8Ir3bp/uH3x4JZKiwNk7bTj4kNF8RtfXCvAZFqdz5Ok2gME3rLFw/1243A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=arDpoJvQSpWPqIBq+VIuBFzJI/ncJkAMfn7zQFtJyuE=;
	b=V1iQDJOFSld2ymokjUht1al2nQrVVgCEsCqIobVvDARTsNYHrGb70vzfncPN6q2GKy6X
	 PhPojj8w1jSrqvWzG9dJvqp8Z0cJMb5DvmN0/DDPaPwy7ssUYv4u6hF2uoIbJ5CHOd/Sr
	 IVMjFg3UB5UrjKwKcjFMYnCZrweiY3rtvnoeSXm6c+UUAzmc5N+45pSe0rgdwDAPzS+Vg
	 z1Vac9JAlbiGSkhlfOrWrddzbx1wls/M9lxMtt2S1waqCvqd/EWV1OAGPXykNn0Is16IH
	 oMLwnP3PI4GQlxKYJxi9sb0JI0Wuzjp9D1rbM/AdkBBhMLd2aAr4T09wqyrtwZy01Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=g9EnZolK;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DjD+bBrd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F7606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F02F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=g9EnZolK;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DjD+bBrd
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACENHW31229934
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=arDpoJvQSpWPqIBq
	+VIuBFzJI/ncJkAMfn7zQFtJyuE=; b=g9EnZolKV1uyUKw9E/o/R4qYuNRrLGnn
	LWToVJSq0zntMOR53KLoh+f9OttWwc1C4u/lavjyOAa6M1XSqgL+LAilK7/HDEBp
	FU54IKRKddzajJXMDbkWZ4lKAt7RmrHMr1uZTIX4za9jnlirYKT1osDyVZdTtCl6
	q7PIwtnZKcqecytbX5A919VGd4lIGaVdfdqRkBmnTIVmXbHARZ5YojgUJAzhSsyA
	3wWE2cc3hSEHSkg3MfzC9SKxZuVNSVkl8Fe61vNYi2b5W4kggZ5VOM0nucaWU0kU
	zxwsYNGGi7J+1aljZs3aEi1hVp++Gfy5s7geB6lifOMldU4kxsDdVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsukryn83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:52:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFcKuQ109758
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:52:51 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hwfr92b90-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:52:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKcYAfZ+ve0/6j+HHfPLbyM0xgj95RR3tM5xZTYiDVI299HX3Z/3HZZO2kzacpzSCVXU6OXAkDV4+sQZC+iDlocMAkXanxMVRRRbiGhN3DJs8gATWehRKdPi3/KZhu9tU1QUHc8yhh34/nfF6JYBp35rKvfOaWYpJl5sAD9rLYxA4G6XxZ1XsKDXaZZOet7xEvPIxtzc/Tjhn+giwk3o4vtYk/H6hfjS6I69Jftp24HwJ+sg3zwMif/CVj8RPz07JzGfvGNldCNTHgJ45JlDv6/KDdbD9A96e0z2cJfvHAjZuVnaQIFqZ5a0ZW6oN/zWz7mJYOChbYbqzhmwOQCKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arDpoJvQSpWPqIBq+VIuBFzJI/ncJkAMfn7zQFtJyuE=;
 b=vxej8WupfGBV6s135FUwNRuLKAoB9tFF0iM7hOcgxzUurEOTA3HLOMH36noEjIj85Nyqufkd6bpfw9J1pv/iGN5KgKiY4wUNDKFLYeLG+0GcG7XbtUGWLfvx3trVJ8T3mAf4i2TTbrSJSmSRyu4pdhxZ6Gyb/daDPza7McYFwlgH2XTdjZxfh60oJqRyiEQlQTlo6O0vKbBziNI4uc48aqBpuTp3mwjfpfiLSdaOTnDUzsI80ueHu9hLx2RXbiazPUBGycYgGUiBhE9ktKQrUWTG7nunW7P+U9rEc66zPaLlS41oRe0Uj2+JgshlWwBcWneWk8K00CTPQNmNrxi4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arDpoJvQSpWPqIBq+VIuBFzJI/ncJkAMfn7zQFtJyuE=;
 b=DjD+bBrdTFBMJi5ZJtmcDsxOWuwjODg+8X1L4TztaGhVaRwim8SOWpktLPRoV4SjugYtBPYFsfrKM+i4Ifu3/KhYsCIDL4QGXHvXf9QkbKES3PtWEBlJkGVSFCTtseO24FndIVZHfzQKQzfrFtndXusOhQFrAuRKIwlCr5EmTA4=
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 by CH4PR10MB8227.namprd10.prod.outlook.com (2603:10b6:610:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 15:52:49 +0000
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de]) by SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de%3]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 15:52:49 +0000
From: Jakub Kulik <jakub.kulik@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: uname check fails on Solaris due to different return value
Thread-Topic: uname check fails on Solaris due to different return value
Thread-Index: AQHdcr3QoPFPHygKuUO34f9iiC4UTw==
Date: Thu, 12 Nov 2026 15:52:49 +0000
Message-ID:
 <SJ0PR10MB578540903B4931FFD985580C8A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Enabled=True;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SetDate=2026-11-12T15:52:48.851Z;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Name=Public;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_ContentBits=1;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Method=Privileged;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5785:EE_|CH4PR10MB8227:EE_
x-ms-office365-filtering-correlation-id: 876193e4-4903-4591-ca6a-08df40d5009a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|261022105027099003|261026121527099003|56012099006|261102123227099003|261026140227099003|261009223027099003|261021121427099003|261028144727099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 z1l269HEIq4sJoe0TpxKtyw1MhtIrkQgUL1SGpxs7kkAvR6KrIkAPyy5jnaLOHLxtZOLJPey8UlIzd7FNaeRjZUUKN8swGVcN38FXUHWD6yVsm1j+BqAt1FI+ZWcljpURHRTwNozja2B8qXyHeryhX5YCdMIjP2b3E60R6gbNr6hPyLFk8G6DhZ60tEC1DyTpf7FMWCLnbPkecAs5vK0qjxrlwrxoC7L4go05bNL9PaI+2lzbQJCUc4rUJ17CxoekkSFpi5lFaH4TfYeY4AfnIoPmW6eyj9YAvvidXhqj8sOm4NUNrS/voULhNkH6d7lk+aGzzM0wRcE7lJLAvw+DTNRRqyEXHLngmHNxOr0A3o3GvRMAq3pF1aVH4E78c9A9UqOV/qLbqHyKfqahnLelvdNrtOv3Ti/Gbcroet2Cvn1TLfGT2nRRX8GO36rSjdJWPgHE9/uR9OeYYE20cytrstce/tNG7DauB1QYuEoeuYYvO+8IdOUnNTEC2s5z55q4LI8Hc/ceudf8iqslX+VAdmYSv6GlmHroMYt3pG0/TxgYU2bUXcBrMXSPZOpYixiS6Tv6hHUx+Ev2t5SYMuz23Oz+SagATZrv3MqOgFBCZDxZdumLzljm7OFaXXYZEyq0Xu/HWEPvnlVXr3ydJgzJ4lbxEd+Nhinl93+daoTimg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5785.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(261022105027099003)(261026121527099003)(56012099006)(261102123227099003)(261026140227099003)(261009223027099003)(261021121427099003)(261028144727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+X3X9Jj4A24A/b281UNfrRH6iGcrILCD5PGRvVvLeonISlQEP8XlpIvWbF?=
 =?iso-8859-1?Q?kviXh3mZKTP1GXNcnMv9ugewwqafWu/+yqfI1Qn9evRumY2ZHeAJM0lDlM?=
 =?iso-8859-1?Q?0xY7iglKSpgMomCaWolCoNW2Tqbf4VygP6c/Qy/EAlgYaaFPVCpe+57LkD?=
 =?iso-8859-1?Q?yb8KRGDbmjBaZwmX366ciN3ltQn9vIEAPf7W/6oUBzyFxYTsNLcT4S3zim?=
 =?iso-8859-1?Q?vdjBsuTnlK9aUkvp7L/YFmf9JM0aQ/zLKW8ogTC0rrqyb81mHGTT3nberE?=
 =?iso-8859-1?Q?jByi0BIL1LBXYmAHko8Pjkq+W5uWSd9gfdJMWsAKVlrVar6LtQ8e8PU+F4?=
 =?iso-8859-1?Q?y1Q/qwgveUqZKGiF6G/Drv3W2KVJonyN31Im7lJu7EQb6NuxoEQKBrlIc4?=
 =?iso-8859-1?Q?yPOSp1eeQHY7qD8C6NpQE0DoDKSW+Yaosbub3tpnwj0BA/x2YjpDb6yQOY?=
 =?iso-8859-1?Q?NWm/KIkH1LRNfcizrggSW95RXUyd0Eb3dy52fqm1+VNFIPqn1nynT+b7wL?=
 =?iso-8859-1?Q?BpdsscjctJZdhWp+Z3K8BylajVeCjds4p6H6cAObSu6fZzryOvpBpYMYiW?=
 =?iso-8859-1?Q?g/LqbB3XMbejOII1VmccfwlC0bvEkXG+ZesJcc0fir60ui6Up9tmsVuQSu?=
 =?iso-8859-1?Q?eQgG6gT3ank6cPkt7yKttfE0rSH//9QzOdyFS9vjWLHGWimn19xPoNdvF3?=
 =?iso-8859-1?Q?uOG1n40SA8K3mfQrSbNFdnftFy9sUGsdyd4rvzo89j8K8VtrAoLEXb2Pax?=
 =?iso-8859-1?Q?FJL4ANQo0wz4AOuHDlLHCrAr41eCDzEkavs5a9+YMjbaXiyYppu3kT3hP6?=
 =?iso-8859-1?Q?jIw87IMO9MDaYp/sV8EJOuzrPaWmzqys0F7+YL8QM+U/UNqZ9BIAMKmzUa?=
 =?iso-8859-1?Q?euhE4+VeXe8AHnSSYe8F1IKRn5zk04o232Q+oAmYat0VGNip4HAr8fmSgR?=
 =?iso-8859-1?Q?fgmwdbvuDgnv/ziaIHKKDTiPHRl0edfHtU6OrDEX9Lcu9aWQtTRe16ZIk8?=
 =?iso-8859-1?Q?4NUCx+S1qcm9FtU/rHj3zHnoBZ/YF4EqQGtKIZx8kBfMBKZDKU0JpHgwts?=
 =?iso-8859-1?Q?cp9Y+9rrUIIP9A/r5QvCv3LJ1T5F9asGfg/66N+vKE8dbq/1v4LCA17GmN?=
 =?iso-8859-1?Q?5UwTYjrwb7QBUxe/js9oyc9miSvf36IYxkczdzfb590V/TGXUEL0ABBaGP?=
 =?iso-8859-1?Q?VYh5tJ/e97xEK25vO7wdEbu7qaPwJN0Af1VX7abpiCfpcZn8AriKES2zRp?=
 =?iso-8859-1?Q?+kPpUelrfD9VEWeH1LA67WHERbEjPpOTsOczsWQ4nxu/y9TWlqmt+O7HbC?=
 =?iso-8859-1?Q?nhmswyln4O8lW3LYyIfSmQY0aYCc9EAYUlOyAQ4CWFpZ2RgV/Z9GyE0XEE?=
 =?iso-8859-1?Q?JPT0Twv6w+BslGDP3vKIUARoWO7ZLW30Fs/QeuBlP8IaI2NhGZpT1iBNNO?=
 =?iso-8859-1?Q?7i+RmuTr3P4JOq8/GVLHo8mh087AL0XfnV9DmsIskGLyaXzPHjz6tBcNWH?=
 =?iso-8859-1?Q?Blvdoq53fUhwOE5EeXd7jZgIGdou+XOcQBf9zfSjHbBp0gRlUnG3NYg6tx?=
 =?iso-8859-1?Q?Ague+nEtsgzV4AuiBApt94WXAgg68Dt+BNI2XaZkwqtrwg0M8WbRiPo/VE?=
 =?iso-8859-1?Q?IvjTyVJvUda3ByJLBGf/7ETRgWRu/b3e+BTvEunNDXQN/y9m+3P2ouauFS?=
 =?iso-8859-1?Q?3StJCdtROP5sTRxpVbDT5Lh2z4e4QZQ3qWC+j5C4HqyEfwGRpkE4zAst8G?=
 =?iso-8859-1?Q?9M4S2dBria8SHWe1Enlp71v5bDMDUMhyOjVLu9Oi/NFYjbsYo4NRWelT2Q?=
 =?iso-8859-1?Q?Ag6Gqf5nVw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ckh6k+bAeFqIrvxHnhjXukxY4Xuaaai4X/cXHqiUzBCJejylFo4BJImfU4e86E6UgKtqF7948lmE8ozlpt6w98NuPJVXNe83mTkoCmmSt1Pz9+rEaa7/bzSgXagNvXqIsk1G5J0qqoKCHlerzt9W6k1JFHuQY7aZTewSWVwnfgZ1/thjb7h/lVRzQpIS5BvTIPbybrj5ivBK8mtYLDl0j5u5qgYFtovb4WIzsu2T8U+oDWFOUukwU2DRjvi5ErOWHWY6LkZPl5iD9ARD8d+qc/RXFtqJ1T0rkLvUYr7R2GpmyVxH6ZywmG0+l2CWWMGus+BTJZutJxTuamxlYrJxPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sfSD8Y+rYj6NYMlOPG2yrt5n0a9RtgQX7Ht0zJ8xAaYDK7nXIm6o1w1EzfdKGB4tPwXnyUWAkO7iNT9I/Spc2mdgxstmZjpKlCMDVa+Iu60U3Zj2xxIFkZ9AawdCteQMX7VrxrLoF0utt8hofg+NFrK7QrST0ftOxItCg8/ehkhqDQ/Q+miusQHqvmeMeRMFGHuRKhWn8wqbX4MzbztuQ5Vt+VYku3UeRQHZeqKS5Rny4F/vLnPXfYkcDYXE6dEYf80OQsws2NDxmHmmmYachajFeRqYLIR3BM+9cYvS+w1bhbtZEvzEXluAqJ32qyIRm329ICnhZdACIHRx2lElgCdWqG4WIGkPQGIGikokAWTgykRRVH4EemXGXY5nlsL2JugEwtewGcEsOwv2nct41BbhMzZoG8r5rBvUPgVsU7jYi6rRirAFlOnqRl1IDG8eK5LvzBzfp76RcP3I5nI03TytQxInAv7VirNXStwA74hWQegZ1h4mtLf8G4LCn4pCmqcPIdHKkIGxeDlwhjzk3zWxk8oNGZO5JWD0CigJcaFgToNZcV3obSeiu8afm7x/UCxBHrpf0qzjWw18Bqft+QpXkNrbvZ9prdLXjO4HkUc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5785.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876193e4-4903-4591-ca6a-08df40d5009a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 15:52:49.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIB7Qbs+jSPFoVGSaQfoUMOvLf950107hv3W68Hr1Am9CTzKIPCbvAdwv8IBF7rYg6P88dnF6BRwFyTmxqPNuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611120062
X-Proofpoint-GUID: wvdsyR0WpNYeaql_QRUNCSw6mLr7vgx2
X-Proofpoint-ORIG-GUID: wvdsyR0WpNYeaql_QRUNCSw6mLr7vgx2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MiBTYWx0ZWRfX+RBi6EYu3IvJ
 R4feJ9oT6bOvxYyg4CHvd7bSmNB0nYcvgMMPYmmmzmT/gcBmLm4rp44QxD/sDG4LO9PoIfJNTt2
 sSFUAinbSPMc2kSv8FW8inYwFaGg1TkC84h1xABOfoIKYQxg2tHw
X-Authority-Analysis: v=2.4 cv=TIPQ2Fla c=1 sm=1 tr=0 ts=6af5e0d4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=yPCof4ZbAAAA:8 a=EvLsFUAmAAAA:8 a=uZvujYp8AAAA:8 a=6cVhVXFjhb0FDlLh9sgA:9
 a=wPNLvfGTeEIA:10 a=WmVTiCyuxqgg3mnwYu6p:22 a=ihFelORD2_JXWTZZVsTd:22
 a=SLzB8X_8jTLwj6mN0q5r:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MiBTYWx0ZWRfX6nOGKEZjBREl
 JhdGcKWzKkyed6U/5nH1hHRlo6oDZta9LpSvQ7ypJRsb9UUzuBp1BAYY1/ua1DKTyYvsXFg3EPB
 Jck4iunFksEoV5n/Uh4A2RwF7Ltc4xwQC6zfak8JL+hxUpdbetVE14tsHUJQZs4iCT8O9DvoMH2
 796wmVlBK2PBpBXnihv7SU4YdKIXh49J7XP2TjuYrIaOKyuslPrD0gSkbnjnpqUX1LS+ktwMDCO
 ky5RqBS5Qkar+Meag+v+5w2hHyO7BBNPRT5eg9pqkyw4MYWCAsYjB6tZYIXdUJjQzsH+SBXFMql
 UYfdH6ZFbbg1rxkDQPeYhuPxTgTQG3sbMqn2AfoVVN4XhRt86Q/gKhIaQFPq83eliK7QQXY+mB4
 Q9C1OAIdUX6rjS7rwlSi38Mb9CVCE8OpMC4BbceZmz92ESDWERop9zwc0a8IIdCtBUCpZp7kaiQ
 5ITFW2thJe8DEaXE7Ug==

Hi, I encountered one more minor Solaris failure.=0A=
=0A=
On Solaris, uname syscall returns non-negative value on success and -1 on f=
ailure [1], which is different from seemingly all other supported platforms=
, which return 0 on success (and still -1 on failure). As such, the current=
 check in version.c doesn't work on Solaris.=0A=
=0A=
I managed to fix this with:=0A=
=0A=
--- git-2.56.0/version.c=0A=
+++ git-2.56.0/version.c=0A=
@@ -83,7 +83,7 @@ int get_uname_info(struct strbuf *buf, u=0A=
 {=0A=
 	struct utsname uname_info;=0A=
 =0A=
-	if (uname(&uname_info)) {=0A=
+	if (uname(&uname_info) < 0) {=0A=
 		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),=0A=
 			    strerror(errno),=0A=
 			    errno);=0A=
=0A=
=0A=
which *I think* should work on other platforms as well ([2]), but I might b=
e missing some where this change wouldn't work. Still, I wanted to at least=
 report this.=0A=
=0A=
Thanks and Best regards,=0A=
Jakub=0A=
=0A=
[1] https://docs.oracle.com/cd/E88353_01/html/E37841/uname-2.html=0A=
    https://smartos.org/man/2/uname=0A=
[2] https://pubs.opengroup.org/onlinepubs/009604599/functions/uname.html=0A=
