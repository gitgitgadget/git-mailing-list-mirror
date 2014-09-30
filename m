From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 27/39] try_merge_strategy(): use a statically-allocated
 lock_file object
Date: Tue, 30 Sep 2014 16:04:03 +0200
Message-ID: <542AB853.5000303@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>	<1411726119-31598-28-git-send-email-mhagger@alum.mit.edu> <xmqqh9zu8ax5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 16:04:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYy2Q-0004DD-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 16:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaI3OER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 10:04:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48477 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbaI3OEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 10:04:16 -0400
X-AuditID: 12074411-f79d86d000006a97-31-542ab856cee1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 78.22.27287.658BA245; Tue, 30 Sep 2014 10:04:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741E.dip0.t-ipconnect.de [79.201.116.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8UE43Pg003580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 30 Sep 2014 10:04:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <xmqqh9zu8ax5.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsUixO6iqBu2QyvEYMpbGYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOWHx8L3vBVf6K5unfWBoYL/N0MXJySAiYSNz/tJIF
	whaTuHBvPVsXIxeHkMBlRolDDdOYIZzzTBLPp19lBKniFdCWuLK7iRnEZhFQlXgzfQ0biM0m
	oCuxqKeZCcQWFQiQ+ND5AKpeUOLkzCdgG0QE1CQmth1iARnKLPCFUeLuvHtgzcICiRITzt5g
	hdi2llHi26IlrCAJTgFrieOdO8GKmAXUJf7Mu8QMYctLNG+dzTyBUWAWkiWzkJTNQlK2gJF5
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZINAjuYJxxUu4QowAHoxIPb4Ki
	VogQa2JZcWXuIUZJDiYlUd6ulUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwztwPleFMSK6tS
	i/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvOIgjYJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgeI0vBkYsSIoHaK8/2N7igsRcoChE6ylGY45JG9/3MnGs6/zWzyTE
	kpeflyolzntqG1CpAEhpRmke3CJYGnzFKA70tzBvCMhAHmAKhZv3CmgVE9CqtA3qIKtKEhFS
	Ug2MU7f4MmxNkJSblf5fuE5HOuDk7F+p1tsDlZjiLjw1qrh+/FVygfqxYDnXZzEd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257669>

On 09/26/2014 09:00 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Even the one lockfile object needn't be allocated each time the
>> function is called.  Instead, define one statically-allocated
>> lock_file object and reuse it for every call.
>>
>> Suggested-by: Jeff King <peff@peff.net>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> ...
>> -	hold_locked_index(lock, 1);
>> +	hold_locked_index(&lock, 1);
>>  	refresh_cache(REFRESH_QUIET);
>>  	if (active_cache_changed &&
>> -	    write_locked_index(&the_index, lock, COMMIT_LOCK))
>> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
> 
> I wondered if the next step would be to lose the "lock" parameter
> from {hold,write}_locked_index() and have them work on a
> process-global lock, but that would not work well.
> 
> The reason why this patch works is because we are only working with
> a single destination (i.e. $GIT_INDEX_FILE typically .git/index),
> right?
> 
> Interesting.

Ummm, this patch wasn't supposed to be interesting. If it is then maybe
I made a mistake...

My reasoning was that after the lock is acquired, it is released
unconditionally before the function exits. Therefore, it should be no
problem to reuse it each time the function is called.

Of course, one gap in this argument is the possibility that this
function calls itself recursively. The fact that it calls
merge_recursive() should have alerted me to this possibility. So let me
check...

* try_merge_strategy() is only called by cmd_merge()
* cmd_merge() is only called by the command dispatcher

So I don't see a way for this function to call itself recursively within
a single process.

A second possible gap in this argument would be if this function can be
called from multiple threads. But hardly any of our code is thread-safe,
so I hardly think that is likely.

What am I missing?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
