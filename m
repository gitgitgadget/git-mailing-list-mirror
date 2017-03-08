Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92BD202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752818AbdCHMzm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:55:42 -0500
Received: from [195.159.176.226] ([195.159.176.226]:52252 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751720AbdCHMzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:55:41 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1clb6T-0006F2-Mx
        for git@vger.kernel.org; Wed, 08 Mar 2017 13:54:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: diff.ignoreSubmoudles config setting broken?
Date:   Wed, 8 Mar 2017 13:54:02 +0100
Message-ID: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Cc:     Stefan Beller <sbeller@google.com>
X-Mozilla-News-Host: news://news.gmane.org:119
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

with

$ git --version
git version 2.12.0.windows.1

I'm getting

$ git config --global diff.ignoreSubmodules all
$ git diff
diff --git a/scanners/scancode-toolkit b/scanners/scancode-toolkit
index 65e5c9c..6b021a8 160000
--- a/scanners/scancode-toolkit
+++ b/scanners/scancode-toolkit
@@ -1 +1 @@
-Subproject commit 65e5c9c9508441c5f62beff4749cf455c6eadc30
+Subproject commit 6b021a8addf6d3c5f2a6ef1af6245e095c21d8ec

but with

$ git diff --ignore-submodules=all

I'm getting the expected empty output.

I can reproduce the same on Linux with "git version 2.11.0". Am I missing something, or is this a bug?

Regards,
Sebastian

