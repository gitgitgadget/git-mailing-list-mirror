Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6096C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B720674
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 11:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lXSxp33/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgATLPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:15:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:46033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgATLPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 06:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579518902;
        bh=Vi0AoLX8z4fOlJer4cVGm36auls47jtxH/nUAIZ5Yfw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lXSxp33/7KqS0GFO6CJOI5JvsGD8FU+yjaRRSwODKRkrskglkxjD55ppiDdSwRqV+
         ZOuhBhcXJgtE91K5sy88tOuRhFH3s+bE8qVMiFIyT3ZhAa0C+Q/G1W+LMiic+trV+j
         ZXjcGFxZH0v1Ty4xURgEgLZVnfqm300QIbZhpIks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1jWhS03cTB-00e5Fb; Mon, 20
 Jan 2020 12:15:01 +0100
Date:   Mon, 20 Jan 2020 12:15:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
In-Reply-To: <cdada301-b521-78b4-badc-192af2fa3d08@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001201214260.46@tvgsbejvaqbjf.bet>
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com> <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com> <nycvar.QRO.7.76.6.2001121936290.46@tvgsbejvaqbjf.bet> <cdada301-b521-78b4-badc-192af2fa3d08@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:akC5p1ZB42CMi5Z0VtojPS/1hxtDUIYLbH5yb2Q13Z6NjV2na8Y
 O7NJEc+FAoKUik5r46rZYgnziVXjRIDnVpKUJv+QkJTrxhdKW4zjgdUh57A7DkDUxCxPVnX
 BqBU9k3fgoyOFc6Ue1i4zNfjxc5oPcgMS2hkI1SEt0gTVw30vF9LuUINClWzJt8hhdDViAB
 Qdv3jEvSuo8j6cUVzoZ4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cu+QWjJpsrM=:pZowoCbanDrcIfU+RWR5fm
 cN7BruF3JvBMzev95A8djeMjlxpjtRSiyL2VBRa40R+NGZ9DYg456Ce/WNQdZ8+n7IdvL1nKd
 no1vne5a40DTL4sTJ3bVNjwNYxdbF52DAFRZHOwxPnzXobYPzv/c2BBgLq66bkEBLqlVmHhaa
 KUn52hKvwyFUoKDBkfVqFEiyH3OvwagQegf2ukAlANt5Wi3dlzBp4V/OvklHqGiXSn4Rqx+wn
 47dc42PQKdFBLZzMmtxB7r9Lf93PZITPz5xKhGSByD8q3gxHp6ay4KWTOv9lFJak31eRaj5Z9
 eRpHCzFupoz5V9to/kPbqy7WE+6wGAPm7vb/uzn+Qc3LjNbMAudcHskn6PPkg8A3qi3Lopi1R
 sUEjv3COlhkQNT1l2eMMk/B6dmldKVH6P6bXvjC4AsLEcVF6XHjzYUVsTGpkKA+c6r2xWdds0
 QEbD2IPWDRaY9GwKV9jKScvVmuiEXp+NpSbNe+i+GNd92nsr4Y7nBHfMfCMFxaSvqSkWrzkCN
 SO/hthxLWuMlyFcLBfVWOO9w65433x5lKg1NWZNtrTR1LYUONAnEZ+P4kTHDbU9fMOlgLhJuG
 uMzLbsFxxTwzkW5GJs4nu5CX7SIHB7ot0UCYZpXid1sxMjXfbc1vRlkqFNZ6Doulz0HFxAbXL
 dt9FGkbNODhmFMXtN1qQnpEuh8FDUl+ajwIQrAfiHC/Wvud22L7nnxewVXktnGxeLwLvyIsjE
 llcGBRWWrKeztfkzMn3hpg2v373ZUrILoRpUp5H9PdOofBFNTY/4CaEgLgFAbZBRPirvZ8zRV
 jPLNmMoYB1xMxdvXhJMnvPi1SX6U4i2n7AVxU3sFqvAC+wguTkwEjrK4aVlcsMTtc/FR8p9Hf
 ir1LNrzKqXcwaEhrlE43xWBEcPixbWacxB8/fqC5/BlXTPlT6Dv1MRnqfqKUGHjFmSLGIGRZT
 +fwzpBPgNCX3yP3usf9x4DmLUpKpYi9hu2BPPJ4abc2b9XuWiBcn8V2Uaad9ra8OpP09Pxh3V
 sWnKKej3Ll0YoxCF0Epza7eeN+mR4BCWKKAdQ80ToTdOlwcratCTwwZ3c9Q8yjggOiQtD8J/h
 JfhM0g4DjqiHTNHjPsfbbysx2Wi/ko9/um5e4tvg6JDrVknfKJI4iSwkHq0WmtfSjYRTCb/Q3
 HqhG0/sj868L8Ol8pElvRNVKkkdeir2UDfx5BSR3C0vBy2ULdonuFdLgUXBP7v6tZcTSR4UZz
 2Sm1by0jK7+70dh4H0OVcPJnQ7e9Os3CHyuEIdToYsf4ywV0yn92cKzFeND8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 17 Jan 2020, Phillip Wood wrote:

> On 12/01/2020 18:41, Johannes Schindelin wrote:
> >
> > On Sun, 12 Jan 2020, Phillip Wood wrote:
> >
> > > On 12/01/2020 16:12, Phillip Wood wrote:
> > > > I'm concerned that there are some bugs in this series and think it
> > > > may be best to revert it before releasing 2.25.0. Jonathan Nieder
> > > > posted a bug report on Friday [1] which I think is caused by this
> > > > series. While trying to reproduce Jonathan's bug I came up with
> > > > the test below which fails, but not in the same way.
> >
> > Thank you so much for your thoughts and your work on this. For what
> > it's worth, I totally agree with your assessment and your suggestion
> > to revert those patches _before_ releasing v2.25.0. (I seem to
> > remember vaguely that there were repeated requests for better test
> > coverage and that those requests went unaddressed, so I would not be
> > surprised if there were more unfortunate surprises waiting for us.)
>
> Yes there were more surprises - when we fork `git merge`
> --committer-date-is-author-date is broken. That was tested but with a
> commit where the author date was the current time so it did not detect
> the failure.

Thanks for confirming.

> > [...]
> > > --- >8 ---
> > > diff --git a/sequencer.c b/sequencer.c
> > > index 763ccbbc45..22a38de47b 100644
> > > --- a/sequencer.c
> > > +++ b/sequencer.c
> > > @@ -988,7 +988,7 @@ static int run_git_commit(struct repository *r,
> > >                  if (!date)
> > >                          return -1;
> > >
> > > -               strbuf_addf(&datebuf, "@%s", date);
> > > +               strbuf_addf(&datebuf, "%s", date);
> >
> > I have to admit that I have not analyzed the code before this hunk (it
> > would be much easier to increase the context in a non-static reviewing
> > environment, e.g. on GitHub, but the mailing list does not allow for
> > that), so I do not know just _how_ likely our `date` here is going to
> > change or remain prefixed by a `@`. Therefore, this suggestion might b=
e
> > totally stupid: `"@%s", date + (*date =3D=3D '@')`
>
> The date was read from the author-script so I think we should leave it a=
s is
> in case the user has edited it and is using a different date format. Hav=
ing
> said that I'm keen to make a bigger change to Rohit's implementation and=
 just
> get the author date out of the argv_array holding the child's environmen=
t as
> this avoids re-reading the author-script file. It has taken a bit longer=
 than
> I planned so it'll be next week before I post the fixes.

I look forward to it!
Dscho
