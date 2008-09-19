From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Get a copy of an old version of a file, using git gui/gitk
Date: Fri, 19 Sep 2008 10:20:47 +0200
Message-ID: <20080919082047.GA10733@atjola.homenet>
References: <Pine.LNX.4.64.0809190855060.17960@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Sep 19 10:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgbFZ-0005fj-9O
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 10:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYISIUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 04:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYISIUw
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 04:20:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:55294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750792AbYISIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 04:20:51 -0400
Received: (qmail invoked by alias); 19 Sep 2008 08:20:48 -0000
Received: from i577B8FFC.versanet.de (EHLO atjola.local) [87.123.143.252]
  by mail.gmx.net (mp007) with SMTP; 19 Sep 2008 10:20:48 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/8VEJsPyb8rG5U2NTg8oeCzfrTtImamdI92OQSsU
	dYPohWarVsn+KR
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809190855060.17960@ds9.cixit.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96266>

On 2008.09.19 08:58:04 +0100, Peter Krefting wrote:
> From the command line, I would try to find the SHA-1 and use git
> cat-file, but I can't figure out how to do it from the GUIs. Or, to
> fall back to the command-line, how to get the SHA-1 for the object ou=
t
> of git gui/gitk.

You don't need the sha1 of the blob object, just the revision and the
filename, and then you can reference the blob using the
<tree-ish>:<path> syntax.

=46or example:
	git cat-file blob HEAD^^^:some/file.c
or less plumb-ish:
	git show HEAD^^^:some/file.c

I've been told that neither cares about the CRLF conversion, and I don'=
t
know if there's anything except "git checkout" that actually does care
about it. With checkout, you would do:

git checkout HEAD^^^ -- some/file.c

But that replaces the current version of that file in your working tree
and index with the version from the HEAD^^^ revision, so that might not
be exactly what you were looking for.

Bj=F6rn
