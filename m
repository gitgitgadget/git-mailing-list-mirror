Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB5C1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJZHs2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 03:48:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38764 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeJZHs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 03:48:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id k19-v6so8194470oiw.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svnQZyveU396QA/OvlPbklAhkXBvtPHSfEqwBJCsGwU=;
        b=uva/qwUQ4+MJ1KTJn+r95fUA1Sc9TIsIvXD0oVfBBOfOIJ1c8+Ih4oy3IHhMk9WFWE
         mlO4UR/ZSUr7GoHLpM1SOAN4PHh7+brm1OWMLKwwm09XAWwk8aDbxbgfYJUauV/+16K9
         yfXggBL2ki5Xm1CjFRNzU8Ug6IsrEIyErJdd9aOVDj3PbcO97nPf7bNmql1yHSilnaGw
         vqRi85GCLmVX4tNuhFetwu9o+3rvF62iAXRSU/MSdCS/auZZiA3pckKwbzB1gGifTDa9
         DjkyQ7Oo/4UbZcKDqQfXcmZ+rWLFgLrhgvDD9CugR1nNHBwDV5bAVewOT1hbpQzcFrh0
         5rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svnQZyveU396QA/OvlPbklAhkXBvtPHSfEqwBJCsGwU=;
        b=IQZ+fLOgAUapHR36lUJhqSOeVUdYXLb8KFrURcZDbOo0l4mrPBoCIHA5epzUHmvGv1
         G9OIojmeXEFW7JN0f/R1698nTfEn1sdhZ7t4UlOxty5HZPVV8UhAKyOI8DKzG2M1fCOa
         yjAB7byPEoHEGMR5shMQtNCVSHjmYzTQepQmT6sZ9Fe3pFz1EWUXHXoykh6RjiglfGqH
         dfF0npIYyCz6ayoRpm5HKfJXo21EiVhQR/aN4NSPDvnwDUP5eDEAx1D228Ke39Gckbss
         fiLFmx9nod3zqMI25hrBEaKVo2wgh3klc0KKUA/pza0xq+lyFEXE0sgLCrrxkUojCfQ1
         v15g==
X-Gm-Message-State: AGRZ1gJwHmpURFRM7W7DUt2aNNBPdYGsSQuW6G29X3ju88eFMU99IY3+
        kFqL8TitM+IvJEcsT43vaLf2nqPyOt10RQwvEniJ
X-Google-Smtp-Source: AJdET5cS+bBomt5GJBccHwjHmhul6b0k20Oq6fD/herwC2UZTTsXbR8XsFkkDOJwZgMFUHXpZBNmmKGJc9HXfAbS6Ac=
X-Received: by 2002:aca:e501:: with SMTP id c1-v6mr690237oih.281.1540509232358;
 Thu, 25 Oct 2018 16:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181023215745.245333-1-matvore@google.com> <xmqqa7n4osgi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7n4osgi.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Thu, 25 Oct 2018 16:13:40 -0700
Message-ID: <CAMfpvhJ4_5EtcTiaU6T1T9qPd=kBBvcVpaUFC_AAy4VBo7hv5w@mail.gmail.com>
Subject: Re: [PATCH] revision.c: drop missing objects from cmdline
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 9:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > No code which reads cmdline in struct rev_info can handle NULL objects
> > in cmdline.rev[i].item, so stop adding them to the cmdline.rev array.
>
> "The code is not prepared to have cmdline.rev[].item that is NULL"
> is something everybody would understand and agree with, but that
> does not automatically lead to "so ignoring or rejecting and dying
> is OK", though.  The cmdline thing is used for the commands to learn
> the end-user intent that cannot be learned by the resulting objects
> in the object array (e.g. the user may have said 'master' but the
> pending[] (and later revs.commits) would only have the object names,
> and some callers would want to know if it was a branch name, a
> refname refs/heads/master, or the hexadecimal object name), so
> unless absolutely needed, I'm hesitant to take a change that loses
> information (e.g. the user named this object that is not locally
> available, we cannot afford to add it to the pending[] and add it to
> revs.commits to traverse from there, but we still want to know what
> object was given by the user).
Hmm, when you explain the purpose of cmdline, it's obvious now that it
doesn't make sense to mechanically drop items from it. I'm sending
another version of this patch which uses a more focused approach and
is a bit simpler.

>
> > Objects in cmdline are NULL when the given object is promisor and
> > --exclude-promisor-objects is enabled.
>
> A "promisor" is a remote repository.  It promises certain objects
> that you do not have are later retrievable from it.  The way you can
> see if the promisor promised to later give you an object is to see
> if that missing object is reachable from an object in a packfile the
> promisor gave you earlier.
>
> "The given object" is never a "promisor", so I am not sure what the
> above wants to say.  Is
>
>     When an object is given on the command line and if it is missing
>     from the local repository, add_rev_cmdline() receives NULL in
>     its "item" parameter.
>
> what you meant?  Is that the _only_ case in which "item" could be
> NULL, or is it also true for any missing object due to repository
> corruption?

Yes, that is what I meant. I believe for corruption there is an actual
error shown with die() or the like, though I am not certain.
