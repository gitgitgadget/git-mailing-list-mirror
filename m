From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper  functions.
Date: Wed, 05 Sep 2007 01:05:24 -0700
Message-ID: <7vodghk057.fsf@gitster.siamese.dyndns.org>
References: <20070904115317.GA3381@artemis.corp>
	<11889144743483-git-send-email-madcoder@debian.org>
	<46DDEE73.5020904@lsrfire.ath.cx>
	<20070905074815.GB31750@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:06:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISptj-0001u0-Lp
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXIEIFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbXIEIFe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:05:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbXIEIFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:05:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BCC0F12EBAF;
	Wed,  5 Sep 2007 04:05:48 -0400 (EDT)
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20070905074815.GB31750@artemis.corp> (Pierre Habouzit's message
	of "Wed, 05 Sep 2007 09:48:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57680>

Pierre Habouzit <madcoder@debian.org> writes:

>   oh boy, yes I fixed that in my local patch collection. I'm waiting for
> a few hours (days ?) to see if there will be some more comments, I've
> integrated every single one done here already (and some I had on IRC
> too), and I'll repost a new clean series that I intend to be a real
> proposal for inclusion.

Ah, I actually did the single trivial fix-up (ALLOC_GROW) and
have been looking at it, but I'll discard it.  Thanks.

>   And yes, this patch is a perfect example of the gain we have to share
> a common buffer API. The code looks (at least to me) way nicer, and if
> you look in the details, we perform as many memory allocations, copies,
> and so on as in the previous version.

Wait.  What is your point in saying this?  Is that a good thing
to do "as many"?  "API is cleaned-up and it is much easier to
read but we do not do more than before" is certainly a *BIG*
plus, so perhaps that is what you meant, but when I first read
it I thought you were saying "we are not optimizing it at all"
in a negative sense.
