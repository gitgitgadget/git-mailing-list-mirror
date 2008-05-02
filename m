From: Teemu Likonen <tlikonen@iki.fi>
Subject: BUG: "git checkout" displays Q-escaped commit titles
Date: Fri, 2 May 2008 16:39:03 +0300
Message-ID: <20080502133903.GA3079@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvUT-0004zW-DB
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763034AbYEBNjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760991AbYEBNjI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:39:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:43586 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758105AbYEBNjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:39:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.0.013.9)
        id 481AE2A70002D41C for git@vger.kernel.org; Fri, 2 May 2008 16:39:04 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JrvTb-00017S-Fp
	for git@vger.kernel.org; Fri, 02 May 2008 16:39:03 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80996>

When commit message's first line (i.e. the title) contains non-Ascii
characters "git checkout <commit>" displays this title in Q-escaped for=
m
which looks something like this: =3D?utf-8?q?=3DC3=3D84=3DC3=3DA4kk=3DC=
3=3DB6si=3DC3=3DA4?=3D

Steps to reproduce:

$ mkdir repo
$ cd repo
$ git init
$ echo stuff >file
$ git add file
$ git commit -m "=C4=E4kk=F6si=E4"
$ git checkout $(git rev-list -1 HEAD)
Note: moving to "dc968d26f2fb74a6991c03798ee1d7aab458548a" which isn't =
a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at dc968d2... =3D?utf-8?q?=3DC3=3D84=3DC3=3DA4kk=3DC3=3DB6s=
i=3DC3=3DA4?=3D
