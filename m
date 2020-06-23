Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF95C433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC91920707
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 20:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XJ8FhIT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbgFWUK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:10:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:36913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388265AbgFWUKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592943013;
        bh=74YsARRc+lvXUnCMxG4+j96LwZLt1yEwWpWJTw1iiB8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XJ8FhIT56RrmhzH0EeABlQvMZWmHZviEYTJ6eON9dMXPoAZ79/2w+2swnfXf3bW4U
         UEgvbtSNaIqkD3lvkS9VF3s52pQ9NbaSzxYzqyboFnFmdwfTzB/MEpVYj43sX8Z8PV
         Dvm/rlbssFwS/QPK5G02vCnoEI5sfI2IvZdUMSHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1jCrfg2rmr-00gKjO; Tue, 23
 Jun 2020 22:10:13 +0200
Date:   Tue, 23 Jun 2020 22:10:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <20200616001955.GA686455@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2006232122360.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com> <nycvar.QRO.7.76.6.2006150011360.56@tvgsbejvaqbjf.bet> <20200616001955.GA686455@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DhvCD+at5aeH6IrvVLIQV3lHFP9AXtQYwJnDsENXbbW+CwVE0lG
 4QQiOgV0VTk4ppykXhjI7Y3ZJPz4cuY6QeBFt8MsDV+tcU6crnTjy7/sV8A4EJljyzk1PAX
 agaGqvP4rGMQlS8y9/pwhCmv7pmoW9nAcvVoxNrHPj4/89ltpz7r1KTVFM467CXrFgvriZ5
 upQlVKKrnQW2x+ucfsbVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mWSJe2U6UWY=:QvKeAg+wrXgZHaHTDB6QGN
 qX76cvO9iO+cpn+50f07Eno6DdleFVkp1dty6cT0mUQx1pul4Yaz/+nWvBdQAQ6r4TnCtHVEl
 v/1esmimhD6YJ+Kik3Qu88ZA3m54V9J2r6sQvyXmayZZf91Pjpge7ARgKa056aUdR2eKEOmj5
 dkml4Li9NJRVcFbI0Mul9iYaZyLHWPWGO60MINQTBCFDk8PDGVbGBqYKlcVybRLMd1L1vmQi+
 9OoUM663WFkv14Kx5o+tFi618Lf6U2nRkA+lHHAZquwjrDS4bfQCF0QL9iqixmnE51nsZnvQv
 BFE5qcwhO9yvcR2i+4RZfuQ9WAWK9GrmF1IVEvvendkz9dOOk6EUeEJcVC8rXzK4Z+hh9nXgn
 vw8IRtGGOtahFV6nq0J2UKN9gvxwvL58e9FWU+HET1xRKpKnTGvh5u8CQ24DHsJ/o96KiAO1B
 NKYtJ9JN75259ntROxujgXLua59U1rCAQ4bdsshmBuxkeFADah0etTNe2GbwH4LBSZdvq5IY/
 5AgjGrm4LeC4B9nY6WJKXvutHFyGrAngVSpepGnJlue5Vz+tVqwh9XeWgk89W8nsjuFtdMkTy
 eYFFPsV72lY1Wg1KAhjK8iovBpoY16/OyfrWcBCukq61PluqW4NXp0lR6/R+xtl8h8UWBT9lm
 ODwWm53tZHkjReOYpIxoSVXP7wMRdEp9H72LSohAE8czPJlRfN7olddMTEduYM6Gl71nilsC4
 eYAInulDegCLzxSt5eMl0NhV9Qcyv5Zc5eH+ukxjA4Kz1dtDx4TcsgAqipWFZnOWxx/q+xx+r
 damMuJHNzOIoc034E4yrx06MXFjZtzHkXrIXNz3vTIRMR31hJO7Gm2yHRZUsnHmlgS2kzFHL6
 lqWMUl5I47hb1eUmSdu2msrcynGRxfK2aeLH5LY9421POTIDyk7qkIEw2PPOlb9TivlRF0FZ1
 os7ZaOJVIE7M2WYAB7NPKLnOYUIUKVRiseu6LlhRkP/LXEOhjrcLC36TZ0rJaM9qLDNUUyYLZ
 jrr9Q5QFbNnIdM7dvI/ZLZo4b4+3H0rOu9ZSakKogQ3wd9f5tdz25vU4VX0W5nzGfo0k+DX7H
 T35eUdJ1i7KuI3jvTgUx9Xdx3oGkp7kmTITm1Bxz37fjk/OL/6cQToivqN/TDFZ7rp1HRpIj2
 Rl6CWT5D9IMehSC5qa7sPOSeuzEDIy6+YeJOjsS5qv83yYkAvgoQ7t040O2uEO08ZWFtSj4j/
 VSEkh7MeahkcJz8P88X611JU0GDARYZrhZh1ARg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 15 Jun 2020, Denton Liu wrote:

> On Mon, Jun 15, 2020 at 12:26:03AM +0200, Johannes Schindelin wrote:
> > > For example, my vim plugins are submodules in the '~/.vim/bundle'
> > > directory. When I want to update them, I run:
> > >
> > >   git submodule foreach 'git remote update && git reset --hard origi=
n/master'
> > >
> > > With this change hitting a Git release, more and more people would c=
all
> > > their main branch different names they like. So what is the recommen=
ded
> > > way to do something like this now? How do I checkout the tip of the =
main
> > > branch? How do I push to the main branch? How do I pull from the mai=
n
> > > branch? And so on...
> >
> > ... has less to do with a new Git release, but more with the decision =
of
> > an existing project to change their main branch name.
> >
> > That's something users already had to deal with, of course. For exampl=
e,
> > projects switching to the Git Flow model will start to use the main br=
anch
> > name `development`.
>
> I brought this concern up in a parallel thread but I'll bring it up here
> too since it's relevant. Currently, in the .gitmodules file, if the
> branch is not specified, it defaults to 'master'.
>
> When I want to update my vim plugins, I run
> `git submodule update --remote` which pulls in all of my submodules'
> 'master' branches. By convention, a lack of `branch` key in .gitmodules
> conventionally means 'master'.
>
> With your change, it becomes the value of git_main_branch_name(), which
> is fine for now. However, if this value changes to something else, then
> when I update my Git, suddenly `git submodule update --remote` will be
> broken for me as all of the new repositories that I pull will be for an
> incorrect (and possibly missing) branch.
>
> This leaves us in a scenario where one developer running an older
> version of Git would have submodule updates work perfectly fine while a
> developer with a newer version would have it suddenly broken. This might
> be hard to debug, especially for someone who doesn't follow the release
> notes around Git and doesn't realise why the default has suddenly
> changed.
>
> This problem gets much worse if we allow the main branch name to be
> configurable as then the *private* configurations that a developer has
> may have an effect on the *publicly visible* behaviour of a repository.
>
> I think I see three possible solutions to this:
>
> 	1. Special case 'master' in submodules to retain backwards
> 	compatibility.
>
> 	I don't think this is very appealing as if the change is made to
> 	use another default branch name, then the "default" branch for
> 	submodules would be "master" even though the new default
> 	everywhere else would be different. And in the future, someone
> 	who doesn't know the context behind all of this would be very
> 	confused where there are two different default branch names.
>
> 	2. Disable 'update --remote' support for submodules that don't
> 	specify a branch.
>
> 	If Git detects that a branch key is missing when trying to do an
> 	'update --remote', it should just quit out and refuse to do
> 	anything. Of course, this a very backwards incompatible change
> 	and it would require several release cycles to implement where
> 	we warn users about this impending change before we actually
> 	make it happen.
>
> 	3. Make 'update --remote' get HEAD.
>
> 	I argue that this is how it always should've been implemented
> 	but, alas, I can't go back in time and fix it. Regardless, it
> 	might be good to flip this to be the default if we're going to
> 	be making the change anyway.
>
> 	Unfortunately, this suffers from both the problems of 1 and 2.
> 	As with 1, we'll end up in a situation where users with
> 	different versions of Git may experience different behaviours
> 	given the same public repository and I think this is definitely
> 	undesirable. With 2, this change will also require a long
> 	deprecation period which I don't think it compatible with how
> 	people seem to want the default branch switch to happen this
> 	release.
>
> So I dunno. I think my opinion leans on not changing the default branch
> at all. Since it seems like the consensus is generally that it _will_
> change, I think I would prefer options 3, 2 and 1 in that order.
>
> Thoughts?

My intuition matches your preference, and I have a strong preference for
3.

It took some banging my head (not my HEAD...) against the code to convince
myself that the patch I prepared for v3 is good: I managed to confuse
myself what with all those submodules and clones in t7406.

Ciao,
Dscho
