Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A684420373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbdCMVql (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:46:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:55563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753491AbdCMVqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:46:40 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Me4Ly-1caxQJ2Nji-00PwSX; Mon, 13
 Mar 2017 22:46:29 +0100
Date:   Mon, 13 Mar 2017 22:46:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 10/11] setup_git_directory_gently_1(): avoid
 die()ing
In-Reply-To: <xmqqvardq66u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703132244400.3767@virtualbox>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de> <a1e24f1b31773f4d2f7f06ab7d5870e920211d51.1489098170.git.johannes.schindelin@gmx.de> <xmqqefy5yn4k.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703131826330.3767@virtualbox> <xmqqzigpq7qp.fsf@gitster.mtv.corp.google.com> <xmqqvardq66u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i7UbPV4rlqZ/7qFw7Hiqpbj9RYJs1T3MLdbDkNLIJjZ14IvPw47
 1QajU7vz+VKg0Jjk6zw7keYCBEFpHd3Lvev5o66AQ60N3Xc+ptzbu6VGeRu96pYcar1HQKa
 Qj17CsfgXSMcegoN0HdwQAFLcZrij8v32n2tkgWwYVKqEEv4uWonLrkx19ujzFdS3iFCcyb
 SCUBjTUfWOKD0OgPQhI9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4kI6xNvAbWs=:eSMUHArWFT3vSsTXdwIOdR
 78WQ4uZ2yJjjLdIFG7+ZnGElYkhft3tj60J/fEOa2KmFWLwMSEH4Dq5VG0uRWTSFe7RnMAvKv
 hPNCZIL1gimQAulaZcq4jqAGPnwqLCuzmPTjNPLWCctZrec/4wwaIZlwlqojEPEso9LQO7PK6
 1phIh3ciMLdSPaq7pc1xyAid5JIXVAWO4nY/03003qulhsS9C6MTGJg6IqcGtN10/Jl5HFkDO
 jI/GiR29ZlF8MGp02f8Z7T3uftgAuiojY2lli06FtF8wrIk0uG+PrZyHzFrohW2xAMV0gKXzH
 QHok7TRHwxdUh8LD2e3VQ0D5HUiYWti2ewi+oqORyfDDs3RkVFb9Yv7WlX5cqXwZ3AoFUjYLs
 wvh9yHEfQeqJRQqy5Td/4z4NtIyT3eQXm6MNHyfM3EvHlqtKhtoGPzkt3d07iDplsv9AacNvj
 WzQglinX9RKRUwxjfsVFN6lMwW3KfiqEbnZ1oigP5H9q1k/mbK49mfNTXMSIAOKh0bXgcxtI6
 hRYx5F/pTOZE3tkzDupPvovyH+J+KwXFBuoZbIKzMFSpRjOGlV+N3KCSOMONNUlLz41Xg1TMw
 5WOYAvqHvtIBu5g/8GYDmBRUo4GIpK44stLO1lBJB11VqqSl+99hylLC6lzvJHYijTxHLey1n
 BI/LyJdBxkbf9b2FlfQ4s6cgWsRmgXFDMoQfS3wtJRqDkT4yAZyRcpwIWC0Q65Y/oucFjFPBb
 k7AACfZRPkkOJ0xqxOiD2/dFFvPqhw0Ox133TMTgJlzErtR3KkziQKSd16z1kEW7YNZKomeiF
 +NAW4Xh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Mar 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The former case may split into two.  "Yes I agree that is bad and it
> > is the same badness as the version without this change", in which case
> > we may want to leave a "NEEDSWORK" comment in-code so that people can
> > notice when browsing the code (but fixing the badness would be outside
> > the scope of the series), and "yes that is bad and we shouldn't
> > introduce that badness", in which case we do want to fix it in the
> > patch.
> 
> We however need to be a bit careful here, though.
> 
> When a patch series is refactoring an existing function to be used
> in different codepaths, an existing issue inherited from the
> original code (e.g. perhaps an existing error checking that is
> looser than ideal) may have been OK in the original context (e.g.
> perhaps it died and refused to run until the user corrected the
> repository), and it still is OK in the codepath that uses the
> refactored building blocks to replace the original code, but it may
> not be acceptable to leave the issue in the original code when a new
> caller calls the refactored building block (e.g. perhaps the
> refactoring made it possible for a caller to ask the function not to
> die and instead act on different kinds of errors in different ways).

In this case, discover_git_directory() is intended to use the exact same
logic as setup_git_directory() (including bugs and all) so that they do
discover the same directory.

It would not do for discover_git_directory() to detect a *different*
directory, no matter how much "more correct" one would deem it.

Ciao,
Johannes
