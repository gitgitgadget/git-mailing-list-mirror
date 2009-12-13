From: Moe <moe@signalbeam.net>
Subject: on-any-overwrite hook, filename for smudge filter?
Date: Sun, 13 Dec 2009 18:55:54 +0100
Message-ID: <4B252AAA.2070203@signalbeam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 19:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJsmw-0003Ov-B5
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 19:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbZLMSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 13:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbZLMSCM
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 13:02:12 -0500
Received: from s2.mbox.bz ([85.214.91.204]:58079 "HELO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752755AbZLMSCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 13:02:11 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Dec 2009 13:02:11 EST
Received: from mini.local (unknown [92.206.92.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id 43E08E04B62
	for <git@vger.kernel.org>; Sun, 13 Dec 2009 18:55:55 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135149>

Hello git family.

I'm looking for a way to reliably preserve permissions in a repository.

I found the excellent metastore-utility[1] (which also backs etckeeper),
but it hooks into git-pull and can miss file overwrites caused by other
operations.

The closest I found to a global "on-any-file-overwrite" hook would be
the "smudge" filter-command as described in gitattributes(5).

Unfortunately the smudge-command seems to never learn
about a filename but merely filters stdin -> stdout.

The regular hooks don't cut it either, as for example the git-merge
hook doesn't run on partial merges ("XXX needs update").

So, is there a way to run a script after git has
overwritten any local file for any reason?


Best, Moe

[1] http://git.hardeman.nu/?p=metastore.git
