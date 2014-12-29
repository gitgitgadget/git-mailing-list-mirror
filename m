From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git update-ref --stdin : too many open files
Date: Mon, 29 Dec 2014 02:28:00 +0100
Message-ID: <54A0AE20.4060806@alum.mit.edu>
References: <54954E44.1080906@dachary.org> <xmqqoaqv8jmi.fsf@gitster.dls.corp.google.com> <549A20B8.3060805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Loic Dachary <loic@dachary.org>
To: Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 02:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5P85-00061O-9a
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaL2B2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2014 20:28:11 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:65199 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589AbaL2B2J (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Dec 2014 20:28:09 -0500
X-AuditID: 1207440f-f792a6d000001284-e0-54a0ae229acc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A7.0D.04740.22EA0A45; Sun, 28 Dec 2014 20:28:02 -0500 (EST)
Received: from [192.168.69.130] (p5DDB08D1.dip0.t-ipconnect.de [93.219.8.209])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBT1S0Em023010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 28 Dec 2014 20:28:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <549A20B8.3060805@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqKu0bkGIwYsHxhZdV7qZLBp6rzBb
	vNruY7F5czuLxZruHUwOrB7PtrF67Jx1l91jwaZSj4uXlD0+b5ILYI3itklKLCkLzkzP07dL
	4M74dHIJU8EvmYpbt+ayNjA+EOti5OSQEDCReNF7mg3CFpO4cG89mC0kcJlR4uQ6gS5GLiD7
	HJPE/Su/WEASvALaEjsONbF2MXJwsAioSsw4JgsSZhPQlVjU08wEYosKBElcadnMDFEuKHFy
	5hMWkHIRgWqJh9e9QcLMAhYSDT/nMYOEhQUsJf7sC4bYWiax5spOdhCbU0BTov3dA1aIcj2J
	Hdd/QdnyEs1bZzNPYBSYhWTBLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KX
	m1mil5pSuokREtb8Oxi71sscYhTgYFTi4Z1wbH6IEGtiWXFl7iFGSQ4mJVHeg2sWhAjxJeWn
	VGYkFmfEF5XmpBYfYpTgYFYS4TUqA8rxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphak
	FsFkZTg4lCR4S9cCNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjS+GBilICke
	oL0zQNp5iwsSc4GiEK2nGBWlxHnbQRICIImM0jy4sbBk9YpRHOhLYV5HkCoeYKKD634FNJgJ
	aPCsg/NBBpckIqSkGhj7mxYenb/tzqzI8AOTL79aLbDp2ZVjM6z/7mXa6mMpJFt9tfCuPcP5
	uijxA7dNo6ofHDsRpMSyvuP564SAQ0HHQmeLKn+c3lfVzXFun8v/1wa7d3ZO/avF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261857>

On 12/24/2014 03:11 AM, Stefan Beller wrote:
> On 22.12.2014 13:22, Junio C Hamano wrote:
>> Loic Dachary <loic@dachary.org> writes:
>>
>>> Hi,
>>>
>>> Steps to reproduce:
>>>
>>> $ git --version
>>> git version 1.9.1
>>> $ wc -l /tmp/1
>>> 9090 /tmp/1
>>> $ head /tmp/1
>>> delete refs/pull/1/head
>>> create refs/heads/pull/1 86b715f346e52920ca7c9dfe65424eb9946ebd61
>>> delete refs/pull/1/merge
>>> create refs/merges/1 c0633abdc5311354c9729374e0ba25c97a89f69e
>>> ...
>>> $ ulimit -n
>>> 1024
>>> $ git update-ref --stdin < /tmp/1
>>> fatal: Unable to create
>>> /home/gitmirror/repositories/Ceph/ceph/refs/heads/pull/1917.lock': Too
>>> many open files
>>> $ head -20 /tmp/1 | git update-ref --stdin
>>> $ echo $?
>>> 0
>>>
>>> The workaround is to increase ulimit -n
>>>
>>> git update-ref --stdin should probably close some files.
>>>
>>> Cheers
>>
>> Sounds like the recent "ref update in a transaction" issue to me.
>>
>> Stefan, want to take a look?  I think we do need to keep the .lock
>> files without renaming while in transaction, but we do not have to
>> keep them open, so I suspect that a fix may be to split the commit
>> function into two (one to close but not rename, the other to
>> finalize by renaming) or something.
>>
>> Also the version of transaction series we have queued seem to lock
>> these refs very late in the process, but as we discussed privately
>> a few weeks ago, we would want to move the lock much earlier, when
>> the first update is attempted.
> 
> So I decided the first thing to do was to put this case into the test
> suite. so I typed in good faith:
> 
> test_expect_success 'but does it scale?' '
> 	for i in $(seq 1 1234567) ; do
> 		git branch branch_${i}
> 		echo "delete refs/heads/branch_${i}" >>large_input
> 	done
> 	git update-ref --stdin <large_input
> '
> 
> And there I have problems with my hard disk having more than a million
> files in one directory. So once I get rid of that I'll come up with a
> better way to test and fix this problem.

I suggest something like the following to demonstrate the failure. Note
the attempt to set "ulimit -l" to a lower value to make the test more
tractable. (Given that change, sharding the references, which is also
demonstrated here, is perhaps superfluous.)

test_expect_failure 'big transaction does not burst open file limit' '
(
	# Temporarily consider it a failure if we cannot reduce
	# the allowed number of open files:
	test "$(ulimit -n)" -le 1024 || ulimit -n 1024 || exit 1
	for i in $(seq 33)
	do
		for j in $(seq 32)
		do
			echo "create refs/heads/$i/$j HEAD"
		done
	done >large_input &&
	git update-ref --stdin <large_input &&
	git rev-parse --verify -q refs/heads/33/32
)
'

After the bug is fixed, this can be changed to

test_expect_success 'big transaction does not burst open file limit' '
(
	# Try to reduce the allowed number of open files, but even if
	# that is not possible, run the test anyway:
	test "$(ulimit -n)" -le 1024 || ulimit -n 1024
	for i in $(seq 33)
	do
		for j in $(seq 32)
		do
			echo "create refs/heads/$i/$j HEAD"
		done
	done >large_input &&
	git update-ref --stdin <large_input &&
	git rev-parse --verify -q refs/heads/33/32
)
'

It might make sense to test both the "create" and the "delete" code
paths, as their locking sequence differs.

I'm doing some work in this area, so I should be able to work on the
bugfix in the not-too-distant future. My feeling is that the bug is
unlikely to affect many current users, though it definitely should be
fixed before sb/atomic-push is merged.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
