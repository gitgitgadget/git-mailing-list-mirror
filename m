From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-cvsimport broken?
Date: Thu, 02 Mar 2006 14:47:23 -0800
Message-ID: <440775FB.4000300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 02 23:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEwa5-0006oA-Jy
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWCBWra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWCBWra
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:47:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:12509 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750960AbWCBWra
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:47:30 -0500
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k22MlNvv006972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Mar 2006 14:47:24 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17116>

I have started consistently getting the following error trying to do a 
git-cvsimport into an empty directory:

+ git cvsimport -C /home/hpa/local/kernel-cvs-import -k -u -m -A 
/home/hpa/local/authors -d /home/hpa/local/cvsroot 
project/sw/kernel/linux-2.6
cp: cannot stat `/export/hpa/kernel-cvs-import/.git/refs/heads/origin': 
No such file or directory
fatal: master: not a valid SHA1
fatal: 'HEAD': No such file or directory
usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
checkout failed: 256

After failing, the directory in question contains the output of 
git-init-db, including a HEAD file which contains a symbolic reference 
to a nonexistent branch (which makes sense, since there has been no 
checkins yet.)

Have other people seen this problem?

	-hpa
