From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid unnecessary 'lstat()' calls in 'get_stat_data()'
Date: Sat, 09 May 2009 21:20:07 -0700
Message-ID: <7v8wl5613c.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0905091501460.3586@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 10 06:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30Wc-0003U2-IT
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbZEJEUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 00:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbZEJEUJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:20:09 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:64679 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZEJEUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 00:20:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090510042008.GZWL25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 May 2009 00:20:08 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pgL81b0014aMwMQ04gL841; Sun, 10 May 2009 00:20:08 -0400
X-Authority-Analysis: v=1.0 c=1 a=FBa1IiYnV70A:10 a=_rGolq_aGIsA:10
 a=Z4Rwk6OoAAAA:8 a=zBK5yZjOAAAA:8 a=40oYvWAKQ7NgQl15XG8A:9
 a=Gf9O4QKK7BCWOfEDURYA:7 a=TJHUwaqVLoQXZLNlVBYr2FoS0RsA:4 a=jCX6CI3P4pcA:10
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118700>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Sat, 9 May 2009 14:57:30 -0700
>
> When we ask get_stat_data() to get the mode and size of an index entry,
> ...
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> I sent this as part of the "make 'git checkout' preload the index" patch, 
> but since the preloading was of somewhat dubious value, and this part of 
> it is not, I'll just send this one-liner as an "obvious performance fix".

Oops.

I have been processing the patches in my "after 1.6.3" mailbox from the rc
freeze period and have already queued this one, but the re-integration of
four branches is taking a bit longer than usual.  It takes too much time
to run tests (and as a part of my build procedure I do docs, too) for all
integration branches, and until they all pass tests on Debian5 (primary
development box) and Fedora9 (at k.org) I do not push the result out, so
it is a bit painful for me to replace a patch once a day's testing cycle
begins.

I was about ready to push the whole thing out, but with this much improved
commit log message, it is _very tempting_ to rewind what I queued and redo
today's cycle.

I'll see how many other such (re)-sends I've got; most likely I'll redo
today's cycle after replacing what I earlier have queued with this and
your 'checkout' one, and also a patch from Dave Olszewski I want to
replace with the 'real' one.

Thanks.
