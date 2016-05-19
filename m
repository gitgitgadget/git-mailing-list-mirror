From: Jeff Hawk <jeff.hawk@here.com>
Subject: since/after not working properly
Date: Thu, 19 May 2016 10:41:51 -0500
Message-ID: <573DDEBF.7000903@here.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 19:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3RYO-0003uR-0h
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbcESRP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 13:15:58 -0400
Received: from mail-db3on0140.outbound.protection.outlook.com ([157.55.234.140]:58496
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754140AbcESRP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 13:15:56 -0400
X-Greylist: delayed 4692 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 May 2016 13:15:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com;
 s=selector1-here-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=N0Yo5zcFuRlEeVw3iSTZHT1sy+e13gA/YeKTsuyQUUM=;
 b=XbiWjnjr86Bzi7xhm1sTuHm0PxHnX89nNfgu8dIdzgMCHFYTok1Vv1mB3QpR41758vZYWxJ8V/DBKYAOq4wxRj9x5vrXWDhs+LvuboUmxNmp4bs+mT2WCdpCvxfr8iUKPT1HcVxrXRvuinD5ZBST7mXLhpclxGkXisD1V2rYgek=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=here.com;
Received: from [10.228.45.43] (131.228.197.43) by
 DB5PR0401MB1845.eurprd04.prod.outlook.com (10.165.6.15) with Microsoft SMTP
 Server (TLS) id 15.1.497.12; Thu, 19 May 2016 15:42:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
X-Originating-IP: [131.228.197.43]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 DB5PR0401MB1845.eurprd04.prod.outlook.com (10.165.6.15)
X-MS-Office365-Filtering-Correlation-Id: 4d14bae0-e94d-4a79-0113-08d37ffc2f4f
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0401MB1845;2:Hp6/ZYwRIxb7TVZJI+xZ8sIKC/ejnUPAqEnNM7TnUV3puZxU7cM+PGLuLb1vvcW9RfML3ccEdrv6LqznrfBkzsLb6xldHaf8vzDJTIfMRJA2JAoskpdhOAGOYoPsQr8tXyqwsGCVlIg6kOD90JKQz2xfw1OyAOZsS8t/ydZ78Ru6dlGOuax+xNKHutZPWiA1;3:MFG527QDnLPl2vux/aasjJbfEtkKgqQggyzcXgq6dWVsoQ2FBqPkk0BMK8poRZZW8EXCfTl4yLS8ICk//TSBOx+Ods4LyXoX6Rc37FmsqDQh+9p8vofATK3Ih5dXMwN5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1845;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0401MB1845;25:M2eFCUZafuoLdGRRHs3l3zoXnkjieYct18/iYSC9O3fm7eHEHW/Pja2QIxpmE4n7th53BseMgbw/tbUzzr4UTCzVPCrckfPbHRXRUYA9AQk7YCtiq4TuT3PHZrCD6MrpyPraYiRv88XVLju7FskeECLi1rl2Aln2zzXDs01IHzGUv5nWuN7zEKqo2Acq6CD1FdDcidplGNaWYkOKIaxZpkCi33QuR2DNKMBcgwyHNOlnPnREcGJiuLKrcFk/7WTqRCiHMOP7jV8etSdFwfuPTs9auaM/jqPNF8TUx8sC8YIKemq5T2kvf9EGZaD4N8UMjJPXibw7098kZJKXL6XXe+IhZVsxv532QE0xNRX2aMtg+XadYf+cXulZgOTOuA9wj5QTDKpxekxDb8SJPEj3U+v79qNmp+3gXJOvFBwepeLvtKl7ZFoizydAFjqJt1HjMsyh2x6WR3GFmLZIfjM8Zw591zgCo0O62Vkop7GG7Stk1N5KVpWblSweuq2ISbhXHISkFnV6Vn7gBL99FAJrenAMfffgTa1YIWq4V+ZH1NXhWPElhXOM0PHLsYV9Rf2imj8Tv8EIe1vVZEdWqPIeo3pnBVYdz8yqUTUVuKOUjaUONDZUd8PKwVukMPvQwCFPArIymP+f8+A88Xw0ZNE52jytFAQTtPAve3o4Mr0r2QIJKgPeESSPLoRcFv8H9HLq/2cYuLDk4XF0GiRPVZyYVw==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0401MB1845;20:GhJkaXtnwIiRj0/fMEVxpc/PXEKzIfJhUjB4+oQDKwJROCC9SpgF+LVx+6JNc0t6W3DUvEp+z4QK4Q1mnkY0hgj1lWkOayxbWX59QtvbwzS2XHjS8xTZ2gtehdKqqXXMt72Kdindy+RJ/to676s2EyrYbdTWSm502G9fwaQ/iA44zwOc9I8HupPnMff2BXV2MWtZCUgSCeQZfWWP27ySGuMhYYVE8mMRTZQrm21cpS+708Ks0IIbvC/NzVaYQ9OCJayoSW1YHyJuDxIQgugV1DhGBFrdOxhbh1BkMigijpW+oDY8CMsQLaSYrEHC52KlsP9ZqyGZ/z9rCX2xn3i3KUVrSV/YgkbRv+Ufn6TNNQR9Casb+JXOC059hwkzhVJH4xj7a872FlTqwTzcGTVtGGjeNrybcKPcmvb6440RqE8t6FveMpeBcVYzt3ui2XNuT+jeg6eXjsclcEfdcexUwaL5iSoYMZVHnkDxx3qY5mKWlXOsvlKojrbNQ7yIxfl4;4:6hGxDG0VIJem04vHZp0bBJJG4jlDe6Qrh1rbFKtEZzk9q57+CmAW3QBo1Zq3qnxkGUAAScX8QkUHXWRzP/t6kqlea2bCadWL6Bd5XA6F42370ZXj5wQnVHpmwrI33AlR9miWFLVC2xGvkxANBrTRE0SGv7kvY1AJqDHL006Uww1BjYFG0p0KtKTuzdVN6fyglgvRN9FAVaFfEJP+pCvOKktqDjbCCoE0p31DeP
 8eixyVw81zkL/IEt45yIgTe+v9W7XSsFPKKCLUwnYY25pn8I3DPUX9PSr/KKZoxz19fZ3/PW3MMQioEBA2W3VZ7hSPxJcPTUsn 
X-Microsoft-Antispam-PRVS: <DB5PR0401MB184539D6F8342F2DADD3F9549B4A0@DB5PR0401MB1845.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026);SRVR:DB5PR0401MB1845;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1845;
X-Forefront-PRVS: 094700CA91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(6049001)(377424004)(77096005)(586003)(83506001)(81166006)(3480700004)(8676002)(47776003)(86362001)(23676002)(50986999)(87266999)(65816999)(5004730100002)(450100001)(6116002)(2870700001)(80316001)(2906002)(5008740100001)(54356999)(2351001)(229853001)(3846002)(33656002)(65806001)(42186005)(59896002)(4001350100001)(50466002)(107886002)(189998001)(110136002)(92566002)(65956001)(64126003)(36756003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR0401MB1845;H:[10.228.45.43];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjA0MDFNQjE4NDU7MjM6a1hSbk5NM0IzN2ZkK1N6SytzZEs2aWJP?=
 =?utf-8?B?eE1qeXAzTWJsRFpTdnpXRFFwTDNWUGEvVFZtdkVqaGFkZnVpRjVwSmVodGwy?=
 =?utf-8?B?VkdHM0VmYzZOYXdNUEo2ZWwwNW1kZXNhLzgwd1ZkWEpxWit3K0grMG45ZDIz?=
 =?utf-8?B?MXhoM04zakRhTno5YURMUmgzY3d2QXVVRXozNlNENWMwbjFmYUhzSmp0YnhX?=
 =?utf-8?B?QnhDWWtDT2ZLZTF6REttK2ZFL0pFaGhpa1lRaS9CaW5Cd0hQeTA5bUhaYUFP?=
 =?utf-8?B?RXBpdWRqVHFOam40Z3JKUVBGTHBQRzdXZXM2dnUzNVk5ak1yOE1WZ1lYcDky?=
 =?utf-8?B?RDJvaDJXWUNnaXlOLzhmdHU4T2o1QkVZaGFwZXVrTFVWOTFWVHhmRGVtTm5E?=
 =?utf-8?B?R25KMmZKcmNBZVA3MlArZjk2eDVvdmVwaHdEMWg0c1VSc0xIeUxHWHdrTk0x?=
 =?utf-8?B?NkMxb3hxanhVY1dMNU5lN2UrNkdEY0NIeG14UERJc0NQSjhGOGx5YXZ1MmhN?=
 =?utf-8?B?TGNaT3J1TndkWms4MFpuSDJQbXFwSjArYm1vTW81emhEWHNYYkFMSFFyOWJP?=
 =?utf-8?B?VTlLQ1VGQTNUbmpuUlJCaklSOTgzVG5SZnVseFdsQnNwbFlJWWZtc3NiNjVy?=
 =?utf-8?B?MVhhMXoyVm91QTZvcFJvcld6eGZ1K1duK25oQThQOD 
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0401MB1845;5:NcUwgKLCUVTYkJ/Yv1MjtWkNwENKK+iqn9GpJQGOqwQohnXBo72IshQzjkAy+o7gpmOzSQ96KaGJdKD+Z8NknyvyK/lA1VmlP8Ot5JCN+r3OYZ3JediBk5FR2yCVu22v1y54eQzKoNR8bYDBdSHlYw==;24:nEegs1loTojQu1iRTvte8We4vGELPRB55A2Q/7El5HhFYtvqDDwea51KBSZ2aVbJpJvcMb0NO3ep01IXlTsBC1zU7PEWEW3FMk8u+Y0Rmg8=;7:1aSZMHRn4x8e+fumkQzF6VcXxx7M5XE2ZyWnw1OyB95THeOeF3IOIou528ZKsUq5w2WTK+RwYXRytty4KwA+59m42W4mSaHbztigl3tIo42hyHjagt3ON6ayqKee9aqpSPk/sKY3nlwDgYGkE/IDqgovgp/2RT+zkkLLmUzEne9dAFBk4gXWXWppa/7paWtF
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2016 15:42:28.5314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1845
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295077>

[jeff:~/src/git] master* 2s =C2=B1 git log --pretty=3Dformat:"%ad" --da=
te=3Dshort=20
--after=3D2016-05-01 | sort -u
2016-04-14
2016-04-27
2016-04-29
2016-05-01
2016-05-02
2016-05-03
2016-05-04
2016-05-05
2016-05-06
2016-05-07
2016-05-08
2016-05-09
2016-05-10
2016-05-11
2016-05-12
2016-05-13
2016-05-17
2016-05-18
[jeff:~/src/git] master* =C2=B1 git --version
git version 2.8.2.537.gb153d2a

[jeff:~/src/git] master* =C2=B1 git log --pretty=3Dformat:"%ad" --date=3D=
short=20
--after=3D2016-04-01 | sort -u
2016-02-27
2016-03-08
2016-03-11
2016-03-14
2016-03-16
2016-03-18
2016-03-25
2016-03-27
2016-03-28
2016-03-30
2016-03-31
2016-04-01
2016-04-02
2016-04-03
2016-04-04
2016-04-05
2016-04-06
2016-04-07
2016-04-08
2016-04-09
2016-04-10
2016-04-12
2016-04-13
2016-04-14
2016-04-15
2016-04-17
2016-04-18
2016-04-19
2016-04-20
2016-04-21
2016-04-22
2016-04-24
2016-04-25
2016-04-26
2016-04-27
2016-04-28
2016-04-29
2016-05-01
2016-05-02
2016-05-03
2016-05-04
2016-05-05
2016-05-06
2016-05-07
2016-05-08
2016-05-09
2016-05-10
2016-05-11
2016-05-12
2016-05-13
2016-05-17
2016-05-18
