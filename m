Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E5E1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933015AbdC3ISL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 04:18:11 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53241 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932763AbdC3ISJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 04:18:09 -0400
X-AuditID: 1207440f-129ff70000003517-e6-58dcbf3f66a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.EE.13591.F3FBCD85; Thu, 30 Mar 2017 04:18:07 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2U8I46s019037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 04:18:05 -0400
Subject: Re: [PATCH v5 2/6] dir_iterator: refactor state machine model
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-3-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8838e12a-41b9-fd31-da2c-12352fd374b8@alum.mit.edu>
Date:   Thu, 30 Mar 2017 10:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-3-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1LXffyfCoLNX3+Lxp7dsFl1Xupks
        GnqvMFt0T3nLaLF5czuLA6vHzll32T0WbCr1uHhJ2ePzJrkAligum5TUnMyy1CJ9uwSujFs/
        uhgLvjBVnOiewNLAuJGpi5GTQ0LAROJ6+yXmLkYuDiGBHUwSXxe+ZgRJCAmcZ5K4d0y0i5GD
        Q1jATaLpKx+IKSJgLXF9jRdERbnEtcmX2EBsZgEbieNNvWCdbAK6Eot6msHG8wrYS+xbsAos
        ziKgKnFr00sWEFtUIERizsIHjBA1ghInZz4Bi3MKOEo8PHaLHWKmnsSO679YIWx5ie1v5zBP
        YOSfhaRlFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQICVz+
        HYxd62UOMQpwMCrx8FasvR0hxJpYVlyZe4hRkoNJSZR389w7EUJ8SfkplRmJxRnxRaU5qcWH
        GCU4mJVEeO0WA+V4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8VfuA
        GgWLUtNTK9Iyc0oQ0kwcnCDDeYCGC4HU8BYXJOYWZ6ZD5E8x6nLcOH7gDZMQS15+XqqUOC8X
        SJEASFFGaR7cHFjCecUoDvSWMG8LSBUPMFnBTXoFtIQJaIm4zS2QJSWJCCmpBsZ+39kp6TVv
        Hx2r1qlYPS39zMOuXqmqpY9UOiR0Iu+y+9xVDdCqDfMTOZfFXXVgm2yz0BQ5Rbb9KSkfExw6
        f8ROz+9aNGGbiOOZRx/3OF76cDBsi+gEk63fXqzPkb8kxDHl4aygwF7nN7ZTJaxkSq8rnzf5
        lfBi6tX0TJcrAdOsfot3v7P6sF2JpTgj0VCLuag4EQBMZtexEwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Remove the "initialized" member of dir_iterator_level. Replace its
> functionality with a DIR_STATE_PUSH state in the
> dir_iterator_level.dir_state enum.
> 
> This serves to remove a redundant property in the dir_iterator_level
> struct and ease comprehension of the state machine's behavior.

Nice.

Michael

