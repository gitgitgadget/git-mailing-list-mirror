From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 09:38:26 +0200
Organization: At home
Message-ID: <eakc16$p77$1@sea.gmane.org>
References: <20060730223754.GA16364@admingilde.org> <7vzmeqa7tx.fsf@assigned-by-dhcp.cox.net> <20060731070819.GD16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 09:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7SMI-0004Zi-3p
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 09:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWGaHie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 03:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWGaHie
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 03:38:34 -0400
Received: from main.gmane.org ([80.91.229.2]:35285 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964810AbWGaHid (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 03:38:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7SM3-0004Ws-9g
	for git@vger.kernel.org; Mon, 31 Jul 2006 09:38:23 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 09:38:23 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 09:38:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24500>

Martin Waitz wrote:

> On Sun, Jul 30, 2006 at 06:20:26PM -0700, Junio C Hamano wrote:
>>
>> I think the other parts are sensible but I am not sure if we
>> want to report the version of git distribution (your patch), or
>> the version of git binary the cgi script happens to use (the
>> current implementation).
> 
> hmm, right.
> Well, now that gitweb is included with GIT I think that they will
> be in sync on many sites, but of course that's not guaranteed.
> 
> Shall I send a new patch without that change?

There are currently two version variables in gitweb: the version of the
script, and the version of git binaries used. They might be different.
But now that gitweb is bundled with git, perhaps we could use compile-time
git version as gitweb version, i.e. 

  our $version = "@@GIT_VERSION@@";

while leaving $git_version as is, i.e.

  our $git_version = 
    qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown"

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
