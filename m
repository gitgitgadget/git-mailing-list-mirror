From: Peter Eriksen <s022018@student.dtu.dk>
Subject: Re: Hard link problem during build
Date: 02 Apr 2008 14:12:11 +0200
Message-ID: <yqsr1w5oa21w.fsf@rifpc20.inf.ethz.ch>
References: <606CC410B038E34CB97646A32D0EC0BF09E1A4@venusbis.synchrotron-soleil.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 14:13:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh1qF-00024D-In
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 14:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbYDBMMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 08:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYDBMMd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 08:12:33 -0400
Received: from main.gmane.org ([80.91.229.2]:55392 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755291AbYDBMMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 08:12:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jh1pH-00082Z-DR
	for git@vger.kernel.org; Wed, 02 Apr 2008 12:12:23 +0000
Received: from rifpc20.inf.ethz.ch ([129.132.45.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Apr 2008 12:12:23 +0000
Received: from s022018 by rifpc20.inf.ethz.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Apr 2008 12:12:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rifpc20.inf.ethz.ch
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78692>

...
> I am working with a filesystem mounted via nfs.
...

> It seems that it do not allow hard linkage. Nevertheless soft linkage
> is allow.

Beware that git depends on that stat() gives the correct (Posix) size of
symlinks. This can give problems, if a Windows filesystem is mounted
over NFS.

> So the build process failed during the link of built-in commands.
> git-merge-subtree$X: target and
> $(BUILT_INS): target.
> 
> Is it necessary to do hard link instead of soft link ?

You can change the Makefile (look for calls to 'ln') to copy the build-in
commands instead of linking them, and that should work (but waste some
space).

Peter
