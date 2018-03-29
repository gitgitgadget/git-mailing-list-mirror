Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B281F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC2PSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:18:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:55171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeC2PSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:18:43 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgZdt-1eDzMz0qn7-00nv9t; Thu, 29
 Mar 2018 17:18:32 +0200
Date:   Thu, 29 Mar 2018 17:18:30 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/9] Assorted fixes for `git config` (including the "empty
 sections" bug)
Message-ID: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8fpBlTI1csfMMdRv/V+EdIdj9YQEqgfKi8eNjWPU9lqMEusUs7O
 KAfDi7Rh58qX/QFA4UHbJkL/Zs2hzlSUZ4goduXwhWeQrwri9y/T7CPbWkE6fOnuhX1t8N4
 xW2Ehdb7oHrBuz3fDGH6LyDFgVqaX/ksKaXLzoBP2q1jXXJ5EMSqIYuezh4h8tlSggADcg8
 tTB6EUHNAhuYmIfw54RcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5UAKF7FxPNU=:Lj+w+nIj8+CRfhbMtEpd1g
 HS3v+4Y/GpUAtY7peDIV93o5bVxe+q7+L+2H1A4LxX/yyqo95S3mAvCSmJ57Cejjh/xlaTdVy
 earb/fzPJ+655Bilc3WXYGXY2DDehoEZJRt693IKmkePCjJasIizj1OC+MJBZ6SPiPQ0GGovo
 1m8R7tEY16kIEZCxXZOpINmScCZg7tpwJAU2RdwvKjRYTsbtFn8tsBCrRjBww+1VPmDmf8hTd
 EIEnky3BMi7BJNOs33CiRtnB3I6XSczhhbzISLEmSgdOqqGZGoD+0osCJiT52s7ywLyiDYEyF
 NdPjAGaBOYNMpSphZD7V2o2O1RsLSRvDdp6fzz3C5ewXgY30gvK4Kubt7Fr5JB0WJU/08RB6V
 /yWbx5q4Yq9smcsSmyAzbLy7gby5aRSNuSpB+PQzWsOi9DPSlR6hFz/oXFt62AOrXvnhrDW0C
 oc9gEpt7rUr8C/oWezQMzXDLGyzdPZ0BI+xrWrFMNojHITG6Ti11xW14Vg6Jxy8INoi0aPd4j
 jfXT3fWnCIT6s2fIsRkAmuDKZlirFnWqdD5VgwbdJxDnMfMBb6ynaJcU0eT6K9UEPDDx0qP8i
 6F0lkv63syVe/kcgjt7FpEYlC6f9fI/O9tIg3HS6AW0sPCZa6UlO+Q2Ufm0DuiG9ZukN78WAx
 ez0B/WCZknVFwfU9aRaH2v3GXHk9cfnA8+8p62uBLjzM2wI3dz5mA4HDHS6BEfAKlQDhHJ9TX
 O6XN4zaF2S09XWS8ZP+8KzefN4AAto5zSmqjFG30GkHDlY8+yTpSWM3QY6y0rukkuveCQ4i3p
 tBpDiASU7ntMsazEMmy9uZwAoAmfUMTflGVz0f0qgIuLTwxG13o6xPw2XTgIs8M+ZRrJg7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started out as a single patch trying to figure out what it
takes to fix that annoying bug that has been reported several times over the
years, where `git config --unset` would leave empty sections behind, and `git
config --add` would not reuse them.

Little did I know that this would turn not only into a full patch to fix this
issue, but into a full-blown series of nine patches.

The first patch is somewhat of a "while at it" bug fix that I first thought
would be a lot more critical than it actually is: It really only affects config
files that start with a section followed immediately (i.e. without a newline)
by a one-letter boolean setting (i.e. without a `= <value>` part). So while it
is a real bug fix, I doubt anybody ever got bitten by it.

Nonetheless, I would be confortable with this patch going into v2.17.0, even at
this late stage. The final verdict is Junio's, of course.

The next swath of patches add some tests, and adjust one test about which I
already complained at length yesterday, so I will spare you the same ordeal
today. These fixes are pretty straight-forward, and I always try to keep my
added tests as concise as possible, so please tell me if you find a way to make
them smaller (without giving up readability and debuggability).

Finally, the interesting part, where I do two things, essentially (with
preparatory steps for each thing):

1. I add the ability for `git config --unset/--unset-all` to detect that it
   can remove a section that has just become empty (see below for some more
   discussion of what I consider "become empty"), and

2. I add the ability for `git config [--add] key value` to re-use empty
   sections.

Note that the --unset/--unset-all part is the hairy one, and I would love it if
people could concentrate on wrapping their heads around that function, and
obviously tell me how I can change it to make it more readable (or even point
out incorrect behavior).

Now, to the really important part: why does this patch series not conflict with
my very early statements that we cannot simply remove empty sections because we
may end up with stale comments?

Well, the patch in question takes pains to determine *iff* there are any
comments surrounding, or included in, the section. If any are found: previous
behavior. Under the assumption that the user edited the file, we keep it as
intact as possible (see below for some argument against this). If no comments
are found, and let's face it, this is probably *the* common case, as few people
edit their config files by hand these days (neither should they because it is
too easy to end up with an unparseable one), the now-empty section *is*
removed.

So what is the argument against this extra care to detect comments? Well, if
you have something like this:

	[section]
		; Here we comment about the variable called snarf
		snarf = froop

and we run `git config --unset section.snarf`, we end up with this config:

	[section]
		; Here we comment about the variable called snarf

which obviously does not make sense. However, that is already established
behavior for quite a few years, and I do not even try to think of a way how
this could be solved.


Johannes Schindelin (9):
  git_config_set: fix off-by-two
  t1300: rename it to reflect that `repo-config` was deprecated
  t1300: avoid relying on a bug
  t1300: remove unreasonable expectation from TODO
  t1300: `--unset-all` can leave an empty section behind (bug)
  git_config_set: simplify the way the section name is remembered
  git config --unset: remove empty sections (in normal situations)
  git_config_set: use do_config_from_file() directly
  git_config_set: reuse empty sections

 config.c                                    | 234 +++++++++++++++++++++++++---
 t/{t1300-repo-config.sh => t1300-config.sh} |  36 ++++-
 2 files changed, 250 insertions(+), 20 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (98%)


base-commit: 03df4959472e7d4b5117bb72ac86e1e2bcf21723
Published-As: https://github.com/dscho/git/releases/tag/empty-config-section-v1
Fetch-It-Via: git fetch https://github.com/dscho/git empty-config-section-v1
-- 
2.16.2.windows.1.26.g2cc3565eb4b

