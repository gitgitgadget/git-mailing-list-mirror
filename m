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
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CC41F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 22:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfJMWTJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 18:19:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:35587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfJMWTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 18:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571005146;
        bh=3Pjw0mkwYIz0nvZRwjFDerZ9acnFMzgpaBJ4FP5dJYk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jSEeMm1WsDKf7fRt5Uzc76OK9I2HOz89WAnqwpoJTbWXVBEKXbz5LvJNGLdUXxmUh
         dW9qJXlv2Zr53aT/1iEK5piho0HktvOCyQnhZTT5RGt5X5HlC4U1du059pxLaCgp3/
         RTOEXUmag7R8Dfe+YlLOqS8HK4H6fYQamFesA06U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1iHIIa3bBJ-00FjQR; Mon, 14
 Oct 2019 00:19:06 +0200
Date:   Mon, 14 Oct 2019 00:18:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v4 1/1] Make gitdir work with worktrees, respect
 core.hooksPath, etc
In-Reply-To: <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910140015500.46@tvgsbejvaqbjf.bet>
References: <pull.361.v3.git.gitgitgadget@gmail.com> <pull.361.v4.git.gitgitgadget@gmail.com> <2f55d6fb2a158c5b26b93ddb9c144ce1af5d9c32.1570534405.git.gitgitgadget@gmail.com> <20191011222611.le5lyf6mr5lmvbbd@yadavpratyush.com> <nycvar.QRO.7.76.6.1910122321211.3272@tvgsbejvaqbjf.bet>
 <20191013185540.fwyn4ox5dbyxgvnh@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xag/nWF2sgkOHXuL4bC/Bb7Wtu3vhuxhes4Xvb9qmpadgfqZAIi
 YH5pNHGjdWB6o9slEmStCa4DfxzmfqI9CsFesAPoX7hVaPvRSfKatN/VYFoFRHFBuhQ4+7q
 9fpKLuPaUpp/2NQ7VPKhwDCgzYgjumC6tP31Frd4KjgP48ok+VCX7gI1OrNVTC04nNxTylK
 NnOc0sNyMs9KFHOZMM3Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7nuYn00nPNE=:qYr8QSP/5KwPDPWhftvsA+
 yoQmaeZmifLko+dixtJPlBJsjpO+6GY0rrWcztoUzbpb2AWMijsAePHaZvSEKOkGPqqYAUCz0
 7dNfOcSH7rDeWAwarBS7ybWT1B+CSI8HR0KuKVPLRoo8NSSCGGmplI6xuYJyuL6xJnZHOXAwN
 1Ul8PuoPIVSHX+HmNN3eGoTMq4YvVtw4GaGHfFu/iafqvGJsAcGRYP+wDWjtzsoBSSMYor06k
 HXNXE0TrQIRHs8I4w9egC+TA3KQ9CpAH+WlUrBYABBKkWQLu30TyfidZX0T4pF2dDMQMlV9Oq
 TmCyxQo9/uxYW354Efd9uRcbTF1j/21Lt8msHh6al4r6VVe5yJmN8UkRi5s/5l2dVlddKJxgg
 lY/F9J4TE0F+SUwlCqvSVQrH5spTS2DY3PMHY/P9QqA5GDu2RN0j4sU6HqljRALsr9MBlk113
 14xxr305CyDhAL6tduPTd2zwiACs5w2CeZ1tsQFTgmNGg8Dq2rxZBx+ETEYAkt6IVIHg+FhRE
 7EQov3pRoobZNQeZB1GZnu9P+DreUMRr4DrbAsvSi5BZO1EgsLfS3ksLvCavHo6AymUzOutmQ
 naK80sF9dNEi9qZhMrtJ7HObDlwvf8By2/VY3rQPreNqRcl65YTePwoz2SM0K7/6saEfARbNB
 XkO1PRlB9/SBPafo11oUqS3BaGxz6vpoX9FhTSzxj+zsN+uwRF+Kw+yq84H9Ud5azc69sTN2c
 pEOhgnI278NLtSnjdMGAHZVJfDi0F1owyAO4O0Q0CXgkRyRgzzr+AJMlwfH2HpAn3czVaDHLZ
 lRgsny/nOGN4/d6mcg4PCNEj7dRqNEZzkxUTOmh0Q7+IIlQqiFT6qv9xGQdJa7OjCohYLYjsS
 G1UOU5sydqMlM0Y+AScw2+2AiomdTLWdynQOzjhgjif4/NNV14XaXzUv1LJuWM5AQRjghAzqp
 sDkA1CntNXhfdjj7EEElqz+7uS2jUh9PDWVUr37ezzNNSFr1siPOiK2JAaCRV7prY0mDY6tEw
 gxcqCBSDkiM1Hum3UJ6UD/V07HyEpOwx0C3/A57G3Qa+knJ41aiErP7DrujvtcBc18pNWmqvk
 ikzGvFDePyxiyNB5QEZk2ooXth/6p7SHj0aldRQkF1i6Blma5E8uqy6o5JiAyAERtyj0fTG5q
 Nv/6U7oWQY5ULUuqhhFUpfJJ68Hq936ZCbcATdCVtEPW9tx0rPOioN2m0nS4HSHefp3XRX2BH
 V9/W1mLFbRniX2Q2+I/E/NJ5hwDkQ6XLrMYg8TBed1+pPvb7w8v6UV08wYqc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 14 Oct 2019, Pratyush Yadav wrote:

> On 12/10/19 11:24PM, Johannes Schindelin wrote:
> > Hi Pratyush,
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

The obvious problem with that solution is that the `_gitdir` is reset
_after_ the rescan. In my solution, it is reset _before_, as I have no
idea how often the `_gitdir` values are used during a rescan (and if
none of they were, I would like to be very cautious to prepare for a
future where any of those `_gitdir` values _are_ used during a rescan).

So I am afraid that I find way too serious problems with both of your
proposed alternatives.

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
>
