From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 20:54:49 +0200
Message-ID: <20080416185449.GA27015@steel.home>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <20080415183023.GA23098@linux-sh.org> <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:14:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmCnD-0006A0-UG
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 20:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbYDPSyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYDPSyx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 14:54:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:18442 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYDPSyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 14:54:53 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHGlvQw==
Received: from tigra.home (Face8.f.strato-dslnet.de [195.4.172.232])
	by post.webmailer.de (fruni mo8) (RZmta 16.24)
	with ESMTP id f027c6k3GGi3dr ; Wed, 16 Apr 2008 20:54:49 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9129E277BD;
	Wed, 16 Apr 2008 20:54:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5307256D28; Wed, 16 Apr 2008 20:54:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79724>

Linus Torvalds, Tue, Apr 15, 2008 21:56:50 +0200:
> 
> 
> On Wed, 16 Apr 2008, Paul Mundt wrote:
> > 
> > It was a combination of mbox munging and git-am, I checked with git log
> > and thought things were ok, but I wasn't aware that it stripped out empty
> > lines. cat-file shows that it was just the 2 patches from Andrew that had
> > this particular problem. I had stripped out the subject and thought the
> > first line would be used for the merge summary, but it looks like git-am
> > simply wrote out an empty line and inserted one after that before the
> > rest of the summary.
> 
> Ahh, looks like a git-am buglet then. It will indeed turn an empty subject 
> line into an empty first line.
> 
> We should run "git stripspace" on the whole thing, so maybe a patch 
> something like the appended will help.
> 
> NOTE! Totally untested! Beware the patch!
> 

t4014-format-patch.sh broke. It probably has to be updated
