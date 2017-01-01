Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4CD20968
	for <e@80x24.org>; Sun,  1 Jan 2017 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbdAAIl1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 03:41:27 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43679 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752985AbdAAIl0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 03:41:26 -0500
X-AuditID: 12074414-78bff70000004a85-ab-5868c0b3f571
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.C0.19077.3B0C8685; Sun,  1 Jan 2017 03:41:25 -0500 (EST)
Received: from [192.168.69.190] (p57906284.dip0.t-ipconnect.de [87.144.98.132])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v018fLsg021740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 1 Jan 2017 03:41:22 -0500
Subject: Re: [PATCH v3 10/23] log_ref_write(): inline function
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <dba3d081c32854593d8113f9cd604a9891748bcd.1483153436.git.mhagger@alum.mit.edu>
 <xmqqzijb4jky.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <0b62220b-141f-2872-65f0-c20d6ec10ed7@alum.mit.edu>
Date:   Sun, 1 Jan 2017 09:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqzijb4jky.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsUixO6iqLv1QEaEwZon3BZdV7qZLBp6rzBb
        LHn4mtniR0sPswOLR1f7ETaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugSvj2caTzAWf
        GCse7r3F1sB4kLGLkZNDQsBEYsW/A+xdjFwcQgKXGSXO/L7JBuGcY5J4+fkEC0iVsICdxNcZ
        79hAbBEBNYmJbYfA4kICOxklLq+NBbGZBeIl/q44xApiswnoSizqaWYCsXkF7CUmLdoAto1F
        QEXi2ZFWZhBbVCBE4vKco2wQNYISJ2c+AZrJwcEpYC1xaVkNxEg9iR3Xf7FC2PIS29/OYZ7A
        yD8LSccsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iREStCI7
        GI+clDvEKMDBqMTD2/A7PUKINbGsuDL3EKMkB5OSKG/ChowIIb6k/JTKjMTijPii0pzU4kOM
        EhzMSiK8unuBcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKEryB+4Ea
        BYtS01Mr0jJzShDSTBycIMN5gIYn7gMZXlyQmFucmQ6RP8Woy3Hg/YqnTEIsefl5qVLivBNA
        BgmAFGWU5sHNgSWbV4ziQG8J824BqeIBJiq4Sa+AljABLfkalw6ypCQRISXVwNjQvqL+Ibt5
        ec/6a7/XqbFZx/5zOPpU5NqaQ+5JVxkUb7QXTGZfxz89K3eNlUrHzEYpbuk/TDKSzb5X+Bk/
        yKR8b95QVvtpZkiz1I5niUtzyzewrW3zrRW8OyvigMPpm6kz89mlX7Xltdgo3otrUtXQjfog
        XSyybrNi1bobMzI36vUYVG6pV2Ipzkg01GIuKk4EAMnbk6MRAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 03:09 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This function doesn't do anything beyond call files_log_ref_write(), so
> 
> s/call/&ing/; I think.

Thanks; will fix.

Michael

