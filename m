From: Steve =?ISO-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 19:22:33 +0100
Message-ID: <1174069353.2599.13.camel@mejai>
References: <20070316042406.7e750ed0@home.brethil>
	 <20070316045928.GB31606@spearce.org>
	 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
	 <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHB8-0003kJ-JV
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965830AbXCPS3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965828AbXCPS3Q
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:29:16 -0400
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:40291 "EHLO
	serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965830AbXCPS3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:29:15 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Mar 2007 14:29:14 EDT
Received: (qmail 27676 invoked by uid 510); 16 Mar 2007 19:22:33 +0100
Received: from 83.182.29.53 by serv108.segi.ulg.ac.be (envelope-from <nudrema@gmail.com>, uid 501) with qmail-scanner-1.25 
 (clamdscan: 0.90/2842.  
 Clear:RC:1(83.182.29.53):. 
 Processed in 0.015535 secs); 16 Mar 2007 18:22:33 -0000
Received: from unknown (HELO [10.0.0.3]) (s020908@[83.182.29.53])
          (envelope-sender <nudrema@gmail.com>)
          by serv108.segi.ulg.ac.be (qmail-ldap-1.03) with SMTP
          for <nico@cam.org>; 16 Mar 2007 19:22:33 +0100
In-Reply-To: <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
X-Mailer: Evolution 2.10.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42390>

On Fri, 2007-03-16 at 12:26 -0400, Nicolas Pitre wrote:

> Sure.  But the output from an executable is a damn good abstraction and 
> the executable itself is an impenetrable boundary.  Anything can change 
> (and did change) underneath.

Strictly speaking, you can use opaque structures for commits and so on
(so that the outside world will only ever see a pointer), and use some
getter/setters for commonly used stuffs (like datum, title, content).

Also, I guess what people would expect from a C library is roughly the
same as for the current plumbing... just easier to use from another
program. It doesn't need a low-level access to data structure (most
applications would be to interact with an existing repo or to store data
for a third-party software, something that is high-level) and I don't
think such an opaque API would be a huge constraint as soon as you keep
the Object/Index/Tree/Commit/etc basic opaque structs.
