From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: "git log --first-parent" shows parents that are not first
Date: Sun, 11 May 2008 11:23:41 +0900
Message-ID: <20080511112341.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 04:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv1KA-0001hg-QV
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 04:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbYEKC2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYEKC2w
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 22:28:52 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:34451 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYEKC2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 22:28:51 -0400
Received: from fe1.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4B2Sot0012982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 May 2008 19:28:51 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:subject:date:message-id:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=a32ZBBxct/wfEGB+JfiTYHuLr6Y/j8TY66sFPWP5V420NphoQs5OZNC8as6aPcczt
	RkzpGzkdQ39pBbJrtNwvclu8y/MkCJ19mwlPhTkwzf3pHFpnzHL2xuxm+uuKcCs
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4B2SifI029246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 May 2008 19:28:49 -0700
X-Trusted-Delivery: <677eb34eb21f5d385ddcba45b48d1774>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81724>

The result given by "git log --first-parent" ('next' version) is
unexpected to me.

  % git rev-parse origin/next
  4eddac518225621c3e4f7285beb879d2b4bad38a
  % git log --abbrev-commit --pretty=oneline --first-parent origin/next^..origin/next
  4eddac5... Merge branch 'master' into next
  1f8115b... Merge branch 'maint'
  ca1c991... Merge branch 'sg/merge-options' (early part)
  31a3c6b... Merge branch 'db/learn-HEAD'
  a064ac1... Merge branch 'jn/webfeed'
  d576c45... Merge branch 'cc/help'
  ca1a5ee... Merge branch 'dm/cherry-pick-s'
  4c4d3ac... Merge branch 'lt/dirmatch-optim'
  c5445fe... compat-util: avoid macro redefinition warning
  eb120e6... compat/fopen.c: avoid clobbering the system defined fopen macro
  bac59f1... Documentation: bisect: add a few "git bisect run" examples
  d84ae0d... Documentation/config.txt: Add git-gui options
  921177f... Documentation: improve "add", "pull" and "format-patch" examples
  c904bf3... Be more careful with objects directory permissions on clone

I asked for the log between one commit before the tip of "origin/next" and the tip of the branch, following only the first-parent links.  v1.5.5 is not broken and shows the expected result:

  % ~/git-v1.5.5/bin/git log --abbrev-commit --pretty=oneline --first-parent origin/next^..origin/next
  4eddac5... Merge branch 'master' into next

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
