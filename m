Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032D91F461
	for <e@80x24.org>; Thu,  4 Jul 2019 08:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGDI3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 04:29:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:53169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfGDI3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562228964;
        bh=sQ2U7bSG38o1f9rpxW2H+b/ipkl2wAv2cHTt5gTj6rM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZwRyS8P2FBCbviG5f7APhOdonN3E7eDNBkpbIOVao/Ri+rysbNQKwmqNzk6KRD1EH
         01NDg6kYSNJ7g6uoqwveVgE9P4gb3RL7vu41TQ9JctBARDKR9A9zL7DjT1rd13l/QP
         vzqBsHnR23XVPFMjJnHsR3HthQXNE/OTZXRhvc6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lq9oW-1iDaya0RsG-00dq3q; Thu, 04
 Jul 2019 10:29:24 +0200
Date:   Thu, 4 Jul 2019 10:29:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in
 push_refs_with_push
In-Reply-To: <20190703205755.GF121233@google.com>
Message-ID: <nycvar.QRO.7.76.6.1907040947170.44@tvgsbejvaqbjf.bet>
References: <20190702005340.66615-1-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet> <20190703185535.GC121233@google.com> <nycvar.QRO.7.76.6.1907032137210.44@tvgsbejvaqbjf.bet> <20190703205755.GF121233@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h356XnbP6p91UDY1uqzPC7l+it0+QMaa1V1SvCb4+Ntn8PSuUDp
 G+/eJMFgCrdE7Apr8/GwC1X82TVowfSI3CiWUkexy5HjHbf0apDI4tBZAIAihc62v4PMYLJ
 HS9K+Fj79RWX8/Pz2G8/vokzr6pYF3vMI1OAryTwwbbJgnxCI+rmKxp9AxsZIBJqu2uRRd1
 A1ciMM+a0Yr/occM65pWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wpA5zsepQ6M=:eP8WaxNggkkpdg9XDs+Htp
 ZBf3GGjQdG8oJaIW8yHrWoRBuNhdlWOu9tOnjRT8B6xPwbGd2B1epTk8iKDevF1xbS2rAo9GC
 r4txAYUXJERnQcZAF34H8aTCwemaffG7XkCii+8sTgDdSd48BMgMz9PmLqB16gc8AoHt3B47I
 Jza/pNQV3H8bhfLLJdBRb8SWDZLlGlhHQf24YQDt4H7l5gvjMFLUG1dkn+2R0ju1YDu6cZCU4
 WCUcQEARJqjMVvEsPW7MLGkfyegnhLk00HQPMM5ZjMz54nWMTvQBS5pRuVQbq2Vo1w2S9x9b/
 +JwSkDAa/+Asc8SfcP3u5oMN2XTLB0Lb+l/3eNFoJnpUijGWcTqaoWdAB4QvwbJLeR6+2w8Ls
 uLE4s0Zlg5W1x7+MAks9D/7Wbbo8f7KmrVvJbUxmWrOECYIfytXTU/V8EhwNXll93Q8gOJj4d
 Z+YfNQvz2NrW18beJzfqspZV3z/Ra8Sc4JtzjPmpH5+vfgEQdyWs0UMTl1HxRktfAxAFgeI1T
 tNhifM14wjYrBGkz+JheAbrSG8YC7qpEkXWFlmgtHJ9oUQziBzXEO9IMrF7EJFsDdeE6qOFIN
 7VRSz2JbteRbdaba44q+jIk0cQM7EA72iSJKsCuVSXMA2o2tQdIFA+kKAqkfmVvtZmwXzuaIp
 Sg+idjqo5E9Dv1gI6Q8kcw1NZ66+70qFDm2A3Zig+KyTP5zqlEzSB0d+BMeDQ9QYDZe+EyoXh
 bBSOYxRGe1O4jqPCBDYW/yfG93NAbW6CHXmfnaTGeEFxAwtWRwSOcPMLpKt3G0G60CzACyFTI
 Muk9pgr0khNrS6GG/uSjeFiL4SvTC0zCEoW5lwkK86PpBccku5B3jithmWtYqzrFPHyuLPS2x
 x7fqQEpAwxVm41NrrqD6ymOK8DxQQVPLRwsKy8xyEpzSFkcL00aYXyPlsokL0NQN2O243Xi3P
 e8/lkoON1Zv6YKlwKIj7MED4z8Zi2sRk3+kdz2N3Vj/KAuM8ZE1Oq9ouVvWJrJU9rBcC69cWU
 PUjbdNUSe33ixhy0IV5N6KuTyl5YZzy5u+zPTVUJpF085byO9eEQAuR2BFyyJo6wIK629Np1Y
 Eqj3R4d7GYhu6SAqr51E5+xMh8ywKJsRwtq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 3 Jul 2019, Emily Shaffer wrote:

> On Wed, Jul 03, 2019 at 09:41:46PM +0200, Johannes Schindelin wrote:
>
> > On Wed, 3 Jul 2019, Emily Shaffer wrote:
> >
> > > > > +	up=3D"$HTTPD_URL"/smart/atomic-branches.git &&
> > > > > +	test_commit atomic1 &&
> > > > > +	test_commit atomic2 &&
> > > > > +	git push "$up" master &&
> > > >
> > > > It would be more succinct to do a `git clone --bare . "$d"` here,
> > > > instead of a `git init --bare` and a `git push` no?
> > >
> > > I'm not sure I would say "more succinct." This leaves the test with =
the
> > > same number of lines,
> >
> > No, it does not, as `git clone --bare . "$d"` does _both_ the initiali=
zing
> > and the object transfer.
> >
> > It only saves one line, of course, but do keep in mind that anybody
> > running into any kind of regression with your test case needs to
> > understand what it does. And from experience I can tell you that readi=
ng
> > any test case longer than 5 lines is quite annoying when you actually
> > only care about fixing the regression, and not so much about the wonde=
rful
> > story the test case tells.
>
> I suppose I'm confused, then, as I understood you were asking me to
> combine my three test cases into one, which naturally makes the test
> itself more complex and longer to read. Which do you prefer?

If I were tasked with developing this further, I would try to move as much
of the setup into the initial test case (if there is already a `setup`
test case; otherwise I would create one). In fact, I would try to reuse as
much of the existing setup test case as possible, and only add commands if
really necessary. Then, I would try to combine the three test cases in the
patch into a single one, structuring it by white space and using comments
to clarify what is happening.

In my mind, even just adding an empty line before the comments like "Make
master incompatible with up/master" would make it much easier for me to
read, were I to analyze a test breakage.

I have to admit that I have a hard time understanding what the intention
of those three test cases is because I get confused: where does the set-up
end, where is the code that is expected to fail, where are the
expectations tested?

Also, I get confused by how similar the test cases look, and have a hard
time discerning what the differences are (i.e. what are the interesting
bits, where the entropy comes from).

I could imagine that I would have had an easier time reading something
like this:

test_expect_success 'push --atomic' '
	: set up two branches, one which will require a force push &&
	git checkout -b fast-forwarding master &&
	test_commit push-atomic &&
	git checkout -b non-fast-forwarding &&

	: now, initialize the bare repository to push to &&
	d=3D$HTTPD_DOCUMENT_ROOT_PATH/atomic.git &&
	git clone --bare . $d &&

	: modify the two branches and create a third one &&
	git reset --hard HEAD^ &&
	git checkout fast-forwarding &&
	test_commit no-need-to-force &&
	git branch new-branch &&

	: now the atomic push must fail &&
	test_must_fail git push --atomic "$HTTPD_URL"/smart/atomic.git \
		fast-forwarding non-fast-forwarding new-branch 2>err &&

	: verify that new-branch was not pushed &&
	test_must_fail git -C $d rev-parse --verify refs/heads/new-branch &&

	: fast-forwarding should be mentioned even if it would have been OK &&
	grep fast-forwarding err
'

Of course, everybody has their preferences, and their personal style. I do
not want you to imitate my style just to "pacify" me. That's not the point
of this example.

The point is that I need some structure to walk along, especially when I
am a bit annoyed at a test case that shows that I introduced a regression
and all I want is to understand as quickly as possible what I did wrong
again so that I can fix it and move on.

The point is that I want a regression test case to _not_ distract me from
the essential part, ideally I should be able to ignore all the set-up code
and deduce from the command-line of the failing command what is going on.

For example, if the test case fails in the line `grep fast-forwarding err`
above, that command-line alone does not tell me anything, it just
frustrates me. If there is a comment above that line (which is ideally
part of the `-x` trace, that's why I used `:` instead of `#`) that states
the intention in what I consider to be clear, simple English, it is a lot
easier to figure out what the heck is going wrong.

Of course, it would be even better if we had a function, say,
`must_contain` that runs that `grep` and shows the file contents and the
regular expression if that `grep` failed. That's of course outside of the
concern of your patch. But this idea illustrates what I want in a
regression test case: I want it to _help_ me figure out things when it
breaks.

Ciao,
Dscho

P.S.: Please note that the many test cases _I_ introduced into Git's test
suite mostly do not conform to what I wrote above. I learned _quite_ a
lot of how I want regression test cases to look like in the past six
months, not from writing them, but from analyzing literally hundreds of
Azure Pipelines builds. And your question forced me to think about my
learnings to formulate the above (hopefully clear) explanation of what I
want in a regression test, so: thank you.

