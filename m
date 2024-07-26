Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1921364
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013997; cv=fail; b=WOb75/4/hz3hdoeZOhC0V8qkwmAqQLTZwElZITLhYVa7nvCKlf0+y06wOZ9ElbhZrBCGN/9PJMyk1Yp+XKwHP6A9gKAx+OAVMgAt9tB68nEwSHXYt8pyoIXWgDBbFoSjSGNfbtzcwMoP1yy57Hw1KkTUXOwNtzry2WEe18HkjOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013997; c=relaxed/simple;
	bh=qEMaHx/4c+dHxrjRhl45BtdZr0AzMhrlPtXoxGtt/c0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BheLkCKKxRUtH+kwfyTdZiK3BkXUzYyXzPVn7wfXG7XAtKlmZUM3tFrFPua/6huvQgpwQV10QOYQuFhmdWsDtqjmPirIN18sZ34H9pLUjf9CEDYRm0Fpoh8w8O++8Wi/G+Y1jgcVZ0mWCEX5Q7NGQQmpnOuCTjbBjWo6hatv/4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=alum.mit.edu; dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b=Ebo3mGHW; arc=fail smtp.client-ip=40.107.243.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alum.mit.edu header.i=@alum.mit.edu header.b="Ebo3mGHW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsD66SKdAM2NdclvLXhRHpQ8tEViS1iHonuMFrOvMp5WrnfaubYn7/2El0MpavueZsItv7NZS/ll9kzIl89XHMORemU2xz667I3JigdWCwb8dmmNXXuukV0m3e1IAbIEO1OUSH3299kSRsEzyTDN7qA//mEpM6qS/sLLF/z9PMAOgmmnL8t6DoCvcg2FDwZWOYr9Pe+CAXC5nygLfRfiKk3OSiJTqJ7DfHEuqzR9M2Ldb7QKn2JW5u6SxWPhIRRT42lWjk5WBmcWqrcN23dXzTMe91QC56E21GpVqDMKHV3+Z3gUBW2emiDEV8hlpr7h9cq2dYZzKkyxu5eQESlM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkzVv+Hu9u/BXHJf4e/u25df0oezjRWHr51P1SYtmVQ=;
 b=L1+rCRx9JTSAiZCID44p+gFIgZQZTswIy2P/mJRJIuDJ1vXaJEG4pXOMrHa0dlmFPFhw2AHF1YDBhNmK1Xh/PA3sKiYeHV/BoJVXF40Vw3vf41tTtpgZT1kT3KL2umhoSO+BCFGnT3Q+7kJMK7wh+9SFNTfERVvPNMDg/e22bgXmxy6QJGacv17v31KYqQtKsdm/HFQPVACPpmX6p2X2qQPGxIqmajCl7Xtb3MGl2Iu613axTzFaUYcO+6/WkqYIA+ZaQEDRNq7rc9Wcv6IsBpmx7eJaYKl/LRJBCepkOycFaHO3ndfCqNNWjdDnNZEbh4TElWeWHHpLLNqeyKOe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 18.7.68.33) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=alum.mit.edu;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=alum.mit.edu;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alum.mit.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkzVv+Hu9u/BXHJf4e/u25df0oezjRWHr51P1SYtmVQ=;
 b=Ebo3mGHWEdofVKJikrc4sBa0PfnYp0uFRbLEVz+uSX2aD5+OTw+JVdYi+zKu6dmXuU0gVaUdwSft4xZIR3cR7372cVE2hkGl4J6FOQGf/paHEdvcqa9+TvKkM36UDYBUp/yuvrfWNxIJEM8P6KUsCZTXk9AZUuxxkT1Z+7WCWXU=
Received: from MN2PR12CA0032.namprd12.prod.outlook.com (2603:10b6:208:a8::45)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 17:13:13 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::38) by MN2PR12CA0032.outlook.office365.com
 (2603:10b6:208:a8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Fri, 26 Jul 2024 17:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 18.7.68.33)
 smtp.mailfrom=alum.mit.edu; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=alum.mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of alum.mit.edu designates
 18.7.68.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.68.33; helo=outgoing-alum.mit.edu; pr=C
Received: from outgoing-alum.mit.edu (18.7.68.33) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 17:13:12 +0000
Received: from charles (c-24-218-5-141.hsd1.ct.comcast.net [24.218.5.141])
	(authenticated bits=0)
        (User authenticated as ryan.hendrickson@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.14.7/8.12.4) with ESMTP id 46QHCpi2026156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 13:13:11 -0400
Date: Fri, 26 Jul 2024 13:12:51 -0400 (EDT)
From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH] http: do not ignore proxy path
In-Reply-To: <xmqqr0bgw1z1.fsf@gitster.g>
Message-ID: <6b408a07-f2ff-1e04-5b3a-fd287fb1c151@alum.mit.edu>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com> <xmqqr0bgw1z1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: c271dc10-2836-4c3c-dfc9-08dcad963af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V9NGWBe9rJOvb/EhQgc6cJQrSsI1CytokmW1SBdzzdwPU4h/0YxYx3TB8ND4?=
 =?us-ascii?Q?bj/YhYCJ9/Or7P3cY8ZRi0hszz3lriy2HJ24NRNWMhmmMIUUwxOB47G1xOA0?=
 =?us-ascii?Q?IVjjhMlfrgSZ2deoD/y5IRvWPTkh4VGd4hHk1Poxhk3TckIky+lF4t3F9USJ?=
 =?us-ascii?Q?yUOFgA0mZqSInkz7QBhEACY66gmatwUlUYYRGfPV0oZS5fv7mR8oz6RyKyEj?=
 =?us-ascii?Q?PnS2tA3UpJO22o78DnuWMPuXG54xYx7EiUdVMtvfsbM0VLJCHYrLo+AowCWD?=
 =?us-ascii?Q?pgSx95qC0WSZjgK5ARNXHCu4lNjZ1Cg5q7UZ7M3fwiTz4m+vcm4RsM2I8zpO?=
 =?us-ascii?Q?jXH1Lgb1STViLq31vhyvrqCMSsKdVCFI7JPojG+W6/iMHnzRTUpHl0g1/v3K?=
 =?us-ascii?Q?Y/xB60FQXQpZhK1DEdDU+502HcQ42e9Tu+79McUllp9w+RB1KCnJxEQ8ypNy?=
 =?us-ascii?Q?aLh9urqk97Ydb74EyelXE5GKZSCljYxI0XOXJBew8tlxPGQe6puiJDc9S2Oc?=
 =?us-ascii?Q?KxjrEy1YexiHkcMZT1eAcN4GHgCUGbutIdx/v25MSaMNt7YkHFsEWgF7zSmp?=
 =?us-ascii?Q?wMaBbKLfpLLkViwY4wm59Ix2PR+QMuK6Mr00mb9si87D/HkQtdU1Tp0RaYO9?=
 =?us-ascii?Q?cyfFwS/jbTWAxGdmgynSoBmybcQ9ur6VAVXhLA703zE5pAt63OW3WEBTngLT?=
 =?us-ascii?Q?qPChuja+s3vJ+aRsIXzX5jj6/+VIDU0RfLuugQJOdXzHJF0Jq3u9TMymRyMT?=
 =?us-ascii?Q?mU91cbvPHU0t6swd099lHJHmIY9zlCY92CDEg3KkUoLp+Eb3+4YJYrmQc2+n?=
 =?us-ascii?Q?+a9gQWdiA+vmEm3REbtgSnz9ySoWjQszcl/9a3AHhg+96i+I46lrnDOk3ppz?=
 =?us-ascii?Q?ExV+aJT3hc/uc1F27RlG7ZnSBEYTpE3oYrLjLOjTe8WqA+taCcAl2rCBgD7A?=
 =?us-ascii?Q?R2yiBD7aKwZ2k8TaIVK5JaODm67b9zHDhhMGd2MqAzAd2AlF1qpypu9EBWAc?=
 =?us-ascii?Q?Ym+Gqk+/GkDRgOBRHiLIEJiuAOpcTrHaAP36OLuUKYE3feWgnU9XunXIzGFI?=
 =?us-ascii?Q?KB2NqWPlMcOD1+FRLfNnKd5T1zsX9NNLOXIH0B9FK7retFayk/tB73x2Q0w+?=
 =?us-ascii?Q?98J6/kCpVewbfs2x/ReopydU4OR+puX6CB+BEgRpnsj9ymqYFVYrb87r9p5T?=
 =?us-ascii?Q?tLDU28VjqzuwjzL+nXDSacw7wJ4vdkAbOZncpcuL22A84hU498OJ8ljrp3UI?=
 =?us-ascii?Q?EjxlAYTKARlGhntiFChVVCmhd06cTcXFdyTjAekXloQlgrI+zh12xPBr13B4?=
 =?us-ascii?Q?J2ofsSZAXWdIVzxE+2PayR2EFsrWqU2PnQqTeA8b9OmqNvmveYdIZBbWp0L9?=
 =?us-ascii?Q?1NNu4NVaq1Lfy+f0uI4SRaLjcHWzztXFGyUmZE5HhH5F8225Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:18.7.68.33;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:outgoing-alum.mit.edu;PTR:outgoing-alum.mit.edu;CAT:NONE;SFS:(13230040)(41320700013)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: alum.mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 17:13:12.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c271dc10-2836-4c3c-dfc9-08dcad963af1
X-MS-Exchange-CrossTenant-Id: 3326b102-c043-408b-a990-b89e477d582f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3326b102-c043-408b-a990-b89e477d582f;Ip=[18.7.68.33];Helo=[outgoing-alum.mit.edu]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

At 2024-07-26 09:29-0700, Junio C Hamano <gitster@pobox.com> sent:

> http.proxy documentation says
>
>  The syntax thus is [protocol://][user[:password]@]proxyhost[:port].
>
> but the updated code pays attention to what can come after the
> "host[:post]" part, does it not?

Correct; I'll add a "[/path]" to that construction.

>> +		if (proxy_auth.path) {
>> +			struct strbuf proxy = STRBUF_INIT;
>> +			strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
>> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
>> +			strbuf_release(&proxy);
>> +		} else
>> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> Style.  If "if" side needs {braces} because it consists of multiple
> statements, the corresponding "else" side should also have {braces}
> around its body, even if it only has a single statement.
>
> If you have the proxy strbuf in a bit wider scope, then the above becomes
>
> 	if (proxy_auth.path)
> 		strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
> 	else
> 		strbuf_addstr(&proxy, proxy_auth.host);
> 	curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
> 	strbuf_release(&proxy);
>
> which might (I am not decided) be easier to follow.

For what it's worth, I was following the precedent set by the if-statement 
starting at line 1256 (a few lines above this patch):

> 		if (strstr(curl_http_proxy, "://"))
> 			credential_from_url(&proxy_auth, curl_http_proxy);
> 		else {
> 			struct strbuf url = STRBUF_INIT;
> 			strbuf_addf(&url, "http://%s", curl_http_proxy);
> 			credential_from_url(&proxy_auth, url.buf);
> 			strbuf_release(&url);
> 		}

<https://github.com/git/git/blob/ad57f148c6b5f8735b62238dda8f571c582e0e54/http.c#L1256>

I have no problem with being inconsistent with surrounding code in these 
style choices; just let me know what I should do in light of that.

> Could existing users have been taking advantage of the fact that the
> extra /path at the end of http.proxy (and $http_proxy and friends)
> are ignored?  For them, this change will appear as a regression.

That is possible, though I have difficulty imagining a scenario in which 
it would be intentional.

What do you recommend I do about that possibility?

R
