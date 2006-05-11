From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Thu, 11 May 2006 08:02:07 +0200
Organization: At home
Message-ID: <e3uk0u$14n$1@sea.gmane.org>
References: <1147037659.25090.25.camel@dv> <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org> <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE> <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org> <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org> <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com> <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org> <Pine.LNX.4.64.0605102148310.24505@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 11 08:02:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fe4Fn-0006Iy-Nd
	for gcvg-git@gmane.org; Thu, 11 May 2006 08:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWEKGCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 May 2006 02:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWEKGCY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 May 2006 02:02:24 -0400
Received: from main.gmane.org ([80.91.229.2]:54434 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965134AbWEKGCY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 May 2006 02:02:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fe4Fc-0006Hs-Cb
	for git@vger.kernel.org; Thu, 11 May 2006 08:02:16 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 May 2006 08:02:16 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 May 2006 08:02:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19902>

Nicolas Pitre wrote:

> On Wed, 10 May 2006, Linus Torvalds wrote:
> 
>> [branch "origin"]
>> remote = git://git.kernel.org/pub/scm/git/git.git
>> branch master
> 
> I totally agree with the principle, but I find the above really
> confusing.  Which "branch" means what?  At least if it was "remote_url"
> and "remote_branch" then there wouldn't be any possibility for
> confusion.

I'm not sure if remotes shortcuts and configuration (which branches should
be pulled, and to which branches) should be in branches configuration. It
is somewhat confusing. Branches configuration might be used for default
pulling, e.g.


[remote "kernel.org"]
        url = git://git.kernel.org/pub/scm/git/git.git
        pull = master:origin
        ...
        pull = +pu:pu

[branch "origin"]
        pull = kernel.org
        readonly

[branch "pu"]
        pull = kernel.org
        readonly
        fast-forward = no

-- 
Jakub Narebski
Warsaw, Poland
