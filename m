Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574EC1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756472AbcKVRB1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:01:27 -0500
Received: from mout.gmx.net ([212.227.17.21]:49470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755346AbcKVRBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:01:25 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1cQDay2514-00JKyg; Tue, 22
 Nov 2016 18:01:18 +0100
Date:   Tue, 22 Nov 2016 18:01:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Show Git Mailing List: a builtin difftool
Message-ID: <cover.1479834051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QYcdPNFOLMefjqjO7WvlfNAIlWZi4NgIaaso/fJqLCyST4S4Arl
 /xOGx7qgNusL0z+jXxep0d4O5s4sEVd8IkTA7s+wBHeuvOGH71FJXb+Xv7tj5h79I2GQvdk
 SX3QEzDc7s7intupkpvGEFDcUk9xtPbVUjpswgNL/y0it02AWaCvV0QNhLhqdKWBpYIO3yY
 um+zKQJHwVG2G3rlLtbBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PzqaJ6RKvE0=:20D+HkcOX4aWw6xz+wCHvp
 TBrKpbmA9PlHZ6bVc02HmwiS7/Fn+hu7nGdXCU+0sn1GxPOh7L/kOAjdyr4xZCjm1Yz/XkVjf
 NT+UhCUKyPG6HsOP7kRB83Zmx421+u6wSOBaNTvVCBnw83Jz+LlQUHtdBfOzuH/xZr/SQe1od
 Bm9c0mI/rRJinLk0AELexWFMIBuRSoIgq4wkpLM9holu9zPqULzRjm+/bVJIBdlTp3jN5yqK3
 KMpvHElEOjuhIo8UghH288Oq3aySQwZGrtm3MU0o55BRwm1NfG2guFDNhzUIdkx0762Z8pXml
 nMNgyzXWMYYvpygrLnB8w4AsSuyzJP31Ke9jnE8ToEUsdfyFqyYnZrFGIJ/I36ZUhuxYmRmgx
 nAZI3Y+4pZ7AYuM8aVRcGY33EzKb6wAnq1OOwR8BPbWIeb4gKvUjByJTa6OCCE+PtpHb8T7Ap
 sR9JV3d63eLjhASpkYKe0jrSlqHxPph/0EACi8tHUo3Txd9HyobfgY43ykOhzo7aNYFTupN5a
 rxxQG1TqR+lVbh+IF1EOZqErk897maLpG+PSgWmtEHxMwxUIQWo5ffSZzMcieWKBPykgEeCVg
 dCbuW9gpikxOuQRCnFkhQsHQcEeYCQBBHQYhMDF5guEgcftri7LClTVtjLwWjdaGL2z+KaOzi
 jY98exmW5mYXiGAal6xFxBfjJmCP+zmTG1JI+rAhlcFwljuzqWVpe9AwUhKKU0mVx5r5JnXe9
 sygUhpIpqwtRQgoMpNz6QOjRzML3a2M9+zuK/nZyvOxpBZ0XZblaF/2KSVlXG8Jm2Jr9dMTBg
 ypjbDja
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been working on the builtin difftool for a little over a week,
for two reasons:

1. Perl is really not native on Windows. Not only is there a performance
   penalty to be paid just for running Perl scripts, we also have to deal
   with the fact that users may have different Perl installations, with
   different options, and some other Perl installation may decide to set
   PERL5LIB globally, wreaking havoc with Git for Windows' Perl (which we
   have to use because almost all other Perl distributions lack the
   Subversion bindings we need for `git svn`).

2. Perl makes for a rather large reason that Git for Windows' installer
   weighs in with >30MB. While one Perl script less does not relieve us
   of that burden, it is one step in the right direction.

This pair of patches serves two purposes: to ask for reviews, and to
show what I plan to release as part of Git for Windows v2.11.0 (which is
due this Thursday, if Git v2.11.0 is released tomorrow, as planned).

The second patch really only explains how I will make sure that the
builtin difftool will only affect users who want to opt in to testing.


Johannes Schindelin (2):
  difftool: add the builtin
  difftool: add a feature flag for the builtin vs scripted version

 .gitignore                 |   2 +
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/builtin-difftool.c | 680 +++++++++++++++++++++++++++++++++++++++++++++
 git-difftool.perl          |   7 +
 git.c                      |  21 ++
 6 files changed, 712 insertions(+)
 create mode 100644 builtin/builtin-difftool.c


base-commit: 1310affe024fba407bff55dbe65cd6d670c8a32d
Published-As: https://github.com/dscho/git/releases/tag/builtin-difftool-v1
Fetch-It-Via: git fetch https://github.com/dscho/git builtin-difftool-v1

-- 
2.10.1.583.g721a9e0

