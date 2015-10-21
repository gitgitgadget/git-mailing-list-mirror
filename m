From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Wed, 21 Oct 2015 22:04:52 +0200
Message-ID: <5627EFE4.1060106@kdbg.org>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
 <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
 <5627B496.7030102@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:05:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zozda-0002sC-FE
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbbJUUE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:04:58 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:22441 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480AbbJUUE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:04:56 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nh2qB0g00z5tlD;
	Wed, 21 Oct 2015 22:04:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0F5E6537B;
	Wed, 21 Oct 2015 22:04:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5627B496.7030102@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280009>

Am 21.10.2015 um 17:51 schrieb Ramsay Jones:
> On 20/10/15 22:24, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> some numbers on my desktop (Dell T3500 2.66GHz Xeon X5650 with 12GB,
>> running Ubuntu),
>
> I suspect that I haven't tested exactly the same version as you, but I had
> a quick look at testing this on Cygwin today. I have included a complete
> transcript (below), so you can see what I did wrong! :-P
>
>>
>> Between 'master' and the version with this series (on 'jch'),
>> applying this 34-patch series itself on top of 'master' using "git
>> am", best of 5 numbers for running:
>>
>>      time git am mbox >/dev/null
>>
>> are
>>
>>        (master)                 (with the series)
>>      real    0m0.648s            real    0m0.537s
>>      user    0m0.358s            user    0m0.338s
>>      sys     0m0.172s            sys     0m0.154s
>>
>
> The corresponding times for me were:
>
>      (master)           (with the series)
>    real	0m9.760s      real	0m5.744s
>    user	0m0.531s      user	0m0.656s
>    sys	0m5.726s      sys	0m3.520s
>
> So, yes, a noticeable improvement! :)

Same here, on Windows built with the old msysgit environment:

(master)             (with the series)
real    0m3.147s      real    0m1.947s
user    0m0.016s      user    0m0.000s
sys     0m0.015s      sys     0m0.031s

Although I tested 'git am patches/*' where the patches/* are the result 
of 'git-format-patch v2.6.1..github/jc/mailinfo-lib'.

-- Hannes
