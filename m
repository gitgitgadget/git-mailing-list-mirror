From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 12/19] 1/2: Add Python support library for CVS remote helper
Date: Fri, 30 Oct 2009 09:33:35 +0100
Message-ID: <200910300933.35567.johan@herland.net>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
 <1256839287-19016-13-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:33:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3mvY-0000yG-HT
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbZJ3Ide (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 04:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755482AbZJ3Idd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:33:33 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33492 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755263AbZJ3Idc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:33:32 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB000P8JS1KG30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:33:37 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB0062VJRZR600@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:33:37 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.30.82124
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <1256839287-19016-13-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131680>

On Thursday 29 October 2009, Sverre Rabbelier wrote:
> From: Johan Herland <johan@herland.net>
> 
> This patch introduces parts of a Python package called "git_remote_cvs"
> containing the building blocks of the CVS remote helper.
> The CVS remote helper itself is NOT part of this patch.
> 
> This patch has been improved by the following contributions:
> - David Aguilar: Lots of Python coding style fixes
> 
> Cc: David Aguilar <davvid@gmail.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
> 	This has my patch to util.py squashed in.

Why? Or: why that one, and not the others? Also, you might want to mention 
your contribution in the commit message itself.

> diff --git a/git_remote_cvs/util.py b/git_remote_cvs/util.py
> new file mode 100644
> index 0000000..d3ca487
> --- /dev/null
> +++ b/git_remote_cvs/util.py
> @@ -0,0 +1,194 @@
[snip]
> +
> +def notify(msg, *args):
> +	"""Print a message to stderr."""
> +	print >> sys.stderr, msg % args
> +
> +def debug (msg, *args):
> +    """Print a debug message to stderr when DEBUG is enabled."""
> +    if DEBUG:
> +        print >> sys.stderr, msg % args
> +
> +def error (msg, *args):
> +    """Print an error message to stderr."""
> +    print >> sys.stderr, "ERROR:", msg % args
> +
> +def warn(msg, *args):
> +	"""Print a warning message to stderr."""
> +	print >> sys.stderr, "warning:", msg % args
> +
> +def die (msg, *args):
> +    """Print as error message to stderr and exit the program."""
> +    error(msg, *args)
> +    sys.exit(1)
> +
> +

It seems the two functions you add (notify() and warn()) have a different 
indentation than the existing code (which uses 4 spaces). Please fix.

(When I first introduced these Python patches, there was a discussion on the 
differences in indentation/style between the Git C code, and Python code, 
and it was decided to follow the Python conventions, to make the code more 
inviting to the Python community.)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
