Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2044.outbound.protection.outlook.com [40.92.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8D156230
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807625; cv=fail; b=T2kC1QLkhsMJbQ1hTrp8lDYMaISY85TQQRiBUTtDiOgoLvqaFeblmp4KYeBguqQn3fNmIcC2b0/YOxtpzWvcYxqffd1Syix0BJbRhZL7/qef0h9zevfqNvfHGQkyZsqTrv9J/o0x7/vYyqfCSl5jopN3dVTdrgTW6vYNwy5jpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807625; c=relaxed/simple;
	bh=iSUUbVZ5L6iYv9wLsjHQ9uRz7VWp1uixAw07EeBekS4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I6FYNEn27vnC2ZuB2/DixryOyM/56Dqmro55MCvzk8ds4UJ8mhOgvldh26qqg7SgfAQ94pWzJ3rrdytjpsMSzp+sjSp8pAd4mkghbw/L8jwqyMkHH4j/bSPS2KonK28E7JtNOPcfQBeBzrphY7py/oM4f/zlGgk2WQrjVsUUZYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.jp; spf=pass smtp.mailfrom=outlook.jp; dkim=pass (2048-bit key) header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.b=G/zFDmdx; arc=fail smtp.client-ip=40.92.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.b="G/zFDmdx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDgULPfBrkzE/Fi25YE0Tfjy6p3RI0ELX/hlYgt7v39lW2oBLdSiGj18LR2hcucstyKnNsHCZ/kdpFbQJlHWv+jNwW1JjH5TLuoY5D0bEvSvYA6P040ZDcVj40ImFxbqYfaEDP1vgchwRofMKZrm2y/9j2Y3zvWy0MiWVCEWbmz7YZGCNm/sTThMsXzbL7kIF37QS34G517T6caWpkot6R4Ngyu8qYUdKmY2lenz3O33f/8Wn5Tyif+osYGthbANF5OIlRvvMW1r/EtlD97/1MnSEnB/KJHcoZX4YciPwUXTGwlXdGukvaFnqcnJK+fU1XRGo/Bt4rBu3IMQtj/M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSUUbVZ5L6iYv9wLsjHQ9uRz7VWp1uixAw07EeBekS4=;
 b=Oph69dhwkiesfr73XXHxVKYFHbU7j/afuZt9xBJVxgb1Xjs68DnmXM1vvkhYYgqOJgVhr+VWWL1vtLpIwQOn0pwOeBFSIMnSOJGik8JqaRGQX1wgiRnfHKM9TX4dY2bDOkPG4bds7gZkzxjAc+b9cl18e6t1y+mkydK+wo5ZXBoSCa1yWurfLtOenRiBk2HVZmwGWLCmYeMkmuiIvD0S3UShW8eaF5q1NfFKBnsW97a0DDvfOLqrNKQxRyMQnQjjDCXAGWE5muuuN+oFz6FeubzF82aBjGRu7mccl+hw7SUPQyM5pMUbmkuCE+quX1beKlNCptuvgxPrC1dMSxKFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSUUbVZ5L6iYv9wLsjHQ9uRz7VWp1uixAw07EeBekS4=;
 b=G/zFDmdxkgPje/G7P46XanFRYTZ7xHODDyfyZyW6TyPTPBDiKE6n9Tu5IMUE8Eap2HEysbqb3P5Y3zI4wKByeQcayT0jajBliR9n15veBQG5LWde4UkXsnv4q2wHXMvb/DPQwOzEBks1tkT5KO7gQXIBteAbm2Qo5ovsyEQg+ygDVgbSlK9UtEk65xt1odh/MOAtdbIxF0yr0lPUH4xyjJexvp24R3k0J9kQ7AePxFLluqsfonqjhCnOI3vZrgbi5ES9YRuJFhzoznFH8cX6xeLrrev4qNJXX4MefeGn+4wbuL68r8g32jsXI5u3gn3AKjzqpvwQfv4jq0OF9k0khg==
Received: from TYZPR01MB6508.apcprd01.prod.exchangelabs.com
 (2603:1096:405:b0::6) by TYZPR01MB5056.apcprd01.prod.exchangelabs.com
 (2603:1096:400:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 12:47:00 +0000
Received: from TYZPR01MB6508.apcprd01.prod.exchangelabs.com
 ([fe80::d7f4:4468:be96:7444]) by TYZPR01MB6508.apcprd01.prod.exchangelabs.com
 ([fe80::d7f4:4468:be96:7444%4]) with mapi id 15.20.8606.029; Wed, 16 Apr 2025
 12:46:59 +0000
From: =?iso-2022-jp?B?GyRCJTIhPCVfJXMlMBsoQiAbJEIlRyU5JS8lSCVDJVcbKEI=?=
	<iphone16promax@outlook.jp>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject:
Thread-Index: AQHbrs2edzt6r3sYtEaA7P4knhL5yQ==
Date: Wed, 16 Apr 2025 12:46:59 +0000
Message-ID:
 <TYZPR01MB65085B5965B497F4D19D55D2ACBD2@TYZPR01MB6508.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, ko-KR, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB6508:EE_|TYZPR01MB5056:EE_
x-ms-office365-filtering-correlation-id: 4b156192-6efe-4f26-c133-08dd7ce4c771
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15030799003|37102599003|15080799006|10035399004|3412199025|4302099013|440099028|3430499032|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?WVhVZ0kzR0xBdmxVKzF2SVp1bXM3b2hBMytVN1Q0N2ZWV3RySXhINTdj?=
 =?iso-2022-jp?B?L01EMFduNVJkNDRid2dnNm5QcFI0R3N4ZWxCejV2cTh0WFEweXYzbDN0?=
 =?iso-2022-jp?B?SE91QngxWm80MTB5ODFBQkVRMGNqaG15S0FNOWd3TzNWSkxjRW13d1lu?=
 =?iso-2022-jp?B?dmhTL0hSc1ROR2RKblVLRnVOcTRMNlZoTmhyblBvdFNRZkJrb3Iwa2dK?=
 =?iso-2022-jp?B?K3Bwb0dUUWRiYlpWUXFEM0NTKzNpOGk1Z1FpZHoyMW8xUnF6WlFUenhi?=
 =?iso-2022-jp?B?RzduSTdPT2xtT2twOVFkMURBVDNva2duU0dha0Q3bFo5VUNyZmdKM2Vt?=
 =?iso-2022-jp?B?bUFzTldQcUhncmhSK1ZxQ1Nlais1RUNGOTZqWGxxOHNBeTJTUDN3cU1w?=
 =?iso-2022-jp?B?b2czS0laMzJjenFsVXhaajRIMEhBZ0dQSStrdDlsd3IreU1zSmFINHpz?=
 =?iso-2022-jp?B?WW1zcmtpNis2aWZZTDB3MUY1ZUxWTFgvazVSYUc5M0QwTEtYcGdqUTdl?=
 =?iso-2022-jp?B?NzZLbGk1cUdsZmkvZjJ5T2owOXhtZ053c1Z2VklEb0R5RXhOdjVRYThv?=
 =?iso-2022-jp?B?eVcrME5vTlhwY1Z1TlhLa2doM2JNOXMwaEJITFowNVNycTFEbHF2TlR6?=
 =?iso-2022-jp?B?UURIMXFRVmlDcjIvcUpaZnFabUhLM1Awd2RUOHRaUXRyMmJoUmZ4d2tx?=
 =?iso-2022-jp?B?T285ckxZTXZ5WUEzMFpqSi9CNDZTSWlTcDgxMkJZK3EwWUs1emNUdWlu?=
 =?iso-2022-jp?B?WDZNUU5WWGNQWHpnVlRvblMvQ0JlaVR6VjZ2RjdoTnN1SjBEWG5XalJz?=
 =?iso-2022-jp?B?YWQ4OGt5cnlNbWNGZFJrOE1ZbHN2RHF5Ri9BejNNN0p6Mm16TEZnVGhR?=
 =?iso-2022-jp?B?eFpJWXYxMGl0WG02c1B5MjY5anhETjJJdWtEZU1ZN1R5aHhCVkJDUXZh?=
 =?iso-2022-jp?B?WjN0cnZuRlVvZ2ZsL2NQajhxQTMydkhRT3ZwMmlKSVBNZWcvak9pVTdH?=
 =?iso-2022-jp?B?RDNacnZ0NitWNDNhMHN1dGpEREFCTC91NmoyZWsvUkRCY2o3YjZiQnpt?=
 =?iso-2022-jp?B?eUo2ZTc0VnBxK2JobndDdXlkN05BYjZHSnBzYThQR3pZdkp5TlNaU0gw?=
 =?iso-2022-jp?B?MHZDUVNXZmxXVTF2Ujk3UHYyd21FOFdvdkM5a2VseTA1V2J2ZnFobEY3?=
 =?iso-2022-jp?B?MjdQaHFTaE93MDlTekdFV0s5cGpxQ1pSVDkvcG1CWFQzK2hEZno4d3pu?=
 =?iso-2022-jp?B?TWx0UkFENE9FcW9aU2NYNEY4VTBHZGVucTYrU3NHdVhpbHEyQmdoS2ls?=
 =?iso-2022-jp?B?MkVQTHgxaE5reHV6eEtJbEUxU3hoYVFISTc5MEI5UU85Vm1CRk9TOXhL?=
 =?iso-2022-jp?B?K285UDMrcHVKWDh6ZkpDK3JMTmFsbmJDeHRIY0J2a2Y1YU9xZzNRVFFr?=
 =?iso-2022-jp?B?ZFh2YjhIOVlRM25OSWJ5VWhtMHpzZXZNb1NvSGxCQWxnYitYdmsvTHoz?=
 =?iso-2022-jp?B?aGhjQTFpVkFBNXA3Y2ltVG9YT1R5WUJuc3FESWo3WUtkMjU2bUJvaTB0?=
 =?iso-2022-jp?B?UmJEb0F2WVMyVDRFa3ZHZDJCUVlzNU0zWDdIRWtwOTZLNSt3ODRMOXgw?=
 =?iso-2022-jp?B?ZUZzZlhtT3RCSDRCa2N3SkFKZGthOFlNVWVhdTNxZGRlM0Z5MnVxL0FF?=
 =?iso-2022-jp?B?aVdna2tqRGt1UlRCTEpVQkJxZFhqZWM5NWlFWlozcFMzQnVPMllqOU9x?=
 =?iso-2022-jp?B?eEJra0RJWS9BRXBFRDliLzlQd2hSOVpHL2NmNm40S09JRHJEY0c5azY3?=
 =?iso-2022-jp?B?bTk2T1dkVnBMZXVJUm1rS1BSMUg=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Z1I3d0E1elZLOFVaYWVzUFFhN3paRmVuaUFOcnYzdmNFeWNEYWEvSCti?=
 =?iso-2022-jp?B?M0ZhVnZRcWVFa2ZIMTE0MDhoNVF0OHdqZTZwQW1uOVUyOTExYW5UWUQx?=
 =?iso-2022-jp?B?a2dXNU5DZDZuUHlGTXVFYXJPNVFtSzA1SzJLQjNHbDFyWnI3ODVvQVpy?=
 =?iso-2022-jp?B?ZWVRYUpreVZzdmg3RXJzSE4rUlF0bFI5b283NHFLZm03TjdpTlIrbTNx?=
 =?iso-2022-jp?B?MFM0RTc2TGpGOGNuWStSRllheWJLNUgzRHYvcTNMQkNWN0ZVZ1paOUFu?=
 =?iso-2022-jp?B?dWZVeG9zYXc0ZmtqaE9RRk82WXp3NnJ5NEdzTFJYckwvNnpkMUt3b21T?=
 =?iso-2022-jp?B?dHhIU3g2WjJocVRmNnlFY1ZRWm81bEVSek96T3dXS0V3Z2dLS0Y4UjNo?=
 =?iso-2022-jp?B?bkFwNFhuNkRRdTNjTzAva0NOMEdlbGk0SXZTSFZiV2ZUUmNRUEVYamNk?=
 =?iso-2022-jp?B?dWtnR0UybW03UmVQVldhb3JTbDBsTzJYZy80M1NDcklHVnVHWnpuSjc1?=
 =?iso-2022-jp?B?S3VxZ2paREpoc1BoMnd6d3I0SE02cVZDTVgvT3NKTHV4dDd2SEQ4cnFP?=
 =?iso-2022-jp?B?ajY0cmRFWDFuclNiQUZmWC9SblI0VnNma2RQQXdKRGlzM1VCOG5uUGx1?=
 =?iso-2022-jp?B?WWZGYUYrZHJrc3dVeDNnTkRKYThheDF3NkRNRm8zcmpHNzJJcmM5enk1?=
 =?iso-2022-jp?B?WElET2dzazJKeksrU1I2b3BEYjliMUZUM2xnRjVEcEhlY3hNQ3M0ZmNh?=
 =?iso-2022-jp?B?MzZNUG1VY3dJQk1jdmR1ZVVaZUpuVU45aUM1UEs2YlNPVGtkUVZuM0dv?=
 =?iso-2022-jp?B?anRyY2djc2Vub3doQzZqN2ZkMFh3dnMrR3F4TkxqWTdqMmRXY05nTE9t?=
 =?iso-2022-jp?B?K3RGZ2VBRndybW9EZW9Tbzh2YjZoQzZaWkRwaEk4RHR5TnJzN09ab3Rw?=
 =?iso-2022-jp?B?ZHloUjhLTm5vLzFnZ2E4OFpiVjNrb1VNaytNdjQzVi9wMTRobGg0NUFF?=
 =?iso-2022-jp?B?dkJUTXgxNWV5T2k2YWQ1dDNtbEVsRkdXMk1jeEU5MVJSN0FSQVdBT093?=
 =?iso-2022-jp?B?dGVuK1FHRnZxZWdVc1B5Q3hrVmt2NG1MdURoTUZOVHhuZ3ZWNjdHSFRz?=
 =?iso-2022-jp?B?a2t5YVJuYnluZXh0YVFXR1pZRlBEZkpyYUVHbVNFWFJ3MlpxZVk4OCsw?=
 =?iso-2022-jp?B?TUZDQXRGZGN2RW1uQ1RpUDk2d3YwaE1TU3d1VE1hdHMwM2RLOW5pa0lv?=
 =?iso-2022-jp?B?T3pXcVdURE1VQ1FTRkVNTllsVzBtZU4xZ2NvZUhhNVlRc0s2OTZqekg5?=
 =?iso-2022-jp?B?OU0xd0t5YlVmZU16bHB0c1IrN2c4clA3ZzJNY0VCaVJzNElkSFhlZUsw?=
 =?iso-2022-jp?B?Mmwra0hFOVJuUnduRFdBM0NWMkNLVmZyZFM5Y1dzM3FXM0YraGZRc2NZ?=
 =?iso-2022-jp?B?NHV5OGlNZ0tGMkhvc0FxeDloOW9oa0wxRHA4aHNNTUlxYWc2SldqeStI?=
 =?iso-2022-jp?B?elFIeitMdXRTNnh0aGs0d1VOUTVPbkc1QWlLWGcyT0NadGIxck9NUkJp?=
 =?iso-2022-jp?B?QVFtL1h0MHFIYmZmc1dOam1aZHJEa2U4STFhcXZXMXlsTjlwMkpYWUN4?=
 =?iso-2022-jp?B?TWVYM1pQWENmMkZDbUJwa2ZFZllZNklzUEh0d1lVMVYvbENjYk56cmhs?=
 =?iso-2022-jp?B?b1pVS2pDUHE2VFBMZmgvYjV3TkNHcnRTMHQweXBxUFg0eFFuM1pnVUFj?=
 =?iso-2022-jp?B?SUJVd21xOXcyaGgycUZURE52VnFXYkdwS3JSa2NEdXZ1MUkxVmdPaW5E?=
 =?iso-2022-jp?B?OU0xWjdZS04wYnd1YWpFS3cvenBMbFg3bXNNWU90OUZtUXlKaGJ4MVRm?=
 =?iso-2022-jp?B?Z1phdytCM2VkTFhKRWtJUndQNm5VPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-b4c57.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB6508.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b156192-6efe-4f26-c133-08dd7ce4c771
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 12:46:59.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5056

Microsoft To Do =1B$B$N6&M-%j%9%H=1B(B "=1B$BL5Bj$N%j%9%H=1B(B (2)" =1B$B$K=
;22C$7$F$/$@$5$$!#=1B(B=0A=
https://to-do.microsoft.com/sharing?InvitationToken=3D1oI_7iP9huTb6DL2JT_z5=
gm8yi4UAYPtNvCYHZrVheMgLbtUkFuxo8UDq4DnBxkKo=0A=
