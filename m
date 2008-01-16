From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:14:30 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161606160.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site> <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com> <20080116135420.GA21588@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF93z-0000ps-NN
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYAPOPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYAPOPt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:15:49 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:34752 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752199AbYAPOPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:15:48 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF93M-0007Ok-5t; Wed, 16 Jan 2008 16:15:40 +0200
In-Reply-To: <20080116135420.GA21588@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70676>

On Wed, 16 Jan 2008, Jeff King wrote:

> On Wed, Jan 16, 2008 at 03:39:06PM +0200, Petko Manolov wrote:
>
>> What i am trying to suggest is that there might be cases when you need
>> something in the repository, but you don't want GIT to keep it's history
>> nor it's predecessors.  Leaving it out breaks the atomicity of such
>> repository and makes the project management more complex.
>
> But not versioning some files while versioning others breaks the
> atomicity of project version, which is at the core of git's model. There
> is no such thing as "this file is at revision X, but that one is at
> revision Y." There is only "the project is at revision X."

Sigh.  You are right.

However, the said project is kind of exception.  The binaries are there 
from the very beginning - they are indivisible part of the project and it 
won't work without them.  This is why i am not worried if i revert to 
previous source code version, but actually check-out fresh binary - in my 
case it won't break things.

>> There's a few examples out there that shows how to solve this, but it
>> seems inconvenient and involves branching, cloning, etc.  Isn't it
>> possible to add something like:
>>
>> 	"git nohistory firmware.bin"
>>
>> or
>> 	"git nohistory -i-understand-this-might-be-dangerous firmware.bin"
>
> Not easily. It goes against the underlying data model at the core of
> git.

Damn, i knew you'd say something like this. :-)

> How big are your firmware files? How often do they change, and how large 
> are the changes? IOW, have you confirmed that repacking does not produce 
> an acceptable delta, meaning you get versioning for very low space cost?

Changes don't happen too often, but the size of everything binary in the 
tree easily goes to about 100MB.  Three commits later it ends up at about 
300MB...


cheers,
Petko
