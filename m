Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C841F790
	for <e@80x24.org>; Mon,  1 May 2017 11:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdEALtZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:49:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:60915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756836AbdEALsK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:48:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8laO-1dF2EO24HE-00C7s9; Mon, 01
 May 2017 13:48:00 +0200
Date:   Mon, 1 May 2017 13:47:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705011307450.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704271607550.3480@virtualbox> <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704281711540.3480@virtualbox> <xmqq4lx5i83q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Op4pws1WipXpQt5ZnG+92ymoXPxVovDRb4Tv7ggKVWwAbEKZ8CB
 TEydAAqP8+WTGFTI2ZZiD/SQf3TmCEoa/dSlq8mgGWix1KTkHykLNzhgroRjrkSEyhtUYqv
 f40PhC6R2Z/m2ENYZAhfAjPKYAe96aY0sg0FJsQaWpnwkgmFTD0+zH+u9cEqPCMOTgnLS+P
 nf/EiqfktkZ2uRAG5G5ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TYshaJyGgC8=:f4FZrgytDEGcWYf9XMfV4Y
 i3DxGNtDxHpxYHgYnB6foCOBZ/EkZiKsN9wVT3O7ijPC3e5poW2h8Iiy3gpfT9PF3qHCkdpUd
 2hZEEdi4m/wpJbSgUR+A2LuhK2GqZqdMWi7pZvavqqqartCzBPbNEsziMd7ZzHWwiKR92G/j3
 8zud87v8tptWURlvO3lR2Wp4mcreoLmMwvk/4I2p//Dezofa71Xn2Cts55eIbeXAeYf+uq1fM
 T9KfmM/G+p6pVTAOOjPjLIjB1ZgKSWASyqt1H8o4qCUl7HD0YLl18ujzmEWVYIXN+VzNDNsJX
 pGtKhn9LntO5URq90c3CdweWKKPt71zYMQeaa+e9R5ObhhF0vZ7/ENjEdF6jFZVZ2r//QH/9z
 ArW0SNLeWr8GLdDx3VMte3OoTupKAvJeZxw2d0Fa6LCnDAsdnaFaHHzOk3TSWIPaIxaTq0GQ4
 jrVy8Gxd9B9sv22C0k5VeBwLxwRZd9ycOEgvzFM5+XpEHmtXWuG1tUtBEQw4g3ErDKxvtYjwS
 cCXVUkraghjjd1NOzMSXnzJXuWjaC7zo04jRe8ukO6Ewq16u/ltFfNY/Thh9M/bEAN+VXnxIL
 U45tYHSlpFQ/NEvaCXUj15ubXPQQXHMoNg32IK2Qhx5Mz76PmZJGDMvt86uiRuUDFtOkoNPU8
 G7d7AdPuhc0F08teFEAv3auaBpjeN6DGYCj072HqLGyaz1I6JBglTmErpEYIS9qpIpPnGDMbn
 VypulGz0xIxd7EpMutgoRGnZ/uaTSrZU4RxYm2dsZS6ki/o5fh3e05GnotL5PVhukmOOQ+WF7
 px8BGLW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 30 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In that case, I would strongly advise to consider redesigning the API.
> 
> The API we currently have and is used by "log", "rev-list" and friends
> is to have setup_revisions() parse the av[], i.e. the textual API, and
> it is sufficient to hide from the caller the implementation detail of
> what bit rev_info structure has and which bits are flipped when reacting
> to say "--format=..."  option [*1*].

Yes, this (parsing options passed in as strings, with the very real
possibility of catching coding errors only at runtime) is the current way
the API is used.

Sometimes.

And sometimes not.

For example, in builtin/bisect.c's show_diff_tree() function, we *do* call
setup_revisions(), but with argc = 0. We set all the options beforehand to
avoid parsing, to avoid runtime-instead-of-compile-time errors.

The same holds true for builtin/merge.c's squash_message() function.

> As the implementaiton detail of which bits are flipped when reacting to
> each options is _not_ the API, we are essentially left with two choices:
> write this series to the current textual API, or invent an alternate API
> [*2*] and write this series to that new API.

You make it sound as if my goal was to imitate slavishly what that option
did that was passed to the Git command in the git-rebase--interactive.sh
script.

But that is not what my goal is.

My goal is to imitate the *intent* of the shell script. Faithfully, of
course. The fact that the shell script had no better way to access the
internal API than to call the Git command is just a red herring.

What I really want to do *is* to access the revision machinery, as bare
metal as possible, because sequencer *is bare metal, too*.

The current code fulfills that goal rather excellently.

Your suggested change to call the parser and pass plain options as plain
text really flies in the face of this goal.

Your suggested alternative is actually not necessary here, as the code
does exactly what it is supposed to do: it calls, from the internal
libgit.a, another part of libgit.a, and therefore it is totally legitimate
to use implementation details.

If my code were bleeding implementation details to the user interface, I
would agree with you that there is an issue.

But that code does not do that. To the contrary, it hides those
implementation details behind a rather simple user interface.

In the long run, I think you are correct in your fear that bits may be set
incorrectly.

The solution for that is, of course, not to rewrite the API. The solution
is to make the API less fragile.

To be explicit about the fragility in question: the API should not require
the pretty_given bit at all, but it should use an initialized
pretty_print_context within the rev_info struct as indicator that the
pretty print machinery should be used to print out commit messages.

There is something even more fragile about the current concept of parsing
--pretty: the fact that get_commit_format() sets a *file-local* variable
`user_format`, and that that variable is then used for formatting when
pretty_given = 1, is just asking for trouble.

This fragile aspect of the API simply dooms the revision API to suffer
side effects until fixed.

After writing this, I really, really, really fail even more to see why you
make such a big deal out of the pretty_given bit. It is insignificant. If
I were you, I would worry much, much, much, MUCH more about the fact that
`user_format` in pretty.c is changed implicitly by sequencer_make_script()
(not the fault of my patch, of course, but of the way get_commit_format()
operates).

Obviously this latter issue (the `user_format` side effect) is what is a
real problem later on, when we try to make rebase a true builtin, as
sequencer_make_script() will be called as part of a larger operation that
will subsequently run the rebase, and may very well use the revision
machinery to print other commit messages again, *possibly using that
`user_format` by mistake*.

Now, if your suggestion to undo the compile-time safety in favor of a
runtime error, say, in case of a speling eror (which I really would like
to avoid, as I find it a highly sloppy development style to turn compile
time errors into runtime errors for no good reason) would help avoid this
problem with the `user_format`, I would grudgingly bite my tongue,
implement what you suggested and move forward.

But it does not. All it does make the code less safe by pushing a possible
problem from the time of compilation to the time of running the code.
Meaning that problems would be found by users, when developers could have
caught them without this change.

I really wish we were on the same page that this is a really bad idea.

Ciao,
Dscho
