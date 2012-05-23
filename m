From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] submodule: document handling of relative
 superproject origin URLs
Date: Wed, 23 May 2012 14:14:08 -0700
Message-ID: <7vvcjmzjkv.fsf@alter.siamese.dyndns.org>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
 <1337791554-31294-2-git-send-email-jon.seymour@gmail.com>
 <4FBD4F68.90305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 23 23:14:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXItM-0005t1-In
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760817Ab2EWVOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:14:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760814Ab2EWVOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:14:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B9E88C2F;
	Wed, 23 May 2012 17:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LE4l4g43kbi/tA0ZrpJqmdb2d+Q=; b=OWTBLd
	7u0+a4goTVBOle5m/CDtgRYwPpPJC2U6+xXl2HkGIdtnhsqoZ/01BLAgBM0cWOGe
	73cSCwBz4Eyi0eXPCbAyUHRfyLnjGbq92Al4+SFBcnvGUTn+OlGxKe0FH3XhrSFO
	cy6/qZGK3dyySFeNkN04qV7852NtiFbr3ywYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXZvyCj7RAZJ/IORDch7e4764XdjSN9d
	hzRGj4V56GdmlgaOSjLfVJvARjvPrFYcpcYSr0U0UXKkP+v06W8KfOP37PjpjCBp
	x2hGhEZ1PzsKpeWYN352RyDZMjZdWRCnBThjQ5o1uskSar3rBsgtKk7BrtJZokSE
	Dl4RuPJMoTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 228728C2E;
	Wed, 23 May 2012 17:14:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EBEB8C2D; Wed, 23 May 2012
 17:14:10 -0400 (EDT)
In-Reply-To: <4FBD4F68.90305@web.de> (Jens Lehmann's message of "Wed, 23 May
 2012 22:58:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D578906-A51C-11E1-A5D8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198324>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Maybe the subject should rather be:
> "submodule: document failures handling relative superproject origin URLs"
>
> Am 23.05.2012 18:45, schrieb Jon Seymour:
>> These tests document how submodule sync and init handle various
>> kinds of relative super project origin URLs.  The submodule URL
>> path is ../subrepo.
>> 
>> 6 cases are documented:
>>   foo
>>   foo/bar
>>   ./foo
>>   ./foo/bar
>>   ../foo
>>   ../foo/bar
>
> Nice test coverage!

I recall correctly, the original use case for relative URL entries in the
.gitmodules file (to be copied to .git/config as submodule.$name.path) was
so that by looking at the top-level, the locations of the origins for
submodule repositories can be known from where the top-level was cloned.
The above cases do not seem to be relevant, so in the sense, they are of
secondary importance (and I do not find the "sneakernet tool" example
convincing---the sneakernet tool that is distributed in the scenario can
be written differently so that it does not require the other repositories
to be named relative to it).

As long as you and submodule stakeholders believe this is a reasonable
addition and does not break the existing use cases, I am perfectly fine
with it, though.

>> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
>> ---
>>  t/t7400-submodule-basic.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>  t/t7403-submodule-sync.sh  | 63 +++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 124 insertions(+), 1 deletion(-)
>> 
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index 81827e6..97e7a73 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -507,6 +507,68 @@ test_expect_success 'relative path works with user@host:path' '
>>  	)
>>  '
>
> But please use test_expect_failure for all tests that fail due to
> current bugs and document what should succeed in the commands used
> inside the test case (just like you did in v3). The only change
> needed when the bug is fixed should be changing each
> test_expect_failure to test_expect_success.

Very true.

Thanks for a review.
