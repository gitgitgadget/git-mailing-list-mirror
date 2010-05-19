From: Adam Monsen <haircut@gmail.com>
Subject: ok to delete =?utf-8?b?dG1wX3BhY2s=?= file(s)? also, backing up a git repository
Date: Wed, 19 May 2010 23:05:12 +0000 (UTC)
Message-ID: <loom.20100520T010426-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 01:05:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEsKR-0002Jj-Nt
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 01:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0ESXF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 19:05:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:46562 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab0ESXF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 19:05:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OEsKG-0002GI-MQ
	for git@vger.kernel.org; Thu, 20 May 2010 01:05:20 +0200
Received: from 75-149-167-17-Washington.hfc.comcastbusiness.net ([75.149.167.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:05:20 +0200
Received: from haircut by 75-149-167-17-Washington.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:05:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.149.167.17 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147352>

I backup my remote git repositories on sf.net using "rsync -a REMOTE
LOCAL". I chose rsync instead of clone --mirror/fetch because I wanted
hook scripts, "description", and "config" backed up.

I got the following error from my backup cron job:

        rsync: send_files failed to open
        "/mifos/head/objects/pack/tmp_pack_IcK2CZ" (in gitroot):
        Permission denied (13)

So, fine, I can't reach that file. Looks like a temp file--I think I did
a CTRL-C during a push, so maybe that's what caused it to be left
around. A few questions:

     1. Should I just ignore "objects/pack/tmp_pack_*" file in my rsync
        backup?
     2. Should I shell into sf.net and run "git gc" on the repository?
        or "git repack"? or something else?
     3. Is rsync a bad idea? For instance, is the backup useful even if
        rsync was running while someone was doing a "git push" into the
        repository being backed up?
     4. Anyone have different rsync options to recommend for optimal
        backup of a git repository?

Thank you!
-Adam

PS - git rocks... our benefits since migrating from svn are numerous:
* remote folks (UK, India, Africa, etc.) are quite happy with the speed
increase
* branching and merging just works
* examining logs/forensics is much easier and faster
* lots more, but I gotta grab me some lunch
