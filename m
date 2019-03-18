Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEFD20248
	for <e@80x24.org>; Mon, 18 Mar 2019 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfCRHCy (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 03:02:54 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:35413 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727805AbfCRHCy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Mar 2019 03:02:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 13E5C18224B89;
        Mon, 18 Mar 2019 07:02:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: price89_53407a36ee249
X-Filterd-Recvd-Size: 1823
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Mar 2019 07:02:51 +0000 (UTC)
Message-ID: <e2c7cc07618ecc753fe5939a90b562c97885af39.camel@perches.com>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Baruch Siach <baruch@tkos.co.il>, git@vger.kernel.org
Date:   Mon, 18 Mar 2019 00:02:50 -0700
In-Reply-To: <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
         <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
         <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
         <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2019-03-18 at 15:28 +0900, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > My preference would be for correctness.
> > I presume something like this isn't too onerous.
> 
> I am guessing that /^---/ is to stop at the three-dash line *OR*
> after the initial handful of lines of the first diff header (as the
> last resort) and that is why it is not looking for /^---$/.

Right.

> If that is the case, I think it makes a lot of sense.  It is a
> general improvement not tied to the case that triggered this thread.
> 
> Independently, I think it makes sense to do something like
> 
> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
> 
> to tighten the match to exclude a non-trailer; that would have been
> sufficient for the original case that triggered this thread.


