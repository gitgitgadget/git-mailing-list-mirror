Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E91D5CE0
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336836; cv=fail; b=QRrjNFliW2sm3BYYYyOM3lOr+QZPPSThCPbNAKNYvquoSMw1TC9Ho/eXJ0t5Ympz3EZqRaipw0cer4Bbzn1yq/5oMhmukZVYJAy1Lu+lBShHWMq8otp1R3vc6USYyVOepoCJ6CmhpEInQaxglJ4leIlX5wv/sNTEE1HhKYH7fEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336836; c=relaxed/simple;
	bh=884crElC31oDbf3gi9mLu8vaSs4A9QLNif/8A7KvPy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oN7BjcElw0fJbYVYRzfnz0Z4xz9/JDesUR7U2hBjLecyp1CXddS7GqI6IGGej0ydCiS9nQfnM+t9+pSlCKu+oZPHvkhDLZ7cCKtn2TvS+Vh920CSG5nzuPhStyN3tCAnHGKN4JrVt+kzhUo1xazEg4WJ0diBUQkjPP7Q9os2pZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhpFKa9O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=muWGtjE1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhpFKa9O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="muWGtjE1"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1OR6p1870016;
	Thu, 21 May 2026 04:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tuCj47nbpbunzCaog4
	HuDc9LIhrrf3BvhAzNCpTfc8w=; b=JhpFKa9OPjlF8j8euDj14o42AruBePJ4Ur
	Jeb8Eu9xzDuO6gb9Dky8cnqfJ7jgG7S4mrA7Vbdj/tUU/IQ78k5uoWzLCJKHutlm
	7mBNhBUp93DSJkqpawrebAXM4n40Osjaj4ZjTYrThSUNk/neZpGDTXkX0gf4LbOW
	4+yLyXbiXDq1/hfSrBKhmKZc9/4HLM/OsMNIWPkGIGdGmyz0fx+GDVBcOmJ9sieL
	k3HnWmcazgr/vmHC2gAKPgJ0ax5tLTCOD4/ZBMIJL3CVW+sbw8rTGfe7C+1pi5cx
	dskvJ5DO+nJMiYn3+nnONkpYvH7v1pHpvB2rJP8dVswVDZe+lNIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t0ewa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:13:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L49hFh020242;
	Thu, 21 May 2026 04:13:50 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1d1sms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 04:13:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVHlObvgJH2z/9RXNxOQ6swgVMidExiRHyMc/TN97JaapEu3WgmqhyItD5tN/DGf15fgddIJWp224P6qhxQv75dnXz8GogoqEe37y/R7YNsrHSkgpnOIacAtUrRV18j6lPf8nMP2BeEk881gDBhkpNo24nbo68+t7gX8t2OO5n3NDnNzCN9JQOisGnywUAQRraFgM7pqn1GU++lpPuI188E8WKcNjeKoWCPOHOo7G1AP0tqwZTsQqeFAkale0WjbFOF0bR5P9Ez0bge6KdxAmh7qVxmNhknW29J5+NF9J44HcrC04tme3QQODl89+iqIUFHfp1nawCTkXwB389kghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuCj47nbpbunzCaog4HuDc9LIhrrf3BvhAzNCpTfc8w=;
 b=OE5H+Zj9MhtbqTJQjroVl3g+pEBFfMZfJ6WCaDnX89kcVFjX2ZvEVb+/HXBaX1zxbnkgm8VLAuHjZSZDxvV1Yr1PCmqg1cO0PQTOO7zEyvexZk7hqo1dYrvUeGC32I/om4olQGcldUVRu5WsPtruTq3wpUZDS2WOfvsE3KlTuZPozPqPnwKb7dNMRvEzyycFwUlsuci/3WFuSp9Pbqvs0xO0seUXF2gAv56uquVjfxSdBb3QhBYuFppt9x8Bx36DtsdG1BMY1OFh0wwtvm/+tlU45tvzZRUcPgK5GW1WiB+/k+n9MVxXptjwsXIN8ytyC+aiiCjlZXB5u4+Ja0U3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuCj47nbpbunzCaog4HuDc9LIhrrf3BvhAzNCpTfc8w=;
 b=muWGtjE19n6w6CjaeNKW42m2KHDI16hE2po7SUZw2o2yXkG5gfAFgOA5SGXuOZ+9ifkF/xV0JhFQA7x07eq2904AsJxC/hjTV+IcyutBbXgjWoxiip3CszH4JFVlVpgidt6AN2eV641/o44H0mQZsvb6/7hXa4lrKnlmuVbRN0E=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS0PR10MB6032.namprd10.prod.outlook.com (2603:10b6:8:cc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 04:13:45 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:13:45 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gitster@pobox.com" <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com"
	<newren@gmail.com>, "ps@pks.im" <ps@pks.im>,
        "code@khaugsbakk.name"
	<code@khaugsbakk.name>
Subject: Re: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
Thread-Topic: [PATCH 1/9] Documentation/git-range-diff: add missing notes
 options in synopsis
Thread-Index: AQHc6Ng3raLJm7qa/kSd3wI0hxEPGw==
Date: Thu, 21 May 2026 04:13:45 +0000
Message-ID: <c0e892b012c780c254069bd718b98453a2027ece.camel@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
		<290fe06d81e956253d3a06fc1e16848e0b86b603.1779207350.git.siddh.raman.pant@oracle.com>
		<87v7cjq7vc.fsf@gitster.g>
		<b3958381907244ca06a39e2fc116eec113a6bc85.camel@oracle.com>
	 <xmqqpl2p38s4.fsf@gitster.g>
In-Reply-To: <xmqqpl2p38s4.fsf@gitster.g>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|DS0PR10MB6032:EE_
x-ms-office365-filtering-correlation-id: 89a82917-7ea8-428c-cfa8-08deb6ef5a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|6049299003|10070799003|4053099003|56012099003|22082099003|4143699003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 EUAGJKd3+KlcREGLevlbPmbU8oNMRh++iIMU6OmaY5Z1bBYruiokoR++dAwGLqa1OByHowUe8Al2LvweCJCeUfzL8c+L1HTid6jBuYlsboTNfLHXJiSTsLG1g/Az2LzdqH4+cIZLSzQo5kuTv8MS8EtYgwZBschqE5epFvw4m0adP9E7FnHaMRlFUxn4AQN7LV1sx6+Oy7BziWAOy/sEN4lOVuiwXwIGf3bkv9ZZqOghhTHHmnBqK0UXsE6fPVN6PBThHRBUsZZVEeMHaQ2R3jmrMi7/wxXBy0kvtoFAAjnahoyudYTDJctlJgkRVYmTwhHCQMv32ffK1HopijyLzsSuxc0fzHAHeZsrdph2dUAPD7+3suPlGKgVXfvQLfRtUESmYOiasU2KBibVttz9CZp1pcz9UV9JgzbMIeOq87u4aPK7KW0wWNjK94zNf3BbqHk0wdY+cjSsiTihTckDs0lBO7Clc/83834KpC7xKqjcUC63dBLkooj4aE+we6UGcUb645cmqWXN/MkaShlHj7dGHZ2Ec5B9czLYDB/QN7v1Ugx1kXXsILkzhfxtTglSPcryuIFysiSDeHUV0v9WShLZM+Cjnu0suXm7+AxaNZCY2/n6SBWfweiCQmwtNvVIlhfuneZm0uF/EXy7m6fKvGOmF9f1+yyCjgPhFycPHAl+EJCybG43ly8S3QbVI1baLZ2PmivT61g3vxvdAttxO4PJNclK07X9Y/kbyXcxYalzBVxNp+b8Vlc/j2JGgLWP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6049299003)(10070799003)(4053099003)(56012099003)(22082099003)(4143699003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWY4NTROMjNETE5hTjBFRndGbkN1MjZLZ3lRNzVjUE0wWWlCTjlHaml0VW9j?=
 =?utf-8?B?QVA5RUR0V0RFYjJPSFBuU29zK0xxWk9vUFBybGhFZm5lZmk0VkIxUVNCZU5G?=
 =?utf-8?B?NE0wK3RjaDlxbWdyemh2cmFSREM5YVlscHExUklQSlQ0VFJkc0VJM2VKTUdy?=
 =?utf-8?B?RU16M2JJb25nM2ZER0V5L2djb3NpcXU0bmdUQ1pvTVJHdlppckVJYzNqOFVu?=
 =?utf-8?B?S2RJc3VaY3VhYVh6MldwRHM4ajJ5TVdRbUo1aTMrKzV2a0NBSmIwQUEwUkM3?=
 =?utf-8?B?UllpaTJiRFg3aXF0ZlNFNFk0TWVhYitwZldaUmVWSTl1am9ubklBSzBOQStX?=
 =?utf-8?B?Qi9FZ1NnNm1scm44cCt6Mk5DaW5VaWtjeGxSMWttVHovOTVGRURmTGxqbUt4?=
 =?utf-8?B?cWgzT01tMGh2YVlJaHBtbXF3R1FtcjN6ZTNqV2swTEoxNnpIdjJMbWZrczI1?=
 =?utf-8?B?YjRhUjd2QmlIb04zaHBoZ1BwU252ZVoxSXloMEluUUxqOFJXSnVkemlOSUJF?=
 =?utf-8?B?T0QxL1hoM1lXdmdQNVBLVWRldlgwdmc2NERzbURzeGlEWjRVcEdBMUtNRUdQ?=
 =?utf-8?B?RWFKcWlkcTc3b1JsL08xS01HN2FNUEJPdkdpYXdVN3BocDEvU3RjWHBnMkxt?=
 =?utf-8?B?eTd1NWdTNjE5aU84V3JqRGJzUGRSazFpUkNIMXNaMStHV1hiY1haa1FkeWw5?=
 =?utf-8?B?cEdZYTBQYWUwNUhPZlI0c3AzNnFFc2hRekpSUktMRUFURkhVNlE5NWF4MzlI?=
 =?utf-8?B?QTlhUTJodlU4TTlQdFpJS1FYSzg2Y00rVXVyZERJaFJ5UkZ2ZEpkanJPT3Fk?=
 =?utf-8?B?NEFPUzhUR3RGMDhrM3UwdTBoZ0taTGluZG1NRjlNQ3gwZXhnQ0EzdGdVOTQw?=
 =?utf-8?B?UGszVFdJVVlMQ3RLSEQ4UzNTa3ZnYU5IWENHYU51cTJ6QU1SRXc1M0ROUU4y?=
 =?utf-8?B?WjJzcWJlb1FEV2d1U3NBeHVlSHllanZPbnZHUDV6dURKK0RhaDAvVXVJZitX?=
 =?utf-8?B?bkhiTzk4TUtSU2xmSWJXUlNaa3lhbHd2Q3VTVjFoQ1VoSnphS3h1KzVSQ2ow?=
 =?utf-8?B?VGwyYm84ai9pSXBSS2VvOEswK3djRGVobFp0TVdrUW16eVdLZGJKR3VhRGp6?=
 =?utf-8?B?WWNNNk1BMDVXV3NLNnhZRUpOeW9JbDdKaEhqK2xleWxpYjMyVW4vUlZ6aVVz?=
 =?utf-8?B?ZDZyZnptM3ZMTmw1Wmo3VTFaTE1iZEd6MEdzaU4wdWN3dWlDS1F5K3Rmd29N?=
 =?utf-8?B?UFB2dThXNmprb2VudEpmTm1MOFp4T2VqMDlISEY0MWNJNXBLRmxCK08yMmJZ?=
 =?utf-8?B?SU9PODlmeWllTForRUFiRlVQR21wOEZkRDRyenIwTC9oNmpQd1hPYTdScy9P?=
 =?utf-8?B?emVKZkZ6OEQwUXhSNDEzUWpIbHZqVDdqZ0x1ek9Ta0xlZEN3Vzc3Q1VWeWxm?=
 =?utf-8?B?czR2M0l2SFAzdWpqTHp6Vmd6Mzk0THdQUzZZWnBaQUdOK0hYU2NGRlo0Q3Rv?=
 =?utf-8?B?a2REbys3NFhXQ1BpZ0tsUHFSdWsyUnhRWUhuUkpWelJMMkM3RHFibVFaL0N6?=
 =?utf-8?B?L0VJOUF5c0RCd1FFUlJnb1JnZDJLbXRmc3FhZjNNY1laUjBwaVZVV3ZnVzJ6?=
 =?utf-8?B?eUhhOUFZdi9jR29QUktTVERwenhrRXczWGpXQ3Jmdk1FLzFiYlk1QjVUWHBi?=
 =?utf-8?B?bFYrNktodjZDL0FCdzQzM3MrN2xGY1JIb29XZ1l0TXlSbFlDTzJvbG5GUlFx?=
 =?utf-8?B?OGprRDdDRHVMb1lHdXJJY3A4YVd0WUtmYmtNOEthWkt5Q3h1UWVHc1BaTlVt?=
 =?utf-8?B?WWg4UHo3TGlHbVJOSk4rOG5RZE1DN1VZL3U3TmVHNmZ5eTg1SW13aWl4WVhp?=
 =?utf-8?B?RlllcDlwS2J5UXQ3dXp3cnlqUStvVGRNbFFWRXBXM05WZGNkM3NPVWU1bWNM?=
 =?utf-8?B?ejV5ajI4QTk5OGJJZVpxZCtNTTFlRzFDQ2U3cDVydktGUFF5RWtibHB5MFYy?=
 =?utf-8?B?Wkd1d0hjVEpmTEhCaGtLMWNHWlBoY2xpVHkyZWJXVEgrODNOb2pLSWZna3Fp?=
 =?utf-8?B?S0RkeEZPbXZkV1pvUWxTUm10V2ppcW1qVCt6S2pXMmtTallQWlZuMkFsUktu?=
 =?utf-8?B?SjBvNTg3dkVsUjVQWTZCY0lrbExJc0dBRFdOaTdJRHBGdi83N3hBTTRISkh5?=
 =?utf-8?B?MElkYUVnM2hyenZHQWZacjV3VVJhMm5USmlOZkVrUDdFSFExYkhQY3A3YndK?=
 =?utf-8?B?MW9WV2cyUWlqN0RuK3M3dm5kMEJxdWpMOFY1MDRLWFh5ZU9qT0k1bityTklo?=
 =?utf-8?B?bU41bTFPOUZ5ZGN1MnZzTitJUVQxY3FQd1dJY2V1cS9VUTNBQThoYm05d0Yz?=
 =?utf-8?Q?G7oqRaDKLLdcuSB6QAtqVVzg/AexmWCkHIFae/e8ahVjB?=
x-ms-exchange-antispam-messagedata-1: ttgsh8e+6cMOx+4mR5J+xXkkfK+ltKh+49I=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-1u/4HLqsEkrlkUwFqBBK"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EX5MvFy5G2c0SBRbE6IB/dVAjl4Mazri4M/Ncz9ANP9UHe/cYjl+uCoSGiP8M6EXsse3x6c0ToCbRFX1Hfogbqe3JNDTXMCcmWaA/sHAYjZDqOGEUCOi/k4kSRTIIpeIobx5uxAkZZAdMGz1G+r2L2HwU8iMIjC6ObjbYlqHFInj/TDvg8qyProrcV0KjwrOIARK31IZdOG+XTApsR3/ladDpvbzYum/856UVXeI0NFwG7kmk3J6nyLfup2k+nNfWl7NocCapIT1U6vgP8VB6v/Fmrrs/OMnpb1yKpAiKoa+4/SuEt2OyuGwuJZy0yRRA7XGQDj/cN1vHcG9AC5CVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4WU5JiQndhe6HKzZlNhuOADB5RuGWxA3XQeG9/b+nlJv+Ut4S7xj/sB+ngvCupZjy5CKb6aTD7mjyVzOSoXMUDFHWaIxDPBBbkZA10SPZ1lDbJFNWxCfwT7DgvfAVcYpuEEjmFTDdaD54KSz25P70QS9UnfVbYHJ9A7GkQBq0oUKHF87tiq6J3HSiwEJeQi6MHuwLF8C7Zr9m1I1toEsxRJgHuDqlH0jK3cEsAAAuZzNPuFpV14/aHhY3GRI4J0tS1MOXxltGDId+M6lkjzVx2yEY6UyyLy3Fbl/BoWoETxBAvQDskHTt6RDTaux1fm9+v0kpLQzUytqFNHt3N1aIVRTOKvHWY552zF8uI4kpAvAx7G5/8BOhK71q1VLrdFuunjN5keyvu4fTOmiVFzckYc89HczuQiR9Perpc3fMH+bBiBkj0YUxiVSoPOTI44hupfZY9/DVyrSVrMc5vQQ5axhHDCS9twqFJUrgEd2AMkzEF5fvxrMzufQQx5e9XWbDmfWY0mhB2m01E1wyXggmDKOFT3ZhMdCxu2b2RI7IngLXZj9o082mJ7/nAdvyGsMnOnbx7diiuXZziZYz53WsVwzjLGo0CuU0OCz9077ry0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a82917-7ea8-428c-cfa8-08deb6ef5a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 04:13:45.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKFtp97twh55pojMKIdT2vVpij16HgJNzdrD3+4TVeA7EC0E/9fqhssACgI4GPHzPL9dWy4FJBjeW4HqJ5HBr4PXe4ek5VlrA3/NYmWFvBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210037
X-Proofpoint-ORIG-GUID: aUdy9uxDLVHx4ECasx1q5HgLZ3TxVptw
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a0e8680 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=yPCof4ZbAAAA:8 a=pguReuT5bTnhOLdPEf8A:9 a=QEXdDO2ut3YA:10
 a=7skmfoFSLNDWTAqrBI4A:9 a=FfaGCDsud1wA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzNyBTYWx0ZWRfX7EIBBPYblpAz
 /D3Ht8/M1ceF3xf5IFzWPBmbq2nQJK7hv8EOTGDuiHUDEeBWbfv7UT1v55ncU9GYYsuK0IT2swh
 pQ9WuazmnDVtBzhgXXCFr+MZQ1g45rVPBFstGpfrwgdMl5D8+v6fzBtoNo2I2QoY3I9g6Nlf1w0
 j+qN6RGXvo+TsM3Pmp/awc7hZhbADmJ3cZG3imWOhc2mrlESZewUxZcocAEAuGJkjJlgeo9CurL
 zaDJg1LOWSVsoErDpnMJS/bF9zW+f4ZtgoWTmsWdBmZVdMlnnTP05jUrIwI4VdcNQ351+Z26lEa
 3OMQJVYmBs9qTQawYyBzHErtv98F90i7a16EHVeK+W9zsQH1UHN5hkLbSIs5eBLArGNCfk64qFX
 pz1gXd2YsLcHd758DxVClQba+IM6kXQ5wBvd01wXwS/jW54DAXgPbEB6maiM5yjBNMWytWp5IuH
 KTtaFEYS+k0u1mzzQfA==
X-Proofpoint-GUID: aUdy9uxDLVHx4ECasx1q5HgLZ3TxVptw

--=-1u/4HLqsEkrlkUwFqBBK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21 2026 at 05:58:59 +0530, Junio C Hamano wrote:
> Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:
>=20
> > On Wed, May 20 2026 at 05:17:51 +0530, Junio C Hamano wrote:
> > > This has nothing to do with "external notes" topic, no?
> >=20
> > Yeah, but since I added the command line flag I found it doesn't
> > mention the existing flags.
> >=20
> > Fixing it in the "external notes" commit would be bad, so I put it
> > before that, since it also then provides a logical place to add new
> > flags.
>=20
> What I meant was that it would have been better as a standalone
> patch that is unrelated to the (now) 8-patch topic for the external
> notes.  That way, it can move faster without waiting for the rest.
>=20
> Unless this patch has complex semantic or textual conflicts that
> makes it easier to manage together with the external notes series,
> that is.  I think adding [--notes=3D...] to one existing line (this
> patch) and adding a new line with [--[no-]external] on it (the main
> part of the topic) can be done in parallel and it is not too much to
> ask for the integrator to merge them on the receiving end.

Ok sure, I'll send it as a standalone patch.

Thanks,
Siddh

--=-1u/4HLqsEkrlkUwFqBBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmoOhnMACgkQBwq/MEwk
8iqejg/+NtfhzSN3yKcpkfcPLhDP31Li+/nT1p4gOZAfcGF7NzNqluQ0z4PvE1ne
dQXe5tzBZ0WLq0opjA5IxgENAgwZELeEO1bwIKodfRXaZLItZtbgQV8rTiV3yz+R
LKivfPmeZnxE2XXlc5T02XkYvg2i20V1JNCf6ox7Z8DGHdET2W4iJvzdWLLPHHfR
1U8OLx+EEaecdh/QeiG8eSM7sAAgal96RDfiW2uNe0fRZrL/YB/rbgxPJxnz9QGI
JUlVfIAYgkkqH8zHTGU9sRdLDIcwSpPe38ZMYnaTqbrDWE8KFRZLq+dW47WAjkST
hAE54OTFTJOI9LfS1ok524vYG9oZ6iNLo7FwSJQizITLOyoBzBbI2TmGUdZ1DTsN
ehUtL8uZMzmPBSIB9HJUUIBB+xzAEZsKmE0Sfge5dNReFsfOgUdasyqbmNJRBHwr
XxkeG7NxnM7k7B5BTW0Vbu0Ix9HPxQB1LmDWlScvWORNyKs/+FtVdlJ5Noiqrwsf
TCgbAf4+LPSatFnyUPZmAtzRfr4eVdeBDru7bHV4vBAXozrHpgWy+5MO9rQOVugo
2FUs3vqLRt0r0yLTarnMrurDyOcrAPr3XxOoVyPDdS32lNElFCITz2m0GgyVALMl
KDy35oDuG4Pq1YFUqNIK06YH9qYoG+d1C03IfWep0VSr4HInGYk=
=kAIL
-----END PGP SIGNATURE-----

--=-1u/4HLqsEkrlkUwFqBBK--
