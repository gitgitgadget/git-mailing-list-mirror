From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Maintaining site-wide clones
Date: Thu, 8 Jan 2009 17:22:44 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmcdj4.i8d.sitaramc@sitaramc.homelinux.net>
References: <alpine.LNX.1.00.0901081129500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 18:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKycM-00038k-Q4
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 18:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZAHRXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 12:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbZAHRXB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 12:23:01 -0500
Received: from main.gmane.org ([80.91.229.2]:60548 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbZAHRXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 12:23:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKyat-0006jB-OH
	for git@vger.kernel.org; Thu, 08 Jan 2009 17:22:55 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 17:22:55 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Jan 2009 17:22:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104944>

On 2009-01-08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Is there a good way of handling a setup where the canonical repository is 
> in some slow foreign system and you want a lot of git clones? I've been 
> using a bare repository that I import into and clone, but then I need to 
> go to the bare repository to update anything, which is vaguely annoying.

Why?  You can push to it too?

I don't have your use case but if I did, I'd do this:
 - everyone clones from the local mirror
 - one person clones the slow foreign system at whatever
   interval he thinks appropriate, and pushes to the local
   mirror
 - (or the local mirror can do this via cron)

This works fine if you can sort of judge the average
frequency of updates, and not getting some of them
*immediately* is not earth shattering for local developers.

If the slow foreign system lets you put in a post-commit
hook that'll be even easier -- no more guesswork!
