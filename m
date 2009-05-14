From: Mark Plaksin <happy@usg.edu>
Subject: Re: Syntax check via update hook?
Date: Thu, 14 May 2009 15:52:02 -0400
Message-ID: <wsd4abfonx.fsf@usg.edu>
References: <wsprejtm71.fsf@usg.edu>
	<20090509144711.GA3926@sigill.intra.peff.net> <wsd4aem8rh.fsf@usg.edu>
	<20090514065544.GC10411@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 21:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gyd-0007Jk-7z
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZENTwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZENTwP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:52:15 -0400
Received: from main.gmane.org ([80.91.229.2]:33680 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbZENTwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 15:52:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M4gyT-0005KV-VC
	for git@vger.kernel.org; Thu, 14 May 2009 19:52:14 +0000
Received: from stone.tss.usg.edu ([168.24.82.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 19:52:13 +0000
Received: from happy by stone.tss.usg.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 19:52:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: stone.tss.usg.edu
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.93 (gnu/linux)
Cancel-Lock: sha1:BT+7E1qh19wa9kskLgpOQVfnsJg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119218>

Jeff King <peff@peff.net> writes:

> On Tue, May 12, 2009 at 03:16:50PM -0400, Mark Plaksin wrote:
>
>> >         $ cat <<EOF >.git/hooks/update
>> >         #!/bin/sh
>> >         GIT_INDEX_FILE=/path/to/tempdir/index; export GIT_INDEX_FILE
>> >         cd /path/to/tempdir/tree &&
>> >         mkdir -p tree &&
>> >         git read-tree "$3" &&
>> >         git checkout-index &&
>> >         your_syntax_check
>> >         EOF
>> >         $ chmod +x .git/hooks/update
>> 
>> Thanks for helping! :)
>> 
>> Unfortunately we don't quite get it.  Can you flesh out your example a
>> bit and explain the concepts involved?  We're relative git newbies.  We
>> tried reading the man pages to the commands you use to no avail.  One
>> big stumbling block seems to be how we create/set-up tempdir.  Is that
>> supposed to be a pre-created git checkout, or created via git-archive,
>> or .. ?
>
> What I was trying to say earlier is that you have two choices based on
> how efficient you want to make it. The simple way is to use git-archive:

OK, this makes sense now.  Thanks for being patient with us :)

> However, all of that being said, if you just want:
>
>> Also, we actually just want to check the syntax of the files that were
>> changed in the commit, not the whole tree.  Will your method give us
>> access to the path names of the files that changed?
>
> That is simpler, especially if you can feed the files to your
> syntax-checker over stdin. You just need to enumerate the files, and
> then ask git to dump each one:

...

> Make sense?

It does!  You make it seem so easy!  Thanks very much.  I now have an
update hook which checks syntax just like we want.  Thanks again!
