From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Tue, 15 Nov 2011 11:16:33 -0800
Message-ID: <7vk471urfy.fsf@alter.siamese.dyndns.org>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu>
 <4EC27328.3070309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:16:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQOUw-0008C4-UH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 20:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab1KOTQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 14:16:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab1KOTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 14:16:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CEDF6F0C;
	Tue, 15 Nov 2011 14:16:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HKMW0AAD3FxUoSNXdYtp35/XH3M=; b=CyU5wi
	8IvDdOB8H6gRpyYDEoKlOd9fsUoH1Tl5jKPRdKpzvQ4YAzOx2TCQlBYZYtSE+BNx
	dvf+Qk540GFI4sie3xlaIA1ieY/B7GyMuTNS23Aq0yaAml6QL5/1dCl5dHaK4SWE
	ohWX5qJvsygEtz74RkOwO8gl3/SFz1jpeNVCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKDM07fuxVVNF+AniYLBRSwVV8/LVm3A
	fapAHQWUVLOtlmFELrPfOMc7zQgdqI7mkTwG2w0uKfTq2D0bEBs92m4O2EIpGSrJ
	AVeG/ZbRwgqVlZHmWWLx1NnIHRuq3NnQlPruktZI8GBunRSWwxt/ypA74hEmO0PW
	gSQsX8Wbwrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B0B6F0B;
	Tue, 15 Nov 2011 14:16:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C21A76F0A; Tue, 15 Nov 2011
 14:16:34 -0500 (EST)
In-Reply-To: <4EC27328.3070309@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 15 Nov 2011 15:11:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 555AF4FA-0FBE-11E1-8D4A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185481>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio,
>
> Did this one fall through the cracks?  I don't see it in your tree.
>
> Michael

Yeah, I was wondering if we can have a concise description in what context
any "^" must be spelled as {caret} and what other context "^" can be
spelled literally, and possibly which versions of AsciiDoc toolchain have
this issue [*1*]. Without a clear guideline, people may unknowingly use
literal "^" to new paragraphs, or perhaps worse yet, spell {caret} that
end up being shown literally.

Since I didn't find a clear pattern other than that "^" can and should be
literally given in a literal paragraph (i.e. an indented paragraph or
inside a listing/literal block that shows program examples), I was meaning
to ask you if you knew the rules better than I did, and I stopped there,
forgetting to follow through.


[Footnote]

*1* For example, http://schacon.github.com/git/git-show-ref.html indicates
that the description for "-d" does not seem to need your patch for the box
it was formatted on.

> On 10/19/2011 08:52 PM, mhagger@alum.mit.edu wrote:
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>> 
>> One of the "^" characters was not coming through in the man page.
>> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  Documentation/git-show-ref.txt |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
>> index 3c45895..87f358d 100644
>> --- a/Documentation/git-show-ref.txt
>> +++ b/Documentation/git-show-ref.txt
>> @@ -44,7 +44,7 @@ OPTIONS
>>  -d::
>>  --dereference::
>>  
>> -	Dereference tags into object IDs as well. They will be shown with "^{}"
>> +	Dereference tags into object IDs as well. They will be shown with "{caret}\{\}"
>>  	appended.
>>  
>>  -s::
>> @@ -75,7 +75,7 @@ OPTIONS
>>  	Make 'git show-ref' act as a filter that reads refs from stdin of the
>>  	form "^(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$"
>>  	and performs the following actions on each:
>> -	(1) strip "^{}" at the end of line if any;
>> +	(1) strip "{caret}\{\}" at the end of line if any;
>>  	(2) ignore if pattern is provided and does not head-match refname;
>>  	(3) warn if refname is not a well-formed refname and skip;
>>  	(4) ignore if refname is a ref that exists in the local repository;
