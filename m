From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: suggested feature: someone mails me a blob, git please tell me what it is
Date: Sat, 17 Feb 2007 01:10:16 -0500
Message-ID: <20070217061016.GA27813@spearce.org>
References: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIImL-0002gH-Ne
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946413AbXBQGKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbXBQGKW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:10:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59671 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946413AbXBQGKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:10:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIIm2-0003rl-Sg; Sat, 17 Feb 2007 01:10:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A7C2020FBAE; Sat, 17 Feb 2007 01:10:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39965>

Mike Coleman <tutufan@gmail.com> wrote:
> Here's a suggestion for a git feature, if git doesn't already have it.
> Since git generally doesn't use RCS-style keyword cookies (like
> "$Id$"), it'd be nice to have some other way to identify an installed
> file.  Perhaps you'd want to know exactly what rev a user is running,
> for example.
> 
> It seems like it should be fairly easy, given a blob (the file), for
> git to describe what it knows about it.  For example, it could provide
> a list of commits that it's a part of, etc.  It'd be *really* nice if
> only the output of the sha1sum command on the blob were needed.  (I
> can't recall exactly how git's blob SHA1's are computed--maybe this
> isn't feasible.)

Rather than embedding something like "$Id$" on a per-file basis
use the output of git-describe in your build process to insert the
string into your executable file(s), and then provide a way to let
the user extract it, or insert it with a unique enough pattern that
you can grep for it in the output of `strings`.

This is what git does itself.  We replace GIT_VERSION in git.c
with the output of git-describe during compile time (C preprocessor
macro).  The value can be printed by the user with `git version`.
We also embed it into some Perl scripts.

git-gui does the same thing, but is a Tcl/Tk script.

-- 
Shawn.
