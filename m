From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Fri, 17 Apr 2009 03:42:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngufuke.1am.sitaramc@sitaramc.homelinux.net>
References: <1238793954.19982.14.camel@hyperair-laptop>
 <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
 <49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int>
 <20090415192054.GE23604@spearce.org>
 <20090415T220710Z@curie.orbis-terrarum.net>
 <20090416142728.GG23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 05:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luezh-000850-F2
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 05:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbZDQDm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 23:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbZDQDm0
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 23:42:26 -0400
Received: from main.gmane.org ([80.91.229.2]:41572 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbZDQDm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 23:42:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Luey7-0005bl-DT
	for git@vger.kernel.org; Fri, 17 Apr 2009 03:42:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 03:42:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 03:42:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116725>

On 2009-04-16, Shawn O. Pearce <spearce@spearce.org> wrote:
>> The other downside to relying on SSH presentation of identity directly,
>> is the inability to use the SSH key to uniquely identify the user during
>> the SSH auth (see designs like gitosis, where you always push to
>> git+ssh://git@host/repo).
>
> Uhm, yea.  That's a fault of gitosis then.  It knows the key that
> was used, and has that mapped back to some token that identifies that
> account in the configuration file.  Why it doesn't push that into the
> GIT_COMMITTER_* environment before launching git-shell, I don't know.

If you set GIT_COMMITTER_*, won't it change the SHA of the
commit itself?  I always thought so...

One possibility is to set "LogLevel VERBOSE" in
/etc/ssh/sshd_config and save those logs -- they can help
you match up the timestamps in the reflogs and find out who
pushed what, subject to all the other caveats in Shawn's
earlier post.

But it's a kludge... sadly my python-fu is zero; I really
wish gitosis would put that info *somewhere*.
