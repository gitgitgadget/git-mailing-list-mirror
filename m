From: Alan Clucas <alan.clucas@teamwpc.co.uk>
Subject: Re: [PATCH] Pass amend to pre-commit hook
Date: Mon, 14 Sep 2015 17:49:17 +0100
Message-ID: <55F6FA8D.6030509@teamwpc.co.uk>
References: <55F6BA1C.7080507@teamwpc.co.uk>
 <20150914144727.GA25003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 18:49:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbWwk-0007tn-78
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 18:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976AbbINQt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 12:49:29 -0400
Received: from mail-am1on0140.outbound.protection.outlook.com ([157.56.112.140]:14863
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755806AbbINQtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 12:49:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alan.clucas@teamwpc.co.uk; 
Received: from omar-linux.teamwpc.local (87.83.8.229) by
 VI1PR05MB1391.eurprd05.prod.outlook.com (10.162.122.29) with Microsoft SMTP
 Server (TLS) id 15.1.268.17; Mon, 14 Sep 2015 16:49:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150914144727.GA25003@sigill.intra.peff.net>
X-Originating-IP: [87.83.8.229]
X-ClientProxiedBy: DB5PR03CA0046.eurprd03.prod.outlook.com (25.164.34.14) To
 VI1PR05MB1391.eurprd05.prod.outlook.com (25.162.122.29)
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1391;2:hFl1vrRzyb2VwTdmATMFzxi4T+foVBQ+FcEpTFAj5bmDT7JKYhM9rahkYF/Si/tXgllIfqnFV87vwoOnH/oQL8axhU9iEZZ6x7tvdXByUMNYeAGU9OOtP52iMjMwqNXMRYaMB8Hh/482KixzS49nD3W3vRkniOnw/a7h6UQPxog=;3:YF//YLOgkq7x9hD3mc834Og10lCFRkvynRmUJj64VNzlpMb6MagMCh8MuCn7wawuoZfcSGWno1GxBZ3ZnbWIcYyuBFTtQNz5GI9BKqFBfDDz2UQ8t6xY/7a0ZjIJzdvT4W3gH/uZDutUdJbmjKKejA==;25:8nk4Ebw4Wl/tC4+RLw5JspkrQjN1KB5oaVt1AtLu8Uu6I+YrnPqpuhwy1pa/pj+bU8vMZh8c37MSFtTMrzkvAWjTpaZHhaY4WasO/kvpi2O/zbY1MSI+7zdyFm8fZtBI9knlxEVE8QKCJEuDY2rqBxYIOcO9iFhD3rVqZdxUrys4wb8VUAjKKRKqiYdckoWecMLwPcXPgElo30pPLbaRnQ5j3qB9LVchsRNI0Y1vPysDEFqiev9w9TLHRUli5pSX;20:47d3/bDHTA7o7suI09ZeDPa29eRcBxBnh3uZx61Xt3ToPoLZ1c8xwxxk+5hlRiHghRQ5KJZWgM1r6+THwvXohZa44AWai8W4QQIF5RjZyQYrYbFIjxCz9l3bmq43I+OwJ0ik1VUKkGQzY5GsPN/ZM+WyG7/7a
 jlPmzYi7ismWJdjJbcgfPDZWiehNv6CRqtSvcN2+CSrokkg5pjBNqO7+q28aBi+NlYX1cHWks5tS+ukiFkd/FZkDpKUWW9FZNx 
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1391;
X-Microsoft-Antispam-PRVS: <VI1PR05MB1391F59BAF19AA64A2710E31B65D0@VI1PR05MB1391.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(8121501046)(3002001);SRVR:VI1PR05MB1391;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1391;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1391;4:kMe93gYk8Yx+St6ZyeEYMqkcKIq5gm9c6RsAM5SYfJwd22PC1wghwkXQMndtQrIT/eDSJSI6kBDUe+y2q0maPuQcmaUHzgGdZsGNR+OY8yPGN7ahQKdcgUUbgVGTubT45eU2cOsYoeRx7asWgAsJxk5Z0IHaVcZ2gPzAqj8Jc6re/ZOJt3fKmqggWmVE27PX/YTmOrMEV1SKma3MJsS5HwY7lTWqTSGDVrzVu812ilSlqO/lMMI9AjGN//pgDP8ht9w4NyfypS+XLcKuSyv43RHVWfAYLp43XntCBR9tiy/e5oUxriXMH69h8PV9gx6a
X-Forefront-PRVS: 0699FCD394
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(199003)(479174004)(189002)(24454002)(65806001)(66066001)(65956001)(74482002)(5001830100001)(80316001)(46102003)(19580395003)(92566002)(40100003)(47776003)(64126003)(50466002)(64706001)(77156002)(86362001)(62966003)(68736005)(122386002)(15975445007)(23676002)(42186005)(59896002)(77096005)(105586002)(4001540100001)(5001860100001)(5001960100002)(65816999)(97736004)(4001350100001)(101416001)(110136002)(33656002)(106356001)(189998001)(87266999)(50986999)(54356999)(36756003)(76176999)(2950100001)(5004730100002)(5007970100001)(87976001)(83506001)(81156007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB1391;H:omar-linux.teamwpc.local;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: teamwpc.co.uk does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIxMzkxOzIzOlBQYm1JaEI2MlhTdllnMlFjaWZtYUhEZXBO?=
 =?utf-8?B?NkRXaFN6ZjhlbWhCcndjVUZPWmc3UFhkY2dsT3dUZ2JzaXNpUzhYNkpQQUZG?=
 =?utf-8?B?ZSszZS9LVUx4cGdlN2JZaDVuSmFNZU9XaEF2b0RFYmNoRlFVRVJ2L2NkMWRi?=
 =?utf-8?B?QldNQXNsSEluWDhDVFkrcUlaZzJDSEU3UmRZSjludGdxbHBtZXVYVk9WTmtu?=
 =?utf-8?B?Vk9xWnNhUXdTTERydlRsQk5DdElBWHl6aUpTbjk3Z0ZRMGN0SkVRVmpvbngz?=
 =?utf-8?B?emhmSjNENkNwWWdON0lhR1R5NDJxcFJMdmlvaGpvbkZNVUp5QjROdTJ1Y29U?=
 =?utf-8?B?aEFtL1NEVkltOUtRM1g3MW84QmtvejRGMjROdmRDdUh4VU1Ya3lBbElNR2k0?=
 =?utf-8?B?TWdKajFPTmhhYTNuZTROMm9VeTErVUk2bXZ4VXVuRGMxMURlNGw2LzFRUjZD?=
 =?utf-8?B?enR1Um9RL2wxRTNDeHRZSmpub3Z6dkZIYTU5dFJvSlFFVW5ZUVQrSDR6OG5V?=
 =?utf-8?B?QUs0MWRWTVRGdzdyRDVmbUl6U3drZHRoaXdjSHR2dWtJUmhIbzg5Z0ZvaXpU?=
 =?utf-8?B?NjFFS2xiL29WQlFJaGdadEl5QjYrVnZETmVVb3J0ZlZxblhBTzVnaDhEaUQ3?=
 =?utf-8?B?dWxPSDNXZUl3eUM2SndwTFpiViswU25YNVRTUUZPY2 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1391;5:X85fXVeCy6XiP38qNzBJGOj/CmbZZCMn+oRcJ3IdHB90Vs/+wH1ZHodBawZEii+AyNSIeCicpkADu9jxLxlEZl2ofk0qjIH41NmbtEa58PufC2XVbXlyBi4K6G+SDrb4GjNUKROCehAG9e1+dPz3KA==;24:IN5JK55mRbD8+TiLeXzacSA1wMtsoLOdPshQMGz3oiT5oIKXVp1kjOQ7aFUb4WVwmJBXNIBwpu6/5NX42rEGOXSJoryd0nZ/5TjpId2/MWU=;20:TWOfpf6gmUdvpume18xRVOZdTLhBrEOoqda50wguCHyTkDi4bJn+4H0xrDodkjwj0CgV0t6SnnJoyqEqiQtx5w==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: teamwpc.co.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2015 16:49:21.3851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1391
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277835>

On 14/09/15 15:47, Jeff King wrote:
> On Mon, Sep 14, 2015 at 01:14:20PM +0100, Alan Clucas wrote:
>
>> Pass a single parameter 'amend' to the pre-commit hook when performing a
>> commit amend.
>
> I think this is a sensible thing to want, and it has come up a few
> times. I'm not sure why the last round didn't get merged, though. Looks
> like it just slipped through the cracks.
>
> Here are the relevant threads:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/260122
>
>    http://thread.gmane.org/gmane.comp.version-control.git/260245
>
> Looks like there was some question of what to pass in the normal,
> non-amend case. I've added interested parties from the original thread
> to the cc here.
>
> -Peff
>

Ah thanks. My google-fu didn't find any of those threads, I should have 
tried specifically searching the archives I guess.

Maybe with a little cajoling we could get some version of this passed. 
The issue that came up before was my worry, I didn't like defining the 
interface that way in case it needed extending... (but other hooks also 
have bad interfaces, so wasn't sure what precedent to follow).

Alan
