Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C94B1E5C
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699907; cv=fail; b=MLMeuR1teT8/HFhIurwCbxDvIe8/Xm/6IpQEg8K1Yijo/n8exfjaIDOyaclORffvsPSgMey6vc+pwRyDWanQatX4wQhOhdvY+Jy7Jgrgwq5fd8oIsAdpXCdU85mQ9uASkPQQaQpvCyhV5uglsHVaVjZ3HZAOdR4xxoXFlbmU8ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699907; c=relaxed/simple;
	bh=XjyEWLe8mZeItEModPJ8Lmc7jXnr/WcTLHNmhTqAhQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VryY29hCI9x9iijp86bG0jOZp1qOSwZuJVC/M52GWlAnWu+iPwOBPMGZAhPkJydDgrY7KPhK/d6hQkeTElOMkm9NqOfYqK/Enta3mQD8nVBj8QWsXZVjMvH+J2LILsSuouBwGCcdTQfurtSNmYkuIK4VSxQ7IG6oxLNFCbNI/ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=dUXvvWwJ; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="dUXvvWwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3T2Eaz+q3dvv20ozBw317A24Vcsij+5aGK5Q1rfnr+9tWdeqkeGPAiwQZqaVwuCPImKJuXrOgoq5vgQPYrDHjup9KuhRtSbcNOwNTFzuUqxU19LzsNQLPosbwS8y2JJv4tPSz5/4rriN6skTKYkpvLkbyy7n/cWmjsTfQO631ukKER8GbmbtzjsGJxz4THJkKQz12Zse4j7HcIPN/vnp42kNb2KUAUAQMaV5JpwlPEvLfiFcZ+RG41k+tpGdZNe1YLxjdaFqAwddmHA5vMxzk7ToD486FxIvqF/DM6iSUgYzGcVl2pFvPuG+1W+GCITZNYWbKn11CKOOs6b+nij/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33qdNE4XCEKyBmFeJ+qpc3GPR2dTb5JV3M0iYFs1wQc=;
 b=KxeYjkgNeiIggaziK8+7kpQ5kfUpNLEEYVcNcSMCGkxZj/oUo9p4e150RKzm6KHswfNJX5EJiz7EGZfBlqNFrsoq0OClx3RmHRgAqpX3aPujp6qp5fUElrWR62CJoRa8TAw/F5ppcXMiAe2Pyno9/Jsdt1/XeMdaQt8lEHo6wNWXwWwHP3xUx96lwYY0KJDHG9UdvHzKQjuheyyUo/SM7NiXvrOPYPMPYKcGq/W9dSVhNgCNQzH1oH9FbCFD1tvNAfEYwLCS/NVzGrj6vKnSJ9IeoRC+JVyKOuOGnCRkeEE57Y7EVW9omCO6rNdQpDSDe+V8hmIlxKqVjcL2KqY2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33qdNE4XCEKyBmFeJ+qpc3GPR2dTb5JV3M0iYFs1wQc=;
 b=dUXvvWwJKAvQq6uWmeVt/sP9Ihufjhrpl31UQ8D3z3KKex41Kt5D9uVaaxxwqeG91oI1LfzeNU1liFtVq+vVzfEBI271m/UoZY2oKIjR18FQUzBnCargCwlzJ3B6FPt7i9jpv4JG1oaviaQ+Ts/YRDVa5ZcwQxDToywrHYogsxNkxXDTkAifFhZIuiGs5dr44E05DHQkZ4SdN1iH8G7np922jPFWi6WEH/WomO6UpFwaifVSDSJ6Byn5zQwB0l5NqgY6tJ96x5WYOzfxv/gL5LFZ33Hf6tHmfzzfvlssDljmSzBn70cyxEceGOHDWbQVWY931xpqfUCVbZE47P1/hg==
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com (2603:10b6:a03:458::14)
 by DS0PR19MB7297.namprd19.prod.outlook.com (2603:10b6:8:149::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 10:24:56 +0000
Received: from SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291]) by SJ1PR19MB6401.namprd19.prod.outlook.com
 ([fe80::dfce:4bc1:f841:c291%5]) with mapi id 15.20.8699.035; Thu, 8 May 2025
 10:24:55 +0000
From: Abhishek Dalmia <adalmia@commvault.com>
To: Justin Tobler <jltobler@gmail.com>
CC: Akash S <akashs@commvault.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Adithya Urugudige <aurugudige@commvault.com>, Abhishek
 Dalmia <adalmia@commvault.com>
Subject: RE: Incremental Backup of repositories using Git
Thread-Topic: Incremental Backup of repositories using Git
Thread-Index: Adu9yuZ7Kg9IZ5BOSWCrIQPM1Q8FHgADnPsAACq806AAEOrIAABOC8/w
Date: Thu, 8 May 2025 10:24:55 +0000
Message-ID:
 <SJ1PR19MB64010CDB3F21FE91C97E566BAE8BA@SJ1PR19MB6401.namprd19.prod.outlook.com>
References:
 <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
 <2dz3cema2mr5mrlvuroemnyeqyrglxfmusfdz2kaghv6rvj3ro@ti2dhu45fdmr>
 <SJ1PR19MB6401D7734B73C453E491D54DAE89A@SJ1PR19MB6401.namprd19.prod.outlook.com>
 <hanlqq5mma3dvbfq4j4u2zgz5mjegejjg3gjrhyggg2e6ozd5t@354nrc4nq6gn>
In-Reply-To: <hanlqq5mma3dvbfq4j4u2zgz5mjegejjg3gjrhyggg2e6ozd5t@354nrc4nq6gn>
Accept-Language: en-GB, en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR19MB6401:EE_|DS0PR19MB7297:EE_
x-ms-office365-filtering-correlation-id: 94596603-5a8a-4b55-2217-08dd8e1a93d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y0IcgqRHbfU7o1KcqgHwWdmNwbn4wbjxZR3I3jbFhTTpMS66PqNQTZ/Df4Av?=
 =?us-ascii?Q?ndzhJnA+C60DYbARWEkGKoUuIUsM9w0LYdab0afQhz4PBbw0pa7TLraW/ynJ?=
 =?us-ascii?Q?zZ40DDjsogTr5BJS9awb03y6WGQSu64uN/3hvECpOH0XIDgqvZ9LATALwwpM?=
 =?us-ascii?Q?jMQo8h6mh6HZ9DgUBBOTHr+R8JTqtQBbyShnLRaDWAqrfel/5XAPOT/DlmOc?=
 =?us-ascii?Q?L24OJYcDjO4MD/FJ1A+rtBTyWNe72O3g0fPbWsFubFBRy6NCoLT+SNfQ0p9J?=
 =?us-ascii?Q?T+YNMlYVyYaZ9YfMrAjcRrUaK3HvGcvOAWkwOvXArbBkoKRpUK8mNCQHo2Hu?=
 =?us-ascii?Q?d1JR9mz/FnNDX/e2YfETgweJThciAf5vhb2yCQT6t8TSsu/6wH/WBrD61iDE?=
 =?us-ascii?Q?42hxJMELge4PIdIapaV5Zvs+ga/8qgq44aMDjXhznFB6gZjWTzPc3X21zI1j?=
 =?us-ascii?Q?cMLyRauV5SOqNOAxMohWyBqVfLAda2ZX/0/x6Dh3Ly/OXgV4kFFAF1xu1tp6?=
 =?us-ascii?Q?HTnQaj5KXdSnJkzGlybWZ5Vsjn1rswOu7CYJHBXFUM4wPAAUUJ3bht3o+gKt?=
 =?us-ascii?Q?Xxrj8tWRfkl/lJ6ftzFxXlyiFKOQRGCvlguM3ndqZr7IOX4l1SB2YQYdxRWM?=
 =?us-ascii?Q?QZJSIr1B+QaL1e/ClWApVIvCyDv8nfi1H+nhd9qp2/5GmgMW9usACf4TYfSQ?=
 =?us-ascii?Q?MbsEqhTQat33iPOxJGkSO7xdi4v+vD/xJeIHiv11iAtN9tz74Z/+zN7xF+bo?=
 =?us-ascii?Q?PtmFm/9B18gzbDuw+4RAsIMBASn5ETsvT/jp+g4VDpGg/5EdjsHfJX3dEqzs?=
 =?us-ascii?Q?2wQgULyO5ki5BruKoZPBQHfO4G7WMPF3edlXnkKZgsaR8j4e+44XXuZtuqr1?=
 =?us-ascii?Q?A6lDNoqG+3KDsDxHL4ZXQAWu0ian5KFu2aLhI/kebC8ZBu7MYjAQ/LXzl7Uu?=
 =?us-ascii?Q?0fxjYkyHWebnkQ3/xPDMVz8gPW42pRgQD2kYQ2jwc2CV5CKi6mbTXNow1doG?=
 =?us-ascii?Q?QhDdNmMPVh0o/vCwzKzYCoTiTPwfl2hUrvWgYbnkZ8mQt+rNlLZ+34B+nuku?=
 =?us-ascii?Q?nGalhgsY1BVwng9biUAkBnEarTA9BNcpSHp3vDZsesD+Ma8VuHBYpOF5FHv1?=
 =?us-ascii?Q?KFj6m4lo+BIWuGFkqRxn69ki4cekuH8ufflDMrgUk4SUBwtXAJweXp5N9tYa?=
 =?us-ascii?Q?OZJ8x2UIXKahEkvL3zCbw6sNUflb1q53A0Anx15pLbV1PrAv4eNdYM3AMghI?=
 =?us-ascii?Q?P8/DJDiApwup8PPI6P4JlFB1XfwV8G8NZVmRk+OdQR38RgGgGRl0C8XqZ+tc?=
 =?us-ascii?Q?Trfz2Ho6Hm2F5u29Hq5asNRbbuqxb76x+HQVharzvx5Pm99rXuSFIt+NSIWB?=
 =?us-ascii?Q?S16b5UWJBy2IW2aGOBzegp8MyyQ/RZ9XSkn6F1gJ7igCBpB1v5iPZtk7EuIS?=
 =?us-ascii?Q?ZKwaOa+IpFxtFvMtiqfiDy8/+5pHPL/6n8h2K3MbfTZxkl4kxNVIlfbINCE3?=
 =?us-ascii?Q?ML+p5sLy5WmjtCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR19MB6401.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UfTK3iYFI+RuNy3jnt8lQsponRR7qkQy7n8aX+wyp4u59t5alcQMEhHVJN0B?=
 =?us-ascii?Q?LiGykKntjrQ8jthMuiWzZHYl+TXi+m2DnHIIv1zMsmB8G+AmonRji+37byt3?=
 =?us-ascii?Q?vu0WTguY6QSIF6Z8qZ1Vg4QcSsZtzOvmRe1OFLuaamQtZStmd/StkWiXce1h?=
 =?us-ascii?Q?unkloLRRSfcU8FaLV8GnrjjTdv741zJEzpmVp1bYSytbLk3m9EOuyrnFxLwx?=
 =?us-ascii?Q?SHBsQwBMYtg8/UtUseZi22i1GhrCaXqhaKPv+tompkAFDGTLYF1FCkXzlGQr?=
 =?us-ascii?Q?6kD+lLLH2yzkqsosDsngWkGgfDucx2KflvmvOPjjFHkFuZO3h6fgGRDFlfUg?=
 =?us-ascii?Q?jNnlMOTIx58gza93N2tORDUjKudHg38LLHAQzJK9SMrqKBycimSJCJWEAnG/?=
 =?us-ascii?Q?pxaqkSC+lp2Sk5wmi5bjZaGUMxeyCm/iE4KRVY1jbkudFwsZS0AiRT8v5Yub?=
 =?us-ascii?Q?Dv/Q6Nfu7fr04UJqTdAODiu+N3Khx76mzXAeB82pAq1s6zu5DNA/wKNA7rVx?=
 =?us-ascii?Q?0pgu0gFv9dDuG8x0XUq1L6Yvv+SdtkIUrfED7Q10nR6xvQrvbJPeSe/aOVob?=
 =?us-ascii?Q?rSW4SKfZqOE1TXXunK6InzA0JCGAm0dulXa93IKAqhaxH+WvpI5MsssF4UK8?=
 =?us-ascii?Q?kGdXY/dDOSVopktYzDsMv44z/SzkkvNv5baWqUim8wFrTHCcRrbSCrFhvrvJ?=
 =?us-ascii?Q?NZBA3wiZuKKoIy+jmrNCBFBQql9RpfqhyhT6gBmMHmL+l+EwRX5Q38tPRgc1?=
 =?us-ascii?Q?TEIiWWxv2CeC8nh7Kx+xubP+8gvcz91cvx26335bvCW7WUMFtn5W/hMkL65E?=
 =?us-ascii?Q?kK0+2FGC2BV7lscPJUuzscTttFCn6183YlPstiTTwvB+0eTB+oaOVht+42u7?=
 =?us-ascii?Q?Oi8rXVRbqHJrfIWaWhjIDdUOMXV8U02zjUUvEIwEa69hAtqbY3Bun+aXQ1L1?=
 =?us-ascii?Q?83G4JlH8oCdXcwoXduxYVJGp3l/jTHT9p8tFmwlHSVfD2Yui257ZtRsr+hOX?=
 =?us-ascii?Q?e5IZ2zDQ1i+uZDw+07lKcKw2LZW2rCISiiTtKd5eBrhYirDUHpd/kNiLsNog?=
 =?us-ascii?Q?kxtiM2sJAYWuYJpd8A2KxWDT4AL6Z+hVPi9aGCn53JFW/51rrwatMv4GhPQ5?=
 =?us-ascii?Q?uo5IYwLVjTlvmuHqsDBww6R6SkpzSvQTdMerJLBP6dqT2IAqZaRvEVdUWBrj?=
 =?us-ascii?Q?OwZzhHl+KstFyLmJXergwRKjQkiG+sfOcRICKxCWLN2EC3a8VOmq3SK8mYRJ?=
 =?us-ascii?Q?sX5lxjvej37N6lRNdPnA4i5+k3yQw2ZDBfLqnqeFu7KbqLA5cNXmq0yRfImd?=
 =?us-ascii?Q?yKq7XwEAqvuLNhqcW6m+qkXS5ou/aUUlCSNrP7/1xG896hxaAf/xpnDwD0AB?=
 =?us-ascii?Q?KVYVghUcgEBUFVsSydlfC7XqqbR7MmuvvUWVTjKOkFDh+5R9tbvj97x8TDVp?=
 =?us-ascii?Q?w+Qp0RHS5GeMW86nHMYYc+QRMo5V1dfSOzuHh4UNmPgu0TYCYokc2lc6em2i?=
 =?us-ascii?Q?CvRvY1qMIw5zwzcxkJTXh+T78zLsqWYaWswlzukaPDpwIJbVlmjRcs6gioal?=
 =?us-ascii?Q?5SymN23eQWHIl7RgIhHa3G+I2KQJhPuw8aRNpYTh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR19MB6401.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94596603-5a8a-4b55-2217-08dd8e1a93d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:24:55.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWimcaZNuMV4XuAngAtHmnCtKN2eGHVqieQRUkEoMlwwIUy7/A2srqtQgcHvk+155ziVuYdeUwPTCxnKj2jFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7297

Hi Justin,

I ran into an edge case while testing incremental backups with git bundle. =
If a commit is created with a timestamp earlier than the latest full or inc=
remental backup, it can be excluded from the next bundle due to the --since=
 parameter even if there is a buffer.
Given this, do you think git bundle is still the most reliable approach for=
 incremental backups, or is there a better alternative worth exploring?

Regards,
Abhishek=20

-----Original Message-----
From: Justin Tobler <jltobler@gmail.com>=20
Sent: 07 May 2025 02:17
To: Abhishek Dalmia <adalmia@commvault.com>
Cc: Akash S <akashs@commvault.com>; git@vger.kernel.org; Adithya Urugudige =
<aurugudige@commvault.com>
Subject: Re: Incremental Backup of repositories using Git

External email. Inspect before opening.



On 25/05/06 12:44PM, Abhishek Dalmia wrote:
> Hi Justin
>
> (My previous email got blocked due to HTML content)
>
> Thanks for the recommendation. We want to backup all the repo contents, s=
o could you please comment if the following steps will help us backup and r=
estore everything, or we might miss some tags/references?
>
> During backup:
> - Create full bundle first time using: git bundle create=20
> <full-bundle-file-path> --all
> - Create further incremental bundles using: git bundle create <inc-bundle=
-file-path> --since=3D"<last-backup-time>" -all
>       - making sure we don't miss out any time

Just something to note, it's ok if a bundle contains objects that already e=
xist in the repository. So some overlap with the previous backup would be f=
ine.

> During restore:
> - Create the initial repo with: git clone -bare=20
> <full-bundle-file-path> - using the full bundle we created earlier
> - For restoring further incremental bundle files
>       - git fetch <inc-bundle-file-path> 'refs/*:refs/*'
>       - I can't use --all here, that works only with remote repos

This seems reasonable to me. It may be worth validating that the bundles wo=
uld apply to a fresh repository. If an incremental bundle depends on some p=
rerequistite objects that are not in a repository it cannot be applied. Thi=
s means if you have a series of incremental backups, they all would depend =
on each other and one missing in the middle could prevent subsequent bundle=
s from being applied.

> Will using 'refs/*:refs/*' restore everything, or is it possible any git =
data might get missed out?

That refspec captures all references and mirrors them. All branches and tag=
s, along with all reachable objects from them, would be fetched.

-Justin
