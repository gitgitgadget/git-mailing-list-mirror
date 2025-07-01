Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711E27F166
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389149; cv=fail; b=Z7qqgc2H5hw9FE3T1cecRnbOUN3unHeQxX0ouw6wKrN3z59ZXc98eTwF1etFhnZHwWxY5ryRRZcVgZJG0lmVixPtix2EhNuuQHFloBA5m/DmjXSuU/g/AOukpvfPYeoHW8NGaiEiuDCPRLlgwK0KW9HP11w8xxG5YikP2mx+VUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389149; c=relaxed/simple;
	bh=8A6sjBiTk9MFLp+NJqFTRfkbbeavtbzerypl2zjh2WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tStahHjogieFocEUfgjYBXuUr0rhhaDkS9hvfpfR9mZs/aEFn0+q2WRvbGpx9nltbLUdkdJSSGVc+C1huhfapDmg+lF7f9GSfGUfRYkBTf5DY9YtRHtJE2cQxr/QTEOh60Dun5JlfnJbppn2YMQHlF24we8zxyFivt8jujOjnPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=otRC5Y9L; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="otRC5Y9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AysEfr55Ug4i4Yemm9hDxMM01cuktu8agVIIaOVrs+HVAmgY6E/FTphEfshm//qy2IbLyX6YvFZJxWMt+XbQKICyF5fvN/paZefPdA4LvjIujTHrRMRc56Buv/VOQmmLXqjKdQTENXtZDv+XkX241O0DBMxpahoRhP1yVbQGOh1CvKSFJYPwUryLUxsuWbx1+ABJjWSqJw1Mlu1MUYuo3ZDRE6u586OxW/NLoiEpQHTZDttRYfQ62s3crLIha9ypMNdHBtifAva6UoWe5g2WxDORRErE23aZTr2sE/7wG48acJKxVO0t2RjVnEp4+FAnpn7M5Ls2QjYjvqqp9ERtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3fEzbo12auqMbVpnS2mwr9Od53xfy57qxtI8uqq8+Q=;
 b=bNFPCzkZvDsSAgfoH4xcHF/uFko+l1xVf9JtXCY8KqePOAGN9f3GZELVxDkMlLQfc3qhQYKcuXSqDJ/QAVpR4yHsi5gTv8xsrLTRXer2uZtIbKCNSv7S/n4teb8TzGOMKTOC4p+S6ATF8PCPjt/RNomKtCPHpFUvl+60WDc/7irxwG48QKtIODWkECNKlNdXaI7tAGfREZaCPm987twJgJSSCtOOHZEA4HunDpbJ30VXeiPa3c6FbZvOALdko/BlHSWtiJIIeS6kbEVil2+zYye8h0IBKqIQpsr7p+s3ocdg+MMGdJkpUBWbcDDoENfs05VjNDVvcPGV9h6EE+pY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3fEzbo12auqMbVpnS2mwr9Od53xfy57qxtI8uqq8+Q=;
 b=otRC5Y9L5OeNMyRWKZVzwaepxj8E9/W5vWQGho9i1tnYg6aJyiRRQtABbc1vlmUhRs3b4/QiMaJ6SN+MGnLdXxp/Jwn/FKvITYu32iPfXhDvAQ6/9cAnWwiDB+VjYZVH1YyIcGclpcpOe2kJ/eswjXdDtJ2K6fiDldzevp9zUOF4eSy29V58Dzb0EdZWiIFcF1FuA1kFcFRCTlFlR7gmiuD9Q+vbhHVWL9htNdhJq5KbtrW38uXMnWvv1uo8ioagi8320k393+kwqN+rAku7RJth885KSUEhmKvP/w4hCBJKt/B3ouCmKbg7RuWFuPOcH/MzBffbnBmY+Ocqmca0zw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 16:58:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%3]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 16:58:53 +0000
Message-ID:
 <PN3PR01MB95976A4B664ECB1EEB80D215B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 1 Jul 2025 22:28:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <610f64a5-015e-b2d8-03ea-78bb623f6af0@gmx.de>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <610f64a5-015e-b2d8-03ea-78bb623f6af0@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <e749489f-bac1-4601-818d-083de0a6f646@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2dbb59-e637-4992-210d-08ddb8c08ee9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|461199028|6090799003|15080799009|19110799006|7092599006|440099028|3412199025|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHJmZEkzY3VTcTZuM2lOT2JJR3VjYmhhS3VzS09JYXBVNmtodExlZ3JXa1ZF?=
 =?utf-8?B?dnd0ZmdxSHloUGRhd2JTdG0xWVJRMlRrUWxPYmhnQUlUVTJPMUVPY3ZzdjQv?=
 =?utf-8?B?cFRyNUpxdnJ3UUlPc2ZsSnBPWGlRajNWUzJzMXpsdDRCY1d3MWh6U3VIbkI1?=
 =?utf-8?B?b3d3bG9mdjZGRG9YbVhWVnVqWnJycFZCUkZsMlVWNEJ6TnV1dlNJZGFxSkJZ?=
 =?utf-8?B?SGFsU1N5WE5vbThuekZwYVJCR3F1RGRuamFSb1ZScUFTQjdmb2V0dGhqdTFE?=
 =?utf-8?B?cUNlT2w4NmhFaUdqTE1aajdRRkg4WHpaUkZhc0xDM3NjOE5oSTUrRGFqODBv?=
 =?utf-8?B?WGR6NlJTMzR4VHB3OUxzM3d3SDFhb29HT1QrcldWZlczSmo0c0hSbU55Mkpu?=
 =?utf-8?B?aHR4RVZuY2hUaG83Q2E5VnlZbU1xc0pSVjBJZmJrRFg2RFF0Q2V5eW13cVRI?=
 =?utf-8?B?TWU2QzYyb2ZIU2RUTThiMWJydFNlTzJPOSthdFBjRkkxY1NmS01jN25vTTMw?=
 =?utf-8?B?dkxTRERGKzNPQkRHM05nNVBtRXpDWmUrbmZTK0VsVm5HTjg2UHJNZFl1SGlT?=
 =?utf-8?B?MDU4Y2tRWUNHUEFCSlJkTzc1aFhqYlBWendPZ1hudEhlZlg2dWVFbHc4d0xF?=
 =?utf-8?B?enI1VTVSbHlMeUNKbmlGYzFGeGI3OWxHTDlGYnhlTFJiSks1QTZUcmNaMWl4?=
 =?utf-8?B?aUIwRHBtVUE4NnA5cjFzc2Y5Q0ltaHczWXpPM251YUxqMXJtWnlFRUpnT1gw?=
 =?utf-8?B?RXpXMUgwWnVxVEpIckM2TGMzSmZpY1BQenRTU3lsK3E3QmxldFdlWDdZZUsr?=
 =?utf-8?B?TTEwNkNUbHY0V0JBQnpLNUhsQ2pxWEx0MVY5SXY5QTFhQW1NZjRtTlM0REJY?=
 =?utf-8?B?Q2p4dUJ4QTZOcUVZaDNVWEp3UUtjcnpvc0tkNVhJR3V5VDZTeE5oZ1NNdCtE?=
 =?utf-8?B?b1IyTWxCcG9YWmFmbm9LTzlkR3JyQTdwRDhCKzJocG16Z0J6YU0vZEhaek1U?=
 =?utf-8?B?YlZ4bDloMVdGNSswb29POE5nRzVRbThwVTlOanZweWxOd0xndXJrRm1VZ0tx?=
 =?utf-8?B?U3gwZmN4QzlZSHZMbW5zZ3I1SWxQYm5yYThWZmFYNktmSzVqMWswd3IzMnZm?=
 =?utf-8?B?NnJqWUQzKzl0UHQyaHdsOHFWTWJoYWJ5LzRSWVpidGF0N0xYWUNsWTFMT1lO?=
 =?utf-8?B?c2tZYUpBalQ4bXJySHo3STZvUDdqZU9TU2o0L0xnZ3B2QnBBUFU3ZDlmemZm?=
 =?utf-8?B?N0w0cFB4eFRUa0hBNTM0SFpqZ3FKWjFZOUtQYVNOdndrWnA2aVVjcTkyZzJG?=
 =?utf-8?B?WFJNcUtQeC9lTGlzalVpMTFFSGxvOEhlSXU1bXZkSDZUdXhLOWtBV1lxWXR6?=
 =?utf-8?B?MGloRk94V0hEbUdNQmlTS01VKzNhR0ErOHZLcHczdmgwTVlvMUN4K0pNdnpD?=
 =?utf-8?B?SXBQbXpuMXpnekIzR2RXTXFmeGlmb0pLSkpFQ2o4S1E2UlpFNHJYbkdzWVNz?=
 =?utf-8?B?MnFPT0JPM0d3ZlZRNlNDUG9IRGZ4VDJkUThkazFFc1A0cTd2dGROczVTb0Yw?=
 =?utf-8?Q?z3tJSJU/W2opfiRQKL7BzEtQY0URBlQ3vJ4dYu9Mz5WQy3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVKbmNmcXliTEhNWnNwWTVhOWlKeDlEMlRnZnAvOERnUEFzbU5Bd0dwck96?=
 =?utf-8?B?WU1wZkQvSFllbzlWQjlqOEorZC9ZZ3JPSTVoTHlkTTNzcHYzRGxtbHJOOG0y?=
 =?utf-8?B?amhYbW12d1hhdXRiVWgyZ3dLY3VRUHNIQlJ5c2ppTlNPbFJUMEN2UDBiblhZ?=
 =?utf-8?B?K3VjY3RrQUpLQUdqTXhiYlh5ZnQ2ZW5aL3RpVjl3M0U3b2ZVY3JXYWNaS1Rm?=
 =?utf-8?B?UE5oM2tLNWorSEpBSDJSbmVPTXFna0szK2hNcmVpb2Y2alNVMnBYWTdhOGVC?=
 =?utf-8?B?SU5relZMdEFzZG5pcDlZV2l2VlRTL0JvU2lSSFhIVEtLWEExamlhak1KNXhD?=
 =?utf-8?B?eEIzbGFOdGtCMDM2VDBZS3BvcE9zQXNNN0lZNmplL0REdTJMeGJXNUNVSTIv?=
 =?utf-8?B?OTBrK042SVU2VWhBUXVRcVEzeElmWnhGM0FQeVBOZm83MjhrZmxBTXlhbTAw?=
 =?utf-8?B?MXJydjFpak1lQnNDS29rYWdXSDVsUENveENTUWt6M0hHQnNPbWV1ZU1LUW9k?=
 =?utf-8?B?N3l5TmZIREhhaUxSbnluK3FtNzN2YVQ4dlBiY3NaSFZmWVlodkpVdlkvNisx?=
 =?utf-8?B?RVlVMlU0VnJHOFB5Q0RRWmFPYzJJdVZFWmlSMGxNTVduVEY4cEdZMVFxckt1?=
 =?utf-8?B?VGovVDZaWEtkdkFPd2N0ZTRNL3A3SURnNzExZmtOVSsxbWJOeHduQ3ZYM3BJ?=
 =?utf-8?B?VDVYMU1PejlBUzh4TTliREhQalJlLzl5N3M1MzhzV013Y25kYVlxM2luWDFs?=
 =?utf-8?B?UWZ6aVRIOURPMVA5RnFCT0VQVDhqTWRadUl0V1ZGL1NBMjV5dUdHeituYkJC?=
 =?utf-8?B?YnlkUkV4WS9oeDVEYWlXUWQ5QkU5Ykc5c2xxVlgxYUZWRDZoYnFJbmxoby9O?=
 =?utf-8?B?dEVSY2IzT3RjWmxBRmNvZ1A1WWdUWW93cXQ1QXJ0VWRNa1RqQXdvZjRJMzdX?=
 =?utf-8?B?a1ByWnN1OVR4ZmlsdG9acGE3ZFFFR3dOYVlCcTNPczhDWDk2RG5HQWRDMm8z?=
 =?utf-8?B?NGNhYmQxQkRGSFBpOHdNdWdObW5lM3ROVzdZOTY2OTFJK3htU2lKdG5YQVdw?=
 =?utf-8?B?dzRibXI3SXo5MFlNakFKQmdxejU3R2ovbTBnbjBHWFlqNnR1Umd0OGh0Nzk3?=
 =?utf-8?B?aHFYbk5PNHRjY09XbXFxeXhvL1FSTXpoUlVLTzFzYnRDcTJiVDRVV3lDbGQ2?=
 =?utf-8?B?aXdkNFJCUFdrajh2Z0lQTFJqYXY3NUFmMHdCbEJ1Mi9YdVRSdUJzblFvalUx?=
 =?utf-8?B?K29CQWRtSmxiWU9WT2ROWGk1U1FvMnhvUFpPSC9KUTdQSHZvSmUvMlFXam1O?=
 =?utf-8?B?Ynl2MmxYbzM2Rkh5RTFpSVMyem1aQloyZjJkY1h4SjM3VTdDL1VJV3drQVZR?=
 =?utf-8?B?c3hPRWhHN2Z5QTZybllGMVl0UklpU3NFNENlNHJBYUxXWW4wTHZaZG5EOExs?=
 =?utf-8?B?Sk42THorSkhpUG5aeXJwcWgvakdhZzBBa0QyeXFHSmVPaEg0d2pra1FuZ3I1?=
 =?utf-8?B?UHhZT2x1bDJDT3dMN3YvWXRhYkU1dUV0alR5WGpnNWdFOG1EUU9ZQkhtaEkz?=
 =?utf-8?B?WkFaZVZTTkNWcVE2UGNWWUxIamRYSzM4dVJjNzF3eWZVMXc1TFZNeDlSQlNu?=
 =?utf-8?B?TC9SRzRYY0VtUXJqNEpmUitCb3R6Z2VrTTlod0lmYndaRiswS3BuRXdwZVdx?=
 =?utf-8?B?a3BzelFhRmZPN2paTXpLdUhuT0FjUjZzeDkwVTA1UEV0RXJNSSt5R1NRdHdh?=
 =?utf-8?Q?ZQtXMZaDgBn+tyXS/YBTznMBwbau9U0TGWz+XjQ?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2dbb59-e637-4992-210d-08ddb8c08ee9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:58:53.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7035



On 01-07-2025 10:11 pm, Johannes Schindelin wrote:
> Hi Aditya,
> 
> On Tue, 1 Jul 2025, Aditya Garg wrote:
> 
>> I am having this issue with Git for Windows that in case I configure a credential helper by following the git
>> credentials documentation (https://git-scm.com/docs/gitcredentials), the Git Credential Manager still pops up.
>> I simply close the pop up window, and then it seems to be getting the password from my credential manager.
>>
>> I removed it using git config --edit --system, but after every update, it pops out again.
> 
> As per
> https://git-scm.com/docs/gitcredentials#Documentation/gitcredentials.txt-helper:
> 
> If there are multiple instances of the `credential.helper` configuration
> variable, each helper will be tried in turn, and may provide a username,
> password, or nothing. Once Git has acquired both a username and a
> non-expired password, no more helpers will be tried.
> 
>> I wonder if some proper fix is there for this.
> 
> Yes, from the same page:
> 
> If `credential.helper` is configured to the empty string, this resets the
> helper list to empty (so you may override a helper set by a lower-priority
> config file by configuring the empty-string helper, followed by whatever
> set of helpers you would like).
> 
> So the trick is to call `git config set --global --add credential.helper ''`

I wonder if this is a bug in git for windows?

PS C:\Users\Aditya\git> git config set --global --add credential.helper ''
error: unknown option `add'
usage: git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<value>] [--fixed-value] <name> <value>

Config file location
    --[no-]global         use global config file
    --[no-]system         use system config file
    --[no-]local          use repository config file
    --[no-]worktree       use per-worktree config file
    -f, --[no-]file <file>
                          use given config file
    --[no-]blob <blob-id> read config from given blob object

Type
    -t, --[no-]type <type>
                          value is given this type
    --bool                value is "true" or "false"
    --int                 value is decimal number
    --bool-or-int         value is --bool or --int
    --bool-or-str         value is --bool or string
    --path                value is a path (file or directory name)
    --expiry-date         value is an expiry date

Filter
    --[no-]all            replace multi-valued config option with new value
    --[no-]value <pattern>
                          show config with values matching the pattern
    --[no-]fixed-value    use string equality when comparing values to value pattern

Other
    --[no-]comment <value>
                          human-readable comment string (# will be prepended as needed)
    --[no-]append         add a new line without altering any existing values


Or you meant by --append as per https://git-scm.com/docs/git-config

I anyways manually added `helper = ` line and now it works well! Thanks a lot.

