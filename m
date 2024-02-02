Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2100.outbound.protection.outlook.com [40.92.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F113BEB6
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870632; cv=fail; b=WSUSsrvbpXemAe8CLbYuujg1Fk5G/G65G6DAMx+WYcCAFbQ3dWI9HJQ1VUtnUsyeQpEZ53cfKjDuEtq2uAzDL74AGaDUCjVueH/+15cy1+R7f0FsvUJKs/2xrQ/O32CA3yYJnGJqInNAPsRW9qqfXNk7j4VmORt152lkuNut6mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870632; c=relaxed/simple;
	bh=040IgWglCUlir/JZfwRRTV7j+BvfEUy4AimobBhMRbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fvVGr0b2Sd9LLfbI6WL8MBdpwVfHiJAKMnt7Lzzd70IdfWY2Q9H7BX5Zi1oGLMu+/p3Mvg2EmMIBGoJ9Z4HqYw/O9z0vIxCxcsed+n1q+xpmxRLMVM2gZEQTqgTGvgMtqLpAClMjB1kr5Gv0mCrssqYLDH1bWGsLD6vZOXyxqM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ka2HD/Gs; arc=fail smtp.client-ip=40.92.58.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ka2HD/Gs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbP/CKx2KmFqZszK5f8HWADrvQ0o8bMf7mhhDhDapmeYT+0y6nn/diX50TMXBh/LwgJ6G0sGDYp8O/tKAXkIii6W4JHKP9bHCqtbU2/w37V7EXtLBmVLe7FCVLl3/9RgkayciQYM2G6EuMfjLeUsfjcsVI5+8LG+MfMDzhpTWqH8WT9e3J5rOaEf3bmlL7xJxKPQIrgB8NOW4zl50e6aMgrtwUo/JJr9Pq65+VIEP3aDnwkErAgHDeX0YdkdVSxs1MiuAppye1QdI3XeZeulOid122rbPDVSzeyubgeJXaPGjchKk2MswSK/CI14DW9iid03UlTJMSUievFZK2QRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=040IgWglCUlir/JZfwRRTV7j+BvfEUy4AimobBhMRbQ=;
 b=Pb0sYbZTNj7/FJl4cJBVd8ig6LyKBpo5qbUD1EP3CUffhkoqW6FN4OGWCABMMROLxtohU1+vfVy6qyyWyiVkMgPKKHg7mGqkjxmArlMcAfvZxIktY8BqjBRmYv3jnycqa2xiYOh0wFsvLVEOX8U4PgIdssXy/h7eQhuBXDdxj65hr9A22QyaqHodMbieb/Eps/nNKGQC68GD5Gibh7jRHcx/ppXCwcbgHJzRCIWKaAq7FjiSv6ywn3GqJiJveCBrGRp52W78LZ3GtIozStHKCXJ6DyB/Kui+ecEFfwbqW/4CQWhaamDsCXdJP3iN87jP5J39DfV0ubvI+viiOoh3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=040IgWglCUlir/JZfwRRTV7j+BvfEUy4AimobBhMRbQ=;
 b=ka2HD/GsXmT38i+JdO0JeuZdldqSJm6RXFIaFApKzu98OYwbS8YxJM21S94YZGWFN3s5adMDkQETLk1BZOcS5x6glJNIvp93FXCyN8RyiBU04vH8tlzdv348CdCsdR6pdZEmX+PFQclsRdOdu/A41KJmIlJYtfklcjw9MruBOVhOt5D/y5jAzE+pL9WTqZgK2lwnAnIKxCvboEBo50+wgykeq3v0JreQIPlrVexfubCDVf/HsrfivId8MudQEtPjF92eTVVJ019W4GmP3S8UX1Rfho0juSkSSAme8BWRXydZC+rY41L370RtXmKlG/w5VE+u3Vc9Eue5L13VI/Ov/Q==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by VI1P195MB0654.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:151::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 10:43:44 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 10:43:44 +0000
From: Hans Meiser <brille1@hotmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: Dragan Simic <dsimic@manjaro.org>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index:
 AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9oAACw8AgAAGJuWAAH5PgIAAkvjQ
Date: Fri, 2 Feb 2024 10:43:44 +0000
Message-ID:
 <DB9P195MB21302F96E3E2CD404FDBF9ACE2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
In-Reply-To: <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [HsgXLA7CZVNy7ypwb6xPZsJCgXjoxOG7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|VI1P195MB0654:EE_
x-ms-office365-filtering-correlation-id: f1780066-9840-44b8-1661-08dc23dbd436
x-ms-exchange-slblob-mailprops:
 laRBL560oLTmV3YUZGBVpWtZmo3U4emCtqUDDGv6+Lq7tVtvgqFNE2nooWj+lkFJQMvfTIlQp9URZSXI2UtLTK8mfPGx9PV4R+DC8b/MZuOzrGsmr5GzYXWUVQI5czIah4CxzCJtAyMP95I7i7snQp7r5vVPxkimz2oy0/YO2/AxBUrj1/zOMRLnsiGENTShKhGdo+OdANhnU5jwn/G8Qs0ZeOXkwtbYWX0/b71thYVP0LogjTF1ehvKbxbig1riFWE196gibt6nLWW41eY7+V8hqw7s4DCiQCLqXxtn56XHI0LbzIZDbBAVGGW4yflXaJC2JmGCt7YKpcYbW6dd3r9wgVhZmCHweVxLDC565so2WllXgkFMFFPmBUDkpFYkb8pCy8qmloSZdetTe4TnfJU5FGJlJ+WFh/Zt1Cy+oN3ksVjbGa7wOtmK8/GGRbiN/Y3DaAmGBHM9zqJg1/7etPbF7pkyckmomlI9PiWo2cZ2/e/zTCv9gBln+VgNxCDth3Bu/JybTO/n3JHaDy+24ne7ol8sElrgkmumK/mYYRCyBSN+lpZNPG0K3QwltgsTd/yatbT1Vz/HC+OMQBY13LvZ6hwdAAhMwH/Ja5hsO5kY8rdvblv2+5HnbiIcf1uKDclnSZnD6ap2NMgoqYwta/tqD/CLeEUQkvLSbZ77aM69kQ5onH65v8BHZwCHUWG1ymbZsUXXquvkJpy4N75IOO/lGwGdnoQPiIGrc98ZaMHs9byOs1d2DVIUV5Qieejqnjp84dXr7w2l2YySEpPN7XNg1djHpQYu
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6EoIdkzbmm6jr5fuaUxzZSrhhjUT7XeIsFyTbjBgACc/VkmNFfZaAaJOMORAWz2b0ye0Zp82QOaFIUJbBhf4TylDZrHnLNkXWBwY27K2/jIdJEmSYf22vmN+u/FJopH2PbMzaTxCD5rV4QJ4FClq3qHs/gjDk0CUFpVqEAyICroitCsiNGlw0SEZbdhNBjWDeqsouFkmh9/QAPJw7C5NdgezqwnG26cMhYLazY2HEs9EZLyPwQiIDNc1hdR7LHmT7qsZjRhpZvldGklXjmDqel/hKIvCTXdlrfuptw4Yl8aD/G1Q/qY7UP4Mr68McNEQafykSf3HP9B9nx/jGT8AWuW4+po6RbesF+j9IlxzD3aVWappQyJIbiB3JO3FL8/QOK3XDy6tp4uVJqRyog5+JMoB6BE+MbQSPfMF5Vwq15n1xd+csbctPJiX2A3yd95i7CsGfMZydqZz5Jr7iA73BAI+tprUY1dIIVtzSHV2LxSCCB/fJVK91CdHnJjCu1YmD2gByE4n/bH7gTsEH1js9T6LcGze9+3Mc/nlMRG/tmh12+PkXopi+joTnhqQzszc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?e3kvWOeNU2k0/ChpeV3GFWlszjdxH1sNNJMdRKaVM9az7y+64XaxVfb53L?=
 =?iso-8859-1?Q?W7cvshKQCRy69Kd9NcRdTm+tBDxTkpU8SMbjMbGe0yzIqcMfUlqM2/yP7y?=
 =?iso-8859-1?Q?ZBjqS3d9TUSHIvHiVRR1vwWZerfkWwzIFZSlpQbLNHQSvKsLVrE2nWIcHg?=
 =?iso-8859-1?Q?3CSKHLG0ji+fdD5u0BywdjnNZfPBElZWIau/wsLN4Q3Yl6owvoClTrn3/W?=
 =?iso-8859-1?Q?RYCk2j9DIUQOdS50c+QiXC7WDe3hzIQ43lMl1Wr7fArQumezC0Kw1Uug77?=
 =?iso-8859-1?Q?jL8OVhQ/I+mrsFwQEeEBIOP54UsYz8EuSxxl5bkAo/BJHGiuVWl4fGfJ+G?=
 =?iso-8859-1?Q?/atsfTNmrER+SyvFa2w3kKtHL1jQnM7uQiLplAnv/kp3jInzocoa0QLq4t?=
 =?iso-8859-1?Q?Rzmr697HakRMIpTmtG98EbU5orbw6ySUKuZTVUfPEd1abm6FuZcmBIckXW?=
 =?iso-8859-1?Q?k6BMAh1XQ3vxuuk4FYJ6YX4j94i1VBQ0Q+CmXTqhnvwKfI5O/mQlLqQ9qZ?=
 =?iso-8859-1?Q?hwSBQyqzPaSzzFci3YItCMCuX9bkm663RswjxguQPiuGbCFTRUBeUJ0emP?=
 =?iso-8859-1?Q?Loh4v+49rEd6wvwPKIsl/gw6m9gI6N7PombBfAo22Z+ERiItLgtmZmEz0o?=
 =?iso-8859-1?Q?JbGbVA74sePHYZhiRSt8Q3AoAd2rdlMr8L67qS79Ttqg/YRQwRJLFoR1DU?=
 =?iso-8859-1?Q?z+vskw+ftsVciE+DC/f+/wk/fpA4U/nlXxcX7+sibouqQAZb5xYZECUKY3?=
 =?iso-8859-1?Q?Ma3VcqNDTGu4hk0gkHRBOPUbktE24bC7ZlvdcFZGw2dHs+T74tG1uelFEO?=
 =?iso-8859-1?Q?oj3Q85+SnL5QNpNyqW3vDHJFMYH35/gcaKjWFQvZeHphYQcsvt1r036iAr?=
 =?iso-8859-1?Q?/Y8Hn1xl6HjihIG+YxlMqWK8J+Z+ythdlOeV08PCCXUUajM+xYocyQ5kvf?=
 =?iso-8859-1?Q?fSdqdQM87stY8T18ll797tWDGc0hDrePuCvGYAg1NbgnI6ud+6DKElfKHA?=
 =?iso-8859-1?Q?tISXOcJkNIpQkRSUEWdJCHmhg4vRgOWOByb9t/N0KQgbCOxIW3CXLaFA2J?=
 =?iso-8859-1?Q?QjdIUSs/Objq/wgnf+77/tQXcdjF7M4LqwK4JD8Yf3Oj6McEFWEpr5kjjj?=
 =?iso-8859-1?Q?KzK5slkwCF/Rw1mfTRYqFvQb00RK9TcP3M7HJ+MRloh4whXkreoq4JjTGZ?=
 =?iso-8859-1?Q?DmH61RXMaQMTz2pQO9XZHbJwbPqd4uXV0vCqBkWMgFpZq8WcOzLgtBcs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f1780066-9840-44b8-1661-08dc23dbd436
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:43:44.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0654

> We've discussed moving to Markdown.=A0 Unfortunately, while Markdown is=
=0A=
> great for HTML, it's pretty terrible for things that are not HTML.=0A=
> Certainly there are tools that convert Markdown to other formats, but=0A=
> I'm not aware of any single tool (outside of Pandoc[0]) that does so into=
=0A=
> all the formats we offer, including HTML, PDF, Texinfo, and manual=0A=
> pages.=A0 Markdown also comes in a large variety of variants and writing=
=0A=
> documentation to please any substantial number of tools is very=0A=
> difficult.=0A=
=0A=
Actually, there a plenty of converters out there converting Markdown to any=
thing. You many find many websites that are using these converters for prov=
iding conversion online. In case there'd be a particular target language th=
at actually may be missing, you may want to employ a 2-step process: e.g., =
just convert Markdown to HTML and from there to anything else. Once establi=
shed, documentation would get updated automatically with every build and al=
ways correspond to the latest version.=0A=
=0A=
I've been working with many documentation teams (e.g., Microsoft, Alphabet)=
 who are using their own Markdown compilers for adding hyperlinks, warnings=
 etc. in their automation script converting Markdown to HTML. In all the ca=
ses I've seen it's a simple pre-compiler, replacing particular tokens with =
actual Markdown content before conversion.=0A=
=0A=
Moreover, Markdown commonly accepts a restricted set of HTML tags, so you m=
ay even extend Markdown inline for anything fancy.=
