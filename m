From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/40] whitespace: remediate t1006-cat-file.sh
Date: Sat, 6 Aug 2011 03:28:57 -0600
Message-ID: <20110806092856.GB7645@sigill.intra.peff.net>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 11:29:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpdBp-0005X5-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab1HFJ3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 05:29:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385Ab1HFJ27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 05:28:59 -0400
Received: (qmail 5408 invoked by uid 107); 6 Aug 2011 09:29:34 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Aug 2011 05:29:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Aug 2011 03:28:57 -0600
Content-Disposition: inline
In-Reply-To: <1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178876>

On Sat, Aug 06, 2011 at 06:44:17PM +1000, Jon Seymour wrote:

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index d8b7f2f..c78bf87 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -14,7 +14,7 @@ strlen () {
>  
>  maybe_remove_timestamp () {
>      if test -z "$2"; then
> -        echo_without_newline "$1"
> +	echo_without_newline "$1"

Yes, this indent with spaces violates our coding style policy. However,
the 4-space indentation does, too (and the space between function name
and parentheses). The "right" way is according to our policy is:

  maybe_remove_timestamp() {
          if test -z "$2"; then
                  echo_without_newline "$1"

So I have to wonder if this automated indentation is really worthwhile.
The result still doesn't meet our whitespace criteria (and I am slightly
dubious that it is possible to write an accurate general-purpose
indenter for shell code).

I suppose you could argue that even taking it partway towards right is
better than nothing. But I get the feeling that nobody is really looking
at this code; if they were, they would fix the style while they were
there. And if not, then who cares if it's 10% right or 30% right?

I dunno. I'm not against a one-time cleanup, but I think making the
cleanup script a part of the repo is kind of silly. Between git's
whitespace warnings (which I suspect post-date most of these changes)
and code review (which we need to catch non-automated style violations,
in addition to regular bugs, of course), it seems like we already have
a better solution in place. It's just that nobody has bothered to clean
up the old code.

-Peff
