Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2121.outbound.protection.outlook.com [40.107.116.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558B53814
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="FBXOhZ5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1zyy1Im2FU8Ke04EbzUEpTarixAgDeYzQBQ4VzQCaHWXsui1ldnnyTnEG5Dp2/M8bs2g7ADg7ecFSFeZfeYtnvWOc0aqKR5XLR6uW3MyFN3KEpVwi/OjOBbfIlZAy78ZLi4tbZ1Tj099F9sk96fXbCzJ3ScQAJStRptMM/LkOrbctxgIAW4qgIve2tLEp+j1y5+3VwLRYgUF/GM7zPzjXSsZ5jvRjmU/KC7Re9PTCfnh1WlDlpz8KcFHdWe9IGu4Ex+BCOwM57r2y0Wa7xRszjT0qX00H6R+INRo9Sluf4EkYhb5Qm9I8gmoJ7aG/z5KIQs22ght7i2GOkLjXv7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8t0lr0If3DnoocLwtmniLW+Lwj/w05/bq0NX+n/ndI=;
 b=IpcJLdoQHDf8XY254iwmyDaRLiH8+phmFDQ0KbD3eX3Ua0OqbFkQGIEGEctPfte3ju4FSjh07DMtv6knnITplsgF+8eqv52cPPqMAcod4tbJAOps+/Yiu57qb8JEzh+TVPfC3JoTUZhUITTpikeNocBYeXJe35WmzIxnUjqILvjEwGA4ezz+KXi5yJV8bh+3n2oR+8CfN6Y7P7bXe/E7apL7k69xr00he/tpR/vbfO1/xVFuK3T0koJA1w2U9Dgr7V+AAYYUf4XYSI6UB39D8YTxGDyYOyEBcySHrwTUw7zW0GWxjckZmenCW3+8dUd8AGe76jg9cj4u+5R+MtE7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8t0lr0If3DnoocLwtmniLW+Lwj/w05/bq0NX+n/ndI=;
 b=FBXOhZ5TTpjquNguW15USR1WKPRe5JUQeiChNMa3Ijqn1pgGYPeazWHF6D6Yxagm3JaBQOqM7n98dPCZBUluzA0ERRQciteyDmcWbU1KHQdasN7ST9xJ6MQAUGf5hBTezsmUiWb05oH5cqUfH5WkJcA2SLbEb8tiHvJMx7CfS2r3ksj0QuOgBidE82VsgaBpkmcub+k0BOULQ4dm5EzcEM1EHFDz3O7NJYHpu3i2LbQ82/ujb/t++fk+fTg6u0r7kQqlh/AwIfIMLGk+EDmSTYy7DLfKC1o6fI8tmnkOBtyAX3ab7gVNLurM10MBsbmD1t8lLmoPIGkXKY8z8k73rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT1PR01MB8218.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 19:48:35 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::777:2753:8fe1:e6fa]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::777:2753:8fe1:e6fa%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 19:48:35 +0000
Message-ID: <3717f23b-14a9-4c00-aaa9-ebb0f46f811e@xiplink.com>
Date: Mon, 8 Jan 2024 14:48:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Storing private config files in .git directory?
Content-Language: en-US
To: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <8e344dee-f84e-4a2c-835a-406ee72d129b@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::42) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT1PR01MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 627d21ea-b69b-444b-8332-08dc1082cd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFfvIZisFzuiWsVON271+zDLNLNLcl0ZA8++BqmZ4t76quuNhmGD1CQDk4nFkXISXCDl6GCXgl5lTbblbHSF80s7kg2VQilHVcOdr6m7L2wDoBb3PKUirAvNpL9MEJFiFRs6L5w9U2CJNUpHoCIKDNjK3Wz1X87xj3Rb4bMQdT793CgOX9LAf0DJPNVQZBePwcCTiRKXDswNZfH6R4CEXV8GC5nTRml23ADnrdqTzF5csL5W/I7I/fW9+YRy6KpsjfsiK/NGRpGe74r7KRyMhWDGoDG5ujGl2CIPGscAZKCewuZoATTrwoL2ba7GGMZLRg5j47ZDNa6VIbtWKe0vrf7W3X0pcN54GvWTMx/zsDGzzIKys0zZNLMuYWGpmiQKTrAGIVUlp7rPggtp6T7Zv2afGM5b0hr7rFelf5Z3uI6ZlT9dJMJl8QZn2cQIA+yO7C7VuhgXZzXQmrclIa4LGCEuD8W6KAhegoFmJAQYx73jvcBoTXPh8W2eJgpvH+HEIBMdDlD8Y3wA5RZM5EMOSUoXQhzi7+ntkpmRp1z9UPPqysXYQPTek8x/fIU3w/xgBzNa78CBVjdsUSyIslostT0KHYCRNWCD975PtZBZP3YTWAfwkLy2QDhH+s0K7XimfMl0TpyEYR0MTjUc8ep+0NDwPE7TzMYZ3YKRPBEOsu/zzfYFhJA30jKrV/QSAtqC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39840400004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(2906002)(6486002)(2616005)(66556008)(66946007)(66476007)(26005)(41300700001)(31696002)(86362001)(31686004)(5660300002)(36756003)(66899024)(316002)(53546011)(6506007)(6512007)(83380400001)(478600001)(8676002)(8936002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTFjUktqU3M0aEU0YThzQjBzWGZHL3JkRnd3QmpFZEx4MW01U0pMN3JWV3NP?=
 =?utf-8?B?bnErN3NITjljeTZSUGxuY3FPdWpKTlNDcDVhZDVKNm1oV2FUL1NoVzJIRitU?=
 =?utf-8?B?bGVEY09rdjNEa1FzTjAvY090S2Rvdnk4VzNJYkJXV1BpNWdZVFV5c1ZHcVA0?=
 =?utf-8?B?QUIzb25HWVRvY0RmbnA1TS9Ea2I3dURXdFJMblFvTWdnR21vR1JzaDJTNm9W?=
 =?utf-8?B?MFRHbnpEWkJuR2tHUzhwZzBPdkFXTzNNeFRxaVd2M0MzYjJFTHptVHBUN0Fa?=
 =?utf-8?B?MXBPUitMQVliV1ZyZVpJbElFRHRjTUdHV283K1ROU3lXSjhwamlrZjJaMlRC?=
 =?utf-8?B?M2JweTk4NjAyZFhySGI5aVJtWTRTWmVlOFBybEhoMUdCY0FHTmZvaTFqLzVO?=
 =?utf-8?B?OW9qMzJEQ1lUY2xiSng2dXRmbFdxU1FQZ1dGak1hU3hNVUJRZXBlU01Na0Vz?=
 =?utf-8?B?SjBEdEJRakJYN2J6dFBVQ0Jqa3Y0ZEcxT0lwOTZ5UUdBa29kUUk5dG5jVHA3?=
 =?utf-8?B?YUI0bjFtZkxPam9Pb0Q4WTUrMWNubzFmY3pjR3ZqL2ozWmI4TkdJY0VHM1ls?=
 =?utf-8?B?bkIzdm50N21uUGliSVMxM0Vjd2NxeGhLRk1udGpuZWJ1RVVSNWk4MnczLzVI?=
 =?utf-8?B?VHFjQjVLVFdieTZsWW5POGVwWHJLbktrbktuV1Z4MjdLUy8xQSs3cmlqWkEv?=
 =?utf-8?B?WTQwYkVVQVNGeTVlenBjZWpXYllBdjJrQlU5a0plTzQ2MWcwTHB2N29Lbit0?=
 =?utf-8?B?OEo2TEdrY1pTN09QM3c3dDF3cTR1MVVBOUNEQ3NCdXdjZlhiZlREVE94ZDg0?=
 =?utf-8?B?YkZ6L1F1QVdFZzYvWldIRm8rQTZtcjNCNnB3YWdscVBqNXozcXZQL29rNkly?=
 =?utf-8?B?RDV2SEIzdHg5Mys3ZUYyWk5NMDdTSGVRYTdqY2M4MFUyUGpkdmIxOUdyMGVx?=
 =?utf-8?B?cWEyWHlPbVdrWUsvejJ1SGlXNk5ZRlQ1MnIzRnoyUUJNZ1c4ZDBIMXQvWmhH?=
 =?utf-8?B?MUZ0aE51K0hQaVFTR3NLQlI0YXBlWC9LOW02cE1WaU5xcitjbUR4aHQ2ZHVS?=
 =?utf-8?B?a0QxZXZKa09Pb3MxY3c4MC80eU5JWUF6WmhuOTdxaWlyNU5DendDTEJrQUtm?=
 =?utf-8?B?MnFrMnNjYVZnbVM2a0NyeHF4dlZTZjExMnNIbTZmdHBDeHRuM01XZUc1RG8w?=
 =?utf-8?B?b2xLbjFicVc1TG1HVHp0eWR5UE80bHo5MEhzYWVxZVZjSmZRMEhWTHhiNGh3?=
 =?utf-8?B?WUxxZGF5d0xiMWZuVFc5dTJyTVF0V3greEhpbittaTIzb25Ic3RRR25lOGIz?=
 =?utf-8?B?NmF3Sk1WVDlONGIzeGFvOFdxaDdZM0tWSkhGNFVxRVFaN1EwTStONWlPYzlB?=
 =?utf-8?B?N1lNRXA5TVRIaktMWVR6SVVRQTlnTEJ2bmFJQmZTTHFBRTJRc3JXWDM2ZE9a?=
 =?utf-8?B?cStteFdLS29MQkJHSzJ4dytUZ1U2T3NEUTBUQXRHaDJOSlR2QWQrUHlUcnNt?=
 =?utf-8?B?TEgvQW9MVlNLRjZVbCswTXJtTFNVZ1cwQ1lOSmhoTDhXR0FaSEF5TXVYZk9U?=
 =?utf-8?B?QkZiMFJtc1J3SUFES2NHRkIzd1dNVWNLZE4xa05XK29TRDBvSkJLdXNPUk5Z?=
 =?utf-8?B?L1FKWVNIelkrU2FwWVRCbC9CWTRKYVdZY2Jxb1BQVDcrNmJISXdzd214c2JW?=
 =?utf-8?B?ZXVQSXROYmxWaDRqRnZkK2hZZG04M0ZvL290Zmw0RWxtejVVNTNoeFNpWEox?=
 =?utf-8?B?UEk0M1JqT2FML1pqbkZUSU9ueTdmcW1rL2ZUQlYzS2laVVc1NGF0SmR3V2Vm?=
 =?utf-8?B?OC9kUmVVZ0hyUWluMUlGYjN3RmFTU3A1L0tKcWJzK3lvTUhZY2hNZ0NRdjZH?=
 =?utf-8?B?WnlpOHhGbVI3RXBiSjFjWnRneHJMNnpNSXMxUmpiZlpubEFZcGNTMVYwWGh5?=
 =?utf-8?B?cjRWZmorYzdNcEcrblljYTZiRkxoUWRVdmY0QlpUeG9iN29pTm1XakZaOXVT?=
 =?utf-8?B?Tmk1T3FBNlRPd3E3SmFtUXVYWnZQb1hGbFNWSXpERkJpTDQ0OXl5OWh6ak1N?=
 =?utf-8?B?eFludElRRTJHbVB1NHhWQ213RGQwcUFVYytYZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627d21ea-b69b-444b-8332-08dc1082cd2e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 19:48:35.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wituqO9Vr1MLVcL3k/CmE7wdVoju0jZ/7h8IphRYZqHxzdkilsDxUEqFruZo6vz9sMI+28t9ux0k01u2gCJLPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8218


On 2024-01-07 08:03, Stefan Haller wrote:
> Our git client (lazygit) has a need to store per-repo config files that
> override the global one, much like git itself. The easiest way to do
> that is to store those in a .git/lazygit.cfg file, and I'm wondering if
> there's any reason why this is a bad idea?

In a worktree (created by "git worktree"), .git is a file not a directory.

Worktrees are designed to each have their own .git directory, which you 
can find with "git rev-parse --git-dir".  If you just want a single, 
repo-wide config file, not a per-worktree config, you probably want to 
instead use "git rev-parse --git-common-dir" to find the "main" repo's 
.git directory.

The problem of finding a worktree's .git directory goes away if you use 
Git's own config system, though.

> Another alternative would be to store the config values in .git/config
> (that's the path taken by git gui, for example), but since our config
> file format is yaml, this would require translation. It would be trivial
> for scalar values such as int or string, but I'm not sure how well this
> would work for more complex settings like lists of objects.
> 
> Any thoughts?

YAML is a horrid little format (hey, you asked for "thoughts"!), and 
IIRC Git's config file format only supports multi-line values with 
\-escaping and similar patterns, making it nearly impossible to directly 
embed YAML in Git's config file.  Ideally, if you do use Git's own 
config then you really should just drop YAML altogether.

But you have a couple of options without going so far as translating all 
the YAML constructs you use into git-config ones.  For example, you 
could replace all the newlines in a YAML blob with \n to make a 
single-line value that you could store in Git's config file.  That 
complicates hand-editing the YAML though, if that's a use case you care 
about.

But even if you replace all the newlines with \n, in my experience there 
are always corner-case clashes when mixing file syntaxes (e.g. quoted 
strings are often problematic, and maybe some of your YAML values are 
themselves multi-line).  If you want to use Git's own config file but 
stick with YAML, and you really don't care about directly editing the 
YAML, I suggest you encode the entire YAML blob in a robust single-line 
format, like base64, and store/retrieve that using "git config".

You could still support hand-editing the YAML with a command like 
"lazygit editconfig", too.

		M.
