From: "Yann Dirson" <ydirson@linagora.com>
Subject: [BUG] git stash refuses to save after "add -N"
Date: Fri, 28 Aug 2009 13:02:23 +0200
Message-ID: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 13:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgzKb-0004qn-PM
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 13:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZH1LJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 07:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbZH1LJL
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 07:09:11 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:53521 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZH1LJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 07:09:11 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2009 07:09:10 EDT
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id BCC57429F04
	for <git@vger.kernel.org>; Fri, 28 Aug 2009 13:02:07 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Fri, 28 Aug 2009 13:02:23 +0200
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127290>

$ echo foo > bar
$ git add -N bar
$ ./git --exec-path=$PWD stash save
bar: not added yet
fatal: git-write-tree: error building trees
Cannot save the current index state


Maybe it would require some magic in git-stash to detect/save/restore that
particular state, or "just" to cause "add -N" to insert an empty file
instead ?

I suspect that second solution would not be particularly popular, but I
don't find the 1st one very appealing, it just looks like breaking the
whole idea behind git-stash :)
