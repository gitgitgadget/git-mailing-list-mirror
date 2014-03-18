From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 21:59:26 -0400
Message-ID: <CAPig+cRGwBV5CE3X9yGZGRNtKojCagz_F_f4Kd+S+D_qX+ZwJw@mail.gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
	<1395093144-6786-2-git-send-email-quintus.public@gmail.com>
	<xmqqob14a14s.fsf@gitster.dls.corp.google.com>
	<CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPjJf-0007zl-SG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 02:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbaCRB73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 21:59:29 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:45649 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbaCRB71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 21:59:27 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so6191173yhl.20
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QSAeUL8n1K1bCsQsObmglQb2iAEgubYeRN0ibJKLedg=;
        b=yfbuRgRN+8wx4mUQt0JMOGz94/MyuqvpheUutHP7wHpBbMLkJGiTNowZDmQjo8KPLe
         oI4Ltr7kuLc6unkyddPm3f4MTnbeNHUrYagg6jJikXwdaAYkraIv+1GEIOR8fkhODKoI
         ss2WxhQ6X75lgVxAcyr3BW2qlAk9H5jIAej7MgVXqo12l4x+v2JzMOH/57AyUOZzSep7
         sGlcqNhMELapjH0CpUQKHCAvxpJ0LlfecSfo+k+wmc1+SdjXkdx65YFhvUaokUxQyt9P
         F+My+D38yVCMrdsyu4xRAe4ys7qoKWOzHYSE00gTmxUGA8zwp4QpacZOgChoivcTwRxc
         7lKA==
X-Received: by 10.236.200.35 with SMTP id y23mr14221065yhn.38.1395107967045;
 Mon, 17 Mar 2014 18:59:27 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 18:59:26 -0700 (PDT)
In-Reply-To: <CALs4jVGxmirDdO03kaKco7=NrTaXBinY=1U71=fYwX1mbqNDOA@mail.gmail.com>
X-Google-Sender-Auth: wL17Blvrcf7F0YfWYvx78HoSR9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244320>

On Mon, Mar 17, 2014 at 7:46 PM, Quint Guvernator
<quintus.public@gmail.com> wrote:
> 2014-03-17 18:52 GMT-04:00 Junio C Hamano <gitster@pobox.com>:
>> Thanks.  This probably needs retitled, though (hint: "replaces"?
>> who does so?) and the message rewritten (see numerous reviews on
>> other GSoC micros from Eric).
>
> I found some messages [1] by Eric concerning imperative voice ("simplify"
> rather than "simplifies/ed").
>
> Other than the change of verb, what sort of changes are you looking for in
> the description? It doesn't look much different than, for instance, this
> [2] commit in the log.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/243848
> [2]: https://github.com/git/git/commit/0eea5a6e91d3da6932c13f16fdf4b4e5ed91b93c

I can't speak for Junio, but the description could be made more
concise and to-the-point. Aside from using imperative voice, you can
eliminate redundancy, some of which comes from repeating in prose what
the patch itself already states more concisely and precisely, and some
from repeating what is implied by the fact that you're making such a
change in the first place. Here's your original:

    Subject: general style: replaces memcmp() with starts_with()

    memcmp() is replaced with negated starts_with() when comparing
    strings from the beginning and when it is logical to do
    so. starts_with() looks nicer and it saves the extra argument of
    the length of the comparing string.

In the subject, "general style" is a bit unusual. This isn't just a
stylistic change; it's intended to improve code clarity.

Examples of redundancy:

"memcmp() is replaced with ...": The subject already says this.

"negated starts_with()": Having to negate the value is a necessary
artifact of switching to starts_with(), thus it's a mere
implementation detail of the change. There is no mystery here. Anyone
familiar with memcmp() and starts_with() will understand implicitly
why the value is negated.

"when comparing strings from the beginning": That's effectively
implied by the name starts_with(). (And, if you did happen use
starts_with() at a location other than the start-of-string, a reviewer
would likely point out that doing so makes the code less readable.)

"when it is logical to do so": The scope of the patch already implies
that the changes are restricted to cases when it is logical to do so
(and if it's not, a reviewer will question the illogical changes).

"starts_with() looks nicer": Subjective, as written. Reworded to be
more forceful, it might make a decent justification for the patch (see
below).

"saves the extra argument": This is incidental to the real change,
which is to make the code read more clearly, and is an obvious
artifact of switching from memcmp() to starts_with().

A patch of this nature doesn't require much more description than
stating what it does ("replace memcmp() with starts_with()") and why
("improve code clarity"). The following rewrite might be sufficient:

    Subject: replace memcmp() with starts_with()

    starts_with() indicates the intention of the check more clearly
    than memcmp().
