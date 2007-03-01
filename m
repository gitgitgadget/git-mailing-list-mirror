From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Thu, 1 Mar 2007 12:56:49 +0100
Organization: Dewire
Message-ID: <200703011256.50659.robin.rosenberg.lists@dewire.com>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <200702282348.51478.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.63.0703010213420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:55:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjsT-0005Zx-Oz
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbXCALzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXCALzP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:55:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:5814 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965016AbXCALzN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:55:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0347B803396;
	Thu,  1 Mar 2007 12:50:07 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25401-05; Thu,  1 Mar 2007 12:50:06 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6AC83802809;
	Thu,  1 Mar 2007 12:50:04 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0703010213420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41090>

torsdag 01 mars 2007 02:18 skrev Johannes Schindelin:
> My points are these:
> 
> - If your project depends on symlinks, and you are on a system that does 
>   not do symlinks, you're screwed. However, you might want to checkout the 
>   project nevertheless.
> 
> - If you have a symlink, and your system does not do symlinks, you want 
>   the information where the symlink points to, at least _somewhere_. 
>   Without digging deep into Git internals.
> 
> - If you have a symlink, and your system ..., you want it to fail _early_.
> 
> The last point is reaaaaally important. There is a reason why we have 
> compiler errors, instead of just blindly compiling it, and if that 
> particular code path is triggered, explode in the face of the user.
> 
> So, all I would like to do on top of Johannes' patch is to add a _big_ 
> _fat_ warning whenever Git realizes it has to substitute a file for a 
> link, but I DON'T WANT THE BLOODY FILE TO BE COPIED.

I do want it to fail early initially (checkout), no default workaround, until 
I SAY I want  copies (or text links, this is apparently a preference. By 
default git should complain loudly that it cannot create links. 

- What do you want to do today?
	a) Screw me with copies
	b) Screw me with text links
	c) Screw me with shortcuts (cygwin does this which is fine as long as I stay 
within cygwin, so it is ok as a default behaviour there, but not otherwise)

I case of a link pointing to / I certainly do not want a copy either. :). 
There is no sane way of figuring out what I want.

-- robin
