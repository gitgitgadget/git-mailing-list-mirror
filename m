From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Support marking .git/ (or all files) as hidden on Windows
Date: Tue, 10 May 2016 10:22:20 -0700
Message-ID: <xmqqh9e5rfoz.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<cover.1462603453.git.johannes.schindelin@gmx.de>
	<xmqqposvw4fs.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605101036460.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BMb-0001pG-GU
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbcEJRWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:22:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbcEJRWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:22:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7116119C4C;
	Tue, 10 May 2016 13:22:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yeZsTp0NGW3c2BaU4Xfm3NjIBoA=; b=qjeBm8
	J+a+WhmTnS7o9aKOI+UG+hYYjaSg5Yvczc3rMTxAgbK1en+B+6H+0gkduC/z6Xjm
	rKWD3YZ5U6f5jn28RPJxuq9YTa96WUneR0kwgeTNyhRiypypk+cZNyrJz0JO7qsZ
	z3FG/1rS20sjfiUJayg1Pro+3NXDYsUmbStCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHCDxDkl1CM9wX06ORwmsPYLv1RgTKCC
	Mi8hiE6wkKUCx7IaMR8MhJzjDdF9PtIxbsTqXoVK58ef8bWU9BW05MMF6XbwlNq6
	pKJ935LPcF/PuyEoZYR9nmMYzUfn8Gg3qjDPKZzEEj2y/b1cdaSQOlNllL8unH3u
	Qz8hLdAVtxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 68A2019C44;
	Tue, 10 May 2016 13:22:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E23F619C3C;
	Tue, 10 May 2016 13:22:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605101036460.4092@virtualbox> (Johannes
	Schindelin's message of "Tue, 10 May 2016 10:41:20 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1F5AAD0-16D3-11E6-AB8D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294158>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 9 May 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > This is a heavily version of patches we carried in Git for Windows for
>
> s/patches/patched/
>
> I wish I had a penny for each time I wrote this particular typo.

    This is a heavily version of patched we carried...

does not sound all that grammatical.

    These are heavily modified version of patches...

is a possibility, but perhaps you meant

    This is a heavily patched version of what we carried...

>> OK, so what do you want me to do with this "heavily modified
>> version"?  Earlier you responded:
>> 
>>     > I have a huge preference for a code that has been production for
>>     > years over a new code that would cook at most two weeks in 'next'.
>> 
>>     I agree. However, it does not fill me with confidence that we did not
>>     catch those two bugs earlier. Even one round of reviews (including a
>>     partial rewrite) was better than all that time since the regressions
>>     were introduced.
>> 
>> So do we want to follow the regular "a few days in 'pu' in case
>> somebody finds 'oops this trivial change is needed', a week or two
>> in 'next' for simmering as everybody else, and finally down to
>> 'master'" schedule?
>
> Well, I plan to include this patch (replacing the original
> version) in whatever Git for Windows version I release next.  I
> guess that we can go with the regular way in git.git. You could
> just as well merge it to master right away, it won't matter much
> as far as Git for Windows is concerned.

OK.
