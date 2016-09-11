Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A31207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbcIKI0T (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 04:26:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:56800 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbcIKI0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 04:26:14 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1ar1xV1rKX-00sMgR; Sun, 11 Sep 2016 10:26:08
 +0200
Date:   Sun, 11 Sep 2016 10:26:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
In-Reply-To: <2e15ae99-59cf-7fac-517b-30b59d6d574d@gmail.com>
Message-ID: <alpine.DEB.2.20.1609111010440.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de> <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com> <alpine.DEB.2.20.1609011619220.129229@virtualbox>
 <dbc1b08c-a151-29ab-a5a2-45343ca556d6@gmail.com> <alpine.DEB.2.20.1609091639430.129229@virtualbox> <2e15ae99-59cf-7fac-517b-30b59d6d574d@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1665979214-1473582368=:129229"
X-Provags-ID: V03:K0://CrEHd7A6t2UvR/kkLj7QzhOE1LK8q6IPT3j2rBzAbjGQKuXTL
 aUf65a3ROuzrtYrA7RagZ8us2y2VxAldulkBvQB/zJqfQuZynGw6zvczUhvuy71INzX5H66
 vruYqt4F4hOTtjppu1MQD8eD3IbIgMp+GDkvZPRbr5hCAlbDCm4Umfg4lU0msyLp4moz510
 mXSHhmGDVxZGyl78usQRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mi0ITtz7uaQ=:OdWkm0YxQH383aJhhfyGkr
 8PUAvzUjgPcsZ5IEjsxI01Lbqmi+OUXTXnmaE94BFwLgG5k6Ly58EfcukwPpHogqgx8L6v5Bm
 uJ4BvBflMWKJtJlCRelIcoo3rnqOOxj7KKqXGrLWzUDNDi2o0Nx/fezVUAPjygn+qMVuFM6Os
 uCqg5EdFY837jzZ/2DN46dhSKf0u7hOqrio16lymlwyehOTZMY+icC3TXTLidqUckuiXjx07M
 JBsvIdqDKuibMNmc0itJosEL9u6A3LFiKEjdfbBMN7YTrO8OYQfBE+wH13YT2PHWPAcz2Pbla
 ddMTGnPaiBZcnAOsEynMGWuj6gwFiITL7frHxI+0pJ/vgqwTaYWHml/7JQvB8uDG0aXR+BMUd
 e2VTpHIbEY63HvSuPwNKTeBHTl3VnQKpBWOiqlEMk8P19YZXbOsIZdIpPiB1CepRYDwXiJGFC
 TkUTDrsvGiuHnb7is7OVlzUBPc+AOcrRGofSE3qT8JCqMcQKR0mMHmd532l5zWek8ye8VJbE3
 Buy7Xqe4VdAOAZzrBKvLYL0603xdkR9uVMpWuIGjYnsZKUQkz2Kkr1c6hOkESesTm/89Qeprb
 yrc4Z3UAAcKv2DUsM5CJAbQAufL/izUhlNtDEFJQDTZNrUjoEXPQ8mETwRZWicjClEJWpQw/w
 rE0gdSxW8CIisQHiPzDCl7JSANi5iaaUCF7fb1o/qB6Tl6yyZ1HptSBDnzWEsbRZ22eGtBNS6
 KUNC375ClJvOxXIOWo4mXC/hr5FaoAk1Mji5eNmSBrptNqNU7T/1YzRR33LJlQaUSX7PDthU6
 hQniRIH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1665979214-1473582368=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 9 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 09.09.2016 o 16:40, Johannes Schindelin napisa=C5=82:
> > On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:
> >> W dniu 01.09.2016 o 16:20, Johannes Schindelin pisze:
> >>> On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:=20
> >>>> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
> >>
> >>>>>  =09if (commit_lock_file(&msg_file) < 0)
> >>>>>  =09=09return error(_("Error wrapping up %s."), filename);
> >>>>
> >>>> Another "while at it"... though the one that can be safely postponed
> >>>> (well, the make message easier to understand part, not the quote
> >>>> filename part):
> >>>>
> >>>>   =09=09return error(_("Error wrapping up writing to '%s'."), filena=
me);
> >>>
> >>> As I inherited this message, I'll keep it.
> >>
> >> Well, please then add quotes while at it, at least, for consistency
> >>
> >>   =09=09return error(_("Error wrapping up '%s'."), filename);
> >=20
> > I may do that as a final patch, once all the other concerns are address=
ed.
> > I really do not want to change the error message during the conversion.
>=20
> Is not wanting to change error messages during conversion because of
> your use of Scientist tool to catch errors in conversion process?

It is more out of an aversion to mix unrelated purposes in the same patch.
You will see that I inserted an extra patch with the purpose of fixing the
style, that touches all the relevant error messages in sequencer.c.

> BTW. could you tell us what were those three regression caught by the
> cross-validation?

Sure!

The first one was that my original version of the rebase-i-extra patches
did not reorder patches correctly when there was more than one space after
the fixup!. I fixed it, and added this test:

cbcd2cb (rebase -i: we allow extra spaces after fixup!/squash!, 2016-07-07)

The second one was that `git commit --fixup` unwraps the commit subject
into one long line and rebase -i *still* manages to find the correct
commit to fix up. The test is part of the rebase-i-extra patches (and
therefore you will find this commit only in my fork):

9fc25ce (t3415: test fixup with wrapped oneline, 2016-07-24)

The third one was an obscure one: when I marked a commit as 'edit' and
there was a merge conflict cherry-picking that particular commit, rebase
--continue would squash the resolved changes *into the previous* commit,
but with the cherry-picked commit's message. It was a simple, stupid
oversight to write the "amend" file in the "edit" code path even if the
cherry-pick failed.

All fixed, of course.

Ciao,
Dscho
--8323329-1665979214-1473582368=:129229--
