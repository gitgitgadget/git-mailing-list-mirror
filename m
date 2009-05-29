From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Makefile: introduce SANE_TOOL_PATH for prepending required elements to PATH
Date: Thu, 28 May 2009 22:13:54 -0700
Message-ID: <7v63fkh4od.fsf@alter.siamese.dyndns.org>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
	<8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
	<8D9Pn2N3FZLQcyxrPABrG-BSSbTCg9PE0lVG9rBAr5BVQibQYcIzXrxDf4S0P9Pb6AZO5MBuasg@cipher.nrlssc.navy.mil>
	<8D9Pn2N3FZLQcyxrPABrGxTLa3Dlq25WDqK5xSJyY6cvQv4mphIUXvRu59EA7ewVS-vbi5IZUc4@cipher.nrlssc.navy.mil>
	<20090528191342.GF13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 29 07:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9uQg-0001KO-My
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 07:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZE2FOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 01:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbZE2FOp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 01:14:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40365 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZE2FOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 01:14:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090529051356.BLFB2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 May 2009 01:13:56 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id xHDv1b0044aMwMQ03HDvYs; Fri, 29 May 2009 01:13:55 -0400
X-Authority-Analysis: v=1.0 c=1 a=eDh1dgJSGzsA:10 a=G4P8onpsFtgA:10
 a=PKzvZo6CAAAA:8 a=t0EAXYfJfIJ4AB_ZQmUA:9 a=cF_jeK-0BYPmB1dCCaYA:7
 a=5X2t-P3b9KFM7MqH_8T-n0hha18A:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090528191342.GF13499@coredump.intra.peff.net> (Jeff King's message of "Thu\, 28 May 2009 15\:13\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120248>

Jeff King <peff@peff.net> writes:

> On Wed, May 27, 2009 at 09:17:08PM -0500, Brandon Casey wrote:
>
>> Some platforms (like SunOS and family) have kept their common binaries at
>> some historical moment in time, and introduced new binaries with modern
>> features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
>> features provided by these modern binaries are expected and required by git.
>> If the featureful binaries are not in the users path, then git could end up
>> using the less featureful binary and fail.
>> 
>> So provide a mechanism to prepend elements to the users PATH at runtime so
>> the modern binaries will be found.
>
> My concern with this is that the PATH bleeds over into things we execute
> on behalf of the user, like GIT_EDITOR or snippets in git-filter-branch.
> So we can end up surprising users that way.
>
> On the other hand, I don't know how big a problem that is in practice. I
> feel like any sane Solaris user is going to have xpg4 in their PATH
> these days.

I share that feeling, in which case the patch should be no-op.

But I recall the "how about this" patch was done as an illustration of a
possible approach to solve breakage in _tests_; the patch actually does
not touch t/Makefile and would not help tests.
