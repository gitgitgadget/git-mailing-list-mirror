From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 20:58:54 +0200
Organization: glandium.org
Message-ID: <20080625185854.GA4816@glandium.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home> <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org> <7vd4m66rfp.fsf@gitster.siamese.dyndns.org> <20080625055605.GD28563@glandium.org> <alpine.LFD.1.10.0806251449530.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:00:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaET-00032m-77
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYFYS7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYFYS7p
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:59:45 -0400
Received: from vuizook.err.no ([194.24.252.247]:35138 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbYFYS7o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:59:44 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KBaCl-0003Ms-OV; Wed, 25 Jun 2008 20:59:02 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KBaCk-0001GJ-39; Wed, 25 Jun 2008 20:58:54 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806251449530.2979@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86320>

On Wed, Jun 25, 2008 at 02:53:41PM -0400, Nicolas Pitre wrote:
> On Wed, 25 Jun 2008, Mike Hommey wrote:
> 
> > On Tue, Jun 24, 2008 at 09:59:06PM -0700, Junio C Hamano wrote:
> > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > 
> > > > On Wed, 25 Jun 2008, Nicolas Pitre wrote:
> > > >> 
> > > >> Git older than version 1.5.2 (or any other git version with this option
> > > >> set to 1) may revert to version 1 of the pack index by manually deleting
> > > >> all .idx files and recreating them using 'git index-pack'.  Communication
> > > >> over the git native protocol is unaffected since the pack index is never
> > > >> transferred.
> > > >
> > > > Rather than talk about when it does _not_ matter, wouldn't it be better to 
> > > > talk about when it _can_ matter?
> > > >
> > > > Namely when using dumb protocols, either http or rsync, with the other end 
> > > > being some ancient git thing (and it is worth mentioning version of what 
> > > > counts as 'ancient' too, I can't remember, probably means that pretty much 
> > > > nobody else can either).
> > > 
> > > I agree with you that the description of the change (in the commit log)
> > > and the instruction (in the documentation) could be more helpful and
> > > explicit.
> > (...)
> > 
> > Wouldn't it be a good idea to add a warning in git update-server-info
> > when it detects pack.indexVersion is not 1, too ?
> 
> That would give the idea that index v2 is not good, while what we want 
> is to encourage everyone to move to index v2 ASAP.

The warning could just say that people with older git won't be able to
clone over dumb protocols. Nothing more.

Mike
