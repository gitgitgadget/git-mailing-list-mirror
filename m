From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Thu, 12 Aug 2010 16:17:51 -0700
Message-ID: <7v1va3pgio.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net> <20100812224044.GK2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Greg Brockman <gdb@MIT.EDU>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 01:18:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojh2N-0003A0-ME
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 01:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761155Ab0HLXSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 19:18:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761106Ab0HLXSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 19:18:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2E0CCC3E;
	Thu, 12 Aug 2010 19:18:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cYjTg3MSyFvdD16bE55H2YJqJzg=; b=LM1oto
	sutb26OhFeEGszc7/a55vUvj4Oy7Z8rEuCZXgD1Y+sz7hyJSr+KvgUlU7sQXZcpS
	jsvAWvDpPAFwUVUufK41Kk54RwOmN1enLnupJ6Hti+thqxuEFjRYLSDSvT5SKxtg
	8TRDebVuZeGXs7ueFu02D2sl/SNWpn4NJ/dx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GQfJpaMFpv9opIxhY9K4iUOD4NoBNYcF
	smJk5DGHMtlupkVI0YsrZ/YWEqUeu8hkJUdOEGu8xKXLbK+EOF1RJvva6V04WkGx
	NKpkp/eLzNDdlYdgUVJlJG07eW1iHqob4fluQx6cR3mhx98p+S7KCZt7esaS1Duk
	o0oh0kwzMmY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF08CCC3D;
	Thu, 12 Aug 2010 19:18:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A3C3CCC3C; Thu, 12 Aug
 2010 19:17:53 -0400 (EDT)
In-Reply-To: <20100812224044.GK2029@burratino> (Jonathan Nieder's message of
 "Thu\, 12 Aug 2010 17\:40\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D982AD66-A667-11DF-B40D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153442>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>
>>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>>>  - apply: Handle traditional patches with space in filename
>>>  - t4135 (apply): use expand instead of pr for portability
>>>  - tests: Test how well "git apply" copes with weird filenames
>>>  - apply: Split quoted filename handling into new function
>>> 
>>> Looked Ok.  Will merge to 'next'.
>>
>> The test cases that work with files with tabs must have a prerequisite;
>> see t3600-rm.sh.
>
> Would this work?
>
> -- 8< --
> Subject: t4135 (apply): filenames with tabs are not usable on NTFS
>
> Move the code setting up the FUNNYNAMES prerequisite from
> v1.3.0-rc1~67 (workaround fat/ntfs deficiences for t3600-rm.sh,
> 2006-03-03) to test-lib and use it.

Hmm.  FUNNYNAMES is used by only these two but we have nearly 500
individual test scripts in the test suite, and that was the original reason
why we don't have it in test-lib.sh.

I wonder if we can/should lazily check this kind of thing upon the first
use of symbol during a single test session?

 * Create an empty $TEST_DIRECTORY/test-prereq file part of pre-clean
   target of t/Makefile.  This file needs to be removed as part of clean
   target;

 * t/test-lib.sh "."-sources the test-prereq file before doing anything
   else;

 * Instead of using "satisfied" variable as a SP separated list of
   prerequisite tokens, use PREREQ_FOO shell variable (whose value can be
   true, false) to represent FOO prerequisite we have already checked;

 * When checking for prerequite FOO, test_have_prereq checks if PREREQ_FOO
   variable is set.  If not, then it calls a shell function of the same
   name (i.e. PREREQ_FOO) defined in test-lib.sh (the function can exit
   with zero or non-zero just like usual tests to signal if the
   prerequisite is met), sets PREREQ_FOO to an appropriate value, and then
   runs "echo PREREQ_FOO=$PREREQ_FOO >>$TEST_DIRECTORY/test-prereq".
   Then $PREREQ_FOO can be examined to see if prerequisite FOO is
   satisfied.

The file based caching of the above wouldn't work well under "make -j";
without it, we can still have a prerequisite checked only once per a test
script run, which is not worse than the current situation (and it would
even save cycles if a test does not check for a particular prereq,
e.g. SYMLINKS, that is always checked in test-lib).
