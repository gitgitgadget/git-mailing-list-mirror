Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61FCC43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14DF610F9
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbhIBOUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:20:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:40985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345479AbhIBOUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630592312;
        bh=hGZLVWr5vqp1cgMESK+6MnHbKJqYGTrm8Es1ePry5j4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FArYAQl/E12/IiH7M6PH17QTHgksBF1aHen8fvF72xuiL1RENt4OFyxliFjbfzwnq
         kAYYs1MEicWSj2XCv9EFDpYRMBuGoUNe1YFz/jZ9x6vLPHAsgaS7S5U4qS4etQS4GX
         M2vhhk5UMK465e0PRluA6qgO1z96U95mC4cS6WJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1mUpyL02oz-00QhwK; Thu, 02
 Sep 2021 16:18:32 +0200
Date:   Thu, 2 Sep 2021 16:18:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
In-Reply-To: <xmqqk0k0ndbq.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DHlpUHfDUpY3jy3KJQsycIcXdCduzYhVT/F/oW1irZtWWLNNWmm
 mzhABv0EpEGqpLsNOC2SHdclGf2OFGhqFwKluuZmKkEq7eeQniQ6JqRAkB5/UWwDcC8C8kN
 Y8E7Br6CjUZsW1hIxmE7bG8tYPIMNs30dCWJW+3lrau757brVOvHlIqEnHGJwC+TinxTBbV
 10hMONTSVIdbOPfPN72uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+XhsyRmORY=:wvESkSQLn6EO5CCxnh4ksz
 3+F4uFSY5NGO4HJqck/stjjav1s6q6TiqR3NV9Ycaf7Lj8sBnxsnCDoDsi+/ulO0lK9EntsAL
 aKF5lqMezA/mMh4DP3o+qg4x1Yp+Xy68754pZ2sZE7JGIkhxsSmcog7cPHgcwBnho3FhLf+qZ
 ZiLc/9ptjt722WmfUiFO7/gPmVT0M7M2gVxjmg6c7IUgK8uihrKBLotmq4Wq5sFxcYNkp0gRK
 hJPUUKbCiY55mDXcIBBG140LSvvOKWqNJXXrmmbDNd2MMnSjPF+y1+nVJS/2JMQurzQEtE7C+
 5/qiRXmS/PO7T4exiRCiyJ3hY9cBUoKtv17GlDrBVxa96l24Gb/nBRkKWjnazwJqE95/E3V07
 C5KbBW2Vx+aJITVSuwqPo4/aHThitqmpoPjD4wK6urugjgkpHRUDKPFc8NzcmIWLF7+KcgWdC
 4qUvDwoSTocCP58AA0aSiW3+B92BhncDNdi/9aVZIQfufn6HP8JjrG8a6JHRnU3WWAOS2WEVw
 R8qlKH9hzOgO0vUq+w5opUfb7z+HlZfm59BrBzblDQ//OCwQRyY9fxqejn4GCqiHvnfn08i/f
 dNFGmvK0cp9R52Tu8ixkAkpMX+eOY6Wlc05Iuz6GNb4y8hOPsOt4VmHinQphInuY6bt1aFWS/
 6hyThY0XIUVtXre6mWqt1CZqtWOB3rmmr4q6rTVYBWfvKrn34A4R3x3Sy5g7Ndb8mUy/Gub7R
 pl0TWAhIK1GwLjIdPZwUdxJ2SQvdB0FteICp2ZOhi281m3B1o6/HZ4SFRtbWNBLsPic5WMqZy
 5/auGF1luzFxlVumIXLtzbGVw+Yeg6Re1Mh/1g8TbuKR8tjJwNGdr6AoaC6qjtVTRlRcdX5Zo
 EREQV/CjZxl3Dbg1Lz8Q4PQnRjE3QPsBHTLMs6T+4HotlEN487e0ur4PW5IuVEaYfUz6iZh83
 wot6dWf9cUtJWRubUf8fZGKYBA/adebzJ5d1J5nouxxNTqv0j8DwK4HLjuTT6n4cmJX7+rUeB
 gYldFBx2Cjwoqd5YA18y+r32Y+BtiO5u8tX7sgNhnWQf00YqPki10QM31hya1UQO/gpYJTeL0
 y7rb7tMqEclq74BsWDdjmFTyQ7ux5yeLH12gnbOzUPL9z56Qd/S3nyi/g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Sep 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (whic=
h was
> > included in v2.22.0), we officially deprecated the --preserve-merges
> > backend. Over two years later, it is time to drop that backend, and he=
re is
> > a patch series that does just that.
>
> A good goal.  There is no remaining use case where (a fictitious and
> properly working version of) "--preserve-merges" option cannot be
> replaced by "--rebase-merges", is it?  I somehow had a feeling that
> the other Johannes (sorry if it weren't you, j6t) had cases that the
> former worked better, but perhaps I am mis-remembering things.

I think that I managed to address whatever concerns there were about the
`--rebase-merges` backend in the meantime.

To be honest, I developed one (minor) concern in the meantime... Should we
maybe try to be nicer to our users and keep handling the
`--preserve-merges` option by explicitly erroring out with the suggestion
to use `--rebase-merges` instead? Not everybody reads release notes, after
all. In fact, it is my experience that preciously few users have the time
to even skim release notes...

Ciao,
Dscho
