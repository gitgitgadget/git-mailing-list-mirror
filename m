Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D0F1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 08:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404439AbfHBIr4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 2 Aug 2019 04:47:56 -0400
Received: from mx.sdas.de ([88.198.162.67]:48952 "EHLO mx.sdas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfHBIr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 04:47:56 -0400
Received: from [100.90.158.10] (unknown [37.168.66.42])
        (Authenticated sender: etienne.servais@voucoux.fr)
        by mx.sdas.de (Postfix) with ESMTPSA id 8C0B011C0F0
        for <git@vger.kernel.org>; Fri,  2 Aug 2019 10:47:52 +0200 (CEST)
Date:   Fri, 02 Aug 2019 10:47:51 +0200
User-Agent: K-9 Mail for Android
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Simplify-by-decoration with decorate-refs-exclude
To:     git@vger.kernel.org
From:   =?ISO-8859-1?Q?=C9tienne_SERVAIS?= <etienne.servais@voucoux.fr>
Message-ID: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I've asked this question yesterday on stackoverflow: 
https://stackoverflow.com/q/57305719/2622010
And have been confirmed it does look like a bug. 
Unfortunately I'm unable to update to latest git revision but a search through the release notes didn't show anything related to this problem. 

I'm working in a git (v2.19.1) repo with lots of tags and branches. To get a glance of the git tree, I'd like to use the `--simplify-by-decoration` option while excluding some of the tags with `--decorate-refs-exclude=<pattern>` of `git log`, but, as per [the documentation](https://git-scm.com/docs/git-log/2.22.0#Documentation/git-log.txt---simplify-by-decoration):

> --simplify-by-decoration
> 
>     Commits that are referred by some branch or tag are selected.

Thus every tags are selected even those that are excluded from the decoration by the pattern.

Thus, when I enter

```
git log --oneline --graph  --decorate=full --decorate-refs-exclude='refs/tags/<pattern>'
```
The selected tags are properly excluded but once I add the `simplify-by-decoration` option

```
git log --oneline --graph  --decorate=full --decorate-refs-exclude='refs/tags/<pattern>' --simplify-by-decoration
```
The excluded tags pop back again.

Is there a workaround?

Étienne
--
+33 6 45 98 22 65
Envoyé de mon appareil Android avec Courriel K-9 Mail. Veuillez excuser ma brièveté.
--
+33 6 45 98 22 65
Envoyé de mon appareil Android avec Courriel K-9 Mail. Veuillez excuser ma brièveté.
