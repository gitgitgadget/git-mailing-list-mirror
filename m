Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F33387
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuix.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nuix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="1mrptxOe";
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="1mrptxOe"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=N6Jpr89muIJZx7GlSur6vtNMbfkHPE7kITVrYQ3G36o1mhTzPGJXu0+d1CMoVvr2wU123jGkzROhEuVd74DMZW2woYehQktLl82XTX8dKRjQjimQLdRguOtDTO1O57XxtBMJjUMgSbpJF6Cjk2tQ/6jU3pWyFd/01FSp8a9buWLZbm5XGFr0E/rm6kyvtT3MwWPBylEKKwa9LpjaOcMRb5nrob5SSVrZqMYTm/lPPa2YjbtjF4QHtitjupazawUBuB6U6yqleC869PVxKQ0qYBixeJcv9CD6TQbAE6vRYmDKYhqkCsWo0ETntpO4pCys6ilgTG5k1Bm6PHRL8vB3HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4Nln+7sk9xXYH4K8xNf+fmqVUDORqHG9Da8Yeb6GDU=;
 b=YF8v7NJKTXAJ+CXLT9SYfJmssLpOUChQlG64rc+3pK80+OXqt68u0OpGHmg74m5rrylxblntvTpMu5bi8Gc2IYgUa2N2zvoz7SdmhOglbLF6EnjHmznVyb3ByLJa1M8ji9OwNALBlp1Wdn1M7IUuCua2Dm9npTiuEEEXsx/03U0ZHeYocZWyyBDn6Xf8NcSjDavbm7m9i7Rtou5qQ0oDRZrngV6sQ+QN/io68yPEECp3EM92Nkg9a+Mtygd9sPWqtbjf/j1rRl3EAKoh6Le+zoKJ/BjmvaXnqwG30QdlD9cJf2bR4+jGgItiMjrWbaNywTZuPvWb7Q+f5MCXVyemxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.98.2.159) smtp.rcpttodomain=web.de smtp.mailfrom=nuix.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nuix.com;
 dkim=pass (signature was verified) header.d=nuix.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=nuix.com] dkim=[1,1,header.d=nuix.com]
 dmarc=[1,1,header.from=nuix.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Nln+7sk9xXYH4K8xNf+fmqVUDORqHG9Da8Yeb6GDU=;
 b=1mrptxOe4bR9jri8Ux7RaJ3Z1TfcA+8s/Cql/+UA/EgOF9JdKNN31TG+SEPCF1mQbfI7JmRCAUgNIBUmufmLlsFqgUWQsN5nczTuL8JEVIjnsGRPRWWlQ4m/V88HHz8NyIEUXe21Xn5XxM/b5JonXDFjEcmcUyOlluI+jQ9KYk4=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by BN0PR10MB4949.namprd10.prod.outlook.com (2603:10b6:408:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 00:19:25 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::84) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 00:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.98.2.159)
 smtp.mailfrom=nuix.com; dkim=pass (signature was verified)
 header.d=Nuix.com;dmarc=pass action=none header.from=nuix.com;
Received-SPF: Pass (protection.outlook.com: domain of nuix.com designates
 20.98.2.159 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.98.2.159; helo=us1-emailsignatures-cloud.codetwo.com; pr=C
Received: from us1-emailsignatures-cloud.codetwo.com (20.98.2.159) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 00:19:25 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169) by us1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 16 Jan 2024 00:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMOKZlI8wgBKuNLxcUQRtMmAyAgsvKZDgMjnlglgKDhVsx5Qbxyggpi6IhRTBZcWA0PI2+Dqb2zE83aiEDlA5nl28xFDORd1bZnrImJC5OZfVlT7RsWfZG3VWAmY3Yzdpi1HjLbFDH2T6QF7cyBvszoK7s9TfWQSQh+UwgpVzz2x8Bt+EFVZxIaxMJ3+LOGmsPqhMoJtGK79T2HehFaWPYHzAIlKzu9UKRmmO0txHYlFDRgxri8xMzI3zW1VJLMZ+W0UxxYv9QmIZXXzURxlDgMmuq9bLlIXoyoB9XD13wVpuJEpothSr9JACkd2rR5kSlcQ9Wxtiw16qUyHG+JdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4Nln+7sk9xXYH4K8xNf+fmqVUDORqHG9Da8Yeb6GDU=;
 b=Y3/CQmMDvVKG8EftoWBjklYCxrpXuB6PMFwuea02DxpazH1mEUFF/zoKjCunqRVE4oBCF7b4j5TdkQORWUCI0X38UFs+4J6LOTU154BMH81IuiNdMfbx+YRL7EQY3ON0j3t7Ci801Q3kXnab1ZTMmESsmyQrTpQOTEtB/sTUCGmmYEJzaxle0v5lm34DQREHTVyIWDXoCqYplAfA6kjbdvneNOIgJcN8Ydr7nCg2l3mXo3HSyymp35H7SAwi7gcaOzQkJ9nDmDi6NdpJl/+VB1lIWaw1um19QIYZ4LMMWmZBNqRsPOlQK9dxGb1S/ASsIHTlh2zSaxN5fkjz2qN6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuix.com; dmarc=pass action=none header.from=nuix.com;
 dkim=pass header.d=nuix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Nln+7sk9xXYH4K8xNf+fmqVUDORqHG9Da8Yeb6GDU=;
 b=1mrptxOe4bR9jri8Ux7RaJ3Z1TfcA+8s/Cql/+UA/EgOF9JdKNN31TG+SEPCF1mQbfI7JmRCAUgNIBUmufmLlsFqgUWQsN5nczTuL8JEVIjnsGRPRWWlQ4m/V88HHz8NyIEUXe21Xn5XxM/b5JonXDFjEcmcUyOlluI+jQ9KYk4=
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 00:19:21 +0000
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6]) by SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 00:19:20 +0000
From: Michael Litwak <michael.litwak@nuix.com>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	=?iso-8859-1?Q?Matthias_A=DFhauer?= <mha1993@live.de>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Thread-Topic: Suggested clarification for .gitattributes reference
 documentation
Thread-Index: AQHaSBGmyx7DLt3fi02CwA/riMROEw==
Date: Tue, 16 Jan 2024 00:19:20 +0000
Message-ID: <SJ0PR10MB5693A19B0B66F47B2A985739FA732@SJ0PR10MB5693.namprd10.prod.outlook.com>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
 <SJ0PR10MB56937175632E5D82793CE13EFA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <SJ0PR10MB56932ABBEEEC6F8ADE23995AFA6E2@SJ0PR10MB5693.namprd10.prod.outlook.com>
 <20240113074323.GA6819@tb-raspi4>
In-Reply-To: <20240113074323.GA6819@tb-raspi4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuix.com;
x-ms-traffictypediagnostic:
	SJ0PR10MB5693:EE_|CO1PR10MB4609:EE_|CY4PEPF0000EE34:EE_|BN0PR10MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: c920ee33-8808-4851-0356-08dc1628cbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 EidMeLTlHtfRVc56DNsVN2mq8y7FbSKMizVRGBLjk+9MXoPeZwe8Cc6BIy6vWPPMIvTZBm4Ey8pVzBcA7tJ5y12UHi6WQcm31HVr1ZuZ/dO1Srl3Ez9MUAIlfDoPc6E5gtFRz8leVpcVUIF7290bauyQPb6psavrEkcLauLut/vVQnT8q4RBp8W0TRd8UN2TpZq3+TmNyg8hcXx1stNljico09AHIGzIXBLraJsYQBemWarIGm5XmFR3rfPBoNjv4vJ+Vtn4xsJpY0+mkEUoiXfRJE4YnfBS26Mu5Ari6X9Ex3PrGMvkyJsSC+I5KF8UPrZMsQSR5VOJN40k6d9SsBZuA482HIiGSmVf7sgvQSdbHOYXTAviz/FFmyZxu9WweiL6Hh38ZLod7yVQ4rWFoMQt5QG1n640FbkaKS0aIVGI8AokR1Iutp6XHjfYR/docR+gmdMxrX7PDQOPykXLP9PSYDJGCEb74J6jgWj0p2aizbEOjCqH242JYyF8St4mx5haJdeOG4tMwDkMirn7UMpsWGvooY9Y1qCbekWiyMcmP5XEfmyQCcM2Bkixe6V+BjSao3myBWAVPM9lwi2bav+CsISO0m5R6kKGupWXeHkQWZnWqcd3vuuv/T8NqJKxCOAw+VNT8SyM6RL6QSdHm5oyJ8KXZgCXcCipDSkHilGn1eGknygoLzoKaf/8aLcA/W5ElAAdWVazKUj0NZiThngtpUkP+HcvFFv1Ee+T1CBAqz3wX0ff3aoSDFdXZTvQ
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5693.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39850400004)(230173577357003)(230273577357003)(230473577357003)(230373577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66556008)(55016003)(66899024)(41300700001)(478600001)(2906002)(5660300002)(8676002)(4326008)(44832011)(52536014)(8936002)(66946007)(64756008)(316002)(110136005)(66476007)(54906003)(66446008)(38070700009)(76116006)(86362001)(66574015)(966005)(38100700002)(122000001)(83380400001)(33656002)(53546011)(7696005)(71200400001)(6506007)(26005)(9686003)(142923001)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-CodeTwo-MessageID: 1b5a0be3-53d0-4597-a7f6-3e69d5206e35.20240116001924@us1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e88a12db-0650-4f64-c0e6-08dc1628c8e3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QxWq46YAAy11JEMOOxiv8Gpp7M84uBJQwmGTXcTNlkXTMa8V5xwx8rCOJ7xb9u2i9bRZ8pO8n1S2MWAqDMVzjPP/5rDRQFb2DCI9qvHNO2CZVE7fBED78SVK/UK4Iejl1/4Lswno1LgK8aj0s6KwtF9eOQd0BcIMnr+/xSeyUEJqadja6TtSFOSIm7eFNBpgKgoJEDIkWt/5dUJSm/+OcLpFmii/4nsiT8ii+blYrOXA4RzvOt7ePtRBlD+QsNdBXWX/F5e+uat9X7Xw6IZPvjbMONOQhbw9BQhpXhun4pc1ivXMPRypPOdzedFQXOUdWN5enndnsZ5WZrJtjhPm2YLpuDqPSzqSfc76Jld567S8MR9q+Jq1GznhTHqrfSnSWdvBIOyLWRr7lUjDaylcIhjghnHyQ7fC/R9xt7kPwMH8/ihI0WFeiaqcl6AEJ/V/yfVMGRLvNVRYbvxVRYb4zE6wZLu3X6sG08kZdVOiL9LPKZ5LBandVx2CBnbEYESOzivGr/JmPn8+CbCYjFaICAE/00PFnw0c21KZBoH38nsRZltQfE7SbzDt7kJf2KM9zgih6QU/av/Nbx2rkKViFneJgvKA4/qvwHq5N2+ALWxDwQ7OV7qd22/xXeWdJCTeWfTjV84nUQWwtDca9854tfZIKufC4WWxfSDnZLEz7Nlkx3G4Vt05aDyThTcebjDWVV2tPXu1LeOyCwCyRY44UckJwHQiqtw/yDtMSNVSb3x/Sb2NiVtRVCYBfn5mNloY6XEMgnGWp9l1Da2s4N0NZFm/wHNMbuHVv2gYXr0Z9Gs22Ua+XJTMvb+Fr9HH05BkSCAmWVQENm7eKmINgXOkmA==
X-Forefront-Antispam-Report:
	CIP:20.98.2.159;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:us1-emailsignatures-cloud.codetwo.com;PTR:us1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(346002)(136003)(376002)(230473577357003)(230373577357003)(230173577357003)(230273577357003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(6506007)(7696005)(53546011)(9686003)(966005)(32650700002)(478600001)(36860700001)(66574015)(336012)(26005)(83380400001)(41300700001)(2906002)(66899024)(5660300002)(54906003)(110136005)(70206006)(70586007)(316002)(44832011)(52536014)(8676002)(8936002)(40480700001)(356005)(7636003)(7596003)(86362001)(33656002)(55016003)(4326008)(82740400003)(142923001)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: Nuix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 00:19:25.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c920ee33-8808-4851-0356-08dc1628cbaa
X-MS-Exchange-CrossTenant-Id: a00035bc-d628-4788-97c4-bbfbf70f3e7a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a00035bc-d628-4788-97c4-bbfbf70f3e7a;Ip=[20.98.2.159];Helo=[us1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4949

> To my knowledge the binary iconv.exe (or just iconv under non-Windows) is=
 never called from Git itself.

> I can't find a single instance of Git for Windows calling iconv.exe inste=
ad of using the corresponding library functions.

Thank you for your responses.  I think you are both right.  Git must instea=
d call methods in libiconv-2.dll to do encoding conversions.

I have no idea why my Windows 10 PC could add a UTF-16LE with BOM file, but=
 then fail to later successfully "decode" it, when running Git from an ordi=
nary Command Prompt (cmd.exe).  I assume this failure was a fluke, since I =
cannot replicate the failure on my other (Windows 11) PC.  So I am withdraw=
ing my concerns about:

1) Git for Windows failing to support UTF-16LE with BOM.
2) Git for Windows installer being misleading in its "recommended" PATH mod=
ification option.

As for documentation clarifications for the .gitattributes manpage at https=
://git-scm.com/docs/gitattributes, I still suggest adding an explicit examp=
le for UTF-16LE with BOM, and/or adding a table listing which working-tree-=
encoding value to use for each of the following UTF-16 text encodings:

ENCODING              'working-tree-encoding' VALUE
-------------------   -----------------------------
UTF-16LE with BOM     UTF-16LE-BOM
UTF-16BE with BOM     UTF-16
UTF-16LE no BOM       UTF-16LE
UTF-16BE no BOM       UTF-16BE

Why bother clarifying the documentation?  Because These UTF-16 encodings ar=
e commonly found on Windows systems.  Notepad supports the first two, and m=
any Visual Studio project wizards add various files using these encodings a=
s well.  Older versions of PowerShell saved new .ps1 scripts using UTF-16BE=
 with BOM as the default encoding.

Also, the current .gitattributes documentation makes frequent reference to =
"UTF-16" as an encoding but fails to be clear that the working-tree-encodin=
g value "UTF-16" is now only for UTF-16BE with BOM.  It would be easy to as=
sume that the working-tree-encoding value "UTF-16" meant any UTF-16 file wi=
th a BOM (either LE or BE), which was the original meaning of this value be=
fore UTF-16LE-BOM was added to Git.

Finally, I am not sure how to use git add --renormalize to correct a UTF-16=
 file that was previously added incorrectly (i.e. with a missing or incorre=
ct working-tree-encoding entry in .gitattributes).  The git add documentati=
on at https://git-scm.com/docs/git-add implies 'renormalize' resets only th=
e end-of-line values; however, I suspect it also re-converts text encoding =
when a working-tree-encoding property is set.  It would be helpful to know =
one way or the other.

- Michael Litwak

-----Original Message-----
From: Torsten B=F6gershausen <tboegi@web.de>=20
Sent: Friday, January 12, 2024 11:43 PM
To: Michael Litwak <michael.litwak@nuix.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>; git@vger.kernel.org
Subject: [EXTERNAL]Re: Suggested clarification for .gitattributes reference=
 documentation

[You don't often get email from tboegi@web.de. Learn why this is important =
at https://aka.ms/LearnAboutSenderIdentification ]

On Sat, Jan 13, 2024 at 02:56:27AM +0000, Michael Litwak wrote:
> I just installed Git for Windows 2.43.0 and noticed the installer offers =
three options for altering the PATH:
>
> 1) Run git from git bash only
>
> 2) Run git from git bash, cmd.exe and PowerShell (RECOMMENDED)
>
> 3) Run git from git bash, cmd.exe and PowerShell with optional utilities =
(warning: will override find, sort and other system utilities).
>
> It turns out iconv.exe is accessible from cmd.exe (Command Prompt) only w=
hen you take the third option.  But iconv.exe is NOT optional.  It is requi=
red for git to deal with UTF-16LE with BOM text conversions (and probably f=
or numerous other encoding conversions).

Plese wait a second - and thanks for bringing this up.
To my knowledge the binary iconv.exe (or just iconv under non-Windows) is n=
ever called from Git itself.
Git is using iconv_open() and friends, which are all inside a library, eith=
er the C-library "libc", or "libiconv"
(not 100% sure about the naming here)

iconv.exe is not needed in everyday life, or is it ?
If yes, when ?
iconv.exe is used when you run the test-suite, to verify what Git is doing.

Could you elaborate a little bit more,
when iconv.exe is missing, and what is happening, please ?

>
> But when PATH option #2 is chosen, and iconv.exe is unreachable from a Wi=
ndows Command Prompt, the git commands which call upon iconv.exe do NOT ind=
icate the error.  The call to iconv.exe fails silently.  It is only later a=
fter you commit, push and clone the repo again that you see the encoding fa=
ilures.
>
> And the warning about overriding find and sort must be taken with a grain=
 of salt, since the Windows versions of those programs are accessed via a W=
indows folder which appears earlier in the PATH.
>
> So this Git for Windows installer screen is misleading.  And perhaps icon=
v.exe should be relocated so it is accessible even when PATH option #2 is c=
hosen.  I intend to submit an issue on the Git for Windows issue tracker re=
garding this.  I'll also submit an issue about the lack of an error when ru=
nning 'git add' for a UTF-16LE with BOM file under PATH option #2.
>
> Thanks,
> - Michael
>
[]






CAUTION:This email originated from outside of Nuix. Do not click links or o=
pen attachments unless you recognise the sender and know the content is saf=
e.

