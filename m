From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git support for subprojects?
Date: Wed, 14 Mar 2007 02:11:51 +0100
Organization: At home
Message-ID: <et7hvh$phh$1@sea.gmane.org>
References: <OFD596829F.8C32CA61-ON8625729D.004F66DC-8625729D.00501D41@BJSERVICES.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 02:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRHzX-0004Qw-Fv
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbXCNBJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXCNBJU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:09:20 -0400
Received: from main.gmane.org ([80.91.229.2]:39418 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbXCNBJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:09:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HRHzR-00072I-5t
	for git@vger.kernel.org; Wed, 14 Mar 2007 02:09:17 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 02:09:17 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 02:09:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42161>

[Cc: git@vger.kernel.org]

Luke.Powell@bjservices.com wrote:

> Say that I have projects A and B which both depend on another project Z. 
> Whenever I update one of those projects, I'd like to also update to the 
> latest version of Z in a subdirectory. Is there that kind of support for 
> these subprojects? If I'm not being clear, I'm talking about the kind of 
> support that is available in Subversion through svn:externals or something 
> analogous.

Git currently doesn't have submodule (subproject) support, although this
topic appears from time to time on git mailing list. There are even two
prototypes of proper submodule support; link to one of those (heavyweight
one by Martin Waitz) can be found at
  http://git.or.cz/gitwiki/SubprojectSupport
There is also lightweight submodule support proposal, but as author did
not put info in above page, and I don't have I think an URL saved...
It is I think what you might want.

But it should be fairly easy to cobble together something analogous
to broken[*1*] svn:externals with update hook...
 
> Also, please cc me in any answers since I'm not sure my subscription to 
> the list went through.

http://git.or.cz/gitwiki/GitCommunity  


[*1*] In short: you really, really want to bind/connect submodule commit
(submodule version) to supermodule (main module) commit. E.g. you want to
know for sure that v2.1.3 of your project pass all the tests and works
with v0.2.1 of a submodule.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
