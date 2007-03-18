From: Nicolas Pitre <nico@cam.org>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 17:15:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703181709280.18328@xanadu.home>
References: <20070316042406.7e750ed0@home.brethil>
 <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
 <20070316104715.483df0d5@localhost> <20070316140855.GE4489@pasky.or.cz>
 <20070316153822.5c842e69@localhost> <20070316231646.GB4508@spearce.org>
 <20070317195832.2af87c06@home.brethil> <20070318052332.GC15885@spearce.org>
 <7vzm6bp07f.fsf@assigned-by-dhcp.cox.net>
 <20070318161854.5a6a34e0@home.brethil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT2j2-000349-Ho
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXCRVPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbXCRVPf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:15:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60528 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXCRVPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:15:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF400CCKB1XA1B0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 18 Mar 2007 17:15:33 -0400 (EDT)
In-reply-to: <20070318161854.5a6a34e0@home.brethil>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42521>

On Sun, 18 Mar 2007, Luiz Fernando N. Capitulino wrote:

>  Other possibility is to let the caller do the job.
> 
>  I mean, if the information needed to print the error message (packfile
> name and version in this example) is available to the caller, or the
> caller can get it someway, then the caller could check which error
> he got and build the message himself.

Nah...  The error details should be handled at the failure location.  
Any error code based mechanism is bound to get out of synch at some 
point, or people simply won't bother adding new codes for new error 
conditions but simply reuse an existing generic enough code instead.

We already have this nice error() function.  Right now it simply dumps 
the message to stderr but it could be made more sophisticated if needed.


Nicolas
