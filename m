Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E641F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 21:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfJLVYa (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 17:24:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:45305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbfJLVYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 17:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570915468;
        bh=/8K28y+SFtAnvOjf2ru8ayHx6FR9bH/+j2lLPZmYdi8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FEBkMoWdM0cYq2UE6Aw0fF9YSPF7w4UY02ACoLbzSUF3CcqLtHQpHM5ZMBhV/D2KR
         rONXNqQotDfIV4PqEM4DJCH+0nz/bKZZydIIXaM0TyLVxO+9vCGkwQwknC/CRilZfi
         nQaupq2sbS8l9CgygqG7j9RcAuhETzGzTsF3fvr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1ieEbo0edw-00KyBK; Sat, 12
 Oct 2019 23:24:28 +0200
Date:   Sat, 12 Oct 2019 23:24:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
In-Reply-To: <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
References: <pull.361.v3.git.gitgitgadget@gmail.com> <pull.361.v4.git.gitgitgadget@gmail.com> <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com> <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G3EKXLJL4yRXz4QWtI945phwfs0LxLfNZQFe+5WIzXN2EMjpaKe
 RRJi4OsKUdQAkKpHcgZLlm1qGFY1oZgUdnjpkHE3nExMvtfJ5P8Uz4AfVRJ0vCU1Fnjo4OW
 odeIqYm1nMhybVqm6LNPMP3efl6p1ICPaz0zKRgej9i53T8d3u86MRSfDvn0eUaJ0vXugDf
 1mx/4gtCUUsH0VP/9uctw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A1ZhstK+xkA=:gnyJfQoOfRGuvcm8D3TMxv
 KeTdKoRimJO+pvPCl4nhqISvibWM5ciZ4h4FnGwiEuDTG8uN2MBLIrE8iUcY1UmOkh3PfcDoI
 ezvUZ8yy0BCMb3IvTK4BL4ie4Btltk/192AzMvCIAcznRAbPckVrbyMMLd9e0c+ey0ExQ+Jgw
 K+karAMD4+6al45PuKWuxAUW9gvNHOdKux4u0FncYcJzBEO4AEJ5QgXBm5GW2NQOlB3R1sj1E
 eP7haKgCn5ARdxvyRVZVnyEjMf5CNgCGqw1UXqLPUJwh6oHrXUS3PGOg4L/KP7tIJhTB9Gp3Z
 1BFuVLI+ory4ncjtew3w9uOPLKAhmK0OeCSTN0YO33NHLV/ZTV534IYN+DrZLJ8xd8WAu2w5q
 i5SlTVPzoN0M7sxmr1Azl5TJy7JCrl9MkLRiHJxpewT2FT3Sb0zp9uvKnTmaMIlJTr1Vej1sF
 1hxdczc4WOiyopNNmHlBD/g35zOusrALdShmdFWwA6+wDZBwGLytB+eMhfXufA/cpv27Tjp6G
 Jkg1y6r3vibMxcZL4nklV5WVNwHAJQMgw1w8uHFM8WVvwPwd/wzoMMIyL5vFe0FSpz+TjuEie
 ur+gMoEfna50yQktc8Xu59F0bOm7gIdtKPR8japFOMa5djKrsqXjRT5JUEkKKlAEsV1rnbGv4
 KVpsuCyFc0fnfawAcQZpVzcQu5W426fXANie4d36Iq6NrPqbsWnzwFYOvOvGWAPw/T++FG8wZ
 fw3hn0zOwKdRHbxuBrEFS5Yo+0gHM3pkr+Av5NQfwGmctT4zTFY9GHMB05a2loJtIhaNQ6UTi
 8zeUuuZov18M679yEJeCMAHEAIyC2yNKvnfa1aQUTq6/biVG3fWWSIGbNS33seGov7cwxICO2
 bSpnB40OKCw29pZOL7OeuTEg83yHKSIXna9Og9rnDfga9dCioDGjREhGFI+afUSmtNGI3z4vS
 IGYVay57ljp1y7ddDk5uzXPt9s2xI7AYzpwy8MeLVxZmumqicb35dG/Qt5cBD+C9vv2FivC7a
 UG5Us9/cTFKikJRXEVe6V5vqPxGX3aIhwaupStC69yzxzyhNzMvG1uukBIuZdeHtOHgOWIQmG
 AVvpf137uNzjlxwViFZErJwhgFB+Wuc5tsCQwK6T8pXAO1Ewp++XMgSE/Vo9p49M2P4qQ1/74
 JXPw/JOC/obsmzFkR2UDpoF3gzjYSNa6F7bhqM6iPahCm4KWLg+JIxDZdH5pm5BAVGY7VsJzL
 cc0yluiMmpMtIFCooC4d7hQFa1K2HT+vA8p0WdNymLm4TnFNPgbC/fRoIaz4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Sat, 12 Oct 2019, Pratyush Yadav wrote:

> On 08/10/19 04:33AM, Johannes Schindelin via GitGitGadget wrote:
>
> > @@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
> >  	global HEAD PARENT MERGE_HEAD commit_type
> >  	global ui_index ui_workdir ui_comm
> >  	global rescan_active file_states
> > -	global repo_config
> > +	global repo_config _gitdir_cache
> >
> >  	if {$rescan_active > 0 || ![lock_index read]} return
> >
> > +	# Only re-prime gitdir cache on a full rescan
> > +	if {$after ne "ui_ready"} {
>
> What do you mean by a "full rescan"? I assume you use it as the
> differentiator between `ui_do_rescan` (called when you hit F5 or choose
> rescan from the menu) and `do_rescan` (called when you revert a line or
> hunk), and a "full rescan" refers to `ui_do_rescan`.
>
> Well in that case, this check is incorrect. `do_rescan` passes only
> "ui_ready" and `ui_do_rescan` passes "force_first_diff ui_ready".
>
> But either way, I'm not a big fan of this. This check makes assumptions
> about the behaviour of its callers based on what they pass to $after.
> The way I see it, $after should be a black box to `rescan`, and it
> should make absolutely no assumptions about it.
>
> Doing it this way is really brittle, and would break as soon as someone
> changes the behaviour of `ui_do_rescan`. If someone in the future passes
> a different value in $after, this would stop working as intended and
> would not refresh the cached list on a rescan.
>
> So, I think a better place for this if statement would be in
> `ui_do_rescan`. This would mean adding a new function that does this.
> But if we unset _gitdir_cache in prime_gitdir_cache (I see no reason not
> to), we can get away with just something like:
>
>   proc ui_do_rescan {} {
>   	rescan {prime_gitdir_cache; ui_ready}
>   }
>
> Though since `prime_gitdir_cache` does not really depend on the rescan
> being finished, something like this would also work fine:
>
>   proc ui_do_rescan {} {
>   	rescan ui_ready
>   	prime_gitdir_cache
>   }

That was my first attempt. However, there is a very important piece of
code that is even still quoted above: that `if {$rescan_active > 0 ||
![lock_index read]} return` part.

I do _not_ want to interfere with an actively-going-on rescan. If there
is an active one, I don't want to re-prime the `_gitdir` cache.

That was the reason why I put the additional code into `rescan` rather
than into `ui_do_rescan()`.

Ciao,
Johannes

>
> This would allow us to do these two things in parallel since `rescan` is
> asynchronous. But that would also mean it is possible that the status
> bar would show "Ready" while `prime_gitdir_cache` is still executing.
>
> I can't really make up my mind on what is better. I'm inclining on using
> the latter way, effectively trading a bit of UI inconsistency for
> performance (at least in theory).
>
> Thoughts?
>
> > +		array unset _gitdir_cache
> > +		prime_gitdir_cache
> > +	}
> > +
> >  	repository_state newType newHEAD newMERGE_HEAD
> >  	if {[string match amend* $commit_type]
> >  		&& $newType eq {normal}
>
> --
> Regards,
> Pratyush Yadav
>
