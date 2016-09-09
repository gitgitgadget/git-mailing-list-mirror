Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F241F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbcIIKJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:09:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:58512 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbcIIKJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:09:34 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmeGF-1b8gsd2crb-00aDEr; Fri, 09 Sep 2016 12:09:20
 +0200
Date:   Fri, 9 Sep 2016 12:09:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <20160908080035.czwn5y3re5bp5vkg@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091158550.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com> <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net> <alpine.DEB.2.20.1609061521410.129229@virtualbox> <20160906182942.s2mlge2vg65f5sy4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1609080921030.129229@virtualbox> <20160908080035.czwn5y3re5bp5vkg@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-875689667-1473415760=:129229"
X-Provags-ID: V03:K0:0ww4nVF6OyIdaxUJUf6PORcLOUzXFbsIqoKzrudhYV6Qdf8Q9Cs
 ZaA17ZXOauDdDW4JHls08oQZjj3yAiciCW1z2vWuCbf5+1di0SzeNovz+Bnz8jF7eHSy0/0
 +Kvkzww48wLB0J+Z3Zrr8W2HrF7cFiXKidEwKHZJemitJ4wG5SSaPijnubMdTH4P9G21GxX
 IYkpKzYqhwsifnUzsfsRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:egtSRC7nW5E=:fRihLs+D6XSLlcBH1k0uEe
 YgZPomyRjgNdXjgjHhi3sVXVgT/qHXS4L+cnDMWvXlTpwH6w9M2QKK8GT08Il2xROsqEFldxb
 vJdR4pMB39rrxtCKEcir+nHUAQl10zm89cPToo2pMSTRMGVmlLy3L7Ysgnzv4VZnsbmeEJmUK
 M9etow3+ye7F8KvGj9G60Vt4zH2fspcvgqhEU18uwTE+ykxYjMhr4iLMxx3HK3JIufpAJbDRa
 Q+XhlMm/WAlQHcO946SEzRjXr2O0ExjuYM2NdzKRKl8TzVkw+8Op/KMAwtQaJtRvchJvd4/hF
 MQF4UfR23tagxsu9MRICO0d+DEMKJjt4u3l4OyKL34jk+X1CKVt/5xCd0VuCqm+gx+UqlElcT
 5XuNJ52DT25fcihg5ehjcOs6/P+YJjTCWg/rw0RUdvI+pc1EEP9VtpPVixOr5RRDiG/F6rtPM
 6kGxNtuACziLADY91X8oMAZrVj61CSMrELqvYU96A3bmgoeYK9ucH51n5L9Kgb0dOpvbzu7TN
 fRd85ZqG58x8jtNAkx57Qb2Fb3QpmnppDBn2nlMYUrVx9haUGNHu1yuUSnRMHyy87IncXkMBp
 Cwnx7lQc1X3JM395KFwhe/E6VgLG22zbwnOZcQOI88ymTaMiyahq3cm06dRxi4REenbpCmETG
 2o150JC+57E9HzrYFMdSZlR6e+T8RRE1MphnyLFvaiW9KKR7SJah3Fq93N3U8vsfXYR62ndFE
 stsEF2rp//DVWEapZ+h5PnTQ2DhwbqlBoyQIKYjNRm1e20IslnnAou4OyUFJj66hb51GPlnIn
 r1qo7PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-875689667-1473415760=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Thu, 8 Sep 2016, Jeff King wrote:

> On Thu, Sep 08, 2016 at 09:29:58AM +0200, Johannes Schindelin wrote:
>=20
> > sorry for the late answer, I was really busy trying to come up with a n=
ew
> > and improved version of the patch series, and while hunting a bug I
> > introduced got bogged down with other tasks.
>=20
> No problem. I am not in a hurry.

I kind of am. The second half of September, I won't be able to do much of
anything Git-related, and this is a major bug that blocks some important
work.

So I kind of have to press on that front.

> I think I'd rather just have:
>=20
>   #ifndef REG_STARTEND
>   #error "Your regex library sucks. Compile with NO_REGEX=3DNeedsStartEnd=
"
>   #endif

Done. Although I permitted myself to reword this a little ;-)

> One other question about REG_STARTEND is: what does it do with NULs
> inside the buffer? Certainly glibc (and our compat/regex) treat it as a
> buffer with a particular length and ignore embedded NULs, as we want.
> But the NetBSD documentation says only:
>=20
>      REG_STARTEND   The string is considered to start at string +
> =09=09    pmatch[0].rm_so and to have a terminating NUL
> =09=09    located at string + pmatch[0].rm_eo (there need not
> =09=09    actually be a NUL at that location),=20
>=20
> Besides avoiding a segfault, one of the benefits of regcomp_buf() is
> that we will now find pickaxe-regex strings inside mixed binary/text
> files. But it's not clear to me that NetBSD's implementation does this.
>=20
> I guess we can assume it is fine (it is certainly no _worse_ than the
> current behavior), and if people's platforms do not handle it, they can
> build with NO_REGEX.

Ren=C3=A9 mentioned in f96e567 (grep: use REG_STARTEND for all matching if
available, 2010-05-22) something along the lines of REG_STARTEND being
able to parse beyond NULs. My interpretation of NetBSD's documentation
agrees with your interpretation, though, that the buffers are still
thought of as being NUL-terminated, even if rm_eo makes the code *not*
look at that particular NUL.

Be that as it may: it is completely outside the purpose of my patch series
to take care of making it possible for Git's regex functions to match
buffers with embedded NULs. The only purpose of my patch series is to fix
the crash that was reported to me due to regexec() reading past a mmap()ed
buffer. I already let myself being talked into fixing more things than
that, and I have to leave it at that.

Ciao,
Dscho

--8323329-875689667-1473415760=:129229--
