From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 10:34:11 -0500
Message-ID: <20121220153411.GA1497@sigill.intra.peff.net>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
 <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tli8l-00088Y-J8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063Ab2LTPeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:34:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59726 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab2LTPeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:34:13 -0500
Received: (qmail 10012 invoked by uid 107); 20 Dec 2012 15:35:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 10:35:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 10:34:11 -0500
Content-Disposition: inline
In-Reply-To: <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211897>

On Sun, Dec 16, 2012 at 07:01:56PM +0000, Adam Spiers wrote:

> On Sun, Dec 16, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Adam Spiers <git@adamspiers.org> writes:
> >
> >> This series of commits attempts to make test output coloring
> >> more intuitive,...
> >
> > Thanks; I understand that this is to replace the previous one
> > b465316 (tests: paint unexpectedly fixed known breakages in bold
> > red, 2012-09-19)---am I correct?
> 
> Correct.  AFAICS I have incorporated all feedback raised in previous
> reviews.
> 
> > Will take a look; thanks.
> 
> Thanks.  Sorry again for the delay.  I'm now (finally) resuming work
> on as/check-ignore.

I eyeballed the test output of "pu". I do think this resolves all of the
issues brought up before, and I really hate to bikeshed on the colors at
this point, but I find that bold cyan a bit hard on the eyes when
running with "-v" (where most of the output is in that color, as it
dumps the shell for each test).  Is there any reason not to tone it down
a bit like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 256f1c6..31f59af 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -227,7 +227,7 @@ then
 		pass)
 			tput setaf 2;;            # green
 		info)
-			tput bold; tput setaf 6;; # bold cyan
+			tput setaf 6;; # cyan
 		*)
 			test -n "$quiet" && return;;
 		esac

-Peff
