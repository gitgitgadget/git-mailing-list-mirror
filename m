From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] minor error message newline purge
Date: Sun, 29 Apr 2012 20:28:44 -0400
Message-ID: <1335745726-2583-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 02:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOeU2-0000G4-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 02:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab2D3A2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 20:28:50 -0400
Received: from honk.padd.com ([74.3.171.149]:35039 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2D3A2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 20:28:49 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id 403D32EB4;
	Sun, 29 Apr 2012 17:28:49 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 761C5313F8; Sun, 29 Apr 2012 20:28:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.574.g53b8dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196524>

Some error messages show up with an extra blank line, like this
one:

    $ git commit -m foo
    unable to create temporary sha1 filename : Too many open files

    error: Error building trees
    $

Most of the callers of error() and similar functions in usage.c
don't add a newline, but a few do, causing odd output like the
above.

No tests for these; they're hopefully trivial.  One of the edited
messages was marked for translation.  I'm not sure if changing it
requires any work in po/.

Pete Wyckoff (2):
  remove superfluous newlines in error messages
  remove blank filename in error message

 builtin/branch.c                       |    2 +-
 builtin/merge-file.c                   |    4 ++--
 builtin/unpack-objects.c               |    2 +-
 compat/win32mmap.c                     |    2 +-
 contrib/examples/builtin-fetch--tool.c |    4 ++--
 fsck.c                                 |    2 +-
 http-push.c                            |    4 ++--
 http.c                                 |    2 +-
 imap-send.c                            |    2 +-
 ll-merge.c                             |    2 +-
 object.c                               |    6 +++---
 sha1_file.c                            |    6 +++---
 transport-helper.c                     |    4 ++--
 unpack-trees.c                         |    2 +-
 vcs-svn/svndump.c                      |    4 ++--
 15 files changed, 24 insertions(+), 24 deletions(-)

-- 
1.7.10.572.ged86f
