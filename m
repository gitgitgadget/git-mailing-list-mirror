From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the --done option.
Date: Fri, 24 Aug 2012 16:19:09 -0700
Message-ID: <7voblzyj2q.fsf@alter.siamese.dyndns.org>
References: <20120822105705.GA30472@thyrsus.com>
 <7vobm2968x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Aug 25 01:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T539u-0004MH-51
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 01:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab2HXXTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 19:19:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028Ab2HXXTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 19:19:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03EA38B48;
	Fri, 24 Aug 2012 19:19:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SEef31UaKsg9pudLFhEQPR4r6fU=; b=nt2J7M
	EGEhOTC8PDDHyTu4gRCZid4qxwhy/t5RiwvjDimx14pzNsMi6AfRNqeqrR/rh4Yy
	TRGef5PbEuOwJ20/TaJl6FvJThXnb3RxvivXmNfO86otgCCcsbl7minHbuFf1g0A
	oi9QSkHae+jWY8PiT+nJgZYJR+cexVu7RuB1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L53A7+zgypSpH3NlUb/yb/atfePUmZZp
	Pq3phAaHlOH9Pinm7SIRdO1M8fJ+63nVDJp0qL9zFYFLNKiJW4KTM6SucSNJslR2
	FHSPdjh6/elCcCTk6XkjwvP84K/Z+lGZ+WRzbowCTIM1sx0tAVJPJVSxWkTY+Zxp
	/Taoov7QeIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E52E48B47;
	Fri, 24 Aug 2012 19:19:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A29158B46; Fri, 24 Aug 2012
 19:19:10 -0400 (EDT)
In-Reply-To: <7vobm2968x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 22 Aug 2012 10:38:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C3B5C7E-EE42-11E1-84DE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204238>

Junio C Hamano <gitster@pobox.com> writes:

> "Eric S. Raymond" <esr@thyrsus.com> writes:
>
>> ---
>
> A forgotten Sign-off?

Ping?  Just telling us that this is Signed-off is fine.

Thanks.

>
> Sverre, the text matches my understanding as well as what be56862
> (fast-import: introduce 'done' command, 2011-07-16) says it did.
> Ack?
>
>>  Documentation/git-fast-import.txt |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
>> index 2620d28..9291ea0 100644
>> --- a/Documentation/git-fast-import.txt
>> +++ b/Documentation/git-fast-import.txt
>> @@ -39,6 +39,10 @@ OPTIONS
>>  	See ``Date Formats'' below for details about which formats
>>  	are supported, and their syntax.
>>  
>> +-- done::
>> +	Terminate with error if there is no 'done' command at the 
>> +	end of the stream.
>> +
>>  --force::
>>  	Force updating modified existing branches, even if doing
>>  	so would cause commits to be lost (as the new commit does
>> @@ -1047,7 +1051,9 @@ done::
>>  	Error out if the stream ends without a 'done' command.
>>  	Without this feature, errors causing the frontend to end
>>  	abruptly at a convenient point in the stream can go
>> -	undetected.
>> +	undetected.  This may occur, for example, if an import
>> +	front end dies in mid-operation without emitting SIGTERM
>> +	or SIGKILL at its subordinate git fast-import instance.
>>  
>>  `option`
>>  ~~~~~~~~
>> -- 
>> 1.7.9.5
