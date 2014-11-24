From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 25 Nov 2014 00:27:31 +0100
Message-ID: <283403992.8FOSVk7RPR@al>
References: <6997784.RuzRO1AFsK@al> <1660121.8PEbpzfRYH@al> <20141124225457.GA9942@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 00:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt32l-0007sY-TI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 00:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbaKXX1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 18:27:39 -0500
Received: from lekensteyn.nl ([178.21.112.251]:42001 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbaKXX1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 18:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=lxevziFnacK/v5ci7xI8cP0TsWPTE+um7hw+rVvqgEk=;
	b=yosFicO/crWFQpugHSDcTukh57Sk1h0i4TGA1YzvnxY/eSMpV4hW+oby4/Y6NY9WYvlR1NegDaWwxjMrfC/dSvwOyvDtiVKuKuV21AffL2Cjt9nZ/DtMBrf30UKpF5CJuP6aLlOvTwFHMZAJ9icY+4BRm7/0RKYtE65heXqviMWJth5+9FbHkLBOlRvNBL0sj37Sw/wqilyU1dqq046LNHMGgbbsuC3nz/N08jrfQjUEErHEXa1fK0CMu7KIc9wpvtSM5g611k9v+25dOrXJeO4hPwDO+0E0tGFv1M/pvC4scO1RekqZFBqnOT7cnQdhrGna3SlWyMYe3Fo/F4um2A==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Xt32a-0006Z8-4b; Tue, 25 Nov 2014 00:27:32 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <20141124225457.GA9942@peff.net>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260171>

On Monday 24 November 2014 17:54:57 Jeff King wrote:
> On Mon, Nov 24, 2014 at 11:47:30PM +0100, Peter Wu wrote:
> > I can understand that --fetch sounds a bit weird, what about this
> > natural translation:
> > 
> >     "git remote: set the URL (only the fetch one) for NAME to URL"
> >     git remote set-url --only=fetch NAME URL
> > 
> >     "git remote: set the URL (only the push one) for NAME to URL"
> >     git remote set-url --only=push NAME URL
> >     (obsoletes --push)
> > 
> >     "git remote: set the URL (both) for NAME to URL"
> >     git remote set-url --only=both NAME URL
> >     (it would be nice if --only=both (weird!) can be removed in the
> >     future such that the option is more natural)
> > 
> >     "git remote: set the URL for NAME to URL"
> >     git remote set-url NAME URL
> >     (current behavior: YOU git guru knows what I do right?)
> 
> Yeah, I think that addresses my concern (because it explicitly leaves
> no-option as a historical curiosity, and not as an implicit version of
> "--both").

Ok, I will make a clear note about the default (without --only) behavior
having weird behavior for historical reasons. Are you really OK with
--only=both? It sounds a bit odd (mathematically speaking it is correct
as fetch and push are both partitions that form the whole set if you
ignore the historical behavior).

> > >   3. Live with it. Probably address the weirdness in the documentation.
> > > 
> > >   4. Do nothing, drop the patch.
> > > 
> > > I think I'd be OK with (3), with an appropriate documentation update.
> > 
> > I prefer 1 for now as it avoids the extra manual action I have to take
> > when changing URLs.
> 
> I'm not sure if I was clear on (3), but "live with it" was "live with
> your original patch". Which I think you would also be happy with.

Oh yes, I misunderstood this one ;)

What about the translations? Should I send a separate patch for that or
can I update all translations at once?
-- 
Kind regards,
Peter
https://lekensteyn.nl
