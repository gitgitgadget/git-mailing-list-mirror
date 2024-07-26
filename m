Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9046026A
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033816; cv=fail; b=b1xd8jw9B4TmHJ+YBnQ+bU6eUpQX1fM7DLft0oY1lk/lFaPp1yYiVeGnqf367jWTftwxWyOrvc0uRF7kaax+TtTwRbjB32QxN5TGXXkz2kn0WqpNTqvtgwuV7Xmffe2WfbU8zq8iVJ+EHtNHsshrRnTwepJh6+VUR6di1uihl4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033816; c=relaxed/simple;
	bh=6+wRVn5nRUyAlGsGiN1MZ0AcDyHaGE19oQoxPHJy1xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K6WY+465LsM8rgAyGFFIwd6ECZsrEge5cHTkwdJMJZKBfiKOBUs6MjyQdS4j1eS7FC1f6qG/XyCpf+EPVJTj3PpKOTiz6uY0niGj/2NAtbiYfTS7XeCmR8v67gFsGOcJJVtePEKQ+o6qmxMOdjhKRy/UyzQTIYvqFXdlqxTK7Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=jYHKa7lH; arc=fail smtp.client-ip=40.107.92.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="jYHKa7lH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKxlmglnPEnOOb25VpqKDzShpn6GkXHXp0AXULN8IfUDDu9cXh/5JX3IwgkqC1lh0uSYrZye1xGeodiILc040TXSkH8naJUPRnEYos+cFX0pBrMAp41R52fMltysyHqhWxxQ67QyFme3drf2rieI0BPG0Z31gkO9DQ7CtUkKKgsm2f2Fpb+RLBU92pAag58gX4eF+h7LrQ/bfEHKqgCnrbeAQm4UKZ2H6nPiGerokqtbONgPQtaNw+FpmPBp3A9d9Gq5MXSjIku4QKH7UGp2v4+dzUXW2/PRx498RhMC4K/AckmcUJH/pfQ1fVNTd7/seJyp/4nXyojITYDXdGZWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfPIN+U0jHfLWJ4Y3UWUrodD7Pn+bbM7S/mnCgJbsvY=;
 b=KFUh4nO+eF0hpgHIniHG6nZQcB0Zw30NUTWporu6mOW8XonrrQNdRwi7NuuUaFe6yc0hc4vhtXl0TTmw/dNvaYKeTRq/7Pblh+vECw8ohMfWK5U4KM48clewdUlc3/WPLuia74850lBnwlYKUPYWk4LM4xJ2MNjXDcxprV5y0MbdfH/hy9v5SaiOCUlV1TtG9jOhrUKdxFrPpnJE+4jo3Wh5jQosd3Ye+oGzB0TCjCcwk3iHHBk1AVMj5m9414H1qCeTHF2LuWrVz8n/DeBm4uBSOXBp8Z0zERRUgVriLvze4F7HzrnH/rEviszF6otqUTN4ZMb622amak7G6Sxw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=alum.mit.edu;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=alum.mit.edu;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfPIN+U0jHfLWJ4Y3UWUrodD7Pn+bbM7S/mnCgJbsvY=;
 b=jYHKa7lHASAlUUCKkUo0S09nEd2TEpPaulDVMDqzNiSAzP+UKBV+ntOHsApdzSUw07SW9jo8VGt9L4LGs+RimppJoVA/nAURRxOzH/hgkFWm0rYWwq/w4u5TTlz2OI0ydviiTznH5ncbFEuNSmpyUKq3A47Dxuo31Sc2sYdyx4Y=
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 22:43:32 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::e2) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Fri, 26 Jul 2024 22:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 22:43:31 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 46QMhTge012881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 18:43:30 -0400
Date: Fri, 26 Jul 2024 18:43:29 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Jeff King <peff@peff.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH] http: do not ignore proxy path
In-Reply-To: <20240726211156.GA714986@coredump.intra.peff.net>
Message-ID: <4f962eaa-d12b-d250-dd93-a1673af850c6@alum.mit.edu>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com> <20240726211156.GA714986@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: a17aaded-9a61-4085-66ab-08dcadc45fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|41320700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9m4UWD6R84TDYNcVOm0ul4amy87nNnxqOgKb3KE0l0k9LQsz0OKGfpGIsn6?=
 =?us-ascii?Q?KaVGNEalkqw87mEcwAsgDjBSsEipU4B+/2L5R2ACApT8AyPDlI1IhcnbIYPc?=
 =?us-ascii?Q?YCR3pJlLpF2gSLhfzadk04WkKZXW1W8z8g9GtHejWTxAftkVPEXZmLxY6m/x?=
 =?us-ascii?Q?p4D+F301MBi05/O71m45VtHt8slcCgk0AysFzHNOsutpAe90mqjZ8KrtyWif?=
 =?us-ascii?Q?sye23dvj6zV7aS4jp2kSzQta8enRJvpaeClqtZU3wCD/l6i35Z36tUqNYQle?=
 =?us-ascii?Q?7qmf1rODzDid/qujVasgB7MK4Cq1qpTjssrfX02kpYqzZsH3MpRdGSPEiCp0?=
 =?us-ascii?Q?B0N0U7xEGyBsuYqKPRPxTFmV42xEk/7OaMv1VQjGuLrvZ3nO7Ncpoh0BAVQE?=
 =?us-ascii?Q?S9kuNE5TXn/r6rZlaYStiZfs72UcynBD8xfJJwsr6ES9pOFacSmtc+CtWbfv?=
 =?us-ascii?Q?ZhUueGS2GGzEqJ5GcVWVaOLVZYLIxaqwgMtHQtcNjxryGol4Mw68X7yOzeoE?=
 =?us-ascii?Q?5vSzsjKiDR06W5mLNkDaUZq8mwFyZzL7KLCmIkdNJFQ1oDyQB6dyEnWzP8jU?=
 =?us-ascii?Q?q5gOi4n1yTFaGpSRGS6e9G0cgIp6Kv14zybzVpvhLClmJ6cNJTVdAcDMsByH?=
 =?us-ascii?Q?ECnD6KUpBb8hJttzmLcFSLC/hb8w77y/RlMelETtwwoh5C519uRoQDv/LrbW?=
 =?us-ascii?Q?zajn95QNw3j9J3FQIpZYfIqR2ihZwPJQ8FFz8E6btE2kzZT+2aYFtMHXBJev?=
 =?us-ascii?Q?WRHvUp7gmJNffXUBzRfTsw7IryVgJF6jUMXYc44hXgQK83KmUhxsd/IhzV3z?=
 =?us-ascii?Q?cCHbAQKkZSJJZCiZH0VkClCSY1aotlojhTC2WV39dPGdqCwBh0SNMjEJG71k?=
 =?us-ascii?Q?TYeDmsOaufAdos0NmOjVUOCq1hPmUm3tnlBDI9tm9eEBHytUrpz6yAJ5vm0h?=
 =?us-ascii?Q?F43RJgVaSNF73zeixl8TIro6sB6AtPOJ64UQoZHp28EZfOW3rArigJsWVmtB?=
 =?us-ascii?Q?ul54rL9ILJk8HyrgsH18+HZU2X8Mu+wvjQRKSh0yMI6kb7WwiR3PqKdRPR/i?=
 =?us-ascii?Q?OI6dnHHHRleHk6+P3KY3cAYkU2ATfZMHJoiqM+1EbrWwucqHEfXMMJqV9UKp?=
 =?us-ascii?Q?HvmpOE6HMZaRK0zmXtVn2GSK8G2EaVZcRnGVN89+B7E+Z3U6HbOqh4kQms8C?=
 =?us-ascii?Q?sH5q90Ys26WOJYEG2q1LTvabl78swkQkM2dA5mPalx5opRgOotlJwAl7hV5N?=
 =?us-ascii?Q?UE+GlVlMAroLAXU1R5iMb2QOPbRkTIeg8Sh2rwmbmcEl6Pn2Xqbv7HhNLK2O?=
 =?us-ascii?Q?n6NEXuHihM2AAvI4RGMrCu8SDSQ6AT0CgZ9hGAuoUV6ENvm5FQY2ZtqnQTLm?=
 =?us-ascii?Q?fA+W4ovLfFNCZtfnRqq/1JoD5w2U+8nNanAI3T0RlJ8704Fe7YW0XT0uTjhZ?=
 =?us-ascii?Q?oLFqIBHRP1Z1CtW4tDbuXRpA2rnjc4Xv?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(41320700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 22:43:31.2597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17aaded-9a61-4085-66ab-08dcadc45fea
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

At 2024-07-26 17:11-0400, Jeff King <peff@peff.net> sent:

> I would warn that there are several not-quite-compatible variants of
> netcat floating around, which can create headaches. You might be better
> off with a short perl script using IO::Socket::UNIX or similar.

Ah, okay, thanks for the pointer!

>> diff --git a/http.c b/http.c
>> index 623ed234891..0cd75986a6b 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1265,7 +1265,13 @@ static CURL *get_curl_handle(void)
>>  		if (!proxy_auth.host)
>>  			die("Invalid proxy URL '%s'", curl_http_proxy);
>>
>> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>> +		if (proxy_auth.path) {
>> +			struct strbuf proxy = STRBUF_INIT;
>> +			strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
>> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
>> +			strbuf_release(&proxy);
>> +		} else
>> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> The fields in the proxy_auth struct have been parsed from the url, with
> any url encoding removed. But then we paste them back together into a
> pseudo-url without doing any further encoding. Is that correct?
>
> I doubt that the host contains a "/", but if you had a path that
> contained a "%", then the URL form of that is going to be %25. Which is
> curl expecting to get here?

Oh, I see! Yes, this is an issue with my patch: if I create a socket file 
named "%30", command-line curl wants http_proxy to contain "%2530", and 
patched Git wants http_proxy to contain "%252530". Good edge case to put 
in a test.

> I wonder if we could go back to passing the string straight to curl (as
> we did prior to 2016), and keeping the proxy_auth struct purely as a
> mechanism for gathering credentials.

Hmm, that would be nice, but I think curl doesn't deal well with the extra 
case that Git supports of specifying a username but no password. It causes 
one of the existing tests to fail if I pass the string straight through.

On top of that, all of those starts_with tests for checking the protocol 
are written quite loosely, so in practice Git "supports" the protocols 
"socks://" and "socksonmyfeet://" by mapping them both to SOCKS4, and curl 
would not like it if it received those strings directly.

So given that Git wants to handle the protocol and the credentials, it 
makes sense that only the host and the path are passed to curl. I just 
have to make sure that they are correctly re-encoded.

R
