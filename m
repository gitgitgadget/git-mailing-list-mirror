Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2111.outbound.protection.outlook.com [40.107.212.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888C6FC2
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuix.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nuix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="mxFbzKpn";
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="mxFbzKpn"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=cv2O23F8qUHhurmxndTmwTWvyLNt9Zze66dX+BIksLJl/+t0d8vYBV7xLCU/EXCNzlxeLjPZyef8wBdtwa0Rndj1cxEKzR6Mb773rcFqILPinQ2Q5K+j4GCYUkhVB4ul7A/t1yE8NuBmV5E0jfDb3uvPVn6shHSXEyXzz6K9GrsyY16WIAx+26B1oXrU5HotRRAn/pbifkEhuHAjy/GlZ40PzqNdYf0RYYprwq5pfi3ecs+C2BBf9dSa1GpIijMhXXjnkSJYtFpyUV9fy7tEaZQDAUM/2chHKADIpSaPEinvtfiF1k+fhN/iNC64QOniGcteD6Y/0Y57GANiYF3uFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4gAzU9kvTKCwjiUK6zIvjCz4EnVwWbNG+BDF3DpQx4=;
 b=ilVkK0AGFTg2t+b76qkt38BUPElrTdn09B739d5QxTSKAqcsUQ4k7GCZ2ekN1Ig4p/4CnuJBGsp0S6eljSq48lW0EEcmaq5JqOykJ1I2S9renQK99beNCKadre9s6Z0+7LWXUJuksY909zyd2LQ/JUuCndFvRWVG2w7xtze7Ruo8V1TbBBcz5yQizYoZhsZkirZWJZwebg2Ljh28qG2vz3UAn3OhE5fT0HBbZFmzfbIgEZzprZUFO5MFL4Du38Qi6glnSDhuLR05EVwu9fb/VDY61Nyv/ennEYJjl28dpTqAPOR78U71hh2DGVnRgrgS73Y7EXFoyzTT+Pq7B6hYLg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.98.2.159) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=nuix.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuix.com; dkim=pass (signature was verified) header.d=nuix.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=nuix.com]
 dkim=[1,1,header.d=nuix.com] dmarc=[1,1,header.from=nuix.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4gAzU9kvTKCwjiUK6zIvjCz4EnVwWbNG+BDF3DpQx4=;
 b=mxFbzKpnFJ1pmp8h0wqxT55nQTM+oVdaPlKmzSKkl1fFSJQl4WFAKuadtHptQMayZrc1cx0SAHLVLULSyca2T2CJvbxFCYRoNhsV3IQJgtWyRe/Wwn89Oe3qZ2L9uyasO+lFmyRmik0bJZO21lVrgZ5wCn8zJToPGsXp1CkB3Bc=
Received: from CY5P221CA0071.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::37) by
 PH8PR10MB6552.namprd10.prod.outlook.com (2603:10b6:510:224::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Sat, 13 Jan 2024 02:56:32 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::41) by CY5P221CA0071.outlook.office365.com
 (2603:10b6:930:4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Sat, 13 Jan 2024 02:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.98.2.159)
 smtp.mailfrom=nuix.com; dkim=pass (signature was verified)
 header.d=Nuix.com;dmarc=pass action=none header.from=nuix.com;
Received-SPF: Pass (protection.outlook.com: domain of nuix.com designates
 20.98.2.159 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.98.2.159; helo=us1-emailsignatures-cloud.codetwo.com; pr=C
Received: from us1-emailsignatures-cloud.codetwo.com (20.98.2.159) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.13 via Frontend Transport; Sat, 13 Jan 2024 02:56:32 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168) by us1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 13 Jan 2024 02:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYXLCPsLhip7hVRQy7AZFxBDo+f/C41LMnq4prphdHo83Ezxelpxx2i44Tt2eePlw4ESy5S9trQlmg5JCJZ+mYG+6ZIjjmkpjdUSel3wvHZs73zLz+TMUPsagABaAyVOIhuk0DSZAo9TSZs5olzD84dbjozvOb7ENFs4SYgBCSSZEh+2HB8GdOp16gmoLA4UOT6na9VujwVy3VAvVGRgLqikE+HTiTSz6zqw1ZsBxtqkJN1gtM+h9uTkU6P2al8srOniCS+S8SUdxUx1C3ROpn7jmIoF3LBBurUgwDw+gXhW60MNOPrTVFGc/dK/YOZjVmrPumSy5+8DnmyVV1KqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4gAzU9kvTKCwjiUK6zIvjCz4EnVwWbNG+BDF3DpQx4=;
 b=IHVC5xlIVz4vQO9F4dsSOy7a++V3PPbPvCP2Qa1Q3dit+cn+PQwtR/VQ5FRwoj7WWZHTlgr7/EVHO9FY6rRA5cSbcWzTU7sWTjeiA6XzUT3040BJQu3DA/PXMhgT7ghTWFF/Y/b+3s19KDbHJJlkbpCknhtk7LFLgUDZINHmKz5wc5+LmE3WXHcRsklcF75gjBWStrMjvDU+6fIsf0I+yL/iGQ49PctbuKQfQCgeQXKS7622v6D6DL80eTZhNmhKMCc4YlB0Wmtby5M0d89OrWORTc6TyTxiC9Bp9wLY1kswUl1+m7vN/ww1FcJogwmXITOCyzw+SwqGVto86qBGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuix.com; dmarc=pass action=none header.from=nuix.com;
 dkim=pass header.d=nuix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4gAzU9kvTKCwjiUK6zIvjCz4EnVwWbNG+BDF3DpQx4=;
 b=mxFbzKpnFJ1pmp8h0wqxT55nQTM+oVdaPlKmzSKkl1fFSJQl4WFAKuadtHptQMayZrc1cx0SAHLVLULSyca2T2CJvbxFCYRoNhsV3IQJgtWyRe/Wwn89Oe3qZ2L9uyasO+lFmyRmik0bJZO21lVrgZ5wCn8zJToPGsXp1CkB3Bc=
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 02:56:28 +0000
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6]) by SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6%6]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 02:56:27 +0000
From: Michael Litwak <michael.litwak@nuix.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Suggested clarification for .gitattributes reference
 documentation
Thread-Topic: Suggested clarification for .gitattributes reference
 documentation
Thread-Index: AQHaRafHGVsr0eDalEqCluuSk5bwILDXCitA
Date: Sat, 13 Jan 2024 02:56:27 +0000
Message-ID: <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
 <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
In-Reply-To: <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuix.com;
x-ms-traffictypediagnostic:
	SJ0PR10MB5693:EE_|CO1PR10MB4659:EE_|CY4PEPF0000FCC3:EE_|PH8PR10MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: e128d244-f58d-42c2-b6b5-08dc13e33f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 CiFgJ4XkWQ0F6NbrJvFa3X+MxJvq0lBV1+7fJGCOKLjmky3sME0V1nwQY9rFPdtnxEhQKThjpl3nfIteZK9lhKR7IVn3ws4BbhqLFzYqJmVFFr2GmYrRociZ7R+Ki5b8QfEKEd/lGIXHhA+ZRSGiN/E9ZYiI9pxAzTPamp6Wb8LnXTvs9KeZ6ey6xWhe14iIbEaRf8EsFdch933ciAye/ebbGwZhJwuuSDL8noCPaHBsLK+RnZVJV/MVgXwpgv+BsMMAhoMCfGas9r5CrzgwF0WES3EG2EBsnBFhLf3jsvN+RkHHZRcE1jNCPkPZBHJgQARy0pHY3nYJW4YaAOVE0Z9gLCN3rgin6IXXLpMZ3cG7CKiofwpp1faqIpvA3ThAz88U70GqnNuXmyc1497VB1MPYFflsy5WkE5aekvLPPjbjZ0hSbcBhsVkOeSwx/msP5S2SU0j8v6uNxfCL4p7UGEAhQpVCIGPe6g8h8gG437M2wZgaNJudgGYQyN3uKTHiiSw0yXwwj5EBkQZz+wmL18s0lSdNdku+r6nVfh3Ii/uIpGf+sUpMcCc19mAF3+cr5kEqg0RnnzaROPsBL1YABZuhxbJWw1trHQ2U2ftQ+UHXgPgI6bruN+jDBO8HHbKclBLuEa//itSbYmtLZX3mbouTJyQNLzfaGUzCZTVyRULEIn11taX7bXHF0mYZDUzBt8Vq8zpJ2MjKRFleSn8HQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5693.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(66899024)(55016003)(83380400001)(86362001)(316002)(76116006)(41300700001)(33656002)(38070700009)(122000001)(38100700002)(9686003)(26005)(6506007)(53546011)(5660300002)(2906002)(64756008)(7696005)(6916009)(66556008)(66446008)(66946007)(66476007)(71200400001)(8676002)(52536014)(4326008)(8936002)(478600001)(44832011)(142923001)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-CodeTwo-MessageID: 6822c4e8-5829-4c8e-8d7e-fafe2595f9c1.20240113025631@us1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0d1c45b2-52d4-48fa-0f5e-08dc13e33ccc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C6WFyNSc42tRJ+3Jm4X7ner8jjbMtPJqj7UbKm7EMtLg2K2YQjGVfs8Hn9iB0nRDUhg1z7aJaKb2xHVClz6nbLYhchYCBpIKPl3pmWLpDdB8GnIzavPNxM6j4Z4Ccmd1DLjroa59o91OW66SuoPsgn8oo69hjt1NPuYVe2dnUtk6/tm2VSgDQUkZT2uYUoMZMrn+hNhA2N1LbP36U5bFi7gSiBNOumcmGZgUNsWdqysh9B+PSURZ+sT6itYZinbYiH3Er57ci40xR6ncawZWQ1XBVGXm1IJALtbiOvgYUOo8N7CWIcuydGw7iAWHyZY5RDbYBTY3zP1/6k6gle5KSEdMhK5uMohqzhx+NcTrm4edivPypEUGUfr7WoAQTf/F+yAzomUpjfQcpNXWI3CfYTmw7pJEG+hunguDDrQtmmTCgciFlP1cgKo6PvF54SHwEQHoHKtjDBH6DHUQL/u1OuAZgyxLhUYBV/M5yb3q2PhsB2Pof3Ng8pvQ7kqLNsCy9BHYvs00uXPRjAMvHMhzB7IIgasupCviDLGPedTKdbg8DiTQHCdT0098HZe/EKJiRv/unyyuPrV32Gts2Jnu7n/+52Y+Tr4E3YAh3lHomM/pKsHZtDAibmf2jS5HA+oJTLMm8Uuzm3K/cq3MB4+n4gL8cd6S9KI5qCXW82h02xEnuT5VQw3InuX8xXb9jZsQHJ5tlhoA7yUwt9pi+wvIIYZoxOZMjiQmdSJcw91om3DOgZDD5dlXJFVVn8asFOqnTLeYkCuJSJisvMyMxhCofHUOWYW5o0eCVXtkuxCuh8ArFmlo4T8A1g99R2pPJ64A
X-Forefront-Antispam-Report:
	CIP:20.98.2.159;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:us1-emailsignatures-cloud.codetwo.com;PTR:us1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39850400004)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(82740400003)(66899024)(36860700001)(33656002)(356005)(86362001)(7636003)(41300700001)(7596003)(6916009)(4326008)(8936002)(44832011)(6506007)(8676002)(316002)(70206006)(26005)(52536014)(40480700001)(70586007)(7696005)(9686003)(53546011)(47076005)(5660300002)(478600001)(2906002)(336012)(55016003)(83380400001)(142923001)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: Nuix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 02:56:32.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e128d244-f58d-42c2-b6b5-08dc13e33f85
X-MS-Exchange-CrossTenant-Id: a00035bc-d628-4788-97c4-bbfbf70f3e7a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a00035bc-d628-4788-97c4-bbfbf70f3e7a;Ip=[20.98.2.159];Helo=[us1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6552

SSBqdXN0IGluc3RhbGxlZCBHaXQgZm9yIFdpbmRvd3MgMi40My4wIGFuZCBub3RpY2VkIHRoZSBp
bnN0YWxsZXIgb2ZmZXJzIHRocmVlIG9wdGlvbnMgZm9yIGFsdGVyaW5nIHRoZSBQQVRIOg0KDQox
KSBSdW4gZ2l0IGZyb20gZ2l0IGJhc2ggb25seQ0KDQoyKSBSdW4gZ2l0IGZyb20gZ2l0IGJhc2gs
IGNtZC5leGUgYW5kIFBvd2VyU2hlbGwgKFJFQ09NTUVOREVEKQ0KDQozKSBSdW4gZ2l0IGZyb20g
Z2l0IGJhc2gsIGNtZC5leGUgYW5kIFBvd2VyU2hlbGwgd2l0aCBvcHRpb25hbCB1dGlsaXRpZXMg
KHdhcm5pbmc6IHdpbGwgb3ZlcnJpZGUgZmluZCwgc29ydCBhbmQgb3RoZXIgc3lzdGVtIHV0aWxp
dGllcykuDQoNCkl0IHR1cm5zIG91dCBpY29udi5leGUgaXMgYWNjZXNzaWJsZSBmcm9tIGNtZC5l
eGUgKENvbW1hbmQgUHJvbXB0KSBvbmx5IHdoZW4geW91IHRha2UgdGhlIHRoaXJkIG9wdGlvbi4g
IEJ1dCBpY29udi5leGUgaXMgTk9UIG9wdGlvbmFsLiAgSXQgaXMgcmVxdWlyZWQgZm9yIGdpdCB0
byBkZWFsIHdpdGggVVRGLTE2TEUgd2l0aCBCT00gdGV4dCBjb252ZXJzaW9ucyAoYW5kIHByb2Jh
Ymx5IGZvciBudW1lcm91cyBvdGhlciBlbmNvZGluZyBjb252ZXJzaW9ucykuDQoNCkJ1dCB3aGVu
IFBBVEggb3B0aW9uICMyIGlzIGNob3NlbiwgYW5kIGljb252LmV4ZSBpcyB1bnJlYWNoYWJsZSBm
cm9tIGEgV2luZG93cyBDb21tYW5kIFByb21wdCwgdGhlIGdpdCBjb21tYW5kcyB3aGljaCBjYWxs
IHVwb24gaWNvbnYuZXhlIGRvIE5PVCBpbmRpY2F0ZSB0aGUgZXJyb3IuICBUaGUgY2FsbCB0byBp
Y29udi5leGUgZmFpbHMgc2lsZW50bHkuICBJdCBpcyBvbmx5IGxhdGVyIGFmdGVyIHlvdSBjb21t
aXQsIHB1c2ggYW5kIGNsb25lIHRoZSByZXBvIGFnYWluIHRoYXQgeW91IHNlZSB0aGUgZW5jb2Rp
bmcgZmFpbHVyZXMuDQoNCkFuZCB0aGUgd2FybmluZyBhYm91dCBvdmVycmlkaW5nIGZpbmQgYW5k
IHNvcnQgbXVzdCBiZSB0YWtlbiB3aXRoIGEgZ3JhaW4gb2Ygc2FsdCwgc2luY2UgdGhlIFdpbmRv
d3MgdmVyc2lvbnMgb2YgdGhvc2UgcHJvZ3JhbXMgYXJlIGFjY2Vzc2VkIHZpYSBhIFdpbmRvd3Mg
Zm9sZGVyIHdoaWNoIGFwcGVhcnMgZWFybGllciBpbiB0aGUgUEFUSC4NCg0KU28gdGhpcyBHaXQg
Zm9yIFdpbmRvd3MgaW5zdGFsbGVyIHNjcmVlbiBpcyBtaXNsZWFkaW5nLiAgQW5kIHBlcmhhcHMg
aWNvbnYuZXhlIHNob3VsZCBiZSByZWxvY2F0ZWQgc28gaXQgaXMgYWNjZXNzaWJsZSBldmVuIHdo
ZW4gUEFUSCBvcHRpb24gIzIgaXMgY2hvc2VuLiAgSSBpbnRlbmQgdG8gc3VibWl0IGFuIGlzc3Vl
IG9uIHRoZSBHaXQgZm9yIFdpbmRvd3MgaXNzdWUgdHJhY2tlciByZWdhcmRpbmcgdGhpcy4gIEkn
bGwgYWxzbyBzdWJtaXQgYW4gaXNzdWUgYWJvdXQgdGhlIGxhY2sgb2YgYW4gZXJyb3Igd2hlbiBy
dW5uaW5nICdnaXQgYWRkJyBmb3IgYSBVVEYtMTZMRSB3aXRoIEJPTSBmaWxlIHVuZGVyIFBBVEgg
b3B0aW9uICMyLg0KDQpUaGFua3MsDQotIE1pY2hhZWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5u
ZXQ+DQpTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMTo1MCBQTQ0KVG86IE1pY2hhZWwg
TGl0d2FrIDxtaWNoYWVsLmxpdHdha0BudWl4LmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBbRVhURVJOQUxdUmU6IFN1Z2dlc3RlZCBjbGFyaWZpY2F0aW9uIGZvciAuZ2l0
YXR0cmlidXRlcyByZWZlcmVuY2UgZG9jdW1lbnRhdGlvbg0KDQpPbiAyMDI0LTAxLTEyIGF0IDIx
OjI1OjE5LCBNaWNoYWVsIExpdHdhayB3cm90ZToNCj4gICAgIFBsZWFzZSBub3RlLCBHaXQgZm9y
IFdpbmRvd3MgZG9lcyBub3Qgc3VwcG9ydCBVVEYtMTZMRSBlbmNvZGluZyB3aGVuIHJ1bm5pbmcg
Z2l0DQo+ICAgICBjb21tYW5kcyBmcm9tIGFuIG9yZGluYXJ5IENvbW1hbmQgUHJvbXB0LiAgVXNl
IGEgZ2l0IGJhc2ggY29uc29sZSBpbnN0ZWFkLg0KDQpUaGlzIHNvdW5kcyBsaWtlIGEgR2l0IGZv
ciBXaW5kb3dzIGJ1Zy4gIFJhdGhlciB0aGFuIGRvY3VtZW50aW5nIGl0LCBjb3VsZCB5b3Ugb3Bl
biBhbiBpc3N1ZSBmb3IgaXQgb24gdGhlaXIgcHJvamVjdD8NCg0KPiBORVcgVEVYVDoNCj4gICAg
IA0KPiAgICAgWW91IGNhbiBnZXQgYSBsaXN0IG9mIGFsbCBhdmFpbGFibGUgZW5jb2RpbmdzIG9u
IHlvdXIgcGxhdGZvcm0gd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQ6DQo+ICAgICANCj4gICAg
IGljb252IC0tbGlzdA0KPiAgICAgDQo+ICAgICBGb3IgR2l0IGZvciBXaW5kb3dzIHVzZXJzIHRo
ZSBjb21tYW5kLCBhYm92ZSwgaXMgb25seSBzdXBwb3J0ZWQgd2hlbiBydW5uaW5nIGluIGEgJ2dp
dCBiYXNoJyBjb25zb2xlLg0KDQpUaGF0IHNvdW5kcyBsaWtlIGEgUEFUSCBtaXNjb25maWd1cmF0
aW9uIG9uIHlvdXIgcGFydC4gIEhhdmUgeW91IGNoZWNrZWQgeW91ciBQQVRIIHNldHRpbmdzIHRv
IG1ha2Ugc3VyZSB0aGF0IHRoZSBwYXRoIGluY2x1ZGluZyB0aGUgYmluYXJ5IGlzIGluY2x1ZGVk
Pw0KDQo+IENPTkNMVVNJT046DQo+IA0KPiBUZXh0IGZpbGVzIGVuY29kZWQgd2l0aCBVVEYtMTZM
RSB3aXRoIEJPTSBhcmUgY29tbW9uIGluIHRoZSBXaW5kb3dzIA0KPiB3b3JsZCwgYXMgc29tZSB2
ZXJzaW9ucyBvZiBWaXN1YWwgU3R1ZGlvIHdpbGwgdXNlIHRoaXMgYXMgdGhlIGRlZmF1bHQgDQo+
IGVuY29kaW5nIGZvciAucmMgb3IgLm1jIGZpbGVzLiAgU29sdXRpb24gZmlsZXMsIHByb2plY3Qg
ZmlsZXMgYW5kIA0KPiBvdGhlciBWaXN1YWwgU3R1ZGlvIGZpbGVzIGNhbiBhbHNvIGJlIGluIHRo
aXMgZm9ybWF0LiAgT3RoZXIgZW5jb2RpbmdzIA0KPiBhcmUgY29tbW9uLCB0b28sIGUuZy4gc29t
ZSBvbGRlciB2ZXJzaW9ucyBvZiBQb3dlclNoZWxsIGRlZmF1bHRlZCB0byANCj4gVVRGLTE2QkUg
d2l0aCBCT00gZm9yIG5ldyAucHMxIGZpbGVzLiBZZXQgdXNlcnMgY29udGludWUgdG8gZXhwZXJp
ZW5jZSANCj4gZW5jb2RpbmcgZXJyb3JzIGV2ZW4gd2hlbiB0aGV5IGFyZSB1c2luZyB0aGUgcHJv
cGVyIA0KPiB3b3JraW5nLXRyZWUtZW5jb2RpbmcgaW4gdGhlaXIgLmdpdGF0dHJpYnV0ZXMgZmls
ZS4gIFBhcnQgb2YgdGhpcyBpcyANCj4gZHVlIHRvIHRoZSBjb21wbGV4aXR5IG9mIEdpdCBhbmQg
dGhlIG51bWJlciBvZiBkaWZmZXJlbnQgcGxhdGZvcm1zIGl0IA0KPiBzdXBwb3J0cy4NCg0KSSBz
aG91bGQgcG9pbnQgb3V0IHRoYXQgVVRGLTggaXMgcHJldHR5IG11Y2ggdGhlIHN0YW5kYXJkIHRo
ZXNlIGRheXMgaW4gbWFueSBkb21haW5zLCBldmVuIG9uIFdpbmRvd3MuICBGb3IgZXhhbXBsZSwg
bm9ib2R5IGlzIGdvaW5nIHRvIGJlIHBsZWFzZWQgaWYgeW91IHdyaXRlIGEgd2ViIHBhZ2UgaW4g
YW55IHZhcmlhbnQgb2YgVVRGLTE2LCBhbmQgc29tZSBsYW5ndWFnZXMsIHN1Y2ggYXMgUnVzdCwg
YXJlIHNpbXBseSBkZWZpbmVkIHRvIGJlIGluIFVURi04IGFuZCB3b24ndCB3b3JrIGlmIHlvdSBw
dXQgdGhlbSBpbiBhbnkgb3RoZXIgZW5jb2RpbmcuICBBbG1vc3QgYWxsIGVkaXRvcnMgdGhlc2Ug
ZGF5cyBkbyBzdXBwb3J0IFVURi04ICh3aXRob3V0IEJPTSksIGV2ZW4gb24gV2luZG93cywgc28g
d2UgZG8gd2FudCB0byBzdHJvbmdseSBlbmNvdXJhZ2UgdGhhdCByYXRoZXIgdGhhbiBoYXZpbmcg
cGVvcGxlIHVzZSBVVEYtMTYuICBUaGUgR2l0IEZBUSBzcGVjaWZpY2FsbHkgb3V0bGluZXMgVVRG
LTggYXMgdGhlIHJlY29tbWVuZGVkIHdheSwgd2hpY2ggaXMgbW9zdCBwb3J0YWJsZSBhbmQgbW9z
dCBmdW5jdGlvbmFsLg0KDQpXZSBoYXZlIGFsc28gZG9jdW1lbnRlZCB0aGUgVVRGLTE2TEUtQk9N
IGNhc2Ugc3BlY2lmaWNhbGx5IGluIHRoZSBHaXQgRkFRIChnaXQgaGVscCBnaXRmYXEpIHVuZGVy
ICJJJ20gb24gV2luZG93cyBhbmQgbXkgdGV4dCBmaWxlcyBhcmUgZGV0ZWN0ZWQgYXMgYmluYXJ5
Ii4gIEFuc3dlcmluZyBxdWVzdGlvbnMgb24gU3RhY2sgT3ZlcmZsb3csIEkgcmVhbGl6ZSB0aGF0
IG5vYm9keSBhY3R1YWxseSByZWFkcyB0aGUgRkFRLCBidXQgd2UgZGlkIGNsZWFybHkgZG9jdW1l
bnQgaG93IHRvIGRvIGl0LiAgVGhhdCBiZWluZyBzYWlkLCBJJ20gbm90IG9wcG9zZWQgdG8gYW4g
YWRkaXRpb25hbCBtZW50aW9uIGluIHRoZQ0KZ2l0YXR0cmlidXRlcyg1KSBwYWdlIGlmIHlvdSB3
YW50IHRvIHNlbmQgYW4gYWN0dWFsIHBhdGNoLg0KLS0NCmJyaWFuIG0uIGNhcmxzb24gKGhlL2hp
bSBvciB0aGV5L3RoZW0pDQpUb3JvbnRvLCBPbnRhcmlvLCBDQQ0K
