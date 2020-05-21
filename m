Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163FC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC1F207FB
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sriTfl9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgEUJwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:52:02 -0400
Received: from mout.web.de ([212.227.15.14]:39603 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgEUJwC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054712;
        bh=6xVVG/Ra+KwOoaR0lOjNWQTijiZpMNQmsiAbqN5TAXQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sriTfl9rYc0CvysxDIjFLof0J/zuB+Ocush6HFzZCYueW4u6KVJ7BOs9q6yoCTqsY
         iUHj2YJiNfbiRryJFKvsdalHTj0jGdrCRWNiy35RKHCTZ0axTxZ7GpUTvHcBuCA8VX
         HhtnJQlxoIXv6dCzaB8scKileudX20l0b2AXukGo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeSYJ-1jPGTv39Lz-00Q9EI; Thu, 21
 May 2020 11:51:52 +0200
Subject: Re: invalid tree and commit object
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <xmqq1rnrvj8d.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0dd3b35-5875-8d4a-e078-26c368b81506@web.de>
Date:   Thu, 21 May 2020 11:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rnrvj8d.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N6VUlqs82GyMYg1jbBkowjG1MHStdqkXQbFFQGEajwL0xWcrYC4
 8YvT6Fv8vbR9GDgomttAVo+/UVsTQhY3IzpTycxkZvUn1A6TBrU2S4XvLLRBizHHcRgQG80
 aB4QSi8r3coychdVQhhkA5az7naPyM2gVHqrGkdvEay3FyGubgVnZYKE3WKC6QCwsXhm421
 Oov3usA2dkrP+iVfAVtYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tufkDlD2RDI=:CxLYoXdw4u51Ms47sARj3w
 n/eHip6x0gUK+oaP7HzAPfH50Mo7FFOacQShsKlz7P4zOeLw1NCifPzfpqMo8Pv/5mQ/7u2gO
 i0I2KhUCTchj5iI6/jTpExLw8uG5aWt1uTjfvIcz7ZjeWIhnM+bUJzJRnYGidNd2ds+D306PK
 sH8XLebW9A/dDHQeJO1a/Smlz+7qP7hCtKf7XbbGd4GzngkpuP/+n2Wl8vymY38W9jWT2/rii
 XvnPykUonKaeXjmsogdKsEjqP7pPUXxi6IWbtcq5Fg54seerpWJUbQJGl2o/eiInh4HoUuc8Q
 JL/vp5w5JTDdgp4ED7KpwlTWji7/RYnozTebnfNdThoIIYKqeQxUN3AdLtJhfzsfiYr8vNhQ3
 ta0CtM964FzadfniVCvQV+XIBoTpRl27rINkRK7oMcq+fYIc1QFugg4hYaZ5Jjc0MR7R/ZcgK
 bknfscM1/+ASvTLiC38ne09lkGawAuyVjLkoCnJSB9YRNJAC/1+d05sPKU1i14YRL6deeI2Q4
 NvUyqYZx0nPev70R4mQUYvw09IRcJI/V3T5fyl1O17BPty+B2JxxibbE/O5q6L0OXwjsYvn3/
 VlsZ9/yKwISObsIpe3MejBtc4a8L2DOhPSgBpIsNaO5RsKFK8iyeGbNezRuNeMQJDGN+M2Q6/
 oZq3v2ZlwBWXfhTTxBwiltutFiMfrfCzRSnvhp5m/bZQIOaODF/ZyC3tmQWnqVeQbErJRvkli
 pszqjv4xaFb6VQqgffYF60y5nEgLRivtN88Fx59ewi8b76o2aOU1OUPqspkuCPF2C09SFFNf9
 ShfDTJQSePTPzZrnYvToHO0ruYCb5+4qEaQCXBs0HC/L0ne2WUhL7PrjD9Koav0qG9E08lFja
 xxNwxk1gnbeh89+R8cA5FXUE2gYDAnycW/i+H+l8EklGuoDH4Dr1SRgQp3YaLalyfOFSeWCjS
 ciOpd5iU029zhT2z+TS7fddIt6PYT7zy7i7OPzrwtiw4n07OZ2AQ2thDMW8pcYy51YSxUp3l2
 aZCvzEwR50OkMruiLKStvDK1pxRpS1EPmUWug1zzYui2m20T3/hf/0CRvUXDDNP1nzkYMyGI8
 cdUiW06WcifPZc9t89YOc55qMHbW/3rui/mO/GkVfplV1E+Lgiht2iEk/avMqiIUsvSyweUYe
 TAQXnb2WP6TK1V1xaquMPIEmMoYP+DGU/4lSLbZzZ4KareJ6K4DPPXMwA9ADeBdHuF0HmDRlz
 CIjb+d0wl2XB4MJxU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.05.20 um 18:37 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Would a stack work?  When we see a candidate non-directory, we put
>> it on the stack.  When we see a candidate directory, we compare it
>> to the entry at the top of the stack using strcmp().  Equality
>> indicates a duplicate and we are done.  If the directory name is
>> less then we can pop the entry from the stack and check again, as
>> we're past the point where a duplicate would be.  Makes sense?
>
> Perfectly and quite excited ;-)  I wonder if we can do the same in
> the unpack-trees side.

Walking multiple trees in lockstep should be possible as well.  We may
want to include a bitmap indicating which trees contain the name in the
stack entry, or any other necessary information.

And output of candidates would be delayed until the matching directory
name is either reached or found to be missing, so it can be out of
order.  Sorting like in diffcore_fix_diff_index() is an option if the
order is important and the entries are collected before being used
further.  Not sure if streaming in the right order could be done
efficiently.

But lets see if that scheme works in fsck first.  I'll send a patch for
making testing a bit easier.

Ren=C3=A9
