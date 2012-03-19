From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Mon, 19 Mar 2012 12:39:28 -0700
Message-ID: <7v1uoobcsv.fsf@alter.siamese.dyndns.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
 <1332179503-2992-2-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9iQb-0008Pd-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 20:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267Ab2CSTjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 15:39:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab2CSTjc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 15:39:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68725668C;
	Mon, 19 Mar 2012 15:39:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kazxD/YlIHo9vgbmC+1dUc1ORw=; b=qfWBQ2
	Iqvb4Bpa00xH1G0SigsiVI/zwV10ZfPUSbORWk41qV7FbVBPlwPeIAEJULTQtFsW
	/CG35eGehcp9zpTjmX9imBOaaeHWBti3AMR5iN0LlX5Gj7pRqm+0wHsCF1UtSwRI
	JN6HFJQCH0WGQh2nr1aH10GytQ/3BgCAWiz+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TC8yx0i6bh3PtNrBjONgB585VMea3ZPB
	q3dnLXteC/iY1xuHBXTRL3lcPheecJC+QYKu7Fh9hRU6+wjeHSYzjTKniTyZsiU0
	eKEHpG+lvVJjfZ/ntLkWe/PDg7PXmFv9i7kuwbQBGfrs7l/w+QRSfova0qpnPZ3E
	2JWeAaFzY60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F34A668B;
	Mon, 19 Mar 2012 15:39:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2EA6667B; Mon, 19 Mar 2012
 15:39:30 -0400 (EDT)
In-Reply-To: <1332179503-2992-2-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Mon, 19 Mar 2012 18:51:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F3B36F4-71FB-11E1-8D37-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193451>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> Rewrite user messages to stick to a uniform style for all messages. From the surrounding code, the following guidelines were deduced:
> - messages start with a capital,
> - short messages do not end with a full stop,
> - paths, filenames, and commands are quoted by single quotes (if not separated by the normal text by a ':'),
> - 'could not' is used rather than 'cannot'.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
>  gpg-interface.c |    6 +++---
>  grep.c          |    2 +-
>  help.c          |    2 +-
>  sequencer.c     |   24 ++++++++++++------------
>  4 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 09ab64a..5e14a21 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -56,7 +56,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	args[3] = NULL;
>  
>  	if (start_command(&gpg))
> -		return error(_("could not run gpg."));
> +		return error(_("Could not run 'gpg'"));

Ok with s/c/C/, but I am not sure about the 'gpg' bit.  The name of the
program and path to it can be configured so the user may be expecting to
run a program called gnupg, and unquoted gpg feels more like a generic
term to refer to the program.  It might be worth using all-CAPS, though.

Likewise for the other hunks for this file.

> -		return error(_("cannot open %s: %s"), filename,
> +		return error(_("Could not open '%s': %s"), filename,

Honestly speaking, I would personally prefer "Cannot open" over "Could not
open".  Yes, all the error messages report _after_ we attempted to do
something and finding that we _couldn't_ do that thing, so "Could not" may
be technically more correct, but still...

But that is probably just me.

Other than that, the patch looks good; let's hear from others, too.
