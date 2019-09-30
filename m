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
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B6B1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfI3Jmu (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:42:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:40533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbfI3Jmu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569836564;
        bh=luXJLyZ+FYi2RSEz8GQK9GyEWDDHCy+Yg/dnxaYPaIc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jM/9+wk98QJOh8LcvmlpFlXuuyi7FmTi6XX9xtabTz+lAx2IHp7lkGB+PjQU3CnfG
         aKIuVk/PyBVKouQth55RR4ij3PrrNiMct+Jw3uuR+JGw5viEQGdYpoBB8cj7EbwsTz
         rQyhizDNmd3jL29hgjWY+xf5g7EXTyiIsrtPPufc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1ibx032ylo-00VyeT; Mon, 30
 Sep 2019 11:42:44 +0200
Date:   Mon, 30 Sep 2019 11:42:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
In-Reply-To: <20190927130539.52oir56byuedqmm3@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1909301139460.46@tvgsbejvaqbjf.bet>
References: <pull.361.git.gitgitgadget@gmail.com> <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com> <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com> <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
 <20190927130539.52oir56byuedqmm3@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zl0OOQATTtV9G+UsjWqWx2A6pJFZZcOIJtxbhAyFjwpDJSxt1Ia
 MhWXp8srMkJQjhr8OLu1xQvY0sYsuIADOD8khxA2jVlH/7JKgDL6q+MgFe6H4FMrxt61zs5
 hyjE3QXqQnVpDenPUpt5Lv4LutQaQ+pd2mL450miuyHsiUhIIHdC1/03KZMzwmjScDNLFRY
 m/YUFsoeyDOZgxE7Jthsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0zV3TXd3IPQ=:UDUYno38wTF43LtSpWUKhi
 L2qA0VdcSEcyuBIR7QHxCZ/dNEGZNHX6E5kPYpDHyCVaF1pPCeF3sRJBeJTGatHxWOQ4ij2E+
 u8L+GPO4yh3f8JXbg/8jrymhxqp8xq+wzbfFn7sHNyBM+XMBpT03HVqv/XlsAmApm5zN7VnQh
 1QbbLhdMcQXzEy4F3jTdVnUWE2K9pyV14iFHvMm21/bm7Jdr7hhM2/NssNjouXAwjU2Z+0Gw2
 D/JtuJIPRTN9Lkq4Sc92F/ogxWTBCI6HkPI5MRcQLhJi+GtdFo+eB6Vwip1qCVETIvrRYnbP1
 ZgESou/3y5t7xrBhw0nONLKFFRk8DdBUVMDntneBqE7jWz3nkIsynUql2bsoBtaNrFMcJY3f0
 31GiQ+ZNpHYNgRZ6VNOP1qIiWSYSMR/P8kLXTbmIMxrblTJpxN/d6qT/XtpFcWSkBSLCNORvT
 efiHKFVVgRcwZgz/agcXFPay/IqyFYuGGTt7DZ7mWD7qJv/c/w5g7lIooQb5eApTb1xcRFfHz
 MX7cgVxM5egmbMDxIabzjK44eOCRvPRnI5Zpy0rf3XCSUjqMs5BWOlM8B2fF5eHL9XFXfA6lc
 dXanMW9lBRAvhHpV4+0LPkswFHh2LPTPe56eqbJFi6xyvY/DFi0a0HZVOcruHzU8PLd/Z6ZG8
 fvQGGi3lwEIn7+zZBu5Q9uwfOiXcA7JicQg4aeocEtj/KAV7sA8Vs3cho7j5dgTVGvAihQ4jL
 m/QoRULSACZ5M69s8iMH8WJEZc6DjDucK5P3Ymh/bPZBWeq8Z1GYLt7JAiStpKUH9q1Q0S8IB
 7vCsMdlkK4byk1bBXHvCv0B0n+MURSXHXId5OiaSnIzarPe202paF4r8LJsf71+a5+HTytg0/
 EIBA8w4R2onIEnl4ctEXw3ECkmP7GIXSIKmim/4vA3FBMKNaGjdGsLyu0RLyo32WkrzyeLn5b
 J0KpWnC7RGEttotohQqohQVSNIYbIivAv73rpNQMvqYwew+hsDGwbgeloSbHY1KEsLRsh4RK+
 f/qq3RsaiaL+brDCpUourq84OLE655F2WmaW2xL0NoorMG4qP+73nE05VdTk8pnoUQpOMO5PU
 39W0U/SuTVNvjHwZKytqTW4BH73E42IaZLjucTEKQuZkynBvNoJV7uP7idRqddiSeiDj52h/6
 AxtToN2sSixS2r5IUW/jtDbFOsiAqxIIFwjU9XkIU5P7hO4l417UgyxYXqgdfU2ZghvuObjJn
 ITxuOCNVvZFvY9nr+kk5BNAuJC4/JgWX1P5KRqNDF/hfUsaR3QgXIErjWjbY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 27 Sep 2019, Pratyush Yadav wrote:

> On 27/09/19 08:10AM, Bert Wesarg wrote:
> > On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.com>=
 wrote:
> > >
> > > On 26/09/19 02:17PM, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > >
> > > > Since v2.9.0, Git knows about the config variable core.hookspath
> > > > that allows overriding the path to the directory containing the
> > > > Git hooks.
> > > >
> > > > Since v2.10.0, the `--git-path` option respects that config
> > > > variable, too, so we may just as well use that command.
> > > >
> > > > For Git versions older than v2.5.0 (which was the first version to
> > > > support the `--git-path` option for the `rev-parse` command), we
> > > > simply fall back to the previous code.
> > > >
> > > > This fixes https://github.com/git-for-windows/git/issues/1755
> > > >
> > > > Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >  git-gui.sh | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/git-gui.sh b/git-gui.sh
> > > > index fd476b6999..b2c6e7a1db 100755
> > > > --- a/git-gui.sh
> > > > +++ b/git-gui.sh
> > > > @@ -623,7 +623,11 @@ proc git_write {args} {
> > > >  }
> > > >
> > > >  proc githook_read {hook_name args} {
> > > > -     set pchook [gitdir hooks $hook_name]
> > > > +     if {[package vcompare $::_git_version 2.5.0] >=3D 0} {
> > > > +             set pchook [git rev-parse --git-path "hooks/$hook_na=
me"]
> > > > +     } else {
> > > > +             set pchook [gitdir hooks $hook_name]
> > > > +     }
> > >
> > > gitdir is used in a lot of places, and I think all those would also
> > > benefit from using --git-path. So I think it is a better idea to mov=
e
> > > this to the procedure gitdir. It would have to be refactored to take=
 any
> > > number of arguments, instead of the two it takes here.
> >
> > gitdir already takes an arbitrary number of arguments and joins them
> > to a path. The more imminent challenge is, that gitdir caches the
> > GIT_DIR, thus it tries to avoid calling "git rev-parse". Which works
> > for most, but not for hooks.
>
> What I was thinking of was something like this:
>
>   - If no args are passed, then just directly return $_gitdir. This is
>     already being done. I assume the GIT_DIR relocation is already
>     handled by `git rev-parse --git-dir`, so this would point to the
>     correct location.
>   - If args are passed, then we want a subdirectory of GIT_DIR In this
>     case, it is possible that this subdirectory has also been relocated
>     (hooks/ being one of those subdirectories). So in this case, use
>     `git rev-parse --git-path` instead.
>
> So the gitdir procedure would look something like:
>
>   proc gitdir {args} {
>   	global $_gitdir
>   	if {$args eq {}} {
>   		# Return the cached GIT_DIR
>   		return $_gitdir
>   	}
>
>   	# Use `git rev-parse --git-path` to get the path instead of
>   	# using the cached value.
>   }
>
> Am I missing something? Or does this fix the issue you describe?

The `gitdir` function is called 13 times during startup alone, and who
knows how many more times later.

So I am quite convinced that the original intention was to save on
spawning processes left and right.

But since you are the Git GUI maintainer, and this was your suggestion,
I made it so.

Ciao,
Johannes

> > We could either maintain a blacklist, for what we cache the result
> > too, or always call "git rev-parse --git-dir".
> >
> > This blacklist would need to be in sync with the one in Git's
> > path.c::adjust_git_path() than.
>
> Is caching GIT_DIR that important in terms of performance? Otherwise,
> I'd say calling `git rev-parse --git-path` for _every_ subdirectory of
> GIT_DIR is a much simpler solution.
>
> --
> Regards,
> Pratyush Yadav
>
