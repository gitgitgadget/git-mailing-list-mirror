Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14330C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF1D61053
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKAVeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:34:16 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:27365 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhKAVeM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 17:34:12 -0400
IronPort-SDR: /8HN5u0V/6s5RqgvNlgwtSwNOn50NbeGLkVH+Rq+EbZ33vL1yQ/iphhltyQl77gvnoBlQKI9OL
 vxsRcHjgqSE3mNbIiOCptQhOaKcSlrrJv9QBA6sbLJi70+uqPriAs9bshSXuO8+60vTiJspyN2
 ZboU4G+h+oFMML7swagd9ceFZ2UDikCZNtsiWfDkt+eCkcgI4kYsfIZJU9oLYUOJnOcnLwmFXR
 UnTT+fW6VHbIk/bfjzWrLcGhXJlVKzkyLx9AutzC8uxJm0b+Iak4K+dr1oUljFi6D7oR0WQO79
 YbcVJ9hgWyxFkog6Ft6JBaZ7
X-IronPort-AV: E=Sophos;i="5.87,200,1631606400"; 
   d="scan'208";a="67765910"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 01 Nov 2021 13:31:37 -0800
IronPort-SDR: AqggZ70hZ7ne6ghGXbhp8ZYTOSK3fcBwp71AIzUtLXST/I4o/lxxBaspP2JVGLJCbSnLShqsG4
 i7vqSELD3O3Siip1zqojAEFrcshQZ3hO4Nk9yILzdQLMHV29p4mJ5jd8h1SgGDFUKPDAT7RXEW
 Djo88BgcscRkD8R2eZ/XAglm4ns8/6xWBIezOMilZdnjta7PnHzLPHvJmD7GjmOS+urg4/npG/
 kAPzyZ7S9TG5pyyb42q+x3ViBh+Bgjp5r5DPluZ446/fK4PjmrwzJcURuPt/pOJF1gHKc25QPN
 4J4=
Date:   Mon, 1 Nov 2021 21:31:31 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
CC:     linux-man <linux-man@vger.kernel.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "tech@openbsd.org" <tech@openbsd.org>,
        Klemens Nanni <kn@openbsd.org>,
        Benoit Lecocq <benoit@openbsd.org>, <git@vger.kernel.org>
Subject: Re: Is getpass(3) really obsolete?
In-Reply-To: <fd78c241-c51e-03c6-1e6b-641536245fbd@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111012124460.1978253@digraph.polyomino.org.uk>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com> <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <211029.86r1c43uwj.gmgdl@evledraar.gmail.com> <865e5899-b991-918d-8bc6-ced65a67a566@gmail.com> <alpine.DEB.2.22.394.2110291627330.1788146@digraph.polyomino.org.uk>
 <fd78c241-c51e-03c6-1e6b-641536245fbd@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 30 Oct 2021, Alejandro Colomar (man-pages) via Libc-alpha wrote:

> > See the discussion of deprecation starting with
> > <https://sourceware.org/pipermail/libc-alpha/2021-May/126356.html> (C2X
> > has also deprecated those functions).  The comments in that thread
> > supported marking the functions deprecated, but it needs someone to send a
> > patch and I don't know what breakage might result in applications using
> > those functions.
> 
> Thanks.  The latest draft for C2x that I know of is N2596.  Is there any newer
> draft that I can consult for these things?  I see many proposals, but it's

The latest public draft is N2731, but there are still various accepted 
proposals not included in there, including N2566 (wording version 2) which 
I believe was accepted in October 2020 (I think issue 68 in the (private) 
C standard GitLab, for integrating that paper, has been incorrectly closed 
without integrating it).

-- 
Joseph S. Myers
joseph@codesourcery.com
