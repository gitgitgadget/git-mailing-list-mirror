Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2120.outbound.protection.outlook.com [40.107.102.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37533168B9
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuix.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nuix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="afW0/V1t";
	dkim=pass (1024-bit key) header.d=Nuix.com header.i=@Nuix.com header.b="afW0/V1t"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DTuCKogBmRMKaecOu2wpBWUxXnGFlGl7FUAdSaZc7zoUNcNflT/3WTjliTQ5qqZY6njATdOCYNkXc0ZjcaZ+RqI0RAlN9jTaifmCtTdPBx5LLMo9FB+oorO9MhzjyhAd4ECGjCVvh72MM2Du1bBPFEBFYR51goAgLScm3cVHmP8m/l1a0R2Vupizz8rZxQ/WNc1WOFwU78sW3+iVIPgvrlHVE1laaKz7J27Kfb9Er776aMI0N5/k339BjnOaOUEff5/SEKqPMeZFaHmbkIty0E2apZZqI6XTMMSn8fFlPIaJd1BAmKcGiOXNB0KFVSUnzwCrIqBfOBX8L0ZcFwrSlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/32tLdP/LuiVBLzysL4vnbXlXHcAEBxR9OnkQpEcrY=;
 b=d2blRE8AUhG2i9QpvlBUvlCLShT2AHqxSWgIOG/p9Fg+aeANGKb/kUE+edvlmqSlOi5AVT6ztVMiN1WflgFAAhr8o6dvWaUbyW6Pt++NGounzBA96rULwk6US/KGfhVFf3ReGfANTyN6VDY/X5POpbcjnAqTk7LyaVQe2RahBoP7XNj0AWbtgm+FcbE/Jitk25nJxgrmvIVKXR+HMqtWkGfCN9C0fflmafN7aUGE4Yppvetos8mccP3bEqrYZJUjrjFaAaKLQkJWG7pn7KmPkJ9vNa9YoqQLGMGjikPGNRZdG9W17HMEObHqog8EZegz/AJndrZ5ZRrhB30Jpkfp+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.98.2.159) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nuix.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuix.com; dkim=pass (signature was verified) header.d=nuix.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=nuix.com]
 dkim=[1,1,header.d=nuix.com] dmarc=[1,1,header.from=nuix.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/32tLdP/LuiVBLzysL4vnbXlXHcAEBxR9OnkQpEcrY=;
 b=afW0/V1tbr69Z/NFGYJ8vcPItPC+Q56NHeuOSxgCkrqn3QM2PYnAG7AFHjGWS147bQTR9Uo1OD/CFe1MfMQSFi42DSv/fy5AT2YXGBjbn2PF6+tL/5VZaVo1L7fjSxxdmJgSc8jh7LIRUQj0jBEmsKDZB+3O1lCWlVSwKQ+tvAQ=
Received: from MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12)
 by IA0PR10MB7302.namprd10.prod.outlook.com (2603:10b6:208:407::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 21:25:23 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::99) by MN2PR11CA0007.outlook.office365.com
 (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21 via Frontend
 Transport; Fri, 12 Jan 2024 21:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.98.2.159)
 smtp.mailfrom=nuix.com; dkim=pass (signature was verified)
 header.d=Nuix.com;dmarc=pass action=none header.from=nuix.com;
Received-SPF: Pass (protection.outlook.com: domain of nuix.com designates
 20.98.2.159 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.98.2.159; helo=us1-emailsignatures-cloud.codetwo.com; pr=C
Received: from us1-emailsignatures-cloud.codetwo.com (20.98.2.159) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 21:25:23 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168) by us1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 12 Jan 2024 21:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9y+bqt6bk1rG4Wd1jIJH0Su/Mx2//xHUHWY9fI+EfhOHtJOpVVVSnuDOJM0+W1gZ+Jh1ZH8uo0hQTz2CKW+L/Jj4Cq4NYlXYrtoLSiTUDwYbQITyzIBnxLFOgA6cHdlxMT5ZBJWagh7Y+hQyDHZw/0u1ZGaPzcbZi9JJiTOGrHzzfacB3ynlLL9FLnE1zzV5vcPgY7cbURqdvjyHfnUa13R1MGhad4GW/aAj/zANxs2RZEq1YjT1eTE3BYdKGA8qXCnbV92Vwd8d0lKD9DizC8dtMt6iDtlu47RgkuRhb/FImh6PDnFHbvHVozQizz3vGEGktw6T4OYWXYZvLXmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/32tLdP/LuiVBLzysL4vnbXlXHcAEBxR9OnkQpEcrY=;
 b=M/BlBMJZKdXpYekW3Kme9NwvevGdt2Irmen0+cQ13i1pqeP+10QotaKUoPOrb3PJcNPYTtluhxC+r9vMugAiQ2r9+euvpLLCpJYJCWE666yjzkzgWG056a9bsS0w1SkrD0wUPysGiBQUzroKNLiJsBxE9RW2aQ7L2DAUkUeFyl4olJVn8SOQ0v25Xvvd8nk0DSvHU77EISWbj3dbLXozOz3B0faySgOA4mLuNF6OkvCbMS7CI7kqajBEeFdj3rCJj3qQJWHO9AMLTseFVI7lkq+QkrNcmR9ZOQ4oXLrUuEl0pOaB1gskIVAXuCX6StN4emH+7VCfDwQ9yaHrV6FjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuix.com; dmarc=pass action=none header.from=nuix.com;
 dkim=pass header.d=nuix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nuix.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/32tLdP/LuiVBLzysL4vnbXlXHcAEBxR9OnkQpEcrY=;
 b=afW0/V1tbr69Z/NFGYJ8vcPItPC+Q56NHeuOSxgCkrqn3QM2PYnAG7AFHjGWS147bQTR9Uo1OD/CFe1MfMQSFi42DSv/fy5AT2YXGBjbn2PF6+tL/5VZaVo1L7fjSxxdmJgSc8jh7LIRUQj0jBEmsKDZB+3O1lCWlVSwKQ+tvAQ=
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 21:25:19 +0000
Received: from SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6]) by SJ0PR10MB5693.namprd10.prod.outlook.com
 ([fe80::3be3:df38:712f:e6d6%6]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 21:25:19 +0000
From: Michael Litwak <michael.litwak@nuix.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Suggested clarification for .gitattributes reference documentation
Thread-Topic: Suggested clarification for .gitattributes reference
 documentation
Thread-Index: AdpFmK9hLe1OgqvXQoCBJ88rxjQx3g==
Date: Fri, 12 Jan 2024 21:25:19 +0000
Message-ID: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuix.com;
x-ms-traffictypediagnostic:
	SJ0PR10MB5693:EE_|SN7PR10MB7004:EE_|BL6PEPF0001AB75:EE_|IA0PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: a1525e69-6a66-41ea-d6a0-08dc13b4fcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 jsBoDLVGZzMkqq0JYrM9RXBjpWAcLdN9g1cbkL3hCKB2fwmYUwuD1JZmBcLLElLr8GOOJWdaSgdhI7iwHe8t/hzugwME39RQB1iSVQxvsWEgYU/Eah5M2RUh44CwxqD7uvKJ47bABGEeL1n3k9ifK9H1Wga0GBI2T+GfSeBVKIGnlioWp/BPlOwEqIlnf5BTbVMMeND4HuCTsE8Swdd1mfH2XPZ6iVumayM5BH+rVKAPde7BhsABBcT0DmDFv4KuZglih/XzlNnhntcMOZn5pQ648jlKvYUcWHKMrK62pfgmNFcH4q5IJiGQrRtC4rqHooeXRhBuVSYWbqIL+inoKBiFiAAwHtzIMjB5WUiW0mScRjF055NZnO/mzaJZ07NqZv9RYHntQmxbIpZ2W5k0lxHE1BQfSG94BTj8n7WwsqYFEc5Rk2S5vU5ZeT3hnWuwMS5oz18CFwvH5qDd9V0YUDInUR78RNo/TDPfv/8VC71oSvCFMSrD+fro86qdHyGd9vzhne/p/AvSADgnm7VeSRSo/ZsFdgrBDEzKzEdY7h2mz5X099syzxYLkThnH2dodZsktsqP/Lb5nrJjO+OD5W9wgXZRTZzr0T8FG+EDXYPSTesNTpidZ3aVeUP2g6ni/XO6bSZcroA6YteYurfeT3X/De2sd04jq5lFEHnU4iI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5693.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38070700009)(55016003)(66899024)(83380400001)(41300700001)(76116006)(122000001)(86362001)(33656002)(38100700002)(66946007)(9686003)(966005)(66476007)(26005)(316002)(66446008)(66556008)(6506007)(7696005)(8936002)(6916009)(2906002)(71200400001)(64756008)(478600001)(5660300002)(52536014)(44832011)(8676002)(142923001)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-CodeTwo-MessageID: 73f59a3e-9909-45e9-81ff-b237a9a69083.20240112212522@us1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fcbaa9e2-b191-431b-4574-08dc13b4fa19
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a83JNHx3RNf7HZf4VPTi1YF1MfVoq2Tta+uAuXTLUnIAP5qsxRLkpwzxNKLop5hzPc8hgGpTQfq2DPWJWce8GV5HWNuArA7Kfvuemh57mqT7lGjIqeOleFKEfSrHXHDS5IFWhnK0v6D9M/G9hN/bAAPmSZXXlyIsVnwWEXHGC/qoDcHBIzwHynM3awfxnZdOfiWONPzP6YYtl4qaVgoWjSH22XY0+f8l7/LgYqMAzX8xz7IxU5W2QP+vdgEGisdrg7kCYl+TOvIkhAKnkxk0uTsxArgppNotLDdVf6M+enXzBiUTcc1XXATelkSWaAx6cv58YCUqS9Diu0KiMOpjQsC4tbvO/uzBAo8S5UajlXS5hCPetbWAOmmVxf4aBIK+IwYMc6y5S09e9b0gM7fkZZRClwCNUiEuRLCZLhCeuw5r6bFQI5WcWsgRwT+3FJgKpTJkd5yQM0tND6y8zJyEWGArURZf8npMchtvTJ1uzuPYGqchUt5Js/oLNgA475T5RKv98FBVuHSdB2HkaxrCRxj1CuKBd0DL5YCC0KI1X445VGM4a3phIv6EkHgc+J+ok2Ti4DhcYFsTHOESSRxV0qoNoz+plA5lJmysB1SyD0SrTPTvAgECJGxfud23yTkpmLkX3krjvKiJn12y04qmoMqrE3qCfCAxELmjz3Mv45yIPKwcVjuw7phi0IIxi1d/ZTg8tNUP49REFd5dNzo4iwwgYXbGefuxZ6r82uEazrIbgy1AOssN4f4YaNdDDNpN
X-Forefront-Antispam-Report:
	CIP:20.98.2.159;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:us1-emailsignatures-cloud.codetwo.com;PTR:us1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(46966006)(36840700001)(26005)(66899024)(336012)(33656002)(2906002)(83380400001)(9686003)(6506007)(7696005)(966005)(478600001)(8676002)(8936002)(55016003)(5660300002)(7636003)(356005)(7596003)(86362001)(82740400003)(70206006)(6916009)(316002)(47076005)(70586007)(52536014)(40480700001)(44832011)(36860700001)(41300700001)(142923001)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: Nuix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 21:25:23.2784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1525e69-6a66-41ea-d6a0-08dc13b4fcaf
X-MS-Exchange-CrossTenant-Id: a00035bc-d628-4788-97c4-bbfbf70f3e7a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a00035bc-d628-4788-97c4-bbfbf70f3e7a;Ip=[20.98.2.159];Helo=[us1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7302

The .gitattributes documentation should be clarified to ensure files encode=
d as UTF-16 are properly accounted for,
In particular for Windows users.

Specifically, within the working-tree encoding topic https://git-scm.com/do=
cs/gitattributes#_working_tree_encoding, I suggest the following edits:


NEW BULLETED PARAGRAPH UNDER THE HEADING "Please note that using the workin=
g-tree-encoding=20
attribute may have a number of pitfalls:"

    * Git for Windows is not able to access the iconv.exe text conversion p=
rogram from an ordinary
      Command Prompt.  Be sure to run 'git clone' or 'git add' from a git b=
ash console or a Git
      GUI.

OLD TEXT

    As an example, use the following attributes if your *.ps1 files are UTF=
-16 encoded with byte order mark (BOM)=20
    and you want Git to perform automatic line ending conversion based on y=
our platform.
   =20
    *.ps1       text working-tree-encoding=3DUTF-16
   =20
    Use the following attributes if your *.ps1 files are UTF-16 little endi=
an encoded without BOM
    and you want Git to use Windows line endings in the working directory (=
use UTF-16LE-BOM instead=20
    of UTF-16LE if you want UTF-16 little endian with BOM). Please note, it=
 is highly recommended=20
    to explicitly define the line endings with eol if the working-tree-enco=
ding attribute is used=20
    to avoid ambiguity.
   =20
    *.ps1      text working-tree-encoding=3DUTF-16LE eol=3DCRLF
   =20

NEW TEXT (SPECIFYING UTF-16BE EXPLICITLY IN THE FIRST EXAMPLE, AND WITH A N=
EW SEPARATE EXAMPLE FOR UTF-16LE WITH BOM)

    As an example, use the following attributes if your *.ps1 files are UTF=
-16 big endian encoded
    with byte order mark (BOM) and you want Git to perform automatic line e=
nding conversion
    based on your platform.
   =20
    *.ps1       text working-tree-encoding=3DUTF-16
   =20
    Use the following attributes if your *.ps1 files are UTF-16 little endi=
an encoded without BOM
    and you want Git to use Windows line endings in the working directory.
   =20
    *.ps1      text working-tree-encoding=3DUTF-16LE eol=3DCRLF
   =20
    Use the following attributes if your *.ps1 files are UTF-16 little endi=
an encoded with BOM
    and you want Git to use Windows line endings in the working directory.
   =20
    *.ps1      text working-tree-encoding=3DUTF-16LE-BOM eol=3DCRLF

    Please note, it is highly recommended to explicitly define the line end=
ings with eol=20
    if the working-tree-encoding attribute is used to avoid ambiguity.
   =20
    Please note, Git for Windows does not support UTF-16LE encoding when ru=
nning git
    commands from an ordinary Command Prompt.  Use a git bash console inste=
ad.


OLD TEXT:
   =20
    You can get a list of all available encodings on your platform with the=
 following command:
   =20
    iconv --list


NEW TEXT:
   =20
    You can get a list of all available encodings on your platform with the=
 following command:
   =20
    iconv --list
   =20
    For Git for Windows users the command, above, is only supported when ru=
nning in a 'git bash' console.


In the thread "help request: unable to merge UTF-16-LE "text" file" at  htt=
ps://lore.kernel.org/git/Yl8uiflurfjuLIvD@camp.crustytoothpaste.net/, Brian=
 m. Carlson,  Chris Torek and others describe tips for dealing with imprope=
r encoding, such as the following:

    if you have already checked the file in without an appropriate
    working-tree-encoding, you should run `git add --renormalize .` and the=
n
    commit.  You'll need to do that (or merge in a commit that does that) o=
n
    every branch you want to work with.

    > For that to work, it is likely that you'd need to convert not just
    > the tips of two branches getting merged, but also the merge base
    > commit, so that all three trees involved in the 3-way merge are in
    > the same text encoding.

    The old merge-recursive has `-X renormalize` that I believe would
    do this for you. (I see code in merge-ort for this as well, but have no
    handy means to test it myself.)

So a NEW SECTION describing ways to deal with improper text file encoding c=
ould be added under the
working-tree-encoding topic, specifically a description of what the followi=
ng two
commands can do to remedy improper encoding:

    git add --renormalize
    git merge-recursive -X renormalize


CONCLUSION:

Text files encoded with UTF-16LE with BOM are common in the Windows world, =
as some versions of Visual Studio will use this as the default encoding for=
 .rc or .mc files.  Solution files, project files and other Visual Studio f=
iles can also be in this format.  Other encodings are common, too, e.g. som=
e older versions of PowerShell defaulted to UTF-16BE with BOM for new .ps1 =
files. Yet users continue to experience encoding errors even when they are =
using the proper working-tree-encoding in their .gitattributes file.  Part =
of this is due to the complexity of Git and the number of different platfor=
ms it supports.

Ideally Git would automatically detect the most common UTF encodings and tr=
eat these files as diffable text files on all platforms -- without the need=
 for entries in .gitattributes.  And it would be great if Git for Windows c=
ould handle common UTF text encodings when executed in an ordinary Command =
Prompt.  Until then, clarifying and enhancing the documentation for .gitatt=
ributes could go a long way in making text encoding easier for Git users.  =
Thanks for considering these revisions.

- Michael

