Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2112.outbound.protection.outlook.com [40.107.115.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315D132461
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227865; cv=fail; b=mRta09zawLWN9kUJI8bLdYzRrheR6Hju+msUMuETywdIAVsIfeaq3/v/lRlhORtoY36jSpOpQenxLNOP8n+2/muNLbUSiscch8SVdrQbkUIlwiGQas56wk30ef1IV1e4gipkkbl6jSX4QQMotHlvsbfpCXLltZ9/7IoSLX5Y9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227865; c=relaxed/simple;
	bh=JIapccJNGv2B1aeJwDNo2nS4ALThWfNMoeEvxm+L3mA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIU28/cgWi1ykdqWYDKZTxwSfXrWjamXK7wlzcSPt8zZFtL+hnleJsV4karnoFzVANrtb6vgxuzy8NdtBFRRG9FEDasKHjP77N0ZD3ud9JJnLsE9IAeB+OMTrXrS+ibtr7I3VkV5pYz2DG1el1G15q1cYNu78dH+i85p7AAL3V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=LRhRFeeY; arc=fail smtp.client-ip=40.107.115.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="LRhRFeeY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnE7Po0vjdixdEV7apCFX6xQt2C6qk4zXQ9CTqRn24dg93D33kZjLKpgGu1y1vqc8dq4xuSIwy/FQ4iKiWro4h6oa2Js+Brw+rIfck1WbJiQI3BdC1fXfJmffbIq3RCWU4zHh+LMh/qKrWlmUei9nziv8VXaOH3rMOPQYc5GBasDL4huMCt14YYcF1r0pwubeB4QYJQ5fgIevzYULd+xzwGqSUCp7A6tLHOBQ4tEoKh8mWQ2J9fkS93ptYZ6eXi+YHewGVEeJ5OZN2/o4P+KLQu1hkMBrsbBg8D/vmD5wtC0+IsrU24i5SrhmQjzCtdSOJrOGVgoFAuAy1+gHVCsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l79ftcbYjheQxS+re6zv4vHtz1Hr3bpe/FpBYkt/eI=;
 b=NrEq48u4lRGAJPH5T/y8DA8qBKOR04EWs9nefvJcxBKYqAhfqb2kT12WLzCn5gkuC1vENZgNC6AoMfwwe9AikEDLnPC1Zjy/X03uCvrNs+FYt5sW7+0GwN9y5EoXsvRKa2HsPLdmE1eaA8rZxK30vMnpU+/GT65fTDvJHMo3v1yrrG0g57VurHQF6FGT4AgkWECFSo7WelEwWH4fIr/E1YHqP/YSpXvYKOa8QKWdGPcM5KxlZOiiNCuNr5Zuj1Z+ePkOeWLGCUDvNV8T3E6OFTM8LVAviDyNjA4exkPfsAwSe5HOnqxjLY/NCP3Egil6MKkVsnF2i1AmiaeEH1zwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l79ftcbYjheQxS+re6zv4vHtz1Hr3bpe/FpBYkt/eI=;
 b=LRhRFeeY0RHWcLBFIEWoxfDD5bS/5GI626Se7j/rw9tU6zqLngO+5RCDi4F6IR6QC/UH9u2cvigjymFsOzkJk8JhROcLX0J9ftdnq6JOp7OGulTRE9NqYd9rRoLoDqJI05iGImZgCyVN0wh3QZjNdSUdqhaKKlG6seeV8kw/zXIrsWFtzmKw3itop9PKOSch/FfYDd/4yLdCbuqnUuvsk5/1wa29rjBqaA6fJMIg60GfU+C9CQJv7R8kI/x1tqzXEEdlAvRuvjiPmGwh+yjllniH0Ce/AW/akC4STW9mbCx+Ilrs3IJ1vEU81UJdWAzqWeTvidEH4iPN7xRGaj0m0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT4PR01MB10630.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 13:57:41 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b677:adf5:fa0f:3c4f]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b677:adf5:fa0f:3c4f%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 13:57:41 +0000
Message-ID: <e7483f01-8bbb-48d9-8e17-3fbaef5c62c0@xiplink.com>
Date: Tue, 6 Feb 2024 08:57:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: git-gui desktop launcher
Content-Language: en-US
To: Johannes Sixt <j6t@kdbg.org>, Tobias Boesch <tobias.boesch@googlemail.com>
Cc: git@vger.kernel.org
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
 <993e6823-7fa7-4130-8c0a-69ed31da5fbe@kdbg.org>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <993e6823-7fa7-4130-8c0a-69ed31da5fbe@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::6) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT4PR01MB10630:EE_
X-MS-Office365-Filtering-Correlation-Id: e3295e3e-6f6c-4113-95c4-08dc271b95a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EJNiMdeqFqyU47KPkq4rFwxEsBuEo4clNEewyeZ7V60wiGq/5D2nCZt/3Mt90Glr4sIBilC6z5eXSDha5RZGk3Em+NWsWXtpFWHBKCBzRd7xDe+6mZgL7F6lLtUjUkqacJUk8vnC25eA+dqjCPTfRoccRmxu/8XfUzTtjURN5i9fm/pOHKaB6tWB6zWpmgLOBL/AFdL87EnIcyux87NukAdBfjyrTtI00lx9IXpbdvhQTOoOGgcUOvRBWlvXWIytNChfgM+ddykxAshUmgHmDxtzkn9O/v7/h10WwNJc4iPrfVFeNe/g6Eqs1o5pDqPFQdTHjTVm93Nb0RYQ2EJRx5EnUNOpvz09iJz3h6f/sjbBXv7t9ELJAZYs0Yn2C07KZRms3ccMjIzov7o4TVzby+scJ2l3vPnxcUS90krcfGxo8Xe60lvgbngxR6fwpnvuUMbgCniLtcVnBJOtk4ECpUIlg3PTYGYaZscoi/To3l0cnlttBT3T++TtYmaz5dGb82kMYHztF6dal8XZBZfkEa+RQ0bWXwts1L2rVbZiGJZEP2hxpIM8EM0iaDSsg/zY/Edj18oWElgk6kEkOqJnydt1NnNDg8q8lAQa1TwwQd8ahb5ffpZQA7Mcr3GsuP466uxrsYrpnmuz9q66ElT8bQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(8936002)(8676002)(4326008)(31696002)(4744005)(478600001)(36756003)(6486002)(2616005)(6506007)(6512007)(53546011)(5660300002)(110136005)(26005)(66556008)(66946007)(66476007)(316002)(2906002)(31686004)(38100700002)(3480700007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWk0L2Z4YkpaVWFMR0Y3ajlSTWdKSUVGN01KYndzRDNsMVhpemZxMTd5Z29u?=
 =?utf-8?B?NnlBVXFoWlEveGltU0htV2x5ZG1VeWxkYWdzTkhBMlRET0dKdmVkMitEMURL?=
 =?utf-8?B?aU5xNldVY0xMdmxwb1NBNGM4TUxTQ0prR2NYd1p6R0I5WHUxV2hBT2JORVpT?=
 =?utf-8?B?c3dvSWQza2ZZQStpVm9IRXNSVUw0SzlOOGtEczRmOGhMNkZhdFgzbmhtNWJz?=
 =?utf-8?B?c2g0NUFrZFlrdHorU3czMXZlZ2FidXpTY2gxdTRwOUxMWGlJT3labWFrbG9C?=
 =?utf-8?B?bGJzRHdUbDdDTU5QQ2ZuUTBaYXpzUjFYbEFkTHBySVNLdS9MMWJKblZzeVFN?=
 =?utf-8?B?L3J0NXhiRkJlU3hxQUFwRDRFVVpFSGdjMU9nc1VtZlZjMGNZU3ZZUm00TEVo?=
 =?utf-8?B?TmVDbkVaVEwwb205NmVhanpvdW13bC9XcTZFUVZnWFcxU0dnSEtHRGtNQmtn?=
 =?utf-8?B?dEZldy9Tc3dsNEJxOW9wVWdDNkZ6Z2gxVnNXRy95V3VsejZueTE3OU1jNkk2?=
 =?utf-8?B?WjB0b2p2T200Wkd4ZGlNZ1E0Tkc4QWtncTNSWXVmT2JCdFA5cWVCaDc5NGtP?=
 =?utf-8?B?bzJOVVlzc1kvYVVRdUJ5K2gyYVRkWnNMS04zMnQvQkpsalAwOTBQZ0xKaEE4?=
 =?utf-8?B?bE55TXhmdUd1ZWVWOXFaZEZ4OGJXZ243a28zamp0U3ZKNS95Zm1ZRWpGWm9o?=
 =?utf-8?B?dDdsa09wOFF2aWllTXhmdVJYc21mNlc0STNxZXNzS0kzVE41c2dHeURMRlFm?=
 =?utf-8?B?VFVVWlEvOTBmU0p4N3RiWTVITnVJaStmdUVMYUJOdXg1RTBtZm1veFRUZXZF?=
 =?utf-8?B?ejB2WnNrWHRUcUswRjkyNE82MjVOUHJVOVNuUTV0Y01aQ0RsUnQ0cFR0SWMv?=
 =?utf-8?B?ZEMzVjdOMVUrdjBKb3hodjdaMStISTk5MFd0NmJjQUNobGxDdEluaWhNL1hW?=
 =?utf-8?B?L00zOVpjNGVsQmN6UlVBNHZGU3IvWWNpNTY2WStialR5SW5FSmh6OGpDNEFX?=
 =?utf-8?B?a25hdm0rNVNzRXZhVWIyYnFTQXdtb2pzQXM4bkZOQUxKbDY0R1RwS095dlNH?=
 =?utf-8?B?VWZnWEVhNm5FTVF3MDlITk9yUzlyMjhyaFhyQ0ZZdWxqVGRuN2h0NkpqQ2pW?=
 =?utf-8?B?eExJVnZyTTNCckRDNUhSeUN3czJCUFkxbkxxTEJkZURMRWVJU1cvQm5Uek40?=
 =?utf-8?B?NUZYOFV5eE5Ma0JUWC9USWIyRnA3YlNxc2hTTlBCalNmNlE2azByNzlSeTNQ?=
 =?utf-8?B?ZmNISWtTNEg5Zy82NmhhMWtaN3hudWg4NmdvNGZCRGV0SGVNa2JjekQ0L1lX?=
 =?utf-8?B?bVN2KzFSMThCNmZpdjljRzM2czF1QUppV2hZRlJLNWduYlU0dVp4YWkxdlZP?=
 =?utf-8?B?VTBhVXpVWDJWT2J3ZkFvS3lMOG9NSUhjVEI2dzAyWDlsZkx6cE5tQlhyU1hn?=
 =?utf-8?B?Uml4YWY0RFlMZ0lac3ZsRkxWZHdjK1liYkx2eWFNOVd6ZnQ2K1N4RmJwa0Na?=
 =?utf-8?B?SFdqWFNHSzFjQnVQTmIrUmRjdlFHKzZXR2VGemJjVlp0aHJMZGFsaTBpNjlP?=
 =?utf-8?B?Sk5CTWZtM2o2Y1hEMjU0MkhiV1NIT1Y1VHMvazBrYmwzbnprM2JVUmNXZ096?=
 =?utf-8?B?clM5R2dBdVEzNGNFUVcvM1l1ZDJXdTdDK0w4bktnVnp6eHFLWjBab2V1VkVw?=
 =?utf-8?B?WGNLM2l4QjR6MlFKSjRwQ09LNXdIWk1NalY0Z1ZaVnB1VlR4Qit6Tmw1SnI2?=
 =?utf-8?B?Rmt6M0dvaGNGaFYxS1JnUVFaZ3kyanJMK3Y1dnVYa3VEN0ErRlo4c0wwVDhs?=
 =?utf-8?B?Snp5SUsvMWJPNGlNZmR0SWN1emt4M1h4b0M4c1JrdmFCS0ZXWVVVclFJWTZX?=
 =?utf-8?B?TjF0ZHF6UFVvWWdtZVhjWGNwWU9pbUdtY205MGptRjd4ckJxck9YNDA2ZnQy?=
 =?utf-8?B?QXZBcUhSMHVjUHNQaUZLQUhzTGIxSFFtL1MrNTlPRGNkMTBwcXlrUnlwWFZ1?=
 =?utf-8?B?QzNyZlQ4Z1dkeUszNUxBM1BMbXJPVG9EamN6eURiU1krZUNmS2cxY0pEdkZ0?=
 =?utf-8?B?dlZYMjZtUC85b01LNUlQRTFTTTJjUjloRkZuQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3295e3e-6f6c-4113-95c4-08dc271b95a0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:57:40.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF+Ed65J3pZutwszAVhyFmlyEUX+DSyml6jo5oO9WkoWZsNgkhO+v4ECY0IVAKiBoREcHkn3tAnwjUkagEIevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10630


On 2024-02-06 01:50, Johannes Sixt wrote:
> 
>> Comment=A portable graphical interface to Git
> 
> I have two gripes with this Comment:
> 
> - That the program is portable is irrelevant for the user. The word need
> not occur in this Comment.
> 
> - I had hoped for a more precise description. In particular, when a
> program is advertised as "graphical interface to Git", then I would
> expect that it can do a bit more than initialize repositories and make
> commits. At a minimum, I would expect a history viewer; but Git Gui
> doesn't have one. Unless you count the two "Visualize" entries in the
> "Repository" menu that invoke gitk as such. So, I dunno.

Perhaps
	A graphical tool for creating Git commits
?

		M.
