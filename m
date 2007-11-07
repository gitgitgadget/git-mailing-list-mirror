From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add Documentation/CodingGuidelines
Date: Wed, 07 Nov 2007 15:14:17 -0800
Message-ID: <7vtznx8x86.fsf@gitster.siamese.dyndns.org>
References: <20071106201518.GA6361@ins.uni-bonn.de> <47317CD7.5040506@op5.se>
	<Pine.LNX.4.64.0711071456440.4362@racer.site>
	<200711072243.21086.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.64.0711072233010.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Andreas Ericsson <ae@op5.se>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:14:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipu6h-0004Nq-CH
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbXKGXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbXKGXOc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:14:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59832 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbXKGXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:14:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1E50C2EF;
	Wed,  7 Nov 2007 18:14:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 375119349D;
	Wed,  7 Nov 2007 18:14:46 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711072233010.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 7 Nov 2007 22:35:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63890>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> new file mode 100644
> index 0000000..2d8656f
> --- /dev/null
> +++ b/Documentation/CodingGuidelines
> @@ -0,0 +1,106 @@
> +As a popular project, we also have some guidelines to keep to the
> +code.  For git in general, two rough rules are:

I'd rather not to say "As a popular project" here.  That is
something for others to decide, not for us to advertise.

Also we now have three rules here ;-).

> +
> + - Most importantly, we never say "It's in POSIX; we'll happily
> +   ignore your needs should your system that does not conform."

"should your system not conform"?  "if your system does not
conform"?

> +As for more concrete guidelines, just imitate the existing code
> +(this is a good guideline, no matter which project you are contributing
> +to...).  But if you must have some list of rules, here they are.

s/\.\.\.//;

> +For C programs:
> +
> + - Use tabs to indent, and interpret tabs as taking up to 8 spaces
> +
> + - Try to keep to at most 80 characters per line
> +
> + - When declaring pointers, the star sides with the variable name, i.e.
> +   "char *string", not "char* string" or "char * string".  This makes
> +   it easier to understand "char *string, c;"

End each sentence with a full stop "." for consistency.

> +
> + - Do not use curly brackets unnecessarily.  I.e.
> +
> +	if (bla) {
> +		x = 1;
> +	}
> +
> +   is frowned upon.  A gray area is when the statement extends over a
> +   few lines, and/or you have a lengthy comment atop of it.  Also,
> +   like in the Linux kernel, if there is a long list of "else if"
> +   statements, it can make sense to add curly brackets to single
> +   line blocks.

As Robin suggests, s/Do not use/Avoid using/ feels more in line
with the spirit with the "A gray area is..." description.

I think the official name for {} are "braces", by the way.

> +   Double negation is often harder to understand than no negation at
> +   all.
> +
> +   Some clever tricks, like using the !! operator with arithmetic
> +   constructs, can be extremely confusing to others.  Avoid them,
> +   unless there is a compelling reason to use them.

Need a bullet point "-" before "Double" (but not "Some").

> + - #include system headers in git-compat-util.h.  Some headers on some
> +   systems show subtle breakages when you change the order, so it is
> +   best to keep them in one place.
> +

The first #include in C files except platform specific compat/
implementation should be git-compat-util.h or another header
file that includes it, such as cache.h and builtin.h.

> + - if you are planning a new command, consider writing it in shell or
> +   perl first, so that changes in semantics can be easily changed and
> +   discussed.  Many git commands started out like that, and a few are
> +   still scripts.

Begin a statement with a Capital letter, for consistency.
