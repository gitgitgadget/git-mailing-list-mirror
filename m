Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EE17BB3D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235812; cv=fail; b=Rh/cpnoRKDyMvkepevF+VDKYjLOnTeG1bnisZyppReSMRtXLq6vEdm7pfUDixYQbLgQrFaNTR/I1DhPFrgf8Wwd0IVqhIvkg81s6+os4+2PKtOoPoZol7WlgFhGS4GmSJimN44Kw9Dp9vSu0wP5yZBl0UsthAVydWh8iEVj/D7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235812; c=relaxed/simple;
	bh=sjMgAveG0MB8qA93qaojZp65b2HcqHlkgbWCKqtmjYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJqcGSTNdzhguuDI7haJ55uj7SYqgZYivy5XS6pBMrBCSreQL75guZ02lxh9iwkOCnXWtEyFfJeDi16y+V6xfYR7Dz+xP5Br9hL1yUlyEGOXV5xRnKCbyxgbcFOPuAgUJyyHfCEtJyAF7hnu8ivJmA8PR4QM8L0WXu6dMuk9UHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=electrolux.com; spf=pass smtp.mailfrom=electrolux.com; dkim=pass (1024-bit key) header.d=electrolux.com header.i=@electrolux.com header.b=ViaslLGH; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=electrolux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrolux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=electrolux.com header.i=@electrolux.com header.b="ViaslLGH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceKw6VmJEm7IzKF6ADyXI3t7eoJd+8XMcvq6CGe0PKeyyC/YQXbWYG5ZvPCYboGWCr9+wYDJU4+7LJ5iD7G8M5mkaP5qPRQx9ImsVdyUggu94/ChAVnpZri2YllfS9QlqUdlzvMTl31qbDGbHtfVUhQaqvskkdN9a2Vcd7Y/p6u09m4M904GAntD747QlBn+xwBkzeWjypgR22QODw8iAMYh1hfGsmNXzZc8S+TyvHzHE1tb/+oYxntgbkhp1DB4kYG4vJcwuuCg4ntZONo44tUstDPJphkWYu1IeLNAnjVrHcHf49Gcxwo7TkR/73XVWSCjr8YvCHh/Sldo+0F/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjMgAveG0MB8qA93qaojZp65b2HcqHlkgbWCKqtmjYU=;
 b=UemgpEvkNLdHO59MhTdwfsJfTdl3rCTUn9rgBHGGnKFgyEhHjIC/qeHS1p6y9Kynh41EvrLwSoTNJMXdH7QTfH2RGAHMtYdj5Juk8BFnzFTd+9id1EIiFbla7VWwXxLZjwJtmn/7l1y4SIA6gRMLRB5LV+zqwo1ZE05C2FOC6EUP0McAe51l1wbVxEwl33qNJ5CMp4PmYyL52ADlhfh7wOmAOTvYECs8CWNlYUdjvPf1BC8xtQZoHGeBisMB11L80XkThWcEXtmhVBqWmagAtFZrCkNe4rB3djmuq/1X0hdG7K9d+EYKVCnNJ8/0q+NgXlRqPoESKAGaKPNgBEeVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrolux.com; dmarc=pass action=none
 header.from=electrolux.com; dkim=pass header.d=electrolux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=electrolux.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjMgAveG0MB8qA93qaojZp65b2HcqHlkgbWCKqtmjYU=;
 b=ViaslLGHs3vSqikO7PUdvDwQeCbAUHl8Gw1n+K8A8PAHXtOcvlB41DGcBJRUlKomIzO9hdXV8WPhRQjNllMpmtrdbfDdsSJ4Wv0W9y4fl3jGa12/AiPMuiLV6hCJi1R6Oc8iWYp/OXdpjjSMKsvgCyLeLSLQ2qZbKl6l9+kH2GM=
Received: from VE1PR06MB7070.eurprd06.prod.outlook.com (2603:10a6:800:1a1::7)
 by PAXPR06MB7904.eurprd06.prod.outlook.com (2603:10a6:102:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 07:16:47 +0000
Received: from VE1PR06MB7070.eurprd06.prod.outlook.com
 ([fe80::e921:fd86:a964:53a]) by VE1PR06MB7070.eurprd06.prod.outlook.com
 ([fe80::e921:fd86:a964:53a%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 07:16:47 +0000
From: Dario Esposito <dario.esposito@electrolux.com>
To: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: fetch and pull commands not working with latest git version +
 BitBucket
Thread-Topic: fetch and pull commands not working with latest git version +
 BitBucket
Thread-Index: AdsgkuIRs8FkeoySTxWzjkKEb8zsvAAMBBQAAABNyQAAGlQMMA==
Date: Fri, 18 Oct 2024 07:16:47 +0000
Message-ID:
 <VE1PR06MB7070A5259636FF4F37E890EAE5402@VE1PR06MB7070.eurprd06.prod.outlook.com>
References:
 <VE1PR06MB707063B6C98798EF8AD9EF00E5472@VE1PR06MB7070.eurprd06.prod.outlook.com>
 <CAPig+cSzkWfC7WSrT-1Kdm78PU3EPNj25+FV4gZfERQLOc6U8w@mail.gmail.com>
 <ZxFaUnQvVwaoc+pw@nand.local>
In-Reply-To: <ZxFaUnQvVwaoc+pw@nand.local>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_ActionId=eacc287d-fe91-4e75-9ebe-eced951c0e81;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_ContentBits=0;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Enabled=true;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Method=Standard;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_Name=477eab6e-04c6-4822-9252-98ab9f25736b;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_SetDate=2024-10-18T07:15:13Z;MSIP_Label_477eab6e-04c6-4822-9252-98ab9f25736b_SiteId=d2007bef-127d-4591-97ac-10d72fe28031;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrolux.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB7070:EE_|PAXPR06MB7904:EE_
x-ms-office365-filtering-correlation-id: f9fd0761-170c-4491-c9fd-08dcef44d43d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?YS9Qa1VlVE82YWdjTXdQQk5XUjZycE1WTmZadUpScjNoVjA5T2FtT2pob1dW?=
 =?utf-7?B?OWlrN1h4V2dyUFdWenN6d0VPYXVsTFZRODFwc1YzVUczOUkybE9saDNVRFRC?=
 =?utf-7?B?T3A4cExlanhsOW9UbTJvS2N2a2lySy8xSVd5MHdzTE9MTUdtWjQ1RGw0L1hM?=
 =?utf-7?B?TFhwVE1iZlA4Y01nOFBzOWFENE9KYjJFVXVxNTVkQlpROVFSakNoRTIyVU9G?=
 =?utf-7?B?VG83ZCstNXpjcGloQ2xFdk5iSzM5dlIyZExXNEwyTlpIQ2NRNWI5bFBnUjMz?=
 =?utf-7?B?b2k4MWZpQ1F4UWVXVystZ1c0VGd1dUtmelZjc0xrNVBiVDZXMjI0QmM0Q0tE?=
 =?utf-7?B?cSstVFp6RWcvM0ZaNW5ZSFpGYUY0WGlxUlRvR1JVMlNuTHFZWWx6SzZGM0sy?=
 =?utf-7?B?MklpNGpabG5ZL2szWklTZlkxMG40L09vaXZMNVl5UVZVVGtYUGl0WmxPVG5o?=
 =?utf-7?B?SkVIZU9icW0xM2lYanJnTCstYmN4OGxzb252cDVuSzBPZldCY00zejdXRkRR?=
 =?utf-7?B?T0tmMGZKKy1uQTRqcFR0ak5Tb3FIcFR0RTFueXpESW5sSjIvUmk5c2t1Qnk0?=
 =?utf-7?B?NUNQOWtDOVR2aVhlbTlqVy9pblFPeHFLSFpWbGphTVAzNTlpRER6N1c3SWdM?=
 =?utf-7?B?WjRUNFNWN2tEaCstS0xNN0FsZUpJd2d2eVdtRkpkbWFPeUdpSmhPeW5iUDA=?=
 =?utf-7?B?distVmxiZDVWY21kd1Iya1Z1QystKy15RCstaW8wQ0dncmZIMXlidVFad2xn?=
 =?utf-7?B?Q01EeVVKYVFXY3I1OUhMUTJQdWJkalo3bHpFZzRXZGhDTEFGdkJoeXRYT3VN?=
 =?utf-7?B?WjIxYWJJRlFocHQ4N3ltaGFoN3VPRzdhanJoKy1Ka3dnVXNVcW1OSWVkY0hC?=
 =?utf-7?B?VGI2NE81QWlXdlczY21lcGkzS2ltVXFvcmFrbzNXd2VrWDNkN0xzSGJmbzhv?=
 =?utf-7?B?ZjhhMWs3MDl5ZFIwT0M4aGNyQlo0M0RiWGRCdEwxU1dVOTVPUTBpeGZCNVhr?=
 =?utf-7?B?NG50UWZCak0zaVNQQSstN3pvazc5OTB0bXpjWlNxazVzUXdKRThaQ01CbnBm?=
 =?utf-7?B?WUEwaGkydkViU1J2RnQ0RlV3L3IvUW1rYlRlVGx3Y1FDS096eHlMQ2RzdlVp?=
 =?utf-7?B?cnFJRFdmUTZSSkRYV2lYbCstZnVnQnRTdVJJUEhia3VQeTI5UWQ1YkpCMFdr?=
 =?utf-7?B?MWYyeTRma2VLL2IzQ3FkVEJQQzJMYUd0RGQyZm9hRnBZbFhhT0paUzlBSjBW?=
 =?utf-7?B?UCstYncrLWhoQi9ZUUhmUXVtem44MEcvZlZ5RXZFcEdMU21oV1ZWOFY1OVRx?=
 =?utf-7?B?Q3QyTFNZeEk2T3dhRmRIYUdjZTRLTlN3ZTZDKy02bysta2ZDeW9RUk5qa29I?=
 =?utf-7?B?V1loMnVPd2h3blcxektlZFJRSXpNUjBKa2FvOTZLdnRzcTcxU0JGaE1SSEs2?=
 =?utf-7?B?OVU0NnFXbystRG5kbUNjWjNJTnZ4OXFjUystM05sM3ZiS3hyaUpOeW1tMVJZ?=
 =?utf-7?B?V0t3QlZsUFNSc2VDLzdhKy1DQ2pUbHF4V2QrLWN2WXNkc3Y0VjZ5SEhWVnpF?=
 =?utf-7?B?dkFZUystb1liUCstNHRON05Cb2VIRkNNMmNLb2JnZzZlN2dCamhVS3QzMWcy?=
 =?utf-7?B?ak9iZysta2NNZW5EcWYzSWNrM2pxSjVONGtOb3l2MHVoVUlTRFZ0QlhSbyst?=
 =?utf-7?B?U0tCL3BvdDllSWtJT1hOMURQRjMxQk5ENG1KajZYdWUxZmdFR3kyZ3QxeW9M?=
 =?utf-7?B?bkxpS3pBRWVVMWRTRHVTcEZoU2FyYjI2d3IwUjNhWlF5bzd0emt3NnVKaWI0?=
 =?utf-7?B?cUhHcVF1eGZOYVJOMFpVUjlISWc=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB7070.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?L3R5dzJEKy1VazFiSE85T3lCbWwrLWswR3F0MWU4dHNxSEtVd0tjNGFzQndo?=
 =?utf-7?B?L3dlRm4zKy1nODMxcGw4SUdCYVNlSlJkcDc4TnFodEhWcjlPdWRnQUE3VnFr?=
 =?utf-7?B?cllZVllNWWhHejgvcW5yZElZYS8ybGFEZ2pxY090VTdyV1lOMkxhemV5MThD?=
 =?utf-7?B?dWk4WlZqcm92MUN3YXpscGdHeUl0bVdqKy0yYUNOSystS3A2NW5Nb1VtQ0ov?=
 =?utf-7?B?VXltaEFEU1JtNDJMNVVBejBDaUQ3aHBSQm50S1k5MElmZnd2a3IyWnpFS3Zw?=
 =?utf-7?B?RTBGWFJtMFBwYmFSWVZLNS9ycG5MeTM0cVZLSzY5S0J1Zkg4SWlQRFZ1N2pP?=
 =?utf-7?B?QUtwTHJNYVRQVE0vRWk4Y1BJRnVTQ1FpV2V1cFhrdmVSdHZ2c3lBOUtkdy82?=
 =?utf-7?B?VGRSTnE0M0s0SnI3amxIS3VBSE1kSW9sY3FNVndJSkxNOTNnWXJ3Zm9aTzNy?=
 =?utf-7?B?UElib1o1cUJySmlDeWpKODdPNFlWYlJpUzg5blo1MW9TSTRTOU5sdHl6T1hu?=
 =?utf-7?B?YTlTTGVKZkhaa3BwNTRld0tjUkw3RWQzbWdWY1RZZ1ZwSndBT1cvL3pWeWNB?=
 =?utf-7?B?NlhoRDJySGNUWUZiYWtSUEFsdXVMcVViNistODVZeWxtNnMvOVZXbUo2QTAy?=
 =?utf-7?B?aVdpeVlyOWRONWhwMlV0Q2xmRU9jWGdqWnAyRXR3T3JNV1N3Zno0c244VDhk?=
 =?utf-7?B?ZHRZR2hRZFdnck1YcDZaMmRPVHdMKy1UKy0wVEY1TjJWV1IzNUZnQVZsQmJh?=
 =?utf-7?B?eWx0Mk9CaVVHaWFTczVyN094NjI3NEt5RDhlakFTR0R6Y1V4SXdoaUNtTSst?=
 =?utf-7?B?YncvZmE5RXJFL0l1aEtsMUlxSEtkemJXcnhxcmk4M3VpV094QXE5NjAvclBP?=
 =?utf-7?B?VVBKcEpuWTdDa2tPNTFDbUFCbVJXamVFWmFHKy1YN2NBbUM2NnViWkRpeWFP?=
 =?utf-7?B?ZEZ4UXVtb1Y1QkpnNFNjNktFTElBODVCYWlFKy1wZVFuZWpjN0hONGgrLVEv?=
 =?utf-7?B?cDNNV1o3aEZESFBXeW9sQ3FoWER4VjVIeGNYTzVrUXhJTTJOQm5SYXdKeVkx?=
 =?utf-7?B?aGpkVG50b2xHL0NSR2dUbHdud3k3dWdIVGh2djYwL2tlWnJHTnNGTWpwNDJD?=
 =?utf-7?B?YUlzNXFpNzRlVmRPNks4TFd5R3FBL0Y1TDN4cHNFVzU4MkM4NktWdjM1NDBB?=
 =?utf-7?B?clM1NVdacW94bWFNUUZKOHZqUkFPU3ljelUrLTNqdEhjU2U3OUFoZXBENm1r?=
 =?utf-7?B?T256cVN0VkJEUmRJbVVFNlQ3NFdhbGFxSjd6OUpZblovMFk2YzBJTFlYeWVF?=
 =?utf-7?B?Q29TYjVmMGhQbTU2LzlwQ3NiMistQkdQWWZwOVhNTE1CYUl5NTI1Unk2NE9t?=
 =?utf-7?B?NWFNWXFuWVVDZzJwUUI0OHRua2pnMlhMbldHVVE0RDByKy1hSzBRSXFGWEZ0?=
 =?utf-7?B?QTgrLWgyOEVJdzRQaWwxVmFwclRFNXI3b1BMaU1weUxCYzlLRmZ3NEExdDYw?=
 =?utf-7?B?eVlQSDhHNmYrLWczMXlsSVZValZzOHlMRistUmJlRUtzd1RHT0toM1ZsbGtH?=
 =?utf-7?B?SUdGa2J4UlpGSEI2dy92SHNhdWVLOU55Q3pnNDg5RllXbnByTW91TistVlI5?=
 =?utf-7?B?L1hPQVhBSkRPYktoRlMvL3FzY1loNFZMdktJYVI4UWhIcEdkL3FIRElRZHlD?=
 =?utf-7?B?WklBQ1J6ZThaTk5aWnhVM0JFRUNXVXd0OE1aWmpPa1drTVJYYnczNmdYOEJY?=
 =?utf-7?B?Tmt6OFQzNmhWVUpYVmdZUmpLcjJtME9OWmVzVUp6UzVjU09PVWRTRlNQNjJU?=
 =?utf-7?B?VUFaeG40VisteldwMkQyQmRoMFVJc1FEWDRybE5MR0hzZ1hQQTV3dk55WU9R?=
 =?utf-7?B?QzErLTZ3Y2NrSGNrajRLVm81RE9STSstOXJNVGxUQi9kN0pqKy1kcXE4aUlh?=
 =?utf-7?B?ZmJoQ2U2c1MyMkFMOVVRSm96alJGcXZqZ0lobDJadHkydG1yTUxzVWZ0WVh1?=
 =?utf-7?B?aFovV3YyQ3hWNzZlT0gyRWZOQ25scmFVeVptQmdyTWhVY1lsNkRUQkQ5dkl3?=
 =?utf-7?B?Zm5MbzU1S3l6eEwzVjkxSG1wMzBFVE9KVTBVdG85VG1XMWduajRTRWRUckdZ?=
 =?utf-7?B?MUF4R1QvZi96dklxME53ZkhZSGJMSjAxYms5bUQ3aXRXNzlqd3orLWNLVjhy?=
 =?utf-7?B?ejRUdGcwSWxlSnZuNzJpbmFmSWxOaTEvb0ErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: electrolux.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB7070.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd0761-170c-4491-c9fd-08dcef44d43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 07:16:47.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2007bef-127d-4591-97ac-10d72fe28031
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMggBPVVWnvjSgvnAsnkdl3zNeHzSgwn9/E1ha/LWWZAZiP0PVklhex0pHf3WOaifpe7ArS0WcgBDbv3/Aup63luiawTOPtph3BPZ0LnBY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7904

Hello,

I confirm that by using the latest git for windows snapshot it's working.

https://wingit.blob.core.windows.net/files/Git-prerelease-2.47.0.windows.1-=
7-g8597dced10-20241011120159-64-bit.exe

Thanks for the support.

Regards,

Dario Esposito


Classified as Internal
-----Original Message-----
From: Taylor Blau +ADw-me+AEA-ttaylorr.com+AD4-
Sent: Thursday, October 17, 2024 8:41 PM
To: Eric Sunshine +ADw-sunshine+AEA-sunshineco.com+AD4-
Cc: Dario Esposito +ADw-dario.esposito+AEA-electrolux.com+AD4AOw- git+AEA-v=
ger.kernel.org
Subject: Re: fetch and pull commands not working with latest git version +-=
 BitBucket

CAUTION - EXTERNAL EMAIL : Report suspicious emails using 'Report Phish' bu=
tton +IZE-


On Thu, Oct 17, 2024 at 02:32:40PM -0400, Eric Sunshine wrote:
+AD4- On Thu, Oct 17, 2024 at 8:49+IC8-AM Dario Esposito
+AD4- +ADw-dario.esposito+AEA-electrolux.com+AD4- wrote:
+AD4- +AD4- What did you do before the bug happened?
+AD4- +AD4- I updated from git version 2.46.2 to version 2.47.0.
+AD4- +AD4-
+AD4- +AD4- What happened instead?
+AD4- +AD4- Git fetch and pull commands get stuck and never complete.
+AD4- +AD4-
+AD4- +AD4- After reverting to git 2.46.2, fetch and pull commands are work=
ing again.
+AD4-
+AD4- This sounds like the issue reported and resolved by +AFs-1+AF0-.

Thanks+ADs- I was going to say the same thing +ADs--).

+AD4- +AFs-1+AF0-:
+AD4- https://urldefense.com/v3/+AF8AXw-https://lore.kernel.org/git/9d2d6e7=
b-9691-
+AD4- 4c9f-9b13-f1019cd1c491+AEA-gmx.de/+AF8AXwA7ACEAIQ-OJgLNWf5u1JzCMvA+AC=
E-VxZ2ohQdgVdW9Pyref
+AD4- bzjr9LtBQNGBDN0XCSUZcG1t9X0bx5F4BTahD2CBFFncSZN833bn6adUbbTJpPiQ+ACQ-

Thanks,
Taylor
This email and any attached files are for the attention of the intended rec=
ipient. The email and any attachments may contain material that is confiden=
tial, privileged and/or attorney work product. If you are not the intended =
recipient: (a) contact the sender immediately and delete from your system, =
all copies of the email including any attachments. (b) do not read, print, =
retain, copy or disseminate this message or any part of it. Any such unauth=
orized use may be unlawful. Email transmission cannot be guaranteed to be s=
ecure or error-free as information could be intercepted, corrupted, lost, d=
estroyed, arrive late or incomplete, or contain viruses. The sender therefo=
re cannot accept liability for any errors or omissions in the contents of t=
his message, which arise as a result of email transmission. If verification=
 is required, please request a hard-copy version. The protection of your pe=
rsonal data matters to us. Please find relevant information relating to Art=
. 13 GDPR on https://www.electroluxgroup.com/privacy/en/. The Electrolux Gr=
oup www.electroluxgroup.com
