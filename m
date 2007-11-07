From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Tue, 06 Nov 2007 16:40:49 -0800
Message-ID: <7v640ega5q.fsf@gitster.siamese.dyndns.org>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	<20071106201809.GD6361@ins.uni-bonn.de>
	<20071106202600.GH6361@ins.uni-bonn.de>
	<7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711062317330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 01:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpYyl-0007HH-Tn
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 01:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbXKGAk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 19:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXKGAk4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 19:40:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44017 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbXKGAk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 19:40:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DD15E2EF;
	Tue,  6 Nov 2007 19:41:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2968A92C94;
	Tue,  6 Nov 2007 19:41:13 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711062317330.4362@racer.site> (Johannes
	Schindelin's message of "Tue, 6 Nov 2007 23:17:50 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63759>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> new file mode 100644
> index 0000000..622b80b
> --- /dev/null
> +++ b/Documentation/CodingStyle
> @@ -0,0 +1,87 @@
> +As a popular project, we also have some guidelines to keep to the
> +code.  For git in general, two rough rules are:
> +
> + - Most importantly, we never say "It's in POSIX; we'll happily
> +   screw your system that does not conform."  We live in the
> +   real world.
> +
> + - However, we often say "Let's stay away from that construct,
> +   it's not even in POSIX".
> +

I am not sure if we want to have CodingStyle document, but the
above are not CodingStyle issues.

If we are to write this down, I'd like to have the more
important third rule, which is:

 - In spite of the above two rules, we sometimes say "Although
   this is not in POSIX, it (is so convenient | makes the code
   much more readable | has other good characteristics) and
   practically all the platforms we care about support it, so
   let's use it".  Again, we live in the real world, and it is
   sometimes a judgement call, decided based more on real world
   constraints people face than what the paper standard says.

> +For C programs:
> +
> + - Use tabs to increment, and interpret tabs as taking up to 8 spaces

What's the character for decrement?  DEL? ;-)

> +   Double negation is often harder to understand than no negation at
> +   all.
> +
> +   Some clever tricks, like using the !! operator with arithmetic
> +   constructs, can be extremely confusing to others.  Avoid them,
> +   unless there is a compelling reason to use them.

I actually think (!!var) idiom is already established in our
codebase.

> + - Use the API.  No, really.  We have a strbuf (variable length string),
> +   several arrays with the ALLOC_GROW() macro, a path_list for sorted
> +   string lists, a hash map (mapping struct objects) named
> +   "struct decorate", amongst other things.

 - When you come up with an API, document it.

> + - if you are planning a new command, consider writing it in shell or
> +   perl first, so that changes in semantics can be easily changed and
> +   discussed.  Many git commands started out like that, and a few are
> +   still scripts.

No Python allowed?
