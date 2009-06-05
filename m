From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [BUG?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 14:24:44 +0200
Message-ID: <20090605122444.GA11035@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 14:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCYTf-0001Jk-Cd
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 14:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZFEMYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 08:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZFEMYp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 08:24:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:53342 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbZFEMYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 08:24:44 -0400
Received: (qmail invoked by alias); 05 Jun 2009 12:24:45 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp048) with SMTP; 05 Jun 2009 14:24:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Tt4I/kP2T1wPZfgcpVUoJ+r9XZrLRLz+c1V/wuS
	kvgwuGqX47kzDX
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120769>

Hi,

can't make any sense out of this at all:

doener@atjola:git (master) $ git reset --hard HEAD@{1}
HEAD is now at b11cf09 Merge branch 'da/pretty-tempname'
doener@atjola:git (master) $ git update-ref refs/remotes/origin/master =
HEAD

doener@atjola:git (master) $ git pull
=46rom git://git.kernel.org/pub/scm/git/git
   b11cf09..6096d75  master     -> origin/master
Updating b11cf09..6096d75
=46ast forward
 Documentation/RelNotes-1.6.3.2.txt     |   12 +++++-------
 Documentation/git.txt                  |    7 ++++++-
 contrib/completion/git-completion.bash |   12 ++++++++++--
 grep.c                                 |    6 +++++-
 4 files changed, 26 insertions(+), 11 deletions(-)

doener@atjola:git (master) $ git diff-index --name-only HEAD
doener@atjola:git (master) $ git diff-index --name-only --cached HEAD

*wait a minute, doing nothing*

doener@atjola:git (master) $ git diff-index --name-only HEAD
Documentation/RelNotes-1.6.3.2.txt
Documentation/git.txt
contrib/completion/git-completion.bash
grep.c

doener@atjola:git (master) $ git diff-index --name-only --cached HEAD

doener@atjola:git (master) $ git diff-index --stat HEAD
 0 files changed, 0 insertions(+), 0 deletions(-)

doener@atjola:git (master) $ git diff-index --name-only HEAD
Documentation/RelNotes-1.6.3.2.txt
Documentation/git.txt
contrib/completion/git-completion.bash
grep.c


Running "git status" seems to fix things.

Bj=F6rn, confused
