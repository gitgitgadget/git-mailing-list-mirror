From: Jeff King <peff@github.com>
Subject: Re: [PATCH] stash: fix false positive in the invalid ref test.
Date: Wed, 6 Apr 2011 14:27:26 -0400
Message-ID: <20110406182726.GC8205@sigill.intra.peff.net>
References: <1302045673-59982-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7XS4-0000uw-AW
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab1DFS1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:27:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35535
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368Ab1DFS1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:27:30 -0400
Received: (qmail 7394 invoked by uid 107); 6 Apr 2011 18:28:16 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 14:28:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 14:27:26 -0400
Content-Disposition: inline
In-Reply-To: <1302045673-59982-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170999>

On Wed, Apr 06, 2011 at 09:21:13AM +1000, Jon Seymour wrote:

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 11077f0..5263de7 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -543,11 +543,11 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
>  	echo bar6 > file2 &&
>  	git add file2 &&
>  	git stash &&
> -	test_must_fail git drop stash@{1} &&
> -	test_must_fail git pop stash@{1} &&
> -	test_must_fail git apply stash@{1} &&
> -	test_must_fail git show stash@{1} &&
> -	test_must_fail git branch tmp stash@{1} &&
> +	test_must_fail git stash drop stash@{1} &&
> +	test_must_fail git stash pop stash@{1} &&
> +	test_must_fail git stash apply stash@{1} &&
> +	test_must_fail git stash show stash@{1} &&
> +	test_must_fail git stash branch tmp stash@{1} &&
>  	git stash drop

Probably we should just squash your fix in with my first patch, and drop
my test.  Your fixed version is a superset of what mine tests.

-Peff
