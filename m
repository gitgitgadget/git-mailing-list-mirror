From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Fri, 21 Mar 2014 09:11:19 +0100
Message-ID: <87eh1wc6oo.fsf@fencepost.gnu.org>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<20140320234859.GD7774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuYY-0005LT-BR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 09:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbaCUILh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 04:11:37 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41821 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbaCUILb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 04:11:31 -0400
Received: from localhost ([127.0.0.1]:40860 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQuY5-0007DE-JT; Fri, 21 Mar 2014 04:11:29 -0400
Received: by lola (Postfix, from userid 1000)
	id 161F8E08F9; Fri, 21 Mar 2014 09:11:19 +0100 (CET)
In-Reply-To: <20140320234859.GD7774@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 20 Mar 2014 19:48:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244679>

Jeff King <peff@peff.net> writes:

> If you have before-and-after numbers for just this patch on some
> repository, that would be an interesting thing to put in the commit
> message.

It's a hen-and-egg problem regarding the benchmarks.  The most
impressive benchmarks arise with the git-blame performance work in
place, and the most impressive benchmarks for the git-blame performance
work are when this or something similar is in place.  Of course, when
there are two really deficient things slowing operations down, fixing
only one is going to be much less impressive.

So I decided to tackle the low-hanging fruit here first.  But it would
appear that this amounts in far too much work since it means I have to
search for and create some _other_ benchmarking scenario not hampered by
substandard code like the current git-blame is.

I have enough on my plate as it is, so even though it puts the _real_
git-blame work in a worse light, I should rather get that finished first
(nobody will argue to keep the useless threshing of it around).  Of
course, the person then creating the two-line change to
deltaBaseCacheLimit will be able to claim much larger performance
improvements in his commit message afterwards than what I can claim
regarding the git-blame work when going first, but that's life.

-- 
David Kastrup
