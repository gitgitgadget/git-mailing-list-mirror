Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9886C1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 06:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392235AbfHWGE2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 02:04:28 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41874 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfHWGE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 02:04:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id m62so5455075vsc.8
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nb85gml8pqXmAfbOK+KtY1Kl3zlfJIIeZRLRMDzadtI=;
        b=a4EUyKBwbiPpAsGSVTBEuCKVEUqJEV86IEw5TzGNVyC3xadeFulFk60J6gqjAcQiAE
         PJrkEomLo58lZJAgIcK+7iXpGX29mxmpcaxZE7Nrm/6tl2vOxidp5cNBE+kUwpG669HH
         pSum5fVf4xhIGAlyV9kMv0Z0FmcM25IHUK+vwEzXwUichOa+Yc1Vagi5GtrUmGigQb8H
         kQmlng2fe28+KdCQ2ihzs+WBC9TKorTd8SK9/qBESdqf44pEe4p8q1HZMW7RA395bM4n
         lZ1ydXdX02oNRQbVDBJ+oARhp5Qy7IcoK9IjlXs4if0mBgsmhBjIpIyY0dYXBqhVuFFR
         /tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nb85gml8pqXmAfbOK+KtY1Kl3zlfJIIeZRLRMDzadtI=;
        b=bM83zTzkXiJutZe3PTuL/0VY0hoQKEso7UdG9wiH/NgrCSF4PrapfUFMQIGJraN2f6
         IOyZIKFwK2/f8Uur8gNZf2xNSWXkqesQJu0fyzK6Xn16a8Jr3Ovyp8BXrzv7+OsxkTS0
         yfX7aAStwwWbvXpyp0AaGZo5eeocB7we8syrNaT2wZ5nVwdD2HKifSOL1pXyjOEyD5tL
         Cwm3JBPKXZsDpUifEg4M7FICt3wkRebzGzIHaCG5g6GC2G9rmC+IpV13qWNHu14hbRLu
         /bnh3b6J5rChKhqj1gCnvIsmwGlaJ6LeVk5qN3TLf2O9UM9/HQPRn1km511KpylzcTsS
         cYFQ==
X-Gm-Message-State: APjAAAWpqUiwvLG9WHbW8wPoVd4uTtDLtzXvYi/1rAfeBfGZr5sHnrdz
        OK3Srh2GZXGAbzBsUhGosWikD2mBYRgmVDZkuVM=
X-Google-Smtp-Source: APXvYqy9O3iL1whoCVlW7C6Gd60uhL/qvkXiSRp56xy+ZSyumo55JdMcEGXuWnJQ7iGXhOPxUJrAATtp6JAKXnqWeo4=
X-Received: by 2002:a67:e9da:: with SMTP id q26mr1584670vso.31.1566540265843;
 Thu, 22 Aug 2019 23:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190819214110.26461-1-me@yadavpratyush.com> <20190822220107.4153-1-me@yadavpratyush.com>
 <xmqq4l28ommg.fsf@gitster-ct.c.googlers.com> <20190822225143.3blolae3f65z6zqq@localhost.localdomain>
In-Reply-To: <20190822225143.3blolae3f65z6zqq@localhost.localdomain>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 23 Aug 2019 08:04:14 +0200
Message-ID: <CAKPyHN27Pz8BtzdUCewZMd2wi5hx8LyJTfJqwkyTbbQLJk+=VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 12:51 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 22/08/19 03:34PM, Junio C Hamano wrote:
> > Pratyush Yadav <me@yadavpratyush.com> writes:
> >
> > > This series adds the ability to revert selected lines and hunks in
> > > git-gui. Partially based on the patch by Bert Wesarg [0].
> > >
> > > The commits can be found in the topic branch 'py/revert-hunks-lines'
> > > at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
> > >
> > > Once reviewed, pull the commits from
> > > 415ce3f8582769d1d454b3796dc6c9c847cefa87 till
> > > 0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
> > > apply them locally, whichever you prefer.
> >
> > Let's see how we can work together by you playing the role of
> > git-gui maintainer and the others on the list (including me) playing
> > the role of reviewer and contributor.  So I may keep an eye on the
> > discussion on this thread, I may even comment on them myself, but
> > you'll be the one waiting for the discussion to settle, adjusting
> > the patches in response to reviews, etc. and making the final
> > decision when/if the topic is done, at which time you'd be telling
> > me to pull from you.
> >
> > > Pratyush Yadav (4):
> > >   git-gui: Move revert confirmation dialog creation to separate function
> > >   git-gui: Add option to disable the revert confirmation prompt
> > >   git-gui: Add the ability to revert selected lines
> > >   git-gui: Add the ability to revert selected hunk
> >
> > "Move" and "Add" after "git-gui:" would better be downcased to be
> > more in line with the others in "git shortlog --no-merges"; I also
> > think "allow doing X" is shorter and better way to say "add the
> > ability to do X".
>
> Will fix. Thanks.
>
> > If I am reading the first patch correctly, we already ask for
> > confirmation before reverting local changes, and the steps 3 and 4
> > are about allowing partial reversion in addition to the wholesale
> > reversion, right?
>
> Yes. The ability to revert whole files already exists. This revert
> always asks for confirmation. Steps 3 and 4 allow for partial reverts.
> Step 2 allows the user to disable the confirmation dialog for both
> whole-file reverts and for partial reverts.
>
> > An earlier objection from j6t sounded like we
> > require users to respond to an extra dialog after this series, but
> > that does not look like the case.  Instead, step 2 adds a new
> > feature to allow those to opt-out of the existing dialog (which may
> > be reused to squelch the dialog to protect features added in steps 3
> > and 4).  Am I reading the series correctly?
>
> Yes. The users always responded to an extra dialog for whole file
> reverts even before these changes. j6t was running a fork of git-gui
> which had the ability for partial reverts, and his fork did not ask for
> confirmation for partial reverts. Always asking for confirmation
> disrupts his workflow, so I added an option to disable it. It disables
> the dialog for partial reverts (which j6t cares about), and also for
> whole file reverts, which I added to maintain consistency.

as I'm the one who use this feature for more than 7 years, I can only
object to this. I'm happy to have the confirmation dialog for the
whole-file revert (the current state) but having the dialog also for
partial revert would be too disruptive. And disabling both at the same
time would not be an option for me.

The thing is, that the partial revert "just don't happen by accident".
Here are the minimum user actions needed to get to this dialog:

1. whole-file revert

- do a Ctrl+J, more or less anywhere in the GUI

2. hunk revert/revert one unselected line

- right click anywhere in the diff pane (thats around 60% of the window area)
- move the mouse pointer down 3/4 menu items
- click this menu item

3. partially revert selected lines

- select some content in the diff pane by starting by pressing and
holding a left click
- end the selection by releasing the left click
- move the mouse pointer down 3/4 menu items
- click this menu item

Thats always at least 2 user actions more than the whole-file revert.
Thus this cannot happen by accident quite easily in comparison to the
whole-file revert. And thats the reason why this dialog exists, from
my point of view.

I can see the need to disable the dialog for the whole-file revert,
and IIRC that was also requested a long time ago on this list. But I
don't see a reason to have this dialog also for the partial reverts as
a safety measure.

Best,
Bert

>
> --
> Regards,
> Pratyush Yadav
