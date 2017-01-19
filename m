Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C7220A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932107AbdASUcG (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:32:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:53927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754308AbdASUai (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:30:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6B6s-1cK5y20fPe-00y7f5; Thu, 19
 Jan 2017 21:30:28 +0100
Date:   Thu, 19 Jan 2017 21:30:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH v6 0/3] Turn the difftool into a builtin
In-Reply-To: <cover.1484668473.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1484857756.git.johannes.schindelin@gmx.de>
References: <cover.1484668473.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:23A++rJAkCFXYQ5hB2/s+6LjqIA3sEinflzQrOe6SuQgkOSI6wb
 6e6jHFV/N2SgFEoUplPuchwoWB97yXIt++mL6cuLsFcWcdDR4YSL1H53eghUvnKBpNcHWIl
 h3mvDewBjNKoBCvETPqlwmzET6T29p8YlY43Y7jm9BILG2ftoz4etcapnQHCJiqpUKhHZje
 xqWrbXv1egZ/ZVaTPxEGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qnh7kz7dCQE=:l18AN5RIlCL4A1m3Db4EVt
 fQ8CiIHfGv6JiXUvpMrWKoXh5ThkfINpsMFV8XX2Cs6xP2gQt0xLdwrXtVnoWX3Lvofe4fup1
 CiVpzduOY9qzdR0cbqCISCY5bRWnioZUtWjtNBy4T43/xT7cse66ePLq4cDnUC5uC8vKFPEJh
 WBcVPUBUCu3HZxyrDwmkkBy7LGeJc+AMgfi+zz3ReFr2X1NtRJmeMYNyJby87BTLnCqaWlEC3
 E9OoklJQxrpiqqvSSUmTLdeWkj8p0TGkd9xLXgd2gF3uQgSXk3hZWWWgF26cjz3KdOTW2Yy9C
 sYGJpQbY7aEUPOzWUSoeYBqGqlRHHHBFPV++gRNKohOvez+34YfBGb16cc5gWxyw+qExFjnH7
 oWMjG0cEllJRDH3Kt+eJsiyJ6cJX9BAYnkiTRX2cWp6KeNKWtN3nhoCNThEgwBOL3Ylm77JIf
 CSYahYYr18Rby0Gk6du1KLXv/H7Yirf4T+8oGlWqA0JUY76q6UlUEOOfJZcEoOXhzmiQKSo+T
 09NdyOE3CldfCpRtJGpnEfLswoJsfH7KnnHvP3saqyRKbJViIEVSAqBZWzNWOmK4ydvUzVaxJ
 g5lsVzVxVYpJ5b2uhPMwVI9Izpyxt9Jl8CdtXbofRgX4eLFzhCubnlNR0ur96oi0W+BNjZCTB
 YtU0ETHhbL/Pr/nQUkMRoZBD5pKKT/scEQlhAWV2f5BqJFK/TC31JvB+64YbnX6cqiAxQCJoz
 gEJ6eFNs+CdLrEGb7GS/cnvSCtqdO3sH3rPSSDBO7hPrcu7dZbw6eXQW1X7tnRTGpuNSHBSiB
 iVJujFXyZ3JG6GYLNKgT7eVfWN6svRlXun7sF+tnXftBvDraOC5fe4J2dCiNZEPSPhQ8pXx50
 vkS3tKrjptTFFnkLTvzT9rj1r2JIWkPeYiD/k9i3FhKRDISn550gJ4vmbYF0jjsoligTFIFwP
 48r/kJLULcGztuK64q5EhEd7nJI/F8qhNkmWFBXt4RXwRnSMloaqzXZWUS2c0pMA2lvPsYNz4
 3JsP/Lpcn83QwxCWZJllYJU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series converts the difftool from a Perl script into a
builtin, for three reasons:

1. Perl is really not native on Windows. Not only is there a performance
   penalty to be paid just for running Perl scripts, we also have to deal
   with the fact that users may have different Perl installations, with
   different options, and some other Perl installation may decide to set
   PERL5LIB globally, wreaking havoc with Git for Windows' Perl (which we
   have to use because almost all other Perl distributions lack the
   Subversion bindings we need for `git svn`).

2. As the Perl script uses Unix-y paths that are not native to Windows,
   the Perl interpreter has to go through a POSIX emulation layer (the
   MSYS2 runtime). This means that paths have to be converted from
   Unix-y paths to Windows-y paths (and vice versa) whenever crossing
   the POSIX emulation barrier, leading to quite possibly surprising path
   translation errors.

3. Perl makes for a rather large reason that Git for Windows' installer
   weighs in with >30MB. While one Perl script less does not relieve us
   of that burden, it is one step in the right direction.

Changes since v5:

- reworded the commit message of 2/3 to account for the change in v4
  where we no longer keep both scripted and builtin difftool working
  (with the switch difftool.useBuiltin deciding which one is used).


Johannes Schindelin (3):
  difftool: add a skeleton for the upcoming builtin
  difftool: implement the functionality in the builtin
  Retire the scripted difftool

 Makefile                                           |   2 +-
 builtin.h                                          |   1 +
 builtin/difftool.c                                 | 692 +++++++++++++++++++++
 .../examples/git-difftool.perl                     |   0
 git.c                                              |   1 +
 t/t7800-difftool.sh                                |  92 +--
 6 files changed, 741 insertions(+), 47 deletions(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => contrib/examples/git-difftool.perl (100%)


base-commit: ffac48d093d4b518a0cc0e8bf1b7cb53e0c3d7a2
Published-As: https://github.com/dscho/git/releases/tag/builtin-difftool-v6
Fetch-It-Via: git fetch https://github.com/dscho/git builtin-difftool-v6

-- 
2.11.0.windows.3

