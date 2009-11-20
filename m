From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gitk: add --no-replace-objects option
Date: Fri, 20 Nov 2009 12:04:39 -0800
Message-ID: <7vocmxvu7c.fsf@alter.siamese.dyndns.org>
References: <20091120194046.4469.53971.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBZjB-0007BN-Vl
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbZKTUE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZKTUE4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:04:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45735 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbZKTUEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:04:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BED5813FE;
	Fri, 20 Nov 2009 15:05:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4lf3OxWqJDkpy/hM9I8b5/9WmIw=; b=h3Jtwm
	myoPYk80ePt8SOYzX5Vcp2hEOpTyw5x2uLexf0k4xA844FN73xFg6/WNtEYcTVxk
	62ky6t82xs8kkSMRt+mMHa84JGEsXYp26lxXU4r0wM+syfWm6DS5QXWEiyA8CMtC
	zBTfk7OGgKoDriIH8VeLDDurSgCyBKfndKGcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLkM9J/zsCHySlJFOIKKn81dLHuXzocJ
	6W/ws3tARdYWIURI7kYLFJvgUrycHH+SKiTtAyKw/WUmGUNZT2fSH1bdE7YsoMcE
	qFjzzpWItll2vvVaZqg+3cnvIaRMaGABCgdEc1QNF2gQM9BL1164jk7Lqt0qL5zH
	8FjJezgntyY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75C16813FC;
	Fri, 20 Nov 2009 15:04:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B330813F9; Fri, 20 Nov
 2009 15:04:41 -0500 (EST)
In-Reply-To: <20091120194046.4469.53971.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri\, 20 Nov 2009 20\:40\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F666BB6C-D60F-11DE-9A37-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133372>

Christian Couder <chriscool@tuxfamily.org> writes:

> This option simply sets the GIT_NO_REPLACE_OBJECTS environment
> variable, and that is enough to make gitk ignore replace refs.

This is a much less interesting implementation detail than everything else
you should talk about the new feature you are adding; why is it the first
sentence of the message?

> The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
> safer on some platforms, thanks to Johannes Sixt and Michael J
> Gruber.

And this is even less interesting.

> Replace refs are useful to change some git objects after they
> have started to be shared between different repositories. One
> might want to ignore them to see the original state.

This is what the reader needs to see to understand why this patch is
worthy of consideration.  It is a minor offense that the paragraph does
not end with "... original state, and --no-replace-objects option can be
used from the command line to do so", but this could be excused if this is
made the first paragraph in the message, close to the subject.

I wonder if this switch deserves run-time flippability, though...

> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  gitk-git/gitk |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index a0214b7..c586b93 100644
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -128,7 +128,7 @@ proc unmerged_files {files} {
>  }
>  
>  proc parseviewargs {n arglist} {
> -    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs
> +    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
>  
>      set vdatemode($n) 0
>      set vmergeonly($n) 0
> @@ -208,6 +208,9 @@ proc parseviewargs {n arglist} {
>  		# git rev-parse doesn't understand --merge
>  		lappend revargs --gitk-symmetric-diff-marker MERGE_HEAD...HEAD
>  	    }
> +	    "--no-replace-objects" {
> +		set env(GIT_NO_REPLACE_OBJECTS) "1"
> +	    }
>  	    "-*" {
>  		# Other flag arguments including -<n>
>  		if {[string is digit -strict [string range $arg 1 end]]} {
> -- 
> 1.6.5.1.gaf97d
