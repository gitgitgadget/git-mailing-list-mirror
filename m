Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7536827E
	for <git@vger.kernel.org>; Wed, 20 May 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260388; cv=fail; b=f8iF7u0xZW3brMfJOVdAMs9Bmr8ADSzgnl0VgppoEQt7NuU66/LTU4qgQebxVqo6s3a43qjGPphvv7C/BPfLJwRyJuYuCf9PserYa0rdnNtWdydPlauQWsf9ovSi3hLOT0LpUwDrmDGTA1DIavsdHf9F+3PprmiOjM8rtnNf86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260388; c=relaxed/simple;
	bh=VKS0XugGkMJ9Wc/QpE0+NUub4G4lcwJXwsoIyKhQqHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usgxuZFRwt0C2KhVFPr0ujcVNGQ4yXqiXEDB3RZ96jhjVeGzj24h0zBAgAOb1ZbwmHV0TEnm1jUYapFH99rgVHjgoWNpDPDGtlfAFluXWNfPvhOaH9snBF1G4YhU9ZJazWEbhJDOSsKyv1+to4jMAM7yEg27BMxFfGmJmg4ahNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XHUlXY2G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VPp10EoN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XHUlXY2G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VPp10EoN"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JJMviF2689835;
	Wed, 20 May 2026 06:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=D1oYIPUgrM1R3xyYzz
	Mh4xjxW5CWnHUpuGxpM6YQjuo=; b=XHUlXY2Gwey1YnrIqOCSaNwrb4PHKmT3cb
	Bn9AfSzn7V5yuhksz7Xkr7O2P6BYWfbKBcf/MpOpdOo6X3zZVhi+paB9ZNKUtnLf
	IY+nDDvPbRW0/5E7xholdK5NRL4jb/Xpgldt8XuP652Z+LxPMGIJvVAocojd0l9K
	//EkDBmlYABdagSfVPzpmT939t+/pjt7ZylI/Eu9fs/mG2pjaaweY4225DQ7rrGY
	DI+eExCuOMtOFOxPh6TSOkx3YXaToMtwl2yRxcf7YOK7rt2S0f8TYtyaEsqMdtmK
	qtqZ4cKaWf1/D4mKfhhCTdiXvx4lBEZyklX9ot1cQFJ/0I5qt1qA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4q6er6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 06:59:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64K6t127011171;
	Wed, 20 May 2026 06:59:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1bruv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 06:59:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqyoKlTVF1iinAU5IxgfbrIet1Zb99prrqxG/WjEnYVQYy1f5oXPi2uRLYj8OEreP8iLgM2fST4rQc7HhfxQKaed71i+KpGN45rqjgG/QMwFGST1UmFS704dnjIgR4a/3WfDnoGWzvVzLnlh+7cUeL3WZNaA+0lwnRGu84+xmyG4XLFc2HbE7XQJOFTAG/xI/72AyghZWpF8fXR8Eks+9tIhuIJAKOsggO98fQsl5UjMfaCLCFV5JGHZn1/wHnuxrdbsPqqvbxTzqC5hV171rzYHFSdBhMlSE4l1XNItJFBu3lKSdGzWKkRuztjG3I7MFD6yNhJpcc8zDiH7ou+zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1oYIPUgrM1R3xyYzzMh4xjxW5CWnHUpuGxpM6YQjuo=;
 b=C2SNQcGVBnvmwtgThsXgvKnlqiJlw19KcyV8Pdc2nUH7zuUaFAwfxm1f5TUZQTL7hAaK9CMaZ1W6e0EhmZYw7rellOEy//LbNMlUOgADOrbYMZNBC5eQTEEB2JnmcxbcgFp2U7blEREd4mfZ+pGjIQoywdCoXOcHQzmL41l1bpBSRLueCoEWcCQk+Gzic0I6eju2YKJBg3g0dOzxDivVFQ5/YKhWecryxQXarWkReH4ZqnoVugyG06ijW2SMN4ELL3OBnvhD3g3lS53IekdTp6Z7AqbJZryYO5lUMt/Q6vTV/TVqra3z9p+haZHGdWRQIvAJXM+pJqBXwyu+8ABNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1oYIPUgrM1R3xyYzzMh4xjxW5CWnHUpuGxpM6YQjuo=;
 b=VPp10EoNbM8Iyr3QvL8Vvns1h0uGV8Odtc00h2mXni1kM4NXb/QJCr3L665/Zfpj/OKeyixsHx8i1osLEG3hrYlhv72x/ZN1FF4ToXQKh7va88GVlZm/rF05qpi5zuncpDlHt2YabD28oXANvoM2IArRcNeEu0ifGUq3sX0jr1w=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA3PR10MB8348.namprd10.prod.outlook.com (2603:10b6:208:581::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Wed, 20 May 2026 06:59:37 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:59:37 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "calvinwan@google.com"
	<calvinwan@google.com>,
        "newren@gmail.com" <newren@gmail.com>, "ps@pks.im"
	<ps@pks.im>,
        "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 7/9] notes: support an external command to display notes
Thread-Topic: [PATCH 7/9] notes: support an external command to display notes
Thread-Index: AQHc6CY4QerVTb4goEeji0DHcdG0ZQ==
Date: Wed, 20 May 2026 06:59:36 +0000
Message-ID: <aaf25b8c84a51d0a3156af1944ec39b51f764019.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		<9619077369f1a567bd505b1de1e4f672a5cd1950.1779207350.git.siddh.raman.pant@oracle.com>
	 <87fr3nq74l.fsf@gitster.g>
In-Reply-To: <87fr3nq74l.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|IA3PR10MB8348:EE_
x-ms-office365-filtering-correlation-id: 793a0cdf-fd4a-4091-22c4-08deb63d5b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|6049299003|1800799024|3023799007|38070700021|4053099003|18002099003|22082099003|56012099003|4143699003;
x-microsoft-antispam-message-info:
 3Z30G3MbOy76EjV0GvyBWO9XNlz5og3Bx8VYSeIqDJJwDSnWWEpFbwjfzef/ilKLWxcV2P+r3NFsrWd0sJZKdg2spRPgj/C8z2UnSk+BKfjRxnx8S0W8cPjm/ClwLFvD2o0qkxowwnCkfc7HGb62V8xsh80VDFO1bVjKG1MRR0GeqX1ZI7sqvCK3BdtFWbN4XUIdEyiPLXn4Oe7zOhJQETyOHvBJsYHEBU2ajZdpHhep1qNyZvhqc99yku3cRAotak5yNri1J7sbiW0gYtRJ3tM6GpGVoNw7mTaw0xtB9h8VqyWTOfd3ii6hmEJGvZGiwEg839zbt5JTr5ZKy1wSWoCAM1uZB9rUU2naBUV+fa7SYInzFb2WcnixS9hg7+Mni4d9dqhr4LZ3HdztLyRo4b2KnYaLUfM+SATRkSMSQvDwbOW2C2/N184DoBjzK4OmM9Xv7iT6Y67+Bi7iAHh4SwmsLtI5n0MRd0cBz25DpAAR65h33fwbZNYxuOOLKhopwuznETmjm36c/xJ7EmzSnwhyy4nduafldE2mvGDPyrf/EU4xyRsuqKvEFBmcpF2TvS3jFBUAjT8MtckSG9okFP3DMrbuzGPDbqUOZWL4CjTY7KfA/PQzMol1wyQyqDZ3PD72GxxLmPtXBHPmHlgbPCDN8CrV3LqdRNk0ogLz+ibGLGaFr5bxTsL2S5bT8QUfyRWyl9IaO7ThX5v8Th4IhDxGeAh5+QcCdVCuasptnYG1XGOAQ1wNyiKBZVJFU2bT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(6049299003)(1800799024)(3023799007)(38070700021)(4053099003)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWtWSkJtVEpoSkw5eUN1OGdYOGQwUmNINHlqQ0F5NjBqcUtpZDBtbUVISjI0?=
 =?utf-8?B?QlVkU0diOUZZQkNpVlc2Zzk2SWZXWXhCVlB5ZTFYdHpUTXBNWXlJZkpuMUZV?=
 =?utf-8?B?RS8rQk1RamkvTjRVaytYRDZlV09EanpqcDU4WWsvdUpib244a3Ixc1hQTHZE?=
 =?utf-8?B?YjVwTmtmWlV4YzJ4Wk9kYlNWZE9Cdm1ZZlBtUDVJd2lleWxDUXhvMTVWaVdL?=
 =?utf-8?B?UFZVNHRxanYwejdGd3A4c1BidFJTeDZlZElDcCtnRUtnT3BmZWZsNWFhTUpU?=
 =?utf-8?B?SkFOUGZqY091VEhQUEhVcjZiSTMreXk0ais2SmVrQThWaGFKZ3RMYjFxTjdH?=
 =?utf-8?B?RkwvdkxMWTZWVEQwTDB5V2xQY2xBVERTTlhnRUQyWXNnY0d6UFJ4T0c3S3Qy?=
 =?utf-8?B?aTI0Q2lNeVBCVEFVSjVnWTBWS1U0Uy8yeklsR0xJTFpJNlgzU3dCbDV3a0Np?=
 =?utf-8?B?NnpmKy9CMzF5cDhiS2tjR0l5OWFaTGRLd0tQVkswa2U5aFkwTDRFc3dUeG9o?=
 =?utf-8?B?NVFFalJPcWs1MHUreDY5RHY5eld2YS90MVhjWEpJd0ViWld1VGwwWklLVWY0?=
 =?utf-8?B?QWJQTVpxejhvOVhkZGd1T01SbVhXcGtuK1VwbnVJYzVNUlJDSzF4UTU3bkJ4?=
 =?utf-8?B?aGZCZVFnWVRHQllNekZoWEZiV3B5RFp2b0ZucGNuUnMrMEJ0aVRoYjNXdm9t?=
 =?utf-8?B?c3BNaG1melV0eGVmR0F5ZS9uZE55OGFyM1NsT0lqSGxPYUVmUUkwNVlqOGlT?=
 =?utf-8?B?U2F6WDVJZnJVOG16b1dwYUJydE9rdkhValpnRTUyS3NEQ29jRGdnVW1BNTh0?=
 =?utf-8?B?QkJ3WCtYRE9zYm4xZ0dJMVd6bXlhbWV3WGRCeEJERFNicVU4d3puNjhLZ2Nu?=
 =?utf-8?B?bStrSlZkWkpnVXpPMU5nL2ZJbU5rOEpxaHhuc3VPZEVvTFV2ZGFWNENPMG45?=
 =?utf-8?B?VWlzTVFUYjM4RXVrTWQwWEszdnptV2ZPUmNwaUJla1plTHdoNEhma0pIWHBz?=
 =?utf-8?B?K2tZcmo3RG9CbjRLV1plQzNUOUlJanU4a1lUaXNhdDJFSmlEbURxWExrTnJB?=
 =?utf-8?B?NXJna21NOXh5a040cGlNV1pvMnp4bzRWRmpISDJpaUpsOUJOVDJUL1JJV1BW?=
 =?utf-8?B?bkJvbnJneEVBY2ovbU9JeEkyVUFXZFlYR0lQWkdHbnJ1UjFRdHlzUFRXVExN?=
 =?utf-8?B?cUxZZ3daWUdvb0ZJTWo1ODQ1OExkSXpZaEFtWlp2VDg4b0FRcmdLZXljVmVZ?=
 =?utf-8?B?dUJzbWhYRmJYWXJEbW1vT1pQbWN5NEdNQUZRRitYR1IwSWVIdGNBZk1jU2tG?=
 =?utf-8?B?bE9JV3RaWmhJc3hWK3RGWFRaaFpUM3JlZ21QRWc4NXZIeitZbzYxMGlNdW1Q?=
 =?utf-8?B?U1p6OTdMZGwrUTRBTkhVZnVSbXFaaEdqUmFzazFRSVBEWFNEMGRZQXUrNS93?=
 =?utf-8?B?a3lHUzRCVHE3QnpLN3liRDR3UDJUemNyWk1IT2c5b2JDd3E1SzhaVmE0Rnp3?=
 =?utf-8?B?ekY1bndubml2TDhySUpNaXZaZGsvckZlNUFSZ0ZsZ01CdndtaERxT3lLN01s?=
 =?utf-8?B?ZUJmaEc2dEQ0KzFBTWlvT3dFRVVpbm1oS0NNMDNNTzdRVmZPS2NUYWdvSlFZ?=
 =?utf-8?B?dFdlMXFsaW1mTTBTbkd1U2NDaUp4eGR3eDhiWjdocGMwNDFuam01bzBSQnhl?=
 =?utf-8?B?aEFIUVErZGUvdHQzMXFGNWRJQTFpZ1c0ZHZTSkVxUFZ1Zm9QT0swU3lYMWNV?=
 =?utf-8?B?ekc5YzlGQWtMM3IvYnQ3a0dGc01VZEhxeDNhSmtvQ3RrUjc3SGw4ZEhjTytK?=
 =?utf-8?B?U3Z1cVNOVzZ0ZERWWVBGMkN6U1RpMjl5VEpwMnRjb285QTUrSS80N1llNE5s?=
 =?utf-8?B?T081VkhpWFRQcWF2UEYxQmcrUFNkNk5TeXVoYUVQM2YwVW1MV1BvU0FydjRB?=
 =?utf-8?B?dG1xNE0rRnNNeTNVYmk2dU5UY1NoWGNGR1UvbVk5RWFhOUNyUm1PeUV4SVIy?=
 =?utf-8?B?YS9qSUNFak54ZnQ0SFg0RlZjQ25tM1ZvOGkyZ3RVaXZRZEF4ekJISlZ4Y0tz?=
 =?utf-8?B?OEZ0aU5lL1JVYi9neDB2UWs1N1M2aWp4REF0RkRMSUVqc1dCOUpJaWxKQjVD?=
 =?utf-8?B?UVhrUjFMZy9JUXFMYVBtajVhOG5hclhCTEg2ZGtWWk1JSXJGVldCVENJMTJR?=
 =?utf-8?B?MWhxeEpjazRlZi80TnVJUjhCU2NYd212d1crOW9OTmZmekVpaVN1SU5oRWJD?=
 =?utf-8?B?RU5TcWY4VUdMVEhud2MySVJHMnFlQ3pFQ0I3UWlFZDlaY1RmUTd5N0RVOGtx?=
 =?utf-8?B?czlwdGpSSkRzaCs3SUJyUDZ5RnUwSHVuMXB5aU1ZbzRZdVdadDZBcmtkVy9S?=
 =?utf-8?Q?O4sQIAGHOXQlOH4yrCjG113N8Fn0/etyufU/NY6xopxLE?=
x-ms-exchange-antispam-messagedata-1: qm+GImfVMdGYHAlPaxtHOufOuyGlp/8Ris8=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-OU6SCFU0rwmpqrRxRTlz"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	BLHhiIm4bcgvzs28RZ33V4beUHBS9kJUBeHn6KPqGk1dhdhWh0fRVNNxXeLJunkT3mzgbdS8yHj5ffhdJWKSybKUV4ri2PBfFH4wKLcVLZsk9cViH8EgGlbuAOo5FhGEAnmWB+cjWUoKGK61JFlurwEmvODCcc64cHDG2g9P40Gu0rHyPl1esBIjd/x2HeVKskE+8PLU1txIbWe7+zyfwYO5DqX3bjwAp5XZXMKkl1IvVzOuW3ioGsthcFUnd2t0jwLt5SrZE/2ozoU2C2fqZtn1LI+SskMduUMElRYKYgrY63MxNxcRUT18jhimvC92q3K/OsFGxHwz9CJADlC29g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IMrRdjr2sb2Xa5AbiBYZ2RG3oh0doZfW2ZR1BNdtXZaNw0xe00XtmVeMU+xrJqqUKg0orO1NYJgJxQnYWR3+bppLPqIW/SEc1v1vBtFDR7w0qWMdzfGhrv3KwirEohiHLB5L/RR6XgoyBzeJfwU8OyEqEjpMlpIB9bT6pGqvthw+w7dVsCrVc8f2WLJZOhSahpesbkE7fACZzqpm01agKkbc729lSQ1SltA/87/IcgNAZGqrNpH80kIv/JeMXPZpy2oaGkq5+aNcoZBJh9jF8eOsS0y2/BkHDiQ0oIejwSwxUzDGLN79uEAUIoHV8WPpX9vmrL6yKzTVto0R2C1VqdWE6mitttxjE07HN2JyUA2r48o2CNj+oGl9wMrxPkcyKUJHxcjL+2pW8fvJnwtlvab9GW7EhvZCwVqxYQTA00GYiQaMh/YmoO7PUtmZGHHWoJAsSmHGoqfZop4hbs8siZtru3q6RxT8qLD/8bE28IZ6op/K/1ruEtaX94cJS5JE0nYyv2//xdRpA66aMYydPYE8p3HJFOrzRDhFqE6xRi/OLabtFzyuV0o2U7BxeVlbGa0IssISSg7JpwCkVvy4Ap0wk1YNnEeC78FVswb/JVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a0cdf-fd4a-4091-22c4-08deb63d5b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 06:59:36.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9I3ibwXryWEG4ugSF1l/K55BdkoxoxPEjhlg7uAdnHAvwAbVVzzmMY+oR6B39RjKb6J0d1L8zLOo656e0T/02Od6f168tiaxI9899YvMppg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605200065
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a0d5bdd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=yPCof4ZbAAAA:8 a=pLZwUUUAabWpCopk0MYA:9 a=QEXdDO2ut3YA:10
 a=d1ROjDpXXtP9WWCVSeQA:9 a=FfaGCDsud1wA:10
X-Proofpoint-GUID: E3k3_ghQeXedU4l07uE7OGd92cfIajZq
X-Proofpoint-ORIG-GUID: E3k3_ghQeXedU4l07uE7OGd92cfIajZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NSBTYWx0ZWRfX871yBB1P9OFw
 15LcSKGbGgmU+L2X+dILgqGqaClZ5gwQEak4V1pUmC8qQ7oasbTlx/iOZI0zX19gyhhzANy50AC
 60H8kskfMMT/meHKVgR4SUWQU5q48BogHKYhPRlzDkQmQzyuksJIn0KTzC2fZ3lYJabBWmB+EG2
 WUV7+5kCz6AGggILn85fURyGtjvC7XO8C/1B2xNSTyDugG1OI04a4iIE3ik10I7b1L8ms40tUV1
 YdNC4XA83oPJb9myK6s4Ej03Ln73XXQdzRF8EkUIiQStQjqcn3lresaXz6/v2w/ZPR40ljlRK4Y
 OQi/Lx+fOp7SeB9saLsCWkvxcjJistZ4Z3WZpTCewz2G69gZDI04QdgQ8hEjJ0GSBNs0WNxzT3Q
 4z6EMWoLkyAAx/5B/UWHIydBv4+Q4ZuvrpD6OlrNP+ZGLTZYWqQOAWht5VSlEmGEQVYIlslp7SE
 uzFeVwa7Mgzy1IXGKtg==

--=-OU6SCFU0rwmpqrRxRTlz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20 2026 at 05:33:54 +0530, Junio C Hamano wrote:
> Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:
>=20
> > This problem excaberates on scale.
> >=20
> > One solution to this is a realtime fetch or faster updation via
> > external means, but unfortunately we lose the coherence in the
> > display of information, and the user would end up reinventing
> > git log.
> >=20
> > So let's add support for an external command to display the notes.
>=20
> It is unclear how we would arrive at "So let's" from the previous
> paragraph.  It is not limited to notes but multiple people updating
> the same thing racing against each other happens all the time in the
> main part of the history, no?  Isn't a better solution for such
> racing situation usually based on a better merge support, I have to
> wonder?

Sorry, I should have been clear.

The issue I meant to describe is not primarily about two people
updating the same note object at the same time.

The workflow I have in mind is different. In kernel work, the same
logical upstream fix can appear as different commit objects across many
downstream branches, such as the stable branches and vendor-specific
branches (based on which the released kernel is actually built).
Different developers may be working on those branches in parallel, and
a review decision recorded for one backport is useful context for the
others.

Today, seeing that decision in ordinary history output requires first
synchronizing the local notes ref, and then interpreting those notes
for the branch being inspected. The latter step is workflow-specific
and can be cheap, but keeping the local notes state fresh enough can be
expensive in a large kernel repository with a large shared notes
history (and if we are to extrapolate, a slow git server conn/ops can
be a factor too).

That is the synchronization problem I was trying to describe: not that
Git should solve all concurrent note updates, but that users can be
looking at stale note-derived information simply because their local
notes state has not caught up yet and catching up is expensive.

The intended role of the external command is to move that freshness
policy out of Git's notes ref synchronization path. A site-specific
helper can decide how to obtain current note text for the commit being
displayed, such as consulting an external service, doing a targeted
lookup, or using its own cache/update policy. Git still owns the
coherent git log/show presentation; the helper only supplies the note
text to display.

> > We split the addition of documentation and tests from this commit for
> > easier review. The new help text added in Documentation/ in the next
> > commit should make the usage clear.
>=20
> It is unclear why a large body of code that is not documented or
> whose uses are not illustrated by examples found in the test scripts
> is easier to review, though.

Okay my bad. I'll squash them in v2 after this discussion, along with
rewording the commit.

Thanks,
Siddh

--=-OU6SCFU0rwmpqrRxRTlz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoNW5oACgkQBwq/MEwk
8ipmHQ/9Hjf/QawkLIaJvhx1l2Dw+ufvnrWDVJdyS7sqwh+0eOECqTEWf1Hwuj9M
Du3WkND6Q5oogpryOl8SPTx0sQNDPpFFPzMFN4DqW0njIPAhKmBxDr32ib1IDqGG
4+DiK/FUA73A16T43bzkLTnVQtYezbmTnzXKcdbAZhnjRJzqw9eINxwHxJd4EhsV
tENvr5+XbGG+USjX5pNMfi6OWaNSfPotroSNgfZtyfTq4uvZ3qtZh0XECIPBREiM
1kbJoSPUTvFJcbZZxE1ZdYGIFKutvNz/tHP7MiTsBkq/BucbO8di0B3GR5UlJK4u
3SDedwfMOF40mcEQCVXy0h2FBcnaEfh8hEQrjqcJSXSUHrAefwj3NT0zIOaua9Z0
LdjPiWIzjG0lEbvPycaqKBAvErKFcda1W09FpUPVf8bCdp3zKxpqZ1qa/kPDYNZj
j5ZZaySbgPnnrLLZK1/KPNr3vJ3u7QQHI8Xk/1bHt+WhLfGCsI16hy9a387pLPdq
JfuZnfQL++zhEW1Ke1CRQbNwVNvpxwozz51RdVHFAn8ux5XFpk/DFeds9Wv/fWP3
dnLhZkS33v5/koKaTeJBJDisbHusiNmME9tR3KjLZhwICE8Uwh6qaDOcXhAMEeDM
5SVJttlXfcgwXp/hU6u+RTOR4ewl6tU+OHLlkhNJNQYHy0fD+vY=
=SLxp
-----END PGP SIGNATURE-----

--=-OU6SCFU0rwmpqrRxRTlz--
