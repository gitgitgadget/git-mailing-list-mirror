From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 20:13:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001262006150.1681@xanadu.home>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
 <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com>
 <alpine.LFD.2.00.1001261639550.17519@localhost.localdomain>
 <fabb9a1e1001261650r18e04e3cw2efade6072a426b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Juliusz Chroboczek <jch@pps.jussieu.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwTp-0001pD-FJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab0A0BN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965Ab0A0BN5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:13:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39617 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab0A0BN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:13:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWV007WWSR85XN0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Jan 2010 20:13:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fabb9a1e1001261650r18e04e3cw2efade6072a426b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138096>

On Wed, 27 Jan 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Jan 27, 2010 at 01:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > That wouldn't work either. People can, should, and do add extra things to
> > the message before applying it.
> 
> Ah, that's a fair point.

FWIW, I do manually edit both incoming and outgoing patches from time to 
time as well.

> > In short, it might make sense to have some anti-corruption logic, but I
> > suspect it needs a lot of thought.
> 
> Perhaps it makes sense to make it a separate mode to git am, such that
> it only checks that the patch is not corrupted, but does not apply it.
> That way it would be possible to download the patch, check that it
> arrived unscathed, and then do your usual patch handling. Those who do
> not edit patches before applying it would be convenient to set a
> configuration option that automatically does it when applying the
> patch, either warning about it or aborting (as Juliusz suggested).

I think what would be even more useful at first is to find out why 
corrupted patches still apply.

And yet without any changes in the patch format, it should be possible 
to test the validity of a patch whenever the blob for the preimage SHA1 
from the index line in the patch header is available locally.  Just 
applying the patch to that blob and confirming it matches the postimage 
SHA1 should cover many cases already.


Nicolas
