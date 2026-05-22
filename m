Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06083A4F59
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428830; cv=fail; b=aAmdVrG5n+1TBJ1X2XweP0w/QVfkrrv+XbpKqHOQ2R1DeQAlpWBdFE3mO9hEL1dNgg6bQ20rYkjT5Pfozm+pixzXFurx3KYANqwdATX68fwoGjJfWEaoArl0sW47Sdmc3C/y/bx/R1l3q+5sOhwp7khadc/JCxtNMiKR5vKqhpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428830; c=relaxed/simple;
	bh=TdE9vzRwnH1XzKH6rLNmv45ASIBNiQUwEQ83iUnJ874=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahanemDR33WVNDpJ6D9euQ3SPFC9qLL06/sUBqDu7A1U0u9J/MeYP1BlBZLlo97Db10kwEA30NCSuvoo26kJOp8meGy3UztIwsSti4PA96ytnbAdGUapb3pEbQFBA7zLMOQpSvS34/7ObK+EVA+NzrbxOewJS9yI8re4DghceWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dM+ptnWp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dfoK8HJl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dM+ptnWp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dfoK8HJl"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M0k44G2442675;
	Fri, 22 May 2026 05:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=V02R/1Fvrf+iG+C0j5
	rHAXq5XGuWn50lZPTNBQkhja8=; b=dM+ptnWptQ7BRv9Yk9Ng2BAd6m32StxOeF
	FQaeNzaxA+SMIkRnO6Zb4LCY+XgAHQgtSa3nQcICoG2JxKV4RxEtdZzrrJvE6kW/
	ibhwlPgYHU5oipNmbBpafH4fNMBgs/nI+FkdkJ8d964uSygZt9yc8+GgXX8ckzhv
	oavJYyMNREn9fv0ZKLqOByI151EoahA0C/eocITljxuzu7kQUUvMOkwOhfx5je/U
	J/Z5JxX7CQoE+FphCWD0EI1ZfRS1e0PNgVh77tNJlP+Ya5Kf+lIWOyu+PbtRSq5e
	P5D2iQJTtmS8R4CPWtVN8Wn2BZM3UMtQhs8/sNS3j6eeuTflJukg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6gyxajvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 05:46:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64M5ioep036516;
	Fri, 22 May 2026 05:46:58 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1egrka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 05:46:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAKUsf9++4/MTguw1LSvCYqaIiKQHj7pSiGmMFqlaw9a866OsCqSxK4Xb8J4OD8vePczxXUJUrH/RCt0hynZio0EEiO83nPbcmWnZtNINlg/md+T5BKMC8dKpHXUneie9F7b31L+Kl+eO+m+p4UEwXJZdcar7KuFGtBv3i45RZ0/YejTMRJnTNjZmB43hrRSBhGKMLhVfueyX754uQ9gAyWTxcH8NPMmN22SiGewH+L3/0tm4i7bmWYfkUd9cd6ODroZJpPqSvf8IFt7yQKqec/Jh8ar3UwS2uX7kU2QybMGUYEojGD756u/+b7eAHCA+SuWd60YrguSBgVWOmFMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V02R/1Fvrf+iG+C0j5rHAXq5XGuWn50lZPTNBQkhja8=;
 b=RE4uJIQfnTbFqJXd58vABIb8wCWSKbFdC2sXd7Rge3jAUo5xVRYtwHaZR/m68RUJetqn4Dxd/yZOoihYxnOVgq0flASDRUvW3sFDbRgH/1d0CrHLN8TOTca0IbpRZtU3ZdtwRh2O/h+qlOMxX1iA7G7wIfc2mRbhFX+8XxZIzy+EW50HS2LMkM00o+eywUj3mcx7RQ4SGQGpqRfX6tsj1DFDc8fOLFrIcG2xx+4o4+LUzs6S/VqjQDRD3fDeglXPwV1dDm8vLfnsdo3+e+lrebJPvE15Wj7pXSVcqcS0iLCZc6sNdoX/R6N6eumnDMyhnLuBndpiuAMYoIUts0RoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V02R/1Fvrf+iG+C0j5rHAXq5XGuWn50lZPTNBQkhja8=;
 b=dfoK8HJlrdqp+K5zx2Amtk7x+pe4m8dGYCBPaPz05brLvrJyLF25hUnddT13C1DTG5dMM6yS8h7j6m1kX2r5PpDE+A54NgUQ+mtn40Gn38aMe9tACbsmFPY/VMR9sVVx+SM121wrig5jFdt05W+l2I5qFAWuNp2yEuGmA9kJg8Q=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB997600.namprd10.prod.outlook.com (2603:10b6:8:314::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Fri, 22 May 2026 05:46:55 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 05:46:55 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "j6t@kdbg.org" <j6t@kdbg.org>, "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com"
	<newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
        "oswald.buddenhagen@gmx.de"
	<oswald.buddenhagen@gmx.de>,
        "code@khaugsbakk.name" <code@khaugsbakk.name>
Subject: Re: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Topic: [PATCH 4/9] run-command: add support for timeout in command
 finisher
Thread-Index: AQHc6a5lF+gfHk/oVkaXinmihn0dsg==
Date: Fri, 22 May 2026 05:46:55 +0000
Message-ID: <cea0975e77d8167c0bceab8a45acf6882910a74b.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		<f58c8c522814dce9257f64733e9fbc9bd9f446c0.1779207350.git.siddh.raman.pant@oracle.com>
		<b69605a6-e841-47b9-a899-a57e184d3c8b@kdbg.org>
		<2f7eea03273ffaacc50a9ae186673da88fc3345f.camel@oracle.com>
		<cf52154c-1275-4a4b-957e-5aa17f22705c@kdbg.org>
	 <xmqqv7cgxq0o.fsf@gitster.g>
In-Reply-To: <xmqqv7cgxq0o.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DS0PR10MB997600:EE_
x-ms-office365-filtering-correlation-id: 90a92a5e-f040-42dc-c7b6-08deb7c58863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|6049299003|38070700021|4143699003|3023799007|56012099003|18002099003|22082099003|4053099003;
x-microsoft-antispam-message-info:
 5HuvMn5q+wMwm7Rb6qJEBQS96HOCt01+y7L8S2bf+uFplLYtid7VG9b3s0r2k9Am+1J9AW8JjsgHh3CCaWrjGWU5Y+h12t6fDaotvEyRsVN+se5lT7dDEMmthA7sq4XSnHvtlScJsXTydMSozBhGQ6Hqm1xq9JgmZ9vMKHvia4CyOizDRBHs5G61iWxSAUn0Xprm92HW133S+y/r8uM1fTG7jOfnUvnk6PN7kE7Yq0kOOXqnELIqArv+mZV44ebVqJnlZx07EYkeia426YF8Wcy/dEwTj6yDwGsJ5Sx66K0ix+ecuvo4zO5smxexqpWF+NAewcFzs7bejc00HqmD5zwHotjwOlN+VAlj+hNbEo1YJ2ZC8NE+oXO++lxUZL5nWGzKH1eAAwj3boLKQzcf82OIYIvlxQww24PFOzBMhGdfS2z5lwr/9QYxjnFmKxm1kZgKzW4gfmeQ25QWtkRCxODsGkyEj3kJ4SqZ3FMphSlTIWlDffLmfEL3b8oLoi0WPAXtd4FvhXhcmaaW3HBjhynxyNUNRNMnKVKMQDa6p2PcJooyhClTxtZJEolDfkAjMcJcaUQQCLsSpQFpESQUa+/DlpgAfgwj94HZqoNoSrb0bfuvmMeHJENG3TXR86zVoY7BnsdC+UYmtQXe/GdEbx4cjl5AoQqAQv821vzuoD5doPYUgAbgyQefr5juBDeYoiXfjVj56fmyDATO6QB1PiNvYi7bkBKhAdVk4bB1r4j1biAK3BT4MYKEGgbiwh1M
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(6049299003)(38070700021)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXc2ME54UnRTdGtnWk0ya1NvTmRiUmpRNHJQMmhqWDc3aWpqUysyT2Q1TEtq?=
 =?utf-8?B?SUF2cm12NlRhYTBleE81cGdxQnF6L0hUeEQ5SUFJUmswRkt2RDYzeXdaUmFT?=
 =?utf-8?B?aHc1ZHcyRlVsd0N6c1ByczF2QzkzUm1naG1XeSs0NGZLN1lmdEhmeGgzL2t3?=
 =?utf-8?B?TUE4L1ZibFJ0dnN6Q3hkR1hBU2xsL3kvSUlZZ2xRRGpEaWVqWGNPVDc4Vk1a?=
 =?utf-8?B?cDR0MUlVT2d2VUw4VXBoWHcyRUNjc3dJdVFYck0yZGFtdHd4Si9lamswWnRl?=
 =?utf-8?B?NU9uZHEreWwrMmVtTmRjU1hmZ1Fsem5pTlNSbkRTTzJVTUwxeDI2Y2U5MW9k?=
 =?utf-8?B?V1ovN2U4VnM0MG5iZXEwb1E1eitTYUJtU0FVZ2dYdTBUNjhleU9HWUtkaUpR?=
 =?utf-8?B?L3RQQVhFV2g1MXUrcmhsK0RDUlJsWnRjUlJpQU1jK0tteVgrTEtLcTc3RjlB?=
 =?utf-8?B?eUovQW16WGZTTmdwZHFGcWE3WlRjSFUzbGpmU2RMekJXcmV5amx3MWs5WXhs?=
 =?utf-8?B?ZzBSSklFeWdpUm1qYjBBNjJ3N2VCckNHMVlVWWhYQTFXb1hLNktJTWJnakww?=
 =?utf-8?B?ZHM2d093SWNFWDRpWmN3Nk83TjlwSFNSR01xK3FrUkdEM2ZHQzVsR1dDUWJn?=
 =?utf-8?B?SnVqaWkzQW90UFZKbWUyMllBTS9DL3dxNnkvRmNZdzRROEdHMDdwMXV1bmpZ?=
 =?utf-8?B?VGdnVlp0cDZYRFdwOTQ3eGRTdlYybTNGNnc1UDhmeTRaK1U0U1lQTWF5cEVi?=
 =?utf-8?B?dHNtZDFPRXEranB5a2tHK3lXRE5JUnQyZURzQTJ2eWRSVmtqU0F3SE1uMkNP?=
 =?utf-8?B?VTRFWjhjUHV6WXY2S3FybkNqQitaK2dCajhCYkoxSE42VEpVeHZ5VTg3TU14?=
 =?utf-8?B?cVEvT0pGamk4RzNwdERSNXFraUF4M1FBbEdDU0hFQzBCdldHZHVGWVlZanFX?=
 =?utf-8?B?T09XRWMyUENOOHlNV2I4NlllNk13U1pHTGxOa3dEK0RaZkMwdHFaTHdrcHl6?=
 =?utf-8?B?Nnc4QlRNSFZ3c21xVndTRGJxRGRyaWNMa2FoS3g0dGVkUVBCamFvUlJLdC9a?=
 =?utf-8?B?WS80QnQ2WldQZ3F2RzVManlCem1Db2hjcCtLRjJjY3RKK1Uxb2FMeEZiNlhV?=
 =?utf-8?B?WHJweDZJdnhwZ1FLd0dIREpmWUN3MndJdDZ1cFVFYTlhZVZUdzRpVEpKM2hp?=
 =?utf-8?B?eTBRaTQ4eWNXTXRRMUlubjY0YmpESGNZbDVzeDUvczhacTFSUnBUVlB1NzJZ?=
 =?utf-8?B?TFF3aVU3SXJaQ0Q1bFhKRkM0eFYvMmhuTmVGb3dhc0pOek5RTDdLaTZBYVMx?=
 =?utf-8?B?UWFJUWlnSmZ1ZFBDYUhRYW5qRDBOSkhzZ3Q0enVBVjBnZ1NNQXJYdFdheStK?=
 =?utf-8?B?VSsyZUt2NUNiQlRkUnRrYW94SVAxNDBtRjR3T3dxcVczUFN5WFhrVm9QaFJX?=
 =?utf-8?B?M0NKN1U5Q0wxQldxUU5PcWNBTEowaWh4b0E3ZXJjL0piT0xxUVc2MzErdzJt?=
 =?utf-8?B?U2NwSDcwM2hKRE5XWkVNd0tXa283VCtiTjlPdU5pTDZkNDlWK0FLT05ZeEps?=
 =?utf-8?B?QUdjaHhHODEvL3RkQ0xPVEszMGJaQWRPTXpjeldzQWVNSGIxb0JDLzN2NkZ3?=
 =?utf-8?B?OXgrUXV1a1RzMHovZmRXd0ZCOElxaHZ0T2ovSEVsdklUdWVZOVRGNm5BM0Zw?=
 =?utf-8?B?ZUhFWDhGVmF5Zk4rdmwvcWF0Tk9GcG0xeFdrZGRzMFRQdVFnRjNHTEduQi9G?=
 =?utf-8?B?d2p2UUJxV2tvT0tadnNtTTN3eUdVTU1EbEVCWkgwRVQ2RkhrRVlRVFJsY1Vy?=
 =?utf-8?B?YjM2RGVtc2F5ck5XMWlpUzBuRTJBYjd6R25odktHdVhpMEY0cU1FQ2xuZWdC?=
 =?utf-8?B?cDJxcStyeW1DMnpnQ242clhaL2xqdU5FNE15S3psY2xadFN5YkJSQU9va1Zo?=
 =?utf-8?B?WDZ4endWdXNGM3FEOFF4N3NZV2hJY3pWclBoWnFvSUs3NHpVUFI5a3dvOE43?=
 =?utf-8?B?OGxTZHVrOEhHMnQ0TEd4WVY5YTZoRHRpWE9veUQ1M0FlTStPN0pIYXdDSjFI?=
 =?utf-8?B?U3I5djFDaWw3T01kcE5IQ1pxY1cvZEl0Nyt4K2l0TzFYMUpsQ1ZHRHowTGNP?=
 =?utf-8?B?RjNPd3k4NEtXY2pYb3dMb3FPdnhRaFVETzVXcFRjMExDckFkK3VJMGFndVgv?=
 =?utf-8?B?UGdhVnhtN1dQTkYzZkhpM2xNOVNGYVptTTNybmlXSWIzU085ZHlSZkp6aUhq?=
 =?utf-8?B?OXBYbS9aNnNwemFTRlhFakF1cXRYaUNPL3MybjVjUCtNeVpUSmFhbkM1bDdm?=
 =?utf-8?B?SmgzTG5nMDFOZzFYcXFGOFNQN0J5dDhzUVVKZGxKNlErYXVkd0oxeENuWFp6?=
 =?utf-8?Q?krdOOeL3PqpR8WpyYFS17MhUzgghPSqpenY+S5DJLMzJE?=
x-ms-exchange-antispam-messagedata-1: 4mWS54KI4l0SJsaFAEB8X7I96hAuRjL7384=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-rZx43JCT5DBZTM4ltymO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hmm3KspPJPwHvWAYGAL/Ol9PIZmiTYcBFgB2xAGcGt+xMEp+d/AvB3MnDGSIcjYXamSEEZoat0rtVWQgeZtpwfW8Bb38YIll5GORpKoN42GTZMxatrtnbSgH95dYQdTIDH/CU6ZlW2a0kbsT1sfGjklWn/0TQInbgXUcMxuVL275zKCDIeiMXwjeqjmitD9vV2uMYSq+jq3RUWSgBlcLNopd3+lFSV66prlfdq16VuReOBjrANiZtZPfH9K4kwK68Y0XLSnRUCGHQfXxx+O0CleAByGQ5IB3rlqRrDE3lVvXHi/nKR2f3tv0Pja/K51iDJq2CQu8WxZx2Fhuh6Sy+g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EIkUXUtyFsHkp0wu3tjaLCHB1utBGfqe8cF+Zs0GnYO2RPksiBnSqsvqTSidyTgnEv3FKo4BLAbPPlMUr7lKlVm5odsE9ZvGQO7qsaoiOPMBEQSFRY6pew+HBBsB5Nlg47GoCxuyKskyBzD/OIXarfza+r+Ab1euGjKNHJxrY518cD11ZSFPXKmQMr5XLDRIuDdO19sYbL02be1A9YJ0SJecdB2LCgxkB4t31MUUo4Xvfzizz8GIAuLWMDDXJzOgwa9PGnLFj/XpQ9jiO38bNRz6vnpJ+3eNhAvrlPOuVmt2VlQIFBsDfBBv4nymA3FtnDxI3kiCF7G6TR+g/v2fGBJMWKWsu7hWiD6oFlDK/uR47iE8vOFoc5rknTSCQs5gn2+2kuLDM0b1Ev32Q2nnFLpVxldI1wkwXmQSwYVSyYTLAbQ83cKs5KepYa8iY1609e6P+QKpMD7/UkggBfzCUcYSp0LgxrEJ/khQZ2jGBQW9MZvthJu3fhjYOLbcws5y8+vRX1xR4B32XHeV80XJrjq6btUqK/8FSTCQsZDbvAVARGqgDekl82QVjfUh4vGsmlY9JbfTxh5ASyMZy9mOGXNTT2JJI0php3CEuyB67KE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a92a5e-f040-42dc-c7b6-08deb7c58863
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 05:46:55.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KppzMZ2wR+JuRWeGhC9TltfANIsDqOH/zaWwaHBRhgPp1r9sH/epsOd++NHId6EPogxF9KGcuTj9OQ6AkEuBF1M3+yvqH4fELyO4sJsH6xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605220055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1NSBTYWx0ZWRfX2+GhsdqsKqlU
 JgHu52uZrKz6zNey9vQxKxuXAD83pG907+/REzOnwm3qnVlyDFO4/kSUbpIXKi+AVGec+LWdTQv
 IQhzLStEeDdV1ZvlWNvPMGxNsSxaiPPTHwAPntfoMXqWfav4d8Ihzo9QkDZioBjOguj7EL23nBr
 tGZrU+Lt1ecFZAjZvTrOA9r9Awg0m4ERZGiZ256iknw/3uwbo9M+93QDG4gtAv+Wp251KKF3CL6
 z639GYwxGjBzJS1g1fG1gQ5zRsV1kTsC6XHDVOApKXF5bB6GHLcHM/4cD2BBFZge6chYZKm2grr
 yq8aJ6v7FkBoczRUXJ0zw8FRDW+Jdnd62y8BRPTOnFbt6zzCeNfHaKIpyH6UyaVpGMKUijQbrbo
 NGdb0N3rVyFG++xreE6EcNTBblESixHygrRWAUhHpzzbmjCEhGViNAppL8p9Q6J0Eg6GF0F8Ezj
 i7+c4lnGrUp8dVKaR7g==
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a0fedd3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=N2FjME50r00upK4ZXRQA:9 a=QEXdDO2ut3YA:10 a=qEtdi1aOGEHhisPQskcA:9
 a=FfaGCDsud1wA:10
X-Proofpoint-ORIG-GUID: FkpyntjFo6MCwfpkH25s53s6JsY9rrHH
X-Proofpoint-GUID: FkpyntjFo6MCwfpkH25s53s6JsY9rrHH

--=-rZx43JCT5DBZTM4ltymO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22 2026 at 05:40:47 +0530, Junio C Hamano wrote:
> If a protocol builds its own way to declare "this backend is slow,
> so please do not consider less than 3 seconds of nonaction something
> to worry about but kill it off if you waited more than that" to make
> the receiving/waiting end responsible for managing timeout, that
> might be workable, but it certainly feels like a kludge.  The
> protocol can instead allow an "error - for your particular request,
> we couldn't come up with an answer within a reasonable time limit"
> response (in practice, "within time limit" does not have to be the
> only reason for such an error) to be returned, I think.

I think we are confusing two different commits here.

The response read deadline is the next commit. This commit is about
force-killing a process if it doesn't respond to the initial
termination signal.

Thanks,
Siddh

--=-rZx43JCT5DBZTM4ltymO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoP7b0ACgkQBwq/MEwk
8ipyAw//btpliABOZ6jHifFhp/MmYXgBDWlJwNXQMCk+4gbnqo1nheSM9HrlN9KF
SRC8+G1z4Y/NE419I5sKfHdpVVAX1Lcy8tpvUW5pfI5Ve4OLfFnb3YbYGxq3X3X8
TT140siUFaWmpBYFiHqBMVhPo0aIyLzdmc8QHijMu3cFUQwg9M0f5PwoMTwHybhi
bVij+DgBCL2l9wyzBDahIikr4YaTpOy6b1VsRRGaiInQvTwxX7DyQzq3UHhQo4JP
Rv0I+3r+0mvOsr0+2E9ZhMshMiaezJR34ocH1nZ6xl/jroXUj5Ahxrs/n3JvuOHq
Ue08LByCpiW9wNOCUitxG+cAc81E9FWgXLOs/cynPmmOAuMAJwwSm3mwConKoZ8Q
D3nM/DS74sGPbmBQfzY4/Y8yZH+4FNle0BxZoHsMMJ+3Rw2ofDYu9sFjGyOUSktH
WVlK3UG9Ekgk9Wyf8LlVCM6DXQeVT9yTRG3vKbBCzclWRlHKGI4J/G8Tr2eVlcwV
3JsbkKZtyuveeHDkKmrZ7JcliGYzmawMaF4StAOtGt3J4T+/3/VW8pNUTPlEGXw8
vrRTeP9zDoy7F8Lsfv55HZJCaeueU/VK+2hIrSvtRVFJImJEC8nxsAmT8b93O058
6lCofbd+FkmzpB0eIpc7Ct1StErfiO+dJFTV5jS9nmtGPVqlkYk=
=YRYZ
-----END PGP SIGNATURE-----

--=-rZx43JCT5DBZTM4ltymO--
