From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable)
Date: Sun, 4 Feb 2007 13:51:45 -0500
Message-ID: <20070204185144.GB24368@coredump.intra.peff.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 19:51:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDmSv-0006Ww-Dr
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 19:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbXBDSvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 13:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbXBDSvs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 13:51:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4362 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752500AbXBDSvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 13:51:48 -0500
Received: (qmail 32475 invoked from network); 4 Feb 2007 13:51:46 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 4 Feb 2007 13:51:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Feb 2007 13:51:45 -0500
Content-Disposition: inline
In-Reply-To: <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38699>

On Sun, Feb 04, 2007 at 01:36:29AM -0800, Junio C Hamano wrote:

>  - Teaching "git blame" to also use the working tree files
>    and/or index.  I actually think defaulting to working tree
>    when an explicit HEAD is not given (and --cached to use the
>    one in the index) makes a lot of sense, but I haven't got
>    around to code the latter yet.  Not defaulting to HEAD
>    changes semantics, so if we ever are going to do it, I think
>    we should do so before 1.5.0.

Just a thought, but it might be useful to blame the contents of an
arbitrary file (but starting the history at a given pathname). Something
like "git blame --contents /tmp/foo.c file.c", with contents defaulting
to "file.c". There's much discussion of editor interfaces, and this
leaves the possibility of git-blaming the contents of the editor buffer
(after writing it out to a temp file) without having to save changes to
the working tree file.

Admittedly, I think this will be rare, but if you git-blame from an
editor, it seems awkward to either be inaccurate (by blaming the last
saved working tree file, but comparing it to the buffer) or to save the
file as a side effect.

-Peff
