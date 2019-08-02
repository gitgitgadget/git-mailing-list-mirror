Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6063C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfHBWUq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:20:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36464 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfHBWUp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:20:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so36717567pgm.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VdtUA8GTeNP/F1yn3EFUH8OjY8rEdyiT8ZGBlLENK9c=;
        b=sm5pc0rZCc9m7q+KCJaCPIgoAHNpCwiBGtJpEG64+FdqCI5cDIDw4VKhX2k4X+O0UU
         GYCaXKDkEellQwAn/Z2IA7KexT1FUpxZh1mtHSe6AvWM35BiaxSMiEFwxcwAoTs0axqK
         OVi6VuHl1FhsryJk+MkJaQUn9KhR4VnU143nTvkOa0zyPBgtjAF8ME7fQ5ADdj4RpeWB
         dTKw015KDhAMZnFWt75BqPeOaJ4XOk+qNsvOV/dIaCw8R9GEXG3qg1Xj0HOeZRqUg092
         JzndQGpdLd4dYws28FAJoGJrMYOzRy4ls0OyeuAPFcHQikxPEtCYsuc7GVYEC0srrFAi
         k1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VdtUA8GTeNP/F1yn3EFUH8OjY8rEdyiT8ZGBlLENK9c=;
        b=ox4a7bJ7i9/psb+9lhc1/1/Cia1s/6E1VYjODaNjrCdM51p6FCCLZOZ4SroiEikeu1
         7cACanHZbZr1Ula+dZdlVSU5qnNwZPQ7OARXA71V0/q0GvBhyjkLi2a/vCigO5KQVQAb
         /UGp0NHrpYys/WTUnBumBv6WKLC//UK+yxsJOfyvfi3jfiwmCTleZHqV2WNocCYHqgMe
         Tg7kQW53K6FM/hcPdGrj54+BUNBsSF5biKCNfSnQap1Tn4VTvIzBmJupY8F8q8MVeMeJ
         mGsaeqAy6Jkl807kI3WmPKb+zZfVIYn6rr2RRSm3C0EEjsIhV8jLTAWJyge/nyOB78JH
         hN/A==
X-Gm-Message-State: APjAAAXQSEhySi4hRQ+dKf26bhmXil/J694ZynfVu4gAzKsEOvF1gEA4
        Wbb4yYlFd8m3TutIVmINZhNAVhCgxMGwpQ==
X-Google-Smtp-Source: APXvYqxX53u+cfi4HUJyu5x6Fg9mx2alWsZG4rCYS17l3n+Q2OFZMuIei115T6Cv+N5ZtPFpifUk2w==
X-Received: by 2002:a62:1c5:: with SMTP id 188mr59475884pfb.26.1564784444801;
        Fri, 02 Aug 2019 15:20:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id a25sm51140145pfo.60.2019.08.02.15.20.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 15:20:43 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:20:39 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v3 3/4] git-merge: honor pre-merge-commit hook
Message-ID: <20190802222039.GS43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
References: <cover.1563490164.git.steadmon@google.com>
 <cover.1564695892.git.steadmon@google.com>
 <61b989ff16eadfd0508e10f71c9b318eb15ce2a7.1564695893.git.steadmon@google.com>
 <CAN0heSo30-ng223sJTvz5_Go+-Yu=h=qvFg0KOhguLsFVE7b2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSo30-ng223sJTvz5_Go+-Yu=h=qvFg0KOhguLsFVE7b2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.08.02 11:45, Martin Ågren wrote:
> On Fri, 2 Aug 2019 at 00:20, Josh Steadmon <steadmon@google.com> wrote:
> 
> > diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> > index 82cd573776..7c4c994858 100644
> > --- a/Documentation/githooks.txt
> > +++ b/Documentation/githooks.txt
> > @@ -103,6 +103,13 @@ The default 'pre-commit' hook, when enabled--and with the
> >  `hooks.allownonascii` config option unset or set to false--prevents
> >  the use of non-ASCII filenames.
> >
> > +pre-merge-commit
> > +~~~~~~~~~~~~~~~~
> > +
> > +This hook is invoked by 'git merge' when doing an automatic merge
> > +commit; it is equivalent to 'pre-commit' for a non-automatic commit
> > +for a merge.
> > +
> 
> I'm not sure everyone understands what an "automatic merge commit" is.
> (Is it an automatic "merge commit", or an "automatic merge" commit? Or
> sort of both?) And I'm not sure exactly what to infer from the
> "equivalence". I happen to know that the statement about the default
> hook can only be half-carried over. And I'm not sure what to infer from
> "All the git commit hooks are invoked with the environment variable
> ...".
> 
> Is the below suggestion 1) correct, 2) readable?
> 
>   This hook is invoked by linkgit:git-merge[1], and can be bypassed
>   with the `--no-verify` option.  It takes no parameters, and is
>   invoked after the merge has been carried out successfully and before
>   obtaining the proposed commit log message to
>   make a commit.  Exiting with a non-zero status from this script
>   causes the `git merge` command to abort before creating a commit.
> 
>   The default 'pre-merge-commit' hook, when enabled, runs the
>   'pre-commit' hook, if the latter is enabled.
> 
>   This hook is invoked with the environment variable
>   `GIT_EDITOR=:` if the command will not bring up an editor
>   to modify the commit message.
> 
>   If the merge cannot be carried out automatically, the conflicts
>   need to be resolved and the result committed separately (see
>   linkgit:git-merge[1]). At that point, this hook will not be executed,
>   but the 'pre-commit' hook will, if it is enabled.
> 
> (If you use this or something like it, notice how this already mentions
> `--no-verify`...)

This looks good to me at first glance. I may reword a bit in V4, but
probably not much.

> > +test_expect_success 'root commit' '
> > +       echo "root" > file &&
> > +       git add file &&
> > +       git commit -m "zeroth" &&
> > +       git checkout -b side &&
> > +       echo "foo" > foo &&
> > +       git add foo &&
> > +       git commit -m "make it non-ff" &&
> > +       git checkout master
> > +'
> 
> You got rid of loads of "> file" in patch 1/4, so it seems unfortunate
> to introduce a few here. ;-)

Thanks for the catch, will fix in V4.
