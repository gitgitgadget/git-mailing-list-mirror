Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12901F404
	for <e@80x24.org>; Tue, 13 Feb 2018 22:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965987AbeBMWlR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Feb 2018 17:41:17 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61637 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965942AbeBMWlP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Feb 2018 17:41:15 -0500
X-AuditID: 1207440f-ab7ff70000000ab0-f7-5a836988470c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 89.3A.02736.989638A5; Tue, 13 Feb 2018 17:41:13 -0500 (EST)
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com [209.85.223.172])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w1DMfB4l020094
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 17:41:12 -0500
Received: by mail-io0-f172.google.com with SMTP id d13so23069634iog.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 14:41:11 -0800 (PST)
X-Gm-Message-State: APf1xPCNK3qX5BUV6fbfokRnPoOriTBS9h9hInBI9fRs9RQlv6rjscza
        R5btJDP0NLYcR5s4dt+LYK5gDJ1zpAs6Y07QVQ4=
X-Google-Smtp-Source: AH8x225oTZqqRgCqFCw1rJ5eTMH+4NSM8hJ8fjebeOeh1vyoGeyf3OT+XmP95mOKWlwXKJ6+VfXswbRObXsxXTIB1FI=
X-Received: by 10.107.27.138 with SMTP id b132mr3181012iob.205.1518561670927;
 Tue, 13 Feb 2018 14:41:10 -0800 (PST)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.158.73 with HTTP; Tue, 13 Feb 2018 14:41:10 -0800 (PST)
In-Reply-To: <CAOmC-AnXD=eSphS=TK4v72tSYDYEV2cgu_EsP4kgNGR=7yre8w@mail.gmail.com>
References: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
 <20180213160824.GA5203@sigill.intra.peff.net> <CAGZ79kYXStMQCxnVjpV7n7miZEDAw4moR+0JksgTaRqHJwgSqw@mail.gmail.com>
 <CAOmC-AnXD=eSphS=TK4v72tSYDYEV2cgu_EsP4kgNGR=7yre8w@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 13 Feb 2018 23:41:10 +0100
X-Gmail-Original-Message-ID: <CAMy9T_FHhXMJTTHR3jg-SGab-1Rgy3FScMxeCUcUjnPfCZEJiw@mail.gmail.com>
Message-ID: <CAMy9T_FHhXMJTTHR3jg-SGab-1Rgy3FScMxeCUcUjnPfCZEJiw@mail.gmail.com>
Subject: Re: make git diff output easier to read - use better diff heuristics
To:     =?UTF-8?B?zqPPgM+Nz4HOv8+CIM6SzrHOts6xzq/Ov8+C?= 
        <sbazaios@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqNuZ2RxlMGW/vkXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDL+PFzNUnCeu+JZ+13mBsYDnF2MnBwSAiYSG9deYuti5OIQEtjB
        JLH26zsWkISQwFMmiTlf6yES/YwSszb0sXcxcgB1lEusmuwN0Vwkcf7yMjYIu1TizfPT7CA2
        r4CgxMmZT6DmyEm82nCDEcL2klg7pwMszikQKDH/dTMzxPweJokpX1aAFbEJ6Eos6mlmArFZ
        BFQlPl5+ywqxIFHifvNGZogFARJ3598AqxEW8JU4sGQm2GIRAU+JJzObmEHuZBZIlVjwrx4k
        zCygKdG6/Tc7hK0tsWzha+YJjKKzkJw6C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+bl
        pRbpmujlZpbopaaUbmKExAL/Dsau9TKHGAU4GJV4eDe8aooSYk0sK67MPcQoycGkJMrL/B8o
        xJeUn1KZkVicEV9UmpNafIhRgoNZSYQ34T5QjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1
        OzW1ILUIJivDwaEkweuS0RwlJFiUmp5akZaZU4KQZuLgBBnOAzRcGKSGt7ggMbc4Mx0if4rR
        nuPbrAdtzBx/9oLIb9OeA8kbL163MQux5OXnpUqJ815MB2oTAGnLKM2DmwxLc68YxYEeFeZN
        AxnOA0yRcLNfAa1lAlqrq90IsrYkESEl1cC4fMvCw+t2Z0Z6MXrHTrhwsWitwMrwwoInvKk3
        tTcxRy4NXVrTs09o9cENH3P5U2yvZ/zSrF1dNmmSToTs/Hmce6OZ/jO8X7b2R4f8STaf7wpV
        z+Q+fJ0/IapQObplhg7zwWfvGW8ftovXstp3nrXk46TDx1fcsbZimPLtZdr2mTPu7H+7jedZ
        tRJLcUaioRZzUXEiABl4jz1OAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 7:25 PM, Σπύρος Βαζαίος <sbazaios@gmail.com> wrote:
> While I din't have the experience to express an opinion on this
> matter, I have to say that the --no-indent-heuristic that Jeff
> suggested worked great.
> There were more than a handful of cases that this issue happened in my
> diff file (all were the same: #endif followed by #ifdef).
> Oh, and the language is C indeed.

The "indent heuristic" algorithm that Git now uses by default is
nothing more than that—a heuristic—so it can be fooled. It bases its
decision on the locations of blank lines and the indentations of
non-blank lines. In the vast majority of cases it gives the same or
better results than the old algorithm, but there are some cases, like
yours, where it gives aesthetically less pleasing (though still
correct) results.

The algorithm usually handles C code well, but it tends to be confused
by preprocessor directives, because they are not indented like typical
code. It might be possible to tweak the weights to get it to handle
preprocessor directives better, but that causes it to do worse on
other, more common things like Python code (where blocks are preceded
but not followed by a line with lesser indentation).

Doing significantly better probably would require some amount of
language-awareness, but that's a bigger job than I was willing to take
on.

Michael
