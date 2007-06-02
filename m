From: Frank Lichtenheld <djpig@debian.org>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference it elsewhere
Date: Sat, 2 Jun 2007 12:56:48 +0200
Message-ID: <20070602105648.GX3242@planck.djpig.de>
References: <46609BC4.9000508@freedesktop.org> <20070601234710.GW3242@planck.djpig.de> <4660BF65.3000605@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuRI2-0001Z8-EW
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 12:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXFBK4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbXFBK4w
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 06:56:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:4981 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbXFBK4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 06:56:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 9F50E881B4;
	Sat,  2 Jun 2007 12:56:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RHktHCWeWNg; Sat,  2 Jun 2007 12:56:48 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E46F0881B5; Sat,  2 Jun 2007 12:56:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4660BF65.3000605@freedesktop.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48923>

On Fri, Jun 01, 2007 at 05:52:53PM -0700, Josh Triplett wrote:
> Frank Lichtenheld wrote:
> > On Fri, Jun 01, 2007 at 03:20:52PM -0700, Josh Triplett wrote:
> >> + - Otherwise, git treats the pattern as a shell glob suitable
> >> +   for consumption by fnmatch(3) with the FNM_PATHNAME flag: any
> >> +   slash in the pattern must match a slash in the pathname.  For
> >> +   example, "Documentation/\*.html" matches
> >> +   "Documentation/git.html" but not "ppc/ppc.html".  A leading
> >> +   slash matches the beginning of the pathname; for example,
> >> +   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
> > 
> > I realise this is copy&paste but shouldn't that read:
> > "Documentation/\*.html" matches "Documentation/git.html"
> > but not "Documentation/ppc/ppc.html"
> > ?
> 
> I don't know.  Neither file seems to exist in current Git.

The point I was trying to make is that "Documentation/*.html" _of
course_ doesn't match ppc/ppc.html. What we try to tell the user here
is that * doesn't match /
So I think it should definetly read Documentation/ppc/ppc.html
FWIW, I find the sentence
"any slash in the pattern must match a slash in the pathname"
very confusing too. The sentence in fnmatch(3) is much more precise:
"match a slash in string only with a slash in pattern and not by an
asterisk (*) or a question mark (?) metacharacter, nor by a bracket
expression ([]) containing a slash"

Anyway, if you prefer (and if it is okay with Junio) I can send a
patch of my own for this single issue to not hinder the commit of
your big patch as the issue is equally present in the old and the
new text.

Gruesse,
-- 
Frank Lichtenheld <djpig@debian.org>
www: http://www.djpig.de/
