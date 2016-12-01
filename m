Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600141FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 04:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756350AbcLAEab convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 30 Nov 2016 23:30:31 -0500
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:63523 "EHLO
        dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752576AbcLAEaa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Nov 2016 23:30:30 -0500
X-AuditID: 12074425-8b3ff70000000221-41-583fa756eb4d
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 63.05.00545.657AF385; Wed, 30 Nov 2016 23:30:14 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id uB14UDpm010310;
        Wed, 30 Nov 2016 23:30:13 -0500
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id uB14UBxk020219
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Nov 2016 23:30:12 -0500
Date:   Wed, 30 Nov 2016 23:30:11 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] xdiff: Do not enable XDL_FAST_HASH by default
In-Reply-To: <20161201035914.kftxb4vqmzcqed5r@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.10.1611302329010.20145@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1611302202100.20145@buzzword-bingo.mit.edu> <20161201035914.kftxb4vqmzcqed5r@sigill.intra.peff.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42IRYrdT1w1bbh9hcGatjEXXlW4mi4beK8wW
        P1p6mC0OHpN0YPF41ruH0ePiJWWPKff+s3p83iQXwBLFZZOSmpNZllqkb5fAldF19C9LwRmp
        ijt73zI2MN4T7WLk5JAQMJG41L6SrYuRi0NIoI1JYuL+82wgCSGBjYwSJzZzQiR2M0lMu7ac
        FSTBIqAtcfJcAzOIzSagJvHh6FewuIiArMT3wxsZQWxmgRSJ+59/gNnCAnYS51afYeli5ODg
        FHCRaF8kDmLyCnhI7OsQgVjVwCjx61UliC0qoCtx6N8fsBN4BQQlTs58wgIxUV3iwKeLUNO1
        Je7fbGObwCgwC0nZLCRls5CULWBkXsUom5JbpZubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6
        iREcxi6qOxjn/PU6xCjAwajEw5tw2y5CiDWxrLgy9xCjJAeTkihvWYl9hBBfUn5KZUZicUZ8
        UWlOavEhRgkOZiURXr1lQDnelMTKqtSifJiUNAeLkjjvf7ev4UIC6YklqdmpqQWpRTBZGQ4O
        JQleFpBGwaLU9NSKtMycEoQ0EwcnyHAeoOG2YMOLCxJzizPTIfKnGHU53ux6+YBJiCUvPy9V
        Spz30FKgIgGQoozSPLg54PTD6SDxilEc6C1h3mkgo3iAqQtu0iugJUxAS96+tgZZUpKIkJJq
        YHS/qHpYO4dJVTj6uXJ3Z0PFNc+Pck6PNj/dc23rnFmbPv45v7icYeMbu13dM2J+z/fdHCr1
        8faDDX6X1v3t9npXMIF7/q2gH+lq2caXCpjyLixofXii+8+ixmMChxsueP6+sdLu1PSF8ZGi
        waE3hD/OFZ14/1fKkhNfd2ZvEjNouGB5VaaI9cYiJZbijERDLeai4kQAmVOtLhoDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although XDL_FAST_HASH computes hashes slightly faster on some
architectures, its collision characteristics are much worse, resulting
in some pathological diffs running over 100x slower
(http://public-inbox.org/git/20141222041944.GA441@peff.net/).

Furthermore, it was being enabled when ‘uname -m’ returns x86_64, even
if we are cross-compiling for a different architecture.  This mistake
was also causing the Debian build reproducibility test to fail
(https://tests.reproducible-builds.org/debian/index_variations.html).
Future architecture-specific definitions should be based on compiler
macros such as __x86_64__ rather than uname.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---

[Oops, also resending for Thomas’s new email address.  Sorry for the 
spam.]

On Wed, 30 Nov 2016, Jeff King wrote:
> However, I think this might be the tip of the iceberg. There are lots of
> Makefile knobs whose defaults are tweaked based on uname output. This
> one caught you because you are cross-compiling across architectures, but
> in theory you could cross-compile for FreeBSD from Linux, or whatever.
> 
> So I suspect a better strategy in general is to just override the
> uname_* variables when cross-compiling.

The specific case of an i386 userspace on an x86_64 kernel is important 
independently of the general cross compilation problem (in fact, the words 
“cross compilation” may not even really apply here).  And I don’t think 
one should have to manually tweak the build for this setup, especially 
since the compiler already has the needed information.

> All that being said, I actually think an easier fix for this particular
> case might be to drop XDL_FAST_HASH entirely.

Works for me.

Anders

 Makefile         | 1 -
 config.mak.uname | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index f53fcc90d..c237d4f91 100644
--- a/Makefile
+++ b/Makefile
@@ -341,7 +341,6 @@ all::
 # Define XDL_FAST_HASH to use an alternative line-hashing method in
 # the diff algorithm.  It gives a nice speedup if your processor has
 # fast unaligned word loads.  Does NOT work on big-endian systems!
-# Enabled by default on x86_64.
 #
 # Define GIT_USER_AGENT if you want to change how git identifies itself during
 # network interactions.  The default is "git/$(GIT_VERSION)".
diff --git a/config.mak.uname b/config.mak.uname
index b232908f8..2831a68c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -1,10 +1,8 @@
 # Platform specific Makefile tweaks based on uname detection
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
-uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
 ifdef MSVC
@@ -17,9 +15,6 @@ endif
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
-ifeq ($(uname_M),x86_64)
-	XDL_FAST_HASH = YesPlease
-endif
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
-- 
2.11.0

