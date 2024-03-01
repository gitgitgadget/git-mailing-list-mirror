Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2D69943
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709277692; cv=fail; b=kwtBbYzpcxYJ0c0lTvLutXSleqwh/0vQsda0zh0fZ8L7NLujmswVeG4qtiVTtR6yFgWHD3B0OUd/Im06mIu3E3P2rAR1fVCLpkjthZxPm0kb4JQ2PAmhFlTPmX3IoNDrIhIEWfXz4qZN9Oekyyqiow/IdDmUbdq3Lc1mtAQkObI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709277692; c=relaxed/simple;
	bh=kQQwpJvQdDXaaIwdzW9TlILd/27zP4eCOl1s6H7QSNM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PZzl6Ix98wVjoN+kbu59zLFrbKGaOwKPzqmh9dyq8l5J98oLlDBYYbkxFRtS4+eRRBD7d/MAAfzkJ/UksBEcagt9huJoFsJGjk0xlWELnCGLxR3DN3b25pJNAOrE5b0Yj+D3QLHg8eLAmoiCUnRUqI6qQshrSwilpR3aHw9cYDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=pjQzswFD; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="pjQzswFD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNXiD7FHav3gE3dysvaIJm/vJ8+x98iD8FFtzVnudsosPJF//+0si1JrAd07nngk6TWfEcBcXE5kw8r2AtA2/mdI/x9WoLTb+yOwXUUDEozxz5MU2ohmeR1d1imAlf1sN8iVcbyrR278uChdFT2yvzgMKD2sfsilPLEU++RM4TKgX4vLqrmhWnESwn6Ra54HsZh58CjDsfZnvKzOnktvM/N+7pkUm23k6Dn3IMb69vOaAq263lUtdX/hsyoqsbHTpqULZuQ+ky7RbnLQN1SZ6vLZJQ7Aokta+rOhOl9SKtLyJZbIe/ZPYCJKTaikYhdE4TX6KkyFpyaCz41TX9jNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQQwpJvQdDXaaIwdzW9TlILd/27zP4eCOl1s6H7QSNM=;
 b=O59CBkAClKipLAY3+HgZQe1H42nbBkimZUoZLqqIQvPPd+uatJuYOnGT2dGwqWG8Ls4EWeYOvHs3E6RVfzncDzdSe9oiycRChhmbxDiBXiAguG+weUTFkGOMh5VPgIxPoAtYXLf0Hb+q06FXI1Kfs4NVqW9zJEjXZY+AsUuF9/tTDxFkYDYVtBHJJFeUMKhGAu3yvv/wV6DIXo/VXU0ZHnevgVXBTwaHNAiwVbFdUUxk9wvzIqakUxcesiCPXxxn3WYIyaANaqcQwoiU37yDl8e03dVrVI3d8h8mR3uFElpw0wowh0JnPDmYDoRjBwBeE8UOOi2uSB3I/c98ihxn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQQwpJvQdDXaaIwdzW9TlILd/27zP4eCOl1s6H7QSNM=;
 b=pjQzswFDVjEnp66vqxnqBV78pm1X+OvRwSURbatf410nG6jOiXJx+xnh98XAu+lUa7rZIHFQhRByphSYOsqVIK/KRr7fhGYGdOjYlkBrlkBm/dlj0buEGfhLRD3Tt7sj5aWlDujyNT6WeQeQEBwZXJPPQKPq68cW9hsFH0dQiQgMYs3i71R60qusVneS1xpuw9wdKE9NtR0D/GGW9q4Mrjdqg5qPfYrWCXtawQDooxXMkvcxXuzZDGvKZ5BebSLyeHRibOyO2UCUCB+hiwGWv//VLfl+L6TxwHqfLLXaBgmrJ8Bpvp90j/ABt3lB00Ugt3H8NBmlbw7BfkOaXwN/YQ==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by GV1PR02MB10863.eurprd02.prod.outlook.com (2603:10a6:150:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:21:23 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::90ba:855e:a753:79a5]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::90ba:855e:a753:79a5%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 07:21:23 +0000
From: "Baumann, Moritz" <moritz.baumann@sap.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Accuracy of "git blame -C" - are there configuration options?
Thread-Topic: Accuracy of "git blame -C" - are there configuration options?
Thread-Index: AQHaa6RWLJJUmHp20UCV7h4P5SYpFg==
Date: Fri, 1 Mar 2024 07:21:23 +0000
Message-ID:
 <AS1PR02MB81858FD5DDD15551754AEA74945E2@AS1PR02MB8185.eurprd02.prod.outlook.com>
Accept-Language: en-US, en-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|GV1PR02MB10863:EE_
x-ms-office365-filtering-correlation-id: 238e37ff-6307-4319-7e05-08dc39c0335e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WLG1O/RgTA0b+Q22i0CJJLumbx6y+j+eWCYErfeLvbBaBSC2Gnnw4TdzqrKYNqAau9EVaeOhqDIi+9IGbjZw/oqXT54gvjaULaypY/CNmHgEVtHKZYWPr8K+lDAV0Y3Ftij9mRvDNFNirSzKIH6P7n4DH1suIWbCvbtpw/yP8PaLLCun0MYP9TDJHwGZHK6eA0xJd0OxDTFC/OVw6ZCDDP3G7Xy7hvUbTUOwrmJIzRa5IhOSs24AE9YOuLgPXF182zkTWfZT+VeYNwOUlC4IZK5lqoq608GqDoNKKHm5bfKmgmAjrcoDuJTCUE4UaRrQfANqzIsV4ohF9JnRZesER5nUpnwMxT9lEi7lhlKzgKKAbrOdF5nsmxFrobqBXrulyrJjKuwvYelWC5yXwFRYRjGPKj/hvNWMzfFhXyiwhpg3PCc0Fc0qgX46U00TN/4b/tknEzhRIIWLc8nmiK3MFfaz7XuBlGDpZF7u6rfUhDwz8ukDr4Y4pWZB/M6bZJXQwq7AOPDq09m5tyA8QuySwpHD09Rxn0YGbTZMQO9xfBr5eCxeGJn2FPAOfpEILB4Q6E45KPmSRCWLNyFsoQuUSNC/wj/xDLXONjXotNEXqTlOFMMTy9SAO1La4ZeHvULjBNjrgvvhDZeUW6QOQDo8coRktGL87+1kbOHqJgTcjfc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jK+jULwRvSqiDQ9V++tEiBBXnV3Zn7oOmLyInHyGpvcdIkg1hTUlpbu0H4?=
 =?iso-8859-1?Q?EeK0a9K4r4w9bvAQZQiTyq9JnuBCi6RZt02renql417LA/8q7TQ91feLdu?=
 =?iso-8859-1?Q?06LOu79cuLbPmH6pNHZSoi1aDW9A/mFG5emUMlxSvewYuGLTGlvVf9vRfs?=
 =?iso-8859-1?Q?+IO3LeJQmaxWlja6rlWVG41KhlO7wseed+oJW1w9eclHc0GVNs7lmvGgW+?=
 =?iso-8859-1?Q?9V3A5PeTPxtx0SnFHu5PGW5A77Nnoec2mJ0g2fyStmvSGwhMdTl/qNLeqP?=
 =?iso-8859-1?Q?4gkoOvx4DjGEZOwIdrALrwEO+h3Qhh10IGg2nPfjDM4xPtk9rAnZ/6BNIw?=
 =?iso-8859-1?Q?iWP+VgaIokHBfrogUWzq0QPTNGXvUeGK8aea26hNMnX4ZA8Yqo6yJoqyTy?=
 =?iso-8859-1?Q?nKEUYuBh73W9FST47iG134LpNCmskx572pjskj749ZZznAu+fgmh3/Ashe?=
 =?iso-8859-1?Q?gUHT7z7olrUZtd8ohv/zLMEBkKl1fE90DG/RVj58oY+1MruPnn2UmhJF3B?=
 =?iso-8859-1?Q?nH0i56ouz50o6GfrZPhHsfHLT3Csx2w0c/tO0MT/lxo1O3AgHcS075Guva?=
 =?iso-8859-1?Q?3dp0r9nwzAzWxW9W1TDtUg67eGFdf3pwOlH11i3UhDHuWhP5+/39rVgYIc?=
 =?iso-8859-1?Q?fd01YW/nHqdBaEfn8+dGvnNgVxNTzvqHVTbipYXIExUDpqViyT9escIV3U?=
 =?iso-8859-1?Q?1wkrINkpayrRhF/neP5CYBfYzXKRFYts0C4l8jEu8BmP061UN86naeiovt?=
 =?iso-8859-1?Q?gHbF59pV5pv+pjFoeTaZU6H/BEjtEtbo6S3SpvJLLz/9GEDzfbQaG9/42G?=
 =?iso-8859-1?Q?X1BPmtZlYGb8/pkVG5z83KFfMOHe6VDL1QS4SEpbeMaTxOWJ33AbTFXtIp?=
 =?iso-8859-1?Q?rCl4YifmtHS44Prf5UvIR82qHFG4bvGe0HzVvhSjIbb/uzhCeDFcuyzKMi?=
 =?iso-8859-1?Q?Epj+pU6pfyHIj6CGICeOvO6+DPS4WSiumuG4Y5LYOdLCivDefUu9KNsfIv?=
 =?iso-8859-1?Q?RksRsB5v4vGZJBHGIYZY/ThP47PMuRlC78cRF0mkgZpH26n5RERy5hTAyz?=
 =?iso-8859-1?Q?isNY+xeGQnesTYpb+ZBn6bh1ohI9I1K8gy/4b76ldJvBbx/1/iNQ5+Q5gE?=
 =?iso-8859-1?Q?qYGULGL/Bz0jdH4b5EeMOqMwvm0PHCBQlVeX3cJ+CV3ny8FrhOeXucNsP2?=
 =?iso-8859-1?Q?Pigg5I6weLF0nnp3JA41Fn+C16hyThOZ0JUs46phG5Xh0ViTEkEKSa1pEi?=
 =?iso-8859-1?Q?MMsO9Qh8Lvc16dFTZB9bNg4rcLSsujqklLrgi+1+DWv5g9rkJLihuJi/hk?=
 =?iso-8859-1?Q?B9IR1w4mwaaxp139zV++vkPwwxex4cdge9HpcCYZ+ayPNFYpSirmlqcWIY?=
 =?iso-8859-1?Q?LAOOpJPdq51oa1O9wWp5a/Z0UHZIr0aB1y3vtyh5J3J9qtuM/YJnGZ/OUI?=
 =?iso-8859-1?Q?0LMJOmWsRpU0359/GbL8lfjL/SrT1SiGOgcQMxiyGJcE5TwHwml1jRSO/b?=
 =?iso-8859-1?Q?poSGd8eoIkhF4o570C0ZeFAfcIccJGh5G5+4MiT3Va7hlj18opgphAJ8AP?=
 =?iso-8859-1?Q?Ard4g6gGoH29J4uZzWGfC8Xm2t/4Q3PYnGURYbYvHoLbvNRKUz5dMCFNWe?=
 =?iso-8859-1?Q?gqJSQ/m12+HAMqEvCELLsDDQ9VAhVs8a6H?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238e37ff-6307-4319-7e05-08dc39c0335e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:21:23.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE2lt4fMDavrR80lbHQzB3HwmaJzpdGIIl1dR780WOlDfP6b0tKZBhS5AzcQUmjVtUG5Zh751Zy3dEmsRIztZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10863

Hi,=0A=
=0A=
A colleague recently experimented with "git blame -C" and noticed that=0A=
the accuracy with which git detects lines moved from other files varies=0A=
a lot depending on the sizes of the files involved.=0A=
=0A=
Example repository: https://github.com/Boddlnagg/git-blame-problem=0A=
=0A=
The latest commit on all branches moves some lines from Decl.cpp to=0A=
line 93 of DeclBase.cpp. "git blame -C" doesn't detect this on main, but=0A=
on the "works-as-expected" branch, in which the size of Decl.cpp was=0A=
artificially reduced, it does.=0A=
=0A=
Further experiments show that the following work as well:=0A=
git blame -L 93,95 -C main -- DeclBase.cpp=0A=
git blame -L 80,108 -C main -- DeclBase.cpp=0A=
=0A=
However, with a sufficiently large range, it stops working again:=0A=
git blame -L 80,109 -C main -- DeclBase.cpp=0A=
=0A=
How does the pickaxe search of git blame work under the hood? Are there=0A=
any configuration options I can use if I want to trade performance for=0A=
accuracy?=0A=
=0A=
Best regards,=0A=
Moritz Baumann=
