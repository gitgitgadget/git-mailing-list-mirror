Received: from esa5.dsv.c3s2.iphmx.com (esa5.dsv.c3s2.iphmx.com [216.71.156.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19E2356D9
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.250
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582609; cv=fail; b=o6Bqe0Z0XniTLSs5Tga9InVTn7ZKQ46o3TJshbF26dSFwuVHmk0YqVxcLoRJDNzNfZIfNCz9E8HhWdCxlXz7Owo3kBGpoz5CT82dpkTRaVNIM6w5NTv4wwJtYIt6MNRwZSEzvYEuyw7PxCF+it3e0dhbjjyz1w3Q/MhfrQadLOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582609; c=relaxed/simple;
	bh=z7vjD+JW1qPGYpGOXGFYbSP2QMQYB3xhxail7tAwtp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YS+az0r4NgViDBFTXyzoeMtlmbkWCvmeAftphJ/ZqchIM8EhNCktPtCMVvYGSF5tEscaIEwaWOJRJk0q9WHsuVjypCvdF4c5wrERiqbsbD9ArAY+T3+XAn3+8xNY4n4f66/3tR2IBXfK+FAqocUv9B0DyX/OcOpxMfjaC+at38w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com; spf=pass smtp.mailfrom=dsv.com; dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b=Qh5deXO5; dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b=Q6qS0eMN; arc=fail smtp.client-ip=216.71.156.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dsv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dsv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dsv.com header.i=@dsv.com header.b="Qh5deXO5";
	dkim=pass (2048-bit key) header.d=DSV.COM header.i=@DSV.COM header.b="Q6qS0eMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dsv.com; i=@dsv.com; q=dns/txt; s=dsv13122017;
  t=1745582607; x=1777118607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z7vjD+JW1qPGYpGOXGFYbSP2QMQYB3xhxail7tAwtp0=;
  b=Qh5deXO5QJuWCsuf6sHlIsUbvG5nkr1mLF3Ix9o6glOgJuHFJ3zSqMKy
   FOst+FxRto9o1eUuSbF1HjIyIpZ8Zs+lilghlONxI1x50ot/cMpaTCdGW
   rgBPblOqd4GBzY54y2rbxBMHn7RX9G3mASSwpu6u3iQIp9tZnj6u4uf7V
   5Ss4gc0znjHIr5xjtiGWsZLP7z0sBCAFEVeExoJ579I1gZQUwzRxWBd0l
   yDUX7aKUBzCSbuPhKTKvAIoMTQG5SvSc4nZYR9E277ELnX2g6CSh5fWb1
   CVgfMnk335yTBusehzwyg5A3/o9ixMrpNdMIQkyizK1l+95bNkBEVfnb2
   g==;
X-CSE-ConnectionGUID: nzMpfwxYRIma90o00ANpzg==
X-CSE-MsgGUID: TWtkH0fGQKmNjOU9/00wxg==
X-IronPort-AV: E=Sophos;i="6.15,238,1739833200"; 
   d="scan'208";a="364001576"
Received: from mail-westeuropeazlp17010015.outbound.protection.outlook.com (HELO AM0PR83CU005.outbound.protection.outlook.com) ([40.93.65.15])
  by ob1.dsv.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2025 14:02:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6s6gq/cFKCsdkiM/IO9fAPFnSR2XHLYdNWDtnJtu8SImcB4szFdE+KtzS802+j3irkaOkv9lh7FiPulVu6VM5SlKIspDUwBHvNALFvu+fcm6KmIfN+tEYLDQK4syqnaPehGcPWdA7ge/Qp2rKNBk6WITPEjoKluOfZcWZsYoWCudc6OGJPvW02ZZw+Ot058r3JX/JSDwHxbQicJZunHs8mCJB3nMXPhxNYaJSAK2yFbd+Fw6Q7FyZlLE2JCdJvk0Nowqtdtc+IFltHfdi3vVorWftwOmzLKIFayeRHC82vSvC3u5Nx/xmQGQ0riRf+cntsL+OumyP43HY+Sc1s3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7vjD+JW1qPGYpGOXGFYbSP2QMQYB3xhxail7tAwtp0=;
 b=BgR6AA3rD72kX92jBOCW54OLJGQnLCFFiDcb/3J0HJ0R5M2L3aSd3DSnJX2G6jf+X4IS5lLgFSEZZTPRmcwAJSYbie33tq5lQGLAXp/l+0QOzOXjm/itFkVqrmib57T9K8Zqg4wXtcevi4VbjECGCn7Y/KLwjwcXSmmDl/p5bHwRPnQyxoRVHQHbAX13HShuhDjLF1n8/Gj5XhvslhuaYbM77sSd8j2PSGDdXcouMjJAMbqqN01iKyzXR/AhAUz2KVX9ZKoQ6xG4FOgXjMERBdcYKyLwl+U5F2ag5iafZivotUbUJQ6WEU4LtmifdAY7eBm3Qk9CThWIvjKxzE1gxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dsv.com; dmarc=pass action=none header.from=dsv.com; dkim=pass
 header.d=dsv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=DSV.COM; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7vjD+JW1qPGYpGOXGFYbSP2QMQYB3xhxail7tAwtp0=;
 b=Q6qS0eMNHHgbHj9tAIcXAeI5icIUXD7/iK/VCm07rok3Y9kJkoiTu5HW79RcHMgSrrLTJe8qRdRECfebxJr8VEQfV+sg1Oo7nI4p51jEtmw2PicOwFzAXRJls7bgKNBVmLNxuhGKBENYipc2Iu8+v+IkRcWdalIISIPt+EBiCJKZqy4mv+OfUdEuJP+gosO4nXwdK7cUaIAjUy7a/C/8c9BoRfyV2ikp+cD3qYGuTUf5GthvBarcthpXlIq7gFLmj7jaUVFf9tXO+00Nq8ROtw4TmovUrWb4O0qEWV6mbrjoO0ypFOj5nwmLQ7I59vRRl1JyXy1exErkM7eu6E45VA==
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8b::13)
 by DB5PR10MB7796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Fri, 25 Apr
 2025 12:02:11 +0000
Received: from GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5]) by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d45:ce2c:d45:b7a5%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 12:02:11 +0000
From: Lars Eriksen - DSV <lars.eriksen@dsv.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: cURL in git for windows does not support HTTP/2 anymore
Thread-Topic: cURL in git for windows does not support HTTP/2 anymore
Thread-Index: Adu06jewhtBLBy4JSwGSMq19l6V9JwALYJ+AACXcI2AACg7MgAAAe4nw
Date: Fri, 25 Apr 2025 12:02:11 +0000
Message-ID:
 <GV1PR10MB7600CAC40B084DD3AA85FE119B842@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
References:
 <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
 <1cb70ac5-31ee-ec1b-dea5-e900f28a38f2@gmx.de>
 <GV1PR10MB76004ED8EC327A2D11EDD2CB9B842@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
 <01fd2b48-dc9e-ec69-b4f9-1183beb7f8a8@gmx.de>
In-Reply-To: <01fd2b48-dc9e-ec69-b4f9-1183beb7f8a8@gmx.de>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ActionId=02d561ad-3d6e-4745-92e7-5b0782db6041;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_ContentBits=0;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Enabled=true;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Method=Standard;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_Name=Internal;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SetDate=2025-04-25T11:58:16Z;MSIP_Label_fc6c1fee-2f04-49ca-98cf-bcf61896c7fa_SiteId=4a90c23a-3ece-4ef2-b857-522f23b8204c;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dsv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB7600:EE_|DB5PR10MB7796:EE_
x-ms-office365-filtering-correlation-id: 92aa0fca-ad4f-4305-3db0-08dd83f102bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R7f/k5oKE21oWefZZydd7aIjfqwk/euIqQyLeKZoUV/mJFaNZcN9U+bdkNZP?=
 =?us-ascii?Q?FvBZV0mRsvm7IjRPyAzve6rrDXLizv221OqLoMw772SrqGdX2GmfJ+N9Cyo8?=
 =?us-ascii?Q?XduD3la1cF8+Jl0x2EmxziYttSlJ+TtCk47JE/PaolB3C+uvQVeoxARKCLVg?=
 =?us-ascii?Q?lZO0tcXbZgCD1+uULcHUXQJQSZCcleJkwLalnbmoqk2OAGL8bWaTS9IKBYCz?=
 =?us-ascii?Q?MqpgDn9y1TQOwVyfL35Y95R60QwyM0TLnSXm/NwAHx94pGNILeiBhZEpbQXH?=
 =?us-ascii?Q?VEyNmSYIYgJvU/mOItGN5kXNfs5Lr9ti3005hTO8YHCcQekh44h3l9yJ8ZyY?=
 =?us-ascii?Q?36NCTYnWUjzEUMyPP3LrrVarHTB/RdVNfCnEehHn3MVcO+nVAgYgg5kyCA8V?=
 =?us-ascii?Q?yil9/pArhtycOIHKjQzO1Sw5oXN8PFGqm+uJa1euyrD5HhBay2OqG8Zc14pj?=
 =?us-ascii?Q?Nq7CyX51VrcDuLvQXXoVkZdJ47/HGv+ZXpJCJ8keLiJupRLJP0ASofaJhoCh?=
 =?us-ascii?Q?NkazTWb8C+iM933lcJoIHxpmumoa+BZJv2K3KOKO/yHR+U2seMO7BTj1iwSW?=
 =?us-ascii?Q?vdwy7SRqGjbZytNP7M8o4ZM15fCjKAyAUKakZvTsX8UyIdqTKZalHWAH4dQi?=
 =?us-ascii?Q?z5dOTbooXV13Iy5+IA+UzE6oXKIH5d3erFOYQN6OqVd0h6lgxkhyjpoeT3Ip?=
 =?us-ascii?Q?by/VWORDV+BlCcKM7YkyTKBl4GozQl8GgokD0xcOdSVdpaiQBH/xuFOENMlZ?=
 =?us-ascii?Q?FBRh6HzzhJ/wuGTBfkmZMjz6pr5vnDgkDFacoWzJg91Vp2J9ooVQEwGVP1w+?=
 =?us-ascii?Q?GJKkD/dxdV+dp59MyzATXg0d80YZCdeY41VW1PIv49rQmeId6Q7kofhbWGSB?=
 =?us-ascii?Q?7G2GjhvM+tXQ0EpnlY2OTk0ZMvLOm/eMvC/7wTDSNs4TKLu4FJ00DLxC+Et/?=
 =?us-ascii?Q?tn0s4KS3089ZvXqWrl6ChWUJChlGaZMnrAXmpb5CFIS6Iiy6pSXXIHgQye6f?=
 =?us-ascii?Q?Z5+jDA154ikyAixcMGGmFiuErWIlDsp1epb1Aj2XgbnGZc2u19cOeuGSJ24n?=
 =?us-ascii?Q?oerCHiLoryRBm56guPzLeOHRxmx8FQo/LCZsbH5WaQsEMoD0CMfe2xI731n+?=
 =?us-ascii?Q?p7uMfYexNNamytTYaiSHnm2Izdgfl7inxeFuByJObNb++RkFTYof3DAGhSwT?=
 =?us-ascii?Q?p+lzOuUUsFBAI7dVhr7XCxMkAQkfykfcQn8+acWTxIcIAm+7OkxKFoBcz85O?=
 =?us-ascii?Q?+VJTaIFk8h0JJUNP7eJxOa/CHpQ2INONqzjcfXAzJQSvvyIxz4d2R5+RHn2j?=
 =?us-ascii?Q?JPxDoxXgtzyBYv4/E6CjTc59ikPRjq3w1yCfalEagtCJcAxJT2b0zcl60A1t?=
 =?us-ascii?Q?wivPVP3xe54ziaTdFlTTLlKpVi6kFw+cqIqfxSQyEZhQTyayrcJg8C3qLe7c?=
 =?us-ascii?Q?0Szz0X4KfBf4OKCXLMaWZXYieCl0GiogpITJpghUzfB5QdAUiiIrIXqL35I3?=
 =?us-ascii?Q?gcvn+p6h3pgVL+w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ViTADcMQJ/394+LSzOyE329mm4G/l6SX7XsFfx6oog9zkC75LZ6Xi2muDfe6?=
 =?us-ascii?Q?J996FYq0AhJQH/wEGyeMehBb4ssCpEoxjDmBRHuYogwNzfwCQJjVLL+wtah9?=
 =?us-ascii?Q?k6psQxKXd/5aR68SgiV8gh0qx6inZ1HDDHSGBfiLFXLLhcfSlIvoQ9SNuBCu?=
 =?us-ascii?Q?XghPpDczvDGBjNqSEJRiKNOxmWoVLRNqXmuuAlkqJjeE1HswNBifx79P0A9+?=
 =?us-ascii?Q?Grks8ve39er1VUEkSVAJj3/+Vj65Okh7DLNBmJU9oZ2tNnTEO3vISmt0cj+s?=
 =?us-ascii?Q?1wTRC2elbY0J266cj4OAP3t4neQqsvN10AmocOAkj7icqddpEXIOJgC4krS7?=
 =?us-ascii?Q?0wMGqiQ/JK3fFrGZZGCcIqznEkOrtZ0jYTK9tuiqfNUl8IwgwIzP25ONU4GC?=
 =?us-ascii?Q?1EW/9fITzf0A4L0XbhMYByDIb9OrewIV94JMxjnaUZ+EtEgkcxwh4nf9l41K?=
 =?us-ascii?Q?aoC+KJMLpAIkPU1I7Bku711P87kMuKR+HOvEuCAQ8HCY7CEq9/efgGfAcDA8?=
 =?us-ascii?Q?mr0cHmS4tsW4QvHqUKXS3Am5CNxH7CCGJwvN12UtaqBMTgrGYBJS/KC3Snqc?=
 =?us-ascii?Q?BqmVnHodI8ui/ydb6vPOxeYh9jzJY8hkzAhJXULfnlnkRTFNE2BBUj6BzKvl?=
 =?us-ascii?Q?pDj4uQd0aW7Y+4O3Z/HN40fGv6wNXBqC7DvjnF+2dMFVbVDno9QGqg437MBA?=
 =?us-ascii?Q?fQil8681H1tHU13VXgnyIdo5pxRunOhLzWWDa3s1q7DwpaH3GS/if05B1XFI?=
 =?us-ascii?Q?VpD8LM1Xch0hM2YK6bjZG7UGpvgzNYXSy7mvN+ZhX9cvaFmJ2kLQOzLjW0Tm?=
 =?us-ascii?Q?OH9z/doV7436z6n4r8N+LHaxDUSANCr5NL1pgP3eDMBWDKA/yLUYqBM2PTeM?=
 =?us-ascii?Q?utKNNWN+Oq2amOung71d+6KsOz88zXo0aHEpKK/Zqk8bykeRVMkR8q+B5kJg?=
 =?us-ascii?Q?k3hjyA38sSlkryhLA0/JjRAkFiEz+KLBybwmAosrIkPA6DrKOGITiiZuax/i?=
 =?us-ascii?Q?jTsrD6KEOcgEl8o0vQOXU40VZ6x0ezmjzmAgXGVMTRb32a0f2VCsCrJ3w4to?=
 =?us-ascii?Q?fPdX4HPmhW2JV3UmdtNTC8OvhMlHu24TmNJeaU9kwgnRAbzJVCQ5tuyz8COO?=
 =?us-ascii?Q?ux1eRjh58Psa1B8Hbf5pxcXeZeFKqlmZvZnygThOaDVTsknAD4Zcq5yeEyAE?=
 =?us-ascii?Q?ao7+MH14GjIW7wcXDJK5tRPfzLs7Ztskm9Cu1xKOYVpxihxzkh65HCyQJMVo?=
 =?us-ascii?Q?Q6Po5ze/UvkG+BSwGCYQzGKfZMVkNPzmY42mFhQ+VJWUGbiawCBvH15Tuvc4?=
 =?us-ascii?Q?XjY3gdUjDX4K3r2KOoDBzrw4uBxI59w4W/EBOAlTqHT94alLgcffOu/GEBKu?=
 =?us-ascii?Q?R0r/UvY25f2Ejjkp3yKMwYrVqhkH5Mt/ENZLdOFJcrEzEZCsJGiaL+x6AOz1?=
 =?us-ascii?Q?txfs/gd/mERnu4jSi+zcWA3d8E2nm23iV1KrP9CreCkIuQ2qtW/bKQGHll2F?=
 =?us-ascii?Q?BYrvmG+Xqiak3LQeMAFVzxFagUOMKA5TXRzbUL5wyG//HcefiBHQDctXtUUr?=
 =?us-ascii?Q?a1WEnzIGmQJOo3+gdA/TkieF5BJOh55gE+YZWctH?=
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
	mCmz+/UIsPMgxlkfguCxp2eII4JJeLBDHsFUby1f/KoZQCKB/blZbvPNcwrmls1apHycp/1K6BIKYkhyqrO1ZOfwa3ayFXldkSVUqTp6J+ZC5ACOFCc3ybWCrDqdVC0GIDWFNAtTYJ/oQdiRW4zJziXvO8cmvkPvn99vAdETbDIweLPYoXRKOXKQGvCHSzQDVJIkNeUJHvOiHhRzxsiC0PVUcQc0VgFxJUDAI8CIXnbSl2yzrLwxA0vZaAVh9xYqATRYNeRRdMdtyEn61+k8RQGCzGbefuMDgFScLiX0JMfAqHoVi+qFLXZTleVK3/BtWZvj4PmPFXkESwAxj9ZeSzjlSvXvqmUyIazKtv3R6ZA968zJjbEeIR8wxw+LhMXnrpJWy4SNqZeJH00nNjSsQXpYDq3qhjIAudwZ237I5p1Of3aOAJcwRo9k+nwukbx5P5L+XQ0mWYs14p2ehgQV2/fBJ/MrArvE5i2v2XwRf9pRJGQ5SCEsWQvf15AjfAgRj2hs6tXa71Anm4e40g3GZ6DtvH1WO9hc3QqX/dt2c+blJ1xu1ls0CCsRVEx0q+ucIRmf0lwp+MIacfWHgZPF8hYKAATeyvWYl0hFRi6cKzvnZLE8Dx5EwgjkG/tHMwgkDlPgMdSi7L+3oblXohv9hEr+wKzQU7VnDkenMoAvZm0zG0yeK/LGYv0KeX0O+qlv
X-OriginatorOrg: DSV.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aa0fca-ad4f-4305-3db0-08dd83f102bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 12:02:11.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a90c23a-3ece-4ef2-b857-522f23b8204c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NBPb7flOBTEE0/npGPxAcMg2iZMNSV9Nc66zqvuz359q+aPwoPTh7dKcFOLemQT9R8F5pB3tv0UF6LhhtCsnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7796

Hi Johannes

The curl found in Windows has the same problem, but I got the server team t=
o install an independently built curl. This is what is allowed for us.
It is a fair assumption that the one found within git is only intended to f=
unction with git commands, but it has worked well for us up until now. So y=
ou can ignore my request.

Sorry for the inconvenience.

On Fri, 25 Apr 2025, Lars Eriksen - DSV wrote:

> I'm sorry for the confusion, but the problem is not within the git
> command itself. This works fine. But we use the distributed curl
> command for POSTing data in a custom script when we deploy to production.
>
> So the problem is with how the curl command is built for windows. It
> used to be built with HTTP/2 support, now it is not.

I am sorry, but Git for Windows is not really intended as a distribution mo=
del for the `curl.exe` command, it merely is shipped in Git for Windows bec=
ause some scripts require it.

Have you tried using the `curl.exe` in `C:\Windows\system32`? If that does =
not work, you may need to switch to MSYS2 (which is a proper software distr=
ibution, not a hard-baked one like Git for Windows that includes bits and p=
ieces necessary to run Git commands).

Ciao,
Johannes

DSV internal
