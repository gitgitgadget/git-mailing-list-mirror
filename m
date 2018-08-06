Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09079208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 09:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeHFLmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 07:42:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:48905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeHFLmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 07:42:45 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXr3H-1fScLO3bfD-00WrI8; Mon, 06
 Aug 2018 11:34:25 +0200
Date:   Mon, 6 Aug 2018 11:34:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] rebase --exec: make it work with --rebase-merges
In-Reply-To: <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808061132420.71@tvgsbejvaqbjf.bet>
References: <pull.13.git.gitgitgadget@gmail.com> <b29c4d979f147f38bc0a4765a953a748eec0cd6d.1533318123.git.gitgitgadget@gmail.com> <xmqq1sbfxq1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9CDeMsLgiOjRK2aUmmPDY6NEftzsM+gpSTGOk48IWVmp3KbIk1r
 m1EpUXlqk2awRF8M8UX3lbOL1g3PQGHnEVOjjpeXu49F5DgwDlHizOB0jYFY/aI+v3dgAK7
 VRPu8msP7qSFiIO1A0FeDNycoVhi2fPu9il1jhmtSTvtKXFjHDE6ioA3ZN8nHm8EKFlqq8v
 rCOKQEyElfBVyhke47q8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OgxFGopNFmg=:HSGks3fDpJ77KZynp3YNeI
 KRL+MVEPOZBGq/pGiKMo22da1pxygCQPuc2o4L3GMa0l8bTs65jcatLNQ5iBoHpkyJnGzw1uU
 Wk13QxlyzkELo4x3qOH7rPfQ6mSTlPojsZNHfD+qS1JLybK23P0uQIYWvnM4rFaqRwVwdkn6s
 HJQ/mFT9zy9l8nhsZvhkoejoh+l5CZjnz2fGPqXx6ZSO/3clmJVteVi4zza2/iQJ11qiBt9f/
 y55HqWpXBEMd3Ca5jYW9MBLtt+yQ8K+7L+NhRV9g74bPXq4zeUsEk0ZCWNkRlGUewHjC/ec2t
 XUU4bD9Js3DGdL5LQLeASeUXdiQL6frDtNWVQTeUHDUVXTqQIi8256QYMTCxhXFbxnFgw/XjN
 +PWdlz1Tj2z6dxB8+73Sw7yYHIi9cOg1YE6tGmCCsyT/ZOtcdjflnXGPQpQ3Ttg+gx+qXOIiB
 kU4Rr9ov01UKLQws09SYqTsPdFBtwFfNAcl5nFkqhRl3q4sPY3KqDRkyCrhuE1OffpGcm9lsK
 wdzresuhLOsWPh6Rwj0+xPBzfBlPOQ49uP2EEoU0j062LZON0OBYSMKaA8JB3eHTi3l0Tqjau
 4CFgI/6VmoQU3SqEKWaZwxVFQXsQwKI1Ce6/1poB45cngEIgvWHenQa+8mfD911y58TVr1Iqe
 3e+zWY+g6DQwIuy9Mo+pSvwX7DwwLWTUxiuE1BfUnagu4YsnQrhi4xX85xoPcZqdsWPB/60n3
 hYYkyXoMr9qVCnhaAPUqKzf/xq/AOOYm1o2xvq/ij44oouRXu/yrJ81kiRjT3FWiGitxmfwqE
 BnviJUu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Aug 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The idea of `--exec` is to append an `exec` call after each `pick`.
> >
> > Since the introduction of fixup!/squash! commits, this idea was extended
> > to apply to "pick, possibly followed by a fixup/squash chain", i.e. an
> > exec would not be inserted between a `pick` and any of its corresponding
> > `fixup` or `squash` lines.
> >
> > The current implementation uses a dirty trick to achieve that: it
> > assumes that there are only pick/fixup/squash commands, and then
> > *inserts* the `exec` lines before any `pick` but the first, and appends
> > a final one.
> 
> Ahh, it may be "dirty" but "clever" ;-) As there is no way to say
> "add exec after only the third one", inserting before 'pick',
> assuming the lines before that would be a "previous group" that
> began with a pick and then possibly its amending operations, was
> sufficient.  Makes sense.

Yes, it was clever. It is the kind of clever that causes regressions when
new features are introduced that were not anticipated by the cleverness.

Ciao,
Dscho
