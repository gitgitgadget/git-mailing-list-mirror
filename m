Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022094.outbound.protection.outlook.com [40.107.193.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889162957CA
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069760; cv=fail; b=WzsNkbPXzqMPWVARS8hb+TOa21YEBkoytqajby7VUAuVJyf+V9DRF8HEchw+SHc0TZaSm3h7HiNRn3bSHWTBw0A4ZcTfwPHo9Po2xLBwA3V8kSHxoJfdK2s1kUwwRpecKeWRrt8tL89+8IkDUA5ebeZ5UnsDUWrUcNu0Y2LFzrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069760; c=relaxed/simple;
	bh=3md4lKUraVKln1N7f+GaaWK+wwyT3EVt1gNBLJVVRyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwJL3mR1+foqALkB85nwWMB3f9WcjkrWHtI51rnzEUoZ1HdBhy30jsLz14GeANAIy4kVEWyI3YnIWlS9H3yBtvFXi5trERy8MX5Mm09JH++PYO7V7VSKdfF3kGjUiKdK/YzLmHvc4tJbB+FeN17axwZEPesBHvdipeoeQLaTl20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com; spf=pass smtp.mailfrom=kaimaging.com; dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b=QYvMf+Qm; arc=fail smtp.client-ip=40.107.193.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaimaging.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaimaging.com header.i=@kaimaging.com header.b="QYvMf+Qm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW0Ecj/4jwHwI8WH6O7ZotRlLXC4hzPRjO2bXjiZos1mAWNXcstGAvtZEKNUXMpp3O2OVwe1NH2r8bIB9KdaWm8lBH0jJTKbeJMZdGnriRNP2dPDg4IeBuOhvPGa/2QNQcwyqqLKqHQA50oekiksdaaZfTwgj53NrB9wIi/ydqF7wtN8LA1m5L1ZZvjmnCoTtd9PMX5/WwxgmlENZznaVWG4/7cNt33StU0DJDT9OC9hkkYFfsO/fQcNXj0hLsG8wMd6+uyoI77jGyqzJYiOsnjUi8xR0cUbvfaWgz5wJ9tvafRI2ivVdv1yz95X79/gHXhQLEW/taLiHT6j0oMAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3md4lKUraVKln1N7f+GaaWK+wwyT3EVt1gNBLJVVRyw=;
 b=R0dF5FEHuSGgEfTdymAIaaoWcbYICPo2oN2QxnGBbib4+uvpJsBsGzuN3PcfJu/Pw5GMxdYfrZiY+DL8glZlwOHCVmx/IitJtkltt7GX+FHodcAu1ePcCJmJjcIkcXJrzbqwcANfqm+m2bQWPFmsKs5nBoBhQAav+AU3SWdl29Xgzo9TDDTLn3B1hBPhdwzN5XWQMKRRSTbeUsxxC+gavYdkiVC8Gg/1dsMElhgS45bfARlWUwtYRghqAhgop5MijnA3hyUcnJX/D5EK1Efixb/2/lJhe2JdlKHyDPlTV8+ADKZ6lI/rWyr+e3umujjFga7aay6bPqDcsNZ2nXzvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kaimaging.com; dmarc=pass action=none
 header.from=kaimaging.com; dkim=pass header.d=kaimaging.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaimaging.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3md4lKUraVKln1N7f+GaaWK+wwyT3EVt1gNBLJVVRyw=;
 b=QYvMf+Qm3FmD+brU5dsFOMwM1bo51JoDcZXi479Lr6wR4HhiKDgnx3RWpMlRoxoNlvsxJlaB8PWMWZLjGPhkUk6Wqe8mm+lJ3tX9KYJYLA/TZQKmy2dRkKh58V8B8f5VvyM8OLZnGhViXMi1wYsDP/hke9VmUWOiLRR+Oto2nvA=
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::626)
 by YT1PR01MB9244.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 17:09:13 +0000
Received: from TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e]) by TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::32af:10e4:7fda:a80e%8]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 17:09:13 +0000
From: Stuart MacDonald <SMacDonald@kaimaging.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
Thread-Topic: [PATCH] stash: fix incorrect branch name in stash message
Thread-Index: AQHbw1yP74QUkzFa/kKa27Hr29f/prPPMxIAgAAGEu8=
Date: Mon, 12 May 2025 17:09:13 +0000
Message-ID:
 <TO1PPF29324B4CEE0C0BCD7CA1F2FAFE505CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
References:
 <TO1PPF29324B4CE2F822159A3F1C6A5F3B4CD97A@TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM>
 <20250512164001.62065-1-jayatheerthkulkarni2005@gmail.com>
 <CA+rGoLfv6E7=TCm99yt4SYsZ1P-QRxD+vMuaHtDWX=ufneiYUA@mail.gmail.com>
In-Reply-To:
 <CA+rGoLfv6E7=TCm99yt4SYsZ1P-QRxD+vMuaHtDWX=ufneiYUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kaimaging.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TO1PPF29324B4CE:EE_|YT1PR01MB9244:EE_
x-ms-office365-filtering-correlation-id: a6bfe637-ecd9-49a2-c5c9-08dd9177b85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dn1bkLJ76jxvxXWqTgUrmuVBxw4GGzpZNI0NqsjZhdRyktCgOqT+y3DpGe?=
 =?iso-8859-1?Q?dFMNh3np6hu/UM4MRKtAVk9PZHgRWNyDZpfbYU7U/2FNhb7+o/g/hggx89?=
 =?iso-8859-1?Q?+QyfJyZWDOeCpeli5tm4pTrc0d0BNbKMDPpj00yfZgENwypPjmFbXAABR6?=
 =?iso-8859-1?Q?UKmqJJNEGFK2kNqBuf5NsYL4x1KS8YGdfXKCLBAvYFDULl2RKC4spMk/0W?=
 =?iso-8859-1?Q?psl0zaif3Z8RO9VaemBYe9tWzXCLn2scPmwPRnkwV3cPzy0NX5v7ajqEe9?=
 =?iso-8859-1?Q?OBPQhs+fd7G9aWkPlgOWxOXkqdI9EI6WG9xeHMgi+h/qOI8GYYiTrl7Hl4?=
 =?iso-8859-1?Q?2lpIpDkVvCOd0JCTUkRY/6KeDSWIbtof0T68BsAOyJqahMkrs3B/WmxYkj?=
 =?iso-8859-1?Q?GSGxCHkdqHTcvPdVoaPBUZhJJX58Tzp4R8LwU2OScBRdb/zszG+6iaXGnm?=
 =?iso-8859-1?Q?ol/KQVDMzGNiCmFZc9B0DIW2IVBSuvGKm5tqkFer5ytew8aw86Oj/0LlP6?=
 =?iso-8859-1?Q?M9CdcSBpEGJMEahUgAgBp7dX8bAJ1vkUHn/+kFoQHENV2eRsTo/yU2RWLI?=
 =?iso-8859-1?Q?6jxRIx4BFc+e0Pjw2KvcIcreajC2AM6AzgNgcUXmMeeHFTAVzX+FK3aa0/?=
 =?iso-8859-1?Q?FiShC43QcMtz0F2gXDTlx4Ct22edt0dczyvQXg0JObbJWG0G6VcdmDaBqN?=
 =?iso-8859-1?Q?KEYK9W5XSGc4sO/UjnQcB1inQ2vOnKAcYsztqvmXOUoLKaqXTmSfqlreCS?=
 =?iso-8859-1?Q?4XPGqRe+hEX3ELVI/GWBXDTpEPyDrt4R85riv76WdgGrpSyoOuurRwsGst?=
 =?iso-8859-1?Q?J5YLsMU18GGxspX1/cTMZ0ikSHWIX5wdu9fzGG4AuWBDzSuQGVhdbFfq6i?=
 =?iso-8859-1?Q?hkiARvPpcQFxok9ol+jFFlQCQ0pzqjqFGRdGnynkgwiVq45LuKsEEpwDKg?=
 =?iso-8859-1?Q?mrgq6DVgZUulcY9QvisvLQ7FUdzSuvrNgJdI+TQmEKnsZtIR/mh1VnXOBh?=
 =?iso-8859-1?Q?dE8/+engqFlSap8u0vcGu1ETlhC+PxbHY8oXYH0HUdHubCjb9JDERBTiz7?=
 =?iso-8859-1?Q?wJePpzBSzKiGVV5SMjgh5tPH8RgewHTX7ogX6ATZjg3pHJuoSA2z6bulQo?=
 =?iso-8859-1?Q?BEeSaR6eYVnGXUpmj9HZlfxO23HvGdXixtXzFmCqjyJiaj44tS7Ar9IQne?=
 =?iso-8859-1?Q?SQ0xMF4s9+P4RO0pRBWxYCJc2CTLZY60ZrTbtkzWbxyBDQ2ntoeUvwezmu?=
 =?iso-8859-1?Q?EL+QAYzoeYISB8aNr7GC3OHOYMTgrI6TYTEGekQ3noUPtxRcj/h5E1p5aP?=
 =?iso-8859-1?Q?LcLjM9voar+QxrYXn0F9K9MYdkSmG4wMd1dIDpUTJnlzK93B9ZvL/vM+cF?=
 =?iso-8859-1?Q?43Mg7dsX+NePB0WW81DS7U24tuQlbtXzIvQihGPsVfIu/2mSnbKN3ovSyg?=
 =?iso-8859-1?Q?gf5c8x9dyCqE1sB3fvM+7x9eCvQ09xsHGG44gOfVV9jG589GdKEZF7yX9l?=
 =?iso-8859-1?Q?OZzb35+fT/lz4pf70x4zeTaiO1y5j8vos6gST1lgTgAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QuF+gc8JVfV2hmCLyHgx5BDYsRJmxLa/8zOZt1suCYucOdDd9tc5r3BjyZ?=
 =?iso-8859-1?Q?y3Sjz0i+i1VDDpTgw5HMZhKl8TILltYqdBnNKW2g0QIqTq8I+BWsAr5Llh?=
 =?iso-8859-1?Q?7pClfdheZN74Sou4yt6W1BiUsKQuYkYXmACSOxqmzK7ozzIKbOhP2iz9Hy?=
 =?iso-8859-1?Q?FG+XSk/22rzRiuSRXc1hHmQUtA6N7ftrxvz/MJq8JaJZeZ+U9mx3fVqmSL?=
 =?iso-8859-1?Q?CUz3Vb4Nhq+E+1VG5WGSeunDMb5/6s6y3mifD1Eod4FFc0oyyqeYqC6Lu6?=
 =?iso-8859-1?Q?urJVrsDNiwAQYlOLpBMzdnJIlu787+NSsViquL1PGDqxANIIzwQRClUBhK?=
 =?iso-8859-1?Q?ZodnwndhJ0N/uN/EdRtdnucXHb5UsI24XfPi3cL/GgWpxsBAvElvJ/b3f4?=
 =?iso-8859-1?Q?UzpY8gFgoXeo3Si0w1wheDq8+hNZUZg07iWEpnQDi3f3dS8g9onwkWg63/?=
 =?iso-8859-1?Q?IG/ZlOomopp4OVCCWxvbvFFd7Efe7YXKsQS8hnNCfeB2MfqBN5kIpRPNdu?=
 =?iso-8859-1?Q?bgSzClsp0GjlZpeplS3PA961GG5GoBv3d/2Erlnj5A87fccB2GeItwZSVg?=
 =?iso-8859-1?Q?si5z20kcidlEq8kY+8M8TL+OUHOW4pluJr01wh4oYYkNTXBOUcsrSqzlRr?=
 =?iso-8859-1?Q?FRVThrKZkifG5s0srOPiEZ8HuhBfhPb2kEOHH2Vgk6pdsUfA+8Q8PleQUY?=
 =?iso-8859-1?Q?SfEAY4HhmX0Bvir0IcFJMuWBSElLRLm/eWfY7ZKHQC6kC5mWT0m/f/eT12?=
 =?iso-8859-1?Q?DceJ6F3nYljSo//wrKEJw/v+/w7liC72wTKPrDxfUz5qnX0mSw/QY2NkKD?=
 =?iso-8859-1?Q?0xsczh806U2F1hwc37qNtsnlqWifpvcXFs26pQYxe46crmgKwx88oZGV2i?=
 =?iso-8859-1?Q?izu2WApRKBoRD4BBRszsFMmEfAj1i+TuLZXfIooMa7wPiN1LD3gFKjaGw5?=
 =?iso-8859-1?Q?kdnD6zS8RxfCpP3kTfLFWh7iVINh+1wG3sm42KdSmisTGYc6gj3RuqI7E6?=
 =?iso-8859-1?Q?PP0j+t3Y+vCspNnf2teWG/vZ15Mnxf7l/axFLsIJxmbv1ep5ccwHHn7Nd+?=
 =?iso-8859-1?Q?RyZ+vf533QsaIFWEuTCery+BnjApdKsruy5r54D4HzLWOjbCRqFy1SXxtC?=
 =?iso-8859-1?Q?ZwLrPs8uCatb5KQRIIlSjJLF6TtnklZ4tdVh50mx6I9tFylWQE2xXM/vid?=
 =?iso-8859-1?Q?bGIvBk3Yd/HeHde7oa3ti3vOl9AOJCiyZmSXAi6EfzXlAV4luN3OIu0cWC?=
 =?iso-8859-1?Q?ze7BE94x7PE+F4e4UV28QyM4k6Kw0rSOCciRp2n9Lp4Ev7+4n8bsUqx8q+?=
 =?iso-8859-1?Q?YArlyEvttkx4k75KutsxiRLWUsb+UnjmcSeRGCP16WIcfvnihWN40O1mad?=
 =?iso-8859-1?Q?ATYvrRGGo7Ew9m5ZrIFGB5zPxpnoYfO08sAyQJZ1uWd+XsUQAsJfeZfKkm?=
 =?iso-8859-1?Q?jJ4hsa0AHiXXp9XAZVoSLcCR2OB8hyVfoeqmrG3VEbrjqu+LWiyDgHJ6gN?=
 =?iso-8859-1?Q?qGXcx7gUKautu9fDR2lp6bLWgpaw1ultZtRG4tRi6mJZrnHew5Kxn6BtKV?=
 =?iso-8859-1?Q?XkvbfDZBZyt0z3JyTROurWvcdoS/hb4my41skcY1toGjShETZU/Z6jJP1b?=
 =?iso-8859-1?Q?geftFeIksJVOnyYOennKFXo/1BzMEJoOym?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kaimaging.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TO1PPF29324B4CE.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bfe637-ecd9-49a2-c5c9-08dd9177b85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 17:09:13.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd646163-ccd8-44eb-b4ed-abc194a640ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sirJcAWTBBqgcYGlZwx4p8hfpJC5Lz/QBt2yY39scXj9kxrBzk3lw7NtZrkrovDaJcWpLKHCOU3m5dcQVEpL4TPq77xmFinz5ulzqL1BJ3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9244

> Changing this I found results to be correct

The patch looks reasonable to me.

> I think you can use this patch if you want a solution on an immediate bas=
is

I would if I knew how to update/rebuild Git For Window's git.

For now, I'll count this as fixed and try to remember to check it in the fu=
ture.

Thanks!
...Stu
CONFIDENTIALITY NOTICE: The contents of this email, including any attachmen=
ts, may contain private and confidential information intended to be reviewe=
d only by the individual(s) or organization to whom it is addressed and may=
 be legally protected from disclosure. If you are not the intended recipien=
t or an authorized representative of the intended recipient, please be noti=
fied that any review, distribution, copying, saving or disclosure is strict=
ly prohibited. If you have received this email in error, please immediately=
 notify the sender by return email and delete this email from your system, =
including from the deleted items folder. Thank you for your cooperation.
