Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C281E533
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239640; cv=fail; b=UK79NKJXFeJ6IAPSWBJfQDhcJCCpqQjzu6Llr2ui8aZ1wbJhk+qSfVb/YNuJ+GLVClhso5llR+pS2ZCZRE9lp7mrzdQj7JfgCToeAWGVEf1byWvDJgHlmJ03QcknQvoLbbLKTlDjc9m3ED+A/u+cpJYVtQDSQ25b5Gl2g/XjXQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239640; c=relaxed/simple;
	bh=7pmiiwEgATp6XxTWhvaVVE1xvfi2Ja/WVIRrCNg0I/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJV7DnWGK7Zz9CDdeLhTTyByEPYu86TF97fr8KQLyP/fmxocwI8mIBP2/YGak+ZHcfAXEroVJmiMcACtBf3sfX6XuUnIcS+ZHg3FF74wxyRiCWl4aH6rq94NM6Jq72BAt/TRTD1T6PpRNsUSCZhZ7ZZkZuWFNhO2qg9S8Kp3eQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=nua4BurW; arc=fail smtp.client-ip=40.107.244.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="nua4BurW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtStTpxNtptCtlL5fwvlgNZrF8JL3F3kc3brNxApOh1zcuLjYpwpY8z2Ev4qy47dm9vu6LxGSrotu1UerKOE4RPd8cx4fXHVJwnHijOPcyvVB5QR67PtxL9GoZqv83/EqDCfUNoWB2peWzBYuKOjO0WlnKofAzR/e7bEYVc6geS9GtmAX6luB2Z8KrUjSyi9xS3g6kIO0fxeoYewGNZKePSnQ7ESxEfX/EcFgTDDIHqrawgTSh2G4zxbIU2yGH5TJOjIxkJH1BrYAEN3zr2m76tJ/+PkI6jTV8oBqYYSlrE9pM7e45EyfhTQOBMLTphCSoMRqV3Pgpugr+PujDIqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R943941YkL0HGd0dyjcsKWnhF9fztuByIhZQQQK86Fw=;
 b=h+grUmmRiN/WG4Vrw0hU+99ml0ci53oBn0cC2PJjFsG1M76OHv5VS8jJWlXyeMzxAEvCgiI99jINAkU0GCa5B+m5ErfolHWGJwJWylbgbp1Cv87gnYmucUbyOSPsn7MwfnldnoQN6KMngr4IVUtGd47ZuHUjOmz9CORHq0e5bZuI9gwa38mguHBfY1l567W1gRl4krgDAkaVaY3DuSEIC7QSEjUPlpKSwpt51kl4iODkxU0J2ceVcX0cPkBHOBnqgCeN1TJuY2KUknVYtw8e9jrrBGAFza6Pu7BbriB060+pQ/1oznH8//eRtz7D2ZRxiEeFpSWf0x5YAZ2Y0+DrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R943941YkL0HGd0dyjcsKWnhF9fztuByIhZQQQK86Fw=;
 b=nua4BurW01ufK7iR0X1NkfOCffR3pB6xKP9ooApPFfJExwpWNr//cuMYysW72xGT45iiBup1l2DtgPq9tIAYAxnOvibiIKXoCJ3y1uPuBYUFPOJTYdfbje15oNTGprDn1HBkgFWAz5PW33p9rxK+9q+ZEzYOREp0Hp+m3BrsCTU=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 DS0PR17MB7005.namprd17.prod.outlook.com (2603:10b6:8:127::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.25; Mon, 24 Jun 2024 14:33:54 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 14:33:54 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, "Randall S. Becker"
	<the.n.e.key@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "Randall S . Becker"
	<rsbecker@nexbridge.com>
Subject: RE: [PATCH v2 1/2] Teach git version --build-options about libcurl
Thread-Topic: [PATCH v2 1/2] Teach git version --build-options about libcurl
Thread-Index: AQHaxkC1Q8lpHEETNk+PGGsbnZgMpbHW+LUA
Date: Mon, 24 Jun 2024 14:33:54 +0000
Message-ID:
 <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
In-Reply-To: <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|DS0PR17MB7005:EE_
x-ms-office365-filtering-correlation-id: 2a952f29-c1c2-42e6-2c13-08dc945aacae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C4viMvGZX+SYPZwpX3liuPVdbG+cHNWffA7qDnpszkLJAo8FyHPi/AZ2hZo7?=
 =?us-ascii?Q?uIn3D2CMVHIZuvb2fZ3Srl2kQGXzrr3vWewB6uKrSSrj+iqIC7J59BnN606a?=
 =?us-ascii?Q?x/u/2f147pnP2bsez9NgOoABl3toJ1XIy/y5NIBSe79n9YL6awkpb14Qv750?=
 =?us-ascii?Q?RABA3HZ4bHKXpEKdT39WhDnifvCjkJhkswnipQZB4lQHCjjyzE6Oe68Zdp2B?=
 =?us-ascii?Q?sp4gKSUOIMTBIshK4t+r3Izfwkhp3vLCa2sW2Rveqx4Bsu6BFe3TThZV0WnG?=
 =?us-ascii?Q?lBXnIdnWKD761GN0ehFlIQnvwm00MaLIgAmnJF18F98br4tNsMZpAVcdLzjH?=
 =?us-ascii?Q?GT37sLDvVEag0FPlDm2D65cEXAetyYfo4Aa9KOsBZkLhjck92Hyjyq5Bs2ZV?=
 =?us-ascii?Q?IuyBEpJQZowzLo5z/5DeH+BH/SRW6oWaEwr+X6BYv4VWnaPm5BKK8bWUPRN2?=
 =?us-ascii?Q?2zQR7Ny/fEbtWPbhDiT4p6sjvR824LnNYPcKgHlalDL+fDxAcaPG8itYVsd/?=
 =?us-ascii?Q?C1wnrVGVkX6AFQ5A5nPhyATYD5uWrZIxyitqGLt83ocHiBxRNA53B6DnVLmJ?=
 =?us-ascii?Q?2ea9ifIi0CfB1KyM13/LW/zCLREP9OOctAY5cDGOM6McIL3tyu7lXjYBA909?=
 =?us-ascii?Q?BX18/hN01ikJplMvzrku8J/zn9Usz0BlwXS8HItOJ51ktjJFC/IKEZ6+jkgM?=
 =?us-ascii?Q?3yiTgEb645qVlCu8yrAYjj9iCRnG6s6MoB1DzRHzCHC2mv3XE4LCYLGCMWNm?=
 =?us-ascii?Q?vFwwU1IOegUFY9rIZ4epNcnGXg4BhUw/C5N/QeCxS5nXHgzVuDWGTRslyvS6?=
 =?us-ascii?Q?wq5VJYLNGorecBd7y3EqxREQ6RkWH0a5PTLoWJFL96y8HsVQ/abHfGka3NOf?=
 =?us-ascii?Q?pxnCu47Dbd5kPOkleJ6L+QTeg990qKEkxCunWX+CuePWcpVgi4Xq/TYXNgfB?=
 =?us-ascii?Q?2Pd4G3b9YPSZ9Rk1iRS46Vg0gZc3q8FThZy7pQYuVCaLqsHTfCJu3rs3/G5A?=
 =?us-ascii?Q?TI5j1EEgiJYrEpYJ86gS7/4Yp7gUx6n+MiAKJ+EEY3nn6o+nqNJ/P69yJ/7Z?=
 =?us-ascii?Q?6PXYsQqXAxQnyLW6Hh0z6Z1YWMGANmOk+w0K96aujS09eLJ/izR9MV+sPpOX?=
 =?us-ascii?Q?/WvFmqQm2REpbTa3pKRHbeRChbyzJODus/SeO8k7Wtf2Aa7+80KdHWULxxMK?=
 =?us-ascii?Q?6AnN48tgButu8MsfmOp3Q2A2PmqRuQj5XLysFxckdluqJVrdva233LUl0LS4?=
 =?us-ascii?Q?BolD8/clnj4jTy5/vlMrHFFuy1EuoKp9G4MbUdP32tOvRnqnC8HT0z+ADljB?=
 =?us-ascii?Q?PgdB37Cg1JL6sZbDCBbfHZbh4nQ3hq9FCJsaYqpWE9UBsfL49VDcnSnisilv?=
 =?us-ascii?Q?3jqbnxk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ScWIqKBvREpCA9RSUAEJTnsY1EEnxoV3ay9qTLf9gqN3XNlzbi8nn7u4K3Lb?=
 =?us-ascii?Q?PIh2Y5IKJWYR4uvh9qsdN69LSuUCs+/acRr54w7USigFtOZHCTOvoJTaFq0/?=
 =?us-ascii?Q?c2CEWfyodfAGJwZDSb7o/xnJwRD0oFLxrEUuiTwvxnAnNK7VSdB1WrCe0FCx?=
 =?us-ascii?Q?bf+Q7H9HlCNajEWfiKugkUfYAUJI0lRItBUhZU9Hf4qqWtjK/OZR+1bEnZwN?=
 =?us-ascii?Q?L5lw5iyoSv0AjNQLFqZmrqiiU4sAZdh75SyQh4W5WjHLFz6L/LjdOQdHju2A?=
 =?us-ascii?Q?0eauVCsMJGbKXi9Ao4nGkQOJEtHTwtXefjfzmmRaVld3Od6Q5AKHOReZShMA?=
 =?us-ascii?Q?ePuorGlROODDMUI1jfMixKuQ2HHwceVWW30II9SrHLhB+/cQZZnrSzMV4Och?=
 =?us-ascii?Q?Nl8r6SjRmOgIsEtsw26FVwZvRlgaZ6M56vqH9cuvZwmCosqpyluLKfaNChUn?=
 =?us-ascii?Q?EVonOrlQ1z2dM5P6491QQrmLIKoa+ZSAGv+0XXUHVvqpP6oGcAtaLqJIOaL/?=
 =?us-ascii?Q?VYzSyu899m5TZuCskxdIRw9MG4kqlQSIR0Y9iI4v9BLcoJ1/fXsVAVAqrP4P?=
 =?us-ascii?Q?nUUikZZlEV6JaADcNCgtx2obqd9HZOZ3S2WDKiuLlbrts6bmWaZzcqj6R29r?=
 =?us-ascii?Q?mSK9US+ggQxzfFt1/m8QEK1SmezhFnCndp6B65wY4png+E/Ahd/RAG+0DfI8?=
 =?us-ascii?Q?Ktw+0kQwhQEgR1TCeLN17v4/6QCRGcZKX0xqLB9fWy0hoFnuHvcHZnTrXUVN?=
 =?us-ascii?Q?7V1MLelf/cHgfgU2nVFslouQYbO2toSB0qvtJHkFRFDQHqPu4bgX34a1DzTW?=
 =?us-ascii?Q?QajyIb57kZfPuW2xwPeq+k8ak+dbDM2Ll1nw6voSTqE2OogvZRAnkykVXGwW?=
 =?us-ascii?Q?uxlmvNs1imlRjn3f07vMNlyHaL8v7LkSh/7x8RcQgcmaEQcwmItgEjLpFKl4?=
 =?us-ascii?Q?JtHXusXD73IPEbV4fX/iyHpz0ilMQQDH/+7xWOv7bfhp/j8JaW56JAtTKcPO?=
 =?us-ascii?Q?xezvcUkv7dw408jdJXFuaTejEpwtC4WwyXS7/KVmI9P36MBr8nwZtfNW82m0?=
 =?us-ascii?Q?/8S1M2/2E4+jL7DykrD4wAKyLX9Gm8z9WJNEZgo3dgI9dfPnCHmanmygvp0M?=
 =?us-ascii?Q?ihJrHtDMH1e8alR8PP8V0ZMl96D+L4NYbtt4u3P7p2cb1p1dacarWdOESu6R?=
 =?us-ascii?Q?hL10oapsyfpR6FnASQDhHY3Bh12A1vXQzXhFQ237mhJxDhO0x68DSlEVqkBw?=
 =?us-ascii?Q?d9dbqNoUcZmXlfu5pvs7Q+4g6QwPNlruKn6xJLiI7mgOViKFP2jiuwggVSGW?=
 =?us-ascii?Q?YK9C8iRusjthz7wUpawfqgQoHcD2kJYqzQg2sGumTskFT0YzwSOFdWiTSwYt?=
 =?us-ascii?Q?atqEHNd3bukJhcBxpDgxNUIY8spHo6sPBkK3/qatYaBbZHx15gmprjguBv6c?=
 =?us-ascii?Q?J+UjOn5OVRxPEvH2DpF6M20hmPjDUunrKNdmmQZgvqx39TA1KDXbeWbdzwrA?=
 =?us-ascii?Q?mHvUTL94BVIDKI6MvEKO5Gy81MEEk56pCmpX874n436GU3ReRGrC06ve0keH?=
 =?us-ascii?Q?DfswNQeT5i/PjuLCR7Q2ZKoqBmnb8QiP2Wip07kFAWjXJvms1hD7/SGgxvWE?=
 =?us-ascii?Q?h4hLPXhjCFIGFNDat3JjMoDFviIAa3WL9j0mSbzDIAYgy9pUqqnGZbMFcKbR?=
 =?us-ascii?Q?KHoHMw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a952f29-c1c2-42e6-2c13-08dc945aacae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 14:33:54.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5uMkC5JgcxWiJeMoquAz9mOR+WRcg9r95HnGoe+3042hSMEjLQjLWoFOP2Vy0AL4oIqYFdKq0T4MxAMB7HNXiWesOs+XepLAfYu23+awJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB7005

On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
>On Fri, 21 Jun 2024, Randall S. Becker wrote:
>
>> This change uses the libcurl LIBCURL_VERSION #define text macro. No
>> stringification is required for the variable's use. If the #define is
>> not present, that version is not reported.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  help.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/help.c b/help.c
>> index 1d057aa607..bf74e935b9 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -1,4 +1,5 @@
>>  #include "git-compat-util.h"
>> +#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
>>  #include "config.h"
>>  #include "builtin.h"
>>  #include "exec-cmd.h"
>> @@ -757,6 +758,9 @@ void get_version_info(struct strbuf *buf, int
>> show_build_options)
>>
>>  		if (fsmonitor_ipc__is_supported())
>>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
>> +#if defined LIBCURL_VERSION
>> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>
>I am not sure that this is the most helpful information Git can provide:
>It reports the version against which Git was _compiled_, whereas the versi=
on it is
>_running against_ might be quite different.
>
>Wouldn't calling `curl_version()` make more sense here?

I think the more important information is the build used. My reasoning is t=
hat one can call run curl --version to see the current curl install. Howeve=
r, different versions of curl have potential API changes - same argument wi=
th OpenSSL. What initiated this for me (the use case) started with a custom=
er who incorrectly installed a git build for OpenSSL 3.2 (and its libcurl f=
riend). Git would then get a compatibility issue when attempting to use eit=
her library. The customer did not know (!) they had the git for OpenSSL 3.2=
 version and I had no way to determine which one they had without seeing th=
eir path - hard in an email support situation. Having git version --build-o=
ptions report what was used for the build *at a compatibility level* would =
have easily shown that the available library (after running openssl version=
 or curl --version) reported different values. Otherwise, we are back to gu=
essing what they installed. The goal is to compare what git expects with wh=
at git has available. The above series makes this comparative information a=
vailable.

>Ciao,
>Johannes
>
>> +#endif
>>  	}
>>  }
>>
>> --
>> 2.43.0
