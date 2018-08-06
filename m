Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CFC208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 10:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeHFMgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 08:36:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:37405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeHFMgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 08:36:09 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNHqL-1fp7pt4Anp-006uLl; Mon, 06
 Aug 2018 12:27:41 +0200
Date:   Mon, 6 Aug 2018 12:27:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] line-log: demonstrate a bug with nearly-overlapping
 ranges
In-Reply-To: <20180805015908.GE258270@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808061216060.71@tvgsbejvaqbjf.bet>
References: <pull.15.git.gitgitgadget@gmail.com> <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com> <20180805015908.GE258270@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wkIZM3YVg7HjHK+US5r6hIvcEBjAG6xNwKhkqlrOj04VKMLBziB
 VxSMfN5O+VUao+WpqNe3ziJz/LFVqG75laBriHDgfP7F4zGpZ016JwrxReq5JgxTEK/8Kw2
 JcvLSEb4yqfEIqAK+zp+oRiy3r5nFJ81SM34zDmhdjNEB6yXe3jAXV34OM0j/wdxU96KQa3
 aVT86s0jhtYnSGhpF/25g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I0jdllLYEFo=:653pRDHetNzn3U88uNK3wA
 xtmiqH0uTuIuS6qYzNu8MIYt4/PcVtVBpCn1Ub5pXYFjpbGe+igGT4G4lyOh3ulBgapuwyHMS
 pkCViaRB7BbdrJUMdID6YIBNnXCVtBktA2IQ6f2FteU7v+qnO7tSw6QpX6F/TjXIyQmdF/1G6
 s0eUQF/YLYFrpzaC85rG/5FKzO1RoykMLLPYTrjp+4fI04mkznNF+a79Ocv9bpi/+mCjjWJz/
 wMlmsmDUcvmEpSr0CyKSEVtv8uIbe7ufDCJloUTzpWES0F8eYrqYked46fpy0sUjrbFnl4BsK
 LyHNGv1Vuyx5s/rM9Iet8we4yR3l+BqZ2nVhdP+GO4M9KM6hfFGHFWV2ten88l996G+iNBbq0
 rqzvmc2qkMisNz6IYLb0KDiil+y5uWZxylo5QuUL2/ioFJRThBSlqESjj/kDwfkI7ISlX7kAQ
 N7e85G20AdWKKm3vCTe3itHxktD04TQEElidt4aFsqzPsofltfSeCfmZNXmQMvbdhT/ukSbwe
 LltvOZsghBf70L5KwpZYLu4RzUWSfy00/bSxiflr1fktzVREEdGjvoKVMdFHmma1wz+NugBus
 rjF6jCxeSP0C/seBTFInST7wCZjkWsyI7ztooZo401dXRCFgcJq8sX0G5lQ7Y+3B3413x95rZ
 x2yIknmCHvbhjUF47XdXs/wtKvmQ6c7NwRTQPJA/KBIhFFTHxXF0xbaxCq7FcoFNP7mFb8uhN
 rIPGJ7McjGM5DqHpj6yl7uXIoObTMT+8J2JwrxgQut6qnT/AT5GoM08wYUvpYs6dZDmkQ17PR
 vSrJm7T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Sat, 4 Aug 2018, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > Currently, this test case throws an assertion:
> >
> > 	Assertion failed!
> >
> > 	Program: git.exe
> > 	File: line-log.c, Line 71
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t4211-line-log.sh | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> 
> Thanks for finding and demonstrating it.

You're welcome.

> Can you say more about what is going on in the test case?

Certainly. I considered writing more into the commit message, but all my
attempts were really repeating what the test case does, and were therefore
poor commit message material.

Under certain circumstances, multiple ranges specified for the line-log
were adjusted incorrectly, leading to violation of assumptions as well as
to segmentation faults. This test case demonstrates this.

> Alternatively, could it be squashed in with the patch that fixes it?

There is this really awful trend on this mailing list to suggest
conflating the demonstration of a bug with the bug fix.

It is really, really important to realize how valuable it is to have the
regression test as an individual patch that can be used to verify that
there is a bug, to pinpoint where it was introduced, to test alternative
fixes, to keep records separate, and I could go on and on and on. Please
do not ignore these very good reasons, and please refrain from
recommending such conflation in the future.

> The below will be more nitpicky:
> 
> [...]
> > --- a/t/t4211-line-log.sh
> > +++ b/t/t4211-line-log.sh
> > @@ -115,4 +115,21 @@ test_expect_success 'range_set_union' '
> >  	git log $(for x in $(test_seq 200); do echo -L $((2*x)),+1:c.c; done)
> >  '
> >  
> > +q_to_lf () {
> > +	tr Q '\012'
> > +}
> > +
> > +test_expect_failure 'close to overlapping ranges' '
> > +	test_seq 5 >a1.c &&
> > +	git add a1.c &&
> > +	git commit -m "5 lines" a1.c &&
> 
> It would be nice to use test_tick or test_commit for a more realistic
> history (with time marching forward).

As far as this test is concerned, that realism is not necessary, and comes
at the cost of readability.

> > +	sed s/3/3QaQb/ <a1.c | q_to_lf >tmp &&
> > +	mv tmp a1.c &&
> > +	git commit -m "2 more lines" a1.c &&
> 
> It's probably just me, but the bit with Q makes it hard for me to
> follow.  Maybe there's a simpler way?

Maybe. I did not find it, else I would have used it.

> "sed -e '3aa' -e '3ab'" works here, but I don't know how portable it
> is.

My experience with BSD sed and the `a` command made me highly suspicious,
that's why I did not go down that route.

Besides, that `sed` invocation does not really look intuitive either.

> I'd be more tempted to do
> 
> 	test_write_lines 1 2 3 4 5 >a1.c &&
> 	...
> 
> 	test_write_lines 1 2 3 a b 4 5 >a1.c &&
> 	...
> 
> 	test_write_lines 1 2 3 a b c 4 5 >a1.c &&
> 	...
> 
> which is concise and has obvious behavior.

That works for me!

Ciao,
Dscho
