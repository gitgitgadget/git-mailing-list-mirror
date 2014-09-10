From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2014, #02; Tue, 9)
Date: Wed, 10 Sep 2014 09:39:55 -0700
Message-ID: <xmqqbnqnig4k.fsf@gitster.dls.corp.google.com>
References: <xmqqa968jxj5.fsf@gitster.dls.corp.google.com>
	<20140909222054.GC14029@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 18:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRkwC-0001Z1-30
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 18:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbaIJQkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 12:40:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54926 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbaIJQj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 12:39:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29ECD37E6B;
	Wed, 10 Sep 2014 12:39:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=izLVJJgaQ4aA/rLySWSSjqfbfZE=; b=g68v5O
	H8IApK8rGwh74bbFC3E32EjpSTdZFLU8fMCtKks9OJP/M6+i0LGQigOnOa5wyC1J
	NFCOqo28bS/y3C7Cz5FvxNQJFmibPtwuouZnNIzwamRGO8XGlBrSSjgWbYJPKbAJ
	SYMeKfI1I9pBa9H7qikcw6g7GS3ys4EZJB9S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XLQ8AyK23VSR9+BxiY/R4cPIyrUyYCsa
	Y9Mh3tY5tFubUXMOxDprqGbXpHmJZTtYDnyl8T/PDZzP1/7Z+u1DteKKJQt/zabD
	QsnMom+Lr6nMg2lQEYxgDQCTpnyWRJHu/69WjXjFAyOLkQErKUp6h18xuBOohaTK
	aZPi8mj76xA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F5BA37E6A;
	Wed, 10 Sep 2014 12:39:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DEC837E67;
	Wed, 10 Sep 2014 12:39:57 -0400 (EDT)
In-Reply-To: <20140909222054.GC14029@peff.net> (Jeff King's message of "Tue, 9
	Sep 2014 18:20:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 19A82866-3909-11E4-8AB9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256751>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 09, 2014 at 02:26:22PM -0700, Junio C Hamano wrote:
>
>> * jk/command-line-config-empty-string (2014-08-05) 1 commit
>>   (merged to 'next' on 2014-08-29 at 74f04af)
>>  + config: teach "git -c" to recognize an empty string
>> 
>>  "git -c section.var command" and "git -c section.var= command"
>>  should pass the configuration differently (the former should be
>>  a boolean true, the latter should be an empty string).
>
> Hmm, there is something funny about the authorship on the sole commit in
> that topic. It's too late to fix now (and I do not care too much), but
> you may want to puzzle out what happened (stray --reset-author, weird
> use of "git am"?).

I think that I am'ed on top of 2.1.0-rc1 first, but because it was a
maintenance material, I backported it to fork from 1.8.5 maintenance
track.  Perhaps rebase or cherry-pick did not work well while doing
this and I ended up doing "show | apply -3", "merge --squash", or
something silly like that.
