Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0D41F461
	for <e@80x24.org>; Fri, 17 May 2019 11:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfEQLKV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 07:10:21 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33103 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfEQLKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 07:10:21 -0400
Received: by mail-pg1-f173.google.com with SMTP id h17so3177226pgv.0
        for <git@vger.kernel.org>; Fri, 17 May 2019 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a9EJdEosV5Qj2wdMgz+JRpZiDKPq5igEQGb/aYpCNc=;
        b=byO97JbDciZjDE9tfhcKZcYB9DMfFtCNrGBw6tCVCRZm8UoqAFzquB4PFbHbJprRhm
         NHvqhM998ylo7JQJBP+RuB1c/BCbz1sLyULITYFAeXOJWuo4AZoyGy0ABcu0SNq6hXl0
         fxL4HQXyv7/AiXv27MGWBDzqGwABSspxPfM9T0sDPNuOW2e2efCtK5iZltXZ0qkPxfCc
         QU+LI4C1H2lAeg1O9WPXl1Eq773L7LDZA5V2e9m9KBXupCKCrsuqKd7E4EgAw1fuHk8O
         HjsjgIn5ddl89u5Q/wbcrzlxLGD4vCaw9VbLFMYt4FkJm4wU3o/A5MbkNWPVXpVfptn9
         rbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a9EJdEosV5Qj2wdMgz+JRpZiDKPq5igEQGb/aYpCNc=;
        b=jrs9uxykXOer3a/HddB2lWC3KYPCDIx6D6I9uUZI4CrpJUUIGneciWStNrIKSxqV/K
         brKAroP9sKbMUNnyS2dmmUnmQ0lsXKWVwNjPAojVq2rQNzBBJ/gpjpg/GR7vMeBV15RV
         mtI/ByXu3tnOITQfAmKJBgxIR/kWqGRNhC3O/VttD/Ku7ZHQfb680c7S8XARWcQTrQPB
         wB31w1DEa8HoM0SnEitRgN2x46ocwwDOi4jAnKFOZ0RU/L3KFKgTbaGIYzEfdhZ9Qz80
         dU8i4pzIl6lS3zemnfz3ucsnPQmUnsS1f999XhKJsOLEvxvht+37smv/OEjK89UOD79d
         /A6Q==
X-Gm-Message-State: APjAAAVjr+ZBIf7ZHTegh/Lbb3HzuzwTSvnvRbqggvycJOOaWKCw4MVc
        hMek5V7ivDnu9uZvnjfqSHANJSx2CdROPCdcKybLTw==
X-Google-Smtp-Source: APXvYqzxifssvLCBcqwGU/w2b76S+eoPmGwKCjFinek/pA/SXQGt0XN8A/b+cTNM14TIbSwwzwH4iq29QKm0zPSPyxc=
X-Received: by 2002:aa7:9615:: with SMTP id q21mr41769631pfg.253.1558091420869;
 Fri, 17 May 2019 04:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUvTg5S_-i9JjOwEG75CY+xFXJHAwTqh8uLG3SQTa3O0YA@mail.gmail.com>
 <CAPig+cQ0MB4F++JDC-RO2SFA4Hv7DiEW4hNJGQs71Wi75pXuOg@mail.gmail.com> <CAGqZTUv7zkgT=GJK5Mo7HCoNcjqvsZoCKb93Pc=_r6LcskAabw@mail.gmail.com>
In-Reply-To: <CAGqZTUv7zkgT=GJK5Mo7HCoNcjqvsZoCKb93Pc=_r6LcskAabw@mail.gmail.com>
From:   clime <clime7@gmail.com>
Date:   Fri, 17 May 2019 13:10:09 +0200
Message-ID: <CAGqZTUuh5K447ejUTDfnR-5t0oqQ8BpU=tKUR=s9APmCja=mhw@mail.gmail.com>
Subject: Re: getting pull/push/fetch url
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 May 2019 at 13:02, clime <clime7@gmail.com> wrote:
>
> On Fri, 17 May 2019 at 10:10, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Fri, May 17, 2019 at 3:30 AM clime <clime7@gmail.com> wrote:
> > > for my app, i need to be able get remote urls (fetch/pull/push) so
> > > that i can derive some information from those, e.g. pull url netloc
> > > from which i derive where other custom endpoints (binary file storage)
> > > related to the remote git repo is located. This is just one example. I
> > > am also using fetch url to store it into the composed package that i
> > > generate by the app.
> > >
> > > Now, the problem is that getting those urls (fetch/pull/push) doesn't
> > > seem to be an easy task. Currently i have the attached scripts to do
> > > that. But i noticed that older gits like 1.7 use origin as a fallback
> > > for pull url whereas the newer raise an error.
> > >
> > > My question is if there is a better way to determine the urls that
> > > would be backward compatible and easier than what i am doing right
> > > now.
> >
> > Perhaps not a complete answer (and I'm sure people more familiar with
> > the topic can provide better direction), but have you tried querying
> > this information via higher-level commands rather than low-level
> > git-config? For instance, to get the name of the remote for a branch:
> >
> >     git branch --list --format='%(upstream:remotename)' $BRANCH
> >
> > and, to get the fetch URL for a remote:
> >
> >     git remote get-url $REMOTE
> >
> > or the push URL:
> >
> >     git remote get-url --push $REMOTE
>
> Right, the problem is that both constructs `git branch --list
> --format=<format> <branch>` and `git remote get-url <remote>`
> works only under git v2 (not exactly sure about the minor version) but
> they do not work under git 1.7.1 and git 1.8.3, it
> seems.
>
> Anyway, i figured i was too fuzzy in what kind of url i actually need.
> I thought about it a bit more and figured that I probably this
>
> function git_branch_remote {
>     branch_remote="$(git -C "$GIT_ROOT" config --get
> branch."$GIT_BRANCH".pushRemote)"
>
>     if [ -z "$branch_remote" ]; then
>         branch_remote="$(git -C "$GIT_ROOT" config --get remote.pushDefault)"
>     fi
>
>     if [ -z "$branch_remote" ]; then
>         branch_remote="$(git -C "$GIT_ROOT" config --get
> branch."$GIT_BRANCH".remote)"
>     fi
>
>     if [ -z "$branch_remote" ]; then
>         branch_remote="origin"
>     fi
>
>     echo "$branch_remote"
> }
>
> Because basically, if some wants to go for triangle workflow, then
> push url remote should be preferred because
> that's where user has write access. If not, then there is a fallback
> to branch.<branch>.remote and to origin
> eventually, which is just nice to have cause it makes a minimal setup
> for my app easier.
>
> So basically, it is possible that an effective (where git actually
> pushes when `git push` is invoked) remote
> for pushing will be different than what that function returns (e.g.
> when git 1.7.1. is used which doesn't
> know about branch.<branch>.pushRemote and remote.pushDefault) but it
> doesn't really matter as long
> as a user is able to make a local configuration where effective push
> remote and remote returned by
> the fuction will align.
>
> Then i also need 'origin' being returned immediatelly after clean
> clone but that's the case as well.
>
> So when i have this kind of 'abstracted' remote, then i need to take
> pushUrl on one place and fetch
> url on another but there should be no problem there.
>
> Sorry, i didn't realize i actually kind of this 'hybrid remote' thing.
> There still might an easier way to write
> that function (in a compatible way). Not sure about that.
>
> Anyway, thanks
> clime

And sry for my previous email being a mess. I rushed too much
to write it.
