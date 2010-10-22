From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 0/3] Documentation: refactor config variable descriptions
Date: Fri, 22 Oct 2010 07:02:28 +0200
Message-ID: <cover.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 07:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99mX-0006us-R1
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab0JVFDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:03:03 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11329 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab0JVFDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:03:02 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 22 Oct
 2010 07:02:59 +0200
Received: from localhost.localdomain (129.132.209.169) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 22 Oct
 2010 07:02:38 +0200
X-Mailer: git-send-email 1.7.3.1.281.g5da0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159641>

This resurrects (finally) the earlier attempt at

  http://mid.gmane.org/cover.1280169048.git.trast@student.ethz.ch

It tries the inverse approach: teaching the script how to find config
variable blocks in each manpage, and then linking them from the main
list.  (Obviously just inserting them into the main list could also
work.)

In other words, it attempts to push out the "original" documentation
of each variable from the main list to the individual manpage, which
is exactly opposite from v1.

This has the advantage that it does not make the source .txt for each
manpage "unreadable by themselves", as the earlier approach did (and
Jonathan noticed).

It also has the advantage that it will shrink config-vars.txt over
time.

Instead of going through all manpages again, I just tacked on a sample
patch as 3/3 that shows what the use/effect could be.  Once we settle
on the direction (v1 or v2) of the refactoring, I'll make more patches
or resurrect the old ones.

I'm afraid 1/3 (semantically unchanged from the equivalent patch in
v1) will again not make it through, so I again pushed this out:

  git://repo.or.cz/git/trast.git t/doc-config-extraction-v2

(incidentally v1 is still there as t/doc-config-extraction).  I based
it on master; 1/3 is prone to conflicts but can easily be recreated
from scratch.


Thomas Rast (3):
  Documentation: Move variables from config.txt to separate file
  Documentation: complete config list from other manpages
  Documentation: move format.* documentation to format-patch

 Documentation/Makefile              |    9 +-
 Documentation/config-vars-src.txt   | 1691 +++++++++++++++++++++++++++++++++
 Documentation/config.txt            | 1748 +----------------------------------
 Documentation/git-format-patch.txt  |   65 ++-
 Documentation/make-config-list.perl |  131 +++
 5 files changed, 1892 insertions(+), 1752 deletions(-)
 create mode 100644 Documentation/config-vars-src.txt
 create mode 100755 Documentation/make-config-list.perl

-- 
1.7.3.1.281.g5da0b
