From: Kenneth Johansson <ken@canit.se>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 18:47:53 +0100
Message-ID: <pan.2006.02.14.17.47.53.126690@canit.se>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Feb 14 18:50:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F94J5-0002Nj-7D
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWBNRtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 12:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWBNRtR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:49:17 -0500
Received: from main.gmane.org ([80.91.229.2]:48061 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422719AbWBNRtQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 12:49:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1F94I3-00028M-NJ
	for git@vger.kernel.org; Tue, 14 Feb 2006 18:48:39 +0100
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Feb 2006 18:48:39 +0100
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Feb 2006 18:48:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16145>

On Tue, 14 Feb 2006 09:05:16 -0800, Linus Torvalds wrote:

> 
> 
> On Tue, 14 Feb 2006, Nicolas Vilz 'niv' wrote:
>> 
>> i wonder, how i revoke a straight forward merge of two trees... I
>> actually wanted to be look like somewhere in the git-repository, where
>> some branches are merged back with the master tree, but i think, that
>> wasn't "cg-merge -c <tree to merge with the actual one>"...
>> 
>> my result was that my master tree has now the same sha1-sum as my
>> development-tree and gitk visualisation differs from that what i saw in
>> the git-repository. (Several Arrows headed into back into one line...)
>> 
>> maybe that was because i didn't do anything in my master tree in the
>> meantime.
>> 
>> And another thing, is there no posibility to get back to some commits or
>> tags? I realized you can rebranch tags... what, if i want to switch back
>> to git version 1.1.6 in the git repository? Or a certain commit?
> 
> Both of these can be solved with "git reset".

I also had this exact question today since I wanted to compile an earlier
version of the kernel and like Nicolas I naturally got stuck on the
checkout command and that dose not work like one would think.

What I ended up doing was going nee deep into the plumbing.

first doing cat on the tag in .git/refs/tags/ 
taking the output as an argument to  "git-read-tree"
followed by "git-update-index --replace" and "git-checkout-index -a -f -u"

I'm not sure that many people will understand that they want git-reset for
this just reading the man pages.
