Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2113.outbound.protection.outlook.com [40.107.244.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E631152511
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828169; cv=fail; b=BWY6rvYpDnMlDPCXQL+r1NYG/l+kqKRpiQhx02l7mee94GkTXfAMDZIFsQkilLRH34OZeE0+AR1pLvBch0uqpoloy0ELX8T1Sv9djBfEE8zYLKsRFlB6n9MkX2zO4uTptAj8/oT6GA9aAy3kMEVs+p4TWfkP237zX+tSdJEOvc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828169; c=relaxed/simple;
	bh=FA/YswZP2K5xn0gjP+JSJf1wCMJFqiNmJ7h4HIL2BSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JtdWnmn5IvxDriTO4zUy56+YdR6qox1R4CT5lcYyUCzkBsPVDTHakzH7pJtu4kIPIOF29jd7H6K3AFl2SBjBX4CS/5FWLJNOPdey1ZIVlLWB5v8kubtByPaSFLTPFanbdND6PhZGcreOOsJb6Mzshxls9YPFyjqE46xbabAlTLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=vi7wsIa+; arc=fail smtp.client-ip=40.107.244.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="vi7wsIa+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce8rRYGAmoyeCgOhQzsv4vvAWB8rEIWCVT+qNMorcpJK6hqzMlfRE395LlU8pWTtQioPquCt4ybRvPoRWVYc+OFVhK8OytBJ7iNOgOjUOLWyf2RLi4bje1DqnY8X/5Bs5YOZvWeuXs4G6JcHAEgOCabULFBVvJz0x1dkxXhVEN7QUCpC8hMXhskS+qnp6ldLUTm5zoIMdwv/y04TO4tZPiLcTsBzTKqx9nDcFOYFQvgUhH14n2jF78C2MD+YpUp/XOlK4B1MEd9BvXK72QGR0N4fmqMuDp+nSSEd4mF5c5/PCOI/1KTqC71HMp8RKoBlCEh/4q1YlRP8RYrvH2fXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvhZawyoKu2/CstRSgIW21DuKUqg/EfU2RBaXLht1ps=;
 b=NToxz7ImZXhtgcj2aHJavRvw9D/CotkQLShRsvFYNzUwHgQlqtGRI/4sGT2n9c8S2it8ma+e1R7sieus8yAlf6+YoiSCI1V/6Yhv9iDYHn1j/EeQBivS+LiuubgFqHQYa6dA8ssIh2hEpls8KH36txeyvnvBIPFkyjGAkjQRwNRx2/ZZortVCxIhdyVRD612SjoLrg5xUKlbQOb84Bns3kJBikjWwneMmgyecURATgWutsYtRE74QXXbIHLoaYot+ROhzyLBXx1MCyRASJ5enFf3J07810bj5gSxCR1EgD4pG0vkDbkJuS6LXt//ON/WMrAMtUngzkAQZlw5YXt0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvhZawyoKu2/CstRSgIW21DuKUqg/EfU2RBaXLht1ps=;
 b=vi7wsIa+AlJGWMoxWTlPItQyPl3IOu9XE+VC473FTp1vEGfhF680Jc1Own1SY/y3BiUINu+YaW2VpVVUp5KjIwLctMOP32px3amdUZRK0stj1I3yI+Rs9UIvtWmMkK40GLwmZOVfkt9+P/8wVj8CT2vfial2eKkhyhNnnVp6zAk=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 MW4PR17MB4257.namprd17.prod.outlook.com (2603:10b6:303:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 24 Jul 2024 13:36:03 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%4]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 13:36:03 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "Randall S. Becker" <the.n.e.key@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
Thread-Topic: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
Thread-Index: AQHaxkEOQNNXjGXhfEu8oPtEokiJvLHW+qHAgC7quwCAACmz4A==
Date: Wed, 24 Jul 2024 13:36:03 +0000
Message-ID:
 <DS0PR17MB60312EE0F4B6679DBEEDAB42F4AA2@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-3-randall.becker@nexbridge.ca>
 <80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>
 <DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
 <0bec87dc-d852-4133-1e6d-11e9a1c5df2c@gmx.de>
In-Reply-To: <0bec87dc-d852-4133-1e6d-11e9a1c5df2c@gmx.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|MW4PR17MB4257:EE_
x-ms-office365-filtering-correlation-id: d801161d-f208-45c5-4872-08dcabe58ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kT1p3GZp/kxUW+x0sq0/mWHCk+zkajMxiM6XsknzXHZc+80jRhY3u9TQQh1O?=
 =?us-ascii?Q?Hmai147HLumQHnn52Vk16YlzoRdUh0agyb7lluBFDTcZjogZz+JGOKQuTz9c?=
 =?us-ascii?Q?NgSoMOHMfB5TYrZn6DJLoxNlc8lLKJIZfvFW+6bNAhpx79iP8p/soHQVNYw5?=
 =?us-ascii?Q?aE7EDQMzC6nLNekdP82RhF023ouHsfAP1yqJ21ILrH+eXQBu9G61oq7EUCaP?=
 =?us-ascii?Q?j+jkVnczx3D2dSN/O9gXYMKCXBDwfxElO1HvfpPB8fCNstfVCBgBpf4nYCCV?=
 =?us-ascii?Q?Hby8S/OOvix+dng/psN5pHA2TFtDFprpmwJN/goZ0VuR0nwACF+vmj9xvyLM?=
 =?us-ascii?Q?GlomlbiyD5W+cSD6MouXSdaY+8pOYBQ8/jz0u84IwW8fjQVlQMhJ1eVgjAeA?=
 =?us-ascii?Q?4rk8XBUKrfIOwfKH9RxJTbFNJAf47HJrWxpuByLZXqwkoHLct0MybrjS7217?=
 =?us-ascii?Q?gUcfC18xE29Yq9q1MhH+7qnIgSsMOLo4X+YqJBjzrU8Y6Pglf49cVx1v0EJ9?=
 =?us-ascii?Q?xIU+mUvT9gVzJ4V39bDv9kkvMVuOe4cPeG72JG+xjh+i991A6UPXOGvi7Ac6?=
 =?us-ascii?Q?GIo2mX44XhTYLbZX1Sl1Vh73oF4VXERK4CXhxDG8uXq71J8ksO2tRW0nWTIa?=
 =?us-ascii?Q?Fy35sDbt+x3l36gde4FIW+UTfiLF64UdC+NFsuGAQPAlaFs9x571K6G3DKyq?=
 =?us-ascii?Q?aLeB8cWM/cCH1GNDnxLPa8bSP+2zzrUhueYfNLHSmU/kIbX/52LCugSOqdmo?=
 =?us-ascii?Q?2ifhWKArg4TU1d2MwUwmsCxgRMK0V+fNAZFLNGyCoX57leYDIIxkLztDdE31?=
 =?us-ascii?Q?n3B7x1AhmMypAFdEB8SNYwkdJvckLBPph1CBbkeilOclTmuGbH14akLOlH4z?=
 =?us-ascii?Q?A4lMijr6G3zjaRIivPV9sgJRckEQwzDH3ZqtKm6+pjepkVAvabacCg5PQh1r?=
 =?us-ascii?Q?UlYraiyOtP4G3Yt9vwty8XckDq4QqjyIO5AaVc8Mg7sbfMzTa5mDVRuQ1jGQ?=
 =?us-ascii?Q?KGnS0UjCopSzjCAkeKtwfi9YUIlCfTUT+Fe8jlneJkAI6dBO4jQ97DqfTqAJ?=
 =?us-ascii?Q?7FW7oJ5Gq6C4+Yvgc+tqgo5NSVEJ2cLwHSUT/Mep9zDTBzoO3gIcsIGtr8UO?=
 =?us-ascii?Q?Fr2vSKbxPkviCgF8th0aBz2yvF2pJ34XCSRypD2qNssnxP68EoJRAaf9Cx1j?=
 =?us-ascii?Q?doBeztzlSkIUDY+L5wZr+fFXiQWGHsPpfGDdcymm02We915yQVpySixD0uH+?=
 =?us-ascii?Q?oiKe96C71m6wNtVKNblv17fdDtiIWkxqMLzDEEbB1q3qeDSU8XNmCbcuSdgo?=
 =?us-ascii?Q?R+459oAh5/FwDdfJGFMQ1QLwjDayfqhf34HGj0kAiubVW1VUKE9Nw8h2DUUY?=
 =?us-ascii?Q?phebD0ABhay0DOtoU4D9LmdXhVppwr8ZQBkj7B1/Uxu1d6f76g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9pYfuE6YikCIdR7+/hVE4hMiZhJmC6DrbtAseDufsogIrIbYww+sxZ1lcM7C?=
 =?us-ascii?Q?n5D0hq6H3rEawEtXfe93Jhw8YJZ2ckLS83JmHl1gXFmB5J+4nMpmUKc+ME42?=
 =?us-ascii?Q?v1QROm0M7Yi1V741XZ/NsXDFdkcmjL088D0g8dGe6F8UqPrIum5aByWnq3Lm?=
 =?us-ascii?Q?nPOWRX/LlndRBVJBrLnCOQyJLAXG+xA6nGaXePMy8dluZat+gUH4AoX7TyeO?=
 =?us-ascii?Q?89QEvXbr3efRHUaCBOsEueO3jvq8zOhP5tlbxFgnYeYSacsguhigF1jyxY7+?=
 =?us-ascii?Q?gOY18xjENn+cfvG23yF+lHKpcuqyLtewFCFycqIzlNhgX7JpyRCtmblrpFwk?=
 =?us-ascii?Q?bjAhF3GaQ1KjFjD+GsAHx5RWajb2wKTA1OkehkWHmyuia0Gyn+ytLzWNGFud?=
 =?us-ascii?Q?5s2OEcjMGrN+tVPIBJqX7kazFi40nzSr/Lflzn7TVM2o+un6iXiIRCXuNF/p?=
 =?us-ascii?Q?JzEMpvzEjxlVNShjNBOHp9f88SKVADoslG/PwEm4fPMdHOHEigQr2QwAIqwk?=
 =?us-ascii?Q?TazG18RfCdN4/bUHp/RJDKEhPzlU4zhjKxbyt5U7OjSY+P94u8OrKtfMkkuF?=
 =?us-ascii?Q?42TKV+FsnkJuTy8xHJlh/DxFaFGQwhrc/TBIThW9wgT76ASHvEwVE9t0r3fi?=
 =?us-ascii?Q?ODCzjUHXutNvXgn+fMpNkYE2DvJNHgtzJKq08Y1Jy8jQ1jDSuFo9elppX7wc?=
 =?us-ascii?Q?p8esLGmyWFk5YUrA2nlgRbIBn6OEIctMMX9m9F548jTD65gCTQ2AaeEQJ4mu?=
 =?us-ascii?Q?aqhRijgebTDhmob/fB1ieBx3DXe+Y/XThZIwIS5xT/+CB8Mm5X9ejSkgJN5q?=
 =?us-ascii?Q?z8U1EJ6famUjPjedhnmxymtWnH3P/Zv+LG6nfQ+TMW4K4hos+sJIfm4fD8sv?=
 =?us-ascii?Q?fglLUkaRM9vbQJozU7x9AokEPtzRLcphIVr7zke84wdVxbqyjh+5VehA/6+k?=
 =?us-ascii?Q?ftBwF5bZiPYdbjYI4RjZ6W84zvXvYRwgLmgpwLn8QraA7dI7AcOGuuwWyuPB?=
 =?us-ascii?Q?I/foYr3xaGYwDijiMnGGeRRsfb7nKC+l3qovlZ6EU4E/oJVieoS8xNOX8Snv?=
 =?us-ascii?Q?4XQTEdpEx4BXobIEugeRecD8G92BLKDQpRKj0HZjCw6+9GpWtLBbU0/Atd1a?=
 =?us-ascii?Q?+CXD4oTp5i65oGeU7FlvmyFKNUbuaXOe2I94eYtTP0wkyXDrhSwxQUdAhrPe?=
 =?us-ascii?Q?X7ovWBq4UCrOqwxVSRrJOhuisbxj53dNe4+NLILEiODPenraZICyFJfk+YgR?=
 =?us-ascii?Q?CgH6WPTVxUT+W9/2JcG0XMrh8foe6WdXqcVr62/wmCyL4K3gYxMJDoPh4MGW?=
 =?us-ascii?Q?u79IvXJuR+XOcfI//AtgurrC8DQ3zhijC6BzgNolh7h10gY6+n0eIUVsoi09?=
 =?us-ascii?Q?zwBMiMQJsCuPNfIihVR4BlA5x2F4mWs1P1OzwKMDekBtWZZ7KRTCtLP6pqQT?=
 =?us-ascii?Q?NEuUf9suvflSX+dUBbci2l+l8uzgPAezqRCvF/HlpGsyOin7jYRaubUetakF?=
 =?us-ascii?Q?KJ6QSiP+0qaeihvn3N2JDB2E6QJRkPN788dd1XXnodZf9xADzikBnkKaWUIv?=
 =?us-ascii?Q?uhyocJ/pCXBV7ZlNR07Ybd0hYyt2Y2Vfn1iYcEbixKTP7xtdudbWhQ144Y/T?=
 =?us-ascii?Q?0I/qPN5w0Fj9zbiV/2CfUExg0Hh6m8ZJALbAqqqtW0SkEXtWO9DQwuTaI72B?=
 =?us-ascii?Q?CzK9lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR17MB6031.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d801161d-f208-45c5-4872-08dcabe58ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 13:36:03.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGkAkjDpJR4e2bRtxLUR1eBty2BJ/fNjXQF7wJflcZ7aAKCoa6yRSe6YiNhBX3QVU/uqsF0biNeP82kVfWqs1FHCsNuyXa9IbUAx0gA/jwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4257

On Wednesday, July 24, 2024 7:02 AM, Johannes Schindelin wrote:
>On Mon, 24 Jun 2024, Randall Becker wrote:
>
>> On Monday, June 24, 2024 10:16 AM, Johannes Schindelin wrote:
>> >On Fri, 21 Jun 2024, Randall S. Becker wrote:
>> >
>> >> This change uses the zlib ZLIB_VERSION #define text macro. No
>> >> stringification is required for the variable's use. If the #define
>> >> is not present, that version is not reported.
>> >>
>> >> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> >> ---
>> >>  help.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>
>> >> diff --git a/help.c b/help.c
>> >> index bf74e935b9..f378750af4 100644
>> >> --- a/help.c
>> >> +++ b/help.c
>> >> @@ -760,6 +760,9 @@ void get_version_info(struct strbuf *buf, int
>> >show_build_options)
>> >>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");  #if
>> >defined
>> >> LIBCURL_VERSION
>> >>  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>> >> +#endif
>> >> +#if defined ZLIB_VERSION
>> >> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
>> >
>> >This reports what zlib version Git was linked against, at compile time.
>> >That may be misleading e.g. when running with a different version that =
has a
>bug.
>> >Would `zlibVersion()` be more useful here?
>>
>> Please see my comments on the libcurl sub-thread. Same logic applies her=
e.
>
>Let's summarize the part of your comments in that sub-thread that is actua=
lly
>relevant here, okay? Here goes my attempt:
>
>	The scenario of concern involved a customer having installed a Git
>	build targeting the wrong library version.
>
>Does that sound like a valid summary?
>
>I am quite puzzled what exactly your answer is meant to tell me here, thou=
gh. Is it
>meant to say:
>
>- Yes, it should be `zlibVersion()`, it is the version that is used and
>  that might cause troubles after all,
>
>- No, you want to continue showing the compile-time version, even if the
>  user might actually use a different version depending what is installed
>  in their setup,
>
>- Yes _and_ no: both versions need to be displayed, as a discrepancy
>  there might explain reported problems and could therefore be quite
>  useful when handling bug reports.
>
>In other words: Please understand that your answer to my question left me
>wanting for an answer.

What I actually proposed was splitting --build-options with runtime (some r=
epresentative argument). This would allow the headers used at build time (-=
-build-options) to be reported *and* the runtime (probably) DLL versions (b=
ut would also report static linked library versions) to be reported. Both a=
re useful from a support standpoint. However, the --build-options argument =
was intended to report an invariant set of values used during the build, so=
 I would rather not conflate the two distinctly different semantic values.

--Randall
