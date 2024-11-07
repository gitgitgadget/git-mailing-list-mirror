Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022116.outbound.protection.outlook.com [40.107.149.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DEA1D7E4E
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970471; cv=fail; b=thjuW5raqt8OvhtrC6QNo877oUPOfpY/e8URPXqKxIT7g6A8R6yNioVPSr5E6QFWV75F2xBIKfM+C++8zwbFPE5bPzg8wknLQ1Q+04YddWLqnY8RORE2gtT1Sdz6bEG5qZ1Vc7fXsRKg4djUVreKy2WiZF/gMGb7GqT5AzQLYoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970471; c=relaxed/simple;
	bh=g1kDjDlWedQsHFRMFt2yu1n2bE/jTXNnAfWSvlzRfkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k0qEZhCeqDBfAGUgFWXta/GVGJJsH/q//fWFuUbpWGHEp1QDpRTLe63cqlLiEkQYieqV+US9N96pQvezUcyEUHTQqz2Uh3SClmMEDiRVOKmG0H+FzB48snGoIGFtWts8kuJGrcW5DZyltr3dJLpcZBXAYbPrr6Y/3hecKQSNWCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigacodes.de; spf=pass smtp.mailfrom=gigacodes.de; dkim=pass (1024-bit key) header.d=gigacodes.de header.i=@gigacodes.de header.b=gQjvx58J; arc=fail smtp.client-ip=40.107.149.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigacodes.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigacodes.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigacodes.de header.i=@gigacodes.de header.b="gQjvx58J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckoKMsVVCMnDejL0ebLyNEE42FB3pKi5POpD/l5Volj5Ee1rS2M8gAcYnhZ20J33DE1msodb2klRn8hfKunDc9h6PnqC62a10fZ91+YdZ9vnauVMy8JNsF1crbiJXjoPZMzXLxuhhO+pJATrHtfNQI+Rra3n7m2fgfG2pZZ8wH8ICUFtT17Bi6DJbiHJCJKe0ky50IL5w4xOauWPld1bgrrK9undKYjy24c8xQVpQtUGbdmoY8XBsJmBIylU1Zbxztk9CADd3qhAMMiY4fI7OIvPA4pHt+MlHK4il1qJKRgySmzzXgefqM7ya+ol+LAXfRHimH2mmx5xSVRVRxJEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyAHOOqh6dognMoIPkOYe/AUj3jtZdwC+wtu9trhYcA=;
 b=Xk4Db45watrXY8pr6BzvUZHZnA2lBkfERG2CXcmB+U5xi0TC14abRr+407q/xDOCZL1XB5gYrkbfEb7Mj37sUHqGhRPGQMisX0d2UoB3h/4UUBCJBvvfbad0ejdiydKf/Mfnbvop4vwyDXFqP9eUh0c+nu6787O9f4gQKuheWQW9yx4Vz6hL6klgrsY/HcTvT8d/vBuCGdaJWguvx3AHVzYk2C1OKWqFXGMwIttNmFCgutDvtyN1WAAbH0Bf/g1u/PtQ6A72nbIhLbkBmuwx9aSAu2YRwQNO0aY44G3uU43G0du7iOcB2ddxc7vfgdmEvwocSv2iFcCjVH0pEvmmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyAHOOqh6dognMoIPkOYe/AUj3jtZdwC+wtu9trhYcA=;
 b=gQjvx58JTjw86kr4TC3vk5hWcJhaOWdNJMlIX9lEbYY+14CpySHqknLqjmQsvE1Dcp8gBWxMVatCcLWByvhdJxKeWgKchxa0F3Q++WWdmuOCIt6IrKziDr+N6NZmd3oW1R8BeSQYvmp+2CPYae/OJnCTjbq/bL6YwQH771AGdvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::164)
 by BEZP281MB2836.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 09:07:43 +0000
Received: from FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6518:f31b:e3d7:f3ee]) by FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6518:f31b:e3d7:f3ee%3]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 09:07:43 +0000
Date: Thu, 7 Nov 2024 10:07:42 +0100
From: Fabian Stelzer <fs@gigacodes.de>
To: Yarden Bar <ayash.jorden@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: gpg-ssh signing with AgentForwarding
Message-ID: <oeic2p6av3b65mibwmtmiiiciduufysqw4wekileu2tlch3ryx@uqtxefn2wuf5>
References: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::164)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPF8A0F20B12:EE_|BEZP281MB2836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3c52e1-703d-485e-5795-08dcff0ba350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c05icVBNUnlJSm00c1RCVGVES0paUndlbGVlLzdqdFh2UzFxcGlialdDU0hv?=
 =?utf-8?B?aWdHcjd4YzJzTS9jNkt1Ym5JOXdBS2dNc0t0Y1lTZ25HY0dVWEhESzVCaERO?=
 =?utf-8?B?UnFPOXk2K21wWWVXL0FPVkJsRmI5MktTMlJicEJqaVJ6OHlFTHMwc2FyY0Rr?=
 =?utf-8?B?Y1ZpVGFKdnhXRzdOVHpLZGlHM0JGTEJ1eDZ3dUdtZTBXZm9WcEp1TU5GYmhz?=
 =?utf-8?B?L0xBOXVxSVdMVytvOEhPeWxNck9hQW5ZZXR1YlRLcUI4MXhqMXgxZjVsSElm?=
 =?utf-8?B?ZmFDbE15ZEt0UW82VWhua3hLZnd0eUN3cFVna3dva0lvS00zMVJURXZac3hr?=
 =?utf-8?B?Y2hsNXYvTWpVN1poWmhOaW5XaFBua21iZlg4OVkrcmFzTGVZQTJqcTNIajc5?=
 =?utf-8?B?RmFXQ0N0SVdBMWRlcngwQ0NidkFDb2w2MlBRZ0UvZzRVV0s5Zk5RRGtjbFph?=
 =?utf-8?B?N00wM0tLWHRoYUljc3ZIaG85SDMxTjhndjBhcnVyK2cyY0dxRVRlWExEWng4?=
 =?utf-8?B?bllBOVp6dDBFRXNIaGlySVVKbXFlaDVOYkVoelVoUnEwWjRUMXhlSHhkNnQz?=
 =?utf-8?B?QzZzbWFidm1idHhlQW1RQWplM3k1cHdvQXNmSE9DNHNaS0FYNFI5aC9Dckcy?=
 =?utf-8?B?bk9rTGl2S25TZXJNQmxTcnlLaVVKb2lXRDlIK0VOb2h3NjU1TVJrd0pRQjJW?=
 =?utf-8?B?ejUzdFkveDZLUk91dDlRdFNDVFpHWkY5N1JCdkM4dUpoOUVxckFGVWQ4K2VP?=
 =?utf-8?B?eXp6UGo4WDllV1krdTUrR3dBQkxnVkIydGZ5ZmlGK2Y0a20zL3Q1SEU2MHor?=
 =?utf-8?B?T3d5YXFzRmF0LytPODd5aFZaTXk1TUMwQUtmQTVBWE82NlNLMGhrZnYrUFFZ?=
 =?utf-8?B?R20yb0U3UTJMakFGckduK01VVGdrNDJjWGxhMWY5QkdrOUoxczFNT2IvR1Nq?=
 =?utf-8?B?WWRROHo0Y1lCcHdvOGZpRjcyODZ4b2xoQkRORTNSbk5uVDZMWnFPalhTc2w1?=
 =?utf-8?B?QVlRWUsxa21OQW9WeUlqblBZdmc3Q0tyQVRkdXJKbEd1b1M3b2FmN3M4RE5i?=
 =?utf-8?B?N3YvMmpubTJUYUlTeHN1YXFnU0ZRNVAvYzJIcytNc1N3S3g5UjlEczBuMDlJ?=
 =?utf-8?B?TGxObDhIcFduZjEyaFZ2UlRONFE4NUlnSkd2di84blVvMTllcjFjVlhwS2RC?=
 =?utf-8?B?VWhjN3dscTZvcnhnTUJTcjAzZ2svL05HdFlTSVBjeUxWNGtMMjZFUWNVeEhs?=
 =?utf-8?B?bDNSUWVaczNweWdia3BRWlNubTV1VDEvbk1pemJLb2tsbU9oaEoxS0RyRDdF?=
 =?utf-8?B?UzMzYVV1TE9vdlNzYmlBVzFGdlNTZktYWU5CMnk4YkRscWJJQ0IyR2JVSEIv?=
 =?utf-8?B?cVk5THpqdzhJSjZKclBLSHJwOGNMRFNSQUxMRVBvUlRFOElkbExyNkZEb2dv?=
 =?utf-8?B?RUl0RGRGclphd2dXZjhWVFpOMUR2enlGWTNSeG9KbkhVNXFNUTcyYnZaL1hL?=
 =?utf-8?B?ZlNFK3k5S3FSdHA1MCtjQjhoN2FQcHBvYTMwdTQwOGYwSkVsUHd3R25CK2Nv?=
 =?utf-8?B?KzF1T2R3ZlJCVFF0OFE5SStxVHdRdzFzVUNLWTFXZnhDUEo5WG1PaEp0OUJ6?=
 =?utf-8?B?SlFUV3dPVkpRLzQvMDcwdEZ4NDA1UTNKWGd6K1hGaUJkT3ViR3d2Rm5qWHU3?=
 =?utf-8?Q?WCh6jsS152Gbm9P5yZfs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9meEN1TURvcmFoYVBKRXY0VWlGdFBCazZOZkpPQis4aUhONnErZkZGd0hr?=
 =?utf-8?B?cWE5R2VWOUJMYW5TN2Q4azNhMHllWWxZKy9Wa0gwSCt5TzJPU0lBK0Vxelgx?=
 =?utf-8?B?UkNrV21KcjlJYktiNXYxM2JJUUtVeWtiTXJtYmVsSmY0Z2pHcDlRa1lDdTVv?=
 =?utf-8?B?OGdqYm8xR2Q0SHdjTzdXaTB2RkdRRnpORGxMd3c5TmdqT0tqOFc0aCtWNUZZ?=
 =?utf-8?B?MW9UYmRyV3FJcm93TVY4Y3JSa3lVOFY2WWVtVDRCVHhJenRuN1ZkMnlyenJB?=
 =?utf-8?B?NitmQU52aVJWTTlNOFB3akcvd2c2WDQycHBSa2RFZGkxS1dKTFg1U2src0tR?=
 =?utf-8?B?aEFzT0lFTmhJdWt0endta2tCTkpYbDJvcXUxZWwzWUQ3cFp6dkdFa2hyNkxJ?=
 =?utf-8?B?bnJBSmhQMGpLSC92S0FyMkdHb3BNbGVFbGJkK2ZBVlVxSloxaHBNaEhuT3pC?=
 =?utf-8?B?VmErMS8vVmxFMkFESWdsSDJXOTU4OFk0VFV1TVZ3UjhETUNXb0xVcWVVd25B?=
 =?utf-8?B?ejVoc3c0QStldXlub3UwZzNtM2I3K3prRG5hWGRSeC9mYkdtNEc0NFpIWmdr?=
 =?utf-8?B?bnBnWFhWaXF1V1V2aFh2YURiRVVwcnhuZEZhVWlxRFNzVjNVN1JnNy8xUWwv?=
 =?utf-8?B?VnhXR20vV2ZKSHNla0x0VjNTYklMd085dXg5VjkvbVh6RVlBWU1xSU5rcWJJ?=
 =?utf-8?B?K252VDlWZnV1QlZIS3VCbzFaQjBjYkdzSjh5WS8vYUxIa1dnZ01SdUNhbE5W?=
 =?utf-8?B?dGtPdmdpaFcza1Jyd2wySmh3TFczU1E0SWlDKzBqS1FIUjF1QkdXTVFxaGlC?=
 =?utf-8?B?bThHY0pCd0ZrZkxFcmpKQk4xN0xqa2VaYXhnL3hGaXVzdUJPczhMajlpZ2V6?=
 =?utf-8?B?aWc3U29ibkR1U2Y1VFUxZmJNVzVaNXhnM2w2NjRRSHUyV2FlN3ZyMjBEdkhQ?=
 =?utf-8?B?RC9NNWRua0MzTUpRN2pRNU40SVdCYSsrS0ZOYjZ6N081R0VQQ28ycXpOVlpT?=
 =?utf-8?B?WC96MWo4cGNWQlRYTnQwTGdOSWlJdFNGTEFNNEtHY0Y4WmNsUWJ1L2I2TEZs?=
 =?utf-8?B?UHgrMnQrU3dzS002TVViMVZDNGJtMkUyMkY4MEtGSW1yRUxxdFVKSlp2cDky?=
 =?utf-8?B?SWx2bU5aY2FkN2JIQ1h2WU5ERVNsdGFQVjhtakR2TkV4VnZiaVNPSzF0OGRH?=
 =?utf-8?B?bElKV0RYRnp5Qi9OMC9jWUdFUklyQU11cGpCc0RMTlpxdnA0b3RaUXJWakda?=
 =?utf-8?B?WjFVWS9vbW9jR0tZaEtibGxBUlZXMWxZVU9lRnFxQjlhVDkyZWZHOHFxenVk?=
 =?utf-8?B?WTU2QUt6dDdXZ3RseFVkSlI2bnVyQ2x5NE5sY0dFWnFPQXpRT2hSTG42OEpX?=
 =?utf-8?B?RHJGdkJ1LzFXK2hMSHErV09abENReWxtSnlFVnVWem5DdVVES1ZKUXl3NzZE?=
 =?utf-8?B?UXF4NUx0VEdncDA3ejExM2VsbzNyemxiYUZEeWJMaktjWFNibEYwU2EwU0Fj?=
 =?utf-8?B?MnRMSVdsSmJCM1lteHNvRFp4R0pJK29MVW9FSnpNdThQT2ZibHUvNnZCL05o?=
 =?utf-8?B?SmgyM1QwNGJDVXMyVW1reWROUVlEa1orWmpBWk1oc1crZExkQlJYNER3RjdP?=
 =?utf-8?B?aXpkVm9vOWZtNTNMTUZ5Tml1NHFQb3RYd3YxYnVLVXdFWEtCeUQ0VGgwVTBJ?=
 =?utf-8?B?SWFHSzRrME9ENUJqeEtuQ3g2WmZ4aFpBbkMwTUxqTWVCamp6c2Y4Q0dYSFlQ?=
 =?utf-8?B?Z25sNGJ4bzgvMWpyTVowMGRFWTdEYTJkT2VFQUl0TldGcFJ3NGFxbmI1Y3JV?=
 =?utf-8?B?NnNHUHQ3dEJlQW83dW1waGQ3QlpVYk5yR2M4TXByOFIzNVRsU2tqMkhWZC9B?=
 =?utf-8?B?UENhZXFQbFVsWGNzU2VzckJEaVJ1cFBuZy9mc3BQb251WjVnbFBFUHU3c1JR?=
 =?utf-8?B?K3lYa293dmkvQU02WUxLVmVLdHNNQ0dOQ3Q5ZHRTZ2RQK3FjWkN0Um1pQ2Zq?=
 =?utf-8?B?VG0yREhMWWNoaFI2WXpRcjhCNUs3T0ZMS2NhaUIvbXZBaUhQaE9wa3A4MFVa?=
 =?utf-8?B?WUpFQlUrMS9VQ1ZvUzAwbzFZakd3Y0x3TEtVTDJsMUV5NEVMV01aNy9UWXJH?=
 =?utf-8?B?TzBQK1ZwRkxjWlBqcEhIZmdFWGJaYTB3WCtka2QzMW9XTGV1RHBZN0o5bmFl?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c52e1-703d-485e-5795-08dcff0ba350
X-MS-Exchange-CrossTenant-AuthSource: FR3PPF8A0F20B12.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 09:07:43.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjVr35SrfAakIBliOZ2JfJMvNfkg6T7ED/pmMPNficTPzC1LfisvxBBN7cM1w2U0dbzjoC+NQSRL14699fc7LaigXfqp+5mWMcBdJcszGnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2836

On 06.11.2024 20:16, Yarden Bar wrote:
>Hello Git community,
>Not sure what search terms I haven't used, but I'll try to describe the use-case
>
>On my local machine I have a SSH key, and I use AgentForwarding when I
>go out and about to other hosts (dev machines)
>The usual workflow of using the forwarded socket works for pull and push.
>
>Where it gets pitch-dark is when I try to use my ssh key to sign git commits.
>Following is my git config on the remote host:

Hi Jordan,
the process on the remote host is pretty much identical to your local one as 
long as the AgentForwarding works. When pull/push work so should the 
signing.
One small caveat for older remote machines can be that you'll need a 
somewhat recent openssh version. Default redhat 7 or 8 for example will not 
work.
The ssh-keygen command needs the `-Y sign|verify` commands. If the remote is 
too old you can place a newer ssh-keygen there yourself and reference it in 
your git config via gpg.ssh.program

>=====================
>[user]
>    name = John Doe
>    email = jdoe@jdoe.com
># on my local machine(gpg-ssh signing works): signingkey =
>/Users/jdoe/.ssh/id_ecdsa.pub
>    signingkey = WHAT_SHOULD_I_PUT_HERE # on my laptop its the path to
>the public key from Secretive, or just omit it?

A path to your public key file or the literal key prefixed with key:: is 
fine.

>[gpg]
>    format = ssh
>[commit]
>    gpgsign = true
>[gpg "ssh"]
>    allowedSignersFile = /Users/jdoe/.gpg.ssh.allowedSignersFile #
>contents is: "email1,email2 key-type public_key comment"
>=====================
>
>I've tried
>1. `ssh-agent -a /path/to/ssh.sock` - errored with address already in use
>2. signingkey set to a path on the remote host with my public key,
>errored with "no private key found"
>
>I sense that I should be able to employ `gpg.ssh.defaultKeyCommand` to
>use the socket somehow, but I can't wrap my head around it or find
>some docs/guidance.

No need for defaultKeyCommand and no need to start another agent on the 
remote host.
If you get the "no private key found" error then the connection to the ssh 
agent does not work. (Maybe because you started another on the remote?)
You can test this easily by running "ssh-add -l" on the remote host which 
should print your public keys from the agent.

Kind regards,
Fabian

>
>Other (related) links
>https://developer.1password.com/docs/ssh/git-commit-signing/ - I think
>that 1Password invested the time to make it work
>https://github.com/maxgoedjen/secretive/discussions/338#discussioncomment-11170722
>- asked the same on Secretive repo, which is one way to store keys
>https://github.com/maxgoedjen/secretive/issues/405#issuecomment-2460948732
>- also here.
>
>Thank you,
>Jordan
>
