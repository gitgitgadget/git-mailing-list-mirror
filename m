Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB0C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569C1208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8YQV535"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD2QrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2QrB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:47:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D74C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:46:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j26so2297380ots.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhHL+3Nuguss5t3TLBUE92ID+ajTxDj1MElrluAHvWk=;
        b=Z8YQV535/bS6c1o0DfZQHYeHYYWQ0SVcFijqpoEpY1oQtKCv8/LjdRGLQyj1qV3cKD
         miSG/EJG1mgGTlYRwTtpiuMcc0whqhaYYhjJ05az9heZHITSJF6jyHtpGxqnr4pL0FtQ
         rBoxiZ1IBKVCjJGsnAiNgZYXCpBfSRuoAMFNwSvcXeFP07gya9DKG1Wc7ULTArCmM/1w
         kvCRic/FUFp0KV6YeUiKDuiaSm2mC4wlmfO3//QgS6owFZMPTA8CqAW/zAYPOpTV1NsF
         B96LOssPh/UFSxtWc8T6W/iBnvVzfhnlu6GiCDjXKn8cb8BbrVx45z+vKXEKvi5vcYlR
         CPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhHL+3Nuguss5t3TLBUE92ID+ajTxDj1MElrluAHvWk=;
        b=hg9V4RWho75QRVrL/LjwhdtR+OFsj+Y731AEpLIOrRBgd+mtIeAzvFxnBnlTaInlYP
         feWm0SO13KHXVTbxPDulaXN+8K53D+JwdI5bmfT5nYINj2gA8pW6p4Wph8/kjdnQRQ/n
         ajbYz1Dda/TiJ9J+bzyBGJWvMvKqYJt8nom5Y9J9F3tfBCmllA5Ule6ktx2fDIKXC/cw
         wAD2s2nEWDF4uZnNLM5cD0uOOKoH/YlimtkwHOBiVeCfXca3aQHrB8NCdCSaJbSASXX8
         LdwB+ilSS5RdhM1xrUnYiaCjpCTeuBM4wgMAepNGpcfTNxrS9v8vAEG46osP9k9uEvx9
         oSBQ==
X-Gm-Message-State: AGi0PuZxGQYHC6BMJ49IwTnj5m9duCau0tTJCwi0Om8yLx1Fh3VNMAhb
        lkfgqlji5twdU0YTPysf9cuzIzEmTOO8g//K3Us=
X-Google-Smtp-Source: APiQypJUhEnIcsJaMIbnldeGGk1NsAvA2LLqM+BQstKX/PMXh3gMeghprRiBy0unPLrj240S519cUnhHMIla6HDvz+0=
X-Received: by 2002:a05:6830:1d62:: with SMTP id l2mr26403422oti.316.1588178818245;
 Wed, 29 Apr 2020 09:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <xmqq7dz938sc.fsf@gitster.c.googlers.com> <CAHd-oW5qq=dtaSmqcSyxoHd3HPipxjfaiCXtdBQwk9yNVe9okA@mail.gmail.com>
 <CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com>
 <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com> <CAHd-oW4NBEcx4ZHfhTZoWttROmEd9TXQC7kLtXgGATHQY9Gr9w@mail.gmail.com>
In-Reply-To: <CAHd-oW4NBEcx4ZHfhTZoWttROmEd9TXQC7kLtXgGATHQY9Gr9w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 09:46:46 -0700
Message-ID: <CABPp-BGytfCugK0S99nLPH4_VXmcYPHWdVyLO59BZc4__4CT9w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 10:15 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> Hi, Stolee and Elijah
>
> I think I just finished addressing the comments on patch 2/3 [1]. And
> I'm now looking at the ones in 3/3 (this one). Below are some
> questions, just to make sure I'm going in the right direction with
> this one.
>
> On Tue, Mar 31, 2020 at 5:02 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 3/31/2020 3:12 PM, Elijah Newren wrote:
> > >
> > > Anyway, maybe it will help if I provide a very rough first draft of
> > > what changes we could introduce to Documentation/config/core.txt, and
> > > then ask a bunch of my own questions about it below:
> > >
> > > """
> > > core.restrictToSparsePaths::
> > >         Only meaningful in conjuntion with core.sparseCheckoutCone.
> > >         This option extends sparse checkouts (which limit which paths
> > >         are written to the worktree), so that output and operations
> > >         are also limited to the sparsity paths where possible and
> > >         implemented.  The purpose of this option is to (1) focus
> > >         output for the user on the portion of the repository that is
> > >         of interest to them, and (2) enable potentially dramatic
> > >         performance improvements, especially in conjunction with
> > >         partial clones.
> ...
> > > """
> > >
> > > Several questions here, of course:
> > >
> > >   * do people like or hate the name?  indifferent?  have alternate ideas?
> >
> > It's probably time to create a 'sparse-checkout' config space. That
> > would allow
> >
> >         sparse-checkout.restrictGrep = true
> >
> > as an option. Or a more general
> >
> >         sparse-checkout.restrictCommands = true
> >
> > to make it clear that it affects multiple commands.
>
> If we are creating the new namespace, 'core.sparseCheckout' should
> also be renamed to something like 'sparse-checkout.enabled', right?
> And maybe we could use 'sparsecheckout.*', instead? That seems to be
> the convention for settings on hyphenated commands (as in sendemail.*,
> uploadpack.* and gitgui.*).

Or maybe just call the namespace 'sparse.*' if we're going that route?

> As for compatibility, when running `git sparse-checkout init`, if the
> config file already has the core.sparseCheckout setting, should we
> remove it? Or just add the new sparsecheckout.enabled config, which
> will always be read first?

We seem to have two competing issues:

  * If you remove the core.sparseCheckout setting in favor of
sparse.enabled, then people can't use the repo with an older version
of git.  (This may be acceptable, but we've generally been somewhat
careful with index extensions and such to avoid such a state, with
slow transitions with index and pack versions and such.)
  * If you leave the core.sparseCheckout setting around as well as
having sparse.enabled, then we have two different settings that we can
keep in sync with newer git but which older git will only update one
of.  What do we do if we detect they are out of sync?  Throw an error?
 Pretend that one overrules?  If the older one overrules, what do we
accomplish with the new name?  If the newer name overrules, doesn't
that also potentially break using an older git version?

I'm not sure what to do here.  Maybe people who have worked on index
version and pack version transitions have some good suggestions for
us?

> Also, should we emit a warning about the former being deprecated? The
> good thing about deprecation warnings, IMO, is that users will know
> the name change faster. But, at least for `git grep <tree>`, where we
> read  core.sparseCheckout and core.sparseCheckoutCone for each
> submodule and each tree, there would be too much pollution in the
> output...

We've already started to steer away from users setting these values
and just have them get set/updated/unset by sparse-checkout init and
sparse-checkout disable.  Since users won't be setting these directly,
I don't think deprecation warnings make sense.

> Finally, about restrictCommands, the idea is to have both
> sparsecheckout.restrictCommands and `git --restrict-to-sparse-paths`,
> right? For now, the option/setting would only affect grep, but support
> would be added gradually to other commands in the future. I noticed

There should be both a config option and a global command line flag,
yes.  We might need the flag to default to
not-restricting-to-sparse-paths for now because that's consistent with
the only thing the current implementation of these commands can do.
But I'm really worried that this will remain the default and we'll
force users in the future to jump through a bunch of hoops to do a
simple thing:

$ git clone --sparse-paths $WANTED_DIRECTORIES user@server.name:path/to/repo.git
$ cd repo
<Enjoy their small view of the repo without every command suddenly
requiring a network connection and downloading huge reams of data they
don't even care about.>

> git-read-tree already has a --no-sparse-checkout option. Should we
> remove this option in favor of the global
> --[no]-restrict-to-sparse-paths?

read-tree is plumbing; we can't break backward compatibility.  We'll
have to leave that option there and just document that the two options
do the same thing.

> Sorry for too many questions. I just wanted to make sure that I
> understood the plan before diving into the implementation, to avoid
> going in the wrong direction.

Nah, these are all good questions.  Sorry for the delay in getting back to you.
