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
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D8C1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 08:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfJNIOn (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 04:14:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:41165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728883AbfJNIOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 04:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571040880;
        bh=JwdUTSo2qyhqeNTafVeJzbCzzK4qDhbRHeqP1aZQGJo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kr4FkxgpIQ4HMYai6Iu6iix6qQ+d86yFbnD4+IYAj+OL3DsUZV+Sp//1iflLshWpn
         t8FVfh0DxdbXos1qFgCcPPPy+foiMrg8HBn4kommqUwcdT1G/c1Zq+dC61J01ZYRDf
         5g4yqr2jzU4v+IE91NGt0YAVFzVuo6wSdBxMTEpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1iSlAe1CDI-00QRzP; Mon, 14
 Oct 2019 10:14:40 +0200
Date:   Mon, 14 Oct 2019 10:14:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
In-Reply-To: <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910141013360.46@tvgsbejvaqbjf.bet>
References: <pull.361.v3.git.gitgitgadget@gmail.com> <pull.361.v4.git.gitgitgadget@gmail.com> <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com> <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com> <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
 <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:90fcOYnEBi1vmjbOipAayV0BYN1RIiHo6nYUkwWr2kSpM0ngAlM
 WYdY97P71iRJnFQ/KRDFmvd1g6HD37/9y11QECVPgtyMsj0jjEpYR1NOBXRa3UqpKSr+485
 sKhbUOhrbXtI8b88O4ICbOHXtj2j0hO0n2/FVYE7+DKLb9SuK3Q+LdfkzHbIZb5xZbXH5Yj
 GaIW1It+pdq7ks4gsklMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgbhUediozc=:UEkkprli2vnGDxb+9lOG6Y
 A9i2nVroY/+g1ZFzuy7xem1VQPg5ntNGNLHZq9VStyvQim4YV9GzcLkfK7E+2uAVtV+Z7Ci1Y
 N91Ob22NtVWZt0vtnZFTpeEJ65aEq0Sm/9im+u/arMUJBN9w8qW6e5NydfefrYJp0t88vFsil
 hGmXGYA2e8NkSTnYB72+FOxJcvmBQM/p5J/QJ2fOnXK2pqn2ON5KmPVj5mxn1K142Hav6KHQT
 AUbVNyJn79BcBHWCgjowb8UsVcfDIpZxs0pNTszAzp31inSveQavwJHX5ZrOJ4OZ5arihAs4H
 p5A0pFNiXr7o44dpAJdyDU3WIcFI7hoJ43b8Q4Ri2I+BPkc2EeOib9euE9+TJ8eLEdVfZ9oDd
 MstanJgGPIt/E5xob6av1YTFuTfW9TsUDsmKhgiq1KtYx/a7hwfnawK4izU0lmlajSJ/s0F7V
 1UtTLHAY3ndfuQqVR+lhChWRuNIgP3rplyhyVt3oiXUSi0rGZnTTXEHJwk/pAn2NksC9oEMJE
 MEkWxqnXWO4X9iTvHJ8FJivIwp/9TyJWYINittMkNh2fqFMybL67CE5Fb/2ogpFfzwLBy4imA
 aEm0DcT6VCb9TX5cCP89LnwQHMpXcVUmnhfhqcPxMKlULXlczK4wlvKonItwBcLgnZi+r4tD+
 c+5spm0+1lKddmJh7Tuo5zONN4gKQYiJcwvLeOLOiNIFoZ+Wjqee4/ixRT+RQwfQ/Q5jrygaw
 UdYuPSYtWCLAhRmeZtJEKTRL6DJ8ncqw/lpm34vYtccrDz5HGZ+hG1lwZ2e9fGS0VruAD4ieb
 WZnsky9S6LNFLC1vxGMlsamu1eGCZjGjqLlUTL6Opyh6apuEgqBmkllC3+XMX5pvw7Nz41L93
 5BftNnqlWBFm3BziCzAO80Ei6tc6ZoKs5WnrxRN9z4kr50fzsccQifc15rcrzsvr3dUWuk7oO
 EtqBQcJFpyW0nvEa/PKhS5rp+573Twei1p9A98/bRKVXzBxo++2+FcjeslkjrL8ogsmn9hTVM
 g/D4L4uvUZgdRXt1KDm+jkZtPog9sW8GI2XP6ZfYxeGUS/txtaXwVB3l24TLgWXNQqXVVJlrf
 Rv7kH08AmP+bmIvTrkIX+LyVEF6MNmzWb8uUSNVkdVxaXXjIYNV/Fm98CGnhNYvNrtm0Y7RZy
 6Tz9wtdcNHSVEE9fkwsqyit2aX1zv3rH4ImRLne2ESRb6GBZsCvJvZHczD8OWXKjnjPwKGjU+
 OrJc21k7FC6fLpx1Z9DpVCzN22UtZ5Xl5SZudCvIV2FXxZgUGCBWn4ea/Fp4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 14 Oct 2019, Pratyush Yadav wrote:

> On 12/10/19 11:24PM, Johannes Schindelin wrote:
> >
> > On Sat, 12 Oct 2019, Pratyush Yadav wrote:
> >
> > > On 08/10/19 04:33AM, Johannes Schindelin via GitGitGadget wrote:
> > >
> > > > @@ -1453,10 +1501,16 @@ proc rescan {after {honor_trustmtime 1}} {
> > > >  	global HEAD PARENT MERGE_HEAD commit_type
> > > >  	global ui_index ui_workdir ui_comm
> > > >  	global rescan_active file_states
> > > > -	global repo_config
> > > > +	global repo_config _gitdir_cache
> > > >
> > > >  	if {$rescan_active > 0 || ![lock_index read]} return
> > > >
> > > > +	# Only re-prime gitdir cache on a full rescan
> > > > +	if {$after ne "ui_ready"} {
> > >
> > > What do you mean by a "full rescan"? I assume you use it as the
> > > differentiator between `ui_do_rescan` (called when you hit F5 or cho=
ose
> > > rescan from the menu) and `do_rescan` (called when you revert a line=
 or
> > > hunk), and a "full rescan" refers to `ui_do_rescan`.
> > >
> > > Well in that case, this check is incorrect. `do_rescan` passes only
> > > "ui_ready" and `ui_do_rescan` passes "force_first_diff ui_ready".
> > >
> > > But either way, I'm not a big fan of this. This check makes assumpti=
ons
> > > about the behaviour of its callers based on what they pass to $after=
.
> > > The way I see it, $after should be a black box to `rescan`, and it
> > > should make absolutely no assumptions about it.
> > >
> > > Doing it this way is really brittle, and would break as soon as some=
one
> > > changes the behaviour of `ui_do_rescan`. If someone in the future pa=
sses
> > > a different value in $after, this would stop working as intended and
> > > would not refresh the cached list on a rescan.
> > >
> > > So, I think a better place for this if statement would be in
> > > `ui_do_rescan`. This would mean adding a new function that does this=
.
> > > But if we unset _gitdir_cache in prime_gitdir_cache (I see no reason=
 not
> > > to), we can get away with just something like:
> > >
> > >   proc ui_do_rescan {} {
> > >   	rescan {prime_gitdir_cache; ui_ready}
> > >   }
> > >
> > > Though since `prime_gitdir_cache` does not really depend on the resc=
an
> > > being finished, something like this would also work fine:
> > >
> > >   proc ui_do_rescan {} {
> > >   	rescan ui_ready
> > >   	prime_gitdir_cache
> > >   }
> >
> > That was my first attempt. However, there is a very important piece of
> > code that is even still quoted above: that `if {$rescan_active > 0 ||
> > ![lock_index read]} return` part.
> >
> > I do _not_ want to interfere with an actively-going-on rescan. If ther=
e
> > is an active one, I don't want to re-prime the `_gitdir` cache.
>
> Good catch! In that case I suppose refreshing the cache in $after would
> be the way to go (IOW, the former of my two suggestions). Anything
> $after won't get executed if we return early from that check.

But it also won't get executed before the actual rescan. Which is
precisely what I tried to ensure.

Ciao,
Johannes

>
> > That was the reason why I put the additional code into `rescan` rather
> > than into `ui_do_rescan()`.
> >
> > Ciao,
> > Johannes
> >
> > >
> > > This would allow us to do these two things in parallel since `rescan=
` is
> > > asynchronous. But that would also mean it is possible that the statu=
s
> > > bar would show "Ready" while `prime_gitdir_cache` is still executing=
.
> > >
> > > I can't really make up my mind on what is better. I'm inclining on u=
sing
> > > the latter way, effectively trading a bit of UI inconsistency for
> > > performance (at least in theory).
> > >
> > > Thoughts?
> > >
> > > > +		array unset _gitdir_cache
> > > > +		prime_gitdir_cache
> > > > +	}
> > > > +
> > > >  	repository_state newType newHEAD newMERGE_HEAD
> > > >  	if {[string match amend* $commit_type]
> > > >  		&& $newType eq {normal}
>
> --
> Regards,
> Pratyush Yadav
>
