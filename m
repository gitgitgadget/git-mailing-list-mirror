From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v5 0/3] push: submodule support
Date: Mon, 13 Feb 2012 10:25:41 +0100
Message-ID: <20120213092541.GA15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 10:33:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwsHb-0000Sr-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 10:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2BMJdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 04:33:06 -0500
Received: from darksea.de ([83.133.111.250]:42036 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751763Ab2BMJdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 04:33:05 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2012 04:33:05 EST
Received: (qmail 15602 invoked by uid 1000); 13 Feb 2012 10:25:41 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190618>

I have rewritten and cleaned up the recursive submodule on-demand push
patch from Fredrik. Since this involved changing large parts of it I
have taken over the ownership. To pay credit that this is built upon
Fredriks work I have left the signed-off and mentored-by footers the
same. I hope that this is the proper way to handle such cases. If
someone comes up with a better idea I am happy to change things.

Cheers Heiko

The first iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327

The second iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/177992

The third iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179037/focus=179048

The fourth iteration of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/179731

Heiko Voigt (3):
  Teach revision walking machinery to walk multiple times sequencially
  Refactor submodule push check to use string list instead of integer
  push: teach --recurse-submodules the on-demand option

 .gitignore                                       |    1 +
 Documentation/git-push.txt                       |   14 +++-
 Documentation/technical/api-revision-walking.txt |    5 +
 Makefile                                         |    1 +
 builtin/push.c                                   |    7 ++
 object.c                                         |   11 +++
 object.h                                         |    2 +
 revision.c                                       |    5 +
 revision.h                                       |    1 +
 submodule.c                                      |   70 ++++++++++++++---
 submodule.h                                      |    4 +-
 t/t0062-revision-walking.sh                      |   33 ++++++++
 t/t5531-deep-submodule-push.sh                   |   94 ++++++++++++++++++++++
 test-revision-walking.c                          |   66 +++++++++++++++
 transport.c                                      |   41 +++++++++-
 transport.h                                      |    1 +
 16 files changed, 338 insertions(+), 18 deletions(-)
 create mode 100755 t/t0062-revision-walking.sh
 create mode 100644 test-revision-walking.c

-- 
1.7.9.114.gead08
