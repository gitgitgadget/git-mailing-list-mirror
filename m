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
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B071F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfJHMql (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:46:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:53753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHMqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570538794;
        bh=rgi9wAwmP2Htj3CjfG1z18UtWOxIAx3hX7D5N3wQ1Qw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ye3RtWg3ZrGfDWTo4ED8bfOwg1ZalrXe1jzRe5aLrWzeI2z3PUrYG/PTKDAdF2NM1
         UTuRo/IdMBClrdIHCkaWGZNkheKPFzy18decQfxe64+Jau9aOcA16xhd1w2ZuXbNyS
         hAdskCX1U1n9lYtjq4vHCjxYDzFNuiTQaCOMXrTM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1iP0wS35g2-00Bahe; Tue, 08
 Oct 2019 14:46:34 +0200
Date:   Tue, 8 Oct 2019 14:46:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910081423250.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com> <pull.288.v3.git.gitgitgadget@gmail.com> <xmqqimp26808.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
 <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet> <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cupto7lLAGifLQ0TAv5ks62egQ8m+SqLJE+omZiYspe8k7f+Nl4
 GDqKnPcEtwpkQWcFgkIErLyJVG7eMb1PcUqO9BR+D0ZELUQUu+51iWNOUHh+ADVLVWhANh7
 6HXPhFfdSy9k6GApmlBIPesun1l7f1gK1CqJ/IBPxy181Fk+XFMaGdljNT6S1veAGS/aC1j
 EBM5LXcwUgN5d0p8YTb7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SmuKHsaQZZc=:9XSpF3LrY+p8vMKMGEAKYT
 1n6KsjTvBNa/kmO13TaC3q2S8+3/9hqVQw0ohPNsdamY4YQqQK71pA5AxkzDIJFjp/qxNycQj
 9J/LGcpf/TvnXfhNAXcSGUChF3pp/jhIr05XH1WrCDkuJN5NRaSQFMOskVVg3TA0PLG3keyKZ
 SaGaLHkCDsazfI+4F71MHCW4LAcRm8cu17Ce+NPL2ewqAFD0Xyj5aT9IQVlZhmXIRbybDAsg2
 0p09p8i/RXs3DcjNOq4ZsIoNs/ktu20FGWC3HtcKKDP2gsT1hBUf2RuutP8pP8F88dd1N2ywg
 hzitA9KafIQ+9jrNOvtOglFiq25cbRYgngjW8GbGqfSYoTUT+fHruYFVeHcqzNS9YDEo0uPH9
 tQq8J4gW2tKOgnahlOVAik6fyttFq3CkKbrpoi1ZAwHzIfwNtLFGJHeJ4Egp6rCvMjnydIKlo
 /AbdJp0nVCCarBrbJ4UTVXFryybz9xR0zwUQ+0j3rimPIincJK2J0Hv3plJTYZ5zbcfMxdod9
 zfn0ezgn+2oEc/QBAKudw476FaISjthMQzT7+2xddTw7+FKndDFRXTC3Bq2WptMtzuPj/mHYD
 qiQ1bi3o6rEJOPebF1XZRd84JO0Tfu1xINNhVqTkhQfTQ0bktJfvMxzZI8juawfBz4uvXMfwb
 qTg16iBLULiMMZYWpQnKlJGRNUs34byOvp283bf12xF5RUYFuxUKgFj1Q8k8BjuWvqGu4n24r
 reZZ6kdUkhv0J97h5T0Udm2aAc7zYOkp7QhCauuhjTYnh3+IbsBsjuc85wQRq9499flp0tzhY
 NPRJFUx14OkAlbTbQje778Lb8U/FM2cCFnkyLUhIMCeXiIPGeAA5PVD+bNztlZatGK0B3ngPc
 SxCEdWWyVZZ4AUojATDviwhBBsKppN97L8mrZQHGiHaz1zGXmgwRRev30rIkXg39ZYACz6eMu
 HDpDVfGvC2W5e8CsYINFHuTLKeB1PhoW9NvtlXrcfm4YM0LjOkDUruRIaYCK1q73I3A5qpxmk
 yQPn2fnEQYtQMeHXJPLM1HIyteEChxMgvov3Ju2y9TabfdhkH+FYuQ2u82OhLR7DsvqepLuFu
 XtQRqn1K9V3h5O7cOHDlIttOdu3iS+y8qcPn1YRWaiRwdWUcI8vDe7WbBJ4H/d5M9Bk5mCksQ
 iCwjFjM5CHYk5VOGfXW0edobOTh7dSZYLjiYphLhjGkVZFFzc12RETGoaVUfww2qPC8txMeRe
 kSOTIQcdYN/1C0uPT0Rs8hECEwO18Xfm61x3QWtwZTxx832tY/XTfxoYjN6o=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I didn't quite understand this part, though.
> >>
> >>     The default creation factor is 60 (roughly speaking, it wants 60%=
 of
> >>     the lines to match between two patches, otherwise it considers th=
e
> >>     patches to be unrelated).
> >>
> >> Would the updated creation factor used which is 95 (roughly
> >> speaking) want 95% of the lines to match between two patches?
> >>
> >> That would make the matching logic even pickier and reject more
> >> paring, so I must be reading the statement wrong X-<.
> >
> > No, I must have written the opposite of what I tried to say, is all.
>
> So, cfactor of 60 means at most 60% is allowed to differ and the
> two patches are still considered to be related, while 95 means only
> 5% needs to be common?  That would make more sense to me.

Okay, I not only wrote the opposite of what I wanted to say, I also
misremembered.

When `range-diff` tries to determine matching pairs of patches, it
builds an `(m+n)x(m+n)` cost matrix, where `m` is the number of patches
in the first commit range and `n` is the number of patches in the second
one.

Why not `m x n`? Well, that's the obvious matrix, and that's what it
starts with, essentially assigning the number of lines of the diff
between the diffs as "cost".

But then `git range-diff` extends the cost matrix to allow for _all_ of
the `m` patches to be considered deleted, and _all_ of the `n` patches
to be added. As cost, it cannot use a "diff of diffs" because there is
no second diff. So it uses the number of lines of the one diff it has,
multiplied by the creation factor interpreted as a percentage.

The naive creation factor would be 100%, which is (almost) as if we
assumed an empty diff for the missing diff. But that would make the
range-diff too eager to dismiss rewrites, as experience obviously showed
(not my experience, but Thomas Rast's, who came up with `tbdiff` after
all): the diff of diffs includes a diff header, for example.

The interpretation I offered (although I inverted what I wanted to say)
is similar in spirit to that metric (which is not actually a metric, I
believe, because I expect it to violate the triangle inequality) is
obviously inaccurate: the number of lines of the diff of diffs does not
say anything about the number of matching lines, quite to the contrary,
it correlates somewhat to the number of non-matching lines.

So a better interpretation would have been:

	The default creation factor is 60 (roughly speaking, it wants at
	most 60% of the diffs' lines to differ, otherwise it considers
	them not to be a match.

This is still inaccurate, but at least it gets the idea of the
range-diff across.

Of course, I will never be able to amend the commit message in
GitGitGadget anyway, as I have merged that PR already.

Ciao,
Dscho
