From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Sat, 12 Jun 2010 04:19:25 -0400
Message-ID: <20100612081925.GA19525@coredump.intra.peff.net>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
 <20100612055831.GA2426@burratino>
 <20100612062812.GA12685@coredump.intra.peff.net>
 <4C132C7E.5090606@gmail.com>
 <20100612071850.GA2765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bobby Powers <bobbypowers@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 10:19:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONLwI-0006P5-9B
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 10:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab0FLITd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 04:19:33 -0400
Received: from peff.net ([208.65.91.99]:43486 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab0FLIT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 04:19:29 -0400
Received: (qmail 20168 invoked by uid 107); 12 Jun 2010 08:19:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Jun 2010 04:19:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jun 2010 04:19:25 -0400
Content-Disposition: inline
In-Reply-To: <20100612071850.GA2765@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148997>

On Sat, Jun 12, 2010 at 02:18:50AM -0500, Jonathan Nieder wrote:

> Subject: Documentation: explain use of cherry-pick -n in scripts
> 
> Add an example to indicate how to munge a commit while cherry-picking it.
> 
> The formatting is ugly because I do not know how to ask asciidoc to
> use a multiline heading in a definition list.

I don't think there is a way to do what you want. Even an explicit " +"
at the end of line, which is supposed to cause a line-break, doesn't
seem to work.

However, I wonder if all of the examples should actually be in "----"
listing blocks. That would generally render them in a monospaced
typewriter font (though in the manpage, it doesn't matter much), and
your multiline addition would be rendered properly, too.

> +------------
> +git checkout maint &&
> +git cherry-pick -n bugfix &&
> +git add new_file.txt &&
> +git show -s bugfix --format='%s%n%n%b%n%nAlso add a new file.' |
> +git commit -F -
> +------------

You can use the much shorter "%B" instead of "%s%n%n%b" these days, and
as a bonus, it will use the right number of newlines for a subject-only
commit.

-Peff
