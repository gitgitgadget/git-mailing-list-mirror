From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Mon, 19 Oct 2015 22:17:44 -0700
Message-ID: <xmqqbnbu9kzr.fsf@gitster.mtv.corp.google.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
	<xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
	<xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com>
	<CAMMLpeTf93NnqPM+SaxfhsSdMg1HUiVyo5FFdiuGF9o-KQbGog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 07:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoPJV-00082d-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 07:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbbJTFRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 01:17:48 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35091 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbJTFRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 01:17:47 -0400
Received: by pasz6 with SMTP id z6so9507628pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uJFm7rS/Ls/XxtBUflrvBjpCjgilhDzhli1ssq78ck8=;
        b=oXKrMWLS/CAMICcHF/NicA3QebzDCWSzzPFiAkwTvsz0QCJDaP7bRfH/u3MuvjkQj8
         L8tRNIwM14ua1a//JWwQm9Ocgiu7vE8KscNYGwmM9D3OdstuHkJCpvxYPeg8EfdM/mLJ
         n7jYcRoduHbAarSlg8AxGy0lm/O1uZVRdnoGDgMuIp74DH4nQePqJwL3VI6Nc0xDjV6z
         9oAkWNBAqwDaZRS620xGAudfB+y2YGJpQe2qTwR0FuDpMzHwF/swuy+UDQaL9QcRrS8r
         edpsHirmXOj2x6CrGmldRYgjNqGIraWgoVlzYIJ5sYBsiOY42YKsi4umaHt16cNiCqD5
         gf9A==
X-Received: by 10.68.173.130 with SMTP id bk2mr1613794pbc.169.1445318266779;
        Mon, 19 Oct 2015 22:17:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id ve8sm1184161pbc.48.2015.10.19.22.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Oct 2015 22:17:45 -0700 (PDT)
In-Reply-To: <CAMMLpeTf93NnqPM+SaxfhsSdMg1HUiVyo5FFdiuGF9o-KQbGog@mail.gmail.com>
	(Alex Henrie's message of "Mon, 19 Oct 2015 11:27:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279901>

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2015-10-16 11:42 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>>
>> Yes, but that fixes historical "mistake", no?
>>
>> With this, you are breaking historical practice by changing only one
>> instance to deviate from the then-current practice of saying
>> 'options' without brackets.  It is based on the point of view that
>> considers anything inside <bracket> and a fixed string 'options' are
>> meant to be replaced by intelligent readers, which is as valid as
>> the more recent practice to consider only things inside <bracket>
>> are placeholders.
>
> OK, I see. You're saying that it's OK to fix typos and grammatical
> errors in contrib/examples, but it's not okay to modernize the
> scripts' designs.

Please read it again, look at contrib/examples and realize that that
is not what I said at all.

This is not about modern vs old-school.  The reason why the part of
the patch to contrib/ under discussion is wrong is because of
(in)consistency.

Look at the output from "git grep option contrib/examples/" and
notice that in the old days, these scripted Porcelains consistently
said "[options]" without "<bracket>".

It would have been a different matter if the patch _were_ to update
all "[options]" to "[<options>]" in contrib/examples/ consistently,
and such a patch might have even been an improvement, especially if
the modern style were clearly superiour than the old-school style
(which is not, by they way [*1*]).

But that is not what the patch did.  It turned only one of them into
"[<options>]", making the single instance inconsistent from all the
others around it.  That is why it was wrong.


[Footnote]

*1* The "modern" style is not necessarily an improvement, by the
    way.  The way we specify that a "thing" in the help text is a
    placeholder and that there may be more instances of the same
    "thing" is to say "[<thing>...]", but in your "modernized" form,
    unlike all the other usual "things", possibly multiple options
    are spelled "[<options>]" without having ellipses at the end,
    which is an oddball.  If we are to treat options specially like
    that anyway, intelligent readers can read an "old-school"
    description "[options]" and understand that that token stands
    for possibly multiple options just fine, and all we have gained
    by going to the "modernized" form is to waste two characters for
    <brackets>.

    I am not saying that we should not apply the other half of the
    patch that makes builtin/pull.c say "[<options>]".  These days,
    many other commands nearby (i.e. the "modern" ones) do use that
    form consistently, so it is an improvement.
