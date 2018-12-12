Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12B520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 08:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeLLIYE (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 03:24:04 -0500
Received: from [195.159.176.226] ([195.159.176.226]:48105 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeLLIYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 03:24:02 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1gWzm9-0007qu-Hi
        for git@vger.kernel.org; Wed, 12 Dec 2018 09:21:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Issues with gitattributes pattern matching
Date:   Wed, 12 Dec 2018 09:23:50 +0100
Message-ID: <puqgen$t0m$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

after reading though [1] and [2] again, I believe a pattern in 
.gitattributes like

     */src/*/assets/**/*-expected-* text eol=lf

should match a committed file at

     reporter/src/funTest/assets/NPM-is-windows-1.0.2-expected-NOTICE

In other words, "**" should be able to match "nothing", but it doesn't 
seem to do in my case.

To cross-check, assuming that ls-files supports the same patterns, running

     git ls-files "*/src/*/assets/**/*-expected-*"

indeed does not list the committed file at

     reporter/src/funTest/assets/NPM-is-windows-1.0.2-expected-NOTICE

for me. Tested with Git 2.20 on Windows and Git 2.19.2 on Linux. Is it a 
documentation error or a bug in Git?

[1] https://git-scm.com/docs/gitattributes
[2] https://git-scm.com/docs/gitignore#_pattern_format

-- 
Sebastian Schuberth

