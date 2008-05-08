From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: How to (re-)create .git/logs/refs
Date: Thu, 8 May 2008 12:56:11 +0200
Message-ID: <200805081256.11465.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 13:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju3r8-00023C-5Z
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 13:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762012AbYEHK7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 06:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761933AbYEHK7S
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 06:59:18 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:18604 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761610AbYEHK7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 06:59:16 -0400
Received: from lin01.mn-solutions.de (pD95F84B8.dip0.t-ipconnect.de [217.95.132.184])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 6B7BE5E4143
	for <git@vger.kernel.org>; Thu,  8 May 2008 12:59:14 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id F0E8D1E004D; Thu,  8 May 2008 12:56:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id D20B41E0004
	for <git@vger.kernel.org>; Thu,  8 May 2008 12:56:19 +0200 (CEST)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81524>

Hi !

I have an old SVN project with lots of commits from 2005 to 2008
converted. This was a month ago. In the mean-time, I've made
some commits from git as well.

"git log" shows both types of commit quite nicely.

"git checkout <sha1>" works also correctly, for arbitrary ancient
SHA1s.

"git checkout @{2007-04-01}" doesn't work. I get an error like
this:

  warning: Log for '' only goes back to Thu, 8 May 2008 09:35:38 +0000.
  fatal: bad object @{2007-04-01}

However, "git checkout @{2008-05-01}" works, because this commit
was a git commit, not an SVN-converted one. It seems that
neiver "git svn clone" nor "examples/git-svnimport.perl"
creates/updates .git/logs/refs and that therefore @{date} is
useless here.


So my question:

a) is there a way to re-create .git/logs/refs ?

b) is there a simple way to get a list of ISO-dates and
   associated SHA1?  Then I could use a little python code to
   determine the SHA1 id that corresponds to some date (I need
   to access old versions of the source via bitbake and/or
   www.openembedded.org, so adding a custom fetch method with
   some python magic is a non-brainer).

c) any plan to fix git-svn?
