From: jidanni@jidanni.org
Subject: rebase-merge/done: No such file or directory
Date: Tue, 13 Jan 2009 03:13:18 +0800
Message-ID: <87ocycjq29.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Jan 12 22:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUYe-00058w-6D
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZALVl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbZALVl1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:41:27 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:47190
	"EHLO homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752247AbZALVl1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 16:41:27 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 5E0039C4E2;
	Mon, 12 Jan 2009 13:41:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105391>

Bug at git-rebase--interactive.sh:107: count=$(grep -c '^[^#]' < "$DONE")

$DONE might not exist. Do test -f $DONE before you grep it.

This will happen if the user gave a wrong squash choice.

$ git rebase --interactive ...
Waiting for Emacs...
grep: .git/rebase-merge/done: No such file or directory
Cannot 'squash' without a previous commit
