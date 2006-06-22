From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 15:32:31 +0200
Organization: At home
Message-ID: <e7e65f$dhf$1@sea.gmane.org>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622130523.GA6893@coredump.intra.peff.net> <E333ADD9-1096-4137-9D72-D58A8E2A5582@kernel.crashing.org> <20060622131344.GA7168@coredump.intra.peff.net> <A4C01915-3337-460C-BE19-7AC17249BE50@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 15:33:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPJ5-0008S4-0l
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWFVNdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWFVNdI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:33:08 -0400
Received: from main.gmane.org ([80.91.229.2]:24720 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751787AbWFVNdH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:33:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtPIi-0008Mk-QD
	for git@vger.kernel.org; Thu, 22 Jun 2006 15:32:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 15:32:52 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 15:32:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22339>

Kumar Gala wrote:

> 
> On Jun 22, 2006, at 8:13 AM, Jeff King wrote:
> 
>> On Thu, Jun 22, 2006 at 08:10:10AM -0500, Kumar Gala wrote:
>>
>>>> git-fetch?
>>> Its the first half, still need to resolve FETCH_HEAD, HEAD, etc..
>>
>> Can you elaborate on what you're trying to accomplish?
> 
> A local mirror of a git tree.  I can do the clone easy enough, its  
> trying to figure out the updates after the fact that is the issue.

Assuming typical configuration, with the following in remotes/origin

---[ <path-to-repo>/.git/remotes/origin ]----
URL: git://git.kernel.org/pub/scm/git/git.git
Pull: refs/heads/master:refs/heads/origin
Pull:+refs/heads/pu:refs/heads/pu
Pull: refs/heads/man:refs/heads/man
Pull: refs/heads/html:refs/heads/html
Pull: refs/heads/next:refs/heads/next
Pull: refs/heads/todo:refs/heads/todo
Pull: refs/heads/maint:refs/heads/maint
---------------------------------------------

to update your repository, do:

$ git checkout master
$ git fetch origin

Any branch except listed ot fhose fetched to will do, or even any command
that leaves HEAD different than one of the branches fetched to. Everything
is updated. Then you can do the second part of pull, using

$ git checkout master
$ git pull . master

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
