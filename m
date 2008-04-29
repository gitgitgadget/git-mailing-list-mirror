From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: point git-prune users to git-gc
Date: Tue, 29 Apr 2008 15:05:03 -0700
Message-ID: <7vskx45ncg.fsf@gitster.siamese.dyndns.org>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
 <7vve28sdys.fsf@gitster.siamese.dyndns.org>
 <20080423221316.GE30057@sigill.intra.peff.net>
 <20080424012836.GA30812@sigill.intra.peff.net>
 <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
 <20080424161407.GA23737@sigill.intra.peff.net>
 <32541b130804240959y3b05d4b5u67ac7a7c14bf187e@mail.gmail.com>
 <20080429204514.GA21029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:06:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqxxn-00039D-R3
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYD2WF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYD2WF2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:05:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYD2WF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:05:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F9673EFA;
	Tue, 29 Apr 2008 18:05:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3E763EF6; Tue, 29 Apr 2008 18:05:16 -0400 (EDT)
In-Reply-To: <20080429204514.GA21029@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 29 Apr 2008 16:45:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D117A30-1638-11DD-BF0C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80754>

Jeff King <peff@peff.net> writes:

> Yes, I don't think there is any reason for most people to use git-prune
> at all, unless they are trying specifically to prune and don't want the
> other gc effects to happen.
>
> Junio, please correct me if I'm wrong there.

Well, this is a hard statement to make corrections to.  If A is defined to
be a subset of B, and A is generally useful, the only reason to do B is
when you want the effect of B without anything else.  So your statement
cannot be incorrect.

However, in order to help people decide when to run B (or, if there ever
be a case where they might want to), there needs a discussion what other
things that _might_ be unwanted A does in addition to B.

For that reason,...

> diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
> index f151cff..f92bb8c 100644
> --- a/Documentation/git-prune.txt
> +++ b/Documentation/git-prune.txt
> @@ -13,6 +13,9 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> +NOTE: In most cases, users should run linkgit:git-gc[1], which calls
> +git-prune. See the section "NOTES", below.
> +

I think this note upfront is not helping readers very much (this is
git-prune documentation after all -- they are interested in the command
and not gc), but ...

>  This runs `git-fsck --unreachable` using all the refs
>  available in `$GIT_DIR/refs`, optionally with additional set of
>  objects specified on the command line, and prunes all
> @@ -50,6 +53,23 @@ borrows from your repository via its
>  $ git prune $(cd ../another && $(git-rev-parse --all))
>  ------------
>  
> +Notes
> +-----
> +
> +In most cases, users will not need to call git-prune directly, but
> +should instead call linkgit:git-gc[1], which handles pruning along with
> +many other housekeeping tasks.

... this paragraph should be made a bit fatter by mentioning what "other
housekeeping tasks" are.

> +For a description of which objects are considered for pruning, see
> +git-fsck's --unreachable option.
> +
> +See Also
> +--------
> +
> +linkgit:git-fsck[1],
> +linkgit:git-gc[1],
> +linkgit:git-reflog[1]
> +
>  Author
>  ------
>  Written by Linus Torvalds <torvalds@osdl.org>
> -- 
> 1.5.5.1.172.g4dce
