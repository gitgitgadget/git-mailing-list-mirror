From: Pierre Habouzit <madcoder@debian.org>
Subject: [RFC] CLI option parsing and usage generation for porcelains
Date: Sat, 13 Oct 2007 15:29:02 +0200
Message-ID: <1192282153-26684-1-git-send-email-madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 15:29:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igh3h-00080I-5W
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 15:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbXJMN3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 09:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbXJMN3Q
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 09:29:16 -0400
Received: from pan.madism.org ([88.191.52.104]:49037 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbXJMN3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 09:29:15 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 606DE245EF
	for <git@vger.kernel.org>; Sat, 13 Oct 2007 15:29:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9AC5139A8DF; Sat, 13 Oct 2007 15:29:13 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Following Kristian momentum, I've reworked his parse_option module
quite a lot, and now have some quite interesting features. The series is
available from git://git.madism.org/git.git (branch ph/strbuf).

  The following series is open for comments, it's not 100% ready for
inclusion IMHO, as some details may need to be sorted out first, and
that I've not re-read the patches thoroughly yet. Though I uses the tip
of that branch as my everyday git for 2 weeks or so without any
noticeable issues.

  And as examples are always easier to grok:

$ git fetch -h
usage: git-fetch [options] [<repository> <refspec>...]

  -q, --quiet           be quiet
  -v, --verbose         be verbose

  -a, --append          append in .git/FETCH_HEAD
  -f, --force           force non fast-forwards updates
  --no-tags             don't follow tags at all
  -t, --tags            fetch all tags
  --depth <depth>       deepen history of a shallow clone

Advanced Options
  -k, --keep            keep downloaded pack
  -u, --update-head-ok  allow to update the head in the current branch
  --upload-pack <path>  path to git-upload-pack on the remote

$ git rm -rf xdiff # yeah -rf now works !
rm 'xdiff/xdiff.h'
rm 'xdiff/xdiffi.c'
rm 'xdiff/xdiffi.h'
rm 'xdiff/xemit.c'
rm 'xdiff/xemit.h'
rm 'xdiff/xinclude.h'
rm 'xdiff/xmacros.h'
rm 'xdiff/xmerge.c'
rm 'xdiff/xprepare.c'
rm 'xdiff/xprepare.h'
rm 'xdiff/xtypes.h'
rm 'xdiff/xutils.c'
rm 'xdiff/xutils.h'
