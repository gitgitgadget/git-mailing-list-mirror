Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.144.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903082FA0C6
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.144.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232525; cv=fail; b=iS0V51Kg1FeAV4WV8mmZnR4NjSmh4UD09R4hdy6NRlOYs1mqJbixbKSDGeOXkxYYn1aVZ+cKZzzOeRNgvwvsp0gGfsVHQ6vy6sBaZdKONiAX1SlHLy/G2wRuYYy6cW0PGabE8Et0N0JYuPwEXTGdfV2s1xqDhGgXnVDZ8QJWXU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232525; c=relaxed/simple;
	bh=LJu6OxFhLTDwmi2dts5MBLdh0S+dtAfrhCEcRdZExgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJMsLQmvWM9R6geLM4sjWEtnm+agBmQitmEnW96iTXG6r8LgGkh6d56wTkL89OdMX0AYOwaBaXOwfAQA8RXHRZrxuy6eZy4FhQVXOITD3rANfv5YsC5CIlCyZWB59dIuVoFcwrHKjUgiAM71MEUtnYiL/j7YuYnFCfnMGTJPC1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com; spf=pass smtp.mailfrom=johndeere.com; dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b=EdjwdgrF; arc=fail smtp.client-ip=67.231.144.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=johndeere.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johndeere.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johndeere.com header.i=@johndeere.com header.b="EdjwdgrF"
Received: from pps.filterd (m0040767.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILlIg018668;
	Thu, 18 Sep 2025 16:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johndeere.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	S1-Feb19; bh=LJu6OxFhLTDwmi2dts5MBLdh0S+dtAfrhCEcRdZExgo=; b=Edj
	wdgrFftxM+HgT6ojF+TSTnI9c1+0i2mzrDJ5Z3SmK7ByNHe+jmtwWp7TlIeRWe8B
	jy5vdD/MG+oZ0AdclP6JEgCSJ/NOCW4DX3wY9cOU8QQUuZMMEVKgQvSQg3xcLtna
	W+I/Pa2A4e8Latkfrqw/UT8yx1ao/DmI+z4T/YgWAQGNhkvdbi0T8uqI83fHZtyx
	MPJc2FgcEMEO6WknCTIAltUyvnj8l7vgmARwX1aj9tO3HY/yrRDZR7QCfBvxXm/L
	P5k1iHVfL+oIMmoxg6CFFY9EdbP8aB8hkQMLpir3UDgjf5vVKVKqEq5PZt0XteOu
	de8ZRU4/r6LkI9zzf4A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 498q9w9bgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 16:55:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX+sSney+3pgaTqj7KUazzS4PijK7YuAZnVRYpC4VFJS9xXbv3CyH7B4NhDJFSBDjiLjGDWB/GKrsL2ZFeHZOuTMC8621E3Fj9+aYEwlrOui8TJ4H1efLkGngC6Nev/x95Kf9eXR8FXoRi0zSa1zY8nIODgk9oCxmUG60XY3746P2iNw6rLs6IpOh9mS/xiUaz19koyJK5IsjB5F4OG6/v9TTrbyhH3r0H2Atq5mTF8uJQcrxdQJs1jXNbo8JfJq38v6i3KkScS1vPaHJhl+95iqTeijNiQbNgCpk46zrGaJwkBbg+DxHn8DvMZ2PT/uQHEBhBu8RAO0xgYgzQP4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJu6OxFhLTDwmi2dts5MBLdh0S+dtAfrhCEcRdZExgo=;
 b=g5Ari8xJuoqVNv2TrRTiTmZ87iQzltuhn+lSAw213VQEPecqtcCLVPxQqTsESJ6l3ipk80qRuSDLHosdgRPk9uH5vXOH3TAkDTh91f9XuRC6aXjVdVNsGxuhLWzrX4anb6NCjui0oFKwFhoJMFxXXXbKhlmsHXJlaY2EYujvZSRXoVv43ENdbHK3eXGNEvrbtLN/ROOdyqE7N+Z6LT8n7e6+ldyp1WAfDdbASxN5/mG0FMmoZ+LWu/MUOVhaAagtqO5O2rbjRCEcL6pi0Pvm2Y2LOPRJ8WyfmncCu3BYUUX+0EWVFd4+QDhiu+zidB7ZWpKWuIIS7aJ0RgMIuTsISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=johndeere.com; dmarc=pass action=none
 header.from=johndeere.com; dkim=pass header.d=johndeere.com; arc=none
Received: from DS0PR05MB10013.namprd05.prod.outlook.com (2603:10b6:8:dc::9) by
 CH4PR05MB10998.namprd05.prod.outlook.com (2603:10b6:610:241::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 21:55:03 +0000
Received: from DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d]) by DS0PR05MB10013.namprd05.prod.outlook.com
 ([fe80::9fee:64a0:138c:ac3d%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:55:03 +0000
From: Kevin Puetz <PuetzKevinA@johndeere.com>
To: Jeff King <peff@peff.net>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: RE: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Topic: [Bug] git fetch --dry-run --filter makes changes to .git/config
Thread-Index: Adwn4L+L8mwJ2RsSTrSupH686MDnlwAOFSCAAAMzZEAAKtzLgAACOftQ
Date: Thu, 18 Sep 2025 21:55:02 +0000
Message-ID:
 <DS0PR05MB10013AC6090CEE7A562B56CBCB516A@DS0PR05MB10013.namprd05.prod.outlook.com>
References:
 <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
 <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
 <DS0PR05MB100132C058A3D9D5AA735D905B517A@DS0PR05MB10013.namprd05.prod.outlook.com>
 <20250918192045.GA1187769@coredump.intra.peff.net>
In-Reply-To: <20250918192045.GA1187769@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Enabled=True;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SiteId=39b03722-b836-496a-85ec-850f0957ca6b;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_SetDate=2025-09-18T21:55:00.0000000Z;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Name=Public;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_ContentBits=3;MSIP_Label_029374dd-2437-4816-8d63-bf9cc1b578e5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR05MB10013:EE_|CH4PR05MB10998:EE_
x-ms-office365-filtering-correlation-id: 3e13a777-7309-4c73-0c1c-08ddf6fe0562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjhBYmtvblFocmJ0b0JINld4bFFTeDZPcDEvNDJQWmtGbGpNOWs2YzRiamMv?=
 =?utf-8?B?UTlBV0JrRUNQWDY0NzFQT0YrWFpZZnFnM01DUnJvWFZ1ZXVBdUY2VFltNytD?=
 =?utf-8?B?cW5kQ2hlL1lZbEpQc2VRTW5SdUFqV3E4YmhtREJUamx6bkgzcGYrenVSOGlJ?=
 =?utf-8?B?NktyMENnQXlZWTFkTERsSU1URG1hZTdqSW85Q2ovN0ZoVWpVZ0FwRlFkNzlz?=
 =?utf-8?B?VGhiSm1sSHEwQ0dWbk1pam8wc1dqWEF6ZEZ1ZjBlckZwMXBtL2NhUWF1VXk5?=
 =?utf-8?B?ckNvdW9jaXM5YldvUTRRYWlPUWZtTWhOcEZYQzhkaHFqZW01WVp6Z2M0dGZn?=
 =?utf-8?B?dVlEdFN5N1FQQ3RiRXlHRzJKeXNSMWMwL01lZWpIY0crcEhsK1o0c3hscGVG?=
 =?utf-8?B?UlIrM05wbys2UUFCZEY2dWtXSHNmQ3lnekw1cE10Z0tPT3EycjdOWmhZZDFX?=
 =?utf-8?B?L0xDVFdMbjVLN2prL0VvUExORHYydit0eFlMNUZnSmQzUDB2b1A1dnFtNVFp?=
 =?utf-8?B?a2hkUGxTY3VidUI0ZlNmTEJyS0x5ZFRxWDdiVGYweDhYb0dPbGJxRk9wekcz?=
 =?utf-8?B?TmR4clNNRkFwN1FtcW51UG1RTmVDRkhZdHlrcmVsQW1rNExpQTNlWkJYYjFh?=
 =?utf-8?B?Mjd1T29xUndpTW5DVlRtNXBGamdwanNBQVVuMWphT2t5QndRVHEydXhWK012?=
 =?utf-8?B?M0FLdzlKYnB3Q0NhMyt3eHVsWU5pRE1DcXNBRmtZR2VEaVJQZEZEYi9Mb1JB?=
 =?utf-8?B?NXB6THAxVTBtV1Fac0gySTE3eFhZSkVUOWpWcUE2L3V6ckFFNnBOQ1QxWkFl?=
 =?utf-8?B?R0UyaWNib3V0TVppL2FMZVpNTUVWZUdSZ3g1bUJKM1U2SHExMEUzaVlmRXdz?=
 =?utf-8?B?MmpZaU9WVUJkQXc3ZmVFT2lZamE0VDRGWDJTeXpNcmJZZVBmMk5ORytRaTFQ?=
 =?utf-8?B?UmFGYzdVN29NeVR6TEdnRXhaQmJuYXNxdzZwdFUzVG5hMzh6a0VwM0pzNGdV?=
 =?utf-8?B?RzhTVDBzMUlyb3hlKzI4K1Zad2d6Tk1OaFJ2SUJZeHVwbjFJczJyWXJhM0tX?=
 =?utf-8?B?SmttTVFQcWVudnpmNnczMW1QSEl4bFUwM2liK3M0dWE1Y1lYYVVWQ3ZyWk9t?=
 =?utf-8?B?Yks1TDFoRGkwUVRJanN4RTZXS0ZETXJoTU1VREwxQis3LzFRaGwvcldPR0xp?=
 =?utf-8?B?eWhQOG8vZVFnN0pvSzVZdzBHYjhDQ2FaWDZTN2pIM1J0ZFpaNE4zL3RXYVBP?=
 =?utf-8?B?RjNaMW5CeGQydjZ0WEFUMm8yNi90d2pjcjVnK1Bnc0R2cmp2SUNFWXB6Uk1V?=
 =?utf-8?B?ck5ZSVZzRERJVWRjMzdhOHVNczZ2ak5sMTFoVnY4YXJzTmhtendTdDN5QmRX?=
 =?utf-8?B?ZkVldmtna3h1eEUxTUNKeDUxWkNsNFVCYjVvRnpseGtYanZtQit2QTBPT3ZF?=
 =?utf-8?B?blBQV1ExTDNHOE5zRVpTaFVmLzJVZ2RaRzZMQk16REwzaVUvWTU2TGQyd0Jt?=
 =?utf-8?B?a3BCenF4TmVlOHZmM0UyaGZrR3RKcTYyejhpa0l5V1RNNGR6bDFZTFNwSFI5?=
 =?utf-8?B?VVEvbG9qSnNyWXFxc05MaTM4TGJOZ3FEVzhoakV4dWsrdldpcGtvK3NGaDB1?=
 =?utf-8?B?dHh0WHpYcStnbGhwR3hQS3NsTWV0YWk0T05xdW50U3RQWEZSY2NNQlZIbHRG?=
 =?utf-8?B?VEI1QUtpRDd4bHR5Z0xoeEVwaElqalVGMlpoMGtKQS9RVGh5OW9heWdUVnRu?=
 =?utf-8?B?WThsWkZJak9EWGo4MDFyeXE0Sko1RDBhYWVuQlpjRHE3UTUrR2JUam1ZTitU?=
 =?utf-8?B?S1pGdmV1SGNuVXNMUEd6OUd3RTM2ZEdVRWpyZDk0aWVCSnAvRnB4SDJLbjZS?=
 =?utf-8?B?eTc1RndWSmdkMkR2UTlSK01MRURwNWZnOUs5cEcyU2FyUlVTWkJIbHNGMzdP?=
 =?utf-8?Q?ScKsMzXuoGJQngPAFDcp1MPvbO0U+PsF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR05MB10013.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1MyWHVoQnV1UER5VmFPOVc0TnlkVnlORlBhamhabHZickZQYnM5K0pHVTFy?=
 =?utf-8?B?N29ra2E5dzZBNWtZT2thclJxaE9EMTFvU2tKUEJFdmVDcVhGRW9oMXpSQUY5?=
 =?utf-8?B?UUNCRFoxQ05kUzlab240VTA4dzBhRG9kK05YZFY0NExxREowdXE2UDc0RHBM?=
 =?utf-8?B?Vjlzc1ZTT0lBdENpaFV4OEVhcUJad3FaYjZocldNMk5NYlYzNS8xR2huSzRa?=
 =?utf-8?B?bmFtUkVxSy9oWnNPZ2t0ZkVsQTdEczRBenMxVUtadml2WThJWWQ3R0Y2YjRI?=
 =?utf-8?B?NHhOTWdidWs5TFp0SGYwdzJqMjFVUUQ4M0xpRnQ5cGxzWGRlcDY4ZzdOL282?=
 =?utf-8?B?N3E1bm1FTVhIR2dneDh2QU81VzBSNHdXNjdlbjZXa1l6c3hxR2NueENkaGho?=
 =?utf-8?B?OXRPMTEzL2RURHdYWWNVUzd3VmtBTUZBQ3dhN3krZTdUWFBlTzk3YkhpNnhU?=
 =?utf-8?B?T1hhbGlMaGJNM3ozTE5BYVB3enJ4WkY2YkxOcjlJQ1JWTEl0Nm9kTG5hVmZI?=
 =?utf-8?B?aEJsUU1tUWtlMU4yUUtnOGpUblNjRkY2VXN4T1VkR2pYKzc5TC9xdCt6b1lh?=
 =?utf-8?B?cGpiTkU4ZUtGLzZkQzVmMHpTUHBxWjRGd3BFajQ1YkVnNkcrWU83dGFQVFhB?=
 =?utf-8?B?eXlGVTZZOUFUT3h2ZitNVlFqVVdCOE9BNlNYQUpUaTdNbEI0OHppTmE3dll1?=
 =?utf-8?B?NnIxeVo2dTJIUGI5Um1hamRjcVloWDd4ZVJ2ek5GNWR6aDY1NHNyUXd1VVB4?=
 =?utf-8?B?eFpYZVIxN3lYMDhGelQvMDBnbnZiQ204ZlRuTVpldkl4M250RXhQampjekF5?=
 =?utf-8?B?N1VBWG9OUmNNWXgxUnVobWpBNTVJbjFGcU5hempuTGRBWE9IYkFnbzhnQlA4?=
 =?utf-8?B?bk9MbGZHQzRKdVFYTlUveXBpb0Fzbko2VzZTdlVkOUx0NEdvM2hkZDNTOWdX?=
 =?utf-8?B?MU9FVVJKazk5Z1MxZ0k2UmE5UEl1T0NZZUEvWUxIemE0TkJJWGtTMW1SbUZX?=
 =?utf-8?B?dnRCUysvMEdmRndIeUM0dTh1QVczNTR2eXJMaFprNFhCc2MvcmpuRkh2T0ps?=
 =?utf-8?B?K0cwRHRnREhnQ21JZ3gxdktrMll1V282c2N0RS9UWlVpczZYNlBmNDVNVGU0?=
 =?utf-8?B?VXBOSG5UbXFmWE80ZXdxaWI4dGlsL2RVOFdrK1NIeXNwVzlMclptRUswQVZB?=
 =?utf-8?B?Y0tkR2RtY2FJeExEc0ZaZGtGdHNWOFpJTVJZRTlQTVBzSVdFTDdsQWZQMHIy?=
 =?utf-8?B?UFZsLzJCMEdjTlFzSHJ3RVUxKy9OckFxTDFOVncwZG5ENjBDWk1tTnBnakQw?=
 =?utf-8?B?OWlaVS9RVFMxWXJLMlVnbFE3T1NBTS8vV1RocTZqdmNJSlVHQnZ2QUl2dGl3?=
 =?utf-8?B?MU9vcWF5VzFyaHRWRFRYK0hhbGZoRjVWMFRxODkrc1VSQ0ovdDhPaUNYbWZ4?=
 =?utf-8?B?NjlmOEMyWkg4UTlUT2c1aEk4V04rMFFYUTh0NmRocEdncytZbW45Y2ZmeStI?=
 =?utf-8?B?TmNTTEc2UDVCOEtNb0VXQWRTWDlYZlhCTzd5YjMvS25OVGQxRVBGWktSWFFm?=
 =?utf-8?B?OWRsc3VUUm5vQzExZTIxa2pFSFgrR3BBMTlzT1VaNGY2bWNXcWRVUDh4Y1F0?=
 =?utf-8?B?Sk9xcjFYaFlPV3VoVkdLUUNoeFNpamJSb2RuWFhjQXIvVG9DM1VMVndpejFQ?=
 =?utf-8?B?cEVLbTZtZG91VlIraTNIZUI2ZWRFWnQ3UHNWOHFQMTZOSUcyWElaN2RBYW43?=
 =?utf-8?B?dnVIemtMWWRLZjF1NUtNWm9GWDNCdGRDWVBwTlZ5Ulp5b0FEUE5oMTBQbW00?=
 =?utf-8?B?ejVSanRXVjB1d2NEOFFXeEpZeXVvaE1qK29OQ2MzMVFmWFRHSzJDd0doNzhO?=
 =?utf-8?B?SjYyUzUxSk9rZzE2QlVTUHNsczFveHAzdkcrOUVHRVl4VGI4VThIZTQ5d25G?=
 =?utf-8?B?VWJid2ZqY0NMSExCT1JLaExQTTVYVGxKbGQ5NUVlYW9JZkZuM1dwV2Jjemgw?=
 =?utf-8?B?cEdmYUl5SU5xMHNIUjVnZURPWkhTNXdBa0VhZzFzbFN5OEc5U2F3VlFKandJ?=
 =?utf-8?B?Nkd6S0VSQktnMnJ2YTVwVENjbDVrUmM2MWJPUHRid0hYME9PSS95L0wyWU12?=
 =?utf-8?Q?Kd0hqI6q9HV3163GoS8MWCVg9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: johndeere.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR05MB10013.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e13a777-7309-4c73-0c1c-08ddf6fe0562
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 21:55:02.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b03722-b836-496a-85ec-850f0957ca6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvNd5yikAZlSbW88GkepVIM9zH+NRiAaEiYRVYm0RsYn151fZn9JQq7SkjKmI746MZ2YHNTyCwOlfQ7T0iTLcsBxMvaGkelTASoVjoLfbdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR05MB10998
X-Proofpoint-ORIG-GUID: rDswZBPo1URMm0AZkxXtAPZJ_IBt8sui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE2MiBTYWx0ZWRfX7gi+FZMaxfLX MPtZMUo2yWMOQukjtT+nIk7FxIBxBt7Ks0W8MuLFvJoLB8tLegLF1stI37zLtZUMPcy/uuuR5B3 QFP6XbO/kwQ8c75CrFPvwMXEGOPRNHz+x6L2WBjnWjYhNj5QeiE7NkdhtXAQA3/0XeIfXnkDFhE
 9B5EsbIPmw4Usq3rZcu2aFlz21khXEBefbs6/vlGQHNKqa9yKUQtk68zW3fG7i7zYZGlduCg9fN NtjInHTx2S91NDUtI3FHJi+BKpr6oo29eSgnRX/Swcm991QeEP4MY47P9CpZuqpjOGJ0N8lzGJW JP16AWVVr2u/XO+OXQPmUk5s0yX5YJ9wZeVMF6Kaym5OBY9mdGYVWkPcUz2uaOkolW+clnphbT7 VZKmc3Zh
X-Authority-Analysis: v=2.4 cv=KsJN2XWN c=1 sm=1 tr=0 ts=68cc7fb9 cx=c_pps a=m7Xu73pz8xWBtfo2USfVfA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=anyJmfQTAAAA:8 a=W9ymYDpetpEb6u5QA2cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rDswZBPo1URMm0AZkxXtAPZJ_IBt8sui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509180162

PiA+IEkgZGlkIGZpbmQgb25lIG9kZCBxdWlyay4gV2hlbiB0aGUgcmVtb3RlIGFuZCB0aGUgcmVx
dWVzdGVkIGNvbW1pdCBhcmUgdW5yZWxhdGVkDQo+ID4gZS5nLiBJJ20gdGFraW5nIHRvIHRoZSB3
cm9uZyByZW1vdGUsIG9yIGhhdmUgZG9uZSBgZ2l0IGNoZWNrb3V0IC0tb3JwaGFuYCksIEkgZ2V0
DQo+ID4NCj4gPiAkIGdpdCBmZXRjaCBodHRwczovL2dpdGh1Yi5jb20vZ2l0L2dpdA0KDQogLS1u
ZWdvdGlhdGUtb25seSAtLW5lZ290aWF0aW9uLXRpcD0kQ09NTUlUDQo+ID4gZmF0YWw6IGV4cGVj
dGVkICdhY2tub3dsZWRnbWVudHMnLCByZWNlaXZlZCAncGFja2ZpbGUnDQo+ID4NCj4gPiBUaGlz
IHN0aWxsIHdvcmtzIGZvciBjb25hbidzIHB1cnBvc2UgKGV4aXRpbmcgd2l0aCBhbiBlcnJvciBt
ZWFucyBpdCBkaWRuJ3QgcHJpbnQgYSBtYXRjaGluZyBjb21taXQgaGFzaCksDQo+ID4gYnV0IEkg
ZXhwZWN0ZWQgc29tZXRoaW5nIG1vcmUgbGlrZSB0aGUgImZhdGFsOiByZW1vdGUgZXJyb3I6IHVw
bG9hZC1wYWNrOiBub3Qgb3VyIHJlZjogLi4uIg0KPiA+IGVycm9yIHRoYXQgeW91IGdldCBmcm9t
IGdpdCBmZXRjaCB7cmVtb3RlfSAtLXJlZmV0Y2ggJENPTU1JVC4gT2YgY291cnNlLCB1bmV4cGVj
dGx5IHNlbmRpbmcgYSBwYWNrZmlsZQ0KPiA+IGNvdWxkIGJlIGEgcHJvYmxlbSB3aXRoIGdpdGh1
YidzIHNlcnZlciBpbXBsZW1lbnRhdGlvbiwgcmF0aGVyIHRoYW4gdGhlIGdpdCBjbGllbnQuDQo+
DQo+IEkgaGFkIG5ldmVyIHVzZWQgLS1uZWdvdGlhdGUtb25seSBiZWZvcmUsIGFuZCBkaWQgYSBz
aW1wbGUgdGVzdCB3aGljaA0KPiBlbmRlZCB1cCB3aXRoIHRoZSBleGFjdCBzYW1lIHByb2JsZW0u
IEkgYWdyZWUgaXQncyBwcm9iYWJseSBhIGJ1ZywgYnV0DQo+IGl0J3MgcHJlc2VudCBpbiBnaXQu
Z2l0IGl0c2VsZiAobXkgZmV0Y2ggd2FzIHRvIGEgbG9jYWwgdGVzdCByZXBvKS4NCj4NCj4gSSdt
IG5vdCBzdXJlIGlmIHRoZSBidWcgaXMgaW4gdGhlIHNlcnZlciBvciBjbGllbnQsIHRob3VnaC4g
SWYgSQ0KPiB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhlIHNlcnZlciBkb2VzIG5vdCBrbm93IGFu
eXRoaW5nIGFib3V0IHRoaXMNCj4gIm5lZ290aWF0ZS1vbmx5IiBtb2RlLCBidXQgaXMganVzdCBy
ZXNwb25kaW5nIHRvIHRoZSBjbGllbnQuIFRoZSBjbGllbnQNCj4gaXMgc3VwcG9zZWQgdG8gc2F5
ICJkb25lIiB0byB0ZWxsIHRoZSBzZXJ2ZXIgdGhhdCBpdCBpcyBub3Qgc2VuZGluZyBhbnkNCj4g
bW9yZSAiaGF2ZSIgbmVnb3RpYXRpb24sIGF0IHdoaWNoIHBvaW50IHRoZSBzZXJ2ZXIgc2VuZHMg
dGhlIHBhY2tmaWxlLg0KPiBCdXQgaW4gdGhpcyBjYXNlIHRoZSBwYWNrZmlsZSBjb21lcyBhbnl3
YXkuIFJ1bm5pbmcgd2l0aCBHSVRfVFJBQ0VfUEFDS0VUDQo+IGluIHRoZSBlbnZpcm9ubWVudCBz
aG93cyB0aGUgY2xpZW50IG1ha2luZyBhbiBleHRyYSByZXF1ZXN0IHdpdGggbm8NCj4gImhhdmUi
IGxpbmVzIGF0IGFsbCwgd2hpY2ggdGhlIHNlcnZlciB0aGVuIHRha2VzIGFzIGFuIGluZGljYXRp
b24gaXQgY2FuDQo+IHNlbmQgdGhlIHBhY2tmaWxlLg0KDQpZZXAuIEluIHRoZSBjYXNlcyB3aGVy
ZSB0aGluZ3Mgd29yayBhcyBleHBlY3RlZCwgdGhlIGNsaWVudCBzZW5kcyB2YXJpb3VzIGBoYXZl
YCBsaW5lcw0KZm9yIGFuY2VzdG9ycyBvZiB0aGUgbmVnb3RpYXRpb24tdGlwcywgYW5kIHRoZW4g
dGhlIHNlcnZlciBzZW5kcyAiQUNLIC4uLiIgd2l0aCB0aGUNCm9uZSBpdCBrbm93cy4NCg0KV2hl
biB0aGV5IGFyZSB1bnJlbGF0ZWQgKG5vbmUgb2YgdGhlIGhhdmUgbGluZXMgYXJlIGNvbWl0cyBr
bm93biB0byB0aGUgcmVtb3RlKSwNCml0IHJlcGxpZXMgd2l0aCBOQUsgKHdoaWNoIGlzIHNlbnNp
YmxlIGVub3VnaCkuIEJ1dCB0aGVuIHRoZSBjbGllbnQgZG9lc24ndCBqdXN0IGVycm9yDQpvdXQg
YWZ0ZXIgdGhlIE5BSyBpdCBrZWVwcyBnb2luZy4gSSBndWVzcyBiZWNhdXNlIGlmIHRoaXMgcmVh
bGx5IHdhcyBhIGZldGNoLA0KcmF0aGVyIHRoYW4gbmVnb3RpYXRlLW9ubHksIGFuZCB3ZSBoYXZl
IG5vdGhpbmcgaW4gY29tbW9uIHdpdGggdGhlIHNlcnZlciwNCndlJ2Qgc3RpbGwgbmVlZCB0byBm
ZXRjaCB0aGUgd2FudGVkIHJlZiAoYW5kIHJlY2VpdmUgZXZlcnl0aGluZykuDQpCdXQgaXQgKmlz
KiAtLW5lZ290aWF0ZS1vbmx5LCBzbyB3ZSBkb24ndCBhY3R1YWxseSB3YW50IGFueXRoaW5nIGVp
dGhlci4NCldoaWNoIGxlYWRzIHRvIHRoaXMgd2VpcmQgZW1wdHkgcmVxdWVzdC1mb3Itbm90aGlu
Zy4gU2VlbXMgbGlrZSB0aGUgY2xpZW50DQpSZWFsbHkgc2hvdWxkIGhhdmUganVzdCBleGl0ZWQg
ZWFybHkgYWZ0ZXIgdGhlIE5BSywgZ2l2ZW4gdGhhdCBpdCBkb2Vzbid0IHdhbnQgYW55dGhpbmcu
DQoNCj4gU28gSSB0aGluayB0aGVyZSBpcyBhdCBsZWFzdCBvbmUgY2xpZW50IGJ1Zywgd2hpY2gg
aXMgbWFraW5nIHRoYXQgZXh0cmENCj4gcmVxdWVzdC4gVGhlcmUgbWlnaHQgX2Fsc29fIGJlIGEg
c2VydmVyIGJ1ZywgYmVjYXVzZSBpdCBpcyBzZW5kaW5nIHRoZQ0KPiBwYWNrZmlsZSB3aXRob3V0
IGEgImRvbmUiIGxpbmUsIGV2ZW4gdGhvdWdoIGl0IHdhcyB0b2xkIHRoZSBjbGllbnQgd2FudHMN
Cj4gdGhlIHdhaXQtZm9yLWRvbmUgb3B0aW9uIChhbmQgdGhlIGNsaWVudCBkb2VzIG5vdCBldmVu
IHNlbmQgYSAid2FudCINCj4gbGluZSBhdCBhbGwsIHNvIHdoYXQgZG9lcyBpdCB0aGluayBpdCBp
cyBzZW5kaW5nPykuDQoNCkxvb2tpbmcgY2xvc2VyLCBJIHRoaW5rIHRoZSBzZXJ2ZXIgYnVnIGlz
IGF0DQogICAgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvYmxvYi9jYTI1NTljMWQ2MzBlYjRm
MDRjZGVlMjMyOGFhZjFjNzY4OTA3YTllL3VwbG9hZC1wYWNrLmMjTDE4MDUtTDE4MTMNCg0KVGhl
cmUncyBhbiBlYXJseSBleGl0IHRvIFVQTE9BRF9ET05FICh3aXRob3V0IHNlbmRpbmcgYW55IHBh
Y2tmaWxlKQ0KaWYgeW91IGRpZG4ndCB3YW50IGFueXRoaW5nLCBCdXQgaXQncyBza2lwcGVkIG92
ZXIgaWYgeW91IHVzZSB3YWl0LWZvci1kb25lLA0KYmVjYXVzZSB0aGF0J3MgdGhlIG5lZ290aWF0
ZS1vbmx5IGNhc2UsIHdoaWNoIHN0aWxsIHdhbnRzIHRoZSBhY2tub3dsZWRnZW1lbnRzLg0KQnV0
IHRoZW4gKGR1cmluZyB0aGUgd2VpcmQgZW1wdHkgY2xpZW50IHJlcXVlc3QpIHNlZW5faGF2ZXMg
aXNuJ3QgdHJ1ZSBlaXRoZXIsDQpTbyBpdCBza2lwcyB0aGUgVVBMT0FEX1NFTkRfQUNLUyBjYXNl
IHRvby4gQW5kIGl0IGVuZHMgdXAganVzdCBmYWxsaW5nIHRocm91Z2ggaW50bw0KdGhlIGZpbmFs
IGVsc2UgeyBzdGF0ZSA9IFVQTE9BRF9TRU5EX1BBQ0s7IH0NCg0KSSB0aGluayBoZXJlIHRoZSBj
bGllbnQgd2FzIGV4cGVjdGluZyB0aGUgc2VydmVyIHRvIGdvIGludG8gVVBMT0FEX1NFTkRfQUNL
UywNCmFuZCBqdXN0IHNlbmQgYW4gZW1wdHkgc2V0IG9mIGFja25vd2xlZGdlbWVudHMsIHdoaWNo
IHNlZW1zIGxlZ2FsLg0KaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdHByb3RvY29sLXYyIHNh
eXMNCg0KLSBJZiB0aGUgc2VydmVyIGhhcyBmb3VuZCBhIHN1aXRhYmxlIGN1dCBwb2ludCBhbmQg
aGFzIGRlY2lkZWQgdG8gc2VuZCBhICJyZWFkeSIgbGluZSwNCiAgdGhlbiB0aGUgc2VydmVyIGNh
biBkZWNpZGUgdG8gKGFzIGFuIG9wdGltaXphdGlvbikgb21pdCBhbnkgIkFDSyIgbGluZXMgaXQg
d291bGQgaGF2ZSBzZW50DQoNClNvIEkgdGhpbmsgdGhlIHNlcnZlciBjb3VsZC9zaG91bGQganVz
dCByZXBseSB3aXRoIG5vICJBQ0siIGxpbmVzIGFuZCAicmVhZHkiDQooaS5lLiB5b3UgZG9uJ3Qg
d2FudCBhbnl0aGluZywgYnV0IHN1cmUsIEkgY2FuIHNlbmQgeW91IGFuIGVtcHR5IHBhY2sgZmls
ZSkuDQpCdXQgaXQncyBkZWZpbml0ZWx5IGEgY29ybmVyIGNhc2UuIEFuZCByaWdodCBub3cgaXQg
d291bGRuJ3Qgd29yaywgYmVjYXVzZQ0KaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvYmxvYi9t
YXN0ZXIvdXBsb2FkLXBhY2suYyNMMTcxMi1MMTcxMw0KDQp3b3VsZCBzZW5kIE5BSyBpbnN0ZWFk
ICh3aGljaCBhbHNvIHNlZW1zIGxlZ2FsLCBkZXBlbmRpbmcgb24gaG93IG9uZSBpbnRlcnByZXRz
DQoNCi0gVGhlIHNlcnZlciB3aWxsIHJlc3BvbmQgd2l0aCAiTkFLIiBpZiBub25lIG9mIHRoZSBv
YmplY3QgaWRzIHNlbnQgYXMgaGF2ZSBsaW5lcyB3ZXJlIGNvbW1vbi4NCg0KSSB0aGluayB0aGUg
Y2xpZW50IGNvdWxkIGRlYWwgd2l0aCBlaXRoZXIgInJlYWR5IiBvciAiTkFLIiwgaXQncyBqdXN0
IHRoZSBlbXB0eSBwYWNrIGl0J3Mgbm90IGV4cGVjdGluZy4NCg0KUHVibGljDQo=
