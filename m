From: Nicolas Pitre <nico@cam.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 13:44:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710171337330.19446@xanadu.home>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net>
 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net>
 <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> =?ISO-8859-1?Q?=20=04?=
 =?ISO-8859-1?Q?
 <"B2F6DB0C-4EFE-4?= =?ISO-8859-1?Q?C56-8E7A-3182032?= =?ISO-8859-1?Q?0CA02"@mit.edu> ?=
 <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena>
 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> ?=
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <86sl49g1w1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiCxQ-0006V0-1x
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759547AbXJQRpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758329AbXJQRpM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:45:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXJQRpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 13:45:11 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ200BLOHAFI120@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Oct 2007 13:44:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86sl49g1w1.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61398>

On Wed, 17 Oct 2007, David Kastrup wrote:

> Luke Lu <git@vicaya.com> writes:
> 
> > But I still haven't seen any compelling arguments against the "all
> > space" case, other than "people will screw it up into mixed spaces",
> > which is really a straw man, as many multi-platform projects
> > enforced the all-space policy easily by using a pre-commit hook in
> > maintainers' repository.
> 
> All-space indentation renders the binary delta algorithm git uses for
> compression of packs slow and partly inoperative (all sequences of 16
> spaces share the same finger print, and the number of identical finger
> prints for which the file information is kept is reduced to 64).

But sequences of 16 spaces are unlikely to land on 16-byte boundaries 
all the time in the file so adjacent data to those 16-space blocks will 
still provide good hashing.

> > The only downside of all-space is a moderate space bloat in source,
> > which is insignificant, all things considered.
> 
> It will also slow down git's packing and make it produce worse
> results.

If that was effectively the case then it is Git that had to be fixed and 
not the way people write code.  Git should cope with the data it is fed 
and not the other way around.

And this is completely orthogonal to the policy of using hard tabs or 
spaces in source code, so I'm clearly _not_ providing any argument to 
that discussion one way or the other here.


Nicolas
