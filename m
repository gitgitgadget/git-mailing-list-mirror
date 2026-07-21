Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE038B142;
	Tue, 21 Jul 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657018; cv=fail; b=h+xIFgLZe57L+G23B4MPDPJcJhBTyiuMl3kVvPyY9b7fS6TAIw1qhOWn4ZYRKDoH19IkxEDhm423k2oC6u7fKWXeNf9kgqwjTUwWuBu0nnY05c4Vuy0Q7jIeWxNwZLj6QbF5XkKsrUwAhJH3SPSH5UYPVQZZU8X5aihbI3IfrnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657018; c=relaxed/simple;
	bh=+MM2u53ClzyVs1yOr+zAmCke1tttdLXrC6CERD8xnF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iTUwDHOojGMML8oSzBjxTfRilI3tVRQ6KZA6kGsYzSx+Dq4jYref6VnrTPwocZhG8OQZAOXO2Zl2H8AVawwHKrsZNhMC8XTY0e8cBO8DHcw84pIPFZYgxiQ+5ZLdBMaV/z36YkbPkMXg0GPdyaNMO+6ymkVe2m6Vhwpf4NxU7/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GO56VawC; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GO56VawC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV35qpiZpk76Z8SJVavXgx9KjV9oGQUYuh2zAtxq8liuqOqsXjm92inJJEujrEOefmmmaSXTLxMZI4DAevTNVv+nzR7C7RXT7wfv10uuYN5JtMwNysCGb2DP8afU1w5EEe7wv6bOpHQf+yFQ0JIky9IfgzrD3NyRXrUPGPb+fC1+IAo91swsaNH+1mxEUOxDv9e4al8oxlp6cHsck2wKd150wrU/+FmaRakCbxaLRLmHwpBbS2lZ6Qs308+hOG6SVi9snKP60/FeJgWzSRDp2PPVGP5dA1QYKPbzdErNFhhj0f+hy9OLy2jQzP22OBZNNxiMlG587PE5R3KBSwTebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgS2ovebvAoSqTU7zN2gGMy0zUBNNNkIryEvtnadOtE=;
 b=nb3bus9ymucD3TFzyPqSnkMZ5LEOs4EOOhfj+dY7ZdpbVw2b+s4hmtGWlS2TeErs6i47H89NNP+1M5rqEnGclqxopgAXHq4e9S8E60VhmGFDUVqx3f7UFQcirwD7x3MYPPa2xseb5g2UbhJOoPVVpKK18gk5n3zy0f7Zau/+uFxt3Avb6Yaq5ZLjG7wm94PUD7TIOoncrdkkjWacASIRgODAfLYU9Y8lqLZcF30fu5ZRmCPnR3ANJwLGXCeX+8eLvUaH8Ih9uxq5mBw0aLzLQQN2B4mzThe0mlFRBwVr7I4OK9aU4Cbdd4kgTmhPK8EeP4ALYZ9LI4hWZbO8xi2ObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgS2ovebvAoSqTU7zN2gGMy0zUBNNNkIryEvtnadOtE=;
 b=GO56VawCVUd8acbOjGHASk4UJtGF8sY5t0//8TueGbwACiaZZ2jMtHSCsmPHHSX0ekyuifsVrTAZ2wcaS4ueVb2WfNRJx/ZyQPlNQlt/Un1UIDf3kBL/TbPLSPZ4qnOxVfzgsefTcqawYEFUpVciRpHYkVN12pcd+siic9gy5ib0t69G2ST331kCR5zBwE/dt9b92yByNPD9g1GsQyxBJTEsP3SuObButF5mCh3Kr8Krml7zm8DJBmAevTYAVRpYdmuk6Pzx0RJ1hgkicN0CxnwyFTpTZe4479hRbdcGtQZ1yy0WSQVhGOB5h7x7YoC79ZcSOn6zloqRQnhwOiTvJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 18:03:33 +0000
Received: from DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f]) by DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 18:03:33 +0000
Date: Tue, 21 Jul 2026 14:03:30 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>, git@vger.kernel.org,
	Thiago Perrotta <tbperrotta@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	=?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>,
	linux-kernel@vger.kernel.org, Codex <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
Message-ID: <al-0ckPhoa-ZPhSi@yury>
References: <20260719134447.381835-1-yury.norov@gmail.com>
 <CALnO6CAuitGp_xLYkXpkQYV9oiXsNNfsXZ_OqzkW7_6ND49=LA@mail.gmail.com>
 <xmqqcxwgz2u3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcxwgz2u3.fsf@gitster.g>
X-ClientProxiedBy: SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::7) To DM3PR12MB9349.namprd12.prod.outlook.com
 (2603:10b6:0:49::12)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9349:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 7297e638-2515-4dbe-9686-08dee75260d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WAGmbV7y4dQCgUcf1NDgt94PuXvoduMJcSay+jA+ZgaUCy6SWAPzptCj4sI2gDpY/LUKQbipM/uZTm4WTfSAw77DJqj3mtgpDFdkCrUzBlwHJUZec3Y5RpVJkDr0sfMBI6TEJObK6S5JSmZw3M7Hvd7x304ctTQ4yVB6JtpM1p0Xmozkroi0JxMLwnzBIWHAL/B+4IpSAjc0kgbiURc7h0BU12CqJ2dsNcW6JEnKvw6Uyyni1P3HUNTR+mmxRrMyFvnNILEyWC+d933Ebnw8jTPABKGcEXa98ENsiUeI5LroLKL57QkEvN5eIVNtSSlwIUzfUvBvvlrH3hP52vHCpjVc59cis2DMR5pvcMOqnhdBk6tnYM3Me3hTPN+frARVtQbEtOP2Y7o1x4xk5iFC6UbZNblEZWk9pkGfja1Mt4+17GY9glNWJsNUYWBrd6+Qlk4Vy5DHkjmLhcyA2JYU6Ii8fRx4N9vcJb6THH6HjvlWRuhPRwfByEzhNer/2BkmrR9WiXxSlGbu78CTGilJNNRRq+kmEaL5uOHt3j1cQE2Qh+lwD/3xrjTw9mJC6gpyvU7t9NJtHgjdIhdcRbCBDkjYZSvVdcWQxiejC/LcriaCaF5DljiKijfwGSCjEXA3lwSUrq9C4zrUrY5smsvhf4eRLYz7pa2QnFGAEmL1Hh8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkpmck5lUGlHa0p3cnFqUTE2M0p0ZnZMOGhPLy9PdXJLbE4reGJNS25tVi9k?=
 =?utf-8?B?eDB6ekNucUwwSEV4WW9DQ2lVL2JncmljWFV4TDRncDlyS0tuczRCbzE2WHRF?=
 =?utf-8?B?bE1MQXhGRlZkU3JwZE5uL2ZhSnZpMGEvSEl1SWhmVGxiMUhvTVE5V0VCN2hN?=
 =?utf-8?B?d1JxcTJFU01ydU5tcElkZk9zdVVzQXAwOWJxR1RYWnE0Sy9wb2ppSFJJSWI2?=
 =?utf-8?B?MXRXY2ZpUWZLMU9HV2dySnJ0ejcvT0VtZnNQek9KQ2V4QUF2NzN6NWlCWngy?=
 =?utf-8?B?V2ZZODRDeUh6aE9CU1lGWVpvRlBFU1I2RExEZU8zbXAzUFJpVFNQOEVUb0VM?=
 =?utf-8?B?UStWbTNMYVA2c2RteHFGenF4ODc3dml4SE96ZHVia2h3aXlqRm9kQ1BhM091?=
 =?utf-8?B?T1ZVWGVVcjBaaTJFYmlYbTlkelBWbERhb1IwVmFpZHBVOTdMc3VXVWxJV1lY?=
 =?utf-8?B?Tll6dFZyR2JmWWcwQzlaNHZPb0t1YTE5dVIvT09FdmM3OWJ3QXlJelVvQmhM?=
 =?utf-8?B?RlZ5OXpEZ0g3ajlQYjZMaXRFOUgvRVZmRmtKQ2liR1RtODhLbjRoQ3prc0xX?=
 =?utf-8?B?dUU3Y3VGRFJpdU11dHJUUnhSeHJXR2k0ZmczN1laMTVSakJVOVRVdXAvV1Mx?=
 =?utf-8?B?REZ0T0tCbjFmSU5uR0I0U0dMMitRQi83by9yL241RDkyTVJuQ25OOHZKQXhx?=
 =?utf-8?B?V1EvOTBKSmpPWURlY3FjMFRwMHNwL1A3T3U1TUduSktUT1BNcW51UmRYb3hp?=
 =?utf-8?B?K09DMGdXSG9oczZvSzF5UDhRK2Vsc3ZKNU9UZm1HR0VRMTdFd211bkJjbVox?=
 =?utf-8?B?T0krd1RIaVZsbExROW84L1F0bTFyVGNXMzh3cjNzeWV6R1pDUGwrYUMrY0I2?=
 =?utf-8?B?SU96bjcrK2FPZlNwYmRFZm00cTYzY2N4Qk9mUGVTQlFXUGIrSEtLMll4bjVv?=
 =?utf-8?B?RjdvRzgyb0JPN2pqTlZZR2Q4a3ozbXNmWXJjcXlxU0l1WForZG1CVjM3ZHpi?=
 =?utf-8?B?MTFwLzdJVGpadE05U1BzdlNZclppSzF1MUFvNjM4RlRFVXRLeHg2c3JLRWpr?=
 =?utf-8?B?KzlURTlmSEJCdlhYV2ZCaTFkcVBPYVorSFlXUE5VNXc5anQ4SzhCalQ4S0Zs?=
 =?utf-8?B?dytWTnV5U3kxUTlmQW9SYnZ2cmpOcGN5bXYySHpySGxyeU9jNFRXOTI2UHY4?=
 =?utf-8?B?YW92OHB4MVlxdWFuNFczeHlXSVM2Qkc1U1BMNVFJVEdrRDFLSStmNEVobVll?=
 =?utf-8?B?STk5SGowTkNZbUsvUWhFVnIvd25PZmRzejNZblkzT1FFaDlSWEZwcHNjV2Yw?=
 =?utf-8?B?ZnEyemhhSDRoZFUrbktFdWtZRGRqVzd6SDF2Y2puY3FDbUxVM1ROQThGWW5L?=
 =?utf-8?B?QnQzRWNwcGdpR1pGeGRSQzV4VkNsTmVZWFJJL1Vham1jdUNWUFEyMW1GSjdR?=
 =?utf-8?B?TU1JcWFFOEZOdUY5YzA2T3JjSnpTNytYQTVpVGV0eEQ5ZUtKcnBOMDg4SFA3?=
 =?utf-8?B?K0Q2VG5vc1VrdGVVeVk2YU91Q3JsZVFqU0tUVS9FdllnVmpCaGYrbFZ5MVJq?=
 =?utf-8?B?OHh2M25TOXIrKzVFNzhxZSt0RzFKbWlBME5sNWozbTNKS1VTck9PNGZmRG9Y?=
 =?utf-8?B?SlFXdUtZbEJ3ZUVIM0RvL0RXYkxKSzYxV1VoNThkNUZoZi9iRG5UMmlJZW8y?=
 =?utf-8?B?ajNOeU1kWit6SzNGcjgvWGNHa2hlSTUxMkZDdE92a08rTGd4YWpFUUNpV3pI?=
 =?utf-8?B?dERJQ1hkUXUrMXNWSVgzcHZ0a2ExZnJaZXQvZnFZaTViMEtZUXlhS1BmekR0?=
 =?utf-8?B?dk9sTlkyYWRDZzN5ZUVRNGE3clZNekkvRWlIekRpdjAwOHdLMFpHSkdXZkRK?=
 =?utf-8?B?OG4wT2VUM0t5c2UwUFlPQ082aWNGUGxoOTdFZ1NONTlmQTVqcTE1ZDlBc2F2?=
 =?utf-8?B?Y2Q0enRpc3A3UHZkdkFIeVFDeXR5N2dsZkVGRDdzenhteC9PK3ZTeHNJdlJt?=
 =?utf-8?B?SkZMUHkrMDFHcVhFUWZnR1J2K0JncGFIWTlGT1VnMVNTelpTWXJUb0dDdW1k?=
 =?utf-8?B?cmt1aTUyNUJqSFVKZzZ2VTh3Z2ExMGQrMk9ZZUxwQUxaVU56T0VHTVUrS0xh?=
 =?utf-8?B?cXE2WlA3Z29VUUo4bENvZEJlS3AvUEtvcU8zT1dLYjducG51ZUIxT1d1Z2t2?=
 =?utf-8?B?STRBcHRma2RXVTBCcHNVRlM5THFid3czOTlaOGtVR1lPbUFVS0RiMS9lSENR?=
 =?utf-8?B?ZE9QUVJQaWphakYwWW1sUDJ3RmNNNytQQVdoWlBKY0RLeHFLQkt3WURXY1po?=
 =?utf-8?B?Rzh0L2JROGpjeEpod2g4WWxIb05MOE5LdkVzKzV1ZDNxT3k4czZxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7297e638-2515-4dbe-9686-08dee75260d0
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:03:33.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAbVKbGQjFiZDdDFGh5cKZ8iQClHwExQ6/c1qLWCxTdfZqWPrN8TWb3nUAu6wgUkl7RqCdxZ8h61QVq3mxBByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

On Tue, Jul 21, 2026 at 10:09:56AM -0700, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> 
> > On Sun, Jul 19, 2026 at 9:45 AM Yury Norov (NVIDIA)
> > <yury.norov@gmail.com> wrote:
> >>
> >> From: Yury Norov <ynorov@nvidia.com>
> >>
> >> git send-email accepts either revisions or paths to patch files, but its
> >> Bash completion only offers revisions. This prevents patch files from
> >> being completed. It can also make a prefix such as "0" expand to an
> >> unrelated hexadecimal ref even when matching 0001-*.patch files exist.
> >>
> >> In my Linux tree, an attempt to autocomplete the standard-named patch
> >> brings a random hashtag:
> >
> > It is unusual to call this a "hashtag." Perhaps "hash" or "object
> 
> Very good point, but I am not sure if the author truly meant object
> names here.   > name" (or id) based on the glossary and datamodel docs?

I said hashtag because for me it's a hash of the tag:

git send-email 0<TAB>
git send-email 05c69d298c96703741cac9a5cbbf6c53bd55a6e2

But also it's a name of the tag, and git warns about it:

  $ git show 05c69d298c96703741cac9a5cbbf6c53bd55a6e2
  warning: refname '05c69d298c96703741cac9a5cbbf6c53bd55a6e2' is ambiguous.
  Git normally never creates a ref that ends with 40 hex characters
  because it will be ignored when you just specify 40-hex. These refs
  may be created by mistake. For example,
  
    git switch -c $br $(git rev-parse ...)
  
  where "$br" is somehow empty and a 40-hex ref is created. Please
  examine these refs and maybe delete them. Turn this message off by
  running "git config set advice.objectNameWarning false"
  commit 05c69d298c96703741cac9a5cbbf6c53bd55a6e2 (tag: 05c69d298c96703741cac9a5cbbf6c53bd55a6e2)
  Author: Tejun Heo <tj@kernel.org>
  Date:   Tue May 15 08:22:04 2012 +0200
  ...

I have no local branch or local file with that name, but the tag exists
for 14 years, and will not go away. And yes, it breaks autocompletion.

So, after rethinking, the problem looks like this: if autocompletion
logic finds a tag beginning with that pattern, it doesn't attempt to
search for the matching files, which is wrong

> The reproduction test uses a long hexadecimal string,
> but that is not an object name; it is an unusual-looking tag name.
> It is like naming a topic branch '012345' and complaining that:
> 
>     $ git send-email 0<TAB>
> 
> completes the input to the branch name while ignoring the
> 0001-changes.patch file.
> 
> When you have a branch named '0-tolerance-policy' and:
> 
>     $ git send-email 0<TAB>
> 
> completes to that branch name, you would not dream of complaining
> about the completion.  IOW, I think the complaint is somewhat unfair
> to begin with.
> 
> Actually, I do not know if the completion script really expands an
> abbreviated object name to a full one.  I tried:
> 
>     $ git rev-parse seen^2
>     179eccf0d01729c19a3238905b951b1880aa4ba1
>     $ git checkout master
>     $ . contrib/completion/git-completion.bash
>     $ git send-email 17<TAB>
> 
> and waited for some time, but it did not complete to anything.
> 
> In any case, when both a '0001-my-changes.patch' file and a
> '0-tolerance-policy' branch exist in your repository and current
> working directory, running:
> 
>     $ git send-email 0<TAB>
> 
> should offer both as candidates, I thihk.  Since I only ever pass
> filenames to the command, I personally do not think it is a huge
> loss if the completion script stops looking at refs and sticks to
> filenames only, but others may have a use for that feature.

Agree. The test should create a file 0001.patch, then a tag
0-tag, then a branch 0-branch, maybe something else that is
relevant; and then make sure every option is correctly offered
by autocompletion.

Guys please let me know if everything else is needed before I send v2.

Thanks,
Yury
