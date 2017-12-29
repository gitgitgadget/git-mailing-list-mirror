Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4F41F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdL2N2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:28:43 -0500
Received: from mout.web.de ([217.72.192.78]:54215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbdL2N2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:28:42 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilJB-1f5dZO2pJt-00cyCb; Fri, 29
 Dec 2017 14:28:27 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 0/2] git diff --UTF-8
Date:   Fri, 29 Dec 2017 14:28:24 +0100
Message-Id: <20171229132824.17551-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <20171218131249.GB4665@sigill.intra.peff.net>
References: <20171218131249.GB4665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/RQQjBBlX2+/+ZaUL+Kxrr3e8wZTHlq+DDYO6Nbhutt03+CQC0h
 vD7aT85ok/9zTV3xVZcN5NwIYQuJM+p1ev/a+sm4Xs0e+jJVP66QAAV4SGyTlDVfJXICrzu
 IDYHg3cx0qsu8HXBoU7MXytR3UPkjirv6ptn18MbnsSIqJlUC7cdfX2IwzWmY9k39ZoUfF9
 1RdC+l9cZRtxTG5cgx2Ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uF0XYPUdzhA=:LeFwGxWSVTUluxelUUY/9+
 gvzo2QtML6lOdTvdpz6t9zb1331P8594SfcFo7yR8P2i/QglUgYj5W+lhxwylu/5sfaQTW75+
 PM958cx5Ga4pbf7BqGlQ/vdRiYAXimfJL1nhNY1saCCi029cJfM6+qTSgMbiSW/QT4gfjOdTO
 c0XPCuWoafoDLrfVvZBJ6Ow2Fw79goh+kXV7NGhA0HHJPJXczmrkTuXz54SjrFmZm4VFlaQ1Y
 RPhxjE0kwDTuU5FJrqgNmjlMPPeKX6BI+eGvglCeve0QQvl3xLZ5gBsMFL2fTYVfETOhDWwXF
 x1bZ03wkJ+ygroj/BZ2Sw0WuA+3b5naOfYp5qSZLm71qt5wt5QD/HB1aJVqeyaG61h7ukj5VT
 4CcZF2hI5HMJcaNr9N6AG1JswB4Jjd7X6fag658DnclZc+FwEL7WvEzQf0/PSjLsa995v5MGX
 qEeQK5QBSobBTGjxpWpMXRBv69ib/xCj+ffnP2ZThciCdvbD3dJMYFJ8iA7Run/CEBxC+C2Vg
 iN8bJoBRichNiOW+EqYSirDQI53AdlwoGMQ8USvfYJEROnQK7Vn7FyXlukIynsRfs+fsAnozv
 or1NBoAl7QKOetsvMqP+lZ/whc4drnboFOk/VlFSQJMTVlbENXlUtSy4+UuGcThylHiEzzHoT
 k69OTVw2PLuXb5Fl9EsCw0HLgb7LiNix0L2IERFL129GoeFDCb8j9C8ML84WHIPOAu80libuj
 MIecQRIQGhMrAt0KXsB1lD187jqhRhaMiFyzYEDWS5bo+6ATKQwm+9u4/8Mtva+Njkt95i6PP
 YwFIM2oSX/sDehWiEMcgRWRHfyEpQeqlINF11o9Yixlp/RKCXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

RFC patch: convert files from e.g. UTF-16 into UTF-8 while running
"git diff".
The diff must be called with "git diff --UTF-8" and the "encoding"
attribute must be set for the file(s).

The commit messages may need some improvements, and a closer look
at diff.c, how command line options are forwared, is appreciated.

It may even be possible to integrate t4066 somewhere...

Torsten Bögershausen (2):
  convert_to_git(): checksafe becomes an integer
  git diff: Allow to reencode into UTF-8

 Documentation/diff-options.txt  |  4 ++
 Documentation/gitattributes.txt |  9 +++++
 apply.c                         |  4 +-
 convert.c                       | 60 +++++++++++++++++++++++-----
 convert.h                       | 20 +++++-----
 diff.c                          | 40 +++++++++++++++++--
 diff.h                          |  1 +
 diffcore.h                      |  3 ++
 environment.c                   |  2 +-
 sha1_file.c                     |  6 +--
 t/t4066-diff-encoding.sh        | 86 +++++++++++++++++++++++++++++++++++++++++
 11 files changed, 205 insertions(+), 30 deletions(-)
 create mode 100755 t/t4066-diff-encoding.sh

-- 
2.15.1.271.g1a4e40aa5d

