Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E49D207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbcJELqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:46:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:53426 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbcJELqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:46:19 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0Kp7-1b27rV29iH-00udtb; Wed, 05 Oct 2016 13:46:04
 +0200
Date:   Wed, 5 Oct 2016 13:46:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 04/25] sequencer: future-proof
 remove_sequencer_state()
In-Reply-To: <xmqqinu028tx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051342490.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <d6b92cd7aa56ceb515c50467a0e6030401e2e1bc.1473590966.git.johannes.schindelin@gmx.de> <xmqqinu028tx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ap6QXZ4s5arnRbDv2gfkAWL+hIcbq4wapfspVs1s09xXgFElHD4
 1nwXb5fYzzfb7UdGm9fq9hr3mIWL5kbqtsM6eSCJe7CPl5GOCkGv/o/1f4bgmP0pVVwes4X
 Wn9yU7wucNip93bAiIHzr67rhUP/vR4GzB467tfH7Z7wCwFT50Qd3DGrGHPgZr2CXWYfyry
 QVhprjlYHe0OYm22XHWng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cvNo6asQgQw=:r+c6tv+CSvWrQirh86UvQV
 1xEb4j4Vr0invDbvHfbYABjsAJUXW7i1A5VTHfqgfvihTQivVds1HzrgBhb09jZfHdFPmRT2f
 hJtTlw/017NXgDlmiFJfW6qoSRTkn/0CEekLVa/T3t5qF+AXpwvpBOabdBp6cIowlM0oXH4l/
 4qT4FnubvvJoHKiczEGhLArKkN+21BzL7pfdOCBMbGRNhyM5N0K2nBhUojXkmFGaYxtpARb1X
 PtXNoetL2BGBwFl6BRsKQcltdQE+avVF65xTpC/tNtIFCHBufKmDFTfogZ3865iYzHDjVEDuv
 kBxmVl+RO8pOMKV/8CfdbtLKxCJJGm7nla3Cph+fzJuTIuzHDxa9E07SThqv+9lg8ZnkLlOK3
 BLs8mJaNqwF9krWHYpGghIFh08+iqkSNUzDQadntywei8MpwhZsimWFfM3lZp236HVxM8RqUO
 cNrg5BV6AX1FtHV4Edsys0qkSz/G2nXOZcdFuUSZHXgLdoUZF+6Jnxiwnv5p7sFmv5TOj5MzS
 qxKUbgdzlcv717m795vBYa06LBV/aQrC+mf7+vG2Ws/UAgIkQMgM20CuREXNUlDcrCHhi1ek2
 uGMn44yuKbVdXH44+2SuA7wZfe68qrPzngz74KWw82viJVlwtsFT2PTsk7cchMnskJasI4QXk
 1GEGojZOPteDx8cIA+H0AOOJuIsfkAKR7MmApSK2I7xDbMgyGELGL+Y0vaJQZYOkiqzMOw7xq
 cic+5V++tZ+PC0XBJmiNA5zdx6g1wxdA7wCMHumA+ojaU/LJhDREhNPxn/DgmmiEBtMb8nLSt
 my5rhuy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +static const char *get_dir(const struct replay_opts *opts)
> > +{
> > +	return git_path_seq_dir();
> > +}
> 
> Presumably this is what "In a couple of commits" meant, i.e. opts
> will be used soonish.

Exactly. The sequencer code was taught to use a state directory different
from rebase -i's (even if it quite clearly imitated rebase -i's approach),
to allow for rebase -i to run at the same time as the sequencer (by
calling it via cherry-pick).

So we need to be able to use different seq_dir locations, depending on the
mode we are running in.

I briefly considered consolidating them and using .git/rebase-merge/ as
state directory also for cherry-pick/revert, but that would cause
problems: I am surely not the only user who cherry-picks commits manually
while running interactive rebases.

Ciao,
Dscho
