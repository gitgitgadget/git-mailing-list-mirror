From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for
 Windows
Date: Thu, 09 Aug 2012 09:03:49 -0700
Message-ID: <7vipcsoxwa.fsf@alter.siamese.dyndns.org>
References: <5022CC90.3060108@gmail.com>
 <7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
 <CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 18:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVDL-0003pD-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617Ab2HIQDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:03:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758396Ab2HIQDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 12:03:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FD465D8B;
	Thu,  9 Aug 2012 12:03:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wqhXk9Pg+9DCZWqAeHEVGbd07FA=; b=SGmxYb
	hS0kQIl/pttbEznYdM/aIIlI53JdR6mv2Smf7ofTKI/O5DEo63uqhtAtj7at2VoN
	FNdB7UF9KOCBKKZdbf+csBcyIoqvwbTmiH/2laAuwqoz7QI4exh1nNTPRqlJbMy2
	3WGphIAu0wu2/MxjNtiKNazh/AserR2nQZg0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pcJ/AQ1PLQjm8fAvJqWZP4UjaOFVo/1T
	slCYU6AB1zqUNRf2eeKBoh5eIDDZPwgnsdwpqsivQELYkai5inxVQEXavSLP2QKh
	+zHBZcsK/fvhAi2UayTuR0zoS0FC1ZJbm5ADbfMfi6QR1DMPPaYaiAV0KORkshFQ
	dgTYrsaQDL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D4CA5D8A;
	Thu,  9 Aug 2012 12:03:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 311D15D89; Thu,  9 Aug 2012
 12:03:51 -0400 (EDT)
In-Reply-To: <CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com>
 (Sebastian Schuberth's message of "Thu, 9 Aug 2012 09:06:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF9F351E-E23B-11E1-9362-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203161>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, Aug 8, 2012 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I do not have a strong reason to vote for or against inclusion of
>> yet another tool as mergetool backends (read: Meh), but what this
>
> That sounds almost as if you'd like to keep the number of directly
> supported mergetools small (I'm not talking about about the length of
> the list of mergetools in the docs right now). I was always thinking,
> the more mergetools, the better. Do you think differently?

It depends on the pros-and-cons between the cost of forcing many
people to see a list of supported backends with yet one more item
(the list only grows and rarely shrinks) and the benefit of the
subset of users who can now use it.  I couldn't measure how widely
the particular commercial program is used from your proposed commit
log message, and that is where my "for or against" comes from.

>> patch does to Documentation/merge-config.txt is actively unwelcome.
>>
>> As we discussed earlier in
>>
>>     http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201976
>>
>> the longer term direction is to reduce the names of tools listed
>> there.
>>
>> I am somewhat saddened to find your name in that thread; you should
>> have been aware of that discussion when you wrote this patch.
>
> I still agree that not listing all mergetools in multiple places is a
> good thing. But doing the whole stuff of extending --tool-help for
> git-mergetool and git-difftool to return a simple list that can be
> used in git-completion.bash etc. IMHO is a separate topic and out of
> scope of this patch.

Exactly.  If you know that is the long term direction, I would have
preferred you _not_ to touch any existing descriptions of the tools
(not even changing them to refer to "--tool-help") in this patch, in
order to avoid unnecessary conflicts with the topic of unifying the
list of tool backends, which can be written and cooked separately.

Thanks.
