Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC7F1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJZW2K (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 18:28:10 -0400
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:31643 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeJZW2K (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Oct 2018 18:28:10 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 18:28:09 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1540560898; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=aldeufZAury+uozn2gh2OvazTM/+Fcgw5Oj2NRm9Dui42GEgx4+7gDfoY6HZqzlXS98JzueWi1XV0
         muDM8f1Ubu7ojPrv2Hnmmjj4aJO5deE/4FrMwORF2VCO5tuS30fKJv11oBl274wGkYjCoxdO/5zLrS
         67KjzBygTVxIL/2EcfB8HaxCMTOONOlyRap/pT3e7ypIUga7V0cncPO7tbh8TQPfLtGH32ujLErz20
         RGMy2iBeYi1B/2L1i4dWlm06xhhLXUbxk1r4i6tgRDbOjNPmAFki006NHqlenN6catsbSkWNV+auvl
         sjsJ7LHC2Ir6fC+9uEMLXKfV++xpvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:dkim-signature:dkim-signature:from;
        bh=77gysncg8vVgGhQtvDHpMIgW3YwT6L343AKqGKQWACw=;
        b=Wym8LNof9GaPAFOo1sJZVWENdP5XBH9I0BLHG6Xp6+hZMmq7v6bCccGlAWJ2aqKk4TnH/y2Ojds9O
         QAXqngEt8ULKbN0v8QEvDKhi5yexxYsqHNYtlkCagsZgbcyXSkNqejlJLdSj4L72hst6TjPrgbwzyz
         +w1wIOrnLE+ppISK5bMifyBoayqQISV9pJdfW9fyuGYxqn8KCf4sabqgRc/c3mGcIfjbEjvly3DFwO
         Ya18aO+u+JKpDZMLoKnvoeu5J3SjQMUSCXVkeleMn1/OP45fWLVucKqfjt/WJ4J6Lywh6OCTVVLfGl
         PXP1zhbx24ObePIP3VxoUFkH5sRc7BQ==
ARC-Authentication-Results: i=1; outbound1.ore.mailhop.org;
        spf=softfail smtp.mailfrom=lakedaemon.net smtp.remote-ip=108.39.81.162;
        dkim=permerror header.d=lakedaemon.net header.s=mail header.a=rsa-sha256 header.b=KYeUHyP7;
        dmarc=none header.from=lakedaemon.net;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=77gysncg8vVgGhQtvDHpMIgW3YwT6L343AKqGKQWACw=;
        b=IBHCy7wBes6Rj9JM92v9Yc3oA/ajKcVKBNaZXg3iZSE1wxGWLVyT78576OP0sA2sFm4HqoxoNhBg7
         FzkU2zAz15joqVNaZoqZ7O/p7va6yBxbHUVkO6JjRxvO5iXxLgdFAlmAUxmpO2JNNrT/M2aaY0IxpZ
         UG1BU1sOsaGyDDSG36XdeGjfenYgY/0+J2F9OP/JgsYKWQGior0ZOuXRU43qKE5X+hcLDPuMO4GR4E
         FVU7VOYgBM57y060HeviuAnrCEVtGGODHNm50W+VK3CuhpSyrWH01mqU7SiDqUrIxRZOnxhLgsIGZW
         ThxWHpGRURA2Hv3T4lTJkulqs5/7Qsw==
X-MHO-RoutePath: amFjMjk5NzkyNDU4
X-MHO-User: ebdb9165-d923-11e8-a93b-310333596487
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 108.39.81.162
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [108.39.81.162])
        by outbound1.ore.mailhop.org (Halon) with ESMTPSA
        id ebdb9165-d923-11e8-a93b-310333596487;
        Fri, 26 Oct 2018 13:34:56 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 2FB9380132;
        Fri, 26 Oct 2018 13:34:53 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 2FB9380132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1540560893;
        bh=77gysncg8vVgGhQtvDHpMIgW3YwT6L343AKqGKQWACw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KYeUHyP7ko6iffRjXeCg8rkO9CC47M2dUuNLS1Iyc/CGvCEeEXuTPZnSj5OAUyEPT
         v/KgjNk6cRqs1wpPSiri0w723Hgc7CHnqavPyhQxL4ljLg7LydlMYpczbBqF1Ztof4
         puuPwQhhVxtY4e0bhZrMAlL31n+XPK7ATjcXleoHYmjvfky8x4hjOC4PmJHuv04/83
         XrYKDJHFKwReBbSFTTWq6Mw55MIdUQvqLx6xo/PDlAFR4QSRd54Dv9n05EgJa9DpHS
         kzAjyTpXtRIdiabt/rbmUNcIDTwTn0aKB4fKqMZIaUiuawL2yjZJn7/IlFEbEsI2Ef
         DAGxpBtisYwsg==
Date:   Fri, 26 Oct 2018 13:34:53 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
Message-ID: <20181026133453.GE24185@io.lakedaemon.net>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
 <20181026093644.GA20876@sigill.intra.peff.net>
 <87tvl8lw5d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvl8lw5d.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 02:39:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Oct 26 2018, Jeff King wrote:
> > On Thu, Oct 25, 2018 at 10:38:46AM -0400, Jason Cooper wrote:
> >> On 10/25/18 1:37 AM, Junio C Hamano wrote:
> >> > "lhf635@163.com" <lhf635@163.com> writes:
> >> >> I have a good idea, add a file to git that is the opposite of .gitignore...,
> >> >
> >> > Do negative patterns in .gitignore file help without inventing
> >> > anything new?
> >>
> >> I did this several years ago in an attempt to track /etc/ (minus
> >> ownership, of course) without storing secrets in the git history. As
> >> the system grew and was maintained (read: crap added), the negative
> >> patterns grew untenable. I quickly realized it wasn't the correct way
> >> to solve the problem.
> >>
> >> Unfortunately, shortly after realizing this, I left that project. So I
> >> never had the chance to develop a proper solution. However, the concept
> >> of a '.gitonly' file was exactly was I was seeking. So, for what it's
> >> worth, I've definitely had at least one legit usecase for this feature.
> >>
> >> The usecases tend to center around tracking select files within the
> >> rootfs of a full-blown operating system. Or a subset thereof.
> >
> > I think what Junio meant is to ignore everything by default, like:
> >
> >   echo '*' >.gitignore
> >
> > and then selectively use negative patterns (and being in .gitignore,
> > that makes them positive "yes, include this") to add things back:
> >
> >   echo 'foo' >>.gitignore
> >
> > which ends up being roughly the same as your .gitonly concept.
> >
> > I don't offhand remember if you might run into problems where a
> > subdirectory is ignored by the "*" and we do not even recurse into it. I
> > think it would work OK as long as you put everything in the top-level
> > gitignore, like:
> >
> >   echo 'subdir/file' >>.gitignore
> >
> > but I didn't test.
> 
> This doesn't work, as explained to myself in this commit in a private
> project I have where I tried this a while ago:
> 
>     I thought this was a bug:
> 
>         (
>             rm -rf /tmp/git &&
>             git init /tmp/git &&
>             cd /tmp/git >/dev/null &&
>             echo '*' >.gitignore &&
>             echo '!*.txt' >>.gitignore &&
>             echo '!.gitignore' >>.gitignore &&
>             touch foo.png foo.txt &&
>             mkdir dir &&
>             touch dir/bar.png dir/bar.txt &&
>             git add *.txt &&
>             git add */*.txt;
>             git status --short
>         )
> 
>     But it's a limitation, gitignore(5) says:
> 
>         It is not possible to re-include a file if a parent directory of
>         that file is excluded. Git doesn’t list excluded directories for
>         performance reasons, so any patterns on contained files have no
>         effect, no matter where they are defined.

Bingo.  This is the exact problem I encountered.

>     So as a hack exclude anything that looks like a file with an
>     extension.
> 
>     1 file changed, 1 insertion(+), 1 deletion(-)
>     .gitignore | 2 +-
> 
>     modified   .gitignore
>     @@ -1,3 +1,3 @@
>     -*
>     +*.*
>      !*.gpg
>      !.gitignore
> 
> I.e. here I'm trying to maintain a repository where I only want
> .gitignore and *.gpg files committed and everything else ignored, but it
> only works for one directory level.

Perhaps a workflow solution using the existing .gitignore syntax would
be to:

    - Use a separate .gitignore file per subdirectory
    - Only list a subdirectory in a .gitignore file when you want to
      exclude the entire tree underneath the subdirectory

Which would give us two things we could warn on:

    - If git detects a negative pattern space (file starts with '*')
        - any directories under that .gitignore need their own
          .gitignore
        - any directories listed in the .gitignore shall not have a
          .gitignore within them.

The warning could then point to the document I alluded to below.

> There's not a lot of room left in the gitignore syntax, but I suppose we
> could extend it to add some "I really mean it" negative pattern which
> would override previous patterns even if those previous patterns matched
> directories.

I'd argue against this.  This is a rare enough usecase, that it should
be possible, but doesn't need to be easy.  Extending the syntax will,
imo, suggest that it's supposed to be easy.  I'd rather see an official
doc for how to do it properly (maybe I'm on the right track with the
above?) with an explanation for why it is the way it is (efficiency,
rare usecase, etc)

> Just fixing it as a bug would make the ignore process slower, since we
> could no longer just ignore directories and would always need to
> recursively scan them.

Right, rare usecases shouldn't impede regular use.


thx,

Jason.
