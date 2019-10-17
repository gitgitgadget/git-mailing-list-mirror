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
	by dcvr.yhbt.net (Postfix) with ESMTP id 318A31F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503727AbfJQWFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:05:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:54895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503724AbfJQWFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 18:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571349936;
        bh=v41wIEZ+GSsWlXp3lRWkZdVai8Ou+oEryYMuYbYuBLw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gzlmkDrropjYO/mrjAAj1IHD2o6QqXG5ksZA2Hi12crFBQIJHxz9zwZhjsZz33YzJ
         QbMnnkwhhjDoKEAvurQb71+14N55AYlB9/IvI8FnJTLlSlPi57ZylWH0KuWz1uYgZV
         hiZr8buNPHJOYHHBb//dG+9aTSUlH90fJ9jVuOhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1iIAx3260j-00EhhU; Fri, 18
 Oct 2019 00:05:36 +0200
Date:   Fri, 18 Oct 2019 00:05:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git_path(): handle `.lock` files correctly
In-Reply-To: <20191016110440.GV29845@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910172333360.46@tvgsbejvaqbjf.bet>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com> <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com> <20191016110440.GV29845@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-166488448-1571349936=:46"
X-Provags-ID: V03:K1:VG+CqaJ5zVJFmIrP7KqiK+4HFy1LyM87hK7MAk3fm4/CmPz1VN6
 +vrRN7a1jS9sDKXZ5l2mUdMzl07Y50BZAnxo+5AsJZkRH81XPcFVkeVrzoMYmOazyH0pdk5
 2gmRs4wz5h+uVSNejMpu+KB/2rbTM2ERirWekZCYvyhfd85WxuGUGqhM2QBIK5MFW5nUjKH
 u3s14gHKUsm19bxGxqrgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZIp38VdBKrE=:sbirG2QbgQ935DnA6OwE8J
 hIpMwC4BSGhinRFoD6edo3VL3D3zZqwgZZNBNv9YPjsvmRc3+d4Nl30eDmeRc4faGzxLiSZJA
 Wsub/cMTR0bYt8HJHDlv0AshW4DgzU8mThNyUUfxSL8fDXrPXVEa7TAYLtSliW8A1L+mwsmC9
 pZ9HaTUR/w6QOKNxpmLqweWG85VZc5bNTWiw4twQZrCAsFdqLqQ0KLbkY34ukpNjzia8aQhFb
 IhbEZUh5AVYpwOAIxYmqq32Z9e49QtmI7y+dQrZc6WB4mp+mrrRzHQJDOJK3XGtReugwWtr6R
 J1zmluFS69OebCjBiXbx4Yih7eWbVUBIYgcGZnWABBNCS3TPgpdvGGENwK36BXA+j8sKzI+9u
 PzvLW3IcDTMCEnxOylmxejpSQs7tBNn1pCAFBsKrQ+wRsSH2Y0rkzbtjzXmOr4pVTwgJxNKBs
 otOxeOUwcg0TdmSOCquWwX2hXMCrooobPsjq9PmUK3PbzXVoIiEn3mJ4/DfF3lPHfcLNXSOxM
 ZY6lg3F8ikH9aKkVlOGKxAFVueyxwXkBvoql+iAAtmxTTOB1mrgDIcUk9Oh1UywAczITlAgTK
 gh8b2hMjZ3ZogwUpyXbGJLsO4zzrM4eZskRPekC8Dgdn5ldWTcSnfIbKonC0kcs9RSEAMyU2n
 HfiZ4AB5BRaxIqfaCirjff0mwnJhnlANEVlPRdDDevGNxjxd92yCFgMMYX8gEH3KHZptSH4b1
 zPk/+97WfeDR/f5tES6pRn9zVTKRgdEtTGeIn13e/7ztXDxX9659DXVF2U7vur+vZL/ws19iP
 7uG7Nji8qpEsV1vtF0N/Fw6352cD7tVpRK6X6UpKD9JCy3MojnWokbE7geo3MG+n/eSNWr/jo
 V4kYWRg4IzaKDbbyNaG30Fe7nvN+vflfDqA5VfqRk4f3FlucR4dMV2j1IEOueI9Tl33x9mC6I
 sEIYu7Zzb34sj0CX0jFVY7gyufZWUIf2DbCBFfgjeVrN4EFCa9F3cYZZYYXmS2bpd0VcRRhmI
 S+Ni4iFV6XCm6UF80NXRnPZiC3qUz99WCS9ZQwp6oiF6pWZ/cJr5EF8u6HBUuaNR3DZBHHFCZ
 fYweBbSqnCw44MiuZW9+Fq2gL9iVzbf0R5pBki5R25l8/bd/YQ6kppRDxfACkFr19HZN2YzB+
 e5CMNicVXvJq2meU7CsFhIe3VYyFaGU9TicLuaAMO9aGxfNXIFyC8PfHxOAuGWaXmL7AN+QxB
 Idvj1R8KyWgsBX/qRXuHczT2icmCUFGcBJQd+Vdhi/mBxkNPrg97MpjJC0Dg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-166488448-1571349936=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Wed, 16 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Oct 16, 2019 at 07:07:17AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Ever since worktrees were introduced, the `git_path()` function _reall=
y_
> > needed to be called e.g. to get at the `index`. However, the wrong pat=
h
> > is returned for `index.lock`.
>
> Could you give an example where it returns the wrong path for
> 'index.lock'?

Oh wow, this was a left-over from an early draft, before I got the
regression test to work... What I meant was of course logs/HEAD.lock.
Will fix.

> I tried to reproduce this issue in a working tree, but
> no matter what I've tried, 'git rev-parse --git-dir index.lock' always
> returned the right path.

With `s/--git-dir/--git-path/`, I agree.

> > This does not matter as long as the Git executable is doing the asking=
,
> > as the path for that `index.lock` file is constructed from
> > `git_path("index")` by appending the `.lock` suffix.
> >
> > However, Git GUI just learned to use `--git-path` instead of appending
> > relative paths to what `git rev-parse --git-dir` returns (and as a
> > consequence not only using the correct hooks directory, but also using
> > the correct paths in worktrees other than the main one). And one of th=
e
> > paths it is looking for is... you guessed it... `index.lock`.
> >
> > So let's make that work as script writers would expect it to.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  path.c               |  4 ++--
> >  t/t1500-rev-parse.sh | 15 +++++++++++++++
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/path.c b/path.c
> > index e3da1f3c4e..ff85692b45 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -268,7 +268,7 @@ static int trie_find(struct trie *root, const char=
 *key, match_fn fn,
> >  	int result;
> >  	struct trie *child;
> >
> > -	if (!*key) {
> > +	if (!*key || !strcmp(key, ".lock")) {
> >  		/* we have reached the end of the key */
> >  		if (root->value && !root->len)
> >  			return fn(key, root->value, baton);
> > @@ -288,7 +288,7 @@ static int trie_find(struct trie *root, const char=
 *key, match_fn fn,
> >
> >  	/* Matched the entire compressed section */
> >  	key +=3D i;
> > -	if (!*key)
> > +	if (!*key || !strcmp(key, ".lock"))
> >  		/* End of key */
> >  		return fn(key, root->value, baton);
> >
> > diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> > index 01abee533d..d318a1eeef 100755
> > --- a/t/t1500-rev-parse.sh
> > +++ b/t/t1500-rev-parse.sh
> > @@ -116,6 +116,21 @@ test_expect_success 'git-path inside sub-dir' '
> >  	test_cmp expect actual
> >  '
> >
> > +test_expect_success 'git-path in worktree' '
> > +	test_tick &&
> > +	git commit --allow-empty -m empty &&
> > +	git worktree add --detach wt &&
> > +	test_write_lines >expect \
> > +		"$(pwd)/.git/worktrees/wt/logs/HEAD" \
> > +		"$(pwd)/.git/worktrees/wt/logs/HEAD.lock" \
> > +		"$(pwd)/.git/worktrees/wt/index" \
> > +		"$(pwd)/.git/worktrees/wt/index.lock" &&
> > +	git -C wt rev-parse >actual \
> > +		--git-path logs/HEAD --git-path logs/HEAD.lock \
> > +		--git-path index --git-path index.lock &&
> > +	test_cmp expect actual
>
> Without the fix applied this test fails with:
>
>   + test_cmp expect actual
>   --- expect      2019-10-16 10:20:31.047229423 +0000
>   +++ actual      2019-10-16 10:20:31.051229519 +0000
>   @@ -1,4 +1,4 @@
>    /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees=
/wt/logs/HEAD
>   -/home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees=
/wt/logs/HEAD.lock
>   +/home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/logs/HEAD=
.lock
>    /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees=
/wt/index
>    /home/szeder/src/git/t/trash directory.t1500-rev-parse/.git/worktrees=
/wt/index.lock
>   error: last command exited with $?=3D1
>
> So the path of 'index.lock' seems to be fine already, it's the path of
> the lockfile for HEAD's reflog that's indeed wrong and makes the test
> fail.

Indeed, and this makes this patch much less important than I previosly
thought. It's not like it would break Git GUI in worktrees, which is
what I thought, which in turn is the reason I sent this so close to
-rc0.

> On a related note, I'm not sure whether the path of the reflogs
> directory is right while in a different working tree...  Both with and
> without this patch I get a path pointing to the main working tree:
>
>   $ ./git -C WT/ rev-parse --git-path logs
>   /home/szeder/src/git/.git/logs
>
> However, I'm not sure what the right path should be in the first
> place, given that each working tree has its own 'logs' directory, but
> only for HEAD's reflog, while everything else goes to the main working
> tree's 'logs' directory.

It's like Junio said, the reflog for `HEAD` is special because `HEAD` is
special. Look for `common_list` in `path.c` (it is a bit confusing, I
admit, you have to look for the 3rd column of numbers: if it is a `1`,
then it is a worktree-specific path, if it is `0`, it is supposed to
live in the "commondir", i.e. in the gitdir of the main worktree).

Thanks,
Dscho

>
> > +'
> > +
> >  test_expect_success 'rev-parse --is-shallow-repository in shallow rep=
o' '
> >  	test_commit test_commit &&
> >  	echo true >expect &&
> > --
> > gitgitgadget
>

--8323328-166488448-1571349936=:46--
