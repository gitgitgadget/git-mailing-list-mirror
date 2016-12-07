Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54321FC96
	for <e@80x24.org>; Wed,  7 Dec 2016 01:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbcLGBMc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 20:12:32 -0500
Received: from avasout06.plus.net ([212.159.14.18]:37047 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbcLGBMb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 20:12:31 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id GpCS1u0050srQBz01pCVEG; Wed, 07 Dec 2016 01:12:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=N659UExz7-8A:10 a=uZvujYp8AAAA:8 a=om7oUi9AbzVqUR__wecA:9 a=pILNOxqGKmIA:10
 a=_g4kg8Y8bwcA:10 a=SLzB8X_8jTLwj6mN0q5r:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
Date:   Wed, 7 Dec 2016 01:12:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161207001018.GD103573@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/12/16 00:10, Brandon Williams wrote:
> On 12/06, Junio C Hamano wrote:
>> POSIX cares about treating "//" at the very beginning of the path
>> specially.  Is that supposed to be handled here, or by a lot higher
>> level up in the callchain?
> 
> What exactly does "//" mean in this context? (I'm just naive in this
> area)

This refers to a UNC path (ie Universal Naming Convention) which
is used to refer to servers, printers and other 'network resources'.
Although this started (many moons ago) in unix, it isn't used too
much outside of windows networks! (where it is usually denoted by
\\servername\path).

You can see the relics of unix UNC paths if you look at the wording
for basename() in the POSIX standard. Note the special treatment of
the path which 'is exactly "//"', see http://pubs.opengroup.org/onlinepubs/009695399/functions/basename.html

ATB,
Ramsay Jones
