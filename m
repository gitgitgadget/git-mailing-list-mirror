Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94D54211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLEEW5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:22:57 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:38067 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeLEEW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:22:57 -0500
Received: by mail-vk1-f181.google.com with SMTP id w72so4348927vkd.5
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 20:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc9CdeA5WpKsAlQtFsZ1xWOO3nOgLNet2gbmQ0JPiL0=;
        b=WJvnQSwPZ3vDzsxugPTaDmO/A69Z5IuxWnAb+biE5uSmhI+Lm03JLVzH8Fj7pTxaGY
         y759oWJw3f7fWDwxqeGNgfqhVhEJm+Sya4Ud/W6R6cryB89h8FfcJNOQavvI9/XpRCZt
         1yd/y9X3e9v9Cb4rV4+Vcr3N5r+5j0SR7q/qdSIovMO71ORNhOme1R5XW/wTa6q9+uQt
         DnP+ZyRqN7CNo0Sj2jS0kKh/UejPaNBKBiNCRxsWTu68x2yb+lJIByX/rBjQzZ+VMX1D
         CMglI+8yE78E0rFbgWGSiqf/HSJW1Num8pLBcWkMtlCe/lTjbz/Rl2Oru+5y5TKcSR9M
         KBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc9CdeA5WpKsAlQtFsZ1xWOO3nOgLNet2gbmQ0JPiL0=;
        b=AGPv+I/ZB7MlBtpnMEA88ZkUPbpPdEVs9TTMQihfj5bavBYE9ImdQ3lBrzt76abOGc
         9Dxk1Aub1ShVbQOjWLaPtYLMoypUAEGDVpNd+dmKg0Jk6GFIwOAgOB3wWXO2SP/9mN6V
         iD5kMDmHqpGmg6t2fAIrtcEkaNjEZu35HftxKyhOsu1sbcT+lBc79ZVZySrBY+mHXkLn
         mw5FXxq4703oOjVhnKWDjAZM1UGDf8FarrjSwjTNA4wHQWXY6eDkT0ULZ2shVV3PmzFR
         I7z2OlXpldRTEuXvKaN8e2bgOwSGknqWIksGL3CSHp9r714UVmQvLt2uRWS9QQgjUYkz
         Aahg==
X-Gm-Message-State: AA+aEWbiHoAmiIK9yt9/mDClEnLJ8THUYrVFbjHO5L/aOZ9LxJRntrza
        wSVGTEai9byQzAAnIOgDDTt5m4ePwiZPVyoOUJA=
X-Google-Smtp-Source: AFSGD/VGx+66IvLCM+X4zQe+DPyLzdS6ccS6o6o1mUJqrhNX8XbpXP4pmVaQxbAfUKw63UPDBToPlQrSciWNMNjqaO0=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr9831810vke.1.1543983775606;
 Tue, 04 Dec 2018 20:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <20181129215850.7278-8-pclouds@gmail.com> <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
 <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com> <xmqqtvjsen3r.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvjsen3r.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Dec 2018 20:22:43 -0800
Message-ID: <CABPp-BHnTqWjxfAYtjyoGsioBKPHcTfxK3jFaBDWCK4MasXDMQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 6:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> My single biggest worry about this whole series is that I'm worried
> >> you're perpetuating and even further ingraining one of the biggest
> >> usability problems with checkout: people suggest and use it for
> >> reverting/restoring paths to a previous version, but it doesn't do
> >> that:
> >
> > ...
> >
> >  git restore-files --from=master~10 Documentation/
>
> The "single biggest worry" could be due to Elijah not being aware of
> other recent discussions.  My understanding of the plan is
>
>  - "git checkout" will learn a new "--[no-]overlay" option, where
>    the current behaviour, i.e. "take paths in master~10 that match
>    pathspec Documentation/, and overlay them on top of what is in
>    the index and the working tree", is explained as "the overlay
>    mode" and stays to be the default.  With "checkout --no-overlay
>    master~10 Documentation/", the command will become "replace paths
>    in the current index and the working tree that match the pathspec
>    Documentation/ with paths in master~10 that match pathspec
>    Documentation/".
>
>  - "git restore-files --from=<tree> <pathspec>" by default will use
>    "--no-overlay" semantics, but the users can still use "--overlay"
>    from the command line as an option.
>
> So "restore-files" would become truly "restore the state of
> Documentation/ to match that of master~10", I would think.

Oh, sweet, that's awesome.  I saw some of the other emails as I was
scanning through and looked at the --overlay stuff since it sounded
relevant but something in the explanation made me think it was about
whether the command would write to the index or the working tree,
rather than being about adding+overwriting vs. just overwriting.

> >> Also, the fact that we're trying to make a simpler command makes me
> >> think that removing the auto-vivify behavior from the default and
> >> adding a simple flag which users can pass to request will allow this
> >> part of the documentation to be hidden behind the appropriate flag,
> >> which may make it easier for users to compartmentalize the command and
> >> it's options, enabling them to learn as they go.
> >
> > Sounds good. I don't know a good name for this new option though so
> > unless anybody comes up with some suggestion, I'll just disable
> > checkout.defaultRemote in switch-branch. If it comes back as a new
> > option, it can always be added later.
>
> Are you two discussing the "checkout --guess" option?  I am somewhat
> lost here.

Generally what was being discussed was just that this manpage was
rather complicated for the standard base-case due to the need to
explain all the behavior associated with --guess since that option is
on by default in checkout.  And since --guess is controlled by
checkout.defaultRemote, that was part of the extra complexity that had
to be learned in the basic explanation, rather than letting users
learn it when they learn a new flag.

The critical part you were missing was part of the original text just
before the quoted part was:

>>> So switch-branch will be controlled by checkout.* config variables?
>>> That probably makes the most sense, but it does dilute the advantage
>>> of adding these simpler commands.

Duy is responding to that even if it wasn't included in his quoting.

> >> > +-f::
> >> > +--force::
> >> > +       Proceed even if the index or the working tree differs from
> >> > +       HEAD.  This is used to throw away local changes.
> >>
> >> Haven't thought through this thoroughly, but do we really need an
> >> option for that instead of telling users to 'git reset --hard HEAD'
> >> before switching branches if they want their stuff thrown away?
> >
> > For me it's just a bit more convenient. Hit an error when switching
> > branch? Recall the command from bash history, stick -f in it and run.
> > Elsewhere I think both Junio and Thomas (or maybe only Junio) suggests
> > moving the "git reset" functionality without moving HEAD to one of
> > these commands, which goes the opposite direction...
>
> Isn't there a huge difference?  "checkout --force <other-branch>"
> needs to clobber only the changes that are involved in the switch,
> i.e. if your README.txt is the same between master and maint while
> Makefile is different, after editing both files while on master, you
> can not "switch-branch" to maint without doing something to Makefile
> (i.e. either discard your local change or wiggle your local change
> to the context of 'maint' with "checkout -m").  But you can carry
> the changes to README.txt while checking out 'maint' branch.
> Running "git reset --hard HEAD" would mean that you will lose the
> changes to README.txt as well.

Ah, indeed.  Thanks for pointing out what I missed here.

> >> > +--orphan <new_branch>::
> >> > +       Create a new 'orphan' branch, named <new_branch>, started from
> >> > +       <start_point> and switch to it.  The first commit made on this
> >>
> >> What??  started from <start_point>?  The whole point of --orphan is
> >> you have no parent, i.e. no start point.  Also, why does the
> >> explanation reference an argument that wasn't in the immediately
> >> preceding synopsis?
> >
> > I guess bad phrasing. It should be "switch to <start_point> first,
> > then prepare the worktree so that the first commit will have no
> > parent". Or something along that line.
>
> It should be a <tree-ish>, no?  It is not a "point" in history, but
> is "start with this tree".

Are you saying that referring to it as a tree will lessen the
confusion users face when they think it's a commit that serves as a
parent and get confused with the fact that this option is named
"--orphan"?  Or are you making some other orthogonal point here?

> I may have more comments on this message but that's it from me for
> now.

Fair enough.  Sorry if I've distracted from RC stuff with all my responses.
