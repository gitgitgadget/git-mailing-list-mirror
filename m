Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36061F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 00:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeK0K7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 05:59:13 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46556 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeK0K7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 05:59:13 -0500
Received: by mail-ed1-f45.google.com with SMTP id o10so17412412edt.13
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 16:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poumzcOWVLja2+9xIMv0TZTKI1q1oH7U5mxn5eqXC1o=;
        b=Q23p+Rp7cmrf9DWPpD7z/f8bvLrU96w5RRguIzQ5WtMkioe6FYArceM4BsvmJUhTCJ
         nddx4LiccBUj/mFUsByFbIzSfSd28Ffuovi74whOCfjKMfFfVs5sea6PXSW2+8ue1sRO
         GGh77W7WVH29QNtgJ//gHxixJ8kuYGhLVTyRcJlqzRl2009ev2KjfBip3cet3SK24hHu
         Nuql+qa52K/QFhByOirLDutaA0Dd+hzJ53DUqPhdcTp8xN20KMaEItnKj7l6gxZ43bH5
         7Pe2eWxl8bkqGLGWuhSEN4hZA6x8ejP66yT40WoeLBBtZ//WjYY4XY8coaTnoelZ4DTq
         SIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poumzcOWVLja2+9xIMv0TZTKI1q1oH7U5mxn5eqXC1o=;
        b=FxJ+aWxpEQttx8/fktmTc65JvWMN0wQ1rLlGmuaO+FHUR3FVxIF7WJoRcwBlEOekGS
         mPXwA3t07aRI37BkyBG2ovOvGNibt7Q/PNIwYRqC36dV5FhlpyLoTSuXQ5d1rv0ijtes
         6+q+GPDHyIr2EVlVYYWXVTINl8isfJVkIGcvkzngr8dQqz1NNwrcWOBB2DewJ49XAGqb
         St6FTYtK7dedDT0rlPjfBAFMlYFnpAmVPnKxs3CYJBRBUuaSVXRTZX/+JVJQ8Kj/aSq7
         07drxj57EU6xl8mKvo+jvB8zjFOCcpKvxklH3A3BwASiIPgOLvibxrgduHPXod4JXO7S
         lTrA==
X-Gm-Message-State: AA+aEWar7sZ2t38gGqbsTRlzZiLbIJebEqhzsHg5b4eky15B1GKYc7Dr
        DRIHiOzj+1BZT4NxAMYOgxXQBG5GS1L9y2o92e46JA==
X-Google-Smtp-Source: AFSGD/VyOIESzf2c4eTKe4k09FchKqH8JEo7dKf6a0jORg8l8S6GWy2kUvQJXC2IzKcYKHdeylCeDGEgjAXV9YiYsTg=
X-Received: by 2002:a50:bac6:: with SMTP id x64mr25205421ede.191.1543276997674;
 Mon, 26 Nov 2018 16:03:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
 <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com>
 <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
 <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com>
 <CAGw6cBvLGZKcf1em0d47hcCuKau2QVbX4wfb0yN+m4umbNLaRg@mail.gmail.com>
 <CAGZ79ka-8a5Uqe21SdHiSG-8eQdbey60R_G=A6th64ow=vqfNg@mail.gmail.com> <CAGw6cBvsiW7nwkJ_DBhXOYkgh7ba+rm+pwd4tOAt1ohRvcCY=A@mail.gmail.com>
In-Reply-To: <CAGw6cBvsiW7nwkJ_DBhXOYkgh7ba+rm+pwd4tOAt1ohRvcCY=A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 16:03:06 -0800
Message-ID: <CAGZ79kax6NpHP-rouezE-A8a2jVN+sC1WnouFWDcaCqYWhs_9w@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Michael Forney <mforney@mforney.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 4:31 PM Michael Forney <mforney@mforney.org> wrote:
>
> On 2018-11-15, Stefan Beller <sbeller@google.com> wrote:
> > On Thu, Nov 15, 2018 at 1:33 PM Michael Forney <mforney@mforney.org> wrote:
> >> Well, currently the submodule config can be disabled in diff_flags by
> >> setting override_submodule_config=1. However, I'm thinking it may be
> >> simpler to selectively *enable* the submodule config in diff_flags
> >> where it is needed instead of disabling it everywhere else (i.e.
> >> use_submodule_config instead of override_submodule_config).
> >
> > This sounds like undoing the good(?) part of the series that introduced
> > this regression, as before that we selectively loaded the submodule
> > config, which lead to confusion when you forgot it. Selectively *enabling*
> > the submodule config sounds like that state before?
> >
> > Or do we *only* talk about enabling the ignore flag, while loading the
> > rest of the submodule config automatic?
>
> Yes, that is what I meant. I believe the automatic loading of
> submodule config is the right thing to do, it just uncovered cases
> where the current handling of override_submodule_config is not quite
> sufficient.

That sounds good.

>
> My suggestion of replacing override_submodule_config with
> use_submodule_config is because it seems like there are fewer places
> where we want to apply the ignore config than not. I think it should
> only apply in diffs against the working tree and when staging changes
> to the index (unless specified explicitly). The documentation just
> mentions the "diff family", but all but one of the possible values for
> submodule.<name>.ignore ("all") don't make sense unless comparing with
> the working tree. This is also how show/log -p behaved in git <2.15.
> So I think that clarifying that it is about modifications *to the
> working tree* would be a good idea.
>
> >> I'm also starting to see why this is tricky. The only difference that
> >> diff.c:run_diff_files sees between `git add inner` and `git add --all`
> >> is whether the index entry matched the pathspec exactly or not.
> >
> > Unrelated to the trickiness, I think we'd need to document the behavior
> > of the -a flag in git-add and git-commit better as adding the diff below
> > will depart from the "all" rule again, which I thought was a strong
> > motivator for Brandons series (IIRC).
>
> Can you explain what you mean by the "all" rule?

-a as short for --all in git commit, and I presumed it to be
'--all-content', but documentation tells me it's about files
only, so there is no really an "all" rule, but rather me misunderstanding
to what it applies.
