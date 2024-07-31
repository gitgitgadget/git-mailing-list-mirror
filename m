Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9F1BB6B2
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440042; cv=fail; b=A03wj68bJP9kJ95yi8CmrywkIxtf7D5GtLwX7gXtDqQuGE4xrXiebE9B7b4vzboF6Ql84u9O6ubhu4qFXTLBTIicvThGlPcqHyAqZRrRtsG+UPb8zq8lEFGzwL7Dv2o9so8d0R8VkUh08rvxTm+CWvhQCaUz1zLXriw8MRUwnAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440042; c=relaxed/simple;
	bh=UCrPI7C6kV+EPNACsaYfvk+zXc7HOXTJbXBUQ5Kf3dg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cv/2n1YL9W99IeCZRo6O/x0ulcXFhKMs0ehT8Uk/jonJWRF+h5pWkJWw01WSbJ2WEnduPi+/U0y7ULw3ZQcqL/tC/9FeubzjCwqy/4zr/0P5jAaHHE8kNgBvf9DY3d12GT7qtRS3BPU2PK7dk+6vIpCoUaH94ZT+AdTCgyjZY5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=NCFPF7XE; arc=fail smtp.client-ip=40.107.101.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="NCFPF7XE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhWPd51e9H/Wg03ejqqvnSibx046TZKlVj97vEJRKofgPetE5lR7MyhxEHcojA2eDkv8PyR9cyHUkATybHnUtiMkxeVg7xQnYHcCBgwQWiMNjesX6iTzhbeWI6FZZ0JkEceB+vg06d56J62t31DtJdWm0IkBn84+0XDDoKf82Yp2BSkLGhaJc3hSMzrOWs1w+0+YeLqHukPN99OUP2LwAhwAi7Sua+6yoGNmF0vvRSI/1ohBk2HKz+0SOfe9y5jl80Fgd4lELZRrltFO4KbkNYCyw9j/hEgsiBAzkBuuHGl0vgsB1jO3C+aR8KXh73g7PilfY0uZJ6u7/B0PKTASWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2B5HU+IpAR5lPTthHgHibYsGc+ROyoMYjV8Xm/zhf4=;
 b=ToldaMJx9qTIGN2TABBfKWgBnn5dSAQpvv2CWwhglEyzX2laNllUMLvfwus/4JEvmaumoZflb94Jh8dy5ZP1L8fw++mQNAth7eP3oBWpRzLh/ttaVWzkW5+5Ab7kal+0r2VvLpNjpUuCqsi9nOD+TEi/gwaWiV0k2pWEBQyWreCjZ4VREGDSZwDXIQPKXRhw1pKrifv/itD0/ski8ljfH0NEphCSRprxZTh9AgPrO2C+2Zpnm/elwECqBu3Z3KX9otfQuF+CT1riznvAcY2CLToNG/CpEQzhTfVYjvg3AksA5DsoWyEfBIPQCkQsuqOC8k0d8ujKoKw0TlGrmoHb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=alum.mit.edu;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=alum.mit.edu;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2B5HU+IpAR5lPTthHgHibYsGc+ROyoMYjV8Xm/zhf4=;
 b=NCFPF7XEX//N3/2mBEd7SKl6hPsaoYGTYwhbg5MI4Uh2wDNwXTWI4Q+IJ+bkPD+xxWLoST0Pi9PQlePftcmlhq7ASs55hzh7PxqWd7CFiFBVXUrXpx1TgGHN60PLkdSJiNcTSfcpBQqTgOtpcCCxSP7PKltFuzIt1mRpW/UvN7k=
Received: from PH7P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::12)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 15:33:58 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::6b) by PH7P220CA0043.outlook.office365.com
 (2603:10b6:510:32b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Wed, 31 Jul 2024 15:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 15:33:57 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 46VFXgPS022701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 11:33:56 -0400
Date: Wed, 31 Jul 2024 11:33:42 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH v2] http: do not ignore proxy path
In-Reply-To: <20240729200953.GB23714@coredump.intra.peff.net>
Message-ID: <3aff1e44-f6eb-b7d7-2bcc-00be8256fcfd@alum.mit.edu>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com> <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com> <20240729200953.GB23714@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: db2bbe86-5e6c-4816-c7e2-08dcb17631f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|41320700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6KCcsgv/lkQaLAMoX6WVMgPi51J5DgKbHxtxb3kpU/W22/f6sOud52lovn9?=
 =?us-ascii?Q?cos0/tRL0rjWnwsWBBZT87ut9KVGPFghPcic9q11j8stVd77C81fF51loa+E?=
 =?us-ascii?Q?RawmnS2TgJlz+uWwkUsvY9GWYjDRJh9tG7kqdMxIY9AYAw+nL+UYp6qpy57D?=
 =?us-ascii?Q?4y/JuTgTWy+ON2R4lltV+6qBclq5BRGIn87W4Xaw8hX9pr8TQkoMtSNNSmAJ?=
 =?us-ascii?Q?SlAsHqxLF1QkjnA+3H5HevOwYlm8iVpeZUaQosj03Q16ivC1s2sngac8doe/?=
 =?us-ascii?Q?R0oDfBegjyKNepbCcPvU5kbvASGjanbNKC6idukgxPHrdwk6LDshdKAyEmgm?=
 =?us-ascii?Q?IBjbMDgLlRsWPy+M/pA9eY3BRxtqGTA3cLUpKuljOuuq343OF7mZBAATxa+c?=
 =?us-ascii?Q?rRxyRiyWWxLLNCTrX6cN0tiAn0tdemiSYAu7cekhDLOpY7FyHEqieYCh+aNs?=
 =?us-ascii?Q?4FBlIC0xDYTnjVWaX1hGPqmQXXqO60srfq953LWnL4ay4nYkolIvoBscBFJu?=
 =?us-ascii?Q?WTG9SjUilPyAhg7PBV3OylUo5KQL2dBpIDqldts7GtilRUF//8UCfWWsHJzJ?=
 =?us-ascii?Q?dmQfNaVwnJnCZqhoeQ2O/YOAAGuXmCG3DaZVr38oNLEbnM6EgxzC64opMcj+?=
 =?us-ascii?Q?8WBE2Wfdez2oQ7O2SJSZ+ZIJI/cqAHxiMO0l9ov5P4rGIMGLPQf5Pc+5wrmY?=
 =?us-ascii?Q?OSu+/wK3urPiGCze4A27BU7ZyM7YPgeoo/O6e9gVFJPOI59bqoTlF9I2YZZC?=
 =?us-ascii?Q?eAuSsdHVd1rdo8Br626r0Q+g/VcYKubWrQK7aIjyqy5RGECsa/6FeSIf67qG?=
 =?us-ascii?Q?ePCpDIQsr+3/jioVCOlGGa6NeuE/R9iCJ9+SZLgBg6wnzI3IH7P9GytnPl0O?=
 =?us-ascii?Q?WDsUPgRQ215e0JHTCJcqZyRaPDyVpsYZjz/oZWsZhFti0EQSTT+8SbVWtGsq?=
 =?us-ascii?Q?kGNql/+TE6mAPaAZnaDi20E1gR5OqNP2+ZaSAyoWu5Ryt320u3o419BqPBcA?=
 =?us-ascii?Q?nYssvgasRaWx7bcqa1HoTZ8dfrgHI3DDpFd1TN2b7R7Mh0eHvk23AM4uUtSd?=
 =?us-ascii?Q?Viu9YcY2inr8hOK3Jp09GLs0w47LX3dEbjO4C+Wtm03nO6jTRI/5NMBRcHFf?=
 =?us-ascii?Q?shItQrGQROa5iaYv9r5MDLvyEPzSeM4/HlAZtlpCX7L69liIa9sNUGS5mSM7?=
 =?us-ascii?Q?uhURLz5L+TI0RkInRt/GjcUWfk4RvuSFx2DdYXf+ZtCaAAfJSjbz5EfEA4F5?=
 =?us-ascii?Q?ducesKbumaf1GtFXxw+B6M5VMw3rlHLOWy+FCbiKJR5rKC4FOgrMLRtWa6ON?=
 =?us-ascii?Q?+cNUFXiDv52jRLaNnoetXISXPKSSMf4KW2IOWqUoFzVT1yZyzNER+k3PGYbM?=
 =?us-ascii?Q?xX4r0Kiokk2QkPR65STdLZLmGQwkrZfNzrEGAMndceqjOdJCuAaSA5I+Zh6Q?=
 =?us-ascii?Q?x5aO/CHWzv3oQvV6NIlWoMIQ+IIzUuc++qjCWz4r6mvLgdYfH5rU+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(41320700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:33:57.9131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2bbe86-5e6c-4816-c7e2-08dcb17631f8
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

At 2024-07-29 16:09-0400, Jeff King <peff@peff.net> sent:

> Looking into the curl support, I did notice two things:
>
>  - unix sockets are only supported for socks proxies. Is it meaningful
>    to have a path on an http proxy? I don't think so (there is no place
>    to send it in the "GET" line). But perhaps we should limit the new
>    code only to socks.
>
>  - curl says you should put "localhost" in the host field for this,
>    though obviously it is not otherwise used. Should we likewise
>    require that to kick in the code?

Sounds good, I've added checks and tests for both of these cases.

>> @@ -1265,7 +1266,24 @@ static CURL *get_curl_handle(void)
>>  		if (!proxy_auth.host)
>>  			die("Invalid proxy URL '%s'", curl_http_proxy);
>>
>> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>> +		strbuf_addstr(&proxy, proxy_auth.host);
>> +		if (proxy_auth.path) {
>
> There's one gotcha here I wondered about: we usually throw away the path
> element, unless credential.useHTTPPath is set. That only happens after
> we load the per-credential config, though, via credential_apply_config(),
> which in turn is triggered by a call to credential_fill(), etc.
>
> I think this is OK here, since we have just called credential_from_url()
> ourselves, and the earliest credential_fill() we'd hit is from
> init_curl_proxy_auth(), which is called right after the code you're
> touching.

Yes, good lookout but I don't think this is a problem either.

>> +			int path_is_supported = 0;
>> +			/* curl_version_info was added in curl 7.10 */
>> +#if LIBCURL_VERSION_NUM >= 0x070a00
>> +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
>> +			path_is_supported = ver->version_num >= 0x075400;
>> +#endif
>
> We've been trying to keep our curl version #ifdefs in git-curl-compat.h,
> with human-readable names. But in this case, I think we can ditch it
> entirely, as we require curl 7.21.3 or later already.

Ah, okay, that is good to know! I'll remove the #if.

> This will be the first time we check curl_version_info() instead of a
> build-time option. I think that makes sense here. Most features require
> extra information at build-time (e.g., CURLOPT_* constants), but in this
> case it is purely a check on the runtime behavior.
>
> We perhaps could get away with just letting an older curl quietly ignore
> the path field, but what you have here is probably a bit friendlier for
> users.

Yes, curl has a nasty tendency to quietly ignore a lot of things. I didn't 
want users to be uncertain about whether they were using the feature 
incorrectly if an older curl was the actual issue.

> What if we switched to socks4, which drops all of the auth bits and
> supports only IPs, not hostnames (that came in socks4a). This is the
> shortest I could come up with (only lightly tested):

Ah, many thanks! I like this much better, and I'm not proficient enough 
with Perl to have written it myself.

> I can see two paths forward:
>
>  a. There's been recent discussion about adding an option for Git to
>     report the run-time curl version. That doesn't exist yet, though
>     "git version --build-options" will report the build-time version.
>     That might be good enough for the purposes of testing a build.
>
>  b. Write the test such that it expects the request to work _or_ we see
>     the "version too old" failure.

Got it, I'll go with option b.

> If you usually see success, try running the test script with "--stress"
> to create extra load, and you should see failures.

Huh. I never saw any race issues on my machine even with --stress, but 
your approach is safer so I'm running with it.

Thank you!

R
