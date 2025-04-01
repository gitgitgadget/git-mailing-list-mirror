Received: from de-smtp-delivery-123.mimecast.com (de-smtp-delivery-123.mimecast.com [194.104.109.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A01EC01F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.109.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509994; cv=none; b=Y01lvP+Bms3UlnLPkKnKmOm9UeESe2gnuzptmCebBzWI5Aq6tZafuPcGxW0FcIWjwPI6jIQlYBS0bwZEHdh5uZiH//Tc+y/XPrV0Zdz2pJ7UfMnNoNq4HEBOSEOZ9IGlifTpSkDQYrdYtWuCVd9pwOWu5yFNo0GKRba1x3N6FS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509994; c=relaxed/simple;
	bh=ty5AdjodzLVdY86wo+KorY1M6w3D43HUcEExBJcXzuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjvtnWL5dlwN/bDzwey9zOpJJySPwIxp50TJ6RykXIHC2i+w+2EEEO6rBIafqiMWNbq89Naycu+JytOjtvT4Mejpz3eGbHnwGpR0Xne6hyr9t4oeAuIaWTqR8pBRBnOs28u+khI4+9KXymVcgkcuFj1qfuTywa688K19EOioTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=se.com; spf=pass smtp.mailfrom=se.com; dkim=pass (2048-bit key) header.d=se.com header.i=@se.com header.b=qpSpl7rw; arc=none smtp.client-ip=194.104.109.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=se.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=se.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=se.com header.i=@se.com header.b="qpSpl7rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=se.com; s=mimecast20240503;
	t=1743509990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ty5AdjodzLVdY86wo+KorY1M6w3D43HUcEExBJcXzuY=;
	b=qpSpl7rwdwKUYSZmCWqVy5AjeymB9ZC4JZgoUiVJqd/No4dU8HTSTEXiDVi3tvp4tq8pRq
	jjWtjHSdcjy5bOM8Rsur9ZfN6DiAlaaCgnYc1iEre29UMXu+dIYgyeUcXXCro4c2ZFxmvc
	bcOl2VwCvNRI9o0MeFVMU/d65VCl9xF+AKGBM+CLv5RReLLY4bvZx8grcHCncxS+2/307r
	+XyOR01zH1FtaOvzmGBI4SYJmoCAfxgJWxw1E/wH2z0EKdsGYE37tXac6eFPZU01V2CIpZ
	g5r+eeH9ddgQ3j8WyU3MBLdnMsNQbUXLkmRW5ddAvFGilm0HZpsJrPmfkUy/pg==
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2042.outbound.protection.outlook.com [104.47.11.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id de-mta-77-8GAPkIfFPs2rez6QpqmxjA-1; Tue,
 01 Apr 2025 14:19:49 +0200
X-MC-Unique: 8GAPkIfFPs2rez6QpqmxjA-1
X-Mimecast-MFC-AGG-ID: 8GAPkIfFPs2rez6QpqmxjA_1743509989
Received: from VI1PR04MB6958.eurprd04.prod.outlook.com (2603:10a6:803:137::16)
 by DBBPR04MB7756.eurprd04.prod.outlook.com (2603:10a6:10:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Tue, 1 Apr
 2025 12:19:47 +0000
Received: from VI1PR04MB6958.eurprd04.prod.outlook.com
 ([fe80::8e40:7e48:3c42:7b87]) by VI1PR04MB6958.eurprd04.prod.outlook.com
 ([fe80::8e40:7e48:3c42:7b87%5]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 12:19:47 +0000
From: Milan AJDINOVIC <milan.ajdinovic@se.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git client bug with branch containing "."
Thread-Topic: Git client bug with branch containing "."
Thread-Index: AdujAFtAqhU1kW9mR4qBaJSow0BCPw==
Date: Tue, 1 Apr 2025 12:19:47 +0000
Message-ID: <VI1PR04MB695864E125F3381932332BDC91AC2@VI1PR04MB6958.eurprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_ActionId=617109ef-32a4-420e-8cd6-e9602941f151;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_ContentBits=0;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Enabled=true;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Method=Standard;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_Name=General
 v2;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SetDate=2025-04-01T12:18:24Z;MSIP_Label_57443d00-af18-408c-9335-47b5de3ec9b9_SiteId=6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6958:EE_|DBBPR04MB7756:EE_
x-ms-office365-filtering-correlation-id: e3edd3eb-9aae-4513-84c1-08dd71177e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018
x-microsoft-antispam-message-info: =?iso-8859-2?Q?L7l6ljn8wapQLTgviC7oWAe2zmF2zilQNNpm8bQ0gFoySvVtUlYuLTfWm9?=
 =?iso-8859-2?Q?HH5AuXmNFcMH974MQd232Yrgx7E8I8b7f2b+5JOn1hkGmvZPTuuLpym3y3?=
 =?iso-8859-2?Q?Zofd/nMao9pCDeyC+Tk++2XBaAoWRSnEOcvRV7O7zgs2hRsN/uhqcl2+Wf?=
 =?iso-8859-2?Q?BMaNZJmArb6QZaLAfuFGABOddK49+6ytKQLRRRwb+G/OpqeW5sGzGP686L?=
 =?iso-8859-2?Q?ZPvBC/jBOcwj22r0nqDEuXgpPM8rhrHrk6orwlIbmdwp8DsjYgxNpcYqJv?=
 =?iso-8859-2?Q?tl0wZL3j600izX5DyYliLNRYnFk6MeWhj8mn9lI3kCiVvxwqOc92wIK/kh?=
 =?iso-8859-2?Q?rAOB7XdXcG3hC41b0006S4D04ikZBili90YEhJgE1V5gsIX/afy1PtqEYf?=
 =?iso-8859-2?Q?Wkfouc8triwDUdoCsDvqajk3HLcEummEkAPoInoQNdD4pVNQNsNBcvEZUy?=
 =?iso-8859-2?Q?bnLuOOfR5xIQLwKK3vz9daD0qUyC/s5arvHGz9fE4SvNkQHdDL7LvffBYj?=
 =?iso-8859-2?Q?GenWgGBgxlkGXH+oeaJ0X9BkFqn0A/L7ma4e6GDsyCyVTj8v++5FkhP5+9?=
 =?iso-8859-2?Q?xA5MAxXIqZkwByVSFzrO6IcPhWSvn+O7KgPAr/4t4hgFrNHGlkeMLtM2SL?=
 =?iso-8859-2?Q?XU02/o5qUheNM+pUC08z2nr8qwz8ECy6WIsM/f86MiJEba8i1L1r9Sq22S?=
 =?iso-8859-2?Q?clQ5cuUTEgcO1jiX5dSbx/8adhgLvjWygyvhkDfBse09f2Tng9CI0UPTCT?=
 =?iso-8859-2?Q?uz1r8rcRftTPBLRlK/HdC7gssKPFWVsHqN25JRlvA9RWrehlI1uFuqOs4o?=
 =?iso-8859-2?Q?BSxz1uCsa7bwGrnQ5oBxS+mUO8RWHS+2/Eh33LN6D3qzwtlYQ7CnAXDgEF?=
 =?iso-8859-2?Q?kty3WCd8hUt4+eSkUdUXQXIqGstDsJWObSDuJxGXAGsR4lXAojZ4iccSVV?=
 =?iso-8859-2?Q?ICD82wzNKCeqgjGJSXX/e9V22HVtE1C/YzW6wErLSd7RTvntwt7WuLKy82?=
 =?iso-8859-2?Q?T03f14k73C0sSoN/W7hrP83v9QvGtTb0wTfkmV6mJwDIaOvJ0hT7Rmkspg?=
 =?iso-8859-2?Q?W3zX3BcAmXyRPCRHXGQOkPKPucDU0DbepD5S2Icii9o/oSLMJl2vpLJa/a?=
 =?iso-8859-2?Q?LUuGNopgG8Uu0M1kBA4Lzih6GQkoz8e95Q2IcAF7cBFQefcUJpxjUF+S6W?=
 =?iso-8859-2?Q?lksHQz2LameKAFzpG4/cYOqEZ1UTYRD/0TqQR9mEYol9w9sDd2vZO8hPl/?=
 =?iso-8859-2?Q?S/tY6sD0Uo/vqbwTUohSvq/3Iz86WPqyuMdpVbGGryF+NB3sctnYypuava?=
 =?iso-8859-2?Q?zBsSyNGYeL6F4OUuBHL30PIH6hOjqyJiNQBiwuWcnqb7c8HJwt0JQoCUvD?=
 =?iso-8859-2?Q?eL8ixv1j2bG1JZnCRe48j3yzhJHQxIBdH1KCsqLvv7rmgzZ6XEMulbUSaP?=
 =?iso-8859-2?Q?v3k8xt6DawDGJEaxOeTOk8QjUzgExixQTISgchjR+cxVxSjJEZQXn125UU?=
 =?iso-8859-2?Q?FZxhA0X1iJxTvUOcYDOb3a?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?2aU6urELzsPEctLixtV0boXSkd7eD/nD4MqSF7tZwnR+zWLxzxR2iX8IgS?=
 =?iso-8859-2?Q?3lXAB2ucUeTqMtQanLxw4AO0TqGGJHf1r+ypG1P3HQQ/num7jKKj/tq8rR?=
 =?iso-8859-2?Q?Q8yT2I53GBYlFLgIuz24X0VH1Ptg6Rg9dLNSRgjwjljKmg7G4YZw9wUX+Z?=
 =?iso-8859-2?Q?pbKefmIPUMjSMWhv6U+n+kn7TkMtzJePHzNI6D8S1aUNDDpJ5TRmQqS9kf?=
 =?iso-8859-2?Q?qt0AN8jaDk6soe96Xu9yRPmFmtcGTAd3n5iKIbFNVDCHyHo100+K6g/k+z?=
 =?iso-8859-2?Q?hI8fiI/DyKWKGWC87iPQu4tKnTEbUzZIpGMxEoVx6Ub+z721h/IQwkaJCv?=
 =?iso-8859-2?Q?nw+bDmk1JJsfQdAezHgQtECycYie+jX9o2ehq8DBK1EQb+bd+8aghq8Gf/?=
 =?iso-8859-2?Q?7yON1s4ibS/qCz6vvbEIrmZp/ltC6iqHyg2UY5bCEglfjQwlRd9/8DknwH?=
 =?iso-8859-2?Q?C9dBsaylfg5eDX8rAahTIqwD2w4uKSLApW3anydN7igam7/TwfQlNmzwNZ?=
 =?iso-8859-2?Q?/fYvZVHevXE54NaavC4T+o6ixXtN6FmQXniQ2W+nc18q79jx6UlhrYG+cI?=
 =?iso-8859-2?Q?r9W+9VE7pWpiwDCY7RoRtVFlkI2j0UvQya6roRVMIG6rWP3rTURx4WTFxM?=
 =?iso-8859-2?Q?movLWFgt3GmBR0PtnsUCK5WT4h+M1TChG8ufl2VBfmJ0WUa/lCoKw4Jh2V?=
 =?iso-8859-2?Q?Pp7VjodLcOW9Ryc9JjPHGIAzGsJQ4wZT8RXTmHktv52DfJhLMXH80dDYxd?=
 =?iso-8859-2?Q?Gp/PBYZWPK7mGE38FuNvT2aeaai9qkeDnpWwT4pWxKEo+vy63iSPpUBxnl?=
 =?iso-8859-2?Q?FabiR3ToScNCS2tifN4AilDSocULhwvngDHutDlCxXKnK4ABkMfYg/ALgg?=
 =?iso-8859-2?Q?lk7icw4KclfVqD9BPNKxwv0VmqUn0X7J+kOiDy1/ZTOPon8M9+nEUeWOmp?=
 =?iso-8859-2?Q?Yo3grmGT468UQYYrUVvk5ZKkSDlfs5hkk2hs1CdhAlp8s3FjTDa6GrNF/N?=
 =?iso-8859-2?Q?SxtQq/43N9GLBXPfT6OYkVLwRDh1gPVGZqFOOy2TBShmJb85Y9Z9V/8MJM?=
 =?iso-8859-2?Q?jxQPJY4+WlN0Uq4bQHohH4oo49E2QczC7RXUtCbfbP/hov0IWV+2gzGB7J?=
 =?iso-8859-2?Q?VwKc0gLAew8+gqvVtQgXZbO+8Ome9noxsBcqDOJ5pp8IiIfp48JVj3yyhv?=
 =?iso-8859-2?Q?iYu8fe5UUH4JvbcOdH58WIhGRU0KHblTgZrsfIqdrdIxBtjNfeY+OawW4j?=
 =?iso-8859-2?Q?gdXQjV6f/2rDMATL7WPaeAVxG7+92IH3sSOGh31f/ny7t9WnSZfoEk7Ag/?=
 =?iso-8859-2?Q?yRwWhmtdlHau/cE9K1BjBmLnLIdarqCS2LkUtR1aJpVNwj7exv9Tu6RcXb?=
 =?iso-8859-2?Q?mFvWMudm8j8Cu4RNlKOLBmxitJmHS8c3WpYfAg6kuRCK+V+OUHTviy3FkU?=
 =?iso-8859-2?Q?0Pc3kjvbP76K/WDeSy7QqnpCupAV25miN+m+n5dd59xTBl7nk5qlR70p+M?=
 =?iso-8859-2?Q?a6YiQY3tVFrBmJ7qYwJKJDDKfKeMUdPJLvSOyTo8zz+72ZBBgF8COxFCP7?=
 =?iso-8859-2?Q?wY6woMkfjWoetInYnOCpdSchki+iYAGrwAUKqzqZ+ADfgO/CcX+RPINsY4?=
 =?iso-8859-2?Q?R1LWpmI9p0wk8=3D?=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FT1IUKdzVCvbLXT3F3O/IfpGUwRANsYeKkWKAVgQD5Sywb2tHuIpjHD0Zbg3xZMO0xnDnHXgeATAL4HwSILt0H5l0d8BJSKhU1S0n9D0ztDMZ/bH8fl/qjmpPNALTZFEPceAUiRjAuKzFQ7qahfbzdzhTb+6M69wd71Jt66rVRBcrK+wnOarZZnpdGS8KmwoCcCL7S5jQ+LWOcomSHVyxnAKfJZTll6hhx/mXXwlt7aoFo2OfX0CAiUQtdS79GnGlqQhDxcYxDW6EvXFB7qVvDFlCPbHE+Y1X9lucAhfXEPwuCzEqLIFiyBj9D1TEmDjqy77x7l4huiGjYaIpCfNJYk+MJo+OUDDg4g0bCTb2xaNRH2+M0y1DrkXNM392qZMLrGsussYStM2unk1QjtX8RZAUBZ9FF8M9scFx4GrE69NbeE5sl1pcNpLwzhpxLv1H7AvfQF/yArO9Y8Irx7lqLXAMnjPEdb69uL5Txd66inWzW+QTonAXeFuzv7mnIAzV/ZQJyH4mCkkxr6h+g0OWQplWaejzMa5GkhMVLkk2Xcu4LY5trmHDSSpiI34sYGyL9UpG/SfvGhDi4lf8Wr//90zE348j3Mo0Rv1Fa7ITF9F+KQQ8nXf17hPIfnLm2nFMZZJ76d4n2xRHgvrIzTAj/SqC4ATKCNJqz/bhWwzuCp5uOvGRHYKVULsp2bxUQBL
X-OriginatorOrg: se.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3edd3eb-9aae-4513-84c1-08dd71177e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 12:19:47.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLjIYtTBxi5+aCobpGa3Zm5P1qj3oioLKDESrrcDu+6bDrSKsTzVoBGnMSmQdlO+zAON/mMGqmw+IVY73KhuEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7756
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gI1pJY8L7CtKWeAMQy60yzv0CnSiq1_obOp2s-AJJZY_1743509989
X-Mimecast-Originator: se.com
Content-Language: en-US
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

What did you do before the bug happened? (Steps to reproduce your issue)
On GitHub Enterprise server I have created a branch named: features/team1/f=
eature./1.0/main in my repo.
I tried to fetch the branch and switch to it.

What did you expect to happen? (Expected behavior)
I expected for branch to be switched to:features/team1/feature./1.0/main
What happened instead? (Actual behavior)
I got an error: fatal: cannot lock ref 'refs/heads/features/team1/feature./=
1.0/main': unable to create directory for .git/refs/heads/features/team1/fe=
ature./1.0/main
What's different between what you expected and what actually happened?
The branch did no switch.
Anything else you want to add:
From my analisys the problem is because my branch have "feature." in it and=
 Windows can not create directory with "." at the end.
Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0.windows.2
cpu: x86_64
built from commit: 2f819d1670fff9a1818f63b6722e9959405378e3
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>









General

