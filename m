Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7541A8F
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720129530; cv=fail; b=nDiy091wDhSKcmp/+hxHMzWrs8WBS9vjC8jTRoYRtwpowlAq9zL9+VP9/yddM0fS+E22QbGBZkefi1NSaf23OahTnsekqEBF73+ZD+TK1v3ddoMtehK27N8/K8wtAaY4LabCFcGUQVVJZr7IEnv3UITc/mmN6O+3KHlrVBsrXDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720129530; c=relaxed/simple;
	bh=HhRF1iOd/GOrAyc/hMC0j/N7+ENwKiyr67ACY21PTDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pdOffcFU4HvjipCkYTCnIUVHUb2ub1v1t5d8+4P30HSiCjw5yeETbdSwgqCOL27gQET9uE+LwMhBifJkgdZzEdsYxvukukXRGxfMmvj6Uxom1MCLQmbhgb0utrvQ6nJI+Yh8omcP/5ybdKhXqz8NpZBeUF62NmGUi/trZfwMMIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iongroup.com; spf=fail smtp.mailfrom=iongroup.com; dkim=pass (2048-bit key) header.d=iongroup.com header.i=@iongroup.com header.b=PlHGG8WE; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iongroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iongroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iongroup.com header.i=@iongroup.com header.b="PlHGG8WE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndGxnRA0WK7872ERiSoELKbnaQnhM7NnsjGo30zMTOmCeHh0Lyak1Y6v+nrGrpN4qEkG2mflygWZGjahyQYCHEYnlJVOfJeWwK60eSIRNkjT2oIH0GVBHCAiULP6aGscIKb7obuZRq0fSsk16Le4kQLOQ0fd6MVAM1kuVpdCK3qzsd2ZR2ouwz0/52Hsyb02qYkqEP6fUvzi6RKOsYtKLAPktp6NyBNgTRjkvFmCdNQHg5laj7dB5zdmGmsg6vJzLLBg99SseTxi/rEtGwl7jzAnAcAdWoeeVLe0+D36Mg59QRryxI+DfCU7kfJtkuGwGft1SRK6cIQXAQj8lv72JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhRF1iOd/GOrAyc/hMC0j/N7+ENwKiyr67ACY21PTDw=;
 b=nKI9R93tAA9JUM4pXGw/SaR1SpUwscx3v/fAxsICNEO9YNJuWZhGUqgMxLU5DnTFkGprujKgku0Jvp8L9DU8LhLI8/Ghj5LY4C51VEs3rFO/OjMxwedZ52zBPI0TBHjKD5F7e/S4omDaXJ14nmCgR0s/rKdr3X4md0Tsp7cYPky26L3il39WyVMnG8aGKAM8w3QuAK3zk+A7jkE6ArLpvMdEuSa/s6bfLHUVS23Ji7VBdHuYkpaF8uiYvS5PijvuIsNq8GHnzAzA0/dLRpK5RuEYplOuvWhvfVu7hnRhsrZ1XmR+bzoqlD8t38w8il81I5AfLCFJn381lRWO54NvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iongroup.com; dmarc=pass action=none header.from=iongroup.com;
 dkim=pass header.d=iongroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iongroup.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhRF1iOd/GOrAyc/hMC0j/N7+ENwKiyr67ACY21PTDw=;
 b=PlHGG8WEwhz4a3qasOJ3B/yxyiuBTGaOz+TVDXESeuO02gaH63eUA/0qXnK1PV493qT57T1JxWQdLcVDj65l2Xio0tD/fQBSNeOgrPpwAtRynAF084pxaloFBNxVMsZLpTNQ4N0lCrlzg9yPnsiJscq0cAMseIhkCc9rfAuuCBHT0c/7sEQfO69sK8BjjB1GT6rDj68t92GoqqVlPJdiXN/nNmlYHLx9d3pd0JHODiQ9swuS7tNjL9DRUrlevYrUjzLkmwrxNi8svXnB84fTGB9uFjeLELhfylCHMfeZzL+zUBlqMaVrMzk9n3sz5QWoHEbAXg1UQUpS/uyW0HXX3w==
Received: from SA3PR14MB6519.namprd14.prod.outlook.com (2603:10b6:806:311::9)
 by DS0PR14MB6787.namprd14.prod.outlook.com (2603:10b6:8:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.22; Thu, 4 Jul
 2024 21:45:25 +0000
Received: from SA3PR14MB6519.namprd14.prod.outlook.com
 ([fe80::2e6b:e255:acca:ad8f]) by SA3PR14MB6519.namprd14.prod.outlook.com
 ([fe80::2e6b:e255:acca:ad8f%7]) with mapi id 15.20.7762.009; Thu, 4 Jul 2024
 21:45:25 +0000
From: Dmytro Ovdiienko <Dmytro.Ovdiienko@iongroup.com>
To: Elijah Newren <newren@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Losing the file during rebase
Thread-Topic: Losing the file during rebase
Thread-Index: AQHazh4oj9wn6X9DrEaBsgyvD643n7HnDvMAgAAKb+8=
Date: Thu, 4 Jul 2024 21:45:25 +0000
Message-ID:
 <SA3PR14MB65191BDFF1F6E867969A678AE7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
References:
 <SA3PR14MB6519B74CA58C9AE49DC28513E7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
 <CABPp-BGE1aDb5Nch8kQx+uZkCvbTz6sN0m2Yad=1D4=z0C9JNA@mail.gmail.com>
In-Reply-To:
 <CABPp-BGE1aDb5Nch8kQx+uZkCvbTz6sN0m2Yad=1D4=z0C9JNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iongroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR14MB6519:EE_|DS0PR14MB6787:EE_
x-ms-office365-filtering-correlation-id: 2a4cacf9-fee2-4c8b-6e49-08dc9c729d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blg5dlFKSWJrWGVha3RaRGtaUS9Yd1V3VkhzK0RoRVdhaUJGK3c5Zjk1ck13?=
 =?utf-8?B?YjJjNnE5eEdZak01Y2JBYWRKazVuSGFtcStxaDFPN0ZOaDZ2RFpyMlJPZDFI?=
 =?utf-8?B?cDBHZnYwS2tKd2pMTk5sUjZIYk5hdHE3WitVa1doNzNyNFdnWURIRFpjOVM1?=
 =?utf-8?B?SGZkS3pxc293RU9CV3AvSGVKUG5FcERBU3M5eDRDSzdrREdrd1NsUDZMeFBw?=
 =?utf-8?B?S1NFVWF4a3hxZ1hCWG1BQkFmVWVhclE3SFNSenNkZWlZVlNXUGMzTW5yZ1Jo?=
 =?utf-8?B?b0FCaDFaUGc3OUxhVDJTVkR6ekNEdWMwOEp6SnhWL2p2Tkc1M3JkYSt2a2V0?=
 =?utf-8?B?QmlFUEFta25WUVdUMW1iWHB3L3NvU2thOVlPRVdxVk4vNHl2bllMSTdaTmJU?=
 =?utf-8?B?dmk3LzhIOTdGMmxHNDA3RWQ4b2g4dDA1aENYbjArTThEaitvaVFydjZHRjBD?=
 =?utf-8?B?UnZPWndlaExWNEJiZ0JTNTRMTmloTFROS3NmM2k1Nmg1ZUFWcmpLOVdoV3l3?=
 =?utf-8?B?bWdrQWZDcTFsTEcwZlRrWDNrS1NBNllYTEc5dWorOXE2YXIxV0lXWGlhWGc1?=
 =?utf-8?B?UGEvUkkzQTUvS1VNSkg3b3dPY1hmVStsUzZYZ3RSMlJOOXBtZERmb0ZLTDVY?=
 =?utf-8?B?T2s0cGxGOU5mQXBXT1hmbDlCcUQ1YzlmR2NYRWlOMzVtcXUrUTVrMlBVenBF?=
 =?utf-8?B?RjlObCtmaWZuRjdNVGVJZWZXempLN1I3RDMzY1RiWGJvN3JVSTdoalYrOG5B?=
 =?utf-8?B?aHVCRU43RzJBQnVSbWk2eFdQT3pPTWh4TjR1RjJCeFRWSTlqQUo5ZHN2RWxs?=
 =?utf-8?B?RXA1L2xaS1haR2ZtR2dTSUJad0YwZGRVSlNsOTZ6Q2pzdGhCb0hMU2lzV2lH?=
 =?utf-8?B?MG1YQWE4S2VLSlV4cEpabHN5VktRS3lmeVBsL3NhN0RTQVV1NkdzYmtadDZ6?=
 =?utf-8?B?c29HZU1JRFZoSFIzSEllajUxejl3Y293Sk5aY3VzUHorc1RXTW1QUlJOTm1u?=
 =?utf-8?B?Tm80ZkVDZkdCSFdOU2xybXBoc280WUdaQmhRRXowRkNKeFFnMlpNRHFUZk56?=
 =?utf-8?B?RktvV256TnhNY0prKzljcUxYZE54eC9rSUNKQ2h3SUFjdGxUTU1JMnVScHlw?=
 =?utf-8?B?OU13R2dJUktqdEVaR3ZRUkZwN0FUcFV4SDhxNElLQ3VnY01JaWxvL08zY1BK?=
 =?utf-8?B?dGVzR0JnQWxOdGdsRDdFc3hWSHcrZzlKUjhMbWMvYlRwSFJ6RGFXWUpGTCtM?=
 =?utf-8?B?NW5hTXF5ZEhpajRZeHdBMERCbGgxZGxQK05MMTNDemZCSkFoVEJCNG5WMmRv?=
 =?utf-8?B?TWhBYWZMWFNSeTBiVi9tbFJDVXQ2WFV2WEQ2Ly9JbHdzd1dTb0tIREh1bjFw?=
 =?utf-8?B?RGJIS25OLzNhK1dnYy9xRXpXSG1ST0FuU3ozOG1NQnl2ZXVhbEZJVzZBcyta?=
 =?utf-8?B?UWp2YkU5ZTNWZkZCVnpSTDdINGs4UWI5SzRqMFBqRVk2eFd5Z3RqM3haN2Rl?=
 =?utf-8?B?elY1SnVDcGF3OTI4UFpTS0dVK2pPVFZ6djBoaXdKK253M2lYUHl1S3Vha2Nx?=
 =?utf-8?B?cms3cHM0a1ZZMTdKbEh2dHNzeE5ZVGlYTFovWWVPUXBDVEZTcnJLZUlqNkI1?=
 =?utf-8?B?dXYyQzFmczBTdC9SbWVjS2dNN1ZqRFBibUliaUFsdFpmV2Z4SnVzUndjWFcx?=
 =?utf-8?B?cDdPVkF0Z2ZnV0F2S2hKYlpuYVFqZTlBZFV2R1FVdFpTZVowVTgxTjM5SC8w?=
 =?utf-8?B?TCtQVXBNdWR2RDZFVCsrQlViOVh0NlJGa2E1eUNFZm9IM3d0UE9rb0g4UFJD?=
 =?utf-8?B?Rk5ueU5qSS94SkRpVUM3R3E3ZTNyT2F0eU9lZ0xpRXVobEwxM1ZrYzNjQVN3?=
 =?utf-8?B?cTB3OFMyRXdoZ2xOOWliN3hFMEtuM201TXBmR1BndGRycXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR14MB6519.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzIrbXA4UUFmVnZuMGlDdlU0Wk9nbWJCMUdFbzBnTCtvZnlxNjJGK3R4dElV?=
 =?utf-8?B?NU5WamwzNXZzVklES012NTFURlRlM1A5czdJWFlLMFdWbGNwdTdFZVZWaDgv?=
 =?utf-8?B?cUxBRlkrK2kxcm04ampycFNYR3ZCSGNVZlc3bkNMZmhubm80WDgzRWlFTFZl?=
 =?utf-8?B?S2N0bm1iVEpESUxkM3A5bzdTVWFhOUlWaHl4dFIwSTZtdXhTbHV5aERrTUtu?=
 =?utf-8?B?bmtZYm9RM2hpa0prU2UyUlhpTVBSVXlwcTVKblRnbFFZU05Jcm5Yc3N4ZEc3?=
 =?utf-8?B?WHA0bVdBeHF0Zmt6SjJXNVVuVEVObEREei9tS1ZRLzh0WFFXV1lIT1RYUW9t?=
 =?utf-8?B?M1BhM1pOYlhnRGVsNUlHZ0thN21tM2I4bFM1Q2RDbzhVak5WK1JMUWRmaFRC?=
 =?utf-8?B?S0hnRHU2bDM0VUlEUWlLczBtS2U1cWxUT0lLUy9JamladU4wcHp3Y3ZDcitZ?=
 =?utf-8?B?aWVFMmtuejUyRVowWXZzYmtEQVZFcXlDeG9VZUtqZFZDbW5iNmJjVnlZalpK?=
 =?utf-8?B?MXY1cnRreERxQ3JBSW5CTDJ6byt2cUpWZUZMY2w1TENKVlFXd3pVZERpQnpp?=
 =?utf-8?B?OXoxVGI5ekowWmw0UUlCRjVEbkFSdC9QdGRLWGNuMlM0elZiOEZDMCtKa0Fi?=
 =?utf-8?B?QVY5aEpkNUVtS2Y5NFV4R1pucXRYVjJCV1RNOWdia1ZYUlNNak42R2d6aXhs?=
 =?utf-8?B?ZG1Qa2RwdFNiOFdyTVRJSHVDclZOYWZYS25hNkJ6UXB0YVFWaDRTcml0aGxQ?=
 =?utf-8?B?R1N3V3h0b2NqQVVRL09PWFovdHQyaXBicDZ0UzNPeU8wL0ZzZmxESE9ubm5u?=
 =?utf-8?B?OWpGcHYrOS9CMjhRK3pRbURUeU1PU0ZqSEZGejI5dUdkcU1uLzZHNG5qTm5M?=
 =?utf-8?B?eHZyTmN4TXo0YUZJV1IzY0Q0Q2NjRDF5Q0h1d0dXTmUyM3JGM0tQK0Y5aUdi?=
 =?utf-8?B?SE5PMHI3VXJGb1NCbTZZbUc2MUw0QW9BQTE5OHhMblkyV1ljNG80U2JZWTVP?=
 =?utf-8?B?UnJpYVh1OU9SRXJOWHVzTVJMczJLQTZHcUlhSzFvcUZyOGZsdzZXMEg1L1Ra?=
 =?utf-8?B?MXp4MGJJN0xGbGhQcU42WisremFnL1JoYlBmcXlxMXZ1RHJyTEdPSm95Mklm?=
 =?utf-8?B?MW1EVFppV291emV3SnlCSXQxTWlqbTUyNXpCZUlyZWtnT0R0czRzL2x6U0VO?=
 =?utf-8?B?L1o2UnY0dEM3L1ZqS1cvb2d2bVpzY2VvSk82NnlDT3FLcFNPZzhCdVpra2Z2?=
 =?utf-8?B?SzFTMjV4bEkwclVsQUc0YzVYcGFlQy9vWEFmZ0UrbmVqNWZTcjgwbjBKQ0Nr?=
 =?utf-8?B?UE4wVi9SQTZ6Z0cwM1llVy9oYVRCTXVGQUdvVHhtU2hjQUVkZmh0ZlJESWpa?=
 =?utf-8?B?Sy9yODFidFZxVldpQW9taEE4K0ZYZ0lLTFdSTmlhSzNuUmVDZHN5QVZVK0ow?=
 =?utf-8?B?a1IrTi90d0thcmY5bUlZRWpua2c3RFhWcW1nVXBKWmNqcmhDUGJBU1RkeXZB?=
 =?utf-8?B?UFo3ZzliYXlvWTRvUkR4eG95SGVSY2NkbkNuLzk0S2dkRjM1SG9DOXY4OXJi?=
 =?utf-8?B?K3l6QmdNZ0d2ZGNXdUJTbEQxYytrZzNobTRqeTNTcGZaeUhjWGZKMWtudWFT?=
 =?utf-8?B?SzJNaHZSQnR5aWFZODRGRkJQS3l2M0RoQnYyMm5pU3lYS0hBTVNjckNuMVEw?=
 =?utf-8?B?YXQxR2ZYQ3dPaStHTTdQTXh0MGhwc3RFTFdkZGJVYXlzSURxUUVDTFduT0h2?=
 =?utf-8?B?N091bDZabkFvbVZiZ0lxeC9SRkNvTjYyOVpMeklXQThESStoSk0zY2xZQVZD?=
 =?utf-8?B?b0ZXN1cwamcvRWpDdXhEUmlSYlpsYVllVEhEM0lCb3d5bHJZbmwya3VmVDZI?=
 =?utf-8?B?dVZkNHR0bmVmV21lMVJpNmtVQTJ3TXd2T083RC9Xekw5aG1hdHdmN29CdUxT?=
 =?utf-8?B?bGtlclFKZXJPYmFOZzd0eUtCaklxb0lsSWZGVXBIbHovV3h3bkEyUDZ5NFpi?=
 =?utf-8?B?aDFtbjNhaGdxZlZuTWxRRVpCeExOVjVUN25RUWdjSlJaTmYraVY0aDE5azQ1?=
 =?utf-8?B?cDlGd2F0TkFYSFRKcXd4eGcwQmlYR0U5NGRKNG5pcGNpMndWV2F5OEo5UFdC?=
 =?utf-8?B?T0FDRjhNSTlWbkFleFFhNDJUZlhEcmhuK1JzTW5wSC92RnlzaERnME1pSTk2?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iongroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR14MB6519.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4cacf9-fee2-4c8b-6e49-08dc9c729d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 21:45:25.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 768fe7d4-ebee-41a7-9851-d5825ecdd396
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOyFOaW2oBclUyBDbHqArTHzdh4eo0mujZb4JB4bxW0IE9iV3Sd0rAtftbrDBDz4a0FCHkhtO4Mi1mNnLeDu6am0qU5cJYdSx6fcUnt3V1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB6787

SGVsbG8gRWxpamFoLA0KDQpUaGFuayB5b3UgZm9yIHJlcGx5Lg0KDQpJIGd1ZXNzIHRoZSBzaW1w
bGVyIGV4cGxhbmF0aW9uIG9mIHdoYXQgaXMgaGFwcGVuZWQgd291bGQgYmUgdGhlIGZvbGxvd2lu
ZzoNCg0KTGV0J3Mgc2F5IHRoZXJlIGFyZSB0aHJlZSBjb21taXRzOiBhZGRfYzEsIGRlbF9jMiBh
bmQgYWRkX2MzLg0KDQpXaGVuIHRoZXkgZ28gbGlrZSB0aGlzICJhZGRfYzEgKyBkZWxfYzIgKyBh
ZGRfYzMiIGF0IHRoZSBlbmQgb2YgZXhlY3V0aW9uIHlvdSBlbmQgdXAgd2l0aCAyLmNwcC4gVGhh
dCBpcyB0aGUgY2FzZSBiZWZvcmUgSSBkbyByZWJhc2UuDQoNCldoZW4gSSBjaGFuZ2UgdGhlIG9y
ZGVyIG9mIGNvbW1pdHMgaW50byAgImFkZF9jMyArIGFkZF9jMSArIGRlbF9jMiIgKHRoZSBjYXNl
IHdoZW4gSSBkbyByZWJhc2UpLCBJIGVuZCB1cCB3aXRoIG5vIDIuY3BwIGFzIGFkZF9jMSBhZnRl
ciBhZGRfYzMgZG9lcyBub3RoaW5nLCBiZWNhdXNlIHRoZSBmaWxlIGFscmVhZHkgZXhpc3RzLiBI
b3dldmVyLCB3b3VsZCBiZSBncmVhdCBmb3IgR2l0IHRvIHJldHVybiBhbiBlcnJvciB0aGF0IGl0
IGNhbm5vdCBjcmVhdGUgb25lIG1vcmUgZmlsZS4gVGhhdCBpcyBwcm9iYWJseSB3b3VsZCBiZSB0
aGUgYmVzdCBzb2x1dGlvbiB0byB0aGlzIGlzc3VlLg0KDQpJZiBJIGNoYW5nZSB0aGUgb3JkZXIg
b2YgZXhlY3V0aW9uIHVzaW5nIHRoZSBicmFjZXMgbGlrZSBpbiBtYXRoIGludG8gImFkZF9jMyAr
IChhZGRfYzEgKyBkZWxfYzIpIiwgdGhlbiBHaXQgZmlyc3QgZXhlY3V0ZXMgdGhlIGNvbnRlbnQg
b2YgYnJhY2VzIGFuZCB0aGF0IGV4cHJlc3Npb24gZ2l2ZXMgbWUgYSBuby1vcCAoZmlyc3QgcmVi
YXNlKSwgdGhlbiBpdCBleGVjdXRlcyAiYWRkX2MzICsgbm8tb3AiICh0aGUgc2Vjb25kIHJlYmFz
ZSkuIFRoYXQgZ2l2ZXMgbWUgYSAyLmNwcCBhdCB0aGUgZW5kLiBUaGF0IGlzIHdoeSBpdCB3b3Jr
cyBhcyBleHBlY3RlZCB3aGVuIEkgZmlyc3QgbWVyZ2UgZGVsX2MyIGludG8gYWRkX2MxIGFuZCBh
dCB0aGUgZW5kIEkgbW92ZSBhZGRfYzMgYmVmb3JlIGFkZF9jMS4NCg0KDQoNCkJlc3QgcmVnYXJk
cw0KRGltYQ0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZy
b206IEVsaWphaCBOZXdyZW4gPG5ld3JlbkBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVs
eSA0LCAyMDI0IDExOjAzIFBNDQpUbzogRG15dHJvIE92ZGlpZW5rbyA8RG15dHJvLk92ZGlpZW5r
b0Bpb25ncm91cC5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZyA8Z2l0QHZnZXIua2VybmVs
Lm9yZz4NClN1YmplY3Q6IFJlOiBMb3NpbmcgdGhlIGZpbGUgZHVyaW5nIHJlYmFzZQ0KDQpbWW91
IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIG5ld3JlbkBnbWFpbC5jb20uIExlYXJuIHdoeSB0
aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRp
ZmljYXRpb24gXQ0KDQpDQVVUSU9OOiBbRVhURVJOQUwgRW1haWxdDQoNCg0KT24gVGh1LCBKdWwg
NCwgMjAyNCBhdCA3OjI54oCvQU0gRG15dHJvIE92ZGlpZW5rbw0KPERteXRyby5PdmRpaWVua29A
aW9uZ3JvdXAuY29tPiB3cm90ZToNCj4NCj4gSGVsbG8sDQo+DQo+IEknZCBsaWtlIHRvIHJlcG9y
dCBhbiBpc3N1ZS4gSSdtIG5vdCBzdXJlIGlmIGl0IGlzIGEgYnVnLiBHaXQganVzdCBiZWhhdmVz
IG5vdCBpbiB0aGUgd2F5IGFzIEkgZXhwZWN0ZWQuDQo+DQo+ICQgZ2l0IC0tdmVyc2lvbg0KPiBn
aXQgdmVyc2lvbiAyLjM0LjENCj4NCj4NCj4gVGhlIHByb2JsZW0gaXMgdGhhdCBHaXQgIGlzIGxv
c2luZyB0aGUgZmlsZSB3aGVuIEkgZG8gcmViYXNlLiBGb2xsb3dpbmcgYXJlIHRoZSBzdGVwcyB0
byByZXByb2R1Y2UgdGhlIGlzc3VlOg0KPg0KPiAxLiBta2RpciB0ZXN0DQo+IDIuIGNkIHRlc3QN
Cj4gMy4gZ2l0IGluaXQNCj4gNC4gdG91Y2ggMS5jcHANCj4gNS4gZ2l0IGFkZCAxLmNwcA0KPiA2
LiBnaXQgY29tbWl0IC1tICJBZGRlZCAxLmNwcCINCj4gNy4gdG91Y2ggMi5jcHANCj4gOC4gdG91
Y2ggMy5jcHANCj4gOS4gZ2l0IGFkZCAyLmNwcCAzLmNwcA0KPiAxMC4gZ2l0IGNvbW1pdCAtbSAi
QWRkZWQgMi5jcHAgYW5kIDMuY3BwIg0KPiAxMS4gZ2l0IHJlc3RvcmUgLS1zb3VyY2UgQH4xIDIu
Y3BwDQo+IDEyLiBnaXQgYWRkIC11DQo+IDEzLiBnaXQgY29tbWl0IC1tICJEZWxldGUgY29tbWl0
dGVkIDIuY3BwIg0KPiAxNC4gZ2l0IHJldmVydCBADQo+IDE1LiBnaXQgcmViYXNlIC1pIEB+Mw0K
PiAxNi4gTm93IGluIHRoZSBvcGVuZWQgZWRpdG9yDQo+ICAgICBhLiBtb3ZlIHRoZSBsYXN0IGNv
bW1pdCAocmV2ZXJ0IGNvbW1pdCkgdG8gdGhlIHRvcCBvZiB0aGUgY29tbWl0cyBsaXN0DQo+ICAg
ICBiLiBzcXVhc2gvZW1iZWQgIChieSB0eXBpbmcgJ2YnKSB0aGUgIkRlbGV0ZSBjb21pdHRlZCAy
LmNwcCIgY29tbWl0IGludG8gdGhlIGNvbW1pdCAiQWRkZWQgMi5jcHAgYW5kIDMuY3BwIg0KPiAx
Ny4gU2F2ZSBhbmQgZXhpdA0KPiAxOC4gbHMNCj4NCj4gVGhlIG91dHB1dCBpcyA6IDEuY3BwIDMu
Y3BwDQo+IEV4cGVjdGVkOiAxLmNwcCAyLmNwcCAzLmNwcA0KPg0KPg0KPiBJbiBjYXNlIGlmIGF0
IHRoZSBzdGVwICMxNiB5b3UgZmlyc3QgZG8gMTZiLCB0aGVuIGNsb3NlIHRoZSBlZGl0b3IsIHRo
ZW4gc3RhcnQgcmViYXNlIGFnYWluIGFuZCBkbyAxNmEsIHRoZW4gYWxsIHRoZSBmaWxlcyBhcmUg
b24gdGhlaXIgcGxhY2VzLg0KDQpOb3QgYSBidWc7IEkgdGhpbmsgeW91IGFyZSBleHBlY3Rpbmcg
cGF0Y2hlcyAmIGNvbW1pdHMgdG8gY29tbXV0ZSwNCndoZW4gdGhleSBkbyBub3QuDQoNCk9uZSB3
YXkgdG8gbG9vayBhdCB0aGlzLCB3aGljaCBJIHRoaW5rIHlvdSBhcmUgdmlld2luZyBpdCBmcm9t
LCBpczoNCiAgICogSWYgeW91IHN0YXJ0IHdpdGggMi5jcHAsIHRoZW4gcmVtb3ZlIDIuY3BwIGlu
IGEgY29tbWl0LCB0aGVuDQpyZXN0b3JlIGl0IGluIGFub3RoZXIgY29tbWl0LCB0aGVuIHlvdSBl
bmQgdXAgd2l0aCAyLmNwcDsgaXQgX2FwcGVhcnNfDQp0aGUgbGFzdCB0d28gY29tbWl0cyBhcmUg
anVzdCBpbnZlcnNlcyBhbmQgdG9nZXRoZXIgZG8gbm90aGluZy4NCkFuZCBzaW1pbGFybHksDQog
ICAqIElmIHlvdSBzdGFydCB3aXRoIG5vIGZpbGUsIHRoZW4gYWRkIDIuY3BwIGluIGEgY29tbWl0
LCB0aGVuDQpyZW1vdmUgaXQgaW4gYW5vdGhlciBjb21taXQsIHRoZW4geW91IGVuZCB1cCB3aXRo
IG5vIGZpbGU7IGl0DQpfYXBwZWFyc18gdGhlIGxhc3QgdHdvIGNvbW1pdHMgYXJlIGp1c3QgaW52
ZXJzZXMgYW5kIGRvIG5vdGhpbmcuDQoNCkhvd2V2ZXIsIGlmIHdlIHRha2UgdGhlIGxhc3QgdHdv
IGNvbW1pdHMgYWJvdmUgZm9yIGVhY2ggc2NlbmFyaW8gYnV0DQpnaXZlIGl0IGEgZGlmZmVyZW50
IHN0YXJ0aW5nIHBvaW50Og0KICAqIElmIHlvdSBzdGFydCB3aXRoIG5vIGZpbGUsIGFuZCB0cnkg
dG8gcGxheSBhIGNoYW5nZSB0byByZW1vdmUNCjIuY3BwICh3aGljaCBhbHJlYWR5IGRvZXNuJ3Qg
ZXhpc3QpLCBhbmQgdGhlbiBhZGQgMi5jcHAsIHRoZW4gdGhlDQpmaXJzdCBjb21taXQgaXMgYSBu
by1vcCB0aGF0IGRvZXMgbm90aGluZyB3aGlsZSB0aGUgc2Vjb25kIGFkZHMgMi5jcHAuDQpUaGUg
bGFzdCB0d28gY29tbWl0cyBhcmUgY2xlYXJseSBub3QgaW52ZXJzZXMuDQogICogSWYgeW91IHN0
YXJ0IHdpdGggMi5jcHAsIHRoZW4gYWRkIGEgY2hhbmdlIHdoaWNoIGFsc28gdHJpZXMgdG8NCmNy
ZWF0ZSB0aGUgc2FtZSAyLmNwcCwgYW5kIHRoZW4gcmVtb3ZlIDIuY3BwLCB0aGVuIHRoZSBmaXJz
dCBjb21taXQgaXMNCmEgbm8tb3AgdGhhdCBkb2VzIG5vdGhpbmcgd2hpbGUgdGhlIHNlY29uZCBy
ZW1vdmVzIDIuY3BwLiAgVGhlIGxhc3QNCnR3byBjb21taXRzIGFyZSBjbGVhcmx5IG5vdCBpbnZl
cnNlcy4NCg0KV2hlbiB5b3UgdHJpZWQgdG8gcmViYXNlIGFuZCBzd2FwIHRoZSBvcmRlciBvZiBj
b21taXRzLCB5b3UgdG9vaw0KdGhpbmdzIGZyb20gb25lIG9mIHRoZSBmaXJzdCBzY2VuYXJpb3Mg
dG8gb25lIG9mIHRoZSBsYXN0IHR3bw0Kc2NlbmFyaW9zLg0KDQoNClBsZWFzZSBhY2Nlc3MgdGhl
IGF0dGFjaGVkIGh5cGVybGluayBmb3IgYW4gaW1wb3J0YW50IGVsZWN0cm9uaWMgY29tbXVuaWNh
dGlvbnMgZGlzY2xhaW1lcjpodHRwczovL2Rhc2hmaW5hbmNpYWwuY29tL2Rpc2NsYWltZXI8aHR0
cHM6Ly9kYXNoZmluYW5jaWFsLmNvbS9kaXNjbGFpbWVyLz4NCg0KDQo=
