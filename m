From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 18:10:03 +0100
Organization: At home
Message-ID: <ep83m2$mts$1@sea.gmane.org>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45B78C55.2030204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 18:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lci-0003uG-DA
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 18:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbXAXRJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXAXRJV
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 12:09:21 -0500
Received: from main.gmane.org ([80.91.229.2]:43328 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbXAXRJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 12:09:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9lcY-0000jW-M5
	for git@vger.kernel.org; Wed, 24 Jan 2007 18:09:14 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 18:09:14 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 18:09:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37659>

H. Peter Anvin wrote:

> Johannes Schindelin wrote:
>> 
>> Granted, for some things this might work. However, I would not wreak havoc 
>> by changing the format of .git/info/refs, rather put the details you 
>> wanted into .git/info/refs-details.
> 
> It's not clear to me if it would be wrecking havoc.  After all, if a 
> format can't be expanded *at all*, there is something wrong, and adding 
> things to the end of a line is a common structured way of expansion. 
> Hence the original query

I don't think it can be easily expanded. .git/info/refs is meant for
http-fetch, and it mimics git-ls-remote / git-peek-remote output.

BTW. putting the info of git-for-each-ref into .git/info/refs-details
would mean that instead of "24175 calls to git" one would need to
read 24175 files. Perhaps the whole info needed to generate projects
index page should be pre-generated on push (update), instead of per
project (per repository) .git/info/refs-details

>> However, for other things (like showing a certain number of commits), it 
>> _might_ make sense to cache them (e.g. when literally thousands of people 
>> look at the 100 last commits of linux-2.6.git), but not for others (e.g. 
>> the 100th last to the 200th last commit of git-tools.git).
> 
> Any query that's within a repository is fairly easily cachable 
> post-generation.  The front page (and its RSS variant) is a bit of an 
> exception, because it involves all repositories at once.

Actually "RSS", or to be more exact OPML variant of front page in its
current invocation is equivalent of project_index page, and it can be
generated once (well, once per adding / removing / renaming a repository).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
