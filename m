Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771346BC
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuix.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nuix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="be8MGJK5";
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="be8MGJK5"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=J+9MUekxOtLEvDVWFiqaJHzHyfBMd7hvBY3Tqnp7KmEvxFtTPOAUDgEyW/Tqk0RYuJKgpPYor0215jpwZMP1LONNs8qqbNR1N2+HpoPdRje5n4yb2bWi0COcEsOqp3rbTabchsC5XTEFXAUjSkEDVIFEhjke+8cbheCP+RKDrjGqs3c7Cd2qWQXBcAp+XBoRtsSSGDCddMFobTD0q15DOQRc+T8QfhiuDZXSx0cHNNCjmoWZ9CtWgc8/ehpICViBCA99JmPsUJJ050okb/o4TkVd1zRHiFFSA0Txq6Vnc6y01QJa5gfuWalcGsq+k+u0p3zUBklVE9ucNyw9FjSKzg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=255p43/k12Y/qgp4GE7EQdOtUS0aWjPB/Luz7uuMIys=;
 b=L17KXGVQfpbv/HXPchjRVEq8YgR/miz/GiT66EmygsN2dUEvDnTh7L/LT7UQ6U/NeCwgXYO0ZByNSIW1kbKQKD2G2KaLzpU+RjEeicBXiTZW1kxGtBNEz7b1uifVRIXWIVgW2jHJM7iBXZpsjRld/TYHigjmQwkV2PZATVN0ZuXYOH/NUim+C0QBqVcQOm7Od3RKmIRdMLPMY7xwGPFsaaqCC+L7ZHHkaXVDeMyXit9T796RDDClPWxht0HbEYQ83Q1lAp3Y7iGt4sfMYUqr8AY1PZ/HTFfcagvxMv480lRS4zv5Ey859inwwn3oCoquQx+W4QjsEPzCjIawKPcybQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.98.2.159) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=nuix.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuix.com; dkim=pass (signature was verified) header.d=nuix.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=nuix.com]
 dkim=[1,1,header.d=nuix.com] dmarc=[1,1,header.from=nuix.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=255p43/k12Y/qgp4GE7EQdOtUS0aWjPB/Luz7uuMIys=;
 b=be8MGJK5mPJgkc9Qe0mkfoKrcIdJ+G2vmAbk3zhsBx86Z52pbkylY3NoW5aaqCDt6oYZyhypnkJ6p3QzhAzdmYnEo/ILwKd+ov8a+pR0KWxfRSEykGrrtY0JsEiFWnKhLF9hD7hdl77ivK1DULzqnWc3wJMaferJ/JB3B2ib8rk=
Received: from SJ0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:2c2::6)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 22:36:35 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::f6) by SJ0PR13CA0031.outlook.office365.com
 (2603:10b6:a03:2c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14 via Frontend
 Transport; Fri, 12 Jan 2024 22:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.98.2.159)
 smtp.mailfrom=nuix.com; dkim=pass (signature was verified)
 header.d=Nuix.com;dmarc=pass action=none header.from=nuix.com;
Received-SPF: Pass (protection.outlook.com: domain of nuix.com designates
 20.98.2.159 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.98.2.159; helo=us1-emailsignatures-cloud.codetwo.com; pr=C
Received: from us1-emailsignatures-cloud.codetwo.com (20.98.2.159) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 22:36:34 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by us1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 12 Jan 2024 22:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/ZCJhyofkwbVapDaF9azHUwUPBNV72jqMRAjMdkHSLwCVhIRivQjYiySxJWO0WzZYzJg3rsXC2ydrVbeLhep7OmL0dp1t55rrxY5eV7BsDJX+sDbuGqT58ALyil9//r2PqV7PXgLF2eljPIhnNLbPk5/pB8dOuzQbBHWpkvVx5Qr9mzyhoUCSFna+e5y/pFMEDSPLSIrpy4C3f3wn2BHzJCYZMNp2m//HVMsU/ovj80ly6aO9jzg0tZi+wceKcNq1QBolSWSEIhEYbp8kbmMbsZkq3XFPiMktacXlbKtNLLYhy5/kEIu+g5ywPnbY4JtCvSw13zJXkH0ZvCpDS4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=255p43/k12Y/qgp4GE7EQdOtUS0aWjPB/Luz7uuMIys=;
 b=KH6pSVqhygDaWZ0c+np/TSMkRkncBhJ7zU0yPxAgK2J2Y4uT4seeM1ANXDZXjXa18F3OZ7SgebB09EOqLWnk+WzF4S6uFNIEydNyx686Bewe0gDA0+HWiErl2R1I64SAPol+mXnynM8bCZ3Y68Er+osQLnLBbfXeXCo8MBfmO0w1C15NHu0DGMeWPUnjj6rk7uvLUk7WYl+m304wzaZuWGAdk6+LUW8GnzfGx+aX+FXjKS6cVQOmJLamQR24tLUJHM8bWgnXDiQTT6i5+vyH9Hr5GMEKzDXlYfCBQLT6rG/mvFA84zpfef7cOJtrIrbWDvYM302mjBIusfoPTCBkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuix.com; dmarc=pass action=none header.from=nuix.com;
 dkim=pass header.d=nuix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=255p43/k12Y/qgp4GE7EQdOtUS0aWjPB/Luz7uuMIys=;
 b=be8MGJK5mPJgkc9Qe0mkfoKrcIdJ+G2vmAbk3zhsBx86Z52pbkylY3NoW5aaqCDt6oYZyhypnkJ6p3QzhAzdmYnEo/ILwKd+ov8a+pR0KWxfRSEykGrrtY0JsEiFWnKhLF9hD7hdl77ivK1DULzqnWc3wJMaferJ/JB3B2ib8rk=
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 12 Jan
 2024 22:36:27 +0000
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6]) by SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 22:36:26 +0000
From: Michael Litwak <michael.litwak@nuix.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Thread-Topic: Suggested clarification for .gitattributes reference
 documentation
Thread-Index: AQHaRafHGVsr0eDalEqCluuSk5bwIA==
Date: Fri, 12 Jan 2024 22:36:26 +0000
Message-ID: <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
In-Reply-To: <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuix.com;
x-ms-traffictypediagnostic:
	SJ0PR10MB5693:EE_|PH0PR10MB4533:EE_|SJ1PEPF00001CE2:EE_|BN0PR10MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: 13986fa4-9221-445c-cd67-08dc13beee73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 vc9+kw/s8/4gFpLZPfJC73VMUmpjnzBMfuWhFOXh1Ln31Uqny58bJZoiG6l1Et7+ZQtjVHbxdkXUJvUVSIIgVDfeg8hF7fYVtnHjbVtPTXCjHZ73pFPfH6v5cUTqK5Kdhcy5y8ibQgKeT3GKQtIdm9LeAHwqOGjvl55MTdlveC0RtliooeDNeYCJg2awctJ8VV/LHFohAkKeOhl63RmPPEufYgHbt0pcnxRr+ZhKNUVulGBHiJmHBu4H4ooIpBW2+5pX1Q0VQ3uG25zKFbdNFrLgeMTCNpoFnd8tQ2hIKKWxise2aKqd/xA6qjfu73uylGgS2EC3Z5uHa3SUV2vb/joODh2cTPuHLLCb9NqUn2zajy+3gT3r5XdD8//edxn9bpfftVL4ThHlDpVFno0XeAYGskSEXxbzqbZkdodHPE+slHwg+q3DN2434Xdn0se5pqr9X8GcrYrOA2uqhDD5puZncNNoEgP8jSimBQzuapDE/KHB5ktfoaRYufY2pEAHL0LJ5Kr/1lxpDLUx5zXIhIZyZ1SPX0KVd4mqsefAlLyRvpBewg6QHCK58lXYDWyO92dmlz9mIUIhCdNlU/osUaESYbukbpz6txpNxa3RT03Ebl3T1Sw67rP0/AryM2XpgHyR8mGyiOG62D/aYMHbprla2UUarErOXdd5CTvIwFUR6pTeD+orW2dv6XHKO1JldSTivfwReMxA2wpqdDucGQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5693.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6916009)(316002)(38070700009)(76116006)(71200400001)(8936002)(44832011)(86362001)(9686003)(8676002)(52536014)(64756008)(66476007)(66556008)(66946007)(4326008)(66446008)(66899024)(5660300002)(2906002)(55016003)(6506007)(7696005)(53546011)(26005)(478600001)(83380400001)(122000001)(38100700002)(41300700001)(33656002)(142923001)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-CodeTwo-MessageID: 14f9be4a-891e-4620-b121-c5c8b49d7c21.20240112223633@us1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1721248-4c29-44cb-6ffd-08dc13bee9c3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fgefnWp0/tPosX3kfFcmzJaeBrRrbT4/Qk9aWN3iTW5CCBgQGdLOT2sRDspVX+F+54vvjOm9jJ3FQ0N4tNXHOtlylmOW5ptk/tNVtqjHvz1D1l+24EYLHMvVNRUR+0IiL5hXTR+gRVLMTBlKrGMfDEsH9PAIWFYg5SEniGP01KUurDM902FR75XSDjsKpR6FgbkFI7ZYZzlHs3B7j2ifNGMwoEazGHeObgGinn4lArWVlvjoKlkg73vUN8IIbPAfD272pEGr8i6yOUVlVYZLGzkXYvOrjfzNH3HvDgtgmv+FTC6RJBKXfOd04E90/w7jyaA6SuEOtwPBO1BI6H7C6DFo0xTDXTZbRLauEQvaWONBGTbJrld1I5EcxwBvc+Onynmg7MQv5R+tL9+i+PxGRwfrwRRGDeCldQ6NzLkioD4SCkz5Z1HGSkTcwLr4Y3lOhhXXjRljOPRv8SiGHW1uaHYrJN58CvZzeKF5w1cnc9TuRW1kJKxvDr+TBmp+rWrbRU+houyfQX+1jh/AkSDXYPLaTuSMnf0IuaVQlHEgY2uHGi20Dwek3zGGBgJGprPRRpxM16DbWhSFJYvDeWAGphC97y9Txrm/GyeXv+fKLCpruaZNCWVpE0S5cJ878ul0Ftlrx8ExeuQDLFPjBPztJM6Lvwxeo83GSDYE65F8WPA2oyrLSGuIqVaxITrXCwsnEHO5WQHSI0hV8eZXYPZ10T1UoktxV4aw0qswREqMtutEVVWOF5hsmuSHwIkSqGcbM1nXkRekznPppZ8neaNJbHuPLQyD7muHXrUG5qWb+OztaKMmepOYQP3i8F60rRQj
X-Forefront-Antispam-Report:
	CIP:20.98.2.159;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:us1-emailsignatures-cloud.codetwo.com;PTR:us1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(9686003)(53546011)(7696005)(6506007)(356005)(33656002)(83380400001)(36860700001)(40480700001)(47076005)(86362001)(82740400003)(26005)(7596003)(478600001)(7636003)(55016003)(336012)(44832011)(4326008)(52536014)(8676002)(8936002)(316002)(70586007)(6916009)(70206006)(5660300002)(66899024)(41300700001)(2906002)(142923001)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: Nuix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 22:36:34.3485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13986fa4-9221-445c-cd67-08dc13beee73
X-MS-Exchange-CrossTenant-Id: a00035bc-d628-4788-97c4-bbfbf70f3e7a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a00035bc-d628-4788-97c4-bbfbf70f3e7a;Ip=[20.98.2.159];Helo=[us1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840

UmVnYXJkaW5nIEdpdCBmb3IgV2luZG93cyByZXF1aXJpbmcgJ2dpdCBiYXNoJyBjb25zb2xlIHRv
IHBlcmZvcm0gdGV4dCBjb252ZXJzaW9uLi4uDQoNCj5UaGlzIHNvdW5kcyBsaWtlIGEgR2l0IGZv
ciBXaW5kb3dzIGJ1Zy4gIFJhdGhlciB0aGFuIGRvY3VtZW50aW5nIGl0LCBjb3VsZCB5b3Ugb3Bl
biBhbiBpc3N1ZSBmb3IgaXQgb24gdGhlaXIgcHJvamVjdD8NCj5UaGF0IHNvdW5kcyBsaWtlIGEg
UEFUSCBtaXNjb25maWd1cmF0aW9uIG9uIHlvdXIgcGFydC4gIEhhdmUgeW91IGNoZWNrZWQgeW91
ciBQQVRIIHNldHRpbmdzIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBwYXRoIGluY2x1ZGluZyB0aGUg
YmluYXJ5IGlzIGluY2x1ZGVkPw0KDQpJZiBpdCBpcyBtZXJlbHkgdGhhdCBJIG5lZWQgdG8gYWRq
dXN0IG15IFBBVEggc28gaWNvbnYuZXhlIGlzIGFjY2Vzc2libGUsIHRoYXQgc2ltcGxpZmllcyBl
dmVyeXRoaW5nOyBob3dldmVyLCBpdCBjb3VsZCBwb3NzaWJseSBiZSBhIEdpdCBmb3IgV2luZG93
cyBpbnN0YWxsZXIgYnVnIChvciBwZXJoYXBzIHRoZSBpbnN0YWxsZXIgb2ZmZXJlZCB0byBjaGFu
Z2UgbXkgUEFUSCBhbmQgSSBkZWNsaW5lZCkuDQoNCkknbGwgY2hlY2sgb3V0IGJvdGggcG9zc2li
aWxpdGllcy4NCg0KPldlIGhhdmUgYWxzbyBkb2N1bWVudGVkIHRoZSBVVEYtMTZMRS1CT00gY2Fz
ZSBzcGVjaWZpY2FsbHkgaW4gdGhlIEdpdCBGQVEgKGdpdCBoZWxwIGdpdGZhcSkgdW5kZXIgIkkn
bSBvbiBXaW5kb3dzIGFuZCBteSB0ZXh0IGZpbGVzIGFyZSBkZXRlY3RlZCBhcyBiaW5hcnkiLg0K
DQpJJ2xsIHRha2UgYSBsb29rIGFuZCBwZXJoYXBzIHJldmlzZSBteSBzdWdnZXN0ZWQgZG9jdW1l
bnRhdGlvbiBlZGl0cy4NCg0KVGhhbmtzLA0KLSBNaWNoYWVsDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFz
dGUubmV0PiANClNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAyNCAxOjUwIFBNDQpUbzogTWlj
aGFlbCBMaXR3YWsgPG1pY2hhZWwubGl0d2FrQG51aXguY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5l
bC5vcmcNClN1YmplY3Q6IFtFWFRFUk5BTF1SZTogU3VnZ2VzdGVkIGNsYXJpZmljYXRpb24gZm9y
IC5naXRhdHRyaWJ1dGVzIHJlZmVyZW5jZSBkb2N1bWVudGF0aW9uDQoNCk9uIDIwMjQtMDEtMTIg
YXQgMjE6MjU6MTksIE1pY2hhZWwgTGl0d2FrIHdyb3RlOg0KPiAgICAgUGxlYXNlIG5vdGUsIEdp
dCBmb3IgV2luZG93cyBkb2VzIG5vdCBzdXBwb3J0IFVURi0xNkxFIGVuY29kaW5nIHdoZW4gcnVu
bmluZyBnaXQNCj4gICAgIGNvbW1hbmRzIGZyb20gYW4gb3JkaW5hcnkgQ29tbWFuZCBQcm9tcHQu
ICBVc2UgYSBnaXQgYmFzaCBjb25zb2xlIGluc3RlYWQuDQoNClRoaXMgc291bmRzIGxpa2UgYSBH
aXQgZm9yIFdpbmRvd3MgYnVnLiAgUmF0aGVyIHRoYW4gZG9jdW1lbnRpbmcgaXQsIGNvdWxkIHlv
dSBvcGVuIGFuIGlzc3VlIGZvciBpdCBvbiB0aGVpciBwcm9qZWN0Pw0KDQo+IE5FVyBURVhUOg0K
PiAgICAgDQo+ICAgICBZb3UgY2FuIGdldCBhIGxpc3Qgb2YgYWxsIGF2YWlsYWJsZSBlbmNvZGlu
Z3Mgb24geW91ciBwbGF0Zm9ybSB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4gICAgIA0K
PiAgICAgaWNvbnYgLS1saXN0DQo+ICAgICANCj4gICAgIEZvciBHaXQgZm9yIFdpbmRvd3MgdXNl
cnMgdGhlIGNvbW1hbmQsIGFib3ZlLCBpcyBvbmx5IHN1cHBvcnRlZCB3aGVuIHJ1bm5pbmcgaW4g
YSAnZ2l0IGJhc2gnIGNvbnNvbGUuDQoNClRoYXQgc291bmRzIGxpa2UgYSBQQVRIIG1pc2NvbmZp
Z3VyYXRpb24gb24geW91ciBwYXJ0LiAgSGF2ZSB5b3UgY2hlY2tlZCB5b3VyIFBBVEggc2V0dGlu
Z3MgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHBhdGggaW5jbHVkaW5nIHRoZSBiaW5hcnkgaXMgaW5j
bHVkZWQ/DQoNCj4gQ09OQ0xVU0lPTjoNCj4gDQo+IFRleHQgZmlsZXMgZW5jb2RlZCB3aXRoIFVU
Ri0xNkxFIHdpdGggQk9NIGFyZSBjb21tb24gaW4gdGhlIFdpbmRvd3MgDQo+IHdvcmxkLCBhcyBz
b21lIHZlcnNpb25zIG9mIFZpc3VhbCBTdHVkaW8gd2lsbCB1c2UgdGhpcyBhcyB0aGUgZGVmYXVs
dCANCj4gZW5jb2RpbmcgZm9yIC5yYyBvciAubWMgZmlsZXMuICBTb2x1dGlvbiBmaWxlcywgcHJv
amVjdCBmaWxlcyBhbmQgDQo+IG90aGVyIFZpc3VhbCBTdHVkaW8gZmlsZXMgY2FuIGFsc28gYmUg
aW4gdGhpcyBmb3JtYXQuICBPdGhlciBlbmNvZGluZ3MgDQo+IGFyZSBjb21tb24sIHRvbywgZS5n
LiBzb21lIG9sZGVyIHZlcnNpb25zIG9mIFBvd2VyU2hlbGwgZGVmYXVsdGVkIHRvIA0KPiBVVEYt
MTZCRSB3aXRoIEJPTSBmb3IgbmV3IC5wczEgZmlsZXMuIFlldCB1c2VycyBjb250aW51ZSB0byBl
eHBlcmllbmNlIA0KPiBlbmNvZGluZyBlcnJvcnMgZXZlbiB3aGVuIHRoZXkgYXJlIHVzaW5nIHRo
ZSBwcm9wZXIgDQo+IHdvcmtpbmctdHJlZS1lbmNvZGluZyBpbiB0aGVpciAuZ2l0YXR0cmlidXRl
cyBmaWxlLiAgUGFydCBvZiB0aGlzIGlzIA0KPiBkdWUgdG8gdGhlIGNvbXBsZXhpdHkgb2YgR2l0
IGFuZCB0aGUgbnVtYmVyIG9mIGRpZmZlcmVudCBwbGF0Zm9ybXMgaXQgDQo+IHN1cHBvcnRzLg0K
DQpJIHNob3VsZCBwb2ludCBvdXQgdGhhdCBVVEYtOCBpcyBwcmV0dHkgbXVjaCB0aGUgc3RhbmRh
cmQgdGhlc2UgZGF5cyBpbiBtYW55IGRvbWFpbnMsIGV2ZW4gb24gV2luZG93cy4gIEZvciBleGFt
cGxlLCBub2JvZHkgaXMgZ29pbmcgdG8gYmUgcGxlYXNlZCBpZiB5b3Ugd3JpdGUgYSB3ZWIgcGFn
ZSBpbiBhbnkgdmFyaWFudCBvZiBVVEYtMTYsIGFuZCBzb21lIGxhbmd1YWdlcywgc3VjaCBhcyBS
dXN0LCBhcmUgc2ltcGx5IGRlZmluZWQgdG8gYmUgaW4gVVRGLTggYW5kIHdvbid0IHdvcmsgaWYg
eW91IHB1dCB0aGVtIGluIGFueSBvdGhlciBlbmNvZGluZy4gIEFsbW9zdCBhbGwgZWRpdG9ycyB0
aGVzZSBkYXlzIGRvIHN1cHBvcnQgVVRGLTggKHdpdGhvdXQgQk9NKSwgZXZlbiBvbiBXaW5kb3dz
LCBzbyB3ZSBkbyB3YW50IHRvIHN0cm9uZ2x5IGVuY291cmFnZSB0aGF0IHJhdGhlciB0aGFuIGhh
dmluZyBwZW9wbGUgdXNlIFVURi0xNi4gIFRoZSBHaXQgRkFRIHNwZWNpZmljYWxseSBvdXRsaW5l
cyBVVEYtOCBhcyB0aGUgcmVjb21tZW5kZWQgd2F5LCB3aGljaCBpcyBtb3N0IHBvcnRhYmxlIGFu
ZCBtb3N0IGZ1bmN0aW9uYWwuDQoNCldlIGhhdmUgYWxzbyBkb2N1bWVudGVkIHRoZSBVVEYtMTZM
RS1CT00gY2FzZSBzcGVjaWZpY2FsbHkgaW4gdGhlIEdpdCBGQVEgKGdpdCBoZWxwIGdpdGZhcSkg
dW5kZXIgIkknbSBvbiBXaW5kb3dzIGFuZCBteSB0ZXh0IGZpbGVzIGFyZSBkZXRlY3RlZCBhcyBi
aW5hcnkiLiAgQW5zd2VyaW5nIHF1ZXN0aW9ucyBvbiBTdGFjayBPdmVyZmxvdywgSSByZWFsaXpl
IHRoYXQgbm9ib2R5IGFjdHVhbGx5IHJlYWRzIHRoZSBGQVEsIGJ1dCB3ZSBkaWQgY2xlYXJseSBk
b2N1bWVudCBob3cgdG8gZG8gaXQuICBUaGF0IGJlaW5nIHNhaWQsIEknbSBub3Qgb3Bwb3NlZCB0
byBhbiBhZGRpdGlvbmFsIG1lbnRpb24gaW4gdGhlDQpnaXRhdHRyaWJ1dGVzKDUpIHBhZ2UgaWYg
eW91IHdhbnQgdG8gc2VuZCBhbiBhY3R1YWwgcGF0Y2guDQotLQ0KYnJpYW4gbS4gY2FybHNvbiAo
aGUvaGltIG9yIHRoZXkvdGhlbSkNClRvcm9udG8sIE9udGFyaW8sIENBDQo=
