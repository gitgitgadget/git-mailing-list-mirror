From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 01:36:07 +0200
Message-ID: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1V-00086f-Cv
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab0GMXgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39996 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab0GMXgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:19 -0400
Received: by ewy23 with SMTP id 23so1272362ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PBZEcuVYoiEJbHOLsOl8oUTmFmOZXzTu/lXdjrLV3l0=;
        b=DsLkWxsVVZ7mo4SaPwsVpLWcVJYbMltW27XId5EljhGneo38kdsRycqln3a/xmDG02
         IT4STuezgtivOOFN0zAT8Js8e0eEo0L6oBanY6ZpUXlqiv+f/jPgW2NuwTMKAfM+l6va
         0x21wN7X+OWhXX1ekNyU20n1+2s61aiBf4vyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PQ94febSJBx4KD0f0UBfUM+DAoV2b3+z2UiFki5yA26bItIKPBmz/6Whv9lCnlBEzw
         /uukxdZ4wDvau7Ub6ACO8j09CuLmzzOXmHqi9H+85bVjHoOQ9lN7TF6jOf8WWM5Srsn5
         j0suha+dADeClkwEeKCTs+FbwAO3lm2SeffPk=
Received: by 10.213.32.140 with SMTP id c12mr3499169ebd.95.1279064176588;
        Tue, 13 Jul 2010 16:36:16 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id x54sm51481375eeh.11.2010.07.13.16.36.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150940>

Hi,

For the convinience of fellow Git developers, here's a series to get
svnrdump merged into git.git. Although the series is in excellent
shape (thanks to reviewers), I'd like to make a special request to
relax conformance guidelines a little bit for this series. I'll be
getting commit access to the ASF repository soon; I will commit it
there and make subsequent improvements in Subversion-land. As you can
imagine, due to whitespace and style differences, it's too painful to
backport the changes here. Once there's a release of Subversion with
svnrdump merged in, I will remove it from git.git.

The series incorporates suggestions by Jonathan, Bert, and
Daniel. However, it does not address the recent review by Stefan, and
does not attempt to; Stefan's review will be addressed in future
commits I make to svnrdump in the ASF repository.

Again, I'd request reviewers not to hold up this series for git.git:
suggestions will be incorporated as commits to the ASF. If something
does not work, I'll quickly post fixup patches while the series is
still in `pu`.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (8):
  Add LICENSE
  Add skeleton SVN client and Makefile
  Add debug editor from Subversion trunk
  Drive the debug editor
  Dump the revprops at the start of every revision
  Implement directory-related functions
  Implement file-related functions
  Implement close_file

Will Palmer (1):
  Add a validation script

 vcs-svn/LICENSE        |   26 ++
 vcs-svn/Makefile       |    8 +
 vcs-svn/debug_editor.c |  421 +++++++++++++++++++++++++++++++
 vcs-svn/debug_editor.h |   10 +
 vcs-svn/dump_editor.c  |  652 ++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/dump_editor.h  |    8 +
 vcs-svn/dumpr_util.c   |  112 +++++++++
 vcs-svn/dumpr_util.h   |   92 +++++++
 vcs-svn/svnrdump.c     |  185 ++++++++++++++
 vcs-svn/validate.sh    |  226 +++++++++++++++++
 10 files changed, 1740 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/LICENSE
 create mode 100644 vcs-svn/Makefile
 create mode 100644 vcs-svn/debug_editor.c
 create mode 100644 vcs-svn/debug_editor.h
 create mode 100644 vcs-svn/dump_editor.c
 create mode 100644 vcs-svn/dump_editor.h
 create mode 100644 vcs-svn/dumpr_util.c
 create mode 100644 vcs-svn/dumpr_util.h
 create mode 100644 vcs-svn/svnrdump.c
 create mode 100755 vcs-svn/validate.sh
