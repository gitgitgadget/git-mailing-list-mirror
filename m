Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6061F576
	for <e@80x24.org>; Sat, 20 Jan 2018 06:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeATG0J convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Jan 2018 01:26:09 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46917 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeATG0I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 01:26:08 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0K6Q63s012890
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 01:26:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [RFE/RFC] format-patch/diff via path
Date:   Sat, 20 Jan 2018 01:26:02 -0500
Message-ID: <018601d391b7$8e8686a0$ab9393e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdORtexR+P1qoCpBTbmxn0ub4HaLpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I’m still a bit perplexed by some behaviour seen today, and am looking for a clean way to deal with it that the documentation does not make clear. So, I’m asking in a different way. Suppose a graph of

A---B---C---D---E
\      \               /
  \----F—G----/

When trying to perform a format-patch from B to E, I was seeing commits B-A-F-G-E rather than what I wanted B-C-D-E.  F and G were younger commits than C and D, which I assume (very likely wrongly) is why diff was giving preferential treatment to that path.

What I am trying to figure out is whether there is a clean way to force format-patch along the B-C-D-E path. If not, would it be worth starting up a small project to make this possible (not knowing exactly where to start), but I would envision something like: git format-patch –via=C B..E

I may be just missing something obvious (new to format-patch operations myself). 

Cheers,
Randall
P.S. Bad ideas happen when tests run for a long time 😉


-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



