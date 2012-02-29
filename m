From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 14:50:42 +0100
Message-ID: <4F4E2D32.9030209@in.waw.pl>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org> <4F4DD5C1.60604@in.waw.pl> <7vbooiuj6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 14:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2jvk-0002mX-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 14:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925Ab2B2Nuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 08:50:51 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55333 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757495Ab2B2Nuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 08:50:50 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S2jvc-0001DO-5t; Wed, 29 Feb 2012 14:50:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vbooiuj6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191833>

On 02/29/2012 09:39 AM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> On 02/28/2012 07:53 AM, Junio C Hamano wrote:
>>
>>> * zj/diff-stat-dyncol (2012-02-27) 11 commits
>>>    - diff --stat: add config option to limit graph width
>>>    - diff --stat: enable limiting of the graph part
>>>    - diff --stat: add a test for output with COLUMNS=3D40
>>>    - diff --stat: use a maximum of 5/8 for the filename part
>>>    - merge --stat: use the full terminal width
>>>    - log --stat: use the full terminal width
>>>    - show --stat: use the full terminal width
>>>    - diff --stat: use the full terminal width
>>>    - diff --stat: tests for long filenames and big change counts
>>>    - t4014: addtional format-patch test vectors
>>>    - Merge branches zj/decimal-width, zj/term-columns and jc/diff-s=
tat-scaler
>>>
>>> I resurrected the additional tests for format-patch from an earlier=
 round,
>>> as it illustrates the behaviour change brought by "5/8 split" very =
well.
>> Hi,
>> the resurrected tests are partly duplicated in 4052-stat-output.sh:
>>
>> t4014:
>> ok 75 - small change with long name gives more space to the name
>> ok 76 - a long name is given more room when the bar is short
>> ok 77 - format patch --stat-width=3Dwidth works with long name      =
  *
>> ok 78 - format patch --stat=3D...,name-width with long name         =
  *
>> ok 79 - format patch --stat-name-width with long name               =
*
>> ok 81 - format patch graph part width                               =
*
>> ok 82 - format patch ignores COLUMNS                                =
*
>> ok 83 - format patch --stat=3Dwidth with big change                 =
  *
>> ok 84 - format patch --stat-width=3Dwidth with big change           =
  *
>> ok 85 - partition between long name and big change is more balanced
>>
>> t4052:
>> ok 3 - format-patch graph width defaults to 80 columns
>> ok 4 - format-patch --stat=3Dwidth with long name
>> ok 5 - format-patch --stat-width=3Dwidth with long name
>> ok 6 - format-patch --stat=3D...,name-width with long name
>> ok 7 - format-patch --stat-name-width with long name
>> ok 24 - format-patch ignores too many COLUMNS (big change)
>> ok 28 - format-patch ignores not enough COLUMNS (big change)
>> ok 29 - format-patch ignores statGraphWidth config
>> ok 36 - format-patch --stat=3Dwidth with big change
>> ok 37 - format-patch --stat-width=3Dwidth with big change
>> ok 38 - format-patch --stat-graph--width with big change
>> ok 49 - format-patch --stat=3Dwidth with big change and long name
>> ok 53 - format-patch ignores COLUMNS (long filename)
>>
>> The ones with * are duplicated exactly. They tests run very fast, bu=
t
>> maybe the duplicated ones should be culled.
>
> Yeah, probably we should de-dup them.
>
> Compare the behaviour change shown for t4052 and for t4014 by 119c07b=
f.
> Which one more obviously show the effect of the code change to allow =
the
> reader judge if the behaviour change is going in a good direction?
t4014 it seems, but mostly because of more descriptive test names.
But this is only true for the ones without *, I think. So the ones with=
=20
* can be deleted without losing this advantage.

The ones with * are very similar in t4014 and t4052.

> The style used in t4052 only changes expect_failure to expect_success=
, and
> the reader has to accept the judgement of the person who wrote the te=
st
> vector and declared "this is the _right_ output!".  The way t4014, ta=
ken
> from your earlier round, shows the behaviour change shows how the
> expectation changes from the old behaviour to the new one, and the re=
ader
> can see and decide which one is giving a better output.
>
> Actually, the whole reason I didn't notice duplicates in 4052 was bec=
ause
> of the above X-<.
>
> If we remove duplicates, will 4052 become empty?  It would be really =
nice
> if we do not have to add a new test script for this series, and inste=
ad
> add necessary new tests to existing scripts.
t4052 tests show, log, merge, diff and format-patch with basically the=20
same commands. Separating the tests into different files would require=20
duplicating a lot of setup code. OTOH, t4014 is only about format-patch=
,=20
so the other ones don't fit. I thought it would be better to create a=20
new file.

-
Zbyszek
