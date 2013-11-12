From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] test-lib.sh: convert $TEST_DIRECTORY to an absolute path
Date: Tue, 12 Nov 2013 12:06:14 -0800
Message-ID: <xmqqfvr1gzbc.fsf@gitster.dls.corp.google.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384235688-9655-1-git-send-email-rhansen@bbn.com>
	<1384235688-9655-3-git-send-email-rhansen@bbn.com>
	<5281C522.7050403@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 21:06:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKEC-0006nF-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab3KLUGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:06:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab3KLUGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:06:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 892A150B32;
	Tue, 12 Nov 2013 15:06:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suI0rgfN5y3okRLYf+QfVtW2pVU=; b=MflniH
	Uo7ZgjfGe6AGPtLEHBpU1Gq2qdrfi6AxNJ47/7zan49Iu8m3Gd1QnqYosiezgtwL
	zxgGJ1g6+Mh3KnxXo71Erv2sOZ3k5hxRZb/t62uI8ygNxtfGuYEtNjWsfYhDs/aj
	8hugmtjmu8mC6uMYqd0TapjP9f5t2OnzCLpDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkJTIHZhgtwVnNtc76M8ucu2t5WerPqg
	XVuaSwab7wzu9I3CxFoikRXcCOWccIh24ukmgrRFEPKxnyE4ycvJYs56v//LdreE
	oSu0ES7Orw1WYJc99q8kbhoWlOjYwD/fGcf3fmzbnVTkV8mA4lABChVdS7BQdgH2
	qOX2MouCg1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7989250B31;
	Tue, 12 Nov 2013 15:06:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26EF50B2F;
	Tue, 12 Nov 2013 15:06:17 -0500 (EST)
In-Reply-To: <5281C522.7050403@bbn.com> (Richard Hansen's message of "Tue, 12
	Nov 2013 01:05:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E416AFF4-4BD5-11E3-966B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237730>

Richard Hansen <rhansen@bbn.com> writes:

> On 2013-11-12 00:54, Richard Hansen wrote:
>> If $TEST_DIRECTORY is specified in the environment, convert the value
>> to an absolute path to ensure that it remains valid even when 'cd' is
>> used.
>> 
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>
> Actually, credit for this and the next patch should go to Felipe.  How
> should I note that?

If the patch text was copied from his response message, you would start
the _body_ of your e-mail as:

	From: F.. C.. <felipe.contreras@gmail.com>
        
	If $TEST_DIRECTORY is specified ...

	Signed-off-by: F.. C.. <felipe.contreras@gmail.com>
	Signed-off-by: R Hansen <rhansen@...>
        
_after_ getting him say it is OK to add his Sign-off.  The first
line in the body of your e-mail, "From: Real Author", followed by a
blank line, will signal to "git am" that you are forwarding a patch
by somebody else, and we record that real author on the "author"
line of the resulting commit object.

On the other hand, if the patch is based on the _idea_ you gained by
discussing with him, you would just mention it near your sign-off,
like this:

	If $TEST_DIRECTORY is specified ...

	Helped-by: F... C... <felipe.contreras@gmail.com>
	Signed-off-by: R... Hansen <rhansen@...>


	

>
> Thanks,
> Richard
>
>
>> ---
>>  t/test-lib.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index b25249e..af172d9 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -26,6 +26,10 @@ then
>>  	# outside of t/, e.g. for running tests on the test library
>>  	# itself.
>>  	TEST_DIRECTORY=$(pwd)
>> +else
>> +	# ensure that TEST_DIRECTORY is an absolute path so that it
>> +	# works even if the current working directory is changed
>> +	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
>>  fi
>>  if test -z "$TEST_OUTPUT_DIRECTORY"
>>  then
