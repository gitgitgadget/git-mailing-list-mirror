From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git log --graph and root commits
Date: Fri, 13 Feb 2009 14:56:21 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpb2gl.rhg.sitaramc@sitaramc.homelinux.net>
References: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0902131237490.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 15:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXzUR-0002jl-1H
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 15:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbZBMO4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758201AbZBMO4d
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 09:56:33 -0500
Received: from main.gmane.org ([80.91.229.2]:40535 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbZBMO4c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 09:56:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXzSw-0002hK-Eu
	for git@vger.kernel.org; Fri, 13 Feb 2009 14:56:30 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 14:56:30 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 14:56:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109752>

On 2009-02-13, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 13 Feb 2009, Sitaram Chamarty wrote:

>> I was wondering if there was any way, when using 'git log
>> --graph --pretty=oneline' to get a different marker (perhaps
>> an underscore) for a root commit.

> Is it not enough that the line ends?  That is a pretty obvious visual 
> marker for me that this is a root commit.  But I see that you are _asking_ 
> for the lines not to be shown, by using --pretty=oneline.

Yes; I'm short on vertical space here.

> You might be interested in this instead:
>
> 	git log --graph --pretty=format:'%h %s%n'

It doubles the height requirement, but you gave me an idea:

    git log --graph --pretty=tformat:'%h <%p> %s' --all |
        perl -pe '$_.="----\n" if /<>/; s/<.*?> //'

Thanks for pointing me in the right direction.

Regards,

Sitaram
