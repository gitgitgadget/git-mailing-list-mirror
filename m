Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B001F453
	for <e@80x24.org>; Fri,  3 May 2019 09:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfECJWH (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:22:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:38599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECJWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556875318;
        bh=dELPYQz8ohICPku5S/89mb28k6xMJuatJBqWCAd69Vc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AEuDx92P3O9QLZayMbFMXN/NwmcuJ4aCVg3ACnGBTwnmAeFZQyEbBeA1lSTJmKVyZ
         Gm6K93ufL9e+OsObcxbb5r1c1EAXSGLHGRHnAcxF6Sy+dbbYxRYLXuwYo3Yhvd5C/I
         7jeoaK+/X20CvC/OhlLTXFN9JcI/a12MUF0dAPIY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1gibfU2e5m-015nBk; Fri, 03
 May 2019 11:21:58 +0200
Date:   Fri, 3 May 2019 11:21:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
In-Reply-To: <4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905031117500.45@tvgsbejvaqbjf.bet>
References: <20190426103212.8097-1-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet> <a3d5dd8c-12a6-a1d8-a41f-ef75c15df024@gmail.com> <nycvar.QRO.7.76.6.1904301848510.45@tvgsbejvaqbjf.bet>
 <4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8gsTL7BHWIpC1cGtflY8AwZtNUgeVodZd++Y3xdRT5xRPudRpn7
 k0UqKs0gmjl5h3nJFFz39zi7noGbvQsmhYAzZw4eT3rQgfS5FgApVm8otp0b7xES6SR39uh
 n1ifbV/Tw0so3wUwWWfu9fekLf3vxP7YTTOGq1gWl1IutAdWXf4l26/MfqpdA6h/ySmLGjR
 dtnt9AjKNnZnWlC/4t75A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AgwOM5Rv+4U=:f1ptKjaRgQlcy0JkIb2oNq
 RpGnTHltggFdOwdhYvudG2qIiFxUHnYhSb9Uqsh2/tYryU6kRje/NMvzOpf2ku1ahZRhcPgOR
 bamd/AZJSxFX8wlPbwEnxMarJdVdlFl9ZkOQPVxyWV5XZmHj922URBWGSA4fMp/A3HXzfEReZ
 U69NGU6yAG7vnrvPrqPPGBjGPuK7AtDvCgGF7Aus48rMnnEGZkQw/o8Wc3bBrAKVuAZiCop8x
 g7XqPcpksX26q61My7qxKHbHAtPsymwcrew7FrF1LjZ7q6POeHqGRbNmgs2xPnfZH2vDXqdt5
 2JVKKfsM1DmdAxo8Akg0P6ZBLEU9Msr0OLGFBKTyf4m/Wd4F1LxebrDnPMAXoZsQm329j9s3n
 XVfipzBlhFg9JZuvyUuXSYaanxx4eQz2p5k08pZKYtrRZJYX52e73YMury36yI4P9j/i2+07x
 aedjuzI4257fqOZge5iXNm17fiOYfdzO4hdw9RVlxRIRu+oH3S8BvFM6g0k9mxAcvjUMiNhWP
 raKSHkxmeojzPG0qcdT2Mb8ET3kml3KqrsjN/YCbq/rQv61Nydh/+2z3GeOfIrZU//UA2Bqoi
 Ii7tsyFaLLENMdt6TKAdsJK564PBXafKGBeg5P+iJMFi1iWFnC2x5YjMm3TKqFA1HxJent1XU
 V5/fZLqcq/8crHIrYhpe4+Lvu1F0fmo6mjmckPQvLel8G+zp1zdQ9Auc3rgrnLCudVWvh+b8R
 Q/tOBQgC/N3z4psTCusGLOLh1UwPC2eu+VQwAaLKpJ4RKf2GEZJRzzxZWCHGEG77S5r42zE4E
 fRnXimAoDXvcqjJyudRrLW5yVmI/ggK7fWGwQhrEE2evI7mTEtNizUQMvpdIPAQb8FAzCIzY7
 TmEMqLyLw6jt9qhG7oAhtnmH+USSuQMDL/K6eN8tMq89eIbCdF9SpwmZsXtpcthCJrEfzI/KL
 IlqrIrZAMTw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 1 May 2019, Phillip Wood wrote:

> On 30/04/2019 23:49, Johannes Schindelin wrote:
> >
> > On Tue, 30 Apr 2019, Phillip Wood wrote:
> >
> > > On 29/04/2019 17:07, Johannes Schindelin wrote:
> > > >
> > > > On Fri, 26 Apr 2019, Phillip Wood wrote:
> > > >
> > > > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > > >
> > > > > When `rebase -r` finishes it removes any refs under refs/rewritt=
en
> > > > > that it has created. However if the rebase is aborted these refs=
 are
> > > > > not removed. This can cause problems for future rebases. For exa=
mple I
> > > > > recently wanted to merge a updated version of a topic branch int=
o an
> > > > > integration branch so ran `rebase -ir` and removed the picks and=
 label
> > > > > for the topic branch from the todo list so that
> > > > >       merge -C <old-merge> topic
> > > > > would pick up the new version of topic. Unfortunately
> > > > > refs/rewritten/topic already existed from a previous rebase that=
 had
> > > > > been aborted so the rebase just used the old topic, not the new =
one.
> > > > >
> > > > > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > > > > ---
> > > >
> > > > Makes a ton of sense, and I feel a bit embarrassed that I forgot a=
bout
> > > > that item on my TODO list. The patch looks obviously correct!
> > >
> > > Thanks, after I sent it I realized that --quit should probably clear
> > > refs/rewritten as well, so I'll re-roll with that added. (One could =
argue
> > > that
> > > a user might want them after quitting the rebase but there is no way=
 to
> > > clean
> > > them up safely once we've deleted the state files and I suspect most=
 users
> > > would be suprised if they were left laying around)
> >
> > I am not so sure. `--quit` is essentially all about "leave the state
> > as-is, but still abort the rebase".
>
> I think it depends on what you mean by "state" `--quit` is about removin=
g
> state specific to rebases while preserving HEAD, the index and worktree.

I guess the fault is mine for bleeding out internal rebase state into the
refs namespace.

While I cannot really imagine any harm from this patch in practice, it is
slightly worrisome that deleting refs also deletes their reflogs, which
makes it an unrecoverable problem *iff* any user runs into trouble with
this.

Ciao,
Dscho
