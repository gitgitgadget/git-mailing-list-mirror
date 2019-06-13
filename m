Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DFA1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfFMQeD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:34:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:60261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbfFMHyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 03:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560412445;
        bh=83uPizdRhb4SjRMBYdaJMZdjMQZO86x+H5LPDNsbYfY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bFIZTOf7Zt3GvIvW2g7a5pOAZJ5wrl2oe/31Bzgmbk0MsfjBIPGaD7ac4avOKkgUN
         WejeD1T7vPTz3d1olgBDHUW9l4wtWqmRlF0wP3pTOsBD8fdm/w6lEXx3TyfKAdvG6W
         /wqOGWn1+MpLqiLa4k9zWG42BWXR4B3dm4WO93aM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkzph-1iC2oq07QT-00apdi; Thu, 13
 Jun 2019 09:54:05 +0200
Date:   Thu, 13 Jun 2019 09:54:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
In-Reply-To: <20190612194106.GJ4012@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906130952360.42@tvgsbejvaqbjf.bet>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <20190611130320.18499-1-szeder.dev@gmail.com> <20190611130320.18499-4-szeder.dev@gmail.com> <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com> <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva> <20190612194106.GJ4012@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-490432158-1560412453=:42"
X-Provags-ID: V03:K1:2j23Sa5T5HF9gDrbeTw35CFXveqmOkzPTkb4Kw6p5OwIYzGtqoQ
 H1f1Q7MvKg55y4GGKLIB0U+J0fW80Sf4+O9skoNK7NtQjqiNnGWEca8h1H9KOYH+WVMlUA4
 pljzNwYvBcY9QbHl1wm47s+3feTV8zzapm6jqaGoNUHuURCD/lAbzX4Q0Ozdz+MH8CgfQKZ
 iPjdwy8B5PUSSgxUGB3ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tr9zG9kDPVQ=:BjlRBBInhUfSfAxxr7a+Yy
 YDlnKBZ8yDb4d1D0At4JAHC6xU9SO5qX38fQObrneQMm5702bzsmQhflU/fep9whBzzMVkgG4
 vsVah3adZD+vOV80r0ngi8frNpcHMARSEvwdxa5Vj19+BHgV3c2aMM9sXtgGs2OsmxYnALtLa
 CKP2ris5yh8YztQEcaOm9NnTjYl6TkJznN8I/HJjcoUdaehYvWlaizB/A2e7eA8Nzd0eXpAWz
 hEaPTgeYe5nyqNFxXHxwzXaZLqSt0HODUageuJE5L1rA8KApbeJELAhEeeQLG96FQPHnQ+akB
 xnzbcdS3wEBPCFchFUmqu82PoOBQ7ptmwp24dgEcp1OLfqx+UkDprXgslMioNaOPrq3wk4EdZ
 lvSLSlrfDgzd54u8ghThZrFnSYfWZ2J0GcIY2JZkfjbBd56dWPLuB2qb+/N31ebUE7RzmUOJ1
 /bhdi0H7C2MXTPesT5U1sGWBsXt/zf/Ydgiiy8WmmqgFdFQn7qoYzuZl/2QoQQ+qdp4QrykdU
 D4urTDWB4KMLFqtxMuOrgp0mEAbUdLLpeyihAiC5PchdvBLMFHorWm8H9qSvxjDLqs/3bUZDJ
 bNF/AGumzdz4RlcM269Mrv9LWqvIIHW5PH5TTPWWbJyn9p8apV6oXrd/6XV/MsdrSt+XmWeUi
 ThOjZSmYfRhp5scLfkiinoVQC73kh3pq8blZylNg7TeLx2Juo3LVpM7BlkrtOGA0oEjIf/OvB
 z5MIuguWCx8u5a+BniSPHMJmOa44PZ5CwGeq8wWagVKxzrnA7sI5+0qyAln3wL1tysmTtuIwt
 30oDkUl5YdeYiGd1nrgjjkAVmtufDFsW5Fm/pFqFHnAGXJi3gFUdn1XEaXRYfXkj9APvLaLo4
 4RzsaO6AkNj/mNeV1dv0wZdgcbEQjXdn2MaTlNx2L32azWBoDLaodDWQXdBCl+zbvyKSx/508
 5MX+TLryz+QdaUufn3OEBfQ8XhVlGyLubcQADiS92LrrsrlVmbIFT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-490432158-1560412453=:42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 12 Jun 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
> >
> > On Tue, 11 Jun 2019, SZEDER G=C3=A1bor wrote:
> >
> > > On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> > > > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> > > >
> > > > > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuc=
cessfully rebased and updated refs/heads/missing-commit.
> > > > > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ  =
                                                                          =
    QSuccessfully rebased and updated refs/heads/missing-commit.
> > > > >  EOF
> > > >
> > > > Yuck,
> > >
> > > Oh yeah...
> > >
> > > >... but I do not see how else/better this test can be written
> > > > myself, which makes it a double-yuck X-<
> > >
> > > Perhaps hiding those spaces behind a helper variable e.g.
> > > 'dump_term_clear_line=3DQ<80-spaces>Q' and embedding that in the her=
e
> > > docs specifying the expected output in these three tests could make =
it
> > > ever so slightly less yuck...
> > >
> > > > Are we forcing out test to operate under dumb terminal mode and wi=
th
> > > > a known number of columns?
> > >
> > > 'test-lib.sh' sets TERM=3Ddumb relatively early on, and in these tes=
ts
> > > we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
> > > term_columns() defaults to 80.
> > >
> > > However, if the terminal were smart, then we would have to deal with
> > > ANSI escape suddenly popping up...
> >
> > And I fear that is *exactly* what makes
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10539&=
view=3Dms.vss-test-web.build-test-results-tab
> > fail...
>
> Isn't it a sign of a problem in that Windows test environment that
> it mistakenly believes that the terminal is smart, even though it has
> been explicitly set to dumb?

Yes, it looks like some odd decision there.

But the more important take-away from my mail is that we do not even want
those test cases to depend on the vagaries of the current progress
machinery.

Ciao,
Dscho

--8323328-490432158-1560412453=:42--
