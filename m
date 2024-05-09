Received: from mx0a-002b1501.pphosted.com (mx0a-002b1501.pphosted.com [148.163.150.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EB1A2C10
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.209
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272243; cv=fail; b=GRriquyMXo00TgZEpX0ldvZCIobkrfS7Lu4VDyh4j+JVY7SnqJIaIIQ+yo5NBVu5RAy/D15Kmj5hybXahq4/2b46oFJUeVwPs2G7TiEQ9tXT+Mi0YfVzkllxE1xDiTHu9mlyLIqnx0VHMBvG5ljJWkj4PbAR9lVgGiQufhCRGB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272243; c=relaxed/simple;
	bh=uTAlsFqg+WGHQeZclGcfXOYaDkN3bbohJf/8vRKgsEg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hxiNCfPp37Pp95UfC/3kNlL0SIivOGfTeWSi7cXfbK2/AXXw0lQTtHPxa5SWi0Zeflm3JYiNbsbFhY7ZKPzylrUPr4erCYk1yaLtFDapxaevNDgoTgliapdih7+jORGiEs0OntMACZBwApYv5D9nCoUAGMISpmmvmJAR54VTLfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com; spf=pass smtp.mailfrom=epic.com; dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b=Rb1/b25N; dkim=pass (1024-bit key) header.d=epic1.onmicrosoft.com header.i=@epic1.onmicrosoft.com header.b=Olch7q6D; arc=fail smtp.client-ip=148.163.150.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epic.com header.i=@epic.com header.b="Rb1/b25N";
	dkim=pass (1024-bit key) header.d=epic1.onmicrosoft.com header.i=@epic1.onmicrosoft.com header.b="Olch7q6D"
Received: from pps.filterd (m0119674.ppops.net [127.0.0.1])
	by mx0a-002b1501.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449E6vs7021987
	for <git@vger.kernel.org>; Thu, 9 May 2024 10:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=dkim202106; bh=iP0GR0
	7DdtdMGyuvWSPQxqGfxlS0Z8ISyZ0EEH/pS7Y=; b=Rb1/b25NRD4T/pjsZaFwUr
	DKiLc7MmcUAsIHNWrq9fwvdkUeGKEx9xdZ7jOCQ2z9E5zvrUgj53CRjBmkGVVFLc
	OnmaCx9LanUNuXfZwXw7pl28ToZyc8IOF3lkw7ysg7JxALxpRr+Sc5K0Yw0n9/BT
	a9gADc3OkMQjWrP+R80S4aL5HIdQDdw4i7QNb/IlIacbSUCtMTkk0woq2oVNbJEA
	Zpa66WXuIYWHuaIlekINYYNVYMc3eZ/8wDGpkIjNvRCixavHmfdjMQfJ35UNb1bk
	QD241igKbvKMeBtIJLL0mo8V/8/sxCeT5nJfR8Yup18x/GQJ18WPx328F8NWv8JA
	==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-002b1501.pphosted.com (PPS) with ESMTPS id 3y0wc3rmre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 09 May 2024 10:45:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSPb5UsN86Pc+rflJpVS8MASFhG0pe2mIXoxVo1mev9YNAfp2Dtg0JDsfI+thRLqQge6Qug1Sbql4cRgD7h7AcAwl2PknOoAtAOeA+51OWfLa2yUmKjsZdzKvq/HXkPSiiN4/tX2O5KG6SxwioKeeVi/A7rhmXphNdu8F4r/sp2+q2UF3LN7ghov561ZUdxvmB0s3t/MH6AG6XLFQTcDypQn5zugJVGQFGlkrBOPP4UYe+tPwy4MOuoBj33X92E7oGmeMYq8rcQciOfDd8db6tSYOfxY5rrIBd1JrC5y1pbFFLRRwINSs26/Sc2r8kEOQdhMjtFz5gmNxn8Cy/TXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP0GR07DdtdMGyuvWSPQxqGfxlS0Z8ISyZ0EEH/pS7Y=;
 b=kEUzcas3z8vjBWBmbl5aSuOA8MGSDJ1RO+HNf7R+9jN5H2Jq43yzKf/UamI/qBB41mpmn3k5u+/rCjjPNmNBHRWwZJpT9w8MewSIIgpMw0stMuyJA/EanwA4731qRbdDehzOhAWZuKLhDc2v13OSc8itRgi28e1aks9OOSTrJliJ/0tDRP1XnyYUhNsBZXxzE2gDQlVCCjbhD5I4R39MB9NEss4ogit7SmUOMzRd7jkhHcLCMSmzNxetqZfd04PAmV7ZsS3NHYBGNsu3nARtbJkcLPxWJpMEJ/Eq3MEAqqPC6lx5N/fYGsul2GlJH+cr0p+pybYlq9kt8YJmgYuAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic1.onmicrosoft.com;
 s=selector2-epic1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP0GR07DdtdMGyuvWSPQxqGfxlS0Z8ISyZ0EEH/pS7Y=;
 b=Olch7q6Dmyi1rsYG4uJp+VSlHJj8sgD2TPAaGljgqdSTI/AnSAzm/CbYnWWB4XadPFoWZ3R5TKuL07AOkwIiC8VaA5O5vTZPbBP0VtMVW3yX1k+DyMxE1xsoTPQCS6Pkr2eFUQ/eh/pxhrZ06V0mxKt3MGc5GEdOoMHiOuHBsaI=
Received: from DM6PR17MB2156.namprd17.prod.outlook.com (2603:10b6:5:af::29) by
 DS7PR17MB7068.namprd17.prod.outlook.com (2603:10b6:8:e8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.46; Thu, 9 May 2024 15:45:47 +0000
Received: from DM6PR17MB2156.namprd17.prod.outlook.com
 ([fe80::cc65:c6a3:d614:ae26]) by DM6PR17MB2156.namprd17.prod.outlook.com
 ([fe80::cc65:c6a3:d614:ae26%6]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 15:45:47 +0000
From: Joni Lameter <jlameter@epic.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG REPORT] fsmonitor and core.untrackedCache combination causes
 inaccurate git status
Thread-Topic: [BUG REPORT] fsmonitor and core.untrackedCache combination
 causes inaccurate git status
Thread-Index: AdqiJ8SyNgb1asgGRQOGVfbRsdLCvA==
Date: Thu, 9 May 2024 15:45:47 +0000
Message-ID: 
 <DM6PR17MB215602138249E744ECFE4185A6E62@DM6PR17MB2156.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR17MB2156:EE_|DS7PR17MB7068:EE_
x-ms-office365-filtering-correlation-id: eaac7668-6fed-4d77-e217-08dc703f1891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?rIzx7Eky+Y1zwXipirteqL3g0GMyq42wlfN6HUeblX3zs0LTuNwYu2pu9U?=
 =?iso-8859-1?Q?0PVPboOQy1Qt3AtcXcm8AdvXp9S6QFH3hM8W/jmMWP5Qb+ayAPm0Eop5lg?=
 =?iso-8859-1?Q?Ql7HNpBjQn1s3uJQsqfTND46eCz56KsCbxY9fVaE8/D0C5f0PPirdgZNj6?=
 =?iso-8859-1?Q?JwSLm2c8Uw2yIKY5NxddI1u0fZiZo5WSi3hL732sGWVDbNuL62U58BFRkE?=
 =?iso-8859-1?Q?FR9bORac7PFFUHQh6poKwlnJk+KP4Xh+Dm+r4qvgk6HZ1/cewebdgGgcFo?=
 =?iso-8859-1?Q?0UaCV/JqzCMBBQ3ktn8+xQAIzS+OcVGCxfzCKnP/XscU+7qxp+mmQgq/jz?=
 =?iso-8859-1?Q?oAsnfHmGa+s1zlXovzcOTUoGdOxjnwPs9Gc8pBQtVWMJY1IGu12jWsPHFs?=
 =?iso-8859-1?Q?7tXmN7OGvUOM0+QBwsXgP0NsWHrqxSifQoewLatpz3ExnMcEBv5R7FdXDe?=
 =?iso-8859-1?Q?MwMShgliy1KqfD5YvNY1vzPtYHf4GexQupO++0qdIAvFrl4w6Rq0rQt00N?=
 =?iso-8859-1?Q?64t1rtVh8SwbeL3LYA/xb4ZbGaAz+hoikAGaZbbI75QqSU05DL0Jgr9PWX?=
 =?iso-8859-1?Q?kS3BI1BdDAjdw29beAv2Pfpx3K8Kcd8Rn7eG02HOP/XeefEDs+gzgpL6dU?=
 =?iso-8859-1?Q?gtlYXz/MDcj4X1FQp2HnqQf0g3qLfqT04cx6IAfU4RZUTZMUOvVVitnmbw?=
 =?iso-8859-1?Q?5Zm4YMMrRks8SsCVu5SFy2vKb4+y2ydjz654x32vCjaTtUUqOmXpgvtBfZ?=
 =?iso-8859-1?Q?Kzh2pj8BNYt66uYqRTpCGPSvslc+hoFnYymS43EugvvDa0o8HEq6gGyt0o?=
 =?iso-8859-1?Q?nn9kYg7yInv1aZQdwHrLXHP0QjVz3zg56XOALbTTykzLq18ni1HfJt+C65?=
 =?iso-8859-1?Q?HJ5kPFOIM7xsQ6djFB2IIs5FXYZzYtVzG4pLIShYBgM+GgJtFCvuPcSEEY?=
 =?iso-8859-1?Q?CTeBzsoV5YpxS4v7yrpijsECttJI0sq7Hzmx+zScUpSnXIGYpFBXJvX2Zh?=
 =?iso-8859-1?Q?iY9Z12bsDB5LnLKj0wZstD4+9KP9BcLFQqXotxYUnLDVq8aA2jBsQmVG69?=
 =?iso-8859-1?Q?kGYoxaB12IDQe5G7Ld0cM8vDBBfH30jFMVMtoCYara4v9sZlKJap0Fc2d0?=
 =?iso-8859-1?Q?MFg/wd8lpnNFBMlol6Fm6gpgZV9HsQdnMSMThoaa92bl/ZHUxwlbCkiYMi?=
 =?iso-8859-1?Q?zMwpFVKmYI1RoHhngKxWy8nQtVlB5rdZcM9HdQvmq8kn1s3y9djJ4wk5s+?=
 =?iso-8859-1?Q?Wi/OdGbb0l/EdCqSy2QK2LxmuOMsWU0CWo1V0+7+8929SeClBSqVgSxt/z?=
 =?iso-8859-1?Q?SXFBOHQySepy11uhh4q+XY2/Dg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR17MB2156.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?O4CCPJlSOHzPmTghmegf6IpS4ntgqMY/wvbzQBHP5L6MwjqCIAU8OkOUAt?=
 =?iso-8859-1?Q?vhf6Pchy2otqQsm2ZB4pHnECl78i+EeJWh8Hqn9Hl0oUhQW3PFFiVurYph?=
 =?iso-8859-1?Q?RL0SjTXy3UMVXFKicWvBfnkz/gQ/NpfrqjdzIDVHqTYjk30Aic7Fyhy5dS?=
 =?iso-8859-1?Q?XOtFa0gPTawELnTW0F212psyk7OszZxO8N7DflaOISd6JejtuA3tMAPKkz?=
 =?iso-8859-1?Q?d0wpsAnFFbFvRuX+LfpMaNDBM/RaedvcWcnvQSChryir1KPuiWLN0SBhIl?=
 =?iso-8859-1?Q?t6gv2yctc90gbUaG1yolj8hSRjexbwCvJHqt25YowRcwsmpxa/iOrbkISb?=
 =?iso-8859-1?Q?iEBbyzaJMMkW7oO/DXQW2AHNZmRjmEOQiT2Zq6XSoKyoi8EN7SLJVHZIvY?=
 =?iso-8859-1?Q?3EtdII9h8zsToCpXP/bcP6fMmlgazNmOs88EHG0QxtcTl5egfAa9aDjtCV?=
 =?iso-8859-1?Q?yjlxl1MdkoWechL7nwGKGKumSBGXmnKzY6afGpO1RMAw69jTqkpvWu3glL?=
 =?iso-8859-1?Q?kNwjxlp/fWH/JlVZ6myjEQ6trJMOgA/2Ob2+jJLMILNO2SUIjorFPzOUF5?=
 =?iso-8859-1?Q?JYKovMfeKRfoCquMvjwEs33tyHKLvrOHA+GIDuJzidYXRKYciMZ1Vb4NNO?=
 =?iso-8859-1?Q?n4N2e8hNrGQYS3/4LuLEECKmxegdnf4t2PI5/OIy8BmsPgiGS3eofTQmkS?=
 =?iso-8859-1?Q?4VsUeRgt0kq48n/S7zEu3tlDYd4NiMiZdEY2yrB97k9JY3xajbkKa/WCh/?=
 =?iso-8859-1?Q?9YDw/2JXA2A/cSnNJ3d7sx6CMUFf9hccNJLF2IV46TS1KcorjkNFzRvUkD?=
 =?iso-8859-1?Q?L7Mxnz9zbr7M9hyxx6R6DFz3U80dlzCIqIaNY7215+KKorIL2l2EkaJiIp?=
 =?iso-8859-1?Q?qLotrb1PMht4ABtpF4OVJVlZ5SqstWH3ojP1f9pfpSe6T/9uV6yTTanli6?=
 =?iso-8859-1?Q?lDyKSVfhCumXweJBU+2G2Sh+i9XNEMNM87tbNvJp1K0Fg2hlLn5qTUBfZO?=
 =?iso-8859-1?Q?/EPH/OvWrmHvYwIvwFud+Vzcy9sXjZW2mAet2XGRRXwrpjKrBRZLTBqoib?=
 =?iso-8859-1?Q?PV8bkqhowXJ2NKwmCcPY4Ykav+L/OtKqHLpoAQB9VlKqManpIVYrKYdBqU?=
 =?iso-8859-1?Q?1RidJ8t8z02Rwh86yb8UcpIPfD7tpIOMcms9fUyzl/p/+SdtqJqqmdP81y?=
 =?iso-8859-1?Q?zvO4Nf8IiQEzUWtxydPl4t24OEXFO2e41vQq5nYmNQO72N4Q5q7FRkmwiw?=
 =?iso-8859-1?Q?d7ghx8vSQmlaZDbCYcXnC4brTMsLNWnC8BdVEOuAoRntjDz4aG6J6NUjji?=
 =?iso-8859-1?Q?cOb3QjztgqBexXWKmVdDkrfqvV1VURFOXPoz5DawZeOw8ZA9yMp8/HZtsJ?=
 =?iso-8859-1?Q?7eZTw4t7iy3LB0bWdh7xC2LHZc6NfesMTDh/74EDqX70tEidTX1AMyokzN?=
 =?iso-8859-1?Q?Bp5GKb2GxmOh6EKq5Zchxt8985m2Ar5JU7RM8hUQU70sTXBIpwFOh8is3Q?=
 =?iso-8859-1?Q?WO2x9IncSRPvm/8mVYidN/CiGA1NQdKXbJ9qYEgvUsf6Bx2Kx1SbaLknH3?=
 =?iso-8859-1?Q?MH0J8lrCq/kHbHauyG84ofmBPEU4mjDA6bzP//Rac6vcwO0IOp5XJVdB4T?=
 =?iso-8859-1?Q?ntbcbb/VTsB1zkVLM/MzS6PGFzZElksn1YhyKjWwwL2/b3cjVyW12jvyvs?=
 =?iso-8859-1?Q?xICd4diDwivXMGSU7NY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR17MB2156.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaac7668-6fed-4d77-e217-08dc703f1891
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 15:45:47.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRcNfXQwEElCTU+GCE8TMRqwUZrE7IAOkzUpGURrsymk7gmRoqhwaFk1XimPpmqI6uiZGC38C6e13opKUpVREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR17MB7068
X-Proofpoint-GUID: Xu0Wkq5xHauw62h3NSauFVTa7xS5G8ea
X-Proofpoint-ORIG-GUID: Xu0Wkq5xHauw62h3NSauFVTa7xS5G8ea
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=906 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090106

Subject: [BUG REPORT] fsmonitor and core.untrackedCache combination causes =
inaccurate git status

# What did you do before the bug happened? (Steps to reproduce your issue)

  ## Setup
  git clone https://github.com/git/git.git
  cd git
  git config core.fsmonitor true
  git config core.untrackedCache true
  git config alias.fetch-bug '!git -C "$(pwd)" fetch'
  wt1=3D$(mktemp -d)
  git worktree add "$wt1" -b test
  cd "$wt1"

  ## Worktree steps
  git fsmonitor--daemon stop
  git fetch-bug
  touch foo.txt
  git status
  touch bar.txt
  git status


# What did you expect to happen? (Expected behavior)

  Expected bar.txt file to appear as an untracked file


# What happened instead? (Actual behavior)

  bar.txt did not appear as an untracked file or in the status output
  at all


# What's different between what you expected and what actually happened?

  git status did not accurately reflect the state of the worktree


# Anything else you want to add:

  The worktree seems to remain in a bug prone state even after
  core.untrackedCache has been disabled, adding these steps shows
  this:

      git config core.untrackedCache false
      # repeat "Worktree steps" (changing file names)
      git config --unset core.untrackedCache
      # repeat "Worktree steps" (changing file names)

  When a worktree is added and core.untrackedCache was not set to true
  it does not reproduce the error:

      git config --unset core.untrackedCache
      wt2=3D$(mktemp -d)
      git worktree add "$wt2" -b test-2
      cd "$wt2"
      # repeat "Worktree steps"


[System Info]
  git version:
  git version 2.42.0.windows.2
  cpu: x86_64
  built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3
  sizeof-long: 4
  sizeof-size_t: 8
  shell-path: /bin/sh
  feature: fsmonitor--daemon
  uname: Windows 10.0 22631=20
  compiler info: gnuc: 13.2
  libc info: no libc information available
  $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.=
exe
 =20
 =20
  [Enabled Hooks]
  post-checkout
  post-commit
  post-merge
  pre-push
