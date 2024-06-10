Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2134.outbound.protection.outlook.com [40.107.7.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CB28EA
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014656; cv=fail; b=H19GyhOsYy01AUF4j2K0DesLOJYD5JKoi6O/V4Zu5dX8TAyLXx9fzqBd2RuB+NcQvIzxm/f4PnQIsHsIs/pMs91W3utbG5pa1jl0hhRxmxZh9Xg0h6oCHIgpyHxzE9pF3/4VtFfhHYDy3wgTVS6Ce7R+76Z0otsTkJ9H8Nv6HSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014656; c=relaxed/simple;
	bh=4BI5NcE0T+m999jnw+LWj30HHMD/nkdjHB5ztTyS4WI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FvKRhI4pzUtoelxP1d09DjCU63YwwqAUVG7mSNG4SnSzTszLlhjDA12BvV+vSJicXLTA+QLFcMc6OHSSxJGVsRZ/urEkDVFxX2C/yyB0jk0SCwHSD/+Ua2mCed38Ff6MpYTJpZ2AYRXKzeQFCLa8w3P5Fy6CCaZNanD+EOC3HiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com; spf=pass smtp.mailfrom=axway.com; dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b=dSRb253/; arc=fail smtp.client-ip=40.107.7.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b="dSRb253/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3S74K9bZZHuSWYBvhImVUaQDxP4YogyUwBMReuoqBvNsGaiHkthyHgBoUQ+TfBG1SG/bXo4+X/gpoF4AA94iI1K4BEWXA9zXVIAyEVLmffF/pU3t6Hk/VsGcNLsMS2h75a6NTtO/IGBNBA6au8sdrn+kUUtiCCmhOXiwUPiJoVQSsN97bDMgc7C8uTXpFNBf0vXJ0FbqjZwmrvoQh1HBOJIV8PgQgTVQJzb0+jznbeRIW8AbN8hX1VAuCZK40ueG4YAfZp2UQuVrx0mjMt/0jFU2dHIf2v5N+cL1uOZJtDMQsu/GVW241DZEvk8Y5ABYrvSX1cYcDQawp3tnPp7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BI5NcE0T+m999jnw+LWj30HHMD/nkdjHB5ztTyS4WI=;
 b=dF9sjsvv3f4I3YFpDDe68uJpa0z8OxOrZTx+9ofSLhPGbezYM+HZZ7/+8aMeO44aVl+QxZi6o4yBM75+fMvxoAzLZDiYzaFbPc+TyywPkpVBA3tuLN5acj917xLZcnv9ezyyOw3Fxa8ZBTIzwc1Ah+gNCcYVZxXUqAa1kNpFLQL5MtXsU6zYiY1foIo7AgheL1TKlhKzKEPFeGEPAyCq3izhg1+L3/4vt5VSrrz5PLMFYAQh/XwrEsnGNUOAdyLt3oPE9w4GKU+TzIrFnQIS8+Gxnro/oxjVB3YfbFrW+1YpTmOCCCGuahmrCy/lYvUiJSkBeqrjrOcy8k1l3nOmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axway.com; dmarc=pass action=none header.from=axway.com;
 dkim=pass header.d=axway.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axway.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BI5NcE0T+m999jnw+LWj30HHMD/nkdjHB5ztTyS4WI=;
 b=dSRb253/q+twB3KXDkmptv8+E14EN7GPo+y5l/BjHX6SNZDLo0Y2z27XgGWAvK/mrBLYPB6QXqPAZmC/axT3wenwGvIaBIuECSg1aIZtqo3whNdCP8MW2bZ6gBsg7RlJIwol3OxC3t0284I1BEM8GRzUm3TumCB1zhLRix3dMkw=
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:241::20)
 by AS8P190MB2032.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:52f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:17:26 +0000
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560]) by DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 10:17:29 +0000
From: Arpit Gupta <argupta@axway.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Issue : Writing commits into the git repository takes longer than
 expected
Thread-Topic: Issue : Writing commits into the git repository takes longer
 than expected
Thread-Index: Adq7H1VaORjtBCCsTq+BTs/ioNM+hQ==
Date: Mon, 10 Jun 2024 10:17:29 +0000
Message-ID:
 <DB9P190MB1500D7DE16D758B8710BEFC7A7C62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-lsi-version: 1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axway.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P190MB1500:EE_|AS8P190MB2032:EE_
x-ms-office365-filtering-correlation-id: 489ea1ed-d17f-4651-ff7c-08dc893688b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rOWBrkMC0tr8PRyd93bU4kV157VqMe39cgcxluikCC7b6TNxbiyaZ+jpvfMZ?=
 =?us-ascii?Q?HLEhbKdPHAqFS7t2nG0zPfJ3BMnP/9tRC1M6DGjwOeUj2A8b5Y0JfDIQ93TD?=
 =?us-ascii?Q?XVA+VxLDaMqRwdt0dfT6sQ0sJsy9Bdkw9KUDI0YbapU8Q9+5gGfq7iBaJaML?=
 =?us-ascii?Q?Th87J8ggsFBcm2ygv47obQme87Zluif3Tg+NII3c2jWc8upt0afCshgt7KId?=
 =?us-ascii?Q?NOW94Kuzhl3FFoKQzaY3JHeCUDX1joe7RHO7CYzRbbx+3x4QI6qSyrlNT1RE?=
 =?us-ascii?Q?hF8Z4WWypOvKHgaLz7Rjv6K01VsswLa7aswxiIQvrMgdSwC5xGN58K/w7Jep?=
 =?us-ascii?Q?wOXASxADvuGkOYqrN5zYqipkf7u95fW1/V+Dejo/811IBNon2bXdvDmDyEJa?=
 =?us-ascii?Q?oKSFSdTxEdqkcNTjW5w4BZtJpTEO/7U0Gyrl21bDqnIeRDqXHyGkyogeafkE?=
 =?us-ascii?Q?oYnfNo5uCEvhneK1nvWYe6FRLD5/+G2USbOVUG049j22f+hYFCwPHRjvxPFJ?=
 =?us-ascii?Q?JowJStCVZKhm4NQb23V7NJ3FLxPuh8Ze2kEUdPJNbp26tyWbplm/qUirlZXI?=
 =?us-ascii?Q?ngwypNhZpqknfb/UB5Cz8fM9iEScJI+4pNSmjMWqm8xGMLb73BNJyf5qT3RR?=
 =?us-ascii?Q?QW501n/C6sRKFl1r9SyhejMSzOhdphI4+hoErdpdTYjLOdC4QIibxIwMzdKn?=
 =?us-ascii?Q?Xec7qmHjS5uma/WohwReAhpF2HI1DSm8diVLIL/IfLdvPPD5OYX//dflrp73?=
 =?us-ascii?Q?GF/CC6qFP3NUPcTgMG59IgQdwYyk3dtSTdesRAG1vFDcmuTjw49bPPQNpy+Y?=
 =?us-ascii?Q?Al8L7ne2pPjhR4xTySJ4ig2lhIV5JVV7pLtDg3/zoQ6fYFfDTPUKHA0eyTy2?=
 =?us-ascii?Q?C2mfGTp9gjHGoK4EOThlriRbMb6uMkuuqWAc8yXVzQdpKpWmlFdkjyDl6Pk7?=
 =?us-ascii?Q?zGF0Gk75Xc2xFXOcDOSpDiIb5XiMGnz6+BvE09Z7YKvn+O1SML99CR72y9MP?=
 =?us-ascii?Q?ZuUG0AoSyx0URXFeqQEOPrRRj2N3rfqXhUQJGcGQuD64Kr1QDaqG9EQrYD01?=
 =?us-ascii?Q?M2bxJT+uFR+4PPc9IlN/Vu2mqgRjl7JFaHiXHX0rg4sAJoDdg/wsJe9tI4JD?=
 =?us-ascii?Q?XuonxqIjs24QEd5U7Y0bSte6j9sOmB4bZ09xtX+aHJV/5enxq81L/otQ9wmx?=
 =?us-ascii?Q?AMqMrgF8N1uGOnVfZa3Ao93+JBde9EXothYvmK8eNpF9VGiwYY2MdCAs0y/4?=
 =?us-ascii?Q?kCDsRTqNFv7LdZXjy5yJzqnDhiToex6Fxt8vliqX9vJrqSTMiyL10+94VzQ7?=
 =?us-ascii?Q?lFaaR1eKe39bpRCfl2bG/EnoFpfb94y0umP4JPStjyjjbwndekcB0wjFbXi3?=
 =?us-ascii?Q?tQpnxIU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P190MB1500.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tOBsw6ZXK0SyPFxBHpuAbFm7WteMfAXyM6Kxe9aO1u6Hm0GbeiWljrw1BDmk?=
 =?us-ascii?Q?kcNaW6QImPLm8gLKkWi+VXCu0XzKGGIVZdvnEe5mYBbNtsFqapZ8FzcFUKHl?=
 =?us-ascii?Q?S5PkHCpiDJB1es3A6QqHJUliPut1EKLbpZ5r9uSpDC3y4l29d2tSx6Qat4FM?=
 =?us-ascii?Q?pDvvJpff69LObyVZ25k5kI+Q9vdBEz7UuuYZKl6L8Q9T0YrPtG1f4XWapuTB?=
 =?us-ascii?Q?qdyO7tjlNcMRE1iLGB1Y9mdgAU6qEWX4S8ofPWOAmYRvvjmG+CsVVPmSZUh2?=
 =?us-ascii?Q?blm8SK4X81gKpgIsdduuC7AKH1vod2X+US0OCcChtADGBc9N3V1NwM145/3n?=
 =?us-ascii?Q?nveNV5Rf368Ku1mbpyZ18TUNodUEPW/9VSaV4fqU6Vq2ktOzPO0AaW9fQXKF?=
 =?us-ascii?Q?+222U9m7iymFMuUyR0bFN1di2jAPyMtzHoFCYS4SzokjsIzxSxIDyf9OU2yA?=
 =?us-ascii?Q?9U6+x3ar0zcrEDIB/NQPHw4nuRWrNGtUUdj8h4lxn/b1w1Pf9mc8xMcwm/uL?=
 =?us-ascii?Q?tLVdCGka+rGBepBLCkHbrHuaptSVA0A3T0jreyvHzXWG+OahzufmCJ/cBIKE?=
 =?us-ascii?Q?EL6SUKqZPKJWBpONjYGgrJToPBw2Szb3j2+mbCABWLZgl13sW8adsYjSTTrE?=
 =?us-ascii?Q?dWPZakAXVgmRSU9yrQHnoBpD+mtWVci5FAs5AkdrSaVgO32qWYN8Gzi1UEeE?=
 =?us-ascii?Q?PoCKWg3RizqPzW2unCKyFnArJnCW35nZ1cPKqrla9LmRNSiKwFKAI68ChCsQ?=
 =?us-ascii?Q?7ylaUHiV7I8HgWpJozGGcDP03RmmPWF9O+psZ9FqEZM24CppGFGNNRc1XS/R?=
 =?us-ascii?Q?s6g1HI21MByVi5VFilNmrTHnnq2hBYAL4k3B+JjxX7Sb5gqfsypf1icpoemF?=
 =?us-ascii?Q?beYcXQ6ed6yqVa0b3f9n2vdD5KRYT3wR04zfnliVzPEaXhKRgrzy8SKf0wZa?=
 =?us-ascii?Q?CGUUvBT1g/TFBmcMAUEpNSsVX3MYQBWRnQhmizBOTyP+7B+Pqg9KgnISHwTX?=
 =?us-ascii?Q?tPbyEXKOlsbVlQvi7zWrglrkun7uJcP3ezK4Jgh8cgFZlwx7J1Byna5kd4Lo?=
 =?us-ascii?Q?cuSm/bgMl4InffS18se6OqCxeal3k5xV1cvd+VH5NgnfJbq+wa2OM8wfcfMJ?=
 =?us-ascii?Q?yS7f9KWHU522WXUqEuBGSe26K/qO4XYHO1I9GaaOrLXDnfZDyyMa8ML1OPRW?=
 =?us-ascii?Q?bvU4hCa9eNpjy/lVNxnFLXITPc2jkT3QGHau371IDZVDGBOwyJm11qc75Baz?=
 =?us-ascii?Q?eipKFzA92Gc30nn/4QdcpCG0p5uGhWLL2ZqbTLGAVSjvaMCESzz/H5NBHoBN?=
 =?us-ascii?Q?CK8nTZuG44WA2ob2NdoRoRY5JULNMW2WLM0iJn+zACT1CAhxym5T2gC86jHW?=
 =?us-ascii?Q?mRkgQvT97ILsMLSQITkx3m241H2/fnqv+fRclvnExjv0w5RMs9QV3PwkABSW?=
 =?us-ascii?Q?T09fOXSviEMMEajMuntPA43TXJ4G1Abord+9vtEG4pBoiyW4tX2L7cxCnZ6V?=
 =?us-ascii?Q?XcOgRbH4fQb0kGyzGZKcS4nuJdQgMUezbvmX8nauZ7ZJIIuhx/N+3QFqFea4?=
 =?us-ascii?Q?EK2cSd0l2xEdxpqm3/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axway.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 489ea1ed-d17f-4651-ff7c-08dc893688b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 10:17:29.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 300f59df-78e6-436f-9b27-b64973e34f7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeGhwAeuq5NfZNAmfJJTJbF+SZ4Z2PV9lafG6CnPXei/bs+DKm/po9uZgiL2QJMpRi7C1ADUBw9mvagg2Wf0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB2032

Hi,

We are maintaining the different versions of data in git repository using j=
git maven library. So, a commit is done on the repository containing proper=
ties such as author name, date and time, action, and the file path.
The file path refers the xml file which contains the action performed and i=
s stored inside the repository.

We have a job running every 5 minutes that commits the information onto the=
 repository and the XML file content is over-written every time. Usually, t=
he commits and writing of XML file takes around 4-5 seconds but sometimes t=
he time while committing as well as writing the data increases which also i=
ncrease the overall CPU utilization of the machine. This behavior is incons=
istent with respect to the process and occurs randomly but during this beha=
vior, there is a time when the CPU utilization becomes high that all other =
running processes hangs up which demands the restart of the server.

Could you please suggest which areas should we look for while identifying t=
he cause of this issue? Also, does frequent commit of the content onto repo=
sitory can trigger this issue?=20
In your view, what might be the trigger of this issue and how we can procee=
d to resolve it?

Thanks & Regards,
Arpit Gupta
