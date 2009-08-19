From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 0/6] Git submodule: 'foreach' enhancements and nested
 submodule handling
Date: Wed, 19 Aug 2009 03:45:18 +0200
Message-ID: <1250646324-961-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	mlevedahl@gmail.com, hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 03:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdaFS-0006td-0k
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 03:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZHSBpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 21:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZHSBpo
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 21:45:44 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33143 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750943AbZHSBpn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 21:45:43 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00483OW6N560@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:42 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOL00EC4OW53WE0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 19 Aug 2009 03:45:42 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.19.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126489>

Hi,

This patch series attempts to expand 'git submodule' command in two
regards:

1. Clean up, selftest, and enhance the 'git submodule foreach' command.
2. Provide better handling for nested submodules where the user want to
   operate on _all_ submodules simultenously.

The first 3 patches in the series are fairly trivial and straightforward.
The last 3 patches are slightly more RFC in nature, although their
implementation is still fairly straighforward.

Patch 3/6 is a resend of a patch that I sent stand-alone on 2009-08-16.


Have fun! :)

...Johan


Johan Herland (6):
  git submodule: Cleanup usage string and add option parsing to cmd_foreach()
  Add selftest for 'git submodule foreach'
  git submodule foreach: Provide access to submodule name, as '$name'
  git submodule foreach: Add --recursive to recurse into nested submodules
  git submodule update: Introduce --recursive to update nested submodules
  git submodule status: Add --recursive to recurse into nested submodules

 Documentation/git-submodule.txt |   23 ++++-
 git-submodule.sh                |   79 ++++++++++++--
 t/t7407-submodule-foreach.sh    |  223 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+), 12 deletions(-)
 create mode 100755 t/t7407-submodule-foreach.sh
