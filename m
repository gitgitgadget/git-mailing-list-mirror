Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C6C10F25
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 21:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38472146E
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 21:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YIKOqrTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgCIVvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:51:47 -0400
Received: from mout.web.de ([212.227.15.3]:40913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgCIVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 17:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583790704;
        bh=zxepoE8mN+VHIepayU/QiTdgDNR8xu0k+i3gpE5lNjA=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=YIKOqrTmAuvMRgcHFdE/jU/MQE41ixFODh3XfC30JZ2M0WiqxcyhVWl1ToFrqAiyk
         jcZtrVgCZl18Qi8CrmZWl3rZCrjTS2vfTu5n4xK+4DJP9P4+Jb5DcQJ/ky5kUpE8ox
         dQLo2MlnLZz1mtYjy6dCxIp1NUpvWYYpl7v/tgHk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbyZa-1isFGg1Ivu-00JGXs; Mon, 09
 Mar 2020 22:51:44 +0100
Subject: Re: Documented option "--deepen" is unknown to git-pull
To:     =?UTF-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>
References: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
Date:   Mon, 9 Mar 2020 22:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BtUOt+w5a3rx/bC9wNwZRHX9+fgygtAccCte1s0fKsKdGjCAKIQ
 hL4C6V1+U5Bf+0r3W/ezjdrTpJjid7GCJHZ3P+2ELJ/IBTVDEd/1Z7aA0RH7V71AodEsMqa
 lgllBTHhTCaJOULgQAVwH8IbR5MvCwrOr2q6c57KdB3wpoF3aXtHcuS9m6lvMS7Il7RIZMW
 1PcylCVkg4Re6b/O9+0kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+mLs336FuJ4=:cYYJ/xxGb2+rXrg3oxrgPD
 fQmEa17frRFb88MoHWw8VsN7TdoUT2giquTdsBtuCLoGs8CjFjkfnBXDQz/nJQR1ITzhjb9Ay
 AhYeOBeqMloS9TyjvuuiyOk7y25Obm4z6+Lt1iwVXswBcFyfV/R6V80fCoNa9242w4SFDkKpy
 6TMApRASRG2F7VJuAClSzrreAXhQ33Pdo5PlsVaxA4ZAg/Fyf8u7jOfObOU1M1cGbRbfSXhWi
 YGE3m3Y750j5+vx6tuoMmbB2sGUBbp4bscsw4bEEzkTX0BMLwzyD7JJ1NyHCMs6O4yD5FZeV+
 3zHOTSaxjMyVm2lsOhjKf2e7MM1HugOE+8CglOdyNGO3yTWcgqO3eAx66WZ3NdKjtQ/9o/LM4
 O6rFK5c9bqIDLg5vbULO6SD+S8f/0DVuSvs8rJJhVgpmEOpcYnwp5z2/uas9uCkrJg6W4MvhQ
 hA0bHQXsiBXsKjKxakMPWJhfZ1ZfVakmFZ5/d6/aI3xFEtKCSp7UpjTU4QReBnXfHPMYljcLE
 7DhzJYpXYYtUedVGTEWqaF7icJsPC81Vl4upakDidZFJZJmjmng08mhkJCRTqcqPgqDGTez3L
 FmlZXDYCQ/ndFbPYJCuqimnayML9XdggD6bOlIzubyAdhmO+/bjE7/JUJeCo6pP2LyH7NQf2Z
 d9ocyyUrqUav4ZVTWIx81Gr41JmonPd0cVSNxlZygiC9CNsjFBqhKQDQtmUpe4cZAxku+6TOp
 Fxy1qOv1DC+3Q9UDU0lmKoDzoSRn5W2DeLV46gwL4rDWw6Iv3PiD0WlnpOHGSnlkvVcVhrlOj
 epxmFfkFGtc2xvmhoeD5FWhCRtpnxkTmASRjDqK0ohkjcYQOtb13pDj+ccKPPQKX208UCJE95
 iVIL5qSpEu1ev/TMQ0KJaU3AdERoo6uE1NkkHLHNoVTW4ltn5kgH0saPrSUQoBrhv/0EbQGUr
 ZSKy8pELiXwrZMAvmNC1qAbvqiO/ymrUTBx1sZjGg/mynDXjBxFIuDeqxX3hnC2TEY1+yqHRK
 R+3w5Xs61dITLbmktC+i3zqjnqs8bQJU7hpQyACxXLjA5Dh7L05fgUdvA3g0QbaWV4/TTwm8w
 CFymCGPELHvQYFys60BXdPq7dx4QAz/YPDJ5Mdr3sgQVaONboa0tzli7clAMO6tSJkONDYzDX
 W6XbFFXLKGBIBGKTfBP/hWYLGWrimv2df1+czfiAugbrpHZUkcN8H9+GgM0gdBnFRLVCKBDFS
 5rAIJVNCsMgXiB7dU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.03.20 um 20:17 schrieb =E5=A4=A9=E5=87=A0:
> Option "--deepen" is documented in online doc of git-pull, Sec.
> _Options related to fetching_, see
>     https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---deepe=
nltdepthgt
> But executing "git pull --deepen=3D100 origin master" returns
>     error: unknown option `deepen'
>
> More tests show option "--deepen" is known to git-fetch but not
> git-pull, although the doc of git-pull says
>     git pull runs git fetch with the given parameters and calls git
>     merge to merge the retrieved branch heads into the current branch.
>     https://git-scm.com/docs/git-pull#_description
> which suggests that every valid option of "git fetch" would also valid
> for "git pull".
>
> Is this a documentation or an implementation problem? (I use git v2.25.1=
.)

Looks like an oversight to me: pull has --depth, so why not --deepen as we=
ll?

Are there more?  Let's take compare short help and manpage:

   LANG=3DC git pull -h | awk '
      /^Options related to fetching/ {show=3D1}
      /^ *-/ && show {sub(/^ */, ""); sub(/, /, "\n"); sub(/[ [=3D].*/, ""=
); print}
   ' | sort >shorthelp
   awk -v pull=3D1 -v show=3D1 '
      /^ifdef::git-pull/ {show=3Dpull; next}
      /^ifndef::git-pull/ {show=3D!pull; next}
      /^endif/ {show=3D1; next}
      /::/ && show {sub(/::/, ""); sub(/[ [=3D].*/, ""); print}
   ' Documentation/fetch-options.txt | sort >longhelp
   diff shorthelp longhelp | grep '^[<>]' | LANG=3DC sort

   < --dry-run
   < --jobs
   < --prune
   < --refmap
   < --set-upstream
   < --tags
   < -j
   < -p
   < -t
   > --deepen
   > --negotiation-tip
   > --no-show-forced-updates
   > --no-tags
   > --progress
   > --server-option
   > --shallow-exclude
   > --shallow-since
   > --update-head-ok
   > -o
   > -u

Hmm, that shows a few false positives: -t/--tags actually pairs with
=2D-no-tags and --show-forced-updates from the short help is mentioned in
the manpage along with --no-show-forced-updates.  And --progress is
actually mentioned in pull's short help, just not in the fetching
section.

If we ignore those cases, the following options are documented in its
manpage but not actually accepted by git pull:

   --deepen
   --negotiation-tip
   --server-option
   --shallow-exclude
   --shallow-since
   --update-head-ok
   -o
   -u

Side note: There must be a better way to keep short help and manpage
in sync than the above ad-hoc AWK scripts.

Here's a patch to fix the easy part:

=2D- >8 --
Subject: [PATCH] pull: document more passthru options

git pull accepts the options --dry-run, -p/--prune, --refmap, and
-t/--tags since a32975f516 (pull: pass git-fetch's options to git-fetch,
2015-06-18), -j/--jobs since 62104ba14a (submodules: allow parallel
fetching, add tests and documentation, 2015-12-15), and --set-upstream
since 24bc1a1292 (pull, fetch: add --set-upstream option, 2019-08-19).
Update its documentation to match.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/fetch-options.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options=
.txt
index a115a1ae0e..00d03ec8c3 100644
=2D-- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,10 +61,8 @@ this option multiple times, one for each matching ref n=
ame.
 See also the `fetch.negotiationAlgorithm` configuration variable
 documented in linkgit:git-config[1].

-ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
-endif::git-pull[]

 -f::
 --force::
@@ -95,6 +93,7 @@ ifndef::git-pull[]
 --[no-]write-commit-graph::
 	Write a commit-graph after fetching. This overrides the config
 	setting `fetch.writeCommitGraph`.
+endif::git-pull[]

 -p::
 --prune::
@@ -107,6 +106,7 @@ ifndef::git-pull[]
 	was cloned with the --mirror option), then they are also
 	subject to pruning. Supplying `--prune-tags` is a shorthand for
 	providing the tag refspec.
+ifndef::git-pull[]
 +
 See the PRUNING section below for more details.

@@ -133,7 +133,6 @@ endif::git-pull[]
 	behavior for a remote may be specified with the remote.<name>.tagOpt
 	setting. See linkgit:git-config[1].

-ifndef::git-pull[]
 --refmap=3D<refspec>::
 	When fetching refs listed on the command line, use the
 	specified refspec (can be given more than once) to map the
@@ -154,6 +153,7 @@ ifndef::git-pull[]
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).

+ifndef::git-pull[]
 --recurse-submodules[=3Dyes|on-demand|no]::
 	This option controls if and under what conditions new commits of
 	populated submodules should be fetched too. It can be used as a
@@ -164,6 +164,7 @@ ifndef::git-pull[]
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
 	clone.
+endif::git-pull[]

 -j::
 --jobs=3D<n>::
@@ -177,9 +178,11 @@ parallel. To control them independently, use the conf=
ig settings
 Typically, parallel recursive and multi-remote fetches will be faster. By
 default fetches are performed sequentially, not in parallel.

+ifndef::git-pull[]
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=3Dno` option).
+endif::git-pull[]

 --set-upstream::
 	If the remote is fetched successfully, pull and add upstream
@@ -188,6 +191,7 @@ default fetches are performed sequentially, not in par=
allel.
 	see `branch.<name>.merge` and `branch.<name>.remote` in
 	linkgit:git-config[1].

+ifndef::git-pull[]
 --submodule-prefix=3D<path>::
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
=2D-
2.25.1
