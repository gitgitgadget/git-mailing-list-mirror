From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Fri, 13 Nov 2015 11:32:53 +0100
Message-ID: <5645BC55.70504@web.de>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
 <56437F96.2070209@ramsayjones.plus.com>
 <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com>
 <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 11:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxBgg-0000sf-GY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 11:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbbKMKe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 05:34:29 -0500
Received: from mout.web.de ([212.227.17.12]:62156 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932556AbbKMKdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 05:33:21 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Ljrdd-1aYAJ33NLl-00bs5i; Fri, 13 Nov 2015 11:33:01
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com>
X-Provags-ID: V03:K0:hsIofEuVrbilkThx+c+iEzVm+CBaJfoNeJH9QTva+cq/71ntH3d
 5ZiIZGiFsRkgrVI2pjqHw0zDlQ6MMfqJey1wrcfWORY5hxG/YCQXnBt181dRyvkarUzwnoX
 9DyrbjMhwN15CFT7nA77CY0hMcmxl6o96D+2wDnnGeNG5b1WH00UPqssX01eUYN6kSVBmnJ
 Bzgz8gY3oUxuGKZ9Ft8Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3J8iKhIUO5I=:Rqw+CArybGLNogaIg1diqo
 4SRGwvo4UT/Ojd15jfF3NfROQwIAeIieK3qF4fw+N7jn0ZV8oOR9k/MvazFd0YO92NzOkfjP+
 o7JN8E4mOEamDXbJ0+OY6aMvGh7XcfXaSZODeFurcSvVI+I2A/WKLxmAyi7ljj95z+mc6sHmG
 VVMy8X9LSb9DFQSZPGQ0jhIvmkxbhqnqZBoTXGbYi2rlqP0uOapn/UeBpB9P/kH/fVOqJ6MdD
 /SbaWMTbDZoWyQHscKxHU5bOfwl0Aei5kY9CrqKY/moFKd45Nz2LVAV3B6++ki975aKOYZuI3
 Fd4egU6GE88NRzcaeE+RilG+hLGO9+QZV6/iGmiA9pMQBIQbLUjofGYctVIOeNF3Hz/1+SRq+
 xKyVWoLclQoevTwYU+y3fRPSPDTDM3Zs2BgPkJgW564LOlM+uXPdWr1d+rCxmVkIQbByo0o0r
 cbl4hEHflxnSz6hhmNqQ5tO0LeWVSJWH7d6tAK4zes34leU559Wyq+nbHUDNgiVPXB7XL8Kdu
 mksndYPZQkkppFrKUWh1TsAcn9YmWAhIImPHok0nJO1k6LLFkXjOb9XpgTD9JgW4J7KX7t1q9
 lbsgoZKW0XHN8d2XsLQA9C6exJEEwLNQmbCe3duXhqICtyBd8QHZtGvIFscXReYb1OSmRrlX9
 eu3M4VVQayroX9i9C5he5AZjz2lBiyXQ9j9Ab31Y/Z3Z1h4mM8z+6qnyfno8BC0rvA3qdwjQd
 eOiCYPVuZpmmjGhkRGjiRKeKtKC8Si/SL4jlaoWzttdCCcBm6mOJlECCgnd1bDAEPyEC+1+B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281247>

On 2015-11-13 09.57, Eric Sunshine wrote:
> On Fri, Nov 13, 2015 at 3:46 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>> On 11/11/15 02:00, Stefan Beller wrote:
>>>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>>>> 02-11-2015) changed the type of some variables from long to off_t.
>>>>>> The 32-bit build, which enables the large filesystem interface
>>>>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>>>>> integer, whereas long is a 32-bit integer. This results in a couple
>>>>>> of printf format warnings.
>>>>>
>>>>> My machine is 64-bit, though, so perhaps it's misleading to
>>>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>>>> 'long long' on this machine, so it complains about the "long" format
>>>>> specifier.
>>>>
>>>> I wonder if 32 bit compilation can be part of travis.
>>>
>>> Did this warning show up on the OS X build?
>>
>> Yes, I added CFLAGS="-Werror=format" to the my experimental TravisCI
>> build and it breaks the build on OS X.
>> See here (you need to scroll all the way down):
>> https://travis-ci.org/larsxschneider/git/jobs/90899656
>>
>> BTW: I tried to set "-Werror" but then I got a bunch of macro redefined errors like this:
>> ./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werror]
>>
>> Is this a known issue? Is this an issue at all?
> 
> Odd. I don't experience anything like that on my Mac.

Could it be, that strlcpy is present on your system ?
And where does it come from ?

Which OS ?
Which compiler ?
What does `uname -r` say ?
Do you have Macports, Fink, Brew... installed ?
