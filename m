From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rev-list --bisect: Bisection "distance" clean up.
Date: Sun, 16 Sep 2007 01:54:06 -0700
Message-ID: <7vfy1f56tt.fsf@gitster.siamese.dyndns.org>
References: <20070915130016.eac885f4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWptT-00033e-Do
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXIPIyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbXIPIyO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:54:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbXIPIyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:54:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C5565135E96;
	Sun, 16 Sep 2007 04:54:30 -0400 (EDT)
In-Reply-To: <20070915130016.eac885f4.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 15 Sep 2007 13:00:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58308>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index c2ce1fc..6ade3b7 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> @@ -189,7 +189,7 @@ static int count_interesting_parents(struct commit *commit)
>  	return count;
>  }
>  
> -static inline int halfway(struct commit_list *p, int distance, int nr)
> +static inline int halfway(struct commit_list *p, int nr)
>  {

This makes sense as we always call with "distance = weight(p)".

But is this three-patch series really needed?  We see this kind
of clean-ups often as a prelude to a larger set of enhancements,
building up anticipation for smarter and more beautiful things
to come, and seeing the series end here leaves me wondering
"Huh?  Is that it?".

Not that clean-up itself does not have any value, but still...
