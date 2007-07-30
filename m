From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 23:22:54 +0200
Organization: At home
Message-ID: <f8lkre$cme$1@sea.gmane.org>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFciA-0008EO-Vy
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966891AbXG3VXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966768AbXG3VXY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:23:24 -0400
Received: from main.gmane.org ([80.91.229.2]:46398 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965439AbXG3VXX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:23:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFchx-0007cy-Oa
	for git@vger.kernel.org; Mon, 30 Jul 2007 23:23:18 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 23:23:17 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 23:23:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54269>

Linus Torvalds wrote:

> On Mon, 30 Jul 2007, Craig Boston wrote:
>> 
>> So far the main snag I've found is that AFAIK there's no equivalent to
>> "svk import" to load a big tree (~37000 files) into a branch and commit
>> the changes.  Here's the procedure I've come up with:
>> 
>> cd /path/to/git/repo
>> git checkout vendor_branch_X
>> git rm -r .
>> cp -R /path/to/cvs/checkout_X/* ./
>> git add .
>> git commit -m"Import yyyymmdd snapshot"
> 
> Ouch.
> 
> What you want to do should fit git very well, but doing it that way is 
> quite expensive.
> 
> Might I suggest just doing the .git thing *directly* in the CVS checkout 
> instead?
[...]

And you can try to use git-fast-import. Check out
contrib/fast-import/import-tars.perl script (adapting it to your purpose).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
