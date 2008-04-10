From: Jing Xue <jingxue@digizenstudio.com>
Subject: git-p4, msysgit, and crlf
Date: Thu, 10 Apr 2008 17:53:38 -0400
Message-ID: <20080410175338.1z2hb82xw4kk4k0o@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 00:01:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk4pV-00068S-UC
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 00:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbYDJWA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbYDJWA3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 18:00:29 -0400
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:44084
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756391AbYDJWA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 18:00:28 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Apr 2008 18:00:28 EDT
Received: (qmail 7779 invoked from network); 10 Apr 2008 21:53:47 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 10 Apr 2008 21:53:47 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id ABFF9100BC1
	for <git@vger.kernel.org>; Thu, 10 Apr 2008 21:53:47 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dma4YfpfvjuN for <git@vger.kernel.org>;
	Thu, 10 Apr 2008 17:53:39 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id EFDF6100CAE; Thu, 10 Apr 2008 17:53:38 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Thu, 10 Apr 2008 17:53:38 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79253>



I'm working on a client project, where everything is developed in
Windows, and perforce is the official SCM. All the files use crlf line
endings.

I'm trying to use msysgit for my personal SCM, and git-p4 to sync with
perforce.

The problem I'm running into is that after

   git p4 clone /perforce/path@all proj

all the files in the working directory are converted to lf line endings,
which I'd like to avoid.

I tracked it down to at some point git-p4 executes what essentially
amounts to

   p4 -G print /path/to/file#rev

in order to get the content of a revision. When I try to run that
manually from the msysgit bash, the file content returned has all
the line endings converted to lf.

However, if I try to run without "-G", i.e.

   p4 print /path/to/file#rev

The content returned has all the original crlf endings left intact.

I know this looks like a p4 issue, but I just wanted to ask other  
git-p4 users out there whether you have run into this, and how you  
dealt with it.

Thanks.
-- 
Jing Xue
