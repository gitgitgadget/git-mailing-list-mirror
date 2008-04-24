From: "Terje Sten Bjerkseth" <terje@ceteo.no>
Subject: Re: Problems importing from Apache SVN
Date: Thu, 24 Apr 2008 08:16:15 +0200
Message-ID: <ceb24f170804232316p5312febeuc19728efb700619b@mail.gmail.com>
References: <935ead450804231050u25be05bcjaaab22caa82c984c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeffrey Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:17:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoulY-0005FY-QH
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYDXGQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 02:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYDXGQT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:16:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21769 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYDXGQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 02:16:18 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2345236wff.4
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 23:16:16 -0700 (PDT)
Received: by 10.142.58.17 with SMTP id g17mr74766wfa.330.1209017775761;
        Wed, 23 Apr 2008 23:16:15 -0700 (PDT)
Received: by 10.142.186.12 with HTTP; Wed, 23 Apr 2008 23:16:15 -0700 (PDT)
In-Reply-To: <935ead450804231050u25be05bcjaaab22caa82c984c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80293>

On Wed, Apr 23, 2008 at 7:50 PM, Jeffrey Ollie <jeff@ocjtech.us> wrote:
>  I'm having some problems importing CouchDB from the Apache SVN
>  repository.  Here's what I get:
>
>  $ rpm -q subversion-perl
>  subversion-perl-1.4.6-7.x86_64
>  $ git --version
>  git version 1.5.5.1
>  $ git svn init -s http://svn.apache.org/repos/asf/incubator/couchdb
>  Initialized empty Git repository in .git/
>  Using higher level of URL:
>  http://svn.apache.org/repos/asf/incubator/couchdb =>
>  http://svn.apache.org/repos/asf
>  $ git svn fetch
>  W: Ignoring error from SVN, path probably does not exist: (175002): RA
>  layer request failed: REPORT request failed on
>  '/repos/asf/!svn/bc/100': REPORT of '/repos/asf/!svn/bc/100': 200 OK
>  (http://svn.apache.org)
>  W: Do not be alarmed at the above message git-svn is just searching
>  aggressively for old history.
>  This may take a while on large repositoriesRA layer request failed:
>  REPORT request failed on '/repos/asf/!svn/vcc/default': REPORT of
>  '/repos/asf/!svn/vcc/default': 200 OK (http://svn.apache.org) at
>  /usr/bin/git-svn line 3833

Works for me using git svn clone. git svn init fails for me, too.

$ git --version
git version 1.5.5.1.57.g5909c
$ git svn clone http://svn.apache.org/repos/asf/incubator/couchdb
Initialized empty Git repository in .git/
W: Ignoring error from SVN, path probably does not exist: (175007):
HTTP Path Not Found: REPORT request failed on
'/repos/asf/!svn/bc/100/incubator/couchdb':
'/repos/asf/!svn/bc/100/incubator/couchdb' path not found
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories

(wait!!)

Checked out HEAD:
  http://svn.apache.org/repos/asf/incubator/couchdb r650729

Then use get svn fetch && git svn rebase to get updates.
