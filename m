From: Marc Weber <marco-oweber@gmx.de>
Subject: FTP Synchronization
Date: Thu, 11 Jun 2009 02:03:42 +0200
Message-ID: <20090611000342.GA20699@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEXlp-0002lg-N0
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 02:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbZFKADp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbZFKADo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 20:03:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:37461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932173AbZFKADn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 20:03:43 -0400
Received: (qmail invoked by alias); 11 Jun 2009 00:03:43 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp038) with SMTP; 11 Jun 2009 02:03:43 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19L47xoiiZLI5/LkOdyZAHAABZEEWPzZV0A7MQK2q
	kFF+RBXcPsSSTN
Received: by mail.gmx.net (sSMTP sendmail emulation); Thu, 11 Jun 2009 02:03:42 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121318>

Has anyone a FTP synchranization which behaves like this yet?

1) get current version from ftp by readitg $REMOTE/hash
2) calculate git-diff `ftp get $REMOTE/hash`..HEAD
3) ftp push all files which have changed and
   ftp rm all files which have been deleted
4) write HEAD to $REMOTE/hash

What happens if there is a failure in the middle?
Then 4) doesn't take place and all the actions will be replayed
(probably ignoring errors). Also there should be a sync option recopying
all files which are know to git at HEAD.

I don't want to use bash because I can't keep a FTP connection open, can
I? (Maybe using lfpt and stdin redirection hacks ?)
git perl lib support is better than python support, right?

If not how to do this? Maybe I should look at the git diff code to get
to know or start comparing the git ls-tree output or such?

Of course I'd like this to be as fast as possible.

Marc Weber
