From: wking@tremily.us
Subject: =?UTF-8?q?=5BPATCH=20v6=200/3=5D=20gitweb=3A=20refactor=20If-Modified-Since=20handling?=
Date: Wed, 28 Mar 2012 11:46:58 -0400
Message-ID: <cover.1332949186.git.wking@drexel.edu>
References: <201203281613.52624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"W. Trevor King" <wking@drexel.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCv5r-0003Dz-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727Ab2C1PrW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 11:47:22 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:49914 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab2C1PrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:47:22 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L00DLCQIOAQ10@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 10:47:13 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 984BB43ADE5; Wed,
 28 Mar 2012 11:47:11 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 28 Mar 2012 11:47:27 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <201203281613.52624.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194134>

Changes since v5:
* Use `test_when_finished` to unset HTTP_IF_MODIFIED_SINCE.
* Actually use the tree ID in the `modification: tree snapshot` test.
* Conditional last_modified argument for `$cgi->header` git_snapshot
  and git_feed.
* tree-ish -> trees in git_snapshot commit message and test name.

Unchanged since v5:
* Patch 1/3, but I'm resending it anyway with `git send-email`.  I
  could skip resending it with:

    git send-email =E2=80=A6 HEAD^^

  but that would mess up the patch numbering.


W. Trevor King (3):
  gitweb: add `status` headers to git_feed() responses.
  gitweb: refactor If-Modified-Since handling
  gitweb: add If-Modified-Since handling to git_snapshot().

 gitweb/gitweb.perl                       |   65 ++++++++++++++++++----=
--------
 t/t9501-gitweb-standalone-http-status.sh |   60 ++++++++++++++++++++++=
+++++-
 2 files changed, 98 insertions(+), 27 deletions(-)

--=20
1.7.3.4
