Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AC21F404
	for <e@80x24.org>; Thu, 22 Mar 2018 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeCVTzD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 15:55:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46114 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeCVTzC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 15:55:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id s10so9919730wra.13;
        Thu, 22 Mar 2018 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:mime-version:content-language
         :content-transfer-encoding;
        bh=b7rdAFZMD0RxMn4W/oVnA3oM1BzLVBuiu1nVIG5bHKU=;
        b=kj7LKE/7wkUv2Ub/Jjg11zYld3x820bCy0zVNqtEsl6S+sgt9GULwKBLegpSyPN4vz
         GAB7m1LccTOu9yFRbk7EGbLfjUtajpdJXEjdn9m+QR0n5Opcap+eDoAWJ7vkUL8iw5jp
         jj/x7SUffnJ+XZXIY63kW1IVUAGck9A0w6F8pUgb9QhT+kOL1WG6NohnNgXkOcz5ymAY
         skixCPPuko3HQE/+xvQcaBKRkF2x54U69VEsddFYyHAFo9/JYmw0vLbMk8X5kAqM9Qcd
         ndRK+bN/yFc+6L+/Qt18/9MTjRYYxvTSX3bfE6eZnRH70rU+52HYvr1PZHkEevxpGiRw
         eq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=b7rdAFZMD0RxMn4W/oVnA3oM1BzLVBuiu1nVIG5bHKU=;
        b=ttePqothrhTc0mOjmGkw9xtuZUKpyOKU6aqtS2fI5aGb2mZPRF4zyovswfh0AY0bRG
         oXc6cOFPLVP3uPTI/6PXIOuLHoxq+MjeJ5K/1ziKaBq5RZLXq0Pdea1Yt3lIz1h8+y3z
         l7FsKvK42ZhMQBGFs0MwkFe3lupAiedsg+5L/VGCB2bpwT1dvwTlIl7ZGP88PUqoEBFN
         C79ACz9PR+hyI6wLSmiDWnQLH9BzOuf97z+ZMpGh0ektOPUDBUw8i9RRTBp5lnaqWtsI
         RcI6sLnwFtG/CQ6DZanIwmrHlROcIbXSJKAeFGWIxrpaaRkSfbj+pyZEF8WnhUOKRJAI
         c9JQ==
X-Gm-Message-State: AElRT7GUGCBhMH8KmHu6vJzGOrHdgS4tMfHgJo3rtJdDjWpTxYOVw9BN
        tbpTqFOgtB7WvbHaKkMofMQn8QM=
X-Google-Smtp-Source: AG47ELs2WpHfLmc1RgvkP87ZsqGHSIY+9BOqVgZpeA1rHszisO3zXiIhXdzaq5g8cgzynP3bbegSqQ==
X-Received: by 10.223.176.7 with SMTP id f7mr20184543wra.257.1521748500598;
        Thu, 22 Mar 2018 12:55:00 -0700 (PDT)
Received: from localhost ([46.222.248.76])
        by smtp.gmail.com with ESMTPSA id n64sm7196638wmd.11.2018.03.22.12.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 12:55:00 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        git ml <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: git: cover letter and automatic Cc: [was Re: [PATCH 23/45] sched: add
 do_sched_yield() helper; remove in-kernel call to sched_yield()]
Message-ID: <ca4949ba-ed8b-3c99-f3f6-e4feee7bc66c@gmail.com>
Date:   Thu, 22 Mar 2018 20:54:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

> On Thu, Mar 22, 2018 at 10:29 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> But why !? Either Cc me on more of the series such that the whole makes
>> sense, or better yet, write a proper Changelog.
> 
> This is a common issue. We should encourage people to always send at
> least the cover-page to everybody who gets cc'd, even if they don't
> get the whole series.


git should be smart enough to do it automatically by itself.
