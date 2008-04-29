From: Lars Alexander Noschinski <Lars.Noschinski@rwth-aachen.de>
Subject: cvsexportcommit and cvsimport's -k option
Date: Tue, 29 Apr 2008 19:15:06 +0200
Message-ID: <f6c6e2a5cc39.481773ba@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 19:16:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqtQt-0006k7-LT
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYD2RPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbYD2RPJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:15:09 -0400
Received: from mta-2.ms.rz.RWTH-Aachen.DE ([134.130.7.73]:35969 "EHLO
	mta-2.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751035AbYD2RPI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2008 13:15:08 -0400
Received: from ironport-out-2.rz.rwth-aachen.de ([134.130.3.59])
 by mta-2.ms.rz.RWTH-Aachen.de
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0K0300GOIJX6PU70@mta-2.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Tue, 29 Apr 2008 19:15:06 +0200 (CEST)
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-2.rz.rwth-aachen.de with ESMTP; Tue,
 29 Apr 2008 19:15:06 +0200
Received: from msg-int.RWTH-Aachen.DE
 (store-2.ms.rz.RWTH-Aachen.DE [134.130.7.105])	by smarthost.rwth-aachen.de
 (8.13.8+Sun/8.13.8/1) with ESMTP id m3THF60b005074	for <git@vger.kernel.org>;
 Tue, 29 Apr 2008 19:15:06 +0200 (CEST)
Received: from [134.130.7.66] (Forwarded-For: [137.226.194.26])
 by msg-store-b.ms.rz.RWTH-Aachen.DE (mshttpd); Tue, 29 Apr 2008 19:15:06 +0200
X-Mailer: Sun Java(tm) System Messenger Express 6.2-8.04 (built Feb 28 2007)
Content-language: de
Content-disposition: inline
X-Accept-Language: de
X-IronPort-AV: E=Sophos;i="4.25,723,1199660400";   d="scan'208";a="41031861"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80706>

[Please CC me on answers, as I'm not subscribed.]

Hello!

Im using git to work on an CVS project. My work cycle is as follows:

... hack away ...
git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
git-rebase cvs # If work was done in the meantime
git-cvsexportcommit -cpuv $COMMIT # Multiple times, if necessary
git-cvsimport -i -r cvs -kk -v -d $CVSREPOS
git-checkout -b master cvs # commit ids are changed now

As far as I am concerned, this works fairly well, accept when for any reason
a line containing a CVS keyword (e.g. $Id$) is contained in a changeset. In
this case, patching fails, and I have to investigate why it fails, eventually
just copying the old version from the cvs repository.

Would it be possible to add an option to cvsexportcommit to detect such
killed keywords and ignore them?


Greetings,
   Lars.
