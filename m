Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA41B010F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103324; cv=fail; b=WF90ImgK3vUke4ljhv0Ued8K5GfzJ725dH6kbXKcvmrEaqlFuT/hXibcE5MS+OtWlcyIxf3hiQU3+rwNqA04IMJHLgv4BbUtJvQAID+uxyqFNPmw1bwrlcocgMprm0lL2LKXQe4RRXOXjsqxEhb+ANeYp0+R+uGeomYpGumezzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103324; c=relaxed/simple;
	bh=hVnZTVxH5fC4rizZN7O/dTVq3IMgqx+u5xS7xfu24cM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ezB6uxE+1Q28raJ/zM32HLSkep5v1O41Ugsksy0KX7Eg/266GjM8Wj2Oh0XQKYKh9sGp1M3AUV2isfsZT4lcDAPfWe87PDw26Ef8xun5dxjy2WsaWjA6rV3EiNUhkOnxTEnb3jJ3sb28fJdAgRBogzs53m1q9eqq1gm+t23OTnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iongroup.com; spf=fail smtp.mailfrom=iongroup.com; dkim=pass (2048-bit key) header.d=iongroup.com header.i=@iongroup.com header.b=GA7TCmav; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iongroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iongroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iongroup.com header.i=@iongroup.com header.b="GA7TCmav"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4+tlFvCTGjB95HPd92O2GiKfOLZQrBD2CenudqKnAtcbdw4Vs4A2TpPkb7QBxoCh3ZYK1Yj41WiPZVX7lb6EHV5qZu97EdgYSFfD2EFi3Q9s9WBpsBoxx+oW14aC0g3yJn5yMAyy0qbDIS8qryHLnxPq9cpQc8CmeKDvUGw6lWVdkPw0N1vaO9FJJgavyvndf2/Pn07wV3/gsFbIx9iPO8zFoPOqLPvmm1lqnoWS+SXUDTYs5/nRsLMaLXND2YaaFDZg8dP+2VJRCkAsCiiIQM+U7m+YEOO3ZkBCxdQe+r+VYfpAPLAFb8xO3sR8DbbyLFtYE0eHX9T54tByDRhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHIVStjDnaPmz8mVVHOQxEFV0W8sTEnByH930graZLc=;
 b=e8fMvIOMxH+LYSBQFv1TjuIsjl7Qe7AkkeXECkI8kpcsAwpjJCpHj8ptlsFmKySmFB27JVZvPkCubutSOx0S3HAzycxmG7RbJBISLHKYSC6GpRnt7M10ipf3Kdwr3XJETSM+3Dqr7IU8KR7inPkLZZbIHZah+pf7kZxnRv1yXMErSuDawFerxl9ULGlLd4aR/9KRa1Xddzaz8usko1OmA7OJJ2n+Z0aL6sUcZOhBtf7OY9muXHx+NZ+Mp+bH7kSLISxML/CU6cHjHPOfCjz1bVfoDBqcZaZ++cubU0zDaYJO5t//ByKV181B7rt0odc8L1OzpsujEijW822xeoliPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iongroup.com; dmarc=pass action=none header.from=iongroup.com;
 dkim=pass header.d=iongroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iongroup.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHIVStjDnaPmz8mVVHOQxEFV0W8sTEnByH930graZLc=;
 b=GA7TCmavz+dqTp+9hIBdswGJLGPH0izILQK85Y4jl8H46Z3WCbClvAsUpHPjwJr9b7p3K03HKllRP1HrAjsmOF68CO5tbr4tKKDB9ls+ZmNxEyX97G7hwFdXDmdU1MAR9YwO+sdNVrdp/2Bdd0YYI0yhwUz6hJxiJ9oUUk4FJHbos/WWNrnyGP2X0t2SJOfkr6vnXBC0CRTZurHm+Z9Aruf2Ihxz89gEa4yp4FCnRh3KgIDV9Dxy390NtezmKp1eswFiPOk+12OoF18dK69ovy94F7S/JeSu47JdMBzgk9XZh6dNdpGIT24IurJXT5S4Z7e9Ds0vUyPDSrwXNz+l9g==
Received: from SA3PR14MB6519.namprd14.prod.outlook.com (2603:10b6:806:311::9)
 by BY5PR14MB3384.namprd14.prod.outlook.com (2603:10b6:a03:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 14:28:40 +0000
Received: from SA3PR14MB6519.namprd14.prod.outlook.com
 ([fe80::2e6b:e255:acca:ad8f]) by SA3PR14MB6519.namprd14.prod.outlook.com
 ([fe80::2e6b:e255:acca:ad8f%7]) with mapi id 15.20.7762.009; Thu, 4 Jul 2024
 14:28:40 +0000
From: Dmytro Ovdiienko <Dmytro.Ovdiienko@iongroup.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Losing the file during rebase
Thread-Topic: Losing the file during rebase
Thread-Index: AQHazh4oj9wn6X9DrEaBsgyvD643nw==
Date: Thu, 4 Jul 2024 14:28:40 +0000
Message-ID:
 <SA3PR14MB6519B74CA58C9AE49DC28513E7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iongroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR14MB6519:EE_|BY5PR14MB3384:EE_
x-ms-office365-filtering-correlation-id: e88c1064-598f-43a1-4021-08dc9c359985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/3Db+cBFxziuuEwq6UYmiKJASEBuSab5O7JJMb4NSbtpqOQVEjEa47/HnR?=
 =?iso-8859-1?Q?fSIzbTPTo4u37/PDo22D3VBF0yGN/GVpfHdX7p4iJpXaswCnTuwztsh3mB?=
 =?iso-8859-1?Q?5jZpubFONuZ3F/Z3oaePGjcsj+UMBA6DDv7OW9UCEzdk6xRNDHAVXYq3K4?=
 =?iso-8859-1?Q?ax8cCWX1CY7L+gZ60urocLYIudvm9ITCrKwaeGJxz8i02KrrZHdXkb80s2?=
 =?iso-8859-1?Q?F91hAaKMHEKU3EjL6qp3Q4sIiGleWIs7eDLi1Y3Jaw6Ypg9XKX4pyLjjb4?=
 =?iso-8859-1?Q?Vus4zSTfMhGp2JigA2XYOqMUEBzZEw66pMmK2dD2jIwoaF2M7pxguU1D9L?=
 =?iso-8859-1?Q?sn7MXPxEI3cqzX8A5QnjheIa666bZ7OJJ+VE6FyOFeVmOzaYCiB0d8dE2M?=
 =?iso-8859-1?Q?eAXN1/qkNShOX+nwnBov8B4p9QHaHyKLGBvCTolrhoE6Lw9GVMDQrzAvyf?=
 =?iso-8859-1?Q?/y9xjliTRTvOVgz32xbQeLwwgTMf6OJOows42fLJJd0+UF35WQH1cRg8OB?=
 =?iso-8859-1?Q?lwMZlOsVOi4R2LU1sa+nLpVPnh5nbAmFA/5gmcx2PdBR0yiwc5XkU8rSrN?=
 =?iso-8859-1?Q?eeZwO0z4ejhvuHJmBuA2IIed37GYaahWzRbpYeYT+MU+LnJyXfaFt+JKG6?=
 =?iso-8859-1?Q?mKVcXUZyWQ69t28V0m3JNGaZKCknxS+7sVa5HW6jXB4sEaxRfIW0lagRKL?=
 =?iso-8859-1?Q?/XGn51TqrYvxK4ss+/qDpzdaqztXNv1ezK6GLNlsSjCHZrEeNLVSkvB24o?=
 =?iso-8859-1?Q?2E/ziK4voc8qPwIa98Dm/8EwX6IT73TPW925QvQhkr0b/agAWicBM0BVix?=
 =?iso-8859-1?Q?wwEw5RVNHAY9YTn3X27fq2qN8X+GXHWyqogttmt+/R2z6LGIzOgJOGL9eu?=
 =?iso-8859-1?Q?xU4UFPkGpQf5pfrldVKosm8HuPOscelaENNKpnQLcczIVL7qiWylVhMjuu?=
 =?iso-8859-1?Q?6VUZmxmN/shjBR5Oi2ouMqxoZRMhebekVjgqdfOK0AtktrAMg5DePTnNzk?=
 =?iso-8859-1?Q?HjRIVCRCgh5GtYWBMFInY6PueJbMzPuUWx7Nq2DnyyI+RZWRkYF2Beh1HY?=
 =?iso-8859-1?Q?BiOQ11Ga6636Mef45uWDVOTEyammODONtHuZN4vP/nb8xJAUvgolVDz1kr?=
 =?iso-8859-1?Q?0FuKEr74KWnMJ23DaM3S92O1ZydgyyWcMVlTeRWFsfxeeG4f2CZbLBvrNB?=
 =?iso-8859-1?Q?F6Oy95Kj1ntrqgdcbvclI5CagU86FIBa/prraIvPmPyjknKrjcNpvQf3y5?=
 =?iso-8859-1?Q?HOsLBWV/3Fbrp/HT7fdj43SpNtcumHFkM8O1Js5zA0y9F3XKyhZtiisEqA?=
 =?iso-8859-1?Q?hku/bf1xujXKs4xlLqxco2HQwFmifnO5+FVit2V7D4M/gUA9cwtGeuxb4G?=
 =?iso-8859-1?Q?8BM9qYQIXOggCaAVi7LYR/uGsQZZeLXEwWN1esLHaxqD0pBJDHTsG/S/r2?=
 =?iso-8859-1?Q?Hz18yU+LfI8n1fQ8ZDltGqkn7NQFZon707gxVw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR14MB6519.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eeyT82F7orPli8lacQ7bTbJtJ1/E2iUi2S8s3ZXubhrTlxRYK6N/y3LRPQ?=
 =?iso-8859-1?Q?Qwr05506jXsHieB0yFGelBb5bXguyu1gHNfJH9Fk7WIp6aeLSOv+2l5ikS?=
 =?iso-8859-1?Q?hrDumh6LIy3PdBWeLGZYzng2uCz/qNL+w9IxC55KcLB/lsa0U8cbDYrF8l?=
 =?iso-8859-1?Q?9sE4F2DGJKVY8mvsVVFYsJzXv+CZtmHgDxgDG+Qejp6x23GqGUU1bMqzPk?=
 =?iso-8859-1?Q?RFgC6RmtQqPhqm900cEvXDpAc12y2sUJP4uVdPy79wn7fcFXu1lpVVTVk8?=
 =?iso-8859-1?Q?dUZr7GsfL1/pxY9LR5ZRDsaT3FjvpJcRjOt8YJcINQ6pWJ/qZWE7/PoMgK?=
 =?iso-8859-1?Q?w6bcw19/TMIsIYeFhiZKcvSQ9mD7fqtx3eozWBZD9cIyIxwcWAJMJ5trT/?=
 =?iso-8859-1?Q?W4EAQQjD8BV40iF0MNUpzNhgKGyyduzdojE0T9Ye/w9EcbBApJepzJ/jZI?=
 =?iso-8859-1?Q?Q+STG7r9jGXRdE1+NhaB8IoZGBuj5y+QmVV7UJ8MOt4L04ksr46H4y/Acu?=
 =?iso-8859-1?Q?Zpkl7lOjJFsRsEmmUdp3YF+mQQF3ja+zAMJaBH004OTr1XcDDCNGqJvHvr?=
 =?iso-8859-1?Q?zwv6g3mH392EvzMtUAaL6fQHI6EFEosDsLXa2L2BYi5TqbVPhv5X5HVd03?=
 =?iso-8859-1?Q?C+/ue2C+BuhhtHUkKgZ3/oIuRkDy+W93uUIbqfaJVE3tu4Pupq1PMnnf8x?=
 =?iso-8859-1?Q?C6F2LA7SM7p3m5qjmWYSu2Thr7ow1V2UZ/eszQSMBW1r66ffg5IWsVZILs?=
 =?iso-8859-1?Q?oMoZK22WrzQK0pLOJQ1lUbawga7VTmY3oHmAr5fClya/icr5ZXGSuu3ba3?=
 =?iso-8859-1?Q?ZPv65NqDBu/4Fv0OmGxXufRbfevQbdZFr5JhcRf0FvgiAeqreeMIM3nIKD?=
 =?iso-8859-1?Q?zOi0IGDL0x/C3bReKw9qYAch1QwKelGuyWCiafOCylF+ts73udau8zCyHz?=
 =?iso-8859-1?Q?20NzpEhOxj5INh2wQ0Fxuq8Hlorz1V6DrGKrISSXqA2opFP/cvRoBaMp+u?=
 =?iso-8859-1?Q?oVTj61Ylw02Yipev0J1Xua0MrN5+bxdLZSX+umm81wG1jBxSpCsfrtOkWG?=
 =?iso-8859-1?Q?JKpuk3WZR0jS56uidGLbBV/gHZINPnFjl7QKH0MJbXlIrixGjhNr92q63i?=
 =?iso-8859-1?Q?byLgaQ3NL4a/3X+5aV9y7ZHm+bKqGkf5cgd2+E9aQ3i+K7fcFFGvjYWYWO?=
 =?iso-8859-1?Q?AFyRSObNvabA96FusSnTCv5sYhzKZWQ4tFbYE2Wlbo0B98F+5UW9amho12?=
 =?iso-8859-1?Q?H5KVoma/qrbFMMoqIXgyd9uLZYcvp8Lsr/f6GMeyKyDRgfq6j7fOcVkCty?=
 =?iso-8859-1?Q?knj81GdiYT9t6o5nFaEM3HvpiJRgXVutcoyh0R7Z7ZnZ1BKMC/jJJ7juK9?=
 =?iso-8859-1?Q?fkexLsl5ntV5Z35bB7718l31rstXHzQOITBXJ4LDBeQ9QP4T0hlV6oNEC6?=
 =?iso-8859-1?Q?bFW9D7TBU35K2yHwaYuyNw0OoxKXKv/a9DDLqWRFL2NMm/RfwOH9n+jXRF?=
 =?iso-8859-1?Q?vlkDHf6cUcnOT3USjjBbMcFT1wgn+UemjgpWNN0hmtznAvlIhIxi6og029?=
 =?iso-8859-1?Q?7HUXdPn2UDoC2NUBuZJWeuB+cqtETR1CWCgsXqQh3JfTj3Tk+x05wvjw/K?=
 =?iso-8859-1?Q?zhpM2QrwaSQRQE3TKfL/t/ZsoJNvmiiYas?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iongroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR14MB6519.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88c1064-598f-43a1-4021-08dc9c359985
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:28:40.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 768fe7d4-ebee-41a7-9851-d5825ecdd396
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrgfHxc6T12kbt1qmTrP26QDKPi2C4cUCkw/WTVUqUmsijOP6jwe9VkBbopvsre6kKg9KC/RGTusiGWFPxcbflaenYBvrLChVCbLkrNGz/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3384

Hello,

I'd like to report an issue. I'm not sure if it is a bug. Git just behaves =
not in the way as I expected.

$ git --version
git version 2.34.1


The problem is that Git  is losing the file when I do rebase. Following are=
 the steps to reproduce the issue:

1. mkdir test
2. cd test
3. git init
4. touch 1.cpp
5. git add 1.cpp
6. git commit -m "Added 1.cpp"
7. touch 2.cpp
8. touch 3.cpp
9. git add 2.cpp 3.cpp
10. git commit -m "Added 2.cpp and 3.cpp"
11. git restore --source @~1 2.cpp
12. git add -u
13. git commit -m "Delete committed 2.cpp"
14. git revert @
15. git rebase -i @~3
16. Now in the opened editor
    a. move the last commit (revert commit) to the top of the commits list
    b. squash/embed  (by typing 'f') the "Delete comitted 2.cpp" commit int=
o the commit "Added 2.cpp and 3.cpp"
17. Save and exit
18. ls

The output is : 1.cpp 3.cpp
Expected: 1.cpp 2.cpp 3.cpp


In case if at the step #16 you first do 16b, then close the editor, then st=
art rebase again and do 16a, then all the files are on their places.


Kind regards
Dmytro Ovdiienko


Please access the attached hyperlink for an important electronic communicat=
ions disclaimer:https://dashfinancial.com/disclaimer<https://dashfinancial.=
com/disclaimer/>


