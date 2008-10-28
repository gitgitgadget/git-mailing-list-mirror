From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re: [VOTE] git versus mercurial)
Date: Tue, 28 Oct 2008 16:33:54 +0100
Message-ID: <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 28 16:35:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqbI-0006FK-9g
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYJ1PeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYJ1PeF
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:34:05 -0400
Received: from frim.nl ([87.230.85.232]:50186 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201AbYJ1PeE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 11:34:04 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Kuqa1-0001Ws-3F; Tue, 28 Oct 2008 16:34:01 +0100
In-Reply-To: <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99299>


On 28 okt 2008, at 15:41, Peter Krefting wrote:

> It seems to me that use of DVCS is polarising between Git, Mercurial
> and Bzr. It would be nice to have easy interoperability between the
> systems, at least as far as can be covered by the lowest common
> denominator of what they support. I would love to be able to use Git  
> to
> clone a Bzr repository that I need to be able to access, since bzr is
> just different enough from Git to be annoying. Same goes for  
> Mercurial.
> And I am sure that users of the other tools feel the same.
>
> Would it be possible to design a common transfer format that could be
> implemented by all three (and that would be a little smarter than
> fast-export/fast-import)?

What would you want that the fast-export/imports are lacking? I think  
they are excellent tools to build some integration on.

You might want to look at my git-bzr script (http://github.com/pieter/git-bzr/tree/master 
), which I created so I could use
bazaar branches easily in git. It allows you to fetch a bzr branch,  
merge it in with your local work, and then push it out again:

	git bzr add bzr-branch ~/bazaar/something
	git bzr fetch bzr-branch
	git merge bzr/bzr-branch
	git bzr push bzr-branch

It's quite crude, but it's also only 100 lines or so and does what I  
need. It should also be simple enough to adapt it to also incorporate  
hg. When I needed the bzr integration, I looked into hg as well, but  
there wasn't a hg fast-import yet. If I understand dscho correctly,  
that exists now, so it should be easy enough to integrate that as well.

- Pieter
