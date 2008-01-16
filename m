From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 15:39:06 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161521500.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <alpine.LSU.1.00.0801161113170.17650@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8Ve-0001sp-Df
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYAPNkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbYAPNkV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:40:21 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:46760 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751379AbYAPNkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:40:21 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF8V6-0007JE-BQ; Wed, 16 Jan 2008 15:40:16 +0200
In-Reply-To: <alpine.LSU.1.00.0801161113170.17650@racer.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70669>

On Wed, 16 Jan 2008, Johannes Schindelin wrote:

> Your subject is a little bit misleading, no?  It's not about the 
> binariness (git handles binary files just fine, thankyouverymuch), but 
> about the not-tracking them.

You're absobloodylutely correct.  I was too preoccupied defining my problem 
in a better way, which left the subject kind of dumb.  Well, quite dumb. 
:-)

> The answer is no.  You cannot ask git to have the newest version of 
> something, but not the old ones.  It contradicts the distributedness of 
> git, too.

I don't agree here.  Assume that whatever you're working on require 
firmware for a device that won't change during the lifetime of the 
software project.  The newest version of the said firmware is mostly 
bugfixes and you basically don't want to revert to the older ones. 
Consider the microcode for modern Pentiums, Core 2, etc.

What i am trying to suggest is that there might be cases when you need 
something in the repository, but you don't want GIT to keep it's history 
nor it's predecessors.  Leaving it out breaks the atomicity of such 
repository and makes the project management more complex.

There's a few examples out there that shows how to solve this, but it 
seems inconvenient and involves branching, cloning, etc.  Isn't it 
possible to add something like:

 	"git nohistory firmware.bin"

or
 	"git nohistory -i-understand-this-might-be-dangerous firmware.bin"



cheers,
Petko
