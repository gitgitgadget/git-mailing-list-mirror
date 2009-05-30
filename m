From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Sat, 30 May 2009 15:05:37 +0200
Message-ID: <200905301505.38016.markus.heidelberg@web.de>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com> <1243289231-32500-2-git-send-email-naesten@gmail.com> <1243289231-32500-3-git-send-email-naesten@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 15:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAOFy-0003nF-AO
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523AbZE3NFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 09:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbZE3NFi
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 09:05:38 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39719 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757557AbZE3NFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 09:05:38 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5614FFE7433D;
	Sat, 30 May 2009 15:05:39 +0200 (CEST)
Received: from [89.59.100.180] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MAOFn-0001A1-00; Sat, 30 May 2009 15:05:39 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1243289231-32500-3-git-send-email-naesten@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/9EjrPKVqKyq9GKcy/KnKvmQX6qyudcmAlaf5b
	3DXPGVyRE6sCe5xo/3s5+2pYt46HQfMpdx2t5uEHI8NLYAfNId
	jz6EjaRIq6BmbYILNrLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120350>

Samuel Bronson, 26.05.2009:
> Signed-off-by: Samuel Bronson <naesten@gmail.com>
> ---
>  Makefile |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 07a141d..b485c21 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1190,6 +1190,13 @@ prefix_SQ = $(subst ','\'',$(prefix))
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
> +# unconfuse Emacs: '
> +
> +# The above comment is in case there is an odd number of _SQ
> +# definitions above, since they seem to confuse Emacs. If there is an
> +# even number of such definitions, it does no harm, since emacs
> +# doesn't recognize string delimiters inside recognized comments.

This doesn't only confuse Emacs, so the subject should be changed to
something like "... to unconfuse editors' syntax highlighting" and be
squashed with Patch 1/3, since this is exactly the same issue.

I think this is way too much comment and would prefer none at all. I
also would remove the global 4-line comment.

But Vim for example is not satisfied with your fix above. It needs this
workaround for every line and additionally needs a closing parenthesis,
because the real one is hidden in the string. So this would work for
Vim:

 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+#')
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+#')

Maybe even behind the concerned line to avoid clutter, if this doesn't
cause other problems:

-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))#')
-TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
+TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))#')

But I'm not completely confident of this fix anyway and don't know
whether it should be included at all.

Markus
