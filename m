Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460AC1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeISFki (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:40:38 -0400
Received: from avasout06.plus.net ([212.159.14.18]:55809 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:40:37 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2PzngDyfIWLW22PzpgvGBf; Wed, 19 Sep 2018 01:05:33 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8 a=x21WTL4w0CHmfyqu34IA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH 0/9] hdr-check
Message-ID: <466296e7-6462-d5c1-2d57-2a636309054c@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFvMfR36Ocmyev0uljKR4QKDCz2BuFKpaeHLe0RMA/+BkXEIhTOrEBkW/Z1rgrs8NOv1hgBoodVBm/iy4P0Cm0GtyMmxUIQT3t6AfOS2xLz+cQM6pM0H
 L49h6kUl39YOD3Zm40TzNu+aw0j0Am3eB6kwbSlDwprdDKY1hrLHQIc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



This series follows on from a quick "just before bedtime" exercise
recently[1]. The new 'hdr-check' target essentially automates what
Elijah did by hand. I tend to run:

  $ make -h hdr-check >hcout 2>&1
  $ vim hcout

... and I only just realised that if somebody wanted to add this to
an travis CI job (it won't be me), then it would be a good idea to
add '-Werror' to the compiler command; otherwise 'make' would not
exit with an error if the compiler only issues warnings.

This series was built on the current 'master' branch (@2d3b1c576c),
although patches #1-6 apply on v2.19.0. (The last three patches used
to be on 'next' until last night!).

If I merge this to 'next', I have to add an additional patch for a
clean 'hdr-check'. Exactly the same comment for the current 'pu'
branch.

[1] https://public-inbox.org/git/b8553a50-6b97-2b45-2f7b-cfe2576548cb@ramsayjones.plus.com/

ATB,
Ramsay Jones

Ramsay Jones (9):
  Makefile: add a hdr-check target
  json-writer.h: add missing include (hdr-check)
  ewah/ewok_rlw.h: add missing include (hdr-check)
  refs/ref-cache.h: add missing declarations (hdr-check)
  refs/packed-backend.h: add missing declaration (hdr-check)
  refs/refs-internal.h: add missing declarations (hdr-check)
  midx.h: add missing forward declarations (hdr-check)
  delta-islands.h: add missing forward declarations (hdr-check)
  commit-reach.h: add missing declarations (hdr-check)

 Makefile              | 12 ++++++++++++
 commit-reach.h        |  5 +++--
 delta-islands.h       |  4 ++++
 ewah/ewok_rlw.h       |  2 ++
 json-writer.h         |  2 ++
 midx.h                |  3 +++
 refs/packed-backend.h |  2 ++
 refs/ref-cache.h      |  3 +++
 refs/refs-internal.h  |  4 ++++
 9 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.19.0
