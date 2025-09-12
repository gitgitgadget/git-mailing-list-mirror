Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013080.outbound.protection.outlook.com [52.103.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A0302775
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684004; cv=fail; b=Nl9uvVYHUVAo3YEpWEazngG2gnVeKBNAaso3VWmWFrK6QzYoo+CvwhuLgl3F+67Ee/B5x0Q4VYdz3wOTTSbXVCoVbSyxJY7St54ikPkUhuV9lK78t9Uh0SxE62fIKxPOQyi5uYMIyZcfD1lzQB+xtl5Py3o14WepqlpJMOwqYTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684004; c=relaxed/simple;
	bh=zYJOM1soWP5V3QsmWfimXrtXCxkYSCDM6w5SwCwroKM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mqsu/SMqRkWF74lNpaC6fhzaXni5pZTJckx9kXmdvr7SmOyrzDSKrqrhRN8g7k/0URWEZz+qk7czJim4hW9BMTb0FGHeW2HPTG7znKtSQqr4pvlsfY9GgE1KpPA4vglYN4JV3RPmMwYKUWo0/ikUNoo/yxc2HdVk8ve2GYEYVY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CM0FBm3E; arc=fail smtp.client-ip=52.103.7.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CM0FBm3E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+yE7r+LmF5pVlo23H1Ntt2KwbRqh8TgkFDw41kAcuyLCqfLC4U/I2/jpLpL8HaBeajVk0VkykHgRDFKm+BALCsrCtMJdQNTQpsdswfOeIkRoDhlo6P8+kAZi0EaQBWwyJUFu5HBjs2HhSr6zF6DMBwVt7BXBcEtBVyroeUWnrykJgxyM2/uZ9+oKUx7A1jgsoca9KDiDIfSCrjsB6gG/3rqSfRr+iWF243wGjvhi5VEDTXWXdT0qjkTZQJ16NGXJXMsAA3Jzxz7ISzgijPgwK8B78E0OBUuNyCv+rAjJTbQYy3ARye4umAfvKcacwWPNkN4YHpoaHQfyhk072E/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYJOM1soWP5V3QsmWfimXrtXCxkYSCDM6w5SwCwroKM=;
 b=jfCJSMwe078wj5lalpX2t0nQEKLVS5AObPoIgjjGhler53sSodFyoFRL1NDbL5vXgNSK2MKMWlUgOWVWRbpLF5+a5ks2FPQIKJvs+uCjzSUyUZmK5Otx6poTfh2KN4h+io04qGWUpIIwBeEd4oSGLizNhbJpxLLvuXUYxajyGd3gSfS/NuFmQDMajhfIshKK04ZUkjcmPW2o3tLiiF79AqY23zjRlWu7mJEVtqiJrio96aVW9QFB9aCDvSGlRYNYppCfSm8HYEXyxBOwU1JP9Pxn2Z6+AKnr+acDUrv7MJHEN7iyeHdNY5YnoN8rgOm3ZwG7nQ1ttyhrqt9+m11N/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYJOM1soWP5V3QsmWfimXrtXCxkYSCDM6w5SwCwroKM=;
 b=CM0FBm3ExrDHUU75I3KjlooXPP5a7obUjLVfqhKXFHpjIoaQwzXu3rvWBchLWWh9Ros64nFhyU7wgDyAWdCmyUoTUUjNp/Nb8dZvdpxF11Ymc0in5+otH8CniyeVoZ+LMGWIKHY7WPdr6iTOFrGtmxI9oqdJUntOW7MhpwaTqbg36beH4pKzDL3ZiBhIGcKwsJdqMJuKpu59c8SUVg+epVEKn8dRgfyeFlNCHTmO+MMD2Xa1FGgvzky1oGnbbObiBIb9g+8+IN+I6p2TZO58HPK+UrKC+HwMo0mZjOko16aOEne/YgOdPE4Ac+9Q0nTO8E48DGOrmzO4P2c0i5KP6A==
Received: from SN6PR03MB4285.namprd03.prod.outlook.com (2603:10b6:805:c1::17)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 13:33:20 +0000
Received: from SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b]) by SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b%5]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 13:33:20 +0000
From: Guo Tingsheng <CoriCraft16@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git apply misplaces patch when similar code fragments exist in
 the same file
Thread-Topic: [BUG] git apply misplaces patch when similar code fragments
 exist in the same file
Thread-Index: AQHcI+mst9hjUm1ElEy6MTQvegh4sg==
Date: Fri, 12 Sep 2025 13:33:20 +0000
Message-ID:
 <SN6PR03MB428591529FBE9413B427B030AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4285:EE_|SA1PR03MB6545:EE_
x-ms-office365-filtering-correlation-id: b8f193c1-3b90-4c4e-a5f5-08ddf200f089
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpVAjouTXUgUPX+o0ch3BuGwYhstVjz3fS9WPfyd50g7nlYrMaTegQPoTkM/pFRKE0AqfMfImzCXydfDhr2t7AP6YIamoVZVVUSvDsDR3mKGUoQ3R3VYStJBsfsSYyXTfAjrkBVx58kca72stLn8aYPe8KmrbvdI5Caa+EBgi4So8L/+hc5akvFRqvwPqws3bgnBBmNSNOk+7mfvshXdYUiVrdK3WMbx4l05CBXHO4nru5GBhKsZpfY4tTtkBEh2TBvoXOD4OWSh2nmNbqcqsKdEN5tFfEsXZQkbCxyiXMPC7lBQuP/GbLkWXtNv0CDN6MHQRZKKCJAQDtXYG9rm0AWDOU0W9LqBrHCHK7TjtCyloJLUkSX9y8t0588RV8xczxj7XSs0hYXPzMQcsMwFQb08QnLBxhfeoF1Zcjbn3J8IYMrp9A3EkB/yu1A2TrSijgYE3XWmO9QGkhLLtkBwsABbZIckp78w7Vke/g70lLLyyNL2PAdD3CZmlQst3vQ0opvHP5wb+bDUQPdz6J/vNYaUakjW/bX2eh3XbT4klkzaidkp2/M5bMi3A6wgUIZir3oaga6EzLIjdTWqCi7cEZcX7N90f7QXsKvd1AAjn15HOyq53xLQZPi0NcyuDQroKfi9surRQ9jZvgAMxagsEwfQsVYb2+lBi3gj8F9JKPhmneYWqPlejk0OwNfCmHgP7h1EVrtygNad+rykamgxTdmlFQcks59G2nkPuqN07xjFJtxa6MkWbWP1
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|15030799006|15080799012|7042599007|41001999006|8060799015|8062599012|19110799012|40105399003|440099028|3412199025|102099032|3430499032;
x-microsoft-antispam-message-info:
 =?gb2312?B?OXJJY1VzUXlmMy9PZk5JaDZidUxuSE5aQlhublcxNDRhQmlUSWRMbWt6VHgr?=
 =?gb2312?B?d29aaldYYnRxYjFEeXZkSkpFTGs3YnpaenI4bVZrS3V1eWJnd3BxVHNzMjV4?=
 =?gb2312?B?a1ZTUHNXY0d6NG9XZXRhZUpKU0ZiY0tGY3Q0bHhxc29Nd21GYXlMcUxkNWVX?=
 =?gb2312?B?bisyenl0RnBiZ00zQm1XdGxoL1pMMWx0Qi9kV3NrdHYxakNLUjBHZFkwZmt4?=
 =?gb2312?B?cmpkM0VxWFdFM0JJR0VkblpBZXdPbk9JeXJmVGM4dUNwbVUrdzZwbXE5VHB4?=
 =?gb2312?B?ci9KRnFrUCtMbXQ3K3dtTGE0Ymxja3RheFR1VWhJRVN4ckgvekNiOVdlVEda?=
 =?gb2312?B?cmhNVTE3SGN0S2JmYzFxdmxHQzA2bzNvNGFTcURtdXAydVBVUndUcTQ3ZHcw?=
 =?gb2312?B?aHpEVW9US0VIOVQ1TlZhYVdwWEIzYk50SjQvam5hT25OdUQvK2E1eUcvMDJK?=
 =?gb2312?B?R3huMk14aDBYZVFyREdnZnZqNHZ6TjlJeGdlTGl2VjRzS1NadlVpTmxuQS9s?=
 =?gb2312?B?bmhlaks3S3dyL1o0RHJmMTV6dUllWXJibGlISHQva0ZGd3J1VjExem1ZQVV1?=
 =?gb2312?B?K3NIcVByVUN6dTRja2IvVTk0UWhGa1RMRHRzeWpMb05FOXBOdWg0dXhFN2Z5?=
 =?gb2312?B?NENWL3RtRVJjdzYvZE1UaHdSdFlCanVkRGh2aHZheE85NEpydEc2N0NmMmJp?=
 =?gb2312?B?a2M4VEFTUGo3SmFlbHFueFhQYlY5Q08yeWhOd3d0dUhIV0FIeEMvbktSZHdG?=
 =?gb2312?B?T1Z2aWZ3OVBheWFLcXNxUGRxRFlpU21JakZWdkJuTW5BQTJ1OUEweWdxdUty?=
 =?gb2312?B?RWp6WnhzZC9ZaEgxcFFzeDFHQUxUaW9hNzd6TGdmcDBFazUyblNQMHBDSkFC?=
 =?gb2312?B?MEQ0c2xKOEpXT2RmSFRxSGVuaWZFRjZRWGpqZVFqYlVRbmtxRWVkY0RjT3hh?=
 =?gb2312?B?VFU4dnhkN0JXc1BiUllhWWFPeGQ4eFdBQlRPNHdLV0FGUFpKMzNGcytqajBF?=
 =?gb2312?B?ZXJORWZvU1VWZzY5M213Y20zN1pkWTEwbFUrd0NRVXV1N0hjcW5rSmNLZDZh?=
 =?gb2312?B?TWZUdU45U1IvL1RPK3VLeUVyNVNlWjc4VHpRVFpwQWsyVTlyR1llZXhSVVRy?=
 =?gb2312?B?QW9LMUxycG0xUnNCOUpMNm1ZYitNRG9ZQkdsanlSeGJLbmc2NWtObzMxQnZj?=
 =?gb2312?B?UWFadFJlZVIrRjhTZUhXNmRoUW55dDZ2Vmg3VTNhMlViV1FOMlpwOTFOa3F4?=
 =?gb2312?B?T2ZYNFBCVnVESnlaYXNpSzQyWXBVSWtMRHdyOUkvMnpUTXRYWWp2MVJpNXRk?=
 =?gb2312?B?K0ZmRTdtaWd2bmxGVWNIQjBabVhGcTRyMWsyVGM3YUtiQlFMM0FXS0pDbGts?=
 =?gb2312?B?TklhOStvL2lEVGpWRWFFbXNaQ3JJeHFybG9CV04xVUV1SlEvSzFhUHk3UVBV?=
 =?gb2312?B?RHRmTWhRbTZwMDh6bUZVMjZQRCszdnZMRFQ0NjV2TTdhS3dqQXh0K25TOG5B?=
 =?gb2312?B?SGhZSzVGcjBFbWRIOU4zVDljbUtyZXBYSHZJdzJncE5Jays3ckJ1OXhmZVFj?=
 =?gb2312?B?bDQzN0dYS0NNRGFtYzc0MDFybVdGblVaR3FPR1htbHpUZXc4TUVLb2xqR2lV?=
 =?gb2312?Q?nilStZpiAkQW+Y6+jHgsdgy6hc6r2RCQNoJyZ7T7sodM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K1VBUnMxd01ZejFOZGdHL0Jva0tqMHplQlRIVHQzZlY5MEZjZ0V0Rno3eWxs?=
 =?gb2312?B?RzgyQXlVZnQrWW1IdjNiVkZiTGFDOU9zQ2NVaEtWWG9Ha1Y3TURhRUxvQ1F4?=
 =?gb2312?B?NUZUOUtsb0ZHN3Y4VUt2QlBuRjIyZlVNam83YWlyK3Y0Q0h3dmFHbVVRdG9O?=
 =?gb2312?B?OXFsY2xPN0tPRHhheXVlamFHZzJ3Qm9JUFg5ZzlpVi9Da3dCNUU2R0lkRUcw?=
 =?gb2312?B?RmRvU01nQlpldFRWUDc2MkJuNVlTMTdraEpNczBCMlJxeUhPWTZYUzhvU2tC?=
 =?gb2312?B?M2V1ZTdqTm84alFIVko2SzFtOURGdEdEZE83WmhnaGs3dkVta3Q2bVAveEdv?=
 =?gb2312?B?bnhGVllBbDZRL3pPaUR2Z01XNThBdzZRcTNidCs3cUhYV1gxZWMwUkx6Mk9z?=
 =?gb2312?B?eUlhMis5aGJXd04yYjgxMGlqSG0vdGFnbm9ReE1NQkZqbi9DMzIvMFV6cjRk?=
 =?gb2312?B?MVNnVDM3VlJnNTVLSGVzcUh2d0xGWlNvWjd4NTY2b2IrcUJ1Q2pBZ0IxRlFz?=
 =?gb2312?B?ejNVMDNVd1ZGSEltMFBRSVE2RU8xN3VJcWNTR091UHFrZndQc2tRSE52cFNm?=
 =?gb2312?B?c3Ardkp6RHlndENkcDBoZWhIMkRPemNScE02SG90Ry8yU0pjWjZMZmZRRFJS?=
 =?gb2312?B?ZklRTm1UazV5ODhYSVpScFpmRGVhK2VvV0ZZTGxRRCtzaVlXd2x5ajI0cm8z?=
 =?gb2312?B?elRMdElNSHJJQUtjOFNlbXY1T3Z2NURCeUt0Ny9JZ2FGdE00OU8vUEVmRmkw?=
 =?gb2312?B?ZE1PTnp1YlY1b3I0T3BYeFNPZUhzNXpQTEtnVWVWWEQ2bXlVdjkxajloZlQx?=
 =?gb2312?B?bUdWVWZlN2lSNG9mQ2ZmNk1YdXNvWk9oUlBOb1dJZWZralZCUmIvSHJ4bTFp?=
 =?gb2312?B?QURuNTZ0dGNmeC9ER3NXMlg1L3ZNYnV3YVFROU9DZnR0TGk5VmJZQitlTitl?=
 =?gb2312?B?Rlk1MTNGUXJPWG44YWNzMWRXUTlXQnBZVEtWK1pEMDI1WGhzY1hPcWpHVjJF?=
 =?gb2312?B?bzBuUGhnN2doZ05lOTlMV2pWN25sc29YMDNoNFRVT1VjN0hLYWRhQ0dZcDJH?=
 =?gb2312?B?cTZBRWhhclNNclcxdnRNaGd0ZEdybyt2M3ZnUS9rYTJtOUhsTUxyZ2VWYXBU?=
 =?gb2312?B?MURCZU9pTS92SnpjZkZsTHo1QzNVMEJ1VDUxaWZJcHl4WklYYzRqV0JUOHYx?=
 =?gb2312?B?TlRDMS83czNvcXRTQ0hkaFFmNFVCclZJL3ZlbmVMcWdtZXhxMHRmdXUzVWk1?=
 =?gb2312?B?T1RsckZFckhXVm9HYnphRkdqMTNqR1A0K2xUTGlFSUkzcEltM3dSVmt0MWlI?=
 =?gb2312?B?OXlUWEtJTlpCYkZHNUkwVXF5eXMzR0x0SlI5Q04rUVRpSGxIa2gvN3MzQ2t0?=
 =?gb2312?B?cm9IVG5zNXh3R1ExNmo0MUtaUENsbVhFNFR4R0NoTEJ6Z09peVlwdGp6aXI2?=
 =?gb2312?B?TmU0cFo3WW52dFh6YVhTS2c1MGJkTHFlb1o0QUhjaDRmL2dsM1R5KzR5cDda?=
 =?gb2312?B?MkduNE9RRUlmMGhiMWVKUE4zZHM5b1VnNEE1TVRoSGhwZ05vZkROcHhqUUxG?=
 =?gb2312?B?cUdaWTVYYXg1a1FhWkRaUS9SWnFvUHZwdkhmOWpvSnV4cDV5VjlDYzRGbXhi?=
 =?gb2312?Q?tWEeprRTog4sIfCQeTa8I1PNG31flD3QUtXyOVDCcacs=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4285.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f193c1-3b90-4c4e-a5f5-08ddf200f089
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 13:33:20.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545

SGVsbG8gR2l0IGRldmVsb3BlcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcG90ZW50aWFs
IGlzc3VlIGluIEdpdCdzIHBhdGNoIGFwcGxpY2F0aW9uIG1lY2hhbmlzbSwgd2hlcmUgYSBwYXRj
aCBjYW4gYmUgaW5jb3JyZWN0bHkgYXBwbGllZCB0byBhIHNpbWlsYXIgYnV0IHVuaW50ZW5kZWQg
Y29kZSBsb2NhdGlvbiBpZiBsaW5lIG51bWJlcnMgaGF2ZSBzaGlmdGVkLgoKRW52aXJvbm1lbnQ6
Ci0gZ2l0IHZlcnNpb246IDIuNDMuMAotIE9TOiBVYnVudHUgMjQuMDQgTFRTCgpTdGVwcyB0byBy
ZXByb2R1Y2U6CjEuIFN0YXJ0IGZyb20gQ29tbWl0XzEsIGNvbnRhaW5pbmcgdGhlIGZvbGxvd2lu
ZyBmaWxlOgoKICAgZnVuY3Rpb24gSGVhZGVyQ29tcG9uZW50KCkgewogICAgICAgcmV0dXJuIGAK
ICAgICAgICAgICA8ZGl2IGNsYXNzPSJsYXlvdXQtc2VjdGlvbiI+CiAgICAgICAgICAgICAgIDxi
dXR0b24+Q2xpY2sgTWU8L2J1dHRvbj4KICAgICAgICAgICA8L2Rpdj4KICAgICAgIGA7CiAgIH0K
CiAgIGZ1bmN0aW9uIEZvb3RlckNvbXBvbmVudCgpIHsKICAgICAgIHJldHVybiBgCiAgICAgICAg
ICAgPGRpdiBjbGFzcz0ibGF5b3V0LXNlY3Rpb24iPgogICAgICAgICAgICAgICA8YnV0dG9uPkNs
aWNrIE1lPC9idXR0b24+CiAgICAgICAgICAgPC9kaXY+CiAgICAgICBgOwogICB9CgoyLiBJbiBh
bm90aGVyIGJyYW5jaCwgQ29tbWl0XzIgaW50cm9kdWNlcyBhZGRpdGlvbmFsIGltcG9ydCBzdGF0
ZW1lbnRzIGJlZm9yZSBIZWFkZXJDb21wb25lbnQsIHNoaWZ0aW5nIGl0cyByZXR1cm4gc3RhdGVt
ZW50IGZ1cnRoZXIgZG93biAoYXJvdW5kIGxpbmUgMTApLiAgCiAgIEluIENvbW1pdF8yLCB0aGUg
YnV0dG9uIHRleHQgaW4gSGVhZGVyQ29tcG9uZW50IGlzIG1vZGlmaWVkIGFzIGZvbGxvd3M6Cgog
ICBAQCAtMTAsNiArMTAsNiBAQAogICAgICAgIHJldHVybiBgCiAgICAgICAgICAgIDxkaXYgY2xh
c3M9ImxheW91dC1zZWN0aW9uIj4KICAgLSAgICAgICAgICAgIDxidXR0b24+Q2xpY2sgTWU8L2J1
dHRvbj4KICAgKyAgICAgICAgICAgIDxidXR0b24+teO79zwvYnV0dG9uPgogICAgICAgICAgICA8
L2Rpdj4KICAgICAgICBgOwogICAgfQoKMy4gR2VuZXJhdGUgYSBwYXRjaCBmcm9tIENvbW1pdF8y
LgoKNC4gQXBwbHkgdGhpcyBwYXRjaCBvbiB0b3Agb2YgQ29tbWl0XzEgdXNpbmc6CiAgIGdpdCBh
cHBseSBjb21taXQyLnBhdGNoCgpFeHBlY3RlZCByZXN1bHQ6Ci0gVGhlIHBhdGNoIHNob3VsZCBh
cHBseSB0aGUgY2hhbmdlIHRvIEhlYWRlckNvbXBvbmVudCwgbW9kaWZ5aW5nIGl0cyBidXR0b24g
dGV4dC4KCkFjdHVhbCByZXN1bHQ6Ci0gVGhlIHBhdGNoIGlzIGluY29ycmVjdGx5IGFwcGxpZWQg
dG8gRm9vdGVyQ29tcG9uZW50IGluc3RlYWQsIHByb2R1Y2luZzoKCiAgIGZ1bmN0aW9uIEhlYWRl
ckNvbXBvbmVudCgpIHsKICAgICAgIHJldHVybiBgCiAgICAgICAgICAgPGRpdiBjbGFzcz0ibGF5
b3V0LXNlY3Rpb24iPgogICAgICAgICAgICAgICA8YnV0dG9uPkNsaWNrIE1lPC9idXR0b24+CiAg
ICAgICAgICAgPC9kaXY+CiAgICAgICBgOwogICB9CgogICBmdW5jdGlvbiBGb290ZXJDb21wb25l
bnQoKSB7CiAgICAgICByZXR1cm4gYAogICAgICAgICAgIDxkaXYgY2xhc3M9ImxheW91dC1zZWN0
aW9uIj4KICAgICAgICAgICAgICAgPGJ1dHRvbj6147v3PC9idXR0b24+CiAgICAgICAgICAgPC9k
aXY+CiAgICAgICBgOwogICB9CgpBZGRpdGlvbmFsIGluZm9ybWF0aW9uOgotIFRoaXMgaXNzdWUg
b2NjdXJzIHdoZW4gYSBmaWxlIGNvbnRhaW5zIG11bHRpcGxlIHNpbWlsYXIgY29kZSBmcmFnbWVu
dHMsIGFuZCB0aGUgcGF0Y2ggY29udGV4dCBmYWlscyB0byBtYXRjaCBkdWUgdG8gbGluZSBudW1i
ZXIgc2hpZnRzIGJldHdlZW4gY29tbWl0cy4KLSBBcyBhIHJlc3VsdCwgZ2l0IGFwcGx5IG1heSBp
bmNvcnJlY3RseSBtYXRjaCBhZ2FpbnN0IHRoZSB3cm9uZyBvY2N1cnJlbmNlIG9mIHRoZSByZXBl
YXRlZCBjb2RlLCBpbnRyb2R1Y2luZyB1bmludGVuZGVkIGNoYW5nZXMuCi0gVGhpcyBjYW4gcG90
ZW50aWFsbHkgbGVhZCB0byBzdWJ0bGUgYnVncyBpbiByZWFsLXdvcmxkIHByb2plY3RzIChlLmcu
LCBjb25maWd1cmF0aW9uIGZpbGVzLCBIVE1ML0pTIGNvbXBvbmVudHMpLgoKVGhhbmtzLCAgCkNv
cmkK
