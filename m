From: "Tor Arntsen" <tor@spacetec.no>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 11:24:19 +0200
Message-ID: <4C10AF43.5050708@spacetec.no>
References: <4C0E5103.7030501@viscovery.net> <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com> <4C0E6810.3070301@viscovery.net> <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com> <4C0E932B.3010702@viscovery.net> <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com> <4C0EB741.9020905@op5.se> <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com> <20100610082916.GA5559@coredump.intra.peff.net> <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com> <20100610085952.GA8269@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:25:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMe0o-0003F2-6p
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab0FJJZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 05:25:15 -0400
Received: from puck.spacetec.no ([192.51.5.29]:35388 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849Ab0FJJZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 05:25:14 -0400
Received: (qmail 26540 invoked from network); 10 Jun 2010 09:25:12 -0000
Received: from citadel.spacetec.no (10.10.2.22)
  by puck.spacetec.no with SMTP; 10 Jun 2010 09:25:12 -0000
Received: from [10.10.1.233] (ringworld4.spacetec.no [10.10.1.233])
	by citadel.spacetec.no; Thu, 10 Jun 2010 11:24:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148847>

On 06/10/10 10:59, Jeff King wrote:
> On Thu, Jun 10, 2010 at 10:48:31AM +0200, Tor Arntsen wrote:
> 
>> That looks good to me.
> 
> OK, here it is with a commit message. Other systems might want the same,
> I guess (Solaris, IRIX?). I'm cc'ing Brandon, who might have some input.
> 
> Note that this is completely untested by me, as all of my AIX boxen have
> gone away in the past few months (yay!).

I did a re-build and test. Everything works fine.

Tested-by: Tor Arntsen <tor@spacetec.no>

-Tor

-- >8 --
Subject: [PATCH] Makefile: default pager on AIX to "more"

AIX doesn't ship with "less" by default, and their "more" is
more featureful than average, so the latter is a more
sensible choice.  People who really want less can set the
compile-time option themselves, or users can set $PAGER.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 34b7dd5..6ad0aca 100644
--- a/Makefile
+++ b/Makefile
@@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
 	HAVE_PATHS_H = YesPlease
 endif
 ifeq ($(uname_S),AIX)
+	DEFAULT_PAGER = more
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
-- 1.7.1.514.g71ed8 
