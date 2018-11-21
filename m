Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9271D1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbeKVA3L (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:29:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:7348 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeKVA3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:29:11 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id D2F2213F892;
        Wed, 21 Nov 2018 14:54:34 +0100 (CET)
To:     git@vger.kernel.org
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: git grep prints colon instead of slash
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <5d3618d4-8a5a-b4dc-3cc9-4134cd73675a@free.fr>
Date:   Wed, 21 Nov 2018 14:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm using an older version of git, so this particular issue might have
already been fixed.

$ git --version
git version 2.17.1


If I specify the branch to explore, git grep prints a colon instead of
a slash in the path:

$ git grep arm,coresight-tmc master:Documentation/devicetree
master:Documentation/devicetree:bindings/arm/coresight.txt:                     "arm,coresight-tmc", "arm,primecell";
master:Documentation/devicetree:bindings/arm/coresight.txt:             compatible = "arm,coresight-tmc", "arm,primecell";
                               ^
                              HERE

There is no such issue when the branch is not specified:

$ git grep arm,coresight-tmc Documentation/devicetree
Documentation/devicetree/bindings/arm/coresight.txt:                    "arm,coresight-tmc", "arm,primecell";
Documentation/devicetree/bindings/arm/coresight.txt:            compatible = "arm,coresight-tmc", "arm,primecell";
                        ^
                    NO ISSUE


Is this expected behavior?
The spurious colon prevents one from simply copy/pasting the output.

Regards.
