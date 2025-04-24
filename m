Received: from esa2.hc2065-58.eu.iphmx.com (esa2.hc2065-58.eu.iphmx.com [194.165.193.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47A38382
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=194.165.193.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500460; cv=fail; b=V+fKoB7axIeP4ZWjpaljforAqY2TIGI+a9c6pcK456x9OIgbXx8luJFIzohh6lCxdyYp779UV2a4vH1MaCTnD1JtDC6tPDnWSW8vhbOQDWutnN97uh3UjybKJU6IBAXQk8gE1wx6YLPrx55lAZ8ydRZuR0E8s1N2XI77bRXxi2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500460; c=relaxed/simple;
	bh=DcQaPl+6yjA1wtpLd4ShEYSYXM/8aEaMrC3q4LT2tvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpUZlB2ITtbHsRePm7ac62T42Rc5GK3lbu6vyTy9zWA3e6srVNnuFEqFI8p0wFCULS5bPXZlagRxuN1bz4nI2f2Mt9yaIW+BrhO1FF0WRmOShhm53XvJ+vs+X5is2poB4PkfE94cnMFWJTeXeyElXVgE82JaqdnSxnN4AOAjS7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com; spf=pass smtp.mailfrom=capgemini.com; dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b=i8yRKn7f; arc=fail smtp.client-ip=194.165.193.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capgemini.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b="i8yRKn7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=capgemini.com; i=@capgemini.com; q=dns/txt; s=group3;
  t=1745500451; x=1777036451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DcQaPl+6yjA1wtpLd4ShEYSYXM/8aEaMrC3q4LT2tvs=;
  b=i8yRKn7fh/9aw+bFcW/hsjj923m6D2yNPeGa7S6ZyfVKd4HBTPAmyP8B
   894OSr46em14CWVKGnVuNLiHe64YIuLoERt3CgY7YmJ6C8H5K7KqHSH6Q
   azL7MrzANiaGO0yPBv2cv1WGJiI7Sn41mUOZNmQmclW7la/DhS6n7hK3i
   tZg1Pzau7yFTmES6qXZSjJkr2jPd47jAfro4tYFusZLsJhbSOdB6o1sDX
   zH6Kcn6Xe7HCDgY/ZhYOgDkDspahfHS/GX+eaHmuBEeEwTGeqhJRDkNeX
   +DMVqQ+kUKQCUu/HC4D8NPylrtexWSIzVwxQZ/grzJFfTx10NDhCAgVHC
   g==;
X-CSE-ConnectionGUID: HjvXV3kPThO9FNve1P1cLg==
X-CSE-MsgGUID: Zz53ZdOJT7KRXS5f6zlcmQ==
X-IronPort-AV: E=Sophos;i="6.13,221,1732575600"; 
   d="scan'208";a="21992696"
Received: from spffrpar02.capgemini.com ([194.4.230.74])
  by ob1.hc2065-58.eu.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Apr 2025 15:13:01 +0200
X-CSE-ConnectionGUID: qPm5C8kESZCbtVuqgaTSUg==
X-CSE-MsgGUID: DtBdU1pwQz2nz9qXjxx/nw==
X-IronPort-AV: E=Sophos;i="6.15,236,1739833200"; 
   d="scan'208";a="376453598"
Received: from intdlp.capgemini.com (HELO gddlppraplv02d.corp.capgemini.com) ([10.247.137.140])
  by IRFRPAR-C695-02-D2-incoming.capgemini.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 15:13:01 +0200
Received: from GDDLPPRAPLV02D.CORP.CAPGEMINI.COM (GDDLPPRAPLV02D.CORP.CAPGEMINI.COM [127.0.0.1])
	by GDDLPPRAPLV02D.CORP.CAPGEMINI.COM (Service) with ESMTP id F36B0600E026;
	Thu, 24 Apr 2025 15:13:00 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown [104.47.51.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by GDDLPPRAPLV02D.CORP.CAPGEMINI.COM (Service) with ESMTPS id D2CE5600AB36;
	Thu, 24 Apr 2025 15:13:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrQCrEhJsPTiz8LpG6RZuBlsZCcUlrFvoOPpYmyhxVWPCPMkpCNOBEYRtl6mg44zE46pO8C2pYQgW0eQ5jP50s9bt+knvYaFlgL0dKyRmcCvPXQAK8kibkOfCdMmXamY6cpsPRq+/+/fn13rlfvyE0Y1ijn6oB0u/vQLlcDrWIXcgYjNqHWrluNlo5xdswtI0ThskvZAccqPokev1JqEkPC2mOwDy9yMXsTeur9fwl5qRnWX2OPPdqTN4tAMrVzGcc6OxvkhHDKeHDfSZlDnIQl+bJ9EMZuAGyiwqWMEOAJH4tbnPueeoaic61ohwkbyU054vXOFZuAmdK0esjLVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcQaPl+6yjA1wtpLd4ShEYSYXM/8aEaMrC3q4LT2tvs=;
 b=YxU+PeozC17ryXEQGcy6bYM2s1zV5wlxaoiBPsHg4ZpRc2VtttW7nf0l1vrFn74uuH/P/QjLgYav6EVPxFlYqTStm6G9rVibQIM/A+s404KBwYWsXq+FE5ZQ9ug5eezeQb7CmEvxI9nJRXkn6sbZbrMSU+6c8lbDZGZoik5jZByYcWg/z7yK5Zz5gUVQ4FHVrxCqSgMVPBaPjn97G+XZP90DzgsLEm5kBf4i/KrQvrYDadUUj+US5A2IM5RQFO/IeP5uo2OnSUq7SIiNn1sOI3DjgZztpBBtVRhEj2cfbxuHEENB/Xc6DHtlQiRIW8m02c3z9BBSVVWwacUzES9Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=capgemini.com; dmarc=pass action=none
 header.from=capgemini.com; dkim=pass header.d=capgemini.com; arc=none
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com (2603:10a6:800:193::8)
 by DB9PR02MB6780.eurprd02.prod.outlook.com (2603:10a6:10:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Thu, 24 Apr
 2025 13:12:59 +0000
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7]) by VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7%4]) with mapi id 15.20.8699.008; Thu, 24 Apr 2025
 13:12:59 +0000
From: =?utf-8?B?SG9od2lsbGVyLCBKw7ZyZw==?= <joerg.hohwiller@capgemini.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Topic: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Index: AduMRF1FlKoLPIQySq6CTv27PYhTgQW2LrCAAGlPe7AEFfWrAAAACbnQ
Date: Thu, 24 Apr 2025 13:12:59 +0000
Message-ID:
 <VI1PR02MB6495D1DDBF55288A5C75B15CFB852@VI1PR02MB6495.eurprd02.prod.outlook.com>
References:
 <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
 <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de>
 <VI1PR02MB6495A9779866FD337F2F8E1CFBA92@VI1PR02MB6495.eurprd02.prod.outlook.com>
 <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
In-Reply-To: <a81435f0-f09d-9197-9776-2402457fdef0@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=capgemini.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6495:EE_|DB9PR02MB6780:EE_
x-ms-office365-filtering-correlation-id: 7ac42bc5-41aa-4703-dc82-08dd8331bc88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vi93UHNEQ09IWmRFSEM2VmtodDduejVaRHNZWUsrV1draUZ4M0dMbUp5VDZH?=
 =?utf-8?B?dFpvSE11OE8yTlV1TmwraVhidVJPSjBIb2MzSFNuQ2ZMWFdrdjBZN2FheVFF?=
 =?utf-8?B?T1FkWmdLRUJ3WWxLa3FxOWNwS0pROGlxMS95QjQ3WEF4SldRMzB4dlRURjlv?=
 =?utf-8?B?YzFCdDlxWnF2eVdmaWt4NlRJM3JtUEdVUTNJalFCTmZweXBGN0wvcDRsM2Z1?=
 =?utf-8?B?dmVVRTZzQ2M2ck5FOE5JaUFBbHlBUnNtdDhKU1dYMWlKcmsxZFdCSnlRRTZx?=
 =?utf-8?B?RWJhbVlIOTBpdU9veXllb2w0R3lzTVZ2bmhENWIrVUt1UXBHWTZjYXJnZWUr?=
 =?utf-8?B?QVdRVHowZU9qV3lNb0dSMlgvaWowVUxzSlBqUzZVUkpScG5PcE5oaXNqQzVX?=
 =?utf-8?B?cjA0S2czc0I4N003SUhEbjZwM0xrZVBGNGhSbTJqWXZURXVuN2o2MUh4eEZM?=
 =?utf-8?B?ZGpTYzlvaDhWVDgzbHF6Y25pd1FsVlB2SVNDaDNPUTBmam1maGd4QWI2RHBR?=
 =?utf-8?B?Z3RyQlNQeHFobFFodVNYOFdYcUlJYjBxUTZSR1ZzQU0yblQ4OC9WZjBHWkhF?=
 =?utf-8?B?MXhUN29PbHdLaTJVbEVjbXFIcmFiNTlhZEtXZk1QM1VWakZHQlYrSUhGQTh5?=
 =?utf-8?B?dGs2VlEvVXJzWWVheTJpYjBRcnhiZmcwTWZWYXl5ZDFpRm9jSzU0VUdsTVVL?=
 =?utf-8?B?a2JWaVQ0aWtRT1IvU2piWldxTU9qckhERzlVMDlZL0l0SndZRjRFVkdDZllK?=
 =?utf-8?B?Y0NWMkdwV0dPcnI4UmlxQ2dtcmJOWjVJNWdOSnNuaTJnVUF5cWxWaDUxRk5F?=
 =?utf-8?B?d3BmY0JVVXhyL2daUFg2QlRMMXFVN04zWU1OeTV2akZLN21TZ3d0SkcwTGlN?=
 =?utf-8?B?bnJPZUpZaWtEYzJZV2dOeTJ5R0JBQTFqZkUzTUQwT0lKTENTYnRBcWlxK3lk?=
 =?utf-8?B?cHE4M0hHd0F4QkxzZG9KMTJnVThwd1o0OHRlajZna09sQloreFUvZGNkQ1M0?=
 =?utf-8?B?a2l6TEZpL25leVBmOCtwZnlkYlpNU1VuUGpiMURNbnVXLzQ1RG9zK0JjbzJV?=
 =?utf-8?B?WGUycC8yc1dNM0dUWW5vMFJ5Y1ltWDNkR1MxUWNNaUxEYmhYRlFNazFrSDJh?=
 =?utf-8?B?eXFYMG9hZXp3ZXdXR0Q2QlVqOVRKRitMb0lqM1lzNzg2dHFodlF3WCtsZXdl?=
 =?utf-8?B?SHh4OGlNQS8vdWdENXU2OG9OM1ZSTU80TDhzcmhlZkdlcExPTEF2UFhqMkJK?=
 =?utf-8?B?TWdLWnY1YS9pd2Q3UnZjZjZKM0tUcXpiQnJzai9LeTBPWWVLZXM5YUh3ejVD?=
 =?utf-8?B?elRBZDNsOEZSQnhCREdnbmZKVWdDRXMwRzJHQ3ZscDdDbWVGR0lVN2pzY2Zx?=
 =?utf-8?B?WWNtTFEvcnUrNTYvbmVyaWNLV2VIZGI1VkpMMmpEWTl0UnBacmVMM0s3TExY?=
 =?utf-8?B?dzZqcExPZkNvMTg1a3JRdTF4MWNkZnFYWkpZMnQ0VkE5WHc4aVpBV0JORjdp?=
 =?utf-8?B?U2dhTTVIVWFHQ2pSTGVoS3BNbWRoTkVYYTFIMVMzSDhIQUgxbURuWHNmd3NS?=
 =?utf-8?B?OFFjL3VJUGtwMmtnOHFkV0JaNnB1SG9BUGIzYnBoN1VHS05pZ3lJd1J4V0Nz?=
 =?utf-8?B?YnloZ0lwVXZMNmtmMWg0ckFtZERIZUxOakZYd0Q1eGY1eVdFMlBsWmlzd1hK?=
 =?utf-8?B?WUxiWTVVTmRYVVhZcFBJWk1qeVpLaUZVRDRtck95UzRacVo1cG1hQi83K1V5?=
 =?utf-8?B?OStOb3RYamFGRE4xL0VvRE50ellFc3h6L1dZV2pHZWs1dTJPVnRWUTRkU2c5?=
 =?utf-8?B?NmFVK09QV2hJRkZJVGdsMi83dnZxSTZsL2VzZUVnYmdhOExpa2JDM2p3K0N2?=
 =?utf-8?B?V2MvVER2WFBKR1o1Rmh6R0lHaGZXelE5d3VEZVFVZ0RpNGM1UHNJYXBlRm1u?=
 =?utf-8?Q?tcxGIBqUTx/RmwyXl2BAOBn3q++xfwvP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6495.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHhzTTZFOVJoS2dxeXM5RlN1QnhBRzh6cXVxTkdiREcxcEJtUytGSWlrSmhV?=
 =?utf-8?B?c1RHUEFZZlo3L3pjTXVRYWlQMzBIZ2ZpRkF2OUI1NzVKVS9YQUIxc24vV05q?=
 =?utf-8?B?MTNna2JqZEw2M1I0REFpQnd6cDhpbFJrVVZ0K1ZlbXE4RllPQ1RlLzE0V1Ri?=
 =?utf-8?B?anY0aXpLMnFFLzVGUzZteHpudzdka2VaL0VDUU9vdVlqdFJFK25zVjc0WFEv?=
 =?utf-8?B?NlZadGN3OFptLzlNUmdwTVE1SFV6S005Y2dMMmNENksrWXFSQnAxNFZjVEZU?=
 =?utf-8?B?Q2RzTng3TjJaaFNHUjNHYWFpSG5OQjFQNyt1QUtNcTFWMVdNc3JMQ0ZVL0x3?=
 =?utf-8?B?b0VvSER5Y1hDTTdLMGN5OHc3TXlqMnhxaEl3S21RUC9sWEZYTG02NGRydmxK?=
 =?utf-8?B?ZXVNNk9ITklNQlBERkZNQU16dCtxQW9mWnVKZjVCb3d5NndFTUc0QjAxVkJz?=
 =?utf-8?B?YnRGOGVxdXN2L0FHQVBUdE1lM1Z1NlhLZ1lJd1p5RURMdkRCb1U4amhldWFs?=
 =?utf-8?B?b1dzczU5bmcrSEZpTmNBWkp2TWpGdTYrSDZxcWVZUFJIQlA2TXkzNEJKb1pp?=
 =?utf-8?B?TUxPZEJlTy91K0xSQ3labU1FY3lMb1dSYXFycW84amlyWmxLYTJnUCtqY2Zp?=
 =?utf-8?B?N1JqcGs0QzUveGpPNWNHV2ZFeXVzOU4raXh3cFoxdGlLNnl6NVdlUXBOWVdD?=
 =?utf-8?B?RDNadC84WDV3UHVqb3AxRmFEZjhxMlozRGdQd0R3MC9QelFxSllac0dhRmtm?=
 =?utf-8?B?WTZIcXNoUkkwUVc3TUYvc094clV6YXNPeEZOSGt2UmVKOTQ0aDBpSzdQMlAz?=
 =?utf-8?B?MnpyN2pKMko5STJHekhQU3d5OU9ONVJKMEZRc0Y1blp2TFZWdlg4YnMwRnRE?=
 =?utf-8?B?SWZvR1FMdGE2cmRucm0yTlRNVFIyYzdLL285S2x1M2xRb25jZSs3OXI5NjVj?=
 =?utf-8?B?bTFrMjg0eHJ0WmZ0WTlGMHRNUFh4NlFTdnNnV1ZOUHZLWkhNb3RjSGNPdytS?=
 =?utf-8?B?U0FyRHk2YllwOVRTeFZLOFpSbFJmeUVjb2JrbnU0UXJqOE9CMjZjbjZUMTlX?=
 =?utf-8?B?aWtqa05aVzEvUHp6R3ZoUmUxRXBPV1E1OTkyeEVhRzVDdmZyZWxvbnFZMkF1?=
 =?utf-8?B?N2xvODNxSUZBYUY4S3haLzdhSW5rbTkveStERTc3aisrNnM2SGxIdFdGNDNn?=
 =?utf-8?B?TEsrdVpwWG5adm5nemV6Zkd5RmxjVE4zdXh0WVluOVBscHFEY0ZmY05LR3pm?=
 =?utf-8?B?Y042dzhPS0xNdm9MN2VYVmhEMFVKREFYUDZ0SXNVZmxyRjhNaXJub2RDbDgx?=
 =?utf-8?B?NWN4YlNPL1RCYnJGb1Rrd3pUVU5GS1JqZFc0NWFvVDZZSW02UWp4WUp2am1O?=
 =?utf-8?B?U01NTk0rSXlWWlB2UWdxbHkybXBOdFJhcDM2VUNNR2pMa01FR2dYZkQ1c1pj?=
 =?utf-8?B?WHZwbk1nL3JJSFpwTzJQVElEWXpocUVUbWZ3QW1Mb3UrMXZuSXBqVnZQeWF0?=
 =?utf-8?B?R0syRkdKRFdGRkhIZmtVZ2lvNVBHMEhpM2hheDFrcmllVWExeEtQR3JETU9S?=
 =?utf-8?B?VUwybTh0a3pFSnVrMGhtTVhWNGlSMzRJZW41NUJ0YThScCtTWlB0b2wrQVJu?=
 =?utf-8?B?OXZQU0NuMzlUczlqUm4zelBBckFGUVJ3M1JSQk9yR2JSNDNJUU5tc3A1ZnRw?=
 =?utf-8?B?d0lYNnRydkpHem91Y1QrYjAwZEhBZTU4U0t6NHo1blgwV2VVQ2xITy91M3NH?=
 =?utf-8?B?dlNoYUs5UnZXWlQwWnFFT0ZWNnNuM1BrVGlHVkU5OGp5SWlnOXV3WUIxbGtz?=
 =?utf-8?B?NmFBVzF2aklqZTd2TjFIeHUwdTQyYm9ocXUweUJXTXNVN0swMEJ6RC9UTUV4?=
 =?utf-8?B?NmkzM3FERkRPVy9qQzc2R3BpbDN0VGpRRUxsOUdOVVFFYzE0NmNkMHFPSG11?=
 =?utf-8?B?RU90Wng2ZmlFN1NrcXJ5N2pZbnF2a3p1N2NpTTlhOXdmaEFOTWwxL0FmQ2k3?=
 =?utf-8?B?Z1BPNjR3bWg0T1FXbDRKeU9NaHNXN1lTeFR1aFVQT3FvMHhENEF1VWZZNDhJ?=
 =?utf-8?B?SjNqYTkrR2NOaWFXOWlLT1dYRjFSTnh6TTVFMjlMVlA1WFFjYXhRNmt0Vkl5?=
 =?utf-8?B?RWp0d08zZWhHN0p5VmdSTG9hVlFqb1QxOEx2YWxKbkl2RjRKTGdwQm0xcEhU?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: capgemini.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6495.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac42bc5-41aa-4703-dc82-08dd8331bc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 13:12:59.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZAYzbxg0hs2gddK6VobWWLvQ+PfaJ/13RmK1bQLpUYheHP6CTVI0Nn6HnSVSCwz3potroUiRT2iv3pH05vTkZ0am2yvEsJFHXK+lA9GyTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6780

VGhlIGAubG9ja2AgZmlsZSBuZXZlciBleGlzdHMuIEkgZ2V0IHRoaXMgbWVzc2FnZSBvbiBhbmQg
b24gYnV0IHRoZSBsb2NrIGZpbGUgcmVmZXJlbmNlZCB0aGVyZSB3aXRoIGZ1bGwgcGF0aCBkb2Vz
IG5vdCBleGlzdC4NCkkgdXNlZCBjb3B5ICYgcGFzdGUgdG8gdGhlIGZpbGUgdG8gYXZvaWQgdHlw
b3MsIGV0Yy4NCg0KSSBhbHNvIG9ic2VydmVkIHRoYXQgY2xpZW50cyBsaWtlIGdpdC1mb3JrIGtl
ZXAgc3RhbGxpbmcgKGV2ZXJ5dGhpbmcgZ3JleXMgb3V0IGFuZCBJIGhhdmUgdG8ga2lsbCB0aGUg
cHJvY2VzcykgZnJlcXVlbnRseSBzaW5jZSB0aGlzIGdpdCB1cGRhdGUuDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb2hhbm5lcyBTY2hpbmRlbGluIDxKb2hhbm5lcy5TY2hp
bmRlbGluQGdteC5kZT4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMjQsIDIwMjUgMTU6MTANClRv
OiBIb2h3aWxsZXIsIErDtnJnIDxqb2VyZy5ob2h3aWxsZXJAY2FwZ2VtaW5pLmNvbT4NCkNjOiBn
aXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSRTogW1dpbmRvd3NdIFNldmVyZSBwcm9ibGVt
cyBhZnRlciB1cGdyYWRpbmcgdG8gMi40OC4xLndpbmRvd3MuMQ0KDQoqKioqKipUaGlzIG1haWwg
aGFzIGJlZW4gc2VudCBmcm9tIGFuIGV4dGVybmFsIHNvdXJjZS4gRG8gbm90IHJlcGx5IHRvIGl0
LCBvciBvcGVuIGFueSBsaW5rcy9hdHRhY2htZW50cyB1bmxlc3MgeW91IGFyZSBzdXJlIG9mIHRo
ZSBzZW5kZXIncyBpZGVudGl0eS4qKioqKioNCg0KSGkgSsO2cmcsDQoNCk9uIEZyaSwgNCBBcHIg
MjAyNSwgSG9od2lsbGVyLCBKw7ZyZyB3cm90ZToNCg0KPiBUaGFua3MgZm9yIHlvdXIgcmVzcG9u
c2UgYW5kIHN1Z2dlc3Rpb25zLg0KPiBJIGRvd25sb2FkZWQgYW5kIGluc3RhbGxlZCB0aGUgbGF0
ZXN0IFNOQVBTSE9UOg0KPiANCj4gJCBnaXQgLXYNCj4gZ2l0IHZlcnNpb24gMi40OS4wLndpbmRv
d3MuMS43Lmc0Y2E3MWJhNTMxLjIwMjUwMzI2MTIyMzA1DQo+IA0KPiBIb3dldmVyLCB0aGUgZXJy
b3Igc3RpbGwgcmVtYWlucy4gSSBjYW5ub3QgcHVsbCBteSByZXBvIHdpdGhvdXQgdGhlIGVycm9y
IEkgd2FzIHJlZmVycmluZyB0by4NCg0KSSBzaG91bGQgaGF2ZSBjbGFyaWZpZWQgdGhhdCB5b3Ug
d2lsbCBuZWVkIHRvIHJlbW92ZSB0aGUgYC5sb2NrYCBmaWxlIG1hbnVhbGx5LCB1bmZvcnR1bmF0
ZWx5LCBiZWZvcmUgdHJ5aW5nIGFnYWluIChpZiBpdCBleGlzdHMsIHRoYXQgaXMpLg0KDQpDaWFv
LA0KSm9oYW5uZXMNCg0KPiBUaGlzIGJsb2NrcyBteSB3b3JrZmxvd3MuDQo+IFRoZXJlIGFyZSB3
b3JrYXJvdW5kcyBsaWtlIHVzaW5nIGBnaXQgcHVsbCBvcmlnaW4gbWFpbmAgbWFudWFsbHkgaW4g
Z2l0LWJhc2ggYnV0IGl0IGlzIHF1aXRlIGluY29udmVuaWVudCBub3QgYmVpbmcgYWJsZSB0byB1
c2UgZ2l0IHZpYSBJbnRlbGxpSiBvciBnaXQtZm9yayB3aXRob3V0IGVycm9ycy4NCj4gDQo+IEtp
bmQgcmVnYXJkcw0KPiAgIErDtnJnDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBKb2hhbm5lcyBTY2hpbmRlbGluIDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT4N
Cj4gU2VudDogVHVlc2RheSwgQXByaWwgMSwgMjAyNSAxNzo0NQ0KPiBUbzogSG9od2lsbGVyLCBK
w7ZyZyA8am9lcmcuaG9od2lsbGVyQGNhcGdlbWluaS5jb20+DQo+IENjOiBnaXRAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbV2luZG93c10gU2V2ZXJlIHByb2JsZW1zIGFmdGVyIHVw
Z3JhZGluZyB0byANCj4gMi40OC4xLndpbmRvd3MuMQ0KPiANCj4gKioqKioqVGhpcyBtYWlsIGhh
cyBiZWVuIHNlbnQgZnJvbSBhbiBleHRlcm5hbCBzb3VyY2UuIERvIG5vdCByZXBseSB0byANCj4g
aXQsIG9yIG9wZW4gYW55IGxpbmtzL2F0dGFjaG1lbnRzIHVubGVzcyB5b3UgYXJlIHN1cmUgb2Yg
dGhlIHNlbmRlcidzIA0KPiBpZGVudGl0eS4qKioqKioNCj4gDQo+IEhpIErDtnJnLA0KPiANCj4g
T24gTW9uLCAzIE1hciAyMDI1LCBIb2h3aWxsZXIsIErDtnJnIHdyb3RlOg0KPiANCj4gPiBJIGp1
c3QgdXBncmFkZWQgdG8gMi40OC4xLndpbmRvd3MuMSAocmVpbnN0YWxsIHZpYSBHaXQtMi40OC4x
LTY0LWJpdC5leGUpLg0KPiA+IEFsc28gSSBrZXB0IHRoZSBjaGVja2JveCB0byBjYWNoZSBmaWxl
cyAobmV3IGZlYXR1cmU/KSDigJMgbWF5YmUgYSBtaXN0YWtlLCBsZXQgc2VlLg0KPiANCj4gSWYg
eW91IGFyZSByZWZlcnJpbmcgdG8gRlNDYWNoZSwgbm8gdGhhdCdzIG5vdCBhIG5ldyBmZWF0dXJl
Lg0KPiANCj4gPiBBZnRlciB0aGUgdXBncmFkZSwgSSBwdWxsZWQgc29tZSByZXBvIHdpdGggZ2l0
LWZvcmsgYW5kIGdvdCB0aGlzIGVycm9yOg0KPiA+IGVycm9yOiBjb3VsZCBub3QgZGVsZXRlIHJl
ZmVyZW5jZXM6IGNhbm5vdCBsb2NrIHJlZiAncmVmcy9yZW1vdGVzL29yaWdpbi9idWdmaXgvWFkt
NzQ0ODgnOiBVbmFibGUgdG8gY3JlYXRlICdEOi9wcm9qZWN0cy9wcm9qZWN0bmFtZS93b3Jrc3Bh
Y2VzL21haW4vcHJvamVjdG5hbWUvLmdpdC9yZWZzL3JlbW90ZXMvb3JpZ2luL2J1Z2ZpeC9YWS03
NDQ4OC5sb2NrJzogRmlsZSBleGlzdHMuDQo+IA0KPiBXaGlsZSB0aGlzIGxvb2tzIGRpZmZlcmVu
dCB0aGFuDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0L3B1bGwvNTUx
NSAod2hlcmUgd3JpdGluZyB0byBhIFJlRlMgZHJpdmUgb24gV2luZG93cyAyMDIyIHdhcyBicm9r
ZW4gYnkgYSByZWdyZXNzaW9uKSwgdGhlIHJvb3QgY2F1c2UgYXMgd2VsbCBhcyBpdHMgZml4IGNv
dWxkIGJlIHRoZSBzYW1lLiBDYW4geW91IHRlc3QgdGhlIGxhdGVzdCBzbmFwc2hvdCBhdCBodHRw
czovL2dpdGZvcndpbmRvd3Mub3JnL2dpdC1zbmFwc2hvdHMvIHRvIGNvbmZpcm0gb3IgcmVmdXRl
IHRoaXMgaHlwb3RoZXNpcz8NCj4gDQo+IENpYW8sDQo+IEpvaGFubmVzDQo+IA0KPiA+DQo+ID4g
SSBsb29rZWQgbG9jYWxseSAoZXZlbiBpbiBDTUQgd2l0aCBjb3B5ICYgcGFzdGUgb2YgdGhlIGV4
YWN0IGZpbGUgcmVmZXJlbmNlKSBidXQgdGhlIGxvY2sgZmlsZSBpcyBOT1QgdGhlcmUuDQo+ID4g
SSByZXBlYXQgdGhlIHB1bGwgYW5kIGdldCB0aGUgc2FtZSBlcnJvciwgYnV0IG5vIHN1Y2ggbG9j
ayBmaWxlIGV4aXN0cy4NCj4gPg0KPiA+IFRvIGF2b2lkIGV4dGVybmFsIHNpZGUtZWZmZWN0cyBm
cm9tIGdpdC1mb3JrLCBJIG9wZW5lZCBhIG5ldyBnaXQtYmFzaCBhbmQgY2FsbGVkIOKAnGdpdCBw
dWxs4oCdIG1hbnVhbGx5IGluIHRoZSB0ZXJtaW5hbC4NCj4gPiBUaGlzIGRpZCBub3QgZ2l2ZSBt
ZSBhbnkgZXJyb3IgYnV0IGdhdmUgbWUgdGhpczoNCj4gPiAkIGdpdCBwdWxsDQo+ID4gRnJvbSBz
c2g6Ly9naXQuY29tcGFueS5jb20vcmVwb3MvcHJvamVjdG5hbWUNCj4gPiAgICA3MjQ3N2Q1N2Yw
MjYuLmRlNzlmNGRiYmY2OCAg4oCmDQo+ID4gKiBbbmV3IGJyYW5jaF0g4oCmDQo+ID4gKiBbbmV3
IGJyYW5jaF0g4oCmDQo+ID4gKiBbbmV3IGJyYW5jaF0g4oCmDQo+ID4gKiBbbmV3IGJyYW5jaF0g
4oCmDQo+ID4gKiBbbmV3IGJyYW5jaF0g4oCmDQo+ID4gKiBbbmV3IGJyYW5jaF0g4oCmDQo+ID4g
KiBbbmV3IGJyYW5jaF0g4oCmDQo+ID4gICAgY2UzOTc5ZDYzOWQ3Li5iODBiNzBhNTZkYTcg4oCm
DQo+ID4gJCBlY2hvICQ/DQo+ID4gMQ0KPiA+DQo+ID4gU28gd2hhdCBjb3VsZCBiZSB0aGUgZXJy
b3IgbGVhZGluZyB0byBleGl0IGNvZGUgMT8NCj4gPg0KPiA+IEFsbW9zdCB0aGUgc2FtZSBoYXBw
ZW5zIGZvciBnaXQtZmV0Y2guDQo+ID4NCj4gPiBJIGRvd25ncmFkZWQgdG8gZ2l0IHZlcnNpb24g
Mi40Ny4xLndpbmRvd3MuMiBhbmQgYWZ0ZXIgdGhhdCB0cmllZCB0aGUgc2FtZSBhZ2Fpbi4NCj4g
PiBBIGRpZmZlcmVuY2UgaXMgdGhhdCBub3cgSSBhZGRpdGlvbmFsbHkgSSBnZXQgbG9ncyBsaWtl
IHRoaXMgYXQgdGhlIA0KPiA+IHRvcCAkIGdpdCBwdWxsDQo+ID4gcmVtb3RlOiBFbnVtZXJhdGlu
ZyBvYmplY3RzOiAyNjksIGRvbmUuDQo+ID4gcmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiAxMDAl
ICgxNDMvMTQzKSwgZG9uZS4NCj4gPiByZW1vdGU6IENvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUg
KDQxLzQxKSwgZG9uZS4NCj4gPiByZW1vdGU6IFRvdGFsIDI2OSAoZGVsdGEgODkpLCByZXVzZWQg
ODcgKGRlbHRhIDg3KSwgcGFjay1yZXVzZWQgMTI2IA0KPiA+IFJlY2VpdmluZyBvYmplY3RzOiAx
MDAlICgyNjkvMjY5KSwgNTkuMzcgS2lCIHwgMi41OCBNaUIvcywgZG9uZS4NCj4gPiBSZXNvbHZp
bmcgZGVsdGFzOiAxMDAlICg5NC85NCksIGNvbXBsZXRlZCB3aXRoIDUxIGxvY2FsIG9iamVjdHMu
DQo+ID4gRnJvbSBzc2g6Ly9naXQuY29tcGFueS5jb20vcmVwb3MvcHJvamVjdG5hbWUNCj4gPiDi
gKYNCj4gPiAkIGVjaG8gJD8NCj4gPiAxDQo+ID4NCj4gPiBMb29rcyBmYW1pbGlhci4gSXMgaXQg
YSBidWcgb3IgYSBmZWF0dXJlIHRoYXQgdGhlIGxhdGVzdCBnaXQgc3RvcHMgbG9nZ2luZyB0aGVz
ZSBzdGF0dXMgaW5mb3JtYXRpb24/DQo+ID4NCj4gPiBJIGhhdmUgdmFyaW91cyBvdGhlciBnaXQg
cmVwb3MgdGhhdCBjb250aW51ZSB0byB3b3JrIGZpbmUgc28gSSBub3cgcmF0aGVyIHRoaW5rIHRo
YXQgdGhpcyBpcyBub3QgYSBnZW5lcmFsIGJ1ZyBpbiBnaXQgcHVsbC9mZXRjaCBidXQgcmVsYXRl
ZCB0byB0aGUgc3BlY2lmaWMgcmVwby4NCj4gPiBIb3dldmVyLCB0aGF0IHVzZWQgdG8gd29yayBm
b3IgeWVhcnMgYmVmb3JlIEkgdXBncmFkZWQgdG9kYXkuDQo+ID4NCj4gPiBTdGF0dXMgb24gdGhh
dCByZXBvIHNheXM6DQo+ID4gJCBnaXQgc3RhdHVzDQo+ID4gT24gYnJhbmNoIG1haW4NCj4gPiBZ
b3VyIGJyYW5jaCBpcyBiZWhpbmQgJ29yaWdpbi9tYWluJyBieSAzODcgY29tbWl0cywgYW5kIGNh
biBiZSBmYXN0LWZvcndhcmRlZC4NCj4gPiAgICh1c2UgImdpdCBwdWxsIiB0byB1cGRhdGUgeW91
ciBsb2NhbCBicmFuY2gpDQo+ID4NCj4gPiBVbnRyYWNrZWQgZmlsZXM6DQo+ID4gICAodXNlICJn
aXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQ0K
PiA+ICAgICAgICAgZmluZC10ZXN0cy5zaA0KPiA+DQo+ID4gbm90aGluZyBhZGRlZCB0byBjb21t
aXQgYnV0IHVudHJhY2tlZCBmaWxlcyBwcmVzZW50ICh1c2UgImdpdCBhZGQiIA0KPiA+IHRvDQo+
ID4gdHJhY2spDQo+ID4NCj4gPiBTb3JyeSB0byBib3RoZXIgYnV0IGRvIHlvdSBoYXZlIGFueSBm
dXJ0aGVyIGhpbnRzIG9yIGlkZWFzLCB3aGF0IEkgY291bGQgdHJ5IHRvIGZpeCBteSBwcm9ibGVt
Pw0KPiA+DQo+ID4gS2luZCByZWdhcmRzDQo+ID4gICBKw7ZyZw0KPiA+DQo+ID4NCj4gPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+DQo+ID4gRmlybWE6IENhcGdlbWluaSBE
ZXV0c2NobGFuZCBHbWJIDQo+ID4gQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlcjogRHIuIFZvbGtt
YXIgVmFybmhhZ2VuDQo+ID4gR2VzY2jDpGZ0c2bDvGhyZXI6IEhlbnJpayBManVuZ3N0csO2bSAo
U3ByZWNoZXIpIOKAoiBKb3N0IEbDtnJzdGVyIOKAoiANCj4gPiBGZWxpeml0YXMgR3JhZWJlciDi
gKIgVmVyYSBTY2hpZXJob2x0DQo+ID4NCj4gPiBTaXR6OiBCZXJsaW4sIEFtdHNnZXJpY2h0IEJl
cmxpbi1DaGFybG90dGVuYnVyZywgSFJCIDk4ODE0IFRoaXMgDQo+ID4gbWVzc2FnZSBjb250YWlu
cyBpbmZvcm1hdGlvbiB0aGF0IG1heSBiZSBwcml2aWxlZ2VkIG9yIGNvbmZpZGVudGlhbCBhbmQg
aXMgdGhlIHByb3BlcnR5IG9mIHRoZSBDYXBnZW1pbmkgR3JvdXAuIEl0IGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBwZXJzb24gdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gcmVhZCwg
cHJpbnQsIHJldGFpbiwgY29weSwgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlz
IG1lc3NhZ2Ugb3IgYW55IHBhcnQgdGhlcmVvZi4gSWYgeW91IHJlY2VpdmUgdGhpcyBtZXNzYWdl
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlbGV0
ZSBhbGwgY29waWVzIG9mIHRoaXMgbWVzc2FnZS4NCj4gPg0KPiBUaGlzIG1lc3NhZ2UgY29udGFp
bnMgaW5mb3JtYXRpb24gdGhhdCBtYXkgYmUgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgYW5k
IGlzIHRoZSBwcm9wZXJ0eSBvZiB0aGUgQ2FwZ2VtaW5pIEdyb3VwLiBJdCBpcyBpbnRlbmRlZCBv
bmx5IGZvciB0aGUgcGVyc29uIHRvIHdob20gaXQgaXMgYWRkcmVzc2VkLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHJlYWQs
IHByaW50LCByZXRhaW4sIGNvcHksIGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCBvciB1c2UgdGhp
cyBtZXNzYWdlIG9yIGFueSBwYXJ0IHRoZXJlb2YuIElmIHlvdSByZWNlaXZlIHRoaXMgbWVzc2Fn
ZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UuDQo+IA0K
