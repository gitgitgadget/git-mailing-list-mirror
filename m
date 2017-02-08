Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4891E1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 03:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbdBHDCm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 22:02:42 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33512 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdBHDCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 22:02:41 -0500
Received: by mail-ot0-f194.google.com with SMTP id f9so16622520otd.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 19:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/xjLvV3f+1oIVaU+eKD8fdJh4pggqpre1IVizYqkRXs=;
        b=bj81A/AWB5Dbw8hdnhKWZXb4Ri0fzFe5DE62cAE2gZ8QA7Z08oxMDph502c2F51kNt
         AcDI6zBUtnzw4AtFVnKNfFOIsaJa/OteNyYwOOmArfB5e14D02sN5rkXCaFuKmFvyfzt
         XafdV2Al+lAwC6Ih4+k1KKeSvwf2sG31bG0sGTHGDDm5J4yVjvOyr6XpoNELSv/CH8IB
         t9Z+LPI4MWICdsl+pS3dzDZ4vp2PZKo8ZGQgNnC4zBTOacudmNPuOlvWfEySuuTveCb9
         7BAj8+HDG++xAmV6u3G5WpYC5s+EoqyF/ODUDyGUYfv9XJM3jeF+hKBNlqrOhisxEOgf
         y8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/xjLvV3f+1oIVaU+eKD8fdJh4pggqpre1IVizYqkRXs=;
        b=NqVh+RQYUV5fHBb76o6JnotS3KXqGglFcEKIfDUboo5xT58WJmAz2sG7uKKyEUKJaY
         0O2b6t5iuvUo+USWyMc6tJLvwcZtqYsfm4wVPzr7Ypc3viuswn0giqhJz3tdSIrNsoFe
         f6zA/pvzrisho2cEy4qF0VjRuqM+TfIJ6ZzbmGJNDvIRRg/Ypg7t9feiYSgsOoJNOIu/
         HfQQqOnGmwI3IQpGwA8xFmeDM/ySkzHZw3Vgao5njC0NFRLNlkSsL330OnglpHJPdaPo
         yRVa3carJ8gS4TVBP1X8n9gHhIusW9xLAs87Tze7B4B5BhPIwQGPuy7fM1ozZka8zQRE
         8Thg==
X-Gm-Message-State: AMke39km/jNxDJ3tFTbi9bMyWz06J9nmt1kcgmpUdQ4L70UDIqyd/IFi6WzD4TBkoZY/7m4BycT7SvFX99JFqA==
X-Received: by 10.202.232.77 with SMTP id f74mr2739527oih.60.1486522945531;
 Tue, 07 Feb 2017 19:02:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Tue, 7 Feb 2017 19:02:24 -0800 (PST)
In-Reply-To: <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2017 19:02:24 -0800
X-Google-Sender-Auth: JBCzISRfKeftBbp9cB-oIR_GSdc
Message-ID: <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  1. I think some commands limit their operands to cwd and some work
>     on the whole tree when given no pathspec. I think the "no
>     positive?  then let's give you everything except these you
>     excluded" should base the definition of "everything" to that.
>     IOW, "cd t && git grep -e foo" shows everything in t/ directory,
>     so the default you would add would be "." for "grep"; "cd t &&
>     git diff HEAD~100 HEAD" would show everything, so you would give
>     ":(top)." for "diff".

No. The thing is, "git diff" is relative too - for path
specifications. And the negative entries are pathspecs - and they act
as relative ones.

IOW, that whole

  cd drivers
  git diff A..B -- net/

will actually show the diff for drivers/net - so the pathspec very
much acts as relative to the cwd.

So no, absolute (ie ":(top)" or ":/") doesn't actually make sense for
"diff" either, even though diff by default is absolute when not given
a pathname at all.

But if you do

  cd drivers
  git diff A..B -- :^/arch

then suddenly an absolute positive root _does_ make sense,. because
now the negative pathspec was absolute..

Odd? Yes it is. But the positive pathspec rules are what they are, and
they are actually what I suspect everybody really wants. The existing
negative ones match the rules for the positive ones.

So I suspect that the best thing is if the "implicit positive rule
when there are no explicit ones" ends up matching the same semantics
as the (explicit) negative entries have..

>  2. I am not sure what ctype.c change is about.  Care to elaborate?

I didn't see the need for it either until I made the rest of the
patch, and it didn't work at all.

The pathspec.c code uses "if (is_pathspec_magic(..))" to test whether
a character is a short magiic pathspec character.  But '^' wasn't in
that set, because it was already marked as being (only) in the regex
set.

Does that whole is_pathspec_magic() thing make any sense when we have
an array that specifies the special characters we react to? No it does
not.

But it is what the code does, and I just made that code work.

>  3. I think our recent trend is to wean ourselves away from "an
>     empty element in pathspec means all paths match", and I think we
>     even have accepted a patch to emit a warning.  Doesn't the
>     warning trigger for the new code below?

It didn't trigger for me in my testing, I suspect the warning is at an
earlier level when it walks through the argv[] array and fills in the
pathspec arrays. But I didn't actually look for it.

                   Linus
