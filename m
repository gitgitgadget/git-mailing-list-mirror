Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76B19AD5C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575940; cv=fail; b=jdfgpAa1QL/SQQWYVg9HGUUiB54Rwft7Q1WevZjQvZMw+c/v06qeVEB8JPOUdaEhcstnRL3kZvCtedTsEYz/EgQUzKnKuuVTS0I0I2TcPpy1AEczL/Gg6UTjTcLHl/7PXZv3eqb/yCdeJP5EMbL/svwj7OhZwl+Cg5Cyeca4/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575940; c=relaxed/simple;
	bh=ervDWNaLDTlXushAI+GtFXMa9IPNH6kkfqxZe7/DGlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=py3XGKQstDv8Pshtv6yc5kFvhf9nPjen+6ymsC2HQZVziTi7oz51jAFaipMLqEWpQRx8ZcF5iVaXOtCSSxERPP2dt7SwPoeDPZh9q9ILlJ5SP0CHzyLhNMsqIJbfZNLQvNpch8glGNML0pDX3Y/VRc6W1ERXhO0LlXzip8BhrGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com; spf=pass smtp.mailfrom=comqi.com; dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b=Fd2f4PfH; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comqi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b="Fd2f4PfH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkYSFIhiklY2b5P98ACU4VSoIRyZLxFiRn4CegoecD/z262xUwgJgT9nEb9cX+KTalIOhrZmwhl0Kx3GjLpmN9MhKz8wVk6eJCY6g1CZzrtHkO0UXL0F6rDWJu1GZkOzyXI+GVSqMgGDn+ME6KfMOkXEfeopFHUreIZV6FoRMtosUKIuypUw5QqWXNn/zcaa7uqMS3xTD8LvVqF6ncuhy5gUwfAHaj+Ez846/l1rPv2SmzmZWZu6y5ss0YwvL+qzrH4Wzl/SRuxf5EYpmq+Aas0GRey8DEm9hE89LUClAuEd9/EnmIyuy7GX/3p6cpeZv2HPzekgqy8oWQ6jDlL84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65YF49kGzDehue2c0uaYvECltecJDmknqQtQRH061Rg=;
 b=uLUONoB5wzCtlymAq6KxbPH4uhoa9fo0IY7DGHzfhueHs3LWgSx33K4h7guEMNkHGFktZotW4jjs3zvp5RJ4bAJnZWap6bCrOAkYUu8JBT+czYH5sPu3SiIwhg6OFLZDW3Fe5MPov7k1ENlwN3d2axmclcgXvLRzbY06/2dfImBklCHtc79NIgIYojYgXEx4giZoD+j/uajYX+QLMVdPKpYeyIfRVz+YwOTBKcN6vbLxGL90EpU/EZDiDEjA1j6aEI2D8p/Tza3NPv+ojSANuwMvKX2B66lgWGD1adrTrKteg2aaoY1/00XcKo7i0Y8Esdp7qc+d+88WitJbgpCELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=comqi.com; dmarc=pass action=none header.from=comqi.com;
 dkim=pass header.d=comqi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comqi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65YF49kGzDehue2c0uaYvECltecJDmknqQtQRH061Rg=;
 b=Fd2f4PfHgciZ6sMf6FHFfgR9uV3xK/wjsSOv44DY1G1wVJ+/imqEouX/076/HerK9SOzN5lybupgWqbYUMPXilIkU1oDA7G4r2nzY508PP/FD3+zDXhucGI4Iu8h49kJBMH4XUJh5kslHIRsjgQPlK+wbEKWvmMgbwGsJ8lNFOSHl3Z+9TJltsRea9d3EKR3694c5bYJ1giaTwNS5Ij/0fqpnguYtTBSiMxH9jR+rI6LkyjWYhVBcc8zMgkC+fJqa1BeW3ZAZ7yvpSyFb+dUsbsrBsmdjC1mjE9fapZfEgDMue/XulAK+UxlwVTu3kX4Vi54chlOrtomhOMQ2KQscw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=comqi.com;
Received: from LV8PR15MB6439.namprd15.prod.outlook.com (2603:10b6:408:1eb::16)
 by MW4PR15MB4634.namprd15.prod.outlook.com (2603:10b6:303:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 19:05:34 +0000
Received: from LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49]) by LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49%4]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 19:05:33 +0000
Message-ID: <13247074-76b3-4980-a097-3d49d26175a7@comqi.com>
Date: Tue, 13 Aug 2024 15:05:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-svn: mention `svn:globalignores` in help+docs
To: Junio C Hamano <gitster@pobox.com>,
 Alex Galvin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alex Galvin <alex.v.galvin@gmail.com>
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
 <xmqq4j7o5nqn.fsf@gitster.g>
Content-Language: en-CA
From: Alex Galvin <agalvin@comqi.com>
In-Reply-To: <xmqq4j7o5nqn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To LV8PR15MB6439.namprd15.prod.outlook.com
 (2603:10b6:408:1eb::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR15MB6439:EE_|MW4PR15MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae43e70-438d-44db-88b6-08dcbbcae811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V21GbDVWOEl6bDNZaTZTTzdXVmxmcGhKeHJGdVB2ejRPbitOMEVyeDV1dG5t?=
 =?utf-8?B?NEp2RG5uaFMva0pGYWhhUTJwMTliVytLRXJCQjI5Qi9hZDBvbWdtSitEV2cz?=
 =?utf-8?B?b1RoQ0RlZ2FLL3BXNFo2WXBaV3hzYU1vQXRCNTQxVkxLeXFlcGxhYW4rOFJY?=
 =?utf-8?B?L0V5ZGlrVi9qQ3E3c0Q4Nlc3SFdQMWwxZnlqc1ZxbUZua09FMnhuMVNrVnNp?=
 =?utf-8?B?NmVjV2dQaTBUbExySVliMU53MnpBMUdCOWxtN3pqUnY3YVNWdmxla3Nralc4?=
 =?utf-8?B?cUVPdi82elU1ZXNGVVRUSU9WWGVPVFBHTnRNWklja2tUbGMrVkhjRXNmbXZE?=
 =?utf-8?B?cm81bGNuSWNuSGNzc3lkY0dHRFplVS8wYnpmNTdSTDdSMmdER05qUk15SFVT?=
 =?utf-8?B?Q2I3c1VJcS9VT1dxdVBGY1J1WmJIOU8rUHhITEFXWHVsK0N3ZVl2UkZiOUJN?=
 =?utf-8?B?TnE5eVNzcVMzRldMTUhBYWhCbW1GV0lNS0h1Wm9WcEphQXBkTGM0UG9iZG1M?=
 =?utf-8?B?bmNSeHBvSWYrS3BNWXB4YmlBL2NaL2JoQjhTUHhaYXFuZ1ExTi9XMkdaWEVs?=
 =?utf-8?B?a0d2Z1h4NHdieEhTa0dZTlZZQkNhM0ZGb0dmdy93MkI4c1JmYzlVTzJ0cHB0?=
 =?utf-8?B?K2F2Z2hxLzNPY1NnYTE1eE00STdaenluV1pISE9WVU9SVGZmeVZYQWdPanlw?=
 =?utf-8?B?V2lGUXZSd1ByM0RXNS9oR1hYOXJWZllwOGxNZVFSTFJFTUFteDd0QStNbWMx?=
 =?utf-8?B?WHMvWFFkRy91a0Ruc2c2MTNTZTU4TlRGVys1aE40QzNnQ21WRkhoZWwxQmU5?=
 =?utf-8?B?dFBhemt4WU9jY0FwbjdrSUNMMkNmUHRZVERhd2QwSE1tVmFEczQybXBUOUhT?=
 =?utf-8?B?dmNIOWFpYVBrcDliNnI4T25aRmMrQ2htZU9Rd09Xa0g3RTRBZ2cxNEZSUjNQ?=
 =?utf-8?B?VXdGb3daMkNrcVhjQUF5NDArdk9Oc1BDS3BjTCt2R1JDaUVvdi9qUjhNTWtW?=
 =?utf-8?B?R25TRGU5WHFnT2pvVnk0V2tPSTJhRjRiK2MyUG9SV2pWeU9LbGR5Zk1Pc01q?=
 =?utf-8?B?SENJc21hOCt3WDRHVzRnZEpnZjk3SXRFTlZqck1DNDZSUmVteVBpemEvVDJU?=
 =?utf-8?B?V2EwbkpKZ3ZnRCtKZk4rUHBVTGRhNWloUkhlajJ5aTdjaEU0Vm9hUjRFcGNp?=
 =?utf-8?B?S1laOUNyV3p0L29wSm5YSUFHcnFVaUZwL2VKRDlmcGN0cVhKRi9WNWtrdjlv?=
 =?utf-8?B?ZGhJMU8yWlc3VnpOYndEMFhKbVNjL2d5TEpQOGN6TEJJSCtZSGwvb3BOdGpW?=
 =?utf-8?B?SGFlNDJzcWFONEd4UUZCWDFXVEcrZDArTkFycFZ3YlMxOXVEZVd0TEF0NU9G?=
 =?utf-8?B?Yis4UDZIYStCRWVHL0Vyc1dKYlVCc3NVK3ZSRUlwRWhDWGlQWTN4VXZTVXZP?=
 =?utf-8?B?ajNhNU1rb0o5enNhK29qajBUYWZJbktnVlV1Q21WYk5ucksyOXZ6UnhsdGxo?=
 =?utf-8?B?VFZwdWNmSHBkN1U5anBpTFlEMElLeTNmWDBKQ242UEdOY3J3cUU5a0ZSYlVM?=
 =?utf-8?B?RW0xM2w4NnF4QmJ2eFlJZUxDQ1Bsa3IwZFhwVWRtZmNuRTNwUzBPTWpaZnlJ?=
 =?utf-8?B?QTlMY3c5R2VhSUlqS0FhUVNOM1d3T1p6aHJNQmc4TE1pK01pWUowVk9qdTZW?=
 =?utf-8?B?djQ2RjU5dVJWeXZmempCU1ZrY0lqcUVpMlAwUVBpeGx1NjlEV1dtdDRZc1Rq?=
 =?utf-8?Q?sJMrRiQsz6BDD7bXgAw6Bk5B1hmluDSlvbIutGl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR15MB6439.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjg3RmROTndkT29zc0N1TEdYUGk1bXRqZmR1NHFhbGwva3BteGFpTG5US05S?=
 =?utf-8?B?c3JDSXd0ZkJ4c2ZMcnpER1BmaUdhWW9JMFRZdFVGNHdkejFHdFhHOE9PL1Z5?=
 =?utf-8?B?TUtKTUJXbzB3UHZZRkRTNjdsMStQaGFIT1VtWmppNWltb0g0WHlFb09UZnkv?=
 =?utf-8?B?U2I4RzlZa0l6LzdOUUJzNUtWY2FZeUgxekprNjNabExjVUROY2hKWVlCVmFJ?=
 =?utf-8?B?ZkNWQWl4d1hjMEV2bUhtVVJNWU5BT2FCWEtZSC8vWXJTUDZOWE1mMzhCQXZ1?=
 =?utf-8?B?VkhEVVVmQ0tNV3N3RmVHaUlsS0kvRjhrZUt0dHFMNDkyT1U5TS9DQVlRUU5S?=
 =?utf-8?B?dXVWeW9vNHFEdVpucWFiYmF4OTVwZy9RREptZkZjU2dwdUovbVpyRGlQY3Zl?=
 =?utf-8?B?U0hOYlZNMzAzZy9JeXlKNTQwZEtjYTNlRXhYM0EwNkRWbFlBalV6R3V3OEFw?=
 =?utf-8?B?UTVObG03TVdabllpeHF0RkprRXZ3KzIzRGVDczlUUUVzVlpaMllMRUtJQWpZ?=
 =?utf-8?B?MnI3UFBDYmVHR1VQVTBEeFdVWlJYSUFrRlpJNUx5UHYvNm1kai9maHpxYkVJ?=
 =?utf-8?B?cThKalZ5WGl2VS9YbVVBWE40VXVTOGltZ0tuNjR1ak16S1NHZmpSREdOcTQx?=
 =?utf-8?B?QjNVUTJoUHlkTVJYQld4N3NvU0lGVktHeTBBS3FZOG12bTk2Wm9NR3FaNmJH?=
 =?utf-8?B?Y3plVFNWYkN5UC8wZ0hHb3BTdVB5Q3IyTTFQNXErejdibi8wTTZjU20wVDEw?=
 =?utf-8?B?NkIxYVlZK2JyK2x1cVk0bVFXY0JybW5HWlBZSE10b3o5ZU1ZMzNRdmdlNHdW?=
 =?utf-8?B?TER1NkZXcGo4K0lleDI1T0VkLzFCRXJNK29abU5RWFpLb3pwZW9jOFlGSlow?=
 =?utf-8?B?Y3hweGRQNnhiTmFITDJrQ041U2ZwRmVPUDlXcHFpdnJzZ1Y1ZnhXOExqSkZT?=
 =?utf-8?B?Y3BxUjEwVXpoL3JzR1pqK09QSEFCSWlFaklwK0VhSHFTekUvQ3lIMHRCSFFF?=
 =?utf-8?B?dDI2R3c4ZU90TEpsRkY5OU1vQTRJRUxCWWZBNGNLWDQ2SDdOcU9xbUN2eWhD?=
 =?utf-8?B?TWIwdER1QmZ0MlpDYXFkUTN2cFYvY0RjVE54TkFDaFh2NHNlbWduVHJTSW1x?=
 =?utf-8?B?RHlTTjlrOVozcTBiMVFMT29RUE5uKzJyNmRrU2JFSlNLSGlSeEs3bXV4K2RP?=
 =?utf-8?B?SDd1aGVtTzZFMC9IVEQvekQ2MXpvUWJ6VjBOaEtaeGJGWDJUTml2OGowQ3pK?=
 =?utf-8?B?UlZkMnVEalNYZlJBUmZZUFgyV3VRNTVWT2F5TDJqWjhtMk9pZGE1WEhCRVN5?=
 =?utf-8?B?ZkR3ZllXQzh4ZGtnWHBFUEYvZ1RxbUx1dXpYWHhMSks4NWRhVDI0ZzBGL0lE?=
 =?utf-8?B?QlZxcVhVWlY5eEN0TFoxSGZsUXJSS2Y2Y3B1V3JlMFJ0TmRnZHg3aU1PY0ps?=
 =?utf-8?B?aXdsNnpHaHJNamI2S0lkR3ByUFFDM0poWDVBS1pjTjE0RnNsRVhjY3luNUx5?=
 =?utf-8?B?K25OUzZ4dmU3ODFwMno2S2JuNWlZaE50MkwzTCszcldxaGV3MnFsNDBvOWUr?=
 =?utf-8?B?RGNjVjFxN2czSWE0U1BQVjNILzBwUDVOOHlwT3J4MTY4Lzc0WVhmcHhCVzda?=
 =?utf-8?B?bWJweHhEQnZnT2NPS1UrN0NweW1jMTJTcXFuWDRHQ1R6clpwMlFPNS9Kb09C?=
 =?utf-8?B?emwwM2t6VUhuYWVYUk5CZDdoRDlWcUgyODAwODBOTzczQVpzU1puSXU0TFhW?=
 =?utf-8?B?dE9hR0JFcVhlUWtmdWZpclFQeWhzeWRhS0MzN2VGSTdjejJpdk5yKy9PY1hV?=
 =?utf-8?B?UUVKOUVIdDgya0hMSHhzN3hrWlM2am93bHpSUSt0M0hSamk0VDczU0F3VGYy?=
 =?utf-8?B?andkY2RLTGlFV0MrRWpIQzAxeEk4UU9JQW1CM2gvRzBobmE4YllRMmVWTThq?=
 =?utf-8?B?TGd6UENDRGttM1BsamhMSkNoWENmTXpzVlZkS3Yyd1dySU9zOXlIdGJwSDlx?=
 =?utf-8?B?RjRNaEdZUEFjVEVMdkVUeWs4MDdRQ2VJU1cvVExzckxucFRicmpYWjE5NW1w?=
 =?utf-8?B?Y2RhYlROYXo5Q3IwR2dscWxqWjdETlNhTlZ0WVdySFhjN1M2TjJ5NGRPMDJw?=
 =?utf-8?Q?xkawaZIUcf28t/em7YmtQq257?=
X-OriginatorOrg: comqi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae43e70-438d-44db-88b6-08dcbbcae811
X-MS-Exchange-CrossTenant-AuthSource: LV8PR15MB6439.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 19:05:33.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e9102f64-4b7b-419e-b154-4a6930148e08
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5APLNvChZsSzVt5vPp+McWEOAVjE9oqeYTEGHCAtscTkIeDzUH/69effF9jhrympXG2bwYJbrPwrtfmLvd/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4634

On 2024-08-13 1:36 p.m., Junio C Hamano wrote:
> I do not know how likely it is that Subversion gains even more
> sources of exclusion data in the future, but it makes me wonder if a
> phrase like "Create a .gitignore file from ignore properties of svn"
> so that we do not have to muck with the message.

I don't think that Subversion will add another attribute for ignored 
files anytime soon. The project has not had a minor release since 2020; 
the svn:global-ignores actually dates back to Subversion 1.8 in 2013.

With that being said, I think your proposed message is still better. I 
spent entirely too long debating if it was more appropriate to use "and" 
or "or" in my version of the help text.
