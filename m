Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB98020986
	for <e@80x24.org>; Sun,  9 Oct 2016 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbcJIJ5j (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 05:57:39 -0400
Received: from mout.web.de ([212.227.15.3]:63310 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbcJIJ5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 05:57:38 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M7sga-1ayAQ00uf2-00vLfg; Sun, 09 Oct 2016 11:56:52
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 0/2] convert: stream and early out
Date:   Sun,  9 Oct 2016 11:56:49 +0200
Message-Id: <20161009095649.1886-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3xR56MjlDllHR6CcqMIYEGrSFk1vhMQBwVA+Ko3jp3L2GadHx/x
 oArJbW6CuZoprIgdZ/2HiFytARv3oT5o3KLMWZ3saqUE4unEOlBOoESzc2MPlZB3jN/oB+L
 lbuCuRU9gI/FmAg9skxe/y16X8ZjlLloTRiUekDNIltYbvyxpJbuAhzyeYEK3lFBc+xzv7Y
 1yjEvaR0KmAUDkayyzgtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gbSeE4M2btQ=:hbaTBfPaO7f3Jhl7lJ2u0D
 xO71WYeQw/2Y9ENGC7Fzs1otD87bvGmmBhmBxSwjI9iBTufHJQbrQ8Z5kosZ71ADXJD94gbD5
 Iffj9XH54qjpIw212UD4mxbPSfjed1qmUSpeJ+svYVPJ9Uw2XCM4x0zGSEPZ5vViX4fXKGE6t
 IhR905iv0bRFN+PhKiCkclqwMhSBOfFMzgP/4vcliAZEIJ82C3Bf4Yz1I4yY0JotB8KZ49vp5
 23MPHPcZn4XACBpC+/HJ16uXCsdPera+ZXxgUxhE61nyrbHpnFR6SimfwGja+HnBAmafjihZV
 sRZcsKE9U+l/WtKjAxT5Scd0Af2UV9ZPG/yK0qsaL4V1lkOqbTEB8THgq2uxlequGqMdITNON
 GayKzvelAlKCuwXeU+kU+114VVQQ10HE7dbQpSU9Id88+cGT9Af2VN7KpCcliwiarZGjoVF3o
 kXz+Mq0zqrP3/4C5PqkhjNSO+w9kE61Ex5ZTKUjKoloNIGt6JnZPQii1BSWHkgsk3gAZZX0xT
 86fPvM90L/vslMU9qpWx8+UqpyxssIbhqqDtgKIbdM6qUY8yGFZXsnIvLI/hwLEp0oIv4uAT5
 7XXLBBJU+8gkGAYgRsy4DebLLnU7tOKynaYqZkMWBYu/YqUP/9wXMjyeJkrnN8Bdp3wS6IMJL
 2ftzPSFRMFpDAsRMAUvTotzaIoYsrs8PavloLFur1VS2s8DTWy7hnYvk01wYOas2KfZ452hW+
 ZRXAuyG5OZ9HHSZ5g+xtKcLg23EkXV2kdmzNpd2XKo9YQbNNtDLm8oYll6alKO5Mdk5KdCygP
 +Xymwzi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

An optimization when autocrlf is used and the binary/text detection is run.
Or git ls-files --eol is run to analyze the content of files or blobs.

Torsten Bögershausen (2):
  read-cache: factor out get_sha1_from_index() helper
  convert.c: stream and early out

 cache.h      |   3 +
 convert.c    | 195 +++++++++++++++++++++++++++++++++++++++--------------------
 read-cache.c |  29 +++++----
 3 files changed, 151 insertions(+), 76 deletions(-)

-- 
2.10.0

