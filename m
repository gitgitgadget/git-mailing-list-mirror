From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Debugging corrupt object generation
Date: Thu, 1 Nov 2007 22:57:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711012256080.17812@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 23:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iniyu-0007w6-Cw
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXKAW5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbXKAW5a
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:57:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:53185 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753067AbXKAW5a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 18:57:30 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1539DC61D3
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 22:57:29 +0000 (GMT)
Received: (qmail 19265 invoked by uid 103); 1 Nov 2007 22:57:28 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4654. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030691 secs); 01 Nov 2007 22:57:28 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 1 Nov 2007 22:57:28 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63032>

I have been trying to import a repository using fast-import, and as part 
of this I have extended fast-import to support copying a path from any 
arbitrary commit.  This works fine on my small test repository.

However, when I run against my (vastly more complicated) real work 
repository things don't go so well.  I get a few thousand commits in, and 
then it breaks.  It appears that I have somehow managed to create a 
corrupt object or something.

After a certain commit, and attempt to use that commit generates a "fatal:
unable to apply delta".  This appears to be coming from unpack_delta_entry
in sha1_file.c.

Can anyone give me any hints as to how I find out what is causing the
problem?  I'm not even sure what it is that isn't working ... and all
attempts to replicate the problem with my test repository have failed.

-- 
Julian

  ---
...the prevailing Catholic odor - incense, wax, centuries of mild bleating
from the lips of the flock.
-- Thomas Pynchon, _Gravity's Rainbow_
