From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 18:24:50 +0200
Organization: At home
Message-ID: <efbk8d$mdj$1@sea.gmane.org>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com> <efapsl$e65$1@sea.gmane.org> <20060926160729.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 18:34:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSFsp-00060u-Gi
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 18:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWIZQd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWIZQd7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 12:33:59 -0400
Received: from main.gmane.org ([80.91.229.2]:64223 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750830AbWIZQd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 12:33:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GSFnL-0004bK-T1
	for git@vger.kernel.org; Tue, 26 Sep 2006 18:28:31 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 18:28:31 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 18:28:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27801>

Petr Baudis wrote:

> Dear diary, on Tue, Sep 26, 2006 at 10:54:49AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> I'd rather not. The fact that the file name and tree name is link,
>> and the fact that commit title and tag title is link is a _convenience_.
>> Not always it is visible (without mouseover) that it is link.
>> And it is _not_ visible in the case of files!
> 
> Then that should be fixed.
> 
> And directories should have trailing slash in their name in the tree
> listing, for people with non-UNIX background who don't understand the
> ls -l like output.

Something like ls -lF format? Currently directories differs visibly
from file entries, because directory entries are visibly links. One
single slash at the end is much less visible than change of color and
underline.

Besides "blob" link for files and "tree" link for directories states
explicitely the kind of view. List entry link states this implicitely.
I'd rather like the redundancy.

>> And for example for commits and heads there are two possible
>> views, commit and commitdiff for commit, shortlog and log for head,
>> of which we arbitrary chose one for the subject link. So in that
>> case the additional self link is needed. I'd rather have both.
> 
> For commits and heads, I agree. But that's not what this patch does.

What this patch does is introduce inconsistency. Even if you agree
to treat commits and heads specially, it treats directory entries
differently from file entries; and differently from tag entries
(where tag objects have the same duplication) in tags view. In tags
view on one hand it clearly distiguish lightweight from "heavyweight"
tags (even heavyweight tags without tag message), on the other
"tag | tag ..." for tag pointing to tag is quite strange.
 
>> And for consistency I'd rather always have visible form default
>> self link/
> 
> A parse error kicked me off here, sorry.
 
I'd rather always have the link which is in "list" entry stated
also explicitely.
 
> (I'm personally kind of ambivalent to the change.)

There are many other changes which should be rather done, like for
example remotes/ support.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
