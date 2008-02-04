From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin, submodules
Date: Mon, 4 Feb 2008 06:19:40 +0100
Message-ID: <A3A63507-41CA-4FE0-BE77-BF6987E87AD2@zib.de>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 06:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLtky-0007YZ-Rx
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 06:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbYBDFT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 00:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbYBDFT6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 00:19:58 -0500
Received: from mailer.zib.de ([130.73.108.11]:51624 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYBDFT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 00:19:57 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m145IgFD016565;
	Mon, 4 Feb 2008 06:19:46 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91676.pool.einsundeins.de [77.185.22.118])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m145Ie7E024342
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 4 Feb 2008 06:18:41 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0802032237320.7372@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72462>


On Feb 3, 2008, at 11:43 PM, Johannes Schindelin wrote:

> On Sun, 3 Feb 2008, Mark Levedahl wrote:
>
>> This patch series was inspired by several issues dealing with  
>> multiple
>> remotes and submodules. The tests added as the last patch demonstrate
>> the specific use pattern to be supported, and that does not work
>> currently.
>
> It seems that everytime you send a new patch series, it gets longer/ 
> more
> complicated/affects more and more of git.
>
> As far as I understood, your problem was _purely_ a submodule  
> issue.  I
> find it utterly unnerving that you keep trying to sneak in _anything_
> unrelated to submodules.
>
> Such as the origin issue.

As fas as I understood, Mark's usage of submodules might have
revealed a deficiency in the current handling of origin.

Mark described a distributed workflow that actively uses more than
a single server to store repositories and these different servers
are not pure replicates of each other.  As a consequence the name
of the server has a meaning for the users and therefore the workflow
makes this explicit by never using "origin" but instead use
descriptive names for the remotes.  He described situations when
people want to speak about what they have in their repositories
and want to describe where they pulled from.  I can well imaging
that the result of everyone saying "I pulled from origin" can cause
great confusion if origin means different things; and therefore it
is a reasonable choice to completely avoid origin.

Partly because of this explanation by Mark and the problems he
described, I decided against using submodules, but instead merged
all the submodules that I originally planned to keep separate into
a single monolithic repository.  I expect that a single repository
works well because this is what the Linux kernel uses.


> I am getting pretty angry that you keep trying to complicating  
> things in
> that area!  origin is origin is origin.  It is the default remote.   
> It is
> what you can change to fetch from somewhere else _by default_.  So I
> absolutely detest your changes in that regard, who help _noboy_ except
> people who like confusion.
>
> So just change remote.origin.url, but do not mess up our nice  
> source code.
>
> If your issue is with git-submodule, then fix _that_, and do not "fix"
> _anything_ else.

If I understood Mark correctly, this would not solve his problem
because he wants to *avoid* origin; and his arguments make sense
to me.  Unfortunately I cannot contribute any real world
experience, because I chose to abandoned the idea of using
submodules.

However, this does not mean that I'll never use submodules.
Actually I am pretty sure submodules could become very helpful
end of March; and I should also support multiple servers at that
time.  So I would be happy if the use case described by Mark was
well supported by git.

	Steffen
