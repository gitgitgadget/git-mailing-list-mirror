Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B31C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FBA21556
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lProfYyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbgALSlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:41:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:57793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgALSlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 13:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578854496;
        bh=Jo93Ao+T7052s5Hiqlg2aTYP/7rID8Y6ZDUcm0psLt8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lProfYyd/FJgoLkV2EOIOsYQqUGC5DS7BC5UWMXAR0Ep3hQwFDDUVhjNCq3Z/HBuy
         GRaEKLcUqNsfG8wg53OrgeNVDBH/ipqD0b8buvyUG/HLR+35Ko+JZzUkHMkRsWkb/Q
         weXZ01uY/s+xTulrjYhCxU/i5CUr2+PXYHfbW6Gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1jkr6K1B3U-017SMd; Sun, 12
 Jan 2020 19:41:36 +0100
Date:   Sun, 12 Jan 2020 19:41:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
In-Reply-To: <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001121936290.46@tvgsbejvaqbjf.bet>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com> <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lxlTruKpAobytlHooY1H62PA22e2qKxcpdM4carYzy7oeRSQTQk
 jkulqmgm1GwjWAuhgJpGMOCXW3E+EsMVpDBcNfIi1YgmA25v6lvyeXxmCvYLiSfiwpGjC7+
 gS+4qcKKANFyHOsW/rFG7Clp1NzKXVFlX+dxDtWRghWBw1qYUULNmtztASizD/wGsYydMPM
 HO7aNrl60cwqTE0BGK1PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qZmgLIfSbto=:S5P0G0geBLbDIeEC7Veahf
 zJnlY2vabVuPRFFivIySnTKMNCA0yge6v8fIxciYayib7y+XnMDgpySuIJOYty4gt6UA8QbaJ
 EfIT2vBnb0K9qt3eGMFFU1fhA6Yw68lLUB2NEsgH7HOIRySxqwixtJB4zNl9K2xuYbfhsIq8e
 LSICxxMGQnyDYe1PG+aPoOQYMyfYzSZDxqLCZMYaM+oVt7UxmfAXffFXPoi25sxsHkzi1P+/f
 1V8LsqmeLxlkA6PTRcDRQWFl4+UErYjyOHHlFZ/3Dipw3WMN7Eemm9P6v2QgrCLhBh5tlnMWx
 Ptw6urvdQZXv7dGSBHN8GVPHATTCR4NKudC3qcSE8NQXTT9Mdsy0bUhSPkMvcWOcfZ2XL34Wi
 ZS7uYXSIvWLbA3dTMilf/HPbPEqZbxqLEpKn2SXYcgQBVvd/MDAhMrQ1qAAifYB+KVcRYJpjO
 0A7z0NOwvcknwbKqYzlrLq7MqlYriHlUP4d/TVcMONHjxahK2GD/8k1sbyRrrotQiJr5hpCsD
 ffCupvVWmyK6elSn5bRGyy355fTGK9ntXYb7QmxXx89q5hO9SLPZR9Nlq4vly5wvKED0sj9kW
 J4gM0ta7e4D+NlLKG2meGXOb5FnIItCGwIpL0Enoqsa4HzIub2kx6iwI4xLrUWmaycWKMgd9h
 XTg1ZgoyFfdR8VJPQPonXMBzFSwEnSpDYdKGkppvWeeroJ1kVpwEbQiIxQKqX18tOeUZxxq8X
 W7pf6HbXrIbmAdgxfLOn/qudaR1wC+8h1OIkYZ+5sd6lCQxLTOUNmUxX9WOkMLutLt/iOAMqJ
 gGXAKgSulNefom9W5yIVKuE5iAGvEK4jy6/4Qq3bIPN0S0MuLP/HKfgx7J6Gfac5YthmBIbL2
 75oPHhz/frUw/dTPyChk28T6luhh6PcV9VJmnq9lIST21TgENxDYv5AuJudAphm7oIiF3Iqr2
 8My6zYjgp8gyplTqp3ve4GnOKE6cqWTbOn2nD7Kvd6gBaC/HsvyROJ1wDDzRnCN9Rj+J5JnMV
 V+55DIIAq/5kHSY8BzDRSm56+S1VZ+/gkpI4jRNSQKkHxpRAZzVyl/irim5/5qSEWCEq2HtU6
 NME8HQPCHdiDlfL4Cdt9E6P/0jTgYM4adBUGhvJi0uHN4nNphVW7Kdf+IbKmQmJP62JNtznLF
 fS//LQvSjxUyEy9vlIUA1h6AwK8jd0VGuCaKysxv4ZyF4CKzO0fef+k8RoFpyZ/R/W4Cfb8jQ
 GeCX259ce/nq8uGLQqWeoaxusKYnibdYckQ20l4O5Kltk6eOSCX+mwXITeC0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, 12 Jan 2020, Phillip Wood wrote:

> On 12/01/2020 16:12, Phillip Wood wrote:
> > I'm concerned that there are some bugs in this series and think
> > it may be best to revert it before releasing 2.25.0. Jonathan
> > Nieder posted a bug report on Friday [1] which I think is caused
> > by this series. While trying to reproduce Jonathan's bug I came
> > up with the test below which fails, but not in the same way.

Thank you so much for your thoughts and your work on this. For what it's
worth, I totally agree with your assessment and your suggestion to revert
those patches _before_ releasing v2.25.0. (I seem to remember vaguely that
there were repeated requests for better test coverage and that those
requests went unaddressed, so I would not be surprised if there were more
unfortunate surprises waiting for us.)

> Doh I forgot to add --committer-date-is-author-date to the rebase
> command line in that test. It passes with that added - how
> embarrassing. However it does appear that it prefixes the date in
> GIT_COMMITTER_DATE with @@ rather than @. I think (though am not
> completely certain yet) the reason the test still passes is that
> the date has more than 8 digits so although
> match_object_header_date() fails because of the '@@'
> match_digit() succeeds once the loop in parse_date_basic() strips
> that prefix. Jonathan's test date only has 7 digits so
> match_digit() does not treat it as a number of seconds since the
> start of the epoch and fails to parse it. The fix for the @@ is
> quite simple, the date we read from the author script already has
> an @ so we don't need to add another. The diff below shows a
> basic fix but we should get rid of datebuf altogether as we don't
> need it. I need a break now I'll try and put a patch together
> later in the week if no one else has by then.

Thank you so much!

>
> Best Wishes
>
> Phillip
>
> --- >8 ---
> diff --git a/sequencer.c b/sequencer.c
> index 763ccbbc45..22a38de47b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -988,7 +988,7 @@ static int run_git_commit(struct repository *r,
>                 if (!date)
>                         return -1;
>
> -               strbuf_addf(&datebuf, "@%s", date);
> +               strbuf_addf(&datebuf, "%s", date);

I have to admit that I have not analyzed the code before this hunk (it
would be much easier to increase the context in a non-static reviewing
environment, e.g. on GitHub, but the mailing list does not allow for
that), so I do not know just _how_ likely our `date` here is going to
change or remain prefixed by a `@`. Therefore, this suggestion might be
totally stupid: `"@%s", date + (*date =3D=3D '@')`

Thanks again,
Dscho

>                 res =3D setenv("GIT_COMMITTER_DATE",
>                              opts->ignore_date ? "" : datebuf.buf, 1);
>
> > The
> > test coverage of this series has always been pretty poor and I
> > think it needs improving for us to have confidence in it. I'm
> > also concerned that at least one of the
> > tests ('--committer-date-is-author-date works with rebase -r')
> > does not detect failures properly in the code below
> >
> > 	while read HASH
> > 	do
> > 		git show $HASH --pretty=3D"format:%ai" >authortime
> > 		git show $HASH --pretty=3D"format:%ci" >committertime
> > 		test_cmp authortime committertime
> > 	done <rev_list
> >
> >
> > Best Wishes
> >
> > Phillip
> >
> > [1] https://lore.kernel.org/git/20200110231436.GA24315@google.com/
> >
> > --- >8 ---
> > diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-=
options-compatibility.sh
> > index 5166f158dd..c81e1d7167 100755
> > --- a/t/t3433-rebase-options-compatibility.sh
> > +++ b/t/t3433-rebase-options-compatibility.sh
> > @@ -6,6 +6,7 @@
> >   test_description=3D'tests to ensure compatibility between am and int=
eractive backends'
> >
> >   . ./test-lib.sh
> > +. "$TEST_DIRECTORY"/lib-rebase.sh
> >
> >   GIT_AUTHOR_DATE=3D"1999-04-02T08:03:20+05:30"
> >   export GIT_AUTHOR_DATE
> > @@ -99,6 +100,22 @@ test_expect_success '--committer-date-is-author-da=
te works with rebase -r' '
> >          done <rev_list
> >   '
> >
> > +test_expect_success '--committer-date-is-author-date works when commi=
tting conflict resolution' '
> > +       git checkout commit2 &&
> > +       (
> > +               set_fake_editor &&
> > +               FAKE_LINES=3D2 &&
> > +               export FAKE_LINES &&
> > +               test_must_fail git rebase -i HEAD^^
> > +       ) &&
> > +       echo resolved > foo &&
> > +       git add foo &&
> > +       git rebase --continue &&
> > +       git log -1 --format=3D%at commit2 >expect &&
> > +       git log -1 --format=3D%ct HEAD >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> >   # Checking for +0000 in author time is enough since default
> >   # timezone is UTC, but the timezone used while committing
> >   # sets to +0530.
> >
>
