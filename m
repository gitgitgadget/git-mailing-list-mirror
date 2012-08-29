From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Wed, 29 Aug 2012 06:14:53 +0200
Message-ID: <503D973D.8040402@alum.mit.edu>
References: <5030F0BF.2090500@alum.mit.edu> <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 06:22:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Znl-0000jB-R4
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 06:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab2H2EWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 00:22:00 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:63735 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845Ab2H2EV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 00:21:59 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2012 00:21:59 EDT
X-AuditID: 1207440f-b7fde6d00000095c-fe-503d9741765b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DD.C2.02396.1479D305; Wed, 29 Aug 2012 00:14:57 -0400 (EDT)
Received: from [192.168.69.140] (p57A2548E.dip.t-dialin.net [87.162.84.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7T4EteW024987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 29 Aug 2012 00:14:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vk3wktiph.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqOs43TbAYPIDDouuK91MFg29V5gt
	1r+7yuzA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M74NM+t4KhERWfPWeYGxq/C
	XYycHBICJhKTXrWwQthiEhfurWfrYuTiEBK4zChxavoyKOcMk8SRX5eBHA4OXgFtic+/fUAa
	WARUJWbeXs4CYrMJ6Eos6mlmArFFBUIk1nybwghi8woISpyc+QSsRkRATWJi2yEwm1nAQ6J9
	1Tp2EFsYyP57YB0TxK4VjBKznzwAa+YUMJN4vHUNE0SDjsS7vgfMELa8xPa3c5gnMArMQrJj
	FpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICV3+HYxd62UO
	MQpwMCrx8B76axMgxJpYVlyZe4hRkoNJSZTXbZptgBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3qemQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisBgeHwJp1qy8wSrHk5eel
	KknwTgNZIFiUmp5akZaZU4JQysTBCbKIS0qkODUvJbUosbQkIx4UwfHFwBgGSfEA3TAVpJ23
	uCAxFygK0XqK0Zjj/8mTdxk5Pj8FkkJgm6TEectBSgVASjNK8+AWwZLZK0ZxYBgI8yaDVPEA
	EyHcvFdAq5iAVu1XtAZZVZKIkJJqYExZxHOnNWFf5+21tnf8fx3Y2JQawfCi5q4jz4N3D59P
	LbO9q5Oxxfby8j0xq5k8XS7XeifJFHxt+6UReOPiJJEPAb2PZjjq2uyt2MjIaD9V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204460>

On 08/27/2012 06:15 PM, Junio C Hamano wrote:
> Jiang Xin <worldhello.net@gmail.com> writes:
> 
>> Some testcases will fail if current work directory is on a symlink.
>>
>>     symlink$ sh ./t4035-diff-quiet.sh
>>     $ sh ./t4035-diff-quiet.sh --root=/symlink
>>     $ TEST_OUTPUT_DIRECTORY=/symlink sh ./t4035-diff-quiet.sh
>>
>> This is because the realpath of ".git" directory will be returned when
>> running the command 'git rev-parse --git-dir' in a subdir of the work
>> tree, and the realpath may not equal to "$TRASH_DIRECTORY".
>>
>> In this fix, "$TRASH_DIRECTORY" is determined right after the realpath
>> of CWD is resolved.
>>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> ---
> 
> I think this is in line with what was discussed in the other thread
> Michael brought this up.  Thanks for following it through.
> 
> Michael, this looks good to me; anything I missed?

I can confirm that this patch eliminates the test failures that I was
seeing in t4035 and t9903.

But it also changes almost 600 *other* tests from "succeed even in the
presence of symlinks" to "never tested in the presence of symlinks", and
I think that is surrendering more ground than necessary.  I would rather
see one of the following approaches:

*If* the official policy is that GIT_CEILING_DIRECTORIES is not reliable
in the presence of symlinks, then (a) that limitation should be
mentioned in the documentation; (b) the affected tests should either be
skipped in the case of symlinked directories or they (alone!) should
take measures to work around the problem.

*If* the official policy is that GIT_CEILING_DIRECTORIES should work in
the presence of symlinks, then (a) we should add a failing test case
that specifically documents this bug; (b) other tests that fail as a
side effect of this bug even though they are trying to test something
else should either be skipped in the case of symlinked directories or
they (alone!) should take measures to work around the problem; (c) the
bug should be fixed as soon as possible.

In fact, we could even go further:

* The "cd -P" in test-lib.sh could be changed to "cd -L", to avoid
masking other problems related to symlinks.  If I make that change, I
get test failures in 10 files when using --root=/symlinkeddir, and not
all of them are obviously related to GIT_CEILING_DIRECTORIES.  Some of
these might simply be sloppiness in how the test scripts are written,
but others might be bugs in git proper.

* We could *intentionally* access the trash directories via a symlink on
systems that support symlinks (much like the trash directory names
intentionally include a space) to get *systematic* test coverage of
symlink issues, rather than occasional testing and mysterious failures
when somebody happens to have a symlink in his build path or root.

(But it is still the case that I don't have time to work on this.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
