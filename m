From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitignore.txt: clarify recursive nature of excluded directories
Date: Thu, 07 Nov 2013 11:37:38 -0800
Message-ID: <xmqq61s457gd.fsf@gitster.dls.corp.google.com>
References: <527BC00D.8000501@gmail.com> <527BC068.3040303@gmail.com>
	<xmqqa9hg59av.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 20:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeVOk-0003qh-4c
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 20:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab3KGThn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 14:37:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab3KGThl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 14:37:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1622C4F16D;
	Thu,  7 Nov 2013 14:37:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zIhDsI/AeYX3A4a9ttVfQY6aZdw=; b=rgbEu6
	ieC3LNIj7KrNHQ9sa7ZdB8cIM/fL4sjSNKYMJhrZKkUSs3y5sjwe4gRrkrl8sa/I
	+EkfOxQBWpXJgMyCvJLGfZ/S8RiAfqBwllK47iDv5Qtk0KQHkHBzO8J0157GiEQ0
	Uv3hWuFra4lsq/uMEGhzAHsTOkwlTZqdBwasY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSJFACPDCRVqocsqo3qA6v2WTXQLSTf8
	1KfOeJlyzpzcElR/GeP6m/rF+qPiqM+PCok4rc6f9c6MNN6TnKWcGYvhmTL8rpUO
	7443S8chbCphBoK8iTQxvERBzGGsfSVCqI0sKkn4WvshLi1eIrNQXPC0MCdkwnq7
	p9IxVY3M8AI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08DC94F16C;
	Thu,  7 Nov 2013 14:37:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57B094F16B;
	Thu,  7 Nov 2013 14:37:40 -0500 (EST)
In-Reply-To: <xmqqa9hg59av.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Nov 2013 10:57:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1059E900-47E4-11E3-A3DD-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237425>

Junio C Hamano <gitster@pobox.com> writes:

> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> Additionally, precedence of negated patterns is exactly as outlined in
>> the DESCRIPTION section, we don't need to repeat this.
>
> Very good, thanks.
>
> Even though I have a suspicion that somebody else may be able to
> come up with a better phrase that does not sound unnecessarily
> strongly than "recursively and irrevocably", that somebody else is
> not me, so I'll queue this as-is for now.

Just in case somebody thinks about rephrasing, to me, these two
words sound heavier than the information they actually convey, and
that is why I said "unnecessarily strong".

The key thing in the behaviour when a directory is excluded is that
it tells us to stop going into that directory, and there is no way
to override it with another .gitignore file somewhere inside,
because we are told not to even bother looking for it.  "Recursively
and irrevocably" may be an accurate description of the end result,
but that sounds more like a rule without a "because"; to a reader
(me), it lacks the "aha, of course" that comes from understanding
why.

>> Signed-off-by: Karsten Blees <blees@dcon.de>
>> ---
>>  Documentation/gitignore.txt | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
>> index f971960..5ecc48e 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -79,8 +79,9 @@ PATTERN FORMAT
>>  
>>   - An optional prefix "`!`" which negates the pattern; any
>>     matching file excluded by a previous pattern will become
>> -   included again.  If a negated pattern matches, this will
>> -   override lower precedence patterns sources.
>> +   included again. It is not possible to re-include a file if a parent
>> +   directory of that file is excluded (i.e. excluding a directory
>> +   will recursively and irrevocably exclude the entire content).
>>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>>     that begin with a literal "`!`", for example, "`\!important!.txt`".
>>  
>> @@ -182,6 +183,19 @@ Another example:
>>  The second .gitignore prevents Git from ignoring
>>  `arch/foo/kernel/vmlinux.lds.S`.
>>  
>> +Example to exclude everything except a specific directory `foo/bar`
>> +(note the `/*` - without the slash, the wildcard would also exclude
>> +everything within `foo/bar`):
>> +
>> +--------------------------------------------------------------
>> +    $ cat .gitignore
>> +    # exclude everything except directory foo/bar
>> +    /*
>> +    !/foo
>> +    /foo/*
>> +    !/foo/bar
>> +--------------------------------------------------------------
>> +
>>  SEE ALSO
>>  --------
>>  linkgit:git-rm[1],
