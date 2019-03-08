Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643C420248
	for <e@80x24.org>; Fri,  8 Mar 2019 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCHUs3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 15:48:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:56469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfCHUs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 15:48:28 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZG7-1hSS1K3LXf-00RFde; Fri, 08
 Mar 2019 21:48:18 +0100
Date:   Fri, 8 Mar 2019 21:48:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Daniel Ferreira via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v5 02/10] add--helper: create builtin helper for interactive
 add
In-Reply-To: <xmqqzhqpt483.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903082138350.41@tvgsbejvaqbjf.bet>
References: <pull.103.v4.git.gitgitgadget@gmail.com>        <pull.103.v5.git.gitgitgadget@gmail.com>        <304c3863b123e08536412019e881967bf01dc4a4.1550662887.git.gitgitgadget@gmail.com> <xmqqzhqpt483.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z5PjId5VF01Jz4BVxzTAX2BxtJTJVMMPAFyyVLNhxcvmcIt5ah1
 qrDh4pX9zlFCcezFFvWhN/NQv6Cem2INaD3Pna2oosIh7ocKA24xu96oFPH9PbEBnMHREPX
 gvxJ0tS5HeelQEWLKnW5zRLfYmvy0bXAQgzFzJ8oAGSvt2vrYPIreht46Xgnt2v+iZZz7UF
 rr+3R4S37qyt6203LwTlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sd44TpsPjIA=:vs4CxN+898REHiQENujLEz
 YM4p53NPGEBFa6+lhslWPyed9qw43o9mdFMxuvRmdIF5Ohy3icnPrT+o2OqvtDQFLobBCtuMr
 AS85xwnvJcqg1NMwLwo57CwS66NZzMab88vZZBnsA3jRMf5oSvGzPlbRjzleUQdgwyc+w8O93
 Hr1fEnQER9CfGUxE3JPosOq3Q8JlkZ9VT8DEx6estrM5fSzPBjgA45YSOPfnMfKQHFDeXYOaK
 M8kRpjhjZFKpRp9TW9VJHrcYwPTe06vbqKug5SAXpriMdn0qXkVc4REwZItrLxTxAVjueJ+6l
 9cc8SuG7Jj9zw8hxYEinOmVAp/HENkGHMfkgd91kPIDr7xuiwpFEpl1JihDRgDDJeyPVac/bG
 9DAg2nvY5U8w84rcMVt8MjQuf4dtbPBAYZO0jM9jcPmaxBN/jdME+LxIvLG596MGB3DDivMvT
 Zfhvf992RR92K3l9syh3wZY0T/nUbzT0irHVqn3N+uJ0qwCkOwFh4Htj2qR96ZdxJRC56g2jN
 Tw+CIsTeT2naOP53BwaryCFYRvQeeYDPKo2BSnmYJwQONBpZNb63dryYgnq/lHKcAJR1FSxxu
 O3YAA6Uoh+3puNZBIU+Rk8sObEOkpe+x5/qET/Xt/RJpEIFk4Hx4iU7l+i1Y5h5CpskuPudv+
 XHXUTOf4sjV5S6J3Ey3KxyPlmm3hlek9NN8mxNXQweTMJN7XpLtY+mFX4JXOKXAOYaw8uoq1V
 n/Ig4NyMIONMp3f5fOmhRST3X9HXJPHrHX6Guj1KWZdqAXsIsddqfYui2oQ13tO9hYu089Dq0
 5NrCDIeriGdftFWO+xsWwtX9CR4EA2v1lxNjGo6A1zGRmu40ECRBZobRYs9xq+0dDapJAvuMu
 baLNlKnBlfVfrTOQeNJ5JyKxz7qJIWix5p0bQVToGigcejDWzQjSQ2DH6BF6MT5YUD/pUAEhz
 aBN7nWJcWBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Feb 2019, Junio C Hamano wrote:

> "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/git.c b/git.c
> > index 2dd588674f..cb42591f37 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -444,6 +444,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
> >  
> >  static struct cmd_struct commands[] = {
> >  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> > +	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
> >  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
> 
> When adding a more complex replacement command we often cannot write
> RUN_SETUP nor NEED_WORK_TREE here and instead do the job ourselves
> in cmd_ourcommand() the hard way.  But because this one is only for
> helping "add -i", we can let the git.c::run_builtin() aka "git
> potty" do the hard part, which is very nice.

Sadly, I ran into a quite curious (and seemingly equally insurmountable)
problem with this approach: when I use `system()` to execute a Git
built-in from the Perl script, and when that built-in then consumes even a
single byte of stdin, that file descriptor gets closed in the Perl
process, and no amount of file descriptor duplication and redirecting that
I could come up helped. After calling the built-in helper to run, say, the
`update` command, the main interactive add process always exited on me due
to EOF on stdin, and I could not make it work.

To be sure, this happens only with MSYS2's Perl. If I try the same on
Linux (WSL, really), everything works Just Fine.

So my current approach is actually the other way round: I started
implementing the main loop in C, and implemented all commands except for
`patch` so far, and I think I will just hand off to the Perl script for
that command for now.

Unfortunately that means that my current state looks already quite a bit
different than what you reviewed. My hope is, however, that it will make
for a nice "story" once I have a version to show that I think could be
applied as-is.

Ciao,
Dscho
