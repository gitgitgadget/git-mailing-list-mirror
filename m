From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: separate message for common ancestors
Date: Sun, 05 Aug 2012 12:32:22 -0700
Message-ID: <7v628x3zjt.fsf@alter.siamese.dyndns.org>
References: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
 <7vehnl41r2.fsf@alter.siamese.dyndns.org>
 <CAN0XMO+j08fV-5+nNrVQAteB3VStBjqvvjMzRq=6wcbg8OR+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:32:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy6Z0-0002wA-Bt
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 21:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab2HETc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 15:32:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278Ab2HETcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 15:32:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1584D9237;
	Sun,  5 Aug 2012 15:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZfHd/tPwKXTNcZ46gnTzwzuXASE=; b=kcMxsp
	WI9ihOY6csksl/SDLebmLNAsYL7tvQYom70Mw87XflDnVpK2VrJ1X56FhIKVceZU
	s+3Joa70O+a173FxI/pFm3qwxNoxMAGELp3Cm9gJtHA5N1jGCN0qNEWQvK/+yPWP
	2PYaUN9P4Lq+/fq5SLO15x92ffl2pLciGfGas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SEX9geRUy/x7c1uBf82LO53vxD3sVp7r
	9GzTg3Y4R0MrXs/TbKIUxkal87vx5LOEl3Jg9Z9R9Ef0pJo7O+LM2FL4SduJDiyF
	jXU7aU0+v2HrxlmeLkUPG7/1vhQ6gMWM40jIs66/HhVmiBFjNELWjcTtn5UJfcCp
	DeaLJxykgHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 028E49236;
	Sun,  5 Aug 2012 15:32:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 558509235; Sun,  5 Aug 2012
 15:32:24 -0400 (EDT)
In-Reply-To: <CAN0XMO+j08fV-5+nNrVQAteB3VStBjqvvjMzRq=6wcbg8OR+xg@mail.gmail.com> (Ralf
 Thielow's message of "Sun, 5 Aug 2012 20:55:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 486330C8-DF34-11E1-B5EE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202918>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> It would be nicer for translators to have two messages.
> In the end it's just a separation for singular and plural as it's
> done in diff.c (e.g. Q_(" %d file changed", " %d files changed", files)).

OK, so there was no hidden message behind "At least for better
translation".  Will apply this so 1.7.12 can have it.

Thanks.

>
> On Sun, Aug 5, 2012 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>>> The function "merge_recursive" prints the count of common
>>> ancestors as "found %u common ancestor(s):". At least for
>>> better translation, we should use a singular and a plural
>>> form of this message.
>>>
>>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>>> ---
>>
>> Thanks.
>>
>> In your "At least" above, I am getting an impression that either (1)
>> you think the updated two-message solution is still not ideal for
>> some reason, or (2) you think the change not only helps translation,
>> it also helps something else.  But I cannot quite guess which.  If
>> it is (1) I am not sure what you are not exactly happy about, if it
>> is (2) I am not sure what other problem the change helps.
>>
>> I am a bit puzzled by the log message, but the change makes sense to
>> me otherwise.
>>
>>>  merge-recursive.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/merge-recursive.c b/merge-recursive.c
>>> index 8903a73..39b2e16 100644
>>> --- a/merge-recursive.c
>>> +++ b/merge-recursive.c
>>> @@ -1915,7 +1915,10 @@ int merge_recursive(struct merge_options *o,
>>>       }
>>>
>>>       if (show(o, 5)) {
>>> -             output(o, 5, _("found %u common ancestor(s):"), commit_list_count(ca));
>>> +             unsigned cnt = commit_list_count(ca);
>>> +
>>> +             output(o, 5, Q_("found %u common ancestor:",
>>> +                             "found %u common ancestors:", cnt), cnt);
>>>               for (iter = ca; iter; iter = iter->next)
>>>                       output_commit_title(o, iter->item);
>>>       }
