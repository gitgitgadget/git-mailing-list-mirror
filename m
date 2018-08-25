Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9C21F404
	for <e@80x24.org>; Sat, 25 Aug 2018 13:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeHYRNN (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 13:13:13 -0400
Received: from mout01.posteo.de ([185.67.36.65]:46801 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeHYRNN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 13:13:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CA79420F5B
        for <git@vger.kernel.org>; Sat, 25 Aug 2018 15:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1535204051; bh=w0XILprPs2mvV2T+hTmV3tXLXJm6m8/na8NhT4LTtLw=;
        h=From:To:Subject:Date:From;
        b=rm1acUkWzFe6Qob2W7xB0/dnydZQDSeQgEonMrAub6cYkYP4U47s4GGrGKj9tcAJ1
         CttAq3S5XDm85nuCUxxbN7oLv9n/+HQnUk8J/zCIDVM7NnXxrGNR+EixPsAL8lm0mC
         EuPf5xbRqs9ZvXX3O3cleqT4QbViiKsikiXvEanElt9ly1O/rmyw9ari74jYYfOw/M
         JxBEgjEdcRisnVGNR5S/ZeLS9oG6pwUWLsPqvf1mGkY9lOqZLCvTRP+OWYzStEaEfI
         7jmoovAdSzTsFUN1XUi/+kTRKTeQCcYtsftXjAcmcpJjFP65wHsGkofmnIown80SFp
         TU1IKG8bmw+fQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41yJyq0b8Lz6tm5;
        Sat, 25 Aug 2018 15:34:11 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?q?Constantin_Wei=C3=9Fer?= <i7c@posteo.de>
User-Agent: alot/0.7
To:     Scott Johnson <jaywir3@gmail.com>, git@vger.kernel.org
References: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
In-Reply-To: <CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com>
Message-ID: <153520405068.637.7595973048355361242@cwe>
Subject: Re: Would a config var for --force-with-lease be useful?
Date:   Sat, 25 Aug 2018 15:34:10 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think there are two aspects to using "force with lease".

Firstly, you, a person aware of the option, using it. In this case I
think an alias is very fitting, because you get quickly used to just
typing `git pf` or so. Plus, you don't have the disadvantage you
described: if you=E2=80=99re working on a machine without your alias, you=
=E2=80=99ll
just notice immediately and type the full option.

The other aspect is working in a team. The problem there is, that most
(at least in my surroundings) use plain --force and you have to make
them aware of --force-with-lease. But with an option or an alias, you
depend on them using force with lease instead of plain force, so again I
don't really see the advantage of such an option.

And lastly, a question: say you are using your proposed option and it is
turned on. Now, git refuses to push, you clarify the situation and
actually mean to push --force now. How would you do this? 1) turn off 2)
push 3) turn option on again?

Regards,
Constantin

Quoting Scott Johnson (2018-08-24 18:39:27)
> Hello Everyone:
> =

> I'm considering writing a patch that adds a configuration variable
> that will allow the user to default the command:
> =

> git push --force
> =

> to:
> =

> git push --force-with-lease
> =

> As discussed here:
> =

> https://stackoverflow.com/questions/30542491/push-force-with-lease-by-def=
ault
> =

> Now, I understand that there are downsides to having this enabled,
> namely that a user who has this enabled might forget that they have it
> enabled, and, as such, on a machine that _doesn't_ have it enabled (of
> which they are unfamiliar) might then run the more consequential
> command "git push --force", but my thinking is that adding this as a
> feature to the git codebase as an _optional_ (i.e. not enabled by
> default) configuration variable would then save some of us who use a
> "rebase-then-force-push for pull request" workflow some time and
> headaches.
> =

> Of course, I don't want to submit a patch if this is a feature that
> isn't likely to be accepted, so I wanted to get some thoughts from the
> mailing list regarding this idea.
> =

> Thank you,
> =

> ~Scott Johnson
