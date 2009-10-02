From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: add --prune-empty to option summary
Date: Fri, 2 Oct 2009 03:45:37 -0400
Message-ID: <20091002074537.GA27664@coredump.intra.peff.net>
References: <c376da900910011747i894404dne1ea60dae5e3990b@mail.gmail.com>
 <1254444731-6852-1-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtcpq-0002Ge-MG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbZJBHpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZJBHpl
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:45:41 -0400
Received: from peff.net ([208.65.91.99]:34587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbZJBHpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:45:40 -0400
Received: (qmail 26283 invoked by uid 107); 2 Oct 2009 07:49:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 03:49:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 03:45:37 -0400
Content-Disposition: inline
In-Reply-To: <1254444731-6852-1-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129424>

On Thu, Oct 01, 2009 at 08:52:11PM -0400, Adam Brewster wrote:

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 451950b..2cc3bd8 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  	[--index-filter <command>] [--parent-filter <command>]
>  	[--msg-filter <command>] [--commit-filter <command>]
>  	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
> +	[--prune-empty]
>  	[--original <namespace>] [-d <directory>] [-f | --force]
>  	[--] [<rev-list options>...]

Thanks. This makes sense given the existing structure, though I have to
wonder how useful some of these gigantic synopses really are. Do we
really need to list all of the options here in a cluttered, annoyingly
wrapped format, when we are just going to list them in a nice
easy-to-read format with their descriptions later on in the page?

And this is really not so much to do with your patch as a meta-rant, so
feel free to stop reading.

What should the synopsis really be communicating? In something like
git-cat-file(1), the synopsis nicely shows a few key facts:

  1. There are two "modes" if invocation.

  2. In one mode, you give an action and an object on the command line.

  3. In the other mode, you give --batch and feed some stuff over stdin.

Those are all useful pieces of information, and they are communicated
more quickly than they would be by forcing me to read the
paragraph-formatted text of the description section.

But look at the 18-line synopsis for git-grep or the 17-line one for
git-format-patch. Are they really helping anyone? (And it is not just
the line count. The 18-line synopsis for git-config is actually useful,
because there really are 18 modes of operation).

Non-git programs seem to take a more sparse approach. For example, some
one-line synopses from my system:

       sed [OPTION]... {script-only-if-no-other-script} [input-file]...
       ls [OPTION]... [FILE]...

or even this longer one:

       vim [options] [file ..]
       vim [options] -
       vim [options] -t tag
       vim [options] -q [errorfile]

Those all communicate some useful information (how to generally invoke
the program) cluttering it with redundant information.

-Peff
