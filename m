From: "Marco Costalba" <mcostalba@gmail.com>
Subject: qgit: added "Renames following" in annotation
Date: Fri, 6 Jul 2007 22:53:28 +0200
Message-ID: <e5bfff550707061353g2a84afa3nf5b9accda274cfd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:53:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6uo0-0005SA-2d
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 22:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760057AbXGFUx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 16:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbXGFUx3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 16:53:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:60415 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbXGFUx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 16:53:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so421679wah
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 13:53:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lZcdP60eTvouG+LjGckxWYdyFBIljJRj5zG3GImGs0j+izlXFKkgIVP1INoXOKnpf6kjFwZLERdiKCG5V4gbNAW58C2xuvg6zEe2o7GCnODbT21TxD7Z6S9kiImGwzIWuN1AmJ3nhKGEqA6hPX44YBy/Z/lfRbDem9Y3U0i52Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MojrkzJddgD5ZYY5oOerV0rhRP8zF0Dm8FMPjpIxetqNN73W7sWvZjUQ5bAY5uFTBkidjfElUXyxqzsz5IqIwD9MAzKwZyDbM3EszNWXgPUvkCiMQ/xERLiUGWihDcO8jaEdO/VqZw1tlmX46Mz59ntndqKVZ0rRPxij8L32tRk=
Received: by 10.114.79.1 with SMTP id c1mr988324wab.1183755208468;
        Fri, 06 Jul 2007 13:53:28 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 6 Jul 2007 13:53:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51788>

I've just pushed (git://git.kernel.org/pub/scm/qgit/qgit4.git) a patch
series that add "renames following" to file annotation in qgit
preserving the non-linear (graph) history.

The most interesting cases in git tree are:

builtin-fsck.c (multiple renames)

builtin-mailinfo.c (multiple renames and changed directory)

git-clone.sh (nice history graph)

but the coolest is by far builtin-tar-tree.c where the file has been
renamed from tar- tree.c to builtin-tar-tree.c in _two_ different
commits on _two_ different branches then merged togheter in commit
1af0d11283...

To handle the latest one, a cool generalization has been necessary.

I have tested with _all_ the git files, and it seems to work in all the cases.

Have fun
Marco
