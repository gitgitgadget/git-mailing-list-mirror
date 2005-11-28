From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 06:46:09 -0800
Message-ID: <868xv86dam.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<20051128104831.GN22159@pasky.or.cz>
	<86d5kk7wbv.fsf@blue.stonehenge.com>
	<20051128134111.GP22159@pasky.or.cz>
	<86zmno6g3v.fsf@blue.stonehenge.com>
	<20051128143428.GS22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 15:46:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgkH4-0007TB-9i
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 15:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVK1OqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 09:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVK1OqP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 09:46:15 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:5929 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750722AbVK1OqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 09:46:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 95E718F721;
	Mon, 28 Nov 2005 06:46:10 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17171-01; Mon, 28 Nov 2005 06:46:09 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id ACABA8F717; Mon, 28 Nov 2005 06:46:09 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <20051128143428.GS22159@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12884>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> Could you patch cg-push like
[yes]

Here's the result:

    localhost:~/Projects/git/Play % rm -rf *git
    localhost:~/Projects/git/Play % cg-admin-setuprepo remote.git
    localhost:~/Projects/git/Play % mkdir local.git
    localhost:~/Projects/git/Play % cd local.git
    localhost:..git/Play/local.git % cg-init -minitial
    defaulting to local storage area
    Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    Committed as 06223ad471c4f1c60da364310d1dd71a91310346.
    localhost:..git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"              
    localhost:..git/Play/local.git % cg-branch-ls
    origin  /Users/merlyn/Projects/git/Play/remote.git#master
    localhost:..git/Play/local.git % cg-push
    using /Users/merlyn/Projects/git/Play/remote.git#master
    now using /Users/merlyn/Projects/git/Play/remote.git
    matched ':' in '/Users/merlyn/Projects/git/Play/remote.git'?
    WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
    WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
    ssh: \033]2;[zsh] localhost: No address associated with nodename
    fatal: unexpected EOF

Well, that's curious, eh?

However, I get this:

    localhost:..git/Play/local.git % echo "/Users/merlyn/Projects/git/Play/remote.git" | grep -q ":"
    localhost:..git/Play/local.git % echo $status
    1

So, perhaps the "bash" on this system is broken for that elif chain?

localhost:..git/Play/local.git % bash --version
GNU bash, version 2.05b.0(1)-release (powerpc-apple-darwin8.0)
Copyright (C) 2002 Free Software Foundation, Inc.

Gah.  Yet Another Hidden Dependency.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
