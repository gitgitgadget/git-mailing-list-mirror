From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Wed, 06 Jun 2007 23:20:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706062314410.12885@xanadu.home>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
 <46676D44.7070703@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 05:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw8Ze-0001Pc-2k
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 05:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbXFGDVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 23:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935757AbXFGDVz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 23:21:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50072 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935753AbXFGDVy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 23:21:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJ8004BGXAZDG50@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Jun 2007 23:20:59 -0400 (EDT)
In-reply-to: <46676D44.7070703@vilain.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49346>

On Thu, 7 Jun 2007, Sam Vilain wrote:

> Dana How wrote:
> > This patch complicates git-repack.sh quite a bit and
> > I'm unclear on what _problem_ you're addressing.
> 
> The problem is simple, and it is partially in the eye of the beholder.
> 
> That is;
> 
>   1. without repacking, you get a lot of loose objects.
>      - unnecessary disk space usage
>      - bad performance on many OSes

No argument.

>   2. repack takes too long to run very regularly; it's an occasional
>      command.

It doesn't take long at all when you don't use -a.

>   3. the perception that git repositories are not maintenance free.

But this perception is true!  It is possible to automate it, but some 
maintenance is necessary at some point.

> What I'm aiming for is something which is light enough that it might
> even win back the performance loss you got from 1), and to solve the
> perception problem of 3).

Run git-repack without -a from some hook.  You can even launch it in the 
background.

Or what am I missing?


Nicolas
