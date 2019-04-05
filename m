Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205BE202BB
	for <e@80x24.org>; Fri,  5 Apr 2019 13:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDENjB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 09:39:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:54999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDENjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 09:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554471527;
        bh=xF0jdrlHCg39NfWinu1SOwg4xmISRcvKXNE5I2sWKMU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OznJrZmRkzU9g5xmrQYGYVsyeIflDLX+ebioROPHXye/bl4FW9Zmj4I7upBKBiDjC
         UdMQCO5wz1rGDb5l8WAoZo7cUjiT1KIr3c9ra8D9ZofQXBT4ZcYAi0sQUAbVMyfw79
         AybXDuM0grUTYr3ar56rEOkC4rSGpgs6oJyedwYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwGDy-1gr2BF1bQc-0186O0; Fri, 05
 Apr 2019 15:38:47 +0200
Date:   Fri, 5 Apr 2019 15:38:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
In-Reply-To: <20190404024710.GO32732@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
References: <20190326220906.111879-1-jonathantanmy@google.com> <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com> <20190404024710.GO32732@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1448133889-1554471528=:41"
X-Provags-ID: V03:K1:RID2EumfzTIeS0zWpzZfbWq5df4BOE+0JiFPm6HoLjTMK/4AFhT
 8tlRnFXaXCTmABmCPzdPAer3V2tHwhtWaqC0ap3xJSrqhp4E4YbJ0/CIT7oqf5o3H3aG253
 wW8yZ/CxkZt9ue/7RYWLJUsH5gyo6tqkUhOWjvptPnZ0iYydOQJmzbKzrk8U1A9Kz+g9qyz
 hMqo7kxu+tTw3YyMufCFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aW9NCGXoxQE=:4tnpHTrcbGoyeqI10nGMA4
 Vf3BKB2PqNwh2v4hCQu3PmSMHEeEbK/hiVjXgDY2mny7Nl+4cgdG4Pn25gmpXiN1W4nvNydRx
 vwnOwSkQT+PV7JaYDIiDBfISRkxnIlWO8hwjOr41GuJuNrJkbSPblWbMipHoiZcGzXx1wTJiW
 SQRLsOzx8ncCZSJK7QU6CH+qlPeaACrQzoJvKztU3z+ZLgbuAAZhN/595XpW9Y4/eUjb0g2TI
 J4zPiuwAa2euFCtnTXI1Kadnwnafyna6N4aWm9tYUWzhHomeRr0M3jTRjceDDfyM2l6/BeL6i
 YVNzu7x8G88oTfPGa6pnCGHMqfTodwYCkH6qUeSqvu6OMVSOD4bNToYhR9zNFFcJVNR7IJCA3
 jOn8eNF8rJIjfKDbMjY7xd7ufQ3Ihqy8u6DfXFRqj0GOPeJIxetJ7wh4qla1ySxGvJb03Xw1o
 MW+ddSKrx4LpdrciGb4CoVByc/vgWTAznTEnE/PSbsPAR2vvQYBPsgWVh3oumucjZl/xdy1ri
 T3MbFqj1TRHIMWpzPZgolyR1KPkxeG64BobH5bxk0VpPqYWN4bOyFRWCBItxV11OWBPJtAlPg
 V/mEO7bhpQeFdPEKaRh8cjyjpaZFfF1gFJDdsRHVecXOZmb0+xoHP5HMbpFwaXuWsE2wRpkAg
 vmYsI8viIjF4oF63cBvO6xyrjnmQKJtyj4IWOfooOv8NrIAtxrFS9uqtXa69oSh2ZIaTrQQps
 hmiZ5MpmSmgftlxuWDhadhfeRbEMLbWg6wSuc3jkf7F9OwFHMTb/o8vnN+zARb0QbbEmcXijP
 IPvjTgsnQ4YHlO+qm0/2NRB6eEB74oECKSv1WV+Cnq65/wkHBw/3jDeqgonRauIDCQTITfwW8
 HrMekFFda/w3bdHnSr0EginDirY3PiC1rQSzbUk05XJ4Y8lWAxMEoVNDKgC1pMIca5dyJuDfk
 gwr6sVkeRog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1448133889-1554471528=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 4 Apr 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Mar 29, 2019 at 02:39:28PM -0700, Jonathan Tan wrote:
> > diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clon=
e.sh
> > new file mode 100755
> > index 0000000000..349851be7d
> > --- /dev/null
> > +++ b/t/t4067-diff-partial-clone.sh
> > @@ -0,0 +1,103 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'behavior of diff when reading objects in a partia=
l clone'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'git show batches blobs' '
> > +	test_when_finished "rm -rf server client trace" &&
> > +
> > +	test_create_repo server &&
> > +	echo a >server/a &&
> > +	echo b >server/b &&
> > +	git -C server add a b &&
> > +	git -C server commit -m x &&
> > +
> > +	test_config -C server uploadpack.allowfilter 1 &&
> > +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> > +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" cl=
ient &&
> > +
> > +	# Ensure that there is exactly 1 negotiation by checking that there =
is
> > +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> > +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client show HEAD &&
> > +	grep "git> done" trace >done_lines &&
> > +	test_line_count =3D 1 done_lines
>
> These patches and 'cc/multi-promisor' don't seem to work well
> together, and all tests checking 'test_line_count =3D 1 done_lines' in
> this test script fail in current 'pu', because there are two
> "git> done" lines.

I investigated a little further, and it would seem that it is neither this
patch nor the cc/multi-promisor patches that introduce the problem, but
the merge between the two... The latter tries to get away from using the
global variable `repository_format_partial_clone` while this patch
introduces another user.

So that merge between these two branches needs to become an "evil merge"
(or should I say "blessed merge", or even a "merge with a blessing"?). I
have this patch, tentatively, for the `shears/pu` branch [*1*], which
seems to fix the test here:

=2D- snip --
Subject: [PATCH] fixup??? Merge branch 'cc/multi-promisor' into pu

The `cc/multi-promisor` patch series and the
`jt/batch-fetch-blobs-in-diff` patch series have a semantic conflict:
the former replaces checks for `repository_format_partial_clone` with
checks for `has_promisor_remote()`, while the latter introduces such a
check.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index fa12b5d04a..86278ce676 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "help.h"
 #include "fetch-object.h"
+#include "promisor-remote.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6493,7 +6494,7 @@ static void add_if_missing(struct oid_array *to_fetc=
h,

 void diffcore_std(struct diff_options *options)
 {
-	if (repository_format_partial_clone) {
+	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
=2D- snap --

Junio, would you terribly mind adopting this?

Ciao,
Dscho

Footnote *1*: I started again to maintain `shears/*` branches in
https://github.com/git-for-windows/git which essentially are Git for
Windows' patch thicket rebased to all four integration branches of
upstream (or "core") Git. I try my best at keeping the CI green on those,
meaning that I liberally add commits on top that are neither in Git for
Windows' `master` nor in core Git's branches.

--8323328-1448133889-1554471528=:41--
