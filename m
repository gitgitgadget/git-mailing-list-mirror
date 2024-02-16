Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDD1AACF
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072592; cv=fail; b=PyyPIFMJkFL30+FtUjD2coxFvntz+zB2wKg8zeoEj0RVOW9NC4U6ej3EOn5+cT4q0QaJ9bdsT/8SMWJku5uVGXJjajs/fqsINmizlOT240XaKTz1fItxYqSjWirNRKp6ZBsoBnLgKMyesojm4+Ae+kzUj/YKJ28zlwdlUWYvr08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072592; c=relaxed/simple;
	bh=jq0EojHxlRiP+rRGWjFIoVhOF4A7Pbcz9R9nmCzohbA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pnR/RRYqh0eveCthFsuq1pZr5hIuCTF1ZwlGVD4u9Em5ywL/8g2QAV+iCHfalxMFUN9lYNwXKuA2NhhsGxhPAufgkWjqxrdqo2KkfrKuFcquO54gzh6N7FKeBky4Z5B5taP7KEcYIGmebzuWcMdkCUCiMUfp8Z4PuKfeumPrlIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaeffler.com; spf=pass smtp.mailfrom=schaeffler.com; dkim=pass (1024-bit key) header.d=schaeffler.com header.i=@schaeffler.com header.b=BMPEKpwo; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaeffler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaeffler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schaeffler.com header.i=@schaeffler.com header.b="BMPEKpwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE6JRWWZ3Di8/ScPhS1Y9QLdxMW2sv/0w3ySmsdWhSaFq94R8Hmq0i5Tz6EAPXJGH3KDXxu75/TEze/6obt19DGjtzZnVuBUEiLHQAcpi5vO+7uPLZDageaRV6s4BKMuJnAfOouKmAjzwChAv4TTgfG9NOKGhVO5+cZtxiWUacZh0GOtNwV8Rh0fJmuZSai8dzbP+v5JtBnI8FW9OxvRdZZqj64K9Tl+EhWyhN9LklzqjJL4JQATp4PFKKXkEm/0UZPm2KPvR/uEpVrRG50Z+aVmUEF9MmiYOkl0ZC7UEzVruRppiuM0A9VZZ7WQjS3268UdrySYJsa6ybDjHIn5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq0EojHxlRiP+rRGWjFIoVhOF4A7Pbcz9R9nmCzohbA=;
 b=Trxw4Y0u+IHuCJCFw3kaWxRpORxjIt0HL8gHcW7SZaWylMa1bnStcY91H/NNZXo9+fAZ1/SQFMvZvlrkLlLSgzK+xANkRUZ/NIH/fx1Y0HSLvu9Ep+so9QYVfnnojICUicawplTsYklHrTf1Ni8CraiYUB+wlsIOAAsSSsLADXYyd2OU1NJAua1gpDrXYzsf9r6GU5tmL8JSicKPbINnLapEWl3O0K7J0InMG6o92eVYimt2Mxn/EulAmJxCuvNglKZ865xWtqUgTECvsPFoCSMwzzpSJtfiL9ywzJKAKiGISTFkHw5lPOsG7rXe2EuZLr549lbJypWpkJSzQqNoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schaeffler.com; dmarc=pass action=none
 header.from=schaeffler.com; dkim=pass header.d=schaeffler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schaeffler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq0EojHxlRiP+rRGWjFIoVhOF4A7Pbcz9R9nmCzohbA=;
 b=BMPEKpwojaz1n9cdMxQsnCtEeNB0vQS9HoHEDHEmQKHesGLlgRYFUe73l5Bp3E2lCmHqXmCKAatVvi+h8NjOFdpN7KBHBP3wJq8AKc/bhBhhMTBAZ5pOehuXbbq5XqtgwDUBT2Zh1W9wIEypY0JdnLiqqfzB0IuVnLmFWksd8nY=
Received: from AS8PR03MB7539.eurprd03.prod.outlook.com (2603:10a6:20b:347::5)
 by AM7PR03MB6548.eurprd03.prod.outlook.com (2603:10a6:20b:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 08:36:28 +0000
Received: from AS8PR03MB7539.eurprd03.prod.outlook.com
 ([fe80::d22:69dc:ade8:3119]) by AS8PR03MB7539.eurprd03.prod.outlook.com
 ([fe80::d22:69dc:ade8:3119%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 08:36:28 +0000
From: "Meiswinkel, Jan  SF/HZA-ZC3S" <meiswjn@schaeffler.com>
To: "bagasdotme@gmail.com" <bagasdotme@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "gitster@pobox.com"
	<gitster@pobox.com>, "isaac.chun.to@gmail.com" <isaac.chun.to@gmail.com>,
	"yoh@onerussian.com" <yoh@onerussian.com>
Subject: Re: git-retry tool or git.retry config (built-in implementation)?
Thread-Topic: Re: git-retry tool or git.retry config (built-in
 implementation)?
Thread-Index: Adpgsw3mJzxvLgNeQlaQ+Rr+p/Nz3A==
Date: Fri, 16 Feb 2024 08:36:28 +0000
Message-ID:
 <AS8PR03MB7539961B9E86362CAEA58B12D34C2@AS8PR03MB7539.eurprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schaeffler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7539:EE_|AM7PR03MB6548:EE_
x-ms-office365-filtering-correlation-id: acaca5ea-7a9f-4710-8ccf-08dc2eca5e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X9dZyJZ3j9Cdd+RDy3ttFU8lxMdsUcW0+Ob6mfgvrbQ7NqHOQPykuhAv4SO5/YYB2JZBzEn9Ccr15zjHg3opb353JP0RZd1I34r8+Ennn7LcjJIRKghDa8iwSFNDA9PX7ZQhhBHz6A9HIu9aL8qCNgyBQ262e8jTQI11tdx9eE33aWc3saE4rLRlg0ZCzrYoHDg/wnGKeyK8nzFQV4t6N8LklXvYjkA9aXEtERI3N5mk7ZVC4Kij+KjhhSebEhsVLdzshIMammnOxnWLELojNO/txstltj7jKVOub+/S9NlmHpgH2Z+COHTdt8dDDfFr7+S9Yu0xtS0VJzzJ/jWwo1GhgllXh5gTf62e2qVWr1UHVBpp/EjFfcNUM4n/0zqZ17dV4AHshqs05xzBChNqPecQsmAm2uVKeUWV/oWzlp98PzI98ZK02JJoRSvPG3RyN+Wnk/Lbe6DLHBdNsqoCEno/i3qmAhTITfVFb26RMejLC5e57hI6DWLUfD5mSh8ZIa4TmYmOeWI3SEofYyjoqBPsJ2h4CMea1Yvb4RIglBHdyi5L1sa1ioFnGVp9QXPQjmCUkrpEDVzAKTRBTqp87frF3/n+NQHdAW6h7HZ7wY0UEDQcXEQobhQVuYSyEOlM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7539.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(71200400001)(26005)(55016003)(4326008)(2906002)(4744005)(8936002)(6916009)(8676002)(52536014)(64756008)(5660300002)(66556008)(76116006)(66946007)(66446008)(66476007)(478600001)(6506007)(7696005)(9686003)(316002)(54906003)(82960400001)(86362001)(83380400001)(38070700009)(38100700002)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6fNOreOiXCoqulwoXGBPV3lDzWuJG8UmgigxqpTXw4frwY2JiSWljA20y2Tx?=
 =?us-ascii?Q?NtcRvIhHicSQg3opqKnn54y7DTt0WCVgTmxuoV1e2/kmWSnwRAB1i7RuTndP?=
 =?us-ascii?Q?ygv4M/lZ6sCVUEeXMS6crIeerU/LMa97A9/e365FemYC0KKynOakYtRmYBTl?=
 =?us-ascii?Q?4GI5Lzi4iY85sL0BicTAP5mwAYXHISYA7xsZ/ECD7MHvnITG3xaXxT/fAp41?=
 =?us-ascii?Q?nqjatvVFCh1ae4nD3BuGoIhHpZqucSqrDeoJuXNWC52e3ePVVt6x8AR3OI8x?=
 =?us-ascii?Q?sr/QfIKd0kg+lR1FP5pLkEBiwVV2KedYP62L+xTklALuY04bkCZGeYEzvZQu?=
 =?us-ascii?Q?0vvadNoMlaGNFgWJbZ8mTNaKfyaoHV+Vs51D6+uyl1mDdGmNfK27cLKdrkwP?=
 =?us-ascii?Q?7t6YkLvijFmIHObF9N8syrO80ohz3luN9Jxsi0ezY7QIQxNHwNnq5S+Jk8Ig?=
 =?us-ascii?Q?alnJXFcaK7roaeYtKKdoCmfC3336yXWSDQDhrlrM16bJ9+eAJFpD7fZmjdz4?=
 =?us-ascii?Q?psD4EMTfVk3rhXiIf7Xh73aQV9Tr/GPcNrfnca0MIetUxt5masbFdnCkSs8J?=
 =?us-ascii?Q?ao3gR/4CUY1aAs9xthkMusXUjKLlLZrYyPHCmr/IzbfkhzaVnCjOczFRpbEV?=
 =?us-ascii?Q?JqiVOeppHp10WVbPHCA8m4tJFn3gpmUlYsHtsXpbwyBOWtsSYQokYDpBUuFg?=
 =?us-ascii?Q?KOjPxRgdIsMfs+7H5ot27khWlWcmYYzJiPZc/NOEhwcQQokwb5a9W8c8bDl9?=
 =?us-ascii?Q?f+1Mmeg5zxqOxgNEWUM9HOfkgMGG5qyYJM0WYihDLp34SvptLHZ/xvRiuBby?=
 =?us-ascii?Q?YM5/trOWQcP4+H8ieM1A5RBhEIpK1KajtERqafcxF5o9aKTfma7jaSZ6+kzK?=
 =?us-ascii?Q?W5GNc+Ql4Oty8c96OaizuV0vA5RkmkV9UA5S02B1H4/nGOQ154SraJ14wCtG?=
 =?us-ascii?Q?jp3pUAj8pOpbPY9BUGBgeTRhmOuU9mZ2rZRSMhNIT1hW24FiTN3IRnpV1s+5?=
 =?us-ascii?Q?0k7xbfzMDna5BEzI2TbB36B2dzXk/OleOBLGaOCOh14Awc9+P6UNvDY4PDTm?=
 =?us-ascii?Q?ZnhDldfvhq8uMTdK++ExF37Jfs8AvdgzwFJD5OzqD1mOottmbEMzC2wuS3cj?=
 =?us-ascii?Q?W4VM1G0OrJmTZH882Zody2b6fQj9inweZHFN+DO5QUFt8bNOEpJLsXbk4aHF?=
 =?us-ascii?Q?brvPAhyr9MwkMiMH4+5w3Yn9TmT269cQ6R8pF0LzT/6xvvBXCkP5hN05STLi?=
 =?us-ascii?Q?DA+8grlJqeCKeKRDB0nFXFossVbyBHmRBiwiAVTU8HFQj+km3oVzz12LG77d?=
 =?us-ascii?Q?SGDr/NvgdtWr8bk9StXmZfsjCV/gCfb7Es21nilr7nYEfkIkRZunNMnGarce?=
 =?us-ascii?Q?Qs6q+8QPVAd0q/DvlqYfgt8r7EbmfnxEkyKyqojvwyd86gGVfGQ5y/R4KmbH?=
 =?us-ascii?Q?WvTF5FSY9XmSsab3hivrGVFxjyDbTRj79fSXQx3lvj9tjlkUd25efIsb+DHC?=
 =?us-ascii?Q?O7AfGEJslQUKfEjRe/TukkGm/BlEfDIxbZ7aTLNcnCpc4E0hzkNsqBz5V8z6?=
 =?us-ascii?Q?9ZiSZF4o0bbveyPV5EoFaTkbyQfmyk6OoTh88bkt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schaeffler.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7539.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaca5ea-7a9f-4710-8ccf-08dc2eca5e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 08:36:28.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 67416604-6509-4014-9859-45e709f53d3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCUjlAqyE5Z6iN4+KICMPgKoM6zhyfoFN0xXW2l2nyMhZEPv82VMACsiSAV/3YflmaACO/40YqQvF0MNw/SQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6548

(let's try this again - had html enabled)

Hi,

I think this thread might have died - a retry-logic for git commands would =
be great. IMO it is not even needed to continue the transfer from the fault=
y point, it would be a great benefit already if it dumps the failed request=
 and simply retries the request X times with a backoff factor (just as the =
user would do manually if his request failed).

Any hopes?

Best
Jan
