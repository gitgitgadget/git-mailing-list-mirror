From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/12] t5524: test =?UTF-8?Q?--log=3D=31=20limits?=
 =?UTF-8?Q?=20shortlog=20length?=
Date: Fri, 08 May 2015 12:07:29 +0200
Organization: gmx
Message-ID: <8e34bc9ea27d147f86de0cf60141687a@www.dscho.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
 <1430988248-18285-12-git-send-email-pyokagan@gmail.com>
 <05adfac12cb9a7ad183281974d991e00@www.dscho.org>
 <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
 <554BB93A.3090000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 08 12:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqfC2-000237-Am
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 12:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbbEHKHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 06:07:38 -0400
Received: from mout-xforward.gmx.net ([82.165.159.13]:57991 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbEHKHg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 06:07:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LzKyn-1ZLifD2BFp-014Wgj; Fri, 08 May 2015 12:07:30
 +0200
In-Reply-To: <554BB93A.3090000@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:N16YgYQGzB3szer9n19LVLhBBb/XbZlo06N09dS9jR2Mvyn6cMO
 SjM9jLQys9RMZrsP26s26ZAnxtqWR6yl5TImSCt9BBT0jPC6mLDQbW7tTfd68mhPw/nd1uK
 E/aPtBYKvhfVAykaBNsb9x16zd89XPIrSGhsUpEJIq2ZOoe7zBfrQbgGAueTPq3moBfSIVz
 VZXQQs9zxZPFJLEgH9ymQ==
X-UI-Out-Filterresults: junk:10;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268610>

Hi Hannes,

On 2015-05-07 21:12, Johannes Sixt wrote:
> Am 07.05.2015 um 19:06 schrieb Paul Tan:
>
>> On Fri, May 8, 2015 at 12:28 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>
>>> On 2015-05-07 10:44, Paul Tan wrote:
>>>> @@ -32,4 +35,18 @@ test_expect_success pull '
>>>>   )
>>>>   '
>>>>
>>>> +test_expect_failure '--log=1 limits shortlog length' '
>>>> +(
>>>> +     cd cloned &&
>>>> +     git reset --hard HEAD^ &&
>>>> +     test `cat afile` = original &&
>>>> +     test `cat bfile` = added &&
>>>> +     git pull --log &&
>>>> +     git log -3 &&
>>>> +     git cat-file commit HEAD >result &&
>>>> +     grep Dollar result &&
>>>> +     ! grep "second commit" result
>>>> +)
>>>
>>> I think it might be better to use `test_must_fail` here, just for
>>> consistency (the `!` operator would also pass if `grep` itself could not
>>> be executed correctly, quite academic, I know, given that `grep` is
>>> exercised plenty of times by the test suite, but still...)
>>>
>>> What do you think?
>>
>> Yep, it's definitely better. Sometimes I forget about the existence of
>> some test utility functions :-/.
> 
> Nope, it's not better. test_must_fail is explicitly only for git
> invocations. We do not expect 'grep' to segfault or something.
> 
> Cf. eg.
> http://thread.gmane.org/gmane.comp.version-control.git/258725/focus=258752

That link leads to a patch that changes `! grep` to a `test_must_fail grep` and is not contested, at least not in the thread visible on GMane. Would you have a link with a more convincing argument for me?

Thank you,
Johannes
