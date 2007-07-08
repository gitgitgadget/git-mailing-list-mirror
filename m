From: Gordon Heydon <gordon@heydon.com.au>
Subject: git cvsimport branches not consistent with CVS branches
Date: Sun, 08 Jul 2007 10:45:10 +1000
Message-ID: <46903396.1010507@heydon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 02:47:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Kw3-0000dF-Jk
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 02:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXGHArd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 20:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbXGHArd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 20:47:33 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:39920 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbXGHArc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 20:47:32 -0400
Received: from spunkymail-a1.g.dreamhost.com (sd-green-bigip-74.dreamhost.com [208.97.132.74])
	by sumo.dreamhost.com (Postfix) with ESMTP id 412E717C7F9
	for <git@vger.kernel.org>; Sat,  7 Jul 2007 17:47:15 -0700 (PDT)
Received: from major.heydon.com.au (c211-28-237-77.thoms1.vic.optusnet.com.au [211.28.237.77])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 02382FFD0C
	for <git@vger.kernel.org>; Sat,  7 Jul 2007 17:45:13 -0700 (PDT)
Received: by major.heydon.com.au (Postfix, from userid 109)
	id B41DA10682; Sun,  8 Jul 2007 10:38:27 +1000 (EST)
Received: from gordon-heydons-computer.local (unknown [192.168.211.59])
	by major.heydon.com.au (Postfix) with ESMTP id 7DC073533
	for <git@vger.kernel.org>; Sun,  8 Jul 2007 10:38:27 +1000 (EST)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51849>

Hi,

After some investigation I found that git cvsimport was not importing 
branches 100% correctly with CVS.

Git and CVS do branching very differently in that CVS this is done at 
the file level (like everything else) and git does it repository wide.

So if I have a CVS repository with the files a, b and c and I branch b 
with a `cvs tab -b BRANCH test` on the branch test I will just have the 
file b.

If I do a git cvsimport on the test branch there will actually be the 
files a, b and c

What I think needs to happen is that when git cvsimport created the 
branch in the git repository it needs to delete all files from the 
branch that were not branched.

Thanks in advance.
Gordon.
