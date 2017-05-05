Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B9C207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbdEEWjJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:39:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:64625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbdEEWjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:39:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0McVKy-1dOIl739we-00Hhcp; Sat, 06
 May 2017 00:38:57 +0200
Date:   Sat, 6 May 2017 00:38:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Daniel Ferreira <bnmvco@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/3] Port git-add--interactive.perl:status_cmd to C
In-Reply-To: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705052316250.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/d0CIrFu6gT0aEZyw3HxlBgK5n6aqlVGf7Bi7r1PFqOW++Vg20n
 Pz5N0Gj4LUejZ0e+pUhvwN3GVGoq0x2oUcfonVzNE0/VaV7av61m2QKWB5nhDmSqA1iBv8M
 rAnukMhMHEN1jWcqgk7BS6TGjJcoGkxBrGu0s6mPxm6pvDA/Z+q4ZA1Q5gx3Q3jaHmcuaJc
 jYbuzScTeBg29QrD/x5Hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cQOvQoywwFQ=:L+AONYeQTI5pLP4u3lV/J4
 //VS2q6gF0QoQbqkzAIqy8ptDRIkse73SBhxpL8yLgbxWgmB/elQPEUi50XuKDfEMEU1ZagDP
 C7dJkKgmt5j3W98OeW0yH+ctmxnI3LK9WRLHC0+A/dL79dK80rzacUCWgySYcyPzIFC7ijhKw
 PQHyROuM23qNuPpxgaqs4YP0uPfCoC9tOLXQe+Rz5zBXrbaKjVvKSBlfWZt+1ryZR1jpaWToH
 nJt0eC8M/tvqOHBgxWWLqKjvLuABLN5/zZj3uEWqnzxH+Rl7xoTelJVk/iQmlpD/ucgU+T14J
 tvI0pby8p6mVGRl6iRT2EywccMaaH9afvCmUO7GMR3Xk1+Tfi0wsajM/AjuqeUYU6w0H/+xIX
 4HWES++Xg/gDYFYoi3fe30LDNKVQ92Cu54Kd1hxe998JIJ9vcvkK15A8RWtNK8Jr8C6SNkO3X
 53HMJcMggyMCybQV9FkS0c6SXQ8i5uPUf9zXFt5pbrZfz5KgIBKTUyNjqRYvE43rgtkAyXF5H
 f0n7ukmklJ3XSTDYrcS8fVP4U9mhcvXmtz2ijGpQn8MSGfkyOgL+ZCf6oiV2eaJumQnaVCYsf
 dIhTLF2cm7FjNWez5giXbb+68OkK277JQ+ntCaEKcf7F0yrXdeuvayO99uq+56Cuzk41s7tay
 kiYvcazsUBgZzGBvawNzL+c6GXFN89g4foHsNHAC654F717PNJHTfVKZ4t6qEt0t27qzEKOcs
 e44slcHHMr0C4P37G1cAxHKFBanoGHXT2woa9897LHsbikQeCP207Q2XelRYZd7vB5inzCf61
 TejACq4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Fri, 5 May 2017, Daniel Ferreira wrote:

> Hm, it looks like my GSoC project won't be in the Git organization,

Yeah, rumors have it that you were quite a popular student and several
organizations fought bloody wars over getting you... ;-)

> although I'm still interested in going for this so I guess I'll send
> patches to implement my proposal anyway (although certainly in a slower
> pace than I would if on the program).

Nice!

> This series introduces git-add-interactive--helper (or should it be
> called git-add--interactive--helper?) as a builtin capable of doing
> what the Perl script's status_cmd() would do.

Since it is a temporary thing, and not user-visible, I would opt for
git-add--helper. I may have mentioned that a couple of times now... ;-)

> I wish this patch series could have been smaller, although I don't
> think it would make sense to bring add-interactive "subunits" smaller
> than a command to the helper, and status_cmd (aside from probably
> add_untracked_cmd) was the simplest one to do after all -- and still
> required ~250 lines on the new builtin.

I think it's fine. There has been a patch series consisting of ~80
individual patches before, as long as you do not go close to that one, I
think you are fine.

> Another regret I had was not being able to retire any code from the Perl
> script yet (and will likely not be able to do so until all commands have
> been ported), but that is not such a big thing after all.

All in due time.

But maybe you want to keep the naming a little more consistent with the
Perl script, e.g. instead of calling the function `print_modified()` call
it already `list()` (and rename it later to `list_and_choose()` once you
have taught it to ask for a choice)?

> As for the new builtin, I think the color handling code is pretty
> straightforward. In fact, it was practically copied from places like
> clean.c or diff.c (which makes me wonder if some of that code could
> be generalized to avoid duplication). The same goes for the pretty
> simple option parsing code.

True. It does look awfully similar to other code handling colors.

Maybe put it on the backlog. Or the GSoC get-your-feet-wet projects for
next year.

> Bigger issues seem to arise when dealing with getting the numstat.
> While (as Junio anticipated on an RFC) some tasks like getting the
> actual diff and splitting it may require making the "diff
> machinery" write to a temporary file that we will read and do things
> with, I think it would be weird to do that for parsing a simple
> numstat from it.

I would actually think that the callback Junio talked about would be more
appropriate than to write temporary files. Even to split the diff. We can
do that much more efficiently in-memory.

> My first instinct was to create something like
> show_numstat_interactive() or something on diff.c (analogous to the
> other show_* functions). Doing that, however, would stumble upon another
> issue: we would not be able to print both a file's diff against the
> index (obtained from run_diff_index) and against the worktree (obtained
> from run_diff_files) in that function. The solution I came up with was
> to export the diffstat interface from diff.c into the world and allow
> our new builtin to use that and build our status_cmd output. Unless this
> breaks some rule of Git's API design, the result seems pretty reasonable
> to me.

It looks pretty reasonable to me, too.

Thank you for this pleasant read!
Johannes
