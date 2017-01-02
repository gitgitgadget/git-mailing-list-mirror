Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2524E205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756231AbdABQEC (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:04:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:58256 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756185AbdABQEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:04:01 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgtWa-1cAnOs1llw-00M4QH; Mon, 02
 Jan 2017 17:03:54 +0100
Date:   Mon, 2 Jan 2017 17:03:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Fix the documentation to build with asciidoctor
Message-ID: <cover.1483373021.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1493540345-1483373034=:3469"
X-Provags-ID: V03:K0:Q0spFr+8m4VF9PSmPKMkqI4GriGwllKpecFAlSJBO6/QuLtuNMR
 wNmC9ngTpmfimR8AdVNoVZWNqENOd/VgIUKI5S2tHx6y8TcSPGLfkLBthBE2tasEy/Vubo6
 9ABVRcPSJ9aJs+5RT24LmRX/TWTZ3HeSakAPcQiA6tJaSPS99aUag7fEyOw27nhxKV1a5Cd
 59GPibek8d3fEjG7YFvjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pb7ez9xf7hg=:uCg1rBt+IPZxtnGWEnWcEc
 O1jKQewMAffxVqYN3A1F0UBLnRdrPeUNeGD64OTN7NnFJnBA9NsZ8QgdsyDgbewlA7bmndEqj
 qvwsLIayq7zCTCyP8Veh/miKbqFplHAYrR/xje87IrCB5rb/dPbVqzeS+/DyRNb0B7fv2se1B
 wicvuyvh0hUiFF6up2hnJNND0R/d6iln4JUBGKSTK2SyyKW2asYfDCc4FBttZGlKwcGRVQCid
 bkeFC3itemuYBvofdICKr/RFoI1cGxAOQrqWwmYrb8/u4Bc65pGPIXtFqVYHkr4uAnIcvJNvw
 DjGdQaulQS1vmFH6a6u+Yl/oBL2DHy6vUxLpoEcDAomjyEmvo81dZ62iZvn5tSujQLGLY8+o2
 W0N9Fr4vdCZJwXHaiXfw6EhHXLHqAakA5ice3Gxjxt/F3IjbA5r9oEscDV1Ri4NbrfU8D0Ml2
 NOFQy9iHBWw/vF48f6GiYaUVp5en8D69iKNAIBRWzouZmn/Lpa2ZVC2DivUqQkTrF5Z51DwAr
 jCSPbV+INbZR95B9Tw5YdVFFz4iy6a0kn4UPp8mdlLcogQWa5CQgan+vD6VBLQ/twi62VdHrf
 HIA8yhu3DIMHT5qm0V6+JaUEgSaFTvZ7Vs+Ym18Q5SULUDxiYdNN39hjusmRNNTPB63diS4sX
 V8xDEOxqdMvQNGEgYw+4lmh/TN/CvmVoJw0T/zxZPG7R+hKI3A+dD/Fg/lmX6bV+lxowfFepM
 KfTsObOw9Am9DQqxdTQIdoC5rpJjyLDcBOVZiqZhceJJfEUOglr/CPpzOrmlCVeeY/NeR8nji
 +DIqNsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1493540345-1483373034=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

The first patch in this series has been with Git for Windows for well
over a year already, the second one is a replacement for such an old
patch.

The reason why we use asciidoctor in Git for Windows is easy to see:
when building new Git for Windows packages, rendering the documentation
dominates the time by far. It takes roughly 75 seconds to compile all
the executables from scratch on my main work machine, but it takes
roughly 125 seconds to build the documentation from scratch.

Out of those 125 seconds, 45 are taken by the HTML documentation.

In the Git for Windows project, we realized a long time ago that we
could reduce the time dramatically by using asciidoctor: it takes only
15 seconds to build the HTML documentation.

Those savings come at a cost, though: asciidoctor was designed to be
much less flexible than asciidoc, in favor for maximum speed and minimal
size of the code base. And to accomodate those shortcomings, it is
unfortunately necessary to change Git's documentation sources.

So what is the big deal with those timings? It's only half a minute!

This is on a very beefy machine. Internally, I use quite a bit of
Continuous Integration to build intermediate Git for Windows versions
for testing, and those builds are backed by reasonably-sized VMs. That
makes it worth shaving that extra time off.

Side note for the curious who wonder why asciidoctor is *so much* faster
than asciidoc: my gut feeling is that the primary reason for this is,
once again, the POSIX emulation layer: asciidoc runs as a Python script,
using a Python interpreter that uses the MSYS2 runtime for path
translation and fork emulation (among other things), while asciidoctor
runs as a Ruby script, using a pure Windows Ruby interpreter (for those
remembering the nomenclature: the Python interpreter is an MSYS2 program
while the Ruby interpreter is a MINGW program). But even after that I
suspect that asciidoc was just not designed for speed, on a very
fundamental level.

Now back to the patch series: I *hope* the patches are not too
disruptive. I am very open to changing them however needed, I only care
about one result in the end: that the documentation builds correctly
(and fast) with asciidoctor.


Johannes Schindelin (1):
  giteveryday: unbreak rendering with AsciiDoctor

=EB=A7=88=EB=88=84=EC=97=98 (1):
  asciidoctor: fix user-manual to be built by `asciidoctor`

 Documentation/Makefile        |  2 +-
 Documentation/giteveryday.txt | 17 +++++++++--------
 Documentation/user-manual.txt |  8 ++++++++
 3 files changed, 18 insertions(+), 9 deletions(-)


base-commit: e05806da9ec4aff8adfed142ab2a2b3b02e33c8c
Published-As: https://github.com/dscho/git/releases/tag/asciidoctor-fixes-v=
1
Fetch-It-Via: git fetch https://github.com/dscho/git asciidoctor-fixes-v1

--=20
2.11.0.rc3.windows.1

--8323329-1493540345-1483373034=:3469--
