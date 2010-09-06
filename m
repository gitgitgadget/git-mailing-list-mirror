From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 6 Sep 2010 17:06:37 +0000
Message-ID: <AANLkTimBO+3UNwdFnjKJR0ODZWLAFbZ30zgYJ3Tfwhg4@mail.gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
	<4c8197ab.1707e30a.3f10.714a@mx.google.com>
	<201009061741.27840.trast@student.ethz.ch>
	<20100906180935.4881dbb8@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 06 19:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osf9Y-0003zp-Oy
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab0IFRGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 13:06:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61329 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0IFRGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 13:06:38 -0400
Received: by gwj17 with SMTP id 17so1615252gwj.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yWFlsoLIZ5rLE//9fn8lWQhIeM0YTWBukCPMY5pIRGg=;
        b=X9L0+DB4ZDfWSvsKqf26MpFmJ9lr+7Ja6VMo3YQ3ls5IUAPtdc6TJG92B2Sw30wi46
         Om3o9uQU58Qh/6ufeyGiz5wSRXzwBDC59aVg746sTdCLmfC1gUK3O1GBZ1p46k0Ysdu7
         fj6+YTlSSzutBgR3/9avbTgxhEH09sHtQJOt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N7c9IuQJyYDLSGMdTufvPbUwKAkXtPxQQnR2qNfdn81TZk5or+7M30l26XkRNYWmDI
         6uD2uLsyiQnhV2HeBuHGFeQ8vPBUh9tDLjTjrS1CHoHlWHokhf1/cBOkCjRR0dYGHid8
         +PhfVd1WU+9kT+tm3tsNHY/00D+uJCmXVu7Yk=
Received: by 10.101.211.11 with SMTP id n11mr3241995anq.91.1283792798020; Mon,
 06 Sep 2010 10:06:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 10:06:37 -0700 (PDT)
In-Reply-To: <20100906180935.4881dbb8@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155584>

On Mon, Sep 6, 2010 at 16:09, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Hi Thomas,
>
> thanks for your comments so far. I pretty much agree with all of your
> thoughts, so below I'm going to focus on those where I have something
> to say in addition to that.
>
>> > +#, c-format
>> > +msgid "nothing added to commit but untracked files present%s\n"
>> > +msgstr "keine =C3=84nderungen f=C3=BCr den Commit vorgemerkt, abe=
r
>> > unber=C3=BCcksichtigte Dateien vorhanden\n"
>>
>> Loses the %s (which is used for advice).
>
> That's me being careless. I will add an additional check to my workfl=
ow
> to prevent format string bugs from happening again.

As noted on IRC this would also be flagged by a compile error if we
were using `msgfmt --check` in the Makefile:

    -   $(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
    +   $(QUIET_MSGFMT)$(MSGFMT) --check -o $@ $<

I'll add that along with some other planned fixes after Junio pulls
the outstanding stuff we have queued up.

It'll break compatibility with Solaris gettext. There are ways to work
around that, but I think we should just drop support for it
anyway. GNU gettext is needed anyway if we want libintl-perl and some
of the fancier gettext features.

Solaris support was always something I was using for an extra sanity
check, not something I planned to support, and the extra effort of
doing so isn't worth the effort I think.

>> [way earlier, and same goes for "by us" -> "hier" [lit. "here"]]
>> > +msgid "deleted by them:"
>> > +msgstr "dort gel=C3=B6scht:"
>> [lit. "deleted there"]
>> > +
>> [...]
>> > +#, c-format
>> > +msgid "behind %d] "
>> > +msgstr "nur dort %d] "
>> [lit. "only there"]
>>
>> This had me pause for a moment. =C2=A0The concepts of "[merge side] =
theirs"
>> and "behind" are quite different; is it a good idea to translate the=
se
>> to the same?
>>
>> Especially so since later on you translate
>>
>> > +#, c-format
>> > +msgid "path '%s' does not have our version"
>> > +msgstr "Pfad '%s' hat keine Version 'von uns' im Index"
>> [lit. "... 'of us' ..."]
>>
>> I do agree that the best I can come up with, "von den anderen
>> gel=C3=B6scht", would be quite awkward.
>
> This was one of the more difficult things to decide on while
> translating. Both are difficult to translate into something that
> "flows", and individually I think both work okay the way I decided to
> translate them (but see the next paragraph), but of course it would b=
e
> preferrable to distinguish the two different concepts better. I'll be
> grateful for any suggestions.
>
> The real problem, I think, is that "ours" and "theirs" are misnomers =
in
> the original terminology. A good translation, I think, will not try
> to translate them literally... that would get us from misnomers to
> misnomers that also don't lend themselves well to the target
> language. :) The question, then, is how to rephrase the messages
> elegantly without removing them all too far from the original idea.
>
> This would be easier if "ours" and "theirs" always referred to the sa=
me
> concept... but they mean different things for merge vs. rebase, for
> instance.

Let's keep in mind that one of the major benefits of the gettext
series is that it's bringing focus to issues like this. Ideally we'd
like to fix those issues in the English originals, not just route
around the damage.

(I don't know if theirs/ours is such a case, but generally speaking..)
