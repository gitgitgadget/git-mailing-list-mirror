From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: Allow missing base objects when creating
 thin packs
Date: Tue, 12 Aug 2008 14:26:52 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808121426100.22892@xanadu.home>
References: <20080811182839.GJ26363@spearce.org>
 <7vk5enuqfg.fsf@gitster.siamese.dyndns.org>
 <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org>
 <alpine.LFD.1.10.0808120023250.22892@xanadu.home>
 <20080812164149.GB31092@spearce.org>
 <alpine.LFD.1.10.0808121402440.22892@xanadu.home>
 <20080812181843.GD31092@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSybP-0001WV-CL
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYHLS1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYHLS1M
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:27:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14646 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYHLS1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:27:11 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5I0052438SPP50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Aug 2008 14:26:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080812181843.GD31092@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92127>

On Tue, 12 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 12 Aug 2008, Shawn O. Pearce wrote:
> > > +# Clone patch_clone indirectly by cloning base and fetching.
> > > +#
> > > +test_expect_success \
> > > +    'indirectly clone patch_clone' \
> > > +    '(mkdir user_clone &&
> > > +      cd user_clone &&
> > > +      git init &&
> > > +      git pull ../.git &&
> > > +      test $(git rev-parse HEAD) = $B
> > > +
> > > +      git pull ../patch_clone/.git &&
> > > +      test $(git rev-parse HEAD) = $C
> > > +     )
> > > +    '
> > 
> > What if the first test command fails?  Won't its result be ignored?
> 
> Isn't the exit status of the subshell the exit status of the last
> command in the subshell?

I'm not talking about the last command but the "test $(git rev-parse 
HEAD) = $B" line.


Nicolas
