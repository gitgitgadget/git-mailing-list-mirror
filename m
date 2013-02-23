From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 00/13] Git help option to list user guides
Date: Sat, 23 Feb 2013 23:05:48 +0000
Message-ID: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OAN-00023c-De
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962Ab3BWXFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:05:31 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:22773 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758730Ab3BWXFa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:05:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoYJANpKKVFZ8rke/2dsb2JhbABFumSHdRdzgnw7gQIkiCqeTqAwklUDpyKDBw
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="415328262"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:05:27 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216923>

The git help system will list common commands, and all commands
if asked. However it is difficult for newer users to discover the
guides that are available. This series seeks to add such an option
to 'git help', and allow the user-manual and [git]everyday to be
accessed in the same way.

Patch 1 to 7 update the codebase and look to work correctly.
Patch 1 & 3 are tidy ups. 
The code is very strongly based on the existing common-commands
list so could be refactored and joined if the series is accepted.

Patch 8 onward get into areas of the documentation Makefile that I
need help on so that the user-manual and [git]everyday can 
follow the naming convention for guides and be picked up by the code.
The intent is shown, but the Documentation/Makefile fails for the
renamed gituser-manual and giteveryday - advice needed.

I'm minded to make them have a man page format to simplify changes to
the make file but haven't managed to get that format right. The
alternative is to tweak the make file to cope with these 'pretty'
documents yet still move them to their new names. (I'm unfamiliar
with make files)

Holding pages have been created for the vacated page locations in
the same vein as used for Rename {git- => git}remote-helpers.txt

The patches are built upon V1.8.2-rc0 which includes the recent
user-manual changes.

Initial discussion was at $gmane/215814/focus=216146

Philip Oakley (13):
  Use 'Git' in help messages
  Show 'git help <guide>' usage, with examples
  Help.c use OPT_COUNTUP
  Help.c add --guide option
  Help.c: add list_common_guides_help() function
  Add guide-list.txt and extraction shell
  Extend name string for longer names
  Rename user-manual to gituser-manual
  Rename everyday to giteveryday
  Update Git(1) links to guides
  Add missing guides to list and regenerate
  Documentation/Makefile: update git guide links
  Fixup! doc: giteveryday and user-manual man format

 Documentation/Makefile           |    4 +
 Documentation/everyday.txt       |  424 +---
 Documentation/git.txt            |   12 +-
 Documentation/giteveryday.txt    |  419 ++++
 Documentation/gituser-manual.txt | 4639 +++++++++++++++++++++++++++++++++++++
 Documentation/user-manual.txt    | 4643 +-------------------------------------
 builtin/help.c                   |   11 +-
 common-guides.h                  |   15 +
 generate-cmdlist.sh              |    2 +-
 generate-guidelist.sh            |   23 +
 git.c                            |    4 +-
 guide-list.txt                   |   30 +
 help.c                           |   30 +-
 help.h                           |    1 +
 14 files changed, 5208 insertions(+), 5049 deletions(-)
 create mode 100644 Documentation/giteveryday.txt
 create mode 100644 Documentation/gituser-manual.txt
 create mode 100644 common-guides.h
 create mode 100644 generate-guidelist.sh
 create mode 100644 guide-list.txt

-- 
1.8.1.msysgit.1
