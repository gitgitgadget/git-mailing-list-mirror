From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: How to (re-)create .git/logs/refs
Date: Thu, 8 May 2008 11:48:43 +0200
Message-ID: <200805081148.43657.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 12:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju2vp-00071Q-0x
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 12:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbYEHKAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 06:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbYEHKAG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 06:00:06 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:24918 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbYEHKAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 06:00:04 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 06:00:04 EDT
Received: from lin01.mn-solutions.de (pD95F84B8.dip0.t-ipconnect.de [217.95.132.184])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 705265E411F
	for <git@vger.kernel.org>; Thu,  8 May 2008 11:51:46 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id A581E1E004D; Thu,  8 May 2008 11:48:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id C8AD81E0004
	for <git@vger.kernel.org>; Thu,  8 May 2008 11:48:51 +0200 (CEST)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81520>

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
come from git direct, not implicitly from SVN. It seems that
neiver "git svn clone" nor "examples/git-svnimport.perl"
creates/updates .git/logs/refs when it creates commits from an
old SVN repository.


So my question:

a) is there a way to re-create .git/logs/refs ?

b) is there a simple way to get a list of ISO-dates and
   associated SHA1?  Then I could use a little python code to
   determine the SHA1 id that corresponds to some date (I need
   to access old versions of the source via bitbake and/or
   www.openembedded.org, so adding a custom fetch method with
   some python magic is a non-brainer).
