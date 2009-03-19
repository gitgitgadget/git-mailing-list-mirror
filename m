From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: git-svn and incorrect working copy file timestamps?
Date: Fri, 20 Mar 2009 00:02:01 +0100 (CET)
Message-ID: <alpine.LSU.2.01.0903192355590.29898@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org, derek.mahar@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 20 00:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRH1-0006Gn-Su
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZCSXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZCSXCJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:02:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51477 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753081AbZCSXCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 19:02:09 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1D73D2F1C46;
	Thu, 19 Mar 2009 19:02:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 19:02:07 -0400
X-Sasl-enc: bCbMy1I3fkn+h/+BCvf7Y9TkvdFkHkfa8m2HkDl7wsva 1237503726
Received: from [192.168.2.101] (p549A49D8.dip.t-dialin.net [84.154.73.216])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 321D1A633;
	Thu, 19 Mar 2009 19:02:06 -0400 (EDT)
User-Agent: Alpine 2.01 (LSU 1184 2008-12-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113855>

> I learned from http://marc.info/?l=git&m=122783905206964&w=2 that all 
> Git commands do not preserve file timestamps because Git, by design, 
> does not record timestamps in the tree objects.  So, in order to see the 
> last time a particular file changed, you must examine the commit log. 
> I guess I'll just have to get used to ignoring the working copy file 
> timestamps.

As far as I know setting the current time is required when switching 
between different named branches in the same repository.

It can happen that a branch switch ('checkout' in Git's terminology) 
retrieves an older version of a source file, and then the Makefile would 
not detect that an object file (a result from earlier compilation that is 
of course not stored in the repo itself) has to be rebuild because this is 
based on time checks only. In order to avoid this, the source file (even 
if older) gets the current date, so it is in any case newer than the 
object file and causes an automatic rebuild.

Regards

Guido
