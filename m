Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964421F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeC3NCT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:02:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:47271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbeC3NCS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:02:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3i8r-1ekmK31wBt-00rKeU; Fri, 30
 Mar 2018 15:02:02 +0200
Date:   Fri, 30 Mar 2018 15:02:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
In-Reply-To: <20180329213823.GH2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de> <20180329213823.GH2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tN0zGOjgNRbWB7/bW/Pd+NblH2oT8o8yTVlVApSuB784qVT6p9v
 G4IYYa9+3vTAhD8KOSao6/qRxVHIKzLI1a3rK6kyObFjxqpcQ05HkGZMzJiNAq63+VPDaOp
 rR/xtmKnloc6UPla76b85U0kn3n40OSFAU9J7zDEAXBz+ALDmIioDKHZ3ABWAlNpvtb0miR
 BMYFAQDz5sUO8APSAIQCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:No/laL3Foeg=:AwS+olW35YVdLvn3CqYHK6
 c3mHNfHbXwUCP7JvsGQWH0Tr+KmpcqoGpj8bxG+I5iEnEoRNtcya4M+DzxZGUFVxQmHbyU1Vr
 o1YRuoKiDsWgCZWNBhmp6ZbigXAYJujjKplPvIbJaHeT5nszocwzO1/9KDg1PvbC+ij8TN8ts
 L0oMhfygkMogS9lgT7XEld6K8ot/fc/0/jInLBQ1OMQb79IDy3+hGQfi6jZIVwsqnXBlENLOO
 g2MBuiBKcoYtYIL40tyZWZ66SU0lVQvQA09yD95Z7oMNU3jFZU1nYtjxydWX42z6im/pRdn0M
 IZwu4OD9fkHD2B2L6oD9l2HHgMPUmp4T9EfREonVOwK9mceMbOG/becCN4V62RDa7Fg8ymUg7
 dAJ9GK47FaRKqVgtrmwyBcuIP+9/IG+aUvYNe3oe2DEXzSIPoVPFSo/jKHPi1nGiA9CDLyMZI
 nSL8VXPwHDpyKK/CwAadwSwRNUKKF+TWkM1X5SRUKGMvPxdQ8PuYv0iSV1zSQGg1ZV8fUyGOt
 Ps2Y2UVICHCBskwsqxhqKPJYxSnjEjx2vWg4sXO2mbf9l5c5artZyAYHR5DPvhwa7Fer44igf
 c0y5JTODGq4NTi19bo/Rg61F+6iRJmwkF5EjwaUbuZSr0uvWRgphMrSks08RRzlhZ8bK3p+Tv
 Zr1N9cXh089V6uWDjkPCA/VOdgvBpaxR4ioHOUQvZ53sck78XJ0Y8hvoP7q6cGm+/xm/FZ4A6
 EFg4bU8KdGrNt5glD+rtPY+d96l6XcDr8RJz1U8uNmpSisKwzhZ2hXmV8abM1KvgCC3ru6ttI
 T7F9dcgK7Dx1E3fkKBIRK4Nadpo26fVn5A1CjyQzqpmKMSDWOJQOWfG/z7VFOPqPBSzaUBh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:19:04PM +0200, Johannes Schindelin wrote:
> 
> > Technically, it is the git_config_set_multivar_in_file_gently()
> > function that we modify here (but the oneline would get too long if we
> > were that precise).
> > 
> > This change prepares the git_config_set machinery to allow reusing empty
> > sections, by using the file-local function do_config_from_file()
> > directly (whose signature can then be changed without any effect outside
> > of config.c).
> > 
> > An incidental benefit is that we avoid a level of indirection, and we
> > also avoid calling flockfile()/funlockfile() when we already know that
> > we are not operating on stdin/stdout here.
> 
> I'm not sure I understand that last paragraph. What does flockfile() have
> to do with stdin/stdout?
> 
> The point of those calls is that we're locking the FILE handle, so that
> it's safe for the lower-level config code to run getc_unlocked(), which
> is faster.
> 
> So without those, we're calling getc_unlocked() without holding the
> lock. I think it probably works in practice because we know that we're
> single-threaded, but it seems a bit sketchy.

Oops. I misunderstood the purpose of flockfile(), then. I thought it was
only about multiple users of stdin/stdout.

Will have a look whether flockfile()/funlockfile() can be moved into
do_config_from_file() instead.

Ciao,
Dscho
