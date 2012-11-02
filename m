From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext
Date: Fri, 2 Nov 2012 10:54:25 -0400
Message-ID: <20121102145425.GC11170@sigill.intra.peff.net>
References: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: rh <richard_hubbe11@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIdu-0003gO-C3
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab2KBOy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:54:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54581 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931Ab2KBOy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 10:54:28 -0400
Received: (qmail 5201 invoked by uid 107); 2 Nov 2012 14:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 10:55:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 10:54:25 -0400
Content-Disposition: inline
In-Reply-To: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208942>

On Mon, Oct 29, 2012 at 09:42:07AM -0700, rh wrote:

> I also consolidated exts where applicable.
> i.e. c and h maps to c
> 
> 
> -- 
> 
> diff --git a/a/gitweb.cgi b/b/gitweb.cgi
> index 060db27..155b238 100755
> --- a/a/gitweb.cgi
> +++ b/b/gitweb.cgi
> @@ -246,19 +246,19 @@ our %highlight_basename = (
>         'Makefile' => 'make',
>  );
>  # match by extension
> +
>  our %highlight_ext = (
>         # main extensions, defining name of syntax;
>         # see files in /usr/share/highlight/langDefs/ directory
> -       map { $_ => $_ }
> -               qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
> +       (map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
>         # alternate extensions, see /etc/highlight/filetypes.conf
> -       'h' => 'c',
> -       map { $_ => 'sh'  } qw(bash zsh ksh),
> -       map { $_ => 'cpp' } qw(cxx c++ cc),
> -       map { $_ => 'php' } qw(php3 php4 php5 phps),
> -       map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
> -       map { $_ => 'make'} qw(mak mk),
> -       map { $_ => 'xml' } qw(xhtml html htm),
> +       (map { $_ => 'c'   } qw(c h)),
> +       (map { $_ => 'sh'  } qw(sh bash zsh ksh)),
> +       (map { $_ => 'cpp' } qw(cpp cxx c++ cc)),
> +       (map { $_ => 'php' } qw(php php3 php4 php5 phps)),
> +       (map { $_ => 'pl'  } qw(pl perl pm)), # perhaps also 'cgi'
> +       (map { $_ => 'make'} qw(make mak mk)),
> +       (map { $_ => 'xml' } qw(xml xhtml html htm)),

I think the patch itself looks OK, but:

  1. It isn't formatted to apply with git-am. Please use
     git-format-patch.

  2. The commit message does not explain the reason for the change.

  3. It isn't signed-off.

The first two are things I can fix up (though it is inconvenient for me
to do so), but the third is a show-stopper.  Please look through
Documentation/SubmittingPatches, especially the bit about the
Developer's Certificate of Origin, and re-send.

-Peff
