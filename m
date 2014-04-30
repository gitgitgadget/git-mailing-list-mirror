From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] CodingGuidelines: give an example for control statements
Date: Wed, 30 Apr 2014 15:03:25 -0700
Message-ID: <xmqqwqe6cw5u.fsf@gitster.dls.corp.google.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-5-git-send-email-gitster@pobox.com>
	<5361711F.1030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:04:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfcbl-0004Qq-IV
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 00:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340AbaD3WD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 18:03:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbaD3WD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 18:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1AAB82D16;
	Wed, 30 Apr 2014 18:03:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UJ5hzd89BtPR+pYlizkguYTKAhQ=; b=RxIAbE
	FcXZ86nnfrKcpyIegkx/MIakkTcu0R4nnEjJT3XCZQ99deOA+vJEUrUG2S1Hx8ra
	zLx5+1eYvvxQznsAsALScEwpljKObi33bygL3NUYCkqHdt800bgEIH7GIUHlb6FS
	+sUl5hOpCbZxhrnbdTMoVsKqmjjc5mlaMQCx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Em4ams6Jwmn/hjVFblOjJnwtK2Nx5JEQ
	Ar8P0mBAO1dJDKmoB1t8b55Y8OGLVWTTDrkUx2150NGR+8PHSxsoF6g9ZS/ij/cF
	CihLx24jtL4uY8mmlspRXCvBjyJ0DlRE9JEuKxCWbrHCjFwZi8w0B+qn4z6X/h4C
	Ury1ZqiXARs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84ADE82D15;
	Wed, 30 Apr 2014 18:03:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2DE82CB6;
	Wed, 30 Apr 2014 18:03:27 -0400 (EDT)
In-Reply-To: <5361711F.1030208@gmail.com> (Stefan Beller's message of "Wed, 30
	Apr 2014 23:54:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41FCAAC6-D0B3-11E3-AAAD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247795>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 30.04.2014 23:45, Junio C Hamano wrote:
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/CodingGuidelines | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index 1e0c4cf..d72e912 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -97,6 +97,17 @@ For shell scripts specifically (not exhaustive):
>>     "then" should be on the next line for if statements, and "do"
>>     should be on the next line for "while" and "for".
>>  
>> +	(incorrect)
>
> At the other patches you used #comments behind oneliners,
> not sure if that's also suitable here for consistency of the documentation.

I think you meant this one (are there others?):

+	cat hello > world < universe	# incorrect
+	cat hello >world <universe	# correct
+
+	echo hello >$world		# incorrect
+	echo hello >"$world"		# correct
+

I can certainly go with this instead over there:

	(incorrect)
	cat hello > world < universe
	echo hello >$world

	(correct)
	cat hello >world <universe
	echo hello >"$world"

I do not think it is wise to use the trailing comment style on all
the incorrect/correct lines for these examples.

>> +	if test -f hello; then
>> +		do this
>> +	fi
>> +
>> +	(correct)
>> +	if test -f hello
>> +	then
>> +		do this
>> +	fi
>> +
>>   - We prefer "test" over "[ ... ]".
>>  
>>   - We do not write the noiseword "function" in front of shell
>> 
