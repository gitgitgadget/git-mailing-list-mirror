From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 16:26:17 -0700
Message-ID: <7vzjvlb7mu.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
	<7v8v35cnp0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 01:26:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufett-0005d2-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065Ab3EWX0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759888Ab3EWX0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E6E12140F;
	Thu, 23 May 2013 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cT1zjBeI3FGNvViXeA7/e9bVcr8=; b=rny5Z/
	OiCGJEAxZXqFiOW6iHiUyHJo6sgNj3hdDnwcbyoi14rRQWMZl2fry6/6IowAK6Cs
	rilMQ/rHITNarcKa3MLV/PzRzeRnVeWWGyG8sAwnAktmzDFRjay/KQTaLfJlxe3A
	73inwV98+whyx6n+GDBS1Owr1ifzH+rrpIli8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRs/hqYNVHwabaecKYr6Fj5SuD+bN9fd
	m5Cw1rC1OzVQWDDFdVR/9hHLnZz3ctYmoivdr55w7Gf9xtx/Py0wGdsGF+ICqZRw
	PBV9gGO7UBFlaFAjMvrvYgblbCT9LCQ6E2oYyQiLwqIpYEv3QIFkNExNLS7uCTmG
	92ay4eZIAGs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0092A2140E;
	Thu, 23 May 2013 23:26:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ACE82140D;
	Thu, 23 May 2013 23:26:19 +0000 (UTC)
In-Reply-To: <CAMP44s1N=xy2B-YkCLC67pX_EVqAziGWyN1qkrs0Sq=o2jL6Sw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 18:09:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C2B97D6-C400-11E2-8800-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225318>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>>> Unless your primary user base is those who use Git as a deployment
>>>> tool to always follow along the tip of some external repository
>>>> without doing anything on your own on the branch you run your "git
>>>> pull" on, defaulting it to --ff-only does not make much sense to me.
>>>
>>> A lot of people do stuff, but the rebase it.
>>
>> If I am parsing the above properly, I think that is only saying that
>> "pull --rebase" makes sense for people who do real work, which I am
>> not disagreeing.
>
> You claimed that 'git pull' (--ff-only) only makes sense if the
> primary user-base doesn't do any work on it, but that's not true; they
> can do a 'git rebase' after such pull (or a merge).

Either you misread what I wrote or I was unclear.  I really meant
"anything on your own *ON* THE BRANCH YOU RUN your "git pull" on".
With

	git checkout frotz ; git pull --ff-only

you do not do anything "on frotz" other than following along.  You
can of course commit, rebase and all others on other branches like
xyzzy and push them out directly.  But you cannot even do this once

	git checkout frotz; git merge xyzzy

if you expect the next "git checkout frotz; git pull --ff-only" will
keep working usefuly.


> We don't have to assume our primary user-base wants to do full fledged
> merges, in fact, such assumption would be wrong.

I think we are in agreement on that point already.

An assumption that people who do merges are somehow more well versed
in Git and are more capable than others to configure their
repository or they will not be annoyed if you asked them a single
configuration change is also wrong, though.
