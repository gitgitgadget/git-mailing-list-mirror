Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF211F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfIDUag (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:30:36 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46783 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfIDUag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:30:36 -0400
Received: by mail-ua1-f66.google.com with SMTP id k12so3180030uan.13
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUY+nIF7FKqdAs81rDqPm0uybUAECihhoruQzdbAPvw=;
        b=lX/xR6gFD4KKJugY+kAIltNBmPzbdn1o5r7nbO+TiF7e/Tns5VCGxCyHAHBKzsndrh
         18jBF0RCCIkHahiNbSPXrmBkrjGhqEIqqdbZGPSpLUkHihxbmule/z/pKhM385KCvQju
         lFfyLFO5paetgXRhejEq1TDerC6uPnTRdGfK93RxbeqzC9akHKfVdfPevGJVzm2HUMr/
         0f+uI13905LjyrUEWpk7wNdEnNyvxKAO45w0ZuCFRwSMqSLRAIDEwh32FaSr0J1Jh+W9
         EQOwOF8YCEKSS8XJUpbbQJNEGCJfwl9CD1hz6F0FD2ag2U6oY0r3M4/spAZ7MGCB+KHX
         DGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUY+nIF7FKqdAs81rDqPm0uybUAECihhoruQzdbAPvw=;
        b=mQoeEC6qxMwttOY77W5NaCP3gqyl1aTysx+Fd7qFnRiDVsUXHggFGve4uEYQrva95j
         6ZH33XvQOW7/W7NECBtwAwcsoPXZVSlNkGHFv1cMLPn7Vmkzpqstj3OP3bNmBB7XSCfV
         cTf3xWJ6xadwt95QFHCeVBg7S4zESUIEnuYXe/GQp4rAYpk7e1Z04BFmkVKFPrO82oyl
         p0+NbAoPuHN6JUbSFdt+JreGhSLQb+LZNq2NTrRbSV2ZteyK17Q+KlZemhhsSFmLkLBk
         jbufxh4AKv718P0EihEZjg0Ui77AXohII7tSzdz+nby8Nts1BpQ9WWUdR0qXT57EQbVY
         /S7g==
X-Gm-Message-State: APjAAAXTagbnrtC74C7VkGRzF3MrzP2ryjfJpvcdAd9BBCF2GDI7pgrb
        aDl/atDu0MqBs+du36r0hzgV1wvxYB2TltcZ8j4=
X-Google-Smtp-Source: APXvYqzGkjKT8/U1ZA9LXNhucajtN8+vKF4zrnj9gLHL8QYzWfsK9IbGYcvN3jvqgWUatg+0Vj751Vp9+YmkA1icsJ8=
X-Received: by 2002:ab0:6908:: with SMTP id b8mr4620375uas.18.1567629035379;
 Wed, 04 Sep 2019 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190828002210.8862-1-newren@gmail.com> <20190903185524.13467-1-newren@gmail.com>
 <20190903185524.13467-4-newren@gmail.com> <xmqqo901rrcs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo901rrcs.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Sep 2019 13:30:23 -0700
Message-ID: <CABPp-BEEb1gZbChjbNQt_anUL65Le3Zf=seM9m3yEN1sEBf=BA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] Recommend git-filter-repo instead of git-filter-branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 5c5afa2b98..f805965d87 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -83,6 +83,19 @@ set_ident () {
> >       finish_ident COMMITTER
> >  }
> >
> > +if [ -z "$FILTER_BRANCH_SQUELCH_WARNING" -a \
> > +     -z "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" ]; then
>
> This is probably the only place where [] instead of "test" is used
> in our shell scripts.
>
> if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
> then
>     ...

Yeah, git-filter-branch.sh has approximately twice as many uses of []
than "test", so it seemed in line with its coding style.  I can switch
it over.

> > +     cat <<EOF
> > +WARNING: git-filter-branch has a glut of gotchas generating mangled history
> > +         rewrites.  Please use an alternative filtering tool such as 'git
> > +         filter-repo' (https://github.com/newren/git-filter-repo/) instead.
> > +         See the filter-branch manual page for more details; to squelch
> > +         this warning, set FILTER_BRANCH_SQUELCH_WARNING=1.
> > +
> > +EOF
> > +     sleep 5
> > +fi
>
> This should say it is "sleeping while showing the message and can
> safely be killed before starting to do any harm"; alternatively it
> should lose the "sleep".  The user would have fear against typing ^C
> to get out of a bulk history rewrite command, and the message itself
> is making the fear worse.  If your goal is to discourage its use,
> then it would be a good idea to make it clear when it is safe to
> kill it before going and studying the alternative.  Otherwise, the
> sleep does not help that much---the main complaint is that filter
> branch is too slow, so the user has plenty of time to read the
> message anyway, right? ;-)

Makes sense; will fix.
