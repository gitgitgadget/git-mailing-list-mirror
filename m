From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status: fix grammar when in detached head
Date: Sat, 19 Mar 2011 18:16:10 -0400
Message-ID: <20110319221610.GA7116@sigill.intra.peff.net>
References: <4D852129.7050205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 23:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q14Ri-00018D-Ub
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 23:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab1CSWQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 18:16:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59073
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187Ab1CSWQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 18:16:16 -0400
Received: (qmail 19902 invoked by uid 107); 19 Mar 2011 22:16:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Mar 2011 18:16:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Mar 2011 18:16:10 -0400
Content-Disposition: inline
In-Reply-To: <4D852129.7050205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169470>

On Sat, Mar 19, 2011 at 10:33:29PM +0100, Piotr Krukowiecki wrote:

> Not a native English speaker, but IMO the previous version isn't 
> correct.

The previous version is fine (well, it's not actually a complete
sentence because it doesn't contain a verb, but that seems not to be the
issue).

Breaking it down with the implied beginning, it is:

  [You are] not currently on any branch.
    |   |    |      |     \------------/
    1   2    3      4           5

1 = subject
2 = verb
3 = adverb (modifying "are")
4 = adverb (modifying "are")
5 = prepositional phrase functioning as predicate nominative

You can put an adverb before or after the verb it modifies. For clarity,
it's usually a good idea to keep the adverb close to its verb, though in
simple sentences it's not necessary, and putting the adverb at the
beginning or end of the sentence can emphasize it.

So:

> diff --git a/wt-status.c b/wt-status.c
> index 4daa8bb..3214f52 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -643,7 +643,7 @@ void wt_status_print(struct wt_status *s)
>  		else if (!strcmp(branch_name, "HEAD")) {
>  			branch_name = "";
>  			branch_status_color = color(WT_STATUS_NOBRANCH, s);
> -			on_what = "Not currently on any branch.";
> +			on_what = "Not on any branch currently.";

Both are correct, as is "Currently not on any branch." As would be "You
currently are not on any branch" if we were including the implied
subject and verb.

I think the current version is my favorite, as it gives the most
emphasis to "not" and "branch", but that is just personal taste. At any
rate, I'd rather not change it lightly as things like editor syntax
highlighters recognize the current phrase (though I suppose they may
soon have to deal with i18n issues anyway).

-Peff
