From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/8] Miscelanous gitweb improvements from 'Gitweb caching v5' by J.H.
Date: Sat, 30 Jan 2010 23:30:37 +0100
Message-ID: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqM-0008H6-4w
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab0A3Wa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753339Ab0A3Wa7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:30:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:19827 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab0A3Wa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:30:58 -0500
Received: by fg-out-1718.google.com with SMTP id l26so1302696fgb.1
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UxZZrOkcJFAThhg6VUex1T4/42w6RJnrdRAYoj0SgXc=;
        b=gbHh+cBY6h9PCDY8TqMVOZCtgFlbLlMhBgYElt9fglepQ9US2j2vWD7TOKDLptVelD
         ih1LVnAPySRqIqViti17MSi+yiJq2LKpYzrhJUaNM1upA396BQpxD+RILQvluLB4tEgY
         91AhgOT3bC33ygYEAsgSk/sCXKGxd0shCSXdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Tt/IaA46Y2AQ5alvzeJLIR0v/9PN5fniYAMV4X3Ka7sjnDpYsPqPLZX6I7HoES/NDc
         4PM6Ad2bo/g579ZeBGG2RJG3ayydlCdViJ5TpmvXa42ItoY/jffNT74H8Bp0s41mYeCp
         O77HiH6V2YeGZZxx/Ung6rvVlSiYwT+6xrNSE=
Received: by 10.87.70.26 with SMTP id x26mr4580434fgk.10.1264890657263;
        Sat, 30 Jan 2010 14:30:57 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.30.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:30:56 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138505>

This series of patches consist of improved and reordered, and rebased early
parts (1-7) of "[PATCH 0/9] Gitweb caching v5" thread by John 'Warthog9'
Hawley.  Those patches are also available from
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

I have added signoff where it was missing, and changed all authorship
of patches by J.H. to use @kernel.org email address.

Pull request:
~~~~~~~~~~~~~
The following changes since commit 3a985c27fe8bb9ed2fa9580a27c4b4dd7c7192ea:
  Junio C Hamano (1):
        Update draft release notes to 1.7.0

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/gitweb-ml-v5

Table of contents:
~~~~~~~~~~~~~~~~~~
 [PATCH 1/8] gitweb: Make running t9501 test with '--debug' reliable and usable
 [PATCH 2/8] gitweb: Load checking
 [PATCH 3/8] gitweb: Makefile improvements
 [PATCH 4/8] gitweb: Check that $site_header etc. are defined before using them
 [PATCH 5/8] gitweb: add a get function to compliment print_local_time
 [PATCH 6/8] gitweb: add a get function to compliment print_sort_th
 [PATCH 7/8] gitweb: Add optional extra parameter to die_error, for extended explanation
 [PATCH 8/8] gitweb: Add an option to force version match

First patch in series is my addition, made to be able to run t9501 test in
'debug' mode without it screwing terminal due to dumping (binary!) snapshot
to it.  All patches in series passes t9500, t9501 and t9502; it allowed to
find bugs in their implementation.

I have reordered patches so those that are less controversial and more
ready to be applied come first, and those that are a bit controversial and
perhaps less ready later (and also later those patches that introduce new
feature without any user for it).

The patches 5 and 6 "add a get function" introduce new format_* functions
which do not have yet any user in gitweb.

Patch 7 "optional extra parameter to die_error" is used only in patch 8,
but it would be I think good feature to have anyway.

In patch 8 the $git_versions_must_match variable is again set to 0 (off) by
default; Pasky's complaint in
  Message-ID: <20100124215924.GA9553@machine.or.cz>
  http://permalink.gmane.org/gmane.comp.version-control.git/137922
made me notice (see my reply to it) that it could be very hard to explain
how to setup gitweb to turn this feature off, in some rare cases.  So it is
again off, and with more detailed explanation of an error.

Note that like 'Gitweb caching v5' thread this series is missing
  gitweb: Optionally add "git" links in project list page
that was present in 'Gitweb caching v2' and 'Miscelanous gitweb
improvements from J.H.' threads.

Diffstat:
~~~~~~~~~
 Makefile                                 |   65 +++------------
 gitweb/Makefile                          |  129 ++++++++++++++++++++++++++++++
 gitweb/README                            |   12 +++-
 gitweb/gitweb.perl                       |  121 ++++++++++++++++++++++++----
 t/gitweb-lib.sh                          |    2 +
 t/t9501-gitweb-standalone-http-status.sh |   57 ++++++++++++-
 6 files changed, 309 insertions(+), 77 deletions(-)
 create mode 100644 gitweb/Makefile

-- 
Jakub Narebski
Poland
