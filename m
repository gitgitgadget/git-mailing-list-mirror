Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADC61FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbcLFOs6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 09:48:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:63534 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbcLFOs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 09:48:58 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaXmV-1cwybH132l-00mK38; Tue, 06
 Dec 2016 15:48:40 +0100
Date:   Tue, 6 Dec 2016 15:48:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1612061512190.117539@virtualbox>
References: <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611281830040.117539@virtualbox> <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611292128340.117539@virtualbox> <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611301325210.117539@virtualbox> <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612051126320.117539@virtualbox> <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612061411000.117539@virtualbox>
 <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fPUvz7Geueg3GSA+vagVrxOLFXocmSzGHpAZwi3fg+rOH/lDIR5
 Srk8Pu66jIa96FGFi7T5Fl5QT/TmpRpzac6rskkxYZZ9fZYlthfgei2H1KQjMveLYfLidLF
 HD9qBOJE2FpGMSIHVOUauBENIXSCd8yy3vxELsX0di2e8Xs1PqbqiwgZBjdGHsP8582MXGa
 SsevixjfEFzYLbD63coOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HEZoIk9adDU=:WTKh0Vvd96hn29ydyu0/sD
 IRs4Z7/jSWwbH/Qwg8hcG3pGfgKoSN2KMV/Uq6jQB7jtgHCF0NCaBgRNmMP49u+g+7KhBqL+m
 o6+6UqQfMlUIdy+JmFxOdRmqM1eGc9xeEZ5gmbMN+NwjikJhMAAbfMrldhJtmmOqhi1rLmQ6/
 SQsAeIMWDhXZ+g7+CzvrfC1izZh3AocHCZLdAWoYJ5pM8qk7a9oAp231qFrDVzMd73vrjfj6Y
 RQYw+m6lR1nT02b717btvlcnNG14lLVoypagLanNu57mjfhAmCMQ7TFBIf6uHtydWROr317bx
 bv2w493FxZoK+M/+o63t7/dKdsro5aKc72r2zBcaKu7+vhp/B7QIQcSaiRusoHloaIbKpVIm2
 LlCK9xIoaFe2pjpZVVUZj949xfNEhNcL87woeGg8f37GnrDtoh9nuG5+VVlWB68OQ9ZX2iGup
 l+Nr0smHSEvb23yNima5WVUC/6e8l70VjixJST5xuuu6y3V1WR5+SHA08VzWtQ1y3sEN2JwIL
 y+wewWxQLyVerTbtJWzLRezYUyYCpqsDpmGwITt0vcK5ttTe7+W51ywie74dEEQvhSQ+rmDqB
 MajtpVlZSLT117ovdRnMHtTcKC3YVDlw/Uwi7n2W+DbEuwwhm/L16VPYUC1ST3YNdz2PWkRTi
 i94I+oUyRO3BMUY0viBCwdl2Nt3JLGWJGPAbOYrkJm60IFWosVoaec3hff0VMYoPjUP2poiL0
 1zS11yOx6P0a4YO0VLfyiSZ5aXf1EO9uNOnrXxsuhCxnHf8YDzyLxpGexSOABOusoYgJjyJ6N
 Z1tTehB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Dec 2016, Jeff King wrote:

> On Tue, Dec 06, 2016 at 02:16:35PM +0100, Johannes Schindelin wrote:
> 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > > Seriously, do you really think it is a good idea to have
> > > > git_config_get_value() *ignore* any value in .git/config?
> > > 
> > > When we do not know ".git/" directory we see is the repository we
> > > were told to work on, then we should ignore ".git/config" file.  So
> > > allowing git_config_get_value() to _ignore_ ".git/config" before the
> > > program calls setup_git_directory() does have its uses.
> > 
> > I think you are wrong. This is yet another inconsistent behavior that
> > violates the Law of Least Surprises.
> 
> There are surprises in this code any way you turn.  If we have not
> called setup_git_directory(), then how does git_config_get_value() know
> if we are in a repository or not?

My biggest surprise, frankly, would be that `git init` and `git clone` are
not special-cased.

> Should it blindly look at ".git/config"?

Absolutely not, of course. You did not need me to say that.

> Now your program behaves differently depending on whether you are in the
> top-level of the working tree.

Exactly. This, BTW, is already how the code would behave if anybody called
`git_path()` before `setup_git_directory()`, as the former function
implicitly calls `setup_git_env()` which does *not* call
`setup_git_directory()` but *does* set up `git_dir` which is then used by
`do_git_config_sequence()`..

We have a few of these nasty surprises in our code base, where code
silently assumes that global state is set up correctly, and succeeds in
sometimes surprising ways if it is not.

> Should it speculatively do repo discovery, and use any discovered config
> file?

Personally, I find the way we discover the repository most irritating. It
seems that we have multiple, mutually incompatible code paths
(`setup_git_directory()` and `setup_git_env()` come to mind already, and
it does not help that consecutive calls to `setup_git_directory()` will
yield a very unexpected outcome).

Just try to explain to a veteran software engineer why you cannot call
`setup_git_directory_gently()` multiple times and expect the very same
return value every time.

Another irritation is that some commands that clearly would like to use a
repository if there is one (such as `git diff`) are *not* marked with
RUN_SETUP_GENTLY, due to these unfortunate implementation details.

> Now some commands respect config that they shouldn't (e.g., running "git
> init foo.git" from inside another repository will accidentally pick up
> the value of core.sharedrepository from wherever you happen to run it).

Right. That points to another problem with the way we do things: we leak
global state from discovering a git_dir, which means that we can neither
undo nor override it.

If we discovered our git_dir in a robust manner, `git init` could say:
hey, this git_dir is actually not what I wanted, here is what I want.

Likewise, `git submodule` would eventually be able to run in the very same
process as the calling `git`, as would a local fetch.

> So I think the caller of the config code has to provide some kind of
> context about how it is expecting to run and how the value will be used.

Yep.

Maybe even go a step further and say that the config code needs a context
"object".

> Right now if setup_git_directory() or similar hasn't been called, the
> config code does not look.

Correct.

Actually, half correct. If setup_git_directory() has not been called, but,
say, git_path() (and thereby implicitly setup_git_env()), the config code
*does* look. At a hard-coded .git/config.

> Ideally there would be a way for a caller to say "I am running early and
> not even sure yet if we are in a repo; please speculatively try to find
> repo config for me".

And ideally, it would not roll *yet another* way to discover the git_dir,
but it would reuse the same function (fixing it not to chdir()
unilaterally).

Of course, not using `chdir()` means that we have to figure out symbolic
links somehow, in case somebody works from a symlinked subdirectory, e.g.:

	ln -s $PWD/t/ ~/test-directory
	cd ~/test-directory
	git log

> The pager code does this manually, and without great accuracy; see the
> hack in pager.c's read_early_config().

I saw it. And that is what triggered the mail you are responding to (you
probably saw my eye-rolling between the lines).

The real question is: can we fix this? Or is there simply too great
reluctance to change the current code?

> I think the way forward is:
> 
>   1. Make that an optional behavior in git_config_with_options() so
>      other spots can reuse it (probably alias lookup, and something like
>      your difftool config).

Ideally: *any* early call to `git_config_get_value()`. Make things less
surprising.

>   2. Make it more accurate. Right now it blindly looks in .git/config,
>      but it should be able to do the usual repo-detection (_without_
>      actually entering the repo) to try to find a possible config file.

The real trick will be to convince Junio to have a single function for
git_dir discovery, I guess, lest we have multiple, slightly incompatible
ways to discover it. I expect a lot of resistance here, because we would
have to change tried-and-tested (if POLA-violating) code.

Ciao,
Dscho
