From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Handling of 'git-config foo=bar'
Date: Sun, 04 Feb 2007 21:20:12 +0100
Organization: At home
Message-ID: <eq5f34$ir9$1@sea.gmane.org>
References: <20070204113350.GN5362@nan92-1-81-57-214-146.fbx.proxad.net> <7vsldlr8wg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 21:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDnsd-0000ld-Nh
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 21:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbXBDUW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 15:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbXBDUW3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 15:22:29 -0500
Received: from main.gmane.org ([80.91.229.2]:41790 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbXBDUW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 15:22:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDnr4-00030e-Qq
	for git@vger.kernel.org; Sun, 04 Feb 2007 21:20:54 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 21:20:54 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 21:20:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38707>

Junio C Hamano wrote:

> Yann Dirson <ydirson@altern.org> writes:
> 
>> Currently, running "git-config foo=bar", ie. presumably an erroneous
>> attempt at setting "foo", indeed queries "foo=bar", so outputs nothing
>> and reports success.
>>
>> Do we want to allow "=" signs in config var names ?  It would seem
>> reasonable to refuse them, and report an error to the innocent user
>> (OK, i'm not that innocent, but still ;)
>>
>> Or does that sound a bad idea to anyone ?
> 
> Something like:
> 
>    git config remote.origin.fetch=refs/heads/master:refs/heads/origin
>    git config remote.origin.fetch+=refs/heads/next:refs/heads/next
>    git config remote.origin.fetch+=+refs/heads/pu:refs/heads/pu
>    git config remote.origin.fetch+=refs/heads/maint:refs/heads/maint
> 
> sounds sensible.
> 
> However, my feeling is "git repo-config" is primarily for use by
> scripts, and we are better off educating users not to be afraid
> of viewing and editing .git/config file themselves.

I think the question was not if we want new syntax for setting variables,
but if we want to disallow '=' in variable (key) names. They are pretty
restricted, and I cannot think offhand of variable name we would want that
would need to have '=' in it...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
