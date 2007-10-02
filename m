From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 01:13:32 -0400
Message-ID: <20071002051332.GA4462@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 07:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ica4k-00067b-K7
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 07:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbXJBFNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXJBFNf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 01:13:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1042 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXJBFNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 01:13:34 -0400
Received: (qmail 22147 invoked by uid 111); 2 Oct 2007 05:13:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 01:13:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 01:13:32 -0400
Content-Disposition: inline
In-Reply-To: <20071002050820.GA4261@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59658>

On Tue, Oct 02, 2007 at 01:08:20AM -0400, Jeff King wrote:

> One approach which I haven't tried but might be promising is to actually
> keep each list sorted, and then do a "merge" of the two lists, comparing
> as you go. We don't really need to do arbitrary lookups in the hash; we
> just need to compare two hash tables at a time. My approach was to be
> simple, but have O(HASH_SIZE) comparisons (where HASH_SIZE is on the
> order of 2^17), and that's clearly just too big. But with a list merge,
> it should be O(n), where n is the actual number of lines in the files
> (or binary chunks for the binary case).

BTW, I don't want to steal credit for this idea...it comes from thinking
about what David Kastrup said earlier in the thread, though I think he
was proposing sorting just inside buckets.

-Peff
