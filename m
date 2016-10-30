Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D548420193
	for <e@80x24.org>; Sun, 30 Oct 2016 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755016AbcJ3TVa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Oct 2016 15:21:30 -0400
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:50085 "EHLO
        dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750846AbcJ3TV3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Oct 2016 15:21:29 -0400
X-AuditID: 12074423-1a3ff7000000298a-31-581648348834
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 9B.97.10634.43846185; Sun, 30 Oct 2016 15:21:26 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id u9UJLOff023951;
        Sun, 30 Oct 2016 15:21:24 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u9UJLLow009827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 30 Oct 2016 15:21:22 -0400
Date:   Sun, 30 Oct 2016 15:21:21 -0400 (EDT)
From:   Anders Kaseorg <andersk@mit.edu>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside
 scripts
In-Reply-To: <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu> <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixCmqrWvmIRZhMOeZgMXCuZeYLdY+u8Nk
        0XWlm8miofcKs0XnzCXsDqweF7ZOYvHYOesuu8fFS8oefXens3l83iQXwBrFZZOSmpNZllqk
        b5fAldH88zFrQQN7xd05yxgbGK+zdjFyckgImEhM/fgJzBYSaGOSOHJGv4uRC8jeyChxYuUO
        FghnN5PEvA9XmUGqWAS0JWb27mQBsdkE1CQ+HP0K1M3BISLgKXFkrRFIPbPAfEaJn3fegcWF
        BfwkVi1zASnnFAiUuHu7nQnE5hXwkGj6/5YdYn4vo8SCd81gCVEBXYlD//6wQRQJSpyc+QRs
        F7OAusSBTxcZIWxtifs329gmMArMQlI2C0nZLCRlCxiZVzHKpuRW6eYmZuYUpybrFicn5uWl
        Fuma6eVmluilppRuYgQFOLuL8g7Gl33ehxgFOBiVeHgjpMUihFgTy4orcw8xSnIwKYny7ncU
        jRDiS8pPqcxILM6ILyrNSS0+xCjBwawkwuvvAFTOm5JYWZValA+TkuZgURLn/e/2NVxIID2x
        JDU7NbUgtQgmK8PBoSTB6+sO1ChYlJqeWpGWmVOCkGbi4AQZzgM0nBmkhre4IDG3ODMdIn+K
        UZfj3eZ3D5iEWPLy81KlxHmd3ICKBECKMkrz4OZAEpODxCtGcaC3hHlrQEbxAJMa3KRXQEuY
        gJakFYqALClJREhJNTAm7e1RLDzLMe3qghM74jQuuXGz5xldM/ubYuvc7hA6+1m+SOXunV+W
        rtswd0JY2LGuimorvVabbqOib5v/rXzkxrjdeuLzuDPvrzGdOXrG++p83mObjZl27tVzErab
        mDaT4YLZ1bDGqapW1te5uCrnFoQ/C/W9MXmF6pSHbUYr1l1rnF5Rf/qnEktxRqKhFnNRcSIA
        ls4a/icDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Oct 2016, Ævar Arnfjörð Bjarmason wrote:
> This seems like a reasonable fix for this issue. However as far as I
> can tell git-sh-setup was never meant to be used by outside scripts
> that didn't ship as part of git itself.
> 
> If that's the case any change in the API which AFAICT is now
> considered internal might break them, so should some part of that be
> made public & documented as such?

It is documented (Documentation/git-sh-setup.txt), and this is not the 
internal Documentation/technical section of the documentation, so my 
default assumption would be that everything shown there is intended as 
public.  I only bring this up as a question because it was apparently 
allowed to break.  If I’m wrong and it isn’t public, other patches are 
needed (to the documentation and to its users in contrib).

Anders
