From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: subdirectory-filter does not delete files before the directory came into existence?
Date: Sun, 19 Dec 2010 23:51:48 +0100
Message-ID: <201012192351.49279.trast@student.ethz.ch>
References: <1292365295.6666.22.camel@ct> <201012190323.59829.trast@student.ethz.ch> <1292751289.21229.26.camel@ct>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
X-From: git-owner@vger.kernel.org Sun Dec 19 23:52:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUS6r-0001fi-R7
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218Ab0LSWvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 17:51:52 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:46676 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756148Ab0LSWvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 17:51:51 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 23:51:47 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 23:51:50 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <1292751289.21229.26.camel@ct>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163972>

Jan Wielemaker wrote:
> On Sun, 2010-12-19 at 03:23 +0100, Thomas Rast wrote:
> > Jan Wielemaker wrote:
> > >   * get all tags, use comm and delete the tags not in the `contained'
> > >   set above.
[...]
> >   http://article.gmane.org/gmane.comp.version-control.git/91708
[...]
> Funny.  That was me having problems with filtering out directories
> as well :-)  I thought your patch was added using the --prune-empty
> flag.  I guess you can comment on that.  I can confirm that I've got
> nice and clean filtering using

No, those two are rather different.  --prune-empty drops commits that
became "no-ops" in the sense that their tree is the same as their
(only) parent's.  In the case of --subdirectory-filter, --prune-empty
is most likely[*] redundant since the former already enables history
simplification limited to that directory.

As you can see from "TOY PATCH", my patch wasn't really meant for
application anyway.  I'm now wondering what the ramifications would
be.  filter-branch only attempts to change refs that you told it to
(listed positively on the command line), so maybe deleting anything
that was not rewritten is a sensible option (not default, mind you).


[*] Read: I think it is redundant, I'm just too lazy to double-check.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
