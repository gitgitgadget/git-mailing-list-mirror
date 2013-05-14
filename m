From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/47] remote-hg: fixes for next
Date: Mon, 13 May 2013 23:36:23 -0500
Message-ID: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70d-0003dy-RT
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab3ENEij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47144 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab3ENEij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so95646obb.19
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qqRx3ukHtlryjOHN9DWgJX5kTh0VWAc1shdo8GwS0a8=;
        b=LwCdE2DH1sdefet+re+Dlh/Fx0eeA91+5BHJy9HmvsVVnjcMWEYFXhrq/MPdct8ZOA
         4IgFRrG4CKCpynSRW/aqIAfyh0A8aJnQgfSJDbRcd+hxMxdMp7rHFd9VpCLYBeZvaxzd
         yKPkVQfgtPCQEx29axsnwylCC8d8oFQYryLzlMAZPeGNwBzs6LGABC9eRguUVpKOj+C3
         YvQj4jKiI01JtuXGT8L73X/FpyaZAgaXydPZW7LV4oled2Aq2rJ8O2Wi60arBThHFPoE
         7I6YFVuM8r7ZY6ocI/JvBikblFVWD91xd2XYZ2tstLvCe0JPZLq82te7Hh80tNHneMLs
         qfKQ==
X-Received: by 10.60.97.4 with SMTP id dw4mr15328242oeb.75.1368506318869;
        Mon, 13 May 2013 21:38:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm20014909obb.5.2013.05.13.21.38.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224235>

Hi,

I've been cooking these for some time now, and they seem to be mostly ready.
The major changes are:

 1) Use our own custom push() method that allows us to push bookmarks without
    having to force a push.

 2) Switch from revision numbers to SHA-1s in the marks.

 3) Use a common repsitory so multiple remotes chan share the same objects.

 4) Cleaned up and add a ton of tests

With these, we pass all the tests from gitifyhg as well as our own.

Felipe Contreras (47):
  remote-hg: trivial cleanups
  remote-hg: get rid of unused exception checks
  remote-hg: enable track-branches in hg-git mode
  remote-hg: add new get_config_bool() helper
  remote-hg: fix new branch creation
  remote-hg: disable forced push by default
  remote-hg: don't push fake 'master' bookmark
  remote-hg: update bookmarks when pulling
  remote-hg: test: be a little more quiet
  remote-hg: trivial reorganization
  remote-helpers: test: cleanup white-spaces
  remote-helpers: test: cleanup style
  remote-helpers: tests: general improvements
  remote-helpers: test: simplify remote URLs
  remote-hg: test: simplify previous branch checkout
  remote-hg: load all extensions
  remote-hg: use a shared repository store
  remote-hg: shuffle some code
  remote-hg: improve node traversing
  remote-hg: add version checks to the marks
  remote-hg: switch from revisions to SHA-1 noteids
  remote-hg: upgrade version 1 marks
  remote-hg: ensure remote rebasing works
  remote-hg: trivial cleanups
  remote-hg: improve progress calculation
  remote-hg: always point HEAD to master
  remote-bzr: simplify test checks
  remote-hg: add check_bookmark() test helper
  remote-hg: add remote tests
  remote-hg: add test to push new bookmark
  remote-hg: add test for diverged push
  remote-hg: add test for bookmark diverge
  remote-hg: add test for new bookmark special
  remote-hg: add test for big push
  remote-hg: add test for failed double push
  remote-hg: reorganize bookmark handling
  remote-hg: force remote bookmark push selectively
  remote-hg: only update necessary revisions
  remote-hg: implement custom  push()
  remote-hg: implement custom checkheads()
  remote-hg: pass around revision refs
  remote-hg: check diverged bookmarks
  remote-hg: simplify branch_tip()
  remote-hg: improve branch listing
  remote-hg: use remote 'default' not local one
  remote-hg: improve lightweight tag author
  remote-hg: remove files before modifications

 contrib/remote-helpers/git-remote-hg     | 444 ++++++++++++++++++----------
 contrib/remote-helpers/test-bzr.sh       | 490 +++++++++++++++---------------
 contrib/remote-helpers/test-hg-bidi.sh   |  33 +--
 contrib/remote-helpers/test-hg-hg-git.sh |  47 ++-
 contrib/remote-helpers/test-hg.sh        | 492 +++++++++++++++++++++++++------
 5 files changed, 974 insertions(+), 532 deletions(-)

-- 
1.8.3.rc1.579.g184e698
