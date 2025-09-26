Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020075.outbound.protection.outlook.com [52.101.188.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065924167A
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883018; cv=fail; b=sRQx27EY7hf4/49E0hEkewXNMLsf2mX2wOROJAaQ166Cj+1PnQvCCoHVJ4aJUhRHjGkviGdkvNHsax+Eg4vZZbpSMM5ssJmFwBjlELlaaozipG0UdOjQb7Z/IHTWcxO27QI8vyKtlMLTD5hhiw5QezO4+2eLok8dS6WcRLDEJE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883018; c=relaxed/simple;
	bh=iV+RGQxfleq+hgF3i2bkNXx8VVdX0N7iGnboepMOyMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TC2wUvmgufHhhqAFCth2gjtaqx1s4hnDo+S4jSxPHUcGHOtOapNZHOjjz26QbUpfgxJJKaoYnJ3ocTxa6p/XClZxU1XjE0EIUfzUUC+WXsPGRJHkakSXsNNbn198Ikhr0bD9KUjjCGgmok2XyMLDF/eeV+CFbajDP5vvwWF8kwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=enclustra.com; spf=pass smtp.mailfrom=enclustra.com; dkim=pass (2048-bit key) header.d=enclustra.com header.i=@enclustra.com header.b=WbLYlxKM; arc=fail smtp.client-ip=52.101.188.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=enclustra.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enclustra.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enclustra.com header.i=@enclustra.com header.b="WbLYlxKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPQ607FH3K/+ZMnjQPEitA5mrw/YAjiQ6xTh0VbgaCvHtIf9AiRMzpOOugq1iajPHpO/QN46Va/08agVLLVQk09O9LRLWQoHoCgnU6STESPi06EJJt09L9I52zuWOGtcs4BLJ3YI6DYq/cGpzz2M+lcHpLIYPkIZt7rEiSI+ORL4rD7JRuUnpIb4C+spEWwt0IePVjOoCqnvuzsjfCdzPEq/50t1VJtTEFTVS+bSgL8nVJvA+s9Lel1Er4HL2UiV8WEahdW9Bn8MzuiWvPRiTecbYhNHYIjSRPWrUKYJE+AfuQiq0WCFuE4XNulBW0AUjq/mP58/VubRn6B6vpyWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV+RGQxfleq+hgF3i2bkNXx8VVdX0N7iGnboepMOyMw=;
 b=OFI1CiAVLCqaYeJ5tKijIpvtS7db0Q9Yj8SmkIHVfoFr5JM34BBGen5PFWRgqZy4rjhzw0paFhTCiraLYBN2f4eha15TKQNGf8ydSi3tdPvYuork/sPHjYYCZ2h5FOcM3SCEMyXle1adjHhPkSjyY5PKvz4eoQ+/mA6XwqWCeHW+K+W6NaKoRW/80OlaN0zcvNXYCgZW4A3l+lVWvo4RaFEG+rFMuZlCRExbCwNYo+eKu0680H5w3RmisB3G9GtqphERi2mWdl0m1rkm0dA6sqAW9Uk+5ibhGM7hC9Pp/szltCrXGMzHceqRghe8mrNlCew/vB9ZglHcNzwGT1hG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=enclustra.com; dmarc=pass action=none
 header.from=enclustra.com; dkim=pass header.d=enclustra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enclustra.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iV+RGQxfleq+hgF3i2bkNXx8VVdX0N7iGnboepMOyMw=;
 b=WbLYlxKMiFI6Zhv7CvDdT8QoyXTwxrXUOdA3PlF5tsJ0yP3NhhRmuedblie8F8KPwuA44/9S8Scw6NzyyRAT1wb9f3FdmuBnUawukaXuQxUgZDjAOJpXlJweynQs5mWJ53eVdLf4Dn58EutQuUN7O2x3OD7k38iHhyMkKgn36yKqADn+Pf+AeAtD70EO8Tba1uPLPdgI9zmmYQ1nzENyqUmEiTW92/nuK7LhMHkoaSyK2baxCzmyYX9l/vV/BYjJBe3b1X82G4xSbOQZOI5W24w6GzElrdsbFEc9K1hzt1TrpaR6Z2D4Ha5SzkV6xSRXB/e7ZUSLpETBN0NPmd4FbQ==
Received: from GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::9) by
 ZR1P278MB1714.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.11; Fri, 26 Sep 2025 10:36:53 +0000
Received: from GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7eef:20a7:6291:fd06]) by GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7eef:20a7:6291:fd06%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 10:36:53 +0000
From: Tiago Gomes <tiago.gomes@enclustra.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [BUG] Git Bash no longer detaches GUI processes with & in version
 2.51.0
Thread-Topic: [BUG] Git Bash no longer detaches GUI processes with & in
 version 2.51.0
Thread-Index: AdwuwhQSMxRSk1AbRzmK/cj0GVZBKQACkb6AAADKL5A=
Date: Fri, 26 Sep 2025 10:36:53 +0000
Message-ID:
 <GVAP278MB0582E314F3EBB51FC2DAEAB2F91EA@GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM>
References:
 <GVAP278MB0582C91C40BC818FD57C59F6F91EA@GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM>
 <3dbf6ce2-6aed-8b47-3c8a-ab2844c1dd7f@gmx.de>
In-Reply-To: <3dbf6ce2-6aed-8b47-3c8a-ab2844c1dd7f@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=enclustra.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0582:EE_|ZR1P278MB1714:EE_
x-ms-office365-filtering-correlation-id: 4f543610-df6f-431b-b4ce-08ddfce89bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGtJV0VzbDlvekFPM1Q3MXkyczJ1TmxBMmpQdGpTTGNreDgycjVkcVhnZmE2?=
 =?utf-8?B?RGd5dXpSY0xMVnBWQnQxUG1PTmxpUUkvOUdYSVJHbFNqQXcvZ09JdVpmUHls?=
 =?utf-8?B?TjBzYXBOWjRtNVlWRnhnblF6Q2lvRDFEOXJONG9XREphM0VML1l2SHdEVXY0?=
 =?utf-8?B?ZmgwMUhKc2JnMVRWcXVYcnJwS2Nqc0FoeWpPOFdhNEZydGdCdXF1a2ttcjlK?=
 =?utf-8?B?OHVCS2FwQ1FvdSswditldkMwS3FDemMrRDRDeDFrRVZFRUtyTksyV1lVbkJL?=
 =?utf-8?B?WlpJWVlQRXVFQmpVZUVndElKYXJ0WFdUcVhFZEs5akNoSDBhUkcxRnVoV0xI?=
 =?utf-8?B?R0VvTjhJTDB5QTdLZ1NDUFhmeDQ2Q0ZWR3ZQemlwVmZLL0E0QmdyU1dTZFYv?=
 =?utf-8?B?NTVnR25FWDZXdzhGQ2ZPQW1lcmJLRCtGVXllUHhnMmd6WGVPNXlSanBLN05E?=
 =?utf-8?B?N2REakFaT0p5VHFwYVpuOW1heVFQOFJ5bUlFS1ZjWFpUNWNucUh3SWNDd0Vt?=
 =?utf-8?B?OGVhVUloYXZHcllQekMyM1ZmV1RPWVdPcHJVS0k5ZjhYQXYzMExpSGVEV1NZ?=
 =?utf-8?B?TGtDSUx5NDZFSGZvWW15UDdmL2pnUmg5RkttL3hwSFA4emJOdzlDTG1IWFVU?=
 =?utf-8?B?eTJqeGZwRWF2Z0JPZWE2ekhCUmdkTU9HdDUvWjVoNk50QUxIVWYxczgrbmkv?=
 =?utf-8?B?UzJ6VlhrTFFvaGc1L00xZ00ydXN6dElIKzRkYkFjbWNCK1A1NFpEYUJSUDVT?=
 =?utf-8?B?Z05kQm1tZklwVlFDYVNaWTRnZldPTkVwdldvbjVMU0oyWnVwTEN5UEoyaFFQ?=
 =?utf-8?B?ajRpN1U2K2dLU3QySUxPSzNUbE1KMm1uNktlL0Zvc09DSjM3T1RTZCtTS1VJ?=
 =?utf-8?B?NGNYd3FCcE9QbWhjWGFTRHpNL3E5Q3RYYjNRL014RDFFRm1yY3o0SkszYnJl?=
 =?utf-8?B?bDFMa3JYaW9qTVMvT2lzTEwxSFpHdXNoVWFCcVVSMzJodU5IUzA5aWFiZ01x?=
 =?utf-8?B?aElxcm5LaXBVZHl2Z0hnY3FzNXd0cmJ6bTY1T0FTY09UOVhLSWpKbDNJUTAy?=
 =?utf-8?B?QlRDUWh0VURvbm9SSmltSy8yVlJzYzRHN0w3R2VlejRINEJNZXllMlA4TkVj?=
 =?utf-8?B?bHBlMHphY3hYNlJwUmxQcjhra3pUd1ZBamNRdVREWDlDR203cjljUW9BRDZI?=
 =?utf-8?B?WVd6eW1MWDdZRVg2TXpyZW5HSlNDMnFDNlM2RG1vbDgrRnYwQWJ2bGxDMU5N?=
 =?utf-8?B?VWVRQ1VOMjA5cXRqc1g4eXVWUENQM3dsVytoK0Z5aUFJWVV6WnZTamVMMExW?=
 =?utf-8?B?UWM1aDBaWmZMM3l2clAxNlhiMGE2RFBnRnhrd3BYYWlNL3k1QUN5WHRUcWxM?=
 =?utf-8?B?TUxkampqbWVFTzBkcGdKMUNtUnJwVlowR1I1czMwT0M5bldmZExTbXFUTG9V?=
 =?utf-8?B?dnBuUHJIa2lTUU81cndiQkZudnlraFNrU2FyT2FYRUJ5R0I3anFSbU5ucDFS?=
 =?utf-8?B?K2F4TGhrZGdLYW45Y0d1dEhOYnpKV0czZU8waW5sajZzWHVoTkt0dlgxek1D?=
 =?utf-8?B?THk3d0Zha3B0WllkbFdpcWhML084bnBZVlhVV0hkOENXd2FhL3p6Y3FWL0J3?=
 =?utf-8?B?R0hLaHRuOE1WK2ZCU0hOK3ZQenllYVVyclhKMGNJUW02TER5WlFMaUhkQmQ1?=
 =?utf-8?B?TGlCVFAweE1uUXVHYUZEeWZzQzlWQ3dRdUFZUkdiV2l2OGE0a1lvRHBpUDNW?=
 =?utf-8?B?MnduWDBSMkVhTXhmcUhEN3pCRUxNZy9mUlM2a2VvNWJzSlN4Y2VieTlHczdu?=
 =?utf-8?B?YUJKaDluUFNSeXNwZ2NCVDlXR2UyRUhhTE9ZVlA1dWdGZnhtZXVUMWRuK21q?=
 =?utf-8?B?aThJTFZjRlVZMFZJemhzRlhBeklxWFRPbC9PS1Fxazdsb1Zzb0lTd3dua1ov?=
 =?utf-8?B?eE53YWlFRFp5czdkYTA4UjJ5YU42OFcyQldYME1xQnJhL0pUOUlkb055YzFB?=
 =?utf-8?B?S0Q4SGJYaUN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkF3T0x0aGxiTXpWdFdTQlR3Nm9pbzVDUitDVy94dTI5NDdnTkpzSkdhQ0Fy?=
 =?utf-8?B?eEs0TjZVSWU3THRhM25pMVdEaUlidjZPeTlDbXc2NkpwcFlVSjhrSkJ6MXdD?=
 =?utf-8?B?RVl4cGNtR21zT2JsOFhsa1dBeXpjOU5iZU56NmJjalczZ3ZjUmtxS2RiWUZE?=
 =?utf-8?B?Q3RPcHZlME5CVUxPNkpqVmtYbXpaWkFla0ZhRjZER2RidFJOWW84REk2Nm9x?=
 =?utf-8?B?NkFHTktZT0VGMTVDV3FILzBvR3Eya21CN0dUcCtBcE1EWnVmaVYrS1Via2Zm?=
 =?utf-8?B?QWxnN1ZHMU9kWkx6N2FNM1V1aUhITDlMSkRlL2xHcVFJZTZJS0h3ck9xZXZC?=
 =?utf-8?B?Vmx5VDN2VjZ2VVZEaWlKeFBaSDZrVXlWdzd2OFVScVRscDNwUWpOaExKRXp1?=
 =?utf-8?B?OUpBWThQWlFKWDVRaWFPTW41WmxzOUV1YzhERmRnUlNtNVBZd0c0dDFGM1Js?=
 =?utf-8?B?NVdqZnozSzlRaS9INUwwZWpmRnU4OXQvdjZwMXpHY3dzVXhVMGlKOFYzSXBK?=
 =?utf-8?B?TDAzZ0NUSGhmNVdhOEI1RDdKZVlvQjROaWo2blJFRUdIdmpwV1NUeEJpVEln?=
 =?utf-8?B?clgzMVJxSEpqQ0F4OW4xY2ZYajhRUlBtNjZvRUtvRFlDUmRsTzhIYzhXaWdu?=
 =?utf-8?B?c1dIUkZ4d0VKWlAxbklGUGFFRVZsNnQwN0lzbzNVUUkxZ04ybzBkTDRWM3pC?=
 =?utf-8?B?ZnlKRU9xK3JVamN0VnBEVUdvdFR5dVpCY3hDVDBIUnNRbE9nNGJVSURMNy8y?=
 =?utf-8?B?NW5ENmQycVJ4L2hrYTkzVS8xNWJXZFNuUnFhYUdsSmJ6L2RGZkZrRTBsRVdx?=
 =?utf-8?B?SHdFUi9sUXBZTzhiSHR1Q3Jpd2x6L2JWdmhReGdBS0FoUUlJQ3dJMi9qc2sx?=
 =?utf-8?B?SnFMclRzdmw1cVdlWDZ6ZFo1dDc5SHZWMDBDYVV0akhCZkQvNjRGeDM3b3Fo?=
 =?utf-8?B?VTRvbXpkTDFoTHdndHhGZ0orUG5XQ2RiSHFVUGZueHg4RW1lUWFrTTVKUGds?=
 =?utf-8?B?QnJOb2RuUG5YL2tTMnRNRkdhYnM4WDRMZ2xkSGROaDNmSUR0cVp1UXRZN2Vw?=
 =?utf-8?B?N0IvdVVnMU5MOXNOVzZ3aFk2eXlwZ0d5bHlrZ2lBNFNEYWhQcDBzd1gvUElD?=
 =?utf-8?B?Qy9qQTRSMUNnVlpvZSt3RXlNOEdOSGx3T2lNK0NrcEhXWjRLUWdMYnlJWENL?=
 =?utf-8?B?eGVwZ0lMSS8rVXNKdGF0bVQzL24vSXNsMGhucHdLQUFKaVZJeVpMaFdudGd2?=
 =?utf-8?B?TzNsRkx6OEhyd0xIN2F0UzJOZTVXRGN1RTh6ZjdoVmJRbi9rNnBON1ZoMjVY?=
 =?utf-8?B?M2owaitlZnIxUFdmVUc5VzZRRkVJa3ZNeG5GbC9jVjNrUVAyNzR1MW1LT01T?=
 =?utf-8?B?Uk9sWEpEdW0waml2UEs1QU8yMjhpWjJBS25SUEIwcmhzQUhyV2dQaG1tUkxV?=
 =?utf-8?B?NytkMjVwU1MyWkdRTWZ5VnBkWXB5RTZvWjdFV0lYWVNSNXk5ZjhLM055UytE?=
 =?utf-8?B?dWlGek5yOEJCUWVobjduREJHZDE3Z0FJOTZsUVdEV2ZEUkhmaFgzZXdlVUJI?=
 =?utf-8?B?RDY2UmxSaGdIN0V1UW9vTU1LRXk5NkV2Z29sMHR4UzFDblZKbmRqOVovYzVH?=
 =?utf-8?B?WnFIL0FuMXJYMVgzZ0k0S2syRG1KRzRpWVNYUjBiUnRjV3VtNnlmYW8rSmpv?=
 =?utf-8?B?amFRWmh1OXI1WlZPdHhFdXB4ejZaY3F0dzQxVWVlWldIc1lhRVA4ZWVhVTlB?=
 =?utf-8?B?VGJ0ZW9aeXgvMTk0QmREWTk2U3l3WHR3aGliVmtZUFoyUjlUQktTTFNGYWd5?=
 =?utf-8?B?YUtkNDNUcmNLM0I2NVVod0I4VnRpd3VHeGRnZjhuSi9IenhzTFBQdE1rUUZ6?=
 =?utf-8?B?enhIK05aVnBFVENuOUR1SU1mQzdyWjc1YUxGUFlnMWtJenNodkFyUlNBV25W?=
 =?utf-8?B?bmRiemdUZGdRM3lrRHludFljWUI3bGVWVml6WVJjNmtNWmdnTEE5WHBEU2lZ?=
 =?utf-8?B?TjVIdUt0ZmtOdFhhVW42eE9lQ1FGRXNmbDlQWFhuTkhzWEZYZ3Z6a1dTNFZB?=
 =?utf-8?B?RjBuamdkdTg0dGI5YzU2bkZYc3UrcGluKzNEcXZNMmFkWjRGaEVlRVZRTjJa?=
 =?utf-8?Q?UQ3LfnQlGt8Y1jf3i7BM4UbpH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: enclustra.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0582.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f543610-df6f-431b-b4ce-08ddfce89bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 10:36:53.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8316e432-9d32-499b-abdf-06a868d8a248
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYBOLimPbGoXPtCMU++ioipN44pIjFixd2xiv82arrElkRPk8iJDBfbRJcN9XVLCDygNacuNCeEXWGL+zFkuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1714

SGkgSm9oYW5uZXMsDQoNCkkgdHJpZWQgaXQgd2l0aCB0aGUgcG9ydGFibGUgdmVyc2lvbiBhbmQg
aXQgd29ya3MgZm9yIG1lIGFzIHdlbGwuDQpJIHdlbnQgYmFjayBhbmQgaW5zdGFsbGVkIHRoZSBy
ZWd1bGFyIHZlcnNpb24gMi41MS4wLndpbmRvd3MuMSBhbmQgImdpdCBndWkgJiIgYWxzbyB3b3Jr
cyBhcyBleHBlY3RlZC4NCg0KSG93ZXZlciwgd2hlbiBjYWxsaW5nIG15IE1ha2VmaWxlLCB0aGUg
dmVyc2lvbiAyLjUxLjAgZG9lcyBiZWhhdmUgZGlmZmVyZW50bHkgdGhhbiAyLjQ1LjIgZm9yIHNv
bWUgcmVhc29uLiBJIGNyZWF0ZWQgYSBtaW5pbWFsIE1ha2VmaWxlIGZvciB5b3UgdG8gdHJ5IHRv
IHJlcHJvZHVjZSBpdC4NCg0KQ3JlYXRlIGEgTWFrZWZpbGUgZmlsZSB3aXRoIHRoaXMgY29udGVu
dCAocGxlYXNlIG1ha2Ugc3VyZSB0aGUgbGFzdCBsaW5lIHN0YXJ0cyB3aXRoIGEgVEFCIGFuZCBu
b3QgNCBzcGFjZXMpOg0KDQpDTUQ9Y21kIC8vYw0KZ2l0X2d1aT0ke0NNRH0gImdpdCAtLXZlcnNp
b24gJiYgZ2l0IGd1aSINCg0Kb3Blbl9naXRfZ3VpOg0KICAgICAgICAkKGdpdF9ndWkpID4vZGV2
L251bGwgMj4mMSAmDQoNCkkgYW0gdXNpbmcgdGhpcyBNYWtlIHZlcnNpb246DQokIG1ha2UgLS12
ZXJzaW9uDQpHTlUgTWFrZSAzLjgxDQoNCldoZW4geW91IGNhbGwgIm1ha2Ugb3Blbl9naXRfZ3Vp
IiB5b3Ugd2lsbCBob3BlZnVsbHkgcmVwcm9kdWNlIG15IGlzc3VlIHdoZXJlIHRoZSBjb25zb2xl
IGlzIG5vdCBhdmFpbGFibGUgdW50aWwgeW91IGNsb3NlIHRoZSBHSVQgR1VJLg0KSWYgeW91IHJ1
biBpdCB3aXRoIGdpdCB2ZXJzaW9uIDIuNDUuMiB0aGUgYmFzaCBiZWNvbWVzIGF2YWlsYWJsZSBp
bW1lZGlhdGVseS4NCg0KUFMuIE15IE1ha2VmaWxlIGhhbmRsZXMgdGhpbmdzIGEgYml0IGRpZmZl
cmVudGx5IGRlcGVuZGluZyBpZiB0aGUgdXNlciBpcyBvbiBXaW5kb3dzIG9yIExpbnV4LCBzbyBv
biBXaW5kb3dzIGl0IGFjdHVhbGx5IGNhbGxzIHRoZSBDb21tYW5kIExpbmUgdG8gZXhlY3V0ZSB0
aGUgY29tbWFuZHMuIE5ldmVydGhlbGVzcywgSSB3b3VsZCBleHBlY3QgdGhpbmdzIHRvIGJlaGF2
ZSB0aGUgc2FtZSBvbiBnaXQtYmFzaCBubyBtYXR0ZXIgdGhlIGdpdCB2ZXJzaW9uLg0KDQpUaGFu
ayB5b3UuDQpDaGVlcnMsDQpUaWFnbw0KDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+
DQpTZW50OiBGcmlkYXksIDI2IFNlcHRlbWJlciAyMDI1IDEyOjAwDQpUbzogVGlhZ28gR29tZXMg
PHRpYWdvLmdvbWVzQGVuY2x1c3RyYS5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3Vi
amVjdDogUmU6IFtCVUddIEdpdCBCYXNoIG5vIGxvbmdlciBkZXRhY2hlcyBHVUkgcHJvY2Vzc2Vz
IHdpdGggJiBpbiB2ZXJzaW9uIDIuNTEuMA0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBm
cm9tIGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRlLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCg0K
SGkgVGlhZ28sDQoNCk9uIEZyaSwgMjYgU2VwIDIwMjUsIFRpYWdvIEdvbWVzIHdyb3RlOg0KDQo+
IFdoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJv
ZHVjZSB5b3VyDQo+IGlzc3VlKSBJIGluc3RhbGxlZCB0aGUgdmVyc2lvbiBHaXQtMi41MS4wLTY0
LWJpdC5leGUuDQo+DQo+IFdoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQg
YmVoYXZpb3IpIEkgZXhwZWN0ZWQgdGhlIHNhbWUNCj4gYmVoYXZpb3IgYXMgd2l0aCBHaXQtMi40
NS4yLTY0LWJpdC5leGUuIEluIHRoYXQgdmVyc2lvbiwgSSBjb3VsZCB1c2UgR2l0IEJhc2ggdG8g
cnVuIE1ha2VmaWxlIHRhcmdldHMgdGhhdCBsYXVuY2ggR1VJIGFwcGxpY2F0aW9ucyAobGlrZSBW
aXZhZG8pIHVzaW5nIHRoZSBjb21tYW5kIGNoYWluaW5nIG9yIGJhY2tncm91bmRpbmcgb3BlcmF0
b3IgKCYpLiBUaGlzIGFsbG93ZWQgdGhlIEdVSSB0b29sIHRvIG9wZW4gd2hpbGUgdGhlIEdpdCBC
YXNoIGNvbnNvbGUgcmVtYWluZWQgcmVzcG9uc2l2ZS4gSSBjb3VsZCBjb250aW51ZSB0eXBpbmcg
Y29tbWFuZHMgZXZlbiB3aXRoIHRoZSBHVUkgc3RpbGwgcnVubmluZy4NCj4NCj4gV2hhdCBoYXBw
ZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKSBXaXRoIHZlcnNpb24gMi41MS4wLCB0aGlz
DQo+IGJlaGF2aW9yIG5vIGxvbmdlciB3b3Jrcy4gV2hlbiBhIEdVSSB0b29sIGlzIGxhdW5jaGVk
IHVzaW5nICYsIHRoZSBHaXQgQmFzaCBjb25zb2xlIGJlY29tZXMgYmxvY2tlZCBhbmQgZG9lcyBu
b3QgYWNjZXB0IGZ1cnRoZXIgaW5wdXQgdW50aWwgdGhlIEdVSSBhcHBsaWNhdGlvbiBpcyBjbG9z
ZWQuDQoNCkkganVzdCB0cmllZCB0aGlzOg0KDQogIG1lQHdvcmsgTUlOR1c2NCB+DQogICQgZ2l0
IHZlcnNpb24NCiAgZ2l0IHZlcnNpb24gMi41MS4wLndpbmRvd3MuMS43Ny5nYWRlMWYxYzEzNi4y
MDI1MDkyNjA2MzkzMw0KDQogIG1lQHdvcmsgTUlOR1c2NCB+DQogICQgZ2l0IGd1aSAmDQogIFsx
XSAyODANCg0KICBtZUB3b3JrIE1JTkdXNjQgfg0KICAkIHB3ZA0KICAvYy9Vc2Vycy9tZQ0KDQpJ
IGRvdWJ0IHRoYXQgdGhlIGJlaGF2aW9yIGRpZmZlcmVuY2UgaXMgZHVlIHRvIHRoZSBkaWZmZXJl
bnQgdmVyc2lvbiAoSSBhbSB1c2luZyB0aGUgdjIuNTEuMCgyKSBwcmV2aWV3IGZyb20gaHR0cHM6
Ly9naXRodWIuY29tL2dpdC1mb3Itd2luZG93cy9naXQtZm9yLXdpbmRvd3MtYXV0b21hdGlvbi9h
Y3Rpb25zL3J1bnMvMTgwMzAwNjIyNDIpLg0KDQpDb3VsZCB5b3UgdHJ5IHRoYXQgcHJldmlldz8g
WW91IGNhbiB1c2UgdGhlIFBvcnRhYmxlIHZlcnNpb24gc28gdGhhdCB5b3UgZG8gbm90IGhhdmUg
dG8gImNsb2JiZXIiIHlvdXIgZXhpc3RpbmcgaW5zdGFsbGF0aW9uLg0KDQpDaWFvLA0KSm9oYW5u
ZXMNClRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgaW50ZW5kZWQgZm9yIHRoZSBz
b2xlIHVzZSBvZiB0aGUgbmFtZWQgcmVjaXBpZW50KHMpDQphbmQgY29udGFpbiBjb25maWRlbnRp
YWwgaW5mb3JtYXRpb24gdGhhdCBtYXkgYmUgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQgb3IgY29w
eXJpZ2h0ZWQgdW5kZXIgYXBwbGljYWJsZSBsYXcuDQpJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRl
c3Ryb3kgYWxsIGNvcGllcy4NClRoaXMgZW1haWwgaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50cyBk
b2VzIG5vdCBjb25zdGl0dXRlIGEgYmluZGluZyBvZmZlciBhbmQgYW55IHByaWNlcyBhbmQgZGF0
ZXMgc3RhdGVkIGluIHRoaXMgZW1haWwgYXJlIG5vbi1iaW5kaW5nIGluZGljYXRpb25zLg0K
