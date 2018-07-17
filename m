Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987E61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 14:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGQOgd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 10:36:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43724 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 10:36:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so485319pgr.10
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2Jvcvk/Ns3LSaHKlrFvjO/ETqbCYjR1a45q/J0jCY+E=;
        b=f5GNSzOKphZwLu7JIWfPeEE9zPPAqMAN47wNrtyrXmmI1RLb9kOMRIr5INlu5oXTCH
         dIeeg70hPLakJjGOQJ4SeQszVKkm8/PxWL/33Tn4tOcK9npvm4nVkms1TCOjp2ODMUhx
         ltPzEc3z2hNU4QylJBEY0yqaP8kjtx6gItXZAcRm4KwY8l6Izd9MAhMYQ+eOKy/GUk+p
         eyq/j1UsUuQQuQfB3Cd3duw+/RepgP0CV/UJr0lbg8mSX93ZPDBYd0651v2Jw9N6oAs4
         7iufz1pierZ66vavMnIS0iGgvSBkxmhbiy/qJGclOqXeCApBALlWHMwmjXnBiYEKLPp2
         tXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2Jvcvk/Ns3LSaHKlrFvjO/ETqbCYjR1a45q/J0jCY+E=;
        b=Ac3Tw3AQPltfty6eUX8rEh9QQUgvLDJ2159wB0sJxDFFTiSmxCwRlhziCxXW5MTANp
         AT5JMKpNl+to27YHrpjpY19+P92BfzJqdmsm8lWeeZzeucFjcvVjZMqnBySp7KiQnJSe
         SfSE9PtdteUBN/UdE0gd7QJJ3E0bibAMMeBBiK7mdJHE2pluOZfATZWI9TQkL3ya+qS6
         vqMRKuylE9X4t7ofr+FMfhHJw/f4InA11IAFCorzsk16qCRTIJgBAYobv+ynGkhYIlAw
         cYAmQBptigbPasZ+xWuZjM2iF/sveKupOm/GILU4tuH/Shrle0MDZ9iJRIbfObOJx4qp
         ypHw==
X-Gm-Message-State: AOUpUlFFOfVA/PqnG4bqJERyxJ72zNzZyD/p1FLAqyoHdUgtvULgb3dw
        RDo+P7TfnR4ZnXjZSSyuLd8=
X-Google-Smtp-Source: AAOMgpculEjBy1YzaDGZPG6K/8NmFLI/QaAKjmz23DFhHU2E41S/NgLDSyHVZzt7juc9yDm4PP00aQ==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr864351pfd.32.1531836223166;
        Tue, 17 Jul 2018 07:03:43 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g14-v6sm2216382pfj.175.2018.07.17.07.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 07:03:42 -0700 (PDT)
Date:   Tue, 17 Jul 2018 07:03:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180717140336.GA229988@aiede.svl.corp.google.com>
References: <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
 <20180716214539.GL25189@sigill.intra.peff.net>
 <20180716220306.GI11513@aiede.svl.corp.google.com>
 <20180716224337.GB12482@sigill.intra.peff.net>
 <20180716225639.GK11513@aiede.svl.corp.google.com>
 <20180716232603.GB13570@sigill.intra.peff.net>
 <20180717015339.GL11513@aiede.svl.corp.google.com>
 <87d0vmck55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0vmck55.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Ævar Arnfjörð Bjarmason wrote:
> On Tue, Jul 17 2018, Jonathan Nieder wrote:

>> That suggests a possible improvement.  If all callers should be
>> ignoring the exit code, can we make the exit code in daemonize mode
>> unconditionally zero in this kind of case?
>
> That doesn't make sense to me. Just because git itself is happily
> ignoring the exit code I don't think that should mean there shouldn't be
> a meaningful exit code. Why don't you just ignore the exit code in the
> repo tool as well?

I don't maintain the repo tool.  I am just trying to improve git to
make some users' lives better.

repo worked fine for years, until gc's daemonized mode broke it.  I
don't think it makes sense for us to declare that it has been holding
git gc wrong for all that time before then.

> Now e.g. automation I have to see if git-gc ---auto is having issues
> can't just be 'git gc --auto || echo fail @ {hostname}' across a fleet
> of servers, but will need to start caring if stderr was emitted to.

Thanks for bringing this up.  The thing is, the current exit code is
not useful for that purpose.  It doesn't report a failure until the
*next* `git gc --auto` run, when it is too late to be useful.

See the commit message on the proposed patch
https://public-inbox.org/git/20180717065740.GD177907@aiede.svl.corp.google.com/
for more on that subject.

> I don't care if we e.g. have a 'git gc --auto --exit-code' similar to
> what git-diff does, but it doesn't make sense to me that we *know* we
> can't background the gc due to a previous error and then always return
> 0. Having to parse STDERR to see if it *really* failed is un-unixy,
> let's use exit codes. That's what they're for.

Do you know of anyone trying to use the exit code from gc --auto in
this way?

It sounds to me like for what you're proposing, a separate

	git gc --auto --last-run-failed

command that a tool could use to check the outcome from the previous
gc --auto run without triggering a new one would be best.

[...]
> I think you're conflating two things here in a way that (if I'm reading
> this correctly) produces a pretty bad regression for users.

The patch doesn't touch the "ratelimiting" behavior at all, so I'm not
sure what I'm doing to regress users.

[...]
>> To solve (3), we could
>> introduce a gc.lastrun file that is touched whenever "gc --auto" runs
>> successfully and make "gc --auto" a no-op for a while after each run.
>
> This would work around my concern with b) above in most cases by
> introducing a purely time-based rate limit, but I'm uneasy about this
> change in git-gc semantics.
[..]
> With these proposed semantics we'd skip a needed GC (potentially for
> days, depending on the default) just because we recently ran one.
>
> In many environments, such as on busy servers, we could have tens of
> thousands of packs by this point, since this facility would (presumably)
> bypass both gc.autoPackLimit and gc.auto in favor of only running gc at
> a maximum of every N minutes, similarly in a local checkout I could have
> a crapload of loose objects because I ran a big rebase or a
> filter-branch on one of my branches.

I think we all agree that getting rid of the hack that 'explodes'
unreachable objects into loose objects is the best way forward, long
term.

Even in that future, some ratelimiting may be useful, though.  I also
suspect that we're never going to achieve a perfect set of defaults
that works well for both humans and servers, though we can try.

Thanks and hope that helps,
Jonathan
