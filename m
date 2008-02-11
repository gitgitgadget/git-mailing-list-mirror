From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 15:44:48 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111542000.2732@xanadu.home>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
 <m3myq7e3ie.fsf@localhost.localdomain>
 <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
 <200802112051.27271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:45:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOfX6-00065u-LM
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 21:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYBKUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbYBKUou
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 15:44:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10389 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbYBKUot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 15:44:49 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW300IXDDMONZE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 15:44:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200802112051.27271.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73581>

On Mon, 11 Feb 2008, Jakub Narebski wrote:

> Marco Costalba wrote:
> > On Feb 11, 2008 7:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > > "Marco Costalba" <mcostalba@gmail.com> writes:
> > >
> > > > So it happens to be just faster to re-clone the whole thing by upstream.
> > >
> > > So what you are doing is passing the work, unnecessary work I'd say,
> > > to some poor server. Not nice.
> > 
> > To a poor net bandwidth I would say because cloning from zero just
> > downloads the packages.
> 
> Cloning from zero over http, https and rsync (and ftp) just downloads
> the packfiles. Cloning over git or ssh if I understand correctly[*1*]
> generates single pack for transfer. And that generates load for server.

The created pack will always reuse existing deltas, so the load is more 
about making sure the sent pack contains only needed objects for the 
required branch -- something that dumb protocols cannot do.


Nicolas
