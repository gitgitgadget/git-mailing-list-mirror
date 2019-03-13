Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B2A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCMWlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:41:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:33361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfCMWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:41:09 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MP0LT-1h9zJA260F-006SBw; Wed, 13
 Mar 2019 23:40:55 +0100
Date:   Wed, 13 Mar 2019 23:40:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache
 bug
In-Reply-To: <20190313165320.GA717@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903132327500.41@tvgsbejvaqbjf.bet>
References: <pull.161.git.gitgitgadget@gmail.com> <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com> <87k1h2bvpb.fsf@evledraar.gmail.com> <20190313163516.GA26045@sigill.intra.peff.net>
 <20190313165320.GA717@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G10dYputNiIHsnRtkGi0DuiwKiUstTOESPzmSn1GDXrdg3e/TmA
 m2q2FtPH0pjXVAGK3bPIh0BX2142s6jN9iTAbWH6qCMov77SLiEUQan56DkMAsXNphtCzXZ
 9twkMZTDdsW99eauxJ5qKbumFj4ld3vbXfXJxkWKh1NAUScpStomaryi+kc1bhx6z54Dp8y
 nOavSHO8tIMhrTI46EL0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPyeXGweEVU=:pXO1iwL392tPkPN02mpFdD
 +w32SwesYaGnCjr/stIjpe3Mq5tZdl1CVZnu3DqPEv+Ha1h55+s9Umh7dWX8gvsRGvSIl/fh/
 tTIFwD2rrf26hbL0RhC32cNStRoCiuPd/vlRE5ypr+BYcvYJkMCwMkXuEqFGXSxDvYYSSTY3d
 ti2FAMln3kZmHxW/nxL4X+LgtCKEiLPeYdTZAAXkYuPS2vRr6uDRq1EXo7zYQBmxsUfPgrjKK
 1sZc7RUEvHe5CUlmibTAsfo80w3DFJr62DKFLx0EDBJSVok1a1lLRtRi+yt4n4M4GGwCMZuvp
 4Bhi0yCzsqIU+QLXFMFI2rKD8t5i8HuPdujsFzSJ7tDOSN4nY6JS5SCXBdLRIBn6VY4qKlKJL
 cazTzcUpOcTlz41CKbgVoDznU0kioWapYIK5OhWR78J131nB74qwrslTFR0eYjbsUAq9TlwOl
 TLGAB93hNdnLsmrOwK7N2gKhbmLZAJxwwmAu7VM1gbRlLcto74Fm3ccKRP8SoxEGPIXBLCmwb
 DDJsk4Y2CyqdL+6HNtl2SVtFe0rvtynFz0JJG4439oMRnDIWxr6aia0vI8pqy/BwtOax8evTY
 2DjcUOvl4rwP9DZDr+XajxFINrKuClrfiu+/jl1GA5/1UbX6VCH0p5CadRLRpQBJCP1sMhMfQ
 0sWGBD7S4TQaSz7l+9/nDmIrZvDg438g+e6qbCHhUlivroRcjSTcGByrvBhkr3VQbzW7+EZzg
 yA7yyH5sxe72rMqze4WZrxk2/AKbo+S9DBwN2lASeiPr8XaugwWsMuAIoh6Mo97ymstWtQEJf
 molf0e94ldClUyb69XamNQ0ygn2+hBlpddFFv7tby2qr79kxykC5VO0EH0Nx2gEazx2xqx8ay
 AHt8qQprLIVxcdaKYUMPrV3c8hKKnv2yK/ZeBU1TahQ/e3X0nqq78unDngACM14QmOc1ewm5Q
 jovaBWdilKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 13 Mar 2019, Jeff King wrote:

> 
> By the way, while reading the test more carefully, I did notice two
> funny things:
> 
> > +test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
> > +	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
> > +	export GIT_REBASE_TODO &&
> > +	write_script append-todo.sh <<-\EOS &&
> > +	# For values 5 and 6, this yields SHA-1s with the same first two digits
> > +	echo "pick $(git rev-parse --short \
> > +		$(printf "%s\\n" \
> > +			"tree $EMPTY_TREE" \
> > +			"author A U Thor <author@example.org> $1 +0000" \
> > +			"committer A U Thor <author@example.org> $1 +0000" \
> > +			"" \
> > +			"$1" |
> > +		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO
> 
> Here we redirect the output into $GIT_REBASE_TODO, not stdout.

Indeed, because we want to append a `pick` command to the todo list.

> > +	shift
> > +	test -z "$*" ||
> > +	echo "exec $0 $*" >>$GIT_REBASE_TODO
> 
> And here we do the same thing. That second redirection is unnecessary.

It is actually not unnecessary, but to the contrary quite necessary to
achieve the intended effect: with this command, we append an `exec` line
to the todo list that is guaranteed to be executed after the `pick`
command that we added earlier.

> I also find it interesting that it iterates over its arguments by
> recursive processes. Wouldn't:
> 
>   for i in "$@"; do
> 	echo "pick ..." >>$GIT_REBASE_TODO
>   done
> 
> be a bit more efficient (as well as more obvious?).

It would be more efficient, but it would also fail to test for the
regression.

Remember: it is absolutely crucial for the regression test that the parent
process' loose object cache already has been initialized *before* the new
commit is created and then picked. Otherwise the cache would contain that
commit object already. The whole point of the regression test is that the
cache does *not* contain that object.

The only way we can guarantee that order in this test is if the first
commit is created and picked *before* we `exec` to create the second
commit and then append the `pick` line for that one.

Now, I could have tried to play some fake editor games because it is not
strictly necessary to create the first commit via an `exec` line. Instead,
I could have generated it before the rebase, and then initialized the todo
list with the `pick` of the first commit and then an `exec` of the script
that creates the second commit and then appends a `pick` line for that.

But the reality is that this would have resulted in more code! And not
even easier-to-read code at that! (I know, because one of my unsent
iterations did exactly that.)

So instead, I opted for using the `-x` option to modify the initial todo
list to begin with (it consists of a single `noop`, obviously). This will
add that `exec` line that calls the script that creates the first commit
and appends the `pick` line.

It *also* adds an `exec` line to guarantee that the second commit is
created, and a `pick` line for it is appended to the todo list, *after*
the sequencer initalized the loose object cache by virtue of picking the
first commit.

So yes, it is crucial that the `append-todo.sh` script is `exec`ed
*twice*. Otherwise the first `pick` would initialize the loose object
cache *after* the second commit was created, which Just Works, even
without this here patch series.

Ciao,
Dscho
