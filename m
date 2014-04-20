From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sun, 20 Apr 2014 14:52:43 -0700
Message-ID: <7v7g6jllck.fsf@alter.siamese.dyndns.org>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
	<1397890843-27035-1-git-send-email-gitster@pobox.com>
	<535413cbc7eaa_1f08dd12eca5@nysa.notmuch>
	<7voazvlna8.fsf@alter.siamese.dyndns.org>
	<535438246097c_4c30158d2ec11@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbzdp-00006R-4o
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbaDTVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:51:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaDTVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:51:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1527E9D7;
	Sun, 20 Apr 2014 17:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zonhUF17yqWa5IwB6pqpZCZyGmw=; b=GBK6Zh
	Vs3a3LlBgGdoK+8+Ek4P2KEjGQ7G6nvkvmXPScxq1YQi5iSu5f5csV3jHoqizdb4
	72+3CSi3wECpbGMtPSzq+XeGkdUaZnnBGlBLQIjYLWVtqwCL0tDKVd5jIAWS2sVx
	SSffKdQnK+gsEmwASnSGfjWfl7LlC0uSIJ1j0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=esgTWM9ddELs7wjQKUuEb/VNMJ/Ok1LX
	Mq8QX0rhHjUvfsBOvRVhJ7HGbiz7AA4mrDZYwV8jKm2xnfsfUQM4vDLlJEYVZr5H
	9MtCMbe2V81HVt+OPdjOOYysGCSoWyGf70WpJOPhvswmbdhB6OhiZONN5UzKjkud
	rLD/FU+zSoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 153F17E9D6;
	Sun, 20 Apr 2014 17:51:07 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 641D67E9D3;
	Sun, 20 Apr 2014 17:51:03 -0400 (EDT)
In-Reply-To: <535438246097c_4c30158d2ec11@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 20 Apr 2014 16:12:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: DE4DB98C-C8D5-11E3-A481-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246592>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Junio C Hamano wrote:
>> >> As I have said in the recent What's cooking reports, the original
>> >> posted here were based on older codebase and needed to be rebased,
>> >> but it had some conflicts and I wanted to see the result double
>> >> checked by the original author before we can merge it to 'next',
>> >> cooked there and hopefully merged to 'master' before tagging -rc1.
>> >> 
>> >> So here is the series that has been queued in 'pu' for the past
>> >> several days.
>> >> 
>> >> Felipe, can you double check it?
>> >
>> > These patches don't help much,...
>> 
>> What do you mean by that, exactly?  As long as your "don't help
>> much" is "would not hurt and will help some even for a small subset
>> of audience", that would be OK, but I am puzzled.
>
> I mean if purpose of these was for me to review the changes you did, it doesn't
> help as much as an interdiff does.

Ah, I misunderstood.  The thing was, that the original was based on
older codebase and I couldn't apply them to my tree cleanly.  It
would be unfair for you to expect _me_ to give you an interdiff in
such a situation, especially when I am asking you to double check
the conflict resolution based on that original.

OK, so I'll advance the topic to the 'next' and hopefully we can
merge it to 'master' before rc1.

> There's nothing in Documentation/CodingGuidelines that says multiple piped
> commands should be one on each line even if togther the line doesn't exceed 80
> characters, nor does it says that file names should be between quotes, even if
> the file name can't possibly have spaces.

Heh, we don't spell out every possible rules. That is where "do as
surrounding code" comes in.

As to "$1" vs $1 without quotes, I had to check the calling sites of
clean_mark and cmp_marks, primarily because these functions do not
say what their "$1" is, to see if an unquoted form is safe.  The
next person who reads the script has to do the same and quoting is
an obvious way to avoid it.

If the functions said "$1 is a branch name", it would have been
clear that unquoted $1 would be OK, but still, what these functions
has to take (especially the "clean" one that takes pathnames) can
change in the future, and a quoted form is an obvious way to
futureproof and relieve readers and programmers from having to worry
about the quoting issues.

So I think it is better to quote these in this particular case.

The pipe is purely subjective readability. I can go either way, but
since I was the one who was applying the patch that needed other
changes anyway... ;-)
