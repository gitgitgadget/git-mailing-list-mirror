Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CDA1F404
	for <e@80x24.org>; Sun, 31 Dec 2017 08:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdLaIGM (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 03:06:12 -0500
Received: from mout.web.de ([212.227.17.11]:57387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdLaIGK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 03:06:10 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSaZk-1eNxtU0YOC-00RYjY; Sun, 31
 Dec 2017 09:05:52 +0100
From:   tboegi@web.de
To:     peff@peff.net, j6t@kdbg.org, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 0/5] V2B: simplify convert.c/h
Date:   Sun, 31 Dec 2017 09:05:48 +0100
Message-Id: <20171231080548.22215-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.4.ga4e00d4fa4
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:UICf2vhBmhPd9hWj5efBXmljf67j69ooTC+j4pVMYadTvjhF2iF
 rWdCfLuyEnwODxKlKl4mSNCv3zxojLpJByuCPxV0FvzSVa59g6NsOheU8nADmN3tltOK7oF
 ADuYUBooQu1CGDsgfDPMtodjqhu8WXfXOgKAekefucQpNLbWTq6EN5BGxYWXQ1+8eJeAYKh
 z47+Ym+z21OcF4SH+t97g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NrIl3McYQ9M=:dXlDMt/+UGpbPpBJEkQskC
 j6RuAeJUkd1tXqCbuO2ouw9Z7cnjayyXtHwG8KiNPWLigOMdaT+TvpHiZMNDwVuSB4ESB39Pw
 qIDaivWutXOQfF4g76StF3IMUoiVs76uQvUsSHmwOd0AtlXy0r0e+qkrgTwD/5iwNo+aMKUZ4
 r2NvedaVK/ULHUiERxncON0JxVoQMDwuHKWyeXKWN9y0pLQETc2oxuPSqT8iBiTFH+b5AZVGy
 xi8S6K3efXscUKrvbGLH1TQzCL9TvBoOOTVLJbQlkAspp7tEsbdCGLf/FZN8tx95r6dYdR7CP
 JNN7hSIjpTRWGNDoi6dOyyqHerIWWe17BzqF5iaKdvA3pY9tkYdc7zvf4M3OBjTZKjTFI//UI
 Q3lBTorUniDQKM493CFatEveaZgumHlmrTBjjk2IlR4VEYgevEcRRGqrFyuWPZ6apfLqIOns6
 1K5R+b2kSDvruy1S4yIo8qzSPiEFTYsSYMqXMLl1FyLQwd6FobdRJymj7JgVS574Ihj4vxGV9
 Yz0YQW667XJvfgGlOQNWIGph3O+MKj/5jXdea+5QfOggDJj+63ZMZrcXBIwuKTfpAWm6M7tSf
 sRblxcj+hIkkoRt68tdjBBuHaTfiH2fG52/XQeMxLnqHfm78xA79AtHbHFaHLsUObRLzYv3VV
 auXvnRDa/RdAizqkwZTrto7rInV+VkZj8RFGqX6/Ce7uFQcc9yyLTzCMDB5JGNElQfGxxGP41
 kDMnL0rkTXM6Hak+H5E388JqnVJEUO+sPiy+cW6hNucjMslgo72T/OWIS1orrzu/v3ogcp7ky
 /9Lj/TDU2P4NPHdkPHJ70qNmLQDPoY/8+6zxJYGBUWSl/RnZ0U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Simplify the convert.h/convert.c logic amd don't touch convert_to_git()
The rest is v2 from Lars

Lars Schneider (4):
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add support for 'checkout-encoding' attribute

Torsten Bögershausen (1):
  convert_to_git(): checksafe becomes an integer

 Documentation/gitattributes.txt |  59 +++++++++++
 apply.c                         |   4 +-
 convert.c                       | 210 +++++++++++++++++++++++++++++++++++++---
 convert.h                       |  19 ++--
 diff.c                          |   4 +-
 environment.c                   |   2 +-
 sha1_file.c                     |   8 +-
 strbuf.c                        |  13 +++
 strbuf.h                        |   1 +
 t/t0028-checkout-encoding.sh    | 197 +++++++++++++++++++++++++++++++++++++
 utf8.c                          |  37 +++++++
 utf8.h                          |  25 +++++
 12 files changed, 549 insertions(+), 30 deletions(-)
 create mode 100755 t/t0028-checkout-encoding.sh

-- 
2.16.0.rc0.4.ga4e00d4fa4

