Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4E21D5B4
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494649; cv=fail; b=OsZeysYMgGr9AOqeq7Y2UmzJwvPrXJG35AMjCtWmSzp+i9HOOWC3D0GBr8Xx7nt2AiBlImK62Gj3a5eiY+i0amPfElNOmA57hLDOCbN0OiLL4yFXhczHl/mpre+McT9CV3uciaRF3cHEfl+98y6/bBM8vuhogJNVnsMdruOcUK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494649; c=relaxed/simple;
	bh=Nw3PRNiVykCCh4n94Ycb5qFbx9I/R15FFeBbQVSq8VY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOK68mFKDLSepxlGM6yvWeqmkKjrW42/uHGL8reKXKLEz7OyijN5NTdt34UYdVkXEiOp6eOFFTFTm7jYkttOkO/ot3ocDmx7TSgyJb2UDBaYiTP7QJ+Ke7hA479l+4YyJNPUynRfJgYxCwkHXDVh2KWiB+AmSWcDKyQJW8rLvQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=J3HNeFtm; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="J3HNeFtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNHLDa45XwlcL0spAwRWs3O74zIWpKwjxZQHQpW/yerthRn9vDM0cfdOknE0bwZ4s0/vC0xmuKdV6kpDiDSpCg/fiu9kmySOMta7n0wKyJvQwZ6bpQeKipPqp0lmgWoxzlQVYtpvPkuSNJ2bScpK7HLFP9esgVY3Oa90fcWsH+N/wWZ2534AmR6VQKpXblcIvR9TG89kZe5kBeNvFexFNshrgGYkSnaRYx6E4jCSUDkBP9YiiP5l8LmbLOi/qQUUfK0HqBa4j+v+IncV+U5xbzy/uKBy4cpF+GQCvVIvKd3nSHvpyV79ypVxDMa41IRayYyfBHN5iBaIK9+VMlaYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw3PRNiVykCCh4n94Ycb5qFbx9I/R15FFeBbQVSq8VY=;
 b=q5w1DVGHeFcYjOdZBY0nICsn9CjUM3dH+Ku6Nu1WAwr36+SRB8dyLJxz+d33UKEADKQvAcXW5egXgIjsv4atkHo0lfo0h+1RwyZzxOmAGv1+jDLrMAK36vdGPV44pL7jeZU6/yfuBSMElMgZ7ekJu+ab5gfgoRQZPuEXmnoFWAhpVpfDFGKyjFbsxvJBFnFk6NXGUhx82EJ30wy2Yi/HTEl2qswOsAlzQngUPFSNVBLhS6blygTns+2e8VW7Jb3d9/WhUJVjVrSr82HlHQFWc6JyaO6yQlgHSxuumJgUFmNiUkucG2trahHWrS7/WJA1l2dwXqUzm8bO8Gd4RxiHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw3PRNiVykCCh4n94Ycb5qFbx9I/R15FFeBbQVSq8VY=;
 b=J3HNeFtmywJgwQJBoqUYgXqiYPkDXI2OEJ2Y3erQXuUOy/0tKygT8TFoXHJO+6OWEMITrMZq19sWjeMFbDGE2pvcIjiLaMlR02JaZOoK7BfN8cM7+am7QJgLpFt37TVnhWe1BEaNFRkDF2dfVA3IDuPM3dwUxIkUiUGG5sptF99WJaGItC6w6daLCmUP9pVRS3hlfkkka3h6RIvYVxowk06KfKggTPWYnr+8lJteCo4WN/TWAkCFnkUnMVM3ICHR4lmRhBSrpfKYOPrAYDAUDn6CxjKb0EP1c1mPO/qSVgHHamfOGNepuv3oTtsA84A0zR3ZQPqdlrQH18wy453l7Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7465.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Mon, 9 Jun
 2025 18:44:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 18:44:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: is there a possibility of getting a warning before a
 git push -f
Thread-Topic: Question: is there a possibility of getting a warning before a
 git push -f
Thread-Index: AQHb2V4cp+tCTaIiSEa0qhfCASgoarP7KcRjgAAAbMA=
Date: Mon, 9 Jun 2025 18:44:04 +0000
Message-ID:
 <PN3PR01MB9597D5059F9C9E0FCF442CB0B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN0PR01MB95880EAA98466C9AB049BA44B86BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqldq0rc3b.fsf@gitster.g>
In-Reply-To: <xmqqldq0rc3b.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB7465:EE_
x-ms-office365-filtering-correlation-id: d741b4fe-e7a4-471b-9bc3-08dda7859bb0
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8022599003|7092599006|8060799009|8062599006|6072599003|19110799006|461199028|15080799009|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3hpODRqdFBQRzlFZzJvdHRJKy9xNlZMTm9Za2tRWk51ZmZxMkFDVGZsSWxi?=
 =?utf-8?B?VEdpUmdNRUQyMkVUbzdrSUFpTXFNUllTd1R1M2luZmpvc0pqRW9jYVNLdFpn?=
 =?utf-8?B?YnRUS09maVNiZk5pSEtpK2xLZHZodnNoNjh0Q2xyUHQwUG9qVFpKR3dvakc5?=
 =?utf-8?B?WHBSSE9JV1V4RmV1T0VrY1FmMjlBZGVBVExzMUFzeGhNR1RXZy80NjZtc1B4?=
 =?utf-8?B?S1dSOTJHY3J1VTgyOUxxYm9YaVVHK0hQdE1ISUdIOGU0ZHIxZ3l0bldmQXU1?=
 =?utf-8?B?VUVpYXJnbHJvdUc3Q3FLWDk1cUcwUU5qSTlmMHQ0N0ZVZ29KMXhIRnFxd3ht?=
 =?utf-8?B?M1hDSXlWa2xnZHRnRE9BN3ZxUGw0WVd1ZitObWRneE9lam9MV2YrTEJTRzFh?=
 =?utf-8?B?enVEam44MFpjL2Y3Y1N6T2MrU3AvRmR4ZjBhcHVnTVI3TzYzZFZSWlZ0TTdS?=
 =?utf-8?B?OEs5dGRBckNUTUd6OThqU3F4U1NDMnRIbVJYUW1QZjFzY3dWNWtYTGNodlQx?=
 =?utf-8?B?QmphRVhCY3dpUHBQMDlVYWgvdGdVV25DZnBGRkhIVlRxb3hrRDJoOXViT3JC?=
 =?utf-8?B?Mk9SOWxQTUE5dFBLMmtrelVjdXh0c01xb0FCTkRvTjJ5WXRtUzd3Nm5GNEtR?=
 =?utf-8?B?ZUMvZERvTnlMa0lzK3N2b0cwWmY3OXoyVGlLdFYyRGl6NzVBMEdrTnk3RVBJ?=
 =?utf-8?B?OFhzcVhsWm02WDVMSlU1VjJYUStqOHVId3VCV2RIWDRKU0ZBVVQ1VVlVVTRV?=
 =?utf-8?B?TWY3U0NXY0xiNURJMFNqTzJVdFM4Q3doNFJONGJDZ0NtZEFxczRNbysxa0Jt?=
 =?utf-8?B?dkJmajRyTkxMMFBLc1F0YldnSXBZY2hNbDAvejBhZy95YWozVFBTVjdBNHMx?=
 =?utf-8?B?M24vRnFNZElkLys0M1JibWhKWnI5T1pYdWJRM2kzTUhPVCsxclRWRUhFbkd3?=
 =?utf-8?B?TFFaZTY2MFlwUGFsMjlWL1VDRjN1UGlXeFVWZmFsR043MGNuaGordGlqMm5T?=
 =?utf-8?B?V1F0cGIvZWM2dmJ2VjVjaDJWT245YWZWUFpPSkFib2NPTEx1eHIyZ1NLSklC?=
 =?utf-8?B?RVV4SEcwa1BDRWhCbXJob3BMNDZvUW05T2J4NFNldng5aUxIVkRwN01yM0tC?=
 =?utf-8?B?RU1HTGRRT3ZWUWlHOVNDQnM2c0RHMXRmTGZQWnZ2T0JCNkw1U3p1YUpUckc3?=
 =?utf-8?B?dTJaRXNkS1lNbndid0FyeTRRaDJJejJTQ0dmUUdqUmh1bzB1Z04vRjVuMlI3?=
 =?utf-8?B?RVJwNTgrbUFCYi9GQ2FRWU1DKzBFb2t1UDFmYlQwVEw2YzgxSklPSUtMTG10?=
 =?utf-8?B?N29ocXVad0l4SUV0Ylh1Q0x5azc0YVd2V2NVNzM4YmpPQ2FYQ1gvTENrSnU4?=
 =?utf-8?B?SmhnajNtMVlGNHRzM21KZVUyTTc0SGcvdnhBTkFHMzFDWGM1dzJGQkM0ZTlu?=
 =?utf-8?B?RFVweTQyS2UxYlRVZzBLUXYya1lZSE1teUVOVTd0blVucStWdGM3T04rNzlX?=
 =?utf-8?B?T2pJakZHbmVWdk9EVGhwaThpY1Z1OWtMa2hjMHVocU1MeG5nU1pTdEpJeTM3?=
 =?utf-8?B?TFZMUWlDOC94VThjWFhMbWFVdzlxb2ZSeXV3RjBjYTk3MXJMSUluL0Z3V2p1?=
 =?utf-8?B?ekREaEFSK1FMdHN2d3RMTWhlOEIzUkE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFlhdnFOSjZYOUgwVWMybEFBbWI0NVFXVlpoR0o1SFQxMUF0T1V0SDl6Mi9R?=
 =?utf-8?B?OWl1b3FUK3NwdStBRldXUnh6cDhMQ0RZQzErUCtXRlFrWWlUdVNCL1JlVmJV?=
 =?utf-8?B?dmZNWUlnSmFsK3VTWGc2V0tnMS9SeUMyUThBbElTKzJyYnBldXpDRDluWEhN?=
 =?utf-8?B?ZjM0TVJ4U2dLU1MwaGNFOE1EbnpaQ1NQa3BxVWVWa2ZoZUFDVGM3SkFyVkdm?=
 =?utf-8?B?S2djSjRqSUt2YjhjdG11c2Znajdqb1hPKzkxQVJFOXVWVnpvdG1kMkRUdTQw?=
 =?utf-8?B?VzY4dUoybnU5Vmw2dzIxc1dlRlNYR3NuR1g2a0RDVlQ5VVlaRER4SUFnbmxu?=
 =?utf-8?B?bWM1c1VvK0dPeEVkVVpZcVBkbGVsRkgzK00waUNZTnhXK3RPOEI1OXdFRWdm?=
 =?utf-8?B?dU95SkpMeEJwdjRaSlRUb2NDak84OXU2M28rT2NnSDM3czRGMlhyRWZMNldl?=
 =?utf-8?B?VmE0Sk9sOGtvS2dvK21JVlFzZkJsTU9QQlB2dFd4NkxuMUk0TlA3czNsaks2?=
 =?utf-8?B?SDFNUGlNSjFDZmttcnhKNXlCdDZSdWovbmhGdXlZL3BJaUpKNVRSK3UwbHRs?=
 =?utf-8?B?NU52RmxiWnJJMHVLOUFXZ3QzRzBFbmVsOFh5R05MWWQ1YzVmMFprYmhUOWZ4?=
 =?utf-8?B?WjZ2S3UvOWRLOEZSOE00Vks0RU9CWW5kOWM1UjBDTldva09xcGZReU8yNWxQ?=
 =?utf-8?B?T0dOcm0xNnJqTC82NmRuN0dGaS9TN2JWQnMxMlVIT2p0NlJERXFCSDIzTGd0?=
 =?utf-8?B?NFkzZUIrYTA0aGkxWXZyK1Q4WGhwLzFVYnFEaGIrSWQzUExwQU5kOU55d3Uy?=
 =?utf-8?B?b0VNdldESlF6R1NzaG5LMHRqUzB0aEhGaGZGYzlPTGhZRTNhWlJzOHE1ZkRM?=
 =?utf-8?B?b3BWckRWaUwrZnVWSG9jMkZYY1VUT1hVUmJ6YzI4czhHcGIwN3UrNXM0R1pm?=
 =?utf-8?B?cmhNWTZjUnY3NGJYb1hlQndWL3VMV3VSSTRQR0VYU0NUbjNYQ2lXU1p3c052?=
 =?utf-8?B?eGtvWlM1ckZYbWJhVkVRYVFhbDZHRmRoZTZTSUszeFZKYnRLU3h6NDRsZi9S?=
 =?utf-8?B?cDRWdXF1WW5CWTZFbTBWUmZmRHR3MUVtZUhsWlI3TTFjejAvNnphRXdOK091?=
 =?utf-8?B?cjBXSVQwTXBUZDE2eWUwaEVWWnVjaWNQN0NZdHJ5d2Z0ODlNeGhpdjVveTc2?=
 =?utf-8?B?Rm5wNlh5NlhmQWppdHdNODJEQzFXSWQxK2hJYW02VGZldzdzUEN4S20wZERN?=
 =?utf-8?B?YlNPYWRlQnNIY3BkNFV0VmNwSzZ4cGRRYTZEb1VKNzBDdEFwMHFIdjdqN1Bh?=
 =?utf-8?B?NHdXTjdsUU80dkJvb2dvTlF4YUU1NWRLNng4Nk1HeGFlbUNoU1o5ZU1Ldncw?=
 =?utf-8?B?YVplNm1kdlhyMUtYV0x1VXFYeGt6Smp0WWMxVFRBNlQ5ZHpUZDlwZHlrbUtl?=
 =?utf-8?B?TnJrd1REazMweWc1UmtGMUJHeStqcE9kOUkxTDVzSVhpcmVSNGhhZ3EycEl1?=
 =?utf-8?B?SGhOU1J0UHlHUklxWUVoallyNzcxSE5OWnNkcVRWSXBid2xxclQyaWhnK3BN?=
 =?utf-8?B?SmFtR0hqcW1lOHFWNnUrUE8xdEdGLzhWZmltcnVFSk1aRDlBdHF2aWtPRmJa?=
 =?utf-8?Q?SCLZa+77y3HQiSvsYZreB4wSsTgfYSA0DLA3Qo+4g2e0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d741b4fe-e7a4-471b-9bc3-08dda7859bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 18:44:04.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7465

DQoNCj4gT24gMTAgSnVuIDIwMjUsIGF0IDEyOjEy4oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gT25lIHRoaW5nIEkgc29tZXRpbWVzIGVuY291bnRl
ciBpcyB0aGF0IEkgc29tZXRpbWVzIGdpdCBwdXNoIC1mIGFuZA0KPj4gbW9tZW50cyBsYXRlciBJ
IHJlYWxpc2UgSSBkaWQgaXQgYXQgdGhlIHdyb25nIHRpbWUsIHJlc3VsdCBiZWluZyBhDQo+PiBk
aXNhc3Rlci4gSSB3YXMgd29uZGVyaW5nIGlmIGEgbGl0dGxlIFt5L05dIHdhcm5pbmcgY291bGQg
YmUgcG9zc2libGUNCj4+IGJlZm9yZSB0aGUgcmlza3kgY29tbWFuZCBnZXRzIGV4ZWN1dGVkLiBJ
IHNhdyB0aGUgY29kZSBmb3IgcHVzaA0KPj4gc3VwZXJmaWNpYWxseSBhbmQgSSBkb24ndCB0aGlu
ayBpdCdzIGltcGxlbWVudGVkLiBJIHRoaW5rIGl0IHdvdWxkIGJlDQo+PiBhIG5pY2UgZmVhdHVy
ZSB0aG91Z2guDQo+IA0KPiBJIHN1c3BlY3QgdGhhdCBhbiBldmVuIG5pY2VyIGZlYXR1cmUgdGhh
dCBpcyBtb3JlIGdlbmVyYWxseQ0KPiBhcHBsaWNhYmxlIGlzIGEgcGF0Y2ggdG8geW91ciBzaGVs
bCB0byBtYWtlIGFueSBjb21tYW5kIHlvdSBnaXZlIGl0DQo+IGlzIG5vdCBydW4gZm9yIGEgZmV3
IHNlY29uZHMgdG8gZ2l2ZSB5b3UgYSBjaGFuY2UgdG8ga2lsbCBpdCB3aXRoDQo+IF5DLiAgWW91
IGRvIG5vdCB3YW50IHRvIHJ1biBhcm91bmQgY2FzdHJhdGluZyBhIGJ1bmNoIG9mIGNvbW1hbmRz
DQo+IGFuZCBmZWF0dXJlcyBsaWtlICJnaXQgcHVzaCIsICJybSIsICI+b3ZlcndyaXRlLXdpdGgt
cmVkaXJlY3QiLCBhbmQNCj4gYWxsIHRoZSBvdGhlciAiZGVzdHJ1Y3RpdmUiIHRoaW5ncyB5b3Ug
bWF5IHJlZ3JldCBkb2luZy4gIFRoZXJlIGFyZQ0KPiBsaXRlcmFsbHkgdG9vIG1hbnkuDQo+IA0K
PiBRdWl0ZSBob25lc3RseSwgIi1mIiBvciAiLS1mb3JjZSIgc2hvdWxkIGJlIGEgaGludCBlbm91
Z2ggdGhhdCB0aGUNCj4gdXNlciB3YW50cyB0aGUgY29tbWFuZCB0byBkbyB3aGF0IHRoZSBjb21t
YW5kIHVzdWFsbHkgZG9lcyBub3QgYWxsb3cNCj4gdGhlbSB0byBkbyB0byBhdm9pZCBwb3RlbnRp
YWxseSBkYW5nZXJvdXMgb3BlcmF0aW9ucy4NCj4gDQo+IEkgd291bGQgZXhwZWN0IHRoYXQgbWFu
eSBwZW9wbGUgd2lsbCB0cnVseSBnZXQgYW5ub3llZCB3aGVuICJnaXQNCj4gYW55Y29tbWFuZCAt
LWZvcmNlIiBzdGFydHMgYXNraW5nICJUaGF0J3MgdmVyeSBkYW5nZXJvdXMtLS1hcmUgeW91DQo+
IHN1cmU/IiBmb3IgY29uZmlybWF0aW9ucywgYW5kIHdvdWxkIGNvbXBsYWluICJZZXMsIG90aGVy
d2lzZSBJDQo+IHdvdWxkbid0IGJlIGdpdmluZyB5b3UgJy0tZm9yY2UnLS0tanVzdCBkbyBpdCBh
cyBJIHRvbGQgeW91Ii4NCg0KRmFpcg==
