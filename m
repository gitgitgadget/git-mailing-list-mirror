From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 07 Sep 2006 22:21:12 +0200
Organization: At home
Message-ID: <edpuut$dns$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 07 22:21:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLQNO-0001MD-HK
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 22:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWIGUVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWIGUVW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 16:21:22 -0400
Received: from main.gmane.org ([80.91.229.2]:8383 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751616AbWIGUVW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 16:21:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLQMt-0001GZ-9Q
	for git@vger.kernel.org; Thu, 07 Sep 2006 22:20:59 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 22:20:59 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 22:20:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26655>

Jon Smirl wrote:

> If you haven't updated for six months when the server walks backwards
> for 10 change sets it's not going to find anything you have locally.
> When this situation is encountered the server needs to generate a
> delta just for you between one of the change sets it knows you have
> and one of the 10 change sets you want. By generating this one-off
> delta it lets you avoid the need to fetch all of the objects back to a
> common branch ancestor. The delta functions as a jump over the
> intervening space.

I don't understand. Git is _not_ patchset based (like GNU Arch, or
Mercurial, or CVS). It is snapshot based. So if you want to download
"skip", you need only for the local part of doenloader to make appropriate
grafts, like below


 *--*--*--*--*--*--*--*--*--*--*--HEAD    (server)

 *--*--*...........*--*--*--*--*--HEAD    (shallow/sparse clone)

But the part you were talking about is _easy_ part; the hard part is
merges including merging branch which was split off the trunk before
cutoff-point, history rewriting (c.f. 'pu' branch, and rebases), etc.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
