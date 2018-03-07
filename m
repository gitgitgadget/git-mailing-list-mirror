Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199F91F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeCGRjo (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:39:44 -0500
Received: from mout.web.de ([212.227.15.4]:38297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933855AbeCGRje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:39:34 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtmK-1f95Uv0LLE-00X8De; Wed, 07
 Mar 2018 18:39:13 +0100
Date:   Wed, 7 Mar 2018 18:39:11 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32
 BOM
Message-ID: <20180307173911.GA19262@tor.lan>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
 <20180304201418.60958-5-lars.schneider@autodesk.com>
 <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
 <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com>
 <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
 <xmqq4lls3irx.fsf@gitster-ct.c.googlers.com>
 <EC8DF4D3-CDF5-4CEB-BD18-585341BBB2C5@gmail.com>
 <xmqqpo4g22tv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpo4g22tv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:H09av6ugOjb2wWzUPq0BYC1K7JJoOh4htR0DkIHEvFxlle6ANrV
 MdKxiVGKQD93artUnAmKeBXdddBbZFPTF0FQ3P4fZHAMhCbpweO+3JsLbKPGcHOZr6L2zct
 /yoBdr4dLjI8yVe3xTFmFYECw9MgbHWe3i7vm8lhVCeqOqcIoAhYtcKz/62YFb7EHzHi4XZ
 KNa3wtDRmd+ggJO3moi6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IMm4AYR0/jU=:JPEft3DKeSKiIU/mCxcUH7
 vqfo9idkKHwYrRAuuuDYx2rF7QJKaHJFvaF8viM6rZX7qySz2dz4Dj53aM4/lmaenTioaQLrH
 DjSJRR6EdvVYkVYLcJBXrfauMpXmXmIJ5Lb4/O3RQqAe+sSkLgXBqD8tUETL38MtUF7GrBXEZ
 9PBf07KCbNPux5UI7T8SkQYV1KouEcu746pDcyAz3RictNtyRSahjX904T+24hIlJR0L/PPvi
 eCiPqZEZkx0UWC06l7ghFOHc1Cs8Uj+X6czn5Kqn2lTtRT5OERkyZdd2h1lgXyalJlKDUWAd6
 4tc2DfrjlfFkKK6cGcNaP7snG+yn0PHP1KBmWuC3Mark3ea5zdXzoOutYQqXqVz3NpMXoCgqP
 wt80t7IxrLi1xS0DzsCNcz4lWmi02fanzkztP6cNhB2kmS0JCkFc4C1TZObWORp4OfNyQ/nY9
 4ymwUA+frwJ7c2wFHe+vS6Mu8NtLWH4BMFk3wycoYRkcLm970Oc/FAH543XU6miCbJz3DTH/v
 wIfexkyi9HD7R9OgHSvCVjd2SeTu744VPEGZIrbXV99ylBVRPUrmoybUU+e3ObBa5LLnx8nKY
 K3mGj/r7DsYKB6W6BnC1w919fuex8mXOCW5fAlctB17oTWKa+xI3fc0IkZij3FFWu1v3rYWdh
 co2ZllX9rNb5MRjkyNt7MPhw3/To6zKpmXI4mNPdF7f+WBQ1oKjbmpUNX0dH1rAyXTpaTZ9iq
 yintVzY/lq4bkJ05b97wO9i8NTIfJ/cmxcgFjcUWCPiZUvoWTdXwjpUo2mfWgE1QuuLUBZlNK
 BDVxaUvjLwCQ2+FLbAS2HS18T6aow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 06, 2018 at 03:37:16PM -0800, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > After thinking about it I wonder if we should barf on "utf16" without
> > dash. Your Linux iconv would handle this correctly. My macOS iconv would not.
> > That means the repo would checkout correctly on your machine but not on mine.
> >
> > What do you think?
> 
> To be bluntly honest, I prefer not to have excess "sanity checks";
> there is no need to barf on utf16 in a project run by those who are
> without macOS friends, for example.  For that matter, while I do not
> hate it so much to reject it, I am not all that supportive of this
> "The consortium says without -LE or -BE suffix there must be BOM,
> and this lacks one, so barf loudly" step in this topic myself.

Loosing or adding a BOM couild render a file useless, depending
on the SW that reads and processes it.

The main reason for being critacal is to make sure that the
material in the working-tree does a safe roundtrip when commited,
pushed, pulled, checked out...

The best thing we can do is probably to follow the specification as
good as possible.

Having a clear specification (UTF-16LE/BE has no BOM, UTF-16 has none,
UTF-16 has a BOM) would even open the chance to work around a buggy
iconv library, because Git can check the BOM.
If, and only if, a platform messes it up, and we want to
make a (compile time) workaround in Git for this very platform.

A consistant behavior across all platforms is a good thing,
sometimes I have a network share mounted to Linux, MacOS and
Windows and it doesn't matter under which Git on which
machine I checkout or commit.

Oh, I see, there is a new patch coming...
