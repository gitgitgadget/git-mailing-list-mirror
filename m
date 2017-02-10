Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31801FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbdBJPpw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:45:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:62681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdBJPpe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:45:34 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYwVv-1cyQvF2YGR-00VeZr; Fri, 10
 Feb 2017 16:44:22 +0100
Date:   Fri, 10 Feb 2017 16:44:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Mike Rappazzo <rappazzo@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a
 subdirectory
In-Reply-To: <CANoM8SV7oJ6YmKM-n63620EkODxD562BZnLZB6OvX8O6BmDT1A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1702101634010.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com> <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092304250.3496@virtualbox>
 <xmqqwpczm0vj.fsf@gitster.mtv.corp.google.com> <CANoM8SV7oJ6YmKM-n63620EkODxD562BZnLZB6OvX8O6BmDT1A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cgy/PnlWNV4aoYlEJasujglrU77iMRlOK8sSph2/1R709W6pIb3
 ndKXYWndZeyXB4FCEAuSbDr+0Al0a81vFHpuni4uqFlhLfj+Z1Vq5wB2XlTpFu/7ZbCD6bf
 LoEmur2tAzjYojF9GzyP1c0iRUePxftvohBrVbwbrKU4bC3ovzILecr4038qLobcVYlVRMu
 QVZYxDtSXRKRPMluyY5HQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5+kaaeqzoGo=:lIhbwCEuICSdh68I5MsEck
 srcARpYddXhE6iwkuFpsvwcvCdAeUwXl4MYUYux/ucdC6xnQOPg93TQb/Ip09QTUr/A4ikCWn
 a/AIwGChdUrKNQ+QjvPMZiSuvp6HreMcijEDIv4fXVsUa5VT7XmN5aRZ530j6etQAqd2dNubX
 ca/BIDgHTIcTHnbGgHEB9FOxj9V/aOSrQxFHHF2g1+oj1hYRZSXsIjJuYCqZqoAVQLzpQN7eO
 kJYJNbRocyjFxJkmB4bZ/fNlBm2RJ23a1q3JOCk2eBzoMYrDbZuvkn9dPCkV1/uGaOUNXimZ5
 D4a6zfzPuURteI0hfnUuHD3I8aQ+dE75unuHDvz5tc5omKoCGIw6rtxlSA6HdKBxR4+0FVra3
 mhhtaSxh7NzbrRi2j6F+sEZeZg+d+fsdppIwFynIt4U415UB5ck+zEUHTdj4pAO3amaLz1XXS
 oP09fkO95jPsdYWuFZ7JuqYGhV0ijZqqcDsQdFef0pzihuh5kzNtMloIKv859aCEbZ0oOU0i9
 fq6e2l6QVPi6MpuE/pZskFpjOAKyH7mkjGXa6uqb6TaRumlqim0F3gLKVOdz45Zm67pm99dnw
 HirdBOH007hSLds1y89Eh1xSgFg6dEWeQsPxrbE285FI6KquWstFaz+XKuWXm+sG8LgNMpq40
 8xSK6/pf8VcqH7RTJU9iAFXFDCyCkhoG/9jCNBlpZBix4UtgJetfuR11E10ZQqgPEwe/J20Bp
 iEuCEftI/SzZhBumKqa/66+icfPHIye5SbSo1LXxdcZ+ZQv/RR6PRa5/i13YUgj8UflJVAgYi
 2mpMawN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Thu, 9 Feb 2017, Mike Rappazzo wrote:

> On Thu, Feb 9, 2017 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > That leaves what the right single-step behaviour change should be.  As
> > I recall Duy said something about --common-dir and other things Mike's
> > earlier change also covered, I'd prefer to leave it to three of you to
> > figure out what the final patch should be.
> >
> 
> The tests which I covered in my previous patch [1] addressed the places
> where we identified similar problems.  We should try to include some
> form of those tests.  As far as implementation goes in rev-parse, the
> version in this thread is probably better that what I had, but it would
> need to also be applied to --git-common-dir and --shared-index-path.

Thank you so much for pointing out that git-common-dir and
shared-index-path have the same problem.

I looked a little further, and it seems that the show_file() function may
have the exact same problem... but then, it only prefixes filenames if the
--prefix=<prefix> option has been passed, and it could be argued that
those prefixed filenames are *not* meant to be relative to the cwd but to
the top-level directory.

Anways, v2 was just sent out, and with Peff's acknowledgement that this
fixes a real bug and that hypothetical scripts relying on the buggy
behavior were broken beyond repair even without worktrees anyway, I am
hopeful that we'll get somewhere.

Ciao,
Johannes
