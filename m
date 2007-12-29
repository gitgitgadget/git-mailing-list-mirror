From: Yannick Gingras <ygingras@ygingras.net>
Subject: On the many files problem
Date: Sat, 29 Dec 2007 13:22:29 -0500
Message-ID: <87y7bdweca.fsf@enceladus.ygingras.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 29 19:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8gRj-0007m8-V5
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 19:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbXL2S3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 13:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbXL2S3n
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 13:29:43 -0500
Received: from mail.cooptel.qc.ca ([216.144.115.12]:53745 "EHLO
	amy.cooptel.qc.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754500AbXL2S3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 13:29:42 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2007 13:29:42 EST
Received: (qmail 22995 invoked by uid 360); 29 Dec 2007 18:23:00 -0000
Received: from 216.144.118.66 by amy (envelope-from <ygingras@ygingras.net>, uid 301) with qmail-scanner-2.01 
 (clamdscan: 0.91.1/3957.  
 Clear:RC:1(216.144.118.66):. 
 Processed in 0.030123 secs); 29 Dec 2007 18:23:00 -0000
Received: from unknown (HELO verdandi.ygingras.net) (216.144.118.66)
  by smtp.cooptel.qc.ca with ESMTP; 29 Dec 2007 18:23:00 -0000
Received: from [192.168.0.15] (helo=enceladus.ygingras.net)
	by verdandi.ygingras.net with esmtp (Exim 4.50)
	id 1J8gKN-0005zu-A6
	for git@vger.kernel.org; Sat, 29 Dec 2007 13:22:55 -0500
Received: from enceladus (localhost [127.0.0.1])
	by enceladus.ygingras.net (Postfix) with ESMTP id AAE6F18501
	for <git@vger.kernel.org>; Sat, 29 Dec 2007 13:22:29 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: 192.168.0.15
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: ygingras@ygingras.net
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on 
	verdandi.ygingras.net
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.5 tests=AWL autolearn=disabled 
	version=3.1.7
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on verdandi.ygingras.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69322>


Greetings Git hackers,

No doubt, you guys must have discussed this problem before but I will
pretend that I can't find the relevant threads in the archive because
Marc's search is kind of crude.

I'm coding an application that will potentially store quite a bunch of
files in the same directory so I wondered how I should do it.  I tried
a few different files systems and I tried path hashing, that is,
storing the file that hashes to d3b07384d113 in d/d3/d3b07384d113.  As
far as I can tell, that's what Git does.  It turned out to be slower
than anything except ext3 without dir_index.  You can see my results
and the benchmarking code that I used here:

  http://ygingras.net/b/2007/12/too-many-files:-reiser-fs-vs-hashed-paths

Quick like that, I would be tempted to say that hashing paths always
makes things slower but the Git development team includes people with
really intimate knowledge of several file system implementations so
I'm tempted to say that you guys know something that I don't.

Can you describe how you hash the paths and what trick is done to
ensure fast creating and access to the subdirectories?  Is path
hashing generally faster or are you trying to avoid problems for
people using git on baroque file systems?

Best regards, 

-- 
Yannick Gingras
