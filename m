From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 07 Sep 2013 09:10:30 -0700
Message-ID: <xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 18:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIL5v-00067x-Kw
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 18:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab3IGQKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 12:10:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab3IGQKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 12:10:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11EAA3DA62;
	Sat,  7 Sep 2013 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZZHfcEMt+3h6EhFBJ38JjO2IPa4=; b=Y1CbwT
	oNipJVStyMYqWS2UCnGWzB3q+cHuazN1moH+YACF7MadBybqlRgE/ubW/ETeodSl
	b/k3VENu/CnX6bdj/UfgoL2q9nWIB1lxOsnsDy2voNUA1a3oJp65Isa25hFj0Z6q
	m3n46K3oj2pfwgHF6x6EuhIDuLor8xw6jTmpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5527fQwJdTlhnF05ZLIo4AUarvZvvqL
	HLX6CHzhzTRpmdtcYAyGK+WvvxGE3kdnlM7mLFUJ2UgLCD8So41OYWbqYCgRr6pJ
	vwyCn4Hc9Mf5DmMauaCygfxGBHYxFvx9/Nl+r5NTPnYbV6w311njD1xR8UTuFb7x
	xyABdaTq3DI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B99E13DA5F;
	Sat,  7 Sep 2013 16:10:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7C173DA53;
	Sat,  7 Sep 2013 16:10:32 +0000 (UTC)
In-Reply-To: <CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	(Sebastian Schuberth's message of "Sat, 7 Sep 2013 14:28:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05D7BB56-17D8-11E3-AAB7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234136>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Fri, Sep 6, 2013 at 11:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> For custom builds of Git it sometimes is inconvenient to annotate tags
>>> because there simply is nothing to say, so do not require an annotation.
>>>
>>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>>> ---
>>
>> Hmmmm, personally I'd actually want this to stay the way it is, or
>> even require a valid signed tag, in order to make sure I won't
>> mistakenly creating a lightweight tag.

I do not mind taking the patch after all, after thinking about it
a bit more.

See later part of the message for this.

>> If you want to give build a custom name,
>>
>>     echo buildname >version
>>
>> should be sufficient, no?
>
> That's not sufficient if you care about a proper (automated) release
> workflow with your releases tagged.

I take the above "your" does not refer to "mine, Junio's".

I am not sure what you mean by automated, but if you can tell your
automation infrastructure that the way to build this Git software is
to run "make" in it, shouldn't it be trivial to instead tell it to
run something like this instead?

	git describe --tags HEAD >version && make

Or are these tags you want G-V-G to use also droppings of the
automated process?  That is, what you tell the automation
infrastructure is to run something like this?

	git tag build-$(date +"%Y-%m-%d") && make

If that is the case, it would be sufficient to tweak that to leave
the same information in >version file and you do not lose any
automation.

So I do not understand the above "not sufficient if you care about"
comment at all.

Having said all that.

I do not think the current use of "describe" helps the builder to
avoid making a light-weight tag by mistake anyway, as it would be
very natural to update DEF_VER to a matching string. In a month or
so, I am sure I'd update that line to v1.8.5 before I make a tag
with the same name, and it does not matter if the current use of
"describe" skipped a mistakenly-made lightweight v1.8.5 tag when
deciding the embedded version string---the end result will get the
same string from DEF_VER and running "git version" with the built
binary will happily show v1.8.5 the same way.

I am however still curious what kind of other tags (either signed,
annotated, or lightweight) you are using for this purpose. Is there
a case where you have your own tag that points at the exact version
as I tagged?  In such a case, do you have a preference on which tag
do you want GIT-VERSION-GEN to use?
