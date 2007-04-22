From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] 42c4b58059f.. during "make install-doc": git-add.5: No such file or directory
Date: Sun, 22 Apr 2007 07:12:51 -0700
Message-ID: <86bqhgqyzg.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 16:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfcoB-0006kD-Cf
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 16:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030881AbXDVOMv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 10:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030891AbXDVOMv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 10:12:51 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:44551 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030881AbXDVOMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 10:12:51 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1D0681DE314; Sun, 22 Apr 2007 07:12:51 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.10; tzolkin = 1 Oc; haab = 18 Pop
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45242>


42c4b58059fa9af65e90f2c418bb551e30d1d32f

$ make install-doc
...
install: git-add.5: No such file or directory
...

which then rolls back deleting all my xml files. :(

Aha... I think it's this line:

       DOC_MAN5=$(patsubst %.txt,%.5,$(MAN1_TXT))

I'm betting that should be MAN5_TXT.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
