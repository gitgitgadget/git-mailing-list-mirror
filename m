From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn: Branching clarifications
Date: Sat, 08 Sep 2007 09:58:53 +0200
Organization: Organization?!?
Message-ID: <85ir6lziyq.fsf@lola.goethe.zz>
References: <46E18095.60501@gmail.com> <20070908052126.GB28855@soma> <85r6l9zlt4.fsf@lola.goethe.zz> <20070908074944.GC24166@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 09:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITvDp-0004fz-76
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 09:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbXIHH7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 03:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXIHH7L
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 03:59:11 -0400
Received: from main.gmane.org ([80.91.229.2]:43515 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXIHH7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 03:59:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ITvDa-0001lt-Ip
	for git@vger.kernel.org; Sat, 08 Sep 2007 09:59:02 +0200
Received: from dslb-084-061-013-010.pools.arcor-ip.net ([84.61.13.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 09:59:02 +0200
Received: from dak by dslb-084-061-013-010.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 09:59:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-013-010.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:X1GJZnzOt5WW35KoPpNr7qJjcbo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58108>

Eric Wong <normalperson@yhbt.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>
>> Please.  git-svn is told how to find the trunk on its command line.
>> Nothing makes sense (short of an _explicit_ wish otherwise for
>> which it might make sense to create a command line option) than to
>> map master to the trunk.
>
> Keep in mind that command-line arguments for trunk, branches and tags
> are _all_ optional to git-svn.
>
> If only trunk or nothing is specified, the current behavior will
> always be correct.

Sure, since Subversion does not distinguish trunk, branches, tags, or
even projects from each other: they are just naming conventions in the
repository and nothing enforces them.  So if you check out a single,
named directory, it is natural that this will be master, and tracked.

> There's also a case if only branches and/or tags are specified, with
> no trunk given.  That would need to be handled, somehow...

Just barf unless a --master=thisbranch option is given.  If you want
to, you can allow multiple --track=remotebranch options as well,
giving you a tracking branch for the specified remote branches under
their original name.

Something like that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
