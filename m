From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 14:29:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002151426350.1946@xanadu.home>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
 <20100214024259.GB9704@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
 <32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com>
 <alpine.LFD.2.00.1002142252020.1946@xanadu.home>
 <32541b131002142101i226663cfk90d1ba14f1031788@mail.gmail.com>
 <alpine.LFD.2.00.1002150016110.1946@xanadu.home>
 <32541b131002151119o2f528ddv147d71d12d9d11fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_eu/+batKRj5WzSSsR6YyzA)"
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 20:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh6e4-00041Y-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 20:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab0BOT37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 14:29:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21985 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab0BOT36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 14:29:58 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXW002XGE5WRP90@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Feb 2010 14:29:57 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <32541b131002151119o2f528ddv147d71d12d9d11fe@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140023>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_eu/+batKRj5WzSSsR6YyzA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Mon, 15 Feb 2010, Avery Pennarun wrote:

> On Mon, Feb 15, 2010 at 12:48 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Ideally you don't keep volatile objects into huge packs.  That's why we
> > have .keep to flag those packs that are huge and pure so not to touch
> > them anymore.
> 
> Of course the problem here is that as soon as you import a single
> (possibly volatile) 2GB file, your pack becomes "huge."  So these
> heuristics stop working very well and start to need some revision.

You don't have to repack that often though.  In which case the 
single-object 2GB pack might be discarded before the next repack.  And 
loose objects are packed into a pack of their own more often than 
multiple packs being repacked into a single pack.  So I think the 
current heuristics should still work pretty well.


Nicolas

--Boundary_(ID_eu/+batKRj5WzSSsR6YyzA)--
