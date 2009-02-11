From: Johannes Sixt <j.sixt@viscovery.net>
Subject: gitk endless loop
Date: Wed, 11 Feb 2009 12:26:22 +0100
Message-ID: <4992B5DE.3010207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXDGA-0008G8-WB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZBKL0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 06:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZBKL0k
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 06:26:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56116 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZBKL0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 06:26:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXDEW-0001zZ-4L; Wed, 11 Feb 2009 12:26:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5FE466EF; Wed, 11 Feb 2009 12:26:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109409>

This recipe sends gitk into an endless loop. In git.git do:

cd t
# remove chmod a+x A near the end of the file
sed -i 's/chmod/: chmod/' t3400-rebase.sh
sh t3400-rebase.sh --debug
cd trash\ directory.t3400-rebase/
gitk master modechange modechange@{1}


I briefly see the history chart, but the dot that should be modechange@{1}
is missing. One automatically selected commit is shown in the diff section
below. But then the commit list is cleared and gitk goes into an infinite
loop.

Things work alright if either modechange@{1} is dropped, or the 'chmod'
line is left unchanged, which is a bit strange.

This is with git version 1.6.1.2.390.gba743

-- Hannes
