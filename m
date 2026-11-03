Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.209
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793735965;
	b=p/GkdcfToJMw1bJT5+vNhQzMh3GA7iWlLG4osT/mf3/e8KXZAWCj9P6ey5VaZhMkHXC7
	 GyO5d6IdaKbH0MKdZ/EizkyvMnL7IKgfCXC2lc7Gv1X2dy1Sj7ph+l+33y3a2LD8qdaa8
	 QrPBPj+bsf3ToDPmn3azvOTnYNCMXHp9lf43zBQigVSv9EeWMgEzZ+Q7DlEkrYd6sxcyW
	 N1ds0ed+Db8MOmEREn1i5gzMd/72Qq3N6/dthfuE41TNe6udRyiaimyjskbQF1Njr6oyo
	 xXK1f01GRbPTMOH+Cn4hzP042VvcCWky6W9cQX2idNW3SrBK3Lm8imfglTIEkE6jeSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details;
	bh=r8tlcZ/hhyHBGEB+7610LxOq0egl6UuPi/0hSQtbX/o=;
	b=uFDscfUDQnyWWTVDXYRXCcb1ehgNR5D2gsseWodS4hwkqB8U9YNRYKXdMAOC3e2hoNLY
	 Elk1gKpL3OfRW4h331n3MhgvaxsijMoK+lzwMlBY1weaBP1iryLbHbmAVUxHs3j4j9jwt
	 5gP0O1oGK3OaO/y/I1EJf6w9mKdPBTW7uj7+HWxoeta2c1yG/gFneSJW/ka7/4TrgavCU
	 2pmA8DLMwY4P3JilM83/34Hy+JPqMO95a7QRwnHMeJElkBO+/a923JABZrvVZAl4ODjFH
	 P9ZRUbP4bCBNVTKOE6A2xtueJ+IDJ9rH4yXdoPps/4IO4AzBDd44CxqqRlNIgzoPqIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=epic.com;
	spf=pass smtp.mailfrom=epic.com;
	dkim=pass header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=2k26 header.b=E3eUXpOY;
	dkim=pass header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=selector1 header.b=arWgDw3l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.209
Received: from mx0a-002b1501.pphosted.com (mx0a-002b1501.pphosted.com [148.163.150.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9E606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45F9E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=2k26 header.b=E3eUXpOY;
	dkim=pass (1024-bit key, unprotected) header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=selector1 header.b=arWgDw3l
Received: from pps.filterd (m0119675.ppops.net [127.0.0.1])
	by mx0a-002b1501.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Ib5f8590174
	for <git@vger.kernel.org>; Tue, 3 Nov 2026 13:59:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=2k26; bh=r8tlcZ/hhyHBGEB+7610LxOq0eg
	l6UuPi/0hSQtbX/o=; b=E3eUXpOYCj4fs1qUxQB+gCXivOlSWaA5IM+12MEpuWY
	JbV5Wi7dgKhUU3ifmAsOWCaoH/FUjA0Dx/3Lg5fXyKuBQzPqQBZg/j1km4mOzGFL
	oQb0TjoNACY6+vR4iMtblvpSd+ZeJLkXorooMF+HPLzNGJIfjUR5eP+x2INCswc0
	NCD5PLqhtPXxiGcJJLE6+UXeB3fRqJo+ibQAC2iAnsbsKwmSjC5A1qvlHzpZDJre
	3BDY2l2oStZ12P6TFK+0XVI8d6g+tRyhsnwYb9/rS/Wat9ZDDQzcxOKWDwjJ0Ko8
	dqXABzU+6CgqJW7E2TiQ7lx096lEBypmBL355bmZKaQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	by mx0a-002b1501.pphosted.com (PPS) with ESMTPS id 4hqkj18rjp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:59:16 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsIdUD8IBIXsRY09vJ/GBKjegDMogK2aT/zq53QunbYbi+OkNeTbAzj/27HHLuN3FsQpZlXxuqMWhgnwxLWF8yB6VuNkM8GFRghOJ2zFSMffaWxXQfM+674USdfe3Nrb/gwajBiZImfeb82sGFdOuoaDnRZsLzPCnqhfDeykIAFXF78CcX0+J3WxnNzAdHZIREv4vwUE5j+VizwbGqPywZwUFgIptQ1SP01D1h+CTQ9ZkaRR+A9YuNX6myrsTnb1G7O4JnJZMiomynNpsuZ777rX4RyUEdlDdht5l8q/JWcg6sB35K0RRaemZPewdUv7mB20QoEdtqg0IkPi8jiorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8tlcZ/hhyHBGEB+7610LxOq0egl6UuPi/0hSQtbX/o=;
 b=eE2F2EdkV3/Dxze7m82R2aP5IpNKFqvcsv8HH6r/keOA6rW3NpGQ/Trym5zjlIGD5BOIAyUTHUViz72Bnu+eNuPPr8Wg8oNtNylJzpEE/2hIAwAp8flglGhr54TbZico+U2b3g0h1f6VC3nll9dS3yQ2Zz7yE6nBHHs16G1R5GrMgWw4lRQImJ73ue3pq+wVGERp8v0+rWmdmLLrff2OY74zIZeLbwzyH2ifMHbRAkkYdLTwY47RVW89Nx9pGxCmdlmqSrbWsIOECcweL2Y4IBPECLy401AEh4Oj3iJltuyNjJ9pY62X5/E3bjUEArK/bFz/ubHApELDj73ksVeSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8tlcZ/hhyHBGEB+7610LxOq0egl6UuPi/0hSQtbX/o=;
 b=arWgDw3l/NubieijCaawMHRs98Mjm0jvMr1SvK5gGY0F3ejlt9lnV+DiDZrPBFClg4akvbjSIv+zPXEueIcwmhGXLy8d7BxQ7kgVSgBNT69XTYAAsoLWBVOm7sgBPmRtzNd6YlbVjwNel5SLUvSAq/5Qr6cfa63Htf3HL0KyvS0=
Received: from CY8PR17MB6236.namprd17.prod.outlook.com (2603:10b6:930:94::12)
 by PH0PR17MB978411.namprd17.prod.outlook.com (2603:10b6:510:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 19:58:14 +0000
Received: from CY8PR17MB6236.namprd17.prod.outlook.com
 ([fe80::f569:c479:a03d:d640]) by CY8PR17MB6236.namprd17.prod.outlook.com
 ([fe80::f569:c479:a03d:d640%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 19:58:13 +0000
From: Kevin Lyles <klyles@epic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Interaction between pre-commit hook and git commit <pathspec>
Thread-Topic: Interaction between pre-commit hook and git commit <pathspec>
Thread-Index: Ad1rzaMcbrOe4sMXTwGSdQqQT+fa7g==
Date: Tue, 3 Nov 2026 19:58:13 +0000
Message-ID:
 <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR17MB6236:EE_|PH0PR17MB978411:EE_
x-ms-office365-filtering-correlation-id: a5ca8adb-7c2d-40b2-d1c9-08df39e4cb58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|261026121527099003|261022105027099003|261022075727099003|56012099006|261021121427099003|261102123227099003|261026140227099003|261028144727099003|10067099003|18002099003;
x-microsoft-antispam-message-info:
 dD/qrO/Etslu20NyX1odsbobKaO9Tho3t9W2hpKanFtrQxsqD8tHzp1958V+Y8WQf7yQ1gK5afiVfJldjD6LPBB45a1TsgLo6Wa3FDGkEWq3EjTzwdfeh8pbpGoMnroettgvmBQD2X0MbuKPaz68oWw4EyoD2OF66dzkDQTHN/A2LUJdK3F2YukhWA7lz4ujpPHF1YyALfUaJsYuCS2pPEx0tMnQHnF87L/nJB1rLi5GfBhQGyE59QtSGNcUDFkw8F4uukfYkmFYdAfSecfJ2NfktXPatVxQ2J4abAhcY5U6DjlChaPfL7H27mQDemyRcfh4Fvn5ry8hDdDgLMjo2+OS2YQggtGK9mX7T+Fczuv8PWavMeMYsTGNy7BFqe09EjhO7yTWNdPcuBcWbAuXTqFY/Mz8Aq3GBorKHOhplnhAppoRYS1RaEb1mjadJDgeKxnUVN+EW0v5RrYbVVw3ylGF1f12DEo+02H7+SSNWMeRIznP2N9SzwsMIDkQNNC7yG5FtIpUORLK+KDYt9AdnrziSNXEN+yzc6u83EWoVmLQtneELZzx3MlIu3MOrQXVzDvIZbhb0Y0eDrRfb8OKbhkwFuMRMVaZkuwL8hOhwjv1ALErFnuIXZ5B99XG2dr2Z9bO8eIbFxwH3Bs2Z43++1bOxA+Z1kWqX6sJwZVY6dLHHQqe5WtekfRF23Iu2FEDT0u9gNLFCuQUI1eezLjnbXM1QS/wdrYO+rJi8zpwMwU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR17MB6236.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(261026121527099003)(261022105027099003)(261022075727099003)(56012099006)(261021121427099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?G80YP8xPuWWDeB9f3GYD2MBlFRkNWc5MaRKGxaeuYPTFtag1QG4+VwZkKJ?=
 =?iso-8859-1?Q?L0lJhxtHm7xf18tdFruZmmK09syJKF1lEAfVG4GkwdFIlLzmJrNrCTdvCU?=
 =?iso-8859-1?Q?zknFNYa2v16Ls/Edpm2a01nMFCppwrGJP4QawixGiNcGkinbNgtfCOHYSl?=
 =?iso-8859-1?Q?FtPglScjo9DW7AUS7eNIina6lqPtkdOVyg82HxrR4Ju5C4EDirOT52nSh3?=
 =?iso-8859-1?Q?sYE34hwyv959JW38iKZUmLh72GBUx2O6FErxPRqM0KimHVQ1jv+6OFoNtI?=
 =?iso-8859-1?Q?jecW8vtSCVX2feoHYrkvaXXjrooXvj/AU9Jc62ZQJiTMqg7hS+IKSi/m6Q?=
 =?iso-8859-1?Q?Y2kCHl+k4H0S0HQt9hl3YkipGFGRn9KdoPBo0erY2Zm4Z9eHuicMBOZ7x7?=
 =?iso-8859-1?Q?HmhsaNtCdba0GGg0oKQZfYuirLapFU2fcm89qVp8de8FFQPR9NJtCDuAwU?=
 =?iso-8859-1?Q?hVQqFl2rfD0qJUcXh3naVAlER1D0HIQJNMS43M6VG9tNIPBj4D3BbbvQ3/?=
 =?iso-8859-1?Q?DP2hL8L1XxEbk8E42nJxsobOwtD3uCyf+xBO2qKcEJFW7LeA7WeBnmYs3V?=
 =?iso-8859-1?Q?ucBoi70oNX4egTruGB3gxR6LiYQmLgYDruKALDlWtKM7eXwjRey9up8uaU?=
 =?iso-8859-1?Q?MfP3XaANvZuWmk2EjTIaQQ7zlVFhHcajN7PJNOGCJHiXKc+BRF+6TsJ2hn?=
 =?iso-8859-1?Q?0a4eYvuxZiN+nXmXLXgJsFapiwVnKKABCmfNHgbDbgDnjKFW5GO8N8feLn?=
 =?iso-8859-1?Q?regv3n1VeenXPEvt1Kmvs+CjzhVXQHpd5WDFcJcnuj7lWAnkjHLKVhyson?=
 =?iso-8859-1?Q?FGXeP4BHkvSpkYy9OBGqp+oDqqSsq+UJpkpXboC8qc6TrfqEL267c5vhOl?=
 =?iso-8859-1?Q?/Xzc9xslSu3kOWSdeGk80Z25vYBhwrmF9OiWTMnjGR+FtNehRHGuf8+nfx?=
 =?iso-8859-1?Q?IxGBzU7JNsranZJuf4ISzdc/D/MmYlYtDQwLW4mrjihQQilHvqpNmuG+Lr?=
 =?iso-8859-1?Q?127ThdgrvHTVPc+28Wbi1O291PYB/PnNdacpPO4EX+t4qxzug5KVzQoo72?=
 =?iso-8859-1?Q?u79FgPO8MsC/Qn4WFO69sEnPdkji1I4oAsH8eJH+/3pMc43dVZJW3YQiEu?=
 =?iso-8859-1?Q?vtiabGsEUmopaXZWeIozG9UsolEjmZTkpwB3hUzeJyjjK7uZljC19TosDB?=
 =?iso-8859-1?Q?TxfNJZQHwks8qxfbvnPj0ZzJWDRod6Vj3i6KtU18K9zBdlyAIGgtf08ZBM?=
 =?iso-8859-1?Q?6f89AxTEzVnblUquXru35YPD5BoaB/vn5RibxNEHXFZqfnr7hhdag6bWNS?=
 =?iso-8859-1?Q?AqJ1X81/Xec0pClCPo63Wjt1W4W4eErju3DO6DZW7Z04+99lBkoFOW3YQm?=
 =?iso-8859-1?Q?57L0F4NlzPLSLGdw9qzYkCkcfaeZSc9bl2WobPiE6MdvRfKhsa+9ODMswR?=
 =?iso-8859-1?Q?gwUATHs98omln1yGC49+nyXrK1sALip/MRi5SN2xEuS9oUO0NW2p1WNk6c?=
 =?iso-8859-1?Q?2oA29GRoycJNntYPK2LxygNrcxXwQzDgPcgFl0D0gJjZpBeXxKYz0uq1tT?=
 =?iso-8859-1?Q?SQ0anAPbe8rgCs3vRAVwFBOqfB7TVFjXBAYyjs2AJ2yfWaT5edVV+LtOUH?=
 =?iso-8859-1?Q?/djgB0dHZ5aVKb1Rc4dCBzeraa+/0h6HrNso4Tq75Ji5kKOkgelqIzYK1H?=
 =?iso-8859-1?Q?R+wyeS3Trp1uu6V1zdN/YKokAjunopMaM+urRc/wNJsZy5kpIFsMb0HGbo?=
 =?iso-8859-1?Q?I2mvQEYNv4ooMvK63OymYCUuc+KvB6bGuFD4h2ooda3RkU?=
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
	pPUzTsLgzsuAkrqXZHWgezHirzv8MZhks/2U6s66uIdYhDXYZh+ffxrhJH9kZjE+3KUxVzbCHg/zcKR9pxrDVNhVTsI5ZnByWGyYtLMJF1ScTg6K/LGq+j2oMLUSjvjWu9EDVmw7085jnAvFphpEZ26p4qGcu2GWpnqoTsbUmt0J9yswXUD4yBu35q2pHfx4PwXIiCRRHx1BiV+R1FNYjLJ0b682r/5JIxevTtQdXO9YvITViqctg+vyKSPpEsUyS1V6V0uFBiCoaBaUSMOCObt1/Eh/SBtnjaardAeovKdQsG+6ND+jnfnozoDO70ypxGLuwut43hKM87r1Qopf5w==
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR17MB6236.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ca8adb-7c2d-40b2-d1c9-08df39e4cb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 19:58:13.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqDHDAT3JjmOhdaTjJviNuLqGUshifIdrjUFwGYTNLupvzOQ/Y8z8Pw4OBEXLxnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB978411
X-Proofpoint-GUID: 3q6zmkZz6oGDEFVXRwviTY_S9fQi4F2h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfXxkyicZqGbV1Q
 Z1uuHcSpR7bA/4QQT5ghmYbbLuh+eOfK0oZSH2KXkHNfDCx592znOBmD1ytCtPTHFoGz4Plgcsv
 Qht0H18Jwautt7gbt65vpjhUaFlmsJw=
X-Proofpoint-ORIG-GUID: 3q6zmkZz6oGDEFVXRwviTY_S9fQi4F2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3OSBTYWx0ZWRfX2ROX53BJqbP3
 XBaKdDeW7XQ6Njcw4BRsvkAaYJHHklY9M2vQsLjK8Ia02BkVzY/+Vt8HE0aA+bLhMLIP2Uz0HZd
 5SJ8ppcaFTIiw9XRJ7FBka98ftLIuM/PSomNCiXYzk/XSf7CR1jW01F+e8W2rF7g6deOekzhv8+
 iud8QTdvBboRaCQpG5bEJ1URLMN6Jc5H6Md3VjX56Q3xheRLL4Evrr0rtk/S23Psh7ZeRYpAsS7
 hPmgFGfSohoq3kK0qS2cHP+Oi8ZjLY1DnuRgyiGassM6AG9Z6R71yx9jN3l7mo/gYqEZrrhWnF+
 i4lmgfUsPJMrppItX2NWzmnsIlx04A8emaixh1PGf4VtMH4rR0xyyK+x57lFp1GoWINmjwu6p9w
 VWL1jzDxNXV/H5aXZRdVvWDf6ZZ5YM05c/I7/WGwGVuBw2W8GR1uJ3O+aS16aog95hvW7peXO3m
 TT7uC+JpMEH8xjsTGXA==
X-Authority-Analysis: v=2.4 cv=CPG/zhrD c=1 sm=1 tr=0 ts=6aea3d14 cx=c_pps
 a=5k1muW5XIJfqWNzrwyhXkQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=fLxXaBswY2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HcFE1RN0hNOP7eReKWeE:22 a=IjcuBzXprzpL5ATefVdM:22 a=nqngphQYAAAA:8
 a=5apz4Hrxl1c4RmL2sF0A:9 a=wPNLvfGTeEIA:10 a=l3Kf0c7r5vjhVLBHvrpp:22
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030079

Hello, folks,

The documentation for the pathspec option of the commit command claims:
"The contents of these files are also staged for the next commit on top
of what have been staged before."
However, that appears to only be true if the pre-commit hook doesn't
modify the index contents.

Here's an example pre-commit script:
    #!/bin/sh
   =20
    git diff --staged --name-only | while read -r file
    do
      {
        git cat-file blob :"$file"
        echo '# Extra text'
      } |
        {
          echo -n "100644 blob "
          echo -n $(git hash-object -w -t blob --path "$file" --stdin)
          echo -e "\t$file"
        } |
          git update-index --index-info
      echo '# Extra text' >> "$file"
    done

This always appends "# Extra text" to the end of any staged files, in
both the index and the worktree. It serves to illustrate the issue,
without getting into the weeds of what my pre-commit hook is doing.
Suffice to say that my hook is (sometimes) modifying files in both the
index (to make sure the updated contents are committed) and the
worktree (to reduce spurious diffs when file contents are changed).

Here's a set of steps to reproduce the issue:
1. Create a new repository with `git init'
2. Set up the pre-commit script above
3. Create a file and commit it
4. Modify that file
5. Run `git commit <file path>'
6. See that the worktree includes the pre-commit changes, but the index
   is missing them.  Alternatively, see that running `git add <file>'
   results in that file having no changes.

If any other files are already staged between steps 3 and 5, those are
included in the commit and the index includes the pre-commit changes.
Additionally, adding the file and then committing without specifying a
file path results in the expected behavior: both the index and worktree
end up with the pre-commit changes.

Are these differences in behavior intentional?

It's possible that there is a better way to achieve my goal than a
pre-commit hook.  I'm open to suggestions.  However, anything that
would run per-file instead of per-commit will likely be too slow to use
in our (~4x the Linux kernel repository by file count) repository, at
least for some large commits.

Thank you,
Kevin

Kevin Lyles (he/him)
Epic R&D - Hyperspace
klyles@epic.com
