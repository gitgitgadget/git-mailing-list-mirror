Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B95C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC41661183
	for <git@archiver.kernel.org>; Sat, 29 May 2021 09:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE2J3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 05:29:47 -0400
Received: from mout.web.de ([217.72.192.78]:47885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhE2J3r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 05:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622280474;
        bh=qJ+hl4NNZC1lBh1otxujtRW+i0CUKmhm2w/VsFJ7xKQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g9AsgNIW505lfb5ZvSJeFwYDEOYoR0mpVu/dP+E1dRp9JdYgF+5lGPp1KZKYlx+ah
         xyU221vOFzI5hvIITm878WR1pu4XK2pcNkVhxC6vVUr/s181eaFfD76UCTTduWGUsg
         5ViHLNH45UZQSuuIfj9dXvfLBSzCAsQVZiiDlthI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2jWI-1lQ3rK0Kq4-0134QD; Sat, 29
 May 2021 11:27:54 +0200
Date:   Sat, 29 May 2021 11:27:52 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Yuri <yuri@rawbw.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
Message-ID: <20210529092752.kifzqt3haddzgsob@tb-raspi4>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g>
 <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
 <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
 <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:h3Kg6UEPJWzpixrvGjOROaHPGZ1dzCTdcvdKcIB3G5eIzIw11jx
 WJlyV+0nyHtJoqZiN3NAcckYarcGoDN1CjBCtautvqSP0OAKkEtQiGa6iNas8iLawLdfR+6
 LZSosF3XnNZHjfr6fDeAZobVpxfRddTJrXote8D6C+Ac70oH9RvlD5Q+cAyfqgQv6ck0pjd
 3xRPWREt3f9Giem7vYT3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6ui/5XDB7g=:PguVmKWPeSzL7w2mV1+Db7
 V2BPcgfD3eymShu3uLVVvvPcjfwZ/EoVm2nvh0nCvoZmaPmVNdU+zpYDOwvUPUC9putJT3kZz
 1XtGxedhhvo5rVZIRcFH1wOs0KL6FFVNlTbe+fDIvphiTrwoyz2RRmEGt+WEn1EGlKcAb8X5A
 Y2Lrydu19I5CmSNdnWKqspAvTwdxXWJcIUy9KOVMM0vySawbHZU6DszZblHMxPXJ/UclDPePD
 2iW0dSWI07NvyCre6x6Tfnyw15Ln0U8vehMz3hmRu5K/akjwIer7aCcdTpqgFbAMBSMz9TBM9
 spfRl7hGZZ/5a9aapfkL/ntj2Gq5Vjpv2KYF8blLvcYOdhHyNJl7ySD1dOYXrG6pBBWMwcM7M
 0/zk48rGaKdBQyibBPII4xVDaSjsTPgV+qRyjxx4AKG8Tc1QZzLT2FD3m7sGJTo9HfpF5unWe
 IctVoI+aBY69+3jtgLTWj2lby30Kd6txgnriS6fY2fI9IjZmFDRbQ/pMJW7Kz16gdecD25apw
 PBvD/L4d3ZLVBzH7dglgsgKNnjLUUNhYW1NUEil93zhyPMIXJ212mJEW0Hl9SEOk8G88r7ybZ
 AAHJanDbrG3B+vHde5PLhQFY9RsvbKDUGkNCb8ZLmdbNORTUgWze1qFbEKeA6PHY69KuVZL63
 ZTWQ97Gc2lj16WVD90sz4Nha/22JN4UWZaun6G0grYlb1xv1YXjJa4bxxi4S/Sh8skQdoD0nE
 s38ZU1KE1Ct6hzg9Rq/Zd1P6mhTiqNOXkxh0O5e2UbZCeaYvPPbW6tz+oivp0QmEoOvLINfqE
 w8JZjdcejTXRLSDNV5sCB+LW9yZdDCtTasX7tZzVopvdaDWZEsm0HEPWcI5lfhsYGmkxfQ/1Q
 cIRbPISFu2miCvnEc67j9N1pWf89+TmGku70J5klChGSo6Nl9bwgM75NjKCOF02YjP7GtHMBr
 7baQt4ga6g+LEF9/pzZzSOEuwGnnmx7tiD9Yr5IPMF4rjkaqHnXg1ukxuS36cqtU3oKWcjWv+
 V7G2vgIG+MMRBbMm3AK8KQKn1ymC8reIqlJLVpRFFuhJBnqrnQME0eDD1Yg+Z76hfFXeT7rfp
 /bUCIsXpQrF7tLcNAIG/k1GyIisAInvzBEvTkTgpiPFlWJn85jyu0g0G+3f7fU8lGZJHVbWSZ
 CnT0DZxy2MSYxBKcSBI6dWm2mTWdeGu7OqnH11n9yglOqXD4zdiMQnpwjTAPNaN+23Rnc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 09:45:53PM -0700, Yuri wrote:
> On 5/27/21 9:39 PM, Bagas Sanjaya wrote:
> > So the current default is only supports ASCII, and escape other
> > characters, right?
>
>
> It appears this way.
>

Yes, that is how it is.

After reading the wiki here:

https://wiki.gentoo.org/wiki/UTF-8

(There are many other web pages as well)

I am not sure that there is a reliable way for Git to detect, if the
terminal is capable of handling UTF-8.
This should work reliable under Linux, Windows, Mac and all the supported
Unix-ish platforms.

Beside that, the outputs of git commands can be feed into other programs
via a pipe usning  "|"  on the command line or redirectet to a file.

And what is a terminal ?
We need to consider that we run programs like `less` or `more=B4 which
need to be UTF-8 compatble.

Most of them are probably UTF-8 compliant (and LANG is set to xx.UTF-8)
these days.
And most repositories have been feed with filenames encoded in  UTF-8 as w=
ell.

Having said that, the default could be switched some day in the future.
Before that is "save", there may be a transition phase,
where users are warned that the default may change.
Scripts calling git need to use `git -c core.quotepath=3Dyes`, or no,
whatever input they expect.

Sorry for the longish answer.
Changing one thing for some users may effect hundrets, thousands or millio=
ns
of other users later, cause surprises, need debugging and fixing effort.

Does someone wants to come up with a patch that anounces a possible change=
 ?



