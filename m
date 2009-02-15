From: Juan Zanos <juan_zanos@talkhouse.com>
Subject: Possible git bug when using filter-branch to remove large binaries
Date: Sun, 15 Feb 2009 16:35:14 -0500
Message-ID: <34854909-55F5-4869-A7A6-0E179F2F7A44@talkhouse.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 22:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYolq-00051x-F4
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbZBOVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZBOVl5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:41:57 -0500
Received: from outbound-mail-138.bluehost.com ([67.222.39.28]:55987 "HELO
	outbound-mail-138.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751318AbZBOVl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 16:41:57 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Feb 2009 16:41:56 EST
Received: (qmail 16998 invoked by uid 0); 15 Feb 2009 21:35:16 -0000
Received: from unknown (HELO box392.bluehost.com) (69.89.31.192)
  by outboundproxy4.bluehost.com with SMTP; 15 Feb 2009 21:35:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=talkhouse.com;
	h=Received:Mime-Version:Content-Transfer-Encoding:Message-Id:Content-Type:To:From:Subject:Date:X-Mailer:X-Identified-User;
	b=BQTTRAQbAe1J03lKfujqSrkCnssTEm8x3MnKyEsHE2wn9nnzNVI/BItpJV6OSs7Nvj/CleBRg081+AGEbNOmqDFp5EMUEwoEMWL9oI9FtbQHUceTOh1hZQeo2jy6WyMl;
Received: from 146-115-56-250.c3-0.wtr-ubr1.sbo-wtr.ma.cable.rcn.com ([146.115.56.250] helo=[192.168.1.2])
	by box392.bluehost.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <juan_zanos@talkhouse.com>)
	id 1LYodw-0005OE-Cg
	for git@vger.kernel.org; Sun, 15 Feb 2009 14:35:16 -0700
X-Mailer: Apple Mail (2.753.1)
X-Identified-User: {2758:box392.bluehost.com:talkhous:talkhouse.com} {sentby:smtp auth 146.115.56.250 authed with juan_zanos@talkhouse.com}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110061>

Hi Vger,

I'm trying to remove a directory of large binaries from a git  
repository    There is a directory of 85M in a git repository of  
92M.  So the binaries are relatively massive and should never have  
been checked in in the first place.  I've tried to use filter-branch  
to permanently remove those binaries.  The directory successfully  
vanishes. However, the repository + working directory only goes from  
216M down to 133M.   That means the binaries were only removed from  
the working directory.   The repository remains bloated.   I've tried  
a handful of magic incantations using commands such as gc, prune,  
reflog expire --all, etc..  None of these have  worked.   In fact,  
after cloning the 133M (repo + working) and running gc the directory  
actually increased in size from 133M to 290M!

I'm not really sure I understand what's  going on here.   It  sounds  
like the growth to 290M  is a  bug.  If so I'm  happy to provide the  
repo as a test case as well as the exact commands I use.  On the  
other hand, I'm finding that the git API is  complex enough that I   
could easily be doing something wrong or missing some command.   In  
that case is there a simple set of commands I could use to remove a  
directory of really large binaries that never should  have been  
checked in in the first place and reclaim the space ?  I've checked  
pretty thoroughly on Google to find people who have successfully done  
this, but it seems mostly people have failed to actually reclaim space.

Cheers,
Juan
