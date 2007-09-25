From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-checkout hooks and related tests
Date: Tue, 25 Sep 2007 16:17:46 -0700
Message-ID: <7vve9y2v39.fsf@gitster.siamese.dyndns.org>
References: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJfl-0004W0-OJ
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbXIYXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXIYXRw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:17:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbXIYXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:17:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2618F13A1F2;
	Tue, 25 Sep 2007 19:18:10 -0400 (EDT)
In-Reply-To: <1190760563-32453-1-git-send-email-jjengla@sandia.gov> (Josh
	England's message of "Tue, 25 Sep 2007 16:49:21 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59192>

"Josh England" <jjengla@sandia.gov> writes:

> diff --git a/git-checkout.sh b/git-checkout.sh
> index 17f4392..78355eb 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -137,6 +137,13 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
>  	git ls-files --error-unmatch -- "$@" >/dev/null || exit
>  	git ls-files -- "$@" |
>  	git checkout-index -f -u --stdin
> +
> +        # Run a post-checkout hook -- the HEAD does not change so the
> +	# current HEAD is passed in for both args
> +	if test -x "$GIT_DIR"/hooks/post-checkout; then

It is usually a good idea to view your patch in your MUA before
sending them out.

You will spot HT vs SP indentation inconsistencies right away.

HEAD did not change but don't you want to differenciate if the
checkout was from the index or from the HEAD?  If not why not?
