Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2119.outbound.protection.outlook.com [40.107.135.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597956BB41
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708270654; cv=fail; b=p/tVIjkakbRPw5CpyAWzSL45s0eKW6Iap2kQzH7jtvxZwLCw5Ya2eYnJfz+xDNzs6mv5/GZUI9IEAhuGteORQ0S/X3S04WInLSy9HNMnW2u+Sl0xyxTLdPBYuMAxWDBhOwJkz77qU6KJdAmcOlfVydQYTbk0b7OQlRE80tbmn9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708270654; c=relaxed/simple;
	bh=ch60xJhGxRhyQ5JfhnRNjhLlErTc65urTFxev6GcSdQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S9HZ5q+uVELSVuSP4+T4CN1AIlgyWmqSnBJsDAWBP3djgt8leog39uUz4Ky1dUCqSKV995GeS4VOI52PtQ9bAEShQImDxa2GurtbDj5hzpFsYwf689bf250Lywc0BSWJc4A1eqRU1kWMWzxLHVt7VrfVR17ZZbhFI1d2UFwOdVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastec.de; spf=pass smtp.mailfrom=fastec.de; dkim=pass (1024-bit key) header.d=fastecgmbh.onmicrosoft.com header.i=@fastecgmbh.onmicrosoft.com header.b=Bzmrzxgn; arc=fail smtp.client-ip=40.107.135.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastec.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastecgmbh.onmicrosoft.com header.i=@fastecgmbh.onmicrosoft.com header.b="Bzmrzxgn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBfPQp/xM6SumfV45gQMoRfh/aH1w7EhNAWYC2yG/l7Kute2tO71hJW1JLlUIfGk+PVELhAcIPa5saqgtNcmAjgKjQMxDs7iGi7Y3Hf+xc6Y/ttDkPjGRg5WaJwQv/UWaJPr6M23bGydH2U+PAsRxktVRdgbkiYGi3cL0FX/qSHAwT56kt/h10dVUDXGJ1BlKlZNP0qX0J28WgzHfYDvD+Oz4DtmA7Jgsf73nrGINJehvm9G6SLtFwvdzHIZ4XRQD1c5eECzu+OJOoIRMVilCXZxgdCeH7FzJ9Get3BMau6ED14DtJ960XRidyiHVh6wIyHh/8nzNpJzlSjE+pvYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch60xJhGxRhyQ5JfhnRNjhLlErTc65urTFxev6GcSdQ=;
 b=aBsxYh/nFpQ3fkzrKhEg8rEEcOxelZjj+CBkdGiy89zT4dFQbdhKrvOGv1+xGd1YBxVa6pVtQZk0bxGAoEaq8r5eypVEO6bK3g86RbxQfnSYTqEpfZg1+6nzIUbQXIjLLg03oawteQrzGtCBtFRgiCit3DEZNCeX+61dv3MTm85wgyFC8gnRlhYukdpWtV/7Fw5d6wUBj9ACyTcJ5gOyo+oqsPN2FZBIp8QGSFZwzVJDsVZm5j/DoRu2xgX7fhXaRhCbTfrgYrT4aEhKjTYq4l8mkHxnMXRnUmIQNebiW3WekJbDaiWLeWszKoa6aKtiiqkKva5BDQ/yyd9izXLipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fastec.de; dmarc=pass action=none header.from=fastec.de;
 dkim=pass header.d=fastec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastecgmbh.onmicrosoft.com; s=selector1-fastecgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch60xJhGxRhyQ5JfhnRNjhLlErTc65urTFxev6GcSdQ=;
 b=Bzmrzxgnp81oSs+IaQ4hGh+AbCO8lnXARv28IOxhXj/L5qV1PO6G7/DkC84mCXZncli6kmnVZfO03BeJ5jZ2jc6IQlbIL6Njlt9BWZiekie+SkS+SSAeHjB4Rsa+NZJ1OMe150b3tRj/fC+v9QSyukcPL1UUheX8wkPNDR22yZQ=
Received: from FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8e::8) by
 BEUP281MB3619.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:9b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.37; Sun, 18 Feb 2024 15:37:30 +0000
Received: from FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6cc0:4279:43dd:b928]) by FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6cc0:4279:43dd:b928%3]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 15:37:29 +0000
From: Dominik von Haller <vonhaller@fastec.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Why does the includeif woks how it does?
Thread-Topic: Why does the includeif woks how it does?
Thread-Index: AdpigFX4rY/DF1D1RvOx6v4IWkYvIA==
Date: Sun, 18 Feb 2024 15:37:29 +0000
Message-ID:
 <FR2P281MB1686B7258CFB60A0F33FE108BA522@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fastec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB1686:EE_|BEUP281MB3619:EE_
x-ms-office365-filtering-correlation-id: 579e5d4e-d37e-4274-cd29-08dc30978462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BfPEb3+VeEQD978dnft7+sgu3fBABUSLH7lZ9GGs1iQlR7DYuEPVGLL3id3i2Tr3TfQeaRgGi8OoofrCnrzPXfF5+w3/BT+grXeDxAdvreusf31/3HYfy8uobjcSDxFvINNA1BVnO9N9Z4zE701MnZDFIn8CsHfpOV+YeHahoLr53FIU8+qEQ6gheHpo275w/+26je3axEnSfC0a9+ABj7Vb1j2uiZlX3G/MCiUw0YD1KubtME4I1C8pVn/D2N7+tCC+Ws031DObQfGFzSZbaB9X1eWvcecNBIilU5QS5vtjhOtlTNsNwrEAgkds3RbTnr1rGzBH4D2evPOrwEizNbqFh0zPbqPhZsojFQlcCLfIya4VQVZ5bgCBB9vbi1ou3XxrW3eg0/kKsKFEFA2Gyt4RcjtBoQokojYNORULst30PT9Ri8u8cc+cqENIb+eZO+SdYzxnQdXukSSArjrSb1QnqEcyOyI68fuheb4REgO1Q5MpK91lxd25UCrlnuSoOco464Vp9tmMuDJ3J6HThu4My56OVyMXWUEgJCmcaCQdZ3x4x3iAVf0B6Ihu1cuGvMe4RvTY9BFPxa7hmYyzF8SJZG9NLUbo8EQtYf1qn6w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33656002)(83380400001)(86362001)(38070700009)(71200400001)(41300700001)(316002)(6506007)(7696005)(5660300002)(4744005)(9686003)(478600001)(2906002)(52536014)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(966005)(8936002)(8676002)(6916009)(55016003)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WiGinV8ul4t1382MT8HgxSRLTTZ27tvKhKy1FQiCgji69QDmyy/lNGf2nGxg?=
 =?us-ascii?Q?Ibe/TRKUJaSD+TjlEHPL8B0QPO8cGnrE0RMFijVdDcVzWIpllBB9M8bkANhz?=
 =?us-ascii?Q?7MCkaHMn+Y2BaEHx/E7ZF4dUsp9WlTGtwbURfhLxINjP64fsPgunxVUn9zM6?=
 =?us-ascii?Q?wctZ9YbaY4E9mStvywtWVGqP+gdBRxLEbflChexjRIQ5e8l0WNvhtgROLC31?=
 =?us-ascii?Q?42o9z07VN5h5sG1Xe2VxiNDb4zrrqWHsRvMeTsyA4ZIR9tK67rolHaTpsc0s?=
 =?us-ascii?Q?+LpPqmca39GmEMBDwk16dU0QD82qIkI+aHakeehLaadSx9lWPWqeAs9nxKq0?=
 =?us-ascii?Q?1rndw6ZdzUatVjPaNHhDYYV71Om/1Ty0q6f1QwmfiGBpKurgvHVWv02Gyy/X?=
 =?us-ascii?Q?a+nTiH8kzIn7VUkOEUGK0Xk92fj1zEfveSuMx6KEUw20ABRPlyHx3j2nKtcg?=
 =?us-ascii?Q?nM5aW/YDe1Lby38smEkNzVUkd1228PM7Cf8pB6fCxqt5y9XiWoak4I8MHiiT?=
 =?us-ascii?Q?7lgQFEvvz9IjzNFQpjFPQV3eCUOe/IOb9rUHAQFItdUIKXzioVLhQikLSSYX?=
 =?us-ascii?Q?Sc55hveirFqu8dEm5dYuNPMr4fUIdTYgDfrxTvQ7Daxofp0EW5vGxGSSujRp?=
 =?us-ascii?Q?106xiegm19l6Pypb1rYyyl/L9yk9FKHRrZiTikN5bsPnUx8LXwh5gfXO+Yix?=
 =?us-ascii?Q?/Ap5T+yUmZMpWl3WAL2mDingITc/c5nSDVheExNWEh/fMjzzHLdySKAYs04/?=
 =?us-ascii?Q?alJYZbliv9McgyGgiyksfSUxGinSSDWKHx6eLwm7IID1Mptga9kcjrYVcTzk?=
 =?us-ascii?Q?vOzwOgZD7iYEX5gIeRY4SOFMYdff0IgGv8GDlr9YtIo6+NqJMkCzvK2RhyMP?=
 =?us-ascii?Q?RKo9IbNTLy6IoLyvmhsN4NwZsUuMPASVNIAGv3NiWEGpc87Gg4cJc5eROi3y?=
 =?us-ascii?Q?GIx0fHiErNXxXt2urumxGWVgs3VI1pq968SfLAMxG+XnJg2vzprO8murPCMx?=
 =?us-ascii?Q?upSq2489YZimH/JxxkE1armNvXYSMpiW3YMYY37BjJsl2ofuuitlaD9Ahapt?=
 =?us-ascii?Q?CNZB4xTLD1lNoLeBn2C30J0uaSyERaQXfTrtJC0zO8RDemDLyy2jxBU7lXWZ?=
 =?us-ascii?Q?m7frfCVaMC8VGIIyUSN8svuFLYoO/U4vYmhuzBZOVBX7BWaETz4s8mYxZyJX?=
 =?us-ascii?Q?Qh8m1Jtbhm5IZU0cep7o7SdV5I4xYkszYTwqV/oTE3mYWY8vhJj10omZTfUS?=
 =?us-ascii?Q?BYxRK9QxBI8/tA/Fw8dn3BFpQOPO1IoUQf0PAFmuVam7pChpyyn78xnAahmS?=
 =?us-ascii?Q?2w4aj3ENGBYH2UPf8MkhuHAy15JIuPKMX6XQlOg61iDstt3P+rMIUYuDns69?=
 =?us-ascii?Q?uok80OdrZ18UzxPjI0fGUhSRYxeMus7Kwt6NvAXuagb4+XMHGau6Rx2VxG+w?=
 =?us-ascii?Q?73G1M//uPMU5KoNxny0EQXEBJhNnitqKimhGRsP39NZNKbSY4ExT7b9IDTGP?=
 =?us-ascii?Q?vNCGv/jZnfhDUxFtcLEpsWYB+RBJN74P4m5Uupxfv/5hkfpsZvTit8SkLVT9?=
 =?us-ascii?Q?1xS3jz6s5Qdb/bkBBup4Y22+WJqbOJmw+JXYX48vWPYMFfa22Dlp8JKGRtEc?=
 =?us-ascii?Q?y5kksZkCOmQGOzGrQ7aLn+p9TCwTFGUbNBOc/5dNbKnZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fastec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 579e5d4e-d37e-4274-cd29-08dc30978462
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 15:37:29.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f95ea7c-9a3d-4add-988c-01b7cee9a358
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fiyN6KpQ4ushEQLyZekWICAHoZ3hxxBKX55M8KoNB/sYnbdHgusrW/GO7RZFR5lujqPBZrUnsbhB/+MxUHUzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3619

Hi,


I have been playing around with the includeif from the .gitconfig. It did n=
ot work for me at first, but after some help, I did get it to work.

If you are curious. My Problem and what else was discussed here: https://gi=
thub.com/git-for-windows/git/issues/4823

Anyway. So, I was trying to access the email property which was set through=
 an includeif config. It did not work because I was in a non git directory.=
 Yes, I do know that the property set in includeif is named gitdir, but it =
was not obvious to me that you need to be in a git tracked directory for it=
 to work.

I am trying to understand why it must be this way. Why does it not work in =
non git tracked directories?

I am not sure if I am conveying my Question correctly. Please read the mess=
ages in the github issue if the content of this email was confusing.


Best regards
Dominik von Haller
