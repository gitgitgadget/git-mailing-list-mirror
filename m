From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] manpages: linking all mail-related commands
Date: Fri, 11 Jan 2008 16:53:43 -0800
Message-ID: <7vy7avzwx4.fsf@gitster.siamese.dyndns.org>
References: <1200095286-2621-1-git-send-email-humberto@digi.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Humberto Diogenes <humberto@digi.com.br>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUdf-000186-7Q
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762744AbYALAxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbYALAxv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:53:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762726AbYALAxv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:53:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 833632256;
	Fri, 11 Jan 2008 19:53:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E980E2255;
	Fri, 11 Jan 2008 19:53:44 -0500 (EST)
In-Reply-To: <1200095286-2621-1-git-send-email-humberto@digi.com.br> (Humberto
	Diogenes's message of "Fri, 11 Jan 2008 20:48:06 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70240>

Humberto Diogenes <humberto@digi.com.br> writes:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index e4a6b3a..fd00fc1 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -144,8 +144,10 @@ names.
>  
>  SEE ALSO
>  --------
> -gitlink:git-apply[1].
> -
> +gitlink:git-apply[1],
> +gitlink:git-format-patch[1],
> +gitlink:git-imap-send[1],
> +gitlink:git-send-email[1]

I do not see a point in this.  "am" is a tool for people who
accept and they do not care how the sender prepared
(format-patch) nor sent (imap-send nor send-email).

On the other hand, as am uses mailinfo and mailsplit, it may be
worth mentioning them (although I suspect not all the readers of
manual page of am are interested in such a low level details).

> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index c1c54bf..53fa937 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -189,6 +189,10 @@ If --index is not specified, then the submodule commits in the patch
>  are ignored and only the absence of presence of the corresponding
>  subdirectory is checked and (if possible) updated.
>  
> +See Also
> +--------
> +gitlink:git-am[1]

Why?  apply is not about email at all.  am uses apply but not
the other way around.

This feels you are going a bit overboard, as if you are adding
"See Also: git[7]" everywhere (even though it is not that bad).

> -See Also
> +SEE ALSO
>  --------

If you are standardizing between "SEE ALSO" and "See Also", I
think that is a worthy thing to do independent from the
additional links, but (1) please be consistent --- you tried to
add "See Also" yoruself above, (2) please have a separate patch
that does _ONLY_ the standardization to "SEE ALSO", and not
limited to commands that has (maybe remotely) something to do
with emailed patch workflow.

Right now, I count 14 "SEE ALSO" and 17 "See Also".  127 spell
"Author" and 5 spell "AUTHOR".  Everybody says "NAME", "SYNOPSIS",
"DESCRIPTION", and "OPTIONS".

I think we should spell these in all uppercase.
