From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: "remote add -f --mirror" fails when the stash is non-empty
Date: Thu, 31 Jul 2008 23:50:39 +0200
Message-ID: <20080731215039.GA9964@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOg3w-0003Yd-KC
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbYGaVun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755382AbYGaVun
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:50:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755030AbYGaVum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:50:42 -0400
Received: (qmail invoked by alias); 31 Jul 2008 21:50:40 -0000
Received: from i577BBE0C.versanet.de (EHLO atjola.local) [87.123.190.12]
  by mail.gmx.net (mp041) with SMTP; 31 Jul 2008 23:50:40 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19HLfFBT/NHkfsescQCuKbsNGIewo7sVXogGcyt8a
	KunFdsc+d4lVB3
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91000>

Hi,

when there are stashed changes in a repo, creating a mirror with "remot=
e
add -f --mirror" fails, because it is missing the objects that are on
the stash.

$ git remote add -f --mirror or ~/src/git
Updating or
remote: Counting objects: 80150, done.
remote: Compressing objects: 100% (21254/21254), done.
remote: Total 80150 (delta 57481), reused 80146 (delta 57477)
Receiving objects: 100% (80150/80150), 21.21 MiB | 16028 KiB/s, done.
Resolving deltas: 100% (57481/57481), done.
=46rom /home/doener/src/git
 * [new branch]      master     -> master
 * [new branch]      rebase     -> rebase
 * [new branch]      origin/HEAD -> origin/HEAD
 * [new branch]      origin/html -> origin/html
 * [new branch]      origin/maint -> origin/maint
 * [new branch]      origin/man -> origin/man
 * [new branch]      origin/master -> origin/master
 * [new branch]      origin/next -> origin/next
 * [new branch]      origin/pu  -> origin/pu
 * [new branch]      origin/todo -> origin/todo
error: unable to find 9e5c2066d7d2bdca937a11b45a7ed8354c637bc9
fatal: object 9e5c2066d7d2bdca937a11b45a7ed8354c637bc9 not found
error: Could not fetch or

In ~/src/git:
$ git rev-parse stash
9e5c2066d7d2bdca937a11b45a7ed8354c637bc9

No idea if that is a recent breakage, as I learned about the --mirror
option recently and most of the time my stash is empty anyway.

Bj=F6rn
