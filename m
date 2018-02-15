Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEFC1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 00:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032283AbeBOA3d (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 19:29:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:49309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032127AbeBOA3a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 19:29:30 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0M0LtB-1eVh6X2sOr-00ud4N; Thu, 15 Feb 2018 01:29:24 +0100
Date:   Thu, 15 Feb 2018 01:29:23 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Teach `git apply` to accept Subversion-generated diffs
Message-ID: <cover.1518654532.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ng80sG0TV2qMt2KEbHMI9LcPYCrWAkjlaOgnx28DduO5LkViCg+
 B+UU60jIoexq0auD+9oDrGhjC6Ovxwqsk6r5CIA/YRsXV57OYiGnDyuEVOZjTjrxTwIbBtv
 Rq8LdKccwXhMvNWxMygFVWk4p6ey1hsKTb77NB39fg3gWLEr9e1GhHJHhFJygxumLowC2vk
 FXSJEuo04RDW3pEhKSwBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X6Cn42DFpBU=:cZAPagf9P6mjkamRwPpy+B
 5cavweNR9mICbph2UMQQrUJLw0JICbakyWk3VTyhfZXP4pfFkO6eXem6bGKhgaqYNObREXRwD
 zUdqBa1sIHw8fMdWhpZiACvKciu942rydEiWNnGZ4mXkHTMbYfVYSOWDCNHSm+mtlxf05H6IW
 nqUkaTpWWU7ssfwblGRl3v1cT+OFMpCBoAxNRZYPXRqEsAA9fCkidnMtNQOkzAyL33D5FUPTF
 97zO+eVWS3Gx/1MLYaV5F4N2nl894kS+IVr4DCm3ag8V6+CKU28v1kW97r3ob0UY37zhBHvRo
 TbifnNHEzFL/Lo0+V90bSi7Bm/jPXLBeRHChiu1Mcfh9KyqNSMKM1HsbuZGoIkwHI7Umex9Tf
 TY03P2ZGd9647/DCDFLjpGXcKJKsVhATb9PLlOC8P3f8Bt8x05R8DWqd3SA4LkRZ/YHxK+/Yo
 oDFbx41Ab1aUy1pzXRQpnbyMR7FkfFSm+Ff6O5Rd3hSOuyCEbf2nFv5QRLf0wVj+RB9FyDYke
 AA9pQk4H7OGLb/sjD+Cy2i2MBjEooRn5ldTx5yL5QYtLUa8n14QJNQtUBJKkFiN97AZPUu/l1
 Pq73vGyK2VY2cHA3jWoMWLofH78Vg5x3oNTpfBwTb01N8AHbjEzxUusruHKDOzA8d/ijR/TFa
 g/+xdti9nXYV0+wikKe6FMN4Fp6TQZgvIFrHuMEqqa5BKOkwwH8cs/kZNCMyInk3Gd/JXT5Cg
 HsUbs3i5qPl4/1tH6YZ9Q2q4E0dAXUvZ0kNiDlj2twgAJhVTqwTs//TdBjmDkVk82GFk9wJvi
 aHyvESH8AXBcOJX6n9QsTLlzCTr4TUgmthy99NLxfO31OQDtJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They are accepted already, almost. With one exception: the ---/+++ lines
contain not only the file names, but continue with a TAB and then the
revision (or "working copy" or "nonexistent") in parenthesis.

We already handle these lines, except in the case of /dev/null. Let's handle
the case gracefully where the diff contains a "--- /dev/null" line with a
trailing comment.

This contribution came in via Pull Request to Git for Windows, from a first
time contributor! Yes!


Johannes Schindelin (1):
  apply: demonstrate a problem applying svn diffs

Tatyana Krasnukha (1):
  apply: handle Subversion diffs with /dev/null gracefully

 apply.c                          |  2 +-
 t/t4135-apply-weird-filenames.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)


base-commit: b2e45c695d09f6a31ce09347ae0a5d2cdfe9dd4e
Published-As: https://github.com/dscho/git/releases/tag/apply-svn-diff-v1
Fetch-It-Via: git fetch https://github.com/dscho/git apply-svn-diff-v1
-- 
2.16.1.windows.1

