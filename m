From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 15:53:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Thanassis Tsiodras <ttsiodras@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:55:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw05O-0005wO-DC
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYJaTx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYJaTx5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:53:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55652 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbYJaTx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:53:56 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M005QVCKOESD0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 15:53:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqej1wra1c.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99629>

On Fri, 31 Oct 2008, Matthieu Moy wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Thanassis Tsiodras wrote:
> >  
> >> So I have to git-gc on my side (after the commits), git-gc on the remote,
> >> and then git-push?
> >
> > Perhaps I haven't made myself clear.
> >
> > On the local side: git-commit creates loose (compressed, but not
> > deltified) objects. git-gc packs and deltifies.
> >
> > On the remote side (for smart protocols, i.e. git and ssh): git
> > creates _thin_ pack, deltified; 
> 
> I don't understand this point: the OP talks about pushing, so isn't
> the pack created on the _local_ machine (and then sent to the remote)?

Yes, the pack is created on the fly when pushing, regardless if the repo 
is already packed or not locally.  The only difference a locally packed 
repo provides is a shorter "Compressing objects" phase when pushing 
that's all. The packedness of the remote has no effect at all.


Nicolas
