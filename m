Received: from esa1.dsv.c3s2.iphmx.com (esa1.dsv.c3s2.iphmx.com [68.232.150.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD81CA81
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.150.186
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564442; cv=fail; b=rHV0YJie7J9PgMIFyt9Ry8STcgfMBhqUWNV8u0jb7wFcMf4mO+7W6DJnCahEKy04AOiJvhpgCKaOW+V16u4VA28IFWG+S9q7Km+cxCWWaVJcZf3JaFwH1cOgSSLdIcoQh6ZQGeu5WXIMWc0cC8vHADnTAl0SgQXtA8CB23YjiVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564442; c=relaxed/simple;
	bh=4WSdrDguUK+o/jvs9ZpTAyo2WNyaDOAcDQ77H5JhMvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WrnoX9CVhcEnUPvHmTbWrnf43dlCTkcyfFvwkJK9uAM17JyISUa14yHFgCvje7Xq8+ishO5fPelPuASLA6GHTsU2BaJYso5NwH7xKyEpHAntbWp99uQ+LOsaFiD212EK9TX+6JgY4B1ztB+JMzh2ThBeBWdhdIqSQToBZElXW80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com; spf=pass smtp.mailfrom=dsv.com; dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b=pbHjspAH; dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b=yLmYsmC4; arc=fail smtp.client-ip=68.232.150.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b="pbHjspAH";
	dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b="yLmYsmC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dsv.com; i=@dsv.com; q=dns/txt; s=dsv13122017;
  t=1745564441; x=1777100441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=miADuQ/vy7Ogm2Ahvly3Oo2JgiSdy8SgndE5oT4pQKk=;
  b=pbHjspAH1SiTlKu/WJFqCJJBetWQm2u5L3uMHFnW16364WHy6QT+EiUS
   u2e15ZTwF0Ird0aAiXGjCNgaSWFpCQCb0AXs0zSDVIrz0tmAN7j3NxDHE
   xGJcpItAUIzvHIzjCjzRcnOPJl6kofFU8gpEAQDe+P6naDb4em9417XRe
   m+hfDeZ1k4CNYgdTUDyb8kSvvzqPrxHtG1V6Yu/GVcMwf28ailYz/UrCu
   pIQ8ng0gMn04WgxW/uQe1nMqjRnREQs8gqzzPg3wFr5jc6lm6LkhA8CMU
   oURHcGqV+1mopGUWlO8COI+8MIW8wvyrhwCF28m22uFuh8dQtezK4bTYB
   g==;
X-CSE-ConnectionGUID: xvie831cQi6WQ/Qw5bSxTA==
X-CSE-MsgGUID: LsXelD/USGC9JAih/KKh8g==
X-IronPort-AV: E=Sophos;i="6.15,238,1739833200"; 
   d="scan'208";a="98714012"
Received: from mail-vi1eur03lp2108.outbound.protection.outlook.com (HELO EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.108])
  by ob1.dsv.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2025 08:59:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ9DmzkVhu7VCu+PMGHyObroEqQ63sKdW/bAJBfG6sF1s77hEoRNLmqqrCiG7IXGlBlLRRlsJBUd1LLpToQUl5139r6r5tg6n5tQ2Irr+5lbcME+m1WSdTYnXtDWwpLgugxAf9d7WdMRecEclwtxTTwQdsO6pPOCeGjbkiiRJVCv1LsASZE7u6isweomwvk+pnF9RvYs9XHWh4wulwObssBtYv514y40Yng2fu96JMNVYxBHzd63Kk0gMK70BiJhEBLfSkL8/7XkKLhp+LnxB1T0ApHXT4qhCBKNy70hf2wzzYcO/D4/hOK7K8/sc2u+Tvzu0iSvpR5v7iPgc2o1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miADuQ/vy7Ogm2Ahvly3Oo2JgiSdy8SgndE5oT4pQKk=;
 b=TXWxUFnhWj5VyT+mUJd6Y8D/vFq2kQZ4RFS6wk+FFq9GdkQIsJbVognYabCSnr2mwWJIrdOb7NxXm0blDy/NsVt/a9BMeW8Ta6hw18feNSar01LopsSSWPfW2EDhscR/ouPZEY6+m7hNdITARoT5HRj6Ar8WuZaT3TwPLE49Z1pO//LipuW4St653jK3uyWfbHFwjla0dDJsz1b7fyP7Zjmoet1UokEhmAeBtgr8k5JyjtMYd2AGWkB7oc9M69QsvxaTcv898faNBWaA9pqaB0BjjJQAySECxnnIa8QP38J2EyH01TN6T12CkGGIl+xuHCZTvxOZCFJp7ikX7PW96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dsv.com; dmarc=pass action=none header.from=dsv.com; dkim=pass
 header.d=dsv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=DSV.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miADuQ/vy7Ogm2Ahvly3Oo2JgiSdy8SgndE5oT4pQKk=;
 b=yLmYsmC4lpoueCcXPoWx7dVZID8Ifj5/NBm2KxjE9KnRDpKYCp/6YvM64+EFcJk3ry8b2eHtKs6kI62UzoiVrbPyse+W3h5pEbFkKLNhSV9zAiMM7NWQYq3GMtaEvrIpSEOz82esja9lZtSl276Y9S+vg6cZMG3KDvPUZ28vYv6HbwUgqYTK8ZfLPUVAogn1suWjA4y1y0PLkXDKXkTA+fdhpQh8ob4wk6NgBvw3dNiaDQGL7Nu3tRm9RYVN3VP4zK8xUgv5vz53sBAw3eEVxfgg2Sux9uAquVPXzhPlJsxVUumAMyKZEjD+4ex9HOdKs0+leQYGYRyMJYGAvACWbg==
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::13)
 by GV1PR10MB5987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 06:59:27 +0000
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5]) by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 06:59:27 +0000
From: Lars Eriksen - DSV <lars.eriksen@dsv.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: cURL in git for windows does not support HTTP/2 anymore
Thread-Topic: cURL in git for windows does not support HTTP/2 anymore
Thread-Index: Adu06jewhtBLBy4JSwGSMq19l6V9JwALYJ+AACXcI2A=
Date: Fri, 25 Apr 2025 06:59:27 +0000
Message-ID:
 <GV1PR10MB76004ED8EC327A2D11EDD2CB9B842@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
References:
 <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
 <1cb70ac5-31ee-ec1b-dea5-e900f28a38f2@gmx.de>
In-Reply-To: <1cb70ac5-31ee-ec1b-dea5-e900f28a38f2@gmx.de>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ActionId=0791b03a-8cb4-4728-a5c3-51d208e3c735;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ContentBits=0;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Enabled=true;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Method=Standard;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Name=Internal;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SetDate=2025-04-25T06:56:27Z;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SiteId=4a90c23a-3ece-4ef2-b857-522f23b8204c;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dsv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB7600:EE_|GV1PR10MB5987:EE_
x-ms-office365-filtering-correlation-id: c32444d4-cf08-4a08-57a8-08dd83c6b81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6MJD8Np2h43NrgFwX1rttpqMbhMAjreeknh/YG+6D0Okc9E+YWo9+rZd2ZER?=
 =?us-ascii?Q?tvWo60wadumHAH59ilzo7Db2lHArzTFAXIewD1yZYTt0f024qlG1nI81AOMl?=
 =?us-ascii?Q?fbUMb8/jCzAJHgDzVEPwAjXZ/yJBvQGTHqSk+cNHOhUtKfsYNQDT8mEtItb6?=
 =?us-ascii?Q?hGpIfBjSB5uRgNbmYV4ZynZShsLRFB+wFVyjruxZ2+boU2lA2j03ZP2oTTVB?=
 =?us-ascii?Q?euMNyR6aebNh4Pc87i7mavKatSjqWwVxW8E5sWjLL3TPyL1ymzh6DBf055oB?=
 =?us-ascii?Q?9y1R/d1jXEvdvzXJiL5YN6TBCUEhlNr+2nCorAYKp2dJilVF8wjRFhvOxlQ9?=
 =?us-ascii?Q?Z59MCnCVQ3pFZm2iLPIC9HAZgEBV6bLNfExwb3Pw2rxSkk24/p5o/Zodh61O?=
 =?us-ascii?Q?LziuMnDXtElPwLphU2Wtdy+nVbANhE+CdUMq23QcI5YJxk3VNi3PazGfTBkk?=
 =?us-ascii?Q?YRK8V36s6v8OSsye1uDvTlv9edX0z/qty16BNK1n/hGGqOhJuDhoDgNkWY85?=
 =?us-ascii?Q?GkWOZurRPRW8cRinr/eXdvQm+DhXXGsqPT2lubpwd8L7+cvhI9JqZLUyEP9q?=
 =?us-ascii?Q?U3EaAZnJYOGFYSdseT5WxqVViolwxDgae1Fux6gStk/tXD7aenqQ792LXG/m?=
 =?us-ascii?Q?OirEv8I+ad4AsLBuTRC0kOMEXBt8vW43nS49PythNkkHb+M1m/lD8RhDabv1?=
 =?us-ascii?Q?DH3Dl4rtzCtWg1jydkXo8UTkUZYBgWKKInT7kUXu4IoztcZGZMZus1wWpJ4D?=
 =?us-ascii?Q?jfCPVQPSxre1kBALlyHGT95aLo3SezJpBWB6XbW1lhgihWJB/DdS/XBxBfOE?=
 =?us-ascii?Q?Vk7ySEl/Ch5yaJonIwzmoBEO0OKjOehNSUrpzBAtSOoXGbVc9RpYQzn8knge?=
 =?us-ascii?Q?FH/id0CwLuLb3n7iYlFzxGcm5gTydLcnPZdlBDH3C/JiN90MGhXwuP8FdcZn?=
 =?us-ascii?Q?ZFD/06tAypNSfpvGR44aG5bQ0uScfh9rYY/xmdJgodLYKZSBlT2uN5s2S6QS?=
 =?us-ascii?Q?6WBY03GArslWsZu16BcSBSaxl9Gheiu/PG5/uXu6SVbiIqH5rt9GLK1tSXcb?=
 =?us-ascii?Q?pmJPVI25tzjeQ7nKtz32M2kb+ujd1kdYonb/2gkxL9gNt2HJvumNrwoaRUcE?=
 =?us-ascii?Q?eN6qkfqIEshOq3Hu5avWyxVuUPTxnM6zELws4qkFgDlX5iWiVFuwqc111oo8?=
 =?us-ascii?Q?ZhMPLfWXHwLUaQ53DsUzH0OM3A80LzzyLmyJRXJiiRpEMQIOvqGCdaIBI9Jd?=
 =?us-ascii?Q?eHbXbV+PWgJzxtDf3vVfNWC3uCCIV3eIOGOddamkasZdEM+7nxDwaNUN/W3y?=
 =?us-ascii?Q?HWYSJyPKYkwofEerStzpKrnRoj+KXl6SqDYET3jAOXwUhIENUpPlgagqMx5h?=
 =?us-ascii?Q?NZVEuWY4MUuvSsXpbk8ejFSCGFXsI4zAk2AvL5MLpwunluS+EPg1icQgFfNq?=
 =?us-ascii?Q?rxsqNHRCYX4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EdMwaplnVbLFXI+76zWC83WXKAVvIYuQjQiuQFCnp4tC/n7q439JkcAx2WuL?=
 =?us-ascii?Q?FW+jmMaDgL66QA2J4HZrsQN0mpTYCxAEvF9EViN/9oV3IAGG690y+dshYU6L?=
 =?us-ascii?Q?5r4c6oq5V43wQ+m9EMIQWUQWKeqi5r4N3jjCNv5/2fhUxOpPcZOVcYYKgsom?=
 =?us-ascii?Q?nKLNNLxN3UXf26uMVoB7CQP55PVeCxRMzoTTJg44W7w7243B8Vt9UPbe4ZVt?=
 =?us-ascii?Q?ygiUdq0IbyTR/czbommlEUSmOD3Z+sJGOOeQjgfO6JJxxNQUSzhNpRunEZ54?=
 =?us-ascii?Q?H7FcpZM+0sLOT6nObzkWcJG6XSUcXNRC5Luvb7k4M7h0OaFXuqzphcNWZaTe?=
 =?us-ascii?Q?bM3DWP0jeTDx7nrKIlvQmHv8/sLfQNhcZGgQaTDFaI/A3M9QBaX/uCDPJtmf?=
 =?us-ascii?Q?Jkpv9iksn7pBpEdjqf7/oA35ZEiLR+8J2p2SsUI34/ssaIMTdkj8/b17ilDe?=
 =?us-ascii?Q?dc8tl1EiRvj1NvAmX2jcjIFlpj9P0MxhYpxn0+wzo2mtOa3Z3hUMQSUzJLeZ?=
 =?us-ascii?Q?bOuXzd33W8Pv0CgNCrdiqUDyR8jzfdwsm4x7acFrOlMw1L1OvnnD6EhhbXpL?=
 =?us-ascii?Q?XC3kh2CCY7iTkWgcoORrMDtBA87Z419B4T8+DPns7dSTPD7+OBpdmM1p1nv8?=
 =?us-ascii?Q?fCcAdQ7VP4NHOSrj5WQ8z4STHzrgqoG1pkV0/RRk57614e9QEqw8cG2LVIX3?=
 =?us-ascii?Q?7nYRBs2bbcEDf/R/51oFtdG82DMjc7ncODShW9suI1zzSD+OHv47SvcWmAdT?=
 =?us-ascii?Q?bUpC+M15skgbNnTRyoWWaYx/HJe+dKTNW/4nEKW2nLbg5Zk3GROAf8nJgqpQ?=
 =?us-ascii?Q?iuO7pD/NUzSZFmeo982VpzM816/icXt/OnbSdRmMJ2Oys/Odw1jjfe3mzHvK?=
 =?us-ascii?Q?guf9qxbO+sxPiKesknf3UJWbimiW8FjLsddKMhM3nZ0Wl2RqNzh5IY5o2WbK?=
 =?us-ascii?Q?74wQEGvezpzc9YTx1PjFq62YOcBKa/8SV6jTcZhxg16tkhSc8GhHF4omIMOH?=
 =?us-ascii?Q?oYM6sjok14dAHXuycQBEF7qBDpLhXjx/EYcoDzCERVqR/xwfDvUy7bjevtTU?=
 =?us-ascii?Q?sQ5W/IxiH7A3/4bh7EHdJxk9mlRvMhy8wDWTs6XwEvM8SXeSXMjT0pcCh0da?=
 =?us-ascii?Q?P0DaNxGibjefR3fyGsTqJrAGPioo2j6P5X10/AaQkAGP283fNERgd2IG/3ix?=
 =?us-ascii?Q?0ygQdZ01+I8wKzKFpS4wt6uFWWQ6acqfFVvl0J7hR/yulmwkakNKOCXla6TB?=
 =?us-ascii?Q?0I6MM4Yp4iREnAzI3WqauU7fF46LOvIK+FQqcYRCJeWRjLNlJ+aYWc4M5lPg?=
 =?us-ascii?Q?9HIag3Igug2/RZjfa0MlWNTHSEmz+yQ0UDZ/zBiIrMfyRO4ZaftswER09ccK?=
 =?us-ascii?Q?DwjT65QVPlYK3GTkyrTpRJ1digIbBP/JjOHH1RNnDtZh92QMP+V21qTXaU/j?=
 =?us-ascii?Q?+2myXuErjyPdIN9wLPHnr2PdfmIggRVIoLErD2trK+xHHPZeRXeUklyyRrag?=
 =?us-ascii?Q?cR/TbELbe/nOTnDHso9NAvKJLK4m0vDVLLxAkVduG7SqMFwknv8a7XEwYxqC?=
 =?us-ascii?Q?F2EpSYzQpeReRl5kez/h7xP0WA4Br2x4QY8EpZ1e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ritEWZatQvXCTQbAJlD/+vwOv/hmWsOna1izwBJ0/F5LjApyMJp5E6Fsh4b1VJCUhTrIRDxpkXhgMTMWK0a/ViEFIalGfdgmdS/J3TgMmwGN8JYA9xGXgqbuUetw8AlA7+iVmil+QZQcJ2VoRyueqhsIme5SuUwNU7f+eHZ/IuOa5OUyVmityN4G/jxqXt78kp8sdKRpLbMbgYY/btqO2r5HONLFAVku3ZOcRkwOIq5FGjTOsRK6qXaghNgfSYIA1dG4WRRNsOP0jwapN9XnSogczjzwvYNR3FMuEzpz+GNg4HSzb6SL2aV83DrSaO1UXTPQeOeUFYbYqvJaOH6hEic8n6SXydyT1/HkE4NEjojWjTvl5/MWLI8zo4igV1Hu/t4ndD/MXXaXLJ3PbTpLU/c7cpGMaFQr/9+l18sskjJCItctahlSPaASTnDyah7YmMpKjEMELZeah2gum19AhDvXX2McPz0X+Ngb4cnJRaq9owa64xyMsV0gNCrV0j8mNgL6A3+atWZp4clC0Elaszuu1Qd7/jr9o30Hl4oEggHo8NziszSpMdn2c6g6ooYCSTqv4960Y+C9x2gGAONN6fJwOzgTm+FEwskHYpoh9/kTeZTGeYJF4wnbFeLMBeQKU6BiOL2QGJJ8m7ZRfL1OshLuwZ9xFrwjvU1EhkUstxItqfKfV14lN7LCNItAPl8c
X-OriginatorOrg: DSV.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c32444d4-cf08-4a08-57a8-08dd83c6b81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 06:59:27.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a90c23a-3ece-4ef2-b857-522f23b8204c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fqq7kYaKHWXzIhEBfnNBY3PfB8vla03fozyb3aNoNlyqla6K0Lxp9tkUGIi7xf9hFvdmUkVPZSLDE5/5ombWhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5987

I'm sorry for the confusion, but the problem is not within the git command =
itself. This works fine. But we use the distributed curl command for POSTin=
g data in a custom script when we deploy to production.
So the problem is with how the curl command is built for windows. It used t=
o be built with HTTP/2 support, now it is not.

Best regards,

Lars Eriksen, Senior IT Developer, Regional IT Services, Business Services,=
 Northern & Western Europe, Denmark

lars.eriksen@dsv.com  |  Mobile +45 22423380  |  http://www.dsv.com/
-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sent: Thursday, April 24, 2025 2:52 PM
To: Lars Eriksen - DSV <lars.eriksen@dsv.com>
Cc: git@vger.kernel.org
Subject: Re: cURL in git for windows does not support HTTP/2 anymore

External email:Be careful with links and attachments


Hi Lars,

On Thu, 24 Apr 2025, Lars Eriksen - DSV wrote:

> What did you do before the bug happened? (Steps to reproduce your
> issue) Upgraded to a recent git for windows found here:
> https://git-/
> scm.com%2Fdownloads&data=3D05%7C02%7Clars.eriksen%40dsv.com%7Cdcb13a0b68
> a34bf77c0608dd832ede41%7C4a90c23a3ece4ef2b857522f23b8204c%7C0%7C0%7C63
> 8810959515529466%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
> iIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
> %7C%7C&sdata=3DOwOqEgoRvwGZjDPsVIIDOUZ9HSWuC7IKHVbfiPzKP8Q%3D&reserved=3D=
0
>
> What did you expect to happen? (Expected behavior) The embedded curl
> should be able to use HTTP/2 against our backend.
>
> What happened instead? (Actual behavior) After updating git for
> windows curl is unable to authenticate to our backend that requires
> HTTP/2. curl --version shows it is not compiled in. It worked in the
> prior version, 2.39.0.windows.2

Careful: `curl.exe` does not necessarily show the same capabilities as are =
in effect when using Git. The reason is that the default SSL/TLS backend is=
 Secure Channel, whereas Git can be configured to use OpenSSL instead.

And looking at the most recent build of Git for Windows' cURL, I see in
https://github.com/git-for-windows/git-for-windows-automation/actions/runs/=
14221753030/job/39851304688#step:16:1230
that the OpenSSL version is compiled with HTTP/2 support whereas
https://github.com/git-for-windows/git-for-windows-automation/actions/runs/=
14221753030/job/39851304688#step:16:2854
shows that the Secure Channel version is compiled without HTTP/2 support.

When you configure `http.sslBackend =3D openssl`, does it work then?

Ciao,
Johannes

P.S.: The bug reporting template of `git bugreport` sadly omits useful hint=
s such as including the contents of `/etc/install-options.txt`, where other=
s could easily see whether you chose the Secure Channel or the OpenSSL back=
end as Git's default.

>
> What's different between what you expected and what actually happened?
> I expected curl to be able to run as before when contacting our backend i=
n our maintenance scripts. I'm not allowed to install a custom curl on our =
corporate network, and the windows version does not support HTTP/2 either. =
But the git version used to.
>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.49.0.windows.1
> cpu: x86_64
> built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.12.1
> OpenSSL: OpenSSL 3.2.4 11 Feb 2025
> zlib: 1.3.1
> uname: Windows 10.0 20348
> compiler info: gnuc: 14.2
> libc info: no libc information available $SHELL (typically,
> interactive shell): C:\Program Files\Git\usr\bin\bash.exe
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>
> DSV internal
>
>

DSV internal
