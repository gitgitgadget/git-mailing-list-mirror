From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Mon, 24 Mar 2014 17:36:59 -0400
Message-ID: <20140324213659.GF13728@sigill.intra.peff.net>
References: <53282741.5010609@web.de>
 <cover.1395433874.git.j6t@kdbg.org>
 <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:37:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCYP-0001IM-Sg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaCXVhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:37:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:46098 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750998AbaCXVhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:37:01 -0400
Received: (qmail 8973 invoked by uid 102); 24 Mar 2014 21:37:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:37:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:36:59 -0400
Content-Disposition: inline
In-Reply-To: <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244878>

On Fri, Mar 21, 2014 at 10:07:15PM +0100, Johannes Sixt wrote:

> Add an infrastructure that simplifies adding new tests of the hunk
> header regular expressions.
> 
> To add new tests, a file with the syntax to test can be dropped in the
> directory t4018. The README file explains how a test file must contain;
> the README itself tests the default behavior.

I really like the cleanups you've done in t4018. I noticed how messy it
was when I modified it recently, but I didn't take the time to clean it.

> diff --git a/t/t4018/README b/t/t4018/README
> new file mode 100644
> index 0000000..283e01cc
> --- /dev/null
> +++ b/t/t4018/README
> @@ -0,0 +1,18 @@
> +How to write RIGHT test cases
> +=============================
> +
> +Insert the word "ChangeMe" (exactly this form) at a distance of
> +at least two lines from the line that must appear in the hunk header.

The existing tests use -U1 to make writing cases simpler. Is there a
reason not to continue that (or if you found that porting the existing
cases was not a chore with -U3, I can buy that argument, too)?

> +The text that must appear in the hunk header must contain the word
> +"right", but in all upper-case, like in the title above.
> +
> +To mark a test case that highlights a malfunction, insert the word
> +BROKEN in all lower-case somewhere in the file.

I wondered why you wouldn't write them in the case you are indicating,
when...

> +This text is a bit twisted and out of order, but it is itself a
> +test case for the default hunk header pattern. Know what you are doing
> +if you change it.

Ah. Clever. :)

-Peff
