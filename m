From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 0/5] Git help option to list user guides
Date: Tue,  2 Apr 2013 23:39:47 +0100
Message-ID: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9sW-00037Z-0s
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447Ab3DBWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:39:42 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:45193 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933441Ab3DBWjk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:39:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtgSAPtcW1FOl3a6/2dsb2JhbABDgwcBgmy2XoZ4BAGBBBd0gnwjGIECJIgrsWuQE418gR2DRwOndoMMOw
X-IronPort-AV: E=Sophos;i="4.87,396,1363132800"; 
   d="scan'208";a="571152194"
Received: from host-78-151-118-186.as13285.net (HELO localhost) ([78.151.118.186])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 02 Apr 2013 23:39:38 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219897>

This is the re-roll of $gmane/217384. The series seeks to provide a help
option that will list the common git guides, and how to access them.

The series is rebased on top of V1.8.2 

Since V2, the OPT_BOOL is now used instead of OPT_COUNTUP.
The git_more_info_string has been further updated inline with Junio's
suggestions, and re-spaced so that command example are not split over
line ends.

Junio's suggestions in $gmane/217354/focus=217355 have been included.
Junio also asked about the `if (!argv[0])` test which is, correctly,
performed _after_ the -a and -g options are taken, as they overide any
remaining arguments.

The list of guides is spaced out in the same manner as the common
command list.

Philip Oakley (5):
  Show help: -a and -g option, and 'git help <concept>' usage.
  Help.c use OPT_BOOL and refactor logic
  Help.c add --guide option
  Help.c: add list_common_guides_help() function
  Help doc: Include --guide option description

 Documentation/git-help.txt | 30 ++++++++++++++++++++++--------
 builtin/help.c             | 17 +++++++++++++++--
 common-guides.h            | 11 +++++++++++
 git.c                      |  4 +++-
 help.c                     | 18 ++++++++++++++++++
 help.h                     |  1 +
 6 files changed, 70 insertions(+), 11 deletions(-)
 create mode 100644 common-guides.h

-- 
1.8.1.msysgit.1
