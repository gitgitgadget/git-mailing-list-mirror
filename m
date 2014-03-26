From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Wed, 26 Mar 2014 11:43:55 +0100
Message-ID: <5332AF6B.1050108@alum.mit.edu>
References: <5331B6F6.60501@web.de> <5331B717.5010600@web.de> <xmqq4n2mknqf.fsf@gitster.dls.corp.google.com> <53328FD8.4050907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 11:44:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSlJZ-0004D4-HY
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 11:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbaCZKoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 06:44:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63632 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751820AbaCZKoB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 06:44:01 -0400
X-AuditID: 12074412-f79d46d000002e58-ba-5332af70ac1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 15.2F.11864.07FA2335; Wed, 26 Mar 2014 06:44:00 -0400 (EDT)
Received: from [192.168.69.148] (p57A25757.dip0.t-ipconnect.de [87.162.87.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2QAhtDf016326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Mar 2014 06:43:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <53328FD8.4050907@web.de>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsUixO6iqFuw3ijYoKvDzKLrSjeTRUPvFWaL
	lY/vMltMnLaY2eLtzSWMFj9aepgd2Dx2zrrL7tH+/h2zx7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujL0N19kLXolVfF82namBsV+oi5GTQ0LAROLDja+MELaYxIV769m6
	GLk4hAQuM0rMXnucBcI5xyRxe/N9ZpAqXgFtiSlfZ7GB2CwCqhJ/320A62YT0JVY1NPMBGKL
	CgRJHN5wihWiXlDi5MwnLCC2iICXxO6X38E2MAssYJRovvmYHSQhLGAnMevCEiaIbW2MEgv2
	rgPr4BRQk/j4aQrQBg6g+8QlehqDQMLMAjoS7/oeMEPY8hLb385hnsAoOAvJvllIymYhKVvA
	yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyQmhHYwrj8pd4hRgINRiYfX
	os8wWIg1say4MvcQoyQHk5Ior9Fyo2AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrw71gLleFMS
	K6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4OJQkeH3WATUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg6I4vhgYxyApHqC9R0HaeYsLEnOBohCtpxh1OTZsW9PIJMSS
	l5+XKiXOGwFSJABSlFGaB7cClgBfMYoDfSzMOwWkigeYPOEmvQJawgS0hKsKbElJIkJKqoHR
	elFTqeicL/XvDXuvbtNef3FLs03d49rrPkKnvKOL624uCJ5/TuNCSc8dX8ngkLWn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245173>

On 03/26/2014 09:29 AM, Jens Lehmann wrote:
> Am 25.03.2014 21:49, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> For the upcoming submodule test framework we often need to assert that an
>>> empty directory exists in the work tree. Add the test_dir_is_empty()
>>> function which asserts that the given argument is an empty directory.
>>>
>>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>>> ---
>>>
>>> I believe this one is pretty straightforward (unless I missed that this
>>> functionality already exists someplace I forgot to look ;-).
>>
>> I am not very thrilled to see that it depends on "." and ".." to
>> always exist, which may be true for all POSIX filesystems, but
>> still...
> 
> Agreed. I didn't find any one-liners to do that ("ls -A" isn't
> POSIX), so I decided to wrap that in a function. Testing that
> "rmdir" on the directory succeeds (because the directory is
> empty) would kinda work, but then we'd have to re-create the
> directory afterwards, which really doesn't sound like a good
> strategy either as the test would manipulate the to-be-tested
> object. I'm not terribly happy with depending on "." and ".."
> either, but couldn't come up with something better. At least
> the test should fail for any filesystem not having the dot
> files ...
> 
>> Do expected callsites of this helper care if "$1" is a symbolic link
>> that points at an empty directory?
> 
> Yep, a symbolic link pointing to an empty directory should make
> the test fail.
> 
>> What do expected callsites really want to ensure?  In other words,
>> why do they care if the directory is empty?  Is it to make sure,
>> after some operation, they can "rmdir" the directory?
> 
> To assert that a submodule is created but *not* populated. This
> is intended to catch any possible fallout from the recursive
> checkout later, in case that would kick in when it shouldn't.
> 
>>>  t/test-lib-functions.sh | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>>> index 158e10a..93d10cd 100644
>>> --- a/t/test-lib-functions.sh
>>> +++ b/t/test-lib-functions.sh
>>> @@ -489,6 +489,17 @@ test_path_is_dir () {
>>>  	fi
>>>  }
>>>
>>> +# Check if the directory exists and is empty as expected, barf otherwise.
>>> +test_dir_is_empty () {
>>> +	test_path_is_dir "$1" &&
>>> +	if test $(ls -a1 "$1" | wc -l) != 2
>>> +	then
>>> +		echo "Directory '$1' is not empty, it contains:"
>>> +		ls -la "$1"
>>> +		return 1
>>> +	fi
>>> +}
>>> +
>>>  test_path_is_missing () {
>>>  	if [ -e "$1" ]
>>>  	then

Why not do something like

    test -z "$(ls -a1 "$1" | egrep -v '^\.\.?$')"

I.e., make the test ignore "." and ".." without depending on their
existence?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
