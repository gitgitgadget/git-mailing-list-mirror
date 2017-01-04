Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700F620756
	for <e@80x24.org>; Wed,  4 Jan 2017 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030213AbdADVLP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 16:11:15 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36285 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936331AbdADUxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 15:53:50 -0500
Received: by mail-pg0-f51.google.com with SMTP id f188so231011571pgc.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=og70JmSI8PiRKrdb+zUHlmZqFDFORSXT1Xk33Re49Xs=;
        b=Uoys3quCjysOMdGVs8vYuiA3AnJi3haDpaIZ47wXMq+6zGlSeevVBpNeOfUqRSmnb3
         2yRx7yYz6wyEHOra8Hcsv2B1K8mkl2qYAxT1ComYVWKRlYZxw1tt/tPwTpVaefc+Qcld
         UU4IfjlQtDxSgAJa7Xwe2h+PS72LlnhSPXYu1dtERcjDkzIRzld2uEK+0QP3OXYRIWo3
         7v/VbX68LD9LfUVgeD+JWhCIUlQePorrASId6pfPLvjM7w3xMlCmEVrQpoWHrJ7n1tjR
         4VgKEvOtrUtpfSeiqlN/oBPRspkXVreuvjfEZ6M9LKwwKVm40EAamy3O/DKlzk9pPdDs
         aIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=og70JmSI8PiRKrdb+zUHlmZqFDFORSXT1Xk33Re49Xs=;
        b=QrEcuyHuuyIAQtD4qH30OCIDoM0kEGxdp7/L86NWGIdlMgpdZ6Eh8RaAExnHhKsUIZ
         Cm8yasMteedW3zT3mMbK38Ms9F2wcejI6SKOEiHOfnV83bQmlIG+oW6TegaZ/zSL3uYq
         NQpxCv1oV7egUY2sZCQHJTS85df6utgMw54y+0aoD6u/6CqhM8oYxk/1xlgR/2dfSbyo
         BrcgrkKBJdqjW4aO+mVGUSo40lpqLaa9hf3L651uTiqbpBeUp25LD4KTdg5JdMi8WfGX
         HnSOUM1gf+oT1URsZdchg5c/R4h9tSOiaUTNAHmxQhnrBlMtBIhVpSVyqEyzQZdPxiA8
         qcfA==
X-Gm-Message-State: AIkVDXLdrcg3ZPJL6+n263GU0pOc6b17LjA9iV/yUFhZj/GOym//SozSV2OZbZe5Shi+fT8h
X-Received: by 10.84.218.77 with SMTP id f13mr144997178plm.141.1483563228774;
        Wed, 04 Jan 2017 12:53:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id k67sm148836296pfk.69.2017.01.04.12.53.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 12:53:47 -0800 (PST)
Date:   Wed, 4 Jan 2017 12:53:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20170104205346.GE69227@google.com>
References: <20170104014835.22377-1-sbeller@google.com>
 <20170104014835.22377-3-sbeller@google.com>
 <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
 <CAGZ79kY3oVfn-xH4RQR9jMoKxoQUtF5HezY9HPUZGbx9KP-S5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY3oVfn-xH4RQR9jMoKxoQUtF5HezY9HPUZGbx9KP-S5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Stefan Beller wrote:
> On Tue, Jan 3, 2017 at 11:55 PM, Jeff King <peff@peff.net> wrote:
> > But as this commit message needs to stand on its own, rather than as part of a
> > larger discussion thread, it might be worth expanding "one of the cases"
> > here. And talking about what's happening to the other cases.
> >
> > Like:
> >
> >   This assertion triggered for cases where there wasn't a programming
> >   bug, but just bogus input. In particular, if the user asks for a
> >   pathspec that is inside a submodule, we shouldn't assert() or
> >   die("BUG"); we should tell the user their request is bogus.
> >
> >   We'll retain the assertion for non-submodule cases, though. We don't
> >   know of any cases that would trigger this, but it _would_ be
> >   indicative of a programming error, and we should catch it here.
> 
> makes sense.
> 
> >
> > or something. Writing the first paragraph made me wonder if a better
> > solution, though, would be to catch and complain about this case
> > earlier. IOW, this _is_ a programming bug, because we're violating some
> > assumption of the pathspec code. And whatever is putting that item into
> > the pathspec list is what should be fixed.
> >
> > I haven't looked closely enough to have a real opinion on that, though.
> 
> Well I think you get different behavior with different flags enabled, i.e.
> the test provided is a cornercase (as "git add ." in the submodule should
> not yell at us IF PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
> were set, in my understanding of the code, so maybe the test rather adds
> a ./file/with/characters inside the submodule directory)
> 
> I think a valid long term vision would be to have
> 
>     $ git -C submodule add file
>     $ echo $?
>     0
> 
> to behave the same as
> 
>     $ git add submodule/file
>     advice/hint: adding file inside of a submodule
>     $ echo $?
>     0
>     $ git -c submodule.iKnowWhatIDo add submodule/anotherfile
>     $ echo $?
>     0
> 
> Brandon, who is refactoring the pathspec stuff currently may have
> an opinion if we could catch it earlier and still have beautiful code.
> 
> Thanks,
> Stefan
> 
> > Given the discussion, this comment seems funny now. Who cares about
> > "historically"? It should probably be something like:
> >
> >   /*
> >    * This case can be triggered by the user pointing us to a pathspec
> >    * inside a submodule, which is an input error. Detect that here
> >    * and complain, but fallback in the non-submodule case to a BUG,
> >    * as we have no idea what would trigger that.
> >    */
> 
> Makes sense.
> 
> >
> > -Peff

So there are really two different things going on in the pathspec code
with regards to submodules.

The case that this series is trying to solve is not because the user
provided a pathspec into a submodule, but rather they are executing in
the context of the submodule with bogus state.  Typically this bogus
state has something to do with the submodule's .gitdir being blown away
(like in the last test (3/3) added in this patch).  Because the
submodule doesn't have a .gitdir, it searches backward in the directory
hierarchy for a .gitdir and it happens to find the superproject's gitdir
and uses that as its own .gitdir.  When this happens test 3/3 catches
that assert with the prefix being "sub/" and match being "sub" (since
the submodule slash was removed).  The condition doesn't trigger when
you supply a pathspec of "./b/a" assuming you have a file 'a' in
directory 'b' inside the submodule, since the prefix would still be
"sub/" while the match string would be "sub/b/a".  Coincidentally the
check that PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE does, does in fact
catch it (if using say the 'git add' command).

This leads me into the second case.  If
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE is set, then any pathspec which
decends into a submodule will indeed be caught and cause and error (as
was happens in test 2/3 in this patch).

So in my opinion, the assert at the end of constructing a
pathspec object probably isn't the best place for determining if the
submodule's gitdir has been destroyed and instead it has fallen back to
its parent's gitdir.  A check for something like this should happen much
sooner.

There are cases where it is advantages to be able to supply a pathspec
into a submodule without it erroring out (git grep --recurse-submodules
is one example).  So right now the current method for not allowing a
pathspec into a submodule is to pass the STRIP_SUBMODULE_SLASH_EXPENSIVE
flag when creating the pathspec object.

-- 
Brandon Williams
